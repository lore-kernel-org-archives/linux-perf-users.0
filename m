From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 11/11] perf tools report: Implement browsing of
 individual samples
Date: Mon, 4 Mar 2019 15:48:48 +0100
Message-ID: <20190304144848.GK30476@krava>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-12-andi@firstfloor.org>
 <20190225125615.GI19795@krava>
 <20190225133335.GM16922@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190225133335.GM16922@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>, acme@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
List-Id: linux-perf-users.vger.kernel.org

On Mon, Feb 25, 2019 at 05:33:35AM -0800, Andi Kleen wrote:
> On Mon, Feb 25, 2019 at 01:56:15PM +0100, Jiri Olsa wrote:
> > On Sun, Feb 24, 2019 at 07:37:22AM -0800, Andi Kleen wrote:
> > 
> > SNIP
> > 
> > > +static void hists__res_sample(struct hist_entry *he, struct perf_sample *sample)
> > > +{
> > > +	struct res_sample *r;
> > > +	int j;
> > > +
> > > +	if (!he->res_samples) {
> > > +		he->res_samples = calloc(sizeof(struct res_sample),
> > > +					symbol_conf.res_sample);
> > > +		if (!he->res_samples)
> > > +			return;
> > > +	}
> > > +	if (he->num_res < symbol_conf.res_sample) {
> > > +		j = he->num_res++;
> > > +	} else {
> > > +		j = random_max(++he->num_res + 1);
> > 
> > will he->num_res keep raising all the time?
> 
> Yes, but the display code limits it to symbol_conf.res_samples
> 
> That was intentional so that we can keep track of the total
> number of samples. Plan was to eventually display it somewhere
> so that the users know how many of the samples are covered
> (currently it is not though) 

if it's not use please change it, so it's not confusing
also there's hist_entry::stat.nr_events for that

jirka
