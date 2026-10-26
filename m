Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792975457;
	b=uN68qKq2b5pA30oV4ZVWnkpaouyr3ErJIqR9VnLGY+UKh/87Dpf8z7/dYIfkTmnMJYCU
	 nnsoCyQsqxFpwEao5o6O10V6L8z1qwavn+dPR+lyNW8wHuTmwQM6L1nSe+HQB8z/M8xfX
	 zP/Nqp8hMaC0YWNiJHJuXl63zN2dZa8WyLcFORDXXXj/rq45kBOKtAfPypbiKovT4D+wR
	 Q1Uv7bJl7FDgo0hO6vgKtk12AlGaaCxKZL7WOvMYU8Q6CpdJiGuhk7/hKbLexbKqOcVcm
	 e0nvbPt9dnbFeyqAGpEHHR+y9LqjS8TVkL6sFCE80T3pxtrXEQFJJm05fa7h/IX7AXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792975457;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=EtiE/FdWM7rG34+O2SLPeqmbkSmBbjQoRkkeXj5Nnfs=;
	b=5bTlc1nr/m2xC3HlIpWugK0hysmjgpu/yOOR+rBG2F/BHkFYGbJMkypFOm6y5CfQ5AeT
	 UmSvUSL43hJFT9PXkWuOHfJnGH5aCtMH3OHbswDwhdA/kcHZr9b8c1vSsYt74kNHK1g1q
	 4w+vZigQ8/7fuZ37rCrk6zPncWBazcnA3n4q9Z4gPrYO7GXVKBkNXFbAFJ4CIx1AeORiM
	 zdgBnyTdke3K75GMgHpqD0ISMAubpxUvKOrj6Bj0puBDMp4eQOW7G21lN+fZ3MnLZ1ilc
	 Zt3UkLEtzGjzRWXsz14GfgU1MuAZIKa2jiF2jpn2IaKjGOZBCJMAlZCKLYvKSEPJKgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YbjwPIO2;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55022606A31B;
	Mon, 26 Oct 2026 00:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55022606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YbjwPIO2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792975455; x=1824511455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KtqGlUfYbHkNSyFkfxUygtbxGNdFcPZECBy9JtfaDBU=;
  b=YbjwPIO2oeyZCRgMLUg/fSIn+emJ8BIguGd/7sA/FZ9h5Xa+QfI0E2Cj
   3dBs5Afi2j75zXX7oy+Zpg5iPDmLCKJoG0zbrmPR8Sw5bgk/GIIgV0mTN
   tZvnr9TnaAAU2TuoS82c1PQZEawhXE3tUHt+05VwamtB1iyAKHDPdZ+MZ
   MtiSIRiYHl/bIMcMbBJjTpbOBcplXOFR1Lv6rorp71SRzh0oYD/vlEbPE
   UgRa3m5sZ7fRKOgnvvNnexiU8lwz+z22CinxEl8As0XXwQ2afXa2F4qze
   smikie29CYZm8nKZV41pFxFUFv/R1TZKKoajXB/PvbIk3Bx8wvghhGboL
   w==;
X-CSE-ConnectionGUID: gKnRcNhnToiKESTxy2sKSw==
X-CSE-MsgGUID: hAgtFkLLTLGiQE2yO3q3rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1531190"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1531190"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 17:44:14 -0700
X-CSE-ConnectionGUID: cxbaJDKtSH6ztnei4iFFFQ==
X-CSE-MsgGUID: szcqLn1KTFunxeID2vIPFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4503957"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 25 Oct 2026 17:44:10 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xL8oo-00000000VJ8-42Gt;
	Mon, 26 Oct 2026 00:44:06 +0000
Date: Mon, 26 Oct 2026 08:43:52 +0800
From: kernel test robot <lkp@intel.com>
To: Amir Ayupov <aaupov@fb.com>, James Clark <james.clark@linaro.org>,
	Leo Yan <leo.yan@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Daniel Pereira <danielmaraboo@gmail.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] perf: arm_pmuv3: Add pmuv3_event_implemented()
Message-ID: <202610260838.P0WtLZz6-lkp@intel.com>
References: <cd3e622681f7254216b0488f09d2cb2d91a2d8ca.1792907333.git.aaupov@fb.com>
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
In-Reply-To: <cd3e622681f7254216b0488f09d2cb2d91a2d8ca.1792907333.git.aaupov@fb.com>

Hi Amir,

kernel test robot noticed the following build errors:

[auto build test ERROR on 343cfcbb3ecfdb80aa576a428cfa3b65ad783842]

url:    https://github.com/intel-lab-lkp/linux/commits/Amir-Ayupov/coresight-etm4x-Fix-event-count-decoding/20261024-233901
base:   343cfcbb3ecfdb80aa576a428cfa3b65ad783842
patch link:    https://lore.kernel.org/r/cd3e622681f7254216b0488f09d2cb2d91a2d8ca.1792907333.git.aaupov%40fb.com
patch subject: [PATCH v3 5/7] perf: arm_pmuv3: Add pmuv3_event_implemented()
config: arm64-randconfig-1003-20261026 (https://download.01.org/0day-ci/archive/20261026/202610260838.P0WtLZz6-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261026/202610260838.P0WtLZz6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610260838.P0WtLZz6-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/kvm/arm_pmu.h:11,
                    from arch/arm64/include/asm/kvm_host.h:38,
                    from arch/arm64/include/asm/arm_pmuv3.h:9,
                    from arch/arm64/kernel/cpufeature.c:80:
   include/linux/perf/arm_pmuv3.h: In function 'pmuv3_event_implemented':
   include/linux/perf/arm_pmuv3.h:333:19: error: implicit declaration of function 'pmuv3_implemented'; did you mean 'pmuv3_event_implemented'? [-Werror=implicit-function-declaration]
     if (id >= 64 || !pmuv3_implemented(read_pmuver()))
                      ^~~~~~~~~~~~~~~~~
                      pmuv3_event_implemented
   include/linux/perf/arm_pmuv3.h:333:37: error: implicit declaration of function 'read_pmuver'; did you mean 'read_tcr'? [-Werror=implicit-function-declaration]
     if (id >= 64 || !pmuv3_implemented(read_pmuver()))
                                        ^~~~~~~~~~~
                                        read_tcr
   include/linux/perf/arm_pmuv3.h:336:21: error: implicit declaration of function 'read_pmceid0'; did you mean 'read_cpuid'? [-Werror=implicit-function-declaration]
     pmceid = id < 32 ? read_pmceid0() : read_pmceid1();
                        ^~~~~~~~~~~~
                        read_cpuid
   include/linux/perf/arm_pmuv3.h:336:38: error: implicit declaration of function 'read_pmceid1'; did you mean 'read_cpuid'? [-Werror=implicit-function-declaration]
     pmceid = id < 32 ? read_pmceid0() : read_pmceid1();
                                         ^~~~~~~~~~~~
                                         read_cpuid
   In file included from arch/arm64/kernel/cpufeature.c:80:
   arch/arm64/include/asm/arm_pmuv3.h: At top level:
>> arch/arm64/include/asm/arm_pmuv3.h:49:19: error: conflicting types for 'read_pmuver'
    static inline u32 read_pmuver(void)
                      ^~~~~~~~~~~
   In file included from include/kvm/arm_pmu.h:11,
                    from arch/arm64/include/asm/kvm_host.h:38,
                    from arch/arm64/include/asm/arm_pmuv3.h:9,
                    from arch/arm64/kernel/cpufeature.c:80:
   include/linux/perf/arm_pmuv3.h:333:37: note: previous implicit declaration of 'read_pmuver' was here
     if (id >= 64 || !pmuv3_implemented(read_pmuver()))
                                        ^~~~~~~~~~~
   In file included from arch/arm64/kernel/cpufeature.c:80:
>> arch/arm64/include/asm/arm_pmuv3.h:160:19: error: conflicting types for 'read_pmceid0'
    static inline u64 read_pmceid0(void)
                      ^~~~~~~~~~~~
   In file included from include/kvm/arm_pmu.h:11,
                    from arch/arm64/include/asm/kvm_host.h:38,
                    from arch/arm64/include/asm/arm_pmuv3.h:9,
                    from arch/arm64/kernel/cpufeature.c:80:
   include/linux/perf/arm_pmuv3.h:336:21: note: previous implicit declaration of 'read_pmceid0' was here
     pmceid = id < 32 ? read_pmceid0() : read_pmceid1();
                        ^~~~~~~~~~~~
   In file included from arch/arm64/kernel/cpufeature.c:80:
>> arch/arm64/include/asm/arm_pmuv3.h:165:19: error: conflicting types for 'read_pmceid1'
    static inline u64 read_pmceid1(void)
                      ^~~~~~~~~~~~
   In file included from include/kvm/arm_pmu.h:11,
                    from arch/arm64/include/asm/kvm_host.h:38,
                    from arch/arm64/include/asm/arm_pmuv3.h:9,
                    from arch/arm64/kernel/cpufeature.c:80:
   include/linux/perf/arm_pmuv3.h:336:38: note: previous implicit declaration of 'read_pmceid1' was here
     pmceid = id < 32 ? read_pmceid0() : read_pmceid1();
                                         ^~~~~~~~~~~~
   In file included from arch/arm64/kernel/cpufeature.c:80:
>> arch/arm64/include/asm/arm_pmuv3.h:170:20: error: conflicting types for 'pmuv3_implemented'
    static inline bool pmuv3_implemented(int pmuver)
                       ^~~~~~~~~~~~~~~~~
   In file included from include/kvm/arm_pmu.h:11,
                    from arch/arm64/include/asm/kvm_host.h:38,
                    from arch/arm64/include/asm/arm_pmuv3.h:9,
                    from arch/arm64/kernel/cpufeature.c:80:
   include/linux/perf/arm_pmuv3.h:333:19: note: previous implicit declaration of 'pmuv3_implemented' was here
     if (id >= 64 || !pmuv3_implemented(read_pmuver()))
                      ^~~~~~~~~~~~~~~~~
   arch/arm64/kernel/cpufeature.c:3364:21: warning: initialized field overwritten [-Woverride-init]
     HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ISAR2_EL1, LUT, LUT6, CAP_HWCAP, KERNEL_HWCAP_SVE_LUT6),
                        ^~~~~~~~~~~~~~~
   arch/arm64/kernel/cpufeature.c:3273:14: note: in definition of macro 'HWCAP_CAP_MATCH_ID'
      .matches = match,      \
                 ^~~~~
   arch/arm64/kernel/cpufeature.c:3364:21: note: (near initialization for 'arm64_elf_hwcaps[44].matches')
     HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ISAR2_EL1, LUT, LUT6, CAP_HWCAP, KERNEL_HWCAP_SVE_LUT6),
                        ^~~~~~~~~~~~~~~
   arch/arm64/kernel/cpufeature.c:3273:14: note: in definition of macro 'HWCAP_CAP_MATCH_ID'
      .matches = match,      \
                 ^~~~~
   arch/arm64/kernel/cpufeature.c:3366:21: warning: initialized field overwritten [-Woverride-init]
     HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, SVEver, SVE2p3, CAP_HWCAP, KERNEL_HWCAP_SVE2P3),
                        ^~~~~~~~~~~~~~~
   arch/arm64/kernel/cpufeature.c:3273:14: note: in definition of macro 'HWCAP_CAP_MATCH_ID'
      .matches = match,      \
                 ^~~~~
   arch/arm64/kernel/cpufeature.c:3366:21: note: (near initialization for 'arm64_elf_hwcaps[46].matches')
     HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, SVEver, SVE2p3, CAP_HWCAP, KERNEL_HWCAP_SVE2P3),
                        ^~~~~~~~~~~~~~~
   arch/arm64/kernel/cpufeature.c:3273:14: note: in definition of macro 'HWCAP_CAP_MATCH_ID'
      .matches = match,      \
                 ^~~~~
   arch/arm64/kernel/cpufeature.c:3367:21: warning: initialized field overwritten [-Woverride-init]
     HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, SVEver, SVE2p2, CAP_HWCAP, KERNEL_HWCAP_SVE2P2),
                        ^~~~~~~~~~~~~~~
   arch/arm64/kernel/cpufeature.c:3273:14: note: in definition of macro 'HWCAP_CAP_MATCH_ID'
      .matches = match,      \
                 ^~~~~
   arch/arm64/kernel/cpufeature.c:3367:21: note: (near initialization for 'arm64_elf_hwcaps[47].matches')
     HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, SVEver, SVE2p2, CAP_HWCAP, KERNEL_HWCAP_SVE2P2),
                        ^~~~~~~~~~~~~~~
   arch/arm64/kernel/cpufeature.c:3273:14: note: in definition of macro 'HWCAP_CAP_MATCH_ID'
      .matches = match,      \
                 ^~~~~
   arch/arm64/kernel/cpufeature.c:3368:21: warning: initialized field overwritten [-Woverride-init]
     HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, SVEver, SVE2p1, CAP_HWCAP, KERNEL_HWCAP_SVE2P1),
                        ^~~~~~~~~~~~~~~
   arch/arm64/kernel/cpufeature.c:3273:14: note: in definition of macro 'HWCAP_CAP_MATCH_ID'
      .matches = match,      \
                 ^~~~~
   arch/arm64/kernel/cpufeature.c:3368:21: note: (near initialization for 'arm64_elf_hwcaps[48].matches')
     HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, SVEver, SVE2p1, CAP_HWCAP, KERNEL_HWCAP_SVE2P1),
                        ^~~~~~~~~~~~~~~
   arch/arm64/kernel/cpufeature.c:3273:14: note: in definition of macro 'HWCAP_CAP_MATCH_ID'
      .matches = match,      \
                 ^~~~~
   arch/arm64/kernel/cpufeature.c:3369:21: warning: initialized field overwritten [-Woverride-init]
     HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, SVEver, SVE2, CAP_HWCAP, KERNEL_HWCAP_SVE2),
                        ^~~~~~~~~~~~~~~
   arch/arm64/kernel/cpufeature.c:3273:14: note: in definition of macro 'HWCAP_CAP_MATCH_ID'
      .matches = match,      \
                 ^~~~~
   arch/arm64/kernel/cpufeature.c:3369:21: note: (near initialization for 'arm64_elf_hwcaps[49].matches')
     HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, SVEver, SVE2, CAP_HWCAP, KERNEL_HWCAP_SVE2),
                        ^~~~~~~~~~~~~~~
   arch/arm64/kernel/cpufeature.c:3273:14: note: in definition of macro 'HWCAP_CAP_MATCH_ID'
      .matches = match,      \
                 ^~~~~
   arch/arm64/kernel/cpufeature.c:3370:21: warning: initialized field overwritten [-Woverride-init]
     HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, AES, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEAES),
                        ^~~~~~~~~~~~~~~
   arch/arm64/kernel/cpufeature.c:3273:14: note: in definition of macro 'HWCAP_CAP_MATCH_ID'
      .matches = match,      \
                 ^~~~~
   arch/arm64/kernel/cpufeature.c:3370:21: note: (near initialization for 'arm64_elf_hwcaps[50].matches')
     HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, AES, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEAES),
                        ^~~~~~~~~~~~~~~
   arch/arm64/kernel/cpufeature.c:3273:14: note: in definition of macro 'HWCAP_CAP_MATCH_ID'
      .matches = match,      \
                 ^~~~~
   arch/arm64/kernel/cpufeature.c:3371:21: warning: initialized field overwritten [-Woverride-init]
     HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, AES, PMULL128, CAP_HWCAP, KERNEL_HWCAP_SVEPMULL),
                        ^~~~~~~~~~~~~~~
   arch/arm64/kernel/cpufeature.c:3273:14: note: in definition of macro 'HWCAP_CAP_MATCH_ID'
      .matches = match,      \
                 ^~~~~
   arch/arm64/kernel/cpufeature.c:3371:21: note: (near initialization for 'arm64_elf_hwcaps[51].matches')
     HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, AES, PMULL128, CAP_HWCAP, KERNEL_HWCAP_SVEPMULL),
                        ^~~~~~~~~~~~~~~
   arch/arm64/kernel/cpufeature.c:3273:14: note: in definition of macro 'HWCAP_CAP_MATCH_ID'
      .matches = match,      \
                 ^~~~~
   arch/arm64/kernel/cpufeature.c:3372:21: warning: initialized field overwritten [-Woverride-init]
     HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, AES, AES2, CAP_HWCAP, KERNEL_HWCAP_SVE_AES2),
                        ^~~~~~~~~~~~~~~
   arch/arm64/kernel/cpufeature.c:3273:14: note: in definition of macro 'HWCAP_CAP_MATCH_ID'
      .matches = match,      \
                 ^~~~~
   arch/arm64/kernel/cpufeature.c:3372:21: note: (near initialization for 'arm64_elf_hwcaps[52].matches')


vim +/read_pmuver +49 arch/arm64/include/asm/arm_pmuv3.h

df29ddf4f04b00 Marc Zyngier      2023-03-17   48  
df29ddf4f04b00 Marc Zyngier      2023-03-17  @49  static inline u32 read_pmuver(void)
df29ddf4f04b00 Marc Zyngier      2023-03-17   50  {
df29ddf4f04b00 Marc Zyngier      2023-03-17   51  	u64 dfr0 = read_sysreg(id_aa64dfr0_el1);
df29ddf4f04b00 Marc Zyngier      2023-03-17   52  
df29ddf4f04b00 Marc Zyngier      2023-03-17   53  	return cpuid_feature_extract_unsigned_field(dfr0,
df29ddf4f04b00 Marc Zyngier      2023-03-17   54  			ID_AA64DFR0_EL1_PMUVer_SHIFT);
df29ddf4f04b00 Marc Zyngier      2023-03-17   55  }
df29ddf4f04b00 Marc Zyngier      2023-03-17   56  
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31   57) static inline bool pmuv3_has_icntr(void)
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31   58) {
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31   59) 	u64 dfr1 = read_sysreg(id_aa64dfr1_el1);
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31   60) 
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31   61) 	return !!cpuid_feature_extract_unsigned_field(dfr1,
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31   62) 			ID_AA64DFR1_EL1_PMICNTR_SHIFT);
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31   63) }
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31   64) 
403edfa436286b Ilkka Koskinen    2023-11-02   65  static inline void write_pmcr(u64 val)
df29ddf4f04b00 Marc Zyngier      2023-03-17   66  {
df29ddf4f04b00 Marc Zyngier      2023-03-17   67  	write_sysreg(val, pmcr_el0);
df29ddf4f04b00 Marc Zyngier      2023-03-17   68  }
df29ddf4f04b00 Marc Zyngier      2023-03-17   69  
403edfa436286b Ilkka Koskinen    2023-11-02   70  static inline u64 read_pmcr(void)
df29ddf4f04b00 Marc Zyngier      2023-03-17   71  {
df29ddf4f04b00 Marc Zyngier      2023-03-17   72  	return read_sysreg(pmcr_el0);
df29ddf4f04b00 Marc Zyngier      2023-03-17   73  }
df29ddf4f04b00 Marc Zyngier      2023-03-17   74  
df29ddf4f04b00 Marc Zyngier      2023-03-17   75  static inline void write_pmselr(u32 val)
df29ddf4f04b00 Marc Zyngier      2023-03-17   76  {
df29ddf4f04b00 Marc Zyngier      2023-03-17   77  	write_sysreg(val, pmselr_el0);
df29ddf4f04b00 Marc Zyngier      2023-03-17   78  }
df29ddf4f04b00 Marc Zyngier      2023-03-17   79  
df29ddf4f04b00 Marc Zyngier      2023-03-17   80  static inline void write_pmccntr(u64 val)
df29ddf4f04b00 Marc Zyngier      2023-03-17   81  {
df29ddf4f04b00 Marc Zyngier      2023-03-17   82  	write_sysreg(val, pmccntr_el0);
df29ddf4f04b00 Marc Zyngier      2023-03-17   83  }
df29ddf4f04b00 Marc Zyngier      2023-03-17   84  
df29ddf4f04b00 Marc Zyngier      2023-03-17   85  static inline u64 read_pmccntr(void)
df29ddf4f04b00 Marc Zyngier      2023-03-17   86  {
df29ddf4f04b00 Marc Zyngier      2023-03-17   87  	return read_sysreg(pmccntr_el0);
df29ddf4f04b00 Marc Zyngier      2023-03-17   88  }
df29ddf4f04b00 Marc Zyngier      2023-03-17   89  
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31   90) static inline void write_pmicntr(u64 val)
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31   91) {
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31   92) 	write_sysreg_s(val, SYS_PMICNTR_EL0);
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31   93) }
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31   94) 
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31   95) static inline u64 read_pmicntr(void)
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31   96) {
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31   97) 	return read_sysreg_s(SYS_PMICNTR_EL0);
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31   98) }
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31   99) 
a4a6e2078d85a9 Rob Herring (Arm  2024-07-31  100) static inline void write_pmcntenset(u64 val)
df29ddf4f04b00 Marc Zyngier      2023-03-17  101  {
df29ddf4f04b00 Marc Zyngier      2023-03-17  102  	write_sysreg(val, pmcntenset_el0);
df29ddf4f04b00 Marc Zyngier      2023-03-17  103  }
df29ddf4f04b00 Marc Zyngier      2023-03-17  104  
a4a6e2078d85a9 Rob Herring (Arm  2024-07-31  105) static inline void write_pmcntenclr(u64 val)
df29ddf4f04b00 Marc Zyngier      2023-03-17  106  {
df29ddf4f04b00 Marc Zyngier      2023-03-17  107  	write_sysreg(val, pmcntenclr_el0);
df29ddf4f04b00 Marc Zyngier      2023-03-17  108  }
df29ddf4f04b00 Marc Zyngier      2023-03-17  109  
a4a6e2078d85a9 Rob Herring (Arm  2024-07-31  110) static inline void write_pmintenset(u64 val)
df29ddf4f04b00 Marc Zyngier      2023-03-17  111  {
df29ddf4f04b00 Marc Zyngier      2023-03-17  112  	write_sysreg(val, pmintenset_el1);
df29ddf4f04b00 Marc Zyngier      2023-03-17  113  }
df29ddf4f04b00 Marc Zyngier      2023-03-17  114  
a4a6e2078d85a9 Rob Herring (Arm  2024-07-31  115) static inline void write_pmintenclr(u64 val)
df29ddf4f04b00 Marc Zyngier      2023-03-17  116  {
df29ddf4f04b00 Marc Zyngier      2023-03-17  117  	write_sysreg(val, pmintenclr_el1);
df29ddf4f04b00 Marc Zyngier      2023-03-17  118  }
df29ddf4f04b00 Marc Zyngier      2023-03-17  119  
403edfa436286b Ilkka Koskinen    2023-11-02  120  static inline void write_pmccfiltr(u64 val)
df29ddf4f04b00 Marc Zyngier      2023-03-17  121  {
df29ddf4f04b00 Marc Zyngier      2023-03-17  122  	write_sysreg(val, pmccfiltr_el0);
df29ddf4f04b00 Marc Zyngier      2023-03-17  123  }
df29ddf4f04b00 Marc Zyngier      2023-03-17  124  
741ee5284551cf Rob Herring (Arm  2024-07-31  125) static inline u64 read_pmccfiltr(void)
741ee5284551cf Rob Herring (Arm  2024-07-31  126) {
741ee5284551cf Rob Herring (Arm  2024-07-31  127) 	return read_sysreg(pmccfiltr_el0);
741ee5284551cf Rob Herring (Arm  2024-07-31  128) }
741ee5284551cf Rob Herring (Arm  2024-07-31  129) 
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31  130) static inline void write_pmicfiltr(u64 val)
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31  131) {
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31  132) 	write_sysreg_s(val, SYS_PMICFILTR_EL0);
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31  133) }
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31  134) 
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31  135) static inline u64 read_pmicfiltr(void)
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31  136) {
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31  137) 	return read_sysreg_s(SYS_PMICFILTR_EL0);
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31  138) }
d8226d8cfbaf5e Rob Herring (Arm  2024-07-31  139) 
a4a6e2078d85a9 Rob Herring (Arm  2024-07-31  140) static inline void write_pmovsclr(u64 val)
df29ddf4f04b00 Marc Zyngier      2023-03-17  141  {
df29ddf4f04b00 Marc Zyngier      2023-03-17  142  	write_sysreg(val, pmovsclr_el0);
df29ddf4f04b00 Marc Zyngier      2023-03-17  143  }
df29ddf4f04b00 Marc Zyngier      2023-03-17  144  
a4a6e2078d85a9 Rob Herring (Arm  2024-07-31  145) static inline u64 read_pmovsclr(void)
df29ddf4f04b00 Marc Zyngier      2023-03-17  146  {
df29ddf4f04b00 Marc Zyngier      2023-03-17  147  	return read_sysreg(pmovsclr_el0);
df29ddf4f04b00 Marc Zyngier      2023-03-17  148  }
df29ddf4f04b00 Marc Zyngier      2023-03-17  149  
df29ddf4f04b00 Marc Zyngier      2023-03-17  150  static inline void write_pmuserenr(u32 val)
df29ddf4f04b00 Marc Zyngier      2023-03-17  151  {
df29ddf4f04b00 Marc Zyngier      2023-03-17  152  	write_sysreg(val, pmuserenr_el0);
df29ddf4f04b00 Marc Zyngier      2023-03-17  153  }
df29ddf4f04b00 Marc Zyngier      2023-03-17  154  
0bbff9ed81654d Rob Herring (Arm  2024-10-02  155) static inline void write_pmuacr(u64 val)
0bbff9ed81654d Rob Herring (Arm  2024-10-02  156) {
0bbff9ed81654d Rob Herring (Arm  2024-10-02  157) 	write_sysreg_s(val, SYS_PMUACR_EL1);
0bbff9ed81654d Rob Herring (Arm  2024-10-02  158) }
0bbff9ed81654d Rob Herring (Arm  2024-10-02  159) 
403edfa436286b Ilkka Koskinen    2023-11-02 @160  static inline u64 read_pmceid0(void)
df29ddf4f04b00 Marc Zyngier      2023-03-17  161  {
df29ddf4f04b00 Marc Zyngier      2023-03-17  162  	return read_sysreg(pmceid0_el0);
df29ddf4f04b00 Marc Zyngier      2023-03-17  163  }
df29ddf4f04b00 Marc Zyngier      2023-03-17  164  
403edfa436286b Ilkka Koskinen    2023-11-02 @165  static inline u64 read_pmceid1(void)
df29ddf4f04b00 Marc Zyngier      2023-03-17  166  {
df29ddf4f04b00 Marc Zyngier      2023-03-17  167  	return read_sysreg(pmceid1_el0);
df29ddf4f04b00 Marc Zyngier      2023-03-17  168  }
df29ddf4f04b00 Marc Zyngier      2023-03-17  169  
711432770f78e5 Zaid Al-Bassam    2023-03-17 @170  static inline bool pmuv3_implemented(int pmuver)
711432770f78e5 Zaid Al-Bassam    2023-03-17  171  {
711432770f78e5 Zaid Al-Bassam    2023-03-17  172  	return !(pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF ||
711432770f78e5 Zaid Al-Bassam    2023-03-17  173  		 pmuver == ID_AA64DFR0_EL1_PMUVer_NI);
711432770f78e5 Zaid Al-Bassam    2023-03-17  174  }
711432770f78e5 Zaid Al-Bassam    2023-03-17  175  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
