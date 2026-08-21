Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E5134D4E9
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787349015; cv=pass; b=khoCn3bAuNazvtTdK8aWmaM8F6skuUNjAAjCAKm20fkNQ5unVA+m9/sIQjWV2DWh5kTNDAkVpt0Yviecgbz0YchGQmjjjkKuBPEAIjEYU4OtDqgN6GCsNbqeVXtey7Dancsb+0pjMP2x2tzGaBsO4EEHqTeDBwpQuPUhawnf18Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787349015; c=relaxed/simple;
	bh=1pLAwWyq6b48NBYz7fHR3XtxzYdps3YoHud1pBkvOsM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Y6KmGDonQNGFgHhmn3Ok8rIKNslVSe7SCjLHBgA6MJ91GTWvESNJeLx5LnN9kqXQeo1RDMiG67cgxF2BrzUN1tvOk0lmjeTT9/mJMowg0CrxQBeoUuBFTy4UMtfslsjH1k258/BhX+BA2wMpKHWeUviWNh05QU41LjfXrTUKTyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyk7vwwY; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyk7vwwY"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-74ac3ea9c60so470646137.1
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 14:50:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787349012; cv=none;
        d=google.com; s=arc-20260327;
        b=F5EebVhzYwUZ5bJeXcanYxqX9tobVgzPA1klzpa5XshEIFjU7fKb1CXUbpIQ93Lgmh
         yQNbpVNK+EkkOiNaelhBU+bfDPA9wKHO87X17F6BE/s4XVYmnppSAG3MsB/HWARsG6YV
         fvx0hz1Qq/XJau6+/xLXwgn5EoaYK/hOdmzPQLXVaXDlBFHPDR68ZlnxXY5qc1UDAoiu
         VxDeFe7mssi5nxyn4pp6g0AIy2zr8WP0aQH03ZhMgvTg64xOBwM03CHG4vlm1Snw+bif
         DcpwHBspgZuWVZLLIlpDT1tHMfBz2nRQeve/tcu0jXnDViy+CIwAiZZxDJ2LlY/c3BKs
         8xJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=4rnRE4yh16NWTqAWZtWQvdw/lABV9SYDUJyTVE6yIOg=;
        fh=EM2sGyPsvFBTCp5QmGLbfOIPnL+NwbNzbt7jVIMMnT8=;
        b=Hn/Lj6CEEZGGpeBDjVdZegxFp2qA3t9iOTiC0ivwtLeaVtaKQ6Ro3wXpVqOjWS+8eM
         oCGDHMYW/VBNh324tdVVWqDp3OEN52JwOZvDL3vAuuvaGeCUsx1DT6j6aV0kkPU0ApQL
         idje4aDonpr0VxIRDrXZCKTXMuDdY8Ar87D2YtCvRVxaP1/KQIdqfjr76Lv0Tvaw7E4E
         JcSQWF59uo8UgGdpIUFZmFauX75CoGHP9OWyuvpNI8MWR6AIAex+QejiFmsK3XOajyvO
         e83eFIJHHFJrRXvR396MNt1nrwSfKd9s1glTgrFxtcA28x6qkG4dTFuZad/6HALO5LT7
         GyWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787349012; x=1787953812; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4rnRE4yh16NWTqAWZtWQvdw/lABV9SYDUJyTVE6yIOg=;
        b=lyk7vwwYpW6+gDzqhO9r9Q0qd/n4KLtVF129GFQqOfFOpXGBieDwcyW6s7ZLC2LWEx
         llYJgIBnZkx0RwjVBpCwl+1XYvVt2GDPMkT52aPE2Kd+4E7Ol4SdmjG8g6o/HPOSjIm9
         ratiGOF/3zMBpcBG8OVy1zzXqyBqUyD7MROmOwYp16ux5CbUcs2PiClaxZ+jWEniRazF
         AERQQO9R8BxKAq2CG1GujhFJ4nUQCzNpCZ3YBEvBkjB1beFC4f7hkIHSm1S3mdpQ+KSO
         bxuuaOQ9kJegKpksE33T8EcWs8fAubEvBxBaHm61tqgvB7ssvMDLjK6gCoa8qyjbkf3C
         cqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787349012; x=1787953812;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4rnRE4yh16NWTqAWZtWQvdw/lABV9SYDUJyTVE6yIOg=;
        b=MPg3ikU9F4ckMCbjIYyMfCaAmW/Oga1MTHDqtz+fBrooCvP/CM2aFDIYtOf/dD4RY8
         LcAoa8UOf09TyemeA85pC1pxq5FnX1ysbMdPUYxA+bKVWT7BbyoqOMQUHqpOUh4d7Ogn
         DSNSrfTNPWcvE6JYeFLG/npMpnPuFqkZSTBr44PZGXMAw78qpvvE53Fv7BnDkJsQV9a2
         BO1KqmyGOIN+38btQJPAWA45TGohb7OHyG/l16Xw1nAugrVk3GTvykd4KegNfOsrsyHY
         +EH8q1A+TdLSudyD+AigoBOkrNMHTnej/iT7TK1i+OcqoOC951bi+vnEP2927waQ4dCX
         crwQ==
X-Gm-Message-State: AFuF++muICJQO9qU3PU0tSHH5BA+3D/te+U3RWm7ZKn+KwQGEn9GgJ2c
	z9uFqpbChoRk4kw1zJc6aIT2m2dSCXAs/jHFAzFGUA8wcMOQhVYKB8UrLgHck8Nd3tNC9ZuOGAV
	tAiShhiaC2dDi0B9Ndud6SgnrOZmWDqZ55Zao
X-Gm-Gg: AR+sD11/yXaewZ0zwnEoqDE7NMnpATIR0YmGsPZrwVZkx1++f8QrDOtr//IOpnmaaxG
	MqWC2fYZ2nw8Kabut0+s29pzBIzAbVSzqHYn0yyNMhCWNQwCVRcAK09ItNCkbvZUbFxiOoAwMwr
	wxzuSaRTQxJA5RJudD+TEYAfsXIGDlkylXsBgFkpAqYkBplprKdTG18JEszzXyy1Jkn6sFK4Y7i
	9H5wU7dSOYvwrME7vPYdvNSsvDksIp7p10k8MYMhaB+qw28eaQZR/OE/aE9ALoFwCrWfGxgLVsG
	o2DSUk0f6URZ9tQWtJ6auHPcODGqxxjikzYm0QHTajJw7v08ZAlAAPzw9POtxwuZ6BGY6Ihw7/c
	VJVQohL5CNK+qcolcN2D7Sy87N3BW3gj5ZzPiCNvCT1sweg==
X-Received: by 2002:a05:6102:3fa8:b0:777:4e99:6f84 with SMTP id
 ada2fe7eead31-77a620270e7mr2798718137.1.1787349011680; Fri, 21 Aug 2026
 14:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gennady Kupava <gennady.kupava@gmail.com>
Date: Fri, 21 Aug 2026 22:49:59 +0100
X-Gm-Features: AcwNN1XbQwXcJ8RIP1rLEpIZkn4gWfI_l212RrrDv8wQqtkmrtk3NASGmO_yKNs
Message-ID: <CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com>
Subject: [DISCUSSION] Three problems behind broken "perf --call-graph dwarf"
 on AMD: IP and stack dump mismatch, libdw fails on lld's layout, and the
 unwinder fallback never runs
To: linux-perf-users@vger.kernel.org
Cc: Gennady Kupava <gennady.kupava@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

I decided to share a sort of horror adventure: my attempt to use a recent
perf with call graphs on recent hardware.  I think this story is useful both
to the developers of the tool - there are small bugs to fix here, and a
user experience worth assessing - and to users, who I am pretty sure could
face the same issues.  Other than that, I have a feeling this might qualify
as an interesting adventure to follow.

So my idea was to work on optimization of an open-source mapping project
(OsmAnd), for which I am trying to prepare a series of patches - some of
them have landed already, others are still in my head.

I have 15 years of experience using perf-like tools periodically; it was
oprofile before perf, and the first tool of this kind that impressed me a
lot.

So the task here was to take OsmAnd's core library, which is typically built
for Android, build it for amd64, and measure its performance with call
graphs.  I am on Debian unstable, very up to date.  The idea of this mail is
to explain the pile of problems I faced during this adventure.

The Linux distribution is important, as Debian did not enable frame
pointers - so it is not possible to "just enable FP", call stacks have
to be done using stack dumps.

So I got everything built and ran it, and tried to run perf on it, which
succeeded, but... it quickly turned out that the stack frames were not
complete at all: there was only 2% of callgraphs with deep chain...

And so, together with an AI, I started figuring out what was going on - and
this is where the adventure begins.

Attempt number 1: kernel paranoid. The first suspicious thing found was
kernel.perf_event_paranoid, which is 1 on Debian.  I set it to -1, and the
profile did seem to improve a lot - the share of samples carrying a deep
chain went from under 2% to around 44%, which felt like the answer.  It was
not. Later it turned out this change did not change anything.

Attempt number 2: the lld issue.  Claude found a mail thread on this very
list - "Call graph dwarf unwinding fails with lld", May 2022,
https://www.spinics.net/lists/linux-perf-users/msg19574.html - where it
seemed clear that lld builds are worse than ld ones, so that was the next
candidate to try.  So I tried, and indeed, using ld as the linker made the
situation better, but... somehow it still did not work.  A few hours of
AI-augmented debugging later there were fewer frames lost, but they were
still lost.

Identified problem number 1: it turned out that the default counters on my
AMD CPU make it impossible to dump the stack and the IP from the same place.

Identified problem number 2: even if the stack dump is correct, libdw cannot
process it, only libunwind can.

Identified problem number 3: even if I compile perf with libunwind, it still
tries to use libdw - and that fails while perf thinks it succeeded.

After identifying all 3 problems, I was able to generate quality stack
traces.

However, it took me half of the day to reach that point, and it is hard to
imagine how people in general are able to use perf - this was way too much
effort just to record call graphs...

From this point I will let the AI explain each of the problems I faced, with
precise technical details (i reviewed it all and it makes sense to me):


The setup
=========

    CPU     AMD Ryzen 9 9950X3D, family 0x1a, model 0x44, stepping 0,
            microcode 0xb404038; ibs_op and ibs_fetch PMUs present
    kernel  6.18.5+deb14-amd64 (Debian 6.18.5-1) - all measurements
    source  linux-source 7.1.8, used for the quotes below; the code there is
            unchanged, so none of this is fixed in a newer tree
    perf    7.1.8, both the Debian build and a local build

Two workloads appear below.  One is a self-contained C reproducer, given at
the end.  The other is the real thing: a map tile rasterizer built on Qt5 and
Skia, with deep chains crossing several shared libraries.

The metric throughout is the share of samples whose call chain came back with
a single frame, plus the average chain depth.  The counting script is at the
end too.  All recordings use --call-graph dwarf,65528.


Problem 1: IP and stack dump mismatch
=====================================

The IP and the stack in one sample describe different moments.

perf record's default event carries the P modifier, so on AMD it is served by
IBS.  How one gets there without asking is covered further down.

perf_ibs_handle_irq() copies the whole register set from the NMI frame and
then overrides only the instruction pointer with the one recorded by IBS:

    arch/x86/events/amd/ibs.c, perf_ibs_handle_irq()

        regs = *iregs;
        if (check_rip && (ibs_data.regs[2] & IBS_RIP_INVALID)) {
                regs.flags &= ~PERF_EFLAGS_EXACT;
        } else {
                ...
                set_linear_ip(&regs, ibs_data.regs[1]);   /* IbsOpRip */
                regs.flags |= PERF_EFLAGS_EXACT;
        }

That same pt_regs is what both PERF_SAMPLE_REGS_USER and
PERF_SAMPLE_STACK_USER are derived from:

    kernel/events/core.c, perf_sample_regs_user()

        if (user_mode(regs)) {
                regs_user->abi = perf_reg_abi(current);
                regs_user->regs = regs;

    kernel/events/core.c, perf_output_sample()

        perf_output_sample_ustack(handle, data->stack_user_size,
                                  data->regs_user.regs);

    kernel/events/core.c, perf_output_sample_ustack()

        sp = perf_user_stack_pointer(regs);

So the IP names the instruction IBS tagged, while SP - and therefore every
byte of the dumped stack - describes wherever the CPU was when the NMI
finally arrived.  These are not the same place: in between, the tagged call
has been taken and the callee has built its frame.

Frame-pointer unwinding barely notices.  It still returns a full chain, only
with a top frame from a slightly different moment.  DWARF unwinding cannot
survive it, because the CFA rule is chosen by IP and then applied to a stack
belonging to somebody else's frame.  This is also why the damage concentrates
in the allocator: malloc() and free() are where a lot of cycles are spent
immediately after a call instruction, so that is where the skid lands.

The driver knows about this.  A few lines further down, in the same
function, sits this:

    /*
     * rip recorded by IbsOpRip will not be consistent with rsp and rbp
     * recorded as part of interrupt regs. Thus we need to use rip from
     * interrupt regs while unwinding call stack.
     */
    perf_sample_save_callchain(&data, event, iregs);

    throttle = perf_event_overflow(event, &data, &regs);

The kernel-side call chain is deliberately built from iregs - the untouched
interrupt registers - precisely so that the IP agrees with rsp and rbp.  The
sample itself, however, is handed &regs, the modified copy - which is
where the user registers and the stack dump come from, as quoted above.

So the inconsistency is known, it is documented in a comment, and it has been
fixed for one of the two consumers.  The DWARF path appears to have been
missed.

What the unwinder is actually handed
------------------------------------

I instrumented get_entries() in tools/perf/util/unwind-libunwind-local.c to
print the result of every unw_step() together with the first words of the
recorded stack dump:

    DBG init  ip=0x...d1d9 sp=0x7ffcc53ff420
    DBG   [sp+0x18] = 0x40                  <- the malloc() argument
    DBG   [sp+0x28] = 0x55f55cbbd010        <- return address slot: heap
    DBG step#1 sret=1 ip=0x55f55cbbd010     <- "returned" into the heap
    DBG step#2 sret=-22

and here is the code at the sampled IP:

    00000000000011a0 <inner>:
      11a0:  sub    $0x28,%rsp
      ...
      11d0:  mov    $0x40,%edi
      11d5:  add    $0x8,%rbp
      11d9:  call   1050 <malloc@plt>       <- the IP reported by IBS
      11de:  mov    %rax,-0x8(%rbp)

inner() opens with "sub $0x28,%rsp", so the CFA is rsp+0x30 and the return
address sits at rsp+0x28.  The unwinder computed exactly that (0x420 ->
0x450) and read exactly that slot.  What it found there is a heap pointer,
because the stack was captured after the call had been taken, and by then the
slot belongs to malloc()'s frame - note malloc()'s own argument, 0x40,
sitting right next to it at [sp+0x18].

I checked the obvious suspects before concluding this: the CFI for that
address is correct, the stack dump is complete (3040 bytes of it), the sample
is a user-mode one, and libdw and libunwind fail on it identically.  The
unwinder is not at fault.  Its input contradicts itself.

Numbers
-------

Same binary, same run, only the event changes; unwound by libunwind:

    event            precise_ip   single-frame chains   avg depth
    cpu/cycles/       0             0.0%                 8.0
    cpu/cycles/p      1            13.2%                 5.1
    cpu/cycles/pp     2            15.1%                 3.7
    cpu/cycles/ppp    3            not available

On the real workload:

    cpu/cycles/P                   32.1%                 4.1
    cpu/cycles/                    16.1%                 8.8
    cpu-clock                      16.9%                 8.6

(The residue there is Problem 3.)

Why this does not happen on Intel
---------------------------------

setup_pebs_fixed_sample_data() copies the entire GPR set out of the PEBS
record, sp and bp included:

    arch/x86/events/intel/ds.c

        regs->bp = pebs->bp;
        regs->sp = pebs->sp;

so IP and stack agree.  IBS records only IbsOpRip; there is no register file
in the record for the driver to copy.  The mismatch is therefore rooted in
what the hardware can provide - but, as the comment quoted above shows, the
driver already has an answer for it, and applies that answer to the
kernel-side call chain.

In fairness to IBS, Intel is not flawless here either.  The registers come
from the PEBS record, but the stack memory is still copied later, when the
NMI runs, so a sample can be spoiled if the thread returned above the
recorded SP and reused that memory in the meantime.  The difference is that
the starting pair is consistent, so the first CFA computation lands on the
right slot; and everything still live on the stack - the frames of callers
that have not returned - cannot have been overwritten, which bounds the
damage to the shallowest frame or two.  With IBS the very first step is
already wrong.  (That paragraph is reasoning from the code; I have no Intel
machine to check it on.)

How one ends up on IBS without asking for precision
---------------------------------------------------

The default event of perf record is built with the P modifier:

    tools/perf/util/evlist.c

        while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
                snprintf(buf, sizeof(buf), "%s/cycles/%s", pmu->name,
                        can_profile_kernel ? "P" : "Pu");

P sets precise_max (tools/perf/util/parse-events.c), which becomes
precise_ip = 3 (tools/perf/util/evsel.c), and evsel__precise_ip_fallback()
then walks it down one step at a time until the kernel agrees:

    $ perf record -vv -g -o /tmp/x.data /bin/true
    Attempt to add: cpu/cycles/
      precise_ip                       3
    decreasing precise_ip by one (2)
      precise_ip                       2

precise_ip=2 is accepted here and routed to IBS.  In other words, a plain

    perf record -g --call-graph dwarf ./prog

on any recent AMD box produces broken call graphs out of the box, silently,
for a user who never asked for precise sampling.

There is already a precedent for special-casing this a few lines up in the
same function: on s390, when call chains are requested, the default event is
a software clock rather than a precise hardware one.

What the workaround costs
-------------------------

Dropping the P is not free, and it should be said plainly.  With a
non-precise event the whole sample is taken at one moment, in the interrupt
handler, so the IP and the stack agree and the chain is right - but the leaf
address now carries the usual skid: it names the instruction the CPU happened
to be on when the interrupt arrived, not the one that overflowed the counter.

    event            leaf instruction address    call chain
    cycles:P (IBS)   exact                       garbage
    cycles           skewed by skid              correct

On this hardware the two cannot be had at once, unless everything in sight is
built with frame pointers - which on Debian it is not, and which is where
this whole story started.  For "where does the time go, by function and by
call path" the trade is the right way round.  For perf annotate on a hot loop
it is not, and then there are no call chains at all.  That is the part I
would like to see acknowledged somewhere the user can find it.


Problem 2: libdw cannot unwind through lld's default segment layout
===================================================================

This is the one that sent me chasing the linker early on, and it deserves
to be stated carefully, because the linker is not the culprit.

Take a program with a deep call chain - twelve nested noinline functions
around a malloc/free loop, source at the end - and link the same
translation unit twice:

    clang -O2 -g -fuse-ld=bfd -o deep_bfd deep-stack.c
    clang -O2 -g -fuse-ld=lld -o deep_lld deep-stack.c

Recorded identically with cpu/cycles/, so that Problem 1 is out of the way.
Share of chains with 13 frames or more, and average depth:

    binary                     libdw            libunwind
    deep_bfd                 97.8%  (16.7)   97.8%  (16.7)
    deep_lld                  0.3%  ( 2.1)   93.9%  (16.2)

Same recording, two unwinders, opposite outcomes.  And the trigger can be
switched off from the link line, which pins it down:

    variant                    libdw            libunwind
    lld, as is                0.3%  ( 2.1)   93.9%  (16.2)
    lld -Wl,--no-rosegment   97.7%  (16.7)   97.7%  (16.7)
    lld -Wl,-z,separate-code 95.5%  (16.5)   95.5%  (16.5)

As far as readelf is concerned nothing is missing from the default lld
output: it has a PT_GNU_EH_FRAME segment and a complete set of FDEs, and
neither binary has .debug_frame.

This is the same ground as llvm-project issue 53156, "perf record
--call-graph dwarf does not support ld.lld's default --rosegment
-z noseparate-code layout" (closed), and the linux-perf-users thread "Call
graph dwarf unwinding fails with lld" from May 2022, where the reporter
wrote plainly "I don't know if this is a bug in lld, perf, or libunwind, only
that it doesn't happen with ld".

What seems to be new here is the missing half of that sentence: libunwind
handles the layout perfectly well.  So this is a gap in libdw, not in lld -
and, because of Problem 3 below, a perf built with both unwinders will not
use the one that works.

The practical reach of this is larger than a synthetic test.  Every Android
NDK build is linked with lld, and lld is the default in a growing number of
clang configurations.


Problem 3: a one-frame chain counts as success, so the fallback never runs
==========================================================================

tools/perf/util/unwind.c walks a hardcoded list of unwinders, libdw first:

    #ifdef HAVE_LIBDW_SUPPORT
            symbol_conf.unwind_style[i++] = UNWIND_STYLE_LIBDW;
    #endif
    #ifdef HAVE_LIBUNWIND_SUPPORT
            symbol_conf.unwind_style[i++] = UNWIND_STYLE_LIBUNWIND;
    #endif

and stops at the first one that returns anything at all:

            if (ret > 0) {
                    ret = 0;
                    break;
            }

A chain consisting of the leaf frame alone satisfies ret > 0.  So whenever
libdw manages to emit the sampled IP and nothing else, libunwind is never
consulted and the user is handed a one-frame "call graph" - which is exactly
what building perf with LIBUNWIND=1 does not fix, and exactly what made this
problem so confusing to chase.

There is no way to influence the choice from the outside: no command line
option, no environment variable, no config knob.  To measure the two
unwinders separately I had to add a switch to my own build.

On the real workload, same recording, only the unwinder changes:

    event         unwinder     single-frame   avg depth
    cycles:P      libdw           53.9%        2.2
    cycles:P      libunwind        7.0%        6.3
    cpu-clock     libdw           45.6%        2.4
    cpu-clock     libunwind        0.0%       12.6
    cpu-clock     default         16.9%        8.6

The last row decomposes as follows: of 2432 samples, libdw returned something
for 904 of them, and 412 of those were a single frame.  Those 412 are the
entire residue - for the other 1528 libdw returned nothing at all, the
fallback did run, and libunwind unwound them in full.

One more thing worth mentioning: Debian's perf ships without libunwind at
all.

    $ perf version --build-options
                dwarf-unwind: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
          libdw-dwarf-unwind: [ on  ]  # HAVE_LIBDW_SUPPORT
                   libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT
                              ( tip: Deprecated, use LIBUNWIND=1 ... )

So the distribution user has only the weaker unwinder and nothing to fall
back to.  Building perf with LIBUNWIND=1 also fails without WERROR=0 (mixed
declarations and code), and the build system calls that path deprecated.  On
these workloads the deprecated unwinder is the one that works.


The net effect
==============

Starting point, on a stock Debian perf with the default event: of 2361
samples, 47.6% came back with no frames at all, 28.3% with the leaf frame and
nothing else, and 24.2% with two frames or more.  Average depth 2.2.  Roughly
three quarters of the profile carried no call path.

Building perf with libunwind but leaving everything else alone gets that to
32.1% single-frame chains at an average depth of 4.1 - better, but the
libdw-first rule is still throwing away the working unwinder's answer.

After switching to a non-precise event and forcing libunwind: 0.0%
single-frame chains, average depth 12.6, every sample carrying a chain.

No frame pointers, no rebuilt system libraries, no debug symbols were needed
to get there - all three of which we tried and measured along the way, and
none of which was the answer.  What was needed was knowing about three
unrelated behaviours, none of which is documented and none of which produces
a diagnostic.


Suggestions and questions
=========================

1. Kernel: the fix that was applied to the kernel-side call chain -
   passing iregs rather than the modified regs - looks like it applies
   verbatim to PERF_SAMPLE_REGS_USER and PERF_SAMPLE_STACK_USER.  Should
   those be derived from iregs too when the event requests a user stack
   dump?  If the precise IP is worth keeping in the sample regardless,
   should such samples carry a flag, so that userspace knows the IP and the
   stack do not belong together?  Today nothing distinguishes them.

2. perf: precise events and DWARF call graphs are mutually exclusive on this
   hardware, so arguably perf should simply not let the two be combined.  I
   would suggest two rules rather than one, because a blanket refusal would
   make the common case worse:

   - for the default event, drop the P when --call-graph dwarf is requested,
     silently and on PMUs where precision means IBS.  Otherwise a plain
     "perf record -g --call-graph dwarf" starts failing outright on every AMD
     box, which is worse than today.  The s390 case in evlist.c suggests this
     kind of substitution is considered acceptable;

   - if the user asked for a precise event explicitly and also asked for
     DWARF call chains, refuse with a message that says why and what to do,
     instead of quietly producing a useless result.

   Note that this should be scoped to IBS.  On Intel, PEBS records the whole
   register set, so precise events and DWARF unwinding work together there
   and nothing needs restricting.  Frame-pointer call graphs are also fine
   with precise events - only the leaf frame is off.

3. perf: a single-frame result should probably not count as unwinder success
   and suppress the fallback.  This one looks like a small, contained fix.

4. perf: a way to choose the unwinder explicitly - an option or an
   environment variable - would have saved most of this investigation.

5. libdw: the lld layout case is worth fixing, or at least worth recording
   somewhere, given how much clang output it covers.

6. Documentation: perf-amd-ibs(1) and perf-record(1) could say that precise
   events on AMD are incompatible with --call-graph dwarf.  A single sentence
   would have saved a day here.


Reproducers
===========

Problem 1, the allocator case:

    /* gcc -O2 -g -o ibs-repro ibs-repro.c */
    #include <stdlib.h>
    #include <stdio.h>

    static void *keep[200000];

    __attribute__((noinline)) static long inner(int n)
    {
            long c = 0;
            int i;

            for (i = 0; i < n; i++) {
                    keep[i] = malloc(64);
                    c += (long)keep[i];
            }
            for (i = 0; i < n; i++)
                    free(keep[i]);
            return c;
    }

    __attribute__((noinline)) static long outer(int n)
    {
            return inner(n) + 1;
    }

    int main(void)
    {
            long s = 0;
            int i;

            for (i = 0; i < 300; i++)
                    s += outer(200000);
            printf("%ld\n", s);
            return 0;
    }

    perf record -e cpu/cycles/P -F 300 --call-graph dwarf,65528 \
        -o p.data ./ibs-repro
    perf record -e cpu/cycles/  -F 300 --call-graph dwarf,65528 \
        -o n.data ./ibs-repro

Problems 2 and 3, the linker case:

    /* clang -O2 -g -fuse-ld=bfd -o deep_bfd deep-stack.c
       clang -O2 -g -fuse-ld=lld -o deep_lld deep-stack.c */
    #include <stdlib.h>
    #include <stdio.h>

    static void *keep[4096];

    __attribute__((noinline)) static long f12(int n)
    {
            long c = 0;
            for (int i = 0; i < n; i++) {
                    int k = i & 4095;
                    free(keep[k]);
                    keep[k] = malloc(64);
                    c += (long)keep[k];
            }
            return c;
    }
    __attribute__((noinline)) static long f11(int n){ return f12(n)+1; }
    __attribute__((noinline)) static long f10(int n){ return f11(n)+2; }
    __attribute__((noinline)) static long f9 (int n){ return f10(n)+3; }
    __attribute__((noinline)) static long f8 (int n){ return f9 (n)+4; }
    __attribute__((noinline)) static long f7 (int n){ return f8 (n)+5; }
    __attribute__((noinline)) static long f6 (int n){ return f7 (n)+6; }
    __attribute__((noinline)) static long f5 (int n){ return f6 (n)+7; }
    __attribute__((noinline)) static long f4 (int n){ return f5 (n)+8; }
    __attribute__((noinline)) static long f3 (int n){ return f4 (n)+9; }
    __attribute__((noinline)) static long f2 (int n){ return f3 (n)+10; }
    __attribute__((noinline)) static long f1 (int n){ return f2 (n)+11; }

    int main(void)
    {
            long s = 0;
            for (int i = 0; i < 200; i++)
                    s += f1(200000);
            printf("%ld\n", s);
            return 0;
    }

    perf record -e cpu/cycles/ -F 2000 --call-graph dwarf,65528 \
        -o bfd.data ./deep_bfd
    perf record -e cpu/cycles/ -F 2000 --call-graph dwarf,65528 \
        -o lld.data ./deep_lld

Counting single-frame chains and average depth:

    count() { perf script -i "$1" | awk '
        /^[^ \t]/ {if (n) {t++; if (n==1) o++; s+=n} n=0; next}
        /^[ \t]*[0-9a-f]+ / {n++}
        END {printf "%d of %d single-frame (%.1f%%), avg depth %.1f\n",
             o, t, 100*o/t, s/t}'; }

To see Problem 1 in isolation a perf built with libunwind is needed, and
Problem 3 has to be worked around; with a libdw-only build all three add up
and the picture is very hard to read.  Which, in a sense, is the whole point
of this message.

== end of AI description

I hope it was an interesting read!
Let me know if I could do anything here, I will be happy to help fixing
these problems.  Hope this would help anybody, and looking for the feedback.

Regards, Gennady Kupava
