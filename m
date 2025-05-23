Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB44E22338;
	Fri, 23 May 2025 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748022506; cv=none; b=ZIyf6oqN1bkPe7EonYTm7s5PbJgpL+2KOu1pl+H/BAjEGsXpY4mr++6HlGhOR1py87coxHbvCzYllf8FhDu4aWVjkcPY9qxY4HxeqAjcMePLerDxKOF7D8pVJWTxsOZuLXyb/Xc8YgvxAz5N5NFA1fE+iil2bL28PZM7eJTk6zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748022506; c=relaxed/simple;
	bh=AqUynDC3Sw8C6ZtTMriTAeGFMTNBji4jXiQmc/rbw2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1yIC3caKW9BqaZjR2EMzdmTrPJIxNGgnPm5RSpE/YC29dyeng/CYNGgkrIdiwOVvzwGe318PmZIrGLlfCFUlTX7XEEyudse22VL0hkET/W5S8QFVTsgfVRYa0YmVd8uod6DFSRfy7aahh13zsDAQkKPwC5L25Ut9zTOgjs1Bgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uj1T2rMY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uj1T2rMY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748022504; x=1779558504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AqUynDC3Sw8C6ZtTMriTAeGFMTNBji4jXiQmc/rbw2o=;
  b=Uj1T2rMYNnVhnHXtN/RnP04tZ1CWrrf6meRJMiClT/em1VWtJgTL9MDX
   DYzGHU8S4kF5p6FvlsvT5KyQnsip+ucOzPvuvE7Ug/NXkWsOAcB7+sk2E
   V3KM52bnREc+oTfqB3hB1II/GuECO/LFiUquQuKyhR8nbjUyvNb1lcg7K
   6qKIoBcsLRQWZcuXncz3B1CUmW8ck63tvAsnn+cN8Ioaomh15KWwQp4qd
   827m8XptPtTyysZtCOS17M2rZsxulhZqywvgHLra6x9iVR2+DnOIlbF7Z
   4Vbk88w/ZXogxcAjJHCDCx9fpDbVhop8uW/lqA09aTJhbAJfS++vzNigE
   g==;
X-CSE-ConnectionGUID: jugNgIZWQ066tu/rZ/IvjA==
X-CSE-MsgGUID: AYASXsoTTJCzt7KzI7G55g==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="37712255"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="37712255"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 10:48:24 -0700
X-CSE-ConnectionGUID: lJrSde5yS5yz0+ah3FyjYQ==
X-CSE-MsgGUID: VO9IXjEZT1W8X0PcYRPbOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="141740316"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 23 May 2025 10:48:18 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIWVD-000QdI-2N;
	Fri, 23 May 2025 17:48:15 +0000
Date: Sat, 24 May 2025 01:48:04 +0800
From: kernel test robot <lkp@intel.com>
To: Rajnesh Kanwal <rkanwal@rivosinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Beeman Strong <beeman@rivosinc.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Rajnesh Kanwal <rkanwal@rivosinc.com>
Subject: Re: [PATCH v3 5/7] riscv: pmu: Add driver for Control Transfer
 Records Ext.
Message-ID: <202505240131.OJkUGGvA-lkp@intel.com>
References: <20250523-b4-ctr_upstream_v3-v3-5-ad355304ba1c@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523-b4-ctr_upstream_v3-v3-5-ad355304ba1c@rivosinc.com>

Hi Rajnesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on e0200e37637e573cd68f522ecd550be87e304c6c]

url:    https://github.com/intel-lab-lkp/linux/commits/Rajnesh-Kanwal/perf-Increase-the-maximum-number-of-branches-remove_loops-can-process/20250523-073341
base:   e0200e37637e573cd68f522ecd550be87e304c6c
patch link:    https://lore.kernel.org/r/20250523-b4-ctr_upstream_v3-v3-5-ad355304ba1c%40rivosinc.com
patch subject: [PATCH v3 5/7] riscv: pmu: Add driver for Control Transfer Records Ext.
config: riscv-randconfig-002-20250523 (https://download.01.org/0day-ci/archive/20250524/202505240131.OJkUGGvA-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250524/202505240131.OJkUGGvA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505240131.OJkUGGvA-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/riscv/kernel/asm-offsets.c:12:
   In file included from arch/riscv/include/asm/kvm_host.h:23:
   In file included from arch/riscv/include/asm/kvm_vcpu_pmu.h:12:
>> include/linux/perf/riscv_pmu.h:156:76: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
     156 | static inline void riscv_pmu_ctr_sched_task(struct perf_event_pmu_context *,
         |                                                                            ^
   include/linux/perf/riscv_pmu.h:158:13: warning: unused function 'riscv_pmu_ctr_add' [-Wunused-function]
     158 | static void riscv_pmu_ctr_add(struct perf_event *event) { }
         |             ^~~~~~~~~~~~~~~~~
   include/linux/perf/riscv_pmu.h:159:13: warning: unused function 'riscv_pmu_ctr_del' [-Wunused-function]
     159 | static void riscv_pmu_ctr_del(struct perf_event *event) { }
         |             ^~~~~~~~~~~~~~~~~
   3 warnings generated.
--
   In file included from arch/riscv/kernel/asm-offsets.c:12:
   In file included from arch/riscv/include/asm/kvm_host.h:23:
   In file included from arch/riscv/include/asm/kvm_vcpu_pmu.h:12:
>> include/linux/perf/riscv_pmu.h:156:76: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
     156 | static inline void riscv_pmu_ctr_sched_task(struct perf_event_pmu_context *,
         |                                                                            ^
   include/linux/perf/riscv_pmu.h:158:13: warning: unused function 'riscv_pmu_ctr_add' [-Wunused-function]
     158 | static void riscv_pmu_ctr_add(struct perf_event *event) { }
         |             ^~~~~~~~~~~~~~~~~
   include/linux/perf/riscv_pmu.h:159:13: warning: unused function 'riscv_pmu_ctr_del' [-Wunused-function]
     159 | static void riscv_pmu_ctr_del(struct perf_event *event) { }
         |             ^~~~~~~~~~~~~~~~~
   3 warnings generated.


vim +156 include/linux/perf/riscv_pmu.h

   152	
   153	static inline bool riscv_pmu_ctr_valid(struct perf_event *event) { return false; }
   154	static inline void riscv_pmu_ctr_consume(struct cpu_hw_events *cpuc,
   155					      struct perf_event *event) { }
 > 156	static inline void riscv_pmu_ctr_sched_task(struct perf_event_pmu_context *,
   157						    bool sched_in) { }
   158	static void riscv_pmu_ctr_add(struct perf_event *event) { }
   159	static void riscv_pmu_ctr_del(struct perf_event *event) { }
   160	static inline void riscv_pmu_ctr_enable(struct perf_event *event) { }
   161	static inline void riscv_pmu_ctr_disable(struct perf_event *event) { }
   162	static inline void riscv_pmu_ctr_dying_cpu(void) { }
   163	static inline void riscv_pmu_ctr_starting_cpu(void) { }
   164	static inline int riscv_pmu_ctr_init(struct riscv_pmu *riscv_pmu) { return 0; }
   165	static inline void riscv_pmu_ctr_finish(struct riscv_pmu *riscv_pmu) { }
   166	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
