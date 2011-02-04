From: David Ahern <daahern@cisco.com>
Subject: Re: Profiling a program's runtime
Date: Fri, 04 Feb 2011 11:10:13 -0700
Message-ID: <4D4C4105.3050002@cisco.com>
References: <ukft18-pba.ln1@burns.bruehl.pontohonk.de> <20110204171604.GB1808@nowhere> <6cqt18-1lh.ln1@burns.bruehl.pontohonk.de> <20110204174750.GD1808@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-6.cisco.com ([171.71.176.117]:28152 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839Ab1BDSKX (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 Feb 2011 13:10:23 -0500
In-Reply-To: <20110204174750.GD1808@nowhere>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>, Christoph Bartoschek <bartoschek@gmx.de>
Cc: linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>



On 02/04/11 10:47, Frederic Weisbecker wrote:

>> I want that not only the CPU time is counted that my task uses, but also the 
>> time my task waits.
> 
> The time your task waits, other tasks executes :-/  (including idle in the scheme)
>  
>> For example, if my task waits for network packets in a read() then the time  
>> should be added to the read() function. Other profilers I know would not 
>> count the time when the process is blocked.

You can determine time blocked on read (and other system calls) by
acquiring all context switches:

    perf record -e cs -c 1 -a

From there you'll want to generate a time history output. To use
unmodified perf code use the -D option to dump raw samples (perf report
-D). You can find the process of interest and the kernel timestamp
between schedule out events -- and the sched out event before your
process. Together you can piece together the time you blocked on read.

Alternatively, there are add-on patches which dump the timehistory in a
pretty print format:

http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg00049.html
http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg00047.html
http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg00048.html


That output can be manipulated much easier to determine time on the
processor and time between schedule-in events.

Not the complete picture of what I think you are looking for -- but a
way to get the time blocked on syscall stats via perf.

David
