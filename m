Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793127110;
	b=dAOiYGT4P7WHFKcPrOHTSuGZ5idWgbX4GQG1jd7o57imMJtevU53WHeLN9E0n4uX3IrQ
	 mzskdYiqMnzMdBSL88LvbdLpBAWtufT/l5x3jH61LwN9c6aVyF3WbAtusUBxfQ8IUsuLs
	 otjubCVuebLz0yjDvnPcLXTglXcKo2WsbGQNWSlamkNyBVQxJCQvR4SvK/U5WThmFdmwr
	 Kw+ckwHEF6ICB+0X6tpnOoXz7LD/TuIQ5VTVhC4EzDjAfzt2xeI2YQFHdWXp7IrkNq79H
	 jF7ZwtO7uCuYGgSgbJxwb84SD/inENYL1deOtqzTxEPFmW3+RR+NMB+nHwIkGtHDelg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127110;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=VowkarhRy+wyYk7debMMQ6GaJuZ7tKs1u3+zocTMjdM=;
	b=q7fHJB1sZJ6Qi+4db9MKP15WubILdb599187BTwhocW49FmCR7lEYdN0rjBzr19Cjo1d
	 ilsIAO7l4FmwAzJpbj61DrD2ahWW4wEDyN2PIP3/VLRFK/jKoSkvsNPPbG9fpJJf6rcOo
	 7phGvl6ZeDt4rGLWCuou3pVakU2vmmZkOrBvRzdjxo+h4AdbCLQHm90Scc4zdUVtWA/tI
	 VJ+tt9RYlz+AWsRB7Em8s+B7G6GUyru/aTBIbTtdsWL0hRFHPltKexr0CGAVgF0SCMpAo
	 o8ZR9rSgrx6nypCb81NCSL6qIWzMISJAJMhkTpILANL6JIl56MRsZdV7CEHsq3QBu8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TvTNHJCa;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qvNzn01Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F283606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 18:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F283606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TvTNHJCa;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qvNzn01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793127108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VowkarhRy+wyYk7debMMQ6GaJuZ7tKs1u3+zocTMjdM=;
	b=TvTNHJCaNVj7WrnH1eMGFC/KSx0cJXtecYVMpOiahXMRfYCrlI8x7pzNA0arorFCUjcvlO
	nBA9KKf0DaFTkSYFIJHYz5BPbdw9QA8bbtAAJv02spdgwI/6Pc0Kol2mTjh8Yr3O4g0yg+
	KZ/krZizRcwoQXsomSCScuVI2QrZhSk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-xgui6DgYPTSf_umimzx_Fw-1; Tue, 27 Oct 2026 14:51:46 -0400
X-MC-Unique: xgui6DgYPTSf_umimzx_Fw-1
X-Mimecast-MFC-AGG-ID: xgui6DgYPTSf_umimzx_Fw_1793127105
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a0284121c6so1053165e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 11:51:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793127105; cv=none;
        d=google.com; s=arc-20260327;
        b=XWt7BNtEtXGiO0P34eQf6ofYTso98RxuE8v+6WB9vdrNs2T3lfA9fRqTdDekSaTRPV
         TGhPORnKpB+Ju3/4WzTDju1HjkvYTMKyUizGbeQnxTHTBbNpyNwZWJoJuvrQK3c9d8mn
         jUY6vIfNUDdP1cyUkwBBV0ZrgNi5G5D5gLwD25Qreg2PiwhDQgmViMShaaCiMDB0Na6e
         gtBdZviF0VDFjOvQDh662kzTAdFP33QumSxyX+QolfqCo5xsyvn6kXfXAmryCj0gdkii
         G3W9db+Cbk2uDk3ZhyszjnnYLPExfKIiKRW670zes6Sob52oDe6B+g+zqsn2SDTSj1NF
         sLbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VowkarhRy+wyYk7debMMQ6GaJuZ7tKs1u3+zocTMjdM=;
        fh=xUiQ0jAP237VapEV+EpVYd2/qeqQQEy/NK5XMrHK5u0=;
        b=GQp+0JAkyYmwheAZ6j72w2SrObNkHbYut9OUMMOWugZlQW8wSUCaCG2/NByHnoZj6E
         SswUva+TtwZ0PbGItwHreSfKDVlbT7ZhwjPi1jG2cAeLyvRlE1nhogvmtX37m2IOrzzI
         6IXel44ZDUyRobqt9Sc3H9h+iJXAJAbkRyhYMa6KxnHP/qrJu8/akTh1wG1cbfVeDH3w
         BXzqT7/zBrmoJnmXxdCVTY2TREb403YyxMzioqXNCAtgmHn7EU+hQNmR6tR9V2GcX899
         ilwfVM0Yon/N+20BzO+G5VHwpMWWhxfomOg2nSfo0CxlCPilZ7qNVoGOlHapt5vsbWtU
         sMOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793127105; x=1793731905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VowkarhRy+wyYk7debMMQ6GaJuZ7tKs1u3+zocTMjdM=;
        b=qvNzn01QewEa9B3y8xsWetbDNOWfa7Gim81DamWsYr3KBZRe5eDDx7sKYOCxIwu6IL
         o0mPoQJZtOOwarJb47bo6iX3BgTkmKkv3QFWZcIaRj2oQ7pEXO8qUBgfsfO3bggYnGnz
         ICvCNj1wtZBoI/wSS6DrIbTzgjO1Ins6u3llraPqObA98izefXjlllFufy3sGqJ8kADi
         kiCcWNDETU4dpUhlN3L1xmx6HyamChzZhxKE8Smkt5A4rqPgX9E+NambysyTZz5sQSpA
         i4ZRJ1PM4p8CZkV2rIUlNPPzaSQlUyxP+rhMpI5nKMZVKzLfgpWWwf9zI3pxnIuuGXCX
         R4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793127105; x=1793731905;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VowkarhRy+wyYk7debMMQ6GaJuZ7tKs1u3+zocTMjdM=;
        b=y+/fey9lERZrF+Hysff9gWeg1UBn9dbWEm1RM71wxJ5Hc4SJXysZSCcIXkfdG80TA7
         NfvrWPmYJj02Oo+yCWvar9CLS0///Xz1NXyhO+qCijmoMg55l74RY6LmHXN3WhktXIk/
         1VieN5s35YErrOlLryZsidpa8g989klRetuy7g6wWqSZifdcXV1qDKysLr/M1xdXbvV8
         NbfhkpYSse4WGGCEK7cK0KwA6tgdSyFz9GLdn+ssGhDwqsjMnstOf/QzKpHcWFEeQA3z
         0LrahT2rI4GA6gKc5ManaVjsBoh6EtkI2EJ7g17ZcBDlKxpXIr+CJGGKyQqmWA5bM7EZ
         PDSA==
X-Forwarded-Encrypted: i=1; AKwUvBwnWcRiVr93L8/vHzPmcPf61QaICULwWD5lwTwEWGFerEyucFNzGiyw1Kr8CP78mgypU+ZHqZOusf3rjWwgoqjz@vger.kernel.org
X-Gm-Message-State: AFq9FYJTF+N3jOAfpR/zjCktUaSPrmslK8hY1EpOpd6iaSwIgpwRpAMX
	7wJCWL8aUqo+xpxhckEtfXDkD9bD9AAoX72/vwWof0rVc/tH/s1aBuDu6aViDURLiMF5aNhUpGu
	JzgW1nixZxsTxhlyb04P9pX9wn/oejwrCScecuYu46z3zn3v7O925dBfQArjahsq6nE0buHu8AG
	f48rFqHJg+mOaaT5xg5JsTy99kZHZa4Op1O8R45NiX9muroA==
X-Gm-Gg: AYBFou2Hl8GA81omn2HP7BnVx3pPZxj6t2/QN18Si+VoTVSK3r2DXoueoxzmo/aWqe3
	/ELLWa3qlzxkaVN1zEvcmjzS4E5u5R9YidiaLH7rrLy+Fz4msfCppo/gQjjJcPBbEZv0VWtSUHM
	qXagbbyP9CODYTnD9RWRJjR7Mx9mbzkUmbR2G3ty5eZaG1+rVcPw3G7yXIrO5p/xQgY0sCDehco
	NQoqjcq5ULMVrs+pQ==
X-Received: by 2002:a05:600c:c0c8:b0:4a4:de70:2ad4 with SMTP id 5b1f17b1804b1-4a4de702b8bmr144770495e9.22.1793127105326;
        Tue, 27 Oct 2026 11:51:45 -0700 (PDT)
X-Received: by 2002:a05:600c:c0c8:b0:4a4:de70:2ad4 with SMTP id
 5b1f17b1804b1-4a4de702b8bmr144770135e9.22.1793127104828; Tue, 27 Oct 2026
 11:51:44 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930063919.608911-1-himanshu.chauhan@oss.qualcomm.com> <20260930063919.608911-6-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20260930063919.608911-6-himanshu.chauhan@oss.qualcomm.com>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Tue, 27 Oct 2026 14:51:33 -0400
X-Gm-Features: AclHuK_RAmNTbd9qUrgxKaN7aTyMXm7OhG7N52ynsHJnVZgYoTv4uxMNIpbxeGY
Message-ID: <CADRr4bdeQS8jXdBY3Q9VJ8rJW928=gO=qXRJPGHBp2ZyCf02FA@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] RISC-V: Add fetch and decode helpers to a common file
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	alex@ghiti.fr, aou@eecs.berkeley.edu, palmer@dabbelt.com, pjw@kernel.org, 
	qingfang.deng@linux.dev, shuah@kernel.org, thecharlesjenkins@gmail.com, 
	cp0613@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 2:40=E2=80=AFAM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> Move get_insn() and __read_insn() from traps_misaligned.c
>
> Add helpers for RISC-V register access and control-flow emulation
>
> Add helpers to retrieve RISC-V register values, calcuate the next
> execution address based on current pc, register states and by evaluating
> conditional branch instructions. the helpers accommodate both compressed
> and standard instructions. Add helper to determine is brach will be taken
> by current pc. It supports register-based jumps, immediate jumps, BEQZ/BN=
EZ
> conditional branches, and signed and unsigned comparisons for standard
> conditional branch instructions.
>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> Co-developed-by: Jesse Taube <jtaubepe@redhat.com>
> ---
>  arch/riscv/include/asm/insn.h        |  15 ++
>  arch/riscv/kernel/traps_misaligned.c |  52 +-----
>  arch/riscv/lib/Makefile              |   1 +
>  arch/riscv/lib/insn.c                | 263 +++++++++++++++++++++++++++
>  4 files changed, 280 insertions(+), 51 deletions(-)
>  create mode 100644 arch/riscv/lib/insn.c
>
> diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.=
h
> index c3005573e8c9..b2125728d4e9 100644
> --- a/arch/riscv/include/asm/insn.h
> +++ b/arch/riscv/include/asm/insn.h
> @@ -227,9 +227,16 @@
>  #define RVC_MASK_C_EBREAK      0xffff
>  #define RVG_MASK_EBREAK                0xffffffff
>  #define RVG_MASK_SRET          0xffffffff
> +#define RVC_MASK_INSN          GENMASK(15, 0)
>
>  #define __INSN_LENGTH_MASK     _UL(0x3)
>  #define __INSN_LENGTH_GE_32    _UL(0x3)
> +
> +static __always_inline bool riscv_insn_is_compressed(u32 code)
> +{
> +       return (code & (__INSN_LENGTH_MASK)) !=3D (__INSN_LENGTH_GE_32);
> +}
> +
>  #define __INSN_OPCODE_MASK     _UL(0x7F)
>  #define __INSN_BRANCH_OPCODE   _UL(RVG_OPCODE_BRANCH)
>
> @@ -600,4 +607,12 @@ static inline void riscv_insn_insert_utype_itype_imm=
(u32 *utype_insn, u32 *itype
>         *utype_insn |=3D (imm & RV_U_IMM_31_12_MASK) + ((imm & BIT(11)) <=
< 1);
>         *itype_insn |=3D ((imm & RV_I_IMM_11_0_MASK) << RV_I_IMM_11_0_OPO=
FF);
>  }
> +#ifndef __ASSEMBLY__
> +#include <asm/ptrace.h>
> +
> +int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn);
> +int get_insn_safe(struct pt_regs *regs, ulong epc, ulong *r_insn);
> +unsigned long get_next_insn_address(struct pt_regs *regs, ulong insn, ul=
ong pc);
> +#endif /* __ASSEMBLY__ */
> +
>  #endif /* _ASM_RISCV_INSN_H */
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/tra=
ps_misaligned.c
> index 6e8ae6c66322..541e6a5b8039 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -10,6 +10,7 @@
>  #include <linux/irq.h>
>  #include <linux/stringify.h>
>
> +#include <asm/insn.h>
>  #include <asm/processor.h>
>  #include <asm/ptrace.h>
>  #include <asm/csr.h>
> @@ -129,57 +130,6 @@ static unsigned long get_f32_rs(unsigned long insn, =
u8 fp_reg_offset,
>  #define GET_F32_RS2C(insn, regs) (get_f32_rs(insn, 2, regs))
>  #define GET_F32_RS2S(insn, regs) (get_f32_rs(RVC_RS2S(insn), 0, regs))
>
> -#define __read_insn(regs, insn, insn_addr, type)       \
> -({                                                     \
> -       int __ret;                                      \
> -                                                       \
> -       if (user_mode(regs)) {                          \
> -               __ret =3D get_user(insn, (type __user *) insn_addr); \
> -       } else {                                        \
> -               insn =3D *(type *)insn_addr;              \
> -               __ret =3D 0;                              \
> -       }                                               \
> -                                                       \
> -       __ret;                                          \
> -})
> -
> -static inline int get_insn(struct pt_regs *regs, ulong epc, ulong *r_ins=
n)
> -{
> -       ulong insn =3D 0;
> -
> -       if (epc & 0x2) {
> -               ulong tmp =3D 0;
> -
> -               if (__read_insn(regs, insn, epc, u16))
> -                       return -EFAULT;
> -               /* __get_user() uses regular "lw" which sign extend the l=
oaded
> -                * value make sure to clear higher order bits in case we =
"or" it
> -                * below with the upper 16 bits half.
> -                */
> -               insn &=3D GENMASK(15, 0);
> -               if ((insn & __INSN_LENGTH_MASK) !=3D __INSN_LENGTH_32) {
> -                       *r_insn =3D insn;
> -                       return 0;
> -               }
> -               epc +=3D sizeof(u16);
> -               if (__read_insn(regs, tmp, epc, u16))
> -                       return -EFAULT;
> -               *r_insn =3D (tmp << 16) | insn;
> -
> -               return 0;
> -       } else {
> -               if (__read_insn(regs, insn, epc, u32))
> -                       return -EFAULT;
> -               if ((insn & __INSN_LENGTH_MASK) =3D=3D __INSN_LENGTH_32) =
{
> -                       *r_insn =3D insn;
> -                       return 0;
> -               }
> -               insn &=3D GENMASK(15, 0);
> -               *r_insn =3D insn;
> -
> -               return 0;
> -       }
> -}
>
>  union reg_data {
>         u8 data_bytes[8];
> diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
> index f668b98970bd..84cdd35afa42 100644
> --- a/arch/riscv/lib/Makefile
> +++ b/arch/riscv/lib/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  lib-y                  +=3D delay.o
> +lib-y                  +=3D insn.o
>  lib-y                  +=3D memcpy.o
>  lib-y                  +=3D memset.o
>  lib-y                  +=3D memmove.o
> diff --git a/arch/riscv/lib/insn.c b/arch/riscv/lib/insn.c
> new file mode 100644
> index 000000000000..361cac7abe10
> --- /dev/null
> +++ b/arch/riscv/lib/insn.c
> @@ -0,0 +1,263 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2026 Qualcomm Technoloies, Inc.
> + */
> +
> +#include <linux/uaccess.h>
> +
> +#include <asm/insn.h>
> +#include <asm/ptrace.h>
> +#include <asm/uaccess.h>
> +
> +/**
> + * __fetch_insn() - Fetch a RISC-V instruction parcel from memory
> + * @regs: Register state used to determine the access context
> + * @insn: Variable receiving the instruction value
> + * @insn_addr: Address from which to read the instruction parcel
> + * @type: Instruction parcel type, either @u16 or @u32
> + *
> + * Fetches an instruction parcel from user or kernel memory, depending o=
n the
> + * execution context indicated by @regs. RISC-V instruction parcels are
> + * stored in little-endian byte order, so the fetched value is converted=
 from
> + * little-endian to the native CPU representation before being assigned =
to
> + * @insn.
> + *
> + * The conversion is a no-op on little-endian targets and performs the
> + * required byte swap on big-endian targets.
> + *
> + * Return: 0 on success, or a negative error code if reading user memory
> + *         fails.
> + */
> +#define __fetch_insn(regs, insn, insn_addr, type)              \
> +({                                                             \
> +       type __val;                                             \
> +       int __ret;                                              \
> +                                                               \
> +       if (user_mode(regs))                                    \
> +               __ret =3D get_user(__val,                         \
> +                                (type __user *)(insn_addr));   \
> +       else {                                                  \
> +               __val =3D *(type *)(insn_addr);                   \
> +               __ret =3D 0;                                      \
> +       }                                                       \
> +                                                               \
> +       if (!__ret) {                                           \
> +               if (sizeof(type) =3D=3D sizeof(u16))                     =
   \
> +                       (insn) =3D le16_to_cpu((__force __le16)__val);   =
 \
> +               else                                                    \
> +                       (insn) =3D le32_to_cpu((__force __le32)__val);   =
 \
> +       }                                                       \
> +                                                               \
> +       __ret;                                                  \
> +})
> +
> +/**
> + * get_insn() - Fetch and decode a RISC-V instruction
> + * @regs: Register state used for instruction access
> + * @epc: Address of the instruction to fetch
> + * @r_insn: Pointer to store the fetched instruction encoding
> + *
> + * Fetches the instruction at @epc and stores its encoding in @r_insn.
> + * Both standard 32-bit instructions and compressed 16-bit instructions =
are
> + * supported. If a 32-bit instruction is split across two 16-bit instruc=
tion
> + * accesses, the halfwords are combined into a single instruction encodi=
ng.
> + *
> + * Return: 0 on success, or %-EFAULT if instruction access fails.
> + */
> +int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
> +{
> +       ulong insn, tmp;
> +
> +       if (!(epc & 0x2)) {
> +               if (__fetch_insn(regs, insn, epc, u32))
> +                       return -EFAULT;
> +
> +               if (riscv_insn_is_compressed(insn))
> +                       insn &=3D RVC_MASK_INSN;
> +
> +               *r_insn =3D insn;
> +               return 0;
> +       }
> +
> +       if (__fetch_insn(regs, insn, epc, u16))
> +               return -EFAULT;
> +
> +       insn &=3D RVC_MASK_INSN;
> +       if (riscv_insn_is_compressed(insn)) {
> +               *r_insn =3D insn;
> +               return 0;
> +       }
> +
> +       if (__fetch_insn(regs, tmp, epc + sizeof(u16), u16))
> +               return -EFAULT;
> +
> +       *r_insn =3D (tmp << 16) | insn;
> +
> +       return 0;
> +}
> +
> +int get_insn_safe(struct pt_regs *regs, ulong epc, ulong *r_insn)
> +{
> +       int ret;
> +
> +       pagefault_disable();
> +       ret =3D get_insn(regs, epc, r_insn);
> +       pagefault_enable();
> +
> +       return ret;
> +}
> +
> +/**
> + * riscv_get_reg_value() - Get the value stored the given RISC-V registe=
r number
> + * @regs: Register state containing the saved register values
> + * @regno: RISC-V register number
> + *
> + * Returns the value of the RISC-V register identified by @regno. Regist=
er
> + * x0 always returns zero, as required by the RISC-V ISA.
> + *
> + * Return: The register value, or zero if @regno is zero.
> + */
> +static unsigned long riscv_get_reg_value(struct pt_regs *regs, unsigned =
int regno)
> +{
> +       return regno ? regs_get_register(regs, regno * sizeof(unsigned lo=
ng)) : 0;
> +}
> +
> +/**
> + * get_next_insn_address_compressed() - Calculate the next address for a=
 compressed
> + * RISC-V instruction
> + * @regs: Register state used to evaluate indirect jumps and conditional
> + *        branches
> + * @insn: Compressed RISC-V instruction encoding
> + * @pc: Current program counter
> + *
> + * Determines the address at which execution should continue after proce=
ssing
> + * the compressed instruction in @insn. Indirect jumps use the value of =
the
> + * instruction's source register, unconditional jumps use the encoded
> + * immediate, and conditional branches evaluate the relevant register va=
lue.
> + *
> + * For a branch that is not taken, or for an unsupported compressed
> + * instruction, the address of the following 16-bit instruction is retur=
ned.
> + *
> + * Return: The next instruction address.
> + */
> +static unsigned long get_next_insn_address_compressed(struct pt_regs *re=
gs, u32 insn,
> +                                                     unsigned long pc)
> +{
> +       unsigned int rs1_num;
> +
> +       if (riscv_insn_is_c_jalr(insn) || riscv_insn_is_c_jr(insn)) {
> +               rs1_num =3D RV_X(insn, RVC_C2_RS1_OPOFF, 5);
Use RVC_EXTRACT_C2_RS1_REG here.
In the other places where it extracts the register it should use
RVC/RV_EXTRACT_*_REG

Otherwise LGTM.

Thanks,
Jesse Taube

> +               return regs_get_register(regs, rs1_num * sizeof(unsigned =
long));
> +       }
> +
> +       if (riscv_insn_is_c_j(insn) || riscv_insn_is_c_jal(insn))
> +               return RVC_EXTRACT_JTYPE_IMM(insn) + pc;
> +
> +       if (riscv_insn_is_c_beqz(insn)) {
> +               rs1_num =3D RV_X(insn, RVC_C1_RS1_OPOFF, 3) + 8;
> +               if (!rs1_num || riscv_get_reg_value(regs, rs1_num) =3D=3D=
 0)
> +                       return RVC_EXTRACT_BTYPE_IMM(insn) + pc;
> +               return pc + 2;
> +       }
> +
> +       if (riscv_insn_is_c_bnez(insn)) {
> +               rs1_num =3D RV_X(insn, RVC_C1_RS1_OPOFF, 3) + 8;
> +               if (rs1_num && riscv_get_reg_value(regs, rs1_num) !=3D 0)
> +                       return RVC_EXTRACT_BTYPE_IMM(insn) + pc;
> +               return pc + 2;
> +       }
> +
> +       return pc + 2;
> +}
> +
> +/**
> + * riscv_branch_taken() - Determine whether a RISC-V conditional branch =
is taken
> + * @regs: Register state used to obtain the source operand values
> + * @insn: RISC-V branch instruction encoding
> + *
> + * Evaluates the branch condition encoded in @insn using the values of i=
ts
> + * source registers from @regs. Signed comparisons are used for BLT and =
BGE,
> + * while unsigned comparisons are used for BLTU and BGEU.
> + *
> + * Return: %true if the branch condition is satisfied, or %false otherwi=
se.
> + *         Unsupported branch instructions also return %false.
> + */
> +static bool riscv_branch_taken(struct pt_regs *regs, u32 insn)
> +{
> +       unsigned int rs1_num =3D RV_X(insn, RVG_RS1_OPOFF, 5);
> +       unsigned int rs2_num =3D RV_X(insn, RVG_RS2_OPOFF, 5);
> +       unsigned long rs1_val =3D riscv_get_reg_value(regs, rs1_num);
> +       unsigned long rs2_val =3D riscv_get_reg_value(regs, rs2_num);
> +
> +       if (riscv_insn_is_beq(insn))
> +               return rs1_val =3D=3D rs2_val;
> +       if (riscv_insn_is_bne(insn))
> +               return rs1_val !=3D rs2_val;
> +       if (riscv_insn_is_blt(insn))
> +               return (long)rs1_val < (long)rs2_val;
> +       if (riscv_insn_is_bge(insn))
> +               return (long)rs1_val >=3D (long)rs2_val;
> +       if (riscv_insn_is_bltu(insn))
> +               return rs1_val < rs2_val;
> +       if (riscv_insn_is_bgeu(insn))
> +               return rs1_val >=3D rs2_val;
> +
> +       return false;
> +}
> +
> +/**
> +* get_next_insn_address_standard() - Compute the next PC for standard RI=
SC-V
> +* control-flow instructions
> +*
> +* @regs: Register state of the current context.
> +* @insn: Instruction located at @pc.
> +* @pc: Address of the current instruction.
> +*
> +* Determine the address of the next instruction to be executed after @in=
sn.
> +* The function evaluates control-flow instructions whose target cannot b=
e
> +* obtained by simply advancing the program counter:
> +*
> +* - Conditional branches: returns either the branch target or @pc + 4
> +* depending on the branch outcome.
> +* - JAL: returns the jump target encoded in the instruction.
> +* - JALR: returns the computed indirect jump target using the instructio=
n
> +* immediate and the value of the source register.
> +* - SRET: returns @pc, as control transfer is handled by the trap return
> +* mechanism.
> +*
> +* For all other instructions, execution is assumed to continue at the ne=
xt
> +* sequential 32-bit instruction and @pc + 4 is returned.
> +*
> +* Return: Address of the next instruction to be executed.
> +*/
> +static unsigned long get_next_insn_address_standard(struct pt_regs *regs=
, u32 insn,
> +                                                   unsigned long pc)
> +{
> +       unsigned int rs1_num;
> +
> +       if ((insn & __INSN_OPCODE_MASK) =3D=3D __INSN_BRANCH_OPCODE)
> +               return riscv_branch_taken(regs, insn) ?
> +                       RV_EXTRACT_BTYPE_IMM(insn) + pc : pc + 4;
> +
> +       if (riscv_insn_is_jal(insn))
> +               return RV_EXTRACT_JTYPE_IMM(insn) + pc;
> +
> +       if (riscv_insn_is_jalr(insn)) {
> +               rs1_num =3D RV_X(insn, RVG_RS1_OPOFF, 5);
> +               return RV_EXTRACT_ITYPE_IMM(insn) + riscv_get_reg_value(r=
egs, rs1_num);
> +       }
> +
> +       if (riscv_insn_is_sret(insn))
> +               return pc;
> +
> +       return pc + 4;
> +}
> +
> +/* Calculate the new address for after a step */
> +unsigned long get_next_insn_address(struct pt_regs *regs, ulong insn, ul=
ong pc)
> +{
> +       if (riscv_insn_is_compressed(insn))
> +               return get_next_insn_address_compressed(regs, insn, pc);
> +
> +       return get_next_insn_address_standard(regs, insn, pc);
> +}
> --
> 2.43.0
>

