From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v6 1/5] perf/jevents: Remove jevents.h file
Date: Mon, 31 Aug 2020 10:43:48 +0200
Message-ID: <20200831084348.GB287892@krava>
References: <20200827130958.189146-1-kjain@linux.ibm.com>
 <20200827130958.189146-2-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200827130958.189146-2-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, john.garry@huawei.com
List-Id: linux-perf-users.vger.kernel.org

On Thu, Aug 27, 2020 at 06:39:54PM +0530, Kajol Jain wrote:
> This patch removes jevents.h file and add its data inside
> jevents.c as this file is only included there.
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  tools/perf/pmu-events/jevents.c |  9 ++++++++-
>  tools/perf/pmu-events/jevents.h | 23 -----------------------
>  2 files changed, 8 insertions(+), 24 deletions(-)
>  delete mode 100644 tools/perf/pmu-events/jevents.h
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index fa86c5f997cc..1c55cc754b5a 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -48,11 +48,18 @@
>  #include <linux/list.h>
>  #include "jsmn.h"
>  #include "json.h"
> -#include "jevents.h"
>  
>  int verbose;
>  char *prog;
>  
> +#ifndef min
> +#define min(x, y) ({				\
> +	typeof(x) _min1 = (x);			\
> +	typeof(y) _min2 = (y);			\
> +	(void)(&_min1 == &_min2);		\
> +	_min1 < _min2 ? _min1 : _min2; })
> +#endif
> +
>  int eprintf(int level, int var, const char *fmt, ...)
>  {
>  
> diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
> deleted file mode 100644
> index 2afc8304529e..000000000000
> --- a/tools/perf/pmu-events/jevents.h
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef JEVENTS_H
> -#define JEVENTS_H 1
> -
> -int json_events(const char *fn,
> -		int (*func)(void *data, char *name, char *event, char *desc,
> -				char *long_desc,
> -				char *pmu,
> -				char *unit, char *perpkg, char *metric_expr,
> -				char *metric_name, char *metric_group,
> -				char *deprecated, char *metric_constraint),
> -		void *data);
> -char *get_cpu_str(void);

I think you can also remove get_cpu_str from jevents.c

thanks,
jirka
