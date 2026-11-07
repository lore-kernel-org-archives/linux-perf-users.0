Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794035124;
	b=jt/HTaAdtUW3wIXDZbnY46pinTtLMEhyIvpLJtY9h4ZQaIpcpBfIxUsmWHzdWqEqs1CQ
	 LHdrtA7KJiJwdeuWY0K3Lfok78pANHkijdCuyoYm3dRklgTO/x14HpQCbOLEejKiYJrh3
	 ZFxwHcvhYiejNUvzh/RFw5PdYeWA1pgXyauUucZjY0nIqu/Tn2pLSPbn+rI9Y1MjHeXka
	 J7JyB0aVbJz1PIUoTze3lohUaWXbzJYzFSmk4xJVC60SaULRfOGbVLvqYE9sI0XHLE6q6
	 EsO0LOHvHesLmJqqmjyGqBxeJZKgAbjmuroatEtJeOEpIw5Kz0LCPXg05L6PZNM8l/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794035124;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=lAwYNWjlqw18PRKfs0wfc6QMvEJ/l8q6K3xULLq/RJc=;
	b=bhxILmQ5atA4se8hQqAgS0lr8SNJ2OdzxcPmVKndBET4IucQmgDJdha0OY17AXl4XMC5
	 qLTa3EN+uJTeFr4qEMrJiVDwAVFC8Y1st2L5ipvros/K0J1x/W5yd/8gHob3FfsQJHXBa
	 It3xf0ktRSrfTlFCXRkP+ClRlZ3bu0MGOGep3qKRKHzcifW+sY2PDsCciG0VYn9dyy5uX
	 /5RnS4U5Ov8tHdtkLZhGT7usf9N5jwhFchwOfoY6xNWm10r3OIhd9EORd7/CUraJdM/Ue
	 fhhZcVkHaeAhVjUxfKd8UVv3wax3zsu/ICLwZQN4CD+8fSxNQhOJ0CHUk0Gjz9C93GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NaFJfyfF;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2341606A32C;
	Sat,  7 Nov 2026 07:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2341606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NaFJfyfF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794035123; x=1825571123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MlHqtS8cT8ajIw/2dp1+/XcpibT8MY0x6er6vc3ClcU=;
  b=NaFJfyfFLQ8fVFchaFpMq8uorPi0StZdUbRASrKZTD2PdM5eV9dkoA0H
   wSkfjPZsd3eZkyKH9ZKXlj9/vif8MPkdGs6eHsyxQqAnpnanpQdHuWN4M
   31uM8GfgRs//Z4R3fqg7i+CxFbqDQ3gkvSDmI/BNbr4lW3Qm2BHfbKnDx
   h+JL4M46FbIjkNZS6/oTFPobBrDnNVqnchhrRAf2KUi7ATcRVi/aBXtif
   KKr8fisKzKKHScRVCPblJ7KNcYtGPaoWNbg3SxU/hTPPtSr1XgywpVAh8
   j/Q15Y5pX49vZjamqxkyetqcAVKYrFIvhNtix3pQRzOYsteCyrpnBqQe2
   A==;
X-CSE-ConnectionGUID: pxQbo8YPQPaBQ2LTkNOyDw==
X-CSE-MsgGUID: jduqnKMgSiqagrZn67E38w==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2734858"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2734858"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 23:05:22 -0800
X-CSE-ConnectionGUID: 9+2ftNMKQAqc50tJyR7fxg==
X-CSE-MsgGUID: pNt5NwnMSVqZrahXN4gQYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7444739"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 06 Nov 2026 23:05:16 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPaUC-00000000qZf-2cVD;
	Sat, 07 Nov 2026 07:05:12 +0000
Date: Sat, 7 Nov 2026 15:04:50 +0800
From: kernel test robot <lkp@intel.com>
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Alexandre Ghiti <alex@ghiti.fr>,
	Jesse Taube <jtaubepe@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: Re: [PATCH v8 3/8] riscv: add ptrace requests for hardware
 breakpoints
Message-ID: <202611071408.gyIRvq10-lkp@intel.com>
References: <20261107023917.40606-4-himanshu.chauhan@oss.qualcomm.com>
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
In-Reply-To: <20261107023917.40606-4-himanshu.chauhan@oss.qualcomm.com>

Hi Himanshu,

kernel test robot noticed the following build errors:

[auto build test ERROR on shuah-kselftest/next]
[also build test ERROR on shuah-kselftest/fixes perf-tools-next/perf-tools-next linus/master v7.4-rc1 next-20261105]
[cannot apply to kees/for-next/execve tip/perf/core perf-tools/perf-tools acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Himanshu-Chauhan/riscv-Introduce-support-for-hardware-break-watchpoints/20261107-080910
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20261107023917.40606-4-himanshu.chauhan%40oss.qualcomm.com
patch subject: [PATCH v8 3/8] riscv: add ptrace requests for hardware breakpoints
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20261107/202611071408.gyIRvq10-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261107/202611071408.gyIRvq10-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611071408.gyIRvq10-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/exit.c:57:
>> include/linux/hw_breakpoint.h:137:20: error: redefinition of 'flush_ptrace_hw_breakpoint'
     137 | static inline void flush_ptrace_hw_breakpoint(struct task_struct *tsk)  { }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/riscv/include/asm/processor.h:18,
                    from arch/riscv/include/asm/cmpxchg.h:16,
                    from arch/riscv/include/asm/barrier.h:14,
                    from include/asm-generic/bitops/generic-non-atomic.h:7,
                    from include/linux/bitops.h:28,
                    from include/linux/thread_info.h:27,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:107,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:8,
                    from kernel/exit.c:8:
   arch/riscv/include/asm/hw_breakpoint.h:58:20: note: previous definition of 'flush_ptrace_hw_breakpoint' with type 'void(struct task_struct *)'
      58 | static inline void flush_ptrace_hw_breakpoint(struct task_struct *task) { }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/flush_ptrace_hw_breakpoint +137 include/linux/hw_breakpoint.h

24f1e32c60c45c include/linux/hw_breakpoint.h       Frederic Weisbecker 2009-09-09  136  
24f1e32c60c45c include/linux/hw_breakpoint.h       Frederic Weisbecker 2009-09-09 @137  static inline void flush_ptrace_hw_breakpoint(struct task_struct *tsk)	{ }
b332828c39326b include/asm-generic/hw_breakpoint.h K.Prasad            2009-06-01  138  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
