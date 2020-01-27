From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2 4/7] perf tools: Support "branch-misses:pp" on arm64
Date: Mon, 27 Jan 2020 13:31:20 +0100
Message-ID: <20200127123120.GD1114818@krava>
References: <20200123160734.3775-1-james.clark@arm.com>
 <20200123160734.3775-5-james.clark@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200123160734.3775-5-james.clark@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Clark <james.clark@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, suzuki.poulose@arm.com, gengdongjiu@huawei.com, wxf.wang@hisilicon.com, liwei391@huawei.com, liuqi115@hisilicon.com, huawei.libin@huawei.com, nd@arm.com, linux-perf-users@vger.kernel.org, Tan Xiaojun <tanxiaojun@huawei.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Al Grant <al.grant@arm.com>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Jan 23, 2020 at 04:07:31PM +0000, James Clark wrote:

SNIP

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 1548237b6558..b9c7e5271611 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -9,6 +9,7 @@
>  #include <errno.h>
>  #include <inttypes.h>
>  #include <poll.h>
> +#include "arm-spe.h"
>  #include "cpumap.h"
>  #include "util/mmap.h"
>  #include "thread_map.h"
> @@ -179,6 +180,7 @@ void perf_evlist__splice_list_tail(struct evlist *evlist,
>  	struct evsel *evsel, *temp;
>  
>  	__evlist__for_each_entry_safe(list, temp, evsel) {
> +		arm_spe_precise_ip_support(evlist, evsel);

this is 'splice' function, you can't configure precise in here

do you need this 'config thing' to be executed on arm only?

if yes, please add something like arch_evsel__config, make it
weak for generic code and define it for arm

if no, just add the call at the end perf_evsel__config I guess

thanks,
jirka

>  		list_del_init(&evsel->core.node);
>  		evlist__add(evlist, evsel);
>  	}
> -- 
> 2.25.0
> 
