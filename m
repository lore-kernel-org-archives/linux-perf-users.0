From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: perf call stacks on 32bit ARM v7
Date: Fri, 30 Sep 2016 09:32:44 +0200
Message-ID: <CAORVsuUtLUVbAQfZgkZrzJihyreHjyD4S-b+aRypi9aNbNEozQ@mail.gmail.com>
References: <4233607.GXAFRqVoOG@agathebauer> <57EB203D.6000603@huawei.com>
 <CAORVsuUB1AwtZxnNS-Z5pXdcDfrD=GWr43C=NMZsVq=CdqR5xA@mail.gmail.com> <1679528.gn0OXkLKrD@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:37271 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbcI3Hcq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Sep 2016 03:32:46 -0400
Received: by mail-it0-f41.google.com with SMTP id j69so29710196itb.0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Sep 2016 00:32:45 -0700 (PDT)
In-Reply-To: <1679528.gn0OXkLKrD@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: "Wangnan (F)" <wangnan0@huawei.com>, linux-perf-users@vger.kernel.org, hekuang 00206996 <hekuang@huawei.com>

Hi,

On Thu, Sep 29, 2016 at 12:33 PM, Milian Wolff <milian.wolff@kdab.com> wrot=
e:
> On Donnerstag, 29. September 2016 09:39:51 CEST Jean Pihet wrote:
>> Hi Milian, Wangnan,
>>
>> I am pretty busy this week. Let me check and come back to you next week.
>
> Sure, take your time - much appreciated!
>
>> PS: did you check the detailed instructions from the Linaro wiki pages?
>> These are linked from the Fosdem presentation slides.
>
> You mean this page, right:
>
> https://wiki.linaro.org/KenWerner/Sandbox/libunwind

I mean https://wiki.linaro.org/LEG/Engineering/TOOLS/perf-callstack-unwindi=
ng
where the details about installation, compilation etc. are found.

In short, DWARF unwinding on ARMv7 should work out of the box. You
need libunwind, the correct kernel config options and perf installed.
As you are mentioning the downside is the size of the generated trace
which can be a limitation on embedded systems. Some parameters can be
used to control the size of the generated trace (-F).

>
> That does not mention perf at all, and only talks about libunwind. Note h=
ow
> your talk, and the wiki, say .exidx unwinding using libunwind works. But =
your
> slides also explicitly say that this mechanism is not supported by perf, =
yet.
> I would like to know the reason for that, or whether this is outdated
> information.

I do not recall the details but .exidx is not supported on ARM,
because of the compiler that does not generate the info in the
binaries (you can check the ELF sections for it) or the kernel does
not unwind the info.

>
> Thanks!

I hope this helps!

Regards,
Jean Pihet

www.newoldbits.com

>
>> Le 28 sept. 2016 3:47 AM, "Wangnan (F)" <wangnan0@huawei.com> a =C3=A9cr=
it :
>> > On 2016/9/28 5:25, Milian Wolff wrote:
>> >> Hello Jean, others.
>> >>
>> >> Can someone please clarify the requirements for getting perf to prope=
rly
>> >> unwind the call stack on 32bit ARM v7?
>> >>
>> >> Looking at [1], it seems that I need either (a) frame pointers, or (b=
)
>>
>> DWARF
>>
>> >> debug information. Because (a) is often not available, and (b) is too
>>
>> large
>>
>> >> for small flash drives on embedded - how do I use perf with split deb=
ug
>> >> information files? I.e. I have tries to record on the arm board using
>>
>> DWARF:
>> >> arm-v7$ perf record --call-graph dwarf ...
>> >>
>> >> Then transferred the perf.data file over to my host machine. Perf
>>
>> archive said
>>
>> >> that no build-id's could be found, so I'm not using that. Instead, I =
try
>>
>> to
>>
>> >> ask perf to find the split debug packes using symfs:
>> >>
>> >> x86-64$ perf report --symfs ... -g graph
>> >>
>> >> But that does not work and I'm not seeing any backtraces. Stracing th=
e
>>
>> report,
>>
>> >> I don't see it even trying to access files - how can I debug this and
>>
>> figure
>>
>> >> out what I'm supposed to be using?
>> >
>> > Unfortunaetly, currently perf only supports corss decoding dwarf
>> > for x86_64, x86_32 and arm64. ARM32 is not on the list.
>> >
>> > Please see:
>> >
>> > http://www.spinics.net/lists/kernel/msg2266293.html
>> >
>> > and
>> >
>> > tools/perf/util/unwind-libunwind.c
>> >
>> > I think adding ARM32 support should not be very hard on perf side.
>> > Add He Kuang to the CC list, he is the author of this patch set.
>> >
>> > Thank you.
>
>
> --
> Milian Wolff | milian.wolff@kdab.com | Software Engineer
> KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt Experts
