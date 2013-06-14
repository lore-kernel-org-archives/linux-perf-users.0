From: David Ahern <dsahern@gmail.com>
Subject: Re: BUG: perf kvm top --callgraph not showing callgraph
Date: Fri, 14 Jun 2013 16:01:29 -0600
Message-ID: <51BB92B9.6080706@gmail.com>
References: <CAPoQQ-2Xqms+FL=sfGKftgyMJsRKbS4+Fh8dV6Th-XjoqCBRjw@mail.gmail.com> <51BA6D96.5050004@gmail.com> <CAPoQQ-3Jq2tu1ccsmcL14H=+QF1B+k5cb-SOqihwvZbWcA960A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:36189 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547Ab3FNWBe (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 14 Jun 2013 18:01:34 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so961166pbc.35
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Jun 2013 15:01:33 -0700 (PDT)
In-Reply-To: <CAPoQQ-3Jq2tu1ccsmcL14H=+QF1B+k5cb-SOqihwvZbWcA960A@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Cody P Schafer <devel-lists@codyps.com>
Cc: linux-perf-users@vger.kernel.org

On 6/14/13 3:53 PM, Cody P Schafer wrote:
> On Thu, Jun 13, 2013 at 6:10 PM, David Ahern <dsahern@gmail.com> wrote:
>> On 6/13/13 7:04 PM, Cody P Schafer wrote:
>>>
>>> Hi all, I'm trying to use perf kvm to profile linux early boot.
>>>
>>> However, perf kvm top always appears to behave as though it's in
>>> non-callgraph mode.
>>
>>
>> During event collection perf kernel side does not walk the guest callchain.
>> I believe it only collects IP.
>>
>
> Some further investigation shows that the user unwind code could be
> used, but [the following] is always false.
>      if (!((evsel->attr.sample_type & PERF_SAMPLE_REGS_USER) &&
>           (evsel->attr.sample_type & PERF_SAMPLE_STACK_USER)))
>                return 0;
>
> There don't appear to be any users which _set_ PERF_SAMPLE_REGS_USER
> or PERF_SAMPLE_STACK_USER, only ones that check it. Can we just use
> __perf_evsel__set_sample_bit() twice and have this magically work?
>
> So, a few questions:
>   - can we get perf to dump the user regs & stack for kvm guest kernels?
>   - does the in kernel stack unwinding _only_ trigger for host (ie:
> real) kernel mode samples? If so, does this restriction always make
> sense?
>   - How did all this user unwind code get triggered if no one is
> setting PERF_SAMPLE_REGS_USER and PERF_SAMPLE_STACK_USER? Was it ever
> triggered?
>


I am under the impression the limitations are these 2 snippets in 
arch/x86/kernel/cpu/perf_event.c:

oid
perf_callchain_kernel(struct perf_callchain_entry *entry, struct pt_regs 
*regs)
{
     if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
         /* TODO: We don't support guest os callchain now */
         return;
     }

...

void
perf_callchain_user(struct perf_callchain_entry *entry, struct pt_regs 
*regs)
{
     struct stack_frame frame;
     const void __user *fp;

     if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
         /* TODO: We don't support guest os callchain now */
         return;
     }
