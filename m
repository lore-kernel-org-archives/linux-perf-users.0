Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C553F0A8C
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 19:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791143839; cv=pass; b=UAKe5BmTq6Td/ie8DXg3IB86vbR8KA7M4cZQbfSPsIwZwCRKRYQuYICyW5n2hhqhsNLHj3EWhfbeXn1jIYH6sg5E2/tZatjb8xYiKDgEKUlnOoAJtx7si7F5SfFsrcpdTaEcPtJlYP1AVLipb0vtPCPZLwF+Jf0LhVKUQw4F1yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791143839; c=relaxed/simple;
	bh=/YxhJJOfk8LhrtN8rf3i6ByASX2d/JTy4zyMHoji1/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLGIfIue6Klv5b6T4PiUpYSUn1zPakMqng0bxnKz4BWxroISh/xehWagFpndMxKfDayduhTmFEUrwXAM1SGWS7kxUVciKYcCIMM1Q85Y90t3lUndt2/qNk3kNxHHTBS1TUXn+ahDfGfYMFVelZ9UDp5Gjsfrx7jBw7UNK5bQknc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=EVmIx3sN; arc=pass smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="EVmIx3sN"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-3a494638445so510418a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 04 Oct 2026 12:57:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791143836; cv=none;
        d=google.com; s=arc-20260327;
        b=hcWVOFQlb+u3qEM+lzXOXpO54QIG/dSEzae3DYI2XUAX4XkcFRhib2QuFyvbexTnL4
         WctKj5aBCS17h5jdcF6vQJPC7nErta0uUJaJ2MbZS2+SuXT3Nr5yCB3ZOvOTuc8GdPVe
         gpqTrtnQP3iJL0pbghJ5pQX7u/BEIzM6qtyqgamkMYXF1q8dEUfxB7qrAuIAoX/kFWrr
         RkzViy0yhnJK+NAaBAtKFIs1Ok3lDZd63GLkh642unGfq8vEFnC3nqaBdjprUqBoQl5G
         3PAisL26XCTKk54MUhIhna0mAdhA618YLvQl+qvGTRYZnRjrtWbiG9y8N6MWKjtl1fN8
         z9Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/piDQ/GD4Joce/NhAHq+0bOi7R0U3/eENCknMZ7zfbU=;
        fh=ysRdTsrnFxOnh9YzHZWbghRNOq6T56NcXoYJtQ6mgbY=;
        b=dtXBAClKTkhldms97JuiXgDUuj6snUk06HzvR7O4VYOGW7GSXd2bKacScO+YUnHsaA
         BDGozZyoXRWHQOAjImr6banNWMaISdpTl2hcSLGsMEnsdJf+aBcIpyOLhNz5y+AScC8+
         UxOF8MxOsVLQIdczb/SchjtERoqSQJXJrAksLlL6j7dlfPHGTOCpbJ5DFSpVcntPDncT
         SCAnC/YXoJq300eb/9LQZmouI+IS5roIX3V1txcV0KNmML54EJ8akTAzcHYtXPqfKKo5
         4y4Lu6eUwG6tuXin3KYytXmqq43leGr1ETNeVM2E/64gwg2JJtE4OTzjMUtUAxzaYDVC
         nlbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1791143836; x=1791748636; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/piDQ/GD4Joce/NhAHq+0bOi7R0U3/eENCknMZ7zfbU=;
        b=EVmIx3sNR2Osq3LDcz55ttui1ARLuqXbl4jc1vwwGFXoUdlj2+/yxNwDzH1BbAOpyz
         1kTtOWzKfDwp7kKnpiAcpEYl4LOWnvYHAEcpAOGPrtW3IATa9dNxmkgYVm/Y373gqAHO
         dKXVNp7uuDEAJrcxCqEjUCNgJXJWjBAclHS7q0JWyN7noEsL9WEHlWJ8OoTbPk59pZvk
         WaKu/ejehGG0qjzykBito+MQ33AXbobRANkxy6VPr8H/RzcgVYVfM3eT63iJE4UFT0v4
         1hn+EJzM/VUpupRBqL2oYpf6ZqSzng1SHi5vFEpRkSLnOJvTw6pgxuxmsiPgBMJ0jBD+
         1o6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791143836; x=1791748636;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/piDQ/GD4Joce/NhAHq+0bOi7R0U3/eENCknMZ7zfbU=;
        b=jplkOyJ66loZH6NcWlHy9uNbM5LUEaSzdEfHDZmSz2/kKNBHe42ZGCwrLmTjJFVBo/
         65KfjsrKJzaiSglkQ8VLBOqymbzXBkJDl3lCb1QU2z9yKX3FZ9pcuXsACcOYztzHXcSU
         ZdNFf0QOARh7b8ViibSQgPx8eiWG2KAZdic947AdWIMK7Y92/ETVR2VcXILVo3xZ+VVa
         i4JLFD4zwa35y7Ati0wuGK8S6NAEWcHvCuUJI7h5v97yhddltT8CfxP02cMdzTfddsZo
         4J6HxvXmbaZXGRSNwyNZVUX/0k2IcbV0ddIFYyF6py7wuf6y22XYStKba1byK7ltGSe5
         jp/g==
X-Forwarded-Encrypted: i=1; AKwUvBzPy2YgHPX3crdcSU9y2MlVbX1vbjVu2bBAt1UxLrKvNzZbJ0wW9ErVr2KzXpC5/H+4jOOX8+b1xziclFsEGwFU@vger.kernel.org
X-Gm-Message-State: AFq9FYJeh5AlEFpp0p7ZG4c4uBTQonispOdV3cO0QSneaQrFtG6kfUDm
	lgU9zBJqLkTFwANzYFATQbmYy1yOgTVhki298W2C0DWA4JgFd5+5i+Sk2kanrDz2RpshCr6mL0C
	CQdSRiUYAM6AWVtPP7eMHvALBFPHf+pHo/Ylrg7b1
X-Gm-Gg: AYBFou35xLRUwCJFLHDc9GLOzY57qYxborBXqxgiPvY6NBgzc0eVtBTws6Skv4JSw1U
	y1UZZnX/erWxcHtzVln1ee5FyNZs0H1o8+d2oYhevT0/SlSGFKEeVJWnBiTVmmZCfhcLSCyacc1
	yKtuFK32HRXolNX1BLQXikRxpPPN8x0IWJP9OQ5206lPRUPVBvwLidZAleTKskm/xFVaDwOozzE
	5CQK5Whht2jciaWZIbRBbOrosKsjDoKanf21TFNkSIHNGe1v7/OzuwhyXdqgr0EGNdu2HdfigrM
	Kqi6rr8hP3msPStv8rTNS8BV1V9bEIKkIYhEb3VRIWvgDEhkp8AQoqhBxit2qKqXCV2HE2K+/vW
	mfldim+I1IuM=
X-Received: by 2002:a17:902:f550:b0:2e5:70cd:b606 with SMTP id
 d9443c01a7336-2e571119743mr17718365ad.56.1791143836040; Sun, 04 Oct 2026
 12:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930210038.196928-1-yzhao62@ncsu.edu> <20260930210038.196928-4-yzhao62@ncsu.edu>
 <20260930211112.B2A431F000FF@smtp.kernel.org> <asA2rgBbNuwh-zR-@google.com>
In-Reply-To: <asA2rgBbNuwh-zR-@google.com>
From: Yanbo Zhao <yzhao62@ncsu.edu>
Date: Sun, 4 Oct 2026 15:57:05 -0400
X-Gm-Features: AclHuK8OqTuwHRlg7cibP1nTwimgKS070HMpOUhLnNJDI3Iy1fSgfGIWhabDzmc
Message-ID: <CA+J8vibM=6-wq2=1NgcBCZjbVyD-+pKq8Y2auUB0RtreLQUxmA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] perf annotate: Resolve C++ virtual function calls
 in x86 insn tracking
To: Namhyung Kim <namhyung@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Fri, Oct 02, 2026 at 03:56:46PM -0700, Namhyung Kim wrote:
> On Wed, Sep 30, 2026 at 09:11:12PM +0000, sashiko-bot@kernel.org wrote:
> > [Severity: Medium]
> > Will dividing the target's vtable byte offset by the host's sizeof(void=
 *)
> > compute an incorrect slot index when analyzing data from an architectur=
e
> > with a different pointer size?
>
> I think this is fine for now as we also have other places assuming the
> host pointer size.  We'll fix it later.

Ok, I'll keep it with the TODO comment.

> > [Severity: Medium]
> > Does this query the wrong vtable slot by ignoring the index register wh=
en
> > src->multi_regs is true?
>
> Multiple register is not handled well in the current code.  Dealing with
> dynamic index would require more careful instruction tracking.
>
> Anyway, it'd be safer to check !src->multi_regs here.

Will add.  I'll also add the same check where it marks a register as
the vtable pointer, since the offset doesn't tell the member with an
index register there either.

I'll send v3 with these changes.

Thanks,
Yanbo

On Fri, Oct 2, 2026 at 6:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Wed, Sep 30, 2026 at 09:11:12PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential is=
sue(s) to consider:
> > - [Medium] perf: cross-platform analysis broken by hardcoded host point=
er size
> > - [Medium] perf: vtable pointer load ignores multi-register index
> > --
> >
> > commit a71181b28893b295ef8ae1558faf7b1c66e3593b
> > Author: Yanbo Zhao <yzhao62@ncsu.edu>
> >
> > perf annotate: Resolve C++ virtual function calls in x86 insn tracking
> >
> > This commit introduces tracking of C++ virtual function calls by resolv=
ing
> > vtable pointer loads and virtual function calls through the vtable in x=
86
> > instruction state tracking. It enhances update_insn_state_x86() to hand=
le
> > TSR_KIND_VTABLE_PTR and TSR_KIND_VFUNC_PTR register states.
> >
> > > diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/per=
f/util/annotate-arch/annotate-x86.c
> > > index 1acf31a2c7597..d21192b74b6bf 100644
> > > --- a/tools/perf/util/annotate-arch/annotate-x86.c
> > > +++ b/tools/perf/util/annotate-arch/annotate-x86.c
> >
> > [ ... ]
> >
> > > @@ -216,6 +216,29 @@ static void invalidate_reg_state(struct type_sta=
te_reg *reg)
> > >     reg->copied_from =3D -1;
> > >  }
> > >
> > > +/*
> > > + * Get the return type of the C++ virtual function at the @offset in=
 the
> > > + * vtable of @class_die.  Returns false if it's not found or the fun=
ction
> > > + * returns void.
> > > + */
> > > +static bool vtable_get_rettype(Dwarf_Die *class_die, int offset,
> > > +                          Dwarf_Die *type_die)
> > > +{
> > > +   Dwarf_Die func_die;
> > > +   int index;
> > > +
> > > +   if (offset < 0)
> > > +           return false;
> > > +
> > > +   /* TODO: arch-dependent pointer size */
> > > +   index =3D offset / sizeof(void *);
> >
> > [Severity: Medium]
> > Will dividing the target's vtable byte offset by the host's sizeof(void=
 *)
> > compute an incorrect slot index when analyzing data from an architectur=
e
> > with a different pointer size?
> >
> > Relying on host execution details like sizeof(void *) breaks
> > cross-platform analysis (e.g., analyzing 32-bit x86 perf.data on a
> > 64-bit host).
>
> I think this is fine for now as we also have other places assuming the
> host pointer size.  We'll fix it later.
>
> >
> > > +
> > > +   if (die_find_virtual_func(class_die, index, &func_die) =3D=3D NUL=
L)
> > > +           return false;
> > > +
> > > +   return die_get_real_type(&func_die, type_die) !=3D NULL;
> > > +}
> > > +
> > >  static void update_insn_state_x86(struct type_state *state,
> >
> > [ ... ]
> >
> > > @@ -622,13 +669,38 @@ static void update_insn_state_x86(struct type_s=
tate *state,
> > >                     }
> > >                     pr_debug_type_name(&tsr->type, tsr->kind);
> > >             }
> > > +           /* Load a function pointer from the vtable (for 'call *%r=
eg') */
> > > +           else if (has_reg_type(state, sreg) && state->regs[sreg].o=
k &&
> > > +                    state->regs[sreg].kind =3D=3D TSR_KIND_VTABLE_PT=
R &&
> > > +                    vtable_get_rettype(&state->regs[sreg].type, src-=
>offset,
> > > +                                       &type_die)) {
> >
> > [Severity: Medium]
> > Does this query the wrong vtable slot by ignoring the index register wh=
en
> > src->multi_regs is true?
> >
> > If the operand is an indexed memory reference using multiple registers
> > (e.g., mov 0x8(%rbx, %rcx, 8), %rax), src->offset contains only the
> > static displacement part, not the dynamic index. Should this verify
> > !src->multi_regs before querying the DWARF vtable with src->offset?
>
> Multiple register is not handled well in the current code.  Dealing with
> dynamic index would require more careful instruction tracking.
>
> Anyway, it'd be safer to check !src->multi_regs here.
>
> Thanks,
> Namhyung
>
> >
> > > +                   tsr->type =3D type_die;
> > > +                   tsr->kind =3D TSR_KIND_VFUNC_PTR;
> > > +                   tsr->offset =3D 0;
> > > +                   tsr->ok =3D true;
> > > +
> > > +                   pr_debug_dtp("mov [%x] %#x(reg%d) -> reg%d",
> > > +                                insn_offset, src->offset, sreg, dst-=
>reg1);
> > > +                   pr_debug_type_name(&tsr->type, tsr->kind);
> > > +           }
> > >             /* And then dereference the pointer if it has one */
> >
> > [ ... ]
> >
> > > diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annota=
te-data.c
> > > index 8a9d3f2eec4dc..e9bf76cc28633 100644
> > > --- a/tools/perf/util/annotate-data.c
> > > +++ b/tools/perf/util/annotate-data.c
> >
> > [ ... ]
> >
> > > @@ -715,8 +723,11 @@ void set_stack_state(struct type_state_stack *st=
ack, int offset, u8 kind,
> > >                         Dwarf_Die *type_die, int ptr_offset)
> > >  {
> > >     Dwarf_Word size;
> > > +   bool is_pointer =3D (kind =3D=3D TSR_KIND_POINTER ||
> > > +                      kind =3D=3D TSR_KIND_VTABLE_PTR ||
> > > +                      kind =3D=3D TSR_KIND_VFUNC_PTR);
> > >
> > > -   if (kind =3D=3D TSR_KIND_POINTER) {
> > > +   if (is_pointer) {
> > >             /* TODO: arch-dependent pointer size */
> > >             size =3D sizeof(void *);
> > >     }
> >
> > [Severity: Medium]
> > Like the vtable_get_rettype() issue above, will hardcoding the host's
> > pointer size here corrupt the stack state tracking for the target
> > architecture?
> >
> > [ ... ]
> >
> > > diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> > > index 5478c134e7e3b..5d96ee4c866b6 100644
> > > --- a/tools/perf/util/disasm.c
> > > +++ b/tools/perf/util/disasm.c
> >
> > [ ... ]
> >
> > > @@ -300,6 +300,11 @@ static int call__parse(const struct arch *arch, =
struct ins_operands *ops, struct
> > >     if (tok !=3D NULL) {
> > >             endptr++;
> > >
> > > +           /* Save the operand (without '*') to extract register and=
 offset */
> > > +           ops->target.raw =3D strdup(tok + 1);
> >
> > [Severity: Low]
> > This is a pre-existing issue, but this file calls strdup() without
> > explicitly including <string.h>.
> >
> > Can we add the explicit <string.h> include? The perf subsystem guide st=
ates
> > that POSIX standard headers should be explicitly included to prevent mu=
sl
> > compilation failures from missing implicit inclusions.
> >
> > > +           if (ops->target.raw =3D=3D NULL)
> > > +                   return -1;
> > > +
> > >             /* Indirect call can use a non-rip register and offset: c=
allq  *0x8(%rbx).
> > >              * Do not parse such instruction.  */
> > >             if (strstr(endptr, "(%r") =3D=3D NULL)
> >
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930210038.=
196928-1-yzhao62@ncsu.edu?part=3D3
