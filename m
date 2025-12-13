Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B0E2773F;
	Sat, 13 Dec 2025 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765620696; cv=none; b=bQA7zyqgUwfxz5XHe+YR4Y4bLhqjQi2Ek6zhBL+P4r8MJFjQdPUJM0wnYiDg7ABRTq4AsiiUhWVyUZcFVhXtqx+xxBwsyEzfq+26aEHuHHhpe6+927gDk2CKsMr2be42YI71RboRTBBjnT0RRi8UfJWjR9iUiWpczMW2++poUI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765620696; c=relaxed/simple;
	bh=CZ0nbq+TNEdlal6qWlcjS6ghxXVLkuG29vXwxsczpXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjjQ7OW4NgaQCl6B1PSsLNzMgv7LXVfl7g8VmfefWOeNi1+800WfcQ2V8Hn1JkCQkrZasUCHWhxFNxkl4TNtpkhI5MD2qEGzvwbL2q/19SHZjV7ehQI5VcylE3qdVBJfOXzL19vkHUjwWjPCXJqwCQdRVlnWdd79Tl1n25sUL5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L7g4osZS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L7g4osZS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765620694; x=1797156694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CZ0nbq+TNEdlal6qWlcjS6ghxXVLkuG29vXwxsczpXE=;
  b=L7g4osZS4TtmnxFO+HYvosBQPu7DZA9lMguVXhGg1S1ZQw7QxkwiIhXD
   vtiU7zw6ISCYEe7bet7LoMNspZ2KnTGj/LFkWFgCgKSRXHWopGnJ6WpWX
   LvQ8joYWhdUyokd3gmoeetMMBcqYfqYrUEX/VZ61rkCaJKeGmx1EHinla
   HaFWIp0Wc358oMTmNDJ/h6letCwMjRwhfE/W5BjVYvnt5xPCCGdrrgbQn
   ZDPpCDKHoy9LzHG5QLexLSj09G+3PbPRnFFvsa0xqW77X0lBc2nkqdurE
   F4m6RNX2xqeKoQcX52YjJwIz2dE/dohjLg7hq2odhBk08R3QpOUA2yZ7E
   Q==;
X-CSE-ConnectionGUID: QQSfNTD5TtmHLhj/NAewfQ==
X-CSE-MsgGUID: 1H8vpWA2Tz6Kk8pi4FYE+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="71456389"
X-IronPort-AV: E=Sophos;i="6.21,146,1763452800"; 
   d="scan'208";a="71456389"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2025 02:11:31 -0800
X-CSE-ConnectionGUID: b0ctH/KrRUSaT01kkNxKSw==
X-CSE-MsgGUID: rjbF0X8iS1+LSKVj5U9vFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,146,1763452800"; 
   d="scan'208";a="197050364"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 13 Dec 2025 02:11:29 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vUMb0-000000007U9-2hay;
	Sat, 13 Dec 2025 10:11:26 +0000
Date: Sat, 13 Dec 2025 18:10:43 +0800
From: kernel test robot <lkp@intel.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: Re: [PATCH] arm64: hw_breakpoint: warn on invalid breakpoint length
Message-ID: <202512131730.89TvJc2D-lkp@intel.com>
References: <20251212205230.84606-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212205230.84606-1-osama.abdelkader@gmail.com>

Hi Osama,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on arm-perf/for-next/perf linus/master v6.18 next-20251212]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Osama-Abdelkader/arm64-hw_breakpoint-warn-on-invalid-breakpoint-length/20251213-045501
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20251212205230.84606-1-osama.abdelkader%40gmail.com
patch subject: [PATCH] arm64: hw_breakpoint: warn on invalid breakpoint length
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20251213/202512131730.89TvJc2D-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251213/202512131730.89TvJc2D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512131730.89TvJc2D-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/arm64/kernel/hw_breakpoint.c:483:17: warning: missing terminating '"' character [-Winvalid-pp-token]
     483 |                         pr_warn_once("hw_breakpoint: invalid AArch64 breakpoint length %d,
         |                                      ^
   arch/arm64/kernel/hw_breakpoint.c:484:24: warning: missing terminating '"' character [-Winvalid-pp-token]
     484 |                                 fixing to 4 bytes\n", hw->ctrl.len);
         |                                                    ^
>> arch/arm64/kernel/hw_breakpoint.c:483:4: error: unterminated function-like macro invocation
     483 |                         pr_warn_once("hw_breakpoint: invalid AArch64 breakpoint length %d,
         |                         ^
   include/linux/printk.h:669:9: note: macro 'pr_warn_once' defined here
     669 | #define pr_warn_once(fmt, ...)                                  \
         |         ^
>> arch/arm64/kernel/hw_breakpoint.c:1014:2: error: expected '}'
    1014 | }
         |  ^
   arch/arm64/kernel/hw_breakpoint.c:476:52: note: to match this '{'
     476 |                 } else if (hw->ctrl.len != ARM_BREAKPOINT_LEN_4) {
         |                                                                  ^
>> arch/arm64/kernel/hw_breakpoint.c:1014:2: error: expected '}'
    1014 | }
         |  ^
   arch/arm64/kernel/hw_breakpoint.c:471:47: note: to match this '{'
     471 |         if (hw->ctrl.type == ARM_BREAKPOINT_EXECUTE) {
         |                                                      ^
>> arch/arm64/kernel/hw_breakpoint.c:1014:2: error: expected '}'
    1014 | }
         |  ^
   arch/arm64/kernel/hw_breakpoint.c:417:1: note: to match this '{'
     417 | {
         | ^
   2 warnings and 4 errors generated.


vim +483 arch/arm64/kernel/hw_breakpoint.c

   410	
   411	/*
   412	 * Construct an arch_hw_breakpoint from a perf_event.
   413	 */
   414	static int arch_build_bp_info(struct perf_event *bp,
   415				      const struct perf_event_attr *attr,
   416				      struct arch_hw_breakpoint *hw)
   417	{
   418		/* Type */
   419		switch (attr->bp_type) {
   420		case HW_BREAKPOINT_X:
   421			hw->ctrl.type = ARM_BREAKPOINT_EXECUTE;
   422			break;
   423		case HW_BREAKPOINT_R:
   424			hw->ctrl.type = ARM_BREAKPOINT_LOAD;
   425			break;
   426		case HW_BREAKPOINT_W:
   427			hw->ctrl.type = ARM_BREAKPOINT_STORE;
   428			break;
   429		case HW_BREAKPOINT_RW:
   430			hw->ctrl.type = ARM_BREAKPOINT_LOAD | ARM_BREAKPOINT_STORE;
   431			break;
   432		default:
   433			return -EINVAL;
   434		}
   435	
   436		/* Len */
   437		switch (attr->bp_len) {
   438		case HW_BREAKPOINT_LEN_1:
   439			hw->ctrl.len = ARM_BREAKPOINT_LEN_1;
   440			break;
   441		case HW_BREAKPOINT_LEN_2:
   442			hw->ctrl.len = ARM_BREAKPOINT_LEN_2;
   443			break;
   444		case HW_BREAKPOINT_LEN_3:
   445			hw->ctrl.len = ARM_BREAKPOINT_LEN_3;
   446			break;
   447		case HW_BREAKPOINT_LEN_4:
   448			hw->ctrl.len = ARM_BREAKPOINT_LEN_4;
   449			break;
   450		case HW_BREAKPOINT_LEN_5:
   451			hw->ctrl.len = ARM_BREAKPOINT_LEN_5;
   452			break;
   453		case HW_BREAKPOINT_LEN_6:
   454			hw->ctrl.len = ARM_BREAKPOINT_LEN_6;
   455			break;
   456		case HW_BREAKPOINT_LEN_7:
   457			hw->ctrl.len = ARM_BREAKPOINT_LEN_7;
   458			break;
   459		case HW_BREAKPOINT_LEN_8:
   460			hw->ctrl.len = ARM_BREAKPOINT_LEN_8;
   461			break;
   462		default:
   463			return -EINVAL;
   464		}
   465	
   466		/*
   467		 * On AArch64, we only permit breakpoints of length 4, whereas
   468		 * AArch32 also requires breakpoints of length 2 for Thumb.
   469		 * Watchpoints can be of length 1, 2, 4 or 8 bytes.
   470		 */
   471		if (hw->ctrl.type == ARM_BREAKPOINT_EXECUTE) {
   472			if (is_compat_bp(bp)) {
   473				if (hw->ctrl.len != ARM_BREAKPOINT_LEN_2 &&
   474				    hw->ctrl.len != ARM_BREAKPOINT_LEN_4)
   475					return -EINVAL;
   476			} else if (hw->ctrl.len != ARM_BREAKPOINT_LEN_4) {
   477				/*
   478				 * Some tools (e.g. perf) incorrectly assume that
   479				 * breakpoints should be sizeof(long). This is wrong
   480				 * for AArch64 where breakpoints must be 4 bytes.
   481				 * Warn the user and fix up the parameter.
   482				 */
 > 483				pr_warn_once("hw_breakpoint: invalid AArch64 breakpoint length %d,
 > 484					fixing to 4 bytes\n", hw->ctrl.len);
   485				hw->ctrl.len = ARM_BREAKPOINT_LEN_4;
   486			}
   487		}
   488	
   489		/* Address */
   490		hw->address = attr->bp_addr;
   491	
   492		/*
   493		 * Privilege
   494		 * Note that we disallow combined EL0/EL1 breakpoints because
   495		 * that would complicate the stepping code.
   496		 */
   497		if (arch_check_bp_in_kernelspace(hw))
   498			hw->ctrl.privilege = AARCH64_BREAKPOINT_EL1;
   499		else
   500			hw->ctrl.privilege = AARCH64_BREAKPOINT_EL0;
   501	
   502		/* Enabled? */
   503		hw->ctrl.enabled = !attr->disabled;
   504	
   505		return 0;
   506	}
   507	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
