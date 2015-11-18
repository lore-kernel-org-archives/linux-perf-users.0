From: William Cohen <wcohen@redhat.com>
Subject: Re: RFE: More inclusive pid filtering of sched:sched_switch
 tracepoint events
Date: Wed, 18 Nov 2015 14:16:47 -0500
Message-ID: <564CCE9F.4050501@redhat.com>
References: <564CCAF9.3070805@redhat.com> <564CCCB9.9020203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55231 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754016AbbKRTQt (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 18 Nov 2015 14:16:49 -0500
In-Reply-To: <564CCCB9.9020203@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>

On 11/18/2015 02:08 PM, David Ahern wrote:
> On 11/18/15 12:01 PM, William Cohen wrote:
>> Hi,
>>
>> I was experimenting with the sched:sched_switch tracepoint to look at
>> the time that a process spend off the processor.  As a really simple
>> experiment record data with:
>>
>> $ sudo perf record -e sched:sched_switch -- du
>>
>> Then examine the data with:
>>
>> $ sudo perf script
>>
>> The output only shows the sched:sched_switch when the process is moved
>> off the processor.  However, there is no data showing when the process is
>> scheduled back onto the processor:
>>
>>                du 20960 [007] 339893.429394: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
>>                du 20960 [007] 339893.429411: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
>>                du 20960 [007] 339893.429544: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
>>                du 20960 [007] 339893.429556: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
>>                du 20960 [007] 339893.429561: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
>>                du 20960 [007] 339893.429567: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
>>                du 20960 [007] 339893.430150: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
>>
>> Would it be possible to make perf's process filtering more inclusive so
>> that output also includes sched:sched_switch tracepoints for pid that
>> are also being scheduled onto the processor?  The alternative of
>> recording all sched:sched_switch events system-wide and filtering out
>> all the unwanted pid's is undesirable.
> 
> Known pain point. I thought Adrian had new sched tracepoints added to handle it, but I lost track of whether it was accepted.
> 

Okay,

As a workaround can use the filtering to cut down some of data being recorded with:

export PID=<process_of_interest>
sudo perf record -a -e sched:sched_switch --filter "next_pid == $PID || prev_pid == $PID" --

Is the following the correct thread discussing those new sched tracepoints?

https://lkml.org/lkml/2015/6/9/513

-Will
