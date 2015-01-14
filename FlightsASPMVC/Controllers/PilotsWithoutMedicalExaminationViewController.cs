using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using FlightsASPMVC.Models;

namespace FlightsASPMVC.Controllers
{
    public class PilotsWithoutMedicalExaminationViewController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /PilotsWithoutMedicalExaminationView/
        public ActionResult Index()
        {
            return View(db.pilots_without_med_examination.ToList());
        }

        // GET: /PilotsWithoutMedicalExaminationView/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            pilots_without_med_examination pilots_without_med_examination = db.pilots_without_med_examination.Find(id);
            if (pilots_without_med_examination == null)
            {
                return HttpNotFound();
            }
            return View(pilots_without_med_examination);
        }

        // GET: /PilotsWithoutMedicalExaminationView/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: /PilotsWithoutMedicalExaminationView/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,name,lastname,patronymic,phone,additional_phone,comment,number_of_flights,hours_in_flights,hire_date,date_of_dismissal,city_of_residence,type,last_medical_examination,brigade,airport,salary,childrencount,sex")] pilots_without_med_examination pilots_without_med_examination)
        {
            if (ModelState.IsValid)
            {
                db.pilots_without_med_examination.Add(pilots_without_med_examination);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(pilots_without_med_examination);
        }

        // GET: /PilotsWithoutMedicalExaminationView/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            pilots_without_med_examination pilots_without_med_examination = db.pilots_without_med_examination.Find(id);
            if (pilots_without_med_examination == null)
            {
                return HttpNotFound();
            }
            return View(pilots_without_med_examination);
        }

        // POST: /PilotsWithoutMedicalExaminationView/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,name,lastname,patronymic,phone,additional_phone,comment,number_of_flights,hours_in_flights,hire_date,date_of_dismissal,city_of_residence,type,last_medical_examination,brigade,airport,salary,childrencount,sex")] pilots_without_med_examination pilots_without_med_examination)
        {
            if (ModelState.IsValid)
            {
                db.Entry(pilots_without_med_examination).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(pilots_without_med_examination);
        }

        // GET: /PilotsWithoutMedicalExaminationView/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            pilots_without_med_examination pilots_without_med_examination = db.pilots_without_med_examination.Find(id);
            if (pilots_without_med_examination == null)
            {
                return HttpNotFound();
            }
            return View(pilots_without_med_examination);
        }

        // POST: /PilotsWithoutMedicalExaminationView/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            pilots_without_med_examination pilots_without_med_examination = db.pilots_without_med_examination.Find(id);
            db.pilots_without_med_examination.Remove(pilots_without_med_examination);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
