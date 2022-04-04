using BibliotecaDLL.DbContexts;
using MongoDB.Driver;
using nrmcontrolextension.Filters;
using nrmcontrolextension.IRepositories;
using nrmcontrolextension.Models;
using nrmcontrolextension.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace nrmcontrolextension.Repositories
{
    public class UserRepository : IUserRepository
    {
        private MongoDbContext _Connection;
        public UserRepository()
        {
            this._Connection = new MongoDbContext();
            if (this._Connection == null)
            {
                throw new ArgumentNullException(nameof(this._Connection));
            }
        }

        public async Task<List<User>> GetUsers(UserFilter userFilter)
        {
            FilterDefinitionBuilder<User> builder = Builders<User>.Filter;
            FilterDefinition<User> filter = builder.Where(x => 1 == 1);
            if (userFilter != null)
            {
                if (!string.IsNullOrEmpty(userFilter.UserId))
                {
                    filter = filter & builder.Where(u => u.UserId == userFilter.UserId);
                }
            }
            List<User> listaUsuarios = await _Connection.Users.Find(filter).ToListAsync();
            listaUsuarios.ForEach(u => u.Exists = true);
            return listaUsuarios;
        }

        public async Task<bool> ValidateLogin(User user)
        {
            UserFilter userFilter = new UserFilter { UserId = user.UserId };
            User? userBase = (await GetUsers(userFilter)).FirstOrDefault();
            //deixado a mesma mensagem propositalmente
            if (userBase == null)
            {
                throw new UnauthorizedAccessException("Usuário não encontrado!");
            }
            else if (Password.CryptPassword(user.Password) != userBase.Password)
            {
                throw new UnauthorizedAccessException("Usuário não encontrado!");
            }
            return true;
        }

        public async Task<User> SaveUser(User user)
        {
            ValidateUser(user);
            if (user.Exists)
            {
                FilterDefinition<User> filter = Builders<User>.Filter.Where(u => u.UserId == user.UserId);
                UpdateDefinitionBuilder<User> updateBuilder = Builders<User>.Update;
                UpdateDefinition<User> update = updateBuilder.Set(u => u.UserId, user.UserId);
                if (!string.IsNullOrEmpty(user.Password))
                {
                    user.Password = Password.CryptPassword(user.Password);
                    update = update.Set(u => u.Password, user.Password);
                }
                await _Connection.Users.UpdateOneAsync(filter, update);
            }
            else
            {
                FilterDefinition<User> filter = Builders<User>.Filter.Where(u => u.UserId == user.UserId);
                User userBase = await _Connection.Users.Find(filter).FirstOrDefaultAsync();
                if (userBase == null)
                {
                    user.Password = Password.CryptPassword(user.Password);
                    await _Connection.Users.InsertOneAsync(user);
                }
                else
                {
                    throw new Exception("Usuário já existe!");
                }
            }
            user.Exists = true;
            return user;
        }

        public Task<bool> DeleteUser(User user)
        {
            return Task.Run(() =>
            {
                FilterDefinition<User> filter = Builders<User>.Filter.Where(u => u.UserId == user.UserId);
                _Connection.Users.DeleteOne(filter);
                return true;
            });
        }

        public void ValidateUser(User user)
        {
            if (string.IsNullOrEmpty(user.UserId))
            {
                throw new ArgumentNullException(nameof(user.UserId));
            }
            else if (string.IsNullOrEmpty(user.Password) && !user.Exists)
            {
                throw new ArgumentNullException(nameof(user.Password));

            }
        }
    }
}
