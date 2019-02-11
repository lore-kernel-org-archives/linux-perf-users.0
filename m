From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2 0/4] [powerpc] perf vendor events: Add JSON metrics
 for POWER8
Date: Mon, 11 Feb 2019 12:52:05 -0300
Message-ID: <20190211155205.GD3269@kernel.org>
References: <20190207175314.31813-1-pc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190207175314.31813-1-pc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Clarke <pc@us.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, ananth@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.ibm.com, mpe@ellerman.id.au, cel@us.ibm.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Feb 07, 2019 at 12:53:10PM -0500, Paul Clarke escreveu:
> The patches define metrics and metric groups for computation by "perf" for
> POWER8 processors.
> 
> Paul Clarke (4):
>   [powerpc] perf vendor events: Add JSON metrics for POWER8 1/4
>   [powerpc] perf vendor events: Add JSON metrics for POWER8 2/4
>   [powerpc] perf vendor events: Add JSON metrics for POWER8 3/4
>   [powerpc] perf vendor events: Add JSON metrics for POWER8 4/4
> 
> v2:
> The content of these patches was sent previously, to LKML and linux-perf-users,
> but never showed up at linux-perf-users, so I split it into smaller patches
> and am resending.
> 
>  .../arch/powerpc/power8/metrics.json          | 2245 +++++++++++++++++
>  1 file changed, 2245 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power8/metrics.json

Thanks, applied, next time please CC:

[acme@quaco perf]$ scripts/get_maintainer.pl tools/perf
Peter Zijlstra <peterz@infradead.org> (supporter:PERFORMANCE EVENTS SUBSYSTEM)
Ingo Molnar <mingo@redhat.com> (supporter:PERFORMANCE EVENTS SUBSYSTEM)
Arnaldo Carvalho de Melo <acme@kernel.org> (supporter:PERFORMANCE EVENTS SUBSYSTEM)
Alexander Shishkin <alexander.shishkin@linux.intel.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
Jiri Olsa <jolsa@redhat.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
Namhyung Kim <namhyung@kernel.org> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
[acme@quaco perf]$

So that it gets to my main inbox and may get slightly faster processing.

- Arnaldo
