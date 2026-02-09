Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675AF3C1F;
	Mon,  9 Feb 2026 00:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770597980; cv=none; b=LH6TqsJR6rkMWZacNQqYsHiPCPDpwz7qblrHJyCPt+VDEKNXD4sqoLiI25HpSh8LFtYCOCcxF91oV4zaOfvIfWdAtF1CJxnmgHit0lo+Qf+1k9YbJP5tciGBdsxZVJSj1nLfAMavPFiwqjtJPfNmrREurHmr9JSIiWOqKwp60mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770597980; c=relaxed/simple;
	bh=WiDvGdY9/hMNal5D7v3aKwx1iH+Txlyos/k45ceIkMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHBMIUXHKNQrCWixghPJoVtHPgn4XbIhtwxvuX0PhOWdeZCcYTIFpv76WpfHqUqJfZbO6GjgjS7faiAYdMnTjkADkZnQ5HEOx1monEjiIGHj9nvuBJtYcyy8mCHZ7h+KQ1elZXmMNgVQCIRanmnkFj94/1SnJHmE9uzFYb+Y4Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQJ1CUpG; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQJ1CUpG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770597980; x=1802133980;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WiDvGdY9/hMNal5D7v3aKwx1iH+Txlyos/k45ceIkMs=;
  b=FQJ1CUpGUGSQCRmY5Je2eStNom/D/pk76XiE3x6eAKGh6jGMzUlRsCxH
   cKNeUqzVXNo2H6gQVsPqiE3Y913lz0MAG4rid9qfJTucB4N5IU0QrH953
   pk+hVaZcsbGxAGnqxME2z0m8oEvrtyuaNkrlmteietNzlAguIiPinBasL
   6Myhu5YTeyXP3ovIjIWWhkG+cKq17AKe0EwAAG4NirHd4aDatO12lttUV
   Q/xO1EpdlPWfiHJbH6T1l1JE19m89b53dy7YbQPgQhlYTa1xvbTihgxCe
   D25fMktDKN4Y2QuBa9t5xg7gkMgj9vFb05OTh56Qpb42bOP2/3bgHWqWB
   g==;
X-CSE-ConnectionGUID: Xlga/HaKRkCUB/sR8HzH7A==
X-CSE-MsgGUID: WrkIHC2mSl6z+fv00e0pOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="71773835"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="71773835"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 16:46:20 -0800
X-CSE-ConnectionGUID: JaHt4qN4Tm2qb/1Ezcgd0Q==
X-CSE-MsgGUID: h53wmeBVTmqur7ngxWel6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="242064508"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 16:46:13 -0800
Message-ID: <d406166d-27ff-413f-9b35-fa7aaec1b886@linux.intel.com>
Date: Mon, 9 Feb 2026 08:46:11 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 0/4] Perf tools: perf-regs bug fix and optimization
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
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
References: <20260203024356.444942-1-dapeng1.mi@linux.intel.com>
 <aYYGA_Mo1ppwdTH0@x1>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aYYGA_Mo1ppwdTH0@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/6/2026 11:17 PM, Arnaldo Carvalho de Melo wrote:
> On Tue, Feb 03, 2026 at 10:43:52AM +0800, Dapeng Mi wrote:
>> Changes:
>>  v2 -> v3:
>>   * Fix the abort issue for "-I" or "--user-regs" options. (Patch 1/4)
>>   * Address Ian's comments.
> Fixed up somme fuzz with powerpc, x86, riscv and s390  Build files wrt
> removing perf_regs.o

Thanks. 

>
> Thanks, applied to perf-tools-next,
>
> - Arnaldo
>  
>>  v1 -> v2:
>>   * Fixing "PERF_REG_EXTENDED_MASK" redefinition building error by
>>     changing the "asm/perf_regs.h" header path to relative UAPI path.
>>     (Patch 1/3)
>>   * Spliting xxx_reg_mask() and xxx_sdt_arg_parse_op() conversion into 2
>>     patches.
>>
>> This patch-set remove the below three architecture specific __weak
>> functions and converted them into the general architecture specific
>> functions which are dispatched base on "em_machine".
>>
>> uint64_t arch__intr_reg_mask(void);
>> uint64_t arch__user_reg_mask(void);
>> int arch_sdt_arg_parse_op(char *old_op, char **new_op);
>>
>> The advantage of this conversion is that these architectural functions
>> can be called even for a different architecture with host instead of
>> only called on the host architecture.
>>
>> Although the converted functions shown below can be called on any
>> architecture, currently they are still only called for the host
>> architecture (EM_HOST).
>>
>> int perf_sdt_arg_parse_op(uint16_t e_machine, char *old_op, char **new_op);
>> uint64_t perf_intr_reg_mask(uint16_t e_machine);
>> uint64_t perf_user_reg_mask(uint16_t e_machine);
>>
>> Tests:
>>   * This patch-set is only tested on x86 platforms. No issues are found
>>     for both intr-regs and user-regs options.
>>   * Tests on other architectures are welcomed and appreciated.
>>
>> History:
>>   v1: https://lore.kernel.org/all/20260123090938.2222960-1-dapeng1.mi@linux.intel.com/
>>   v2: https://lore.kernel.org/all/20260127070259.2720468-1-dapeng1.mi@linux.intel.com/
>>
>> Dapeng Mi (4):
>>   perf regs: Fix abort for "-I" or "--user-regs" options
>>   perf arch: Update arch headers to use relative UAPI paths
>>   perf regs: Remove __weak attributive arch__xxx_reg_mask() functions
>>   perf regs: Remove __weak attributive arch_sdt_arg_parse_op() function
>>
>>  tools/perf/arch/arm/include/perf_regs.h       |   2 +-
>>  tools/perf/arch/arm/util/Build                |   2 -
>>  tools/perf/arch/arm/util/perf_regs.c          |  13 -
>>  tools/perf/arch/arm64/include/perf_regs.h     |   2 +-
>>  tools/perf/arch/arm64/util/Build              |   1 -
>>  tools/perf/arch/arm64/util/perf_regs.c        | 141 ---------
>>  tools/perf/arch/csky/Build                    |   1 -
>>  tools/perf/arch/csky/include/perf_regs.h      |   2 +-
>>  tools/perf/arch/csky/util/Build               |   1 -
>>  tools/perf/arch/csky/util/perf_regs.c         |  13 -
>>  tools/perf/arch/loongarch/include/perf_regs.h |   2 +-
>>  tools/perf/arch/loongarch/util/Build          |   1 -
>>  tools/perf/arch/loongarch/util/perf_regs.c    |  13 -
>>  tools/perf/arch/mips/include/perf_regs.h      |   2 +-
>>  tools/perf/arch/mips/util/Build               |   1 -
>>  tools/perf/arch/mips/util/perf_regs.c         |  13 -
>>  tools/perf/arch/powerpc/include/perf_regs.h   |   2 +-
>>  tools/perf/arch/powerpc/util/Build            |   1 -
>>  tools/perf/arch/powerpc/util/perf_regs.c      | 172 -----------
>>  tools/perf/arch/riscv/include/perf_regs.h     |   9 +-
>>  tools/perf/arch/riscv/util/Build              |   1 -
>>  tools/perf/arch/riscv/util/perf_regs.c        |  13 -
>>  tools/perf/arch/s390/include/perf_regs.h      |   2 +-
>>  tools/perf/arch/s390/util/Build               |   1 -
>>  tools/perf/arch/s390/util/perf_regs.c         |  13 -
>>  tools/perf/arch/x86/include/perf_regs.h       |   2 +-
>>  tools/perf/arch/x86/util/Build                |   1 -
>>  tools/perf/arch/x86/util/perf_regs.c          | 283 ------------------
>>  tools/perf/util/evsel.c                       |   4 +-
>>  tools/perf/util/parse-regs-options.c          |  13 +-
>>  .../util/perf-regs-arch/perf_regs_aarch64.c   | 139 ++++++++-
>>  .../perf/util/perf-regs-arch/perf_regs_arm.c  |   7 +-
>>  .../perf/util/perf-regs-arch/perf_regs_csky.c |   7 +-
>>  .../util/perf-regs-arch/perf_regs_loongarch.c |   7 +-
>>  .../perf/util/perf-regs-arch/perf_regs_mips.c |   7 +-
>>  .../util/perf-regs-arch/perf_regs_powerpc.c   | 183 ++++++++++-
>>  .../util/perf-regs-arch/perf_regs_riscv.c     |   7 +-
>>  .../perf/util/perf-regs-arch/perf_regs_s390.c |   7 +-
>>  .../perf/util/perf-regs-arch/perf_regs_x86.c  | 281 ++++++++++++++++-
>>  tools/perf/util/perf_regs.c                   | 109 ++++++-
>>  tools/perf/util/perf_regs.h                   |  27 +-
>>  tools/perf/util/probe-file.c                  |   3 +-
>>  42 files changed, 787 insertions(+), 724 deletions(-)
>>  delete mode 100644 tools/perf/arch/arm/util/perf_regs.c
>>  delete mode 100644 tools/perf/arch/arm64/util/perf_regs.c
>>  delete mode 100644 tools/perf/arch/csky/Build
>>  delete mode 100644 tools/perf/arch/csky/util/Build
>>  delete mode 100644 tools/perf/arch/csky/util/perf_regs.c
>>  delete mode 100644 tools/perf/arch/loongarch/util/perf_regs.c
>>  delete mode 100644 tools/perf/arch/mips/util/perf_regs.c
>>  delete mode 100644 tools/perf/arch/powerpc/util/perf_regs.c
>>  delete mode 100644 tools/perf/arch/riscv/util/perf_regs.c
>>  delete mode 100644 tools/perf/arch/s390/util/perf_regs.c
>>  delete mode 100644 tools/perf/arch/x86/util/perf_regs.c
>>
>> -- 
>> 2.34.1
>>
