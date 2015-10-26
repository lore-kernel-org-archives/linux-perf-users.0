From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Issue perf attaching to processes creating many short-live
 threads
Date: Mon, 26 Oct 2015 16:49:33 -0300
Message-ID: <20151026194933.GS27006@kernel.org>
References: <562A81ED.70900@redhat.com>
 <562A82F5.8090306@gmail.com>
 <562A8A08.9010101@redhat.com>
 <562A8C0F.4090607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43553 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413AbbJZTtm (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 26 Oct 2015 15:49:42 -0400
Content-Disposition: inline
In-Reply-To: <562A8C0F.4090607@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: William Cohen <wcohen@redhat.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>, =?utf-8?B?5aSn5bmz5oCc?= <rei.odaira@gmail.com>, oprofile-list <oprofile-list@lists.sourceforge.net>

Em Fri, Oct 23, 2015 at 01:35:43PM -0600, David Ahern escreveu:
> I was referring to something like 'make -j 1024' on a large system (e.g.,
> 512 or 1024 cpus) and then starting perf. This is the same problem you are
> describing -- lot of short lived processes. I am fairly certain I described
> the problem on lkml or perf mailing list. Not even the task_diag proposal
> (task_diag uses netlink to push task data to perf versus walking /proc) has
> a chance to keep up.

Yeah, to get info about existing threads (its maps, comm, etc) you would
pretty much have to stop the world, collect the info, then let
everything go back running because then new threads would insert the
PERF_RECORD_{FORK,COMM,MMAP,etc} records in the ring buffer.

I think we need an option to say: don't try to find info about existing
threads, i.e. don't look at /proc at all, we would end up with samples
being attributed to a pid/tid and that would be it, should be useful for
some use cases, no?

- Arnaldo
