From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: RFE: More inclusive pid filtering of sched:sched_switch
 tracepoint events
Date: Thu, 19 Nov 2015 12:52:55 -0300
Message-ID: <20151119155255.GE29361@kernel.org>
References: <564CCAF9.3070805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34054 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934179AbbKSPxA (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 19 Nov 2015 10:53:00 -0500
Content-Disposition: inline
In-Reply-To: <564CCAF9.3070805@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: linux-perf-users@vger.kernel.org

Em Wed, Nov 18, 2015 at 02:01:13PM -0500, William Cohen escreveu:
> I was experimenting with the sched:sched_switch tracepoint to look at
> the time that a process spend off the processor.  As a really simple
> experiment record data with:
> 
> $ sudo perf record -e sched:sched_switch -- du
> 
> Then examine the data with:
> 
> $ sudo perf script
> 
> The output only shows the sched:sched_switch when the process is moved
> off the processor.  However, there is no data showing when the process is
> scheduled back onto the processor:
> 
>               du 20960 [007] 339893.429394: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
>               du 20960 [007] 339893.429411: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
>               du 20960 [007] 339893.429544: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
>               du 20960 [007] 339893.429556: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
>               du 20960 [007] 339893.429561: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
>               du 20960 [007] 339893.429567: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
>               du 20960 [007] 339893.430150: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
> 
> Would it be possible to make perf's process filtering more inclusive so
> that output also includes sched:sched_switch tracepoints for pid that
> are also being scheduled onto the processor?  The alternative of
> recording all sched:sched_switch events system-wide and filtering out
> all the unwanted pid's is undesirable.

So, on a recent kernel, no need to run with sudo:

[acme@zoo linux]$ perf record --switch-events -e dummy -- du > /dev/null
^[[A[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.016 MB perf.data ]
[acme@zoo linux]$ perf script --show-switch-events
              du  4026 103867.891889: PERF_RECORD_SWITCH OUT
              du  4026 103867.891980: PERF_RECORD_SWITCH IN 
              du  4026 103867.984411: PERF_RECORD_SWITCH OUT
              du  4026 103867.984424: PERF_RECORD_SWITCH IN 
[acme@zoo linux]$

[acme@zoo linux]$ perf report -D | grep PERF_RECORD_SWITCH
103867891889845 0x4260 [0x18]: PERF_RECORD_SWITCH OUT
103867891980760 0x4278 [0x18]: PERF_RECORD_SWITCH IN 
103867984411995 0x4290 [0x18]: PERF_RECORD_SWITCH OUT
103867984424725 0x42a8 [0x18]: PERF_RECORD_SWITCH IN 
[acme@zoo linux]$ 

- Arnaldo
