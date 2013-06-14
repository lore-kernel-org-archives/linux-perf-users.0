From: David Ahern <dsahern@gmail.com>
Subject: Re: BUG: perf kvm top --callgraph not showing callgraph
Date: Fri, 14 Jun 2013 17:23:20 -0600
Message-ID: <51BBA5E8.5070204@gmail.com>
References: <CAPoQQ-2Xqms+FL=sfGKftgyMJsRKbS4+Fh8dV6Th-XjoqCBRjw@mail.gmail.com> <51BA6D96.5050004@gmail.com> <CAPoQQ-3Jq2tu1ccsmcL14H=+QF1B+k5cb-SOqihwvZbWcA960A@mail.gmail.com> <51BB92B9.6080706@gmail.com> <CAPoQQ-1sjf6Wj4sU7--X4DpCEeMhbgbap_OfDmD0rCXWT1XyvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:56398 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063Ab3FNXXY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 14 Jun 2013 19:23:24 -0400
In-Reply-To: <CAPoQQ-1sjf6Wj4sU7--X4DpCEeMhbgbap_OfDmD0rCXWT1XyvA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Cody P Schafer <devel-lists@codyps.com>
Cc: linux-perf-users@vger.kernel.org, KVM <kvm@vger.kernel.org>, Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>

[added kvm devel list and Xiao who implemented the original perf-kvm as 
I recall]

On 6/14/13 5:11 PM, Cody P Schafer wrote:
>> I am under the impression the limitations are these 2 snippets in
>> >arch/x86/kernel/cpu/perf_event.c:
> Yep, that's disabling the in-kernel callchain generation (the in-perf
> callchain code should still be an option without this). I wonder if
> one could use perf_callchain_user() to find the callchain of the guest
> kernel.
>
> Does anyone know the particular changes that need to be done to
> support kvm backtraces/the reasons it is specifically disabled?

It's going to require some KVM changes I would think. e.g., for the IP:

unsigned long perf_instruction_pointer(struct pt_regs *regs)
{
     if (perf_guest_cbs && perf_guest_cbs->is_in_guest())
         return perf_guest_cbs->get_guest_ip();

     return regs->ip + code_segment_base(regs);
}

get_guest_ip comes from arch/x86/kvm/x86.c.

callchain walking starts in perf_callchain, kernel/events/callchain.c

For more context:
perf_prepare_sample()
   data->callchain = perf_callchain(event, regs);

For guests you'll want regs from the guest which will need to be 
supplied by kvm.

David
