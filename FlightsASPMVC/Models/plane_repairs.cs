//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace FlightsASPMVC.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    
    public partial class plane_repairs
    {
        public plane_repairs()
        {
            this.plane_repairs_ended = new HashSet<plane_repairs_ended>();
        }

        [Display(Name = "Plane repair identifier")]
        public int id { get; set; }
        public int plane { get; set; }

        [Display(Name = "Repair scheduled date")]
        public System.DateTime scheduled_date { get; set; }
        public int responsible { get; set; }
        public string comment { get; set; }
    
        public virtual employee employee { get; set; }
        public virtual plane plane1 { get; set; }
        public virtual ICollection<plane_repairs_ended> plane_repairs_ended { get; set; }
    }
}
