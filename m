Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57D84266BD
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933221; cv=pass; b=aY2H8lb20nQwIw567kgeqSmgscAEeQ5S2b9B3MqWDtSUfpK2HNZeurrPsfwkfi0/lT0lfNH5V2vpcRVARwq4Dd2BFU+WHC8NMZIdg4WDimmke/wdrHpT4bekaTyl5NU+VRtUhk/LWdHBPyGTQXM+a1SCPKrSY2xhKCc3VbRsvMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933221; c=relaxed/simple;
	bh=tskzmLp0vfAfabYBvS5Dtofr3E3T6hvaR6M5SwFo/K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQUgKpg4cEJkZg2nKpFyYWGSD5L8uU5fgIj4yuxDwXOX2NpeY5/PPkrRVXEjMTt6hhD51yVVECCnlhE9G1yRBr4ERmlS/tSMvZVc3Xoi19xvKbdvOnjIwsziXVkMuoOD/3wxDazz1z533eS8jgNGfX4R4tQoR04KR5R7LOhp9VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E9Fmxdrk; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E9Fmxdrk"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0d06cfa93so5345ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 10:20:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768933218; cv=none;
        d=google.com; s=arc-20240605;
        b=aTjHjwiIyVwgsr1Pq63TSpdPt3+IJ5+mMH6zKmbYwTFe9ycgxg/fGMh265OBz0XIQY
         MemMylwNPinwDEoFCzaxEvV3l9x3EZo8pR6YlJK8L8XpDvWta0q6xEt5MpIhtUQwWnSA
         wLxElhPB6KOWHUlebDcMWb+KlAePHyoBspCh5gvRVLad6JWDUJI5NvOg4U15OalGOTH8
         OHhT6C0CDoTwjqhcRGH3sb+CGGo40SC32C1hNirQnvtfzjUrJzlIFMjr8jiyoABh4w4n
         lXDwRTwMjZ0OLM0Sf5LwnAYuAM7klpb9VITsu/VHL+WE+GZ09NBcCnLPynfQuVCYpf0G
         9fqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Px+Z85dV7uHybEZ8m357RWy205LsDMbykXKREQ0QYOA=;
        fh=4nQ1mKxygarcozsLFEsgzPZgP4IVhofGklZW5p2GCEM=;
        b=D0bYO1xDQMa+rDIxGnPew4gSwbrOLpRu0tPcOMc35EzI8df2LfoSbTef4oOVC8kUXO
         epqrsm9JsXOW1ei0r+Z64+wPTfWbsr7L7DFm7MXLd5R1gABdF/TnirE6g3OEMslcCsDo
         BuSRSkhU0T4e9aKRlIN48dIUGs9ZJpGfYn/gHqDez8w/7qtDcY0mBzqedvws9w4mHHZk
         ffPK8RBjy2Z/y2cj7hMiTlbMTrsOkf0JoOi00tr8LMnbVxJA7ARZSSkWHWvFAfgW4dx7
         6DtE618SwKdWTluf4+a9TWGiQ21rgEhrEmTwBhIFGPxGSKB6HrXGdD/ZaS10+6PfUM5p
         t2uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768933218; x=1769538018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Px+Z85dV7uHybEZ8m357RWy205LsDMbykXKREQ0QYOA=;
        b=E9FmxdrkJYXeFJvhWgJZKpcavIqS7TOELmPdltGFwW4yTBjDDkagGmie+Fb2zjFvyy
         8/FlMCXVzIk4+sDCz0/joeHhMxVkXj3Y/5jh0Ac/IrOQ2/czhY6JUdsB3WLC75S7WBGR
         gEQEFIvAvXIAJwlCp9dJmfImS1ncz3CW2CuzSnOnmtgPUug5u+4+AQG+zNXAwPowP9ar
         BiAcJNaLKG4EZ65lJ6rOW9MSU5H7UpzNEYh8Ki3wIzXb4YFq3V6XzVwvVDiAjvHqlOiK
         pid7Vt2PlO2/jTJgrtHwAChf4puxl1Clo3Yc33UwVUKNh0zPR704+6ots4DMec2XFzGD
         eMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768933218; x=1769538018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Px+Z85dV7uHybEZ8m357RWy205LsDMbykXKREQ0QYOA=;
        b=G+VIAhv2pNZUWPw2KyU042qQINBPyfbc7IMk/V7ykbywLndlfzRlFudnWqynhtj7R4
         +oBMW6OvlIUvzDyLEHwD0vOOfyOd61mb0nJaayKCGkdXzWEjNuZrUus+RrYjbij/aaq6
         Yr7w8fBP1AshktgoOWEJZcO/As3u4NtBajtsOp2n0G3hH7tYpFS7H4N+nPCAJJRMKPaO
         TFo3vE43vKrmaQLKKmC4AQcAoF/AeYBt8l3Z4L8WKskJa97ztdCFgpeJxILkfUmzIBvf
         rT6xDQZLC6aPcJ8ezXvx1FnBbx+w2oP5jojS0EIeMYkBbWF0HbUaUjxtxZkRrydr/6c9
         Av7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzBqveDZ9Jz7UUaru0k9fQ2EfciTILx8SZVd7TYRUn5jbqlUJimEQbJL9trauAAKcBmKWJOIBdVKNbvigXciTO@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ2P4wK9IkAMVoLMe+VWjUh0gKMDk2YJ0TStIpWQMUQnJsNwIZ
	qdmz62GBADe78GcuAtQ6kcYxUjrGzzMgORBT0ReNhufu5sk1bdmnXTKpeqUdSaL+nqkjEzoxSpD
	jUCM5vx+C8FqsTLwd9wOWRp3xAJrJJJ7sn2owqkHT
X-Gm-Gg: AZuq6aKDsFxp6+TSCqoURlcEAGMpJAGN/7xZifulT5IULMM/lnDTYqVRZ/Cwf9hJv5d
	G7kcvrQE7layXjVXt5oqEP7GLjBqUjAOJGnuv1qZsm1AM+Pm7VBF1U8JeTfQpxPZjmZnwRYPgxx
	bV11RSkQ4q1cHkKOKV1myslHCHaLpwsI+as6jSsMsjVxvxpIYg9ADNfcfoFJnK+gDmISTyyez7U
	KYgFMWcz5BdJQA3XT5R1fJ+T71bjjCY3ozlZN5P66zGgR1cQiK8z1vpVP//SaXIzxyEmmEvFBOU
	Hs9KFH5fn5EeRshVKNWx9hDixQ==
X-Received: by 2002:a17:903:2281:b0:291:6858:ee60 with SMTP id
 d9443c01a7336-2a79a3b1e14mr170075ad.4.1768933217026; Tue, 20 Jan 2026
 10:20:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-19-dapeng1.mi@linux.intel.com> <CAP-5=fWOsvAXuu8qx0tk9q8j8BoXPMJB3Gxto+iu6wf06i4cVA@mail.gmail.com>
 <ec427fd5-06f8-4b05-a074-bfc2aa196ffa@linux.intel.com>
In-Reply-To: <ec427fd5-06f8-4b05-a074-bfc2aa196ffa@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 20 Jan 2026 10:20:05 -0800
X-Gm-Features: AZwV_QipfUaIRKUwxkTpsDqZDDLSOGKjYZD2vk5zDrX1yNf_bSXLfp8YBmzVFOw
Message-ID: <CAP-5=fWmKLZtK-BOdRd5hhh=Yd6SedmLBAt6cUcEjdP73V3xrQ@mail.gmail.com>
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

On Tue, Jan 20, 2026 at 1:04=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 1/20/2026 3:39 PM, Ian Rogers wrote:
> > On Tue, Dec 2, 2025 at 10:59=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.int=
el.com> wrote:
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> This patch adds support for the newly introduced SIMD register samplin=
g
> >> format by adding the following functions:
> >>
> >> uint64_t arch__intr_simd_reg_mask(void);
> >> uint64_t arch__user_simd_reg_mask(void);
> >> uint64_t arch__intr_pred_reg_mask(void);
> >> uint64_t arch__user_pred_reg_mask(void);
> >> uint64_t arch__intr_simd_reg_bitmap_qwords(int reg, u16 *qwords);
> >> uint64_t arch__user_simd_reg_bitmap_qwords(int reg, u16 *qwords);
> >> uint64_t arch__intr_pred_reg_bitmap_qwords(int reg, u16 *qwords);
> >> uint64_t arch__user_pred_reg_bitmap_qwords(int reg, u16 *qwords);
> >>
> >> The arch__{intr|user}_simd_reg_mask() functions retrieve the bitmap of
> >> supported SIMD registers, such as XMM/YMM/ZMM on x86 platforms.
> >>
> >> The arch__{intr|user}_pred_reg_mask() functions retrieve the bitmap of
> >> supported PRED registers, such as OPMASK on x86 platforms.
> >>
> >> The arch__{intr|user}_simd_reg_bitmap_qwords() functions provide the
> >> exact bitmap and number of qwords for a specific type of SIMD register=
.
> >> For example, for XMM registers on x86 platforms, the returned bitmap i=
s
> >> 0xffff (XMM0 ~ XMM15) and the qwords number is 2 (128 bits for each XM=
M).
> >>
> >> The arch__{intr|user}_pred_reg_bitmap_qwords() functions provide the
> >> exact bitmap and number of qwords for a specific type of PRED register=
.
> >> For example, for OPMASK registers on x86 platforms, the returned bitma=
p
> >> is 0xff (OPMASK0 ~ OPMASK7) and the qwords number is 1 (64 bits for ea=
ch
> >> OPMASK).
> >>
> >> Additionally, the function __parse_regs() is enhanced to support parsi=
ng
> >> these newly introduced SIMD registers. Currently, each type of registe=
r
> >> can only be sampled collectively; sampling a specific SIMD register is
> >> not supported. For example, all XMM registers are sampled together rat=
her
> >> than sampling only XMM0.
> >>
> >> When multiple overlapping register types, such as XMM and YMM, are
> >> sampled simultaneously, only the superset (YMM registers) is sampled.
> >>
> >> With this patch, all supported sampling registers on x86 platforms are
> >> displayed as follows.
> >>
> >>  $perf record -I?
> >>  available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
> >>  R11 R12 R13 R14 R15 R16 R17 R18 R19 R20 R21 R22 R23 R24 R25 R26 R27 R=
28
> >>  R29 R30 R31 SSP XMM0-15 YMM0-15 ZMM0-31 OPMASK0-7
> >>
> >>  $perf record --user-regs=3D?
> >>  available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
> >>  R11 R12 R13 R14 R15 R16 R17 R18 R19 R20 R21 R22 R23 R24 R25 R26 R27 R=
28
> >>  R29 R30 R31 SSP XMM0-15 YMM0-15 ZMM0-31 OPMASK0-7
> >>
> >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >> ---
> >>  tools/perf/arch/x86/util/perf_regs.c      | 470 +++++++++++++++++++++=
-
> >>  tools/perf/util/evsel.c                   |  27 ++
> >>  tools/perf/util/parse-regs-options.c      | 151 ++++++-
> >>  tools/perf/util/perf_event_attr_fprintf.c |   6 +
> >>  tools/perf/util/perf_regs.c               |  59 +++
> >>  tools/perf/util/perf_regs.h               |  11 +
> >>  tools/perf/util/record.h                  |   6 +
> >>  7 files changed, 714 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x8=
6/util/perf_regs.c
> >> index 12fd93f04802..db41430f3b07 100644
> >> --- a/tools/perf/arch/x86/util/perf_regs.c
> >> +++ b/tools/perf/arch/x86/util/perf_regs.c
> >> @@ -13,6 +13,49 @@
> >>  #include "../../../util/pmu.h"
> >>  #include "../../../util/pmus.h"
> >>
> >> +static const struct sample_reg sample_reg_masks_ext[] =3D {
> >> +       SMPL_REG(AX, PERF_REG_X86_AX),
> >> +       SMPL_REG(BX, PERF_REG_X86_BX),
> >> +       SMPL_REG(CX, PERF_REG_X86_CX),
> >> +       SMPL_REG(DX, PERF_REG_X86_DX),
> >> +       SMPL_REG(SI, PERF_REG_X86_SI),
> >> +       SMPL_REG(DI, PERF_REG_X86_DI),
> >> +       SMPL_REG(BP, PERF_REG_X86_BP),
> >> +       SMPL_REG(SP, PERF_REG_X86_SP),
> >> +       SMPL_REG(IP, PERF_REG_X86_IP),
> >> +       SMPL_REG(FLAGS, PERF_REG_X86_FLAGS),
> >> +       SMPL_REG(CS, PERF_REG_X86_CS),
> >> +       SMPL_REG(SS, PERF_REG_X86_SS),
> >> +#ifdef HAVE_ARCH_X86_64_SUPPORT
> >> +       SMPL_REG(R8, PERF_REG_X86_R8),
> >> +       SMPL_REG(R9, PERF_REG_X86_R9),
> >> +       SMPL_REG(R10, PERF_REG_X86_R10),
> >> +       SMPL_REG(R11, PERF_REG_X86_R11),
> >> +       SMPL_REG(R12, PERF_REG_X86_R12),
> >> +       SMPL_REG(R13, PERF_REG_X86_R13),
> >> +       SMPL_REG(R14, PERF_REG_X86_R14),
> >> +       SMPL_REG(R15, PERF_REG_X86_R15),
> >> +       SMPL_REG(R16, PERF_REG_X86_R16),
> >> +       SMPL_REG(R17, PERF_REG_X86_R17),
> >> +       SMPL_REG(R18, PERF_REG_X86_R18),
> >> +       SMPL_REG(R19, PERF_REG_X86_R19),
> >> +       SMPL_REG(R20, PERF_REG_X86_R20),
> >> +       SMPL_REG(R21, PERF_REG_X86_R21),
> >> +       SMPL_REG(R22, PERF_REG_X86_R22),
> >> +       SMPL_REG(R23, PERF_REG_X86_R23),
> >> +       SMPL_REG(R24, PERF_REG_X86_R24),
> >> +       SMPL_REG(R25, PERF_REG_X86_R25),
> >> +       SMPL_REG(R26, PERF_REG_X86_R26),
> >> +       SMPL_REG(R27, PERF_REG_X86_R27),
> >> +       SMPL_REG(R28, PERF_REG_X86_R28),
> >> +       SMPL_REG(R29, PERF_REG_X86_R29),
> >> +       SMPL_REG(R30, PERF_REG_X86_R30),
> >> +       SMPL_REG(R31, PERF_REG_X86_R31),
> >> +       SMPL_REG(SSP, PERF_REG_X86_SSP),
> >> +#endif
> >> +       SMPL_REG_END
> >> +};
> >> +
> >>  static const struct sample_reg sample_reg_masks[] =3D {
> >>         SMPL_REG(AX, PERF_REG_X86_AX),
> >>         SMPL_REG(BX, PERF_REG_X86_BX),
> >> @@ -276,27 +319,404 @@ int arch_sdt_arg_parse_op(char *old_op, char **=
new_op)
> >>         return SDT_ARG_VALID;
> >>  }
> >>
> >> +static bool support_simd_reg(u64 sample_type, u16 qwords, u64 mask, b=
ool pred)
> >> +{
> >> +       struct perf_event_attr attr =3D {
> >> +               .type                           =3D PERF_TYPE_HARDWARE=
,
> >> +               .config                         =3D PERF_COUNT_HW_CPU_=
CYCLES,
> >> +               .sample_type                    =3D sample_type,
> >> +               .disabled                       =3D 1,
> >> +               .exclude_kernel                 =3D 1,
> >> +               .sample_simd_regs_enabled       =3D 1,
> >> +       };
> >> +       int fd;
> >> +
> >> +       attr.sample_period =3D 1;
> >> +
> >> +       if (!pred) {
> >> +               attr.sample_simd_vec_reg_qwords =3D qwords;
> >> +               if (sample_type =3D=3D PERF_SAMPLE_REGS_INTR)
> >> +                       attr.sample_simd_vec_reg_intr =3D mask;
> >> +               else
> >> +                       attr.sample_simd_vec_reg_user =3D mask;
> >> +       } else {
> >> +               attr.sample_simd_pred_reg_qwords =3D PERF_X86_OPMASK_Q=
WORDS;
> >> +               if (sample_type =3D=3D PERF_SAMPLE_REGS_INTR)
> >> +                       attr.sample_simd_pred_reg_intr =3D PERF_X86_SI=
MD_PRED_MASK;
> >> +               else
> >> +                       attr.sample_simd_pred_reg_user =3D PERF_X86_SI=
MD_PRED_MASK;
> >> +       }
> >> +
> >> +       if (perf_pmus__num_core_pmus() > 1) {
> >> +               struct perf_pmu *pmu =3D NULL;
> >> +               __u64 type =3D PERF_TYPE_RAW;
> >> +
> >> +               /*
> >> +                * The same register set is supported among different =
hybrid PMUs.
> >> +                * Only check the first available one.
> >> +                */
> >> +               while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) =
{
> >> +                       type =3D pmu->type;
> >> +                       break;
> >> +               }
> >> +               attr.config |=3D type << PERF_PMU_TYPE_SHIFT;
> >> +       }
> >> +
> >> +       event_attr_init(&attr);
> >> +
> >> +       fd =3D sys_perf_event_open(&attr, 0, -1, -1, 0);
> >> +       if (fd !=3D -1) {
> >> +               close(fd);
> >> +               return true;
> >> +       }
> >> +
> >> +       return false;
> >> +}
> >> +
> >> +static bool __arch_simd_reg_mask(u64 sample_type, int reg, uint64_t *=
mask, u16 *qwords)
> >> +{
> >> +       bool supported =3D false;
> >> +       u64 bits;
> >> +
> >> +       *mask =3D 0;
> >> +       *qwords =3D 0;
> >> +
> >> +       switch (reg) {
> >> +       case PERF_REG_X86_XMM:
> >> +               bits =3D BIT_ULL(PERF_X86_SIMD_XMM_REGS) - 1;
> >> +               supported =3D support_simd_reg(sample_type, PERF_X86_X=
MM_QWORDS, bits, false);
> >> +               if (supported) {
> >> +                       *mask =3D bits;
> >> +                       *qwords =3D PERF_X86_XMM_QWORDS;
> >> +               }
> >> +               break;
> >> +       case PERF_REG_X86_YMM:
> >> +               bits =3D BIT_ULL(PERF_X86_SIMD_YMM_REGS) - 1;
> >> +               supported =3D support_simd_reg(sample_type, PERF_X86_Y=
MM_QWORDS, bits, false);
> >> +               if (supported) {
> >> +                       *mask =3D bits;
> >> +                       *qwords =3D PERF_X86_YMM_QWORDS;
> >> +               }
> >> +               break;
> >> +       case PERF_REG_X86_ZMM:
> >> +               bits =3D BIT_ULL(PERF_X86_SIMD_ZMM_REGS) - 1;
> >> +               supported =3D support_simd_reg(sample_type, PERF_X86_Z=
MM_QWORDS, bits, false);
> >> +               if (supported) {
> >> +                       *mask =3D bits;
> >> +                       *qwords =3D PERF_X86_ZMM_QWORDS;
> >> +                       break;
> >> +               }
> >> +
> >> +               bits =3D BIT_ULL(PERF_X86_SIMD_ZMMH_REGS) - 1;
> >> +               supported =3D support_simd_reg(sample_type, PERF_X86_Z=
MM_QWORDS, bits, false);
> >> +               if (supported) {
> >> +                       *mask =3D bits;
> >> +                       *qwords =3D PERF_X86_ZMMH_QWORDS;
> >> +               }
> >> +               break;
> >> +       default:
> >> +               break;
> >> +       }
> >> +
> >> +       return supported;
> >> +}
> >> +
> >> +static bool __arch_pred_reg_mask(u64 sample_type, int reg, uint64_t *=
mask, u16 *qwords)
> >> +{
> >> +       bool supported =3D false;
> >> +       u64 bits;
> >> +
> >> +       *mask =3D 0;
> >> +       *qwords =3D 0;
> >> +
> >> +       switch (reg) {
> >> +       case PERF_REG_X86_OPMASK:
> >> +               bits =3D BIT_ULL(PERF_X86_SIMD_OPMASK_REGS) - 1;
> >> +               supported =3D support_simd_reg(sample_type, PERF_X86_O=
PMASK_QWORDS, bits, true);
> >> +               if (supported) {
> >> +                       *mask =3D bits;
> >> +                       *qwords =3D PERF_X86_OPMASK_QWORDS;
> >> +               }
> >> +               break;
> >> +       default:
> >> +               break;
> >> +       }
> >> +
> >> +       return supported;
> >> +}
> >> +
> >> +static bool has_cap_simd_regs(void)
> >> +{
> >> +       uint64_t mask =3D BIT_ULL(PERF_X86_SIMD_XMM_REGS) - 1;
> >> +       u16 qwords =3D PERF_X86_XMM_QWORDS;
> >> +       static bool has_cap_simd_regs;
> >> +       static bool cached;
> >> +
> >> +       if (cached)
> >> +               return has_cap_simd_regs;
> >> +
> >> +       has_cap_simd_regs =3D __arch_simd_reg_mask(PERF_SAMPLE_REGS_IN=
TR,
> >> +                                                PERF_REG_X86_XMM, &ma=
sk, &qwords);
> >> +       has_cap_simd_regs |=3D __arch_simd_reg_mask(PERF_SAMPLE_REGS_U=
SER,
> >> +                                                PERF_REG_X86_XMM, &ma=
sk, &qwords);
> >> +       cached =3D true;
> >> +
> >> +       return has_cap_simd_regs;
> >> +}
> >> +
> >> +bool arch_has_simd_regs(u64 mask)
> >> +{
> >> +       return has_cap_simd_regs() &&
> >> +              mask & GENMASK_ULL(PERF_REG_X86_SSP, PERF_REG_X86_R16);
> >> +}
> >> +
> >> +static const struct sample_reg sample_simd_reg_masks[] =3D {
> >> +       SMPL_REG(XMM, PERF_REG_X86_XMM),
> >> +       SMPL_REG(YMM, PERF_REG_X86_YMM),
> >> +       SMPL_REG(ZMM, PERF_REG_X86_ZMM),
> >> +       SMPL_REG_END
> >> +};
> >> +
> >> +static const struct sample_reg sample_pred_reg_masks[] =3D {
> >> +       SMPL_REG(OPMASK, PERF_REG_X86_OPMASK),
> >> +       SMPL_REG_END
> >> +};
> >> +
> >> +const struct sample_reg *arch__sample_simd_reg_masks(void)
> >> +{
> >> +       return sample_simd_reg_masks;
> >> +}
> >> +
> >> +const struct sample_reg *arch__sample_pred_reg_masks(void)
> >> +{
> >> +       return sample_pred_reg_masks;
> >> +}
> >> +
> >> +static bool x86_intr_simd_updated;
> >> +static u64 x86_intr_simd_reg_mask;
> >> +static u64 x86_intr_simd_mask[PERF_REG_X86_MAX_SIMD_REGS];
> >> +static u16 x86_intr_simd_qwords[PERF_REG_X86_MAX_SIMD_REGS];
> >> +static bool x86_user_simd_updated;
> >> +static u64 x86_user_simd_reg_mask;
> >> +static u64 x86_user_simd_mask[PERF_REG_X86_MAX_SIMD_REGS];
> >> +static u16 x86_user_simd_qwords[PERF_REG_X86_MAX_SIMD_REGS];
> >> +
> >> +static bool x86_intr_pred_updated;
> >> +static u64 x86_intr_pred_reg_mask;
> >> +static u64 x86_intr_pred_mask[PERF_REG_X86_MAX_PRED_REGS];
> >> +static u16 x86_intr_pred_qwords[PERF_REG_X86_MAX_PRED_REGS];
> >> +static bool x86_user_pred_updated;
> >> +static u64 x86_user_pred_reg_mask;
> >> +static u64 x86_user_pred_mask[PERF_REG_X86_MAX_PRED_REGS];
> >> +static u16 x86_user_pred_qwords[PERF_REG_X86_MAX_PRED_REGS];
> >> +
> >> +static uint64_t __arch__simd_reg_mask(u64 sample_type)
> >> +{
> >> +       const struct sample_reg *r =3D NULL;
> >> +       bool supported;
> >> +       u64 mask =3D 0;
> >> +       int reg;
> >> +
> >> +       if (!has_cap_simd_regs())
> >> +               return 0;
> >> +
> >> +       if (sample_type =3D=3D PERF_SAMPLE_REGS_INTR && x86_intr_simd_=
updated)
> >> +               return x86_intr_simd_reg_mask;
> >> +
> >> +       if (sample_type =3D=3D PERF_SAMPLE_REGS_USER && x86_user_simd_=
updated)
> >> +               return x86_user_simd_reg_mask;
> >> +
> >> +       for (r =3D arch__sample_simd_reg_masks(); r->name; r++) {
> >> +               supported =3D false;
> >> +
> >> +               if (!r->mask)
> >> +                       continue;
> >> +               reg =3D fls64(r->mask) - 1;
> >> +
> >> +               if (reg >=3D PERF_REG_X86_MAX_SIMD_REGS)
> >> +                       break;
> >> +               if (sample_type =3D=3D PERF_SAMPLE_REGS_INTR)
> >> +                       supported =3D __arch_simd_reg_mask(sample_type=
, reg,
> >> +                                                        &x86_intr_sim=
d_mask[reg],
> >> +                                                        &x86_intr_sim=
d_qwords[reg]);
> >> +               else if (sample_type =3D=3D PERF_SAMPLE_REGS_USER)
> >> +                       supported =3D __arch_simd_reg_mask(sample_type=
, reg,
> >> +                                                        &x86_user_sim=
d_mask[reg],
> >> +                                                        &x86_user_sim=
d_qwords[reg]);
> >> +               if (supported)
> >> +                       mask |=3D BIT_ULL(reg);
> >> +       }
> >> +
> >> +       if (sample_type =3D=3D PERF_SAMPLE_REGS_INTR) {
> >> +               x86_intr_simd_reg_mask =3D mask;
> >> +               x86_intr_simd_updated =3D true;
> >> +       } else {
> >> +               x86_user_simd_reg_mask =3D mask;
> >> +               x86_user_simd_updated =3D true;
> >> +       }
> >> +
> >> +       return mask;
> >> +}
> >> +
> >> +static uint64_t __arch__pred_reg_mask(u64 sample_type)
> >> +{
> >> +       const struct sample_reg *r =3D NULL;
> >> +       bool supported;
> >> +       u64 mask =3D 0;
> >> +       int reg;
> >> +
> >> +       if (!has_cap_simd_regs())
> >> +               return 0;
> >> +
> >> +       if (sample_type =3D=3D PERF_SAMPLE_REGS_INTR && x86_intr_pred_=
updated)
> >> +               return x86_intr_pred_reg_mask;
> >> +
> >> +       if (sample_type =3D=3D PERF_SAMPLE_REGS_USER && x86_user_pred_=
updated)
> >> +               return x86_user_pred_reg_mask;
> >> +
> >> +       for (r =3D arch__sample_pred_reg_masks(); r->name; r++) {
> >> +               supported =3D false;
> >> +
> >> +               if (!r->mask)
> >> +                       continue;
> >> +               reg =3D fls64(r->mask) - 1;
> >> +
> >> +               if (reg >=3D PERF_REG_X86_MAX_PRED_REGS)
> >> +                       break;
> >> +               if (sample_type =3D=3D PERF_SAMPLE_REGS_INTR)
> >> +                       supported =3D __arch_pred_reg_mask(sample_type=
, reg,
> >> +                                                        &x86_intr_pre=
d_mask[reg],
> >> +                                                        &x86_intr_pre=
d_qwords[reg]);
> >> +               else if (sample_type =3D=3D PERF_SAMPLE_REGS_USER)
> >> +                       supported =3D __arch_pred_reg_mask(sample_type=
, reg,
> >> +                                                        &x86_user_pre=
d_mask[reg],
> >> +                                                        &x86_user_pre=
d_qwords[reg]);
> >> +               if (supported)
> >> +                       mask |=3D BIT_ULL(reg);
> >> +       }
> >> +
> >> +       if (sample_type =3D=3D PERF_SAMPLE_REGS_INTR) {
> >> +               x86_intr_pred_reg_mask =3D mask;
> >> +               x86_intr_pred_updated =3D true;
> >> +       } else {
> >> +               x86_user_pred_reg_mask =3D mask;
> >> +               x86_user_pred_updated =3D true;
> >> +       }
> >> +
> >> +       return mask;
> >> +}
> >> +
> >> +uint64_t arch__intr_simd_reg_mask(void)
> >> +{
> >> +       return __arch__simd_reg_mask(PERF_SAMPLE_REGS_INTR);
> >> +}
> >> +
> >> +uint64_t arch__user_simd_reg_mask(void)
> >> +{
> >> +       return __arch__simd_reg_mask(PERF_SAMPLE_REGS_USER);
> >> +}
> >> +
> >> +uint64_t arch__intr_pred_reg_mask(void)
> >> +{
> >> +       return __arch__pred_reg_mask(PERF_SAMPLE_REGS_INTR);
> >> +}
> >> +
> >> +uint64_t arch__user_pred_reg_mask(void)
> >> +{
> >> +       return __arch__pred_reg_mask(PERF_SAMPLE_REGS_USER);
> >> +}
> >> +
> >> +static uint64_t arch__simd_reg_bitmap_qwords(int reg, u16 *qwords, bo=
ol intr)
> >> +{
> >> +       uint64_t mask =3D 0;
> >> +
> >> +       *qwords =3D 0;
> >> +       if (reg < PERF_REG_X86_MAX_SIMD_REGS) {
> >> +               if (intr) {
> >> +                       *qwords =3D x86_intr_simd_qwords[reg];
> >> +                       mask =3D x86_intr_simd_mask[reg];
> >> +               } else {
> >> +                       *qwords =3D x86_user_simd_qwords[reg];
> >> +                       mask =3D x86_user_simd_mask[reg];
> >> +               }
> >> +       }
> >> +
> >> +       return mask;
> >> +}
> >> +
> >> +static uint64_t arch__pred_reg_bitmap_qwords(int reg, u16 *qwords, bo=
ol intr)
> >> +{
> >> +       uint64_t mask =3D 0;
> >> +
> >> +       *qwords =3D 0;
> >> +       if (reg < PERF_REG_X86_MAX_PRED_REGS) {
> >> +               if (intr) {
> >> +                       *qwords =3D x86_intr_pred_qwords[reg];
> >> +                       mask =3D x86_intr_pred_mask[reg];
> >> +               } else {
> >> +                       *qwords =3D x86_user_pred_qwords[reg];
> >> +                       mask =3D x86_user_pred_mask[reg];
> >> +               }
> >> +       }
> >> +
> >> +       return mask;
> >> +}
> >> +
> >> +uint64_t arch__intr_simd_reg_bitmap_qwords(int reg, u16 *qwords)
> >> +{
> >> +       if (!x86_intr_simd_updated)
> >> +               arch__intr_simd_reg_mask();
> >> +       return arch__simd_reg_bitmap_qwords(reg, qwords, true);
> >> +}
> >> +
> >> +uint64_t arch__user_simd_reg_bitmap_qwords(int reg, u16 *qwords)
> >> +{
> >> +       if (!x86_user_simd_updated)
> >> +               arch__user_simd_reg_mask();
> >> +       return arch__simd_reg_bitmap_qwords(reg, qwords, false);
> >> +}
> >> +
> >> +uint64_t arch__intr_pred_reg_bitmap_qwords(int reg, u16 *qwords)
> >> +{
> >> +       if (!x86_intr_pred_updated)
> >> +               arch__intr_pred_reg_mask();
> >> +       return arch__pred_reg_bitmap_qwords(reg, qwords, true);
> >> +}
> >> +
> >> +uint64_t arch__user_pred_reg_bitmap_qwords(int reg, u16 *qwords)
> >> +{
> >> +       if (!x86_user_pred_updated)
> >> +               arch__user_pred_reg_mask();
> >> +       return arch__pred_reg_bitmap_qwords(reg, qwords, false);
> >> +}
> >> +
> >>  const struct sample_reg *arch__sample_reg_masks(void)
> >>  {
> >> +       if (has_cap_simd_regs())
> >> +               return sample_reg_masks_ext;
> >>         return sample_reg_masks;
> >>  }
> >>
> >> -uint64_t arch__intr_reg_mask(void)
> >> +static uint64_t __arch__reg_mask(u64 sample_type, u64 mask, bool has_=
simd_regs)
> >>  {
> >>         struct perf_event_attr attr =3D {
> >> -               .type                   =3D PERF_TYPE_HARDWARE,
> >> -               .config                 =3D PERF_COUNT_HW_CPU_CYCLES,
> >> -               .sample_type            =3D PERF_SAMPLE_REGS_INTR,
> >> -               .sample_regs_intr       =3D PERF_REG_EXTENDED_MASK,
> >> -               .precise_ip             =3D 1,
> >> -               .disabled               =3D 1,
> >> -               .exclude_kernel         =3D 1,
> >> +               .type                           =3D PERF_TYPE_HARDWARE=
,
> >> +               .config                         =3D PERF_COUNT_HW_CPU_=
CYCLES,
> >> +               .sample_type                    =3D sample_type,
> >> +               .precise_ip                     =3D 1,
> >> +               .disabled                       =3D 1,
> >> +               .exclude_kernel                 =3D 1,
> >> +               .sample_simd_regs_enabled       =3D has_simd_regs,
> >>         };
> >>         int fd;
> >>         /*
> >>          * In an unnamed union, init it here to build on older gcc ver=
sions
> >>          */
> >>         attr.sample_period =3D 1;
> >> +       if (sample_type =3D=3D PERF_SAMPLE_REGS_INTR)
> >> +               attr.sample_regs_intr =3D mask;
> >> +       else
> >> +               attr.sample_regs_user =3D mask;
> >>
> >>         if (perf_pmus__num_core_pmus() > 1) {
> >>                 struct perf_pmu *pmu =3D NULL;
> >> @@ -318,13 +738,41 @@ uint64_t arch__intr_reg_mask(void)
> >>         fd =3D sys_perf_event_open(&attr, 0, -1, -1, 0);
> >>         if (fd !=3D -1) {
> >>                 close(fd);
> >> -               return (PERF_REG_EXTENDED_MASK | PERF_REGS_MASK);
> >> +               return mask;
> >>         }
> >>
> >> -       return PERF_REGS_MASK;
> >> +       return 0;
> >> +}
> >> +
> >> +uint64_t arch__intr_reg_mask(void)
> >> +{
> >> +       uint64_t mask =3D PERF_REGS_MASK;
> >> +
> >> +       if (has_cap_simd_regs()) {
> >> +               mask |=3D __arch__reg_mask(PERF_SAMPLE_REGS_INTR,
> >> +                                        GENMASK_ULL(PERF_REG_X86_R31,=
 PERF_REG_X86_R16),
> >> +                                        true);
> >> +               mask |=3D __arch__reg_mask(PERF_SAMPLE_REGS_INTR,
> >> +                                        BIT_ULL(PERF_REG_X86_SSP),
> >> +                                        true);
> >> +       } else
> >> +               mask |=3D __arch__reg_mask(PERF_SAMPLE_REGS_INTR, PERF=
_REG_EXTENDED_MASK, false);
> >> +
> >> +       return mask;
> >>  }
> >>
> >>  uint64_t arch__user_reg_mask(void)
> >>  {
> >> -       return PERF_REGS_MASK;
> >> +       uint64_t mask =3D PERF_REGS_MASK;
> >> +
> >> +       if (has_cap_simd_regs()) {
> >> +               mask |=3D __arch__reg_mask(PERF_SAMPLE_REGS_USER,
> >> +                                        GENMASK_ULL(PERF_REG_X86_R31,=
 PERF_REG_X86_R16),
> >> +                                        true);
> >> +               mask |=3D __arch__reg_mask(PERF_SAMPLE_REGS_USER,
> >> +                                        BIT_ULL(PERF_REG_X86_SSP),
> >> +                                        true);
> >> +       }
> >> +
> >> +       return mask;
> >>  }
> >> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >> index 56ebefd075f2..5d1d90cf9488 100644
> >> --- a/tools/perf/util/evsel.c
> >> +++ b/tools/perf/util/evsel.c
> >> @@ -1461,12 +1461,39 @@ void evsel__config(struct evsel *evsel, struct=
 record_opts *opts,
> >>         if (opts->sample_intr_regs && !evsel->no_aux_samples &&
> >>             !evsel__is_dummy_event(evsel)) {
> >>                 attr->sample_regs_intr =3D opts->sample_intr_regs;
> >> +               attr->sample_simd_regs_enabled =3D arch_has_simd_regs(=
attr->sample_regs_intr);
> >> +               evsel__set_sample_bit(evsel, REGS_INTR);
> >> +       }
> >> +
> >> +       if ((opts->sample_intr_vec_regs || opts->sample_intr_pred_regs=
) &&
> >> +           !evsel->no_aux_samples && !evsel__is_dummy_event(evsel)) {
> >> +               /* The pred qwords is to implies the set of SIMD regis=
ters is used */
> >> +               if (opts->sample_pred_regs_qwords)
> >> +                       attr->sample_simd_pred_reg_qwords =3D opts->sa=
mple_pred_regs_qwords;
> >> +               else
> >> +                       attr->sample_simd_pred_reg_qwords =3D 1;
> >> +               attr->sample_simd_vec_reg_intr =3D opts->sample_intr_v=
ec_regs;
> >> +               attr->sample_simd_vec_reg_qwords =3D opts->sample_vec_=
regs_qwords;
> >> +               attr->sample_simd_pred_reg_intr =3D opts->sample_intr_=
pred_regs;
> >>                 evsel__set_sample_bit(evsel, REGS_INTR);
> >>         }
> >>
> >>         if (opts->sample_user_regs && !evsel->no_aux_samples &&
> >>             !evsel__is_dummy_event(evsel)) {
> >>                 attr->sample_regs_user |=3D opts->sample_user_regs;
> >> +               attr->sample_simd_regs_enabled =3D arch_has_simd_regs(=
attr->sample_regs_user);
> >> +               evsel__set_sample_bit(evsel, REGS_USER);
> >> +       }
> >> +
> >> +       if ((opts->sample_user_vec_regs || opts->sample_user_pred_regs=
) &&
> >> +           !evsel->no_aux_samples && !evsel__is_dummy_event(evsel)) {
> >> +               if (opts->sample_pred_regs_qwords)
> >> +                       attr->sample_simd_pred_reg_qwords =3D opts->sa=
mple_pred_regs_qwords;
> >> +               else
> >> +                       attr->sample_simd_pred_reg_qwords =3D 1;
> >> +               attr->sample_simd_vec_reg_user =3D opts->sample_user_v=
ec_regs;
> >> +               attr->sample_simd_vec_reg_qwords =3D opts->sample_vec_=
regs_qwords;
> >> +               attr->sample_simd_pred_reg_user =3D opts->sample_user_=
pred_regs;
> >>                 evsel__set_sample_bit(evsel, REGS_USER);
> >>         }
> >>
> >> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/pa=
rse-regs-options.c
> >> index cda1c620968e..0bd100392889 100644
> >> --- a/tools/perf/util/parse-regs-options.c
> >> +++ b/tools/perf/util/parse-regs-options.c
> >> @@ -4,19 +4,139 @@
> >>  #include <stdint.h>
> >>  #include <string.h>
> >>  #include <stdio.h>
> >> +#include <linux/bitops.h>
> >>  #include "util/debug.h"
> >>  #include <subcmd/parse-options.h>
> >>  #include "util/perf_regs.h"
> >>  #include "util/parse-regs-options.h"
> >> +#include "record.h"
> >> +
> >> +static void __print_simd_regs(bool intr, uint64_t simd_mask)
> >> +{
> >> +       const struct sample_reg *r =3D NULL;
> >> +       uint64_t bitmap =3D 0;
> >> +       u16 qwords =3D 0;
> >> +       int reg_idx;
> >> +
> >> +       if (!simd_mask)
> >> +               return;
> >> +
> >> +       for (r =3D arch__sample_simd_reg_masks(); r->name; r++) {
> >> +               if (!(r->mask & simd_mask))
> >> +                       continue;
> >> +               reg_idx =3D fls64(r->mask) - 1;
> >> +               if (intr)
> >> +                       bitmap =3D arch__intr_simd_reg_bitmap_qwords(r=
eg_idx, &qwords);
> >> +               else
> >> +                       bitmap =3D arch__user_simd_reg_bitmap_qwords(r=
eg_idx, &qwords);
> >> +               if (bitmap)
> >> +                       fprintf(stderr, "%s0-%d ", r->name, fls64(bitm=
ap) - 1);
> >> +       }
> >> +}
> >> +
> >> +static void __print_pred_regs(bool intr, uint64_t pred_mask)
> >> +{
> >> +       const struct sample_reg *r =3D NULL;
> >> +       uint64_t bitmap =3D 0;
> >> +       u16 qwords =3D 0;
> >> +       int reg_idx;
> >> +
> >> +       if (!pred_mask)
> >> +               return;
> >> +
> >> +       for (r =3D arch__sample_pred_reg_masks(); r->name; r++) {
> >> +               if (!(r->mask & pred_mask))
> >> +                       continue;
> >> +               reg_idx =3D fls64(r->mask) - 1;
> >> +               if (intr)
> >> +                       bitmap =3D arch__intr_pred_reg_bitmap_qwords(r=
eg_idx, &qwords);
> >> +               else
> >> +                       bitmap =3D arch__user_pred_reg_bitmap_qwords(r=
eg_idx, &qwords);
> >> +               if (bitmap)
> >> +                       fprintf(stderr, "%s0-%d ", r->name, fls64(bitm=
ap) - 1);
> >> +       }
> >> +}
> >> +
> >> +static bool __parse_simd_regs(struct record_opts *opts, char *s, bool=
 intr)
> >> +{
> >> +       const struct sample_reg *r =3D NULL;
> >> +       bool matched =3D false;
> >> +       uint64_t bitmap =3D 0;
> >> +       u16 qwords =3D 0;
> >> +       int reg_idx;
> >> +
> >> +       for (r =3D arch__sample_simd_reg_masks(); r->name; r++) {
> >> +               if (strcasecmp(s, r->name))
> >> +                       continue;
> >> +               if (!fls64(r->mask))
> >> +                       continue;
> >> +               reg_idx =3D fls64(r->mask) - 1;
> >> +               if (intr)
> >> +                       bitmap =3D arch__intr_simd_reg_bitmap_qwords(r=
eg_idx, &qwords);
> >> +               else
> >> +                       bitmap =3D arch__user_simd_reg_bitmap_qwords(r=
eg_idx, &qwords);
> >> +               matched =3D true;
> >> +               break;
> >> +       }
> >> +
> >> +       /* Just need the highest qwords */
> >> +       if (qwords > opts->sample_vec_regs_qwords) {
> >> +               opts->sample_vec_regs_qwords =3D qwords;
> >> +               if (intr)
> >> +                       opts->sample_intr_vec_regs =3D bitmap;
> >> +               else
> >> +                       opts->sample_user_vec_regs =3D bitmap;
> >> +       }
> >> +
> >> +       return matched;
> >> +}
> >> +
> >> +static bool __parse_pred_regs(struct record_opts *opts, char *s, bool=
 intr)
> >> +{
> >> +       const struct sample_reg *r =3D NULL;
> >> +       bool matched =3D false;
> >> +       uint64_t bitmap =3D 0;
> >> +       u16 qwords =3D 0;
> >> +       int reg_idx;
> >> +
> >> +       for (r =3D arch__sample_pred_reg_masks(); r->name; r++) {
> >> +               if (strcasecmp(s, r->name))
> >> +                       continue;
> >> +               if (!fls64(r->mask))
> >> +                       continue;
> >> +               reg_idx =3D fls64(r->mask) - 1;
> >> +               if (intr)
> >> +                       bitmap =3D arch__intr_pred_reg_bitmap_qwords(r=
eg_idx, &qwords);
> >> +               else
> >> +                       bitmap =3D arch__user_pred_reg_bitmap_qwords(r=
eg_idx, &qwords);
> >> +               matched =3D true;
> >> +               break;
> >> +       }
> >> +
> >> +       /* Just need the highest qwords */
> >> +       if (qwords > opts->sample_pred_regs_qwords) {
> >> +               opts->sample_pred_regs_qwords =3D qwords;
> >> +               if (intr)
> >> +                       opts->sample_intr_pred_regs =3D bitmap;
> >> +               else
> >> +                       opts->sample_user_pred_regs =3D bitmap;
> >> +       }
> >> +
> >> +       return matched;
> >> +}
> >>
> >>  static int
> >>  __parse_regs(const struct option *opt, const char *str, int unset, bo=
ol intr)
> >>  {
> >>         uint64_t *mode =3D (uint64_t *)opt->value;
> >>         const struct sample_reg *r =3D NULL;
> >> +       struct record_opts *opts;
> >>         char *s, *os =3D NULL, *p;
> >> -       int ret =3D -1;
> >> +       bool has_simd_regs =3D false;
> >>         uint64_t mask;
> >> +       uint64_t simd_mask;
> >> +       uint64_t pred_mask;
> >> +       int ret =3D -1;
> >>
> >>         if (unset)
> >>                 return 0;
> >> @@ -27,10 +147,17 @@ __parse_regs(const struct option *opt, const char=
 *str, int unset, bool intr)
> >>         if (*mode)
> >>                 return -1;
> >>
> >> -       if (intr)
> >> +       if (intr) {
> >> +               opts =3D container_of(opt->value, struct record_opts, =
sample_intr_regs);
> >>                 mask =3D arch__intr_reg_mask();
> >> -       else
> >> +               simd_mask =3D arch__intr_simd_reg_mask();
> >> +               pred_mask =3D arch__intr_pred_reg_mask();
> >> +       } else {
> >> +               opts =3D container_of(opt->value, struct record_opts, =
sample_user_regs);
> >>                 mask =3D arch__user_reg_mask();
> >> +               simd_mask =3D arch__user_simd_reg_mask();
> >> +               pred_mask =3D arch__user_pred_reg_mask();
> >> +       }
> >>
> >>         /* str may be NULL in case no arg is passed to -I */
> >>         if (str) {
> >> @@ -50,10 +177,24 @@ __parse_regs(const struct option *opt, const char=
 *str, int unset, bool intr)
> >>                                         if (r->mask & mask)
> >>                                                 fprintf(stderr, "%s ",=
 r->name);
> >>                                 }
> >> +                               __print_simd_regs(intr, simd_mask);
> >> +                               __print_pred_regs(intr, pred_mask);
> >>                                 fputc('\n', stderr);
> >>                                 /* just printing available regs */
> >>                                 goto error;
> >>                         }
> >> +
> >> +                       if (simd_mask) {
> >> +                               has_simd_regs =3D __parse_simd_regs(op=
ts, s, intr);
> >> +                               if (has_simd_regs)
> >> +                                       goto next;
> >> +                       }
> >> +                       if (pred_mask) {
> >> +                               has_simd_regs =3D __parse_pred_regs(op=
ts, s, intr);
> >> +                               if (has_simd_regs)
> >> +                                       goto next;
> >> +                       }
> >> +
> >>                         for (r =3D arch__sample_reg_masks(); r->name; =
r++) {
> >>                                 if ((r->mask & mask) && !strcasecmp(s,=
 r->name))
> >>                                         break;
> >> @@ -65,7 +206,7 @@ __parse_regs(const struct option *opt, const char *=
str, int unset, bool intr)
> >>                         }
> >>
> >>                         *mode |=3D r->mask;
> >> -
> >> +next:
> >>                         if (!p)
> >>                                 break;
> >>
> >> @@ -75,7 +216,7 @@ __parse_regs(const struct option *opt, const char *=
str, int unset, bool intr)
> >>         ret =3D 0;
> >>
> >>         /* default to all possible regs */
> >> -       if (*mode =3D=3D 0)
> >> +       if (*mode =3D=3D 0 && !has_simd_regs)
> >>                 *mode =3D mask;
> >>  error:
> >>         free(os);
> >> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/ut=
il/perf_event_attr_fprintf.c
> >> index 66b666d9ce64..fb0366d050cf 100644
> >> --- a/tools/perf/util/perf_event_attr_fprintf.c
> >> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> >> @@ -360,6 +360,12 @@ int perf_event_attr__fprintf(FILE *fp, struct per=
f_event_attr *attr,
> >>         PRINT_ATTRf(aux_start_paused, p_unsigned);
> >>         PRINT_ATTRf(aux_pause, p_unsigned);
> >>         PRINT_ATTRf(aux_resume, p_unsigned);
> >> +       PRINT_ATTRf(sample_simd_pred_reg_qwords, p_unsigned);
> >> +       PRINT_ATTRf(sample_simd_pred_reg_intr, p_hex);
> >> +       PRINT_ATTRf(sample_simd_pred_reg_user, p_hex);
> >> +       PRINT_ATTRf(sample_simd_vec_reg_qwords, p_unsigned);
> >> +       PRINT_ATTRf(sample_simd_vec_reg_intr, p_hex);
> >> +       PRINT_ATTRf(sample_simd_vec_reg_user, p_hex);
> >>
> >>         return ret;
> >>  }
> >> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> >> index 44b90bbf2d07..e8a9fabc92e6 100644
> >> --- a/tools/perf/util/perf_regs.c
> >> +++ b/tools/perf/util/perf_regs.c
> >> @@ -11,6 +11,11 @@ int __weak arch_sdt_arg_parse_op(char *old_op __may=
be_unused,
> >>         return SDT_ARG_SKIP;
> >>  }
> >>
> >> +bool __weak arch_has_simd_regs(u64 mask __maybe_unused)
> >> +{
> >> +       return false;
> >> +}
> >> +
> >>  uint64_t __weak arch__intr_reg_mask(void)
> >>  {
> >>         return 0;
> >> @@ -21,6 +26,50 @@ uint64_t __weak arch__user_reg_mask(void)
> >>         return 0;
> >>  }
> >>
> >> +uint64_t __weak arch__intr_simd_reg_mask(void)
> >> +{
> >> +       return 0;
> >> +}
> >> +
> >> +uint64_t __weak arch__user_simd_reg_mask(void)
> >> +{
> >> +       return 0;
> >> +}
> >> +
> >> +uint64_t __weak arch__intr_pred_reg_mask(void)
> >> +{
> >> +       return 0;
> >> +}
> >> +
> >> +uint64_t __weak arch__user_pred_reg_mask(void)
> >> +{
> >> +       return 0;
> >> +}
> >> +
> >> +uint64_t __weak arch__intr_simd_reg_bitmap_qwords(int reg  __maybe_un=
used, u16 *qwords)
> >> +{
> >> +       *qwords =3D 0;
> >> +       return 0;
> >> +}
> >> +
> >> +uint64_t __weak arch__user_simd_reg_bitmap_qwords(int reg __maybe_unu=
sed, u16 *qwords)
> >> +{
> >> +       *qwords =3D 0;
> >> +       return 0;
> >> +}
> >> +
> >> +uint64_t __weak arch__intr_pred_reg_bitmap_qwords(int reg  __maybe_un=
used, u16 *qwords)
> >> +{
> >> +       *qwords =3D 0;
> >> +       return 0;
> >> +}
> >> +
> >> +uint64_t __weak arch__user_pred_reg_bitmap_qwords(int reg __maybe_unu=
sed, u16 *qwords)
> >> +{
> >> +       *qwords =3D 0;
> >> +       return 0;
> >> +}
> >> +
> >>  static const struct sample_reg sample_reg_masks[] =3D {
> >>         SMPL_REG_END
> >>  };
> >> @@ -30,6 +79,16 @@ const struct sample_reg * __weak arch__sample_reg_m=
asks(void)
> >>         return sample_reg_masks;
> >>  }
> >>
> >> +const struct sample_reg * __weak arch__sample_simd_reg_masks(void)
> >> +{
> >> +       return sample_reg_masks;
> >> +}
> >> +
> >> +const struct sample_reg * __weak arch__sample_pred_reg_masks(void)
> >> +{
> >> +       return sample_reg_masks;
> >> +}
> >> +
> >>  const char *perf_reg_name(int id, const char *arch)
> >>  {
> >>         const char *reg_name =3D NULL;
> >> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> >> index f2d0736d65cc..bce9c4cfd1bf 100644
> >> --- a/tools/perf/util/perf_regs.h
> >> +++ b/tools/perf/util/perf_regs.h
> >> @@ -24,9 +24,20 @@ enum {
> >>  };
> >>
> >>  int arch_sdt_arg_parse_op(char *old_op, char **new_op);
> >> +bool arch_has_simd_regs(u64 mask);
> >>  uint64_t arch__intr_reg_mask(void);
> >>  uint64_t arch__user_reg_mask(void);
> >>  const struct sample_reg *arch__sample_reg_masks(void);
> >> +const struct sample_reg *arch__sample_simd_reg_masks(void);
> >> +const struct sample_reg *arch__sample_pred_reg_masks(void);
> > I wonder we can remove these functions. perf_reg_name(int id, uint16_t
> > e_machine) maps a perf register number and e_machine to a string. So
> > the sample_reg array could be replaced with:
> > ```
> > for (int perf_reg =3D 0; perf_reg < 64; perf_reg++) {
> >   uint64_t mask =3D 1LL << perf_reg;
> >   const char *name =3D perf_reg_name(perf_reg, EM_HOST);
> >   if (name =3D=3D NULL)
> >     break;
> >   // use mask and name
> > ```
> > To make it work for SIMD and PRED then I guess we need to iterate
> > through the ABIs of enum perf_sample_regs_abi.
>
> Suppose so.
>
>
> >
> >> +uint64_t arch__intr_simd_reg_mask(void);
> >> +uint64_t arch__user_simd_reg_mask(void);
> >> +uint64_t arch__intr_pred_reg_mask(void);
> >> +uint64_t arch__user_pred_reg_mask(void);
> > I think some comments would be useful here like:
> > ```
> > /* Perf register bit map with valid bits for
> > perf_event_attr.sample_regs_user. */
> > uint64_t arch__intr_reg_mask(void);
> > /* Perf register bit map with valid bits for
> > perf_event_attr.sample_regs_intr. */
> > uint64_t arch__user_reg_mask(void);
> > /* Perf register bit map with valid bits for
> > perf_event_attr.sample_simd_vec_reg_intr. */
> > uint64_t arch__intr_simd_reg_mask(void);
> > /* Perf register bit map with valid bits for
> > perf_event_attr.sample_simd_vec_reg_user. */
> > uint64_t arch__user_simd_reg_mask(void);
> > /* Perf register bit map with valid bits for
> > perf_event_attr.sample_simd_pred_reg_intr. */
> > uint64_t arch__intr_pred_reg_mask(void);
> > /* Perf register bit map with valid bits for
> > perf_event_attr.sample_simd_pred_reg_user. */
> > uint64_t arch__user_pred_reg_mask(void);
>
> Sure. Thanks.
>
>
> > ```
> >
> > Why do the arch__user_pred_reg_mask return a uint64_t when the
> > perf_event_attr variable is a __u32?
>
> Suppose it's a bug. :)
>
>
> >
> >> +uint64_t arch__intr_simd_reg_bitmap_qwords(int reg, u16 *qwords);
> >> +uint64_t arch__user_simd_reg_bitmap_qwords(int reg, u16 *qwords);
> >> +uint64_t arch__intr_pred_reg_bitmap_qwords(int reg, u16 *qwords);
> >> +uint64_t arch__user_pred_reg_bitmap_qwords(int reg, u16 *qwords);
> > I don't understand this function. The qwords is specific to a
> > perf_event_attr. We could have an evlist with an evsel set up to
> > sample say XMM registers and another evsel set up to sample ZMM
> > registers. Are the qwords here always for the ZMM case, or is XMM,
> > YMM, ZMM depending on architecture support? Why does it vary per
> > register? The surrounding code uses the term mask but here bitmap is
> > used, is the inconsistency deliberate? Why are there user and intr
> > functions when in the perf_event_attr there are only
> > sample_simd_pred_reg_qwords and sample_simd_ved_reg_qwords variables?
>
> These 4 functions is designed to get the bitmask and qwords length for a
> specific SIMD registers. E.g., For XMM on x86 platforms, the returned
> bitmask is 0xffff (xmm0 ~ xmm15) and the qwords length is 2 (128 bits). F=
or
> ZMM on x86 platforms, if the platform only supports 16 ZMM registers, the=
n
> the returned bitmask is 0xffff (zmm0 ~ zmm15) and qwords length is 8 (512
> bits). If the platform supports 32 ZMM registers, then the returned bitma=
sk
> is 0xffffffff (zmm0 ~ zmm31) and qwords length is 8 (512 bits).

What is the meaning of reg? In this file it is normally the integer
index for a bit in the sample_regs_user mask, but for x86 I don't see
enum perf_event_x86_regs having differing XMM, YMM and ZMM encodings.
Similarly, is qwords an out argument, but then you also have the
bitmap. It looks like the code is caching values but that assumes a
single qword length for all events.

> Since the qword length is always fixed for any certain SIMD register
> regardless of intr or user, so there is only one
> sample_simd_pred_reg_qwords or sample_simd_ved_reg_qwords variable.

Ok.  2 variables, but 4 functions here. I think there should just be 2
because of this.

Thanks,
Ian

> >
> > Perhaps these functions should be something more like:
> > ```
> > /* Maximum value that can be assigned to
> > perf_event_atttr.sample_simd_pred_reg_qwords. */
> > uint16_t arch__simd_pred_reg_qwords_max(void);
> > /* Maximum value that can be assigned to
> > perf_event_atttr.sample_simd_vec_reg_qwords. */
> > uint16_t arch__simd_vec_reg_qwords_max(void);
> > ```
> > Then the bitmap computation logic can all be moved into parse-regs-opti=
ons.c.
> >
> > Thanks,
> > Ian
> >
> >>  const char *perf_reg_name(int id, const char *arch);
> >>  int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
> >> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> >> index ea3a6c4657ee..825ffb4cc53f 100644
> >> --- a/tools/perf/util/record.h
> >> +++ b/tools/perf/util/record.h
> >> @@ -59,7 +59,13 @@ struct record_opts {
> >>         unsigned int  user_freq;
> >>         u64           branch_stack;
> >>         u64           sample_intr_regs;
> >> +       u64           sample_intr_vec_regs;
> >>         u64           sample_user_regs;
> >> +       u64           sample_user_vec_regs;
> >> +       u16           sample_pred_regs_qwords;
> >> +       u16           sample_vec_regs_qwords;
> >> +       u16           sample_intr_pred_regs;
> >> +       u16           sample_user_pred_regs;
> >>         u64           default_interval;
> >>         u64           user_interval;
> >>         size_t        auxtrace_snapshot_size;
> >> --
> >> 2.34.1
> >>
