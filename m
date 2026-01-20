Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1791E44CAEB
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932694; cv=pass; b=rGZDvVhoNVXHVaZ3Njm0sgRMAM/+k13ig6+c1sIL9xIJ3PElSpCOhuyy17hEEG9QJbpsq47wlbzdgaou8DoDB0j/ZNLGkMAYmeJiXeThVmUtd673Rlh4ApOgBLdvdZo4ZDLGvJZhMrJ0c3m3dlh7XQavMWBHcOwazHSfOYMYChU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932694; c=relaxed/simple;
	bh=UE/y9Gi2PoxbZeASxsx4xi3WI8OF/9VGQeaL7/qzMy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyJAb4hKwB/WlJmajLFSc1x4d6CWNvDD9cKifCGEE9EEEjwTd0QBZxMnF6FnRx1puiL4LQUllXLCAt/PgbzFa0JVwBkxS2b88JLVYW7Rd/AjeAiyGvsQfCh/7cT4tofwcUMqORQuvG442jkT1h7Y9MDMlYyrjegGfMrVijje9+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D2h0U0Wr; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D2h0U0Wr"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a1462573caso5855ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 10:11:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768932692; cv=none;
        d=google.com; s=arc-20240605;
        b=lnAMfSd5AhAlTAw38kvK4M+NUa+d6rMEU0ptoo6Zz0KEvprAXKi5SdqolBqYRXdvTy
         KfMXa4WyyHhknC6TRXbkvRTh5f0w4K00cu80a7K/65NttF8NZf2K0HFe1Vw4oARwrU7+
         Fvl5R2gwXizwHMw2LOKbxFY1KG9DIg1gxr9qLG94xI/CMSiK7IP27XcNOZV3WAE3Hssd
         H8lYIAeoCB6Xh73xODk1lNyyLxlT8lzcIhslDGNbCbrYjdVBq8yjfKn1025tC/zZ2A8/
         voM+sICURt7y54u885wnncSWaujs8jwwsV/PLUnp9KDaqKkt2w89mxIueiTttSZV2s6n
         XmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wC4xOOBtCB8FcfVU+cv1CTMdcGvCgpYH/1X3gPfYAKQ=;
        fh=pjvztAc8CYyJgv6u0ekshjmaW70Hjl8eeRQEA5eCH4I=;
        b=Rg7IHJGp+LLMq0z/iH/9orO7cxrTJbEwbCviEgRyiv1t5WxrFX4z49jLvHklvpNtYL
         zIKTvDoU/N/qovyjvAcKoE+LBWFG5m8Ydg5CLqLXSWANKEkuvqRsaAaqlOmL5g8LaY0w
         HSbAZORRtiYUYPgZhzsM+SodCOds7M6YVzmCeUJjkhAVMy3wJWQIuwpTow/+qkVTxDcg
         iOY85RtEaRA1R32xmKLTqYVgJr/VSCEhYnXs6I3kWYH9Q4YsdBawTGj86NnAoAeI5Kyj
         MXCVC5615v5AEShxQEc5F73kpaPHCIf+2GPNvy+G+smlxVjfjtvpN4K3ZK656VvXvlgR
         z9iA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768932692; x=1769537492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wC4xOOBtCB8FcfVU+cv1CTMdcGvCgpYH/1X3gPfYAKQ=;
        b=D2h0U0WreZ6Y1BIS5RfmqoNjJ9EDTzBblzgHqkTYhfVTVQOffwYlZlAhpCoU7frinh
         ApkOqmOfbzjWNQW/43lMSqP6uPjw6TQGgwbeOtL7R1mlL1i4dJ3SkopT45xxEV1G4VYH
         fblMlo8munpBMNpZC15vNzP/0XVBaUiUSieVFTXKl55tsuSFVCq/jVDGdJv+p2CnIECM
         ipkSDMYtTf9jidMV/mdDfn7ESvX4T5IaLy0YPoG+WP3YREApPJ04ncb+af+OoH0Pkjxq
         GfDzx+n7cScaQRyAWt8y6jDP35ZjPglOrkRtvHVYrGJTiJ2kdZezR0Y9TdlJXRZMwRbM
         TpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768932692; x=1769537492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wC4xOOBtCB8FcfVU+cv1CTMdcGvCgpYH/1X3gPfYAKQ=;
        b=a6u+mG4UvurMk3fuJfF6xiS/QlcopCOTQmuZVKx3Rwi23dAWbQTCH3Br/ZDS8KggaE
         6KWq187vnaLPNKrb4ko7fpTi4YEXhQ7Wm8czfUe5V6Z0Kl38fsgVxxRQeHZlWOkFuA3f
         hoMc2M+KQ4S7364nY50AixH18DlhuqWi60mxdssdxL+bLvSMZI2ZLwUfaIV+/TzFtuCM
         sV2ax2UWTRrWvpJUk8mkLyxwJbhruHIWihOuo5Rklm0G8Ymw33kOo7D3RMFbvI4Yu2YX
         /YLy1AhG4ITlBOoejTEGPL7H/M9PpbbIsSkka7QLKJxp4I2hgBQ33cBav6EWStHnZKzP
         jPMw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ1r2li+ba4WmxGjsuIMRnaANmQPt512SbXjTXuT+V8zC53K2l3SVEiE9cq9zcoWeqZrI1JwVBP4gBulYT8sJy@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt90GN3dBQ0kdB9IBENGUn+rgJUskJjCBGantVqrmZm7zdKilV
	Kp9Pn9F8NTJ8CdKgNnkaAT/ZRUivqeoXIOSNRY6W6HkeECZHNFhod2Rm5G+cB/Mt7o/yluT8SY/
	t0e4YeEOO/2DnPMddpowySEvbsS/ZPNI2ClhaemfK
X-Gm-Gg: AZuq6aIw8UY/Wep5IYBIO0p3TMqrNRFIvXHYVrFKAn1DRc7KkZAyHNhaIlf/L6egKYs
	tXZOLt8GWcVmgbS+giR8nPbcSZinDIs9zbXGo8PkA30NinQHCUGRnyUtdE13fJBWZqGfDPtqEU7
	y8LWHiHLEzNuCNw/1ecBNFEARsFChc9NQIWqHiWj0BcNYYfA0ybrjj+GMjfE50Z4CE23Lqi+GDw
	+Y45qeROJ5Iu70MRvUVe9+iqjMbGImbQGeHSLA+nRyubu+UfF53wVITRvhLpggzcDtaCftlRPdA
	BoKbbi5u+ecpnJ2MbJoLpgQDBi87hZ+DljIP
X-Received: by 2002:a17:902:ce07:b0:2a7:6ce1:17d8 with SMTP id
 d9443c01a7336-2a799f10c68mr102575ad.0.1768932691902; Tue, 20 Jan 2026
 10:11:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-18-dapeng1.mi@linux.intel.com> <CAP-5=fWPgdiRve_xk_t04wr_p1tccRu1eU7C3v+=yvc4OD4PVg@mail.gmail.com>
 <9b429aa8-d269-4af8-9236-350cb9543f2a@linux.intel.com> <CAP-5=fXQOTXhcuUjHSnMDQzi+u+kja2pNJSwziY7WZo7iLpqng@mail.gmail.com>
 <a5b8d05b-44db-46f7-8b3f-3b4f125480ed@linux.intel.com>
In-Reply-To: <a5b8d05b-44db-46f7-8b3f-3b4f125480ed@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 20 Jan 2026 10:11:19 -0800
X-Gm-Features: AZwV_QhjMUM9FKPOkeTvRDn64NwoIzYwK6Rso__Yu_Jj3PvnyJAAVXjKAoMeCG4
Message-ID: <CAP-5=fWHmTeb7SAvpmMVvi8p_otqU6iSaRO29svyPi3MjhT4Mw@mail.gmail.com>
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

On Tue, Jan 20, 2026 at 1:22=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 1/20/2026 4:00 PM, Ian Rogers wrote:
> > On Mon, Jan 19, 2026 at 11:43=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.i=
ntel.com> wrote:
> >>
> >> On 1/20/2026 3:16 PM, Ian Rogers wrote:
> >>> On Tue, Dec 2, 2025 at 10:59=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.i=
ntel.com> wrote:
> >>>> From: Kan Liang <kan.liang@linux.intel.com>
> >>>>
> >>>> Update include/uapi/linux/perf_event.h and
> >>>> arch/x86/include/uapi/asm/perf_regs.h to support extended regs.
> >>>>
> >>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >>>> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >>>> ---
> >>>>  tools/arch/x86/include/uapi/asm/perf_regs.h | 62 ++++++++++++++++++=
+++
> >>>>  tools/include/uapi/linux/perf_event.h       | 45 +++++++++++++--
> >>>>  2 files changed, 103 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arc=
h/x86/include/uapi/asm/perf_regs.h
> >>>> index 7c9d2bb3833b..f3561ed10041 100644
> >>>> --- a/tools/arch/x86/include/uapi/asm/perf_regs.h
> >>>> +++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
> >>>> @@ -27,9 +27,34 @@ enum perf_event_x86_regs {
> >>>>         PERF_REG_X86_R13,
> >>>>         PERF_REG_X86_R14,
> >>>>         PERF_REG_X86_R15,
> >>>> +       /*
> >>>> +        * The EGPRs/SSP and XMM have overlaps. Only one can be used
> >>>> +        * at a time. For the ABI type PERF_SAMPLE_REGS_ABI_SIMD,
> >>>> +        * utilize EGPRs/SSP. For the other ABI type, XMM is used.
> >>>> +        *
> >>>> +        * Extended GPRs (EGPRs)
> >>>> +        */
> >>>> +       PERF_REG_X86_R16,
> >>>> +       PERF_REG_X86_R17,
> >>>> +       PERF_REG_X86_R18,
> >>>> +       PERF_REG_X86_R19,
> >>>> +       PERF_REG_X86_R20,
> >>>> +       PERF_REG_X86_R21,
> >>>> +       PERF_REG_X86_R22,
> >>>> +       PERF_REG_X86_R23,
> >>>> +       PERF_REG_X86_R24,
> >>>> +       PERF_REG_X86_R25,
> >>>> +       PERF_REG_X86_R26,
> >>>> +       PERF_REG_X86_R27,
> >>>> +       PERF_REG_X86_R28,
> >>>> +       PERF_REG_X86_R29,
> >>>> +       PERF_REG_X86_R30,
> >>>> +       PERF_REG_X86_R31,
> >>>> +       PERF_REG_X86_SSP,
> >>>>         /* These are the limits for the GPRs. */
> >>>>         PERF_REG_X86_32_MAX =3D PERF_REG_X86_GS + 1,
> >>>>         PERF_REG_X86_64_MAX =3D PERF_REG_X86_R15 + 1,
> >>>> +       PERF_REG_MISC_MAX =3D PERF_REG_X86_SSP + 1,
> >>>>
> >>>>         /* These all need two bits set because they are 128bit */
> >>>>         PERF_REG_X86_XMM0  =3D 32,
> >>>> @@ -54,5 +79,42 @@ enum perf_event_x86_regs {
> >>>>  };
> >>>>
> >>>>  #define PERF_REG_EXTENDED_MASK (~((1ULL << PERF_REG_X86_XMM0) - 1))
> >>>> +#define PERF_X86_EGPRS_MASK    GENMASK_ULL(PERF_REG_X86_R31, PERF_R=
EG_X86_R16)
> >>>> +
> >>>> +enum {
> >>>> +       PERF_REG_X86_XMM,
> >>>> +       PERF_REG_X86_YMM,
> >>>> +       PERF_REG_X86_ZMM,
> >>>> +       PERF_REG_X86_MAX_SIMD_REGS,
> >>>> +
> >>>> +       PERF_REG_X86_OPMASK =3D 0,
> >>>> +       PERF_REG_X86_MAX_PRED_REGS =3D 1,
> >>>> +};
> >>>> +
> >>>> +enum {
> >>>> +       PERF_X86_SIMD_XMM_REGS      =3D 16,
> >>>> +       PERF_X86_SIMD_YMM_REGS      =3D 16,
> >>>> +       PERF_X86_SIMD_ZMMH_REGS     =3D 16,
> >>>> +       PERF_X86_SIMD_ZMM_REGS      =3D 32,
> >>>> +       PERF_X86_SIMD_VEC_REGS_MAX  =3D PERF_X86_SIMD_ZMM_REGS,
> >>>> +
> >>>> +       PERF_X86_SIMD_OPMASK_REGS   =3D 8,
> >>>> +       PERF_X86_SIMD_PRED_REGS_MAX =3D PERF_X86_SIMD_OPMASK_REGS,
> >>>> +};
> >>>> +
> >>>> +#define PERF_X86_SIMD_PRED_MASK                GENMASK(PERF_X86_SIM=
D_PRED_REGS_MAX - 1, 0)
> >>>> +#define PERF_X86_SIMD_VEC_MASK         GENMASK_ULL(PERF_X86_SIMD_VE=
C_REGS_MAX - 1, 0)
> >>>> +
> >>>> +#define PERF_X86_H16ZMM_BASE           PERF_X86_SIMD_ZMMH_REGS
> >>>> +
> >>>> +enum {
> >>>> +       PERF_X86_OPMASK_QWORDS   =3D 1,
> >>>> +       PERF_X86_XMM_QWORDS      =3D 2,
> >>>> +       PERF_X86_YMMH_QWORDS     =3D 2,
> >>>> +       PERF_X86_YMM_QWORDS      =3D 4,
> >>>> +       PERF_X86_ZMMH_QWORDS     =3D 4,
> >>>> +       PERF_X86_ZMM_QWORDS      =3D 8,
> >>>> +       PERF_X86_SIMD_QWORDS_MAX =3D PERF_X86_ZMM_QWORDS,
> >>>> +};
> >>>>
> >>>>  #endif /* _ASM_X86_PERF_REGS_H */
> >>>> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/u=
api/linux/perf_event.h
> >>>> index d292f96bc06f..f1474da32622 100644
> >>>> --- a/tools/include/uapi/linux/perf_event.h
> >>>> +++ b/tools/include/uapi/linux/perf_event.h
> >>>> @@ -314,8 +314,9 @@ enum {
> >>>>   */
> >>>>  enum perf_sample_regs_abi {
> >>>>         PERF_SAMPLE_REGS_ABI_NONE               =3D 0,
> >>>> -       PERF_SAMPLE_REGS_ABI_32                 =3D 1,
> >>>> -       PERF_SAMPLE_REGS_ABI_64                 =3D 2,
> >>>> +       PERF_SAMPLE_REGS_ABI_32                 =3D (1 << 0),
> >>>> +       PERF_SAMPLE_REGS_ABI_64                 =3D (1 << 1),
> >>>> +       PERF_SAMPLE_REGS_ABI_SIMD               =3D (1 << 2),
> >>>>  };
> >>>>
> >>>>  /*
> >>>> @@ -382,6 +383,7 @@ enum perf_event_read_format {
> >>>>  #define PERF_ATTR_SIZE_VER6                    120     /* Add: aux_=
sample_size */
> >>>>  #define PERF_ATTR_SIZE_VER7                    128     /* Add: sig_=
data */
> >>>>  #define PERF_ATTR_SIZE_VER8                    136     /* Add: conf=
ig3 */
> >>>> +#define PERF_ATTR_SIZE_VER9                    168     /* Add: samp=
le_simd_{pred,vec}_reg_* */
> >>>>
> >>>>  /*
> >>>>   * 'struct perf_event_attr' contains various attributes that define
> >>>> @@ -545,6 +547,25 @@ struct perf_event_attr {
> >>>>         __u64   sig_data;
> >>>>
> >>>>         __u64   config3; /* extension of config2 */
> >>>> +
> >>>> +
> >>>> +       /*
> >>>> +        * Defines set of SIMD registers to dump on samples.
> >>>> +        * The sample_simd_regs_enabled !=3D0 implies the
> >>>> +        * set of SIMD registers is used to config all SIMD register=
s.
> >>>> +        * If !sample_simd_regs_enabled, sample_regs_XXX may be used=
 to
> >>>> +        * config some SIMD registers on X86.
> >>>> +        */
> >>>> +       union {
> >>>> +               __u16 sample_simd_regs_enabled;
> >>>> +               __u16 sample_simd_pred_reg_qwords;
> >>>> +       };
> >>>> +       __u32 sample_simd_pred_reg_intr;
> >>>> +       __u32 sample_simd_pred_reg_user;
> >>>> +       __u16 sample_simd_vec_reg_qwords;
> >>>> +       __u64 sample_simd_vec_reg_intr;
> >>>> +       __u64 sample_simd_vec_reg_user;
> >>>> +       __u32 __reserved_4;
> >>>>  };
> >>>>
> >>>>  /*
> >>>> @@ -1018,7 +1039,15 @@ enum perf_event_type {
> >>>>          *      } && PERF_SAMPLE_BRANCH_STACK
> >>>>          *
> >>>>          *      { u64                   abi; # enum perf_sample_regs=
_abi
> >>>> -        *        u64                   regs[weight(mask)]; } && PER=
F_SAMPLE_REGS_USER
> >>>> +        *        u64                   regs[weight(mask)];
> >>>> +        *        struct {
> >>>> +        *              u16 nr_vectors;
> >>>> +        *              u16 vector_qwords;
> >>>> +        *              u16 nr_pred;
> >>>> +        *              u16 pred_qwords;
> >>>> +        *              u64 data[nr_vectors * vector_qwords + nr_pre=
d * pred_qwords];
> >>>> +        *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
> >>> Why can't these values be taken from the perf_event_attr? The abi is
> >>> needed as there could be both 32-bit and 64-bit samples for the same
> >>> event - presumably x32 appears as 64-bit. If the ABI has SIMD within
> >>> it (implied by the "} && (abi & PERF_SAMPLE_REGS_ABI_SIMD)" below)
> >>> then why can't we just use the perf_event_attr values? For example,
> >>> data could be "data[weight(sample_simd_vec_reg_user) *
> >>> sample_simd_vec_reg_qwords + weight(sample_simd_pred_reg_user) *
> >>> sample_simd_pred_reg_qwords]".
> >> The main reason is that the sampled SIMD regs could only be a subset o=
f the
> >> requested SIMD regs in perf_event_attr, so we need to show the bitmask=
 and
> >> qwords length explicitly in the sample record.
> > But this doesn't happen in any other register sampling, why in this cas=
e?
> >
> > Perhaps add comments along the lines:
> > u16 nr_vectors;  // weight(sample_simd_vec_reg_user) except when ...
> >
> > My random guess as to why the value differs from the weight would be
> > some kind of optimization around register values of 0. And even if the
> > number of registers is reduced, why is the number of qwords being
> > altered?
>
> Yes. E.g., the user may want to sample ZMM registers (ZMM0 ~ ZMM31), but
> the result is that only XMM registers (XMM0 ~ XMM15) are sampled at some
> time, so both the registers number and qwords length are not identical wi=
th
> the perf_event_attr values in some sampling records. Thus we need to
> explicitly indicates the sampled registers number and length.
>
> Besides, containing these 4 fields in sampling records makes the sampling
> records be parsed more easily and don't need to retrieve information from
> corresponding perf_event_attr. Thanks.

Sgtm (well you still need to look at the perf_event_attr for
regs[weight(mask)] immediately before this, but anyway). Can we add
comments to that effect? Something like:
```
       *              u16 nr_vectors;  # 0..weight(sample_simd_vec_reg_user=
)
       *              u16 vector_qwords; # 0..sample_simd_vec_reg_qwords
       *              u16 nr_pred; # 0..weight(sample_simd_pred_reg_user)
       *              u16 pred_qwords; 0..sample_simd_pred_reg_qwords
```
At least this hints at an optimization rather than a duplication bug.

Thanks,
Ian

> >
> > Thanks,
> > Ian
> >
> >>>> +        *      } && PERF_SAMPLE_REGS_USER
> >>>>          *
> >>>>          *      { u64                   size;
> >>>>          *        char                  data[size];
> >>>> @@ -1045,7 +1074,15 @@ enum perf_event_type {
> >>>>          *      { u64                   data_src; } && PERF_SAMPLE_D=
ATA_SRC
> >>>>          *      { u64                   transaction; } && PERF_SAMPL=
E_TRANSACTION
> >>>>          *      { u64                   abi; # enum perf_sample_regs=
_abi
> >>>> -        *        u64                   regs[weight(mask)]; } && PER=
F_SAMPLE_REGS_INTR
> >>>> +        *        u64                   regs[weight(mask)];
> >>>> +        *        struct {
> >>>> +        *              u16 nr_vectors;
> >>>> +        *              u16 vector_qwords;
> >>>> +        *              u16 nr_pred;
> >>>> +        *              u16 pred_qwords;
> >>>> +        *              u64 data[nr_vectors * vector_qwords + nr_pre=
d * pred_qwords];
> >>>> +        *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
> >>> Same comment.
> >>>
> >>> Thanks,
> >>> Ian
> >>>
> >>>> +        *      } && PERF_SAMPLE_REGS_INTR
> >>>>          *      { u64                   phys_addr;} && PERF_SAMPLE_P=
HYS_ADDR
> >>>>          *      { u64                   cgroup;} && PERF_SAMPLE_CGRO=
UP
> >>>>          *      { u64                   data_page_size;} && PERF_SAM=
PLE_DATA_PAGE_SIZE
> >>>> --
> >>>> 2.34.1
> >>>>
