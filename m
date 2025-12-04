Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FAC2FFF92;
	Thu,  4 Dec 2025 02:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764817122; cv=none; b=ej4+ASXQn4l2+Xhm2g6rupxttQPJ3NahT3nHsgVVXjgmdrzN/zdGJStn2IQu4RMDyNJ9NuU+YFJvZqEpvXeN2LI39tYO8kcfMm8upIWwih1//k/F7X5uWyBqpjhXDMdcgidQ8TTQKuQU2m+iejH2dSf79lUrIw8eRaWhjQhKeVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764817122; c=relaxed/simple;
	bh=DXqoExsTmZ0yDnhSzbPeSMrsvW4r0sNTO5DV3f6uMag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMGT0s0MjcxMKCZS+THvE7HGa76LXA+rixhzEbhz3HOd4VErBG9Km7SMB0fWvb2J0AIu0F3cfHcb6drh/cIpXXkqj2MFZXXrPleYfiTyPQVSOPzzcKETniXe4Uu3oE1CTTqkDZGGOouyEO4Gs8EgCwj1yoOGq8oJd1C+PRVuNhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C0IAqZ9q; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C0IAqZ9q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764817119; x=1796353119;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DXqoExsTmZ0yDnhSzbPeSMrsvW4r0sNTO5DV3f6uMag=;
  b=C0IAqZ9qberH3qMIIYv+wUgTDKJIH8wKXdD9eLrwWHn8SNu2bX/t2rwk
   tmYiLBYGvQRhKvxuF6gzuadrAXIFgSd8jWWrUs1sAzySo00s7LaK5PyqW
   +h43q7uhhVLeFGNiJw67IS50h3oEYlUlPy7R5G3ZeU7yiv4FY2YW3vHbO
   O32tQHuaNsGcpz9dsuU6VPN04G7J1ChkvBRLY8YJRY2PUV5vECLe0od/Q
   fJ/L5napip6WdtH1KcfjxkelBdZyLUWO5dQwfnSJ3bCUiJ+2LffjY7UiO
   6j9uIE1fHAh8yJG/H9cJWQ2CfwRgaFrUEepXbaxrmMCnVshTSKUK0c5I5
   Q==;
X-CSE-ConnectionGUID: OheIxkxpSOOTgolNalNAlw==
X-CSE-MsgGUID: J4vxTLhuTJGqFJZsZx03MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66719362"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="66719362"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 18:58:38 -0800
X-CSE-ConnectionGUID: tbxy+eWLSoGuYdAzUbK/HQ==
X-CSE-MsgGUID: P6VZr/SKRA+JVlUBNeF8Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="199809059"
Received: from unknown (HELO [10.238.3.115]) ([10.238.3.115])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 18:58:33 -0800
Message-ID: <9d97e2f4-3971-4486-8689-ab50b06c3810@linux.intel.com>
Date: Thu, 4 Dec 2025 10:58:30 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 18/19] perf parse-regs: Support new SIMD sampling
 format
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-19-dapeng1.mi@linux.intel.com>
 <CAP-5=fVk7+iGn+jhfE3a9iY_G1Gdph9Sh0RNco+745XQMfubLg@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fVk7+iGn+jhfE3a9iY_G1Gdph9Sh0RNco+745XQMfubLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 12/4/2025 8:17 AM, Ian Rogers wrote:
> On Tue, Dec 2, 2025 at 10:59 PM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> This patch adds support for the newly introduced SIMD register sampling
>> format by adding the following functions:
>>
>> uint64_t arch__intr_simd_reg_mask(void);
>> uint64_t arch__user_simd_reg_mask(void);
>> uint64_t arch__intr_pred_reg_mask(void);
>> uint64_t arch__user_pred_reg_mask(void);
>> uint64_t arch__intr_simd_reg_bitmap_qwords(int reg, u16 *qwords);
>> uint64_t arch__user_simd_reg_bitmap_qwords(int reg, u16 *qwords);
>> uint64_t arch__intr_pred_reg_bitmap_qwords(int reg, u16 *qwords);
>> uint64_t arch__user_pred_reg_bitmap_qwords(int reg, u16 *qwords);
>>
>> The arch__{intr|user}_simd_reg_mask() functions retrieve the bitmap of
>> supported SIMD registers, such as XMM/YMM/ZMM on x86 platforms.
>>
>> The arch__{intr|user}_pred_reg_mask() functions retrieve the bitmap of
>> supported PRED registers, such as OPMASK on x86 platforms.
>>
>> The arch__{intr|user}_simd_reg_bitmap_qwords() functions provide the
>> exact bitmap and number of qwords for a specific type of SIMD register.
>> For example, for XMM registers on x86 platforms, the returned bitmap is
>> 0xffff (XMM0 ~ XMM15) and the qwords number is 2 (128 bits for each XMM).
>>
>> The arch__{intr|user}_pred_reg_bitmap_qwords() functions provide the
>> exact bitmap and number of qwords for a specific type of PRED register.
>> For example, for OPMASK registers on x86 platforms, the returned bitmap
>> is 0xff (OPMASK0 ~ OPMASK7) and the qwords number is 1 (64 bits for each
>> OPMASK).
>>
>> Additionally, the function __parse_regs() is enhanced to support parsing
>> these newly introduced SIMD registers. Currently, each type of register
>> can only be sampled collectively; sampling a specific SIMD register is
>> not supported. For example, all XMM registers are sampled together rather
>> than sampling only XMM0.
>>
>> When multiple overlapping register types, such as XMM and YMM, are
>> sampled simultaneously, only the superset (YMM registers) is sampled.
>>
>> With this patch, all supported sampling registers on x86 platforms are
>> displayed as follows.
>>
>>  $perf record -I?
>>  available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
>>  R11 R12 R13 R14 R15 R16 R17 R18 R19 R20 R21 R22 R23 R24 R25 R26 R27 R28
>>  R29 R30 R31 SSP XMM0-15 YMM0-15 ZMM0-31 OPMASK0-7
>>
>>  $perf record --user-regs=?
>>  available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
>>  R11 R12 R13 R14 R15 R16 R17 R18 R19 R20 R21 R22 R23 R24 R25 R26 R27 R28
>>  R29 R30 R31 SSP XMM0-15 YMM0-15 ZMM0-31 OPMASK0-7
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  tools/perf/arch/x86/util/perf_regs.c      | 470 +++++++++++++++++++++-
>>  tools/perf/util/evsel.c                   |  27 ++
>>  tools/perf/util/parse-regs-options.c      | 151 ++++++-
>>  tools/perf/util/perf_event_attr_fprintf.c |   6 +
>>  tools/perf/util/perf_regs.c               |  59 +++
>>  tools/perf/util/perf_regs.h               |  11 +
>>  tools/perf/util/record.h                  |   6 +
>>  7 files changed, 714 insertions(+), 16 deletions(-)
>>
>> diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
>> index 12fd93f04802..db41430f3b07 100644
>> --- a/tools/perf/arch/x86/util/perf_regs.c
>> +++ b/tools/perf/arch/x86/util/perf_regs.c
>> @@ -13,6 +13,49 @@
>>  #include "../../../util/pmu.h"
>>  #include "../../../util/pmus.h"
>>
>> +static const struct sample_reg sample_reg_masks_ext[] = {
>> +       SMPL_REG(AX, PERF_REG_X86_AX),
>> +       SMPL_REG(BX, PERF_REG_X86_BX),
>> +       SMPL_REG(CX, PERF_REG_X86_CX),
>> +       SMPL_REG(DX, PERF_REG_X86_DX),
>> +       SMPL_REG(SI, PERF_REG_X86_SI),
>> +       SMPL_REG(DI, PERF_REG_X86_DI),
>> +       SMPL_REG(BP, PERF_REG_X86_BP),
>> +       SMPL_REG(SP, PERF_REG_X86_SP),
>> +       SMPL_REG(IP, PERF_REG_X86_IP),
>> +       SMPL_REG(FLAGS, PERF_REG_X86_FLAGS),
>> +       SMPL_REG(CS, PERF_REG_X86_CS),
>> +       SMPL_REG(SS, PERF_REG_X86_SS),
>> +#ifdef HAVE_ARCH_X86_64_SUPPORT
>> +       SMPL_REG(R8, PERF_REG_X86_R8),
>> +       SMPL_REG(R9, PERF_REG_X86_R9),
>> +       SMPL_REG(R10, PERF_REG_X86_R10),
>> +       SMPL_REG(R11, PERF_REG_X86_R11),
>> +       SMPL_REG(R12, PERF_REG_X86_R12),
>> +       SMPL_REG(R13, PERF_REG_X86_R13),
>> +       SMPL_REG(R14, PERF_REG_X86_R14),
>> +       SMPL_REG(R15, PERF_REG_X86_R15),
>> +       SMPL_REG(R16, PERF_REG_X86_R16),
>> +       SMPL_REG(R17, PERF_REG_X86_R17),
>> +       SMPL_REG(R18, PERF_REG_X86_R18),
>> +       SMPL_REG(R19, PERF_REG_X86_R19),
>> +       SMPL_REG(R20, PERF_REG_X86_R20),
>> +       SMPL_REG(R21, PERF_REG_X86_R21),
>> +       SMPL_REG(R22, PERF_REG_X86_R22),
>> +       SMPL_REG(R23, PERF_REG_X86_R23),
>> +       SMPL_REG(R24, PERF_REG_X86_R24),
>> +       SMPL_REG(R25, PERF_REG_X86_R25),
>> +       SMPL_REG(R26, PERF_REG_X86_R26),
>> +       SMPL_REG(R27, PERF_REG_X86_R27),
>> +       SMPL_REG(R28, PERF_REG_X86_R28),
>> +       SMPL_REG(R29, PERF_REG_X86_R29),
>> +       SMPL_REG(R30, PERF_REG_X86_R30),
>> +       SMPL_REG(R31, PERF_REG_X86_R31),
>> +       SMPL_REG(SSP, PERF_REG_X86_SSP),
>> +#endif
>> +       SMPL_REG_END
>> +};
>> +
>>  static const struct sample_reg sample_reg_masks[] = {
>>         SMPL_REG(AX, PERF_REG_X86_AX),
>>         SMPL_REG(BX, PERF_REG_X86_BX),
>> @@ -276,27 +319,404 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
>>         return SDT_ARG_VALID;
>>  }
>>
>> +static bool support_simd_reg(u64 sample_type, u16 qwords, u64 mask, bool pred)
> To make the code easier to read, it'd be nice to document sample_type,
> qwords and mask here.

Sure.


>
>> +{
>> +       struct perf_event_attr attr = {
>> +               .type                           = PERF_TYPE_HARDWARE,
>> +               .config                         = PERF_COUNT_HW_CPU_CYCLES,
>> +               .sample_type                    = sample_type,
>> +               .disabled                       = 1,
>> +               .exclude_kernel                 = 1,
>> +               .sample_simd_regs_enabled       = 1,
>> +       };
>> +       int fd;
>> +
>> +       attr.sample_period = 1;
>> +
>> +       if (!pred) {
>> +               attr.sample_simd_vec_reg_qwords = qwords;
>> +               if (sample_type == PERF_SAMPLE_REGS_INTR)
>> +                       attr.sample_simd_vec_reg_intr = mask;
>> +               else
>> +                       attr.sample_simd_vec_reg_user = mask;
>> +       } else {
>> +               attr.sample_simd_pred_reg_qwords = PERF_X86_OPMASK_QWORDS;
>> +               if (sample_type == PERF_SAMPLE_REGS_INTR)
>> +                       attr.sample_simd_pred_reg_intr = PERF_X86_SIMD_PRED_MASK;
>> +               else
>> +                       attr.sample_simd_pred_reg_user = PERF_X86_SIMD_PRED_MASK;
>> +       }
>> +
>> +       if (perf_pmus__num_core_pmus() > 1) {
>> +               struct perf_pmu *pmu = NULL;
>> +               __u64 type = PERF_TYPE_RAW;
> It should be okay to do:
> __u64 type = perf_pmus__find_core_pmu()->type
> rather than have the whole loop below.

Sure. Thanks.


>
>> +
>> +               /*
>> +                * The same register set is supported among different hybrid PMUs.
>> +                * Only check the first available one.
>> +                */
>> +               while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
>> +                       type = pmu->type;
>> +                       break;
>> +               }
>> +               attr.config |= type << PERF_PMU_TYPE_SHIFT;
>> +       }
>> +
>> +       event_attr_init(&attr);
>> +
>> +       fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
>> +       if (fd != -1) {
>> +               close(fd);
>> +               return true;
>> +       }
>> +
>> +       return false;
>> +}
>> +
>> +static bool __arch_simd_reg_mask(u64 sample_type, int reg, uint64_t *mask, u16 *qwords)
>> +{
>> +       bool supported = false;
>> +       u64 bits;
>> +
>> +       *mask = 0;
>> +       *qwords = 0;
>> +
>> +       switch (reg) {
>> +       case PERF_REG_X86_XMM:
>> +               bits = BIT_ULL(PERF_X86_SIMD_XMM_REGS) - 1;
>> +               supported = support_simd_reg(sample_type, PERF_X86_XMM_QWORDS, bits, false);
>> +               if (supported) {
>> +                       *mask = bits;
>> +                       *qwords = PERF_X86_XMM_QWORDS;
>> +               }
>> +               break;
>> +       case PERF_REG_X86_YMM:
>> +               bits = BIT_ULL(PERF_X86_SIMD_YMM_REGS) - 1;
>> +               supported = support_simd_reg(sample_type, PERF_X86_YMM_QWORDS, bits, false);
>> +               if (supported) {
>> +                       *mask = bits;
>> +                       *qwords = PERF_X86_YMM_QWORDS;
>> +               }
>> +               break;
>> +       case PERF_REG_X86_ZMM:
>> +               bits = BIT_ULL(PERF_X86_SIMD_ZMM_REGS) - 1;
>> +               supported = support_simd_reg(sample_type, PERF_X86_ZMM_QWORDS, bits, false);
>> +               if (supported) {
>> +                       *mask = bits;
>> +                       *qwords = PERF_X86_ZMM_QWORDS;
>> +                       break;
>> +               }
>> +
>> +               bits = BIT_ULL(PERF_X86_SIMD_ZMMH_REGS) - 1;
>> +               supported = support_simd_reg(sample_type, PERF_X86_ZMM_QWORDS, bits, false);
>> +               if (supported) {
>> +                       *mask = bits;
>> +                       *qwords = PERF_X86_ZMMH_QWORDS;
>> +               }
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +
>> +       return supported;
>> +}
>> +
>> +static bool __arch_pred_reg_mask(u64 sample_type, int reg, uint64_t *mask, u16 *qwords)
>> +{
>> +       bool supported = false;
>> +       u64 bits;
>> +
>> +       *mask = 0;
>> +       *qwords = 0;
>> +
>> +       switch (reg) {
>> +       case PERF_REG_X86_OPMASK:
>> +               bits = BIT_ULL(PERF_X86_SIMD_OPMASK_REGS) - 1;
>> +               supported = support_simd_reg(sample_type, PERF_X86_OPMASK_QWORDS, bits, true);
>> +               if (supported) {
>> +                       *mask = bits;
>> +                       *qwords = PERF_X86_OPMASK_QWORDS;
>> +               }
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +
>> +       return supported;
>> +}
>> +
>> +static bool has_cap_simd_regs(void)
>> +{
>> +       uint64_t mask = BIT_ULL(PERF_X86_SIMD_XMM_REGS) - 1;
>> +       u16 qwords = PERF_X86_XMM_QWORDS;
>> +       static bool has_cap_simd_regs;
>> +       static bool cached;
>> +
>> +       if (cached)
>> +               return has_cap_simd_regs;
>> +
>> +       has_cap_simd_regs = __arch_simd_reg_mask(PERF_SAMPLE_REGS_INTR,
>> +                                                PERF_REG_X86_XMM, &mask, &qwords);
>> +       has_cap_simd_regs |= __arch_simd_reg_mask(PERF_SAMPLE_REGS_USER,
>> +                                                PERF_REG_X86_XMM, &mask, &qwords);
>> +       cached = true;
>> +
>> +       return has_cap_simd_regs;
>> +}
>> +
>> +bool arch_has_simd_regs(u64 mask)
>> +{
>> +       return has_cap_simd_regs() &&
>> +              mask & GENMASK_ULL(PERF_REG_X86_SSP, PERF_REG_X86_R16);
>> +}
>> +
>> +static const struct sample_reg sample_simd_reg_masks[] = {
>> +       SMPL_REG(XMM, PERF_REG_X86_XMM),
>> +       SMPL_REG(YMM, PERF_REG_X86_YMM),
>> +       SMPL_REG(ZMM, PERF_REG_X86_ZMM),
>> +       SMPL_REG_END
>> +};
>> +
>> +static const struct sample_reg sample_pred_reg_masks[] = {
>> +       SMPL_REG(OPMASK, PERF_REG_X86_OPMASK),
>> +       SMPL_REG_END
>> +};
>> +
>> +const struct sample_reg *arch__sample_simd_reg_masks(void)
>> +{
>> +       return sample_simd_reg_masks;
>> +}
>> +
>> +const struct sample_reg *arch__sample_pred_reg_masks(void)
>> +{
>> +       return sample_pred_reg_masks;
>> +}
>> +
>> +static bool x86_intr_simd_updated;
>> +static u64 x86_intr_simd_reg_mask;
>> +static u64 x86_intr_simd_mask[PERF_REG_X86_MAX_SIMD_REGS];
>> +static u16 x86_intr_simd_qwords[PERF_REG_X86_MAX_SIMD_REGS];
> Could we add some comments? I can kind of figure out the updated is a
> check for lazy initialization and what masks are, qwords is an odd
> one. The comment could also point out that SIMD doesn't mean the
> machine supports SIMD, but SIMD registers are supported in perf
> events.

Sure.


>
>> +static bool x86_user_simd_updated;
>> +static u64 x86_user_simd_reg_mask;
>> +static u64 x86_user_simd_mask[PERF_REG_X86_MAX_SIMD_REGS];
>> +static u16 x86_user_simd_qwords[PERF_REG_X86_MAX_SIMD_REGS];
>> +
>> +static bool x86_intr_pred_updated;
>> +static u64 x86_intr_pred_reg_mask;
>> +static u64 x86_intr_pred_mask[PERF_REG_X86_MAX_PRED_REGS];
>> +static u16 x86_intr_pred_qwords[PERF_REG_X86_MAX_PRED_REGS];
>> +static bool x86_user_pred_updated;
>> +static u64 x86_user_pred_reg_mask;
>> +static u64 x86_user_pred_mask[PERF_REG_X86_MAX_PRED_REGS];
>> +static u16 x86_user_pred_qwords[PERF_REG_X86_MAX_PRED_REGS];
>> +
>> +static uint64_t __arch__simd_reg_mask(u64 sample_type)
>> +{
>> +       const struct sample_reg *r = NULL;
>> +       bool supported;
>> +       u64 mask = 0;
>> +       int reg;
>> +
>> +       if (!has_cap_simd_regs())
>> +               return 0;
>> +
>> +       if (sample_type == PERF_SAMPLE_REGS_INTR && x86_intr_simd_updated)
>> +               return x86_intr_simd_reg_mask;
>> +
>> +       if (sample_type == PERF_SAMPLE_REGS_USER && x86_user_simd_updated)
>> +               return x86_user_simd_reg_mask;
>> +
>> +       for (r = arch__sample_simd_reg_masks(); r->name; r++) {
>> +               supported = false;
>> +
>> +               if (!r->mask)
>> +                       continue;
>> +               reg = fls64(r->mask) - 1;
>> +
>> +               if (reg >= PERF_REG_X86_MAX_SIMD_REGS)
>> +                       break;
>> +               if (sample_type == PERF_SAMPLE_REGS_INTR)
>> +                       supported = __arch_simd_reg_mask(sample_type, reg,
>> +                                                        &x86_intr_simd_mask[reg],
>> +                                                        &x86_intr_simd_qwords[reg]);
>> +               else if (sample_type == PERF_SAMPLE_REGS_USER)
>> +                       supported = __arch_simd_reg_mask(sample_type, reg,
>> +                                                        &x86_user_simd_mask[reg],
>> +                                                        &x86_user_simd_qwords[reg]);
>> +               if (supported)
>> +                       mask |= BIT_ULL(reg);
>> +       }
>> +
>> +       if (sample_type == PERF_SAMPLE_REGS_INTR) {
>> +               x86_intr_simd_reg_mask = mask;
>> +               x86_intr_simd_updated = true;
>> +       } else {
>> +               x86_user_simd_reg_mask = mask;
>> +               x86_user_simd_updated = true;
>> +       }
>> +
>> +       return mask;
>> +}
>> +
>> +static uint64_t __arch__pred_reg_mask(u64 sample_type)
>> +{
>> +       const struct sample_reg *r = NULL;
>> +       bool supported;
>> +       u64 mask = 0;
>> +       int reg;
>> +
>> +       if (!has_cap_simd_regs())
>> +               return 0;
>> +
>> +       if (sample_type == PERF_SAMPLE_REGS_INTR && x86_intr_pred_updated)
>> +               return x86_intr_pred_reg_mask;
>> +
>> +       if (sample_type == PERF_SAMPLE_REGS_USER && x86_user_pred_updated)
>> +               return x86_user_pred_reg_mask;
>> +
>> +       for (r = arch__sample_pred_reg_masks(); r->name; r++) {
>> +               supported = false;
>> +
>> +               if (!r->mask)
>> +                       continue;
>> +               reg = fls64(r->mask) - 1;
>> +
>> +               if (reg >= PERF_REG_X86_MAX_PRED_REGS)
>> +                       break;
>> +               if (sample_type == PERF_SAMPLE_REGS_INTR)
>> +                       supported = __arch_pred_reg_mask(sample_type, reg,
>> +                                                        &x86_intr_pred_mask[reg],
>> +                                                        &x86_intr_pred_qwords[reg]);
>> +               else if (sample_type == PERF_SAMPLE_REGS_USER)
>> +                       supported = __arch_pred_reg_mask(sample_type, reg,
>> +                                                        &x86_user_pred_mask[reg],
>> +                                                        &x86_user_pred_qwords[reg]);
>> +               if (supported)
>> +                       mask |= BIT_ULL(reg);
>> +       }
>> +
>> +       if (sample_type == PERF_SAMPLE_REGS_INTR) {
>> +               x86_intr_pred_reg_mask = mask;
>> +               x86_intr_pred_updated = true;
>> +       } else {
>> +               x86_user_pred_reg_mask = mask;
>> +               x86_user_pred_updated = true;
>> +       }
>> +
>> +       return mask;
>> +}
> This feels repetitive with __arch__simd_reg_mask, could they be
> refactored together?

hmm, it looks we can extract the for loop as a common function. The other
parts are hard to be generalized since they are manipulating different
variables. If we want to generalize them, we have to introduce lots of "if
... else" branches and that would make code hard to be read.


>
>> +
>> +uint64_t arch__intr_simd_reg_mask(void)
>> +{
>> +       return __arch__simd_reg_mask(PERF_SAMPLE_REGS_INTR);
>> +}
>> +
>> +uint64_t arch__user_simd_reg_mask(void)
>> +{
>> +       return __arch__simd_reg_mask(PERF_SAMPLE_REGS_USER);
>> +}
>> +
>> +uint64_t arch__intr_pred_reg_mask(void)
>> +{
>> +       return __arch__pred_reg_mask(PERF_SAMPLE_REGS_INTR);
>> +}
>> +
>> +uint64_t arch__user_pred_reg_mask(void)
>> +{
>> +       return __arch__pred_reg_mask(PERF_SAMPLE_REGS_USER);
>> +}
>> +
>> +static uint64_t arch__simd_reg_bitmap_qwords(int reg, u16 *qwords, bool intr)
>> +{
>> +       uint64_t mask = 0;
>> +
>> +       *qwords = 0;
>> +       if (reg < PERF_REG_X86_MAX_SIMD_REGS) {
>> +               if (intr) {
>> +                       *qwords = x86_intr_simd_qwords[reg];
>> +                       mask = x86_intr_simd_mask[reg];
>> +               } else {
>> +                       *qwords = x86_user_simd_qwords[reg];
>> +                       mask = x86_user_simd_mask[reg];
>> +               }
>> +       }
>> +
>> +       return mask;
>> +}
>> +
>> +static uint64_t arch__pred_reg_bitmap_qwords(int reg, u16 *qwords, bool intr)
>> +{
>> +       uint64_t mask = 0;
>> +
>> +       *qwords = 0;
>> +       if (reg < PERF_REG_X86_MAX_PRED_REGS) {
>> +               if (intr) {
>> +                       *qwords = x86_intr_pred_qwords[reg];
>> +                       mask = x86_intr_pred_mask[reg];
>> +               } else {
>> +                       *qwords = x86_user_pred_qwords[reg];
>> +                       mask = x86_user_pred_mask[reg];
>> +               }
>> +       }
>> +
>> +       return mask;
>> +}
>> +
>> +uint64_t arch__intr_simd_reg_bitmap_qwords(int reg, u16 *qwords)
>> +{
>> +       if (!x86_intr_simd_updated)
>> +               arch__intr_simd_reg_mask();
>> +       return arch__simd_reg_bitmap_qwords(reg, qwords, true);
>> +}
>> +
>> +uint64_t arch__user_simd_reg_bitmap_qwords(int reg, u16 *qwords)
>> +{
>> +       if (!x86_user_simd_updated)
>> +               arch__user_simd_reg_mask();
>> +       return arch__simd_reg_bitmap_qwords(reg, qwords, false);
>> +}
>> +
>> +uint64_t arch__intr_pred_reg_bitmap_qwords(int reg, u16 *qwords)
>> +{
>> +       if (!x86_intr_pred_updated)
>> +               arch__intr_pred_reg_mask();
>> +       return arch__pred_reg_bitmap_qwords(reg, qwords, true);
>> +}
>> +
>> +uint64_t arch__user_pred_reg_bitmap_qwords(int reg, u16 *qwords)
>> +{
>> +       if (!x86_user_pred_updated)
>> +               arch__user_pred_reg_mask();
>> +       return arch__pred_reg_bitmap_qwords(reg, qwords, false);
>> +}
>> +
>>  const struct sample_reg *arch__sample_reg_masks(void)
>>  {
>> +       if (has_cap_simd_regs())
>> +               return sample_reg_masks_ext;
>>         return sample_reg_masks;
>>  }
>>
>> -uint64_t arch__intr_reg_mask(void)
>> +static uint64_t __arch__reg_mask(u64 sample_type, u64 mask, bool has_simd_regs)
>>  {
>>         struct perf_event_attr attr = {
>> -               .type                   = PERF_TYPE_HARDWARE,
>> -               .config                 = PERF_COUNT_HW_CPU_CYCLES,
>> -               .sample_type            = PERF_SAMPLE_REGS_INTR,
>> -               .sample_regs_intr       = PERF_REG_EXTENDED_MASK,
>> -               .precise_ip             = 1,
>> -               .disabled               = 1,
>> -               .exclude_kernel         = 1,
>> +               .type                           = PERF_TYPE_HARDWARE,
>> +               .config                         = PERF_COUNT_HW_CPU_CYCLES,
>> +               .sample_type                    = sample_type,
>> +               .precise_ip                     = 1,
>> +               .disabled                       = 1,
>> +               .exclude_kernel                 = 1,
>> +               .sample_simd_regs_enabled       = has_simd_regs,
>>         };
>>         int fd;
>>         /*
>>          * In an unnamed union, init it here to build on older gcc versions
>>          */
>>         attr.sample_period = 1;
>> +       if (sample_type == PERF_SAMPLE_REGS_INTR)
>> +               attr.sample_regs_intr = mask;
>> +       else
>> +               attr.sample_regs_user = mask;
>>
>>         if (perf_pmus__num_core_pmus() > 1) {
>>                 struct perf_pmu *pmu = NULL;
>> @@ -318,13 +738,41 @@ uint64_t arch__intr_reg_mask(void)
>>         fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
>>         if (fd != -1) {
>>                 close(fd);
>> -               return (PERF_REG_EXTENDED_MASK | PERF_REGS_MASK);
>> +               return mask;
>>         }
>>
>> -       return PERF_REGS_MASK;
>> +       return 0;
>> +}
>> +
>> +uint64_t arch__intr_reg_mask(void)
>> +{
>> +       uint64_t mask = PERF_REGS_MASK;
>> +
>> +       if (has_cap_simd_regs()) {
>> +               mask |= __arch__reg_mask(PERF_SAMPLE_REGS_INTR,
>> +                                        GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R16),
>> +                                        true);
> It's nice to label constant arguments like this something like:
> /*has_simd_regs=*/true);
>
> Tools like clang-tidy even try to enforce the argument names match the comments.

Sure.


>
>> +               mask |= __arch__reg_mask(PERF_SAMPLE_REGS_INTR,
>> +                                        BIT_ULL(PERF_REG_X86_SSP),
>> +                                        true);
>> +       } else
>> +               mask |= __arch__reg_mask(PERF_SAMPLE_REGS_INTR, PERF_REG_EXTENDED_MASK, false);
>> +
>> +       return mask;
>>  }
>>
>>  uint64_t arch__user_reg_mask(void)
>>  {
>> -       return PERF_REGS_MASK;
>> +       uint64_t mask = PERF_REGS_MASK;
>> +
>> +       if (has_cap_simd_regs()) {
>> +               mask |= __arch__reg_mask(PERF_SAMPLE_REGS_USER,
>> +                                        GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R16),
>> +                                        true);
>> +               mask |= __arch__reg_mask(PERF_SAMPLE_REGS_USER,
>> +                                        BIT_ULL(PERF_REG_X86_SSP),
>> +                                        true);
>> +       }
>> +
>> +       return mask;
> The code is repetitive here, could we refactor into a single function
> passing in a user or instr value?

Sure. Would extract the common part.


>
>>  }
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index 56ebefd075f2..5d1d90cf9488 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -1461,12 +1461,39 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
>>         if (opts->sample_intr_regs && !evsel->no_aux_samples &&
>>             !evsel__is_dummy_event(evsel)) {
>>                 attr->sample_regs_intr = opts->sample_intr_regs;
>> +               attr->sample_simd_regs_enabled = arch_has_simd_regs(attr->sample_regs_intr);
>> +               evsel__set_sample_bit(evsel, REGS_INTR);
>> +       }
>> +
>> +       if ((opts->sample_intr_vec_regs || opts->sample_intr_pred_regs) &&
>> +           !evsel->no_aux_samples && !evsel__is_dummy_event(evsel)) {
>> +               /* The pred qwords is to implies the set of SIMD registers is used */
>> +               if (opts->sample_pred_regs_qwords)
>> +                       attr->sample_simd_pred_reg_qwords = opts->sample_pred_regs_qwords;
>> +               else
>> +                       attr->sample_simd_pred_reg_qwords = 1;
>> +               attr->sample_simd_vec_reg_intr = opts->sample_intr_vec_regs;
>> +               attr->sample_simd_vec_reg_qwords = opts->sample_vec_regs_qwords;
>> +               attr->sample_simd_pred_reg_intr = opts->sample_intr_pred_regs;
>>                 evsel__set_sample_bit(evsel, REGS_INTR);
>>         }
>>
>>         if (opts->sample_user_regs && !evsel->no_aux_samples &&
>>             !evsel__is_dummy_event(evsel)) {
>>                 attr->sample_regs_user |= opts->sample_user_regs;
>> +               attr->sample_simd_regs_enabled = arch_has_simd_regs(attr->sample_regs_user);
>> +               evsel__set_sample_bit(evsel, REGS_USER);
>> +       }
>> +
>> +       if ((opts->sample_user_vec_regs || opts->sample_user_pred_regs) &&
>> +           !evsel->no_aux_samples && !evsel__is_dummy_event(evsel)) {
>> +               if (opts->sample_pred_regs_qwords)
>> +                       attr->sample_simd_pred_reg_qwords = opts->sample_pred_regs_qwords;
>> +               else
>> +                       attr->sample_simd_pred_reg_qwords = 1;
>> +               attr->sample_simd_vec_reg_user = opts->sample_user_vec_regs;
>> +               attr->sample_simd_vec_reg_qwords = opts->sample_vec_regs_qwords;
>> +               attr->sample_simd_pred_reg_user = opts->sample_user_pred_regs;
>>                 evsel__set_sample_bit(evsel, REGS_USER);
>>         }
>>
>> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
>> index cda1c620968e..0bd100392889 100644
>> --- a/tools/perf/util/parse-regs-options.c
>> +++ b/tools/perf/util/parse-regs-options.c
>> @@ -4,19 +4,139 @@
>>  #include <stdint.h>
>>  #include <string.h>
>>  #include <stdio.h>
>> +#include <linux/bitops.h>
>>  #include "util/debug.h"
>>  #include <subcmd/parse-options.h>
>>  #include "util/perf_regs.h"
>>  #include "util/parse-regs-options.h"
>> +#include "record.h"
>> +
>> +static void __print_simd_regs(bool intr, uint64_t simd_mask)
>> +{
>> +       const struct sample_reg *r = NULL;
>> +       uint64_t bitmap = 0;
>> +       u16 qwords = 0;
>> +       int reg_idx;
>> +
>> +       if (!simd_mask)
>> +               return;
>> +
>> +       for (r = arch__sample_simd_reg_masks(); r->name; r++) {
>> +               if (!(r->mask & simd_mask))
>> +                       continue;
>> +               reg_idx = fls64(r->mask) - 1;
>> +               if (intr)
>> +                       bitmap = arch__intr_simd_reg_bitmap_qwords(reg_idx, &qwords);
>> +               else
>> +                       bitmap = arch__user_simd_reg_bitmap_qwords(reg_idx, &qwords);
>> +               if (bitmap)
>> +                       fprintf(stderr, "%s0-%d ", r->name, fls64(bitmap) - 1);
>> +       }
>> +}
>> +
>> +static void __print_pred_regs(bool intr, uint64_t pred_mask)
>> +{
>> +       const struct sample_reg *r = NULL;
>> +       uint64_t bitmap = 0;
>> +       u16 qwords = 0;
>> +       int reg_idx;
>> +
>> +       if (!pred_mask)
>> +               return;
>> +
>> +       for (r = arch__sample_pred_reg_masks(); r->name; r++) {
>> +               if (!(r->mask & pred_mask))
>> +                       continue;
>> +               reg_idx = fls64(r->mask) - 1;
>> +               if (intr)
>> +                       bitmap = arch__intr_pred_reg_bitmap_qwords(reg_idx, &qwords);
>> +               else
>> +                       bitmap = arch__user_pred_reg_bitmap_qwords(reg_idx, &qwords);
>> +               if (bitmap)
>> +                       fprintf(stderr, "%s0-%d ", r->name, fls64(bitmap) - 1);
>> +       }
>> +}
>> +
>> +static bool __parse_simd_regs(struct record_opts *opts, char *s, bool intr)
>> +{
>> +       const struct sample_reg *r = NULL;
>> +       bool matched = false;
>> +       uint64_t bitmap = 0;
>> +       u16 qwords = 0;
>> +       int reg_idx;
>> +
>> +       for (r = arch__sample_simd_reg_masks(); r->name; r++) {
>> +               if (strcasecmp(s, r->name))
>> +                       continue;
>> +               if (!fls64(r->mask))
>> +                       continue;
>> +               reg_idx = fls64(r->mask) - 1;
>> +               if (intr)
>> +                       bitmap = arch__intr_simd_reg_bitmap_qwords(reg_idx, &qwords);
>> +               else
>> +                       bitmap = arch__user_simd_reg_bitmap_qwords(reg_idx, &qwords);
>> +               matched = true;
>> +               break;
>> +       }
>> +
>> +       /* Just need the highest qwords */
> I'm not following here. Does the bitmap need to handle gaps?

Currently no. In theory, the kernel supports user space only samples a
subset of SIMD registers, e.g., 0xff or 0xf0f for XMM registers (HW
supports 16 XMM registers on XMM), but it's not supported to avoid
introducing too much complexity in perf tools. Moreover, I don't think end
users have such requirement. In most cases, users should only know which
kinds of SIMD registers their programs use but usually doesn't know and
care about which exact SIMD register is used.


>
>> +       if (qwords > opts->sample_vec_regs_qwords) {
>> +               opts->sample_vec_regs_qwords = qwords;
>> +               if (intr)
>> +                       opts->sample_intr_vec_regs = bitmap;
>> +               else
>> +                       opts->sample_user_vec_regs = bitmap;
>> +       }
>> +
>> +       return matched;
>> +}
>> +
>> +static bool __parse_pred_regs(struct record_opts *opts, char *s, bool intr)
>> +{
>> +       const struct sample_reg *r = NULL;
>> +       bool matched = false;
>> +       uint64_t bitmap = 0;
>> +       u16 qwords = 0;
>> +       int reg_idx;
>> +
>> +       for (r = arch__sample_pred_reg_masks(); r->name; r++) {
>> +               if (strcasecmp(s, r->name))
>> +                       continue;
>> +               if (!fls64(r->mask))
>> +                       continue;
>> +               reg_idx = fls64(r->mask) - 1;
>> +               if (intr)
>> +                       bitmap = arch__intr_pred_reg_bitmap_qwords(reg_idx, &qwords);
>> +               else
>> +                       bitmap = arch__user_pred_reg_bitmap_qwords(reg_idx, &qwords);
>> +               matched = true;
>> +               break;
>> +       }
>> +
>> +       /* Just need the highest qwords */
> Again repetitive, could we have a single function?

Yes, I suppose the for loop at least can be extracted as a common function.


>
>> +       if (qwords > opts->sample_pred_regs_qwords) {
>> +               opts->sample_pred_regs_qwords = qwords;
>> +               if (intr)
>> +                       opts->sample_intr_pred_regs = bitmap;
>> +               else
>> +                       opts->sample_user_pred_regs = bitmap;
>> +       }
>> +
>> +       return matched;
>> +}
>>
>>  static int
>>  __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>>  {
>>         uint64_t *mode = (uint64_t *)opt->value;
>>         const struct sample_reg *r = NULL;
>> +       struct record_opts *opts;
>>         char *s, *os = NULL, *p;
>> -       int ret = -1;
>> +       bool has_simd_regs = false;
>>         uint64_t mask;
>> +       uint64_t simd_mask;
>> +       uint64_t pred_mask;
>> +       int ret = -1;
>>
>>         if (unset)
>>                 return 0;
>> @@ -27,10 +147,17 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>>         if (*mode)
>>                 return -1;
>>
>> -       if (intr)
>> +       if (intr) {
>> +               opts = container_of(opt->value, struct record_opts, sample_intr_regs);
>>                 mask = arch__intr_reg_mask();
>> -       else
>> +               simd_mask = arch__intr_simd_reg_mask();
>> +               pred_mask = arch__intr_pred_reg_mask();
>> +       } else {
>> +               opts = container_of(opt->value, struct record_opts, sample_user_regs);
>>                 mask = arch__user_reg_mask();
>> +               simd_mask = arch__user_simd_reg_mask();
>> +               pred_mask = arch__user_pred_reg_mask();
>> +       }
>>
>>         /* str may be NULL in case no arg is passed to -I */
>>         if (str) {
>> @@ -50,10 +177,24 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>>                                         if (r->mask & mask)
>>                                                 fprintf(stderr, "%s ", r->name);
>>                                 }
>> +                               __print_simd_regs(intr, simd_mask);
>> +                               __print_pred_regs(intr, pred_mask);
>>                                 fputc('\n', stderr);
>>                                 /* just printing available regs */
>>                                 goto error;
>>                         }
>> +
>> +                       if (simd_mask) {
>> +                               has_simd_regs = __parse_simd_regs(opts, s, intr);
>> +                               if (has_simd_regs)
>> +                                       goto next;
>> +                       }
>> +                       if (pred_mask) {
>> +                               has_simd_regs = __parse_pred_regs(opts, s, intr);
>> +                               if (has_simd_regs)
>> +                                       goto next;
>> +                       }
>> +
>>                         for (r = arch__sample_reg_masks(); r->name; r++) {
>>                                 if ((r->mask & mask) && !strcasecmp(s, r->name))
>>                                         break;
>> @@ -65,7 +206,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>>                         }
>>
>>                         *mode |= r->mask;
>> -
>> +next:
>>                         if (!p)
>>                                 break;
>>
>> @@ -75,7 +216,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>>         ret = 0;
>>
>>         /* default to all possible regs */
>> -       if (*mode == 0)
>> +       if (*mode == 0 && !has_simd_regs)
>>                 *mode = mask;
>>  error:
>>         free(os);
>> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
>> index 66b666d9ce64..fb0366d050cf 100644
>> --- a/tools/perf/util/perf_event_attr_fprintf.c
>> +++ b/tools/perf/util/perf_event_attr_fprintf.c
>> @@ -360,6 +360,12 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
>>         PRINT_ATTRf(aux_start_paused, p_unsigned);
>>         PRINT_ATTRf(aux_pause, p_unsigned);
>>         PRINT_ATTRf(aux_resume, p_unsigned);
>> +       PRINT_ATTRf(sample_simd_pred_reg_qwords, p_unsigned);
>> +       PRINT_ATTRf(sample_simd_pred_reg_intr, p_hex);
>> +       PRINT_ATTRf(sample_simd_pred_reg_user, p_hex);
>> +       PRINT_ATTRf(sample_simd_vec_reg_qwords, p_unsigned);
>> +       PRINT_ATTRf(sample_simd_vec_reg_intr, p_hex);
>> +       PRINT_ATTRf(sample_simd_vec_reg_user, p_hex);
>>
>>         return ret;
>>  }
>> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
>> index 44b90bbf2d07..e8a9fabc92e6 100644
>> --- a/tools/perf/util/perf_regs.c
>> +++ b/tools/perf/util/perf_regs.c
>> @@ -11,6 +11,11 @@ int __weak arch_sdt_arg_parse_op(char *old_op __maybe_unused,
>>         return SDT_ARG_SKIP;
>>  }
>>
>> +bool __weak arch_has_simd_regs(u64 mask __maybe_unused)
>> +{
>> +       return false;
>> +}
>> +
>>  uint64_t __weak arch__intr_reg_mask(void)
>>  {
>>         return 0;
>> @@ -21,6 +26,50 @@ uint64_t __weak arch__user_reg_mask(void)
>>         return 0;
>>  }
>>
>> +uint64_t __weak arch__intr_simd_reg_mask(void)
>> +{
>> +       return 0;
>> +}
>> +
>> +uint64_t __weak arch__user_simd_reg_mask(void)
>> +{
>> +       return 0;
>> +}
>> +
>> +uint64_t __weak arch__intr_pred_reg_mask(void)
>> +{
>> +       return 0;
>> +}
>> +
>> +uint64_t __weak arch__user_pred_reg_mask(void)
>> +{
>> +       return 0;
>> +}
>> +
>> +uint64_t __weak arch__intr_simd_reg_bitmap_qwords(int reg  __maybe_unused, u16 *qwords)
>> +{
>> +       *qwords = 0;
>> +       return 0;
>> +}
>> +
>> +uint64_t __weak arch__user_simd_reg_bitmap_qwords(int reg __maybe_unused, u16 *qwords)
>> +{
>> +       *qwords = 0;
>> +       return 0;
>> +}
>> +
>> +uint64_t __weak arch__intr_pred_reg_bitmap_qwords(int reg  __maybe_unused, u16 *qwords)
>> +{
>> +       *qwords = 0;
>> +       return 0;
>> +}
>> +
>> +uint64_t __weak arch__user_pred_reg_bitmap_qwords(int reg __maybe_unused, u16 *qwords)
>> +{
>> +       *qwords = 0;
>> +       return 0;
>> +}
>> +
>>  static const struct sample_reg sample_reg_masks[] = {
>>         SMPL_REG_END
>>  };
>> @@ -30,6 +79,16 @@ const struct sample_reg * __weak arch__sample_reg_masks(void)
>>         return sample_reg_masks;
>>  }
>>
>> +const struct sample_reg * __weak arch__sample_simd_reg_masks(void)
>> +{
>> +       return sample_reg_masks;
>> +}
>> +
>> +const struct sample_reg * __weak arch__sample_pred_reg_masks(void)
>> +{
>> +       return sample_reg_masks;
>> +}
> Thinking out loud. I wonder if there is a way to hide the weak
> functions. It seems the support is tied to PMUs, particularly core
> PMUs, perhaps we can push things into pmu and arch pmu code. Then we
> ask the PMU to parse the register strings, set up the perf_event_attr,
> etc. I'm somewhat scared these functions will be used on the report
> rather than record side of things, thereby breaking perf.data support
> when the host kernel does or doesn't have the SIMD support.

Ian, I don't quite follow your words.

I don't quite understand how should we do for "push things into pmu and
arch pmu code". Current SIMD registers support follows the same way of the
general registers support. If we intend to change the way entirely, we'd
better have an independent patch-set.

why these functions would break the perf.data repport? perf-report would
check if the PERF_SAMPLE_REGS_ABI_SIMD flag is set for each record, only
the flags is set (indicates there are SIMD registers data appended in the
record), perf-report would try to parse the SIMD registers data.


>
> Thanks,
> Ian
>
>> +
>>  const char *perf_reg_name(int id, const char *arch)
>>  {
>>         const char *reg_name = NULL;
>> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
>> index f2d0736d65cc..bce9c4cfd1bf 100644
>> --- a/tools/perf/util/perf_regs.h
>> +++ b/tools/perf/util/perf_regs.h
>> @@ -24,9 +24,20 @@ enum {
>>  };
>>
>>  int arch_sdt_arg_parse_op(char *old_op, char **new_op);
>> +bool arch_has_simd_regs(u64 mask);
>>  uint64_t arch__intr_reg_mask(void);
>>  uint64_t arch__user_reg_mask(void);
>>  const struct sample_reg *arch__sample_reg_masks(void);
>> +const struct sample_reg *arch__sample_simd_reg_masks(void);
>> +const struct sample_reg *arch__sample_pred_reg_masks(void);
>> +uint64_t arch__intr_simd_reg_mask(void);
>> +uint64_t arch__user_simd_reg_mask(void);
>> +uint64_t arch__intr_pred_reg_mask(void);
>> +uint64_t arch__user_pred_reg_mask(void);
>> +uint64_t arch__intr_simd_reg_bitmap_qwords(int reg, u16 *qwords);
>> +uint64_t arch__user_simd_reg_bitmap_qwords(int reg, u16 *qwords);
>> +uint64_t arch__intr_pred_reg_bitmap_qwords(int reg, u16 *qwords);
>> +uint64_t arch__user_pred_reg_bitmap_qwords(int reg, u16 *qwords);
>>
>>  const char *perf_reg_name(int id, const char *arch);
>>  int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
>> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
>> index ea3a6c4657ee..825ffb4cc53f 100644
>> --- a/tools/perf/util/record.h
>> +++ b/tools/perf/util/record.h
>> @@ -59,7 +59,13 @@ struct record_opts {
>>         unsigned int  user_freq;
>>         u64           branch_stack;
>>         u64           sample_intr_regs;
>> +       u64           sample_intr_vec_regs;
>>         u64           sample_user_regs;
>> +       u64           sample_user_vec_regs;
>> +       u16           sample_pred_regs_qwords;
>> +       u16           sample_vec_regs_qwords;
>> +       u16           sample_intr_pred_regs;
>> +       u16           sample_user_pred_regs;
>>         u64           default_interval;
>>         u64           user_interval;
>>         size_t        auxtrace_snapshot_size;
>> --
>> 2.34.1
>>
