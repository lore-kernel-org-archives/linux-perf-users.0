From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
Date: Thu, 6 Feb 2020 12:10:22 -0800
Message-ID: <20200206201022.GN302770@tassilo.jf.intel.com>
References: <20200131052522.7267-1-kjain@linux.ibm.com>
 <20200206184510.GA1669706@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200206184510.GA1669706@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jin Yao <yao.jin@linux.intel.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Feb 06, 2020 at 07:45:10PM +0100, Jiri Olsa wrote:
> On Fri, Jan 31, 2020 at 10:55:22AM +0530, Kajol Jain wrote:
> 
> SNIP
> 
> >  				ev->metric_leader = metric_events[i];
> >  			}
> > +			j++;
> >  		}
> > +		ev = metric_events[i];
> > +		evlist_used[ev->idx] = true;
> >  	}
> >  
> >  	return metric_events[0];
> > @@ -160,6 +161,9 @@ static int metricgroup__setup_events(struct list_head *groups,
> >  	int ret = 0;
> >  	struct egroup *eg;
> >  	struct evsel *evsel;
> > +	bool evlist_used[perf_evlist->core.nr_entries];
> > +
> > +	memset(evlist_used, 0, perf_evlist->core.nr_entries);
> 
> I know I posted this in the previous email, but are we sure bool
> is always 1 byte?  would sizeod(evlist_used) be safer?
> 
> other than that it looks ok
> 
> Andi, you're ok with this?

Yes.

-Andi
