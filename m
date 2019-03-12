From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 3/3] perf, tools, report: Set up samples correctly in
 hierarchy mode
Date: Tue, 12 Mar 2019 06:52:30 -0700
Message-ID: <20190312135230.bmjm4ynzrtwjf7cr@two.firstfloor.org>
References: <20190312035224.30350-1-andi@firstfloor.org>
 <20190312035224.30350-4-andi@firstfloor.org>
 <20190312111259.GA24700@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190312111259.GA24700@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>, acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Tue, Mar 12, 2019 at 12:12:59PM +0100, Jiri Olsa wrote:
> On Mon, Mar 11, 2019 at 08:52:24PM -0700, Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > In hierarchy mode the res samples need to be cloned from the parent
> > entry. Copy them in this case. This fixes res sample browsing
> > with --hierarchy.
> > 
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> > ---
> >  tools/perf/util/hist.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > index 1f230285d78a..dcf24581dfbd 100644
> > --- a/tools/perf/util/hist.c
> > +++ b/tools/perf/util/hist.c
> > @@ -437,8 +437,15 @@ static int hist_entry__init(struct hist_entry *he,
> >  	}
> >  
> >  	if (symbol_conf.res_sample) {
> > -		he->res_samples = calloc(sizeof(struct res_sample),
> > -					symbol_conf.res_sample);
> > +		if (he->res_samples) {
> 
> I dont think this leg will ever execute because we don't set
> res_samples in template

I originally thought this too, but ...

The hierarchy mode calls it with a hist entry that is not
a template.

-Andi
