From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1 06/10] perf, tools, report: Print better message for
 JITed code
Date: Mon, 11 Mar 2019 13:48:56 -0700
Message-ID: <20190311204856.GD29294@tassilo.jf.intel.com>
References: <20190311202446.10210-1-andi@firstfloor.org>
 <20190311202446.10210-7-andi@firstfloor.org>
 <20190311203302.GB10690@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190311203302.GB10690@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Mon, Mar 11, 2019 at 05:33:02PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Mar 11, 2019 at 01:24:42PM -0700, Andi Kleen escreveu:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > The message about missing /tmp/perf-* for JITed code is quite confusing
> > to users. Add a better error message, but only print it once.
> > 
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> > ---
> >  tools/perf/util/map.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > index fbeb0c6efaa6..d476b76abc6a 100644
> > --- a/tools/perf/util/map.c
> > +++ b/tools/perf/util/map.c
> > @@ -316,6 +316,15 @@ int map__load(struct map *map)
> >  
> >  	nr = dso__load(map->dso, map);
> >  	if (nr < 0) {
> > +		if (!strncmp(map->dso->name, "/tmp/perf-", 10)) {
> > +			static bool warned;
> > +			if (!warned) {
> > +				pr_err("Cannot find executable, JITed code present? May need agent.\n");
> > +				warned = true;
> > +			}
> 
> Please use WARN_ON_ONCE(), we have it in tools/include/asm/bug.h, just
> like the kernel.

But that prints "assertation failed". This is not a perf bug, but can happen
in normal operation.

-Andi
