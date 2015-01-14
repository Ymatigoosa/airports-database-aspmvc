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
    public class PlaneInfoViewController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /PlaneInfoView/
        public ActionResult Index()
        {
            var t = db.plane_info.ToList();
            return View(db.plane_info.ToList());
        }

        // GET: /PlaneInfoView/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            plane_info plane_info = db.plane_info.Find(id);
            if (plane_info == null)
            {
                return HttpNotFound();
            }
            return View(plane_info);
        }

        // GET: /PlaneInfoView/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: /PlaneInfoView/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,airline,passenger_capacity,model,last_repair,last_repair_conclusion,last_inspection,last_inspections_conclusion")] plane_info plane_info)
        {
            if (ModelState.IsValid)
            {
                db.plane_info.Add(plane_info);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(plane_info);
        }

        // GET: /PlaneInfoView/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            plane_info plane_info = db.plane_info.Find(id);
            if (plane_info == null)
            {
                return HttpNotFound();
            }
            return View(plane_info);
        }

        // POST: /PlaneInfoView/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,airline,passenger_capacity,model,last_repair,last_repair_conclusion,last_inspection,last_inspections_conclusion")] plane_info plane_info)
        {
            if (ModelState.IsValid)
            {
                db.Entry(plane_info).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(plane_info);
        }

        // GET: /PlaneInfoView/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            plane_info plane_info = db.plane_info.Find(id);
            if (plane_info == null)
            {
                return HttpNotFound();
            }
            return View(plane_info);
        }

        // POST: /PlaneInfoView/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            plane_info plane_info = db.plane_info.Find(id);
            db.plane_info.Remove(plane_info);
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
