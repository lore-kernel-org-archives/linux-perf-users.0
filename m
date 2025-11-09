Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE01266A7
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Nov 2025 00:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762647772; cv=none; b=A7JDUGkOuysxHZOG21iwf6LIC9G4hnDNyNFYNJCIEiIy7JgTppVK2n5J1mn2UjKYLMS3iqdlBSigZHo7q/rmZNwX7L0qWTW84cgiHBjZuFmWAwydj/E0oB/ZZ1vCcAJSxR9WvdJMjmzbv1oPU00vlo1UMM8XZkfmrpWaph8Y5aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762647772; c=relaxed/simple;
	bh=laCXYFNKClk2vMrOMSAfhVTxD6cj8PjJ9q3Y5/vLmNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cu4LVHKVn8DfLCLUT/1rbT9G13GKWq7mOR6MbVVG03ULw5Qg1mkkbi5PrTf5c4KJQrFRH+Q3ckNs9jgLMm2LyN4rJvjSi+H5HHEDdROOVh4TOKWeOuMx9mR6PHRgbQGXSEzrkLZA8SKc+VaEoNnGpj80jzKg8f14TrVCjlJwvxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-934fb15ee9dso518953241.1
        for <linux-perf-users@vger.kernel.org>; Sat, 08 Nov 2025 16:22:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762647769; x=1763252569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9XYdYgVF/uHSNzaAK6YxriT2SefpaY3pB8an1quYvMQ=;
        b=bawXyB9kymJs/1Gmrq6lrpY21MaksTIgOfGBWQY3rKWPPYuDFJ7I9JHvFXEyhd8X4R
         u8zjJblnCacHp5GuvxP1l/NVdhIo3jk/kWd/VmHTOG02gxSfg63EevKpkvFs9SDs+mUO
         j3Z1N7SQebV3QMROpTtQ221Mjoxgfj6VKCdQ8PdTSArt0kAjOx/ceajaNS0sbfPikk8t
         zBKaiFSLuyBkFfFS8+dEWDYCbOPQlVjjCeJxKLPdFVaEsH+FAh7SnXDM6ChmzJQFgTPi
         A0COaT06PBqzBi4V5lM7b8GX6yhlHnPNnp3D3zl6DyejD5uA+tM9VlInfou4NyyLSRaG
         Owew==
X-Forwarded-Encrypted: i=1; AJvYcCWIZVgDz+WFRVQIO3b/iuqPEKdAvqtDPxJWb//mkNhdfVX/JF8sccdDCj38dJAMPgJF2EnlzJlOS7uwnDDfOMH7@vger.kernel.org
X-Gm-Message-State: AOJu0YyxprqbRXzH7zvNXJaIxCDXeXs758Rau4QjSD0nshEXQUrqVxdQ
	c/oIqlUJzuUOLuRKj5cuHd0izbtqartdysvKVsEXTqqANezrwzWPHBg2ejSTkA==
X-Gm-Gg: ASbGncu5Lo6l0qzduQTxeKEPow6Dibnenv2d4GRYnUZAtGOg/LQgLvkucLs6T2nDRIG
	5Oj9dFiR5xphtMY2Xj3rQfZbiX3dGQWEhI0KsMAcGx0cZ9CqrV7ggu7AIr1qAYQB/WZqzQaAhje
	4GkvygBnqofIHl4+amH73SHqoeEYtjzhR/opFpz4o4kZ+LMgZHBB0AOj8LQ1Ah8UpP6V7prxpWS
	69L7bSR5EMFvNikeFFSbnqsLNS1LiRv1xGS+mEE6nXvNbJqn6e1s0sO32UtJtDW1qB1s/zuHS0B
	GtxSaEZMuidWHL+oGzdpEbv6s0yS2K9j0hGDE3P7T4RP8veDjGXMMwjHZptL00CJBXzJALPt55o
	I9LzNLDA2JbQpBG1hEv+MeXFPfX1/a6p6R6x9CH8fCuNkA5IPhtxcDI92oKyFQOpFSiVyf4ckyV
	6oQH+OuEw4327z1Y7hGCt37sv8JpYBcBgQUi+7vIf4LWakv9WAdJU0rQ8=
X-Google-Smtp-Source: AGHT+IFhMQATO+DLEIHWAZQLZG20gMMczY90bsS/D2Xuac8ythAwZRatNZuAUCrp6NGVcjwKkGWeqg==
X-Received: by 2002:a05:6102:162b:b0:524:3e12:6590 with SMTP id ada2fe7eead31-5ddc46aef4dmr989673137.14.1762647768642;
        Sat, 08 Nov 2025 16:22:48 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-559958285f4sm5067495e0c.18.2025.11.08.16.22.48
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Nov 2025 16:22:48 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5599688d06dso453427e0c.2
        for <linux-perf-users@vger.kernel.org>; Sat, 08 Nov 2025 16:22:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1B1Qy9C4IngO+enXdntA5FPsZlQtTYl+uS25RqptYJVIeWUqdhSgv1YvLFa5DpNSpKPMQnIwId3pcXau5GO1D@vger.kernel.org
X-Received: by 2002:a05:6122:1d01:b0:54a:1e96:e958 with SMTP id
 71dfb90a1353d-559b31510b0mr1229441e0c.0.1762647768096; Sat, 08 Nov 2025
 16:22:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
 <2d713719-709d-4b46-8234-2dfe948b836a@oracle.com> <CAN30aBGEpwA+ZROXufqBL6MHM70oWTtNpGSioCMhxT8yS2t-Pg@mail.gmail.com>
 <9c11b765-66df-46f3-b4ea-a0c7f52dac35@oracle.com> <CAN30aBGX+CuPmPGRjzpRT69pP0QJc_zBAr69RqnMUZ-OXF=t1A@mail.gmail.com>
 <18064090-3418-4005-b35e-1afaeb2b4c95@oracle.com>
In-Reply-To: <18064090-3418-4005-b35e-1afaeb2b4c95@oracle.com>
From: Fangrui Song <maskray@sourceware.org>
Date: Sat, 8 Nov 2025 16:23:03 -0800
X-Gmail-Original-Message-ID: <CAN30aBEN_4Q1gAqh5=6OXXw4BvnmeV41RQCyjm1p1r07ki=FEw@mail.gmail.com>
X-Gm-Features: AWmQ_blboxfhOnP4ELA0qNCG6wCEf-xH4mGfSgHWedj3hgdvgqKee4h_Nkjr3Ek
Message-ID: <CAN30aBEN_4Q1gAqh5=6OXXw4BvnmeV41RQCyjm1p1r07ki=FEw@mail.gmail.com>
Subject: Re: Concerns about SFrame viability for userspace stack walking
To: Indu Bhagat <indu.bhagat@oracle.com>
Cc: Fangrui Song <maskray@sourceware.org>, linux-toolchains@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 12:42=E2=80=AFPM Indu Bhagat <indu.bhagat@oracle.com=
> wrote:
>
> On 11/6/25 1:20 AM, Fangrui Song wrote:
> > On Wed, Nov 5, 2025 at 4:45=E2=80=AFPM Indu Bhagat <indu.bhagat@oracle.=
com> wrote:
> >>
> >> On 11/5/25 12:21 AM, Fangrui Song wrote:
> >>>> On Tue, Nov 4, 2025 at 1:21=E2=80=AFAM Indu <indu.bhagat@oracle.com>=
 wrote:
> >>>> On 2025-10-29 11:53 p.m., Fangrui Song wrote:
> >>>>> I've been following the SFrame discussion and wanted to share some
> >>>>> concerns about its viability for userspace adoption, based on concr=
ete
> >>>>> measurements and comparison with existing compact unwind implementa=
tions
> >>>>> in LLVM.
> >>>>>
> >>>>> **Size overhead concerns**
> >>>>>
> >>>>> Measurements on a x86-64 clang binary show that .sframe (8.87 MiB) =
is
> >>>>> approximately 10% larger than the combined size of .eh_frame
> >>>>> and .eh_frame_hdr (8.06 MiB total).
> >>>>> This is problematic because .eh_frame cannot be eliminated - it con=
tains
> >>>>> essential information for restoring callee-saved registers, LSDA, a=
nd
> >>>>> personality information needed for debugging (e.g. reading local
> >>>>> variables in a coredump) and C++ exception handling.
> >>>>>
> >>>>> This means adopting SFrame would result in carrying both formats, w=
ith a
> >>>>> large net size increase.
> >>>>>
> >>>>> **Learning from existing compact unwind implementations**
> >>>>>
> >>>>> It's worth noting that LLVM has had a battle-tested compact unwind
> >>>>> format in production use since 2009 with OS X 10.6, which transitio=
ned
> >>>>> to using CFI directives in 2013 [1]. The efficiency gains are drama=
tic:
> >>>>>
> >>>>>      __text section: 0x4a55470 bytes
> >>>>>      __unwind_info section: 0x79060 bytes (0.6% of __text)
> >>>>>      __eh_frame section: 0x58 bytes
> >>>>>
> >>>>
> >>>> I believe this is only synchronous? If yes, do you think this is a f=
air
> >>>> measurement to compare against ?
> >>>>
> >>>> Does the compact unwind info scheme work well for cases of
> >>>> shrink-wrapping ? How about the case of AArch64, where the ABI does =
not
> >>>> mandate if and where frame record is created ?
> >>>>
> >>>> For the numbers above, does it ensure precise stack traces ?
> >>>>
> >>>>    From the The Apple Compact Unwinding Format document
> >>>> (https://faultlore.com/blah/compact-unwinding/),
> >>>> "One consequence of only having one opcode for a whole function is t=
hat
> >>>> functions will generally have incorrect instructions for the functio=
n=E2=80=99s
> >>>> prologue (where callee-saved registers are individually PUSHed onto =
the
> >>>> stack before the rest of the stack space is allocated)."
> >>>>
> >>>> "Presumably this isn=E2=80=99t a very big deal, since there=E2=80=99=
s very few
> >>>> situations where unwinding would involve a function still executing =
its
> >>>> prologue/epilogue."
> >>>>
> >>>> Well, getting precise stack traces is a big deal and the users want =
them.
> >>>
> >>> **Shrink-wrapping and precise stack traces**: Yes, compact unwind
> >>> handles these through an extension proposed by OpenVMS (not yet
> >>> upstreamed to LLVM):
> >>> https://lists.llvm.org/pipermail/llvm-dev/2018-January/120741.html
> >>>
> >>
> >> Thanks for the link.
> >>
> >> The above questions were strictly in the context of the battle-tested
> >> "The Apple Compact Unwinding Format" in production in the lld/MachO
> >> implementation, not for the proposed OpenVMS extensions.
> >>
> >> Is it possible to get answers to those questions with that context in =
place?
> >>
> >> If shrink-wrapping and precise stack traces isnt supported without the
> >> OpenVMS extension (that is not yet implemented), arent we comparing
> >> apples vs pears here ?
> >
> > You're right to ask for clarification.
> > The extended compact unwind information works with shrink wrapping.
> >
>
> Sorry, again, not asking about the "extended".
>
> If I may: So, this is a convoluted way of saying the current
> implementation of the Apple Compact Unwind Info (lld/MachO, which was
> used to get the data) does not support shrink wrapping.  The
> documentation of the format I am refering to
> (https://faultlore.com/blah/compact-unwinding/).
>
> That said, the point I have been driving to:
>
> The Apple Compact Unwind format
> (https://faultlore.com/blah/compact-unwinding/) does not support shrink
> wrapping and neither is for asynchronous stack walking.  Comparing that
> data to what SFrame gives is comparing apples to pears.  Misleading.
>
> (The reason I asked the question to begin with is because I wasn't sure
> if the documentation is out of date).

The original compact unwind information implementation was designed in
2009, before
shrink wrapping was implemented in LLVM in 2015. It is definitely not
fully asynchronous
as it lacks information about the epilogue. When unwinding in the
middle of the prologue,
one can recover partial information leveraging the prologue codegen
pattern, probably good enough to recover
SP in the absence of shrink wrapping.

While there are limitations, it does not mean we cannot yield useful
data from it.

In a x86-64 build of clang-21, there is one single CIE and 141845 FDEs.
The average size of a FDE is: (0x733348 - 0x18) / 141845 ~=3D 52.225
(0x18 is the first FDE offset in llvm-dwarfdump -eh-frame output).

Considering .eh_frame_hdr entry, per-function size is around 52.225+8 =3D 6=
0.225.

The .sframe V2 per-function size is 0x820820 / 141845 ~=3D 60.078.

On LLVM Discourse we are discussing the next generation of compact
unwind information,
which will support at least asynchronous stack tracing (the SFrame
feature subset) and synchronous C++ exceptions.
We aim to provide a per-entry size of 12 bytes.
The average number of entries per function is likely between 1 and 2,
making the scheme very size-efficient even without utilizing page
table deduplication.

> > For context, a FDE in .eh_frame costs at least 20 bytes (often 30+),
> > plus its associated .eh_frame_hdr entry costs 8 bytes.
> > Even a larger compact unwind descriptor at 8 bytes yields significant
> > savings compared to .eh_frame. Tripling that to 24 bytes is still a
> > substantial win.
> >
> > Additionally, very few functions benefit from shrink wrapping
> > optimization. When needed, we require multiple unwind description
> > records (typically 3).
> >
> >>> Technical details of the extension:
> >>>
> >>> - A single unwind group describes a (prologue_part1, prologue_part2,
> >>> body, epilogue) tuple.
> >>> - The prologue is conceptually split into two parts: the first part
> >>> extends up to and including the instruction that decreases RSP; the
> >>> second part extends to a point after the last preserved register is
> >>> saved but before any preserved register is modified (this location is
> >>> not unique, providing flexibility).
> >>>     + When unwinding in the prologue, the RSP register value can be
> >>> inferred from the PC and the set of saved registers.
> >>> - Since register restoration is idempotent (restoring preserved
> >>> registers multiple times during unwinding causes no harm), there is n=
o
> >>> need to describe `pop $reg` sequences. The unwind group needs just on=
e
> >>> bit to describe whether the 1-byte `ret` instruction is present.
> >>
> >> Is this true for the case of asynchronous stack tracing too ?
> >
> > Yes. I believe it means the epilogue mirrors the prologue. Since we
> > know which registers were saved in the prologue, we can infer the pop
> > instructions in the epilogue and compute the SP offset when unwinding
> > in the middle of an epilogue.
> >
>
> This is not asynchronous then.
> This meddles with the core business of an optimizing compiler which may
> want to organize epilogue/prologue differently.

Asynchronous as far as the compiler-generated patterns are concerned.
Compilers do exhibit the patterns and we should utilize them, aiming
for a compact format.
We are trying to lift the restriction as much as possible when
designing the new format.

> >>> - The `length` field in the compact unwind group descriptor is
> >>> repurposed to describe the prologue's two parts.
> >>> - By composing multiple unwind groups, potentially with zero-sized
> >>> prologues or omitting `ret` instructions in epilogues, it can describ=
e
> >>> functions with shrink wrapping or tail duplication optimization.
> >>> - Null frame groups (with no prologue or epilogue) are the default an=
d
> >>> can describe trampolines and PLT stubs.
> >>
> >> PLT stubs may use stack (push to stack). As per the document "A null
> >> frame (MODE =3D 8) is the simplest possible frame, with no allocated s=
tack
> >> of either kind (hence no saved registers)".  So null frame can be used
> >> for PLT only if the functions invoking the PLT stub were using an
> >> RBP-based frame.  Isnt it ?
> >> BTW, but both EH Frame and SFrame have specific, condensed
> >> representation for metadata for PLT entries.
> >
> > A profiler can trivially retrieve the return address using the default
> > rule: if a code region is not covered by metadata, assume the return
> > address is available at *rsp (x86-64) or in the link register (most
> > other architectures).
> >
> > This ld-generated unwind info feature is largely obsolete nowadays due
> > to the prevailing use of -Wl,-z,relro,-z,now (BIND_NOW). PLT entries
> > behave as functions without a prologue, so a profiler can trivially
> > retrieve the return address using the default unwinding rule.
> >
> >>>
> >>
> >> Anyway, thanks for the summary.
> >>
> >> I see that OpenVMS extension for asynchronous compact unwind descripto=
rs
> >> is an RFC state ATM.  But few important observations and questions:
> >>
> >>    - As noted in the recently revived discussion,
> >> https://discourse.llvm.org/t/rfc-improving-compact-x86-64-compact-unwi=
nd-descriptors/47471,
> >> there is going to be a *non-negligible* size overhead as soon as you
> >> move towards a specification for asynchronous (vs the current
> >> specification that caters to synchronous only).  Now add to it, the
> >> quirks of each architecture/ABI :). Any comments ?
> >
> > As mentioned, even a larger compact unwind descriptor at 8 bytes
> > yields significant savings compared to .eh_frame, and is also
> > substantially smaller than SFrame.
> >
> >>    - From the document: "Use of any preserved register must be delayed
> >> until all of the preserved registers have been saved."
> >>      Q: Does this work well with optimizing compilers ? Is this an ABI
> >> change being asked for multiple architectures ?
> >
> > I think this is about support for callee-saved registers, a feature
> > SFrame doesn't have.
> >
>
> SFrame doesn't have it, because it doesnt need to carry this information
> for stack tracing. OpenVMS RFC effort, OTOH, is about subsuming
> .eh_frame and be _the_ stack tracing/stack unwinding format.  The latter
> *has to* work this out.

This stance puts SFrame in a very narrow niche.
Per-function unwind info of 120 bytes (EH+SFrame: 60+60) far exceeds the si=
ze
the next-generation compact unwind information aims to achieve (likely
<24 bytes even without using a page table).

I believe the potential of the next-generation compact unwind
information is clear. For this reason, I urge performance maintainers
not to rush the integration of sframe v3 support.
If these architectural design issues of SFrame aren't resolved
beforehand, we risk launching a format that very few people will
actually use.


> > I need to think about the details, but this thread is probably not the
> > best place to discuss them.
> >
>
> Absolutely, I agree, not the best place or time to pin down the details
> of an RFC at all.  But cannot let an unfair argument just fly by.
>
> The point I am driving to with these questions around the OpenVMS
> asynchronous info RFC:
> - 'OpenVMS extensions for asynchronous stack unwinding' in an RFC which
> still needs work.
> - It remains to be seen how this proposal manages the fine line of
> space-efficiency while trying to be the goto format for asynchronous
> stack unwinding together with fast, precise and low-overhead stack tracin=
g.
> - SFrame is for stack tracing only.  Subsuming .eh_frame is not in the
> plans.
>
> >>    - From the document: "It appears technically feasible for a null fr=
ame
> >> function to have a personality routine. However, the utility of such a
> >> capability seems too meager to justify allowing this. We propose to no=
t
> >> support this." and "If the first attempt to lookup an unwind group for
> >> an exception address fails, then it is (tentatively) assumed to have
> >> occurred within a null frame function or in a part of a function
> >> that is adequately described by a null frame. The presumed return
> >> address is (virtually or actually) popped from the top of stack and
> >> looked up. This second attempted lookup must succeed, in which case
> >> processing continues normally. A failure is a fatal error."
> >>     Q: Is this a problem, especially because the goal is to evolve the
> >> OpenVMS RFC proposal is subsume .eh_frame ?
> >
> > I think this just hard-encodes the default rule, similar to what
> > SFrame does: "AMD64 ABI mandates that the RA be saved at a fixed
> > offset from the CFA when entering a new function."
> >
> > While I haven't given this much thought yet, I don't think this
> > introduces problems that SFrame doesn't have.
> >
>
> Correction: Not true. This is configurable in SFrame. s390x needs RA
> tracking (not fixed offset) and is supported in SFrame.

A hypothetical s390x implementation of the compact unwind information
can reserve 1 bit (in the mode-specific-encoding, or "opcodes" in
https://faultlore.com/blah/compact-unwinding/ ) to indicate whether
the RA is saved in a stack slot or a register.

> >> Are there people actively working towards bringing this to fruition?
> >>
> >>> Now, to compare this against SFrame's space efficiency for synchronou=
s
> >>> unwinding, I've built llvm-mc, opt, and clang with
> >>> -fno-asynchronous-unwind-tables -funwind-tables across multiple build
> >>> configurations (clang vs gcc, frame pointer vs sframe).
> >>> [snip]>>>
> >>> .sframe for sync is not noticeably smaller than that for async. This
> >>> is probably because
> >>> there are still many DW_CFA_advance_loc ops even in
> >>> -fno-asynchronous-unwind-tables -funwind-tables builds.
> >>>
> >>
> >> Possible that its because in the Apple Compact Unwind Format, the link=
er
> >> optimizes compact unwind descriptors into the three-level paged
> >> structure, effectively de-duplicating some content.
> >
> > Yes, the linker does perform deduplication and builds the paged index
> > structure. However, the fundamental compactness comes from the
> > encoding itself: each regular function is described with just 4 bytes
> > in the common encoding, compared to .sframe's much larger per-FDE
> > overhead.
> > The two-level lookup table optimization amplifies this advantage.
> >
> >>>>>      (On macOS you can check the section size with objdump --arch x=
86_64 -
> >>>>> h clang and dump the unwind info with  objdump --arch x86_64 --unwi=
nd-
> >>>>> info clang)
> >>>>>
> >>>>> OpenVMS's x86-64 port, which is ELF-based, also adopted this format=
 as
> >>>>> documented in their "VSI OpenVMS Calling Standard" and their 2018 p=
ost:
> >>>>> https://discourse.llvm.org/t/rfc-asynchronous-unwind-tables-attribu=
te/59282
> >>>>>
> >>>>> The compact unwind format achieves this efficiency through a two-le=
vel
> >>>>> page table structure. It describes common frame layouts compactly a=
nd
> >>>>> falls back to DWARF only when necessary, allowing most DWARF CFI en=
tries
> >>>>> to be eliminated while maintaining full functionality. For more det=
ails,
> >>>>> see: https://faultlore.com/blah/compact-unwinding/ and the lld/Mach=
O
> >>>>> implemention https://github.com/llvm/llvm-project/blob/main/lld/Mac=
hO/
> >>>>> UnwindInfoSection.cpp
> >>>>>
> >>>>
> >>>> How does your vision of "linker-friendly" stack tracing/stack unwind=
ing
> >>>> format reconcile with these suggested approaches ? As far as I can t=
ell,
> >>>> these formats also require linker created indexes and are
> >>>> non-concatenable (custom handling in every linker).  Something you'v=
e
> >>>> had "significant concerns" about.
> >>>>
> >>
> >> This question is unanswered: What do you think about
> >> "linker-friendliness" of the current implementation of the lld/MachO
> >> implementation of the compact unwind format in LLVM ?
> >
> > The linker input and output use different section names, so a dumb
> > linker would work as long as the runtime accepts the concatenated
> > sections.
> >
> > My vision for an ELF compact unwind format uses separate section names
> > for link-time vs. runtime representations. The compiler output format
> > should be concatenable, with linker index-building as an optional
> > optimization that improves performance but isn't mandatory for
> > correctness.
> >
> > I'll going to add more details
> > https://maskray.me/blog/2025-09-28-remarks-on-sframe
> >
> >
> >>>
> >>> We can distinguish between linking-time and execution-time
> >>> representations by using different section names.
> >>> The OpenVMS specification says:
> >>>
> >>>       It is useful to note that the run-time representation of unwind
> >>> information can vary from little more than a simple concatenation of
> >>> the compile-time information to a substantial rewriting of unwind
> >>> information by the linker. The proposal favors simple concatenation
> >>> while maintaining the same ordering of groups as their associated
> >>> code.
> >>>
> >>> The runtime library can build this index at runtime and cache it to d=
isk.
> >>>
> >>
> >> This will include the dynamic linker and the stack tracer in the Linux
> >> kernel (the latter when stack tracing user space stacks).  Do you thin=
k
> >> this is feasible ?
> >>
> >>> Once the design becomes sufficiently stable, we can introduce an
> >>> opt-in linker option --xxxxframe-index that builds an index from
> >>> recognized format versions while reporting warnings for unrecognized
> >>> ones.> We need to carefully design this mechanism to be stable and ro=
bust,
> >>> avoiding frequent format updates.
> >>>>>    From
> >>>> https://docs.vmssoftware.com/vsi-openvms-calling-standard/#STACK_UNW=
IND_EXCEPTION_X86_64:
> >>>> "The unwind dispatch table (see Section B.3.1, ''Unwind Dispatch
> >>>> Table'') is created by the linker using information in the unwind
> >>>> descriptors (see Section B.3.2, ''DWARF Unwind Descriptors'' and Sec=
tion
> >>>> B.3.3, ''Compact Unwind Description'') provided by compilers. The li=
nker
> >>>> may use the provided unwind descriptors directly or replace them wit=
h
> >>>> equivalent optimized forms based on its optimization strategies."
> >>>>
> >>>> Above all, do users want a solution which requires falling back on
> >>>> DWARF-based processing for precise stack tracing ?
> >>>
> >>> The key distinction is that compact unwind handles the vast majority
> >>> of functions without DWARF=E2=80=94the macOS measurements show __unwi=
nd_info
> >>> at 0.6% of __text size with __eh_frame reduced to negligible size
> >>> (0x58 bytes). While SFrame also cannot handle all frames, compact
> >>> unwind achieves dramatic size reductions by making DWARF the exceptio=
n
> >>> rather than requiring it alongside a supplementary format.
> >>>
> >>
> >> As we have tried to reason, this is a misleading comparison. The compa=
ct
> >> unwind tables format:
> >>     - needs to be extended for asynchronous stack unwinding
> >>     - needs to be extended for other ABI/architectures
> >>     - Making it concatenable / linker-friendly will also likely impose
> >> some negative effects on size.
> >
> > The format supports i386, x86-64, aarch32, and aarch64. The OpenVMS
> > proposal demonstrates that supporting asynchronous unwinding is
> > straightforward.
> >
> > Making it linker-friendly does not impose negative effects on the
> > output section size.
> >
>
> OK, well, I agree to disagree :)
>
> Looking forward to some movement on the OpenVMS asynchronous unwind RFC
> to see resolution to some of the issues, and some data to back that claim=
.
>
> >>> The DWARF fallback provides flexibility for additional coverage when
> >>> needed, but nothing is lost (at least for the clang binary on macOS)
> >>> if DWARF fallback were disabled in a hypothetical future linux-perf
> >>> implementation.
> >>>
> >>
> >> Fair enough, thats something for linux-perf/kernel to decide.  Once th=
e
> >> OpenVMS RFC is sufficiently shaped to become a viable replacement for
> >> .eh_frame, this question will be for the stakeholders to decide.
> >
> > Agreed. My concern is that .sframe is being deployed before we've
> > fully explored whether a more compact and efficient alternative is
> > achievable.
> >
> >
> >>>>> **The AArch64 case: size matters even more**
> >>>>>
> >>>>> The size consideration becomes even more critical for AArch64, whic=
h is
> >>>>> heavily deployed on mobile phones.
> >>>>> There's an active feature request for compact unwind support in the
> >>>>> AArch64 ABI: https://github.com/ARM-software/abi-aa/issues/344
> >>>>> This underscores the broader industry need for efficient unwind
> >>>>> information that doesn't duplicate data or significantly increase b=
inary
> >>>>> size.
> >>>>>
> >>>>
> >>>> Our measurements with a dataset of about 1400 userspace artifacts
> >>>> (binaries and shared libraries) show that the SFrame/(EH Frame + EH
> >>>> Frame HDR) ratio is:
> >>>>      - Average of 0.70 on AArch64.
> >>>>      - Average of 1.00 on x86_64.
> >>>>
> >>>> Projecting the size of what you observe for clang binary on x86_64 t=
o
> >>>> conclude the size ratio on AArch64 is not very wise to do.
> >>>>
> >>>> Whether the size impact is worth the benefit: its a choice for users=
 to
> >>>> make.  SFrame offers the users fast, precise stack traces with simpl=
e
> >>>> stack tracers.
> >>>
> >>> Thank you for providing the AArch64 measurements. Even with a 0.70x r=
atio on
> >>> AArch64, this represents substantial memory overhead when considering=
:
> >>>
> >>> .eh_frame is already large and being complained about.
> >>> Being unable to eliminate it (needed for debugging and C++ exceptions=
)
> >>> and adding 0.70x more means significant additional overhead for users=
.
> >>>
> >>>>> There are at least two formats the ELF one can learn from: LLVM's
> >>>>> compact unwind format (aarch64) and Windows ARM64 Frame Unwind Code=
.
> >>>>>
> >>>>
> >>>> Please, if you have any concrete suggestions (keeping the above goal=
s in
> >>>> mind), you already know how/where to engage.
> >>>
> >>> I've provided concrete suggestions throughout this discussion.
> >>>
> >>
> >> Apologies, I should have been more precise.  And I ask because you kno=
w
> >> the details about both SFrame and the variants of Compact Unwind
> >> Descriptor formats at this point :). If you have concrete suggestions =
to
> >> improve the SFrame format for size, please let us know.
> >
> > At this point, I'm not certain about specific modifications to .sframe
> > itself. I think we should start from scratch, drawing ideas from
> > compact unwind information and Windows ARM64.
> >
> > The existing compact unwind information uses the following 4-byte descr=
iptor:
> >
> >    uint32_t mode_specific_encoding : 24; // vary with different modes
> >
> >    uint32_t mode : 4; // UNWIND_X86_64_MODE_MASK =3D=3D UNWIND_ARM64_MO=
DE_MASK
> >
> >    uint32_t has_lsda : 1;
> >    uint32_t personality_index : 2;
> >    uint32_t is_not_function_start : 1;
> >
>
> Thanks.
>
> SFrame is not for stack unwinding.  Subsuming .eh_frame is topic for
> another day.  SFrame does not intend to go that route.
>
> > We probably need a less-restricted version and account for different
> > architecture needs. The result would still be significantly smaller
> > than SFrame v2 and the future v3 (unless it's completely rewritten).
> >
> > We should probably design an optional two-level lookup table mechanism
> > for additional savings (at the cost of linker friendliness).
> >
> >>>>> **Path forward**
> >>>>>
> >>>>> Unless SFrame can actually replace .eh_frame (rather than supplemen=
ting
> >>>>> it as an accelerator for linux-perf) and demonstrate sizes smaller
> >>>>> than .eh_frame - matching the efficiency of existing compact unwind
> >>>>> approaches =E2=80=94 I question its practical viability for userspa=
ce.
> >>>>> The current design appears to add overhead rather than reduce it.
> >>>>> This isn't to suggest we should simply adopt the existing compact u=
nwind
> >>>>> format wholesale.
> >>>>> The x86-64 design dates back to 2009 or earlier, and there are like=
ly
> >>>>> improvements we can make. However, we should aim for similar or bet=
ter
> >>>>> efficiency gains.
> >>>>>
> >>>>> For additional context, I've documented my detailed analysis at:
> >>>>>
> >>>>> - https://maskray.me/blog/2025-09-28-remarks-on-sframe (covering
> >>>>> mandatory index building problems, section group compliance and gar=
bage
> >>>>> collection issues, and version compatibility challenges)
> >>>>
> >>>> GC issue is a bug currently tracked and with a target milestone of 2=
.46.
> >>>>> - https://maskray.me/blog/2025-10-26-stack-walking-space-and-time-t=
rade-
> >>>>> offs (size analysis)
> >>>>>
> >
> > The GC issue would not have happened at all if we had used multiple
> > sections and thought about ELF and linker convention :)
>
> Thanks for engaging.
