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
    
    public partial class department
    {
        [Display(Name = "Department identifier")]
        public int id { get; set; }

        [Display(Name = "Department name")]
        public string name { get; set; }

        [Display(Name = "airport")]
        public int airport { get; set; }

        [Display(Name = "head")]
        public int head { get; set; }

        [Display(Name = "type")]
        public int type { get; set; }
    
        public virtual airport airport1 { get; set; }
        public virtual employee_type employee_type { get; set; }
        public virtual employee employee { get; set; }
    }
}
