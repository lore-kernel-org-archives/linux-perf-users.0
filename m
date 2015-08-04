From: Milian Wolff <mail@milianw.de>
Subject: Re: Haswell LBR call stacks - broken
Date: Tue, 04 Aug 2015 19:24:04 +0200
Message-ID: <8643019.4YmQ1Xdl9W@milian-kdab2>
References: <1682663.JO3lAz5bZo@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:55181 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502AbbHDRYG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Aug 2015 13:24:06 -0400
Received: from milian-kdab2.localnet (unknown [185.28.184.2])
	by dd17628.kasserver.com (Postfix) with ESMTPSA id E84CA62803F8
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Aug 2015 19:24:04 +0200 (CEST)
In-Reply-To: <1682663.JO3lAz5bZo@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

On Sunday 14 June 2015 13:02:57 Milian Wolff wrote:
> Hey all,
> 
> Some time ago I read this interesting article:
> 
> http://article.gmane.org/gmane.linux.kernel/1809078
> 
> It mentions a new call stack unwinding for perf, based on Haswell LBR
> facility. I now have a new Laptop with a Broadwell i7-5600U CPU, but my perf
> version 4.0.3 running against a Linux 4.0.4 kernel (all vanilla Archlinux
> versions) does not seem to support this feature. Was it ever included in
> the mainline? Is a special compiler flag required to enable this feature?
> Anything else I'm missing?
> 
> callchain: Unknown --call-graph option value: lbr
> 
>  usage: perf record [<options>] [<command>]
>     or: perf record [<options>] -- <command> [<options>]
> 
>         --call-graph <mode[,dump_size]>
>                           setup and enables call-graph (stack
> chain/backtrace) recording: fp dwarf

OK, with a more recent perf v4.2.rc5 on a Intel(R) Core(TM) i7-4770 CPU @ 
3.40GHz it actually works. Somewhat :) It is much faster, but the callstacks 
don't terminate properly, and are sometimes not correctly demangled. I observe 
the following behavior:

    15.56%  ex_string_compa  libQt5Core.so.5.5.0   [.] QString::compare_helper                 
            |          
            |--5.84%-- 
_ZN7QString14compare_helperEPK5QChariS2_iN2Qt15CaseSensitivityE@plt
            |          QString::compare_helper
            |          main
            |          |          
            |          |--4.24%-- main
            |          |          |          
            |          |          |--1.60%-- main
            |          |          |          |          
            |          |          |          |--1.07%-- main
            |          |          |          |          |          
            |          |          |          |          |--0.54%-- main
            |          |          |          |          |          main
            |          |          |          |          |          
            |          |          |          |           --0.53%-- 
QString::compare_helper
            |          |          |          |                     main
            |          |          |          |          
            |          |          |           --0.53%-- 
QString::compare_helper
            |          |          |                     main
            |          |          |                     main
            |          |          |                     
QString::compare_helper
            |          |          |                     main
            |          |          |                     
QString::compare_helper
...

The correct callgraph, as shown by --call-graph dwarf, is:

    21.62%  ex_string_compa  libQt5Core.so.5.5.0   [.] QString::compare_helper                                        
            |
            ---QString::compare_helper
               main

Is this a known (undocumented) limitation or a bug? Is there anything I could 
do to get this fixed?

Thanks
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
