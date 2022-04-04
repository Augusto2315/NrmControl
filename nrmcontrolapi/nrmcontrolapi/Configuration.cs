using nrmcontrolextension.IRepositories;
using nrmcontrolextension.IServices;
using nrmcontrolextension.Repositories;
using nrmcontrolextension.Services;

namespace nrmcontrolapi
{
    public static class Configuration
    {
        public static void RegisterServices(WebApplicationBuilder builder)
        {
            if (builder == null)
            {
                throw new ArgumentNullException(nameof(builder));
            }

            builder.Services.AddScoped<IDespenseTypeRepository, DespenseTypeRepository>();
            builder.Services.AddScoped<IUserRepository, UserRepository>();
            builder.Services.AddScoped<IDespenseTypeRepository, DespenseTypeRepository>();
            builder.Services.AddScoped<IUserService, UserService>();
        }
    }
}
