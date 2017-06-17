From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf report: fix off-by-one for non-activation frames
Date: Sat, 17 Jun 2017 16:56:57 +0900
Message-ID: <CAM9d7cjqZpuxPmARtp_Zy_PhZ+Gpt7Px_ecsLe=dhguNsYW1Bw@mail.gmail.com>
References: <20170515150444.6841-1-milian.wolff@kdab.com> <5576772.scvU8aRrkq@agathebauer>
 <20170616115744.GA14948@host1.jankratochvil.net> <31894796.cyPb9Arfxd@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32803 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752277AbdFQH5T (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 17 Jun 2017 03:57:19 -0400
In-Reply-To: <31894796.cyPb9Arfxd@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Jan Kratochvil <jan.kratochvil@redhat.com>, "linux-kernel@vger.kernel.org" <Linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>

On Sat, Jun 17, 2017 at 4:54 AM, Milian Wolff <milian.wolff@kdab.com> wrote:
> On Freitag, 16. Juni 2017 13:57:44 CEST Jan Kratochvil wrote:
>> On Fri, 16 Jun 2017 13:51:37 +0200, Milian Wolff wrote:
>> > > perf-4.12.0-0.rc5.git0.1.fc27.x86_64
>> > >
>> > >                   39e32e gdb_main (/usr/libexec/gdb)
>> > >                   10b6fa main (/usr/libexec/gdb)
>> > >
>> > >    0x000055555565f6f6 <+54>:    callq  0x5555558f17a0
>> > >    <gdb_main(captured_main_args*) 0x000055555565f6fb <+59>:    mov
>> > >    0x18(%rsp),%rcx
>>
>> [...]
>>
>> > Excuse me, but I'm having trouble following you. The non-GDB backtraces
>> > you
>> > are pasting do not show srcline information. So what exactly is broken?
>>
>> There is broken that perf now reports address 10b6fa (corresponding to
>> relocated address 0x000055555565f6fa) but there is no instruction on address
>> 0x000055555565f6fa.  If you 'objdump -d' it you cannot find any instruction
>> on adress 0x000055555565f6fa (or on address 0x10b6fa).  There is
>> instruction on address 0x000055555565f6fb.
>>
>> > Maybe paste the perf output you get now and highlight what you'd expect
>> > instead?
>>
>> Actual:
>>                   39e32e gdb_main (/usr/libexec/gdb)
>>                   10b6fa main (/usr/libexec/gdb)
>> Expected:
>>                   39e32f gdb_main (/usr/libexec/gdb)
>>                   10b6fb main (/usr/libexec/gdb)
>>
>> I agree perf needs to calculate with 39e32e and 10b6fa.  But it should
>> display to user 39e32f and 10b6fb.
>
> Hmmm this will require some more changes throughout the stack then. I.e. we'll
> have to remember the "isactivation" flag along with the original IP, and only
> apply the offset then when we query for inliners or srcline information. Maybe
> I can pull that off somehow in the patch series I'm working on currently,
> which refactors the whole inline/srcline/callchain logic anyways.
>
> I don't see an easy way to fix the behavior. Does anyone else? So how do we
> deal with this situation in the interim? I'd prefer we keep the current
> "broken" state, as I consider it less broken than what we had before... I
> guess some of the core perf developers should decide how to handle this.

Not sure whether it needs be fixed or not.  If we fix it, srcline and
address would not match so it can give its own confusion to users.
Ideally it should display an addressof the instruction before the
address IMHO.

Thanks,
Namhyung
