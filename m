From: M Kelly <mark.kelly@lexisnexis.com>
Subject: Re: =?utf-8?b?c3Bpbl9sb2Nr?= cause ?
Date: Wed, 1 Jun 2016 17:43:12 +0000 (UTC)
Message-ID: <loom.20160601T194103-83@post.gmane.org>
References: <574F15E4.5070008@lexisnexis.com> <4716588.WReR5L1Wkn@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43526 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932138AbcFARng (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 1 Jun 2016 13:43:36 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1b8AAy-000316-E9
	for linux-perf-users@vger.kernel.org; Wed, 01 Jun 2016 19:43:28 +0200
Received: from 209.243.55.99 ([209.243.55.99])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Jun 2016 19:43:28 +0200
Received: from mark.kelly by 209.243.55.99 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Jun 2016 19:43:28 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Milian Wolff <milian.wolff <at> kdab.com> writes:

> 
> On Wednesday, June 1, 2016 1:05:40 PM CEST Kelly, Mark (RIS-BCT) wrote:
> > Hi,
> > 
> > Perf report for our application shows:
> > 
> >   34.27%  [kernel]                    [k] _spin_lock
> >    8.19%  libjlib.so                  [.] CLZWExpander::expand(void*)
> >    4.62%  libjhtree.so                [.] CMRUCacheOf<CKeyIdAndPos,
> > CJHTreeNode> 1.97%  [kernel]                    [k] futex_wait_setup
> >    1.51%  [kernel]                    [k] native_write_msr_safe
> >    1.34%  [kernel]                    [k] futex_wake
> > 
> > Any suggestion for how to trace where/who is responsible for the 
spin_lock ?
> 
> For both cases, you should collect backtraces which should allow you to 
find 
> culprits. Have you tried:
> 
> perf record --call-graph dwarf
> 
> or similar?
> 
> Cheers
> 

ok, I will try it, thank you.  I will have to upgrade perf or move to a 
newer kernel ? because dwarf does not seem to be supported on my current 
system.  I will report back what it shows once I get it working.

thanks,
mark
