From: Jun Wang <junwang123@gmail.com>
Subject: Re: access function parameters with DWARF-less perf probing
Date: Wed, 30 Apr 2014 11:47:21 -0700
Message-ID: <CANHDG4bACrpQXDG+FsQU7mdoqs-YkVKuFvY9=1_UFL8jyT+CaA@mail.gmail.com>
References: <CANHDG4btxwQxGme+TwWYhPVEKSwyHA_C3fVxNuaFJOrzGYOyCA@mail.gmail.com>
	<87iopzb8vw.fsf@tassilo.jf.intel.com>
	<53591BD2.6080001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:41960 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758836AbaD3SrX (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 30 Apr 2014 14:47:23 -0400
Received: by mail-wg0-f41.google.com with SMTP id y10so2101986wgg.0
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2014 11:47:21 -0700 (PDT)
In-Reply-To: <53591BD2.6080001@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

On Thu, Apr 24, 2014 at 7:12 AM, David Ahern <dsahern@gmail.com> wrote:
> On 4/23/14, 11:21 PM, Andi Kleen wrote:
>>
>> Jun Wang <junwang123@gmail.com> writes:
>>
>>> Hi Everyone,
>>>
>>> With systemTap, in the absence of debugging information (DWARF), one
>>> can access function parameters using (positional) numbers. Can the
>>> same be done with `perf`?
>>> Why? I'm trying to capture variables in a kernel function but I don't
>>> have an good perf with DWARF support and there is are significant
>>> challenges to build one due to the relatively old distro.
>>
>>
>> You can specify the registers according to the ABI.
>> di = 1. arg, si = 2nd arg etc.
>
>
> http://en.wikipedia.org/wiki/X86_calling_conventions#List_of_x86_calling_conventions
>

Andi/David, Thanks for the information.

In my case, the argument of the kernel function is a pointer to a
structure and I'm trying to capture the value of an element/field of
that structure.

With DWARF, I would have the following.

perf probe -a "___sys_sendmsg sk=@sock->sk"

Without DWARF,
%di can only provide sock directly. Is there anyway to use %di as the
address of the 'struct socket sock;' and capture sock->sk?
The following was tried, but we captured values are all zeros.

perf probe -a "___sys_sendmsg sk=+10(%bp):u32"

Thanks,
Jun
