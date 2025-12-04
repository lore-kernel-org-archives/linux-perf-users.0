Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF747301032
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764833349; cv=none; b=Q58IVMYc0vOBLRH8d76n+EQUMLj5Sw7UrsM3eOqIJ628/APQZgoaXxvQiHwdU+DB9MYFPExhOAMaPZ6bx+Fyk1hoB6qdJbUsyHWsjHBQ0eWsBp8yZbPI47NW13LGyUyqtgR8DtGPld5MkPb8r2wLa13QVUQet+IpvGir8OP18yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764833349; c=relaxed/simple;
	bh=YIy0vE12RQvYF0aDJL6Jk7/hCjJkJbx91V0SFg182Ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thxMFCdXeZHPzrqL5PFKGQI/H27VJQy9TLL7DNzHiPBoAj9xKER2DG9ytbkcYlkAnflUO4T7E3Qe4lS1ius4P7nAEF7J65SqAwQlamydY0UtyV69hFG0Y9oiEapGU0cgSNliKBSl1nTXhqPMgJZMDRONSkXIFncrxzaHtgZxiZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dudvRq5+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dudvRq5+"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297e13bf404so144265ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Dec 2025 23:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764833347; x=1765438147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRK+xpy0moTzFmu5QRbuYTn/PvGvHPi8+Q7eqEMdD6o=;
        b=dudvRq5+CWNnyEuUzIF334kzlTLAamhX6YlQebYItp5zyMOXBykYPyr4Zsr4ymJi64
         +gAcCJJ4kM+72uYN0zD5yLXSU6eyrRaWIMmRHpNcI5+pNQXOjRcrBPN0i1aPhRJc2upR
         Uf+8AnzzZpPxIj70R1QsbNK1+eA3BRON2QZHyA8ETnO9b5P5r9W8dGGQCElqo9C1m/oA
         yP3jxkR3McGn8HxQKTIJcUQbZuM1qrZrHupYmZtzINvtJQom+LkDsRqbh+pdvklCFyrB
         EvwspzoarRfONJ0yiqH/pKz9ViOEVxwRSiXN6DBFwnDvIKoRrrcAhewwB0BtbNH1TFqk
         p8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764833347; x=1765438147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SRK+xpy0moTzFmu5QRbuYTn/PvGvHPi8+Q7eqEMdD6o=;
        b=iv57GQNzkeOYV5qhs/NSwCzsoYg4Ro0UzUdiQE7uvoAVxqHul+bKJ2r1Uu+UD2ctGX
         xWq8iLNObv9d/42O5QazzJyblfso36dNNK3qUA9S5EWK4XEvrD58IlcsyCJwcCBrzikz
         OmDBvQTcZbsnKdPoZhOvILOc3vt0DxoetCWWsJPF1zQwfMNhJvmaTgksW8a2Njd/fKnW
         +094wY8cu0DLS3JfVmietu77UOAMJYfCxyG+9xjN0hKiSH2N7KgjVyhr4BcqJUcHvda4
         g//GKyThP5/WnfEuPDEvIi7XAR5pzgiff41WebigjC2syyzuXGNu2VjIEH8WBJSihbnL
         Y3AA==
X-Forwarded-Encrypted: i=1; AJvYcCX45O5yf/UVTSqQLO8nmHa7OGBH3VDT/KpN3jUQdKtIKHA2j9QImDyYLGHKKjzpZtlkKeVqzMoWRiDP71okfU+e@vger.kernel.org
X-Gm-Message-State: AOJu0YyarL1MmyJBWV9U3qLIDE/w43OrJ70eQfaLWfazM2w2vHH/HKYx
	5Qcm1F7FxA4fkFn15iq2cEJYoE5ZHCqz2bonpaX89fYX4XrVjYh3C9tHqT/isL4w054LbNrCW0y
	0lhCtL8zWNyvbEJkBrOHpUD3UTSPbf1D8xlA9dup3
X-Gm-Gg: ASbGncsnBBhSy5a4V4dRfLIC7Jg5YNYTJxefrro8MD8pn8e7OeMHKayM76vrBtTuCv8
	bQuLe24vrCrWcqic1YiEwK1iXEgBlncljEFb3G/AfWnI1evof9IYvwmZ/erlpWzbOcrA8Z6DZK5
	1eS/H1uVp6UrSInhvrtCF10ues6+shxOgu1FwWWhI6+w+Fm6Fo+gc45x+FXlO9g2WVRs0qL9VpD
	LWN8vjGxSIpL8aILpq112vsx0eF8n6gJUlJXCyNvqwD0tewMPL1JfO4k0pQ9mKQbVPqAC9aWAP5
	mQggwLY=
X-Google-Smtp-Source: AGHT+IGyHd4Vd0NcJMIVCjyCkih7bXCaRTOEZeAu6w9uqH0BCEVse4LErUUnWks/KGCdMt2Wiawo4crmLqyij14gJAE=
X-Received: by 2002:a17:902:ecd1:b0:298:144f:b759 with SMTP id
 d9443c01a7336-29dacbc7771mr1483665ad.9.1764833346622; Wed, 03 Dec 2025
 23:29:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-18-dapeng1.mi@linux.intel.com> <CAP-5=fU+eoG5sXwL_ZHYup2RbZpZvYY7OaMjWQVRhO2ATq9BoQ@mail.gmail.com>
 <ffdcf61f-a525-4e90-a401-b8fb4d7b0453@linux.intel.com>
In-Reply-To: <ffdcf61f-a525-4e90-a401-b8fb4d7b0453@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Dec 2025 23:28:55 -0800
X-Gm-Features: AWmQ_bk1r16_9MdbgGt71bvVP1A_EdM9-GVuPfl8poqffqLLbM2ddXIdtz2FshA
Message-ID: <CAP-5=fVBsrF0_JiyXTF7QjsqAEox_d8exGjhrsDLsipw=yE_eQ@mail.gmail.com>
Subject: Re: [Patch v5 17/19] perf headers: Sync with the kernel headers
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

On Wed, Dec 3, 2025 at 5:38=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.c=
om> wrote:
>
>
> On 12/4/2025 7:43 AM, Ian Rogers wrote:
> > On Tue, Dec 2, 2025 at 10:59=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.int=
el.com> wrote:
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> Update include/uapi/linux/perf_event.h and
> >> arch/x86/include/uapi/asm/perf_regs.h to support extended regs.
> >>
> >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >> ---
> >>  tools/arch/x86/include/uapi/asm/perf_regs.h | 62 ++++++++++++++++++++=
+
> >>  tools/include/uapi/linux/perf_event.h       | 45 +++++++++++++--
> >>  2 files changed, 103 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/=
x86/include/uapi/asm/perf_regs.h
> >> index 7c9d2bb3833b..f3561ed10041 100644
> >> --- a/tools/arch/x86/include/uapi/asm/perf_regs.h
> >> +++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
> >> @@ -27,9 +27,34 @@ enum perf_event_x86_regs {
> >>         PERF_REG_X86_R13,
> >>         PERF_REG_X86_R14,
> >>         PERF_REG_X86_R15,
> >> +       /*
> >> +        * The EGPRs/SSP and XMM have overlaps. Only one can be used
> >> +        * at a time. For the ABI type PERF_SAMPLE_REGS_ABI_SIMD,
> >> +        * utilize EGPRs/SSP. For the other ABI type, XMM is used.
> >> +        *
> >> +        * Extended GPRs (EGPRs)
> >> +        */
> >> +       PERF_REG_X86_R16,
> >> +       PERF_REG_X86_R17,
> >> +       PERF_REG_X86_R18,
> >> +       PERF_REG_X86_R19,
> >> +       PERF_REG_X86_R20,
> >> +       PERF_REG_X86_R21,
> >> +       PERF_REG_X86_R22,
> >> +       PERF_REG_X86_R23,
> >> +       PERF_REG_X86_R24,
> >> +       PERF_REG_X86_R25,
> >> +       PERF_REG_X86_R26,
> >> +       PERF_REG_X86_R27,
> >> +       PERF_REG_X86_R28,
> >> +       PERF_REG_X86_R29,
> >> +       PERF_REG_X86_R30,
> >> +       PERF_REG_X86_R31,
> >> +       PERF_REG_X86_SSP,
> >>         /* These are the limits for the GPRs. */
> >>         PERF_REG_X86_32_MAX =3D PERF_REG_X86_GS + 1,
> >>         PERF_REG_X86_64_MAX =3D PERF_REG_X86_R15 + 1,
> >> +       PERF_REG_MISC_MAX =3D PERF_REG_X86_SSP + 1,
> > I wonder MISC isn't the most intention revealing name. What happens if
> > things are extended again? Would APX be a better alternative, so
> > PERF_REG_APX_MAX ?
>
> Hmm, I don't think PERF_REG_APX_MAX is a good name either since there is
> SSP as well besides the APX eGPRs, and there could be more registers
> introduced in the future.
>
> How about PERF_REG_X86_EXTD_MAX?

Sounds good to me, especially with the eGPR already using the term extended=
.

Thanks,
Ian

> >
> >>         /* These all need two bits set because they are 128bit */
> >>         PERF_REG_X86_XMM0  =3D 32,
> >> @@ -54,5 +79,42 @@ enum perf_event_x86_regs {
> >>  };
> >>
> >>  #define PERF_REG_EXTENDED_MASK (~((1ULL << PERF_REG_X86_XMM0) - 1))
> >> +#define PERF_X86_EGPRS_MASK    GENMASK_ULL(PERF_REG_X86_R31, PERF_REG=
_X86_R16)
> >> +
> >> +enum {
> >> +       PERF_REG_X86_XMM,
> >> +       PERF_REG_X86_YMM,
> >> +       PERF_REG_X86_ZMM,
> >> +       PERF_REG_X86_MAX_SIMD_REGS,
> >> +
> >> +       PERF_REG_X86_OPMASK =3D 0,
> >> +       PERF_REG_X86_MAX_PRED_REGS =3D 1,
> >> +};
> >> +
> >> +enum {
> >> +       PERF_X86_SIMD_XMM_REGS      =3D 16,
> >> +       PERF_X86_SIMD_YMM_REGS      =3D 16,
> >> +       PERF_X86_SIMD_ZMMH_REGS     =3D 16,
> >> +       PERF_X86_SIMD_ZMM_REGS      =3D 32,
> >> +       PERF_X86_SIMD_VEC_REGS_MAX  =3D PERF_X86_SIMD_ZMM_REGS,
> >> +
> >> +       PERF_X86_SIMD_OPMASK_REGS   =3D 8,
> >> +       PERF_X86_SIMD_PRED_REGS_MAX =3D PERF_X86_SIMD_OPMASK_REGS,
> >> +};
> >> +
> >> +#define PERF_X86_SIMD_PRED_MASK                GENMASK(PERF_X86_SIMD_=
PRED_REGS_MAX - 1, 0)
> >> +#define PERF_X86_SIMD_VEC_MASK         GENMASK_ULL(PERF_X86_SIMD_VEC_=
REGS_MAX - 1, 0)
> >> +
> >> +#define PERF_X86_H16ZMM_BASE           PERF_X86_SIMD_ZMMH_REGS
> >> +
> >> +enum {
> >> +       PERF_X86_OPMASK_QWORDS   =3D 1,
> >> +       PERF_X86_XMM_QWORDS      =3D 2,
> >> +       PERF_X86_YMMH_QWORDS     =3D 2,
> >> +       PERF_X86_YMM_QWORDS      =3D 4,
> >> +       PERF_X86_ZMMH_QWORDS     =3D 4,
> >> +       PERF_X86_ZMM_QWORDS      =3D 8,
> >> +       PERF_X86_SIMD_QWORDS_MAX =3D PERF_X86_ZMM_QWORDS,
> >> +};
> >>
> >>  #endif /* _ASM_X86_PERF_REGS_H */
> >> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uap=
i/linux/perf_event.h
> >> index d292f96bc06f..f1474da32622 100644
> >> --- a/tools/include/uapi/linux/perf_event.h
> >> +++ b/tools/include/uapi/linux/perf_event.h
> >> @@ -314,8 +314,9 @@ enum {
> >>   */
> >>  enum perf_sample_regs_abi {
> >>         PERF_SAMPLE_REGS_ABI_NONE               =3D 0,
> >> -       PERF_SAMPLE_REGS_ABI_32                 =3D 1,
> >> -       PERF_SAMPLE_REGS_ABI_64                 =3D 2,
> >> +       PERF_SAMPLE_REGS_ABI_32                 =3D (1 << 0),
> >> +       PERF_SAMPLE_REGS_ABI_64                 =3D (1 << 1),
> >> +       PERF_SAMPLE_REGS_ABI_SIMD               =3D (1 << 2),
> >>  };
> >>
> >>  /*
> >> @@ -382,6 +383,7 @@ enum perf_event_read_format {
> >>  #define PERF_ATTR_SIZE_VER6                    120     /* Add: aux_sa=
mple_size */
> >>  #define PERF_ATTR_SIZE_VER7                    128     /* Add: sig_da=
ta */
> >>  #define PERF_ATTR_SIZE_VER8                    136     /* Add: config=
3 */
> >> +#define PERF_ATTR_SIZE_VER9                    168     /* Add: sample=
_simd_{pred,vec}_reg_* */
> > ARM have added a config4 in:
> > https://lore.kernel.org/lkml/20251111-james-perf-feat_spe_eft-v10-1-1e1=
b5bf2cd05@linaro.org/
> > so this will need to be VER10.
>
> Thanks. It looks the ARM changes have been merged, so we can change it to
> VER10 in next version.
>
>
> >
> > Thanks,
> > Ian
> >
> >>  /*
> >>   * 'struct perf_event_attr' contains various attributes that define
> >> @@ -545,6 +547,25 @@ struct perf_event_attr {
> >>         __u64   sig_data;
> >>
> >>         __u64   config3; /* extension of config2 */
> >> +
> >> +
> >> +       /*
> >> +        * Defines set of SIMD registers to dump on samples.
> >> +        * The sample_simd_regs_enabled !=3D0 implies the
> >> +        * set of SIMD registers is used to config all SIMD registers.
> >> +        * If !sample_simd_regs_enabled, sample_regs_XXX may be used t=
o
> >> +        * config some SIMD registers on X86.
> >> +        */
> >> +       union {
> >> +               __u16 sample_simd_regs_enabled;
> >> +               __u16 sample_simd_pred_reg_qwords;
> >> +       };
> >> +       __u32 sample_simd_pred_reg_intr;
> >> +       __u32 sample_simd_pred_reg_user;
> >> +       __u16 sample_simd_vec_reg_qwords;
> >> +       __u64 sample_simd_vec_reg_intr;
> >> +       __u64 sample_simd_vec_reg_user;
> >> +       __u32 __reserved_4;
> >>  };
> >>
> >>  /*
> >> @@ -1018,7 +1039,15 @@ enum perf_event_type {
> >>          *      } && PERF_SAMPLE_BRANCH_STACK
> >>          *
> >>          *      { u64                   abi; # enum perf_sample_regs_a=
bi
> >> -        *        u64                   regs[weight(mask)]; } && PERF_=
SAMPLE_REGS_USER
> >> +        *        u64                   regs[weight(mask)];
> >> +        *        struct {
> >> +        *              u16 nr_vectors;
> >> +        *              u16 vector_qwords;
> >> +        *              u16 nr_pred;
> >> +        *              u16 pred_qwords;
> >> +        *              u64 data[nr_vectors * vector_qwords + nr_pred =
* pred_qwords];
> >> +        *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
> >> +        *      } && PERF_SAMPLE_REGS_USER
> >>          *
> >>          *      { u64                   size;
> >>          *        char                  data[size];
> >> @@ -1045,7 +1074,15 @@ enum perf_event_type {
> >>          *      { u64                   data_src; } && PERF_SAMPLE_DAT=
A_SRC
> >>          *      { u64                   transaction; } && PERF_SAMPLE_=
TRANSACTION
> >>          *      { u64                   abi; # enum perf_sample_regs_a=
bi
> >> -        *        u64                   regs[weight(mask)]; } && PERF_=
SAMPLE_REGS_INTR
> >> +        *        u64                   regs[weight(mask)];
> >> +        *        struct {
> >> +        *              u16 nr_vectors;
> >> +        *              u16 vector_qwords;
> >> +        *              u16 nr_pred;
> >> +        *              u16 pred_qwords;
> >> +        *              u64 data[nr_vectors * vector_qwords + nr_pred =
* pred_qwords];
> >> +        *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
> >> +        *      } && PERF_SAMPLE_REGS_INTR
> >>          *      { u64                   phys_addr;} && PERF_SAMPLE_PHY=
S_ADDR
> >>          *      { u64                   cgroup;} && PERF_SAMPLE_CGROUP
> >>          *      { u64                   data_page_size;} && PERF_SAMPL=
E_DATA_PAGE_SIZE
> >> --
> >> 2.34.1
> >>
