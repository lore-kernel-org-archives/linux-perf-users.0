Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAD0272803;
	Wed, 28 Jan 2026 02:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769565817; cv=none; b=ZXntGsdEbNHqzl4HtW+COqp9558BmQPhKCGu03n3Nv+xcJ2vPXi3wtsPVw80uZN+9g4h9SPHO5hLxDvtQY6ft3mPmL7ZtjlNX1yVw42QToXVKFJWH27/xXfmeJn1Cw6RsIjnnhbTkgUufZ0mzS7axoVIsSXFNrIvZ3Zm9ok/3NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769565817; c=relaxed/simple;
	bh=icpMv4eJvZC45ka1scMtLY32aGJy1Mn/MyjpM7bS81Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZPH5xXbpiocRKjFTO2hHi6lRVuqeuTowM+mJEiVB0F7uX3RdTPa3SnkK5+Qm5x21qPZiiqq8aOA/3sMn7hV0SjbkpKQs4fWcIoVLs6c9vmuibRQm+E0nYOVcJM3fwb6JzfWWKbq8XPkM8TZIKU9N6PimHaSkQ3DM6sycde0Dr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NfSrlp3G; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NfSrlp3G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769565815; x=1801101815;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=icpMv4eJvZC45ka1scMtLY32aGJy1Mn/MyjpM7bS81Q=;
  b=NfSrlp3Gp96+CE6bhX7JnQ29jksM1W58MnyyCuFtpFaEVcoHPVSLZ6w0
   ZneSsLGQSHCXco51J4LtogkszAfKT5yBIRFKCM9oVqtoYZ4dEWzqMiwSL
   EnGpSroAOXhFpQshOYP79q2244+sHGe+1zFw5tmTTe8l+SXzXVRowLfAj
   Rgb9i7lUrrA8HrW+M7n8o5bvVhyqo7TdwOfDP4kb1VgcNCMTmpfATQ9EC
   lY0Dr/eHbqyIWKXmo/NuS7LvMHBom1Z/eRxriM3MlM07MoOrT31dXZ/qe
   DLO54fjXifyYfJCpA3iEz6Ft1B4vk5Klxsj/NlkgKroRhf0OyAG+fMBIX
   Q==;
X-CSE-ConnectionGUID: bss9TC74RduqdCjwyT/9sg==
X-CSE-MsgGUID: 60QkXc98SKatdlg+e5EUKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="82203394"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="82203394"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 18:03:34 -0800
X-CSE-ConnectionGUID: pebTWDyBTEyiOhYrf4E5JQ==
X-CSE-MsgGUID: CtKcmVAJSma8+4HgRqsFWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="208151660"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 18:03:27 -0800
Message-ID: <9f88ff32-c699-4587-885e-316a914a5d78@linux.intel.com>
Date: Wed, 28 Jan 2026 10:03:24 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 2/3] perf regs: Remove __weak attributive
 arch__xxx_reg_mask() functions
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>,
 Guo Ren <guoren@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260127070259.2720468-1-dapeng1.mi@linux.intel.com>
 <20260127070259.2720468-3-dapeng1.mi@linux.intel.com>
 <CAP-5=fWxxp8vai33kvxf_45v6TUebWR5g3njEnRMQTP=Bx-Gww@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fWxxp8vai33kvxf_45v6TUebWR5g3njEnRMQTP=Bx-Gww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/28/2026 12:46 AM, Ian Rogers wrote:
> On Mon, Jan 26, 2026 at 11:06 PM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>> Currently, some architecture-specific perf-regs functions, such as
>> arch__intr_reg_mask() and arch__user_reg_mask(), are defined with the
>> __weak attribute. This approach ensures that only functions matching
>> the architecture of the build/run host are compiled and executed,
>> reducing build time and binary size.
>>
>> However, this __weak attribute restricts these functions to be called
>> only on the same architecture, preventing cross-architecture
>> functionality. For example, a perf.data file captured on x86 cannot be
>> parsed on an ARM platform.
>>
>> To address this limitation, this patch removes the __weak attribute from
>> these perf-regs functions. The architecture-specific code is moved from
>> the arch/ directory to the util/perf-regs-arch/ directory. The
>> appropriate architectural functions are then called based on the EM_HOST.
>>
>> No functional changes are intended.
>>
>> Suggested-by: Ian Rogers <irogers@google.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  tools/perf/arch/arm/util/Build                |  2 -
>>  tools/perf/arch/arm/util/perf_regs.c          | 13 ---
>>  tools/perf/arch/arm64/util/perf_regs.c        | 36 ---------
>>  tools/perf/arch/csky/Build                    |  1 -
>>  tools/perf/arch/csky/util/Build               |  1 -
>>  tools/perf/arch/csky/util/perf_regs.c         | 13 ---
>>  tools/perf/arch/loongarch/util/Build          |  1 -
>>  tools/perf/arch/loongarch/util/perf_regs.c    | 13 ---
>>  tools/perf/arch/mips/util/Build               |  1 -
>>  tools/perf/arch/mips/util/perf_regs.c         | 13 ---
>>  tools/perf/arch/powerpc/util/perf_regs.c      | 47 -----------
>>  tools/perf/arch/riscv/include/perf_regs.h     |  7 +-
>>  tools/perf/arch/riscv/util/Build              |  1 -
>>  tools/perf/arch/riscv/util/perf_regs.c        | 13 ---
>>  tools/perf/arch/s390/util/Build               |  1 -
>>  tools/perf/arch/s390/util/perf_regs.c         | 13 ---
>>  tools/perf/arch/x86/util/perf_regs.c          | 48 -----------
>>  tools/perf/util/evsel.c                       |  4 +-
>>  tools/perf/util/parse-regs-options.c          |  2 +-
>>  .../util/perf-regs-arch/perf_regs_aarch64.c   | 51 +++++++++++-
>>  .../perf/util/perf-regs-arch/perf_regs_arm.c  |  7 +-
>>  .../perf/util/perf-regs-arch/perf_regs_csky.c |  7 +-
>>  .../util/perf-regs-arch/perf_regs_loongarch.c |  7 +-
>>  .../perf/util/perf-regs-arch/perf_regs_mips.c |  7 +-
>>  .../util/perf-regs-arch/perf_regs_powerpc.c   | 70 +++++++++++++++-
>>  .../util/perf-regs-arch/perf_regs_riscv.c     |  7 +-
>>  .../perf/util/perf-regs-arch/perf_regs_s390.c |  7 +-
>>  .../perf/util/perf-regs-arch/perf_regs_x86.c  | 60 +++++++++++++-
>>  tools/perf/util/perf_regs.c                   | 80 ++++++++++++++++++-
>>  tools/perf/util/perf_regs.h                   | 22 ++++-
>>  30 files changed, 319 insertions(+), 236 deletions(-)
>>  delete mode 100644 tools/perf/arch/arm/util/perf_regs.c
>>  delete mode 100644 tools/perf/arch/csky/Build
>>  delete mode 100644 tools/perf/arch/csky/util/Build
>>  delete mode 100644 tools/perf/arch/csky/util/perf_regs.c
>>  delete mode 100644 tools/perf/arch/loongarch/util/perf_regs.c
>>  delete mode 100644 tools/perf/arch/mips/util/perf_regs.c
>>  delete mode 100644 tools/perf/arch/riscv/util/perf_regs.c
>>  delete mode 100644 tools/perf/arch/s390/util/perf_regs.c
> 8 files deleted is pretty awesome from my pov. Thanks!

Yeah. Besides the reduction of files, another benefit (which could be more
important) is that all perf-regs related arch-specific code currently are
in a same place. 


>
>> diff --git a/tools/perf/arch/arm/util/Build b/tools/perf/arch/arm/util/Build
>> index 3291f893b943..b94bf3c5279a 100644
>> --- a/tools/perf/arch/arm/util/Build
>> +++ b/tools/perf/arch/arm/util/Build
>> @@ -1,5 +1,3 @@
>> -perf-util-y += perf_regs.o
>> -
>>  perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
>>
>>  perf-util-y += pmu.o auxtrace.o cs-etm.o
>> diff --git a/tools/perf/arch/arm/util/perf_regs.c b/tools/perf/arch/arm/util/perf_regs.c
>> deleted file mode 100644
>> index 03a5bc0cf64c..000000000000
>> --- a/tools/perf/arch/arm/util/perf_regs.c
>> +++ /dev/null
>> @@ -1,13 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> -#include "perf_regs.h"
>> -#include "../../../util/perf_regs.h"
>> -
>> -uint64_t arch__intr_reg_mask(void)
>> -{
>> -       return PERF_REGS_MASK;
>> -}
>> -
>> -uint64_t arch__user_reg_mask(void)
>> -{
>> -       return PERF_REGS_MASK;
>> -}
>> diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm64/util/perf_regs.c
>> index 9bb768e1bea1..47f58eaba032 100644
>> --- a/tools/perf/arch/arm64/util/perf_regs.c
>> +++ b/tools/perf/arch/arm64/util/perf_regs.c
>> @@ -103,39 +103,3 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
>>
>>         return SDT_ARG_VALID;
>>  }
>> -
>> -uint64_t arch__intr_reg_mask(void)
>> -{
>> -       return PERF_REGS_MASK;
>> -}
>> -
>> -uint64_t arch__user_reg_mask(void)
>> -{
>> -       struct perf_event_attr attr = {
>> -               .type                   = PERF_TYPE_HARDWARE,
>> -               .config                 = PERF_COUNT_HW_CPU_CYCLES,
>> -               .sample_type            = PERF_SAMPLE_REGS_USER,
>> -               .disabled               = 1,
>> -               .exclude_kernel         = 1,
>> -               .sample_period          = 1,
>> -               .sample_regs_user       = PERF_REGS_MASK
>> -       };
>> -       int fd;
>> -
>> -       if (getauxval(AT_HWCAP) & HWCAP_SVE)
>> -               attr.sample_regs_user |= SMPL_REG_MASK(PERF_REG_ARM64_VG);
>> -
>> -       /*
>> -        * Check if the pmu supports perf extended regs, before
>> -        * returning the register mask to sample.
>> -        */
>> -       if (attr.sample_regs_user != PERF_REGS_MASK) {
>> -               event_attr_init(&attr);
>> -               fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
>> -               if (fd != -1) {
>> -                       close(fd);
>> -                       return attr.sample_regs_user;
>> -               }
>> -       }
>> -       return PERF_REGS_MASK;
>> -}
>> diff --git a/tools/perf/arch/csky/Build b/tools/perf/arch/csky/Build
>> deleted file mode 100644
>> index e63eabc2c8f4..000000000000
>> --- a/tools/perf/arch/csky/Build
>> +++ /dev/null
>> @@ -1 +0,0 @@
>> -perf-util-y += util/
>> diff --git a/tools/perf/arch/csky/util/Build b/tools/perf/arch/csky/util/Build
>> deleted file mode 100644
>> index 6b2d0e021b11..000000000000
>> --- a/tools/perf/arch/csky/util/Build
>> +++ /dev/null
>> @@ -1 +0,0 @@
>> -perf-util-y += perf_regs.o
>> diff --git a/tools/perf/arch/csky/util/perf_regs.c b/tools/perf/arch/csky/util/perf_regs.c
>> deleted file mode 100644
>> index 2cf7a54106e0..000000000000
>> --- a/tools/perf/arch/csky/util/perf_regs.c
>> +++ /dev/null
>> @@ -1,13 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> -#include "perf_regs.h"
>> -#include "../../util/perf_regs.h"
>> -
>> -uint64_t arch__intr_reg_mask(void)
>> -{
>> -       return PERF_REGS_MASK;
>> -}
>> -
>> -uint64_t arch__user_reg_mask(void)
>> -{
>> -       return PERF_REGS_MASK;
>> -}
>> diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loongarch/util/Build
>> index 0aa31986ecb5..0c958c8e0718 100644
>> --- a/tools/perf/arch/loongarch/util/Build
>> +++ b/tools/perf/arch/loongarch/util/Build
>> @@ -1,5 +1,4 @@
>>  perf-util-y += header.o
>> -perf-util-y += perf_regs.o
>>
>>  perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
>>  perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
>> diff --git a/tools/perf/arch/loongarch/util/perf_regs.c b/tools/perf/arch/loongarch/util/perf_regs.c
>> deleted file mode 100644
>> index 03a5bc0cf64c..000000000000
>> --- a/tools/perf/arch/loongarch/util/perf_regs.c
>> +++ /dev/null
>> @@ -1,13 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> -#include "perf_regs.h"
>> -#include "../../../util/perf_regs.h"
>> -
>> -uint64_t arch__intr_reg_mask(void)
>> -{
>> -       return PERF_REGS_MASK;
>> -}
>> -
>> -uint64_t arch__user_reg_mask(void)
>> -{
>> -       return PERF_REGS_MASK;
>> -}
>> diff --git a/tools/perf/arch/mips/util/Build b/tools/perf/arch/mips/util/Build
>> index 691fa2051958..818b808a8247 100644
>> --- a/tools/perf/arch/mips/util/Build
>> +++ b/tools/perf/arch/mips/util/Build
>> @@ -1,2 +1 @@
>> -perf-util-y += perf_regs.o
>>  perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
>> diff --git a/tools/perf/arch/mips/util/perf_regs.c b/tools/perf/arch/mips/util/perf_regs.c
>> deleted file mode 100644
>> index 2cf7a54106e0..000000000000
>> --- a/tools/perf/arch/mips/util/perf_regs.c
>> +++ /dev/null
>> @@ -1,13 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> -#include "perf_regs.h"
>> -#include "../../util/perf_regs.h"
>> -
>> -uint64_t arch__intr_reg_mask(void)
>> -{
>> -       return PERF_REGS_MASK;
>> -}
>> -
>> -uint64_t arch__user_reg_mask(void)
>> -{
>> -       return PERF_REGS_MASK;
>> -}
>> diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
>> index 779073f7e992..93f929fc32e3 100644
>> --- a/tools/perf/arch/powerpc/util/perf_regs.c
>> +++ b/tools/perf/arch/powerpc/util/perf_regs.c
>> @@ -123,50 +123,3 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
>>
>>         return SDT_ARG_VALID;
>>  }
>> -
>> -uint64_t arch__intr_reg_mask(void)
>> -{
>> -       struct perf_event_attr attr = {
>> -               .type                   = PERF_TYPE_HARDWARE,
>> -               .config                 = PERF_COUNT_HW_CPU_CYCLES,
>> -               .sample_type            = PERF_SAMPLE_REGS_INTR,
>> -               .precise_ip             = 1,
>> -               .disabled               = 1,
>> -               .exclude_kernel         = 1,
>> -       };
>> -       int fd;
>> -       u32 version;
>> -       u64 extended_mask = 0, mask = PERF_REGS_MASK;
>> -
>> -       /*
>> -        * Get the PVR value to set the extended
>> -        * mask specific to platform.
>> -        */
>> -       version = (((mfspr(SPRN_PVR)) >>  16) & 0xFFFF);
>> -       if (version == PVR_POWER9)
>> -               extended_mask = PERF_REG_PMU_MASK_300;
>> -       else if ((version == PVR_POWER10) || (version == PVR_POWER11))
>> -               extended_mask = PERF_REG_PMU_MASK_31;
>> -       else
>> -               return mask;
>> -
>> -       attr.sample_regs_intr = extended_mask;
>> -       attr.sample_period = 1;
>> -       event_attr_init(&attr);
>> -
>> -       /*
>> -        * check if the pmu supports perf extended regs, before
>> -        * returning the register mask to sample.
>> -        */
>> -       fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
>> -       if (fd != -1) {
>> -               close(fd);
>> -               mask |= extended_mask;
>> -       }
>> -       return mask;
>> -}
>> -
>> -uint64_t arch__user_reg_mask(void)
>> -{
>> -       return PERF_REGS_MASK;
>> -}
>> diff --git a/tools/perf/arch/riscv/include/perf_regs.h b/tools/perf/arch/riscv/include/perf_regs.h
>> index 89d5bbb8d2b8..af7a1b47bf66 100644
>> --- a/tools/perf/arch/riscv/include/perf_regs.h
>> +++ b/tools/perf/arch/riscv/include/perf_regs.h
>> @@ -10,10 +10,15 @@
>>
>>  #define PERF_REGS_MASK ((1ULL << PERF_REG_RISCV_MAX) - 1)
>>  #define PERF_REGS_MAX  PERF_REG_RISCV_MAX
>> +
>> +#if defined(__riscv_xlen)
>>  #if __riscv_xlen == 64
>> -#define PERF_SAMPLE_REGS_ABI    PERF_SAMPLE_REGS_ABI_64
>> +#define PERF_SAMPLE_REGS_ABI   PERF_SAMPLE_REGS_ABI_64
>>  #else
>>  #define PERF_SAMPLE_REGS_ABI   PERF_SAMPLE_REGS_ABI_32
>>  #endif
>> +#else
>> +#define PERF_SAMPLE_REGS_ABI   PERF_SAMPLE_REGS_NONE
>> +#endif
>>
>>  #endif /* ARCH_PERF_REGS_H */
>> diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/util/Build
>> index 628b9ebd418b..da5b12e7f862 100644
>> --- a/tools/perf/arch/riscv/util/Build
>> +++ b/tools/perf/arch/riscv/util/Build
>> @@ -1,4 +1,3 @@
>> -perf-util-y += perf_regs.o
>>  perf-util-y += header.o
>>
>>  perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
>> diff --git a/tools/perf/arch/riscv/util/perf_regs.c b/tools/perf/arch/riscv/util/perf_regs.c
>> deleted file mode 100644
>> index 2cf7a54106e0..000000000000
>> --- a/tools/perf/arch/riscv/util/perf_regs.c
>> +++ /dev/null
>> @@ -1,13 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> -#include "perf_regs.h"
>> -#include "../../util/perf_regs.h"
>> -
>> -uint64_t arch__intr_reg_mask(void)
>> -{
>> -       return PERF_REGS_MASK;
>> -}
>> -
>> -uint64_t arch__user_reg_mask(void)
>> -{
>> -       return PERF_REGS_MASK;
>> -}
>> diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/util/Build
>> index 5391d26fedd4..3b09c058e0ec 100644
>> --- a/tools/perf/arch/s390/util/Build
>> +++ b/tools/perf/arch/s390/util/Build
>> @@ -1,6 +1,5 @@
>>  perf-util-y += header.o
>>  perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
>> -perf-util-y += perf_regs.o
>>
>>  perf-util-y += machine.o
>>  perf-util-y += pmu.o
>> diff --git a/tools/perf/arch/s390/util/perf_regs.c b/tools/perf/arch/s390/util/perf_regs.c
>> deleted file mode 100644
>> index 2cf7a54106e0..000000000000
>> --- a/tools/perf/arch/s390/util/perf_regs.c
>> +++ /dev/null
>> @@ -1,13 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> -#include "perf_regs.h"
>> -#include "../../util/perf_regs.h"
>> -
>> -uint64_t arch__intr_reg_mask(void)
>> -{
>> -       return PERF_REGS_MASK;
>> -}
>> -
>> -uint64_t arch__user_reg_mask(void)
>> -{
>> -       return PERF_REGS_MASK;
>> -}
>> diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
>> index a7ca4154fdf9..41141cebe226 100644
>> --- a/tools/perf/arch/x86/util/perf_regs.c
>> +++ b/tools/perf/arch/x86/util/perf_regs.c
>> @@ -233,51 +233,3 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
>>
>>         return SDT_ARG_VALID;
>>  }
>> -
>> -uint64_t arch__intr_reg_mask(void)
>> -{
>> -       struct perf_event_attr attr = {
>> -               .type                   = PERF_TYPE_HARDWARE,
>> -               .config                 = PERF_COUNT_HW_CPU_CYCLES,
>> -               .sample_type            = PERF_SAMPLE_REGS_INTR,
>> -               .sample_regs_intr       = PERF_REG_EXTENDED_MASK,
>> -               .precise_ip             = 1,
>> -               .disabled               = 1,
>> -               .exclude_kernel         = 1,
>> -       };
>> -       int fd;
>> -       /*
>> -        * In an unnamed union, init it here to build on older gcc versions
>> -        */
>> -       attr.sample_period = 1;
>> -
>> -       if (perf_pmus__num_core_pmus() > 1) {
>> -               struct perf_pmu *pmu = NULL;
>> -               __u64 type = PERF_TYPE_RAW;
>> -
>> -               /*
>> -                * The same register set is supported among different hybrid PMUs.
>> -                * Only check the first available one.
>> -                */
>> -               while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
>> -                       type = pmu->type;
>> -                       break;
>> -               }
>> -               attr.config |= type << PERF_PMU_TYPE_SHIFT;
>> -       }
>> -
>> -       event_attr_init(&attr);
>> -
>> -       fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
>> -       if (fd != -1) {
>> -               close(fd);
>> -               return (PERF_REG_EXTENDED_MASK | PERF_REGS_MASK);
>> -       }
>> -
>> -       return PERF_REGS_MASK;
>> -}
>> -
>> -uint64_t arch__user_reg_mask(void)
>> -{
>> -       return PERF_REGS_MASK;
>> -}
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index 5ac1a05601b1..a36528fd41c6 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -1055,13 +1055,13 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
>>                         evsel__set_sample_bit(evsel, REGS_USER);
>>                         evsel__set_sample_bit(evsel, STACK_USER);
>>                         if (opts->sample_user_regs &&
>> -                           DWARF_MINIMAL_REGS(e_machine) != arch__user_reg_mask()) {
>> +                           DWARF_MINIMAL_REGS(e_machine) != perf_user_reg_mask(EM_HOST)) {
>>                                 attr->sample_regs_user |= DWARF_MINIMAL_REGS(e_machine);
>>                                 pr_warning("WARNING: The use of --call-graph=dwarf may require all the user registers, "
>>                                            "specifying a subset with --user-regs may render DWARF unwinding unreliable, "
>>                                            "so the minimal registers set (IP, SP) is explicitly forced.\n");
>>                         } else {
>> -                               attr->sample_regs_user |= arch__user_reg_mask();
>> +                               attr->sample_regs_user |= perf_user_reg_mask(EM_HOST);
> Fwiw, I think this is why for dwarf unwinding on x86 we're sampling
> the XMM registers which is probably too much. I think the mask that's
> really wanted here is the mask of all callee-save registers or,
> because maybe there's inter-procedural optimizations, all GPRs.

Yes, XMM are definitely not needed for dwarf unwinding. After supporting
the APX eGPRs, we can do a further investigation for this place.


>
>>                         }
>>                         attr->sample_stack_user = param->dump_size;
>>                         attr->exclude_callchain_user = 1;
>> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
>> index c0d0ef9fd495..2af6e4ad2a34 100644
>> --- a/tools/perf/util/parse-regs-options.c
>> +++ b/tools/perf/util/parse-regs-options.c
>> @@ -70,7 +70,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>>         if (!str)
>>                 return -1;
>>
>> -       mask = intr ? arch__intr_reg_mask() : arch__user_reg_mask();
>> +       mask = intr ? perf_intr_reg_mask(EM_HOST) : perf_user_reg_mask(EM_HOST);
>>
>>         /* because str is read-only */
>>         s = os = strdup(str);
>> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c b/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c
>> index 9dcda80d310f..21a432671f04 100644
>> --- a/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c
>> +++ b/tools/perf/util/perf-regs-arch/perf_regs_aarch64.c
>> @@ -1,7 +1,56 @@
>>  // SPDX-License-Identifier: GPL-2.0
>> +#include <errno.h>
>> +#include <regex.h>
>> +#include <string.h>
>> +#include <sys/auxv.h>
>> +#include <linux/kernel.h>
>> +#include <linux/zalloc.h>
>>
>> +#include "../debug.h"
>> +#include "../event.h"
>>  #include "../perf_regs.h"
>> -#include "../../../arch/arm64/include/uapi/asm/perf_regs.h"
>> +#include "../../perf-sys.h"
>> +#include "../../arch/arm64/include/perf_regs.h"
> I'm a little worried about switching from the asm to the arch file
> because of conflicting definitions from the host machine doing the
> compilation. I see we need PERF_REGS_MASK which is typically:
> #define PERF_REGS_MASK  ((1ULL << PERF_REG_<arch>_MAX) - 1)
> Perhaps we can have in the asm header:
> #define PERF_REGS_<arch>_MASK  ((1ULL << PERF_REG_<arch>_MAX) - 1)
> Perhaps that's just later cleanup.

The "asm/perf_regs.h" has been nested into the
"arch/xxx/include/perf_regs.h". IMO, it should be safe and reasonable to
include the perf tools header file "arch/xxx/include/perf_regs.h" for the
perf-regs related source code.

It works to add "PERF_REGS_<arch>_MASK" into the UAPI asm header, but since
the macros are never called in kernel code, I suppose maintainters would
not like it.


>
>> +
>> +#define SMPL_REG_MASK(b) (1ULL << (b))
>> +
>> +#ifndef HWCAP_SVE
>> +#define HWCAP_SVE      (1 << 22)
>> +#endif
>> +
>> +uint64_t __perf_reg_mask_arm64(bool intr)
>> +{
>> +       struct perf_event_attr attr = {
>> +               .type                   = PERF_TYPE_HARDWARE,
>> +               .config                 = PERF_COUNT_HW_CPU_CYCLES,
>> +               .sample_type            = PERF_SAMPLE_REGS_USER,
>> +               .disabled               = 1,
>> +               .exclude_kernel         = 1,
>> +               .sample_period          = 1,
>> +               .sample_regs_user       = PERF_REGS_MASK
>> +       };
>> +       int fd;
>> +
>> +       if (intr)
>> +               return PERF_REGS_MASK;
>> +
>> +       if (getauxval(AT_HWCAP) & HWCAP_SVE)
>> +               attr.sample_regs_user |= SMPL_REG_MASK(PERF_REG_ARM64_VG);
>> +
>> +       /*
>> +        * Check if the pmu supports perf extended regs, before
>> +        * returning the register mask to sample.
>> +        */
> I know this is just a copy-paste but I think it'd be a little more readable as:
> ```
>         /*
>         * Check if the pmu supports perf extended regs, before
>         * returning the register mask to sample. Open the event
>         * on the perf process to check this.
>         */
> ```

Sure. Thanks.


>
>> +       if (attr.sample_regs_user != PERF_REGS_MASK) {
>> +               event_attr_init(&attr);
>> +               fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
> Similarly:
> ```
> fd = sys_perf_event_open(&attr, /*pid=*/0, /*cpu=*/-1,
> /*group_fd=*/-1, /*flags=*/0);
> ```

Sure.


>> +               if (fd != -1) {
>> +                       close(fd);
>> +                       return attr.sample_regs_user;
>> +               }
>> +       }
>> +       return PERF_REGS_MASK;
>> +}
>>
>>  const char *__perf_reg_name_arm64(int id)
>>  {
>> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_arm.c b/tools/perf/util/perf-regs-arch/perf_regs_arm.c
>> index e29d130a587a..184d6e248dfc 100644
>> --- a/tools/perf/util/perf-regs-arch/perf_regs_arm.c
>> +++ b/tools/perf/util/perf-regs-arch/perf_regs_arm.c
>> @@ -1,7 +1,12 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>
>>  #include "../perf_regs.h"
>> -#include "../../../arch/arm/include/uapi/asm/perf_regs.h"
>> +#include "../../arch/arm/include/perf_regs.h"
> Similar comment on PERF_REGS_MASK as above, no action necessary.
>
>> +
>> +uint64_t __perf_reg_mask_arm(bool intr __maybe_unused)
>> +{
>> +       return PERF_REGS_MASK;
>> +}
>>
>>  const char *__perf_reg_name_arm(int id)
>>  {
>> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_csky.c b/tools/perf/util/perf-regs-arch/perf_regs_csky.c
>> index 75b461ef2eba..36cafa6a4c42 100644
>> --- a/tools/perf/util/perf-regs-arch/perf_regs_csky.c
>> +++ b/tools/perf/util/perf-regs-arch/perf_regs_csky.c
>> @@ -1,7 +1,12 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>
>>  #include "../perf_regs.h"
>> -#include "../../arch/csky/include/uapi/asm/perf_regs.h"
>> +#include "../../arch/csky/include/perf_regs.h"
>> +
>> +uint64_t __perf_reg_mask_csky(bool intr __maybe_unused)
>> +{
>> +       return PERF_REGS_MASK;
>> +}
>>
>>  const char *__perf_reg_name_csky(int id)
>>  {
>> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_loongarch.c b/tools/perf/util/perf-regs-arch/perf_regs_loongarch.c
>> index 043f97f4e3ac..478ee889afa1 100644
>> --- a/tools/perf/util/perf-regs-arch/perf_regs_loongarch.c
>> +++ b/tools/perf/util/perf-regs-arch/perf_regs_loongarch.c
>> @@ -1,7 +1,12 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>
>>  #include "../perf_regs.h"
>> -#include "../../../arch/loongarch/include/uapi/asm/perf_regs.h"
>> +#include "../../arch/loongarch/include/perf_regs.h"
>> +
>> +uint64_t __perf_reg_mask_loongarch(bool intr __maybe_unused)
>> +{
>> +       return PERF_REGS_MASK;
>> +}
>>
>>  const char *__perf_reg_name_loongarch(int id)
>>  {
>> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_mips.c b/tools/perf/util/perf-regs-arch/perf_regs_mips.c
>> index 793178fc3c78..c5a475f6ec64 100644
>> --- a/tools/perf/util/perf-regs-arch/perf_regs_mips.c
>> +++ b/tools/perf/util/perf-regs-arch/perf_regs_mips.c
>> @@ -1,7 +1,12 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>
>>  #include "../perf_regs.h"
>> -#include "../../../arch/mips/include/uapi/asm/perf_regs.h"
>> +#include "../../arch/mips/include/perf_regs.h"
>> +
>> +uint64_t __perf_reg_mask_mips(bool intr __maybe_unused)
>> +{
>> +       return PERF_REGS_MASK;
>> +}
>>
>>  const char *__perf_reg_name_mips(int id)
>>  {
>> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c b/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c
>> index 08636bb09a3a..5211cc0c4e81 100644
>> --- a/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c
>> +++ b/tools/perf/util/perf-regs-arch/perf_regs_powerpc.c
>> @@ -1,7 +1,75 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>
>> +#include <errno.h>
>> +#include <string.h>
>> +#include <regex.h>
>> +#include <linux/zalloc.h>
>> +
>> +#include "../debug.h"
>> +#include "../event.h"
>> +#include "../header.h"
>>  #include "../perf_regs.h"
>> -#include "../../../arch/powerpc/include/uapi/asm/perf_regs.h"
>> +#include "../../perf-sys.h"
>> +#include "../../arch/powerpc/util/utils_header.h"
>> +#include "../../arch/powerpc/include/perf_regs.h"
>> +
>> +#include <linux/kernel.h>
>> +
>> +#define PVR_POWER9             0x004E
>> +#define PVR_POWER10            0x0080
>> +#define PVR_POWER11            0x0082
>> +
>> +#if defined(__powerpc64__) && defined(__powerpc__)
> This is morally the same as the arch directory, I'm guessing that
> missing definitions are an issue? Would having the asm #include fix
> this?

The aim of adding this "#if" is to avoid the building error caused by the
"mfspr" instruction which exists only on powerpc. Since the function
__perf_reg_mask_powerpc() would never be called on non-powerpc platforms
right now, I think it should be fine.


>
>> +uint64_t __perf_reg_mask_powerpc(bool intr)
>> +{
>> +       struct perf_event_attr attr = {
>> +               .type                   = PERF_TYPE_HARDWARE,
>> +               .config                 = PERF_COUNT_HW_CPU_CYCLES,
>> +               .sample_type            = PERF_SAMPLE_REGS_INTR,
>> +               .precise_ip             = 1,
>> +               .disabled               = 1,
>> +               .exclude_kernel         = 1,
>> +       };
>> +       int fd;
>> +       u32 version;
>> +       u64 extended_mask = 0, mask = PERF_REGS_MASK;
>> +
>> +       if (!intr)
>> +               return PERF_REGS_MASK;
>> +
>> +       /*
>> +        * Get the PVR value to set the extended
>> +        * mask specific to platform.
>> +        */
>> +       version = (((mfspr(SPRN_PVR)) >>  16) & 0xFFFF);
>> +       if (version == PVR_POWER9)
>> +               extended_mask = PERF_REG_PMU_MASK_300;
>> +       else if ((version == PVR_POWER10) || (version == PVR_POWER11))
>> +               extended_mask = PERF_REG_PMU_MASK_31;
>> +       else
>> +               return mask;
>> +
>> +       attr.sample_regs_intr = extended_mask;
>> +       attr.sample_period = 1;
>> +       event_attr_init(&attr);
>> +
>> +       /*
>> +        * check if the pmu supports perf extended regs, before
>> +        * returning the register mask to sample.
>> +        */
>> +       fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
> This code feels awfully familiar :-) Similar comments to the arm64 case.

Sure.


>
>> +       if (fd != -1) {
>> +               close(fd);
>> +               mask |= extended_mask;
>> +       }
>> +       return mask;
>> +}
>> +#else
>> +uint64_t __perf_reg_mask_powerpc(bool intr __maybe_unused)
>> +{
>> +       return PERF_REGS_MASK;
>> +}
>> +#endif
>>
>>  const char *__perf_reg_name_powerpc(int id)
>>  {
>> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_riscv.c b/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
>> index 337b687c655d..5b5f21fcba8c 100644
>> --- a/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
>> +++ b/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
>> @@ -1,7 +1,12 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>
>>  #include "../perf_regs.h"
>> -#include "../../../arch/riscv/include/uapi/asm/perf_regs.h"
>> +#include "../../arch/riscv/include/perf_regs.h"
>> +
>> +uint64_t __perf_reg_mask_riscv(bool intr __maybe_unused)
>> +{
>> +       return PERF_REGS_MASK;
>> +}
>>
>>  const char *__perf_reg_name_riscv(int id)
>>  {
>> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_s390.c b/tools/perf/util/perf-regs-arch/perf_regs_s390.c
>> index d69bba881080..c61df24edf0f 100644
>> --- a/tools/perf/util/perf-regs-arch/perf_regs_s390.c
>> +++ b/tools/perf/util/perf-regs-arch/perf_regs_s390.c
>> @@ -1,7 +1,12 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>
>>  #include "../perf_regs.h"
>> -#include "../../../arch/s390/include/uapi/asm/perf_regs.h"
>> +#include "../../arch/s390/include/perf_regs.h"
>> +
>> +uint64_t __perf_reg_mask_s390(bool intr __maybe_unused)
>> +{
>> +       return PERF_REGS_MASK;
>> +}
>>
>>  const char *__perf_reg_name_s390(int id)
>>  {
>> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
>> index 708954a9d35d..d319106dc7b2 100644
>> --- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
>> +++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
>> @@ -1,7 +1,65 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>
>> +#include <errno.h>
>> +#include <string.h>
>> +#include <regex.h>
>> +#include <linux/kernel.h>
>> +#include <linux/zalloc.h>
>> +
>> +#include "../debug.h"
>> +#include "../event.h"
>> +#include "../pmu.h"
>> +#include "../pmus.h"
>>  #include "../perf_regs.h"
>> -#include "../../../arch/x86/include/uapi/asm/perf_regs.h"
>> +#include "../../perf-sys.h"
>> +#include "../../arch/x86/include/perf_regs.h"
>> +
>> +uint64_t __perf_reg_mask_x86(bool intr)
>> +{
>> +       struct perf_event_attr attr = {
>> +               .type                   = PERF_TYPE_HARDWARE,
>> +               .config                 = PERF_COUNT_HW_CPU_CYCLES,
>> +               .sample_type            = PERF_SAMPLE_REGS_INTR,
>> +               .sample_regs_intr       = PERF_REG_EXTENDED_MASK,
>> +               .precise_ip             = 1,
>> +               .disabled               = 1,
>> +               .exclude_kernel         = 1,
>> +       };
>> +       int fd;
>> +
>> +       if (!intr)
>> +               return PERF_REGS_MASK;
>> +
>> +       /*
>> +        * In an unnamed union, init it here to build on older gcc versions
>> +        */
>> +       attr.sample_period = 1;
>> +
>> +       if (perf_pmus__num_core_pmus() > 1) {
>> +               struct perf_pmu *pmu = NULL;
>> +               __u64 type = PERF_TYPE_RAW;
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
> It'd be nice not to remember what the magic 0, -1, -1, 0 means :-)

Sure.


>
>> +       if (fd != -1) {
>> +               close(fd);
>> +               return (PERF_REG_EXTENDED_MASK | PERF_REGS_MASK);
>> +       }
>> +
>> +       return PERF_REGS_MASK;
>> +}
>>
>>  const char *__perf_reg_name_x86(int id)
>>  {
>> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
>> index f21148478db1..900929cff4b5 100644
>> --- a/tools/perf/util/perf_regs.c
>> +++ b/tools/perf/util/perf_regs.c
>> @@ -13,14 +13,86 @@ int __weak arch_sdt_arg_parse_op(char *old_op __maybe_unused,
>>         return SDT_ARG_SKIP;
>>  }
>>
>> -uint64_t __weak arch__intr_reg_mask(void)
>> +uint64_t perf_intr_reg_mask(uint16_t e_machine)
>>  {
>> -       return 0;
>> +       uint64_t mask = 0;
>> +
>> +       switch (e_machine) {
>> +       case EM_ARM:
>> +               mask = __perf_reg_mask_arm(/*intr=*/true);
>> +               break;
>> +       case EM_AARCH64:
>> +               mask = __perf_reg_mask_arm64(/*intr=*/true);
>> +               break;
>> +       case EM_CSKY:
>> +               mask = __perf_reg_mask_csky(/*intr=*/true);
>> +               break;
>> +       case EM_LOONGARCH:
>> +               mask = __perf_reg_mask_loongarch(/*intr=*/true);
>> +               break;
>> +       case EM_MIPS:
>> +               mask = __perf_reg_mask_mips(/*intr=*/true);
>> +               break;
>> +       case EM_PPC:
>> +       case EM_PPC64:
>> +               mask = __perf_reg_mask_powerpc(/*intr=*/true);
>> +               break;
>> +       case EM_RISCV:
>> +               mask = __perf_reg_mask_riscv(/*intr=*/true);
>> +               break;
>> +       case EM_S390:
>> +               mask = __perf_reg_mask_s390(/*intr=*/true);
>> +               break;
>> +       case EM_386:
>> +       case EM_X86_64:
>> +               mask = __perf_reg_mask_x86(/*intr=*/true);
>> +               break;
>> +       default:
> Probably worth a debug statement here, like:
> pr_debug("Unknown ELF machine %d, interrupt sampling register mask
> will be empty.\n");

Sure. 


>
>> +               break;
>> +       }
>> +
>> +       return mask;
>>  }
>>
>> -uint64_t __weak arch__user_reg_mask(void)
>> +uint64_t perf_user_reg_mask(uint16_t e_machine)
>>  {
>> -       return 0;
>> +       uint64_t mask = 0;
>> +
>> +       switch (e_machine) {
>> +       case EM_ARM:
>> +               mask = __perf_reg_mask_arm(/*intr=*/false);
>> +               break;
>> +       case EM_AARCH64:
>> +               mask = __perf_reg_mask_arm64(/*intr=*/false);
>> +               break;
>> +       case EM_CSKY:
>> +               mask = __perf_reg_mask_csky(/*intr=*/false);
>> +               break;
>> +       case EM_LOONGARCH:
>> +               mask = __perf_reg_mask_loongarch(/*intr=*/false);
>> +               break;
>> +       case EM_MIPS:
>> +               mask = __perf_reg_mask_mips(/*intr=*/false);
>> +               break;
>> +       case EM_PPC:
>> +       case EM_PPC64:
>> +               mask = __perf_reg_mask_powerpc(/*intr=*/false);
>> +               break;
>> +       case EM_RISCV:
>> +               mask = __perf_reg_mask_riscv(/*intr=*/false);
>> +               break;
>> +       case EM_S390:
>> +               mask = __perf_reg_mask_s390(/*intr=*/false);
>> +               break;
>> +       case EM_386:
>> +       case EM_X86_64:
>> +               mask = __perf_reg_mask_x86(/*intr=*/false);
>> +               break;
>> +       default:
> Similarly:
> pr_debug("Unknown ELF machine %d, user sampling register mask will be
> empty.\n");

Sure. Thanks.


>
> Thanks!
> Ian
>
>> +               break;
>> +       }
>> +
>> +       return mask;
>>  }
>>
>>  const char *perf_reg_name(int id, uint16_t e_machine)
>> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
>> index 2c2a8de6912d..8531584bc1b1 100644
>> --- a/tools/perf/util/perf_regs.h
>> +++ b/tools/perf/util/perf_regs.h
>> @@ -13,37 +13,55 @@ enum {
>>  };
>>
>>  int arch_sdt_arg_parse_op(char *old_op, char **new_op);
>> -uint64_t arch__intr_reg_mask(void);
>> -uint64_t arch__user_reg_mask(void);
>> +uint64_t perf_intr_reg_mask(uint16_t e_machine);
>> +uint64_t perf_user_reg_mask(uint16_t e_machine);
>>
>>  const char *perf_reg_name(int id, uint16_t e_machine);
>>  int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
>>  uint64_t perf_arch_reg_ip(uint16_t e_machine);
>>  uint64_t perf_arch_reg_sp(uint16_t e_machine);
>> +
>> +uint64_t __perf_reg_mask_arm64(bool intr);
>>  const char *__perf_reg_name_arm64(int id);
>>  uint64_t __perf_reg_ip_arm64(void);
>>  uint64_t __perf_reg_sp_arm64(void);
>> +
>> +uint64_t __perf_reg_mask_arm(bool intr);
>>  const char *__perf_reg_name_arm(int id);
>>  uint64_t __perf_reg_ip_arm(void);
>>  uint64_t __perf_reg_sp_arm(void);
>> +
>> +uint64_t __perf_reg_mask_csky(bool intr);
>>  const char *__perf_reg_name_csky(int id);
>>  uint64_t __perf_reg_ip_csky(void);
>>  uint64_t __perf_reg_sp_csky(void);
>> +
>> +uint64_t __perf_reg_mask_loongarch(bool intr);
>>  const char *__perf_reg_name_loongarch(int id);
>>  uint64_t __perf_reg_ip_loongarch(void);
>>  uint64_t __perf_reg_sp_loongarch(void);
>> +
>> +uint64_t __perf_reg_mask_mips(bool intr);
>>  const char *__perf_reg_name_mips(int id);
>>  uint64_t __perf_reg_ip_mips(void);
>>  uint64_t __perf_reg_sp_mips(void);
>> +
>> +uint64_t __perf_reg_mask_powerpc(bool intr);
>>  const char *__perf_reg_name_powerpc(int id);
>>  uint64_t __perf_reg_ip_powerpc(void);
>>  uint64_t __perf_reg_sp_powerpc(void);
>> +
>> +uint64_t __perf_reg_mask_riscv(bool intr);
>>  const char *__perf_reg_name_riscv(int id);
>>  uint64_t __perf_reg_ip_riscv(void);
>>  uint64_t __perf_reg_sp_riscv(void);
>> +
>> +uint64_t __perf_reg_mask_s390(bool intr);
>>  const char *__perf_reg_name_s390(int id);
>>  uint64_t __perf_reg_ip_s390(void);
>>  uint64_t __perf_reg_sp_s390(void);
>> +
>> +uint64_t __perf_reg_mask_x86(bool intr);
>>  const char *__perf_reg_name_x86(int id);
>>  uint64_t __perf_reg_ip_x86(void);
>>  uint64_t __perf_reg_sp_x86(void);
>> --
>> 2.34.1
>>
