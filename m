From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/3] perf events: add timehist option to record and
 report
Date: Fri, 18 Feb 2011 19:39:59 +0100
Message-ID: <1298054399.5226.779.camel@laptop>
References: <1298008433-22911-1-git-send-email-daahern@cisco.com>
	 <1298008433-22911-4-git-send-email-daahern@cisco.com>
	 <20110218070657.GA11404@elte.hu> <4D5E8204.2090501@cisco.com>
	 <20110218175926.GA3445@nowhere>  <4D5EB564.6030504@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:55194 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272Ab1BRSip (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 18 Feb 2011 13:38:45 -0500
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=dyad.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
	id 1PqVE4-0005s3-4s
	for linux-perf-users@vger.kernel.org; Fri, 18 Feb 2011 18:38:44 +0000
In-Reply-To: <4D5EB564.6030504@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>, Arnaldo Carvalho de Melo <acme@redhat.com>

On Fri, 2011-02-18 at 11:07 -0700, David Ahern wrote:
> We want not only context-switch events, but the stack trace at the
> switch. 

Both ftrace and perf can do that:

 perf record -ge sched:sched_switch -c 1

or

echo 1 > /debug/tracing/options/stacktrace

> That data along with the gettimeofday timestamp has allowed us to
> resolve performance issues such as a system call taking longer than
> expected during a specific sequence of events or a process getting
> preempted and not scheduled for N seconds. etc., etc.

Non of that seems to require GTOD stamps.
