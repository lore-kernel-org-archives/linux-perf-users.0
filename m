From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: RFE: More inclusive pid filtering of sched:sched_switch
 tracepoint events
Date: Wed, 18 Nov 2015 17:18:16 -0300
Message-ID: <20151118201816.GW22729@kernel.org>
References: <564CCAF9.3070805@redhat.com>
 <564CCCB9.9020203@gmail.com>
 <564CCE9F.4050501@redhat.com>
 <564CCEFC.9030808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55961 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754683AbbKRUSV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 18 Nov 2015 15:18:21 -0500
Content-Disposition: inline
In-Reply-To: <564CCEFC.9030808@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: William Cohen <wcohen@redhat.com>, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Em Wed, Nov 18, 2015 at 12:18:20PM -0700, David Ahern escreveu:
> On 11/18/15 12:16 PM, William Cohen wrote:
> >As a workaround can use the filtering to cut down some of data being recorded with:

> >export PID=<process_of_interest>
> >sudo perf record -a -e sched:sched_switch --filter "next_pid == $PID || prev_pid == $PID" --

> >Is the following the correct thread discussing those new sched tracepoints?

> >https://lkml.org/lkml/2015/6/9/513

> I believe so

Right, take a look at:

commit ae938802443732e77d01f8d5b52b900b9327ff30
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Tue Oct 6 17:46:46 2015 -0300

    perf python: Support the PERF_RECORD_SWITCH event
    
    To test it check tools/perf/python/twatch.py, after following the
    instructions there to enable context_switch, output looks like:
    
      [root@zoo linux]# tools/perf/python/twatch.py
      cpu: 1, pid: 31463, tid: 31463 { type: context_switch, next_prev_pid: 31463, next_prev_tid: 31463, switch_out: 0 }
      cpu: 2, pid: 31463, tid: 31496 { type: context_switch, next_prev_pid: 31463, next_prev_tid: 31496, switch_out: 0 

- Arnaldo
