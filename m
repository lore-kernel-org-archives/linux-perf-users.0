Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5F322A1E1
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 05:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768886186; cv=pass; b=eBi4qpZShM5d/hyeryThpHz2HMg1wGrNihAWuGRIvU6lMs5qRQkBdqIqoBhrOIgeqT3LWZpSQahjT7cWHB85f/xRAQkDfoYwJyDsiLOgifkLUMdyL1IQQsRLnm2F5elB3A0EhxRp6WJuiBn8j18gv0nqJ+w5V26FEHwhih9TbKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768886186; c=relaxed/simple;
	bh=llwkIu3VWigD2z5q0hSNsAczlj+ntwJnk1RxvXTvZ28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=siugg2s9ktODNWlMyFNDNKxpLCD7w/o4iR2pCtTXp57/8Tzn+GuvCplSx1NVTp0DE2NftX8ZwXKGIWdozKrim38Bm80sb7qAGmaRi0elnNJAlJS0HQEGnVaeG67Ks5HaNtOE1yK5CTKqH3pLw4cVXJ++BxMSGxi31RXoNm3+QHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b3S4aPgm; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b3S4aPgm"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a1462573caso180675ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2026 21:16:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768886184; cv=none;
        d=google.com; s=arc-20240605;
        b=HYpMsHZs+I8ja1Ctyh9B9N+Y7LoP/jjUSVQW+L2tfoMRsPS8xJFu+RUHSLvchVYweU
         4PQqaCOBB37+k102M+xQ8sk4o+izscl7BqTOoZAsTDSJvZcJ0ywKAVVFZXEDBO8rRLAT
         3A4vo1xm28GBD2ycpcVvuNMXmdAtBKxU2oVqpznDpf7NLqsRMiSgCE14m0tRnKqmZBF2
         en+do/Zc7T43kUEv/Zsn452Lm7gEcxM52dN+FDQJJPU6d/8dOQAKTTjlYOhnMCiYsYpq
         N4Zq3VpbsxYB/M2kwuC36w+CRubffY9mVxL449tdSNTvWLM3J5legN7MyZ1glbAoynAn
         /vhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6NfVjOXiYVgW8SuSfNQoLnCwDW5qipm595NPEV4deoQ=;
        fh=rNrkPCQJHURTs5macBzCCNm4/JF9uAQjOyQFO182yWA=;
        b=JbO12Ya5i7QPk6Vg6TUY8KbOcwVwY267WT/SnwOemYQKDouc9ZpXqMOqnP8693T/iv
         6He+D6nTzwTOBxXH2xhK3HN+L2nCNtkaXY/G7VXxL8BcJGxKJEeIcEFjh5pWbh7Ou8AQ
         +RCQSv1HKc0WkHpHfam3DrJ+tMyqxwgGda+HS/CfqiVcYZ/a1XKwnQOH0wTwk14nWlNF
         eqv4V27g+phjs9HdINg9iE6amBJd9xyZ6kC97QXO0V79htRN6yil4Hcqir/H8gbEawo1
         UQb0gTzBoEO1RkKpXUPH7/B/jg0E4XNr6BufX5qZwiPsRKnL2u4kXUL3LrreecPGhgpe
         zR6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768886184; x=1769490984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NfVjOXiYVgW8SuSfNQoLnCwDW5qipm595NPEV4deoQ=;
        b=b3S4aPgme3baO0EqNYEoyQ16UbHU0gqe6QGY9F/DqhNdYYVRbdqyeGgCfbIoyvY0Xl
         Di+8BAij5XkLJp55VxJcX6v5eHGjPcIj+RQ+PJiM9d7quBOSffAY6/mavY/LGYP4r7hT
         JB2XUsuHw0vuFzlqH/1prlv7O7kMe5B9aL5EB1/FIFYxbsZENaGQJ2nJTYJC4aCjmeyJ
         M3um+pjlkFtRu4hJid/dbbTvxHxDw0hJBDaDFgXwEdM/5ANANNl4GcpHOKziKbeRufu9
         NplOIuexqKFuu1wwh37F9w6zD980kxS9YwBA2X9hhxdn+6GKVIxGZT3oaS3nSPW+OHQK
         sIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768886184; x=1769490984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6NfVjOXiYVgW8SuSfNQoLnCwDW5qipm595NPEV4deoQ=;
        b=sxH0LUEpUwAOvGFuJ8+IPPDreJWcaei3aH6lPa3o4Qd0dlfrEhdm47ALMWhbgY7bkD
         qkjoqve2xM53qstKIaoNbE87MW69tq6BoR2GOT8T3Ex/lS0vrce+itssT9kLv7mGksfy
         pz1g8sJsKyabWZUfWygF+M4642bs2985hyBFHxwW/CDp4b+QRpJO7kIlkSxSZrGZ9BEe
         khUh5yVtEfZ0RRgyvR3JslrWYqF8Dz/HqVuKKqZoGxFTqLWTpSkfb3vMfQHJUFy+Iu8D
         EDGm2akUeOQ+9oJkLVaT22t3NaaBGBoxEjOPv2+au/PT8HEaksgckwfo3yWUVnh3JoCj
         NuQg==
X-Forwarded-Encrypted: i=1; AJvYcCXyE665WubqVA1eG8nr+qyG3IfJbDbpMlrI483AbQAoZAgqWbt8ZEjzcpsVvfHmqZmq6Sxn15Z6b0cFEb13WdNL@vger.kernel.org
X-Gm-Message-State: AOJu0YxrUFA1MmQ5j7TSk9KxWiMa7DzgSSmfvLfhRwQ/Fbo785qWfWQc
	KqK+qPGyZ3Xm8FZihOhPIItpOZ+KsZGfJdpjjFJRrjZmgV3abA/Y+7JdOkiqVtLs5H5lmq6M0TF
	VjJrVN6wNF79Y9HWwH0v6nDnyQQHS/c9L/nQcLbTb
X-Gm-Gg: AZuq6aJQS5xEDlx+WTKp62FgztmgdEOFIS/JZacl5cIckmf++kqT7QbndJP+MoeuhbB
	HMrViCQ6sBXeYdpFtF0WTSJEEP6D9VnNwnTWQAbyJQX22srm21J5+3b4yZxb5IxDc2y4xx3YThB
	ayVpJFHvCw7dPyVoDgRkDVvPFqBn9mb8ftGrN1aCP1HIPcIMDRGuGyq6uSluZo9GNWa60J743Ip
	q5xtTw9x4QiXyRvEPAqP5SgV1q//cTKifB98IcCVo8jAEThvBBCFTYXkXtUmuVX5ElV8vc5
X-Received: by 2002:a17:902:f68f:b0:291:6858:ee60 with SMTP id
 d9443c01a7336-2a728625c1fmr5763665ad.4.1768886183786; Mon, 19 Jan 2026
 21:16:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-19-dapeng1.mi@linux.intel.com> <CAP-5=fVk7+iGn+jhfE3a9iY_G1Gdph9Sh0RNco+745XQMfubLg@mail.gmail.com>
 <9d97e2f4-3971-4486-8689-ab50b06c3810@linux.intel.com> <CAP-5=fU+JeBqCNfKVR9O2cd0zzPO1bsYORtEBzeTeTpMLg4m5Q@mail.gmail.com>
 <0a99aaac-d51c-4c65-addd-5e366408a3f0@linux.intel.com> <CAP-5=fV_dbFzQ8_xHsduFytEq+6H0M0iPof0Krb0dBB+Bsd42g@mail.gmail.com>
 <3d95b037-e1c1-40db-b357-889c62c70221@linux.intel.com> <CAP-5=fW5g-_Owf2wWtXZwpbtTy9uns_pqr=BFumohHxWGU+i0Q@mail.gmail.com>
 <47014c3e-0fca-4248-9f23-09007f9ee95f@linux.intel.com> <CAP-5=fVbWp5bdnxrcA4XQPvFa2iYB3583C4DzOP7wA=oPqvcKQ@mail.gmail.com>
 <8b932ae4-5f65-454e-ae9e-0d9377a92254@linux.intel.com> <54c173b0-55f1-42d2-a43d-d6389d3fbfe3@linux.intel.com>
 <CAP-5=fV0iPapwbKX-rjbF86_WcZPji8opKNgO=r_kDSJB7T8XA@mail.gmail.com>
 <9f73d1f1-80f5-45ed-946f-6a920ba34980@linux.intel.com> <CAP-5=fUNeJpj-rdi+552-o9xhCiT41q-Q8Zhg8U7ev0Wbiyhog@mail.gmail.com>
 <478c90df-61a8-4e19-a640-931ce791fe97@linux.intel.com>
In-Reply-To: <478c90df-61a8-4e19-a640-931ce791fe97@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 19 Jan 2026 21:16:12 -0800
X-Gm-Features: AZwV_Qgym01bX_2n0SjEaPZ9iXsxOvam9Gl-T1bUqgKla6E2if7UY8R1p804UVI
Message-ID: <CAP-5=fXNTSA4wGW+HWS_UdV-iR940A1Td9wgyHOsVbhM0QjE3g@mail.gmail.com>
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

On Mon, Jan 19, 2026 at 7:05=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 1/20/2026 4:25 AM, Ian Rogers wrote:
> > On Sun, Jan 18, 2026 at 10:55=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.i=
ntel.com> wrote:
> >>
> >> On 1/17/2026 1:50 PM, Ian Rogers wrote:
> >>> On Mon, Jan 5, 2026 at 11:27=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.=
intel.com> wrote:
> >>>> Ian,
> >>>>
> >>>> I looked at these perf regs __weak helpers again, like
> >>>> arch__intr_reg_mask()/arch__user_reg_mask(). It could be really hard=
 to
> >>>> eliminate these __weak helpers and convert them into a generic funct=
ion
> >>>> like perf_reg_name(). All these __weak helpers are arch-dependent an=
d
> >>>> usually need to call perf_event_open sysctrl to get the required reg=
isters
> >>>> mask. So even we convert them into a generic function, we still have=
 no way
> >>>> to get the registers mask of a different arch, like get x86 register=
s mask
> >>>> on arm machine. Another reason is that these __weak helpers may cont=
ain
> >>>> some arch-specific instructions. If we want to convert them into a g=
eneral
> >>>> perf function like perf_reg_name(). It may cause building error sinc=
e these
> >>>> arch-specific instructions may not exist on the building machine.
> >>> Hi Dapeng,
> >>>
> >>> There was already a patch to better support cross architecture
> >>> libdw-unwind-ing and I've just sent out a series to clean this up so
> >>> that this is achieved by having mapping functions between perf and
> >>> dwarf register names. The functions use the e_machine of the binary t=
o
> >>> determine how to map, etc. The series is here:
> >>> https://lore.kernel.org/lkml/20260117052849.2205545-1-irogers@google.=
com/
> >>> and I think it can be the foundation for avoiding the weak functions.
> >> Hi Ian,
> >>
> >> Thanks for the reference patch. But they are different. The reference
> >> patches mainly parse the regs from perf.data and the __weak functions =
can
> >> be eliminated in the parsing phase since the registers bitmap is fixed=
 for
> >> a fixed arch. While these __weak functions
> >> arch__intr_reg_mask()/arch__user_reg_mask() are used to obtain the sup=
port
> >> sampling registers on a specific platform.
> >>
> >> We know different platforms even for same arch may support different
> >> registers, e.g., some x86 platforms may only support XMM registers, bu=
t
> >> some others may support XMM/YMM/ZMM registers, then all these arch-spe=
cific
> >> arch__intr_reg_mask()/arch__user_reg_mask() functions have to depend o=
n the
> >> perf_event_open() syscall to retrieve the supported registers mask fro=
m kernel.
> >>
> >> Thus, it becomes impossible to retrieve the supported registers mask f=
or a
> >> x86 specific platform from running on a arm platform.
> >>
> >> Even we don't consider this limitation and forcibly convert the
> >> __weak arch__intr_reg_mask() function to some kind of below function, =
just
> >> like currently what perf_reg_name() does.
> >>
> >> uint64_t perf_intr_reg_mask(const char *arch)
> >> {
> >>     uint64_t mask =3D 0;
> >>
> >>     if (!strcmp(arch, "csky"))
> >>         mask =3D perf_intr_reg_mask_csky(id);
> >>     else if (!strcmp(arch, "loongarch"))
> >>         mask =3D perf_intr_reg_mask_loongarch(id);
> >>     else if (!strcmp(arch, "mips"))
> >>         mask =3D perf_intr_reg_mask_mips(id);
> >>     else if (!strcmp(arch, "powerpc"))
> >>         mask =3D perf_intr_reg_mask_powerpc(id);
> >>     else if (!strcmp(arch, "riscv"))
> >>         mask =3D perf_intr_reg_mask_riscv(id);
> >>     else if (!strcmp(arch, "s390"))
> >>         mask =3D perf_intr_reg_mask_s390(id);
> >>     else if (!strcmp(arch, "x86"))
> >>         mask =3D perf_intr_reg_mask_x86(id);
> >>     else if (!strcmp(arch, "arm"))
> >>         mask =3D perf_intr_reg_mask_arm(id);
> >>     else if (!strcmp(arch, "arm64"))
> >>         mask =3D perf_intr_reg_mask_arm64(id);
> >>
> >>     return mask;
> >> }
> >>
> >> But currently there are some arch-dependent instructions in these
> >> arch-specific instructions, like the below code in powerpc specific
> >> arch__intr_reg_mask().
> >>
> >>     version =3D (((mfspr(SPRN_PVR)) >>  16) & 0xFFFF);
> >>
> >> mfspr is a powerpc specific instruction, building this converted
> >> perf_intr_reg_mask on non-powerpc platform would lead to building erro=
r.
> > Hi Dapeng,
> >
> > So my main point is the arch directory and ifdefs, how do they differ
> > from writing code that uses the ELF machine? For example, your code
> > uses the arch/x86 directory and has ifdefs on
> > HAVE_ARCH_X86_64_SUPPORT. How is that different from:
> > ```
> > switch(e_machine) {
> > case EM_X86_64:
> > ...
> > case EM_I386:
> > ...
> > default:
> > return 0;
> > }
> > ```
> > If we need to determine for the current running machine then e_machine
> > can equal EM_HOST that is set up for this purpose.
>
> I think the key factor that determines if we can convert the code into
> above e_machine switch ... case format is whether the code is
> architecture-dependent both in building and execution phases.
>
> If the code is not architecture-dependent, It's good to covert the code
> into the e_machine switch ... case and that would provide better applicab=
ility.
>
> Otherwise, the architecture-dependent code would lead to the building err=
or
> (building phase) or get incorrect execution results (execution phase).
>
> Even if we introduce EM_HOST case, it won't really solve the building
> error,  instead it may introduce new building error, e.g.,
>
> ```
> switch(e_machine) {
> case EM_HOST:
> ...
> case EM_X86_64:
> ...
> case EM_I386:
> ...
> default:
> return 0;
> }
> ```

No, you wouldn't put EM_HOST as a case statement ever. It is the value
of the ELF machine you are compiling upon, so either EM_X86_64 or
EM_I386 here. You would make `e_machine =3D EM_HOST` were you to want
some which is specific to the host you are compiling upon. ie `if
(EM_HOST =3D=3D EM_X86_64 || EM_HOST =3D=3D EM_I386) { ... }` would be
equivalent to `#ifdef __x86_64__` or equivalent to putting code into
the arch/x86 directory.

> Assume the code is built on a x86_64 machine, then EM_HOST equals
> EM_X86_64, that would cause the "duplicate case value" building error.
>
> If we want to limit the architecture-dependent code is built only on the
> correct architecture, then we still have to introduce the architecture
> #ifdefs. This is actually no difference with current arch directory __wea=
k
> functions and make it more complex.

If we have arch functions for  arch__user_simd_reg_mask then why would
code go through the usual means to determine what the mask is? The
normal means is to get a sample event, use evsel__parse_sample and
then from the sample access struct regs_dump that has within it keeps
a copy of the mask from perf_event_attr associated with the evsel.

In your next patch you do:
https://lore.kernel.org/lkml/20251203065500.2597594-20-dapeng1.mi@linux.int=
el.com/
```
...
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
...
+static void simd_regs_dump__printf(struct regs_dump *regs, bool intr)
+{
...
+ if (intr)
+ arch__intr_simd_reg_bitmap_qwords(reg_idx, &qwords);
+ else
+ arch__user_simd_reg_bitmap_qwords(reg_idx, &qwords);
...
 ```
The session code is generic, it may be dealing with live machine data
or with a perf.data file from anywhere. The reason this patch is
exposing these weak functions is for the next patch, there's not a use
here. But why isn't the next patch using struct regs_dump? The struct
regs_dump was set up with sample event and perf_event_attr on hand.
The evsel__parse_sample logic should likely set up a qwords variable
so the generic code can just do:
```
qwords =3D regs->qwords;
```
The parsing logic should be able to do "nr_vectors * vector_qwords +
nr_pred * pred_qwords" from the perf_event_attr no?

> >
> > I agree that determining features needs calls that may not be
> > supported on other architectures. That should yield EOPNOTSUPP and we
> > can use information like that to populate generic information like the
> > PMU missing features:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/pmu.h?h=3Dperf-tools-next#n190
> > we also probe API support with:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/perf_api_probe.h?h=3Dperf-tools-next
>
> In general, I agree we can return EOPNOTSUPP or some generic information
> for some architecture independent code. But it's not applicable for these=
 2
> specific arch__intr_reg_mask()/arch__user_reg_mask() functions, current
> perf code depends on these 2 functions to return the supported registers
> mask on a specific (running) platform.

You can't put code into generic code like session and assume the
perf.data is for the running machine, so the design is wrong.

> >
> > The current code doing lots of string comparisons is unnecessary
> > overhead and imprecise (x86 is used for both 32-bit and 64-bit x86).
> > It is removed in the series I linked to, I think we can eventually get
> > rid of the whole arch string for similar reasons of trying to minimize
> > the use of the arch directory. I'm curious what happens with APX, will
> > the e_machine change? We may need to pass in the sample regs_dump's
> > abi field for cases like this.
>
> Yes, I agree we should git rid of the arch-string comparison and minimize
> the use of arch directory. It would improve the efficiency.
>
> I don't think the support of APX would change the e_machine, it should
> still be EM_X86_64.
>
> Yes, we need the abi filed (exactly PERF_SAMPLE_REGS_ABI_SIMD) to determi=
ne
> it's APX or legacy XMM.

Right, in my (unmerged) code to map a perf register to a dwarf register:
https://lore.kernel.org/lkml/20260117052849.2205545-13-irogers@google.com/
we'll need the abi field.

> >
> > My point on the unwinding is that the sample register mask appears to
> > be set up the same regardless, whereas for stack samples
> > (--call-graph=3Ddwarf) maybe just sample IP and SP suffices. So perhaps
> > there should be additional registers to set up the sample mask.
>
> Yes, that's true. It can be further optimized.
>
>
> >
> > By avoiding the arch functions we can avoid the problem of broken
> > cross architecture support, we can also lay the groundwork for support
> > on different architectures that may want to do similar things. I agree
> > that doesn't matter until >1 architecture is trying to have more
> > register masks, my concern is trying to keep the code generic and
> > trying to make sure cross architecture is working. New weak functions
> > is going in the opposite direction to that.
>
> Yes, I agree we should git rid of these arch functions as much as possibl=
e.
> But for these architecture dependent code (as above shows), it seems the
> __weak functions are still the simplest and best way to handle them.

So I don't think we should be putting functions that assume the
running machine into generic code like session. The arch functions
create a shortcut that avoids looking at the perf_event_attr,
differences between EM_I386 and EM_X86_64, etc. I'm not sure simpler
matters here, the code is just incorrect relative to how things are
being done around it. How do I grab registers on an APX capable
machine and then dump it on my non-APX laptop? How do the arch
functions account for the differences between EM_I386 and EM_X86_64,
both of which process types may be running on the machine at the same
time and having samples show up in system-wide mode? Having the arch
functions lets things be done wrong and the patch series shows that in
the very next patch.

Thanks,
Ian

> Thanks.
>
> >
> > Thanks,
> > Ian
> >
> >> -Dapeng Mi
> >>
> >>> I also noticed that I think we're sampling the XMM registers for dwar=
f
> >>> unwinding, but it seems unlikely the XMM registers will hold stack
> >>> frame information - so this is probably an x86 inefficiency.
> >>>
> >>> Thanks,
> >>> Ian
> >>>
