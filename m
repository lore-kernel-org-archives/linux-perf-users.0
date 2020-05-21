From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2 0/7] Share events between metrics
Date: Thu, 21 May 2020 14:22:35 -0300
Message-ID: <20200521172235.GD14034@kernel.org>
References: <20200520182011.32236-1-irogers@google.com>
 <20200521114325.GT157452@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200521114325.GT157452@krava>
Sender: netdev-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andriin@fb.com>, Kajol Jain <kjain@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>, Kim Phillips <kim.phillips@amd.com>, Paul Clarke <pc@us.ibm.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, Vince
List-Id: linux-perf-users.vger.kernel.org

Em Thu, May 21, 2020 at 01:43:25PM +0200, Jiri Olsa escreveu:
> On Wed, May 20, 2020 at 11:20:04AM -0700, Ian Rogers wrote:
> 
> SNIP
> 
> > There are 5 out of 12 metric groups where no events are shared, such
> > as Power, however, disabling grouping of events always reduces the
> > number of events.
> > 
> > The result for Memory_BW needs explanation:
> > 
> > Metric group: Memory_BW
> >  - No merging (old default, now --metric-no-merge): 9
> >  - Merging over metrics (new default)             : 5
> >  - No event groups and merging (--metric-no-group): 11
> > 
> > Both with and without merging the groups fail to be set up and so the
> > event counts here are for broken metrics. The --metric-no-group number
> > is accurate as all the events are scheduled. Ideally a constraint
> > would be added for these metrics in the json code to avoid grouping.
> > 
> > v2. rebases on kernel/git/acme/linux.git branch tmp.perf/core, fixes a
> > missing comma with metric lists (reported-by Jiri Olsa
> > <jolsa@redhat.com>) and adds early returns to metricgroup__add_metric
> > (suggested-by Jiri Olsa).
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Applied and pushed to tmp.perf/core, will move to perf/core as soon as
testing finishes,

- Arnaldo
