From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 12/12] perf maps: Set maps pointer in the kmap area for
 kernel maps
Date: Wed, 18 Dec 2019 11:24:22 -0300
Message-ID: <20191218142422.GE7095@redhat.com>
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
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>
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

I'll add that, yeah

- Arnaldo
