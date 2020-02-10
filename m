From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
Date: Mon, 10 Feb 2020 10:00:31 -0800
Message-ID: <20200210180031.GY302770@tassilo.jf.intel.com>
References: <20200131052522.7267-1-kjain@linux.ibm.com>
 <20200206184510.GA1669706@krava>
 <51a4b570eb47e80801a460c89acf20d13a269600.camel@perches.com>
 <20200210121135.GI1907700@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200210121135.GI1907700@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Joe Perches <joe@perches.com>, Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jin Yao <yao.jin@linux.intel.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

> > stack declarations of variable length arrays are not
> > a good thing.
> > 
> > https://lwn.net/Articles/749089/
> > 
> > and
> > 
> > 	bool evlist_used[perf_evlist->core.nr_entries] = {};
> 
> hum, I think we already have few of them in perf ;-)

For user space they don't really matter as long as the size is
not totally out of bound, it has a fairly large stack compared
to the kernel, and also is less security sensitive.

-Andi
