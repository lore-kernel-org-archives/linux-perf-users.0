From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 12/12] perf maps: Set maps pointer in the kmap area for
 kernel maps
Date: Wed, 18 Dec 2019 15:22:54 -0300
Message-ID: <20191218182254.GA13282@kernel.org>
References: <20191217144828.2460-1-acme@kernel.org>
 <20191217144828.2460-13-acme@kernel.org>
 <20191218090504.GE19062@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191218090504.GE19062@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Dec 18, 2019 at 10:05:04AM +0100, Jiri Olsa escreveu:
> On Tue, Dec 17, 2019 at 11:48:28AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> SNIP
> 
> > +	machine->vmlinux_map = map__new2(0, kernel, &machine->kmaps);
> >  	if (machine->vmlinux_map == NULL)
> >  		return -1;
> >  
> > @@ -1098,7 +1097,6 @@ __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
> >  	if (!kmap)
> >  		return -1;
> >  
> > -	kmap->kmaps = &machine->kmaps;
> >  	maps__insert(&machine->kmaps, map);
> >  
> >  	return 0;
> > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > index fdd5bddb3075..a2cdfe62df94 100644
> > --- a/tools/perf/util/map.c
> > +++ b/tools/perf/util/map.c
> > @@ -223,7 +223,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
> >   * they are loaded) and for vmlinux, where only after we load all the
> >   * symbols we'll know where it starts and ends.
> >   */
> > -struct map *map__new2(u64 start, struct dso *dso)
> > +struct map *map__new2(u64 start, struct dso *dso, struct maps *kmaps)
> >  {
> >  	struct map *map = calloc(1, (sizeof(*map) +
> >  				     (dso->kernel ? sizeof(struct kmap) : 0)));
> > @@ -232,6 +232,19 @@ struct map *map__new2(u64 start, struct dso *dso)
> >  		 * ->end will be filled after we load all the symbols
> >  		 */
> >  		map__init(map, start, 0, 0, dso);
> 
> we are passing NULL for kmaps in some cases,
> should we check it in here and warn?
> 
> 		if (!WARN_ON_ONCE(!kmaps, "too bad..") && dso->kernel)

After looking at this some more, I retract this patch and instead the
two-liner at the end of this message seems enough.

I forgot the dso->kernel is just set for the main kernel map, and what
dso__process_kernel_symbol is doing is to split that map into chunks for
the ELF sections for the main kernel map, as an extra tidbit of
information, i.e. that symbol is in a specific main kernel section, so
its dso->kernel continues being set and thus it expects the kmap area to
be in place.

There is space for simplification in this old code, but for now the
safest is just the patch below, agreed?

- Arnaldo

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 6658fbf196e6..1965aefccb02 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -920,6 +920,9 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		if (curr_map == NULL)
 			return -1;
 
+		if (curr_dso->kernel)
+			map__kmap(curr_map)->kmaps = kmaps;
+
 		if (adjust_kernel_syms) {
 			curr_map->start  = shdr->sh_addr + ref_reloc(kmap);
 			curr_map->end	 = curr_map->start + shdr->sh_size;
