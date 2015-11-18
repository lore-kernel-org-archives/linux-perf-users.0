From: David Ahern <dsahern@gmail.com>
Subject: Re: RFE: More inclusive pid filtering of sched:sched_switch
 tracepoint events
Date: Wed, 18 Nov 2015 12:08:41 -0700
Message-ID: <564CCCB9.9020203@gmail.com>
References: <564CCAF9.3070805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:35669 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755611AbbKRTIn (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 18 Nov 2015 14:08:43 -0500
Received: by ioc74 with SMTP id 74so64102278ioc.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2015 11:08:42 -0800 (PST)
In-Reply-To: <564CCAF9.3070805@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>

On 11/18/15 12:01 PM, William Cohen wrote:
> Hi,
>
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
>                du 20960 [007] 339893.429394: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
>                du 20960 [007] 339893.429411: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
>                du 20960 [007] 339893.429544: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
>                du 20960 [007] 339893.429556: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
>                du 20960 [007] 339893.429561: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
>                du 20960 [007] 339893.429567: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
>                du 20960 [007] 339893.430150: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
>
> Would it be possible to make perf's process filtering more inclusive so
> that output also includes sched:sched_switch tracepoints for pid that
> are also being scheduled onto the processor?  The alternative of
> recording all sched:sched_switch events system-wide and filtering out
> all the unwanted pid's is undesirable.

Known pain point. I thought Adrian had new sched tracepoints added to 
handle it, but I lost track of whether it was accepted.
