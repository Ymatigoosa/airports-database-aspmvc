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
    public class PlaneRepairsController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /PlaneRepairs/
        public ActionResult Index()
        {
            var plane_repairs = db.plane_repairs.Include(p => p.employee).Include(p => p.plane1);
            return View(plane_repairs.ToList());
        }

        // GET: /PlaneRepairs/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            plane_repairs plane_repairs = db.plane_repairs.Find(id);
            if (plane_repairs == null)
            {
                return HttpNotFound();
            }
            return View(plane_repairs);
        }

        // GET: /PlaneRepairs/Create
        public ActionResult Create()
        {
            ViewBag.responsible = new SelectList(db.employee, "id", "name");
            ViewBag.plane = new SelectList(db.plane, "id", "id");
            return View();
        }

        // POST: /PlaneRepairs/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,plane,scheduled_date,responsible,comment")] plane_repairs plane_repairs)
        {
            if (ModelState.IsValid)
            {
                db.plane_repairs.Add(plane_repairs);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.responsible = new SelectList(db.employee, "id", "name", plane_repairs.responsible);
            ViewBag.plane = new SelectList(db.plane, "id", "id", plane_repairs.plane);
            return View(plane_repairs);
        }

        // GET: /PlaneRepairs/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            plane_repairs plane_repairs = db.plane_repairs.Find(id);
            if (plane_repairs == null)
            {
                return HttpNotFound();
            }
            ViewBag.responsible = new SelectList(db.employee, "id", "name", plane_repairs.responsible);
            ViewBag.plane = new SelectList(db.plane, "id", "id", plane_repairs.plane);
            return View(plane_repairs);
        }

        // POST: /PlaneRepairs/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,plane,scheduled_date,responsible,comment")] plane_repairs plane_repairs)
        {
            if (ModelState.IsValid)
            {
                db.Entry(plane_repairs).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.responsible = new SelectList(db.employee, "id", "name", plane_repairs.responsible);
            ViewBag.plane = new SelectList(db.plane, "id", "id", plane_repairs.plane);
            return View(plane_repairs);
        }

        // GET: /PlaneRepairs/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            plane_repairs plane_repairs = db.plane_repairs.Find(id);
            if (plane_repairs == null)
            {
                return HttpNotFound();
            }
            return View(plane_repairs);
        }

        // POST: /PlaneRepairs/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            plane_repairs plane_repairs = db.plane_repairs.Find(id);
            db.plane_repairs.Remove(plane_repairs);
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
