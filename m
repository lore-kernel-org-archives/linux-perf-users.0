Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A80B392C28;
	Tue,  5 May 2026 02:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777948329; cv=none; b=h3np86RlPIWDIO8tWmmmOtZ4jxOcLQfe4zASMKqokIcw3kDtuDgUpYVFANHlaO7ZrL+R5Jj+p/y9U9lTE+50gj43pwvC36SeeGzHnIAAubLylPc4ftlZK4mg3ywINfuzlvdwwgKg+DCr7F1mcRKHFYroKbW08Eb5A4GI41wVhhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777948329; c=relaxed/simple;
	bh=7zNpcILadDmWNHLxoyVttbmV+/p9Sska7BiaQLLfP8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKUZEv3LYzHQZjNFopko/pmP+D5bTOxYbrXanc6+ci5DJKwhc5Icw1Hg1utPw2jM7kth66Du8vh2CwQATCMH6b/yP7GmxJP5KzRe22gBTPDc5yxYhG+Yj/XNbecy0z9+PemTRUrYd4l6OZepNOkc4RzMfuULxVFXquPPKMXtzLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OaORdmlu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OaORdmlu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777948326; x=1809484326;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7zNpcILadDmWNHLxoyVttbmV+/p9Sska7BiaQLLfP8c=;
  b=OaORdmlu04mkZPINA9jauoo8OGxbnBPYttGqFWhtAJQZg5nOW6t67pEJ
   sobaaWPThQfawwXiMHHQRROoI3kYnVEFqSGzPd8ul0AM0THp3zMxvy3Gt
   nIgVBQ0IKbwBaqj5wkUyX04Ew0Srpd0mqNvlV0WBIFpagX7dw04esHGti
   xB4i7gG+3Rv1ttxD8AVtISiMTP3qFd3N7qRRayWz0nnfTQAteOSKE2SwE
   zm8YZwQtSO+cfsj35Pm0irLclY8YRKEUpe/gLdE0vv3/QmGHQV/PG6GDT
   YDskBgZViFQCe/y3o+R8kNLS+bcPIMBUBbHE9t5Qa+dxrmfvf2UhWCArh
   g==;
X-CSE-ConnectionGUID: Y6Pad/h8Q6yEZuAn++xmHA==
X-CSE-MsgGUID: fa4pgp8DTTa482bSnTc/WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="90186106"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="90186106"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 19:32:06 -0700
X-CSE-ConnectionGUID: x5tyru0WSOqoOuafiwR/Pw==
X-CSE-MsgGUID: q6TJWa8mTjG8bL9tbn4lSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="259344956"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 04 May 2026 19:32:03 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wK5Zi-000000004Az-0bIO;
	Tue, 05 May 2026 02:31:56 +0000
Date: Tue, 5 May 2026 10:31:02 +0800
From: kernel test robot <lkp@intel.com>
To: Aviv Bakal <avivb@amazon.com>, robin.murphy@arm.com, will@kernel.org,
	mark.rutland@arm.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	zeev@amazon.com, blakgeof@amazon.com
Subject: Re: [PATCH v2] perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5
Message-ID: <202605051052.zOemYJY9-lkp@intel.com>
References: <20260504133923.23373-1-avivb@amazon.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504133923.23373-1-avivb@amazon.com>

Hi Aviv,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm-perf/for-next/perf]
[also build test ERROR on soc/for-next linus/master v7.1-rc2 next-20260430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aviv-Bakal/perf-arm-cmn-Add-workarounds-for-CMN-S3-on-Graviton5/20260505-011858
base:   https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-next/perf
patch link:    https://lore.kernel.org/r/20260504133923.23373-1-avivb%40amazon.com
patch subject: [PATCH v2] perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5
config: i386-buildonly-randconfig-004-20260505 (https://download.01.org/0day-ci/archive/20260505/202605051052.zOemYJY9-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260505/202605051052.zOemYJY9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605051052.zOemYJY9-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/perf/arm-cmn.c:617:15: error: static assertion failed due to requirement 'sizeof(struct arm_cmn_hw_event) <= __builtin_offsetof(struct hw_perf_event, target)': sizeof(struct arm_cmn_hw_event) <= offsetof(struct hw_perf_event, target)
     617 | static_assert(sizeof(struct arm_cmn_hw_event) <= offsetof(struct hw_perf_event, target));
         | ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   drivers/perf/arm-cmn.c:617:47: note: expression evaluates to '104 <= 96'
     617 | static_assert(sizeof(struct arm_cmn_hw_event) <= offsetof(struct hw_perf_event, target));
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   1 error generated.


vim +617 drivers/perf/arm-cmn.c

a88fa6c28b867a Robin Murphy   2021-12-03  600  
0ba64770a2f2e5 Robin Murphy   2020-09-18  601  struct arm_cmn_hw_event {
0ba64770a2f2e5 Robin Murphy   2020-09-18  602  	struct arm_cmn_node *dn;
359414b33e00ba Robin Murphy   2024-09-02  603  	u64 dtm_idx[DIV_ROUND_UP(CMN_MAX_NODES_PER_EVENT * 2, 64)];
7633ec2c262fab Robin Murphy   2023-10-20  604  	s8 dtc_idx[CMN_MAX_DTCS];
0ba64770a2f2e5 Robin Murphy   2020-09-18  605  	u8 num_dns;
60d1504070c22c Robin Murphy   2021-12-03  606  	u8 dtm_offset;
4a112585ebe8cb Ilkka Koskinen 2024-06-17  607  
4a112585ebe8cb Ilkka Koskinen 2024-06-17  608  	/*
4a112585ebe8cb Ilkka Koskinen 2024-06-17  609  	 * WP config registers are divided to UP and DOWN events. We need to
4a112585ebe8cb Ilkka Koskinen 2024-06-17  610  	 * keep to track only one of them.
4a112585ebe8cb Ilkka Koskinen 2024-06-17  611  	 */
4a112585ebe8cb Ilkka Koskinen 2024-06-17  612  	DECLARE_BITMAP(wp_idx, CMN_MAX_XPS);
4a112585ebe8cb Ilkka Koskinen 2024-06-17  613  
23760a0144173e Robin Murphy   2022-04-18  614  	bool wide_sel;
65adf71398f5af Robin Murphy   2022-04-18  615  	enum cmn_filter_select filter_sel;
0ba64770a2f2e5 Robin Murphy   2020-09-18  616  };
ff436cee694ee8 Robin Murphy   2024-09-02 @617  static_assert(sizeof(struct arm_cmn_hw_event) <= offsetof(struct hw_perf_event, target));
0ba64770a2f2e5 Robin Murphy   2020-09-18  618  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
