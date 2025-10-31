Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504AF2BE7A3
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 04:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761884550; cv=none; b=qtFj3Eaakgy3r2bUB0p1QImpPGHxR6Y1UeT6tYIO7Z53q9qrVg7x6WmaPCDWIkxXmrB2Oqtl9F9rFnMON7+/Chc62L/+zuBID4qwgj0C5eolMnv9MyKI+L1anlCeFVXvHi1ZA28hvwon6kr7ZasrmbQ9SUbhmoXTkDe38J3IflE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761884550; c=relaxed/simple;
	bh=Li7t9MdvQL+3mRr4oYbDAW8Vy2ldpf8YTKiBSU0Cx7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdnY/kv0y5iu/vtw8mEKhkDW2djSLXUFcametPk0d29Y/Iegl/Ytp8LJXubFVcXGvCWIdp5E9QPJhzwMC/oMiguwEy+W4MiDrmm05mde+OJT6Iw+MakNbH1SBkQjznIDNWHfrl4OKkNltcdGMilVVTXlBXCrswg34Ypkxwrybyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-932bf9d3deeso1946104241.2
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 21:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761884547; x=1762489347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rajluaO4gybwwGptSh7jM2QmvD0NNSV09uVxYmFwX+U=;
        b=iE6Kxfxrn2Nk8Yzs467Cs2iulV+HIXPUsPLEJkbaoSedahz9OqX1oSungIB2SkCaFU
         9FfyEZiHlArtUtfCiqvSYKmscGi0J6Ml9VJtuA7IRns1aIUIP+a49CRqsNYaEUG0fYJp
         NuyuKgumWf+3wW2rhPJp4Vj4MQZBXrJ/S+svr1OX11ejxDUDHGUs99Gk0cEJ+HrhwZ9R
         ko3YDWGxRC8YItE2JIuHUbmUtDdGMrwE0qroSnItjpc7oQsC+JAAGF+Lk3tNxq6U1ouK
         /jYs0ug4iKruLitBrFrYqBqUoM078ytOY9H8EXokPs7xcEsR4ZmPxaOUhpw57S/MdLG1
         BYCw==
X-Forwarded-Encrypted: i=1; AJvYcCV7Den1FEsGpJ/Uvg/eSxa38dz9HMerQfwsuN8KjTLFlyUwZllgRP2M787KpFqDETVKtExIDvZFHa0I1qoZMWNx@vger.kernel.org
X-Gm-Message-State: AOJu0YyfkdBPfucul4pr3rz/Jbe4aVfstGfMzjozWfh880LgMOmuZeq0
	sqJOboJPeRsskaFNxPpqtZse07e85ZDd6qWHJN9awA1qyN6dqideXL4Mwm+qYQ==
X-Gm-Gg: ASbGncuWnFOZwQXS2c7FpHut6H/12AaKdu1MEeiJDpJF8a6c7m4gq80JZ2eRUsC0ZjM
	NtCnJGUpq8Tq5ueBWdFTMje6ZmALgAT236p+9yZttTvAoPXj+iNwCiYa2FTWWIQVqFDNjKZ5Ysr
	gMjdE4O3+9Lr6lPEJxdMu5ov5THKrF0bKRjfLYaAqdlz64R6jMkufq1gIfmb+pMC6671s6pRIKY
	ZHFvdIthvD3hUM0rls/rg7o8FCAYuXM10gUoXLIaDK+4AzJwDgB5DiIKWnAyF6B16tdcjSXz0u1
	Ie1RwsmlPviXQccDangR0iO9J53uLbdjfndwnKSYmsJg3psy4ab50+ScMmTWj5gZI1PHGNrohK+
	k7PujnNcHXU1CnQYgs63gOiU4vkg1UXPzJkHXi6wM1+PhrqwZ/RsZ9eN93B27I50a27RkqqNxwh
	ijPnJAwoUEtacq+AlzsI5w+Dr/Qx8M3CJAJjIlre4X
X-Google-Smtp-Source: AGHT+IGFHNmGcMJJ7AnRdqGd7jnC5Kf+BlAmv3PDwZuFbwwyqWMEauqvDw3mJ+Z9d+ajphTz8Q+6Bg==
X-Received: by 2002:a05:6122:134c:b0:556:9cb9:65cd with SMTP id 71dfb90a1353d-5593e40750bmr802471e0c.6.1761884546939;
        Thu, 30 Oct 2025 21:22:26 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55944b96e0esm244193e0c.22.2025.10.30.21.22.26
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 21:22:26 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-932f654eaaeso1740440241.0
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 21:22:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/2Z1hxDKZN71KnGjFG+vVK81K2hjPnxV7EFOh26wVY3RK7sKCR80mZ3Byq7pnRYTqDQd2rpk79OLum5lMLkT4@vger.kernel.org
X-Received: by 2002:a05:6122:8b03:b0:54b:bf4d:558b with SMTP id
 71dfb90a1353d-5593e4db718mr851352e0c.10.1761884546398; Thu, 30 Oct 2025
 21:22:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
 <20251030102626.GR3245006@noisy.programming.kicks-ass.net>
 <CAN30aBF3MofmVTjTZ9KFq9OBM0nA16amP5VFv+VAEJfFkLx0qw@mail.gmail.com> <87zf98tj8k.fsf@oracle.com>
In-Reply-To: <87zf98tj8k.fsf@oracle.com>
From: Fangrui Song <maskray@sourceware.org>
Date: Thu, 30 Oct 2025 21:22:40 -0700
X-Gmail-Original-Message-ID: <CAN30aBEO0nKWnHRkT21qEQZCnQ_8O_ayx7DfHaov1YZPZpgjRg@mail.gmail.com>
X-Gm-Features: AWmQ_bkNzw5O2VCpjk6l2EbtdhhxTdj9sCX2XDviTwqU72Qyrwtu_UnbAfXx62Q
Message-ID: <CAN30aBEO0nKWnHRkT21qEQZCnQ_8O_ayx7DfHaov1YZPZpgjRg@mail.gmail.com>
Subject: Re: Concerns about SFrame viability for userspace stack walking
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Fangrui Song <maskray@sourceware.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-toolchains@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 10:04=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> > On Thu, Oct 30, 2025 at 3:26=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> >>
> >> On Wed, Oct 29, 2025 at 11:53:32PM -0700, Fangrui Song wrote:
> >> > I've been following the SFrame discussion and wanted to share some
> >> > concerns about its viability for userspace adoption, based on concre=
te
> >> > measurements and comparison with existing compact unwind
> >> > implementations in LLVM.
> >> >
> >> > **Size overhead concerns**
> >> >
> >> > Measurements on a x86-64 clang binary show that .sframe (8.87 MiB) i=
s
> >> > approximately 10% larger than the combined size of .eh_frame and
> >> > .eh_frame_hdr (8.06 MiB total).  This is problematic because .eh_fra=
me
> >> > cannot be eliminated - it contains essential information for restori=
ng
> >> > callee-saved registers, LSDA, and personality information needed for
> >> > debugging (e.g. reading local variables in a coredump) and C++
> >> > exception handling.
> >> >
> >> > This means adopting SFrame would result in carrying both formats, wi=
th
> >> > a large net size increase.
> >>
> >> So the SFrame unwinder is fairly simple code, but what does an .eh_fra=
me
> >> unwinder look like? Having read most of the links in your email, there
> >> seem to be references to DWARF byte code interpreters and stuff like
> >> that.
> >>
> >> So while the format compactness is one aspect, the thing I find no
> >> mention of, is the unwinder complexity.
> >>
> >> There have been a number of attempts to do DWARF unwinding in
> >> kernel space and while I think some architecture do it, x86_64 has had
> >> very bad experiences with it. At some point I think Linus just said no
> >> more, no DWARF, not ever.
> >>
> >> So from a situation where compilers were generating bad CFI unwind
> >> information, a horribly complex unwinder that could crash the kernel
> >> harder than the thing it was reporting on and manual CFI annotations i=
n
> >> assembly that were never quite right, objtool and ORC were born.
> >>
> >> The win was many:
> >>
> >>  - simple robust unwinder
> >>  - no manual CFI annotations that could be wrong
> >>  - no reliance on compilers that would get it wrong
> >>
> >> and I think this is where SFrame came from. I don't think the x86_64
> >> Linux kernel will ever natively adopt SFrame, ORC works really well fo=
r
> >> us.
> >>
> >> However, we do need something to unwind userspace. And yes, personally
> >> I'm in the frame-pointer camp, that's always worked well for me.
> >> Distro's however don't seem to like it much, which means that every ti=
me
> >> I do have to profile something userspace, I get to rebuild all the
> >> relevant code with framepointers on (which is not hard, but tedious).
> >>
> >> Barring that, we need something for which the unwind code is simple an=
d
> >> robust -- and I *think* this has disqualified .eh_frame and full on
> >> DWARF.
> >>
> >> And this is again where SFrame comes in -- its unwinder is simple,
> >> something we can run in kernel space.
> >>
> >> I really don't much care for the particulars, and frame pointers work
> >> for me -- but I do care about the kernel unwinder code. It had better =
be
> >> simple and robvst.
> >>
> >> So if you want us to use .eh_frame, great, show us a simple and robust
> >> unwinder.
> >
> > Hi Peter,
> >
> > Thanks for this perspective=E2=80=94the unwinder complexity concern is
> > absolutely valid and critical for kernel use.
> > To clarify my motivation: I've seen attempts to use SFrame for
> > userspace adoption
> > (https://fedoraproject.org/wiki/Changes/SFrameInBinaries ), and I
> > believe it's not viable for that purpose given the size overhead I
> > documented. My concerns are primarily about userspace adoption, not
> > the kernel's internal unwinding.
> >
> > If SFrame is exclusively a kernel-space feature, it could be
> > implemented entirely within objtool =E2=80=93 similar to how objtool --=
link
> > --orc generates ORC info for vmlinux.o. This approach would eliminate
> > the need for any modifications to assemblers and linkers, while
> > allowing SFrame to evolve in any incompatible way.
> >
> > For userspace, we could instead modify assemblers and linkers to
> > support a more compact format or an extension to .eh_frame , but it
> > won't be SFrame (all of Apple=E2=80=99s compact unwind, ARM EHABI=E2=80=
=99s
> > exidx/extab, and Microsoft=E2=80=99s pdata/xdata can implement C++ exce=
ption
> > handling , while SFrame can't, leading to a huge missed opportunity.)
>
> The purpose of SFrame is not to be a more compact replacement for
> .eh_frame.  It is intended to be used to walk stacks, not to unwind
> them.

Hi Jose,

Let me clarify my concerns, as I think we may be talking past each other a =
bit.

**The primary concern: size overhead for userspace**

The fundamental issue is that SFrame, as currently designed, results
in a significant net size increase for userspace binaries because it
is large and cannot replace .eh_frame (which would mean losing
debugging and C++ exception handling support).The median .eh_frame
size across executables and shared libraries on a Linux system is 5+%
of total VM size:

https://gist.github.com/MaskRay/5995d10b65e1e18b82931c5a8d97f55e

Increasing this to 10% by adding SFrame on top is simply not viable.
As my reply to Peter mentioned, "If SFrame is exclusively a
kernel-space feature, it could be implemented entirely within
objtool=E2=80=94similar to how objtool --link --orc generates ORC info for
vmlinux.o."

**What about kernel use?**

As I mentioned in my reply to Peter, if SFrame is exclusively a
kernel-space feature, it could be implemented entirely within
objtool=E2=80=94similar to how objtool --link --orc generates ORC info for
vmlinux.o.
I believe SFrame has a size advantage over ORC, which could make it
attractive for this use case.
However, if SFrame will not replace the existing in-kernel ORC
unwinder (as Peter suggested), then I'm afraid SFrame doesn't have a
clear position=E2=80=94neither for vmlinux nor for userspace programs.

**On the ELF format issues**

https://groups.google.com/g/generic-abi/c/3ZMVJDF79g8

The current Binutils implementation disregards ELF and linker
conventions, which is a serious concern for all linker maintainers.
The proposed SHF_OS_NONCONFORMING_DISCARD flag has faced strong
objections in the generic ABI discussion:
https://groups.google.com/g/generic-abi/c/3ZMVJDF79g8

There are also unresolved garbage collection issues. I had to disable
-Wl,--gc-sections entirely when testing for
https://maskray.me/blog/2025-10-26-stack-walking-space-and-time-trade-offs

I want to emphasize: custom merging rules do not inherently conflict
with using proper multi-section structure with section group and
SHF_LINK_ORDER.
The format could be designed to work within established ELF
conventions rather than requiring special cases throughout the linker.
The concern about maintenance burden isn't about the initial
implementation=E2=80=94it's about committing to long-term support for a for=
mat
that requires custom handling in every linker while providing
questionable benefit for its stated use case.
