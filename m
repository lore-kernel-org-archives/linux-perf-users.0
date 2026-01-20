Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE0836C58F
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892233; cv=pass; b=EhH+eJvNJzW1GeC5kkn2YCGxepmn2FqV/72+jkcvF4Q/hyJbvnOImegSMZKeyKF62O7WNGj8H0xRm5zVkelvuT4CLNYLTtjIIHmFdEcdbKTdgIywsX/bTMG2qHh1+yKieKJGgWCX2pmdvsCsMX8lUdZM1hJYyZN9q59DjBVsQhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892233; c=relaxed/simple;
	bh=ToPDQprL8nAqD7Zk0DNhVQzu+V5KVVTNXT6oJvoyyNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FsJu+8G3+jvhaa2rvo7SBBPBidMtTmUsqdGKoCLwCq4XTJn+NRVxeEzZNXdA8LE3jHS9esRZKGRi0PWy3gK1CCLlgDhaiGkTsJoLQiUcaTdYX+W2Mro0Qi0SQg6tkyh4H7H/tid1VTBT9nbPhWd396D8PoOR+tSH2Exa+f4JEiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y9ykmNzN; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y9ykmNzN"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-124643b5b18so12259c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2026 22:57:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768892223; cv=none;
        d=google.com; s=arc-20240605;
        b=OJjzNw1pCQ/Jp3cfay78NfCpnBT56FzQmXr0mBuHY33VH9Jtn72MfpIjvWP/GlJ20b
         MpWgsnIrXX6tW7fp2DA3F2oTJynek9VKQaDZ7mIo1MaDXjYeGZ2yj67ALYpL2R++MYFf
         kaADD5y2l1bIwkdz2yq3YfW3v5YyNv/DpSdl3ahKWGeyy/zvGAy0EmooP4+qhWKIBec4
         nmbYVLiuEmFZZOvjCs22wHkyMHpSJJdA+igCMqu7UmKDDvTI3NnKg0v2mKPefYm4LJoT
         5Hmo4DPzituCBGOy7WvOxZkpfO7H+TWCn+3bpcMr9B7JqJJAjNTynimDhVhx4ndME9qw
         QgAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vdqc/bf1waalLhUi8VR6zSjRbMZapE4y0YSz2MDLfgM=;
        fh=wZmGdIgJTgbA/xIZPCDabiwm7UA/IaXGHE9bFPHXXFM=;
        b=VSxtCeViQP6qE25BeBB+WPCXQK3zDFFyv1jCRl8263APviaAjvBKKdwfB+nFwjGqNe
         6oaVW6axnbhomTjMcaCjvWK1nid4rU3/C/7O6KSOQWZXTXxvrh6dsekiEiEgzZjMSgLQ
         OYBF7lHNvJ3lB5H+focqAmul3kZOPKc6rUDm07DZWEDzWfaOYBZwUVRFL6Av204EGJCE
         nRG/Yht5mb5Twb8P84ZhKs42tZtEaePBDW+lgwsvLjlY0NhEIukOvpA1rh3+EyW4t+4k
         j1fveml4k4k0MQwTO7JShN5pWYscJTiCW7208HNyx0xBH2aC9xQVRzy6BKE8shAd3Luc
         YWbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768892223; x=1769497023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vdqc/bf1waalLhUi8VR6zSjRbMZapE4y0YSz2MDLfgM=;
        b=y9ykmNzNqPpDkG/t/zIlsl8N0mecno3CReB4XWJMnpWZFNnqQPrOWq3SCXbcon7FT2
         WAIh+c91wnXrYkVGEfEZaSUADYP9Mjwe+YWBSwuLV7NiJA0u5t50EoV4ygFmOk5pofWn
         aeVRrPFIw5yBcMIgXjJxvLD8PXFGbXDknkJ58Tx6Bt9zot9T+IS6Bk1O2ppSprcLeKnD
         OWKmTEXFeHk3NYZ9SuUWg7m+iAUEtfLtRdfl8izYrHX2gV47/KtY/980DqOunLbANh9a
         /i+u/gQAIrAvRDR01CZ45U5PbgyWU086E44zBTAili+TvkMCsoz4Is97TU8+oaAlk3QJ
         tr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768892223; x=1769497023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vdqc/bf1waalLhUi8VR6zSjRbMZapE4y0YSz2MDLfgM=;
        b=JAv5KxwePPcOd5tJDCmoHR9ls9/Phj+CHUYOYZWs/FVIVoROVFRF8Em3pZQglf5O/D
         oEgl9LGeciqVPvNYpqiOcrtngnm5uRMMSh85BhuF2ioWyVimxlGkOR2Gu/F7bLRsldvh
         pb5o1DJOnE7EwUyjwA+HCBTyIi4lG7E9qdIZSIMGnAsKvUbCU22OsCgoKjyt10F5DR25
         fkewOObdr1O3fDEpfmNpXKG4O87XWclwKfrDvVyfnrOvRnzzV39SuEKqPZ+XdZPdrMs+
         wreUlQGm6A3TrdYiMKEND1wJGYr/DglxytB3Z6hyxj4q1BTElvtAd1hFLm6rKVEeAodP
         J59g==
X-Forwarded-Encrypted: i=1; AJvYcCW7k+6Q2MGN6EureaTaaJK3pxDUcBcoj6eJEQ4gOKoOo7yFXJjLKDdqoRwpK9d1Wgb1dloc8/MuN7z5u9SBpSwW@vger.kernel.org
X-Gm-Message-State: AOJu0YzwW1P0Tqw+tptli4h48mKVZG3pHTzv/s7eY5arDursqkVIKoed
	K6dGIvY2dd99k4rmN9sKlm/fpD+m1XQx/lVVnoLkso6JPLchAQRWcRbOiTHG2PtiBXqv9EKd66c
	1kVCPZL7FWZ0y4IWJWNk08jMTa1OTqruBEYnNCVON
X-Gm-Gg: AY/fxX4V5CVSGGbIDY0Ndn2Kl86Pea40zf4Bi1fg9HlbnjIimZ6D3TDcbnDj9K0XbiT
	qUi5NALQ484cU15JGtXPg9R1FCPic0c4QkEyR07U5kqfjk8+IzdUZ6JbE/pUbDqw8MlZmKjgN57
	40s127n13Y67xWum7upGDfVR2Y74k79cqLAhsEqBe8+P9HGojU04H4y23lTkycyLjf/HwT2bpNz
	m90SC5IapIYEnnnR+WZNipLvEugIXVv0cXGIPoGUlPPSywHct6EOmrg7wirTxJvrqkRExKh
X-Received: by 2002:a05:7022:ef14:b0:120:5719:624a with SMTP id
 a92af1059eb24-1245457008cmr281640c88.17.1768892222372; Mon, 19 Jan 2026
 22:57:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <9d97e2f4-3971-4486-8689-ab50b06c3810@linux.intel.com> <CAP-5=fU+JeBqCNfKVR9O2cd0zzPO1bsYORtEBzeTeTpMLg4m5Q@mail.gmail.com>
 <0a99aaac-d51c-4c65-addd-5e366408a3f0@linux.intel.com> <CAP-5=fV_dbFzQ8_xHsduFytEq+6H0M0iPof0Krb0dBB+Bsd42g@mail.gmail.com>
 <3d95b037-e1c1-40db-b357-889c62c70221@linux.intel.com> <CAP-5=fW5g-_Owf2wWtXZwpbtTy9uns_pqr=BFumohHxWGU+i0Q@mail.gmail.com>
 <47014c3e-0fca-4248-9f23-09007f9ee95f@linux.intel.com> <CAP-5=fVbWp5bdnxrcA4XQPvFa2iYB3583C4DzOP7wA=oPqvcKQ@mail.gmail.com>
 <8b932ae4-5f65-454e-ae9e-0d9377a92254@linux.intel.com> <54c173b0-55f1-42d2-a43d-d6389d3fbfe3@linux.intel.com>
 <CAP-5=fV0iPapwbKX-rjbF86_WcZPji8opKNgO=r_kDSJB7T8XA@mail.gmail.com>
 <9f73d1f1-80f5-45ed-946f-6a920ba34980@linux.intel.com> <CAP-5=fUNeJpj-rdi+552-o9xhCiT41q-Q8Zhg8U7ev0Wbiyhog@mail.gmail.com>
 <478c90df-61a8-4e19-a640-931ce791fe97@linux.intel.com> <CAP-5=fXNTSA4wGW+HWS_UdV-iR940A1Td9wgyHOsVbhM0QjE3g@mail.gmail.com>
 <a11ddf44-e553-4a9c-a70f-824295317d4f@linux.intel.com>
In-Reply-To: <a11ddf44-e553-4a9c-a70f-824295317d4f@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 19 Jan 2026 22:56:48 -0800
X-Gm-Features: AZwV_QjoH0HVGuKg0UC7YoOr6bujJ9-pilXVVP6KGXGMj15wTVn-NTzIzsY_Tk4
Message-ID: <CAP-5=fVvsoMyLwhyf=9A8fhk9SQFk4wEtyHGyj5+ETciYXcp1w@mail.gmail.com>
Subject: Re: [Patch v5 18/19] perf parse-regs: Support new SIMD sampling format
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 10:46=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel=
.com> wrote:
>
>
> On 1/20/2026 1:16 PM, Ian Rogers wrote:
> > On Mon, Jan 19, 2026 at 7:05=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.in=
tel.com> wrote:
> >>
> >> On 1/20/2026 4:25 AM, Ian Rogers wrote:
> >>> On Sun, Jan 18, 2026 at 10:55=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux=
.intel.com> wrote:
> >>>> On 1/17/2026 1:50 PM, Ian Rogers wrote:
> >>>>> On Mon, Jan 5, 2026 at 11:27=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linu=
x.intel.com> wrote:
> >>>>>> Ian,
> >>>>>>
> >>>>>> I looked at these perf regs __weak helpers again, like
> >>>>>> arch__intr_reg_mask()/arch__user_reg_mask(). It could be really ha=
rd to
> >>>>>> eliminate these __weak helpers and convert them into a generic fun=
ction
> >>>>>> like perf_reg_name(). All these __weak helpers are arch-dependent =
and
> >>>>>> usually need to call perf_event_open sysctrl to get the required r=
egisters
> >>>>>> mask. So even we convert them into a generic function, we still ha=
ve no way
> >>>>>> to get the registers mask of a different arch, like get x86 regist=
ers mask
> >>>>>> on arm machine. Another reason is that these __weak helpers may co=
ntain
> >>>>>> some arch-specific instructions. If we want to convert them into a=
 general
> >>>>>> perf function like perf_reg_name(). It may cause building error si=
nce these
> >>>>>> arch-specific instructions may not exist on the building machine.
> >>>>> Hi Dapeng,
> >>>>>
> >>>>> There was already a patch to better support cross architecture
> >>>>> libdw-unwind-ing and I've just sent out a series to clean this up s=
o
> >>>>> that this is achieved by having mapping functions between perf and
> >>>>> dwarf register names. The functions use the e_machine of the binary=
 to
> >>>>> determine how to map, etc. The series is here:
> >>>>> https://lore.kernel.org/lkml/20260117052849.2205545-1-irogers@googl=
e.com/
> >>>>> and I think it can be the foundation for avoiding the weak function=
s.
> >>>> Hi Ian,
> >>>>
> >>>> Thanks for the reference patch. But they are different. The referenc=
e
> >>>> patches mainly parse the regs from perf.data and the __weak function=
s can
> >>>> be eliminated in the parsing phase since the registers bitmap is fix=
ed for
> >>>> a fixed arch. While these __weak functions
> >>>> arch__intr_reg_mask()/arch__user_reg_mask() are used to obtain the s=
upport
> >>>> sampling registers on a specific platform.
> >>>>
> >>>> We know different platforms even for same arch may support different
> >>>> registers, e.g., some x86 platforms may only support XMM registers, =
but
> >>>> some others may support XMM/YMM/ZMM registers, then all these arch-s=
pecific
> >>>> arch__intr_reg_mask()/arch__user_reg_mask() functions have to depend=
 on the
> >>>> perf_event_open() syscall to retrieve the supported registers mask f=
rom kernel.
> >>>>
> >>>> Thus, it becomes impossible to retrieve the supported registers mask=
 for a
> >>>> x86 specific platform from running on a arm platform.
> >>>>
> >>>> Even we don't consider this limitation and forcibly convert the
> >>>> __weak arch__intr_reg_mask() function to some kind of below function=
, just
> >>>> like currently what perf_reg_name() does.
> >>>>
> >>>> uint64_t perf_intr_reg_mask(const char *arch)
> >>>> {
> >>>>     uint64_t mask =3D 0;
> >>>>
> >>>>     if (!strcmp(arch, "csky"))
> >>>>         mask =3D perf_intr_reg_mask_csky(id);
> >>>>     else if (!strcmp(arch, "loongarch"))
> >>>>         mask =3D perf_intr_reg_mask_loongarch(id);
> >>>>     else if (!strcmp(arch, "mips"))
> >>>>         mask =3D perf_intr_reg_mask_mips(id);
> >>>>     else if (!strcmp(arch, "powerpc"))
> >>>>         mask =3D perf_intr_reg_mask_powerpc(id);
> >>>>     else if (!strcmp(arch, "riscv"))
> >>>>         mask =3D perf_intr_reg_mask_riscv(id);
> >>>>     else if (!strcmp(arch, "s390"))
> >>>>         mask =3D perf_intr_reg_mask_s390(id);
> >>>>     else if (!strcmp(arch, "x86"))
> >>>>         mask =3D perf_intr_reg_mask_x86(id);
> >>>>     else if (!strcmp(arch, "arm"))
> >>>>         mask =3D perf_intr_reg_mask_arm(id);
> >>>>     else if (!strcmp(arch, "arm64"))
> >>>>         mask =3D perf_intr_reg_mask_arm64(id);
> >>>>
> >>>>     return mask;
> >>>> }
> >>>>
> >>>> But currently there are some arch-dependent instructions in these
> >>>> arch-specific instructions, like the below code in powerpc specific
> >>>> arch__intr_reg_mask().
> >>>>
> >>>>     version =3D (((mfspr(SPRN_PVR)) >>  16) & 0xFFFF);
> >>>>
> >>>> mfspr is a powerpc specific instruction, building this converted
> >>>> perf_intr_reg_mask on non-powerpc platform would lead to building er=
ror.
> >>> Hi Dapeng,
> >>>
> >>> So my main point is the arch directory and ifdefs, how do they differ
> >>> from writing code that uses the ELF machine? For example, your code
> >>> uses the arch/x86 directory and has ifdefs on
> >>> HAVE_ARCH_X86_64_SUPPORT. How is that different from:
> >>> ```
> >>> switch(e_machine) {
> >>> case EM_X86_64:
> >>> ...
> >>> case EM_I386:
> >>> ...
> >>> default:
> >>> return 0;
> >>> }
> >>> ```
> >>> If we need to determine for the current running machine then e_machin=
e
> >>> can equal EM_HOST that is set up for this purpose.
> >> I think the key factor that determines if we can convert the code into
> >> above e_machine switch ... case format is whether the code is
> >> architecture-dependent both in building and execution phases.
> >>
> >> If the code is not architecture-dependent, It's good to covert the cod=
e
> >> into the e_machine switch ... case and that would provide better appli=
cability.
> >>
> >> Otherwise, the architecture-dependent code would lead to the building =
error
> >> (building phase) or get incorrect execution results (execution phase).
> >>
> >> Even if we introduce EM_HOST case, it won't really solve the building
> >> error,  instead it may introduce new building error, e.g.,
> >>
> >> ```
> >> switch(e_machine) {
> >> case EM_HOST:
> >> ...
> >> case EM_X86_64:
> >> ...
> >> case EM_I386:
> >> ...
> >> default:
> >> return 0;
> >> }
> >> ```
> > No, you wouldn't put EM_HOST as a case statement ever. It is the value
> > of the ELF machine you are compiling upon, so either EM_X86_64 or
> > EM_I386 here. You would make `e_machine =3D EM_HOST` were you to want
> > some which is specific to the host you are compiling upon. ie `if
> > (EM_HOST =3D=3D EM_X86_64 || EM_HOST =3D=3D EM_I386) { ... }` would be
> > equivalent to `#ifdef __x86_64__` or equivalent to putting code into
> > the arch/x86 directory.
>
> The difference between  `if (EM_HOST =3D=3D EM_X86_64 || EM_HOST =3D=3D E=
M_I386) {
> ... }` with  `#ifdef __x86_64__` or equivalent __weak functions is on the
> building phase. All the "if (EM_HOST =3D=3D EM_X86_64 || EM_HOST =3D=3D E=
M_I386) {
> ... }" code would be built on any architectural platforms, i.e., the x86
> specific code could need to be build on ARM platform. If there are
> arch-specific code, then the building would fail, e.g., there are below
> code in powerpc specific arch__intr_reg_mask() function.
>
>     version =3D (((mfspr(SPRN_PVR)) >>  16) & 0xFFFF);
>
> mfspr is a powerpc specific instruction and it would get building error i=
f building on the other arch platforms.
>
> To avoid the building error, we have to introduce the #ifdef again.
>
>
> I ever tried to covert the __weak arch__intr_reg_mask() functions into th=
e below function.
>
> ```
> uint64_t perf_intr_reg_mask(const char *arch)
> {
>     uint64_t mask =3D 0;
>
>     if (!strcmp(arch, "csky"))
>         mask =3D perf_intr_reg_mask_csky(arch);
>     else if (!strcmp(arch, "loongarch"))
>         mask =3D perf_intr_reg_mask_loongarch(arch);
>     else if (!strcmp(arch, "mips"))
>         mask =3D perf_intr_reg_mask_mips(arch);
>     else if (!strcmp(arch, "powerpc"))
>         mask =3D perf_intr_reg_mask_powerpc(arch);
>     else if (!strcmp(arch, "riscv"))
>         mask =3D perf_intr_reg_mask_riscv(arch);
>     else if (!strcmp(arch, "s390"))
>         mask =3D perf_intr_reg_mask_s390(arch);
>     else if (!strcmp(arch, "x86"))
>         mask =3D perf_intr_reg_mask_x86(arch);
>     else if (!strcmp(arch, "arm"))
>         mask =3D perf_intr_reg_mask_arm(arch);
>     else if (!strcmp(arch, "arm64"))
>         mask =3D perf_intr_reg_mask_arm64(arch);
>
>     return mask;
> }
> ```
>
> But this causes the building error for the perf_intr_reg_mask_powerpc() o=
n x86 platform since the powerpc specific mfspr instruction. A way to fix t=
he building error is to introduce the "#ifdef __powerpc__", maybe like this=
,
>
> #ifdef __powerpc__
>
> uint64_t perf_intr_reg_mask(const char *arch)
> {
>         ...
> }
>
> #else
>
> uint64_t perf_intr_reg_mask(const char *arch)
> {
>         return 0;
> }
> #endif
>
> Do you think it's a correct way to handle the issue?
>
> >
> >> Assume the code is built on a x86_64 machine, then EM_HOST equals
> >> EM_X86_64, that would cause the "duplicate case value" building error.
> >>
> >> If we want to limit the architecture-dependent code is built only on t=
he
> >> correct architecture, then we still have to introduce the architecture
> >> #ifdefs. This is actually no difference with current arch directory __=
weak
> >> functions and make it more complex.
> > If we have arch functions for  arch__user_simd_reg_mask then why would
> > code go through the usual means to determine what the mask is? The
> > normal means is to get a sample event, use evsel__parse_sample and
> > then from the sample access struct regs_dump that has within it keeps
> > a copy of the mask from perf_event_attr associated with the evsel.
> >
> > In your next patch you do:
> > https://lore.kernel.org/lkml/20251203065500.2597594-20-dapeng1.mi@linux=
.intel.com/
> > ```
> > ...
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > ...
> > +static void simd_regs_dump__printf(struct regs_dump *regs, bool intr)
> > +{
> > ...
> > + if (intr)
> > + arch__intr_simd_reg_bitmap_qwords(reg_idx, &qwords);
> > + else
> > + arch__user_simd_reg_bitmap_qwords(reg_idx, &qwords);
> > ...
> >  ```
> > The session code is generic, it may be dealing with live machine data
> > or with a perf.data file from anywhere. The reason this patch is
> > exposing these weak functions is for the next patch, there's not a use
> > here. But why isn't the next patch using struct regs_dump? The struct
> > regs_dump was set up with sample event and perf_event_attr on hand.
> > The evsel__parse_sample logic should likely set up a qwords variable
> > so the generic code can just do:
> > ```
> > qwords =3D regs->qwords;
> > ```
> > The parsing logic should be able to do "nr_vectors * vector_qwords +
> > nr_pred * pred_qwords" from the perf_event_attr no?
>
> The arch__intr_simd_reg_bitmap_qwords() are also used in this patch,  lik=
e
> the below code
>
> ```
>
> static void __print_simd_regs(bool intr, uint64_t simd_mask)
> {
>     const struct sample_reg *r =3D NULL;
>     uint64_t bitmap =3D 0;
>     u16 qwords =3D 0;
>     int reg_idx;
>
>     if (!simd_mask)
>         return;
>
>     for (r =3D arch__sample_simd_reg_masks(); r->name; r++) {
>         if (!(r->mask & simd_mask))
>             continue;
>         reg_idx =3D fls64(r->mask) - 1;
>         if (intr)
>             bitmap =3D arch__intr_simd_reg_bitmap_qwords(reg_idx, &qwords=
);
>         else
>             bitmap =3D arch__user_simd_reg_bitmap_qwords(reg_idx, &qwords=
);
>         if (bitmap)
>             fprintf(stderr, "%s0-%d ", r->name, fls64(bitmap) - 1);
>     }
> }
>
> ```
>
> But I agree this can be convert some kind of generic functions. Let me tr=
y
> to do it in next version.
>
> >
> >>> I agree that determining features needs calls that may not be
> >>> supported on other architectures. That should yield EOPNOTSUPP and we
> >>> can use information like that to populate generic information like th=
e
> >>> PMU missing features:
> >>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-n=
ext.git/tree/tools/perf/util/pmu.h?h=3Dperf-tools-next#n190
> >>> we also probe API support with:
> >>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-n=
ext.git/tree/tools/perf/util/perf_api_probe.h?h=3Dperf-tools-next
> >> In general, I agree we can return EOPNOTSUPP or some generic informati=
on
> >> for some architecture independent code. But it's not applicable for th=
ese 2
> >> specific arch__intr_reg_mask()/arch__user_reg_mask() functions, curren=
t
> >> perf code depends on these 2 functions to return the supported registe=
rs
> >> mask on a specific (running) platform.
> > You can't put code into generic code like session and assume the
> > perf.data is for the running machine, so the design is wrong.
>
> Ok, let me try to convert them a generic function.
>
>
> >
> >>> The current code doing lots of string comparisons is unnecessary
> >>> overhead and imprecise (x86 is used for both 32-bit and 64-bit x86).
> >>> It is removed in the series I linked to, I think we can eventually ge=
t
> >>> rid of the whole arch string for similar reasons of trying to minimiz=
e
> >>> the use of the arch directory. I'm curious what happens with APX, wil=
l
> >>> the e_machine change? We may need to pass in the sample regs_dump's
> >>> abi field for cases like this.
> >> Yes, I agree we should git rid of the arch-string comparison and minim=
ize
> >> the use of arch directory. It would improve the efficiency.
> >>
> >> I don't think the support of APX would change the e_machine, it should
> >> still be EM_X86_64.
> >>
> >> Yes, we need the abi filed (exactly PERF_SAMPLE_REGS_ABI_SIMD) to dete=
rmine
> >> it's APX or legacy XMM.
> > Right, in my (unmerged) code to map a perf register to a dwarf register=
:
> > https://lore.kernel.org/lkml/20260117052849.2205545-13-irogers@google.c=
om/
> > we'll need the abi field.
>
> Let me try to add the change in the next version.

I'm playing around with the patches to see what can be done. Let me
comment on the original patches. But I'll also try to send out what
I've done.

Thanks,
Ian

> >
> >>> My point on the unwinding is that the sample register mask appears to
> >>> be set up the same regardless, whereas for stack samples
> >>> (--call-graph=3Ddwarf) maybe just sample IP and SP suffices. So perha=
ps
> >>> there should be additional registers to set up the sample mask.
> >> Yes, that's true. It can be further optimized.
> >>
> >>
> >>> By avoiding the arch functions we can avoid the problem of broken
> >>> cross architecture support, we can also lay the groundwork for suppor=
t
> >>> on different architectures that may want to do similar things. I agre=
e
> >>> that doesn't matter until >1 architecture is trying to have more
> >>> register masks, my concern is trying to keep the code generic and
> >>> trying to make sure cross architecture is working. New weak functions
> >>> is going in the opposite direction to that.
> >> Yes, I agree we should git rid of these arch functions as much as poss=
ible.
> >> But for these architecture dependent code (as above shows), it seems t=
he
> >> __weak functions are still the simplest and best way to handle them.
> > So I don't think we should be putting functions that assume the
> > running machine into generic code like session. The arch functions
> > create a shortcut that avoids looking at the perf_event_attr,
> > differences between EM_I386 and EM_X86_64, etc. I'm not sure simpler
> > matters here, the code is just incorrect relative to how things are
> > being done around it. How do I grab registers on an APX capable
> > machine and then dump it on my non-APX laptop? How do the arch
> > functions account for the differences between EM_I386 and EM_X86_64,
> > both of which process types may be running on the machine at the same
> > time and having samples show up in system-wide mode? Having the arch
> > functions lets things be done wrong and the patch series shows that in
> > the very next patch.
> >
> > Thanks,
> > Ian
> >
> >> Thanks.
> >>
> >>> Thanks,
> >>> Ian
> >>>
> >>>> -Dapeng Mi
> >>>>
> >>>>> I also noticed that I think we're sampling the XMM registers for dw=
arf
> >>>>> unwinding, but it seems unlikely the XMM registers will hold stack
> >>>>> frame information - so this is probably an x86 inefficiency.
> >>>>>
> >>>>> Thanks,
> >>>>> Ian
> >>>>>
