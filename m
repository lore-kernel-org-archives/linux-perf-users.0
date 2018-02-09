From: "Vuille, Martin (Martin)" <vmartin@avaya.com>
Subject: RE: Records call-graphs on ARM, reporting on x86_64
Date: Fri, 9 Feb 2018 23:26:26 +0000
Message-ID: <30C2D590D16A5C46ADFE6521910377989262DACC@AZ-US1EXMB02.global.avaya.com>
References: <30C2D590D16A5C46ADFE6521910377989262C15B@AZ-US1EXMB02.global.avaya.com>
        <2197547.58bztnllri@milian-kdab2>
        <30C2D590D16A5C46ADFE6521910377989262C1A9@AZ-US1EXMB02.global.avaya.com>
        <30C2D590D16A5C46ADFE6521910377989262D993@AZ-US1EXMB02.global.avaya.com>
 <20180209145608.1f37b8ddc53b398d2fc17013@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from p-us1-iereast-outbound.us1.avaya.com ([135.11.29.13]:33597 "EHLO
        p-us1-iereast-outbound.us1.avaya.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753073AbeBIX0b (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Feb 2018 18:26:31 -0500
In-Reply-To: <20180209145608.1f37b8ddc53b398d2fc17013@arm.com>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Kim Phillips <kim.phillips@arm.com>
Cc: Milian Wolff <milian.wolff@kdab.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

> I thought files like arch/arm/include/perf_regs.h handled that; is that not the
> case?

That is true. But if perf is compiled for x86_64, then it is compiled with
arch/x86/... and knows nothing of arch/arm/... The architecture selection is
done at compile time.

 > Some distros like Ubuntu provide cross unwind packages such as android-
> libunwind[-dev], and I've been known to build unwind and dwarf libraries
> from scratch to get the best results;  not sure if this will help you though (I
> work best given a list of commands that do or don't work).
> 

elfutils/libdw supports all architectures by selecting at run-time based on
the ELF header 'machine' type. So that's not an issue.

I recompiled perf with 'ARCH=arm' on my x86_64 host and, with a few hacks
and the fix to problem (2), it now works fine and can unwind my ARM call
stacks just fine.

MV
