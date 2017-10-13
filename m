From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v5 16/16] perf util: use correct IP mapping to find
 srcline for hist entry
Date: Fri, 13 Oct 2017 10:19:59 +0900
Message-ID: <20171013011959.GA32722@sejong>
References: <20171009203310.17362-1-milian.wolff@kdab.com>
 <20171009203310.17362-17-milian.wolff@kdab.com>
 <20171010044954.GA1870@sejong>
 <2545513.2b6KD6sLaQ@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2545513.2b6KD6sLaQ@agathebauer>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: acme@kernel.org, jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, kernel-team@lge.com
List-Id: linux-perf-users.vger.kernel.org

On Thu, Oct 12, 2017 at 08:22:58PM +0200, Milian Wolff wrote:
> On Dienstag, 10. Oktober 2017 06:49:54 CEST Namhyung Kim wrote:
> > Hi Milian,
> > 
> > On Mon, Oct 09, 2017 at 10:33:10PM +0200, Milian Wolff wrote:
> > > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > > index 006d10a0dc96..6f3d109078a3 100644
> > > --- a/tools/perf/util/sort.c
> > > +++ b/tools/perf/util/sort.c
> > > @@ -334,7 +334,7 @@ char *hist_entry__get_srcline(struct hist_entry *he)
> > > 
> > >  	if (!map)
> > >  	
> > >  		return SRCLINE_UNKNOWN;
> > > 
> > > -	return get_srcline(map->dso, map__rip_2objdump(map, he->ip),
> > > +	return get_srcline(map->dso, map__objdump_2mem(map, he->ip),
> > > 
> > >  			   he->ms.sym, true, true);
> > 
> > I'm not sure this is right.  IIRC hist_entry->ip is a relative IP so
> > it needs to be changed for objdump use.  Maybe there's some bug on
> > translating the address but it seems that the original code is
> > correct.  And this change breaks srcline for my test program (which is
> > a PIE).
> 
> Odd, I'll have to look at that. But this is imo unrelated to the rest of the 
> patch series. So maybe we skip this one and apply the others. Assuming those 
> other patches are OK by now?

Yep, for the patch 1 - 15:

  Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
