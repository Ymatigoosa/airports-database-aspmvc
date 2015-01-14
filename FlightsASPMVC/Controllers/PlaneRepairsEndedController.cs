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
    public class PlaneRepairsEndedController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /PlaneRepairsEnded/
        public ActionResult Index()
        {
            var plane_repairs_ended = db.plane_repairs_ended.Include(p => p.plane_repairs);
            return View(plane_repairs_ended.ToList());
        }

        // GET: /PlaneRepairsEnded/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            plane_repairs_ended plane_repairs_ended = db.plane_repairs_ended.Find(id);
            if (plane_repairs_ended == null)
            {
                return HttpNotFound();
            }
            return View(plane_repairs_ended);
        }

        // GET: /PlaneRepairsEnded/Create
        public ActionResult Create()
        {
            ViewBag.repair = new SelectList(db.plane_repairs, "id", "comment");
            return View();
        }

        // POST: /PlaneRepairsEnded/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,end_date,conclusion,comment,repair")] plane_repairs_ended plane_repairs_ended)
        {
            if (ModelState.IsValid)
            {
                db.plane_repairs_ended.Add(plane_repairs_ended);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.repair = new SelectList(db.plane_repairs, "id", "comment", plane_repairs_ended.repair);
            return View(plane_repairs_ended);
        }

        // GET: /PlaneRepairsEnded/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            plane_repairs_ended plane_repairs_ended = db.plane_repairs_ended.Find(id);
            if (plane_repairs_ended == null)
            {
                return HttpNotFound();
            }
            ViewBag.repair = new SelectList(db.plane_repairs, "id", "comment", plane_repairs_ended.repair);
            return View(plane_repairs_ended);
        }

        // POST: /PlaneRepairsEnded/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,end_date,conclusion,comment,repair")] plane_repairs_ended plane_repairs_ended)
        {
            if (ModelState.IsValid)
            {
                db.Entry(plane_repairs_ended).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.repair = new SelectList(db.plane_repairs, "id", "comment", plane_repairs_ended.repair);
            return View(plane_repairs_ended);
        }

        // GET: /PlaneRepairsEnded/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            plane_repairs_ended plane_repairs_ended = db.plane_repairs_ended.Find(id);
            if (plane_repairs_ended == null)
            {
                return HttpNotFound();
            }
            return View(plane_repairs_ended);
        }

        // POST: /PlaneRepairsEnded/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            plane_repairs_ended plane_repairs_ended = db.plane_repairs_ended.Find(id);
            db.plane_repairs_ended.Remove(plane_repairs_ended);
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
