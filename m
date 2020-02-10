From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 3/4] perf map: Set kmap->kmaps backpointer for main
 kernel map chunks
Date: Mon, 10 Feb 2020 01:37:57 +0100
Message-ID: <20200210003757.GB1907700@krava>
References: <20191223133241.8578-1-acme@kernel.org>
 <20191223133241.8578-4-acme@kernel.org>
 <2617ead1-60e2-3da6-cde6-9efd68412139@linux.ibm.com>
 <20200209150108.GA1784847@krava>
 <20200209193238.GA1907700@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200209193238.GA1907700@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Sun, Feb 09, 2020 at 08:32:38PM +0100, Jiri Olsa wrote:

SNIP

> > > 
> > > perf top from perf/core has started crashing at __map__is_kernel():
> > > 
> > >   (gdb) bt
> > >   #0  __map__is_kernel (map=<optimized out>) at util/map.c:935
> > >   #1  0x000000000045551d in perf_event__process_sample (machine=0xbab8f8,
> > >       sample=0x7fffe5ffa6d0, evsel=0xba7570, event=0xbcac50, tool=0x7fffffff84e0)
> > >       at builtin-top.c:833
> > >   #2  deliver_event (qe=<optimized out>, qevent=<optimized out>) at builtin-top.c:1192
> > >   #3  0x000000000050b9fb in do_flush (show_progress=false, oe=0x7fffffff87e0)
> > >       at util/ordered-events.c:244
> > >   #4  __ordered_events__flush (oe=oe@entry=0x7fffffff87e0, how=how@entry=OE_FLUSH__TOP,
> > >       timestamp=timestamp@entry=0) at util/ordered-events.c:323
> > >   #5  0x000000000050c1b5 in __ordered_events__flush (timestamp=<optimized out>,
> > >       how=<optimized out>, oe=<optimized out>) at util/ordered-events.c:339
> > >   #6  ordered_events__flush (how=OE_FLUSH__TOP, oe=0x7fffffff87e0) at util/ordered-events.c:341
> > >   #7  ordered_events__flush (oe=oe@entry=0x7fffffff87e0, how=how@entry=OE_FLUSH__TOP)
> > >       at util/ordered-events.c:339
> > >   #8  0x0000000000454e21 in process_thread (arg=0x7fffffff84e0) at builtin-top.c:1104
> > >   #9  0x00007ffff7f2c4e2 in start_thread () from /lib64/libpthread.so.0
> > >   #10 0x00007ffff76086d3 in clone () from /lib64/libc.so.6
> > > 
> > > I haven't debugged it much but seems like the actual patch that's causing the
> > > crash is de90d513b246 ("perf map: Use map->dso->kernel + map__kmaps() in
> > > map__kmaps()").
> > > 
> > > Did you face this / aware of it?
> > 
> > hum, looks like there are few more places where we don't set
> > kmaps pointer, patch below fixes that for me
> > 
> > I'll still need to do more checking and I'll send a fix
> > 
> > jirka
> > 
> > 
> > ---
> 
> I found one more place.. please check the attached patch

and third time's the charm.. hopefully ;-)

I made the fix more central.. it still needs to be split
into several small fixes, but I'm running perf top for
few hours now without the crash

jirka


---
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c8c5410315e8..460315476314 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -686,6 +686,7 @@ static struct dso *machine__findnew_module_dso(struct machine *machine,
 
 		dso__set_module_info(dso, m, machine);
 		dso__set_long_name(dso, strdup(filename), true);
+		dso->kernel = DSO_TYPE_KERNEL;
 	}
 
 	dso__get(dso);
@@ -726,8 +727,14 @@ static int machine__process_ksymbol_register(struct machine *machine,
 	struct map *map = maps__find(&machine->kmaps, event->ksymbol.addr);
 
 	if (!map) {
-		map = dso__new_map(event->ksymbol.name);
-		if (!map)
+		struct dso *dso = dso__new(event->ksymbol.name);
+
+		if (dso) {
+			dso->kernel = DSO_TYPE_KERNEL;
+			map = map__new2(0, dso);
+		}
+
+		if (!dso || !map)
 			return -ENOMEM;
 
 		map->start = event->ksymbol.addr;
@@ -972,7 +979,6 @@ int machine__create_extra_kernel_map(struct machine *machine,
 
 	kmap = map__kmap(map);
 
-	kmap->kmaps = &machine->kmaps;
 	strlcpy(kmap->name, xm->name, KMAP_NAME_LEN);
 
 	maps__insert(&machine->kmaps, map);
@@ -1082,9 +1088,6 @@ int __weak machine__create_extra_kernel_maps(struct machine *machine __maybe_unu
 static int
 __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 {
-	struct kmap *kmap;
-	struct map *map;
-
 	/* In case of renewal the kernel map, destroy previous one */
 	machine__destroy_kernel_maps(machine);
 
@@ -1093,14 +1096,7 @@ __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 		return -1;
 
 	machine->vmlinux_map->map_ip = machine->vmlinux_map->unmap_ip = identity__map_ip;
-	map = machine__kernel_map(machine);
-	kmap = map__kmap(map);
-	if (!kmap)
-		return -1;
-
-	kmap->kmaps = &machine->kmaps;
-	maps__insert(&machine->kmaps, map);
-
+	maps__insert(&machine->kmaps, machine->vmlinux_map);
 	return 0;
 }
 
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index f67960bedebb..a08ca276098e 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -375,8 +375,13 @@ struct symbol *map__find_symbol_by_name(struct map *map, const char *name)
 
 struct map *map__clone(struct map *from)
 {
-	struct map *map = memdup(from, sizeof(*map));
+	size_t size = sizeof(struct map);
+	struct map *map;
+
+	if (from->dso && from->dso->kernel)
+		size += sizeof(struct kmap);
 
+	map = memdup(from, size);
 	if (map != NULL) {
 		refcount_set(&map->refcnt, 1);
 		RB_CLEAR_NODE(&map->rb_node);
@@ -538,6 +543,16 @@ void maps__insert(struct maps *maps, struct map *map)
 	__maps__insert(maps, map);
 	++maps->nr_maps;
 
+	if (map->dso && map->dso->kernel) {
+		struct kmap *kmap = map__kmap(map);
+
+		if (kmap)
+			kmap->kmaps = maps;
+		else
+			pr_err("Internal error: kernel dso with non kernel map\n");
+	}
+
+
 	/*
 	 * If we already performed some search by name, then we need to add the just
 	 * inserted map and resort.
