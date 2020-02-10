From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 3/3 v2] perf symbols: convert symbol__is_idle to use
 strlist
Date: Mon, 10 Feb 2020 16:32:51 -0300
Message-ID: <20200210193251.GD3416@kernel.org>
References: <20200207230613.26709-1-kim.phillips@amd.com>
 <20200210163147.25358-1-kim.phillips@amd.com>
 <4F6B8692-B1FE-4108-A6B3-44EEE5F92C97@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F6B8692-B1FE-4108-A6B3-44EEE5F92C97@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Song Liu <songliubraving@fb.com>
Cc: Kim Phillips <kim.phillips@amd.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Andi Kleen <ak@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Feb 10, 2020 at 06:51:53PM +0000, Song Liu escreveu:
> 
> 
> > On Feb 10, 2020, at 8:31 AM, Kim Phillips <kim.phillips@amd.com> wrote:
> > 
> > Use the more optimized strlist implementation to do the idle function
> > lookup.
> > 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Cong Wang <xiyou.wangcong@gmail.com>
> > Cc: Jin Yao <yao.jin@linux.intel.com>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Kim Phillips <kim.phillips@amd.com>
> > Cc: Song Liu <songliubraving@fb.com>
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Cc: linux-perf-users@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> > ---
> > v2: new this series, based on Jiri's comment:
> > 
> > https://lore.kernel.org/lkml/20200120092844.GC608405@krava/
> > 
> > ...and this time with the Cc list intact.
> > 
> > tools/perf/util/symbol.c | 14 +++++++++-----
> > 1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index f3120c4f47ad..1077013d8ce2 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -654,13 +654,17 @@ static bool symbol__is_idle(const char *name)
> > 		NULL
> > 	};
> > 	int i;
> > +	static struct strlist *idle_symbols_list;
> 
> nit, probably just personal preference:
> 
> Maybe move idle_symbols_list out of the function and add the logic 
> to symbol__init()?
> 
> Other than this:
> 
> Acked-by: Song Liu <songliubraving@fb.com>

I applied it as is, improvements can be made on top of it.

- Arnaldo
 
> > 
> > -	for (i = 0; idle_symbols[i]; i++) {
> > -		if (!strcmp(idle_symbols[i], name))
> > -			return true;
> > -	}
> > +	if (idle_symbols_list)
> > +		return strlist__has_entry(idle_symbols_list, name);
> > 
> > -	return false;
> > +	idle_symbols_list = strlist__new(NULL, NULL);
> > +
> > +	for (i = 0; idle_symbols[i]; i++)
> > +		strlist__add(idle_symbols_list, idle_symbols[i]);
> > +
> > +	return strlist__has_entry(idle_symbols_list, name);
> > }
> > 
> > static int map__process_kallsym_symbol(void *arg, const char *name,
> > -- 
> > 2.25.0
> > 
> 

-- 

- Arnaldo
