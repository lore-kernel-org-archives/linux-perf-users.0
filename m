From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC PATCH RESEND] tools/perf: Add Hygon Dhyana support
Date: Mon, 12 Nov 2018 08:30:16 -0800
Message-ID: <20181112163016.GD1111@kernel.org>
References: <1542008451-31735-1-git-send-email-puwen@hygon.cn>
 <20181112110923.GB8167@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181112110923.GB8167@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Pu Wen <puwen@hygon.cn>, peterz@infradead.org, mingo@kernel.org, alexander.shishkin@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Nov 12, 2018 at 12:09:23PM +0100, Borislav Petkov escreveu:
> On Mon, Nov 12, 2018 at 03:40:51PM +0800, Pu Wen wrote:
> > The tool perf is useful for the performance analysis on the Hygon Dhyana
> > platform. But right now there is no Hygon support for it to analyze the
> > KVM guest os data. So add Hygon Dhyana support to it by checking vendor
> 
> acme, pls fix that to "OS" when applying. Thx.
> 
> > string to share the code path of AMD.
> > 
> > Signed-off-by: Pu Wen <puwen@hygon.cn>
> > ---
> >  tools/perf/arch/x86/util/kvm-stat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Borislav Petkov <bp@suse.de>

Thanks, applied.

- Arnaldo
 
> > diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
> > index b32409a..081353d 100644
> > --- a/tools/perf/arch/x86/util/kvm-stat.c
> > +++ b/tools/perf/arch/x86/util/kvm-stat.c
> > @@ -156,7 +156,7 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
> >  	if (strstr(cpuid, "Intel")) {
> >  		kvm->exit_reasons = vmx_exit_reasons;
> >  		kvm->exit_reasons_isa = "VMX";
> > -	} else if (strstr(cpuid, "AMD")) {
> > +	} else if (strstr(cpuid, "AMD") || strstr(cpuid, "Hygon")) {
> >  		kvm->exit_reasons = svm_exit_reasons;
> >  		kvm->exit_reasons_isa = "SVM";
> >  	} else
> > -- 
> > 2.7.4
> > 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
