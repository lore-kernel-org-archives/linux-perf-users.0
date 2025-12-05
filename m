Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D102C2365
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Dec 2025 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764952559; cv=none; b=EtjVdHL9QYXe6nH8xs6xrOIn3EAoLR/4cNNBai64WYg+Nea9rW1U1ZfAVn/VHHDe+wDlIfA7NWDmELWZmAubVxi8yrjjkJlYsJ5SOFtRtBh+yY0XJx10uA65MzlI8Iq1RkxtAxU5OMvCk0Dfea9u8ZhaTY9nZpzliY2RNWDdjw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764952559; c=relaxed/simple;
	bh=BeUKYAMnv43oVMNOSqIkXm03FGrL7aVKg8YcSyFzoLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPG7evrLpcv1JKVg8oUqTUCgX/JXz+8k1huy/rdKb13O1zj8Ofy67LaGCQG9pUFxmlkBwh9ZMyJ55gDIjaNygsX+Y2KMgQYL5JWiUBstM0kih4ZVAeKtSAapGKgyhvxWMj4Q9xSmyLkizaIb2CU/vwFMMlx6rmf7Oul03u3f1lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EEubx9zH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EEubx9zH"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297e13bf404so231115ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Dec 2025 08:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764952549; x=1765557349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xs+h+q3ZUmYnirqG64Ne6heLPGOPvsasew4qahUi9CM=;
        b=EEubx9zHAQkwfAZp5r74i0oiqzTiPtqSsiIgA8ZE47DqJTX1ZZr3TBTgz5xJgob1tt
         c/BPV8MfYznsBCUebIeNj5rhUf86zx+a242k6KjZQIlUBHMPoizwuCRnXIQ3b3ovIFtQ
         nbR+zetzt3xXHdeStckn3q00yeGelOvpHIB4KPu4TgkACcoqAiCsBwsRf0ozX2hTJz3C
         fpzfLWpxKPyW4B4vsEh8zHXGQBetxPsAqGR+9vcL6vzN6J5nuMztJKODxeRUgGbZnEur
         uK2Fypc65ykyTMPQPC4f6dUf9l738ldKTycWiH7gPkuzdoJxcrmGP3PmOYAD9gFMwZut
         ZzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764952549; x=1765557349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xs+h+q3ZUmYnirqG64Ne6heLPGOPvsasew4qahUi9CM=;
        b=PMfjZUEq7JU2oE8P5GCXcm/82NO5ZAbQcOcc1Z0tfA3jqMsb2SaGE47Wd9qqWn5HHT
         E/siv1mUJlFtdji3fmTNiPRVvjLdLeKr8/9HBGXmOL/Wt7MrKuCzhC2JnvEZhCQlzERy
         VShrgAKkNz8KhFHLqlCekm7f8wv3TuJhGHtA8NKthExn4q/Xe2y9ZMtWwZJDgyrGi1SM
         vevKLAn4yAt43fHvHmGzZ3Y7j5fq25Oitpnw9J3kXnobMsL3Ii71ZrzU23eOHKDEIn++
         bn7S4EPXSnWS9Ij6G6eoKloE1GhebYhSoT8ZVqt2F3OcTrbL8nw4Nbio4Hdmw1h4yfVR
         15XA==
X-Forwarded-Encrypted: i=1; AJvYcCVkh2062tnetwLqKMUnwrnEXc2pO4t1bGvVot3xvNO6R4/L3VeSY7PfquRGnM5HoKGK7frCvr2GqVUDzUITIME+@vger.kernel.org
X-Gm-Message-State: AOJu0YzWpIi30AysdvbwuhXLNP4BKLvI1GuYb8KA3j5ZWpAUJqw2M/aQ
	mUTgtF353Wut6gMhZVmnrt2ebC6vi6ew88RxckXtD4U5qBVTvwM8k5BKi4BZPqC3SAsvr1GuWvx
	3kHqBumRX2l978VDnbhgvaibHcdKTUC5GVwBcZool
X-Gm-Gg: ASbGncvaiFAZoL0lXbZj79OHuzNpbxnCwgic5/nQBw9SHQVmkrSvHXComZfjmK6cNf5
	S0azSEWPb6ucpHyjY6Jd1BGoAyPjPbIFuMz6/bvJT6BWwg/HSpM+xKxL//t5y0LUeN7USx08i/I
	2oDzzZz7n3x+KgpX1hWNEADhyTTR1Ebd9Wa6scLt8m5FuKeiqBlO+ehU2qfEC34XSUAlP0B90a5
	DiemCyEWmpJxxATyvn+p6jfZjQ4qmP35QpfOmDVsE0CeEEop0bd28AZp8DqPNlg7K0gFpL3AX3L
	G7zxetCKfup7gp/w1WieWadEpg==
X-Google-Smtp-Source: AGHT+IFDNxX6U5KX6L+mQaMxYg3V/IuiMmQxHdkEJw44msKGOXTTy5843q2yPBKlzix4R/BUtXNtdHxFTaT16CFkmn8=
X-Received: by 2002:a17:902:f691:b0:298:4819:f4d9 with SMTP id
 d9443c01a7336-29dd179b4afmr1688175ad.8.1764952548332; Fri, 05 Dec 2025
 08:35:48 -0800 (PST)
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
 <47014c3e-0fca-4248-9f23-09007f9ee95f@linux.intel.com>
In-Reply-To: <47014c3e-0fca-4248-9f23-09007f9ee95f@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 5 Dec 2025 08:35:36 -0800
X-Gm-Features: AWmQ_bl_6Q7UqjRPxJ7pkGUmNjQd1GKtxrOBVz1fjf7-yShFLud58J7480i9Zcc
Message-ID: <CAP-5=fVbWp5bdnxrcA4XQPvFa2iYB3583C4DzOP7wA=oPqvcKQ@mail.gmail.com>
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

On Fri, Dec 5, 2025 at 12:10=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 12/5/2025 2:38 PM, Ian Rogers wrote:
> > On Thu, Dec 4, 2025 at 8:00=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.int=
el.com> wrote:
> >>
> >> On 12/5/2025 12:16 AM, Ian Rogers wrote:
> >>> On Thu, Dec 4, 2025 at 1:20=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.i=
ntel.com> wrote:
> >>>> On 12/4/2025 3:49 PM, Ian Rogers wrote:
> >>>>> On Wed, Dec 3, 2025 at 6:58=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux=
.intel.com> wrote:
> >>>>>> On 12/4/2025 8:17 AM, Ian Rogers wrote:
> >>>>>>> On Tue, Dec 2, 2025 at 10:59=E2=80=AFPM Dapeng Mi <dapeng1.mi@lin=
ux.intel.com> wrote:
> >>>>>>>> From: Kan Liang <kan.liang@linux.intel.com>
> >>>>>>>>
> >>>>>>>> This patch adds support for the newly introduced SIMD register s=
ampling
> >>>>>>>> format by adding the following functions:
> >>>>>>>>
> >>>>>>>> uint64_t arch__intr_simd_reg_mask(void);
> >>>>>>>> uint64_t arch__user_simd_reg_mask(void);
> >>>>>>>> uint64_t arch__intr_pred_reg_mask(void);
> >>>>>>>> uint64_t arch__user_pred_reg_mask(void);
> >>>>>>>> uint64_t arch__intr_simd_reg_bitmap_qwords(int reg, u16 *qwords)=
;
> >>>>>>>> uint64_t arch__user_simd_reg_bitmap_qwords(int reg, u16 *qwords)=
;
> >>>>>>>> uint64_t arch__intr_pred_reg_bitmap_qwords(int reg, u16 *qwords)=
;
> >>>>>>>> uint64_t arch__user_pred_reg_bitmap_qwords(int reg, u16 *qwords)=
;
> >>>>>>>>
> >>>>>>>> The arch__{intr|user}_simd_reg_mask() functions retrieve the bit=
map of
> >>>>>>>> supported SIMD registers, such as XMM/YMM/ZMM on x86 platforms.
> >>>>>>>>
> >>>>>>>> The arch__{intr|user}_pred_reg_mask() functions retrieve the bit=
map of
> >>>>>>>> supported PRED registers, such as OPMASK on x86 platforms.
> >>>>>>>>
> >>>>>>>> The arch__{intr|user}_simd_reg_bitmap_qwords() functions provide=
 the
> >>>>>>>> exact bitmap and number of qwords for a specific type of SIMD re=
gister.
> >>>>>>>> For example, for XMM registers on x86 platforms, the returned bi=
tmap is
> >>>>>>>> 0xffff (XMM0 ~ XMM15) and the qwords number is 2 (128 bits for e=
ach XMM).
> >>>>>>>>
> >>>>>>>> The arch__{intr|user}_pred_reg_bitmap_qwords() functions provide=
 the
> >>>>>>>> exact bitmap and number of qwords for a specific type of PRED re=
gister.
> >>>>>>>> For example, for OPMASK registers on x86 platforms, the returned=
 bitmap
> >>>>>>>> is 0xff (OPMASK0 ~ OPMASK7) and the qwords number is 1 (64 bits =
for each
> >>>>>>>> OPMASK).
> >>>>>>>>
> >>>>>>>> Additionally, the function __parse_regs() is enhanced to support=
 parsing
> >>>>>>>> these newly introduced SIMD registers. Currently, each type of r=
egister
> >>>>>>>> can only be sampled collectively; sampling a specific SIMD regis=
ter is
> >>>>>>>> not supported. For example, all XMM registers are sampled togeth=
er rather
> >>>>>>>> than sampling only XMM0.
> >>>>>>>>
> >>>>>>>> When multiple overlapping register types, such as XMM and YMM, a=
re
> >>>>>>>> sampled simultaneously, only the superset (YMM registers) is sam=
pled.
> >>>>>>>>
> >>>>>>>> With this patch, all supported sampling registers on x86 platfor=
ms are
> >>>>>>>> displayed as follows.
> >>>>>>>>
> >>>>>>>>  $perf record -I?
> >>>>>>>>  available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 =
R9 R10
> >>>>>>>>  R11 R12 R13 R14 R15 R16 R17 R18 R19 R20 R21 R22 R23 R24 R25 R26=
 R27 R28
> >>>>>>>>  R29 R30 R31 SSP XMM0-15 YMM0-15 ZMM0-31 OPMASK0-7
> >>>>>>>>
> >>>>>>>>  $perf record --user-regs=3D?
> >>>>>>>>  available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 =
R9 R10
> >>>>>>>>  R11 R12 R13 R14 R15 R16 R17 R18 R19 R20 R21 R22 R23 R24 R25 R26=
 R27 R28
> >>>>>>>>  R29 R30 R31 SSP XMM0-15 YMM0-15 ZMM0-31 OPMASK0-7
> >>>>>>>>
> >>>>>>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >>>>>>>> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >>>>>>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >>>>>>>> ---
> >>>>>>>>  tools/perf/arch/x86/util/perf_regs.c      | 470 +++++++++++++++=
++++++-
> >>>>>>>>  tools/perf/util/evsel.c                   |  27 ++
> >>>>>>>>  tools/perf/util/parse-regs-options.c      | 151 ++++++-
> >>>>>>>>  tools/perf/util/perf_event_attr_fprintf.c |   6 +
> >>>>>>>>  tools/perf/util/perf_regs.c               |  59 +++
> >>>>>>>>  tools/perf/util/perf_regs.h               |  11 +
> >>>>>>>>  tools/perf/util/record.h                  |   6 +
> >>>>>>>>  7 files changed, 714 insertions(+), 16 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/a=
rch/x86/util/perf_regs.c
> >>>>>>>> index 12fd93f04802..db41430f3b07 100644
> >>>>>>>> --- a/tools/perf/arch/x86/util/perf_regs.c
> >>>>>>>> +++ b/tools/perf/arch/x86/util/perf_regs.c
> >>>>>>>> @@ -13,6 +13,49 @@
> >>>>>>>>  #include "../../../util/pmu.h"
> >>>>>>>>  #include "../../../util/pmus.h"
> >>>>>>>>
> >>>>>>>> +static const struct sample_reg sample_reg_masks_ext[] =3D {
> >>>>>>>> +       SMPL_REG(AX, PERF_REG_X86_AX),
> >>>>>>>> +       SMPL_REG(BX, PERF_REG_X86_BX),
> >>>>>>>> +       SMPL_REG(CX, PERF_REG_X86_CX),
> >>>>>>>> +       SMPL_REG(DX, PERF_REG_X86_DX),
> >>>>>>>> +       SMPL_REG(SI, PERF_REG_X86_SI),
> >>>>>>>> +       SMPL_REG(DI, PERF_REG_X86_DI),
> >>>>>>>> +       SMPL_REG(BP, PERF_REG_X86_BP),
> >>>>>>>> +       SMPL_REG(SP, PERF_REG_X86_SP),
> >>>>>>>> +       SMPL_REG(IP, PERF_REG_X86_IP),
> >>>>>>>> +       SMPL_REG(FLAGS, PERF_REG_X86_FLAGS),
> >>>>>>>> +       SMPL_REG(CS, PERF_REG_X86_CS),
> >>>>>>>> +       SMPL_REG(SS, PERF_REG_X86_SS),
> >>>>>>>> +#ifdef HAVE_ARCH_X86_64_SUPPORT
> >>>>>>>> +       SMPL_REG(R8, PERF_REG_X86_R8),
> >>>>>>>> +       SMPL_REG(R9, PERF_REG_X86_R9),
> >>>>>>>> +       SMPL_REG(R10, PERF_REG_X86_R10),
> >>>>>>>> +       SMPL_REG(R11, PERF_REG_X86_R11),
> >>>>>>>> +       SMPL_REG(R12, PERF_REG_X86_R12),
> >>>>>>>> +       SMPL_REG(R13, PERF_REG_X86_R13),
> >>>>>>>> +       SMPL_REG(R14, PERF_REG_X86_R14),
> >>>>>>>> +       SMPL_REG(R15, PERF_REG_X86_R15),
> >>>>>>>> +       SMPL_REG(R16, PERF_REG_X86_R16),
> >>>>>>>> +       SMPL_REG(R17, PERF_REG_X86_R17),
> >>>>>>>> +       SMPL_REG(R18, PERF_REG_X86_R18),
> >>>>>>>> +       SMPL_REG(R19, PERF_REG_X86_R19),
> >>>>>>>> +       SMPL_REG(R20, PERF_REG_X86_R20),
> >>>>>>>> +       SMPL_REG(R21, PERF_REG_X86_R21),
> >>>>>>>> +       SMPL_REG(R22, PERF_REG_X86_R22),
> >>>>>>>> +       SMPL_REG(R23, PERF_REG_X86_R23),
> >>>>>>>> +       SMPL_REG(R24, PERF_REG_X86_R24),
> >>>>>>>> +       SMPL_REG(R25, PERF_REG_X86_R25),
> >>>>>>>> +       SMPL_REG(R26, PERF_REG_X86_R26),
> >>>>>>>> +       SMPL_REG(R27, PERF_REG_X86_R27),
> >>>>>>>> +       SMPL_REG(R28, PERF_REG_X86_R28),
> >>>>>>>> +       SMPL_REG(R29, PERF_REG_X86_R29),
> >>>>>>>> +       SMPL_REG(R30, PERF_REG_X86_R30),
> >>>>>>>> +       SMPL_REG(R31, PERF_REG_X86_R31),
> >>>>>>>> +       SMPL_REG(SSP, PERF_REG_X86_SSP),
> >>>>>>>> +#endif
> >>>>>>>> +       SMPL_REG_END
> >>>>>>>> +};
> >>>>>>>> +
> >>>>>>>>  static const struct sample_reg sample_reg_masks[] =3D {
> >>>>>>>>         SMPL_REG(AX, PERF_REG_X86_AX),
> >>>>>>>>         SMPL_REG(BX, PERF_REG_X86_BX),
> >>>>>>>> @@ -276,27 +319,404 @@ int arch_sdt_arg_parse_op(char *old_op, c=
har **new_op)
> >>>>>>>>         return SDT_ARG_VALID;
> >>>>>>>>  }
> >>>>>>>>
> >>>>>>>> +static bool support_simd_reg(u64 sample_type, u16 qwords, u64 m=
ask, bool pred)
> >>>>>>> To make the code easier to read, it'd be nice to document sample_=
type,
> >>>>>>> qwords and mask here.
> >>>>>> Sure.
> >>>>>>
> >>>>>>
> >>>>>>>> +{
> >>>>>>>> +       struct perf_event_attr attr =3D {
> >>>>>>>> +               .type                           =3D PERF_TYPE_HA=
RDWARE,
> >>>>>>>> +               .config                         =3D PERF_COUNT_H=
W_CPU_CYCLES,
> >>>>>>>> +               .sample_type                    =3D sample_type,
> >>>>>>>> +               .disabled                       =3D 1,
> >>>>>>>> +               .exclude_kernel                 =3D 1,
> >>>>>>>> +               .sample_simd_regs_enabled       =3D 1,
> >>>>>>>> +       };
> >>>>>>>> +       int fd;
> >>>>>>>> +
> >>>>>>>> +       attr.sample_period =3D 1;
> >>>>>>>> +
> >>>>>>>> +       if (!pred) {
> >>>>>>>> +               attr.sample_simd_vec_reg_qwords =3D qwords;
> >>>>>>>> +               if (sample_type =3D=3D PERF_SAMPLE_REGS_INTR)
> >>>>>>>> +                       attr.sample_simd_vec_reg_intr =3D mask;
> >>>>>>>> +               else
> >>>>>>>> +                       attr.sample_simd_vec_reg_user =3D mask;
> >>>>>>>> +       } else {
> >>>>>>>> +               attr.sample_simd_pred_reg_qwords =3D PERF_X86_OP=
MASK_QWORDS;
> >>>>>>>> +               if (sample_type =3D=3D PERF_SAMPLE_REGS_INTR)
> >>>>>>>> +                       attr.sample_simd_pred_reg_intr =3D PERF_=
X86_SIMD_PRED_MASK;
> >>>>>>>> +               else
> >>>>>>>> +                       attr.sample_simd_pred_reg_user =3D PERF_=
X86_SIMD_PRED_MASK;
> >>>>>>>> +       }
> >>>>>>>> +
> >>>>>>>> +       if (perf_pmus__num_core_pmus() > 1) {
> >>>>>>>> +               struct perf_pmu *pmu =3D NULL;
> >>>>>>>> +               __u64 type =3D PERF_TYPE_RAW;
> >>>>>>> It should be okay to do:
> >>>>>>> __u64 type =3D perf_pmus__find_core_pmu()->type
> >>>>>>> rather than have the whole loop below.
> >>>>>> Sure. Thanks.
> >>>>>>
> >>>>>>
> >>>>>>>> +
> >>>>>>>> +               /*
> >>>>>>>> +                * The same register set is supported among diff=
erent hybrid PMUs.
> >>>>>>>> +                * Only check the first available one.
> >>>>>>>> +                */
> >>>>>>>> +               while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D =
NULL) {
> >>>>>>>> +                       type =3D pmu->type;
> >>>>>>>> +                       break;
> >>>>>>>> +               }
> >>>>>>>> +               attr.config |=3D type << PERF_PMU_TYPE_SHIFT;
> >>>>>>>> +       }
> >>>>>>>> +
> >>>>>>>> +       event_attr_init(&attr);
> >>>>>>>> +
> >>>>>>>> +       fd =3D sys_perf_event_open(&attr, 0, -1, -1, 0);
> >>>>>>>> +       if (fd !=3D -1) {
> >>>>>>>> +               close(fd);
> >>>>>>>> +               return true;
> >>>>>>>> +       }
> >>>>>>>> +
> >>>>>>>> +       return false;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static bool __arch_simd_reg_mask(u64 sample_type, int reg, uint=
64_t *mask, u16 *qwords)
> >>>>>>>> +{
> >>>>>>>> +       bool supported =3D false;
> >>>>>>>> +       u64 bits;
> >>>>>>>> +
> >>>>>>>> +       *mask =3D 0;
> >>>>>>>> +       *qwords =3D 0;
> >>>>>>>> +
> >>>>>>>> +       switch (reg) {
> >>>>>>>> +       case PERF_REG_X86_XMM:
> >>>>>>>> +               bits =3D BIT_ULL(PERF_X86_SIMD_XMM_REGS) - 1;
> >>>>>>>> +               supported =3D support_simd_reg(sample_type, PERF=
_X86_XMM_QWORDS, bits, false);
> >>>>>>>> +               if (supported) {
> >>>>>>>> +                       *mask =3D bits;
> >>>>>>>> +                       *qwords =3D PERF_X86_XMM_QWORDS;
> >>>>>>>> +               }
> >>>>>>>> +               break;
> >>>>>>>> +       case PERF_REG_X86_YMM:
> >>>>>>>> +               bits =3D BIT_ULL(PERF_X86_SIMD_YMM_REGS) - 1;
> >>>>>>>> +               supported =3D support_simd_reg(sample_type, PERF=
_X86_YMM_QWORDS, bits, false);
> >>>>>>>> +               if (supported) {
> >>>>>>>> +                       *mask =3D bits;
> >>>>>>>> +                       *qwords =3D PERF_X86_YMM_QWORDS;
> >>>>>>>> +               }
> >>>>>>>> +               break;
> >>>>>>>> +       case PERF_REG_X86_ZMM:
> >>>>>>>> +               bits =3D BIT_ULL(PERF_X86_SIMD_ZMM_REGS) - 1;
> >>>>>>>> +               supported =3D support_simd_reg(sample_type, PERF=
_X86_ZMM_QWORDS, bits, false);
> >>>>>>>> +               if (supported) {
> >>>>>>>> +                       *mask =3D bits;
> >>>>>>>> +                       *qwords =3D PERF_X86_ZMM_QWORDS;
> >>>>>>>> +                       break;
> >>>>>>>> +               }
> >>>>>>>> +
> >>>>>>>> +               bits =3D BIT_ULL(PERF_X86_SIMD_ZMMH_REGS) - 1;
> >>>>>>>> +               supported =3D support_simd_reg(sample_type, PERF=
_X86_ZMM_QWORDS, bits, false);
> >>>>>>>> +               if (supported) {
> >>>>>>>> +                       *mask =3D bits;
> >>>>>>>> +                       *qwords =3D PERF_X86_ZMMH_QWORDS;
> >>>>>>>> +               }
> >>>>>>>> +               break;
> >>>>>>>> +       default:
> >>>>>>>> +               break;
> >>>>>>>> +       }
> >>>>>>>> +
> >>>>>>>> +       return supported;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static bool __arch_pred_reg_mask(u64 sample_type, int reg, uint=
64_t *mask, u16 *qwords)
> >>>>>>>> +{
> >>>>>>>> +       bool supported =3D false;
> >>>>>>>> +       u64 bits;
> >>>>>>>> +
> >>>>>>>> +       *mask =3D 0;
> >>>>>>>> +       *qwords =3D 0;
> >>>>>>>> +
> >>>>>>>> +       switch (reg) {
> >>>>>>>> +       case PERF_REG_X86_OPMASK:
> >>>>>>>> +               bits =3D BIT_ULL(PERF_X86_SIMD_OPMASK_REGS) - 1;
> >>>>>>>> +               supported =3D support_simd_reg(sample_type, PERF=
_X86_OPMASK_QWORDS, bits, true);
> >>>>>>>> +               if (supported) {
> >>>>>>>> +                       *mask =3D bits;
> >>>>>>>> +                       *qwords =3D PERF_X86_OPMASK_QWORDS;
> >>>>>>>> +               }
> >>>>>>>> +               break;
> >>>>>>>> +       default:
> >>>>>>>> +               break;
> >>>>>>>> +       }
> >>>>>>>> +
> >>>>>>>> +       return supported;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static bool has_cap_simd_regs(void)
> >>>>>>>> +{
> >>>>>>>> +       uint64_t mask =3D BIT_ULL(PERF_X86_SIMD_XMM_REGS) - 1;
> >>>>>>>> +       u16 qwords =3D PERF_X86_XMM_QWORDS;
> >>>>>>>> +       static bool has_cap_simd_regs;
> >>>>>>>> +       static bool cached;
> >>>>>>>> +
> >>>>>>>> +       if (cached)
> >>>>>>>> +               return has_cap_simd_regs;
> >>>>>>>> +
> >>>>>>>> +       has_cap_simd_regs =3D __arch_simd_reg_mask(PERF_SAMPLE_R=
EGS_INTR,
> >>>>>>>> +                                                PERF_REG_X86_XM=
M, &mask, &qwords);
> >>>>>>>> +       has_cap_simd_regs |=3D __arch_simd_reg_mask(PERF_SAMPLE_=
REGS_USER,
> >>>>>>>> +                                                PERF_REG_X86_XM=
M, &mask, &qwords);
> >>>>>>>> +       cached =3D true;
> >>>>>>>> +
> >>>>>>>> +       return has_cap_simd_regs;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +bool arch_has_simd_regs(u64 mask)
> >>>>>>>> +{
> >>>>>>>> +       return has_cap_simd_regs() &&
> >>>>>>>> +              mask & GENMASK_ULL(PERF_REG_X86_SSP, PERF_REG_X86=
_R16);
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static const struct sample_reg sample_simd_reg_masks[] =3D {
> >>>>>>>> +       SMPL_REG(XMM, PERF_REG_X86_XMM),
> >>>>>>>> +       SMPL_REG(YMM, PERF_REG_X86_YMM),
> >>>>>>>> +       SMPL_REG(ZMM, PERF_REG_X86_ZMM),
> >>>>>>>> +       SMPL_REG_END
> >>>>>>>> +};
> >>>>>>>> +
> >>>>>>>> +static const struct sample_reg sample_pred_reg_masks[] =3D {
> >>>>>>>> +       SMPL_REG(OPMASK, PERF_REG_X86_OPMASK),
> >>>>>>>> +       SMPL_REG_END
> >>>>>>>> +};
> >>>>>>>> +
> >>>>>>>> +const struct sample_reg *arch__sample_simd_reg_masks(void)
> >>>>>>>> +{
> >>>>>>>> +       return sample_simd_reg_masks;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +const struct sample_reg *arch__sample_pred_reg_masks(void)
> >>>>>>>> +{
> >>>>>>>> +       return sample_pred_reg_masks;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static bool x86_intr_simd_updated;
> >>>>>>>> +static u64 x86_intr_simd_reg_mask;
> >>>>>>>> +static u64 x86_intr_simd_mask[PERF_REG_X86_MAX_SIMD_REGS];
> >>>>>>>> +static u16 x86_intr_simd_qwords[PERF_REG_X86_MAX_SIMD_REGS];
> >>>>>>> Could we add some comments? I can kind of figure out the updated =
is a
> >>>>>>> check for lazy initialization and what masks are, qwords is an od=
d
> >>>>>>> one. The comment could also point out that SIMD doesn't mean the
> >>>>>>> machine supports SIMD, but SIMD registers are supported in perf
> >>>>>>> events.
> >>>>>> Sure.
> >>>>>>
> >>>>>>
> >>>>>>>> +static bool x86_user_simd_updated;
> >>>>>>>> +static u64 x86_user_simd_reg_mask;
> >>>>>>>> +static u64 x86_user_simd_mask[PERF_REG_X86_MAX_SIMD_REGS];
> >>>>>>>> +static u16 x86_user_simd_qwords[PERF_REG_X86_MAX_SIMD_REGS];
> >>>>>>>> +
> >>>>>>>> +static bool x86_intr_pred_updated;
> >>>>>>>> +static u64 x86_intr_pred_reg_mask;
> >>>>>>>> +static u64 x86_intr_pred_mask[PERF_REG_X86_MAX_PRED_REGS];
> >>>>>>>> +static u16 x86_intr_pred_qwords[PERF_REG_X86_MAX_PRED_REGS];
> >>>>>>>> +static bool x86_user_pred_updated;
> >>>>>>>> +static u64 x86_user_pred_reg_mask;
> >>>>>>>> +static u64 x86_user_pred_mask[PERF_REG_X86_MAX_PRED_REGS];
> >>>>>>>> +static u16 x86_user_pred_qwords[PERF_REG_X86_MAX_PRED_REGS];
> >>>>>>>> +
> >>>>>>>> +static uint64_t __arch__simd_reg_mask(u64 sample_type)
> >>>>>>>> +{
> >>>>>>>> +       const struct sample_reg *r =3D NULL;
> >>>>>>>> +       bool supported;
> >>>>>>>> +       u64 mask =3D 0;
> >>>>>>>> +       int reg;
> >>>>>>>> +
> >>>>>>>> +       if (!has_cap_simd_regs())
> >>>>>>>> +               return 0;
> >>>>>>>> +
> >>>>>>>> +       if (sample_type =3D=3D PERF_SAMPLE_REGS_INTR && x86_intr=
_simd_updated)
> >>>>>>>> +               return x86_intr_simd_reg_mask;
> >>>>>>>> +
> >>>>>>>> +       if (sample_type =3D=3D PERF_SAMPLE_REGS_USER && x86_user=
_simd_updated)
> >>>>>>>> +               return x86_user_simd_reg_mask;
> >>>>>>>> +
> >>>>>>>> +       for (r =3D arch__sample_simd_reg_masks(); r->name; r++) =
{
> >>>>>>>> +               supported =3D false;
> >>>>>>>> +
> >>>>>>>> +               if (!r->mask)
> >>>>>>>> +                       continue;
> >>>>>>>> +               reg =3D fls64(r->mask) - 1;
> >>>>>>>> +
> >>>>>>>> +               if (reg >=3D PERF_REG_X86_MAX_SIMD_REGS)
> >>>>>>>> +                       break;
> >>>>>>>> +               if (sample_type =3D=3D PERF_SAMPLE_REGS_INTR)
> >>>>>>>> +                       supported =3D __arch_simd_reg_mask(sampl=
e_type, reg,
> >>>>>>>> +                                                        &x86_in=
tr_simd_mask[reg],
> >>>>>>>> +                                                        &x86_in=
tr_simd_qwords[reg]);
> >>>>>>>> +               else if (sample_type =3D=3D PERF_SAMPLE_REGS_USE=
R)
> >>>>>>>> +                       supported =3D __arch_simd_reg_mask(sampl=
e_type, reg,
> >>>>>>>> +                                                        &x86_us=
er_simd_mask[reg],
> >>>>>>>> +                                                        &x86_us=
er_simd_qwords[reg]);
> >>>>>>>> +               if (supported)
> >>>>>>>> +                       mask |=3D BIT_ULL(reg);
> >>>>>>>> +       }
> >>>>>>>> +
> >>>>>>>> +       if (sample_type =3D=3D PERF_SAMPLE_REGS_INTR) {
> >>>>>>>> +               x86_intr_simd_reg_mask =3D mask;
> >>>>>>>> +               x86_intr_simd_updated =3D true;
> >>>>>>>> +       } else {
> >>>>>>>> +               x86_user_simd_reg_mask =3D mask;
> >>>>>>>> +               x86_user_simd_updated =3D true;
> >>>>>>>> +       }
> >>>>>>>> +
> >>>>>>>> +       return mask;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static uint64_t __arch__pred_reg_mask(u64 sample_type)
> >>>>>>>> +{
> >>>>>>>> +       const struct sample_reg *r =3D NULL;
> >>>>>>>> +       bool supported;
> >>>>>>>> +       u64 mask =3D 0;
> >>>>>>>> +       int reg;
> >>>>>>>> +
> >>>>>>>> +       if (!has_cap_simd_regs())
> >>>>>>>> +               return 0;
> >>>>>>>> +
> >>>>>>>> +       if (sample_type =3D=3D PERF_SAMPLE_REGS_INTR && x86_intr=
_pred_updated)
> >>>>>>>> +               return x86_intr_pred_reg_mask;
> >>>>>>>> +
> >>>>>>>> +       if (sample_type =3D=3D PERF_SAMPLE_REGS_USER && x86_user=
_pred_updated)
> >>>>>>>> +               return x86_user_pred_reg_mask;
> >>>>>>>> +
> >>>>>>>> +       for (r =3D arch__sample_pred_reg_masks(); r->name; r++) =
{
> >>>>>>>> +               supported =3D false;
> >>>>>>>> +
> >>>>>>>> +               if (!r->mask)
> >>>>>>>> +                       continue;
> >>>>>>>> +               reg =3D fls64(r->mask) - 1;
> >>>>>>>> +
> >>>>>>>> +               if (reg >=3D PERF_REG_X86_MAX_PRED_REGS)
> >>>>>>>> +                       break;
> >>>>>>>> +               if (sample_type =3D=3D PERF_SAMPLE_REGS_INTR)
> >>>>>>>> +                       supported =3D __arch_pred_reg_mask(sampl=
e_type, reg,
> >>>>>>>> +                                                        &x86_in=
tr_pred_mask[reg],
> >>>>>>>> +                                                        &x86_in=
tr_pred_qwords[reg]);
> >>>>>>>> +               else if (sample_type =3D=3D PERF_SAMPLE_REGS_USE=
R)
> >>>>>>>> +                       supported =3D __arch_pred_reg_mask(sampl=
e_type, reg,
> >>>>>>>> +                                                        &x86_us=
er_pred_mask[reg],
> >>>>>>>> +                                                        &x86_us=
er_pred_qwords[reg]);
> >>>>>>>> +               if (supported)
> >>>>>>>> +                       mask |=3D BIT_ULL(reg);
> >>>>>>>> +       }
> >>>>>>>> +
> >>>>>>>> +       if (sample_type =3D=3D PERF_SAMPLE_REGS_INTR) {
> >>>>>>>> +               x86_intr_pred_reg_mask =3D mask;
> >>>>>>>> +               x86_intr_pred_updated =3D true;
> >>>>>>>> +       } else {
> >>>>>>>> +               x86_user_pred_reg_mask =3D mask;
> >>>>>>>> +               x86_user_pred_updated =3D true;
> >>>>>>>> +       }
> >>>>>>>> +
> >>>>>>>> +       return mask;
> >>>>>>>> +}
> >>>>>>> This feels repetitive with __arch__simd_reg_mask, could they be
> >>>>>>> refactored together?
> >>>>>> hmm, it looks we can extract the for loop as a common function. Th=
e other
> >>>>>> parts are hard to be generalized since they are manipulating diffe=
rent
> >>>>>> variables. If we want to generalize them, we have to introduce lot=
s of "if
> >>>>>> ... else" branches and that would make code hard to be read.
> >>>>>>
> >>>>>>
> >>>>>>>> +
> >>>>>>>> +uint64_t arch__intr_simd_reg_mask(void)
> >>>>>>>> +{
> >>>>>>>> +       return __arch__simd_reg_mask(PERF_SAMPLE_REGS_INTR);
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +uint64_t arch__user_simd_reg_mask(void)
> >>>>>>>> +{
> >>>>>>>> +       return __arch__simd_reg_mask(PERF_SAMPLE_REGS_USER);
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +uint64_t arch__intr_pred_reg_mask(void)
> >>>>>>>> +{
> >>>>>>>> +       return __arch__pred_reg_mask(PERF_SAMPLE_REGS_INTR);
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +uint64_t arch__user_pred_reg_mask(void)
> >>>>>>>> +{
> >>>>>>>> +       return __arch__pred_reg_mask(PERF_SAMPLE_REGS_USER);
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static uint64_t arch__simd_reg_bitmap_qwords(int reg, u16 *qwor=
ds, bool intr)
> >>>>>>>> +{
> >>>>>>>> +       uint64_t mask =3D 0;
> >>>>>>>> +
> >>>>>>>> +       *qwords =3D 0;
> >>>>>>>> +       if (reg < PERF_REG_X86_MAX_SIMD_REGS) {
> >>>>>>>> +               if (intr) {
> >>>>>>>> +                       *qwords =3D x86_intr_simd_qwords[reg];
> >>>>>>>> +                       mask =3D x86_intr_simd_mask[reg];
> >>>>>>>> +               } else {
> >>>>>>>> +                       *qwords =3D x86_user_simd_qwords[reg];
> >>>>>>>> +                       mask =3D x86_user_simd_mask[reg];
> >>>>>>>> +               }
> >>>>>>>> +       }
> >>>>>>>> +
> >>>>>>>> +       return mask;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static uint64_t arch__pred_reg_bitmap_qwords(int reg, u16 *qwor=
ds, bool intr)
> >>>>>>>> +{
> >>>>>>>> +       uint64_t mask =3D 0;
> >>>>>>>> +
> >>>>>>>> +       *qwords =3D 0;
> >>>>>>>> +       if (reg < PERF_REG_X86_MAX_PRED_REGS) {
> >>>>>>>> +               if (intr) {
> >>>>>>>> +                       *qwords =3D x86_intr_pred_qwords[reg];
> >>>>>>>> +                       mask =3D x86_intr_pred_mask[reg];
> >>>>>>>> +               } else {
> >>>>>>>> +                       *qwords =3D x86_user_pred_qwords[reg];
> >>>>>>>> +                       mask =3D x86_user_pred_mask[reg];
> >>>>>>>> +               }
> >>>>>>>> +       }
> >>>>>>>> +
> >>>>>>>> +       return mask;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +uint64_t arch__intr_simd_reg_bitmap_qwords(int reg, u16 *qwords=
)
> >>>>>>>> +{
> >>>>>>>> +       if (!x86_intr_simd_updated)
> >>>>>>>> +               arch__intr_simd_reg_mask();
> >>>>>>>> +       return arch__simd_reg_bitmap_qwords(reg, qwords, true);
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +uint64_t arch__user_simd_reg_bitmap_qwords(int reg, u16 *qwords=
)
> >>>>>>>> +{
> >>>>>>>> +       if (!x86_user_simd_updated)
> >>>>>>>> +               arch__user_simd_reg_mask();
> >>>>>>>> +       return arch__simd_reg_bitmap_qwords(reg, qwords, false);
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +uint64_t arch__intr_pred_reg_bitmap_qwords(int reg, u16 *qwords=
)
> >>>>>>>> +{
> >>>>>>>> +       if (!x86_intr_pred_updated)
> >>>>>>>> +               arch__intr_pred_reg_mask();
> >>>>>>>> +       return arch__pred_reg_bitmap_qwords(reg, qwords, true);
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +uint64_t arch__user_pred_reg_bitmap_qwords(int reg, u16 *qwords=
)
> >>>>>>>> +{
> >>>>>>>> +       if (!x86_user_pred_updated)
> >>>>>>>> +               arch__user_pred_reg_mask();
> >>>>>>>> +       return arch__pred_reg_bitmap_qwords(reg, qwords, false);
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>>  const struct sample_reg *arch__sample_reg_masks(void)
> >>>>>>>>  {
> >>>>>>>> +       if (has_cap_simd_regs())
> >>>>>>>> +               return sample_reg_masks_ext;
> >>>>>>>>         return sample_reg_masks;
> >>>>>>>>  }
> >>>>>>>>
> >>>>>>>> -uint64_t arch__intr_reg_mask(void)
> >>>>>>>> +static uint64_t __arch__reg_mask(u64 sample_type, u64 mask, boo=
l has_simd_regs)
> >>>>>>>>  {
> >>>>>>>>         struct perf_event_attr attr =3D {
> >>>>>>>> -               .type                   =3D PERF_TYPE_HARDWARE,
> >>>>>>>> -               .config                 =3D PERF_COUNT_HW_CPU_CY=
CLES,
> >>>>>>>> -               .sample_type            =3D PERF_SAMPLE_REGS_INT=
R,
> >>>>>>>> -               .sample_regs_intr       =3D PERF_REG_EXTENDED_MA=
SK,
> >>>>>>>> -               .precise_ip             =3D 1,
> >>>>>>>> -               .disabled               =3D 1,
> >>>>>>>> -               .exclude_kernel         =3D 1,
> >>>>>>>> +               .type                           =3D PERF_TYPE_HA=
RDWARE,
> >>>>>>>> +               .config                         =3D PERF_COUNT_H=
W_CPU_CYCLES,
> >>>>>>>> +               .sample_type                    =3D sample_type,
> >>>>>>>> +               .precise_ip                     =3D 1,
> >>>>>>>> +               .disabled                       =3D 1,
> >>>>>>>> +               .exclude_kernel                 =3D 1,
> >>>>>>>> +               .sample_simd_regs_enabled       =3D has_simd_reg=
s,
> >>>>>>>>         };
> >>>>>>>>         int fd;
> >>>>>>>>         /*
> >>>>>>>>          * In an unnamed union, init it here to build on older g=
cc versions
> >>>>>>>>          */
> >>>>>>>>         attr.sample_period =3D 1;
> >>>>>>>> +       if (sample_type =3D=3D PERF_SAMPLE_REGS_INTR)
> >>>>>>>> +               attr.sample_regs_intr =3D mask;
> >>>>>>>> +       else
> >>>>>>>> +               attr.sample_regs_user =3D mask;
> >>>>>>>>
> >>>>>>>>         if (perf_pmus__num_core_pmus() > 1) {
> >>>>>>>>                 struct perf_pmu *pmu =3D NULL;
> >>>>>>>> @@ -318,13 +738,41 @@ uint64_t arch__intr_reg_mask(void)
> >>>>>>>>         fd =3D sys_perf_event_open(&attr, 0, -1, -1, 0);
> >>>>>>>>         if (fd !=3D -1) {
> >>>>>>>>                 close(fd);
> >>>>>>>> -               return (PERF_REG_EXTENDED_MASK | PERF_REGS_MASK)=
;
> >>>>>>>> +               return mask;
> >>>>>>>>         }
> >>>>>>>>
> >>>>>>>> -       return PERF_REGS_MASK;
> >>>>>>>> +       return 0;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +uint64_t arch__intr_reg_mask(void)
> >>>>>>>> +{
> >>>>>>>> +       uint64_t mask =3D PERF_REGS_MASK;
> >>>>>>>> +
> >>>>>>>> +       if (has_cap_simd_regs()) {
> >>>>>>>> +               mask |=3D __arch__reg_mask(PERF_SAMPLE_REGS_INTR=
,
> >>>>>>>> +                                        GENMASK_ULL(PERF_REG_X8=
6_R31, PERF_REG_X86_R16),
> >>>>>>>> +                                        true);
> >>>>>>> It's nice to label constant arguments like this something like:
> >>>>>>> /*has_simd_regs=3D*/true);
> >>>>>>>
> >>>>>>> Tools like clang-tidy even try to enforce the argument names matc=
h the comments.
> >>>>>> Sure.
> >>>>>>
> >>>>>>
> >>>>>>>> +               mask |=3D __arch__reg_mask(PERF_SAMPLE_REGS_INTR=
,
> >>>>>>>> +                                        BIT_ULL(PERF_REG_X86_SS=
P),
> >>>>>>>> +                                        true);
> >>>>>>>> +       } else
> >>>>>>>> +               mask |=3D __arch__reg_mask(PERF_SAMPLE_REGS_INTR=
, PERF_REG_EXTENDED_MASK, false);
> >>>>>>>> +
> >>>>>>>> +       return mask;
> >>>>>>>>  }
> >>>>>>>>
> >>>>>>>>  uint64_t arch__user_reg_mask(void)
> >>>>>>>>  {
> >>>>>>>> -       return PERF_REGS_MASK;
> >>>>>>>> +       uint64_t mask =3D PERF_REGS_MASK;
> >>>>>>>> +
> >>>>>>>> +       if (has_cap_simd_regs()) {
> >>>>>>>> +               mask |=3D __arch__reg_mask(PERF_SAMPLE_REGS_USER=
,
> >>>>>>>> +                                        GENMASK_ULL(PERF_REG_X8=
6_R31, PERF_REG_X86_R16),
> >>>>>>>> +                                        true);
> >>>>>>>> +               mask |=3D __arch__reg_mask(PERF_SAMPLE_REGS_USER=
,
> >>>>>>>> +                                        BIT_ULL(PERF_REG_X86_SS=
P),
> >>>>>>>> +                                        true);
> >>>>>>>> +       }
> >>>>>>>> +
> >>>>>>>> +       return mask;
> >>>>>>> The code is repetitive here, could we refactor into a single func=
tion
> >>>>>>> passing in a user or instr value?
> >>>>>> Sure. Would extract the common part.
> >>>>>>
> >>>>>>
> >>>>>>>>  }
> >>>>>>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >>>>>>>> index 56ebefd075f2..5d1d90cf9488 100644
> >>>>>>>> --- a/tools/perf/util/evsel.c
> >>>>>>>> +++ b/tools/perf/util/evsel.c
> >>>>>>>> @@ -1461,12 +1461,39 @@ void evsel__config(struct evsel *evsel, =
struct record_opts *opts,
> >>>>>>>>         if (opts->sample_intr_regs && !evsel->no_aux_samples &&
> >>>>>>>>             !evsel__is_dummy_event(evsel)) {
> >>>>>>>>                 attr->sample_regs_intr =3D opts->sample_intr_reg=
s;
> >>>>>>>> +               attr->sample_simd_regs_enabled =3D arch_has_simd=
_regs(attr->sample_regs_intr);
> >>>>>>>> +               evsel__set_sample_bit(evsel, REGS_INTR);
> >>>>>>>> +       }
> >>>>>>>> +
> >>>>>>>> +       if ((opts->sample_intr_vec_regs || opts->sample_intr_pre=
d_regs) &&
> >>>>>>>> +           !evsel->no_aux_samples && !evsel__is_dummy_event(evs=
el)) {
> >>>>>>>> +               /* The pred qwords is to implies the set of SIMD=
 registers is used */
> >>>>>>>> +               if (opts->sample_pred_regs_qwords)
> >>>>>>>> +                       attr->sample_simd_pred_reg_qwords =3D op=
ts->sample_pred_regs_qwords;
> >>>>>>>> +               else
> >>>>>>>> +                       attr->sample_simd_pred_reg_qwords =3D 1;
> >>>>>>>> +               attr->sample_simd_vec_reg_intr =3D opts->sample_=
intr_vec_regs;
> >>>>>>>> +               attr->sample_simd_vec_reg_qwords =3D opts->sampl=
e_vec_regs_qwords;
> >>>>>>>> +               attr->sample_simd_pred_reg_intr =3D opts->sample=
_intr_pred_regs;
> >>>>>>>>                 evsel__set_sample_bit(evsel, REGS_INTR);
> >>>>>>>>         }
> >>>>>>>>
> >>>>>>>>         if (opts->sample_user_regs && !evsel->no_aux_samples &&
> >>>>>>>>             !evsel__is_dummy_event(evsel)) {
> >>>>>>>>                 attr->sample_regs_user |=3D opts->sample_user_re=
gs;
> >>>>>>>> +               attr->sample_simd_regs_enabled =3D arch_has_simd=
_regs(attr->sample_regs_user);
> >>>>>>>> +               evsel__set_sample_bit(evsel, REGS_USER);
> >>>>>>>> +       }
> >>>>>>>> +
> >>>>>>>> +       if ((opts->sample_user_vec_regs || opts->sample_user_pre=
d_regs) &&
> >>>>>>>> +           !evsel->no_aux_samples && !evsel__is_dummy_event(evs=
el)) {
> >>>>>>>> +               if (opts->sample_pred_regs_qwords)
> >>>>>>>> +                       attr->sample_simd_pred_reg_qwords =3D op=
ts->sample_pred_regs_qwords;
> >>>>>>>> +               else
> >>>>>>>> +                       attr->sample_simd_pred_reg_qwords =3D 1;
> >>>>>>>> +               attr->sample_simd_vec_reg_user =3D opts->sample_=
user_vec_regs;
> >>>>>>>> +               attr->sample_simd_vec_reg_qwords =3D opts->sampl=
e_vec_regs_qwords;
> >>>>>>>> +               attr->sample_simd_pred_reg_user =3D opts->sample=
_user_pred_regs;
> >>>>>>>>                 evsel__set_sample_bit(evsel, REGS_USER);
> >>>>>>>>         }
> >>>>>>>>
> >>>>>>>> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/u=
til/parse-regs-options.c
> >>>>>>>> index cda1c620968e..0bd100392889 100644
> >>>>>>>> --- a/tools/perf/util/parse-regs-options.c
> >>>>>>>> +++ b/tools/perf/util/parse-regs-options.c
> >>>>>>>> @@ -4,19 +4,139 @@
> >>>>>>>>  #include <stdint.h>
> >>>>>>>>  #include <string.h>
> >>>>>>>>  #include <stdio.h>
> >>>>>>>> +#include <linux/bitops.h>
> >>>>>>>>  #include "util/debug.h"
> >>>>>>>>  #include <subcmd/parse-options.h>
> >>>>>>>>  #include "util/perf_regs.h"
> >>>>>>>>  #include "util/parse-regs-options.h"
> >>>>>>>> +#include "record.h"
> >>>>>>>> +
> >>>>>>>> +static void __print_simd_regs(bool intr, uint64_t simd_mask)
> >>>>>>>> +{
> >>>>>>>> +       const struct sample_reg *r =3D NULL;
> >>>>>>>> +       uint64_t bitmap =3D 0;
> >>>>>>>> +       u16 qwords =3D 0;
> >>>>>>>> +       int reg_idx;
> >>>>>>>> +
> >>>>>>>> +       if (!simd_mask)
> >>>>>>>> +               return;
> >>>>>>>> +
> >>>>>>>> +       for (r =3D arch__sample_simd_reg_masks(); r->name; r++) =
{
> >>>>>>>> +               if (!(r->mask & simd_mask))
> >>>>>>>> +                       continue;
> >>>>>>>> +               reg_idx =3D fls64(r->mask) - 1;
> >>>>>>>> +               if (intr)
> >>>>>>>> +                       bitmap =3D arch__intr_simd_reg_bitmap_qw=
ords(reg_idx, &qwords);
> >>>>>>>> +               else
> >>>>>>>> +                       bitmap =3D arch__user_simd_reg_bitmap_qw=
ords(reg_idx, &qwords);
> >>>>>>>> +               if (bitmap)
> >>>>>>>> +                       fprintf(stderr, "%s0-%d ", r->name, fls6=
4(bitmap) - 1);
> >>>>>>>> +       }
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static void __print_pred_regs(bool intr, uint64_t pred_mask)
> >>>>>>>> +{
> >>>>>>>> +       const struct sample_reg *r =3D NULL;
> >>>>>>>> +       uint64_t bitmap =3D 0;
> >>>>>>>> +       u16 qwords =3D 0;
> >>>>>>>> +       int reg_idx;
> >>>>>>>> +
> >>>>>>>> +       if (!pred_mask)
> >>>>>>>> +               return;
> >>>>>>>> +
> >>>>>>>> +       for (r =3D arch__sample_pred_reg_masks(); r->name; r++) =
{
> >>>>>>>> +               if (!(r->mask & pred_mask))
> >>>>>>>> +                       continue;
> >>>>>>>> +               reg_idx =3D fls64(r->mask) - 1;
> >>>>>>>> +               if (intr)
> >>>>>>>> +                       bitmap =3D arch__intr_pred_reg_bitmap_qw=
ords(reg_idx, &qwords);
> >>>>>>>> +               else
> >>>>>>>> +                       bitmap =3D arch__user_pred_reg_bitmap_qw=
ords(reg_idx, &qwords);
> >>>>>>>> +               if (bitmap)
> >>>>>>>> +                       fprintf(stderr, "%s0-%d ", r->name, fls6=
4(bitmap) - 1);
> >>>>>>>> +       }
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static bool __parse_simd_regs(struct record_opts *opts, char *s=
, bool intr)
> >>>>>>>> +{
> >>>>>>>> +       const struct sample_reg *r =3D NULL;
> >>>>>>>> +       bool matched =3D false;
> >>>>>>>> +       uint64_t bitmap =3D 0;
> >>>>>>>> +       u16 qwords =3D 0;
> >>>>>>>> +       int reg_idx;
> >>>>>>>> +
> >>>>>>>> +       for (r =3D arch__sample_simd_reg_masks(); r->name; r++) =
{
> >>>>>>>> +               if (strcasecmp(s, r->name))
> >>>>>>>> +                       continue;
> >>>>>>>> +               if (!fls64(r->mask))
> >>>>>>>> +                       continue;
> >>>>>>>> +               reg_idx =3D fls64(r->mask) - 1;
> >>>>>>>> +               if (intr)
> >>>>>>>> +                       bitmap =3D arch__intr_simd_reg_bitmap_qw=
ords(reg_idx, &qwords);
> >>>>>>>> +               else
> >>>>>>>> +                       bitmap =3D arch__user_simd_reg_bitmap_qw=
ords(reg_idx, &qwords);
> >>>>>>>> +               matched =3D true;
> >>>>>>>> +               break;
> >>>>>>>> +       }
> >>>>>>>> +
> >>>>>>>> +       /* Just need the highest qwords */
> >>>>>>> I'm not following here. Does the bitmap need to handle gaps?
> >>>>>> Currently no. In theory, the kernel supports user space only sampl=
es a
> >>>>>> subset of SIMD registers, e.g., 0xff or 0xf0f for XMM registers (H=
W
> >>>>>> supports 16 XMM registers on XMM), but it's not supported to avoid
> >>>>>> introducing too much complexity in perf tools. Moreover, I don't t=
hink end
> >>>>>> users have such requirement. In most cases, users should only know=
 which
> >>>>>> kinds of SIMD registers their programs use but usually doesn't kno=
w and
> >>>>>> care about which exact SIMD register is used.
> >>>>>>
> >>>>>>
> >>>>>>>> +       if (qwords > opts->sample_vec_regs_qwords) {
> >>>>>>>> +               opts->sample_vec_regs_qwords =3D qwords;
> >>>>>>>> +               if (intr)
> >>>>>>>> +                       opts->sample_intr_vec_regs =3D bitmap;
> >>>>>>>> +               else
> >>>>>>>> +                       opts->sample_user_vec_regs =3D bitmap;
> >>>>>>>> +       }
> >>>>>>>> +
> >>>>>>>> +       return matched;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static bool __parse_pred_regs(struct record_opts *opts, char *s=
, bool intr)
> >>>>>>>> +{
> >>>>>>>> +       const struct sample_reg *r =3D NULL;
> >>>>>>>> +       bool matched =3D false;
> >>>>>>>> +       uint64_t bitmap =3D 0;
> >>>>>>>> +       u16 qwords =3D 0;
> >>>>>>>> +       int reg_idx;
> >>>>>>>> +
> >>>>>>>> +       for (r =3D arch__sample_pred_reg_masks(); r->name; r++) =
{
> >>>>>>>> +               if (strcasecmp(s, r->name))
> >>>>>>>> +                       continue;
> >>>>>>>> +               if (!fls64(r->mask))
> >>>>>>>> +                       continue;
> >>>>>>>> +               reg_idx =3D fls64(r->mask) - 1;
> >>>>>>>> +               if (intr)
> >>>>>>>> +                       bitmap =3D arch__intr_pred_reg_bitmap_qw=
ords(reg_idx, &qwords);
> >>>>>>>> +               else
> >>>>>>>> +                       bitmap =3D arch__user_pred_reg_bitmap_qw=
ords(reg_idx, &qwords);
> >>>>>>>> +               matched =3D true;
> >>>>>>>> +               break;
> >>>>>>>> +       }
> >>>>>>>> +
> >>>>>>>> +       /* Just need the highest qwords */
> >>>>>>> Again repetitive, could we have a single function?
> >>>>>> Yes, I suppose the for loop at least can be extracted as a common =
function.
> >>>>>>
> >>>>>>
> >>>>>>>> +       if (qwords > opts->sample_pred_regs_qwords) {
> >>>>>>>> +               opts->sample_pred_regs_qwords =3D qwords;
> >>>>>>>> +               if (intr)
> >>>>>>>> +                       opts->sample_intr_pred_regs =3D bitmap;
> >>>>>>>> +               else
> >>>>>>>> +                       opts->sample_user_pred_regs =3D bitmap;
> >>>>>>>> +       }
> >>>>>>>> +
> >>>>>>>> +       return matched;
> >>>>>>>> +}
> >>>>>>>>
> >>>>>>>>  static int
> >>>>>>>>  __parse_regs(const struct option *opt, const char *str, int uns=
et, bool intr)
> >>>>>>>>  {
> >>>>>>>>         uint64_t *mode =3D (uint64_t *)opt->value;
> >>>>>>>>         const struct sample_reg *r =3D NULL;
> >>>>>>>> +       struct record_opts *opts;
> >>>>>>>>         char *s, *os =3D NULL, *p;
> >>>>>>>> -       int ret =3D -1;
> >>>>>>>> +       bool has_simd_regs =3D false;
> >>>>>>>>         uint64_t mask;
> >>>>>>>> +       uint64_t simd_mask;
> >>>>>>>> +       uint64_t pred_mask;
> >>>>>>>> +       int ret =3D -1;
> >>>>>>>>
> >>>>>>>>         if (unset)
> >>>>>>>>                 return 0;
> >>>>>>>> @@ -27,10 +147,17 @@ __parse_regs(const struct option *opt, cons=
t char *str, int unset, bool intr)
> >>>>>>>>         if (*mode)
> >>>>>>>>                 return -1;
> >>>>>>>>
> >>>>>>>> -       if (intr)
> >>>>>>>> +       if (intr) {
> >>>>>>>> +               opts =3D container_of(opt->value, struct record_=
opts, sample_intr_regs);
> >>>>>>>>                 mask =3D arch__intr_reg_mask();
> >>>>>>>> -       else
> >>>>>>>> +               simd_mask =3D arch__intr_simd_reg_mask();
> >>>>>>>> +               pred_mask =3D arch__intr_pred_reg_mask();
> >>>>>>>> +       } else {
> >>>>>>>> +               opts =3D container_of(opt->value, struct record_=
opts, sample_user_regs);
> >>>>>>>>                 mask =3D arch__user_reg_mask();
> >>>>>>>> +               simd_mask =3D arch__user_simd_reg_mask();
> >>>>>>>> +               pred_mask =3D arch__user_pred_reg_mask();
> >>>>>>>> +       }
> >>>>>>>>
> >>>>>>>>         /* str may be NULL in case no arg is passed to -I */
> >>>>>>>>         if (str) {
> >>>>>>>> @@ -50,10 +177,24 @@ __parse_regs(const struct option *opt, cons=
t char *str, int unset, bool intr)
> >>>>>>>>                                         if (r->mask & mask)
> >>>>>>>>                                                 fprintf(stderr, =
"%s ", r->name);
> >>>>>>>>                                 }
> >>>>>>>> +                               __print_simd_regs(intr, simd_mas=
k);
> >>>>>>>> +                               __print_pred_regs(intr, pred_mas=
k);
> >>>>>>>>                                 fputc('\n', stderr);
> >>>>>>>>                                 /* just printing available regs =
*/
> >>>>>>>>                                 goto error;
> >>>>>>>>                         }
> >>>>>>>> +
> >>>>>>>> +                       if (simd_mask) {
> >>>>>>>> +                               has_simd_regs =3D __parse_simd_r=
egs(opts, s, intr);
> >>>>>>>> +                               if (has_simd_regs)
> >>>>>>>> +                                       goto next;
> >>>>>>>> +                       }
> >>>>>>>> +                       if (pred_mask) {
> >>>>>>>> +                               has_simd_regs =3D __parse_pred_r=
egs(opts, s, intr);
> >>>>>>>> +                               if (has_simd_regs)
> >>>>>>>> +                                       goto next;
> >>>>>>>> +                       }
> >>>>>>>> +
> >>>>>>>>                         for (r =3D arch__sample_reg_masks(); r->=
name; r++) {
> >>>>>>>>                                 if ((r->mask & mask) && !strcase=
cmp(s, r->name))
> >>>>>>>>                                         break;
> >>>>>>>> @@ -65,7 +206,7 @@ __parse_regs(const struct option *opt, const =
char *str, int unset, bool intr)
> >>>>>>>>                         }
> >>>>>>>>
> >>>>>>>>                         *mode |=3D r->mask;
> >>>>>>>> -
> >>>>>>>> +next:
> >>>>>>>>                         if (!p)
> >>>>>>>>                                 break;
> >>>>>>>>
> >>>>>>>> @@ -75,7 +216,7 @@ __parse_regs(const struct option *opt, const =
char *str, int unset, bool intr)
> >>>>>>>>         ret =3D 0;
> >>>>>>>>
> >>>>>>>>         /* default to all possible regs */
> >>>>>>>> -       if (*mode =3D=3D 0)
> >>>>>>>> +       if (*mode =3D=3D 0 && !has_simd_regs)
> >>>>>>>>                 *mode =3D mask;
> >>>>>>>>  error:
> >>>>>>>>         free(os);
> >>>>>>>> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/p=
erf/util/perf_event_attr_fprintf.c
> >>>>>>>> index 66b666d9ce64..fb0366d050cf 100644
> >>>>>>>> --- a/tools/perf/util/perf_event_attr_fprintf.c
> >>>>>>>> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> >>>>>>>> @@ -360,6 +360,12 @@ int perf_event_attr__fprintf(FILE *fp, stru=
ct perf_event_attr *attr,
> >>>>>>>>         PRINT_ATTRf(aux_start_paused, p_unsigned);
> >>>>>>>>         PRINT_ATTRf(aux_pause, p_unsigned);
> >>>>>>>>         PRINT_ATTRf(aux_resume, p_unsigned);
> >>>>>>>> +       PRINT_ATTRf(sample_simd_pred_reg_qwords, p_unsigned);
> >>>>>>>> +       PRINT_ATTRf(sample_simd_pred_reg_intr, p_hex);
> >>>>>>>> +       PRINT_ATTRf(sample_simd_pred_reg_user, p_hex);
> >>>>>>>> +       PRINT_ATTRf(sample_simd_vec_reg_qwords, p_unsigned);
> >>>>>>>> +       PRINT_ATTRf(sample_simd_vec_reg_intr, p_hex);
> >>>>>>>> +       PRINT_ATTRf(sample_simd_vec_reg_user, p_hex);
> >>>>>>>>
> >>>>>>>>         return ret;
> >>>>>>>>  }
> >>>>>>>> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_=
regs.c
> >>>>>>>> index 44b90bbf2d07..e8a9fabc92e6 100644
> >>>>>>>> --- a/tools/perf/util/perf_regs.c
> >>>>>>>> +++ b/tools/perf/util/perf_regs.c
> >>>>>>>> @@ -11,6 +11,11 @@ int __weak arch_sdt_arg_parse_op(char *old_op=
 __maybe_unused,
> >>>>>>>>         return SDT_ARG_SKIP;
> >>>>>>>>  }
> >>>>>>>>
> >>>>>>>> +bool __weak arch_has_simd_regs(u64 mask __maybe_unused)
> >>>>>>>> +{
> >>>>>>>> +       return false;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>>  uint64_t __weak arch__intr_reg_mask(void)
> >>>>>>>>  {
> >>>>>>>>         return 0;
> >>>>>>>> @@ -21,6 +26,50 @@ uint64_t __weak arch__user_reg_mask(void)
> >>>>>>>>         return 0;
> >>>>>>>>  }
> >>>>>>>>
> >>>>>>>> +uint64_t __weak arch__intr_simd_reg_mask(void)
> >>>>>>>> +{
> >>>>>>>> +       return 0;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +uint64_t __weak arch__user_simd_reg_mask(void)
> >>>>>>>> +{
> >>>>>>>> +       return 0;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +uint64_t __weak arch__intr_pred_reg_mask(void)
> >>>>>>>> +{
> >>>>>>>> +       return 0;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +uint64_t __weak arch__user_pred_reg_mask(void)
> >>>>>>>> +{
> >>>>>>>> +       return 0;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +uint64_t __weak arch__intr_simd_reg_bitmap_qwords(int reg  __ma=
ybe_unused, u16 *qwords)
> >>>>>>>> +{
> >>>>>>>> +       *qwords =3D 0;
> >>>>>>>> +       return 0;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +uint64_t __weak arch__user_simd_reg_bitmap_qwords(int reg __may=
be_unused, u16 *qwords)
> >>>>>>>> +{
> >>>>>>>> +       *qwords =3D 0;
> >>>>>>>> +       return 0;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +uint64_t __weak arch__intr_pred_reg_bitmap_qwords(int reg  __ma=
ybe_unused, u16 *qwords)
> >>>>>>>> +{
> >>>>>>>> +       *qwords =3D 0;
> >>>>>>>> +       return 0;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +uint64_t __weak arch__user_pred_reg_bitmap_qwords(int reg __may=
be_unused, u16 *qwords)
> >>>>>>>> +{
> >>>>>>>> +       *qwords =3D 0;
> >>>>>>>> +       return 0;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>>  static const struct sample_reg sample_reg_masks[] =3D {
> >>>>>>>>         SMPL_REG_END
> >>>>>>>>  };
> >>>>>>>> @@ -30,6 +79,16 @@ const struct sample_reg * __weak arch__sample=
_reg_masks(void)
> >>>>>>>>         return sample_reg_masks;
> >>>>>>>>  }
> >>>>>>>>
> >>>>>>>> +const struct sample_reg * __weak arch__sample_simd_reg_masks(vo=
id)
> >>>>>>>> +{
> >>>>>>>> +       return sample_reg_masks;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +const struct sample_reg * __weak arch__sample_pred_reg_masks(vo=
id)
> >>>>>>>> +{
> >>>>>>>> +       return sample_reg_masks;
> >>>>>>>> +}
> >>>>>>> Thinking out loud. I wonder if there is a way to hide the weak
> >>>>>>> functions. It seems the support is tied to PMUs, particularly cor=
e
> >>>>>>> PMUs, perhaps we can push things into pmu and arch pmu code. Then=
 we
> >>>>>>> ask the PMU to parse the register strings, set up the perf_event_=
attr,
> >>>>>>> etc. I'm somewhat scared these functions will be used on the repo=
rt
> >>>>>>> rather than record side of things, thereby breaking perf.data sup=
port
> >>>>>>> when the host kernel does or doesn't have the SIMD support.
> >>>>>> Ian, I don't quite follow your words.
> >>>>>>
> >>>>>> I don't quite understand how should we do for "push things into pm=
u and
> >>>>>> arch pmu code". Current SIMD registers support follows the same wa=
y of the
> >>>>>> general registers support. If we intend to change the way entirely=
, we'd
> >>>>>> better have an independent patch-set.
> >>>>>>
> >>>>>> why these functions would break the perf.data repport? perf-report=
 would
> >>>>>> check if the PERF_SAMPLE_REGS_ABI_SIMD flag is set for each record=
, only
> >>>>>> the flags is set (indicates there are SIMD registers data appended=
 in the
> >>>>>> record), perf-report would try to parse the SIMD registers data.
> >>>>> Thanks Dapeng, sorry I wasn't clear. So, I've landed clean ups to
> >>>>> remove weak symbols like:
> >>>>> https://lore.kernel.org/lkml/20250724163302.596743-21-irogers@googl=
e.com/#t
> >>>>>
> >>>>> For these patches what I'm imagining is that there is a Nova Lake
> >>>>> generated perf.data file. Using perf report, script, etc. on the No=
va
> >>>>> Lake should expose all of the same mask, qword, etc. values as when
> >>>>> the perf.data was generated and so things will work. If the perf.da=
ta
> >>>>> file was taken to say my Alderlake then what will happen? Generally
> >>>>> using the arch directory and weak symbols is a code smell that cros=
s
> >>>>> platform things are going to break - there should be sufficient dat=
a
> >>>>> in the event and the perf_event_attr to fully decode what's going o=
n.
> >>>>> Sometimes tying things to a PMU name can avoid the use of the arch
> >>>>> directory. We were able to avoid the arch directory to a good exten=
t
> >>>>> for the TPEBS code, even though it is a very modern Intel feature.
> >>>> I see.
> >>>>
> >>>> But the sampling support for SIMD registers is different with the sa=
mple
> >>>> weight processing in the patch
> >>>> https://lore.kernel.org/lkml/20250724163302.596743-21-irogers@google=
.com/#t.
> >>>> Each arch may support different kinds of SIMD registers and furtherm=
ore
> >>>> each kind of SIMD register may have different register number and re=
gister
> >>>> width. It's quite hard to figure out some common functions or fields=
 to
> >>>> represent the name and attributes of these arch-specific SIMD regist=
ers.
> >>>> These arch-specific information can only be told by the arch-specifi=
c code.
> >>>> So it looks the __weak functions are still the easiest way to implem=
ent this.
> >>>>
> >>>> I don't think the perf.data parsing would be broken from a platform =
to
> >>>> another different platform (same arch), e.g., from Nova Lake to Alde=
r Lake.
> >>>> To indicates the presence of SIMD registers in record data, a new AB=
I flag
> >>>> "PERF_SAMPLE_REGS_ABI_SIMD" is introduced. If the perf tool on the 2=
nd
> >>>> platform is new enough and can recognize this new flag, then the SIM=
D
> >>>> registers data would be parsed correctly. Even though the perf tool =
is old
> >>>> and have no support of SIMD register, the data of SIMD registers wou=
ld just
> >>>> be silently ignored and should not break the parsing.
> >>> That's good to know. I'm confused then why these functions can't just
> >>> be within the arch directory? For example, we don't expose the
> >>> intel-pt PMU code in the common code except for the parsing parts. A
> >>> lot of that is handled by the default perf_event_attr initialization
> >>> that every PMU can have its own variant of:
> >>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-n=
ext.git/tree/tools/perf/util/pmu.h?h=3Dperf-tools-next#n123
> >> I see. From my point of view, there seems no essential difference betw=
een a
> >> function pointer and a __weak function, and it looks hard to find a co=
mmon
> >> data structure to save all these function pointers which needs to be c=
alled
> >> in different places, like register name parsing, register data dumplin=
g ...
> >>
> >>
> >>> Perhaps this is all just evidence of tech debt in the perf_regs.c cod=
e
> >>> :-/ The bit that's relevant to the patch here is that I think this is
> >>> adding to the tech debt problem as 11 more functions are added to
> >>> perf_regs.h.
> >> Yeah, 11 new __weak functions seems too much, we may merge the same ki=
nds
> >> of functions, like merging *_simd_reg_mask() and  *_pred_reg_mask() to=
 a
> >> single function with an type argument, then the new added __weak funct=
ions
> >> could shrink half.
> > There could be a good reason for 11 weak functions :-) In the
> > perf_event.h you've added to the sample event:
> > ```
> > +        *        u64                   regs[weight(mask)];
> > +        *        struct {
> > +        *              u16 nr_vectors;
> > +        *              u16 vector_qwords;
> > +        *              u16 nr_pred;
> > +        *              u16 pred_qwords;
> > +        *              u64 data[nr_vectors * vector_qwords + nr_pred
> > * pred_qwords];
> > +        *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
> > +        *      } && PERF_SAMPLE_REGS_USER
> > ```
> > so these things are readable/writable outside of builds with arch/x86
> > compiled in, which is why it seems odd that there needs to be arch
> > code in the common code to handle them. Similar to how I needed to get
> > the retirement latency parsing out of the arch/x86 directory as
> > potentially you could be looking at a perf.data file with retirement
> > latencies in it on a non-x86 platform.
>
> Ian, I'm not sure if I fully get your point. If not, please correct.
>
> Although these new introduced fields are generic and existed on all
> architectures, it's not enough to get all the necessary information to du=
mp
> or parse the SIMD registers, e.g., the SIMD register name.
>
> Let's take dumpling the sampled value of SIMD registers as an example.

> We know there could be different kinds of SIMD register on different arch=
s,
> like XMM/YMM/ZMM on x86 and V-registers/Z-registers on ARM.
>
> Currently we only know the register number and width from generic fields,
> we have no way to directly know the exact name this SIMD register
> corresponds. We have to involve the arch-specific function to figure out =
it
> and then print them.
>
> At least for now, it looks we still need these arch-specific functions ..=
.

Thanks Dapeng. I started by thinking out loud, so I'm not saying this
is something to necessarily fix in the patch series but it probably is
something that needs to be fixed.

You mention that different archs have different registers and so we
need different routines for those archs, implying weak symbols, etc.
We do actually have generic register dumping code in get_dwarf_regstr:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/dwarf-regs.c?h=3Dperf-tools-next#n33
It takes the dwarf register number, the ELF Ehdr e_machine and for the
purposes of csky the e_flags. If you want the e_machine for the perf
binary itself (such as in perf record when you don't yet have a
perf.data file) there is an EM_HOST value:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/include/dwarf-regs.h?h=3Dperf-tools-next#n27
Perf has historically used a CPUID string, but I'd like to deprecate
that in favor of just using e_machine (and possibly e_flags) values.
We should probably have CPUID string to e_machine convesion utility
functions and remove cpuid from the perf_env:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/env.h?h=3Dperf-tools-next#n67
but anyway, my point isn't about the e_machine values.

What I'm trying to say is that weak symbols and code in arch
inherently means the cross platform development will break. For
example, before:
https://lore.kernel.org/lkml/20250724163302.596743-21-irogers@google.com/
perf_parse_sample_weight just simply didn't exist outside of PowerPC
and x86. This meant that the part of the perf event in the perf.data
containing the sample weights couldn't be parsed on say an ARM64 build
of perf. This meant the values couldn't even be dumped in perf script.
The values are, however, described in the cross platform perf sample
event format, much as the SIMD registers are here.

It seems as we have from a perf.data file at least a CPUID string from
the header features, a perf_event_attr and the register number, we
should be able to do something like get_dwarf_regstr. Such a function
wouldn't be in the arch directory as we wouldn't want to interpret
registers in events just on x86 platforms (as with the retirement
latency). If we're not able to do this then there seems to be
something wrong with the SIMD change and perhaps we need to capture
more information in the perf.data file header.

Thanks,
Ian

> >
> > Thanks,
> > Ian
> >
> >>> Thanks,
> >>> Ian
> >>>
> >>>>> Thanks,
> >>>>> Ian
> >>>>>
> >>>>>
> >>>>>
> >>>>>>> Thanks,
> >>>>>>> Ian
> >>>>>>>
> >>>>>>>> +
> >>>>>>>>  const char *perf_reg_name(int id, const char *arch)
> >>>>>>>>  {
> >>>>>>>>         const char *reg_name =3D NULL;
> >>>>>>>> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_=
regs.h
> >>>>>>>> index f2d0736d65cc..bce9c4cfd1bf 100644
> >>>>>>>> --- a/tools/perf/util/perf_regs.h
> >>>>>>>> +++ b/tools/perf/util/perf_regs.h
> >>>>>>>> @@ -24,9 +24,20 @@ enum {
> >>>>>>>>  };
> >>>>>>>>
> >>>>>>>>  int arch_sdt_arg_parse_op(char *old_op, char **new_op);
> >>>>>>>> +bool arch_has_simd_regs(u64 mask);
> >>>>>>>>  uint64_t arch__intr_reg_mask(void);
> >>>>>>>>  uint64_t arch__user_reg_mask(void);
> >>>>>>>>  const struct sample_reg *arch__sample_reg_masks(void);
> >>>>>>>> +const struct sample_reg *arch__sample_simd_reg_masks(void);
> >>>>>>>> +const struct sample_reg *arch__sample_pred_reg_masks(void);
> >>>>>>>> +uint64_t arch__intr_simd_reg_mask(void);
> >>>>>>>> +uint64_t arch__user_simd_reg_mask(void);
> >>>>>>>> +uint64_t arch__intr_pred_reg_mask(void);
> >>>>>>>> +uint64_t arch__user_pred_reg_mask(void);
> >>>>>>>> +uint64_t arch__intr_simd_reg_bitmap_qwords(int reg, u16 *qwords=
);
> >>>>>>>> +uint64_t arch__user_simd_reg_bitmap_qwords(int reg, u16 *qwords=
);
> >>>>>>>> +uint64_t arch__intr_pred_reg_bitmap_qwords(int reg, u16 *qwords=
);
> >>>>>>>> +uint64_t arch__user_pred_reg_bitmap_qwords(int reg, u16 *qwords=
);
> >>>>>>>>
> >>>>>>>>  const char *perf_reg_name(int id, const char *arch);
> >>>>>>>>  int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
> >>>>>>>> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> >>>>>>>> index ea3a6c4657ee..825ffb4cc53f 100644
> >>>>>>>> --- a/tools/perf/util/record.h
> >>>>>>>> +++ b/tools/perf/util/record.h
> >>>>>>>> @@ -59,7 +59,13 @@ struct record_opts {
> >>>>>>>>         unsigned int  user_freq;
> >>>>>>>>         u64           branch_stack;
> >>>>>>>>         u64           sample_intr_regs;
> >>>>>>>> +       u64           sample_intr_vec_regs;
> >>>>>>>>         u64           sample_user_regs;
> >>>>>>>> +       u64           sample_user_vec_regs;
> >>>>>>>> +       u16           sample_pred_regs_qwords;
> >>>>>>>> +       u16           sample_vec_regs_qwords;
> >>>>>>>> +       u16           sample_intr_pred_regs;
> >>>>>>>> +       u16           sample_user_pred_regs;
> >>>>>>>>         u64           default_interval;
> >>>>>>>>         u64           user_interval;
> >>>>>>>>         size_t        auxtrace_snapshot_size;
> >>>>>>>> --
> >>>>>>>> 2.34.1
> >>>>>>>>
