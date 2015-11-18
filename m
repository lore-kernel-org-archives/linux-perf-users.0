From: David Ahern <dsahern@gmail.com>
Subject: Re: RFE: More inclusive pid filtering of sched:sched_switch
 tracepoint events
Date: Wed, 18 Nov 2015 12:18:20 -0700
Message-ID: <564CCEFC.9030808@gmail.com>
References: <564CCAF9.3070805@redhat.com> <564CCCB9.9020203@gmail.com>
 <564CCE9F.4050501@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35720 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016AbbKRTSW (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 18 Nov 2015 14:18:22 -0500
Received: by igl9 with SMTP id 9so108997091igl.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2015 11:18:21 -0800 (PST)
In-Reply-To: <564CCE9F.4050501@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>

On 11/18/15 12:16 PM, William Cohen wrote:
> Okay,
>
> As a workaround can use the filtering to cut down some of data being recorded with:
>
> export PID=<process_of_interest>
> sudo perf record -a -e sched:sched_switch --filter "next_pid == $PID || prev_pid == $PID" --
>
> Is the following the correct thread discussing those new sched tracepoints?
>
> https://lkml.org/lkml/2015/6/9/513
>
> -Will

I believe so
