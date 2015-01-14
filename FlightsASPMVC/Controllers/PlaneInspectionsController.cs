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
    public class PlaneInspectionsController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /PlaneInspections/
        public ActionResult Index()
        {
            var plane_inspections = db.plane_inspections.Include(p => p.employee).Include(p => p.plane1);
            return View(plane_inspections.ToList());
        }

        // GET: /PlaneInspections/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            plane_inspections plane_inspections = db.plane_inspections.Find(id);
            if (plane_inspections == null)
            {
                return HttpNotFound();
            }
            return View(plane_inspections);
        }

        // GET: /PlaneInspections/Create
        public ActionResult Create()
        {
            ViewBag.responsible = new SelectList(db.employee, "id", "name");
            ViewBag.plane = new SelectList(db.plane, "id", "id");
            return View();
        }

        // POST: /PlaneInspections/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,scheduled_date,responsible,comment,plane")] plane_inspections plane_inspections)
        {
            if (ModelState.IsValid)
            {
                db.plane_inspections.Add(plane_inspections);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.responsible = new SelectList(db.employee, "id", "name", plane_inspections.responsible);
            ViewBag.plane = new SelectList(db.plane, "id", "id", plane_inspections.plane);
            return View(plane_inspections);
        }

        // GET: /PlaneInspections/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            plane_inspections plane_inspections = db.plane_inspections.Find(id);
            if (plane_inspections == null)
            {
                return HttpNotFound();
            }
            ViewBag.responsible = new SelectList(db.employee, "id", "name", plane_inspections.responsible);
            ViewBag.plane = new SelectList(db.plane, "id", "id", plane_inspections.plane);
            return View(plane_inspections);
        }

        // POST: /PlaneInspections/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,scheduled_date,responsible,comment,plane")] plane_inspections plane_inspections)
        {
            if (ModelState.IsValid)
            {
                db.Entry(plane_inspections).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.responsible = new SelectList(db.employee, "id", "name", plane_inspections.responsible);
            ViewBag.plane = new SelectList(db.plane, "id", "id", plane_inspections.plane);
            return View(plane_inspections);
        }

        // GET: /PlaneInspections/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            plane_inspections plane_inspections = db.plane_inspections.Find(id);
            if (plane_inspections == null)
            {
                return HttpNotFound();
            }
            return View(plane_inspections);
        }

        // POST: /PlaneInspections/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            plane_inspections plane_inspections = db.plane_inspections.Find(id);
            db.plane_inspections.Remove(plane_inspections);
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
