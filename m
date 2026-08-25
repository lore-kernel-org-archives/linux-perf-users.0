Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551503546D6
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Aug 2026 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787681122; cv=pass; b=dE0XjYWcpXejlwXO20EH6+kslJEn1DSuZ3uLq9AW4CFfZGy3DUWp7AZfUn87X4X1v6gx+oalOXCklvlY558mPNH6H3+oDLAUFB506rPGpItsZKm6MN1XphzXITXUy4NWRPsePfUboOhleEogAhsDiX8diUxxsVegl0Slk4DWlec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787681122; c=relaxed/simple;
	bh=V3UNN5J6nDz3dzE4VNsp7GZGkFHAyj/McfsSqtxvg7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJ3yodcGHane/jZ1hzbDUR4BEcMm0spV2pXJJ+ZCCBvoRztuamlLdilD/EanHgO7TeBaRw8Zg1pdCj5A2KUIjcdC1c/NDsPY3828jfLwDEihQMsHQ+LcRVuMEADgnmUk7AoQ9pJI1HQn92X58tYpboyjNYm+cw8LsiZWHKgW8oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S5IgZEs2; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S5IgZEs2"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ccdf36f63dso14475ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Aug 2026 11:05:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787681120; cv=none;
        d=google.com; s=arc-20260327;
        b=S4Nz49u4/ulBId0p2xk+RKK8046epzTlQfVbP09SyijsI93QXtV3lBKOY38YUChJkg
         ZluN63iV9AuSVnMJ0FCahgki+tMg6T9LTcqA2czCSvIb/nCMm6tInjNiogyAmya6ketY
         r1Sg2mGReKatmKqpuJEzSrCn5ziIkh6Jl7oS2yZ9mLlp8DBXvYDdga+fEYDx6qHlcfxN
         77yQnVM4MDJyxwtRNnyKaTGs75Ed/3m1qXtF+azVbgFSW7sHJ7Vwgryg0YsSA49ud06d
         Tb7r2w85my9kcGRcxql3+vgKw2OjB7a7lX5jjMcFUI3fK00nduAX9ANO7OK7Pm3Bj/oL
         8Igw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ufh/nfbUTcE49A724IRgg2JNktRd2nFWzMam531z1CI=;
        fh=Xz57Q39q+stAIKaBdsXrca0k9w95HhjwowpHvIq663g=;
        b=CsbhrqIgp15JO17OMPCaKFcIMDMr2eZEdINSq5lHzyALhJDUAR60p9fokbI7ycrrA/
         yowyP3UdB8tQmgSR5QTPyJobZWQ66SxzStF4sFtNr1Xgd/mmJAtv3PsQcJ6mUwm/CzU4
         ogpe8Ivexo1yJO0bMxs8sXJYgeJx4ymbh5xyw/u21VyzsAhLMsLPza9UQYRIW4CGUjiG
         tAZmMoCj4U3TGR9M6ianWbdU4Lo2kmlY/p8TfCZpMH3qZojEFE5CGCKm950QPZoV6FJM
         FirUN3t334w2KseUFe2dE6ssaKy6gbsLz28UeIuAwjA40QOhJp41Ovvq4IllZOjtE4fP
         sbrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787681120; x=1788285920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ufh/nfbUTcE49A724IRgg2JNktRd2nFWzMam531z1CI=;
        b=S5IgZEs2wqzLzwp7QemginD669uprzCazbjufEEQ16T38TyBhMAMFWPv7pc7E/J8XL
         x6oVJIJxceh4dUNeZptutt2rHTRR4KzESnj+rrcUUpP0gl9O7GtIj3BZq+icVZ34cW1D
         tKdQ0rdycCFxWsEw30+eN6R5tezYoylVBcVtRcnCuGFY9jk3k7F1vObZ6cMmHVT9na24
         b08VzZunUZ5+Zn2B2EEq4fPQnUARDDURk9WcyHqBGX7G87fFdQl644KqIRIFDEDgINaC
         CUTHNS8Jwyi77vsGaCgtscO+q1y9hX5eCmAJD3kYtdx2py0TtFqT6Fbw7yUPx2tSMfD0
         2+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787681120; x=1788285920;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ufh/nfbUTcE49A724IRgg2JNktRd2nFWzMam531z1CI=;
        b=N+Rq55mC+oibXDaZ6t/5t3GzrHP5A+DsZ9SG+HenLuemYiAMPXAYtgyLY5MMTlM+7V
         fgezCduZBOd8i9lj/Ut40mYUD2UFAlu1uW7vA+Y0DD6FCc+0I+89giNeWl9mxGDHjxy9
         hqZ9yuprOqzQ7X5RcDlFtkcohTb14d1m5rrP5s6eUPQKTYhOHmAMkslHiCyTaH3myzaM
         wFsR9A1NVlZcXBTT7Vi5g2mZ8won4Kbw5hOJo0Cur8Sc3kYCELDE1PafV+g0JcjJ/Os6
         WYJTkmFzMVjdtaAYsStlIeVi+ulbsjICnjRs1r2eRiInmeS/ZWgaGXeWT+/fNj88lmWo
         PmYA==
X-Gm-Message-State: AFuF++n8WAarAN2xqG6S0ajWkN37T48eLHKx10OdOF0na9TzGwspd6oW
	qimVD7x1hYW8pt6KUUuwp93cKe10/Tl2zOMgVu9W/ON9FrZXjWl/Uj0se0SVUO56sG2zi0d+r1U
	HjXXO5tKjir3KCYCyhCMxfbdlbdPOP5vpZALEc6J+
X-Gm-Gg: AR+sD100q83OxwZC4nekSyIVT2DWv4JjBOJACphPHOAsPlcukpctxW1JYmVGyx1cXLw
	OQuNNA6R1J2aMYtWNrM8n9Q2NwAd3hgN2eCwqtRt0M1mcPKbYKuapm7W860PW/i6GFlCFz32HxX
	/sa9immg97SKBan6/dr5ouSITrcYRD+jUCE+g7vZHe7tMZIPD0GNfK9r+sVxjNsXww2rHZVK/AM
	dz9qTpXBT0CfkZkSW//8Lobmhl8tUbfv+rf3pkrvyJN4kLHw1IztEJrlHrBalJW3Mxvye75A07g
	QcyRoW6SA1dQ9jdfYY1OFrixsoLJdatQH5v+R16f7q9brHZYYqfeCxc2WAmrUgrEP7d1nP0KbH4
	=
X-Received: by 2002:a17:903:b4c:b0:2d1:1d3d:97c3 with SMTP id
 d9443c01a7336-2d707bc991dmr55975ad.13.1787681118368; Tue, 25 Aug 2026
 11:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com>
In-Reply-To: <CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 25 Aug 2026 11:05:06 -0700
X-Gm-Features: AcwNN1XdC95JpHc-V7jAUoj78IoSj2f2iDfPJddtOLSnHe67fCWoajLLoTwCMbg
Message-ID: <CAP-5=fVCPvi8Dt-7igso26_+p7eMpw2K7U1SznNfG-3-S8iK-A@mail.gmail.com>
Subject: Re: [DISCUSSION] Three problems behind broken "perf --call-graph
 dwarf" on AMD: IP and stack dump mismatch, libdw fails on lld's layout, and
 the unwinder fallback never runs
To: Gennady Kupava <gennady.kupava@gmail.com>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 2:50=E2=80=AFPM Gennady Kupava <gennady.kupava@gmai=
l.com> wrote:
>
> Hello,
>
> I decided to share a sort of horror adventure: my attempt to use a recent
> perf with call graphs on recent hardware.  I think this story is useful b=
oth
> to the developers of the tool - there are small bugs to fix here, and a
> user experience worth assessing - and to users, who I am pretty sure coul=
d
> face the same issues.  Other than that, I have a feeling this might quali=
fy
> as an interesting adventure to follow.
>
> So my idea was to work on optimization of an open-source mapping project
> (OsmAnd), for which I am trying to prepare a series of patches - some of
> them have landed already, others are still in my head.
>
> I have 15 years of experience using perf-like tools periodically; it was
> oprofile before perf, and the first tool of this kind that impressed me a
> lot.
>
> So the task here was to take OsmAnd's core library, which is typically bu=
ilt
> for Android, build it for amd64, and measure its performance with call
> graphs.  I am on Debian unstable, very up to date.  The idea of this mail=
 is
> to explain the pile of problems I faced during this adventure.
>
> The Linux distribution is important, as Debian did not enable frame
> pointers - so it is not possible to "just enable FP", call stacks have
> to be done using stack dumps.
>
> So I got everything built and ran it, and tried to run perf on it, which
> succeeded, but... it quickly turned out that the stack frames were not
> complete at all: there was only 2% of callgraphs with deep chain...
>
> And so, together with an AI, I started figuring out what was going on - a=
nd
> this is where the adventure begins.
>
> Attempt number 1: kernel paranoid. The first suspicious thing found was
> kernel.perf_event_paranoid, which is 1 on Debian.  I set it to -1, and th=
e
> profile did seem to improve a lot - the share of samples carrying a deep
> chain went from under 2% to around 44%, which felt like the answer.  It w=
as
> not. Later it turned out this change did not change anything.
>
> Attempt number 2: the lld issue.  Claude found a mail thread on this very
> list - "Call graph dwarf unwinding fails with lld", May 2022,
> https://www.spinics.net/lists/linux-perf-users/msg19574.html - where it

This link was broken for me, but:
https://lore.kernel.org/linux-perf-users/CAOBGo4zjkcX=3DZQm1uYRDe9EjYqsTCyZ=
Y-Gf1C4XqMNYGFCcF+Q@mail.gmail.com/
worked.

> seemed clear that lld builds are worse than ld ones, so that was the next
> candidate to try.  So I tried, and indeed, using ld as the linker made th=
e
> situation better, but... somehow it still did not work.  A few hours of
> AI-augmented debugging later there were fewer frames lost, but they were
> still lost.
>
> Identified problem number 1: it turned out that the default counters on m=
y
> AMD CPU make it impossible to dump the stack and the IP from the same pla=
ce.
>
> Identified problem number 2: even if the stack dump is correct, libdw can=
not
> process it, only libunwind can.
>
> Identified problem number 3: even if I compile perf with libunwind, it st=
ill
> tries to use libdw - and that fails while perf thinks it succeeded.

So libunwind at this point is pretty much unmaintained. Elsewhere
there has been an adoption of an unwinder in LLVM. The problem with
LLVM is that it is a large dependency generally bringing in far more
than what perf needs, leading to startup latency and binary size
problems. Since the perf tools are built and distributed alongside the
kernel, there is reluctance to add LLVM to the list of dependencies as
most distributions would disable such a large dependency.
Consequently, we've been working to make libdw work.

> After identifying all 3 problems, I was able to generate quality stack
> traces.
>
> However, it took me half of the day to reach that point, and it is hard t=
o
> imagine how people in general are able to use perf - this was way too muc=
h
> effort just to record call graphs...

There's no one more entitled than an open source software user :-) But
seriously, thanks for taking the time to provide the feedback.

> From this point I will let the AI explain each of the problems I faced, w=
ith
> precise technical details (i reviewed it all and it makes sense to me):
>
>
> The setup
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>     CPU     AMD Ryzen 9 9950X3D, family 0x1a, model 0x44, stepping 0,
>             microcode 0xb404038; ibs_op and ibs_fetch PMUs present
>     kernel  6.18.5+deb14-amd64 (Debian 6.18.5-1) - all measurements
>     source  linux-source 7.1.8, used for the quotes below; the code there=
 is
>             unchanged, so none of this is fixed in a newer tree
>     perf    7.1.8, both the Debian build and a local build
>
> Two workloads appear below.  One is a self-contained C reproducer, given =
at
> the end.  The other is the real thing: a map tile rasterizer built on Qt5=
 and
> Skia, with deep chains crossing several shared libraries.
>
> The metric throughout is the share of samples whose call chain came back =
with
> a single frame, plus the average chain depth.  The counting script is at =
the
> end too.  All recordings use --call-graph dwarf,65528.
>
>
> Problem 1: IP and stack dump mismatch
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The IP and the stack in one sample describe different moments.
>
> perf record's default event carries the P modifier, so on AMD it is serve=
d by
> IBS.  How one gets there without asking is covered further down.
>
> perf_ibs_handle_irq() copies the whole register set from the NMI frame an=
d
> then overrides only the instruction pointer with the one recorded by IBS:
>
>     arch/x86/events/amd/ibs.c, perf_ibs_handle_irq()
>
>         regs =3D *iregs;
>         if (check_rip && (ibs_data.regs[2] & IBS_RIP_INVALID)) {
>                 regs.flags &=3D ~PERF_EFLAGS_EXACT;
>         } else {
>                 ...
>                 set_linear_ip(&regs, ibs_data.regs[1]);   /* IbsOpRip */
>                 regs.flags |=3D PERF_EFLAGS_EXACT;
>         }
>
> That same pt_regs is what both PERF_SAMPLE_REGS_USER and
> PERF_SAMPLE_STACK_USER are derived from:
>
>     kernel/events/core.c, perf_sample_regs_user()
>
>         if (user_mode(regs)) {
>                 regs_user->abi =3D perf_reg_abi(current);
>                 regs_user->regs =3D regs;
>
>     kernel/events/core.c, perf_output_sample()
>
>         perf_output_sample_ustack(handle, data->stack_user_size,
>                                   data->regs_user.regs);
>
>     kernel/events/core.c, perf_output_sample_ustack()
>
>         sp =3D perf_user_stack_pointer(regs);
>
> So the IP names the instruction IBS tagged, while SP - and therefore ever=
y
> byte of the dumped stack - describes wherever the CPU was when the NMI
> finally arrived.  These are not the same place: in between, the tagged ca=
ll
> has been taken and the callee has built its frame.

This is a known issue with precise samples and call graphs. Even if SP
were sampled, the user stack also needs to be copied.

> Frame-pointer unwinding barely notices.  It still returns a full chain, o=
nly
> with a top frame from a slightly different moment.  DWARF unwinding canno=
t
> survive it, because the CFA rule is chosen by IP and then applied to a st=
ack
> belonging to somebody else's frame.  This is also why the damage concentr=
ates
> in the allocator: malloc() and free() are where a lot of cycles are spent
> immediately after a call instruction, so that is where the skid lands.

There had been hope that frame pointers would become the norm again:
https://www.brendangregg.com/blog/2024-03-17/the-return-of-the-frame-pointe=
rs.html
As accurate stack layout is needed for things like live patching,
there was a push for a compressed debug format, ORC, which has now
been generalized as SFrames. As it takes two instructions on x86 to
establish a frame (push rbp, mov rsp->rbp) then this potentially
closes a problem if a sample happens on the push where you could lose
a function as rbp is still the caller's rbp.

The obvious approach that avoids these problems is LBR. Potentially we
could use shadow stacks, but the work for that doesn't exist - maybe
as an RFC patch; I forget.

> The driver knows about this.  A few lines further down, in the same
> function, sits this:
>
>     /*
>      * rip recorded by IbsOpRip will not be consistent with rsp and rbp
>      * recorded as part of interrupt regs. Thus we need to use rip from
>      * interrupt regs while unwinding call stack.
>      */
>     perf_sample_save_callchain(&data, event, iregs);
>
>     throttle =3D perf_event_overflow(event, &data, &regs);
>
> The kernel-side call chain is deliberately built from iregs - the untouch=
ed
> interrupt registers - precisely so that the IP agrees with rsp and rbp.  =
The
> sample itself, however, is handed &regs, the modified copy - which is
> where the user registers and the stack dump come from, as quoted above.
>
> So the inconsistency is known, it is documented in a comment, and it has =
been
> fixed for one of the two consumers.  The DWARF path appears to have been
> missed.
>
> What the unwinder is actually handed
> ------------------------------------
>
> I instrumented get_entries() in tools/perf/util/unwind-libunwind-local.c =
to
> print the result of every unw_step() together with the first words of the
> recorded stack dump:
>
>     DBG init  ip=3D0x...d1d9 sp=3D0x7ffcc53ff420
>     DBG   [sp+0x18] =3D 0x40                  <- the malloc() argument
>     DBG   [sp+0x28] =3D 0x55f55cbbd010        <- return address slot: hea=
p
>     DBG step#1 sret=3D1 ip=3D0x55f55cbbd010     <- "returned" into the he=
ap
>     DBG step#2 sret=3D-22
>
> and here is the code at the sampled IP:
>
>     00000000000011a0 <inner>:
>       11a0:  sub    $0x28,%rsp
>       ...
>       11d0:  mov    $0x40,%edi
>       11d5:  add    $0x8,%rbp
>       11d9:  call   1050 <malloc@plt>       <- the IP reported by IBS
>       11de:  mov    %rax,-0x8(%rbp)
>
> inner() opens with "sub $0x28,%rsp", so the CFA is rsp+0x30 and the retur=
n
> address sits at rsp+0x28.  The unwinder computed exactly that (0x420 ->
> 0x450) and read exactly that slot.  What it found there is a heap pointer=
,
> because the stack was captured after the call had been taken, and by then=
 the
> slot belongs to malloc()'s frame - note malloc()'s own argument, 0x40,
> sitting right next to it at [sp+0x18].
>
> I checked the obvious suspects before concluding this: the CFI for that
> address is correct, the stack dump is complete (3040 bytes of it), the sa=
mple
> is a user-mode one, and libdw and libunwind fail on it identically.  The
> unwinder is not at fault.  Its input contradicts itself.
>
> Numbers
> -------
>
> Same binary, same run, only the event changes; unwound by libunwind:
>
>     event            precise_ip   single-frame chains   avg depth
>     cpu/cycles/       0             0.0%                 8.0
>     cpu/cycles/p      1            13.2%                 5.1
>     cpu/cycles/pp     2            15.1%                 3.7
>     cpu/cycles/ppp    3            not available
>
> On the real workload:
>
>     cpu/cycles/P                   32.1%                 4.1
>     cpu/cycles/                    16.1%                 8.8
>     cpu-clock                      16.9%                 8.6
>
> (The residue there is Problem 3.)
>
> Why this does not happen on Intel
> ---------------------------------
>
> setup_pebs_fixed_sample_data() copies the entire GPR set out of the PEBS
> record, sp and bp included:
>
>     arch/x86/events/intel/ds.c
>
>         regs->bp =3D pebs->bp;
>         regs->sp =3D pebs->sp;
>
> so IP and stack agree.  IBS records only IbsOpRip; there is no register f=
ile
> in the record for the driver to copy.  The mismatch is therefore rooted i=
n
> what the hardware can provide - but, as the comment quoted above shows, t=
he
> driver already has an answer for it, and applies that answer to the
> kernel-side call chain.
>
> In fairness to IBS, Intel is not flawless here either.  The registers com=
e
> from the PEBS record, but the stack memory is still copied later, when th=
e
> NMI runs, so a sample can be spoiled if the thread returned above the
> recorded SP and reused that memory in the meantime.  The difference is th=
at
> the starting pair is consistent, so the first CFA computation lands on th=
e
> right slot; and everything still live on the stack - the frames of caller=
s
> that have not returned - cannot have been overwritten, which bounds the
> damage to the shallowest frame or two.  With IBS the very first step is
> already wrong.  (That paragraph is reasoning from the code; I have no Int=
el
> machine to check it on.)

Agreed. It is hard to make any of these scenarios work.

> How one ends up on IBS without asking for precision
> ---------------------------------------------------
>
> The default event of perf record is built with the P modifier:
>
>     tools/perf/util/evlist.c
>
>         while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
>                 snprintf(buf, sizeof(buf), "%s/cycles/%s", pmu->name,
>                         can_profile_kernel ? "P" : "Pu");
>
> P sets precise_max (tools/perf/util/parse-events.c), which becomes
> precise_ip =3D 3 (tools/perf/util/evsel.c), and evsel__precise_ip_fallbac=
k()
> then walks it down one step at a time until the kernel agrees:
>
>     $ perf record -vv -g -o /tmp/x.data /bin/true
>     Attempt to add: cpu/cycles/
>       precise_ip                       3
>     decreasing precise_ip by one (2)
>       precise_ip                       2
>
> precise_ip=3D2 is accepted here and routed to IBS.  In other words, a pla=
in
>
>     perf record -g --call-graph dwarf ./prog
>
> on any recent AMD box produces broken call graphs out of the box, silentl=
y,
> for a user who never asked for precise sampling.
>
> There is already a precedent for special-casing this a few lines up in th=
e
> same function: on s390, when call chains are requested, the default event=
 is
> a software clock rather than a precise hardware one.

So you want precise samples by default as they minimize skid, the
distance between an event happening and what the profiler is telling
you. The max_precise on AMD's core PMU is 0 (see the perf list man
page for the precise number meanings), but there's special effort to
make instructions and cycles precise by moving them onto IBS. Because
of this the perf tool ignores the max_precise value from the PMU files
in sysfs and probes what will work by default.

> What the workaround costs
> -------------------------
>
> Dropping the P is not free, and it should be said plainly.  With a
> non-precise event the whole sample is taken at one moment, in the interru=
pt
> handler, so the IP and the stack agree and the chain is right - but the l=
eaf
> address now carries the usual skid: it names the instruction the CPU happ=
ened
> to be on when the interrupt arrived, not the one that overflowed the coun=
ter.
>
>     event            leaf instruction address    call chain
>     cycles:P (IBS)   exact                       garbage
>     cycles           skewed by skid              correct
>
> On this hardware the two cannot be had at once, unless everything in sigh=
t is
> built with frame pointers - which on Debian it is not, and which is where
> this whole story started.  For "where does the time go, by function and b=
y
> call path" the trade is the right way round.  For perf annotate on a hot =
loop
> it is not, and then there are no call chains at all.  That is the part I
> would like to see acknowledged somewhere the user can find it.
>
>
> Problem 2: libdw cannot unwind through lld's default segment layout
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This is the one that sent me chasing the linker early on, and it deserves
> to be stated carefully, because the linker is not the culprit.
>
> Take a program with a deep call chain - twelve nested noinline functions
> around a malloc/free loop, source at the end - and link the same
> translation unit twice:
>
>     clang -O2 -g -fuse-ld=3Dbfd -o deep_bfd deep-stack.c
>     clang -O2 -g -fuse-ld=3Dlld -o deep_lld deep-stack.c
>
> Recorded identically with cpu/cycles/, so that Problem 1 is out of the wa=
y.
> Share of chains with 13 frames or more, and average depth:
>
>     binary                     libdw            libunwind
>     deep_bfd                 97.8%  (16.7)   97.8%  (16.7)
>     deep_lld                  0.3%  ( 2.1)   93.9%  (16.2)
>
> Same recording, two unwinders, opposite outcomes.  And the trigger can be
> switched off from the link line, which pins it down:
>
>     variant                    libdw            libunwind
>     lld, as is                0.3%  ( 2.1)   93.9%  (16.2)
>     lld -Wl,--no-rosegment   97.7%  (16.7)   97.7%  (16.7)
>     lld -Wl,-z,separate-code 95.5%  (16.5)   95.5%  (16.5)
>
> As far as readelf is concerned nothing is missing from the default lld
> output: it has a PT_GNU_EH_FRAME segment and a complete set of FDEs, and
> neither binary has .debug_frame.
>
> This is the same ground as llvm-project issue 53156, "perf record
> --call-graph dwarf does not support ld.lld's default --rosegment
> -z noseparate-code layout" (closed), and the linux-perf-users thread "Cal=
l
> graph dwarf unwinding fails with lld" from May 2022, where the reporter
> wrote plainly "I don't know if this is a bug in lld, perf, or libunwind, =
only
> that it doesn't happen with ld".
>
> What seems to be new here is the missing half of that sentence: libunwind
> handles the layout perfectly well.  So this is a gap in libdw, not in lld=
 -
> and, because of Problem 3 below, a perf built with both unwinders will no=
t
> use the one that works.

So when fixing and expanding libunwind support a not unreasonable
alternative would have been to just remove it.

> The practical reach of this is larger than a synthetic test.  Every Andro=
id
> NDK build is linked with lld, and lld is the default in a growing number =
of
> clang configurations.

Did you confirm the bug was in perf or in libdw? There are fixes in
libdw and my experiences with newer libdw's have been more positive
than older ones.

> Problem 3: a one-frame chain counts as success, so the fallback never run=
s
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> tools/perf/util/unwind.c walks a hardcoded list of unwinders, libdw first=
:
>
>     #ifdef HAVE_LIBDW_SUPPORT
>             symbol_conf.unwind_style[i++] =3D UNWIND_STYLE_LIBDW;
>     #endif
>     #ifdef HAVE_LIBUNWIND_SUPPORT
>             symbol_conf.unwind_style[i++] =3D UNWIND_STYLE_LIBUNWIND;
>     #endif
>
> and stops at the first one that returns anything at all:
>
>             if (ret > 0) {
>                     ret =3D 0;
>                     break;
>             }
>
> A chain consisting of the leaf frame alone satisfies ret > 0.  So wheneve=
r
> libdw manages to emit the sampled IP and nothing else, libunwind is never
> consulted and the user is handed a one-frame "call graph" - which is exac=
tly
> what building perf with LIBUNWIND=3D1 does not fix, and exactly what made=
 this
> problem so confusing to chase.
>
> There is no way to influence the choice from the outside: no command line
> option, no environment variable, no config knob.  To measure the two
> unwinders separately I had to add a switch to my own build.

There's a perf config file value of "unwind.style", the code for it
being in the same file you point at. These statements aren't correct.

> On the real workload, same recording, only the unwinder changes:
>
>     event         unwinder     single-frame   avg depth
>     cycles:P      libdw           53.9%        2.2
>     cycles:P      libunwind        7.0%        6.3
>     cpu-clock     libdw           45.6%        2.4
>     cpu-clock     libunwind        0.0%       12.6
>     cpu-clock     default         16.9%        8.6
>
> The last row decomposes as follows: of 2432 samples, libdw returned somet=
hing
> for 904 of them, and 412 of those were a single frame.  Those 412 are the
> entire residue - for the other 1528 libdw returned nothing at all, the
> fallback did run, and libunwind unwound them in full.
>
> One more thing worth mentioning: Debian's perf ships without libunwind at
> all.
>
>     $ perf version --build-options
>                 dwarf-unwind: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
>           libdw-dwarf-unwind: [ on  ]  # HAVE_LIBDW_SUPPORT
>                    libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT
>                               ( tip: Deprecated, use LIBUNWIND=3D1 ... )
>
> So the distribution user has only the weaker unwinder and nothing to fall
> back to.  Building perf with LIBUNWIND=3D1 also fails without WERROR=3D0 =
(mixed
> declarations and code), and the build system calls that path deprecated. =
 On
> these workloads the deprecated unwinder is the one that works.

Yep. It is deprecated because no one is maintaining libunwind. For
example, building with a mixture of libunwind architectures seems
broken, and there is no feedback from the mailing list.

> The net effect
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Starting point, on a stock Debian perf with the default event: of 2361
> samples, 47.6% came back with no frames at all, 28.3% with the leaf frame=
 and
> nothing else, and 24.2% with two frames or more.  Average depth 2.2.  Rou=
ghly
> three quarters of the profile carried no call path.
>
> Building perf with libunwind but leaving everything else alone gets that =
to
> 32.1% single-frame chains at an average depth of 4.1 - better, but the
> libdw-first rule is still throwing away the working unwinder's answer.
>
> After switching to a non-precise event and forcing libunwind: 0.0%
> single-frame chains, average depth 12.6, every sample carrying a chain.
>
> No frame pointers, no rebuilt system libraries, no debug symbols were nee=
ded
> to get there - all three of which we tried and measured along the way, an=
d
> none of which was the answer.  What was needed was knowing about three
> unrelated behaviours, none of which is documented and none of which produ=
ces
> a diagnostic.

It seems you are venting as much at the distribution as at the perf tool he=
re.

> Suggestions and questions
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> 1. Kernel: the fix that was applied to the kernel-side call chain -
>    passing iregs rather than the modified regs - looks like it applies
>    verbatim to PERF_SAMPLE_REGS_USER and PERF_SAMPLE_STACK_USER.  Should
>    those be derived from iregs too when the event requests a user stack
>    dump?  If the precise IP is worth keeping in the sample regardless,
>    should such samples carry a flag, so that userspace knows the IP and t=
he
>    stack do not belong together?  Today nothing distinguishes them.

This is valid feedback. In areas like LBR, the sample IP and the
branch stack duplicate values, and they differ and in the tool we make
choices about which to report. Including it in the user regs would be
an ABI change requiring versioning support.

> 2. perf: precise events and DWARF call graphs are mutually exclusive on t=
his
>    hardware, so arguably perf should simply not let the two be combined. =
 I
>    would suggest two rules rather than one, because a blanket refusal wou=
ld
>    make the common case worse:
>
>    - for the default event, drop the P when --call-graph dwarf is request=
ed,
>      silently and on PMUs where precision means IBS.  Otherwise a plain
>      "perf record -g --call-graph dwarf" starts failing outright on every=
 AMD
>      box, which is worse than today.  The s390 case in evlist.c suggests =
this
>      kind of substitution is considered acceptable;

The s390 change is relatively recent and somewhat in flux. We could
detect AMD and choose events but what is selected currently was done
for AMD (ie we don't use max_precise from the PMU).

>    - if the user asked for a precise event explicitly and also asked for
>      DWARF call chains, refuse with a message that says why and what to d=
o,
>      instead of quietly producing a useless result.
>
>    Note that this should be scoped to IBS.  On Intel, PEBS records the wh=
ole
>    register set, so precise events and DWARF unwinding work together ther=
e
>    and nothing needs restricting.  Frame-pointer call graphs are also fin=
e
>    with precise events - only the leaf frame is off.
>
> 3. perf: a single-frame result should probably not count as unwinder succ=
ess
>    and suppress the fallback.  This one looks like a small, contained fix=
.

It seems better to fix libdw. Unwinder success means that we think the
unwinder ran and understood the DWARF debug information. Supporting a
mixture of unwinds seems overly complex; moreover, libunwind support
probably shouldn't be there.

> 4. perf: a way to choose the unwinder explicitly - an option or an
>    environment variable - would have saved most of this investigation.

This exists.

> 5. libdw: the lld layout case is worth fixing, or at least worth recordin=
g
>    somewhere, given how much clang output it covers.

Patches welcome.

> 6. Documentation: perf-amd-ibs(1) and perf-record(1) could say that preci=
se
>    events on AMD are incompatible with --call-graph dwarf.  A single sent=
ence
>    would have saved a day here.

It may be profitable here to go to your distribution and complain.
They control how things are built and could, for example, enable frame
pointers.

Thanks,
Ian

> Reproducers
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Problem 1, the allocator case:
>
>     /* gcc -O2 -g -o ibs-repro ibs-repro.c */
>     #include <stdlib.h>
>     #include <stdio.h>
>
>     static void *keep[200000];
>
>     __attribute__((noinline)) static long inner(int n)
>     {
>             long c =3D 0;
>             int i;
>
>             for (i =3D 0; i < n; i++) {
>                     keep[i] =3D malloc(64);
>                     c +=3D (long)keep[i];
>             }
>             for (i =3D 0; i < n; i++)
>                     free(keep[i]);
>             return c;
>     }
>
>     __attribute__((noinline)) static long outer(int n)
>     {
>             return inner(n) + 1;
>     }
>
>     int main(void)
>     {
>             long s =3D 0;
>             int i;
>
>             for (i =3D 0; i < 300; i++)
>                     s +=3D outer(200000);
>             printf("%ld\n", s);
>             return 0;
>     }
>
>     perf record -e cpu/cycles/P -F 300 --call-graph dwarf,65528 \
>         -o p.data ./ibs-repro
>     perf record -e cpu/cycles/  -F 300 --call-graph dwarf,65528 \
>         -o n.data ./ibs-repro
>
> Problems 2 and 3, the linker case:
>
>     /* clang -O2 -g -fuse-ld=3Dbfd -o deep_bfd deep-stack.c
>        clang -O2 -g -fuse-ld=3Dlld -o deep_lld deep-stack.c */
>     #include <stdlib.h>
>     #include <stdio.h>
>
>     static void *keep[4096];
>
>     __attribute__((noinline)) static long f12(int n)
>     {
>             long c =3D 0;
>             for (int i =3D 0; i < n; i++) {
>                     int k =3D i & 4095;
>                     free(keep[k]);
>                     keep[k] =3D malloc(64);
>                     c +=3D (long)keep[k];
>             }
>             return c;
>     }
>     __attribute__((noinline)) static long f11(int n){ return f12(n)+1; }
>     __attribute__((noinline)) static long f10(int n){ return f11(n)+2; }
>     __attribute__((noinline)) static long f9 (int n){ return f10(n)+3; }
>     __attribute__((noinline)) static long f8 (int n){ return f9 (n)+4; }
>     __attribute__((noinline)) static long f7 (int n){ return f8 (n)+5; }
>     __attribute__((noinline)) static long f6 (int n){ return f7 (n)+6; }
>     __attribute__((noinline)) static long f5 (int n){ return f6 (n)+7; }
>     __attribute__((noinline)) static long f4 (int n){ return f5 (n)+8; }
>     __attribute__((noinline)) static long f3 (int n){ return f4 (n)+9; }
>     __attribute__((noinline)) static long f2 (int n){ return f3 (n)+10; }
>     __attribute__((noinline)) static long f1 (int n){ return f2 (n)+11; }
>
>     int main(void)
>     {
>             long s =3D 0;
>             for (int i =3D 0; i < 200; i++)
>                     s +=3D f1(200000);
>             printf("%ld\n", s);
>             return 0;
>     }
>
>     perf record -e cpu/cycles/ -F 2000 --call-graph dwarf,65528 \
>         -o bfd.data ./deep_bfd
>     perf record -e cpu/cycles/ -F 2000 --call-graph dwarf,65528 \
>         -o lld.data ./deep_lld
>
> Counting single-frame chains and average depth:
>
>     count() { perf script -i "$1" | awk '
>         /^[^ \t]/ {if (n) {t++; if (n=3D=3D1) o++; s+=3Dn} n=3D0; next}
>         /^[ \t]*[0-9a-f]+ / {n++}
>         END {printf "%d of %d single-frame (%.1f%%), avg depth %.1f\n",
>              o, t, 100*o/t, s/t}'; }
>
> To see Problem 1 in isolation a perf built with libunwind is needed, and
> Problem 3 has to be worked around; with a libdw-only build all three add =
up
> and the picture is very hard to read.  Which, in a sense, is the whole po=
int
> of this message.
>
> =3D=3D end of AI description
>
> I hope it was an interesting read!
> Let me know if I could do anything here, I will be happy to help fixing
> these problems.  Hope this would help anybody, and looking for the feedba=
ck.
>
> Regards, Gennady Kupava
>
