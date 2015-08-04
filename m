From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Haswell LBR call stacks - broken
Date: Tue, 04 Aug 2015 11:10:32 -0700
Message-ID: <87h9oe3ox3.fsf@tassilo.jf.intel.com>
References: <1682663.JO3lAz5bZo@agathebauer> <8643019.4YmQ1Xdl9W@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3736 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752247AbbHDSLo (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Aug 2015 14:11:44 -0400
In-Reply-To: <8643019.4YmQ1Xdl9W@milian-kdab2> (Milian Wolff's message of
	"Tue, 04 Aug 2015 19:24:04 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: linux-perf-users@vger.kernel.org, kan.liang@intel.com

Milian Wolff <mail@milianw.de> writes:
>
> OK, with a more recent perf v4.2.rc5 on a Intel(R) Core(TM) i7-4770 CPU @ 
> 3.40GHz it actually works. Somewhat :) It is much faster, but the callstacks 
> don't terminate properly, and are sometimes not correctly demangled. I observe 
> the following behavior:
>
>     15.56%  ex_string_compa  libQt5Core.so.5.5.0   [.] QString::compare_helper                 
>             |          
>             |--5.84%-- 
> _ZN7QString14compare_helperEPK5QChariS2_iN2Qt15CaseSensitivityE@plt

Maybe the demangler doesn't like the @plt.


>             |          QString::compare_helper
>             |          main
>             |          |          
>             |          |--4.24%-- main
>             |          |          |          
>             |          |          |--1.60%-- main
>             |          |          |          |          
>             |          |          |          |--1.07%-- main

Yes that looks like a bug.

Adding Kan.

-Andi

>             |          |          |          |          |          
>             |          |          |          |          |--0.54%-- main
>             |          |          |          |          |          main
>             |          |          |          |          |          
>             |          |          |          |           --0.53%-- 
> QString::compare_helper
>             |          |          |          |                     main
>             |          |          |          |          
>             |          |          |           --0.53%-- 
> QString::compare_helper
>             |          |          |                     main
>             |          |          |                     main
>             |          |          |                     
> QString::compare_helper
>             |          |          |                     main
>             |          |          |                     
> QString::compare_helper
> ...
>
> The correct callgraph, as shown by --call-graph dwarf, is:
>
>     21.62%  ex_string_compa  libQt5Core.so.5.5.0   [.] QString::compare_helper                                        
>             |
>             ---QString::compare_helper
>                main
>
> Is this a known (undocumented) limitation or a bug? Is there anything I could 
> do to get this fixed?
>
> Thanks

-- 
ak@linux.intel.com -- Speaking for myself only
