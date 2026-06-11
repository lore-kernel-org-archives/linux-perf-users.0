Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D946B3CAA31;
	Thu, 11 Jun 2026 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172482; cv=none; b=Zy4feud6eUu7QkM+VWvJUn7srFZRW0XoHEegDelC/uQCd9VI9ugu1fFu8tQ/OHj9w1lVZ3O1d5hmO2Z8CJZFQoFik9+qPAxGSe2WzrRNIugNw99ZZfdIgjf8KvDhWk2gQXcEfjPJOz71qS3Jc03Pp55Vn82OMA9/j/YGGKH+LRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172482; c=relaxed/simple;
	bh=dO49bB1U82I9NOj7iBCUPCZlEj0Bk6lEc/VkexmVjv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxmRPCSTG3ImDYqpBvZkQphiYElcuFAM55GrrBdSNMUU/B8X03qenUcesL5g7emUBNdyi+8YgEXpcztwJWcdQFxZM+KzK71rkVz1dUbmoQ7yDu7BbrYM62lFHTUQkRdVjV6doCnAj9DIFxELrD4lkUT5I3rWfxG6VeWRxosb/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I8SyMQnT; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I8SyMQnT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781172481; x=1812708481;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dO49bB1U82I9NOj7iBCUPCZlEj0Bk6lEc/VkexmVjv8=;
  b=I8SyMQnTmLiv95X4TXzhi4ocrmyw1+x0c5JVFrD9Aj45vtk2VsQ1BtnA
   t2E3UUE7riGO25UncCqf1Tq7WFZ2fV/ovqpU9Pvx48TmZY6fWdH7VaWAr
   IGuR2E6B3tz9pMSNoIGRm9E6aSTQFjqmQCDPd7BuyaqGdHgyPEsMt1y4j
   j+pkNUar09yHdd/DURjJWYoiJxG9pGVXl4dmpJEvWi0ryGh4th2u+oDJX
   HRaCbYsXknM8Qov3WHJyCNFRsEM1vCRQmLVsT7in/Wt+4QZnhnbeekOBh
   WSxHYGvKh9MjLwwtzpaARkhngu/x962cxGmLiQbd6iekin0X8zXUfpfmf
   A==;
X-CSE-ConnectionGUID: ctms7xStRW+MDAEOWft4tw==
X-CSE-MsgGUID: wGwRCckUQZmwNgLFd3QtjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81961797"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="81961797"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 03:08:01 -0700
X-CSE-ConnectionGUID: DOHW+5KbQMyubQMXOVKvWA==
X-CSE-MsgGUID: NrbSc8hxRWa0wB2jZjosvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="246459572"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 11 Jun 2026 03:07:58 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wXcKJ-00000000MkY-1KqM;
	Thu, 11 Jun 2026 10:07:55 +0000
Date: Thu, 11 Jun 2026 18:07:24 +0800
From: kernel test robot <lkp@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, jic23@kernel.org, will@kernel.org,
	mark.rutland@arm.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Harshal Thakkar <harshal.t@samsung.com>,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH] perf/cxlpmu: Support Channel/Rank/Bank filter
Message-ID: <202606111843.aJlNG96K-lkp@intel.com>
References: <20260611010409.2776635-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611010409.2776635-1-dave@stgolabs.net>

Hi Davidlohr,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arm-perf/for-next/perf]
[also build test WARNING on cxl/next linus/master v7.1-rc7 next-20260610]
[cannot apply to cxl/pending]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Davidlohr-Bueso/perf-cxlpmu-Support-Channel-Rank-Bank-filter/20260611-090512
base:   https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-next/perf
patch link:    https://lore.kernel.org/r/20260611010409.2776635-1-dave%40stgolabs.net
patch subject: [PATCH] perf/cxlpmu: Support Channel/Rank/Bank filter
config: i386-buildonly-randconfig-001-20260611 (https://download.01.org/0day-ci/archive/20260611/202606111843.aJlNG96K-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260611/202606111843.aJlNG96K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606111843.aJlNG96K-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/perf/cxl_pmu.c:344:19: warning: shift count >= width of type [-Wshift-count-overflow]
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:39: note: expanded from macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^
   include/linux/bits.h:48:20: note: expanded from macro 'GENMASK_TYPE'
      48 |              (type_max(t) << (l) &                              \
         |                           ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:699:22: note: expanded from macro 'compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:687:23: note: expanded from macro '_compiletime_assert'
     687 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:679:9: note: expanded from macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/perf/cxl_pmu.c:344:19: warning: shift count >= width of type [-Wshift-count-overflow]
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:39: note: expanded from macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^
   include/linux/bits.h:49:20: note: expanded from macro 'GENMASK_TYPE'
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:699:22: note: expanded from macro 'compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:687:23: note: expanded from macro '_compiletime_assert'
     687 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:679:9: note: expanded from macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/perf/cxl_pmu.c:344:19: warning: shift count >= width of type [-Wshift-count-overflow]
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:39: note: expanded from macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^
   include/linux/bits.h:48:20: note: expanded from macro 'GENMASK_TYPE'
      48 |              (type_max(t) << (l) &                              \
         |                           ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:699:22: note: expanded from macro 'compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:687:23: note: expanded from macro '_compiletime_assert'
     687 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:679:9: note: expanded from macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/perf/cxl_pmu.c:344:19: warning: shift count >= width of type [-Wshift-count-overflow]
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:39: note: expanded from macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^
   include/linux/bits.h:49:20: note: expanded from macro 'GENMASK_TYPE'
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:699:22: note: expanded from macro 'compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:687:23: note: expanded from macro '_compiletime_assert'
     687 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:679:9: note: expanded from macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/perf/cxl_pmu.c:344:19: warning: shift count >= width of type [-Wshift-count-overflow]
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:39: note: expanded from macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^
   include/linux/bits.h:48:20: note: expanded from macro 'GENMASK_TYPE'
      48 |              (type_max(t) << (l) &                              \
         |                           ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:699:22: note: expanded from macro 'compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:687:23: note: expanded from macro '_compiletime_assert'
     687 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:679:9: note: expanded from macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/perf/cxl_pmu.c:344:19: warning: shift count >= width of type [-Wshift-count-overflow]
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:39: note: expanded from macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^
   include/linux/bits.h:49:20: note: expanded from macro 'GENMASK_TYPE'
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:699:22: note: expanded from macro 'compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:687:23: note: expanded from macro '_compiletime_assert'
     687 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:679:9: note: expanded from macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   6 warnings generated.


vim +344 drivers/perf/cxl_pmu.c

   341	
   342	static u16 cxl_pmu_config2_get_crb(struct perf_event *event)
   343	{
 > 344		return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
   345	}
   346	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
