Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2B8C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Sep 2021 02:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25CC260F51
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Sep 2021 02:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbhINCDj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Sep 2021 22:03:39 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:45460 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235913AbhINCD2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Sep 2021 22:03:28 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0UoJjVVb_1631584927;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0UoJjVVb_1631584927)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Sep 2021 10:02:08 +0800
Subject: Re: [RFC PATCH] perf: fix panic by mark recursion inside
 perf_log_throttle
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <netdev@vger.kernel.org>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>
References: <ff979a43-045a-dc56-64d1-2c31dd4db381@linux.alibaba.com>
 <20210910153839.GH4323@worktop.programming.kicks-ass.net>
 <f38987a5-dc36-a20d-8c5e-81e8ead5b4dc@linux.alibaba.com>
 <YT8m2B6D2yWc5Umq@hirez.programming.kicks-ass.net>
 <YT8ptOoN0age04PQ@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <6aefb972-3691-2b66-a189-97815df10a12@linux.alibaba.com>
Date:   Tue, 14 Sep 2021 10:02:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YT8ptOoN0age04PQ@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 2021/9/13 下午6:36, Peter Zijlstra wrote:
> On Mon, Sep 13, 2021 at 12:24:24PM +0200, Peter Zijlstra wrote:
> 
> FWIW:
> 
>> I'm confused tho; where does the #DF come from? Because taking a #PF
>> from NMI should be perfectly fine.
>>
>> AFAICT that callchain is something like:
>>
>> 	NMI
>> 	  perf_event_nmi_handler()
>> 	    (part of the chain is missing here)
>> 	      perf_log_throttle()
>> 	        perf_output_begin() /* events/ring_buffer.c */
>> 		  rcu_read_lock()
>> 		    rcu_lock_acquire()
>> 		      lock_acquire()
>> 		        trace_lock_acquire() --> perf_trace_foo
> 
> This function also calls perf_trace_buf_alloc(), and will have
> incremented the recursion count, such that:
> 
>>
>> 			  ...
>> 			    perf_callchain()
>> 			      perf_callchain_user()
>> 			        #PF (fully expected during a userspace callchain)
>> 				  (some stuff, until the first __fentry)
>> 				    perf_trace_function_call
>> 				      perf_trace_buf_alloc()
>> 				        perf_swevent_get_recursion_context()
>> 					  *BOOM*
> 
> this one, if it wouldn't mysteriously explode, would find recursion and
> terminate, except that seems to be going side-ways.

Yes, it supposed to avoid recursion in the same context, but it never got
chance to do that, the function and struct should all be fine, any idea
in such situation what can trigger this kind of double fault?

Regards,
Michael Wang

> 
>> Now, supposedly we then take another #PF from get_recursion_context() or
>> something, but that doesn't make sense. That should just work...
>>
>> Can you figure out what's going wrong there? going with the RIP, this
>> almost looks like 'swhash->recursion' goes splat, but again that makes
>> no sense, that's a per-cpu variable.
>>
>>
