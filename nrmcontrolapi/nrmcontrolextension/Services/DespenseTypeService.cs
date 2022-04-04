using nrmcontrolextension.IRepositories;
using nrmcontrolextension.IServices;
using nrmcontrolextension.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace nrmcontrolextension.Services
{
    public class DespenseTypeService : IDespenseTypeService
    {
        private IDespenseTypeRepository _IDespenseTypeRepository;
        public DespenseTypeService(IDespenseTypeRepository iDespenseTypeRepositoy)
        {
            this._IDespenseTypeRepository = iDespenseTypeRepositoy;
        }
        public async Task<List<DespenseType>> GetDespenseTypes()
        {
            return await this._IDespenseTypeRepository.GetDespensesTypes();
        }

        public async Task<DespenseType> InsertDespenseType(DespenseType despenseType)
        {
            return await this._IDespenseTypeRepository.InsertDespenseType(despenseType);
        }

    }
}
