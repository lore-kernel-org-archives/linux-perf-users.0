From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 12/12] perf maps: Set maps pointer in the kmap area for
 kernel maps
Date: Wed, 18 Dec 2019 11:20:10 -0300
Message-ID: <20191218142010.GD13395@kernel.org>
References: <20191217144828.2460-1-acme@kernel.org>
 <20191217144828.2460-13-acme@kernel.org>
 <20191218090707.GF19062@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191218090707.GF19062@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Dec 18, 2019 at 10:07:07AM +0100, Jiri Olsa escreveu:
> On Tue, Dec 17, 2019 at 11:48:28AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> SNIP
> 
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

> hum, how about map__new? kernel maps could go throught that as well, right?

Nope, I even thought about renaming map__new2() to map__new_kmap() as
only it is used to create kernel/modules maps, as is stated above in the
comment just before map__new2().

map__new() is only called from machine__process_mmap_event() and machine__process_mmap2_event()
and only after checking if it is not a kernel "mmap":

        if (sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
            sample->cpumode == PERF_RECORD_MISC_KERNEL) {
                ret = machine__process_kernel_mmap_event(machine, event);
		if (ret < 0)
                        goto out_problem;
                return 0;
	...
	map = map__new(...);

- Arnaldo
