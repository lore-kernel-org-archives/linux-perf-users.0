From: M Kelly <mark.kelly@lexisnexis.com>
Subject: Re: =?utf-8?b?c3Bpbl9sb2Nr?= cause ?
Date: Wed, 1 Jun 2016 19:25:20 +0000 (UTC)
Message-ID: <loom.20160601T211807-101@post.gmane.org>
References: <574F15E4.5070008@lexisnexis.com> <4716588.WReR5L1Wkn@milian-kdab2> <loom.20160601T194103-83@post.gmane.org> <20160601181153.GU2563@kernel.org> <loom.20160601T204307-459@post.gmane.org> <574F2F20.2090007@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49739 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744AbcFATZc (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 1 Jun 2016 15:25:32 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1b8Blh-0003iG-JM
	for linux-perf-users@vger.kernel.org; Wed, 01 Jun 2016 21:25:30 +0200
Received: from 209.243.55.99 ([209.243.55.99])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Jun 2016 21:25:29 +0200
Received: from mark.kelly by 209.243.55.99 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Jun 2016 21:25:29 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Rick Jones <rick.jones2 <at> hpe.com> writes:

> 
> On 06/01/2016 11:49 AM, M Kelly wrote:
> > So that is helpful.
> > I do not understand the system_call_fastpath->futex->_spin_lock part
> > yet,
> > but that is a separate issue!
> 
> Just a guess, but if your application is using threads, contention on 
> the synchonrization primitives you use to keep things straight can 
> end-up punting to the kernel.
> 
> rick jones
> 

Hi,

I think I recall you from hp, years ago when I was there :-)
Thanks for the info.  I suspect we are too heavy on 
pthread_mutex_lock()/unlock() 
which could probably produce these call graphs:

            --- _spin_lock
               |          
               |--49.11%-- futex_wake
               |          do_futex
               |          sys_futex
               |          system_call_fastpath
               |          __lll_unlock_wake
               |          
               |--44.31%-- futex_wait_setup
               |          futex_wait
               |          do_futex
               |          sys_futex
               |          system_call_fastpath
               |          __lll_lock_wait

thanks again,
mark
