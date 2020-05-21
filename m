From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2 0/7] Share events between metrics
Date: Thu, 21 May 2020 13:43:25 +0200
Message-ID: <20200521114325.GT157452@krava>
References: <20200520182011.32236-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200520182011.32236-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andriin@fb.com>, Kajol Jain <kjain@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>, Kim Phillips <kim.phillips@amd.com>, Paul Clarke <pc@us.ibm.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Wed, May 20, 2020 at 11:20:04AM -0700, Ian Rogers wrote:

SNIP

> There are 5 out of 12 metric groups where no events are shared, such
> as Power, however, disabling grouping of events always reduces the
> number of events.
> 
> The result for Memory_BW needs explanation:
> 
> Metric group: Memory_BW
>  - No merging (old default, now --metric-no-merge): 9
>  - Merging over metrics (new default)             : 5
>  - No event groups and merging (--metric-no-group): 11
> 
> Both with and without merging the groups fail to be set up and so the
> event counts here are for broken metrics. The --metric-no-group number
> is accurate as all the events are scheduled. Ideally a constraint
> would be added for these metrics in the json code to avoid grouping.
> 
> v2. rebases on kernel/git/acme/linux.git branch tmp.perf/core, fixes a
> missing comma with metric lists (reported-by Jiri Olsa
> <jolsa@redhat.com>) and adds early returns to metricgroup__add_metric
> (suggested-by Jiri Olsa).

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> v1. was prepared on kernel/git/acme/linux.git branch tmp.perf/core
> 
> Compared to RFC v3: fix a bug where unnecessary commas were passed to
> parse-events and were echoed. Fix a bug where the same event could be
> matched more than once with --metric-no-group, causing there to be
> events missing.
> https://lore.kernel.org/lkml/20200508053629.210324-1-irogers@google.com/
> 
> Ian Rogers (7):
>   perf metricgroup: Always place duration_time last
>   perf metricgroup: Use early return in add_metric
>   perf metricgroup: Delay events string creation
>   perf metricgroup: Order event groups by size
>   perf metricgroup: Remove duped metric group events
>   perf metricgroup: Add options to not group or merge
>   perf metricgroup: Remove unnecessary ',' from events
> 
>  tools/perf/Documentation/perf-stat.txt |  19 ++
>  tools/perf/builtin-stat.c              |  11 +-
>  tools/perf/util/metricgroup.c          | 239 ++++++++++++++++++-------
>  tools/perf/util/metricgroup.h          |   6 +-
>  tools/perf/util/stat.h                 |   2 +
>  5 files changed, 207 insertions(+), 70 deletions(-)
> 
> -- 
> 2.26.2.761.g0e0b3e54be-goog
> 
