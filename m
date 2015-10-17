From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC] perf: fix building for ARCv1
Date: Sat, 17 Oct 2015 14:19:19 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F44C9DD2@IN01WEMBXA.internal.synopsys.com>
References: <1445088959-3058-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:54133 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485AbbJQOTX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 17 Oct 2015 10:19:23 -0400
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Aabid Rushdi <Aabid.Rushdi@synopsys.com>, lkml <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Darren Hart <dvhart@linux.intel.com>

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

Ok this fixes ARCompact - assuming it will have LL/SC. We do have old SoCs w/o
that support.
So what we are saying is that any arch (or a configuration thereof) which doesn't
support atomic r-m-w can't even build perf now - that sucks !

A better way would be to do feature test for __sync_xyz and make atomic_xxx
wrappers call __sync_xyz) vs. an empty stub.
So atleast such arches can build and do "some" perf work !

-Vineet

> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
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
