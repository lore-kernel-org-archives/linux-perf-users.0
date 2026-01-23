Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC60E3EBF1F;
	Fri, 23 Jan 2026 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769157201; cv=none; b=KjyBVKtO1gOk4SjcBtOGGjTF+lK0cj10+NzQ+F/3dvys2Xw5Y+ssYTNlNNiJuxIj2HDBCUKEb/pn0y7mqjAFJrSNVDMxV8010FhptNcewxcuDuvUr7iqrnUwh15I0PUlvaoXeruUkqzsi4hVN3lhxkSpSk4GSu7gQaTuZOJcQko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769157201; c=relaxed/simple;
	bh=USnkpmyaiE6/FWvX5gWz9XFDgQIkN1d3Z/HWGcoDS7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lY1McJLybpSwqPa53TzbbOUzwSRsF/fnKmVLqvyNncBpyk8CgRu+28766MSw4muXe62f9oTyut1REv9i8E/WN9j9uBxPy5yGSaFxkajzH7FGiNhrxjKWlDG6Yh7ZeXutSx7/rMOe7SFMjPJsecnu5zddROu1fpzpBcGDW8o7Wko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YkB0+lPR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YkB0+lPR"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60N7DLFF005847;
	Fri, 23 Jan 2026 08:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QebB4W
	4NBY7wDDDzlK1z5Wh9zIymSigisJpG9EpgfiQ=; b=YkB0+lPR6J7MErSdljpbov
	dCY3rqisDwxIb/Kt8bVCUr0gF8otMytwHELV7M5tHCtDcBexXP3RlnI2EPevCbve
	IaZ21d/fMmQmMeAi8acm//SpcQ8tAN5n7TUotuJ9t6u8k2kOBtVQ5Kw/RcSN+WNX
	BCeC0jDTSSPs5QVoCUx54J4nOmI0UF/EGzmFGvDTO0PXTDdWP65Ti1YD3kL8hvOG
	zcunCa/6WRXw9s3qoKSoYs0N6bVBRTJ39rNJYV28lcQrv/6fy941A/69COE9vl61
	CtiC85Maa+wFNdOBxeOiBW4vWT9ZghUW5C9cIT38PT4W+vv0uAjLMyoioyFH+w6g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bus1pu6hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 08:32:50 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60N8Jg2P023180;
	Fri, 23 Jan 2026 08:32:49 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bus1pu6hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 08:32:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60N6IL7D016679;
	Fri, 23 Jan 2026 08:32:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4yg5j6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 08:32:45 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60N8WdVp62849440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 08:32:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 307952004D;
	Fri, 23 Jan 2026 08:32:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 815562004B;
	Fri, 23 Jan 2026 08:32:37 +0000 (GMT)
Received: from [9.111.48.241] (unknown [9.111.48.241])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Jan 2026 08:32:37 +0000 (GMT)
Message-ID: <238fa60c-4dd3-406f-8b33-69d2206936d2@linux.ibm.com>
Date: Fri, 23 Jan 2026 09:32:36 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf regs: Refactor use of arch__sample_reg_masks to
 perf_reg_name
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark
 <james.clark@linaro.org>,
        John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
        Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Shimin Guo <shimin.guo@skydio.com>,
        Athira Rajeev <atrajeev@linux.ibm.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Howard Chu <howardchu95@gmail.com>,
        Thomas Falcon <thomas.falcon@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr. David Alan Gilbert"
 <linux@treblig.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        =?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
        Chun-Tse Shao <ctshao@google.com>,
        Aditya Bodkhe <aditya.b1@linux.ibm.com>,
        Haibo Xu <haibo1.xu@intel.com>, Sergei Trofimovich <slyich@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <20260121021735.3625244-1-irogers@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20260121021735.3625244-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PHHFmj7RJAMj0y4omm3S0NygVmg3AlWy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA2NCBTYWx0ZWRfXwXinqsSxFeU6
 pGi4Ta6SrCXNSzwep7eJPtlyZTuOBHfd8w06tqmYlInW6P84ZIsqiIfiATNfFV/2bwXt5XIROP8
 6QO/TuxmRRcm/eF/vmS/sK7JbG0ZkYQXqdbDZoKGa+eBI5vNr4/XEOv+kQRVY/g7OUlLFl+Tw3g
 G8x4ODCDhr9kcsvyLSonTGFa/hiuUB7JhrHqSZp8D8mlwZo80adqneR7KSlIKiUl2P2Gfh3hHaW
 YzY83yGeIL46bIGhGNGLvW/b3mIl7kCX8LMTWs4bVLKscObbP1cmyFRVWbU9xGEpL7GMZUWmQ9x
 rfLQ0tbE0OVS6egFkacR4ntI4D8vUOqOnZS4QzbXo7Jfhn+kYSkyVRfb4NhfpF+ndGXAnoj/w7t
 TDBAhYzsV4zeYBrepKXQD0vTB6Mtb2JawCKTKrGMgExGK5plhOlYIgeDnVvLGgCLulzNSXDOW4s
 rAdUyAgHY2sZRF/Ir2g==
X-Proofpoint-GUID: sB5ikwkopOPbdoUp1Lm_UyhK6Y3Tdhek
X-Authority-Analysis: v=2.4 cv=GY8aXAXL c=1 sm=1 tr=0 ts=69733232 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=rdxWDl2YoaJ9roQkb14A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_01,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601230064

On 1/21/26 03:17, Ian Rogers wrote:
> arch__sample_reg_masks isn't supported on ARM(32), csky, loongarch,
> MIPS, RISC-V and s390. The table returned by the function just has the
> name of a register paired with the corresponding sample_regs_user mask
> value. For a given perf register we can compute the name with
> perf_reg_name and the mask is just 1 left-shifted by the perf register
> number. Change __parse_regs to use this method for finding registers
> rather than arch__sample_reg_masks, thereby adding __parse_regs
> support for ARM(32), csky, loongarch, MIPS, RISC-V and s390. As
> arch__sample_reg_masks is then unused, remove the now unneeded
> declarations.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v2: Correct the setting of reg mask for registers that need >1 bit set
>     like XMMs.
> 
> The idea for this patch came up in conversation with Dapeng Mi to
> avoid additional functions and tables for x86 APX support:
> https://lore.kernel.org/lkml/CAP-5=fWOsvAXuu8qx0tk9q8j8BoXPMJB3Gxto+iu6wf06i4cVA@mail.gmail.com/
> 
> The patch is on top of the dwfl clean up patches that switch perf
> register functions to using e_machine as an argument rather than the
> arch string, this means that EM_HOST can be used with perf_reg_name:
> https://lore.kernel.org/lkml/20260117052849.2205545-1-irogers@google.com/
> ---
>  tools/perf/arch/arm/util/perf_regs.c          |   9 --
>  tools/perf/arch/arm64/util/machine.c          |  14 +--
>  tools/perf/arch/arm64/util/perf_regs.c        |  45 +------
>  tools/perf/arch/csky/util/perf_regs.c         |   9 --
>  tools/perf/arch/loongarch/util/perf_regs.c    |   9 --
>  tools/perf/arch/mips/util/perf_regs.c         |   9 --
>  tools/perf/arch/powerpc/util/perf_regs.c      |  68 ----------
>  tools/perf/arch/riscv/util/perf_regs.c        |   9 --
>  tools/perf/arch/s390/util/perf_regs.c         |   9 --
>  tools/perf/arch/x86/util/perf_regs.c          |  47 -------
>  .../util/arm64-frame-pointer-unwind-support.c |   3 +-
>  tools/perf/util/parse-regs-options.c          | 116 +++++++++++-------
>  tools/perf/util/perf_regs.c                   |   9 --
>  tools/perf/util/perf_regs.h                   |  12 --
>  14 files changed, 81 insertions(+), 287 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/perf_regs.c b/tools/perf/arch/arm/util/perf_regs.c
> index f94a0210c7b7..03a5bc0cf64c 100644
> --- a/tools/perf/arch/arm/util/perf_regs.c
> +++ b/tools/perf/arch/arm/util/perf_regs.c
> @@ -2,10 +2,6 @@
>  #include "perf_regs.h"
>  #include "../../../util/perf_regs.h"
>  
> -static const struct sample_reg sample_reg_masks[] = {
> -	SMPL_REG_END
> -};
> -
>  uint64_t arch__intr_reg_mask(void)
>  {
>  	return PERF_REGS_MASK;
> @@ -15,8 +11,3 @@ uint64_t arch__user_reg_mask(void)
>  {
>  	return PERF_REGS_MASK;
>  }
> -
> -const struct sample_reg *arch__sample_reg_masks(void)
> -{
> -	return sample_reg_masks;
> -}
> diff --git a/tools/perf/arch/arm64/util/machine.c b/tools/perf/arch/arm64/util/machine.c
> index aab1cc2bc283..80fb13c958d9 100644
> --- a/tools/perf/arch/arm64/util/machine.c
> +++ b/tools/perf/arch/arm64/util/machine.c
> @@ -1,18 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> -#include <inttypes.h>
> -#include <stdio.h>
> -#include <string.h>
> -#include "debug.h"
> -#include "symbol.h"
> -#include "callchain.h"
> +#include "callchain.h" // prototype of arch__add_leaf_frame_record_opts
>  #include "perf_regs.h"
>  #include "record.h"
> -#include "util/perf_regs.h"
> +
> +#define SMPL_REG_MASK(b) (1ULL << (b))
>  
>  void arch__add_leaf_frame_record_opts(struct record_opts *opts)
>  {
> -	const struct sample_reg *sample_reg_masks = arch__sample_reg_masks();
> -
> -	opts->sample_user_regs |= sample_reg_masks[PERF_REG_ARM64_LR].mask;
> +	opts->sample_user_regs |= SMPL_REG_MASK(PERF_REG_ARM64_LR);
>  }
> diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm64/util/perf_regs.c
> index 09308665e28a..9bb768e1bea1 100644
> --- a/tools/perf/arch/arm64/util/perf_regs.c
> +++ b/tools/perf/arch/arm64/util/perf_regs.c
> @@ -12,48 +12,12 @@
>  #include "../../../util/event.h"
>  #include "../../../util/perf_regs.h"
>  
> +#define SMPL_REG_MASK(b) (1ULL << (b))
> +
>  #ifndef HWCAP_SVE
>  #define HWCAP_SVE	(1 << 22)
>  #endif
>  
> -static const struct sample_reg sample_reg_masks[] = {
> -	SMPL_REG(x0, PERF_REG_ARM64_X0),
> -	SMPL_REG(x1, PERF_REG_ARM64_X1),
> -	SMPL_REG(x2, PERF_REG_ARM64_X2),
> -	SMPL_REG(x3, PERF_REG_ARM64_X3),
> -	SMPL_REG(x4, PERF_REG_ARM64_X4),
> -	SMPL_REG(x5, PERF_REG_ARM64_X5),
> -	SMPL_REG(x6, PERF_REG_ARM64_X6),
> -	SMPL_REG(x7, PERF_REG_ARM64_X7),
> -	SMPL_REG(x8, PERF_REG_ARM64_X8),
> -	SMPL_REG(x9, PERF_REG_ARM64_X9),
> -	SMPL_REG(x10, PERF_REG_ARM64_X10),
> -	SMPL_REG(x11, PERF_REG_ARM64_X11),
> -	SMPL_REG(x12, PERF_REG_ARM64_X12),
> -	SMPL_REG(x13, PERF_REG_ARM64_X13),
> -	SMPL_REG(x14, PERF_REG_ARM64_X14),
> -	SMPL_REG(x15, PERF_REG_ARM64_X15),
> -	SMPL_REG(x16, PERF_REG_ARM64_X16),
> -	SMPL_REG(x17, PERF_REG_ARM64_X17),
> -	SMPL_REG(x18, PERF_REG_ARM64_X18),
> -	SMPL_REG(x19, PERF_REG_ARM64_X19),
> -	SMPL_REG(x20, PERF_REG_ARM64_X20),
> -	SMPL_REG(x21, PERF_REG_ARM64_X21),
> -	SMPL_REG(x22, PERF_REG_ARM64_X22),
> -	SMPL_REG(x23, PERF_REG_ARM64_X23),
> -	SMPL_REG(x24, PERF_REG_ARM64_X24),
> -	SMPL_REG(x25, PERF_REG_ARM64_X25),
> -	SMPL_REG(x26, PERF_REG_ARM64_X26),
> -	SMPL_REG(x27, PERF_REG_ARM64_X27),
> -	SMPL_REG(x28, PERF_REG_ARM64_X28),
> -	SMPL_REG(x29, PERF_REG_ARM64_X29),
> -	SMPL_REG(lr, PERF_REG_ARM64_LR),
> -	SMPL_REG(sp, PERF_REG_ARM64_SP),
> -	SMPL_REG(pc, PERF_REG_ARM64_PC),
> -	SMPL_REG(vg, PERF_REG_ARM64_VG),
> -	SMPL_REG_END
> -};
> -
>  /* %xNUM */
>  #define SDT_OP_REGEX1  "^(x[1-2]?[0-9]|3[0-1])$"
>  
> @@ -175,8 +139,3 @@ uint64_t arch__user_reg_mask(void)
>  	}
>  	return PERF_REGS_MASK;
>  }
> -
> -const struct sample_reg *arch__sample_reg_masks(void)
> -{
> -	return sample_reg_masks;
> -}
> diff --git a/tools/perf/arch/csky/util/perf_regs.c b/tools/perf/arch/csky/util/perf_regs.c
> index 6b1665f41180..2cf7a54106e0 100644
> --- a/tools/perf/arch/csky/util/perf_regs.c
> +++ b/tools/perf/arch/csky/util/perf_regs.c
> @@ -2,10 +2,6 @@
>  #include "perf_regs.h"
>  #include "../../util/perf_regs.h"
>  
> -static const struct sample_reg sample_reg_masks[] = {
> -	SMPL_REG_END
> -};
> -
>  uint64_t arch__intr_reg_mask(void)
>  {
>  	return PERF_REGS_MASK;
> @@ -15,8 +11,3 @@ uint64_t arch__user_reg_mask(void)
>  {
>  	return PERF_REGS_MASK;
>  }
> -
> -const struct sample_reg *arch__sample_reg_masks(void)
> -{
> -	return sample_reg_masks;
> -}
> diff --git a/tools/perf/arch/loongarch/util/perf_regs.c b/tools/perf/arch/loongarch/util/perf_regs.c
> index f94a0210c7b7..03a5bc0cf64c 100644
> --- a/tools/perf/arch/loongarch/util/perf_regs.c
> +++ b/tools/perf/arch/loongarch/util/perf_regs.c
> @@ -2,10 +2,6 @@
>  #include "perf_regs.h"
>  #include "../../../util/perf_regs.h"
>  
> -static const struct sample_reg sample_reg_masks[] = {
> -	SMPL_REG_END
> -};
> -
>  uint64_t arch__intr_reg_mask(void)
>  {
>  	return PERF_REGS_MASK;
> @@ -15,8 +11,3 @@ uint64_t arch__user_reg_mask(void)
>  {
>  	return PERF_REGS_MASK;
>  }
> -
> -const struct sample_reg *arch__sample_reg_masks(void)
> -{
> -	return sample_reg_masks;
> -}
> diff --git a/tools/perf/arch/mips/util/perf_regs.c b/tools/perf/arch/mips/util/perf_regs.c
> index 6b1665f41180..2cf7a54106e0 100644
> --- a/tools/perf/arch/mips/util/perf_regs.c
> +++ b/tools/perf/arch/mips/util/perf_regs.c
> @@ -2,10 +2,6 @@
>  #include "perf_regs.h"
>  #include "../../util/perf_regs.h"
>  
> -static const struct sample_reg sample_reg_masks[] = {
> -	SMPL_REG_END
> -};
> -
>  uint64_t arch__intr_reg_mask(void)
>  {
>  	return PERF_REGS_MASK;
> @@ -15,8 +11,3 @@ uint64_t arch__user_reg_mask(void)
>  {
>  	return PERF_REGS_MASK;
>  }
> -
> -const struct sample_reg *arch__sample_reg_masks(void)
> -{
> -	return sample_reg_masks;
> -}
> diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
> index bd36cfd420a2..779073f7e992 100644
> --- a/tools/perf/arch/powerpc/util/perf_regs.c
> +++ b/tools/perf/arch/powerpc/util/perf_regs.c
> @@ -18,69 +18,6 @@
>  #define PVR_POWER10		0x0080
>  #define PVR_POWER11		0x0082
>  
> -static const struct sample_reg sample_reg_masks[] = {
> -	SMPL_REG(r0, PERF_REG_POWERPC_R0),
> -	SMPL_REG(r1, PERF_REG_POWERPC_R1),
> -	SMPL_REG(r2, PERF_REG_POWERPC_R2),
> -	SMPL_REG(r3, PERF_REG_POWERPC_R3),
> -	SMPL_REG(r4, PERF_REG_POWERPC_R4),
> -	SMPL_REG(r5, PERF_REG_POWERPC_R5),
> -	SMPL_REG(r6, PERF_REG_POWERPC_R6),
> -	SMPL_REG(r7, PERF_REG_POWERPC_R7),
> -	SMPL_REG(r8, PERF_REG_POWERPC_R8),
> -	SMPL_REG(r9, PERF_REG_POWERPC_R9),
> -	SMPL_REG(r10, PERF_REG_POWERPC_R10),
> -	SMPL_REG(r11, PERF_REG_POWERPC_R11),
> -	SMPL_REG(r12, PERF_REG_POWERPC_R12),
> -	SMPL_REG(r13, PERF_REG_POWERPC_R13),
> -	SMPL_REG(r14, PERF_REG_POWERPC_R14),
> -	SMPL_REG(r15, PERF_REG_POWERPC_R15),
> -	SMPL_REG(r16, PERF_REG_POWERPC_R16),
> -	SMPL_REG(r17, PERF_REG_POWERPC_R17),
> -	SMPL_REG(r18, PERF_REG_POWERPC_R18),
> -	SMPL_REG(r19, PERF_REG_POWERPC_R19),
> -	SMPL_REG(r20, PERF_REG_POWERPC_R20),
> -	SMPL_REG(r21, PERF_REG_POWERPC_R21),
> -	SMPL_REG(r22, PERF_REG_POWERPC_R22),
> -	SMPL_REG(r23, PERF_REG_POWERPC_R23),
> -	SMPL_REG(r24, PERF_REG_POWERPC_R24),
> -	SMPL_REG(r25, PERF_REG_POWERPC_R25),
> -	SMPL_REG(r26, PERF_REG_POWERPC_R26),
> -	SMPL_REG(r27, PERF_REG_POWERPC_R27),
> -	SMPL_REG(r28, PERF_REG_POWERPC_R28),
> -	SMPL_REG(r29, PERF_REG_POWERPC_R29),
> -	SMPL_REG(r30, PERF_REG_POWERPC_R30),
> -	SMPL_REG(r31, PERF_REG_POWERPC_R31),
> -	SMPL_REG(nip, PERF_REG_POWERPC_NIP),
> -	SMPL_REG(msr, PERF_REG_POWERPC_MSR),
> -	SMPL_REG(orig_r3, PERF_REG_POWERPC_ORIG_R3),
> -	SMPL_REG(ctr, PERF_REG_POWERPC_CTR),
> -	SMPL_REG(link, PERF_REG_POWERPC_LINK),
> -	SMPL_REG(xer, PERF_REG_POWERPC_XER),
> -	SMPL_REG(ccr, PERF_REG_POWERPC_CCR),
> -	SMPL_REG(softe, PERF_REG_POWERPC_SOFTE),
> -	SMPL_REG(trap, PERF_REG_POWERPC_TRAP),
> -	SMPL_REG(dar, PERF_REG_POWERPC_DAR),
> -	SMPL_REG(dsisr, PERF_REG_POWERPC_DSISR),
> -	SMPL_REG(sier, PERF_REG_POWERPC_SIER),
> -	SMPL_REG(mmcra, PERF_REG_POWERPC_MMCRA),
> -	SMPL_REG(mmcr0, PERF_REG_POWERPC_MMCR0),
> -	SMPL_REG(mmcr1, PERF_REG_POWERPC_MMCR1),
> -	SMPL_REG(mmcr2, PERF_REG_POWERPC_MMCR2),
> -	SMPL_REG(mmcr3, PERF_REG_POWERPC_MMCR3),
> -	SMPL_REG(sier2, PERF_REG_POWERPC_SIER2),
> -	SMPL_REG(sier3, PERF_REG_POWERPC_SIER3),
> -	SMPL_REG(pmc1, PERF_REG_POWERPC_PMC1),
> -	SMPL_REG(pmc2, PERF_REG_POWERPC_PMC2),
> -	SMPL_REG(pmc3, PERF_REG_POWERPC_PMC3),
> -	SMPL_REG(pmc4, PERF_REG_POWERPC_PMC4),
> -	SMPL_REG(pmc5, PERF_REG_POWERPC_PMC5),
> -	SMPL_REG(pmc6, PERF_REG_POWERPC_PMC6),
> -	SMPL_REG(sdar, PERF_REG_POWERPC_SDAR),
> -	SMPL_REG(siar, PERF_REG_POWERPC_SIAR),
> -	SMPL_REG_END
> -};
> -
>  /* REG or %rREG */
>  #define SDT_OP_REGEX1  "^(%r)?([1-2]?[0-9]|3[0-1])$"
>  
> @@ -233,8 +170,3 @@ uint64_t arch__user_reg_mask(void)
>  {
>  	return PERF_REGS_MASK;
>  }
> -
> -const struct sample_reg *arch__sample_reg_masks(void)
> -{
> -	return sample_reg_masks;
> -}
> diff --git a/tools/perf/arch/riscv/util/perf_regs.c b/tools/perf/arch/riscv/util/perf_regs.c
> index 6b1665f41180..2cf7a54106e0 100644
> --- a/tools/perf/arch/riscv/util/perf_regs.c
> +++ b/tools/perf/arch/riscv/util/perf_regs.c
> @@ -2,10 +2,6 @@
>  #include "perf_regs.h"
>  #include "../../util/perf_regs.h"
>  
> -static const struct sample_reg sample_reg_masks[] = {
> -	SMPL_REG_END
> -};
> -
>  uint64_t arch__intr_reg_mask(void)
>  {
>  	return PERF_REGS_MASK;
> @@ -15,8 +11,3 @@ uint64_t arch__user_reg_mask(void)
>  {
>  	return PERF_REGS_MASK;
>  }
> -
> -const struct sample_reg *arch__sample_reg_masks(void)
> -{
> -	return sample_reg_masks;
> -}
> diff --git a/tools/perf/arch/s390/util/perf_regs.c b/tools/perf/arch/s390/util/perf_regs.c
> index 6b1665f41180..2cf7a54106e0 100644
> --- a/tools/perf/arch/s390/util/perf_regs.c
> +++ b/tools/perf/arch/s390/util/perf_regs.c
> @@ -2,10 +2,6 @@
>  #include "perf_regs.h"
>  #include "../../util/perf_regs.h"
>  
> -static const struct sample_reg sample_reg_masks[] = {
> -	SMPL_REG_END
> -};
> -
>  uint64_t arch__intr_reg_mask(void)
>  {
>  	return PERF_REGS_MASK;
> @@ -15,8 +11,3 @@ uint64_t arch__user_reg_mask(void)
>  {
>  	return PERF_REGS_MASK;
>  }
> -
> -const struct sample_reg *arch__sample_reg_masks(void)
> -{
> -	return sample_reg_masks;
> -}
> diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
> index 12fd93f04802..a7ca4154fdf9 100644
> --- a/tools/perf/arch/x86/util/perf_regs.c
> +++ b/tools/perf/arch/x86/util/perf_regs.c
> @@ -13,48 +13,6 @@
>  #include "../../../util/pmu.h"
>  #include "../../../util/pmus.h"
>  
> -static const struct sample_reg sample_reg_masks[] = {
> -	SMPL_REG(AX, PERF_REG_X86_AX),
> -	SMPL_REG(BX, PERF_REG_X86_BX),
> -	SMPL_REG(CX, PERF_REG_X86_CX),
> -	SMPL_REG(DX, PERF_REG_X86_DX),
> -	SMPL_REG(SI, PERF_REG_X86_SI),
> -	SMPL_REG(DI, PERF_REG_X86_DI),
> -	SMPL_REG(BP, PERF_REG_X86_BP),
> -	SMPL_REG(SP, PERF_REG_X86_SP),
> -	SMPL_REG(IP, PERF_REG_X86_IP),
> -	SMPL_REG(FLAGS, PERF_REG_X86_FLAGS),
> -	SMPL_REG(CS, PERF_REG_X86_CS),
> -	SMPL_REG(SS, PERF_REG_X86_SS),
> -#ifdef HAVE_ARCH_X86_64_SUPPORT
> -	SMPL_REG(R8, PERF_REG_X86_R8),
> -	SMPL_REG(R9, PERF_REG_X86_R9),
> -	SMPL_REG(R10, PERF_REG_X86_R10),
> -	SMPL_REG(R11, PERF_REG_X86_R11),
> -	SMPL_REG(R12, PERF_REG_X86_R12),
> -	SMPL_REG(R13, PERF_REG_X86_R13),
> -	SMPL_REG(R14, PERF_REG_X86_R14),
> -	SMPL_REG(R15, PERF_REG_X86_R15),
> -#endif
> -	SMPL_REG2(XMM0, PERF_REG_X86_XMM0),
> -	SMPL_REG2(XMM1, PERF_REG_X86_XMM1),
> -	SMPL_REG2(XMM2, PERF_REG_X86_XMM2),
> -	SMPL_REG2(XMM3, PERF_REG_X86_XMM3),
> -	SMPL_REG2(XMM4, PERF_REG_X86_XMM4),
> -	SMPL_REG2(XMM5, PERF_REG_X86_XMM5),
> -	SMPL_REG2(XMM6, PERF_REG_X86_XMM6),
> -	SMPL_REG2(XMM7, PERF_REG_X86_XMM7),
> -	SMPL_REG2(XMM8, PERF_REG_X86_XMM8),
> -	SMPL_REG2(XMM9, PERF_REG_X86_XMM9),
> -	SMPL_REG2(XMM10, PERF_REG_X86_XMM10),
> -	SMPL_REG2(XMM11, PERF_REG_X86_XMM11),
> -	SMPL_REG2(XMM12, PERF_REG_X86_XMM12),
> -	SMPL_REG2(XMM13, PERF_REG_X86_XMM13),
> -	SMPL_REG2(XMM14, PERF_REG_X86_XMM14),
> -	SMPL_REG2(XMM15, PERF_REG_X86_XMM15),
> -	SMPL_REG_END
> -};
> -
>  struct sdt_name_reg {
>  	const char *sdt_name;
>  	const char *uprobe_name;
> @@ -276,11 +234,6 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
>  	return SDT_ARG_VALID;
>  }
>  
> -const struct sample_reg *arch__sample_reg_masks(void)
> -{
> -	return sample_reg_masks;
> -}
> -
>  uint64_t arch__intr_reg_mask(void)
>  {
>  	struct perf_event_attr attr = {
> diff --git a/tools/perf/util/arm64-frame-pointer-unwind-support.c b/tools/perf/util/arm64-frame-pointer-unwind-support.c
> index 958afe8b821e..858ce2b01812 100644
> --- a/tools/perf/util/arm64-frame-pointer-unwind-support.c
> +++ b/tools/perf/util/arm64-frame-pointer-unwind-support.c
> @@ -2,7 +2,6 @@
>  #include "arm64-frame-pointer-unwind-support.h"
>  #include "callchain.h"
>  #include "event.h"
> -#include "perf_regs.h" // SMPL_REG_MASK
>  #include "unwind.h"
>  #include <string.h>
>  
> @@ -15,6 +14,8 @@ struct entries {
>  	size_t length;
>  };
>  
> +#define SMPL_REG_MASK(b) (1ULL << (b))
> +
>  static bool get_leaf_frame_caller_enabled(struct perf_sample *sample)
>  {
>  	struct regs_dump *regs;
> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
> index cda1c620968e..c0d0ef9fd495 100644
> --- a/tools/perf/util/parse-regs-options.c
> +++ b/tools/perf/util/parse-regs-options.c
> @@ -5,15 +5,54 @@
>  #include <string.h>
>  #include <stdio.h>
>  #include "util/debug.h"
> +#include <dwarf-regs.h>
>  #include <subcmd/parse-options.h>
>  #include "util/perf_regs.h"
>  #include "util/parse-regs-options.h"
>  
> +static void list_perf_regs(FILE *fp, uint64_t mask)
> +{
> +	const char *last_name = NULL;
> +
> +	fprintf(fp, "available registers: ");
> +	for (int reg = 0; reg < 64; reg++) {
> +		const char *name;
> +
> +		if (((1ULL << reg) & mask) == 0)
> +			continue;
> +
> +		name = perf_reg_name(reg, EM_HOST);
> +		if (name && (!last_name || strcmp(last_name, name)))
> +			fprintf(fp, "%s%s", reg > 0 ? " " : "", name);
> +		last_name = name;
> +	}
> +	fputc('\n', fp);
> +}
> +
> +static uint64_t name_to_perf_reg_mask(const char *to_match, uint64_t mask)
> +{
> +	uint64_t reg_mask = 0;
> +
> +	for (int reg = 0; reg < 64; reg++) {
> +		const char *name;
> +
> +		if (((1ULL << reg) & mask) == 0)
> +			continue;
> +
> +		name = perf_reg_name(reg, EM_HOST);
> +		if (!name)
> +			continue;
> +
> +		if (!strcasecmp(to_match, name))
> +			reg_mask |= 1ULL << reg;
> +	}
> +	return reg_mask;
> +}
> +
>  static int
>  __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>  {
>  	uint64_t *mode = (uint64_t *)opt->value;
> -	const struct sample_reg *r = NULL;
>  	char *s, *os = NULL, *p;
>  	int ret = -1;
>  	uint64_t mask;
> @@ -27,50 +66,41 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>  	if (*mode)
>  		return -1;
>  
> -	if (intr)
> -		mask = arch__intr_reg_mask();
> -	else
> -		mask = arch__user_reg_mask();
> -
>  	/* str may be NULL in case no arg is passed to -I */
> -	if (str) {
> -		/* because str is read-only */
> -		s = os = strdup(str);
> -		if (!s)
> -			return -1;
> -
> -		for (;;) {
> -			p = strchr(s, ',');
> -			if (p)
> -				*p = '\0';
> -
> -			if (!strcmp(s, "?")) {
> -				fprintf(stderr, "available registers: ");
> -				for (r = arch__sample_reg_masks(); r->name; r++) {
> -					if (r->mask & mask)
> -						fprintf(stderr, "%s ", r->name);
> -				}
> -				fputc('\n', stderr);
> -				/* just printing available regs */
> -				goto error;
> -			}
> -			for (r = arch__sample_reg_masks(); r->name; r++) {
> -				if ((r->mask & mask) && !strcasecmp(s, r->name))
> -					break;
> -			}
> -			if (!r || !r->name) {
> -				ui__warning("Unknown register \"%s\", check man page or run \"perf record %s?\"\n",
> -					    s, intr ? "-I" : "--user-regs=");
> -				goto error;
> -			}
> -
> -			*mode |= r->mask;
> -
> -			if (!p)
> -				break;
> -
> -			s = p + 1;
> +	if (!str)
> +		return -1;
> +
> +	mask = intr ? arch__intr_reg_mask() : arch__user_reg_mask();
> +
> +	/* because str is read-only */
> +	s = os = strdup(str);
> +	if (!s)
> +		return -1;
> +
> +	for (;;) {
> +		uint64_t reg_mask;
> +
> +		p = strchr(s, ',');
> +		if (p)
> +			*p = '\0';
> +
> +		if (!strcmp(s, "?")) {
> +			list_perf_regs(stderr, mask);
> +			goto error;
> +		}
> +
> +		reg_mask = name_to_perf_reg_mask(s, mask);
> +		if (reg_mask == 0) {
> +			ui__warning("Unknown register \"%s\", check man page or run \"perf record %s?\"\n",
> +				s, intr ? "-I" : "--user-regs=");
> +			goto error;
>  		}
> +		*mode |= reg_mask;
> +
> +		if (!p)
> +			break;
> +
> +		s = p + 1;
>  	}
>  	ret = 0;
>  
> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> index b58d59b84fb1..ec602da1aeb6 100644
> --- a/tools/perf/util/perf_regs.c
> +++ b/tools/perf/util/perf_regs.c
> @@ -22,15 +22,6 @@ uint64_t __weak arch__user_reg_mask(void)
>  	return 0;
>  }
>  
> -static const struct sample_reg sample_reg_masks[] = {
> -	SMPL_REG_END
> -};
> -
> -const struct sample_reg * __weak arch__sample_reg_masks(void)
> -{
> -	return sample_reg_masks;
> -}
> -
>  const char *perf_reg_name(int id, uint16_t e_machine)
>  {
>  	const char *reg_name = NULL;
> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> index 7bfc6a34c02b..2c2a8de6912d 100644
> --- a/tools/perf/util/perf_regs.h
> +++ b/tools/perf/util/perf_regs.h
> @@ -7,17 +7,6 @@
>  
>  struct regs_dump;
>  
> -struct sample_reg {
> -	const char *name;
> -	uint64_t mask;
> -};
> -
> -#define SMPL_REG_MASK(b) (1ULL << (b))
> -#define SMPL_REG(n, b) { .name = #n, .mask = SMPL_REG_MASK(b) }
> -#define SMPL_REG2_MASK(b) (3ULL << (b))
> -#define SMPL_REG2(n, b) { .name = #n, .mask = SMPL_REG2_MASK(b) }
> -#define SMPL_REG_END { .name = NULL }
> -
>  enum {
>  	SDT_ARG_VALID = 0,
>  	SDT_ARG_SKIP,
> @@ -26,7 +15,6 @@ enum {
>  int arch_sdt_arg_parse_op(char *old_op, char **new_op);
>  uint64_t arch__intr_reg_mask(void);
>  uint64_t arch__user_reg_mask(void);
> -const struct sample_reg *arch__sample_reg_masks(void);
>  
>  const char *perf_reg_name(int id, uint16_t e_machine);
>  int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);

I have tested this patch set for s390.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
