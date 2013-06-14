From: Cody P Schafer <devel-lists@codyps.com>
Subject: Re: BUG: perf kvm top --callgraph not showing callgraph
Date: Fri, 14 Jun 2013 16:11:56 -0700
Message-ID: <CAPoQQ-1sjf6Wj4sU7--X4DpCEeMhbgbap_OfDmD0rCXWT1XyvA@mail.gmail.com>
References: <CAPoQQ-2Xqms+FL=sfGKftgyMJsRKbS4+Fh8dV6Th-XjoqCBRjw@mail.gmail.com>
	<51BA6D96.5050004@gmail.com>
	<CAPoQQ-3Jq2tu1ccsmcL14H=+QF1B+k5cb-SOqihwvZbWcA960A@mail.gmail.com>
	<51BB92B9.6080706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:43462 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab3FNXL5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 14 Jun 2013 19:11:57 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so1266545obb.36
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Jun 2013 16:11:57 -0700 (PDT)
In-Reply-To: <51BB92B9.6080706@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Fri, Jun 14, 2013 at 3:01 PM, David Ahern <dsahern@gmail.com> wrote:
> On 6/14/13 3:53 PM, Cody P Schafer wrote:
>>
>> On Thu, Jun 13, 2013 at 6:10 PM, David Ahern <dsahern@gmail.com> wrote:
>>>
>>> On 6/13/13 7:04 PM, Cody P Schafer wrote:
>>>>
>>>> Hi all, I'm trying to use perf kvm to profile linux early boot.
>>>>
>>>> However, perf kvm top always appears to behave as though it's in
>>>> non-callgraph mode.
>>>
>>> During event collection perf kernel side does not walk the guest
>>> callchain.
>>> I believe it only collects IP.
>>>
>>
>> Some further investigation shows that the user unwind code could be
>> used, but [the following] is always false.
>>      if (!((evsel->attr.sample_type & PERF_SAMPLE_REGS_USER) &&
>>           (evsel->attr.sample_type & PERF_SAMPLE_STACK_USER)))
>>                return 0;
>>
>> There don't appear to be any users which _set_ PERF_SAMPLE_REGS_USER
>> or PERF_SAMPLE_STACK_USER, only ones that check it. Can we just use
>> __perf_evsel__set_sample_bit() twice and have this magically work?
>>
>> So, a few questions:
>>   - can we get perf to dump the user regs & stack for kvm guest kernels?
>>   - does the in kernel stack unwinding _only_ trigger for host (ie:
>> real) kernel mode samples? If so, does this restriction always make
>> sense?
>>   - How did all this user unwind code get triggered if no one is
>> setting PERF_SAMPLE_REGS_USER and PERF_SAMPLE_STACK_USER? Was it ever
>> triggered?
>>
>
> I am under the impression the limitations are these 2 snippets in
> arch/x86/kernel/cpu/perf_event.c:

Yep, that's disabling the in-kernel callchain generation (the in-perf
callchain code should still be an option without this). I wonder if
one could use perf_callchain_user() to find the callchain of the guest
kernel.

Does anyone know the particular changes that need to be done to
support kvm backtraces/the reasons it is specifically disabled?
