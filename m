Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7581D5CEA;
	Thu, 22 Jan 2026 02:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769047557; cv=none; b=mfxH6KNADTAkGrgVXAkkzw3+n669rsqobQ21Xs+Wwzqe1fv50A5VxnBJg5t2/kmn7yJHfQqI5vKcr9EJ9xpozEhvgtVdUhPE0I2fygBzcyDo2wQr+YHoVDmKMbn5StuLt7gyNIzK/Nj1nUj1M1PG0Yb+iZHNMRsUiuq64Mm7Tzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769047557; c=relaxed/simple;
	bh=Z5B5wh//Qt82C/gDTTGyeFpKCNKDQxO0GBvNPK37V/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lSQJxoGcui0UgNpL9kCiNSWp9lbehFIt9Zjm2XpzrLcYZDbUasDYS588ZBm/J0Vtut14orCMmvGEc/7xl0JTZ1kVb/FlIlgDPNcMi2BF8kUv5wFap5o5nfNdNcaU+VsZbM/E8I874GytYOsRDtY33PvK21RopBf/5jH2pj8V+0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UMMtPOKH; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UMMtPOKH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769047554; x=1800583554;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z5B5wh//Qt82C/gDTTGyeFpKCNKDQxO0GBvNPK37V/A=;
  b=UMMtPOKHt4kGlMR+HWrzCWa8ARI2idFkQ/gyrAU/T/NZqjBG/KOSXzrB
   v8lPMxzLRIGpb4mZtBuxFvbsB6malsWZP5mcyr+owCeJuPuQj7UQbSLI0
   LWB0kMbipTp+0xRxL8Nuyn/nzcxzoRPNw4HURPmqrkFD1BEhtFuA+o0pC
   VcavrJV9B++bTo8IbtQFwadEJ9ASwLAHfbl2gZPKttv+YJKXo/2tYCOor
   hUER0cAUHWJ9Zt/g7OjM0cqWd67C7le0sxco0vbKc+XxREz+PHaGY7nVU
   Rc1jGRRPTGjLbgs/s4PBvHiIfP2y6EIX5WyKwQQ8t9Iul4H/BQx3p8NWf
   g==;
X-CSE-ConnectionGUID: sxH3azNpSKiK5cZnrrLSSg==
X-CSE-MsgGUID: GCeWrtqTQpyYXlOOiKNL3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="87699324"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="87699324"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 18:05:53 -0800
X-CSE-ConnectionGUID: nc8BKj1qQESfmr2ZlalFVA==
X-CSE-MsgGUID: 2VjWfv2qTjmYLOW/Xg0vYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="229579471"
Received: from unknown (HELO [10.238.3.254]) ([10.238.3.254])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 18:05:46 -0800
Message-ID: <e600bf85-c4f0-42fa-95fd-33000830f28d@linux.intel.com>
Date: Thu, 22 Jan 2026 10:05:43 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf regs: Refactor use of arch__sample_reg_masks to
 perf_reg_name
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 Guo Ren <guoren@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Shimin Guo <shimin.guo@skydio.com>,
 Athira Rajeev <atrajeev@linux.ibm.com>,
 Stephen Brennan <stephen.s.brennan@oracle.com>,
 Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>,
 Andi Kleen <ak@linux.intel.com>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, Dmitry Vyukov <dvyukov@google.com>,
 =?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
 Chun-Tse Shao <ctshao@google.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>,
 Haibo Xu <haibo1.xu@intel.com>, Sergei Trofimovich <slyich@gmail.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20260121021735.3625244-1-irogers@google.com>
 <56bb6d4d-ad9e-485f-af15-e0f6fbc261c1@linux.intel.com>
 <CAP-5=fWS+1412_ZOca3QfbjLzsZRbrYoLh9zGHDx5G_ZpTdg6Q@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fWS+1412_ZOca3QfbjLzsZRbrYoLh9zGHDx5G_ZpTdg6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/21/2026 10:38 PM, Ian Rogers wrote:
> On Wed, Jan 21, 2026 at 12:28 AM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>
>> On 1/21/2026 10:17 AM, Ian Rogers wrote:
>>> arch__sample_reg_masks isn't supported on ARM(32), csky, loongarch,
>>> MIPS, RISC-V and s390. The table returned by the function just has the
>>> name of a register paired with the corresponding sample_regs_user mask
>>> value. For a given perf register we can compute the name with
>>> perf_reg_name and the mask is just 1 left-shifted by the perf register
>>> number. Change __parse_regs to use this method for finding registers
>>> rather than arch__sample_reg_masks, thereby adding __parse_regs
>>> support for ARM(32), csky, loongarch, MIPS, RISC-V and s390. As
>>> arch__sample_reg_masks is then unused, remove the now unneeded
>>> declarations.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>> v2: Correct the setting of reg mask for registers that need >1 bit set
>>>     like XMMs.
>>>
>>> The idea for this patch came up in conversation with Dapeng Mi to
>>> avoid additional functions and tables for x86 APX support:
>>> https://lore.kernel.org/lkml/CAP-5=fWOsvAXuu8qx0tk9q8j8BoXPMJB3Gxto+iu6wf06i4cVA@mail.gmail.com/
>>>
>>> The patch is on top of the dwfl clean up patches that switch perf
>>> register functions to using e_machine as an argument rather than the
>>> arch string, this means that EM_HOST can be used with perf_reg_name:
>>> https://lore.kernel.org/lkml/20260117052849.2205545-1-irogers@google.com/
>>> ---
>>>  tools/perf/arch/arm/util/perf_regs.c          |   9 --
>>>  tools/perf/arch/arm64/util/machine.c          |  14 +--
>>>  tools/perf/arch/arm64/util/perf_regs.c        |  45 +------
>>>  tools/perf/arch/csky/util/perf_regs.c         |   9 --
>>>  tools/perf/arch/loongarch/util/perf_regs.c    |   9 --
>>>  tools/perf/arch/mips/util/perf_regs.c         |   9 --
>>>  tools/perf/arch/powerpc/util/perf_regs.c      |  68 ----------
>>>  tools/perf/arch/riscv/util/perf_regs.c        |   9 --
>>>  tools/perf/arch/s390/util/perf_regs.c         |   9 --
>>>  tools/perf/arch/x86/util/perf_regs.c          |  47 -------
>>>  .../util/arm64-frame-pointer-unwind-support.c |   3 +-
>>>  tools/perf/util/parse-regs-options.c          | 116 +++++++++++-------
>>>  tools/perf/util/perf_regs.c                   |   9 --
>>>  tools/perf/util/perf_regs.h                   |  12 --
>>>  14 files changed, 81 insertions(+), 287 deletions(-)
>>>
>>> diff --git a/tools/perf/arch/arm/util/perf_regs.c b/tools/perf/arch/arm/util/perf_regs.c
>>> index f94a0210c7b7..03a5bc0cf64c 100644
>>> --- a/tools/perf/arch/arm/util/perf_regs.c
>>> +++ b/tools/perf/arch/arm/util/perf_regs.c
>>> @@ -2,10 +2,6 @@
>>>  #include "perf_regs.h"
>>>  #include "../../../util/perf_regs.h"
>>>
>>> -static const struct sample_reg sample_reg_masks[] = {
>>> -     SMPL_REG_END
>>> -};
>>> -
>>>  uint64_t arch__intr_reg_mask(void)
>>>  {
>>>       return PERF_REGS_MASK;
>>> @@ -15,8 +11,3 @@ uint64_t arch__user_reg_mask(void)
>>>  {
>>>       return PERF_REGS_MASK;
>>>  }
>>> -
>>> -const struct sample_reg *arch__sample_reg_masks(void)
>>> -{
>>> -     return sample_reg_masks;
>>> -}
>>> diff --git a/tools/perf/arch/arm64/util/machine.c b/tools/perf/arch/arm64/util/machine.c
>>> index aab1cc2bc283..80fb13c958d9 100644
>>> --- a/tools/perf/arch/arm64/util/machine.c
>>> +++ b/tools/perf/arch/arm64/util/machine.c
>>> @@ -1,18 +1,12 @@
>>>  // SPDX-License-Identifier: GPL-2.0
>>>
>>> -#include <inttypes.h>
>>> -#include <stdio.h>
>>> -#include <string.h>
>>> -#include "debug.h"
>>> -#include "symbol.h"
>>> -#include "callchain.h"
>>> +#include "callchain.h" // prototype of arch__add_leaf_frame_record_opts
>>>  #include "perf_regs.h"
>>>  #include "record.h"
>>> -#include "util/perf_regs.h"
>>> +
>>> +#define SMPL_REG_MASK(b) (1ULL << (b))
>>>
>>>  void arch__add_leaf_frame_record_opts(struct record_opts *opts)
>>>  {
>>> -     const struct sample_reg *sample_reg_masks = arch__sample_reg_masks();
>>> -
>>> -     opts->sample_user_regs |= sample_reg_masks[PERF_REG_ARM64_LR].mask;
>>> +     opts->sample_user_regs |= SMPL_REG_MASK(PERF_REG_ARM64_LR);
>>>  }
>>> diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm64/util/perf_regs.c
>>> index 09308665e28a..9bb768e1bea1 100644
>>> --- a/tools/perf/arch/arm64/util/perf_regs.c
>>> +++ b/tools/perf/arch/arm64/util/perf_regs.c
>>> @@ -12,48 +12,12 @@
>>>  #include "../../../util/event.h"
>>>  #include "../../../util/perf_regs.h"
>>>
>>> +#define SMPL_REG_MASK(b) (1ULL << (b))
>>> +
>>>  #ifndef HWCAP_SVE
>>>  #define HWCAP_SVE    (1 << 22)
>>>  #endif
>>>
>>> -static const struct sample_reg sample_reg_masks[] = {
>>> -     SMPL_REG(x0, PERF_REG_ARM64_X0),
>>> -     SMPL_REG(x1, PERF_REG_ARM64_X1),
>>> -     SMPL_REG(x2, PERF_REG_ARM64_X2),
>>> -     SMPL_REG(x3, PERF_REG_ARM64_X3),
>>> -     SMPL_REG(x4, PERF_REG_ARM64_X4),
>>> -     SMPL_REG(x5, PERF_REG_ARM64_X5),
>>> -     SMPL_REG(x6, PERF_REG_ARM64_X6),
>>> -     SMPL_REG(x7, PERF_REG_ARM64_X7),
>>> -     SMPL_REG(x8, PERF_REG_ARM64_X8),
>>> -     SMPL_REG(x9, PERF_REG_ARM64_X9),
>>> -     SMPL_REG(x10, PERF_REG_ARM64_X10),
>>> -     SMPL_REG(x11, PERF_REG_ARM64_X11),
>>> -     SMPL_REG(x12, PERF_REG_ARM64_X12),
>>> -     SMPL_REG(x13, PERF_REG_ARM64_X13),
>>> -     SMPL_REG(x14, PERF_REG_ARM64_X14),
>>> -     SMPL_REG(x15, PERF_REG_ARM64_X15),
>>> -     SMPL_REG(x16, PERF_REG_ARM64_X16),
>>> -     SMPL_REG(x17, PERF_REG_ARM64_X17),
>>> -     SMPL_REG(x18, PERF_REG_ARM64_X18),
>>> -     SMPL_REG(x19, PERF_REG_ARM64_X19),
>>> -     SMPL_REG(x20, PERF_REG_ARM64_X20),
>>> -     SMPL_REG(x21, PERF_REG_ARM64_X21),
>>> -     SMPL_REG(x22, PERF_REG_ARM64_X22),
>>> -     SMPL_REG(x23, PERF_REG_ARM64_X23),
>>> -     SMPL_REG(x24, PERF_REG_ARM64_X24),
>>> -     SMPL_REG(x25, PERF_REG_ARM64_X25),
>>> -     SMPL_REG(x26, PERF_REG_ARM64_X26),
>>> -     SMPL_REG(x27, PERF_REG_ARM64_X27),
>>> -     SMPL_REG(x28, PERF_REG_ARM64_X28),
>>> -     SMPL_REG(x29, PERF_REG_ARM64_X29),
>>> -     SMPL_REG(lr, PERF_REG_ARM64_LR),
>>> -     SMPL_REG(sp, PERF_REG_ARM64_SP),
>>> -     SMPL_REG(pc, PERF_REG_ARM64_PC),
>>> -     SMPL_REG(vg, PERF_REG_ARM64_VG),
>>> -     SMPL_REG_END
>>> -};
>>> -
>>>  /* %xNUM */
>>>  #define SDT_OP_REGEX1  "^(x[1-2]?[0-9]|3[0-1])$"
>>>
>>> @@ -175,8 +139,3 @@ uint64_t arch__user_reg_mask(void)
>>>       }
>>>       return PERF_REGS_MASK;
>>>  }
>>> -
>>> -const struct sample_reg *arch__sample_reg_masks(void)
>>> -{
>>> -     return sample_reg_masks;
>>> -}
>>> diff --git a/tools/perf/arch/csky/util/perf_regs.c b/tools/perf/arch/csky/util/perf_regs.c
>>> index 6b1665f41180..2cf7a54106e0 100644
>>> --- a/tools/perf/arch/csky/util/perf_regs.c
>>> +++ b/tools/perf/arch/csky/util/perf_regs.c
>>> @@ -2,10 +2,6 @@
>>>  #include "perf_regs.h"
>>>  #include "../../util/perf_regs.h"
>>>
>>> -static const struct sample_reg sample_reg_masks[] = {
>>> -     SMPL_REG_END
>>> -};
>>> -
>>>  uint64_t arch__intr_reg_mask(void)
>>>  {
>>>       return PERF_REGS_MASK;
>>> @@ -15,8 +11,3 @@ uint64_t arch__user_reg_mask(void)
>>>  {
>>>       return PERF_REGS_MASK;
>>>  }
>>> -
>>> -const struct sample_reg *arch__sample_reg_masks(void)
>>> -{
>>> -     return sample_reg_masks;
>>> -}
>>> diff --git a/tools/perf/arch/loongarch/util/perf_regs.c b/tools/perf/arch/loongarch/util/perf_regs.c
>>> index f94a0210c7b7..03a5bc0cf64c 100644
>>> --- a/tools/perf/arch/loongarch/util/perf_regs.c
>>> +++ b/tools/perf/arch/loongarch/util/perf_regs.c
>>> @@ -2,10 +2,6 @@
>>>  #include "perf_regs.h"
>>>  #include "../../../util/perf_regs.h"
>>>
>>> -static const struct sample_reg sample_reg_masks[] = {
>>> -     SMPL_REG_END
>>> -};
>>> -
>>>  uint64_t arch__intr_reg_mask(void)
>>>  {
>>>       return PERF_REGS_MASK;
>>> @@ -15,8 +11,3 @@ uint64_t arch__user_reg_mask(void)
>>>  {
>>>       return PERF_REGS_MASK;
>>>  }
>>> -
>>> -const struct sample_reg *arch__sample_reg_masks(void)
>>> -{
>>> -     return sample_reg_masks;
>>> -}
>>> diff --git a/tools/perf/arch/mips/util/perf_regs.c b/tools/perf/arch/mips/util/perf_regs.c
>>> index 6b1665f41180..2cf7a54106e0 100644
>>> --- a/tools/perf/arch/mips/util/perf_regs.c
>>> +++ b/tools/perf/arch/mips/util/perf_regs.c
>>> @@ -2,10 +2,6 @@
>>>  #include "perf_regs.h"
>>>  #include "../../util/perf_regs.h"
>>>
>>> -static const struct sample_reg sample_reg_masks[] = {
>>> -     SMPL_REG_END
>>> -};
>>> -
>>>  uint64_t arch__intr_reg_mask(void)
>>>  {
>>>       return PERF_REGS_MASK;
>>> @@ -15,8 +11,3 @@ uint64_t arch__user_reg_mask(void)
>>>  {
>>>       return PERF_REGS_MASK;
>>>  }
>>> -
>>> -const struct sample_reg *arch__sample_reg_masks(void)
>>> -{
>>> -     return sample_reg_masks;
>>> -}
>>> diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
>>> index bd36cfd420a2..779073f7e992 100644
>>> --- a/tools/perf/arch/powerpc/util/perf_regs.c
>>> +++ b/tools/perf/arch/powerpc/util/perf_regs.c
>>> @@ -18,69 +18,6 @@
>>>  #define PVR_POWER10          0x0080
>>>  #define PVR_POWER11          0x0082
>>>
>>> -static const struct sample_reg sample_reg_masks[] = {
>>> -     SMPL_REG(r0, PERF_REG_POWERPC_R0),
>>> -     SMPL_REG(r1, PERF_REG_POWERPC_R1),
>>> -     SMPL_REG(r2, PERF_REG_POWERPC_R2),
>>> -     SMPL_REG(r3, PERF_REG_POWERPC_R3),
>>> -     SMPL_REG(r4, PERF_REG_POWERPC_R4),
>>> -     SMPL_REG(r5, PERF_REG_POWERPC_R5),
>>> -     SMPL_REG(r6, PERF_REG_POWERPC_R6),
>>> -     SMPL_REG(r7, PERF_REG_POWERPC_R7),
>>> -     SMPL_REG(r8, PERF_REG_POWERPC_R8),
>>> -     SMPL_REG(r9, PERF_REG_POWERPC_R9),
>>> -     SMPL_REG(r10, PERF_REG_POWERPC_R10),
>>> -     SMPL_REG(r11, PERF_REG_POWERPC_R11),
>>> -     SMPL_REG(r12, PERF_REG_POWERPC_R12),
>>> -     SMPL_REG(r13, PERF_REG_POWERPC_R13),
>>> -     SMPL_REG(r14, PERF_REG_POWERPC_R14),
>>> -     SMPL_REG(r15, PERF_REG_POWERPC_R15),
>>> -     SMPL_REG(r16, PERF_REG_POWERPC_R16),
>>> -     SMPL_REG(r17, PERF_REG_POWERPC_R17),
>>> -     SMPL_REG(r18, PERF_REG_POWERPC_R18),
>>> -     SMPL_REG(r19, PERF_REG_POWERPC_R19),
>>> -     SMPL_REG(r20, PERF_REG_POWERPC_R20),
>>> -     SMPL_REG(r21, PERF_REG_POWERPC_R21),
>>> -     SMPL_REG(r22, PERF_REG_POWERPC_R22),
>>> -     SMPL_REG(r23, PERF_REG_POWERPC_R23),
>>> -     SMPL_REG(r24, PERF_REG_POWERPC_R24),
>>> -     SMPL_REG(r25, PERF_REG_POWERPC_R25),
>>> -     SMPL_REG(r26, PERF_REG_POWERPC_R26),
>>> -     SMPL_REG(r27, PERF_REG_POWERPC_R27),
>>> -     SMPL_REG(r28, PERF_REG_POWERPC_R28),
>>> -     SMPL_REG(r29, PERF_REG_POWERPC_R29),
>>> -     SMPL_REG(r30, PERF_REG_POWERPC_R30),
>>> -     SMPL_REG(r31, PERF_REG_POWERPC_R31),
>>> -     SMPL_REG(nip, PERF_REG_POWERPC_NIP),
>>> -     SMPL_REG(msr, PERF_REG_POWERPC_MSR),
>>> -     SMPL_REG(orig_r3, PERF_REG_POWERPC_ORIG_R3),
>>> -     SMPL_REG(ctr, PERF_REG_POWERPC_CTR),
>>> -     SMPL_REG(link, PERF_REG_POWERPC_LINK),
>>> -     SMPL_REG(xer, PERF_REG_POWERPC_XER),
>>> -     SMPL_REG(ccr, PERF_REG_POWERPC_CCR),
>>> -     SMPL_REG(softe, PERF_REG_POWERPC_SOFTE),
>>> -     SMPL_REG(trap, PERF_REG_POWERPC_TRAP),
>>> -     SMPL_REG(dar, PERF_REG_POWERPC_DAR),
>>> -     SMPL_REG(dsisr, PERF_REG_POWERPC_DSISR),
>>> -     SMPL_REG(sier, PERF_REG_POWERPC_SIER),
>>> -     SMPL_REG(mmcra, PERF_REG_POWERPC_MMCRA),
>>> -     SMPL_REG(mmcr0, PERF_REG_POWERPC_MMCR0),
>>> -     SMPL_REG(mmcr1, PERF_REG_POWERPC_MMCR1),
>>> -     SMPL_REG(mmcr2, PERF_REG_POWERPC_MMCR2),
>>> -     SMPL_REG(mmcr3, PERF_REG_POWERPC_MMCR3),
>>> -     SMPL_REG(sier2, PERF_REG_POWERPC_SIER2),
>>> -     SMPL_REG(sier3, PERF_REG_POWERPC_SIER3),
>>> -     SMPL_REG(pmc1, PERF_REG_POWERPC_PMC1),
>>> -     SMPL_REG(pmc2, PERF_REG_POWERPC_PMC2),
>>> -     SMPL_REG(pmc3, PERF_REG_POWERPC_PMC3),
>>> -     SMPL_REG(pmc4, PERF_REG_POWERPC_PMC4),
>>> -     SMPL_REG(pmc5, PERF_REG_POWERPC_PMC5),
>>> -     SMPL_REG(pmc6, PERF_REG_POWERPC_PMC6),
>>> -     SMPL_REG(sdar, PERF_REG_POWERPC_SDAR),
>>> -     SMPL_REG(siar, PERF_REG_POWERPC_SIAR),
>>> -     SMPL_REG_END
>>> -};
>>> -
>>>  /* REG or %rREG */
>>>  #define SDT_OP_REGEX1  "^(%r)?([1-2]?[0-9]|3[0-1])$"
>>>
>>> @@ -233,8 +170,3 @@ uint64_t arch__user_reg_mask(void)
>>>  {
>>>       return PERF_REGS_MASK;
>>>  }
>>> -
>>> -const struct sample_reg *arch__sample_reg_masks(void)
>>> -{
>>> -     return sample_reg_masks;
>>> -}
>>> diff --git a/tools/perf/arch/riscv/util/perf_regs.c b/tools/perf/arch/riscv/util/perf_regs.c
>>> index 6b1665f41180..2cf7a54106e0 100644
>>> --- a/tools/perf/arch/riscv/util/perf_regs.c
>>> +++ b/tools/perf/arch/riscv/util/perf_regs.c
>>> @@ -2,10 +2,6 @@
>>>  #include "perf_regs.h"
>>>  #include "../../util/perf_regs.h"
>>>
>>> -static const struct sample_reg sample_reg_masks[] = {
>>> -     SMPL_REG_END
>>> -};
>>> -
>>>  uint64_t arch__intr_reg_mask(void)
>>>  {
>>>       return PERF_REGS_MASK;
>>> @@ -15,8 +11,3 @@ uint64_t arch__user_reg_mask(void)
>>>  {
>>>       return PERF_REGS_MASK;
>>>  }
>>> -
>>> -const struct sample_reg *arch__sample_reg_masks(void)
>>> -{
>>> -     return sample_reg_masks;
>>> -}
>>> diff --git a/tools/perf/arch/s390/util/perf_regs.c b/tools/perf/arch/s390/util/perf_regs.c
>>> index 6b1665f41180..2cf7a54106e0 100644
>>> --- a/tools/perf/arch/s390/util/perf_regs.c
>>> +++ b/tools/perf/arch/s390/util/perf_regs.c
>>> @@ -2,10 +2,6 @@
>>>  #include "perf_regs.h"
>>>  #include "../../util/perf_regs.h"
>>>
>>> -static const struct sample_reg sample_reg_masks[] = {
>>> -     SMPL_REG_END
>>> -};
>>> -
>>>  uint64_t arch__intr_reg_mask(void)
>>>  {
>>>       return PERF_REGS_MASK;
>>> @@ -15,8 +11,3 @@ uint64_t arch__user_reg_mask(void)
>>>  {
>>>       return PERF_REGS_MASK;
>>>  }
>>> -
>>> -const struct sample_reg *arch__sample_reg_masks(void)
>>> -{
>>> -     return sample_reg_masks;
>>> -}
>>> diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
>>> index 12fd93f04802..a7ca4154fdf9 100644
>>> --- a/tools/perf/arch/x86/util/perf_regs.c
>>> +++ b/tools/perf/arch/x86/util/perf_regs.c
>>> @@ -13,48 +13,6 @@
>>>  #include "../../../util/pmu.h"
>>>  #include "../../../util/pmus.h"
>>>
>>> -static const struct sample_reg sample_reg_masks[] = {
>>> -     SMPL_REG(AX, PERF_REG_X86_AX),
>>> -     SMPL_REG(BX, PERF_REG_X86_BX),
>>> -     SMPL_REG(CX, PERF_REG_X86_CX),
>>> -     SMPL_REG(DX, PERF_REG_X86_DX),
>>> -     SMPL_REG(SI, PERF_REG_X86_SI),
>>> -     SMPL_REG(DI, PERF_REG_X86_DI),
>>> -     SMPL_REG(BP, PERF_REG_X86_BP),
>>> -     SMPL_REG(SP, PERF_REG_X86_SP),
>>> -     SMPL_REG(IP, PERF_REG_X86_IP),
>>> -     SMPL_REG(FLAGS, PERF_REG_X86_FLAGS),
>>> -     SMPL_REG(CS, PERF_REG_X86_CS),
>>> -     SMPL_REG(SS, PERF_REG_X86_SS),
>>> -#ifdef HAVE_ARCH_X86_64_SUPPORT
>>> -     SMPL_REG(R8, PERF_REG_X86_R8),
>>> -     SMPL_REG(R9, PERF_REG_X86_R9),
>>> -     SMPL_REG(R10, PERF_REG_X86_R10),
>>> -     SMPL_REG(R11, PERF_REG_X86_R11),
>>> -     SMPL_REG(R12, PERF_REG_X86_R12),
>>> -     SMPL_REG(R13, PERF_REG_X86_R13),
>>> -     SMPL_REG(R14, PERF_REG_X86_R14),
>>> -     SMPL_REG(R15, PERF_REG_X86_R15),
>>> -#endif
>>> -     SMPL_REG2(XMM0, PERF_REG_X86_XMM0),
>>> -     SMPL_REG2(XMM1, PERF_REG_X86_XMM1),
>>> -     SMPL_REG2(XMM2, PERF_REG_X86_XMM2),
>>> -     SMPL_REG2(XMM3, PERF_REG_X86_XMM3),
>>> -     SMPL_REG2(XMM4, PERF_REG_X86_XMM4),
>>> -     SMPL_REG2(XMM5, PERF_REG_X86_XMM5),
>>> -     SMPL_REG2(XMM6, PERF_REG_X86_XMM6),
>>> -     SMPL_REG2(XMM7, PERF_REG_X86_XMM7),
>>> -     SMPL_REG2(XMM8, PERF_REG_X86_XMM8),
>>> -     SMPL_REG2(XMM9, PERF_REG_X86_XMM9),
>>> -     SMPL_REG2(XMM10, PERF_REG_X86_XMM10),
>>> -     SMPL_REG2(XMM11, PERF_REG_X86_XMM11),
>>> -     SMPL_REG2(XMM12, PERF_REG_X86_XMM12),
>>> -     SMPL_REG2(XMM13, PERF_REG_X86_XMM13),
>>> -     SMPL_REG2(XMM14, PERF_REG_X86_XMM14),
>>> -     SMPL_REG2(XMM15, PERF_REG_X86_XMM15),
>>> -     SMPL_REG_END
>>> -};
>>> -
>>>  struct sdt_name_reg {
>>>       const char *sdt_name;
>>>       const char *uprobe_name;
>>> @@ -276,11 +234,6 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
>>>       return SDT_ARG_VALID;
>>>  }
>>>
>>> -const struct sample_reg *arch__sample_reg_masks(void)
>>> -{
>>> -     return sample_reg_masks;
>>> -}
>>> -
>>>  uint64_t arch__intr_reg_mask(void)
>>>  {
>>>       struct perf_event_attr attr = {
>>> diff --git a/tools/perf/util/arm64-frame-pointer-unwind-support.c b/tools/perf/util/arm64-frame-pointer-unwind-support.c
>>> index 958afe8b821e..858ce2b01812 100644
>>> --- a/tools/perf/util/arm64-frame-pointer-unwind-support.c
>>> +++ b/tools/perf/util/arm64-frame-pointer-unwind-support.c
>>> @@ -2,7 +2,6 @@
>>>  #include "arm64-frame-pointer-unwind-support.h"
>>>  #include "callchain.h"
>>>  #include "event.h"
>>> -#include "perf_regs.h" // SMPL_REG_MASK
>>>  #include "unwind.h"
>>>  #include <string.h>
>>>
>>> @@ -15,6 +14,8 @@ struct entries {
>>>       size_t length;
>>>  };
>>>
>>> +#define SMPL_REG_MASK(b) (1ULL << (b))
>>> +
>>>  static bool get_leaf_frame_caller_enabled(struct perf_sample *sample)
>>>  {
>>>       struct regs_dump *regs;
>>> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
>>> index cda1c620968e..c0d0ef9fd495 100644
>>> --- a/tools/perf/util/parse-regs-options.c
>>> +++ b/tools/perf/util/parse-regs-options.c
>>> @@ -5,15 +5,54 @@
>>>  #include <string.h>
>>>  #include <stdio.h>
>>>  #include "util/debug.h"
>>> +#include <dwarf-regs.h>
>>>  #include <subcmd/parse-options.h>
>>>  #include "util/perf_regs.h"
>>>  #include "util/parse-regs-options.h"
>>>
>>> +static void list_perf_regs(FILE *fp, uint64_t mask)
>>> +{
>>> +     const char *last_name = NULL;
>>> +
>>> +     fprintf(fp, "available registers: ");
>>> +     for (int reg = 0; reg < 64; reg++) {
>> Could we not use the magic number 64? It's not safe, the supported GP
>> register number could exceed 64 in the future, then the exceeded register
>> won't be iterated.
> How will such a register appear in sample_regs_user/sample_regs_intr?
> There's a requirement that perf registers be indices into the 64-bit
> mask.

In theory, if the GPRs exceeds 64, then sample_regs_user/sample_regs_intr
could become an u64 array. So if the user missed to modify the magic number
64, then there would be something wrong. IMO, the below change looks safer
and I personally doesn't like the magic number. :)


>
>> How about this?
>>
>> diff --git a/tools/perf/util/parse-regs-options.c
>> b/tools/perf/util/parse-regs-options.c
>> index c0d0ef9fd495..5177016a7ad4 100644
>> --- a/tools/perf/util/parse-regs-options.c
>> +++ b/tools/perf/util/parse-regs-options.c
>> @@ -15,7 +15,7 @@ static void list_perf_regs(FILE *fp, uint64_t mask)
>>         const char *last_name = NULL;
>>
>>         fprintf(fp, "available registers: ");
>> -       for (int reg = 0; reg < 64; reg++) {
>> +       for (unsigned long reg = 0; reg < sizeof(mask) * BITS_PER_BYTE;
>> reg++) {
>>                 const char *name;
>>
>>                 if (((1ULL << reg) & mask) == 0)
>>
>>
>>> +             const char *name;
>>> +
>>> +             if (((1ULL << reg) & mask) == 0)
>>> +                     continue;
>>> +
>>> +             name = perf_reg_name(reg, EM_HOST);
>>> +             if (name && (!last_name || strcmp(last_name, name)))
>>> +                     fprintf(fp, "%s%s", reg > 0 ? " " : "", name);
>>> +             last_name = name;
>>> +     }
>>> +     fputc('\n', fp);
>>> +}
>>> +
>>> +static uint64_t name_to_perf_reg_mask(const char *to_match, uint64_t mask)
>>> +{
>>> +     uint64_t reg_mask = 0;
>>> +
>>> +     for (int reg = 0; reg < 64; reg++) {
>> ditto.
>>
>>
>>> +             const char *name;
>>> +
>>> +             if (((1ULL << reg) & mask) == 0)
>>> +                     continue;
>>> +
>>> +             name = perf_reg_name(reg, EM_HOST);
>>> +             if (!name)
>>> +                     continue;
>>> +
>>> +             if (!strcasecmp(to_match, name))
>>> +                     reg_mask |= 1ULL << reg;
>> How much register names are expected to match here? It seems the function
>> expects to match only one register name. If so, we can "break" here.
> Registers like XMM0 double up so that they have two 64-bit slots in
> the sample data. You need to match the name multiple times so that all
> bits can be set in the mask.

Oh, yes. I missed XMM registers. Thanks.


>
> Thanks,
> Ian
>
>> Thanks.
>>
>>
>>> +     }
>>> +     return reg_mask;
>>> +}
>>> +
>>>  static int
>>>  __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>>>  {
>>>       uint64_t *mode = (uint64_t *)opt->value;
>>> -     const struct sample_reg *r = NULL;
>>>       char *s, *os = NULL, *p;
>>>       int ret = -1;
>>>       uint64_t mask;
>>> @@ -27,50 +66,41 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>>>       if (*mode)
>>>               return -1;
>>>
>>> -     if (intr)
>>> -             mask = arch__intr_reg_mask();
>>> -     else
>>> -             mask = arch__user_reg_mask();
>>> -
>>>       /* str may be NULL in case no arg is passed to -I */
>>> -     if (str) {
>>> -             /* because str is read-only */
>>> -             s = os = strdup(str);
>>> -             if (!s)
>>> -                     return -1;
>>> -
>>> -             for (;;) {
>>> -                     p = strchr(s, ',');
>>> -                     if (p)
>>> -                             *p = '\0';
>>> -
>>> -                     if (!strcmp(s, "?")) {
>>> -                             fprintf(stderr, "available registers: ");
>>> -                             for (r = arch__sample_reg_masks(); r->name; r++) {
>>> -                                     if (r->mask & mask)
>>> -                                             fprintf(stderr, "%s ", r->name);
>>> -                             }
>>> -                             fputc('\n', stderr);
>>> -                             /* just printing available regs */
>>> -                             goto error;
>>> -                     }
>>> -                     for (r = arch__sample_reg_masks(); r->name; r++) {
>>> -                             if ((r->mask & mask) && !strcasecmp(s, r->name))
>>> -                                     break;
>>> -                     }
>>> -                     if (!r || !r->name) {
>>> -                             ui__warning("Unknown register \"%s\", check man page or run \"perf record %s?\"\n",
>>> -                                         s, intr ? "-I" : "--user-regs=");
>>> -                             goto error;
>>> -                     }
>>> -
>>> -                     *mode |= r->mask;
>>> -
>>> -                     if (!p)
>>> -                             break;
>>> -
>>> -                     s = p + 1;
>>> +     if (!str)
>>> +             return -1;
>>> +
>>> +     mask = intr ? arch__intr_reg_mask() : arch__user_reg_mask();
>>> +
>>> +     /* because str is read-only */
>>> +     s = os = strdup(str);
>>> +     if (!s)
>>> +             return -1;
>>> +
>>> +     for (;;) {
>>> +             uint64_t reg_mask;
>>> +
>>> +             p = strchr(s, ',');
>>> +             if (p)
>>> +                     *p = '\0';
>>> +
>>> +             if (!strcmp(s, "?")) {
>>> +                     list_perf_regs(stderr, mask);
>>> +                     goto error;
>>> +             }
>>> +
>>> +             reg_mask = name_to_perf_reg_mask(s, mask);
>>> +             if (reg_mask == 0) {
>>> +                     ui__warning("Unknown register \"%s\", check man page or run \"perf record %s?\"\n",
>>> +                             s, intr ? "-I" : "--user-regs=");
>>> +                     goto error;
>>>               }
>>> +             *mode |= reg_mask;
>>> +
>>> +             if (!p)
>>> +                     break;
>>> +
>>> +             s = p + 1;
>>>       }
>>>       ret = 0;
>>>
>>> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
>>> index b58d59b84fb1..ec602da1aeb6 100644
>>> --- a/tools/perf/util/perf_regs.c
>>> +++ b/tools/perf/util/perf_regs.c
>>> @@ -22,15 +22,6 @@ uint64_t __weak arch__user_reg_mask(void)
>>>       return 0;
>>>  }
>>>
>>> -static const struct sample_reg sample_reg_masks[] = {
>>> -     SMPL_REG_END
>>> -};
>>> -
>>> -const struct sample_reg * __weak arch__sample_reg_masks(void)
>>> -{
>>> -     return sample_reg_masks;
>>> -}
>>> -
>>>  const char *perf_reg_name(int id, uint16_t e_machine)
>>>  {
>>>       const char *reg_name = NULL;
>>> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
>>> index 7bfc6a34c02b..2c2a8de6912d 100644
>>> --- a/tools/perf/util/perf_regs.h
>>> +++ b/tools/perf/util/perf_regs.h
>>> @@ -7,17 +7,6 @@
>>>
>>>  struct regs_dump;
>>>
>>> -struct sample_reg {
>>> -     const char *name;
>>> -     uint64_t mask;
>>> -};
>>> -
>>> -#define SMPL_REG_MASK(b) (1ULL << (b))
>>> -#define SMPL_REG(n, b) { .name = #n, .mask = SMPL_REG_MASK(b) }
>>> -#define SMPL_REG2_MASK(b) (3ULL << (b))
>>> -#define SMPL_REG2(n, b) { .name = #n, .mask = SMPL_REG2_MASK(b) }
>>> -#define SMPL_REG_END { .name = NULL }
>>> -
>>>  enum {
>>>       SDT_ARG_VALID = 0,
>>>       SDT_ARG_SKIP,
>>> @@ -26,7 +15,6 @@ enum {
>>>  int arch_sdt_arg_parse_op(char *old_op, char **new_op);
>>>  uint64_t arch__intr_reg_mask(void);
>>>  uint64_t arch__user_reg_mask(void);
>>> -const struct sample_reg *arch__sample_reg_masks(void);
>>>
>>>  const char *perf_reg_name(int id, uint16_t e_machine);
>>>  int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
