From: Kim Phillips <kim.phillips@arm.com>
Subject: Re: Records call-graphs on ARM, reporting on x86_64
Date: Fri, 9 Feb 2018 14:56:08 -0600
Message-ID: <20180209145608.1f37b8ddc53b398d2fc17013@arm.com>
References: <30C2D590D16A5C46ADFE6521910377989262C15B@AZ-US1EXMB02.global.avaya.com>
        <2197547.58bztnllri@milian-kdab2>
        <30C2D590D16A5C46ADFE6521910377989262C1A9@AZ-US1EXMB02.global.avaya.com>
        <30C2D590D16A5C46ADFE6521910377989262D993@AZ-US1EXMB02.global.avaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750853AbeBIU4J (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Feb 2018 15:56:09 -0500
In-Reply-To: <30C2D590D16A5C46ADFE6521910377989262D993@AZ-US1EXMB02.global.avaya.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Vuille, Martin (Martin)" <vmartin@avaya.com>
Cc: Milian Wolff <milian.wolff@kdab.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Fri, 9 Feb 2018 18:06:03 +0000
"Vuille, Martin (Martin)" <vmartin@avaya.com> wrote:

> > > Afaik this is not yet implemented in perf report when you use libunwind.
> > > When
> > > you use elfutils instead of unwinding, it could work if I'm not mistaken.
> > 
> 
> After further investigation, here's what I have found:
> 
> 1) With the perf code as it stands, it is absolutely impossible to do cross-platform
>      unwinding because the unwinding code selects Program Counter and Stack Pointer
>      registers based on the host architecture, not the architecture of the ELF file.

I thought files like arch/arm/include/perf_regs.h handled that; is that
not the case?

> After doing an ugly hack to work around this, I found:
> 
> 2) The DSO path passed to libdw does not account for --symfs option. So libdw
>      cannot find the debug information, ever.
> 
> I think I can tackle fixing (2).
> 
> It seems (1) is more of an architectural issue. If I understand correctly, perf can only
> support one architecture, which is selected with conditional compilation based on
> the architecture of the machine on which perf is built. This would have to change
> to be able to dynamically select the architecture based on ELF content, same as libdw
> does.

I know perf record only does one arch, but perf report should correctly
report any host arch and non-host arch equally.

Some distros like Ubuntu provide cross unwind packages such as
android-libunwind[-dev], and I've been known to build unwind and dwarf
libraries from scratch to get the best results;  not sure if this will
help you though (I work best given a list of commands that do or don't
work).

Thanks,

Kim
