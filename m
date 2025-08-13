Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0E4CA6F;
	Wed, 13 Aug 2025 06:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755065562; cv=none; b=iIszH4FMRlxP+J7Ia+nKSuXgneLDfN63L66tY4bbXX1GXj/R1JUpiJCzu3wO5ALx/ElyaUV684y0kRB3U7xsmj7wEaM8SrxU54F6FHb325fYvHqVOKlBxidbXVHT6itt3/FZDXLkxaD7oUfQhIhMr7Q0F1lt2MR1f5OEi8xwBfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755065562; c=relaxed/simple;
	bh=WEjIl95UqMxFbzW3h7AnyHICcK65Ko5Swc2ymIiErOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSFEair1Vtf5rhpSf8zyxJKpqvUAfMv5vo3fSbNe9TqF/5lfON4+s9oCNu9kc2iF7VOr/j9j+Uhuto0QjmqDRo9X9jKHdYwO4/4Rkgo5zbsLaZk1VgtwJ6dCXglULDFF8teU8MLwcgKLUGoZ6F/T3YqEAELa4XmxmiENkFe63uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k26+XLrG; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k26+XLrG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755065561; x=1786601561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WEjIl95UqMxFbzW3h7AnyHICcK65Ko5Swc2ymIiErOo=;
  b=k26+XLrGbtkXeRqZEnT3Uh7YceBjjUqo5IUeKj7yGAk3sUtboernw/Fy
   ms4szbxQyth4TLC/zhLZoAeG2I49sSc/Ec1fJ2DzdMfBUyhiw1TGxariW
   5tASW61t5RSCyku35KyaKcxt5ODMhtuZJTRyKlHXXUqH0u8ZjuenhBQOB
   /Lp03Th9D10QlP2E//tRvJO4eJNQI7FL3PjBnpDK5QuIssr1k1LcgplB+
   RqijrPuDCH7B0NJGAm8iIOLk4Evx/A/tZoCLi8aX+hCdGyHN1uCixmKKj
   CqQZPw22A2xEBgD4W63TDBn8Bw0G6YCha7X4NljwDkmtzOiRg80nmmQJs
   Q==;
X-CSE-ConnectionGUID: JJHNLjLXRfaHfXLpkPr79w==
X-CSE-MsgGUID: ljy4Un02SKqnuFzWchEwGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="67955599"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="67955599"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 23:12:38 -0700
X-CSE-ConnectionGUID: +WW94DxgSR+S6rEfDZyLDQ==
X-CSE-MsgGUID: bYLOqADlRSeTUjYPXRWrFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="170591939"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 12 Aug 2025 23:12:33 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1um4is-0009aq-1w;
	Wed, 13 Aug 2025 06:12:30 +0000
Date: Wed, 13 Aug 2025 14:12:30 +0800
From: kernel test robot <lkp@intel.com>
To: Jeremy Linton <jeremy.linton@arm.com>,
	linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, thiago.bauermann@linaro.org,
	broonie@kernel.org, yury.khrustalev@arm.com,
	kristina.martsenko@arm.com, liaochang1@huawei.com,
	catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>,
	Steve Capper <steve.capper@arm.com>
Subject: Re: [PATCH v5 5/7] arm64: uprobes: Add GCS support to uretprobes
Message-ID: <202508131334.FfoZQ27h-lkp@intel.com>
References: <20250811141010.741989-6-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811141010.741989-6-jeremy.linton@arm.com>

Hi Jeremy,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on perf-tools-next/perf-tools-next tip/perf/core perf-tools/perf-tools linus/master v6.17-rc1 next-20250812]
[cannot apply to acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Linton/arm64-probes-Break-ret-out-from-bl-blr/20250811-221529
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20250811141010.741989-6-jeremy.linton%40arm.com
patch subject: [PATCH v5 5/7] arm64: uprobes: Add GCS support to uretprobes
config: arm64-randconfig-r111-20250813 (https://download.01.org/0day-ci/archive/20250813/202508131334.FfoZQ27h-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.4.0
reproduce: (https://download.01.org/0day-ci/archive/20250813/202508131334.FfoZQ27h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508131334.FfoZQ27h-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/arm64/kernel/probes/uprobes.c: In function 'arch_uretprobe_hijack_return_addr':
>> arch/arm64/kernel/probes/uprobes.c:171:33: error: implicit declaration of function 'get_user_gcs'; did you mean 'put_user_gcs'? [-Werror=implicit-function-declaration]
     171 |                 gcs_ret_vaddr = get_user_gcs((unsigned long __user *)gcspr, &err);
         |                                 ^~~~~~~~~~~~
         |                                 put_user_gcs
   cc1: some warnings being treated as errors


vim +171 arch/arm64/kernel/probes/uprobes.c

   157	
   158	unsigned long
   159	arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
   160					  struct pt_regs *regs)
   161	{
   162		unsigned long orig_ret_vaddr;
   163		unsigned long gcs_ret_vaddr;
   164		int err = 0;
   165		u64 gcspr;
   166	
   167		orig_ret_vaddr = procedure_link_pointer(regs);
   168	
   169		if (task_gcs_el0_enabled(current)) {
   170			gcspr = read_sysreg_s(SYS_GCSPR_EL0);
 > 171			gcs_ret_vaddr = get_user_gcs((unsigned long __user *)gcspr, &err);
   172			if (err) {
   173				force_sig(SIGSEGV);
   174				goto out;
   175			}
   176	
   177			/*
   178			 * If the LR and GCS return addr don't match, then some kind of PAC
   179			 * signing or control flow occurred since entering the probed function.
   180			 * Likely because the user is attempting to retprobe on an instruction
   181			 * that isn't a function boundary or inside a leaf function. Explicitly
   182			 * abort this retprobe because it will generate a GCS exception.
   183			 */
   184			if (gcs_ret_vaddr != orig_ret_vaddr) {
   185				orig_ret_vaddr = -1;
   186				goto out;
   187			}
   188	
   189			put_user_gcs(trampoline_vaddr, (unsigned long __user *)gcspr, &err);
   190			if (err) {
   191				force_sig(SIGSEGV);
   192				goto out;
   193			}
   194		}
   195	
   196		/* Replace the return addr with trampoline addr */
   197		procedure_link_pointer_set(regs, trampoline_vaddr);
   198	
   199	out:
   200		return orig_ret_vaddr;
   201	}
   202	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
