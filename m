From: David Ahern <dsahern@gmail.com>
Subject: Re: Cross platform perf reporting
Date: Fri, 12 Aug 2016 08:38:24 -0600
Message-ID: <3408f889-40a2-ae3f-db8e-0efb9c817c97@gmail.com>
References: <3989281.iuuvGBEDVR@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35198 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbcHLOkD (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 12 Aug 2016 10:40:03 -0400
Received: by mail-pf0-f174.google.com with SMTP id x72so9725627pfd.2
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Aug 2016 07:38:30 -0700 (PDT)
In-Reply-To: <3989281.iuuvGBEDVR@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>, linux-perf-users@vger.kernel.org

On 8/12/16 6:22 AM, Milian Wolff wrote:
> Hey all,
> 
> I'm trying to analyze perf.data files that I recorded on one machine (usually 
> arm or arm64) on my development machine (x86_64). I have compiled a new 
> version of perf (and the corresponding dependencies, where needed) to do this.
> 
> Now I do:
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~
> aarch64$ perf record -g ...
> aarch64$ perf archive
> 
> x86_64$ scp aarch64:perf.data* .
> x86_64$ tar xvf perf.data.tar.bz2 -C ~/.debug
> x86_64$ perf report |& less
> -> lots of errors, none of which are displayed in the TUI, such as:
> 
> unwind: target platform=arm64 is not supported
> (often repeated)
> Failed to open /lib/ld-2.21.so, continuing without symbols
> Failed to open /lib/libc-2.21.so, continuing without symbols
> Failed to open /lib/libpthread-2.21.so, continuing without symbols
> Failed to open /lib/libdl-2.21.so, continuing without symbols
> ...
> ~~~~~~~~~~~~~~~~~~~~~~~~
> 
> If I try to run `perf report` on the device, I actually see resolved symbol 
> names and backtraces, e.g.:
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~
> aarch64$ perf report
> ...
>     62.93%     0.00%  QQmlThread       libglib-2.0.so.0.4200.1                                       
> [.] g_main_context_iteration
>             |
>             ---g_main_context_iteration
>                |          
>                 --62.92%--0x55ae0
>                           g_main_context_dispatch
>                           0x322dc4
>                           QCoreApplicationPrivate::sendPostedEvents
>                           |          
>                            --62.91%--QCoreApplication::notifyInternal2
>                                      QCoreApplication::notify
>                                      QCoreApplicationPrivate::notify_helper
>                                      0x2decc8
>                                      |          
>                                       --62.89%--0x2de2b4
> ...
> ~~~~~~~~~~~~~~~~~~~~~~~~
> 
> But if I do the same on my development machine, after extracting the perf 
> archive, I only see:
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~
>     62.93%     0.00%  QQmlThread       [unknown]                                                     
> [.] 0x0000007fa58c0eac
>             |
>             ---0x7fa58c0eac
>                |          
>                 --62.93%--0x7fa58c14a4
>                           |          
>                            --62.92%--0x7fa56c43bc
>                                      0x7fa5e55dfc
>                                      0x7fa56c9be8
>                                      0x6e48
>                                      0xc7e90
> ~~~~~~~~~~~~~~~~~~~~~~~~
> 
> So my questions:
> 
> - How do I get an arm / aarch64 unwinder to work on x86_64? Do I need to 
> compile libunwind in a special way?
> 
> - Is the unwinder what is missing to get the symbols resolved in the report? 
> Note that e.g. the "libglib" is not reported as "Failed to open", thus I 
> wonder why I'm not seeing the "g_main_context_iteration" symbol from it in the 
> report. It seems as if the mapping between address and SO is broken?
> 
> Any hints on how to improve that situation would be welcome.

The symfs option was added for this use case. If the dev system does not have the exact same binaries (build id match) perf will not load the symbols. You can create a sysroot that mirrors the runtime environment and then point perf to it using --symfs <path>
