From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH RESEND] tools/perf: Add Hygon Dhyana support
Date: Mon, 12 Nov 2018 12:09:23 +0100
Message-ID: <20181112110923.GB8167@zn.tnic>
References: <1542008451-31735-1-git-send-email-puwen@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1542008451-31735-1-git-send-email-puwen@hygon.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Pu Wen <puwen@hygon.cn>, acme@kernel.org
Cc: peterz@infradead.org, mingo@kernel.org, alexander.shishkin@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Mon, Nov 12, 2018 at 03:40:51PM +0800, Pu Wen wrote:
> The tool perf is useful for the performance analysis on the Hygon Dhyana
> platform. But right now there is no Hygon support for it to analyze the
> KVM guest os data. So add Hygon Dhyana support to it by checking vendor

acme, pls fix that to "OS" when applying. Thx.

> string to share the code path of AMD.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  tools/perf/arch/x86/util/kvm-stat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Borislav Petkov <bp@suse.de>

> diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
> index b32409a..081353d 100644
> --- a/tools/perf/arch/x86/util/kvm-stat.c
> +++ b/tools/perf/arch/x86/util/kvm-stat.c
> @@ -156,7 +156,7 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
>  	if (strstr(cpuid, "Intel")) {
>  		kvm->exit_reasons = vmx_exit_reasons;
>  		kvm->exit_reasons_isa = "VMX";
> -	} else if (strstr(cpuid, "AMD")) {
> +	} else if (strstr(cpuid, "AMD") || strstr(cpuid, "Hygon")) {
>  		kvm->exit_reasons = svm_exit_reasons;
>  		kvm->exit_reasons_isa = "SVM";
>  	} else
> -- 
> 2.7.4
> 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
