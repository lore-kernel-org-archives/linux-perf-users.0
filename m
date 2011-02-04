From: Christoph Bartoschek <bartoschek@gmx.de>
Subject: Re: Profiling a program's runtime
Date: Fri, 4 Feb 2011 20:51:21 +0100
Message-ID: <201102042051.21617.bartoschek@gmx.de>
References: <ukft18-pba.ln1@burns.bruehl.pontohonk.de> <20110204174750.GD1808@nowhere> <4D4C4105.3050002@cisco.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:43937 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752329Ab1BDTuX (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 Feb 2011 14:50:23 -0500
In-Reply-To: <4D4C4105.3050002@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org

Am Freitag 04 Februar 2011 schrieb David Ahern:

> You can determine time blocked on read (and other system calls) by
> acquiring all context switches:
> 
>     perf record -e cs -c 1 -a
> 
> From there you'll want to generate a time history output. To use
> unmodified perf code use the -D option to dump raw samples (perf report
> -D). You can find the process of interest and the kernel timestamp
> between schedule out events -- and the sched out event before your
> process. Together you can piece together the time you blocked on read.
> 
> Alternatively, there are add-on patches which dump the timehistory in a
> pretty print format:
> 
> http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg00049.html
> http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg00047.html
> http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg00048.html
> 
> 
> That output can be manipulated much easier to determine time on the
> processor and time between schedule-in events.
> 
> Not the complete picture of what I think you are looking for -- but a
> way to get the time blocked on syscall stats via perf.

Looks quite complicated to get such a profile. However I have to check it, 
when I'm back at work.

Thanks
Christoph
