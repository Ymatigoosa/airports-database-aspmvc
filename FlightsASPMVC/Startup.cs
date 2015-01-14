using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(FlightsASPMVC.Startup))]
namespace FlightsASPMVC
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
