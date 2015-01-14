using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace FlightsASPMVC.Models
{
    public class FlightAddInputViewModel
    {
        [Required]
        [Display(Name = "Team")]
        public int team_id { get; set; }

        [Required]
        [Display(Name = "Flight Class")]
        public int flight_class_id { get; set; }

        [Required]
        [Display(Name = "Plane")]
        public int plane_id { get; set; }

        [Required]
        [DataType(DataType.DateTime)]
        [Display(Name = "Sortie time")]
        //[DataType(DataType.DateTime)]
        //[DisplayFormat(DataFormatString = "{0:yyyy-MM-dd hh-mm}", ApplyFormatInEditMode = true)]
        public DateTime sortie_time { get; set; }

        [Required]
        [DataType(DataType.DateTime)]
        [Display(Name = "Landing Time")]
        public DateTime landing_time { get; set; }
    }

    public class FlightChangePlaneInputViewModel
    {

        [Required]
        [Display(Name = "Flight")]
        public int flight_id { get; set; }

        [Required]
        [Display(Name = "Plane")]
        public int plane_id { get; set; }
    }

    public class FlightChangeTeamInputViewModel
    {

        [Required]
        [Display(Name = "Flight")]
        public int flight_id { get; set; }

        [Required]
        [Display(Name = "Team")]
        public int team_id { get; set; }
    }

    public class FlightGenerateNextInputViewModel
    {

        [Required]
        [Display(Name = "Flight Class")]
        public int flight_class_id { get; set; }

        [Required]
        [Display(Name = "Team")]
        public int team_id { get; set; }

        [Required]
        [Display(Name = "Plane")]
        public int plane_id { get; set; }

        [Required]
        [DataType(DataType.Date)]
        [Display(Name = "Starting date for generating")]
        public DateTime start_time { get; set; }
    }

    public class FlightLandingDoInputViewModel
    {

        [Required]
        [Display(Name = "Flight")]
        public int flight_id { get; set; }
    }

    public class FlightLandingMoveInputViewModel
    {

        [Required]
        [Display(Name = "Flight")]
        public int flight_id { get; set; }

        [Required]
        [DataType(DataType.Time)]
        [Display(Name = "delta time")]
        public TimeSpan delta { get; set; }

        [Required]
        [Display(Name = "Reason")]
        public string reasont { get; set; }
    }

    public class FlightSortieCancelInputViewModel
    {

        [Required]
        [Display(Name = "Flight")]
        public int flight_id { get; set; }

        [Required]
        [Display(Name = "Reason")]
        public string reasont { get; set; }
    }

    public class FlightSortieDoInputViewModel
    {

        [Required]
        [Display(Name = "Flight")]
        public int flight_id { get; set; }
    }

    public class FlightSortieMoveInputViewModel
    {

        [Required]
        [Display(Name = "Flight")]
        public int flight_id { get; set; }

        [Required]
        [DataType(DataType.Time)]
        [Display(Name = "delta time")]
        public TimeSpan delta { get; set; }

        [Required]
        [Display(Name = "Reason")]
        public string reasont { get; set; }
    }
}