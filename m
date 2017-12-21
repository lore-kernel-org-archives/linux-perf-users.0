From: Hadrien Grasland <grasland@lal.in2p3.fr>
Subject: Re: Trying to understand some strange samples in a perf profile
Date: Thu, 21 Dec 2017 17:02:09 +0100
Message-ID: <9c47802d-a568-1a39-bfa4-6a12d0622a4e@lal.in2p3.fr>
References: <db0e4795-de77-ac92-6bab-4b4d451daf26@lal.in2p3.fr>
 <9831756.pFeoWVMjH9@milian-kdab2>
 <6d2adf7a-b181-a8ed-2069-6063abadf6a1@lal.in2p3.fr>
 <2337765.oK3dqqyzHo@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp1.lal.in2p3.fr ([134.158.88.100]:60938 "EHLO
        smtp1.lal.in2p3.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbdLUP5Z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 21 Dec 2017 10:57:25 -0500
In-Reply-To: <2337765.oK3dqqyzHo@milian-kdab2>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

Hey,

First of all, let me be even more aggressive with e-mail quote removal :)

> <snip>
>
>>>> Can you help me check if my understanding of the other samples is
>>>> correct, and give me some clues about what could happen for these last
>>>> few weird ones?
>>>>
>>>> I can provide perf.data files and archives on demand, but since the
>>>> original is a rather big upload/download ( 2.7 GB ), I thought I would
>>>> wait until you can give me some specific requests or a way to produce
>>>> skimmed datasets with only the samples that you are looking for.
>>> The perf.data file wouldn't be enough, we'd need access to all of the
>>> so/dbg files too. perf archive could be used for that purpose, but I've
>>> seen many situations where not all DSOs encountered had a build-id, and
>>> thus where not put into the archive...
>> Yes, back when I discussed the ffffffffffffffff samples with Jiri on
>> IRC, we had this problem that perf archive failed to include all
>> necessary DSOs for analysis. So I'm not sure if it would work here.
>>
>> If there is anything else which I can do to help you here, just tell me!
> I never took the time to debug this, but I personally consider this a big
> problem with perf. These broken backtraces make analysis often much harder
> compared to others tools like VTune which apparently do not suffer from this
> issue. At least there, I have never seen it - maybe it's just less of a
> problem there for some reason.
>
> So to debug this, I guess we need to sit down and actually find a way to
> reproduce the issue with a smaller test case. I actually have something that
> is much smaller than your code base and also shows this issue sometimes:
>
> https://github.com/KDAB/hotspot/blob/master/tests/test-clients/cpp-inlining/
> main.cpp
>
> perf record --call-graph dwarf -c 1000000 ./a.out
> ..
> cpp-inlining 25448 258803.904661:     100000 cycles:uppp:
>          ffffffff815fd197 [unknown] ([unknown])
> ..
> cpp-inlining 25448 258803.907014:     100000 cycles:uppp:
>                     23783 __hypot_finite (/usr/lib/libm-2.26.so)
>          40e3491ebf75199b [unknown] ([unknown])
> ..
> cpp-inlining 25448 258804.312048:     100000 cycles:uppp:
>                     23783 __hypot_finite (/usr/lib/libm-2.26.so)
>          40f204e9aa06ab79 [unknown] ([unknown])
>
> Interestingly, the last broken state repeats, and the address in libm is
> always the same (0x23783). So that's why I believe that the problem might be
> in libunwind/libdw or in the DWARF emitter in GCC/Clang... We'd have to debug
> this. I guess for that we'd have to do something along the following:
>
> - build a minimal "unwinder" application for libunwind e.g.
> - notify libunwind about all mmap events
> - install the register and stack state from the per.data file
> - try to unwind, see what happens
>
> This should give us a MWE that we could also show to Dave Watson and others
> from libunwind. Similarly, we can easily check what libdwfl does there and
> could show it to Mark Wielaard and others from elfutils. I'm pretty sure that
> together we can then figure out what to blame:
>
> - are the register values correct?
> - is the stack state correct?
> - is the DWARF info correct?
> - ...?
>
> It sounds like a lot of work, but it's certainly doable. Fixing this issue
> would make me very happy, and I bet a lot of other users would appreciate this
> too. Right now, I often have to tell people who use perf "deal with broken
> backtraces, try to guesstimate from the surroundings what actually happened".
> But this is of course far from optimal!

This discussion is getting a bit far from my technological comfort zone, 
and I am very likely to say something stupid or repeat what you just 
said in a different way. But if I look at the libunwind documentation, I 
see that there seems to be a way to attach to a process and generate a 
backtrace of it like a debugger would.

If so, couldn't we bisect the issue and discriminate whether this is 
perf's fault by just using this capability to build a minimal poor man 
profiler, which uses libunwind to print a stack trace of an application 
at regular intervals? To the best of my understanding, if we get broken 
stack traces there, the blame would lie on the side of libunwind or the 
compiler-generated DWARF info, whereas if we get correct stack traces, 
the blame would lie on perf's facilities for copying register and stack 
state.

Am I overlooking something here?

Bye,
Hadrien
