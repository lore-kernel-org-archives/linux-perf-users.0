From: David Ahern <daahern@cisco.com>
Subject: Re: Profiling a program's runtime
Date: Fri, 04 Feb 2011 17:56:20 -0700
Message-ID: <4D4CA034.2010204@cisco.com>
References: <ukft18-pba.ln1@burns.bruehl.pontohonk.de> <20110204174750.GD1808@nowhere> <4D4C4105.3050002@cisco.com> <201102042051.21617.bartoschek@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080709020100010905090206"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from rtp-iport-2.cisco.com ([64.102.122.149]:16454 "EHLO
	rtp-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab1BEBFy (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 Feb 2011 20:05:54 -0500
In-Reply-To: <201102042051.21617.bartoschek@gmx.de>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Christoph Bartoschek <bartoschek@gmx.de>
Cc: linux-perf-users@vger.kernel.org

This is a multi-part message in MIME format.
--------------080709020100010905090206
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



On 02/04/11 12:51, Christoph Bartoschek wrote:
> Am Freitag 04 Februar 2011 schrieb David Ahern:
> 
>> You can determine time blocked on read (and other system calls) by
>> acquiring all context switches:
>>
>>     perf record -e cs -c 1 -a
>>
>> From there you'll want to generate a time history output. To use
>> unmodified perf code use the -D option to dump raw samples (perf report
>> -D). You can find the process of interest and the kernel timestamp
>> between schedule out events -- and the sched out event before your
>> process. Together you can piece together the time you blocked on read.
>>
>> Alternatively, there are add-on patches which dump the timehistory in a
>> pretty print format:
>>
>> http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg00049.html
>> http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg00047.html
>> http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg00048.html
>>
>>
>> That output can be manipulated much easier to determine time on the
>> processor and time between schedule-in events.
>>
>> Not the complete picture of what I think you are looking for -- but a
>> way to get the time blocked on syscall stats via perf.
> 
> Looks quite complicated to get such a profile. However I have to check it, 
> when I'm back at work.

Can be - depends on the insights you seek. It's been invaluable data for
the product I work on. Attached is a couple of snippets from a local
timehist-analysis tool (workflow is 'perf record', dump timehistory, run
timehist-analysis to time sort the samples, etc).

David


> 
> Thanks
> Christoph

--------------080709020100010905090206
Content-Type: text/plain;
 name="example-timehist-analysis"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="example-timehist-analysis"

System view of processes:

               : ------------------ | ------------------ :
               :        cpu 0       |        cpu 1       :
---------------: ------------------ | ------------------ :
Time of Day    : process[pid]   run | process[pid]   run : Stack Trace
----------------------------------------------------------------------------
10:24:17.875423: myproc3[3888]  214 |                    : schedule_timeout    
...
10:24:17.883073:                    | yz[5552]        48 : work_resched     ...
10:24:17.883084:                    | yz[5562]        11 : futex_wait       ...
10:24:17.883103:                    | yz[5552]        18 : work_resched     ...
10:24:17.883113:                    | yz[5560]         9 : futex_wait       ...
10:24:17.883151:                    | yz[5552]        38 : work_resched     ...
10:24:17.883175:                    | yz[5562]        23 : futex_wait       ...
10:24:17.883196:                    | yz[5560]        21 : futex_wait       ...
10:24:17.883211:                    | yz[5552]        14 : schedule_timeout ...
10:24:17.889569: swapper[0]   14145 |                    : cpu_idle         ...
10:24:17.889692: myproc1[3853]  123 |                    : schedule_timeout ...
10:24:17.889781: myproc2[5577]   88 |                    : schedule_timeout ...
10:24:17.889835: abc[4245]       54 |                    : schedule_timeout ...
...


In-depth view of a single process:

               :        cpu 0                 |        cpu 1                :
               : ---------------------------- | --------------------------- :
               :                 run   betwn  |                 run   betwn :
Time of Day    : process[tid]   time    time  | process[tid]   time    time :
-----------------------------------------------------------------------------------------------
...
10:24:17.890170: myproc[3888]    334    14412 |                             :  __skb_recv_datagram ...
10:24:17.898361:                              | myproc[3888]     94    8097 :  work_resched        ...
10:24:17.898806:                              | myproc[3888]     56     388 :  __skb_recv_datagram ...
10:24:17.905296: myproc[3888]    111     6379 |                             :  __skb_recv_datagram ...
10:24:17.915303: myproc[3888]    139     9868 |                             :  __skb_recv_datagram ...
10:24:17.916041: myproc[3888]     14      724 |                             :  __skb_recv_datagram ...
10:24:17.919939: myproc[3888]     16     3881 |                             :  __skb_recv_datagram ...
10:24:17.920047: myproc[3888]     15       93 |                             :  __skb_recv_datagram ...
...


run time is how long the thread ran once scheduled
betwn time is how long the thread went between schedulings


Stack depths snipped to one-level for this example (with schedule_timeout excluded); perf captures the complete stack and you can drop symbols to bring clarity to where a process blocks, for how long, etc.

--------------080709020100010905090206--
