From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] perf kvm: Fix subcommands on s390
Date: Thu, 12 Jul 2018 09:15:28 +0200
Message-ID: <0e9cf3c2-55c5-72e5-27c9-35cffd7f22f0@de.ibm.com>
References: <20180712070936.67547-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180712070936.67547-1-tmricht@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Stefan Raspl <raspl@linux.ibm.com>, stable@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org



On 07/12/2018 09:09 AM, Thomas Richter wrote:
> With commit eca0fa28cd0d ("perf record: Provide detailed information on s390 CPU")
> s390 platform provides detailed type/model/capacitiy information
> in the CPU indentifier string instead of just "IBM/S390".
> 
> This breaks perf kvm support which uses hard coded string IBM/S390 to
> compare with the CPU identifier string. Fix this by changing the comparison.
> 
> Fixes: eca0fa28cd0d ("perf record: Provide detailed information on s390 CPU")
> Cc: Stefan Raspl <raspl@linux.ibm.com>
> Cc: <stable@vger.kernel.org> # 4.17
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  tools/perf/arch/s390/util/kvm-stat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/s390/util/kvm-stat.c b/tools/perf/arch/s390/util/kvm-stat.c
> index d233e2eb9592..aaabab5e2830 100644
> --- a/tools/perf/arch/s390/util/kvm-stat.c
> +++ b/tools/perf/arch/s390/util/kvm-stat.c
> @@ -102,7 +102,7 @@ const char * const kvm_skip_events[] = {
>  
>  int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
>  {
> -	if (strstr(cpuid, "IBM/S390")) {
> +	if (strstr(cpuid, "IBM")) {
>  		kvm->exit_reasons = sie_exit_reasons;
>  		kvm->exit_reasons_isa = "SIE";
>  	} else
> 
