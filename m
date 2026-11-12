Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794512932;
	b=oPL7uH+TOegtXR8jqsbE44P8HoYwxu7JhaDa6V8a+7e79ghTQGJ7VCZXHB2klxITxZM3
	 tm+f4v35jdscd3gOhIbVKBFVnVoyo9OptWL+vZKCQswDOqvasT9widzB+NNRQXIAnZCUY
	 MHZqtMO+bpM8zKAZjNs2jjMU/hlBlqHhhacTrIJzZCOjZ+IqawsKfOSh51hRpRlKIfYW8
	 dL8+EXkZV9UXXUdYcjCXnwG9nhw2zt8ErlL3K++XX5DdmnpExqJhnsBFO7BFyaqyRCsGg
	 5FOrHMzLeolpDsOSi0FUoEKvVT6YPnKizMeNMOQ/qkvN0UK9OWmrWz/5/WSJV3dON1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794512932;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=0YziDZfUnrU7+ZJzcup14ZR4PkDNoZg+AFnvLqgDtiI=;
	b=tGMhHjKTYm3Rbho2RC+J0PrI9Ccts31KBU6JoGjjdY7UdW4JnyGDWdfBb8OrAsPnvLpF
	 xIsXBG85YS/2ZqQ03/XFoeuFC+Iu7EpI+BiNft3DkV0/z4/mbNlSBRZuCLxi98qDpQ6r8
	 s5BLuai2yMaeWSo+JInK9/pvyrhBPK0ABpPt7DtAjOgMgBl3r9r0ujb5+I6m+Si2sezTE
	 +Zb1Wz3mQKgdAC7H+7YEKpe+cadbdde0HZikVXFp1XeLWkNerjWgUd7NdfDpp9gXgVAhd
	 XmGzJJRv780cARWIllimzTqeI76jM8Rb47uwwMCErJNJDPnvDMAxPD/lYRoA3jf+RDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yr3Q76F7;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CCC606A321;
	Thu, 12 Nov 2026 19:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28CCC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yr3Q76F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794512932; x=1826048932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1H8hTocbRs5F0H8f9VjKeKS3W2Q+jtOlQ95m5Xrt4xE=;
  b=Yr3Q76F736hxHm620hSGI1f+wsD/Zvr0AVnIo2T0/zfc0sFvbg3XEcjD
   li6/JH/jUHMYI3zKy1ONzH3huroUedSCHJeAyi9JCfEyWllyP77DNjbdD
   3TyCuf9qHMk6Ch7PZB49AF7f1Q0leJekrCqSPD0MWQkQe9Qm68u4mC2tM
   8Zb9HHYuKC7TWuEFKzgzkWpkTIufROgRmhpsuxG89nWqvVm8oNfsxXTbp
   IXEbRYWkU6/NrLaRLeonGPI77yYzI2DO7zTlIaO7FhcyeB0fJbx0OJwY4
   Hub4lnEUt7Bpj/efK5Ubex+LYqpps24+imC3VwgLuVYIslRyuK7PC5CeV
   A==;
X-CSE-ConnectionGUID: T9H2D/F1RR+iptmksOliWg==
X-CSE-MsgGUID: yLIfWT6ITc6Mi0l0cVH/Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3309589"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3309589"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 11:48:52 -0800
X-CSE-ConnectionGUID: JAAS6zlARt+yL8xcodFyKA==
X-CSE-MsgGUID: yMKYkCFERiWre3Fu7XfTBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9296784"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 12 Nov 2026 11:48:49 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xRamr-000000011yx-3hkD;
	Thu, 12 Nov 2026 19:48:45 +0000
Date: Fri, 13 Nov 2026 03:48:39 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] perf: arm_v7_pmu: suppress -Winitializer-overrides for
 perf maps
Message-ID: <202611130312.GB4BOZab-lkp@intel.com>
References: <20261111023326.70922-1-rosenp@gmail.com>
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
In-Reply-To: <20261111023326.70922-1-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arm-perf/for-next/perf]
[also build test WARNING on linus/master v7.4-rc2 next-20261111]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/perf-arm_v7_pmu-suppress-Winitializer-overrides-for-perf-maps/20261110-183326
base:   https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-next/perf
patch link:    https://lore.kernel.org/r/20261111023326.70922-1-rosenp%40gmail.com
patch subject: [PATCH] perf: arm_v7_pmu: suppress -Winitializer-overrides for perf maps
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20261113/202611130312.GB4BOZab-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261113/202611130312.GB4BOZab-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611130312.GB4BOZab-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/compiler_types.h:173,
                    from <command-line>:
>> include/linux/compiler-gcc.h:118:33: warning: unknown option after '#pragma GCC diagnostic' kind [-Wpragmas]
     118 | #define __diag(s)               _Pragma(__diag_str(GCC diagnostic s))
         |                                 ^~~~~~~
   include/linux/compiler-gcc.h:129:9: note: in expansion of macro '__diag'
     129 |         __diag(__diag_GCC_ignore option)
         |         ^~~~~~
   drivers/perf/arm_v7_pmu.c:156:1: note: in expansion of macro '__diag_ignore_all'
     156 | __diag_ignore_all("-Winitializer-overrides", "");
         | ^~~~~~~~~~~~~~~~~
   drivers/perf/arm_v7_pmu.c:78:57: warning: initialized field overwritten [-Woverride-init]
      78 | #define ARMV7_PERFCTR_CPU_CYCLES                        0xFF
         |                                                         ^~~~
   drivers/perf/arm_v7_pmu.c:167:51: note: in expansion of macro 'ARMV7_PERFCTR_CPU_CYCLES'
     167 |         [PERF_COUNT_HW_CPU_CYCLES]              = ARMV7_PERFCTR_CPU_CYCLES,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm_v7_pmu.c:78:57: note: (near initialization for 'armv7_a8_perf_map[0]')
   drivers/perf/arm_v7_pmu.c:167:51: note: in expansion of macro 'ARMV7_PERFCTR_CPU_CYCLES'
     167 |         [PERF_COUNT_HW_CPU_CYCLES]              = ARMV7_PERFCTR_CPU_CYCLES,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm_v7_pmu.c:45:57: warning: initialized field overwritten [-Woverride-init]
      45 | #define ARMV7_PERFCTR_INSTR_EXECUTED                    0x08
         |                                                         ^~~~
   drivers/perf/arm_v7_pmu.c:168:51: note: in expansion of macro 'ARMV7_PERFCTR_INSTR_EXECUTED'
     168 |         [PERF_COUNT_HW_INSTRUCTIONS]            = ARMV7_PERFCTR_INSTR_EXECUTED,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm_v7_pmu.c:45:57: note: (near initialization for 'armv7_a8_perf_map[1]')
   drivers/perf/arm_v7_pmu.c:168:51: note: in expansion of macro 'ARMV7_PERFCTR_INSTR_EXECUTED'
     168 |         [PERF_COUNT_HW_INSTRUCTIONS]            = ARMV7_PERFCTR_INSTR_EXECUTED,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm_v7_pmu.c:41:57: warning: initialized field overwritten [-Woverride-init]
      41 | #define ARMV7_PERFCTR_L1_DCACHE_ACCESS                  0x04
         |                                                         ^~~~
   drivers/perf/arm_v7_pmu.c:169:51: note: in expansion of macro 'ARMV7_PERFCTR_L1_DCACHE_ACCESS'
     169 |         [PERF_COUNT_HW_CACHE_REFERENCES]        = ARMV7_PERFCTR_L1_DCACHE_ACCESS,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm_v7_pmu.c:41:57: note: (near initialization for 'armv7_a8_perf_map[2]')
   drivers/perf/arm_v7_pmu.c:169:51: note: in expansion of macro 'ARMV7_PERFCTR_L1_DCACHE_ACCESS'
     169 |         [PERF_COUNT_HW_CACHE_REFERENCES]        = ARMV7_PERFCTR_L1_DCACHE_ACCESS,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm_v7_pmu.c:40:57: warning: initialized field overwritten [-Woverride-init]
      40 | #define ARMV7_PERFCTR_L1_DCACHE_REFILL                  0x03
         |                                                         ^~~~
   drivers/perf/arm_v7_pmu.c:170:51: note: in expansion of macro 'ARMV7_PERFCTR_L1_DCACHE_REFILL'
     170 |         [PERF_COUNT_HW_CACHE_MISSES]            = ARMV7_PERFCTR_L1_DCACHE_REFILL,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm_v7_pmu.c:40:57: note: (near initialization for 'armv7_a8_perf_map[3]')
   drivers/perf/arm_v7_pmu.c:170:51: note: in expansion of macro 'ARMV7_PERFCTR_L1_DCACHE_REFILL'
     170 |         [PERF_COUNT_HW_CACHE_MISSES]            = ARMV7_PERFCTR_L1_DCACHE_REFILL,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm_v7_pmu.c:57:57: warning: initialized field overwritten [-Woverride-init]
      57 | #define ARMV7_PERFCTR_PC_WRITE                          0x0C
         |                                                         ^~~~
   drivers/perf/arm_v7_pmu.c:171:51: note: in expansion of macro 'ARMV7_PERFCTR_PC_WRITE'
     171 |         [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]     = ARMV7_PERFCTR_PC_WRITE,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm_v7_pmu.c:57:57: note: (near initialization for 'armv7_a8_perf_map[4]')
   drivers/perf/arm_v7_pmu.c:171:51: note: in expansion of macro 'ARMV7_PERFCTR_PC_WRITE'
     171 |         [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]     = ARMV7_PERFCTR_PC_WRITE,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm_v7_pmu.c:61:57: warning: initialized field overwritten [-Woverride-init]
      61 | #define ARMV7_PERFCTR_PC_BRANCH_MIS_PRED                0x10
         |                                                         ^~~~
   drivers/perf/arm_v7_pmu.c:172:51: note: in expansion of macro 'ARMV7_PERFCTR_PC_BRANCH_MIS_PRED'
     172 |         [PERF_COUNT_HW_BRANCH_MISSES]           = ARMV7_PERFCTR_PC_BRANCH_MIS_PRED,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm_v7_pmu.c:61:57: note: (near initialization for 'armv7_a8_perf_map[5]')
   drivers/perf/arm_v7_pmu.c:172:51: note: in expansion of macro 'ARMV7_PERFCTR_PC_BRANCH_MIS_PRED'
     172 |         [PERF_COUNT_HW_BRANCH_MISSES]           = ARMV7_PERFCTR_PC_BRANCH_MIS_PRED,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm_v7_pmu.c:84:57: warning: initialized field overwritten [-Woverride-init]
      84 | #define ARMV7_A8_PERFCTR_STALL_ISIDE                    0x56
         |                                                         ^~~~
   drivers/perf/arm_v7_pmu.c:173:51: note: in expansion of macro 'ARMV7_A8_PERFCTR_STALL_ISIDE'
     173 |         [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = ARMV7_A8_PERFCTR_STALL_ISIDE,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm_v7_pmu.c:84:57: note: (near initialization for 'armv7_a8_perf_map[7]')
   drivers/perf/arm_v7_pmu.c:173:51: note: in expansion of macro 'ARMV7_A8_PERFCTR_STALL_ISIDE'
     173 |         [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = ARMV7_A8_PERFCTR_STALL_ISIDE,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm_v7_pmu.c:41:57: warning: initialized field overwritten [-Woverride-init]
      41 | #define ARMV7_PERFCTR_L1_DCACHE_ACCESS                  0x04
         |                                                         ^~~~
   drivers/perf/arm_v7_pmu.c:186:51: note: in expansion of macro 'ARMV7_PERFCTR_L1_DCACHE_ACCESS'
     186 |         [C(L1D)][C(OP_READ)][C(RESULT_ACCESS)]  = ARMV7_PERFCTR_L1_DCACHE_ACCESS,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm_v7_pmu.c:41:57: note: (near initialization for 'armv7_a8_perf_cache_map[0][0][0]')
   drivers/perf/arm_v7_pmu.c:186:51: note: in expansion of macro 'ARMV7_PERFCTR_L1_DCACHE_ACCESS'
     186 |         [C(L1D)][C(OP_READ)][C(RESULT_ACCESS)]  = ARMV7_PERFCTR_L1_DCACHE_ACCESS,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm_v7_pmu.c:40:57: warning: initialized field overwritten [-Woverride-init]
      40 | #define ARMV7_PERFCTR_L1_DCACHE_REFILL                  0x03
         |                                                         ^~~~
   drivers/perf/arm_v7_pmu.c:187:51: note: in expansion of macro 'ARMV7_PERFCTR_L1_DCACHE_REFILL'
     187 |         [C(L1D)][C(OP_READ)][C(RESULT_MISS)]    = ARMV7_PERFCTR_L1_DCACHE_REFILL,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm_v7_pmu.c:40:57: note: (near initialization for 'armv7_a8_perf_cache_map[0][0][1]')
   drivers/perf/arm_v7_pmu.c:187:51: note: in expansion of macro 'ARMV7_PERFCTR_L1_DCACHE_REFILL'
     187 |         [C(L1D)][C(OP_READ)][C(RESULT_MISS)]    = ARMV7_PERFCTR_L1_DCACHE_REFILL,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm_v7_pmu.c:41:57: warning: initialized field overwritten [-Woverride-init]
      41 | #define ARMV7_PERFCTR_L1_DCACHE_ACCESS                  0x04


vim +118 include/linux/compiler-gcc.h

8793bb7f4a9dd13 Arnd Bergmann 2018-06-19  115  
8793bb7f4a9dd13 Arnd Bergmann 2018-06-19  116  #define __diag_str1(s)		#s
8793bb7f4a9dd13 Arnd Bergmann 2018-06-19  117  #define __diag_str(s)		__diag_str1(s)
8793bb7f4a9dd13 Arnd Bergmann 2018-06-19 @118  #define __diag(s)		_Pragma(__diag_str(GCC diagnostic s))
8793bb7f4a9dd13 Arnd Bergmann 2018-06-19  119  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
