From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH 1/2] perf: Fix POWER9 metric 'lsu_other_stall_cpi'
Date: Fri, 8 May 2020 12:01:56 +0530
Message-ID: <fa59ef0f-50b3-0ca5-adbe-9dcf06627c06@linux.ibm.com>
References: <1588868938-21933-1-git-send-email-pc@us.ibm.com>
 <1588868938-21933-2-git-send-email-pc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1588868938-21933-2-git-send-email-pc@us.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul A. Clarke" <pc@us.ibm.com>, linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, acme@kernel.org, ananth@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.ibm.com, mpe@ellerman.id.au, irogers@google.com
List-Id: linux-perf-users.vger.kernel.org



On 5/7/20 9:58 PM, Paul A. Clarke wrote:
> From: "Paul A. Clarke" <pc@us.ibm.com>
> 
> The metric definition is too long for the current value of EXPR_MAX_OTHER.
> Increase the value EXPR_MAX_OTHER sufficiently to allow
> 'lsu_other_stall_cpi' to build properly.
> 
> Before:
> --
> $ perf list | grep lsu_other
>   lsu_other_stall_cpi
> # perf stat -a --metrics lsu_other_stall_cpi /bin/sleep 1
> Cannot find metric or group `lsu_other_stall_cpi'
> 
>  Usage: perf stat [<options>] [<command>]
> 
>     -M, --metrics <metric/metric group list>
>                           monitor specified metrics or metric groups (separated by ,)
> --
> 
> After:
> --
> # perf stat -a --metrics lsu_other_stall_cpi /bin/sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>        438,086,889      pm_cmplu_stall_lsu        #     1.74 lsu_other_stall_cpi
> [...]
> --
> 
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> ---
>  tools/perf/util/expr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 87d627bb699b..a0991959cca4 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -2,7 +2,7 @@
>  #ifndef PARSE_CTX_H
>  #define PARSE_CTX_H 1
>  
> -#define EXPR_MAX_OTHER 20
> +#define EXPR_MAX_OTHER 28

Hi Paul,
	Ian already add one patch to increase EXPR_MAX_OTHER value to 68 which is Acked-by: Jiri

Link to the patch: https://lkml.org/lkml/2020/5/1/1023

Thanks,
Kajol Jain

>  #define MAX_PARSE_ID EXPR_MAX_OTHER
>  
>  struct expr_parse_id {
> 
