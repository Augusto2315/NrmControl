using BibliotecaDLL.DbContexts;
using MongoDB.Bson;
using MongoDB.Driver;
using nrmcontrolextension.Filters;
using nrmcontrolextension.IRepositories;
using nrmcontrolextension.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace nrmcontrolextension.Repositories
{
    public class DespenseTypeRepository : IDespenseTypeRepository
    {
        private readonly MongoDbContext _Connection;
        public DespenseTypeRepository()
        {
            this._Connection = new MongoDbContext();
        }

        public async Task<List<DespenseType>> GetDespensesTypesByUser(DespenseTypeFilter despenseTypeFilter)
        {
            FilterDefinitionBuilder<DespenseType> builder = Builders<DespenseType>.Filter;
            FilterDefinition<DespenseType> filter = builder.Empty;
            if (despenseTypeFilter != null && !string.IsNullOrEmpty(despenseTypeFilter.UserId))
            {
                filter &= builder.Where(u => u.UserId == despenseTypeFilter.UserId);
            }
            List<DespenseType> listaTiposDespesa = await _Connection.DespenseTypes.Find(filter).ToListAsync();
            return listaTiposDespesa;
        }

        public async Task<DespenseType> InsertDespenseType(DespenseType despenseType)
        {
            ValidateDespenseType(despenseType);
            DespenseType despenseTypeBase = _Connection.DespenseTypes.Aggregate().SortByDescending(x => x.Id).FirstOrDefault();
            if (despenseTypeBase != null)
            {
                despenseType.Id = despenseTypeBase.Id + 1;
            }
            else
            {
                despenseType.Id = 1;
            }
            await _Connection.DespenseTypes.InsertOneAsync(despenseType);
            return despenseType;
        }

        public async Task<DespenseType> UpdateDespenseType(DespenseType despenseType)
        {
            ValidateDespenseType(despenseType);

            await _Connection.DespenseTypes.ReplaceOneAsync(actualDespense => actualDespense.Id == despenseType.Id,despenseType);
            return despenseType;
        }


        public async Task DeleteDespenseType(DespenseType despenseType)
        {
            await _Connection.DespenseTypes.DeleteOneAsync(e => e.Id == despenseType.Id);
        }

        public static void ValidateDespenseType(DespenseType despenseType)
        {
            if (string.IsNullOrEmpty(despenseType.Description))
            {
                throw new ArgumentException("Descrição");
            }
            else if (string.IsNullOrEmpty(despenseType.UserId))
            {
                throw new ArgumentException("Usuário");
            }
        }
    }
}
