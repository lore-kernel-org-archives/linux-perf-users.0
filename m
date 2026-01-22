Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C40247A0B2
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 07:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769066901; cv=pass; b=HWYQ7NCCWhDfLWtDrWH0+wkpg2z1eeAIipK9a11OXWOg5hB5n/jPZPRnOCD9lXPqWYUkNzrkRrJVijsL2ngc9IHVtSY3qUWgC9KB+AA3103YgiizB5WLaoInJb+4JvCvl9bElKNk84nhTGL2lDMg4pWhMrRULw0lbVR8AM1rjWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769066901; c=relaxed/simple;
	bh=6RBKbNx41psg5MvoY6PIahBoXCiPvgKi1iWMoRbNCnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NkxPwgX/JIFEhQ2eZgtZRrtH30223dcknH8+TXwMaO/hIzaWY6tERTZURX97Yw1Poy0E8xQL13/uhwwwszGpubcF4K7vocIKHNRNL0xwarikcTo+eIwC5cs0c1dTmWCOtgKp+NE6dYu6aDAEQ5nWHBA+pUaNZbLLX+0jRIgbarI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZikJncUI; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZikJncUI"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0d06cfa93so34345ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 23:28:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769066890; cv=none;
        d=google.com; s=arc-20240605;
        b=iSO9nNf8o9jqR/PnsS1EpX8vA0uA2nIbJXxkmFXwajc/paXiYvqS+BcgGaZTnHbemG
         NT09nTzVTb5v5EPUiWhrU744X9WrHLgVKjKe6Y9f2Bh/r63/qXMiW22ChtSkOiwwFrly
         zq9vneM6NyqPRixXyjjTUaz+6T6fXg0W0lR/TvGVhK6bqZ0r+EQZQylIAmTSQW5bK6bq
         W+AQ58P0/3mQ6fSaQMpHa5d9Sz7jy19rBdHJAEqscsC7iANg4msBARcACaYBm5Eg1YqF
         NQcqy1B9BIMsWP/eY2bvarAMhDp9E9UQ1OGMKE2CKT14Gk/MpaVsNAGou2iqEx3XenxB
         mtow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HdfQwwyixeu7qJg5RCip03dimDyzG9kj0TvI1xjm2Tc=;
        fh=PZBwaPp+SwBtSA/dSC7cHicF+Hy6CVkaEbsxCxuWVHc=;
        b=GvR7xu9euAuqjp3yYNGtf1wxNPfZu4aEzdPnQVH/pnLcbV0bIE8jlOZPe1VawTIwoD
         7VncO6IZnx3FASBvPRnJR6scyBuP58ilHdDB+YogOLtZkGC3ZPnYeawrkU88bcp21Zz5
         OwpZwtGiivufb2pijP0ltLo+sFF9D/GjEkBbueVTYgRQThV8t+3JrSjrWnzEic/bZkw6
         OzYI6s95PlA6JtsWh/Gy9v+7SI3Z3kuZe2tgNSKMevFJUcfqLvA7Wb+WeAuWI08rPo7F
         /FmjEHqnhKqHdjZeWeIPE1lGM/y+S7QN4iM6eAHRsIJiRTiwVQTipxqT1/8sWM90/vvL
         wStg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769066890; x=1769671690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdfQwwyixeu7qJg5RCip03dimDyzG9kj0TvI1xjm2Tc=;
        b=ZikJncUI3P3rtVOI6sAi0R9wIbXecZXjjnozkXLKgP52CLbcRqWUc8UmvwQwWyJdyb
         ybu/DAhsjv7Hq7S68d02Dre9kD8dhyQHzmkGmq238EVYbyNzpODg0Dl5ysbkDw061NoC
         3/4gxmZE7AFBTD2HQt2vbQyw1jggjqQ49OhGPzkv0TH8HwA1zHJUhiM39kIYCaJosiLy
         1uHOzliQydY10fZh4ZFHflH+GI94t+/6qUuM4gz/7Z/uUKrysYD3Wp1UZU4TM8TDEybR
         K32VUltWeKQ2fMzRoi0QNJtl9wTYTZ5sF1L+fw4qboKs1Ko14BJM0jgoSwTwnkY8gMt/
         0Brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769066890; x=1769671690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HdfQwwyixeu7qJg5RCip03dimDyzG9kj0TvI1xjm2Tc=;
        b=t5wx5sPUF5vo3/pQLIjmsqRbgkAwHbiKuseKeohXEL/9BOrERCRpD2p/lHr2p8FVbd
         IQIVv3vI1bxC308f0mwvP0eg1G4LxewEWW4HQzKkZqw2GV+JHBm/F8arBcHzDyiahTDT
         WhVQQGmHlSPUbPMYa7pN08KO3TUENg0WzpxFE/wGC694Gh9QYXwNSDa61jFR1qqB8enh
         i2jYkigTCBpNTHT5izKZa3qm9jeaCdi5s+uFiKrvZnNRvHcn3lyc0rH9W+CwW0cs8pou
         HRbHYRF3wAsqRz/qhm4vEYu7282YEZpSPETgAjz/encaRzJnH2uKkxy6+kaE+Vc7OIt/
         9i1w==
X-Forwarded-Encrypted: i=1; AJvYcCXkzh65il7rhjhwoeNl91J1M6FBNIIWyMUy/PpLA4Yqcq0oCRgpNUqLfCbSNSg7MbrqUSXVXlafRMUtZU2DQie4@vger.kernel.org
X-Gm-Message-State: AOJu0YwiwpEfQI31j33HBcOALMwaf9SxDk5Vbt5728/u/GSphZg3HTxO
	p3pj3f1hShzn1j0mIzCQ7gNQb4y0GUTGXnycZEi3VJWzZOj74vfPLEa1gL0nm/ww1PtCbnW2cYF
	VZ4hDi+BS1fFVNkAWuVN1/IwmO4kra+JN7TbscMj2
X-Gm-Gg: AZuq6aIAbvCqyKBDkBXVBWTTTLdGBKz6akppgq0QL6/A6pn1h24uegvZMVb2OG6hktB
	5TOVy2MQkucUkPdgiKL3RwwkuCo1nMqTx3f1jfR38HDXnXeTh94jdfIgTJlrveserX355Qa4ah6
	zB4FoR9KT/mpuVZgDB6VKh5A9HvovKFVN9tViAWyjfK0z2XAWuK6/EUeiUHhuX0jXyyuu86pLby
	2LqHxM3cmBnKZMxKCgbff61gf818vJ4qEMalKt9g3fRHRljw+FX9JAOEXkNaYReED/rIYhK3+Fr
	cFUf8dx8J3YK3TouLt61CA7KcMEW0cASmUrP
X-Received: by 2002:a17:902:f787:b0:2a7:4151:2c74 with SMTP id
 d9443c01a7336-2a7d422143fmr1875415ad.16.1769066888834; Wed, 21 Jan 2026
 23:28:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-19-dapeng1.mi@linux.intel.com> <CAP-5=fWOsvAXuu8qx0tk9q8j8BoXPMJB3Gxto+iu6wf06i4cVA@mail.gmail.com>
 <ec427fd5-06f8-4b05-a074-bfc2aa196ffa@linux.intel.com> <CAP-5=fWmKLZtK-BOdRd5hhh=Yd6SedmLBAt6cUcEjdP73V3xrQ@mail.gmail.com>
 <174bcc6a-8598-4a15-a701-88aa2b105b70@linux.intel.com> <CAP-5=fV5QyLtuMDGm5KMcz0vO1kiHm+H0VCzq7pLJuSNDGhg1A@mail.gmail.com>
 <e00c9041-fee9-4dec-8650-ae5fe9286d87@linux.intel.com> <CAP-5=fUHgGj-+Zwpy4BDNPTGXAzUXLEY0QaKXZQB__d8yze2uQ@mail.gmail.com>
 <efcac676-0b83-480b-8e9c-9734264df693@linux.intel.com>
In-Reply-To: <efcac676-0b83-480b-8e9c-9734264df693@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 Jan 2026 23:27:57 -0800
X-Gm-Features: AZwV_QgOuP3u4lY4WA9zfs0FiE_NvJDtUG0ATsORraW3gnzaygFdlnuomzndy_I
Message-ID: <CAP-5=fWdHyLM=-cWucJNHJMuSHDP0vt8y1_B7cy3D=MAhuE_6Q@mail.gmail.com>
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

On Wed, Jan 21, 2026 at 5:49=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 1/21/2026 10:48 PM, Ian Rogers wrote:
> > On Tue, Jan 20, 2026 at 11:52=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.i=
ntel.com> wrote:
> >>
> >> On 1/21/2026 3:09 PM, Ian Rogers wrote:
> >>> On Tue, Jan 20, 2026 at 9:17=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.=
intel.com> wrote:
> >>>> On 1/21/2026 2:20 AM, Ian Rogers wrote:
> >>>>> On Tue, Jan 20, 2026 at 1:04=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linu=
x.intel.com> wrote:
> >>>>>> On 1/20/2026 3:39 PM, Ian Rogers wrote:
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
> >>>>>>> I wonder we can remove these functions. perf_reg_name(int id, uin=
t16_t
> >>>>>>> e_machine) maps a perf register number and e_machine to a string.=
 So
> >>>>>>> the sample_reg array could be replaced with:
> >>>>>>> ```
> >>>>>>> for (int perf_reg =3D 0; perf_reg < 64; perf_reg++) {
> >>>>>>>   uint64_t mask =3D 1LL << perf_reg;
> >>>>>>>   const char *name =3D perf_reg_name(perf_reg, EM_HOST);
> >>>>>>>   if (name =3D=3D NULL)
> >>>>>>>     break;
> >>>>>>>   // use mask and name
> >>>>>>> ```
> >>>>>>> To make it work for SIMD and PRED then I guess we need to iterate
> >>>>>>> through the ABIs of enum perf_sample_regs_abi.
> >>>>>> Suppose so.
> >>>>>>
> >>>>>>
> >>>>>>>> +uint64_t arch__intr_simd_reg_mask(void);
> >>>>>>>> +uint64_t arch__user_simd_reg_mask(void);
> >>>>>>>> +uint64_t arch__intr_pred_reg_mask(void);
> >>>>>>>> +uint64_t arch__user_pred_reg_mask(void);
> >>>>>>> I think some comments would be useful here like:
> >>>>>>> ```
> >>>>>>> /* Perf register bit map with valid bits for
> >>>>>>> perf_event_attr.sample_regs_user. */
> >>>>>>> uint64_t arch__intr_reg_mask(void);
> >>>>>>> /* Perf register bit map with valid bits for
> >>>>>>> perf_event_attr.sample_regs_intr. */
> >>>>>>> uint64_t arch__user_reg_mask(void);
> >>>>>>> /* Perf register bit map with valid bits for
> >>>>>>> perf_event_attr.sample_simd_vec_reg_intr. */
> >>>>>>> uint64_t arch__intr_simd_reg_mask(void);
> >>>>>>> /* Perf register bit map with valid bits for
> >>>>>>> perf_event_attr.sample_simd_vec_reg_user. */
> >>>>>>> uint64_t arch__user_simd_reg_mask(void);
> >>>>>>> /* Perf register bit map with valid bits for
> >>>>>>> perf_event_attr.sample_simd_pred_reg_intr. */
> >>>>>>> uint64_t arch__intr_pred_reg_mask(void);
> >>>>>>> /* Perf register bit map with valid bits for
> >>>>>>> perf_event_attr.sample_simd_pred_reg_user. */
> >>>>>>> uint64_t arch__user_pred_reg_mask(void);
> >>>>>> Sure. Thanks.
> >>>>>>
> >>>>>>
> >>>>>>> ```
> >>>>>>>
> >>>>>>> Why do the arch__user_pred_reg_mask return a uint64_t when the
> >>>>>>> perf_event_attr variable is a __u32?
> >>>>>> Suppose it's a bug. :)
> >>>>>>
> >>>>>>
> >>>>>>>> +uint64_t arch__intr_simd_reg_bitmap_qwords(int reg, u16 *qwords=
);
> >>>>>>>> +uint64_t arch__user_simd_reg_bitmap_qwords(int reg, u16 *qwords=
);
> >>>>>>>> +uint64_t arch__intr_pred_reg_bitmap_qwords(int reg, u16 *qwords=
);
> >>>>>>>> +uint64_t arch__user_pred_reg_bitmap_qwords(int reg, u16 *qwords=
);
> >>>>>>> I don't understand this function. The qwords is specific to a
> >>>>>>> perf_event_attr. We could have an evlist with an evsel set up to
> >>>>>>> sample say XMM registers and another evsel set up to sample ZMM
> >>>>>>> registers. Are the qwords here always for the ZMM case, or is XMM=
,
> >>>>>>> YMM, ZMM depending on architecture support? Why does it vary per
> >>>>>>> register? The surrounding code uses the term mask but here bitmap=
 is
> >>>>>>> used, is the inconsistency deliberate? Why are there user and int=
r
> >>>>>>> functions when in the perf_event_attr there are only
> >>>>>>> sample_simd_pred_reg_qwords and sample_simd_ved_reg_qwords variab=
les?
> >>>>>> These 4 functions is designed to get the bitmask and qwords length=
 for a
> >>>>>> specific SIMD registers. E.g., For XMM on x86 platforms, the retur=
ned
> >>>>>> bitmask is 0xffff (xmm0 ~ xmm15) and the qwords length is 2 (128 b=
its). For
> >>>>>> ZMM on x86 platforms, if the platform only supports 16 ZMM registe=
rs, then
> >>>>>> the returned bitmask is 0xffff (zmm0 ~ zmm15) and qwords length is=
 8 (512
> >>>>>> bits). If the platform supports 32 ZMM registers, then the returne=
d bitmask
> >>>>>> is 0xffffffff (zmm0 ~ zmm31) and qwords length is 8 (512 bits).
> >>>>> What is the meaning of reg? In this file it is normally the integer
> >>>>> index for a bit in the sample_regs_user mask, but for x86 I don't s=
ee
> >>>>> enum perf_event_x86_regs having differing XMM, YMM and ZMM encoding=
s.
> >>>>> Similarly, is qwords an out argument, but then you also have the
> >>>>> bitmap. It looks like the code is caching values but that assumes a
> >>>>> single qword length for all events.
> >>>> Yes, the "reg" argument indicates the SIMD register index. Strictly
> >>>> speaking for x86 platform, the qwords length is fixed for a specific=
 SIMD
> >>>> register and only the register number could vary, e.g., some platfor=
ms
> >>>> could only support 16 ZMM registers, but some other platforms could =
support
> >>>> 32 ZMM registers. But considering this is a generic function for all=
 kinds
> >>>> of archs, we can't ensure there are fixed length for a specific SIMD
> >>>> register on any arch, so I introduce  the "qwords" argument to incre=
ase the
> >>>> flexibility.
> >>> I'm still not understanding this still :-) What is a "SIMD register
> >>> index", the file is for perf registers and naturally enum
> >>> perf_event_x86_regs on x86, but that doesn't encode YMM and ZMM
> >>> registers. Perhaps you can give some examples?
> >> Yes, it's something just like the register index in the enum
> >> perf_event_x86_regs, e.g. the index of AX register is PERF_REG_X86_AX,=
 the
> >> index of BX is PERF_REG_X86_BX, and so on.
> >>
> >> But the difference is that each index in the perf_event_x86_regs can o=
nly
> >> represent a u64 word. Assume we still want to represent the SIMD regis=
ters
> >> with the perf_event_x86_regs enum, then each XMM register needs 2 inde=
xes,
> >> each YMM register needs 4 indexes and each ZMM needs 8 indexes. Consid=
ering
> >> there are 16 XMM registers, 16 YMM registers and 32 ZMM registers. To
> >> represent all these indexes, then the enum perf_event_x86_regs would b=
ecome
> >> quite large, and correspondingly the sample_regs_intr/sample_regs_user
> >> fields in the perf_event_attr would have to inflate much. That would
> >> consume much memory.
> >>
> >> So that's why we introduce the new below attributes.
> >>
> >> + union { + __u16 sample_simd_regs_enabled; + __u16
> >> sample_simd_pred_reg_qwords; + }; + __u32 sample_simd_pred_reg_intr; +
> >> __u32 sample_simd_pred_reg_user; + __u16 sample_simd_vec_reg_qwords; +
> >> __u64 sample_simd_vec_reg_intr; + __u64 sample_simd_vec_reg_user; + __=
u32
> >> __reserved_4; For SIMD registers, each kind of SIMD register would be
> >> treated as a whole. The sample_simd_vec_reg_qwords would be used to
> >> identify the length of SIMD register, simultaneously it also hint whic=
h
> >> kind of SIMD register it is since the length of each kind of SIMD regi=
ster
> >> is different. E.g. we want to sample XMM registers. We know there are =
16
> >> XMM registers on the x86 platform and qwords length of XMM register is=
 2.
> >> So user space needs to set the attributes like this,
> >>
> >> sample_simd_vec_reg_intr =3D 0xffff;
> >>
> >> sample_simd_vec_reg_qwords =3D 2;
> >>
> >> Come back to "reg" argument, we know there could be multiple kinds of =
SIMD
> >> registers supported on some kind of arch, e.g., x86 support XMM, YMM, =
ZMM
> >> and OPMASK SIMD registers. As each kind of SIMD register is always sam=
pled
> >> as a whole, we don't need to represent each of SIMD register, like XMM=
0,
> >> XMM1, but we indeed need to distinguish different kinds of SIMD regist=
er,
> >> like XMM and YMM registers, since they have different register length =
and
> >> number.
> >>
> >> That's why we define the index for each kind of SIMD register, like be=
low,
> >>
> >> +enum { + PERF_REG_X86_XMM, + PERF_REG_X86_YMM, + PERF_REG_X86_ZMM, +
> >> PERF_REG_X86_MAX_SIMD_REGS, + + PERF_REG_X86_OPMASK =3D 0, +
> >> PERF_REG_X86_MAX_PRED_REGS =3D 1, +}; It's similar withperf_event_x86_=
regs, but each index represents a kind of SIMD register instead of a specif=
ic SIMD register.
> > Could you give me an example call to say
> > arch__intr_simd_reg_bitmap_qwords where you say what the value of reg
> > is, what the expected value of qwords is and what the result will be?
> > Could you do it for say a model without AVX, a model with AVX, a model
> > with AVX512 and a model with APX.
>
> Assume we are on a x86 platform which only supports XMM registers (AVX) a=
nd
> call the function arch__intr_simd_reg_bitmap_qwords() with SIMD register =
index,
>
> 1. reg =3D PERF_REG_X86_XMM
>
> The return value (XMM registers bitmask) =3D 0xffff and the qwords =3D 2 =
(128 bits).

Thanks!
Can we rename PERF_REG_X86_XMM to say PERF_REG_CLASS_X86_XMM
(similarly reg to reg_class), currently the name is very close to
PERF_REG_X86_XMM0 but that value is in a different enum.
So the bitmask is in terms of the qwords whilst the regular perf
register mask is 1 64-bit qword per bit.

> 2. reg =3D PERF_REG_X86_YMM
>
> The return value (YMM registers bitmask) =3D 0 and the qwords =3D 0 since=
 YMM registers are not supported.
>
> 3. reg =3D PERF_REG_X86_ZMM
>
> The return value (ZMM registers bitmask) =3D 0 and the qwords =3D 0 since=
 ZMM registers are not supported.

Ok.

> Assume we are on a x86 platform which supports XMM/YMM/ZMM registers (AVX=
512) and call the function arch__intr_simd_reg_bitmap_qwords() with SIMD re=
gister index,
>
> 1. reg =3D PERF_REG_X86_XMM
>
> The return value (XMM registers bitmask) =3D 0xffff and the qwords =3D 2 =
(128 bits).
>
> 2. reg =3D PERF_REG_X86_YMM
>
> The return value (YMM registers bitmask) =3D 0xffff and the qwords =3D 4 =
(256 bits).

Ok, qwords got bigger.

> 3. reg =3D PERF_REG_X86_ZMM
>
> The return value (ZMM registers bitmask) =3D 0xffffffff and the qwords =
=3D 8 (512 bits). We assume this platform supports 32 ZMM registers (ZMM0 ~=
 ZMM31).

Wouldn't it then also support 32 YMM and XMM registers in the 2 cases above=
?

> As for APX, it has nothing to do with these 4 functions, whether it's sup=
ported is determined by the helpers arch__intr_reg_mask()/arch__user_reg_ma=
sk().
> e.g.,
>
> ```
>         if (has_cap_simd_regs()) {
>                 mask |=3D __arch__reg_mask(PERF_SAMPLE_REGS_INTR,
>                                          GENMASK_ULL(PERF_REG_X86_R31, PE=
RF_REG_X86_R16),
>                                          true);
>                 mask |=3D __arch__reg_mask(PERF_SAMPLE_REGS_INTR,
>                                          BIT_ULL(PERF_REG_X86_SSP),
>                                          true);
> ```
> If the platform supports APX eGPRs, then the returned mask from arch__int=
r_reg_mask()/arch__user_reg_mask() would contain the eGPRs mask, otherwise,=
 it would not.

Thanks for the explanation. In the perf_regs.h why do YMMH and ZMMH
also appear but not as arguments for arch__intr_simd_reg_bitmap_qwords
?

> >
> > I have looked at the code and read the changes to perf_event_attr
> > which is why I was confused by your saying that ZMM could be passed in
> > as a perf register number. I am confused as why when the
> > perf_event_attr has 2 qword length related variables this code seems
> > to be setting things up so that every register can have a qword
> > length. I'm confused what is happening with the return value of this
> > function. As values are being stored into global variables, and you
> > are saying they aren't a max value, then how does this impact the
> > setting up of multiple register sampling events?
>
> The 2 qwords length, sample_simd_pred_reg_qwords is to store the PRED
> register length, and sample_simd_vec_reg_qwords is to store the SIMD
> register length. Since the SIMD/PRED registers with larger length would
> contain the SIMD/PRED register with shorter length, so only the largest
> length would be set  to into the variables
> sample_simd_vec_reg_qwords/sample_simd_vec_reg_qwords .
>
> E.g.,
>
> perf record -e cyles:p -Ixmm,ymm,zmm -c 10000 -- sleep 1
>
> The sample_simd_vec_reg_qwords would be set to 8 to represent the largest
> length (ZMM) and kernel directly samples ZMM registers since ZMM register=
s
> fully contains YMM and XMM registers.
>
> The reason that caching bitmask and qwords is that the bitmask and qwords
> for a specific SIMD/PRED register is fixed on a certain x86 platform,
> right?  E.g. the qwords length of XMM register is always 2, YMM is 4, etc=
...

Ok. My confusion is the overloaded meaning of a perf register in this
file, hence it'd be nice to make the names more distinct.

> The bitmask and qwords values are retrieved from kernel by
> perf_event_open() syscall which is quite expensive, if it's called
> frequently, it would impact the performance heavily.

Agreed. It is a shame the existing probing/caching aren't used.

Thanks,
Ian

> >
> > Thanks,
> > Ian
> >
> >>> How does the generic differing qword per register case get encoded
> >>> into a perf_event_attr? If it can't be then this seems like
> >>> functionality for no benefit. I also don't understand how the data in
> >>> the PERF_SAMPLE_REGS_USER part of a sample could be decoded as that i=
s
> >>> assuming a constant qword number.
> >>>
> >>>> No, the qwords would be assigned to true register length if the regi=
ster
> >>>> exists on the platform, e.g., xmm =3D 2, ymm =3D  4 and zmm =3D 8. i=
f the
> >>>> register is not support on the platfom, the qwords would be set to 0=
.
> >>> So it is a max function of the vector/pred qwords supported on the ar=
chitecture.
> >> Strictly speaking, it's not "max" function of the vector/pred qwords, =
it's
> >> just a function to get the exact vector/pred qwords supported on the
> >> architecture since qwords length won't vary for a fixed kind of SIMD r=
egister.
> >>
> >>
> >>>>>> Since the qword length is always fixed for any certain SIMD regist=
er
> >>>>>> regardless of intr or user, so there is only one
> >>>>>> sample_simd_pred_reg_qwords or sample_simd_ved_reg_qwords variable=
.
> >>>>> Ok.  2 variables, but 4 functions here. I think there should just b=
e 2
> >>>>> because of this.
> >>>> Yes, the user and intr variants would be merged into only one.
> >>> Thanks,
> >>> Ian
> >>>
> >>>>> Thanks,
> >>>>> Ian
> >>>>>
> >>>>>>> Perhaps these functions should be something more like:
> >>>>>>> ```
> >>>>>>> /* Maximum value that can be assigned to
> >>>>>>> perf_event_atttr.sample_simd_pred_reg_qwords. */
> >>>>>>> uint16_t arch__simd_pred_reg_qwords_max(void);
> >>>>>>> /* Maximum value that can be assigned to
> >>>>>>> perf_event_atttr.sample_simd_vec_reg_qwords. */
> >>>>>>> uint16_t arch__simd_vec_reg_qwords_max(void);
> >>>>>>> ```
> >>>>>>> Then the bitmap computation logic can all be moved into parse-reg=
s-options.c.
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>> Ian
> >>>>>>>
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
