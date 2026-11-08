Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098622;
	b=25VHUQOv2neOo6pi93tRyINRaguSO5ZGTh52lzx9y1qFmr9iq8N6JzBGO80anKeJHAWE
	 edKhqcTiN9/AFIsBgNGymwltpZNVl+Nq8TNKrY96Q16+X4WVbhrjfzXJO1C1tz/gDkqwS
	 3qo9zTp/cWXbXG2wMruZGh1RlfcqUBsbKL7U5R/lX8x4H6ZX1e/u99nxA6QXKXm+wGgRy
	 Km/2D8iwZyEb3fAQHXWP/UgPvlCBQ9/PUYVV205wqp+WS6oiwIGp7wTMlQPsaox+fvKEj
	 9t5IRX+DyrOolR1i6q5VaGIGsPaDvzVmUgB63DMttUkmn4KxjKd8JUGVrkEZX9KjGzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098622;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=rG3sxFXQs2YwfYo04qJv9bFe1Lf+g5QXDbyEwDUCygI=;
	b=AriZiu/IjSpeee2wXFO+0aHUHfc4tjE8EwYBIVkVsPIM+Nv8Bx4jlc9N2y7LGnzNI0vH
	 PRgNCOwRtwYPj1mBcBc1KTCAJictsYRhVu4iHKEhNrZey6khBxZZELMJO9sN2QspoZ+Bw
	 R47b9xBLfbNwgo/Bj6AIcEG1oZTMXPKvl7uVDok+LrH3Ex+mZxcPNxSN2RnPSgbciAfQ8
	 99wKEfepnE9Ij+kGKCZv4B2GhmNWoyJ1pqa6uDnWi3Iyb+joet2Lz+z0iczzrvrGqdgbH
	 zTvNdnStfkzVR/A+/gptE6N0uHlAr+PLnWJLx3/h4xqkWjpbSJEUnK/sqT2xXK4fx4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MuzKtUZL;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFDD606A326;
	Sun,  8 Nov 2026 00:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DFDD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MuzKtUZL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794098621; x=1825634621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ck1edxgvk3BDD0VbuIuludWk8bM0SgopvTgDhybmkbE=;
  b=MuzKtUZLwzSl6Bry9hNCpHIQBa6cu93a3yRuhYe0x+vS8J6Jqvk3x4tw
   UyWxOzDdq8OZ60vo8c3Y+mORWljCVS1Pj+3mzABUktJy37EHMDQI/r6zF
   UXxmWQ46hbTpCAQAXOt3EwyQd3gFX+vHgPCHiK6dGz2I+DqSKNxcWLLCk
   LG027cVduu0EPdeAKE80iV/QmYQw27D1d7/QA5UGPrv7BmEzwlg3Q0BRq
   iLytVtt2d2lD9d0IluNQ6NjItqfx/dUK6S8H7el4Q0ccy4voQYN4gcbTh
   ZMdI7gE3/fvutqMIDkShUoila5rnOeGYOCFf+mWLWKJndmMzyBi+r3U9G
   A==;
X-CSE-ConnectionGUID: LstQH8tlR8y74zLHwc65tw==
X-CSE-MsgGUID: rmh/Co06Q4S23pe/2j1GRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11959"; a="2873233"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2873233"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2026 16:43:40 -0800
X-CSE-ConnectionGUID: cJ2oaVP4Rjm6gYOnPiOqgQ==
X-CSE-MsgGUID: hal4leBYT4ysdlFNdJJdIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7702949"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Nov 2026 16:43:37 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPr0P-00000000rqx-2znG;
	Sun, 08 Nov 2026 00:43:33 +0000
Date: Sun, 8 Nov 2026 08:42:38 +0800
From: kernel test robot <lkp@intel.com>
To: Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
	Marc Zyngier <maz@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	Yuvan Shen <yuvanshen09@gmail.com>,
	Myria Sarvay <myrialsarvay@gmail.com>
Subject: Re: [PATCH v2 06/15] drivers/perf: apple_m1: Add Apple M3 Series
 Support
Message-ID: <202611080830.Uv6E9OCL-lkp@intel.com>
References: <20261107-m3-plus-pmu-events-v2-6-acf1e78da039@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107-m3-plus-pmu-events-v2-6-acf1e78da039@gmail.com>

Hi Myria,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 84a1163b0a3ec0acdda113d4c920ed72955dd6e8]

url:    https://github.com/intel-lab-lkp/linux/commits/Myria-Sarvay-via-B4-Relay/dt-bindings-arm-pmu-Add-Apple-M3-M4-A18-Pro-SoC-CPU-PMU-compatibles/20261107-214848
base:   84a1163b0a3ec0acdda113d4c920ed72955dd6e8
patch link:    https://lore.kernel.org/r/20261107-m3-plus-pmu-events-v2-6-acf1e78da039%40gmail.com
patch subject: [PATCH v2 06/15] drivers/perf: apple_m1: Add Apple M3 Series Support
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20261108/202611080830.Uv6E9OCL-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261108/202611080830.Uv6E9OCL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611080830.Uv6E9OCL-lkp@intel.com/

All warnings (new ones prefixed by >>):

         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:285:51: note: (near initialization for 'm1_pmu_perf_map[5]')
   drivers/perf/apple_m1_cpu_pmu.c:290:51: warning: initialized field overwritten [-Woverride-init]
     290 |         [PERF_COUNT_HW_CPU_CYCLES]              = M3_PMU_PERFCTR_CORE_ACTIVE_CYCLE,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:290:51: note: (near initialization for 'm3_pmu_perf_map[0]')
   drivers/perf/apple_m1_cpu_pmu.c:291:51: warning: initialized field overwritten [-Woverride-init]
     291 |         [PERF_COUNT_HW_INSTRUCTIONS]            = M3_PMU_PERFCTR_INST_ALL,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:291:51: note: (near initialization for 'm3_pmu_perf_map[1]')
   drivers/perf/apple_m1_cpu_pmu.c:292:51: warning: initialized field overwritten [-Woverride-init]
     292 |         [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]     = M3_PMU_PERFCTR_INST_BRANCH,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:292:51: note: (near initialization for 'm3_pmu_perf_map[4]')
   drivers/perf/apple_m1_cpu_pmu.c:293:51: warning: initialized field overwritten [-Woverride-init]
     293 |         [PERF_COUNT_HW_BRANCH_MISSES]           = M3_PMU_PERFCTR_BRANCH_MISPRED_NONSPEC,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:293:51: note: (near initialization for 'm3_pmu_perf_map[5]')
   drivers/perf/apple_m1_cpu_pmu.c:297:51: warning: initialized field overwritten [-Woverride-init]
     297 |         [ARMV8_PMUV3_PERFCTR_##pmuv3_event]     = M1_PMU_PERFCTR_##m1_event
         |                                                   ^~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:304:9: note: in expansion of macro 'M1_PMUV3_EVENT_MAP'
     304 |         M1_PMUV3_EVENT_MAP(INST_RETIRED,        INST_ALL),
         |         ^~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:297:51: note: (near initialization for 'm1_pmu_pmceid_map[8]')
   drivers/perf/apple_m1_cpu_pmu.c:304:9: note: in expansion of macro 'M1_PMUV3_EVENT_MAP'
     304 |         M1_PMUV3_EVENT_MAP(INST_RETIRED,        INST_ALL),
         |         ^~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:297:51: warning: initialized field overwritten [-Woverride-init]
     297 |         [ARMV8_PMUV3_PERFCTR_##pmuv3_event]     = M1_PMU_PERFCTR_##m1_event
         |                                                   ^~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:305:9: note: in expansion of macro 'M1_PMUV3_EVENT_MAP'
     305 |         M1_PMUV3_EVENT_MAP(CPU_CYCLES,          CORE_ACTIVE_CYCLE),
         |         ^~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:297:51: note: (near initialization for 'm1_pmu_pmceid_map[17]')
   drivers/perf/apple_m1_cpu_pmu.c:305:9: note: in expansion of macro 'M1_PMUV3_EVENT_MAP'
     305 |         M1_PMUV3_EVENT_MAP(CPU_CYCLES,          CORE_ACTIVE_CYCLE),
         |         ^~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:297:51: warning: initialized field overwritten [-Woverride-init]
     297 |         [ARMV8_PMUV3_PERFCTR_##pmuv3_event]     = M1_PMU_PERFCTR_##m1_event
         |                                                   ^~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:306:9: note: in expansion of macro 'M1_PMUV3_EVENT_MAP'
     306 |         M1_PMUV3_EVENT_MAP(BR_RETIRED,          INST_BRANCH),
         |         ^~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:297:51: note: (near initialization for 'm1_pmu_pmceid_map[33]')
   drivers/perf/apple_m1_cpu_pmu.c:306:9: note: in expansion of macro 'M1_PMUV3_EVENT_MAP'
     306 |         M1_PMUV3_EVENT_MAP(BR_RETIRED,          INST_BRANCH),
         |         ^~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:297:51: warning: initialized field overwritten [-Woverride-init]
     297 |         [ARMV8_PMUV3_PERFCTR_##pmuv3_event]     = M1_PMU_PERFCTR_##m1_event
         |                                                   ^~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:307:9: note: in expansion of macro 'M1_PMUV3_EVENT_MAP'
     307 |         M1_PMUV3_EVENT_MAP(BR_MIS_PRED_RETIRED, BRANCH_MISPRED_NONSPEC),
         |         ^~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:297:51: note: (near initialization for 'm1_pmu_pmceid_map[34]')
   drivers/perf/apple_m1_cpu_pmu.c:307:9: note: in expansion of macro 'M1_PMUV3_EVENT_MAP'
     307 |         M1_PMUV3_EVENT_MAP(BR_MIS_PRED_RETIRED, BRANCH_MISPRED_NONSPEC),
         |         ^~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:300:51: warning: initialized field overwritten [-Woverride-init]
     300 |         [ARMV8_PMUV3_PERFCTR_##pmuv3_event]     = M3_PMU_PERFCTR_##m3_event
         |                                                   ^~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:312:9: note: in expansion of macro 'M3_PMUV3_EVENT_MAP'
     312 |         M3_PMUV3_EVENT_MAP(INST_RETIRED,        INST_ALL),
         |         ^~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:300:51: note: (near initialization for 'm3_pmu_pmceid_map[8]')
   drivers/perf/apple_m1_cpu_pmu.c:312:9: note: in expansion of macro 'M3_PMUV3_EVENT_MAP'
     312 |         M3_PMUV3_EVENT_MAP(INST_RETIRED,        INST_ALL),
         |         ^~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:300:51: warning: initialized field overwritten [-Woverride-init]
     300 |         [ARMV8_PMUV3_PERFCTR_##pmuv3_event]     = M3_PMU_PERFCTR_##m3_event
         |                                                   ^~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:313:9: note: in expansion of macro 'M3_PMUV3_EVENT_MAP'
     313 |         M3_PMUV3_EVENT_MAP(CPU_CYCLES,          CORE_ACTIVE_CYCLE),
         |         ^~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:300:51: note: (near initialization for 'm3_pmu_pmceid_map[17]')
   drivers/perf/apple_m1_cpu_pmu.c:313:9: note: in expansion of macro 'M3_PMUV3_EVENT_MAP'
     313 |         M3_PMUV3_EVENT_MAP(CPU_CYCLES,          CORE_ACTIVE_CYCLE),
         |         ^~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:300:51: warning: initialized field overwritten [-Woverride-init]
     300 |         [ARMV8_PMUV3_PERFCTR_##pmuv3_event]     = M3_PMU_PERFCTR_##m3_event
         |                                                   ^~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:314:9: note: in expansion of macro 'M3_PMUV3_EVENT_MAP'
     314 |         M3_PMUV3_EVENT_MAP(BR_RETIRED,          INST_BRANCH),
         |         ^~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:300:51: note: (near initialization for 'm3_pmu_pmceid_map[33]')
   drivers/perf/apple_m1_cpu_pmu.c:314:9: note: in expansion of macro 'M3_PMUV3_EVENT_MAP'
     314 |         M3_PMUV3_EVENT_MAP(BR_RETIRED,          INST_BRANCH),
         |         ^~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:300:51: warning: initialized field overwritten [-Woverride-init]
     300 |         [ARMV8_PMUV3_PERFCTR_##pmuv3_event]     = M3_PMU_PERFCTR_##m3_event
         |                                                   ^~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:315:9: note: in expansion of macro 'M3_PMUV3_EVENT_MAP'
     315 |         M3_PMUV3_EVENT_MAP(BR_MIS_PRED_RETIRED, BRANCH_MISPRED_NONSPEC),
         |         ^~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:300:51: note: (near initialization for 'm3_pmu_pmceid_map[34]')
   drivers/perf/apple_m1_cpu_pmu.c:315:9: note: in expansion of macro 'M3_PMUV3_EVENT_MAP'
     315 |         M3_PMUV3_EVENT_MAP(BR_MIS_PRED_RETIRED, BRANCH_MISPRED_NONSPEC),
         |         ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/build_bug.h:5,
                    from include/linux/bits.h:30:
>> include/linux/compiler.h:200:59: warning: anonymous struct declared inside parameter list will not be visible outside of this definition or declaration
     200 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                           ^~~~~~
   include/linux/build_bug.h:17:9: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
      17 |         __BUILD_BUG_ON_ZERO_MSG(e, ##__VA_ARGS__, #e " is true")
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:34:35: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
      34 | #define GENMASK_INPUT_CHECK(h, l) BUILD_BUG_ON_ZERO(const_true((l) > (h)))
         |                                   ^~~~~~~~~~~~~~~~~
   include/linux/bits.h:47:14: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      47 |         ((t)(GENMASK_INPUT_CHECK(h, l) +                        \
         |              ^~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:24:41: note: in expansion of macro 'GENMASK'
      24 | #define M1_PMU_CFG_EVENT                GENMASK(7, 0)
         |                                         ^~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:705:65: note: in expansion of macro 'M1_PMU_CFG_EVENT'
     705 |                                      const u16 event_affinities[M1_PMU_CFG_EVENT + 1])
         |                                                                 ^~~~~~~~~~~~~~~~


vim +200 include/linux/compiler.h

230fa253df6352a Christian Borntraeger 2014-11-25  196  
cb7380de9e4cbc9 Kees Cook             2025-02-05  197  #ifdef __CHECKER__
243c90e917f5cfc Vincent Mailhol       2025-03-29  198  #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) (0)
cb7380de9e4cbc9 Kees Cook             2025-02-05  199  #else /* __CHECKER__ */
243c90e917f5cfc Vincent Mailhol       2025-03-29 @200  #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
cb7380de9e4cbc9 Kees Cook             2025-02-05  201  #endif /* __CHECKER__ */
cb7380de9e4cbc9 Kees Cook             2025-02-05  202  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
