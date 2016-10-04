From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: perf call stacks on 32bit ARM v7
Date: Tue, 4 Oct 2016 10:41:25 +0200
Message-ID: <CAORVsuUNz4n6XT=wHOQRo0hG+zMz+OcrD_QBFtyZLEd5QsRscQ@mail.gmail.com>
References: <4233607.GXAFRqVoOG@agathebauer> <1679528.gn0OXkLKrD@agathebauer>
 <CAORVsuUtLUVbAQfZgkZrzJihyreHjyD4S-b+aRypi9aNbNEozQ@mail.gmail.com> <2583963.6LxZiVeVan@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:33267 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753329AbcJDIl1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Oct 2016 04:41:27 -0400
Received: by mail-io0-f178.google.com with SMTP id r145so146261519ior.0
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Oct 2016 01:41:26 -0700 (PDT)
In-Reply-To: <2583963.6LxZiVeVan@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: "Wangnan (F)" <wangnan0@huawei.com>, linux-perf-users@vger.kernel.org, hekuang 00206996 <hekuang@huawei.com>

On Sun, Oct 2, 2016 at 11:12 PM, Milian Wolff <milian.wolff@kdab.com> wrote:
> On Freitag, 30. September 2016 09:32:44 CEST Jean Pihet wrote:
>> Hi,
>>
>> On Thu, Sep 29, 2016 at 12:33 PM, Milian Wolff <milian.wolff@kdab.com>
> wrote:
>> > On Donnerstag, 29. September 2016 09:39:51 CEST Jean Pihet wrote:
>> >> Hi Milian, Wangnan,
>> >>
>> >> I am pretty busy this week. Let me check and come back to you next week.
>> >
>> > Sure, take your time - much appreciated!
>> >
>> >> PS: did you check the detailed instructions from the Linaro wiki pages?
>> >> These are linked from the Fosdem presentation slides.
>> >
>> > You mean this page, right:
>> >
>> > https://wiki.linaro.org/KenWerner/Sandbox/libunwind
>>
>> I mean
>> https://wiki.linaro.org/LEG/Engineering/TOOLS/perf-callstack-unwinding
>> where the details about installation, compilation etc. are found.
>>
>> In short, DWARF unwinding on ARMv7 should work out of the box. You
>> need libunwind, the correct kernel config options and perf installed.
>> As you are mentioning the downside is the size of the generated trace
>> which can be a limitation on embedded systems. Some parameters can be
>> used to control the size of the generated trace (-F).
>
> No, I mean the size of the application code when debug symbols are added:
>
> tmp$ du -hs libQt5Core.so.5.7.1
> 63M     libQt5Core.so.5.7.1
> tmp$ strip libQt5Core.so.5.7.1
> tmp$ du -hs libQt5Core.so.5.7.1
> 4.8M    libQt5Core.so.5.7.1
>
> And this is just one library involved of many in the applications I have to
> deal with regularly. I just had a case where the target platform had about
> 50MB storage space free. I resorted to connecting an USB drive to load the
> application code with debug symbols from. But this changes the performance
> behavior of the application, as the code is not loaded anymore from the often
> excruciatingly slow on-board flash drive.

That is correct. You need some space for the debug symbols and also
for the trace generation (I am using the RAM for speed reasons).

>
>> > That does not mention perf at all, and only talks about libunwind. Note
>> > how
>> > your talk, and the wiki, say .exidx unwinding using libunwind works. But
>> > your slides also explicitly say that this mechanism is not supported by
>> > perf, yet. I would like to know the reason for that, or whether this is
>> > outdated information.
>>
>> I do not recall the details but .exidx is not supported on ARM,
>> because of the compiler that does not generate the info in the
>> binaries (you can check the ELF sections for it)
>
> If I compile with -funwind-tables, then I do get the .exidx section, see this
> link I posted earlier:
>
> https://wiki.linaro.org/KenWerner/Sandbox/libunwind
>
>> or the kernel does not unwind the info.
>
> That sounds more like the culprit - can someone confirm, that:
>
> - for frame-pointer based unwinding, perf unwinds the stacks in kernel space
> - whereas dwarf-based unwinding copies the stack together with the samples
> into the perf.data, and does the unwinding later on

Correct! This dwarf unwinding method generates a lot of trace data.
Also the real time trace decoding is not possible.

>
> So one would need to either
>
> - add .exidx unwinding support into the kernel
> - copy whatever is required into perf.data and do the unwinding later on
>   can someone clarify what is actually required to do that?

That requires a more extensive analysis.

As you know I am a freelance consultant and could work on that topic,
as I did for Linaro before.

Regards,
Jean Pihet
www.newoldbits.com

>
>> > Thanks!
>>
>> I hope this helps!
>
> Cheers
>
> --
> Milian Wolff | milian.wolff@kdab.com | Software Engineer
> KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt Experts
