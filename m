From: Hadrien Grasland <grasland@lal.in2p3.fr>
Subject: Trying to understand some strange samples in a perf profile
Date: Wed, 20 Dec 2017 10:39:07 +0100
Message-ID: <db0e4795-de77-ac92-6bab-4b4d451daf26@lal.in2p3.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp1.lal.in2p3.fr ([134.158.88.100]:34752 "EHLO
        smtp1.lal.in2p3.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754641AbdLTJoK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Dec 2017 04:44:10 -0500
Received: from localhost (unknown [127.0.0.1])
        by smtp1.lal.in2p3.fr (Postfix) with ESMTP id 35FF333E0F2
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Dec 2017 10:34:23 +0100 (CET)
Received: from smtp1.lal.in2p3.fr ([127.0.0.1])
        by localhost (smtp1.lal.in2p3.fr [127.0.0.1]) (amavisd-new, port 10028)
        with ESMTP id Bq4CgihdOmK8 for <linux-perf-users@vger.kernel.org>;
        Wed, 20 Dec 2017 10:34:21 +0100 (CET)
Received: from [134.158.76.29] (pc-grasland.lal.in2p3.fr [134.158.76.29])
        by smtp1.lal.in2p3.fr (Postfix) with ESMTPSA id B6C8C33E116
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Dec 2017 10:34:21 +0100 (CET)
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,

I am currently trying to get a reliable perf setup for a new codebase 
that I am working on. The software is rather big and complex (particle 
physics framework from the Belle 2 experiment), and architected in a way 
that makes it hard to break it down in smaller chunks, which brings some 
new issues that I do not usually encounter in my smaller software 
projects. I thought you might be able to help me understand some of the 
oddities that I observe in perf's output.

-----

I am running perf 4.14.3 on top of Linux 4.14.6 and a Haswell machine 
(Intel(R) Xeon(R) E5-1620 v3). My Linux distribution, openSUSE 
Tumbleweed, has the nasty but sadly widespread habit of building 
everything using -fomit-frame-pointer, which makes FP-based call graphs 
impractical. And some parts of the code produce rather huge stack traces 
(> 100 frames, most likely originating from recursion) which preclude 
use of LBR-based profiling. So as far as I understand, my only option is 
to use DWARF with stack samples that are as large as possible ( 65528 ), 
and hope that the remaining truncated traces do not bias my profile too 
much. I estimated by analyzing the output of perf script (more about 
that below) that they are < 2%, so the impact shouldn't be too bad.

Since these big stack semples cause quite a lot of perf.data I/O, I keep 
the sampling rate reasonable (1 kHz) and store my perf.data on a ramdisk 
during sampling. With these final tweaks, my perf record command ends up 
looking like this:

$ perf record -a --call-graph=dwarf,65528 -F 1000 -o /dev/shm/perf.data basf2 02_fit.py -i simulated.root && mv /dev/shm/perf.data /tmp/perf.data

Due to the aforementioned huge stack traces, I also had to increase perf 
report's stack limit to avoid systematic statistical bias against large 
stack traces. I did not find an "unlimited" option, so I just made it 
large enough to encompass any possible stack trace:

$ perf report --max-stack=65535 -i /tmp/perf.data

-----

Now, my problem is that the aforementioned perf report command only 
attributes ~84% of the samples to the top-level function of the program 
(here __libc_start_main), which seems a little low to me. In an attempt 
to understand this, I started analyzing the perf script output, and 
noticed a number of anomalous samples which I would like to discuss 
further with you.

~0.7% of samples have no stack trace at all. I'm not sure if this is 
expected, my guess was that this could possibly happen if the PMU 
interrupt fires at a time where the system is in an idle state. You tell 
me. In that case, perf script only displays a header like this:

.   irqbalance  1497 [001]   275.010584:    1320760 cycles:uppp:

~ 1.6% of stack traces end with the ffffffffffffffff pointer. I had a 
little chat about those with Jiri on IRC, who suggested that a common 
reason for this is when the stack sample is not large enough. It 
certainly seems true for some samples, but I am not sure if this is 
always the right explanation as I get it even for very short stacks like 
the following one:

.   basf2  3272 [007]   300.526376:    3571762 cycles:uppp:
.   	           27be5 __ieee754_pow_sse2 (/lib64/libm-2.26.so)
.   	ffffffffffffffff [unknown] ([unknown])

However, it might be the case that some functions allocate very large 
stack objects, or that this invalid pointer is used in other cases. I 
welcome additional explanations here.

~0.6% of samples look mostly normal, but end with a DSO like 
"/tmp/perf-<PID>.map". A web search suggests that this happens when perf 
detected JIT-compiled code, but did not get DWARF information from the 
JIT. And in most cases this explanation looks accurate to me as the next 
DSO in the stack is typically libmozjs or similar.

~0.2% of samples are full of "[unknown]" symbols and end up somewhere in 
a DSO with "nvidia" in its name. I understand this as originating from 
the fact that DWARF call graphs cannot work well with proprietary code 
that does not have debug info, and that's fine by me considering the low 
amount of samples.

Now, these are the anomalous samples which I think I understand. But as 
you can see, they are far from accounting for all of my 16% of "missing" 
samples. For the remaining ones, I can explain ~2.8% as originating from 
other system activity (other running programs, syscalls, etc), but that 
still leaves a good 10.2% of samples for which I have absolutely no idea 
what's going on.

In the majority of the cases (~9.7%), the stack traces just suddenly go 
someplace weird for no apparent reason:

.   basf2  3272 [007]   300.560379:    3571034 cycles:uppp:
.   	          1a7036 G4PolyconeSide::DistanceAway (/home/hadrien/Software/Belle2/externals/development/Linux_x86_64/opt/lib/libG4geometry.so)
.   	               1 [unknown] ([unknown])

While in the remaining cases (~0.6%), the stack traces start fine but 
end up rather abruptly:

.   basf2  3272 [007]   300.541377:    3571664 cycles:uppp:
.   	            e4a9 Belle2::G4SafeNavigator::LocateGlobalPointAndSetup (/home/hadrien/Software/Belle2/tests-release/modules/Linux_x86_64/opt/libgenfitUtilities.so)

Can you help me check if my understanding of the other samples is 
correct, and give me some clues about what could happen for these last 
few weird ones?

I can provide perf.data files and archives on demand, but since the 
original is a rather big upload/download ( 2.7 GB ), I thought I would 
wait until you can give me some specific requests or a way to produce 
skimmed datasets with only the samples that you are looking for.

Thanks in advance for your help!
Hadrien
