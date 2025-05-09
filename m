Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67F028FABC;
	Fri,  9 May 2025 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791836; cv=none; b=qwGi4tQ4/7623lWi0rUnxrZ4sNhR9ifhZqSuQvK1Xn/OTGCIb6CzqrksJffZ/Tb7QkWyMwty4VOTq2uWWD2ymdX85Mqv2FMk+OIRihhYuUGwPm+SQiOTm1g/6MfdLv4SmlOWNE5+nySZWy4kOj1iFxXDZ4TIiF8BFeTVt+h3mjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791836; c=relaxed/simple;
	bh=nneM42ftNf3W9eCqj0oF7myaBx5QhI8te/vlDu4AEA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oam8DGCl9yM/4OG6ng48wg6MivbyY2PSFtHm2kGOKHdagjuCiVc6wiXHhpDnI1Y3Fyd1qEOZYBELDSZFPWq6iN0D9PyTLwHc94WmdMoA2+M/33XkoJUNnfk6UnwmebWKbUH8lslQDmmylph6aMYsr7Z8qLMbmsTC3IV6bHzSzwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ncH4M4RJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ncH4M4RJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746791834; x=1778327834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nneM42ftNf3W9eCqj0oF7myaBx5QhI8te/vlDu4AEA4=;
  b=ncH4M4RJ2KX5bS0Jw7Mvz/0rYputq8fnqr1MMYddGee3KvNBiXct4w6y
   lvHGUw7GjHhE5apLG/fCqoCA3mISw5p6z4SnUNQC/K8LIdOkgqDKRUEm0
   sx4j7zUrKLYpGl/zLXhgPa0X9rYwd7Jgz93KEN4XnCCp94DEnFc7AXuJV
   08nRcESKUBSZ+Y6MDsfA+TCnqfUVQbcQ1Wlp9BCVU3F/80W74E12YaVu+
   tWU3k60eN0BmbcyAYFDINiliVABVurc7IcRdWBhkynOHowdGFq2mWMztn
   pnGQ166ZUryXpEhRIv5kq+Bl+SRSeO44etnZzIWeei392vNSz3KouU4FH
   A==;
X-CSE-ConnectionGUID: J1hbgMAOSrKl456U4oEGcw==
X-CSE-MsgGUID: shTH6Z9GQZGT+HOfDp/q9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48776045"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="48776045"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 04:57:13 -0700
X-CSE-ConnectionGUID: CvWz7RQGRRSOCk4M2XPC7g==
X-CSE-MsgGUID: uozSwc/uRNikMEe1RoxKqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="140655720"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 May 2025 04:57:07 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDMLh-000C2N-1E;
	Fri, 09 May 2025 11:57:05 +0000
Date: Fri, 9 May 2025 19:56:46 +0800
From: kernel test robot <lkp@intel.com>
To: Jeremy Linton <jeremy.linton@arm.com>,
	linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, thiago.bauermann@linaro.org,
	broonie@kernel.org, yury.khrustalev@arm.com,
	kristina.martsenko@arm.com, liaochang1@huawei.com,
	catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v3 4/7] arm64: probes: Add GCS support to bl/blr/ret
Message-ID: <202505091926.PBPRfjKb-lkp@intel.com>
References: <20250504233203.616587-5-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250504233203.616587-5-jeremy.linton@arm.com>

Hi Jeremy,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on perf-tools-next/perf-tools-next tip/perf/core perf-tools/perf-tools linus/master v6.15-rc5 next-20250508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Linton/arm64-gcs-task_gcs_el0_enable-should-use-passed-task/20250505-122838
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20250504233203.616587-5-jeremy.linton%40arm.com
patch subject: [PATCH v3 4/7] arm64: probes: Add GCS support to bl/blr/ret
config: arm64-randconfig-001-20250509 (https://download.01.org/0day-ci/archive/20250509/202505091926.PBPRfjKb-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250509/202505091926.PBPRfjKb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505091926.PBPRfjKb-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/arm64/kernel/probes/simulate-insn.c: In function 'update_lr':
>> arch/arm64/kernel/probes/simulate-insn.c:58:3: error: implicit declaration of function 'push_user_gcs'; did you mean 'task_user_tls'? [-Werror=implicit-function-declaration]
      push_user_gcs(addr + 4,  &err);
      ^~~~~~~~~~~~~
      task_user_tls
   arch/arm64/kernel/probes/simulate-insn.c: In function 'simulate_ret':
>> arch/arm64/kernel/probes/simulate-insn.c:162:14: error: implicit declaration of function 'pop_user_gcs'; did you mean 'pin_user_pages'? [-Werror=implicit-function-declaration]
      ret_addr = pop_user_gcs(&err);
                 ^~~~~~~~~~~~
                 pin_user_pages
   cc1: some warnings being treated as errors


vim +58 arch/arm64/kernel/probes/simulate-insn.c

    52	
    53	static inline void update_lr(struct pt_regs *regs, long addr)
    54	{
    55		int err = 0;
    56	
    57		if (user_mode(regs) && task_gcs_el0_enabled(current)) {
  > 58			push_user_gcs(addr + 4,	 &err);
    59			if (err) {
    60				force_sig(SIGSEGV);
    61				return;
    62			}
    63		}
    64		procedure_link_pointer_set(regs, addr + 4);
    65	}
    66	
    67	static bool __kprobes check_cbz(u32 opcode, struct pt_regs *regs)
    68	{
    69		int xn = opcode & 0x1f;
    70	
    71		return (opcode & (1 << 31)) ?
    72		    (get_x_reg(regs, xn) == 0) : (get_w_reg(regs, xn) == 0);
    73	}
    74	
    75	static bool __kprobes check_cbnz(u32 opcode, struct pt_regs *regs)
    76	{
    77		int xn = opcode & 0x1f;
    78	
    79		return (opcode & (1 << 31)) ?
    80		    (get_x_reg(regs, xn) != 0) : (get_w_reg(regs, xn) != 0);
    81	}
    82	
    83	static bool __kprobes check_tbz(u32 opcode, struct pt_regs *regs)
    84	{
    85		int xn = opcode & 0x1f;
    86		int bit_pos = ((opcode & (1 << 31)) >> 26) | ((opcode >> 19) & 0x1f);
    87	
    88		return ((get_x_reg(regs, xn) >> bit_pos) & 0x1) == 0;
    89	}
    90	
    91	static bool __kprobes check_tbnz(u32 opcode, struct pt_regs *regs)
    92	{
    93		int xn = opcode & 0x1f;
    94		int bit_pos = ((opcode & (1 << 31)) >> 26) | ((opcode >> 19) & 0x1f);
    95	
    96		return ((get_x_reg(regs, xn) >> bit_pos) & 0x1) != 0;
    97	}
    98	
    99	/*
   100	 * instruction simulation functions
   101	 */
   102	void __kprobes
   103	simulate_adr_adrp(u32 opcode, long addr, struct pt_regs *regs)
   104	{
   105		long imm, xn, val;
   106	
   107		xn = opcode & 0x1f;
   108		imm = ((opcode >> 3) & 0x1ffffc) | ((opcode >> 29) & 0x3);
   109		imm = sign_extend64(imm, 20);
   110		if (opcode & 0x80000000)
   111			val = (imm<<12) + (addr & 0xfffffffffffff000);
   112		else
   113			val = imm + addr;
   114	
   115		set_x_reg(regs, xn, val);
   116	
   117		instruction_pointer_set(regs, instruction_pointer(regs) + 4);
   118	}
   119	
   120	void __kprobes
   121	simulate_b_bl(u32 opcode, long addr, struct pt_regs *regs)
   122	{
   123		int disp = bbl_displacement(opcode);
   124	
   125		if (opcode & (1 << 31))
   126			update_lr(regs, addr);
   127	
   128		instruction_pointer_set(regs, addr + disp);
   129	}
   130	
   131	void __kprobes
   132	simulate_b_cond(u32 opcode, long addr, struct pt_regs *regs)
   133	{
   134		int disp = 4;
   135	
   136		if (aarch32_opcode_cond_checks[opcode & 0xf](regs->pstate & 0xffffffff))
   137			disp = bcond_displacement(opcode);
   138	
   139		instruction_pointer_set(regs, addr + disp);
   140	}
   141	
   142	void __kprobes
   143	simulate_br_blr(u32 opcode, long addr, struct pt_regs *regs)
   144	{
   145		int xn = (opcode >> 5) & 0x1f;
   146	
   147		/* update pc first in case we're doing a "blr lr" */
   148		instruction_pointer_set(regs, get_x_reg(regs, xn));
   149	
   150		if (((opcode >> 21) & 0x3) == 1)
   151			update_lr(regs, addr);
   152	}
   153	
   154	void __kprobes
   155	simulate_ret(u32 opcode, long addr, struct pt_regs *regs)
   156	{
   157		u64 ret_addr;
   158		int err = 0;
   159		unsigned long lr = procedure_link_pointer(regs);
   160	
   161		if (user_mode(regs) && task_gcs_el0_enabled(current)) {
 > 162			ret_addr = pop_user_gcs(&err);
   163			if (err || ret_addr != lr) {
   164				force_sig(SIGSEGV);
   165				return;
   166			}
   167		}
   168	
   169		instruction_pointer_set(regs, lr);
   170	}
   171	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
