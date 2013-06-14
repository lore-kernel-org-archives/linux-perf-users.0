From: Cody P Schafer <devel-lists@codyps.com>
Subject: Re: BUG: perf kvm top --callgraph not showing callgraph
Date: Fri, 14 Jun 2013 14:53:04 -0700
Message-ID: <CAPoQQ-3Jq2tu1ccsmcL14H=+QF1B+k5cb-SOqihwvZbWcA960A@mail.gmail.com>
References: <CAPoQQ-2Xqms+FL=sfGKftgyMJsRKbS4+Fh8dV6Th-XjoqCBRjw@mail.gmail.com>
	<51BA6D96.5050004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ob0-f193.google.com ([209.85.214.193]:40711 "EHLO
	mail-ob0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab3FNVxG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 14 Jun 2013 17:53:06 -0400
Received: by mail-ob0-f193.google.com with SMTP id xk17so390277obc.8
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Jun 2013 14:53:05 -0700 (PDT)
In-Reply-To: <51BA6D96.5050004@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Thu, Jun 13, 2013 at 6:10 PM, David Ahern <dsahern@gmail.com> wrote:
> On 6/13/13 7:04 PM, Cody P Schafer wrote:
>>
>> Hi all, I'm trying to use perf kvm to profile linux early boot.
>>
>> However, perf kvm top always appears to behave as though it's in
>> non-callgraph mode.
>
>
> During event collection perf kernel side does not walk the guest callchain.
> I believe it only collects IP.
>

Some further investigation shows that the user unwind code could be
used, but [the following] is always false.
    if (!((evsel->attr.sample_type & PERF_SAMPLE_REGS_USER) &&
         (evsel->attr.sample_type & PERF_SAMPLE_STACK_USER)))
              return 0;

There don't appear to be any users which _set_ PERF_SAMPLE_REGS_USER
or PERF_SAMPLE_STACK_USER, only ones that check it. Can we just use
__perf_evsel__set_sample_bit() twice and have this magically work?

So, a few questions:
 - can we get perf to dump the user regs & stack for kvm guest kernels?
 - does the in kernel stack unwinding _only_ trigger for host (ie:
real) kernel mode samples? If so, does this restriction always make
sense?
 - How did all this user unwind code get triggered if no one is
setting PERF_SAMPLE_REGS_USER and PERF_SAMPLE_STACK_USER? Was it ever
triggered?
