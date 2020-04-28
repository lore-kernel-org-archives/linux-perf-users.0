From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH v8 0/7] powerpc/perf: Add json file metric support for the
 hv_24x7 socket/chip level events
Date: Tue, 28 Apr 2020 12:02:42 +0530
Message-ID: <fa31bc42-d34c-c788-0109-350d769b51ce@linux.ibm.com>
References: <20200401203340.31402-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200401203340.31402-1-kjain@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org

Hi Arnaldo,
	Please let me know if there any changes required in this patchset,
as some of its patches are still not part of your perf/core tree.

Thanks,
Kajol Jain

On 4/2/20 2:03 AM, Kajol Jain wrote:
> Patchset adds json file metric support for the hv_24x7 socket/chip level
> events. "hv_24x7" pmu interface events needs system dependent parameter
> like socket/chip/core. For example, hv_24x7 chip level events needs
> specific chip-id to which the data is requested should be added as part
> of pmu events.
> 
> So to enable JSON file support to "hv_24x7" interface, patchset reads
> total number of sockets details in sysfs under 
> "/sys/devices/hv_24x7/interface/".
> 
> Second patch of the patchset adds expr_scanner_ctx object to hold user
> data for the expr scanner, which can be used to hold runtime parameter.
> 
> Patch 4 & 6 of the patchset handles perf tool plumbing needed to replace
> the "?" character in the metric expression to proper value and hv_24x7
> json metric file for different Socket/chip resources.
> 
> Patch set also enable Hz/hz prinitg for --metric-only option to print
> metric data for bus frequency.
> 
> Applied and tested all these patches cleanly on top of jiri's flex changes
> with the changes done by Kan Liang for "Support metric group constraint"
> patchset and made required changes.
> 
> Also apply this patch on top of the fix patch send earlier
> for printing metric name incase overlapping events.
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=37cd7f65bf71a48f25eeb6d9be5dacb20d008ea6
> 
> Changelog:
> v7 -> v8
> - Add test case for testing parsing of "?" in metric expression
> - Reaname variables name to runtime
> 
> v6 -> v7
> - Spit patchset into two patch series one for kernel changes and other
>   for tool side changes.
> - Made changes Suggested by Jiri, including rather then reading runtime
>   parameter from metric name, actually add it in structure egroup and
>   metric_expr.
> - As we don't need to read runtime parameter from metric name,
>   now I am not appending it and rather just printing it in
>   generic_metric function.
> 
> Kernel Side changes patch series: https://lkml.org/lkml/2020/3/27/58
> 
> v5 -> v6
> - resolve compilation issue due to rearranging patch series.
> - Rather then adding new function to take careof case for runtime param
>   in metricgroup__add_metric, using metricgroup__add_metric_param itself
>   for that work.
> - Address some optimization suggested like using directly file path
>   rather then adding new macro in header.c
> - Change commit message on patch where we are adding "?" support
>   by adding simple example.
> 
> v4 -> v5
> - Using sysfs__read_int instead of sysfs__read_ull while reading
>   parameter value in powerpc/util/header.c file.
> 
> - Using asprintf rather then malloc and sprintf 
>   Suggested by Arnaldo Carvalho de Melo
> 
> - Break patch 6 from previous version to two patch,
>   - One to add refactor current "metricgroup__add_metric" function
>     and another where actually "?" handling infra added.
> 
> - Add expr__runtimeparam as part of 'expr_scanner_ctx' struct
>   rather then making it global variable. Thanks Jiri for
>   adding this structure to hold user data for the expr scanner.
> 
> - Add runtime param as agrugement to function 'expr__find_other'
>   and 'expr__parse' and made changes on references accordingly.
> 
> v3 -> v4
> - Apply these patch on top of Kan liang changes.
>   As suggested by Jiri.
> 
> v2 -> v3
> - Remove setting  event_count to 0 part in function 'h_24x7_event_read'
>   with comment rather then adding 0 to event_count value.
>   Suggested by: Sukadev Bhattiprolu
> 
> - Apply tool side changes require to replace "?" on Jiri's flex patch
>   series and made all require changes to make it compatible with added
>   flex change.
> 
> v1 -> v2
> - Rename hv-24x7 metric json file as nest_metrics.json
> 
> Jiri Olsa (2):
>   perf expr: Add expr_ prefix for parse_ctx and parse_id
>   perf expr: Add expr_scanner_ctx object
> 
> Kajol Jain (5):
>   perf/tools: Refactoring metricgroup__add_metric function
>   perf/tools: Enhance JSON/metric infrastructure to handle "?"
>   perf/tests/expr: Added test for runtime param in metric expression
>   tools/perf: Enable Hz/hz prinitg for --metric-only option
>   perf/tools/pmu-events/powerpc: Add hv_24x7 socket/chip level metric
>     events
> 
>  tools/perf/arch/powerpc/util/header.c         |  8 ++
>  .../arch/powerpc/power9/nest_metrics.json     | 19 +++++
>  tools/perf/tests/expr.c                       | 20 +++--
>  tools/perf/util/expr.c                        | 25 +++---
>  tools/perf/util/expr.h                        | 19 +++--
>  tools/perf/util/expr.l                        | 37 ++++++---
>  tools/perf/util/expr.y                        |  6 +-
>  tools/perf/util/metricgroup.c                 | 78 +++++++++++++------
>  tools/perf/util/metricgroup.h                 |  2 +
>  tools/perf/util/stat-display.c                |  2 -
>  tools/perf/util/stat-shadow.c                 | 19 +++--
>  11 files changed, 164 insertions(+), 71 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> 
