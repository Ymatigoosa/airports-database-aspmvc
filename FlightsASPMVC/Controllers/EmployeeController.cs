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
    public class EmployeeController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /Employee/
        public ActionResult Index()
        {
            var employee = db.employee.Include(e => e.airport1).Include(e => e.city).Include(e => e.employee_type).Include(e => e.brigade1);
            return View(employee.ToList());
        }

        // GET: /Employee/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            employee employee = db.employee.Find(id);
            if (employee == null)
            {
                return HttpNotFound();
            }
            return View(employee);
        }

        // GET: /Employee/Create
        public ActionResult Create()
        {
            ViewBag.airport = new SelectList(db.airport, "id", "id");
            ViewBag.city_of_residence = new SelectList(db.city, "id", "name");
            ViewBag.type = new SelectList(db.employee_type, "id", "name");
            ViewBag.brigade = new SelectList(db.brigade, "id", "comment");
            return View();
        }

        // POST: /Employee/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,name,lastname,patronymic,phone,additional_phone,comment,number_of_flights,hours_in_flights,hire_date,date_of_dismissal,city_of_residence,type,last_medical_examination,brigade,airport,salary,childrencount,sex")] employee employee)
        {
            if (ModelState.IsValid)
            {
                db.employee.Add(employee);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.airport = new SelectList(db.airport, "id", "id", employee.airport);
            ViewBag.city_of_residence = new SelectList(db.city, "id", "name", employee.city_of_residence);
            ViewBag.type = new SelectList(db.employee_type, "id", "name", employee.type);
            ViewBag.brigade = new SelectList(db.brigade, "id", "comment", employee.brigade);
            return View(employee);
        }

        // GET: /Employee/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            employee employee = db.employee.Find(id);
            if (employee == null)
            {
                return HttpNotFound();
            }
            ViewBag.airport = new SelectList(db.airport, "id", "id", employee.airport);
            ViewBag.city_of_residence = new SelectList(db.city, "id", "name", employee.city_of_residence);
            ViewBag.type = new SelectList(db.employee_type, "id", "name", employee.type);
            ViewBag.brigade = new SelectList(db.brigade, "id", "comment", employee.brigade);
            return View(employee);
        }

        // POST: /Employee/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,name,lastname,patronymic,phone,additional_phone,comment,number_of_flights,hours_in_flights,hire_date,date_of_dismissal,city_of_residence,type,last_medical_examination,brigade,airport,salary,childrencount,sex")] employee employee)
        {
            if (ModelState.IsValid)
            {
                db.Entry(employee).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.airport = new SelectList(db.airport, "id", "id", employee.airport);
            ViewBag.city_of_residence = new SelectList(db.city, "id", "name", employee.city_of_residence);
            ViewBag.type = new SelectList(db.employee_type, "id", "name", employee.type);
            ViewBag.brigade = new SelectList(db.brigade, "id", "comment", employee.brigade);
            return View(employee);
        }

        // GET: /Employee/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            employee employee = db.employee.Find(id);
            if (employee == null)
            {
                return HttpNotFound();
            }
            return View(employee);
        }

        // POST: /Employee/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            employee employee = db.employee.Find(id);
            db.employee.Remove(employee);
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
