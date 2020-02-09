From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 3/4] perf map: Set kmap->kmaps backpointer for main
 kernel map chunks
Date: Sun, 9 Feb 2020 16:01:08 +0100
Message-ID: <20200209150108.GA1784847@krava>
References: <20191223133241.8578-1-acme@kernel.org>
 <20191223133241.8578-4-acme@kernel.org>
 <2617ead1-60e2-3da6-cde6-9efd68412139@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2617ead1-60e2-3da6-cde6-9efd68412139@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Feb 06, 2020 at 03:10:38PM +0530, Ravi Bangoria wrote:
> Hi Arnaldo,
> 
> On 12/23/19 7:02 PM, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > When a map is create to represent the main kernel area (vmlinux) with
> > map__new2() we allocate an extra area to store a pointer to the 'struct
> > maps' for the kernel maps, so that we can access that struct when
> > loading ELF files or kallsyms, as we will need to split it in multiple
> > maps, one per kernel module or ELF section (such as ".init.text").
> > 
> > So when map->dso->kernel is non-zero, it is expected that
> > map__kmap(map)->kmaps to be set to the tree of kernel maps (modules,
> > chunks of the main kernel, bpf progs put in place via
> > PERF_RECORD_KSYMBOL, the main kernel).
> > 
> > This was not the case when we were splitting the main kernel into chunks
> > for its ELF sections, which ended up making 'perf report --children'
> > processing a perf.data file with callchains to trip on
> > __map__is_kernel(), when we press ENTER to see the popup menu for main
> > histogram entries that starts at a symbol in the ".init.text" ELF
> > section, e.g.:
> > 
> > -    8.83%     0.00%  swapper     [kernel.vmlinux].init.text  [k] start_kernel
> >       start_kernel
> >       cpu_startup_entry
> >       do_idle
> >       cpuidle_enter
> >       cpuidle_enter_state
> >       intel_idle
> > 
> > Fix it.
> 
> perf top from perf/core has started crashing at __map__is_kernel():
> 
>   (gdb) bt
>   #0  __map__is_kernel (map=<optimized out>) at util/map.c:935
>   #1  0x000000000045551d in perf_event__process_sample (machine=0xbab8f8,
>       sample=0x7fffe5ffa6d0, evsel=0xba7570, event=0xbcac50, tool=0x7fffffff84e0)
>       at builtin-top.c:833
>   #2  deliver_event (qe=<optimized out>, qevent=<optimized out>) at builtin-top.c:1192
>   #3  0x000000000050b9fb in do_flush (show_progress=false, oe=0x7fffffff87e0)
>       at util/ordered-events.c:244
>   #4  __ordered_events__flush (oe=oe@entry=0x7fffffff87e0, how=how@entry=OE_FLUSH__TOP,
>       timestamp=timestamp@entry=0) at util/ordered-events.c:323
>   #5  0x000000000050c1b5 in __ordered_events__flush (timestamp=<optimized out>,
>       how=<optimized out>, oe=<optimized out>) at util/ordered-events.c:339
>   #6  ordered_events__flush (how=OE_FLUSH__TOP, oe=0x7fffffff87e0) at util/ordered-events.c:341
>   #7  ordered_events__flush (oe=oe@entry=0x7fffffff87e0, how=how@entry=OE_FLUSH__TOP)
>       at util/ordered-events.c:339
>   #8  0x0000000000454e21 in process_thread (arg=0x7fffffff84e0) at builtin-top.c:1104
>   #9  0x00007ffff7f2c4e2 in start_thread () from /lib64/libpthread.so.0
>   #10 0x00007ffff76086d3 in clone () from /lib64/libc.so.6
> 
> I haven't debugged it much but seems like the actual patch that's causing the
> crash is de90d513b246 ("perf map: Use map->dso->kernel + map__kmaps() in
> map__kmaps()").
> 
> Did you face this / aware of it?

hum, looks like there are few more places where we don't set
kmaps pointer, patch below fixes that for me

I'll still need to do more checking and I'll send a fix

jirka


---
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c8c5410315e8..28212193e1e9 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -686,6 +686,7 @@ static struct dso *machine__findnew_module_dso(struct machine *machine,
 
 		dso__set_module_info(dso, m, machine);
 		dso__set_long_name(dso, strdup(filename), true);
+		dso->kernel = DSO_TYPE_KERNEL;
 	}
 
 	dso__get(dso);
@@ -774,6 +775,7 @@ static struct map *machine__addnew_module_map(struct machine *machine, u64 start
 					      const char *filename)
 {
 	struct map *map = NULL;
+	struct kmap *kmap;
 	struct kmod_path m;
 	struct dso *dso;
 
@@ -790,6 +792,9 @@ static struct map *machine__addnew_module_map(struct machine *machine, u64 start
 
 	maps__insert(&machine->kmaps, map);
 
+	kmap = map__kmap(map);
+	kmap->kmaps = &machine->kmaps;
+
 	/* Put the map here because maps__insert alread got it */
 	map__put(map);
 out:
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 3b379b1296f1..c3dd20082734 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -862,6 +862,9 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 				return -1;
 			}
 
+			if (ndso->kernel)
+				map__kmap(curr_map)->kmaps = kmaps;
+
 			curr_map->map_ip = curr_map->unmap_ip = identity__map_ip;
 			maps__insert(kmaps, curr_map);
 			++kernel_range;
@@ -1145,11 +1148,13 @@ static int validate_kcore_addresses(const char *kallsyms_filename,
 struct kcore_mapfn_data {
 	struct dso *dso;
 	struct list_head maps;
+	struct maps *kmaps;
 };
 
 static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 {
 	struct kcore_mapfn_data *md = data;
+	struct kmap *kmap;
 	struct map *map;
 
 	map = map__new2(start, md->dso);
@@ -1161,6 +1166,8 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 
 	list_add(&map->node, &md->maps);
 
+	kmap = map__kmap(map);
+	kmap->kmaps = md->kmaps;
 	return 0;
 }
 
@@ -1270,6 +1277,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	if (validate_kcore_addresses(kallsyms_filename, map))
 		return -EINVAL;
 
+	md.kmaps = kmaps;
 	md.dso = dso;
 	INIT_LIST_HEAD(&md.maps);
 
