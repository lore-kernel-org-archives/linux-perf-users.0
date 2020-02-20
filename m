From: maddy <maddy@linux.ibm.com>
Subject: Re: [PATCH 8/8] perf/tools/pmu-events/powerpc: Add hv_24x7
 socket/chip level metric events
Date: Thu, 20 Feb 2020 15:23:41 +0530
Message-ID: <276f2495-c838-cae4-d654-065e43b0323a@linux.ibm.com>
References: <20200214110335.31483-1-kjain@linux.ibm.com>
 <20200214110335.31483-9-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200214110335.31483-9-kjain@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org
List-Id: linux-perf-users.vger.kernel.org



On 2/14/20 4:33 PM, Kajol Jain wrote:
> The hv_24×7 feature in IBM® POWER9™ processor-based servers provide the
> facility to continuously collect large numbers of hardware performance
> metrics efficiently and accurately.
> This patch adds hv_24x7 json metric file for different Socket/chip
> resources.
>
> Result:
>
> power9 platform:
>
> command:# ./perf stat --metric-only -M Memory_RD_BW_Chip -C 0
>             -I 1000 sleep 1
>
> time MB       Memory_RD_BW_Chip_0 MB   Memory_RD_BW_Chip_1 MB
> 1.000192635                      0.4                      0.0
> 1.001695883                      0.0                      0.0
>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>   .../arch/powerpc/power9/hv_24x7_metrics.json  | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>   create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/hv_24x7_metrics.json
>
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/hv_24x7_metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/hv_24x7_metrics.json
> new file mode 100644
> index 000000000000..ac38f5540ac6
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/hv_24x7_metrics.json

Better to have it as nest_metrics.json instead.  Rest looks fine

Reviewed-by: Madhavan Srinivasan <maddy@linux.ibm.com>

> @@ -0,0 +1,19 @@
> +[
> +    {
> +        "MetricExpr": "(hv_24x7@PM_MCS01_128B_RD_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS01_128B_RD_DISP_PORT23\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_RD_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_RD_DISP_PORT23\\,chip\\=?@)",
> +        "MetricName": "Memory_RD_BW_Chip",
> +        "MetricGroup": "Memory_BW",
> +        "ScaleUnit": "1.6e-2MB"
> +    },
> +    {
> +    "MetricExpr": "(hv_24x7@PM_MCS01_128B_WR_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS01_128B_WR_DISP_PORT23\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_WR_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_WR_DISP_PORT23\\,chip\\=?@ )",
> +        "MetricName": "Memory_WR_BW_Chip",
> +        "MetricGroup": "Memory_BW",
> +        "ScaleUnit": "1.6e-2MB"
> +    },
> +    {
> +    "MetricExpr": "(hv_24x7@PM_PB_CYC\\,chip\\=?@ )",
> +        "MetricName": "PowerBUS_Frequency",
> +        "ScaleUnit": "2.5e-7GHz"
> +    }
> +]
