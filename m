From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: Records call-graphs on ARM, reporting on x86_64
Date: Mon, 12 Feb 2018 09:28:35 +0100
Message-ID: <20180212082835.GA6253@krava>
References: <30C2D590D16A5C46ADFE6521910377989262C15B@AZ-US1EXMB02.global.avaya.com>
 <2197547.58bztnllri@milian-kdab2>
 <30C2D590D16A5C46ADFE6521910377989262C1A9@AZ-US1EXMB02.global.avaya.com>
 <30C2D590D16A5C46ADFE6521910377989262D993@AZ-US1EXMB02.global.avaya.com>
 <20180209145608.1f37b8ddc53b398d2fc17013@arm.com>
 <30C2D590D16A5C46ADFE6521910377989262DACC@AZ-US1EXMB02.global.avaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932785AbeBLI2j (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Feb 2018 03:28:39 -0500
Content-Disposition: inline
In-Reply-To: <30C2D590D16A5C46ADFE6521910377989262DACC@AZ-US1EXMB02.global.avaya.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Vuille, Martin (Martin)" <vmartin@avaya.com>
Cc: Kim Phillips <kim.phillips@arm.com>, Milian Wolff <milian.wolff@kdab.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Fri, Feb 09, 2018 at 11:26:26PM +0000, Vuille, Martin (Martin) wrote:
> > I thought files like arch/arm/include/perf_regs.h handled that; is that not the
> > case?
> 
> That is true. But if perf is compiled for x86_64, then it is compiled with
> arch/x86/... and knows nothing of arch/arm/... The architecture selection is
> done at compile time.

right, seems like a problem for libdw, but it shouldn't be problem for
linwunwind where it's compiled in via util/libunwind/arm64.o

> 
>  > Some distros like Ubuntu provide cross unwind packages such as android-
> > libunwind[-dev], and I've been known to build unwind and dwarf libraries
> > from scratch to get the best results;  not sure if this will help you though (I
> > work best given a list of commands that do or don't work).
> > 
> 
> elfutils/libdw supports all architectures by selecting at run-time based on
> the ELF header 'machine' type. So that's not an issue.
> 
> I recompiled perf with 'ARCH=arm' on my x86_64 host and, with a few hacks
> and the fix to problem (2), it now works fine and can unwind my ARM call
> stacks just fine.

could you please share those hacks? 

thanks,
jirka
