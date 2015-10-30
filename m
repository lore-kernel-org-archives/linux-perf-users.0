From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC] perf: fix building for ARCv1
Date: Fri, 30 Oct 2015 06:21:56 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F44CE691@IN01WEMBXA.internal.synopsys.com>
References: <1445088959-3058-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:51761 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283AbbJ3GWA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 30 Oct 2015 02:22:00 -0400
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, lkml <linux-kernel@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>

On Saturday 17 October 2015 07:06 PM, Alexey Brodkin wrote:
> Perf uses atomic options and so it is required to have atomics enabled
> in toolchain.
>
> In case of ARC atomics are enabled by default for ARCv2 but disabled for
> ARCv1. Now we explicitly enable atomics for either ARC achitecture
> version so perf could be successfully built.
>
> Currently on attempt to build perf for ARCv1 you'll see tons of:
> ----------------->8-----------------
> undefined reference to `__sync_add_and_fetch_4'
> ----------------->8-----------------
>
> Still note if ARCv1 CPU is configured without LL/SC perf will crash on
> execution once "llock" instruction is attempted to be executed.
>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>

Acked-by: Vineet Gupta <vgupta@synopsys.com>


> ---
>  tools/perf/config/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
> index 38a0853..dc7c0a8 100644
> --- a/tools/perf/config/Makefile
> +++ b/tools/perf/config/Makefile
> @@ -47,6 +47,11 @@ ifeq ($(ARCH),arm64)
>    LIBUNWIND_LIBS = -lunwind -lunwind-aarch64
>  endif
>  
> +# Additional ARCH settings for ARC
> +ifeq ($(ARCH),arc)
> +  CFLAGS += -matomic
> +endif
> +
>  ifeq ($(NO_PERF_REGS),0)
>    $(call detected,CONFIG_PERF_REGS)
>  endif
