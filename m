From: David Ahern <dsahern@gmail.com>
Subject: Re: perf record always record the same kernel symbol
Date: Fri, 10 May 2013 14:22:42 -0600
Message-ID: <518D5712.5070907@gmail.com>
References: <CAKZq+rfUO070Ph38EeOzGGxG3CtWiLZ4-eH=PLgby62Ugk3w1w@mail.gmail.com> <518D46AA.1000006@gmail.com> <CAKZq+rcx8qAmU8ZW8QTcrw3sd28-_5kbo6e5qXZuKqSAjYEm2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-da0-f43.google.com ([209.85.210.43]:44172 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754397Ab3EJUWs (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 10 May 2013 16:22:48 -0400
Received: by mail-da0-f43.google.com with SMTP id u7so533499dae.16
        for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2013 13:22:47 -0700 (PDT)
In-Reply-To: <CAKZq+rcx8qAmU8ZW8QTcrw3sd28-_5kbo6e5qXZuKqSAjYEm2Q@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Chao Xu <caesarxuchao@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 5/10/13 1:58 PM, Chao Xu wrote:
> Thanks David. This indeed gave more samples. Do you know why the symbol
>   [k] 0xffffffff81043fea occured so often? As shown in the pasted
> result, both "swapper" and "perf" had this symbol. And if I "perf record
> dd if=/dev/zero of=/dev/null" or "perf record ping", they all showed
> this symbol. I pasted these results in the end of this email.
> I guess my real concern is the symbols cannot be mapped into meaningful
> function names. These symbols cannot be found in either /proc/kallsyms
> nor the vmlinux I built from the kernel source tree. Any idea? Thanks.

take a look at the output of report -v and report -D. For me those 
commands work just fine:

# perf record -a -- sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.104 MB perf.data (~4527 samples) ]

# perf report

  38.39%       swapper  [kernel.kallsyms]   [k] intel_idle
   9.26%          perf  [kernel.kallsyms]   [k] generic_exec_single
   5.58%       swapper  [kernel.kallsyms]   [k] cpuidle_wrap_enter
   4.73%       swapper  [kernel.kallsyms]   [k] hpet_legacy_next_event
   4.47%       swapper  [kernel.kallsyms]   [k] _raw_spin_lock_irqsave
...

David
