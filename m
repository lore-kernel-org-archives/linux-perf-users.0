From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2 0/7] Share events between metrics
Date: Fri, 22 May 2020 11:31:41 -0300
Message-ID: <20200522143141.GG14034@kernel.org>
References: <20200520182011.32236-1-irogers@google.com>
 <3e8f12d8-0c56-11e9-e557-e384210f15c1@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3e8f12d8-0c56-11e9-e557-e384210f15c1@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
To: kajoljain <kjain@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andriin@fb.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>, Kim Phillips <kim.phillips@amd.com>, Paul Clarke <pc@us.ibm.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, Vince
List-Id: linux-perf-users.vger.kernel.org

Em Fri, May 22, 2020 at 02:55:46PM +0530, kajoljain escreveu:
> On 5/20/20 11:50 PM, Ian Rogers wrote:
> > Metric groups contain metrics. Metrics create groups of events to
> > ideally be scheduled together. Often metrics refer to the same events,
> > for example, a cache hit and cache miss rate. Using separate event
> > groups means these metrics are multiplexed at different times and the
> > counts don't sum to 100%. More multiplexing also decreases the
> > accuracy of the measurement.

<SNIP>
 
> > Ian Rogers (7):
> >   perf metricgroup: Always place duration_time last
> >   perf metricgroup: Use early return in add_metric
> >   perf metricgroup: Delay events string creation
> >   perf metricgroup: Order event groups by size
> >   perf metricgroup: Remove duped metric group events
> >   perf metricgroup: Add options to not group or merge
> >   perf metricgroup: Remove unnecessary ',' from events
 
> Reviewd-By: Kajol Jain <kjain@linux.ibm.com>
> Tested-By: Kajol Jain <kjain@linux.ibm.com> ( Tested it to see behavior with some metric groups in both x86 and Power machine)

Thanks, added to the patches,

- Arnaldo
