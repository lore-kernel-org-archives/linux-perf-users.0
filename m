Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C9625771
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762420844; cv=none; b=d2XImJlr8Um009iXTIccDDqaOTwHi4QtUySRyN1oszT/r9H4mzmPgjTnh0nr8Npi/oUJgyBtQz81oWgkcLUSGgaSWRS74mM3UMh3zsBKVEUW1WotfSrTkMKl/H1Kdlfxu8fLTR9IgxrPaEPYhZ1AusPU6nICytg/fF2EW2PnvwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762420844; c=relaxed/simple;
	bh=BZAj9xjrVrHo55GRm0hzymwHy4ZLkeA4QAEkTM0CiEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqbozrWNDhk8FQ2SDnU01la0oaPwNP6dAH527/wlHXGgbBPHqJrRFoPHSLjOwNg4TD85qq2gtBUbhr7qUB+7j+9+P7cK1mQB5RZSESeVQcozaCrfCfWTe1jQ89JFwWSTPOM9wk61nBJBKZASQaZMjoeHOeNtAb5WodFsZZf9st0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-55986ed1e50so449966e0c.0
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 01:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762420841; x=1763025641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KubX504yPXipht20fG+MoWQGGnheh7S8oC+ZsVSPC28=;
        b=vqN1pE5II/sanEhEk6rTu9m2ZUEyzABGj5f+HQSNgsZTeFzDFrXmuGlnSugfXdY5pM
         0MwVPRAdj6kSLB/0+RrOSWI7hmUBbdzAoY3ez/VpVtEngYqchQ/0nLgo/NRjpwJuE6yU
         6UTUI4NGXtsBLBSoDJEIGQWguSkySgZBlIaI2VXSnLPIphFcG/b4a37kpIZYqTcZ/ASt
         aAMVTf3CgBVLOhnabWZSDr8j7fhH4i8p+ykoZU01MyVbJUWNN+jVGRbICbohj8lg03Vc
         GkaBQDPQVUeJB5Uk3+VV59EKFM3sVaC/hEVN1lFepPfu3ts2l+47xJSCIkzSdJEakkgt
         klCg==
X-Forwarded-Encrypted: i=1; AJvYcCU3y/i9d3lN7TaK7fQQyB9gHW+J411QMKi1gWooL1VZGQZyPb+3a6SE/0EFa+d3qbhA9xD1cVIAqS1b44Tb4Qew@vger.kernel.org
X-Gm-Message-State: AOJu0YxKrwpsEO6ZT2w4w6n135dqBz6wZ7efWMxAIFaMVam2bw6u+lSu
	O/CJ9D6SPO+v3mTbWsDZBE8BhxI2Cdn1YqzIzojzBYvqhlUve6SspI8VyaMWLg==
X-Gm-Gg: ASbGncs128gwuNCP4Hqw2bmL45/lIce4flHvkkHZmYNrKo3C0R9BEF9x9SXQugX6XkP
	qVmjYbO3+N9y8zQQeNGpD/588xaKVPI2OGVw4ZbS0Byw4y0mVlXWUy6E5k1ec23Foh5PGKCFxpn
	i3iGytvFCXyrA+wNlcT/YiWzub9olbDthyiCVR412cQOClc0bo5cvrzO4Rza7amSZvie3pgwsUl
	1jZO892191G1aj7HoRkJafZJ3WNA+5xEzZ+fHkyA4RPkRrjC7IFyb+UfFWR1NG8qpOeld6nXIwv
	lUjggWZEBFBTxzzKuehDN4QHqhDqIM39iC6EeAomMAMIHJfxLWXypLpddppWgbwhkA159wHmzrt
	TYBdXCpkP+8MjiYJzVg4jf8SojDXomHoGMTRvDQVYyevlFrbAo+fo3X7JUR2D2eoApqGmcCgNnc
	MddpW9LMYCoIyAL7p4uS14aqp63m40+TBpz+qE2KxtCu8n4YfO7r4=
X-Google-Smtp-Source: AGHT+IHHqJ4zmbC4iwd4AhitPIfQYkx5ilx4ckZe+VUJY0zyKaKTsi085AKfeSwTbkBn0hmtovUsYg==
X-Received: by 2002:a05:6122:3210:b0:557:ddc4:dea4 with SMTP id 71dfb90a1353d-559862aebd1mr2424730e0c.5.1762420840592;
        Thu, 06 Nov 2025 01:20:40 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-559958286c8sm1039974e0c.17.2025.11.06.01.20.40
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 01:20:40 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-9354425df5cso404985241.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 01:20:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXYYiiWL04xmhAPUyYHUQScOCcGhVoQHrnfli4WT+wanCCrfEQgebjMnxIMeRXl+eos2yPDXSfPxAkcE3bz08gS@vger.kernel.org
X-Received: by 2002:a05:6102:b0f:b0:5d6:254f:4e24 with SMTP id
 ada2fe7eead31-5dd8923950fmr2513215137.32.1762420839881; Thu, 06 Nov 2025
 01:20:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
 <2d713719-709d-4b46-8234-2dfe948b836a@oracle.com> <CAN30aBGEpwA+ZROXufqBL6MHM70oWTtNpGSioCMhxT8yS2t-Pg@mail.gmail.com>
 <9c11b765-66df-46f3-b4ea-a0c7f52dac35@oracle.com>
In-Reply-To: <9c11b765-66df-46f3-b4ea-a0c7f52dac35@oracle.com>
From: Fangrui Song <maskray@sourceware.org>
Date: Thu, 6 Nov 2025 01:20:54 -0800
X-Gmail-Original-Message-ID: <CAN30aBGX+CuPmPGRjzpRT69pP0QJc_zBAr69RqnMUZ-OXF=t1A@mail.gmail.com>
X-Gm-Features: AWmQ_bmbkFbp9Ns2wSajEhEKfF6JH9VFq6mwBwu1G4coOAuj7Nis3hQXrHfz25A
Message-ID: <CAN30aBGX+CuPmPGRjzpRT69pP0QJc_zBAr69RqnMUZ-OXF=t1A@mail.gmail.com>
Subject: Re: Concerns about SFrame viability for userspace stack walking
To: Indu Bhagat <indu.bhagat@oracle.com>
Cc: Fangrui Song <maskray@sourceware.org>, linux-toolchains@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 4:45=E2=80=AFPM Indu Bhagat <indu.bhagat@oracle.com>=
 wrote:
>
> On 11/5/25 12:21 AM, Fangrui Song wrote:
> >> On Tue, Nov 4, 2025 at 1:21=E2=80=AFAM Indu <indu.bhagat@oracle.com> w=
rote:
> >> On 2025-10-29 11:53 p.m., Fangrui Song wrote:
> >>> I've been following the SFrame discussion and wanted to share some
> >>> concerns about its viability for userspace adoption, based on concret=
e
> >>> measurements and comparison with existing compact unwind implementati=
ons
> >>> in LLVM.
> >>>
> >>> **Size overhead concerns**
> >>>
> >>> Measurements on a x86-64 clang binary show that .sframe (8.87 MiB) is
> >>> approximately 10% larger than the combined size of .eh_frame
> >>> and .eh_frame_hdr (8.06 MiB total).
> >>> This is problematic because .eh_frame cannot be eliminated - it conta=
ins
> >>> essential information for restoring callee-saved registers, LSDA, and
> >>> personality information needed for debugging (e.g. reading local
> >>> variables in a coredump) and C++ exception handling.
> >>>
> >>> This means adopting SFrame would result in carrying both formats, wit=
h a
> >>> large net size increase.
> >>>
> >>> **Learning from existing compact unwind implementations**
> >>>
> >>> It's worth noting that LLVM has had a battle-tested compact unwind
> >>> format in production use since 2009 with OS X 10.6, which transitione=
d
> >>> to using CFI directives in 2013 [1]. The efficiency gains are dramati=
c:
> >>>
> >>>     __text section: 0x4a55470 bytes
> >>>     __unwind_info section: 0x79060 bytes (0.6% of __text)
> >>>     __eh_frame section: 0x58 bytes
> >>>
> >>
> >> I believe this is only synchronous? If yes, do you think this is a fai=
r
> >> measurement to compare against ?
> >>
> >> Does the compact unwind info scheme work well for cases of
> >> shrink-wrapping ? How about the case of AArch64, where the ABI does no=
t
> >> mandate if and where frame record is created ?
> >>
> >> For the numbers above, does it ensure precise stack traces ?
> >>
> >>   From the The Apple Compact Unwinding Format document
> >> (https://faultlore.com/blah/compact-unwinding/),
> >> "One consequence of only having one opcode for a whole function is tha=
t
> >> functions will generally have incorrect instructions for the function=
=E2=80=99s
> >> prologue (where callee-saved registers are individually PUSHed onto th=
e
> >> stack before the rest of the stack space is allocated)."
> >>
> >> "Presumably this isn=E2=80=99t a very big deal, since there=E2=80=99s =
very few
> >> situations where unwinding would involve a function still executing it=
s
> >> prologue/epilogue."
> >>
> >> Well, getting precise stack traces is a big deal and the users want th=
em.
> >
> > **Shrink-wrapping and precise stack traces**: Yes, compact unwind
> > handles these through an extension proposed by OpenVMS (not yet
> > upstreamed to LLVM):
> > https://lists.llvm.org/pipermail/llvm-dev/2018-January/120741.html
> >
>
> Thanks for the link.
>
> The above questions were strictly in the context of the battle-tested
> "The Apple Compact Unwinding Format" in production in the lld/MachO
> implementation, not for the proposed OpenVMS extensions.
>
> Is it possible to get answers to those questions with that context in pla=
ce?
>
> If shrink-wrapping and precise stack traces isnt supported without the
> OpenVMS extension (that is not yet implemented), arent we comparing
> apples vs pears here ?

You're right to ask for clarification.
The extended compact unwind information works with shrink wrapping.

For context, a FDE in .eh_frame costs at least 20 bytes (often 30+),
plus its associated .eh_frame_hdr entry costs 8 bytes.
Even a larger compact unwind descriptor at 8 bytes yields significant
savings compared to .eh_frame. Tripling that to 24 bytes is still a
substantial win.

Additionally, very few functions benefit from shrink wrapping
optimization. When needed, we require multiple unwind description
records (typically 3).

> > Technical details of the extension:
> >
> > - A single unwind group describes a (prologue_part1, prologue_part2,
> > body, epilogue) tuple.
> > - The prologue is conceptually split into two parts: the first part
> > extends up to and including the instruction that decreases RSP; the
> > second part extends to a point after the last preserved register is
> > saved but before any preserved register is modified (this location is
> > not unique, providing flexibility).
> >    + When unwinding in the prologue, the RSP register value can be
> > inferred from the PC and the set of saved registers.
> > - Since register restoration is idempotent (restoring preserved
> > registers multiple times during unwinding causes no harm), there is no
> > need to describe `pop $reg` sequences. The unwind group needs just one
> > bit to describe whether the 1-byte `ret` instruction is present.
>
> Is this true for the case of asynchronous stack tracing too ?

Yes. I believe it means the epilogue mirrors the prologue. Since we
know which registers were saved in the prologue, we can infer the pop
instructions in the epilogue and compute the SP offset when unwinding
in the middle of an epilogue.

> > - The `length` field in the compact unwind group descriptor is
> > repurposed to describe the prologue's two parts.
> > - By composing multiple unwind groups, potentially with zero-sized
> > prologues or omitting `ret` instructions in epilogues, it can describe
> > functions with shrink wrapping or tail duplication optimization.
> > - Null frame groups (with no prologue or epilogue) are the default and
> > can describe trampolines and PLT stubs.
>
> PLT stubs may use stack (push to stack). As per the document "A null
> frame (MODE =3D 8) is the simplest possible frame, with no allocated stac=
k
> of either kind (hence no saved registers)".  So null frame can be used
> for PLT only if the functions invoking the PLT stub were using an
> RBP-based frame.  Isnt it ?
> BTW, but both EH Frame and SFrame have specific, condensed
> representation for metadata for PLT entries.

A profiler can trivially retrieve the return address using the default
rule: if a code region is not covered by metadata, assume the return
address is available at *rsp (x86-64) or in the link register (most
other architectures).

This ld-generated unwind info feature is largely obsolete nowadays due
to the prevailing use of -Wl,-z,relro,-z,now (BIND_NOW). PLT entries
behave as functions without a prologue, so a profiler can trivially
retrieve the return address using the default unwinding rule.

> >
>
> Anyway, thanks for the summary.
>
> I see that OpenVMS extension for asynchronous compact unwind descriptors
> is an RFC state ATM.  But few important observations and questions:
>
>   - As noted in the recently revived discussion,
> https://discourse.llvm.org/t/rfc-improving-compact-x86-64-compact-unwind-=
descriptors/47471,
> there is going to be a *non-negligible* size overhead as soon as you
> move towards a specification for asynchronous (vs the current
> specification that caters to synchronous only).  Now add to it, the
> quirks of each architecture/ABI :). Any comments ?

As mentioned, even a larger compact unwind descriptor at 8 bytes
yields significant savings compared to .eh_frame, and is also
substantially smaller than SFrame.

>   - From the document: "Use of any preserved register must be delayed
> until all of the preserved registers have been saved."
>     Q: Does this work well with optimizing compilers ? Is this an ABI
> change being asked for multiple architectures ?

I think this is about support for callee-saved registers, a feature
SFrame doesn't have.

I need to think about the details, but this thread is probably not the
best place to discuss them.

>   - From the document: "It appears technically feasible for a null frame
> function to have a personality routine. However, the utility of such a
> capability seems too meager to justify allowing this. We propose to not
> support this." and "If the first attempt to lookup an unwind group for
> an exception address fails, then it is (tentatively) assumed to have
> occurred within a null frame function or in a part of a function
> that is adequately described by a null frame. The presumed return
> address is (virtually or actually) popped from the top of stack and
> looked up. This second attempted lookup must succeed, in which case
> processing continues normally. A failure is a fatal error."
>    Q: Is this a problem, especially because the goal is to evolve the
> OpenVMS RFC proposal is subsume .eh_frame ?

I think this just hard-encodes the default rule, similar to what
SFrame does: "AMD64 ABI mandates that the RA be saved at a fixed
offset from the CFA when entering a new function."

While I haven't given this much thought yet, I don't think this
introduces problems that SFrame doesn't have.

> Are there people actively working towards bringing this to fruition?
>
> > Now, to compare this against SFrame's space efficiency for synchronous
> > unwinding, I've built llvm-mc, opt, and clang with
> > -fno-asynchronous-unwind-tables -funwind-tables across multiple build
> > configurations (clang vs gcc, frame pointer vs sframe). The resulting
> > .sframe section sizes are significant:
> >
> > % cat ~/tmp/test-unwind.sh
> > #!/bin/zsh
> > conf() {
> >    configure-llvm $@ -DCMAKE_EXE_LINKER_FLAGS=3D'-pie
> > -Wl,-z,pack-relative-relocs' -DLLVM_ENABLE_UNWIND_TABLES=3Don \
> >      -DCMAKE_{EXE,SHARED}_LINKER_FLAGS=3D-fuse-ld=3Dbfd -DLLVM_ENABLE_L=
LD=3Doff
> > }
> >
> > clang=3D-fno-integrated-as
> > gcc=3D("-DCMAKE_C_COMPILER=3D$HOME/opt/gcc-15/bin/gcc"
> > "-DCMAKE_CXX_COMPILER=3D$HOME/opt/gcc-15/bin/g++")
> >
> > fp=3D"-fno-omit-frame-pointer -momit-leaf-frame-pointer
> > -B$HOME/opt/binutils/bin -Wa,--gsframe=3Dno
> > -fno-asynchronous-unwind-tables -funwind-tables"
> > sframe=3D"-fomit-frame-pointer -momit-leaf-frame-pointer
> > -B$HOME/opt/binutils/bin -Wa,--gsframe -fno-asynchronous-unwind-tables
> > -funwind-tables"
> >
> > conf custom-fp-sync -DCMAKE_{C,CXX}_FLAGS=3D"$clang $fp"
> > conf custom-sframe-sync -DCMAKE_{C,CXX}_FLAGS=3D"$clang $sframe"
> > conf custom-fp-gcc-sync -DCMAKE_{C,CXX}_FLAGS=3D"$fp" ${gcc[@]}
> > conf custom-sframe-gcc-sync -DCMAKE_{C,CXX}_FLAGS=3D"$sframe" ${gcc[@]}
> >
> > for i in fp-sync sframe-sync fp-gcc-sync sframe-gcc-sync; do ninja -C
> > /tmp/out/custom-$i llvm-mc opt clang; done
> >
> > % ~/Dev/unwind-info-size-analyzer/section_size.rb
> > /tmp/out/custom-{fp,sframe}-{,gcc-}sync/bin/{llvm-mc,opt,clang}
> > Filename                                    |       .text size |
> >   EH size |   .sframe size |   VM size | VM increase
> > --------------------------------------------+------------------+-------=
---------+----------------+-----------+------------
> > /tmp/out/custom-fp-sync/bin/llvm-mc         |  2124031 (23.5%) |
> > 301136 (3.3%) |       0 (0.0%) |   9050149 |           -
> > /tmp/out/custom-sframe-sync/bin/llvm-mc     |  2114383 (22.3%) |
> > 367452 (3.9%) |  348235 (3.7%) |   9483621 |       +4.8%
> > /tmp/out/custom-fp-gcc-sync/bin/llvm-mc     |  2744214 (29.2%) |
> > 301836 (3.2%) |       0 (0.0%) |   9389677 |       +3.8%
> > /tmp/out/custom-sframe-gcc-sync/bin/llvm-mc |  2705860 (27.7%) |
> > 354292 (3.6%) |  356073 (3.6%) |   9780985 |       +8.1%
> > /tmp/out/custom-fp-sync/bin/opt             | 38873081 (69.9%) |
> > 3538408 (6.4%) |       0 (0.0%) |  55598521 |           -
> > /tmp/out/custom-sframe-sync/bin/opt         | 39011423 (62.4%) |
> > 4557012 (7.3%) | 4452908 (7.1%) |  62494765 |      +12.4%
> > /tmp/out/custom-fp-gcc-sync/bin/opt         | 54654535 (78.1%) |
> > 3631076 (5.2%) |       0 (0.0%) |  70001573 |      +25.9%
> > /tmp/out/custom-sframe-gcc-sync/bin/opt     | 53644831 (70.4%) |
> > 4857220 (6.4%) | 5263530 (6.9%) |  76205733 |      +37.1%
> > /tmp/out/custom-fp-sync/bin/clang           | 68345753 (73.8%) |
> > 6643384 (7.2%) |       0 (0.0%) |  92638305 |           -
> > /tmp/out/custom-sframe-sync/bin/clang       | 68500319 (64.9%) |
> > 8684540 (8.2%) | 8521760 (8.1%) | 105572021 |      +14.0%
> > /tmp/out/custom-fp-gcc-sync/bin/clang       | 96515079 (82.8%) |
> > 6556756 (5.6%) |       0 (0.0%) | 116524565 |      +25.8%
> > /tmp/out/custom-sframe-gcc-sync/bin/clang   | 94583903 (74.0%) |
> > 8817628 (6.9%) | 9696263 (7.6%) | 127839309 |      +38.0%
> >
> > Note: in GCC FP builds, .text is larger due to missing optimization
> > for RBP-based frames (e.g.
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D108386). Once this
> > optimization is implemented, GCC FP builds should actually have
> > smaller .text than RSP-based builds, because RBP-relative addressing
> > produces more compact encodings than RSP-relative addressing (which
> > requires an extra SIB byte).
> >
> > .sframe for sync is not noticeably smaller than that for async. This
> > is probably because
> > there are still many DW_CFA_advance_loc ops even in
> > -fno-asynchronous-unwind-tables -funwind-tables builds.
> >
>
> Possible that its because in the Apple Compact Unwind Format, the linker
> optimizes compact unwind descriptors into the three-level paged
> structure, effectively de-duplicating some content.

Yes, the linker does perform deduplication and builds the paged index
structure. However, the fundamental compactness comes from the
encoding itself: each regular function is described with just 4 bytes
in the common encoding, compared to .sframe's much larger per-FDE
overhead.
The two-level lookup table optimization amplifies this advantage.

> >>>     (On macOS you can check the section size with objdump --arch x86_=
64 -
> >>> h clang and dump the unwind info with  objdump --arch x86_64 --unwind=
-
> >>> info clang)
> >>>
> >>> OpenVMS's x86-64 port, which is ELF-based, also adopted this format a=
s
> >>> documented in their "VSI OpenVMS Calling Standard" and their 2018 pos=
t:
> >>> https://discourse.llvm.org/t/rfc-asynchronous-unwind-tables-attribute=
/59282
> >>>
> >>> The compact unwind format achieves this efficiency through a two-leve=
l
> >>> page table structure. It describes common frame layouts compactly and
> >>> falls back to DWARF only when necessary, allowing most DWARF CFI entr=
ies
> >>> to be eliminated while maintaining full functionality. For more detai=
ls,
> >>> see: https://faultlore.com/blah/compact-unwinding/ and the lld/MachO
> >>> implemention https://github.com/llvm/llvm-project/blob/main/lld/MachO=
/
> >>> UnwindInfoSection.cpp
> >>>
> >>
> >> How does your vision of "linker-friendly" stack tracing/stack unwindin=
g
> >> format reconcile with these suggested approaches ? As far as I can tel=
l,
> >> these formats also require linker created indexes and are
> >> non-concatenable (custom handling in every linker).  Something you've
> >> had "significant concerns" about.
> >>
>
> This question is unanswered: What do you think about
> "linker-friendliness" of the current implementation of the lld/MachO
> implementation of the compact unwind format in LLVM ?

The linker input and output use different section names, so a dumb
linker would work as long as the runtime accepts the concatenated
sections.

My vision for an ELF compact unwind format uses separate section names
for link-time vs. runtime representations. The compiler output format
should be concatenable, with linker index-building as an optional
optimization that improves performance but isn't mandatory for
correctness.

I'll going to add more details
https://maskray.me/blog/2025-09-28-remarks-on-sframe


> >
> > We can distinguish between linking-time and execution-time
> > representations by using different section names.
> > The OpenVMS specification says:
> >
> >      It is useful to note that the run-time representation of unwind
> > information can vary from little more than a simple concatenation of
> > the compile-time information to a substantial rewriting of unwind
> > information by the linker. The proposal favors simple concatenation
> > while maintaining the same ordering of groups as their associated
> > code.
> >
> > The runtime library can build this index at runtime and cache it to dis=
k.
> >
>
> This will include the dynamic linker and the stack tracer in the Linux
> kernel (the latter when stack tracing user space stacks).  Do you think
> this is feasible ?
>
> > Once the design becomes sufficiently stable, we can introduce an
> > opt-in linker option --xxxxframe-index that builds an index from
> > recognized format versions while reporting warnings for unrecognized
> > ones.> We need to carefully design this mechanism to be stable and robu=
st,
> > avoiding frequent format updates.
> > >>   From
> >> https://docs.vmssoftware.com/vsi-openvms-calling-standard/#STACK_UNWIN=
D_EXCEPTION_X86_64:
> >> "The unwind dispatch table (see Section B.3.1, ''Unwind Dispatch
> >> Table'') is created by the linker using information in the unwind
> >> descriptors (see Section B.3.2, ''DWARF Unwind Descriptors'' and Secti=
on
> >> B.3.3, ''Compact Unwind Description'') provided by compilers. The link=
er
> >> may use the provided unwind descriptors directly or replace them with
> >> equivalent optimized forms based on its optimization strategies."
> >>
> >> Above all, do users want a solution which requires falling back on
> >> DWARF-based processing for precise stack tracing ?
> >
> > The key distinction is that compact unwind handles the vast majority
> > of functions without DWARF=E2=80=94the macOS measurements show __unwind=
_info
> > at 0.6% of __text size with __eh_frame reduced to negligible size
> > (0x58 bytes). While SFrame also cannot handle all frames, compact
> > unwind achieves dramatic size reductions by making DWARF the exception
> > rather than requiring it alongside a supplementary format.
> >
>
> As we have tried to reason, this is a misleading comparison. The compact
> unwind tables format:
>    - needs to be extended for asynchronous stack unwinding
>    - needs to be extended for other ABI/architectures
>    - Making it concatenable / linker-friendly will also likely impose
> some negative effects on size.

The format supports i386, x86-64, aarch32, and aarch64. The OpenVMS
proposal demonstrates that supporting asynchronous unwinding is
straightforward.

Making it linker-friendly does not impose negative effects on the
output section size.

> > The DWARF fallback provides flexibility for additional coverage when
> > needed, but nothing is lost (at least for the clang binary on macOS)
> > if DWARF fallback were disabled in a hypothetical future linux-perf
> > implementation.
> >
>
> Fair enough, thats something for linux-perf/kernel to decide.  Once the
> OpenVMS RFC is sufficiently shaped to become a viable replacement for
> .eh_frame, this question will be for the stakeholders to decide.

Agreed. My concern is that .sframe is being deployed before we've
fully explored whether a more compact and efficient alternative is
achievable.


> >>> **The AArch64 case: size matters even more**
> >>>
> >>> The size consideration becomes even more critical for AArch64, which =
is
> >>> heavily deployed on mobile phones.
> >>> There's an active feature request for compact unwind support in the
> >>> AArch64 ABI: https://github.com/ARM-software/abi-aa/issues/344
> >>> This underscores the broader industry need for efficient unwind
> >>> information that doesn't duplicate data or significantly increase bin=
ary
> >>> size.
> >>>
> >>
> >> Our measurements with a dataset of about 1400 userspace artifacts
> >> (binaries and shared libraries) show that the SFrame/(EH Frame + EH
> >> Frame HDR) ratio is:
> >>     - Average of 0.70 on AArch64.
> >>     - Average of 1.00 on x86_64.
> >>
> >> Projecting the size of what you observe for clang binary on x86_64 to
> >> conclude the size ratio on AArch64 is not very wise to do.
> >>
> >> Whether the size impact is worth the benefit: its a choice for users t=
o
> >> make.  SFrame offers the users fast, precise stack traces with simple
> >> stack tracers.
> >
> > Thank you for providing the AArch64 measurements. Even with a 0.70x rat=
io on
> > AArch64, this represents substantial memory overhead when considering:
> >
> > .eh_frame is already large and being complained about.
> > Being unable to eliminate it (needed for debugging and C++ exceptions)
> > and adding 0.70x more means significant additional overhead for users.
> >
> >>> There are at least two formats the ELF one can learn from: LLVM's
> >>> compact unwind format (aarch64) and Windows ARM64 Frame Unwind Code.
> >>>
> >>
> >> Please, if you have any concrete suggestions (keeping the above goals =
in
> >> mind), you already know how/where to engage.
> >
> > I've provided concrete suggestions throughout this discussion.
> >
>
> Apologies, I should have been more precise.  And I ask because you know
> the details about both SFrame and the variants of Compact Unwind
> Descriptor formats at this point :). If you have concrete suggestions to
> improve the SFrame format for size, please let us know.

At this point, I'm not certain about specific modifications to .sframe
itself. I think we should start from scratch, drawing ideas from
compact unwind information and Windows ARM64.

The existing compact unwind information uses the following 4-byte descripto=
r:

  uint32_t mode_specific_encoding : 24; // vary with different modes

  uint32_t mode : 4; // UNWIND_X86_64_MODE_MASK =3D=3D UNWIND_ARM64_MODE_MA=
SK

  uint32_t has_lsda : 1;
  uint32_t personality_index : 2;
  uint32_t is_not_function_start : 1;

We probably need a less-restricted version and account for different
architecture needs. The result would still be significantly smaller
than SFrame v2 and the future v3 (unless it's completely rewritten).

We should probably design an optional two-level lookup table mechanism
for additional savings (at the cost of linker friendliness).

> >>> **Path forward**
> >>>
> >>> Unless SFrame can actually replace .eh_frame (rather than supplementi=
ng
> >>> it as an accelerator for linux-perf) and demonstrate sizes smaller
> >>> than .eh_frame - matching the efficiency of existing compact unwind
> >>> approaches =E2=80=94 I question its practical viability for userspace=
.
> >>> The current design appears to add overhead rather than reduce it.
> >>> This isn't to suggest we should simply adopt the existing compact unw=
ind
> >>> format wholesale.
> >>> The x86-64 design dates back to 2009 or earlier, and there are likely
> >>> improvements we can make. However, we should aim for similar or bette=
r
> >>> efficiency gains.
> >>>
> >>> For additional context, I've documented my detailed analysis at:
> >>>
> >>> - https://maskray.me/blog/2025-09-28-remarks-on-sframe (covering
> >>> mandatory index building problems, section group compliance and garba=
ge
> >>> collection issues, and version compatibility challenges)
> >>
> >> GC issue is a bug currently tracked and with a target milestone of 2.4=
6.
> >>> - https://maskray.me/blog/2025-10-26-stack-walking-space-and-time-tra=
de-
> >>> offs (size analysis)
> >>>

The GC issue would not have happened at all if we had used multiple
sections and thought about ELF and linker convention :)
