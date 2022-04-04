using nrmcontrolextension.Filters;
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
    public class UserService : IUserService
    {
        private IUserRepository _IUserRepository;
        public UserService(IUserRepository iUserRepository)
        {
            this._IUserRepository = iUserRepository;
        }
        public async Task<List<User>> GetUsers(UserFilter userFilter)
        {
            return await this._IUserRepository.GetUsers(userFilter);
        }

        public async Task<User> SaveUser(User user)
        {
            return await this._IUserRepository.SaveUser(user);
        }

        public async Task<bool> DeleteUser(User user)
        {
            return await this._IUserRepository.DeleteUser(user);
        }

        public async Task<bool> ValidateLogin(User user)
        {
            return await this._IUserRepository.ValidateLogin(user);
        }
    }
}
