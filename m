From: David Ahern <dsahern@gmail.com>
Subject: Re: Profile the waiting time for lock or lock stats for one application
Date: Sat, 01 Mar 2014 08:30:47 -0700
Message-ID: <5311FD27.7000903@gmail.com>
References: <1393351991.27573.YahooMailNeo@web124901.mail.ne1.yahoo.com> <20140228184343.GD10080@sdfg.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:45017 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830AbaCAPbx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 1 Mar 2014 10:31:53 -0500
Received: by mail-pd0-f170.google.com with SMTP id y10so1993273pdj.1
        for <linux-perf-users@vger.kernel.org>; Sat, 01 Mar 2014 07:31:53 -0800 (PST)
In-Reply-To: <20140228184343.GD10080@sdfg.com.ar>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Rodrigo Campos <rodrigo@sdfg.com.ar>, Junjie Qian <junjie.qian@yahoo.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On 2/28/14, 11:43 AM, Rodrigo Campos wrote:
> There are ways (not sure if the patch is in) to track for lock contension using
> perf, but not sure (I think not easy at least) if the lock is not contended. As,
> if using glibc, lot of locks are implemented using futex and then solved
> entirely in userspace lot of times (at least without contention).

What patch are you referring to? You can trace system calls to catch all 
contention and wakeups. You can put probes at lock entry, exit and 
unlock entry to track lock accesses by address.

I started working on this end of last year, just haven't had time to 
work on the analysis side -- statistical analysis of lock times with 
ability to see individual events. All I have right now is python script 
that pretty prints the events.

David
