From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFC v2 5/5] perf/tools/pmu_events/powerpc: Add hv_24x7 core
 level metric events
Date: Sun, 12 Jul 2020 20:55:43 +0200
Message-ID: <20200712185543.GC147742@krava>
References: <20200707122314.624400-1-kjain@linux.ibm.com>
 <20200707122314.624400-6-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200707122314.624400-6-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, anju@linux.vnet.ibm.com, kan.liang@linux.intel.com, nasastry@in.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Tue, Jul 07, 2020 at 05:53:14PM +0530, Kajol Jain wrote:
> This patch adds hv_24x7 core level events in nest_metric.json file
> and also add PerChip/PerCore field in metric events.
> 
> Result:
> 
> power9 platform:
> 
> command:# ./perf stat --metric-only -M PowerBUS_Frequency -C 0 -I 1000
>      1.000070601                        1.9                        2.0
>      2.000253881                        2.0                        1.9
>      3.000364810                        2.0                        2.0
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  .../arch/powerpc/power9/nest_metrics.json       | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> index c121e526442a..2a471cb5dd7a 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> @@ -3,17 +3,26 @@
>          "MetricExpr": "(hv_24x7@PM_MCS01_128B_RD_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS01_128B_RD_DISP_PORT23\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_RD_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_RD_DISP_PORT23\\,chip\\=?@)",
>          "MetricName": "Memory_RD_BW_Chip",
>          "MetricGroup": "Memory_BW",
> -        "ScaleUnit": "1.6e-2MB"
> +        "ScaleUnit": "1.6e-2MB",
> +	"AggregationMode": "PerChip"
>      },
>      {
>  	"MetricExpr": "(hv_24x7@PM_MCS01_128B_WR_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS01_128B_WR_DISP_PORT23\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_WR_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_WR_DISP_PORT23\\,chip\\=?@ )",
>          "MetricName": "Memory_WR_BW_Chip",
>          "MetricGroup": "Memory_BW",
> -        "ScaleUnit": "1.6e-2MB"
> +        "ScaleUnit": "1.6e-2MB",
> +	"AggregationMode": "PerChip"

please keep the same indentation, also below

jirka

>      },
>      {
>  	"MetricExpr": "(hv_24x7@PM_PB_CYC\\,chip\\=?@ )",
>          "MetricName": "PowerBUS_Frequency",
> -        "ScaleUnit": "2.5e-7GHz"
> -    }
> +        "ScaleUnit": "2.5e-7GHz",
> +	"AggregationMode": "PerChip"
> +    },
> +    {
> +	"MetricExpr": "(hv_24x7@CPM_CS_32MHZ_CYC\\,domain\\=3\\,core\\=?@ )",
> +        "MetricName": "CPM_CS_32MHZ_CYC",
> +        "ScaleUnit": "1MHz",
> +	"AggregationMode": "PerCore"
> +     }
>  ]
> -- 
> 2.26.2
> 
