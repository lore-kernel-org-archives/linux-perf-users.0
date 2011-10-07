From: Arun Sharma <asharma@fb.com>
Subject: Re: Profiling sleep times?
Date: Fri, 7 Oct 2011 10:58:42 -0700
Message-ID: <4E8F3DD2.9000807@fb.com>
References: <4E8A0F53.7020408@fb.com> <1317673027.20367.41.camel@twins>   <4E8A2EC5.1030901@fb.com> <1317717291.25926.13.camel@twins>  <4E8E2417.2000903@fb.com> <1317951036.9813.12.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47667 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751859Ab1JGSTF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 7 Oct 2011 14:19:05 -0400
In-Reply-To: <1317951036.9813.12.camel@twins>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, Stephane Eranian <eranian@google.com>, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Vagin <avagin@gmail.com>

On 10/6/11 6:30 PM, Peter Zijlstra wrote:

>
> But the idea of the __perf_count() thing:
> [..]
> 	TP_perf_assign(
> 		__perf_count(delay);
> 	),
>
> 	TP_printk("comm=%s pid=%d delay=%Lu [ns]",
> 			__entry->comm, __entry->pid,
> 			(unsigned long long)__entry->delay)
> );
>
>
> is that the counter is incremented with the delay, so the event should
> get weighted right.
>
> So having to get the delay out of the raw tracepoint data shouldn't be
> needed.

How does this work for dynamic tracepoints? Or tracepoints with multiple 
dimensions where the user might want to query each dimension separately?

Andrew: what do you think about generalizing my patch to accept a 
command line option(s) to specify which fields to use for the purpose of 
computing the histogram?

For static tracepoints, TP_perf_assign() could act as a hint on which 
field to default to.

  -Arun
