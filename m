From: Vince Weaver <vince@deater.net>
Subject: Re: measuring offcore events on snb
Date: Sat, 15 Sep 2012 21:06:28 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1209152103400.576@pianoman.cluster.toy>
References: <loom.20120915T194641-95@post.gmane.org> <m2txuyyk50.fsf@firstfloor.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from fbr04.mfg.siteprotect.com ([64.26.60.139]:44049 "EHLO
	fbr04.mfg.siteprotect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894Ab2IPBPf (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 15 Sep 2012 21:15:35 -0400
Received: from smtpauth02.mfg.siteprotect.com (smtpauth02-mf.mfg.chicago.hostway [192.168.33.72])
	by fbr04.mfg.siteprotect.com (Postfix) with ESMTP id CBD099C6E5
	for <linux-perf-users@vger.kernel.org>; Sat, 15 Sep 2012 20:06:07 -0500 (CDT)
In-Reply-To: <m2txuyyk50.fsf@firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Yuanfang Chen <tabloid.adroit@gmail.com>, linux-perf-users@vger.kernel.org

On Sat, 15 Sep 2012, Andi Kleen wrote:

> OFFCORE requires setting an external MSR. perf currently supports this
> for its integrated events, as the support for setting the MSR directly
> was not accepted. It works though to write the MSR manually through
> /dev/cpu/*/msr, as long as you exclude conflicts manually. 
> For details see the Intel SDM.

no, the kernel has had raw offcore response support since 3.3.  It works
fine.  It's just not easy to get if you use the "perf" tool.  (PAPI and 
libpfm4 support it fine).

as far as I know the only way to do it is to use the rediculous
   -e cpu/cmask=1,event=2,umask=3,config1=3f80408fff
format.

Vince
