From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3 1/5] perf/pmu-events/jevents: Add enum to store
 aggregation like PerPkg
Date: Fri, 17 Jul 2020 10:53:01 +0200
Message-ID: <20200717085301.GB528602@krava>
References: <20200716094216.1418659-1-kjain@linux.ibm.com>
 <20200716094216.1418659-2-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200716094216.1418659-2-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, anju@linux.vnet.ibm.com, kan.liang@linux.intel.com, nasastry@in.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Thu, Jul 16, 2020 at 03:12:12PM +0530, Kajol Jain wrote:
> Initially, every time we want to add new terms like chip, core thread etc,
> we need to create corrsponding fields in pmu_events and event struct.
> This patch adds an enum called 'aggr_mode_class' which store all these
> aggregation like perpkg/percore. It also adds new field 'aggr_mode'
> to capture these terms.
> Now, if user wants to add any new term, they just need to add it in
> the enum defined.
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  tools/perf/pmu-events/jevents.c    | 39 +++++++++++++++++++-----------
>  tools/perf/pmu-events/jevents.h    |  2 +-
>  tools/perf/pmu-events/pmu-events.h |  6 ++++-
>  tools/perf/tests/pmu-events.c      |  8 +++---
>  tools/perf/util/pmu.c              |  6 ++---
>  5 files changed, 38 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index fa86c5f997cc..b2f59f0af63d 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -53,6 +53,17 @@
>  int verbose;
>  char *prog;
>  
> +enum aggr_mode_class {
> +	PerPkg = 1
> +};
> +
> +enum aggr_mode_class convert(const char *aggr_mode)
> +{
> +	if (!strcmp(aggr_mode, "PerPkg"))
> +		return PerPkg;
> +	return -1;
> +}

I just noticed you define aggr_mode_class twice,
I think we should keep it just in pmu-events.h
like in change below (compiles for me)

thanks,
jirka


---
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index e1c43f739083..2f48b783a64d 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -49,16 +49,11 @@
 #include "jsmn.h"
 #include "json.h"
 #include "jevents.h"
+#include "pmu-events.h"
 
 int verbose;
 char *prog;
 
-enum aggr_mode_class {
-	PerPkg = 1,
-	PerChip,
-	PerCore
-};
-
 enum aggr_mode_class convert(const char *aggr_mode)
 {
 	if (!strcmp(aggr_mode, "PerPkg"))
