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
    public class PlaneInspectionsEndedController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /PlaneInspectionsEnded/
        public ActionResult Index()
        {
            var plane_inspections_ended = db.plane_inspections_ended.Include(p => p.plane_inspections);
            return View(plane_inspections_ended.ToList());
        }

        // GET: /PlaneInspectionsEnded/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            plane_inspections_ended plane_inspections_ended = db.plane_inspections_ended.Find(id);
            if (plane_inspections_ended == null)
            {
                return HttpNotFound();
            }
            return View(plane_inspections_ended);
        }

        // GET: /PlaneInspectionsEnded/Create
        public ActionResult Create()
        {
            ViewBag.inspection = new SelectList(db.plane_inspections, "id", "comment");
            return View();
        }

        // POST: /PlaneInspectionsEnded/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,inspection,end_date,conclusion,comment")] plane_inspections_ended plane_inspections_ended)
        {
            if (ModelState.IsValid)
            {
                db.plane_inspections_ended.Add(plane_inspections_ended);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.inspection = new SelectList(db.plane_inspections, "id", "comment", plane_inspections_ended.inspection);
            return View(plane_inspections_ended);
        }

        // GET: /PlaneInspectionsEnded/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            plane_inspections_ended plane_inspections_ended = db.plane_inspections_ended.Find(id);
            if (plane_inspections_ended == null)
            {
                return HttpNotFound();
            }
            ViewBag.inspection = new SelectList(db.plane_inspections, "id", "comment", plane_inspections_ended.inspection);
            return View(plane_inspections_ended);
        }

        // POST: /PlaneInspectionsEnded/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,inspection,end_date,conclusion,comment")] plane_inspections_ended plane_inspections_ended)
        {
            if (ModelState.IsValid)
            {
                db.Entry(plane_inspections_ended).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.inspection = new SelectList(db.plane_inspections, "id", "comment", plane_inspections_ended.inspection);
            return View(plane_inspections_ended);
        }

        // GET: /PlaneInspectionsEnded/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            plane_inspections_ended plane_inspections_ended = db.plane_inspections_ended.Find(id);
            if (plane_inspections_ended == null)
            {
                return HttpNotFound();
            }
            return View(plane_inspections_ended);
        }

        // POST: /PlaneInspectionsEnded/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            plane_inspections_ended plane_inspections_ended = db.plane_inspections_ended.Find(id);
            db.plane_inspections_ended.Remove(plane_inspections_ended);
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
