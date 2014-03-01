From: Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: Re: Profile the waiting time for lock or lock stats for one
 application
Date: Sat, 1 Mar 2014 16:03:39 +0000
Message-ID: <20140301160338.GE10080@sdfg.com.ar>
References: <1393351991.27573.YahooMailNeo@web124901.mail.ne1.yahoo.com>
 <20140228184343.GD10080@sdfg.com.ar>
 <5311FD27.7000903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from alerce.vps.bitfolk.com ([85.119.82.134]:49879 "EHLO
	alerce.vps.bitfolk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963AbaCAQEn (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 1 Mar 2014 11:04:43 -0500
Content-Disposition: inline
In-Reply-To: <5311FD27.7000903@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Junjie Qian <junjie.qian@yahoo.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Sat, Mar 01, 2014 at 08:30:47AM -0700, David Ahern wrote:
> On 2/28/14, 11:43 AM, Rodrigo Campos wrote:
> >There are ways (not sure if the patch is in) to track for lock contension using
> >perf, but not sure (I think not easy at least) if the lock is not contended. As,
> >if using glibc, lot of locks are implemented using futex and then solved
> >entirely in userspace lot of times (at least without contention).
> 
> What patch are you referring to? You can trace system calls to catch

I think one from you, from late last year. I'm not sure and I'm not on my
notebook right now. Something to trace the futex syscall or something like that
? That can help to understand lock contention on userspace





Thanks,
Rodrigo
