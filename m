From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 4/9] perf tools: Maintain cgroup hierarchy
Date: Wed, 8 Jan 2020 22:52:35 +0100
Message-ID: <20200108215235.GA12995@krava>
References: <20200107133501.327117-1-namhyung@kernel.org>
 <20200107133501.327117-5-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200107133501.327117-5-namhyung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Tue, Jan 07, 2020 at 10:34:56PM +0900, Namhyung Kim wrote:
> Each cgroup is kept in the global cgroup_tree sorted by the cgroup id.
> Hist entries have cgroup id can compare it directly and later it can
> be used to find a group name using this tree.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/cgroup.c  | 72 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/cgroup.h  | 15 +++++---
>  tools/perf/util/machine.c |  7 ++++
>  tools/perf/util/session.c |  4 +++
>  4 files changed, 94 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> index 4881d4af3381..4e8ef1db0c94 100644
> --- a/tools/perf/util/cgroup.c
> +++ b/tools/perf/util/cgroup.c
> @@ -13,6 +13,8 @@
>  
>  int nr_cgroups;
>  
> +static struct rb_root cgroup_tree = RB_ROOT;

I think we shoud carry that in 'struct perf_env' 

jirka
