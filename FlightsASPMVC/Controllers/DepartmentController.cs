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
    public class DepartmentController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /Department/
        public ActionResult Index()
        {
            var department = db.department.Include(d => d.airport1).Include(d => d.employee_type).Include(d => d.employee);
            return View(department.ToList());
        }

        // GET: /Department/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            department department = db.department.Find(id);
            if (department == null)
            {
                return HttpNotFound();
            }
            return View(department);
        }

        // GET: /Department/Create
        public ActionResult Create()
        {
            ViewBag.airport = new SelectList(db.airport, "id", "id");
            ViewBag.type = new SelectList(db.employee_type, "id", "name");
            ViewBag.head = new SelectList(db.employee, "id", "name");
            return View();
        }

        // POST: /Department/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,name,airport,head,type")] department department)
        {
            if (ModelState.IsValid)
            {
                db.department.Add(department);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.airport = new SelectList(db.airport, "id", "id", department.airport);
            ViewBag.type = new SelectList(db.employee_type, "id", "name", department.type);
            ViewBag.head = new SelectList(db.employee, "id", "name", department.head);
            return View(department);
        }

        // GET: /Department/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            department department = db.department.Find(id);
            if (department == null)
            {
                return HttpNotFound();
            }
            ViewBag.airport = new SelectList(db.airport, "id", "id", department.airport);
            ViewBag.type = new SelectList(db.employee_type, "id", "name", department.type);
            ViewBag.head = new SelectList(db.employee, "id", "name", department.head);
            return View(department);
        }

        // POST: /Department/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,name,airport,head,type")] department department)
        {
            if (ModelState.IsValid)
            {
                db.Entry(department).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.airport = new SelectList(db.airport, "id", "id", department.airport);
            ViewBag.type = new SelectList(db.employee_type, "id", "name", department.type);
            ViewBag.head = new SelectList(db.employee, "id", "name", department.head);
            return View(department);
        }

        // GET: /Department/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            department department = db.department.Find(id);
            if (department == null)
            {
                return HttpNotFound();
            }
            return View(department);
        }

        // POST: /Department/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            department department = db.department.Find(id);
            db.department.Remove(department);
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
