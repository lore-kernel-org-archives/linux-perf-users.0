Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA823B9DAB;
	Thu, 11 Jun 2026 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781173206; cv=none; b=JE/917XPmhfn5tyVLzz1LZOdD6VT/B3fjL2YJI1gcjXuP6o3n+WIvB4ByjDvyCJUihXbqsoKaVdao7J/tJKrFeTjcbyL99Abpl90/uY4L8C0C1+cSGwLe70v8mHigkWfXCUTQBNsENuPmeZxLBBWPuJ5P9QOfPExaayogGrUPh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781173206; c=relaxed/simple;
	bh=9ZinSF2ZYGYkw58iY2LdpTRq3kAEK2U0A8kdLA78wgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8/VnIpO8ib8HQzNSjJNyEHvERuhYJkpLCMN1dzigk+S7QkEQN9ElFbabqRSQDAtSFD15z2jT74zPWuELZq11KABY/VaqVZ+IFZeUoYLaMdHMQYJNlS0bBlykjOpwrc4wLwnzDQNkE2mgZ7q17W6wqkkMNqkp9v8DcmbCbJaL7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lm9IVYr0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lm9IVYr0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781173203; x=1812709203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9ZinSF2ZYGYkw58iY2LdpTRq3kAEK2U0A8kdLA78wgc=;
  b=Lm9IVYr0BwxoDMTX+qwJcrAuMdTUGBp11O8Zk/UK5s7jduJ/+Va7tOPW
   begs6xSWFjieIQ7WFZo7DessZVY6KlDa/jq7qL/WiWlZYD+99nDsnBlbx
   ipbamXoIEDZBLHktVCVqvWCAsOoWytoIOFko3oYLCme32DOu277IHtqED
   x1ca+PqB+saMEp6/I9vfRiFiylErDE+96Osmh6i4CelzEt7Lg3GqNURb9
   WY5f19bRBoN5u59GQ1NXEfTNGsl4At5/8QqWJ2bJRyeU7Y7JdcIMwRU8Y
   NnO75CGmPSDtgKa8bd6fSvYv17TzYEkjMS5bgWLSFpu5Grom4Sqw4fRpt
   Q==;
X-CSE-ConnectionGUID: AtlvUe4OT5+RxgwQqPEjxQ==
X-CSE-MsgGUID: Ns0aUm51Q56Pq7R5rA+hJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85880705"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="85880705"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 03:20:02 -0700
X-CSE-ConnectionGUID: 2XxlcGYgSrW3wSB7Yy6WeQ==
X-CSE-MsgGUID: 3TzXXz5CTGizn4sfHUeXlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="248316614"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 Jun 2026 03:19:59 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wXcVw-00000000Mly-28Xa;
	Thu, 11 Jun 2026 10:19:56 +0000
Date: Thu, 11 Jun 2026 18:19:01 +0800
From: kernel test robot <lkp@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, jic23@kernel.org, will@kernel.org,
	mark.rutland@arm.com
Cc: oe-kbuild-all@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Harshal Thakkar <harshal.t@samsung.com>,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH] perf/cxlpmu: Support Channel/Rank/Bank filter
Message-ID: <202606111835.kj0nhZ5e-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on arm-perf/for-next/perf]
[also build test ERROR on cxl/next linus/master v7.1-rc7 next-20260610]
[cannot apply to cxl/pending]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Davidlohr-Bueso/perf-cxlpmu-Support-Channel-Rank-Bank-filter/20260611-090512
base:   https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-next/perf
patch link:    https://lore.kernel.org/r/20260611010409.2776635-1-dave%40stgolabs.net
patch subject: [PATCH] perf/cxlpmu: Support Channel/Rank/Bank filter
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20260611/202606111835.kj0nhZ5e-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260611/202606111835.kj0nhZ5e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606111835.kj0nhZ5e-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/perf/cxl_pmu.c: In function 'cxl_pmu_config2_get_crb':
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/compiler_types.h:679:23: note: in definition of macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:79:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      79 |         BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >               \
         |         ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:79:26: note: in expansion of macro '__bf_cast_unsigned'
      79 |         BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >               \
         |                          ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:177:17: note: in expansion of macro '__BF_FIELD_CHECK_REG'
     177 |                 __BF_FIELD_CHECK_REG(_mask, _reg, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:344:16: note: in expansion of macro 'FIELD_GET'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:49: note: in expansion of macro 'GENMASK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^~~~~~~
   drivers/perf/cxl_pmu.c:344:26: note: in expansion of macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:679:23: note: in definition of macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:79:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      79 |         BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >               \
         |         ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:79:26: note: in expansion of macro '__bf_cast_unsigned'
      79 |         BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >               \
         |                          ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:177:17: note: in expansion of macro '__BF_FIELD_CHECK_REG'
     177 |                 __BF_FIELD_CHECK_REG(_mask, _reg, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:344:16: note: in expansion of macro 'FIELD_GET'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:49: note: in expansion of macro 'GENMASK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^~~~~~~
   drivers/perf/cxl_pmu.c:344:26: note: in expansion of macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/compiler_types.h:679:23: note: in definition of macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:67:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      67 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/perf/cxl_pmu.c:344:16: note: in expansion of macro 'FIELD_GET'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:49: note: in expansion of macro 'GENMASK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^~~~~~~
   drivers/perf/cxl_pmu.c:344:26: note: in expansion of macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:679:23: note: in definition of macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:67:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      67 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/perf/cxl_pmu.c:344:16: note: in expansion of macro 'FIELD_GET'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:49: note: in expansion of macro 'GENMASK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^~~~~~~
   drivers/perf/cxl_pmu.c:344:26: note: in expansion of macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/compiler_types.h:679:23: note: in definition of macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:69:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      69 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/perf/cxl_pmu.c:344:16: note: in expansion of macro 'FIELD_GET'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:49: note: in expansion of macro 'GENMASK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^~~~~~~
   drivers/perf/cxl_pmu.c:344:26: note: in expansion of macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:679:23: note: in definition of macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:69:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      69 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/perf/cxl_pmu.c:344:16: note: in expansion of macro 'FIELD_GET'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:49: note: in expansion of macro 'GENMASK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^~~~~~~
   drivers/perf/cxl_pmu.c:344:26: note: in expansion of macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/compiler_types.h:679:23: note: in definition of macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:70:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      70 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/perf/cxl_pmu.c:344:16: note: in expansion of macro 'FIELD_GET'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:49: note: in expansion of macro 'GENMASK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^~~~~~~
   drivers/perf/cxl_pmu.c:344:26: note: in expansion of macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:679:23: note: in definition of macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:70:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      70 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/perf/cxl_pmu.c:344:16: note: in expansion of macro 'FIELD_GET'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:49: note: in expansion of macro 'GENMASK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^~~~~~~
   drivers/perf/cxl_pmu.c:344:26: note: in expansion of macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/compiler_types.h:679:23: note: in definition of macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:70:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      70 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:47: note: in expansion of macro '__bf_shf'
      71 |                                  ~((_mask) >> __bf_shf(_mask)) &        \
         |                                               ^~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/perf/cxl_pmu.c:344:16: note: in expansion of macro 'FIELD_GET'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:49: note: in expansion of macro 'GENMASK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^~~~~~~
   drivers/perf/cxl_pmu.c:344:26: note: in expansion of macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:679:23: note: in definition of macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:70:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      70 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:47: note: in expansion of macro '__bf_shf'
      71 |                                  ~((_mask) >> __bf_shf(_mask)) &        \
         |                                               ^~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/perf/cxl_pmu.c:344:16: note: in expansion of macro 'FIELD_GET'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:49: note: in expansion of macro 'GENMASK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^~~~~~~
   drivers/perf/cxl_pmu.c:344:26: note: in expansion of macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/compiler_types.h:679:23: note: in definition of macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:51:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      51 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/perf/cxl_pmu.c:344:16: note: in expansion of macro 'FIELD_GET'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:49: note: in expansion of macro 'GENMASK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^~~~~~~
   drivers/perf/cxl_pmu.c:344:26: note: in expansion of macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:679:23: note: in definition of macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:51:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      51 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/perf/cxl_pmu.c:344:16: note: in expansion of macro 'FIELD_GET'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:49: note: in expansion of macro 'GENMASK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^~~~~~~
   drivers/perf/cxl_pmu.c:344:26: note: in expansion of macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/compiler_types.h:679:23: note: in definition of macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:51:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      51 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:75:56: note: in expansion of macro '__bf_shf'
      75 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/perf/cxl_pmu.c:344:16: note: in expansion of macro 'FIELD_GET'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:49: note: in expansion of macro 'GENMASK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^~~~~~~
   drivers/perf/cxl_pmu.c:344:26: note: in expansion of macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:679:23: note: in definition of macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:51:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      51 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:75:56: note: in expansion of macro '__bf_shf'
      75 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/perf/cxl_pmu.c:344:16: note: in expansion of macro 'FIELD_GET'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:49: note: in expansion of macro 'GENMASK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^~~~~~~
   drivers/perf/cxl_pmu.c:344:26: note: in expansion of macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/compiler_types.h:679:23: note: in definition of macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:51:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      51 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/perf/cxl_pmu.c:344:16: note: in expansion of macro 'FIELD_GET'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:49: note: in expansion of macro 'GENMASK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^~~~~~~
   drivers/perf/cxl_pmu.c:344:26: note: in expansion of macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:679:23: note: in definition of macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:51:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      51 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/perf/cxl_pmu.c:344:16: note: in expansion of macro 'FIELD_GET'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:49: note: in expansion of macro 'GENMASK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^~~~~~~
   drivers/perf/cxl_pmu.c:344:26: note: in expansion of macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/compiler_types.h:679:23: note: in definition of macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:51:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      51 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:75:56: note: in expansion of macro '__bf_shf'
      75 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/perf/cxl_pmu.c:344:16: note: in expansion of macro 'FIELD_GET'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:49: note: in expansion of macro 'GENMASK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^~~~~~~
   drivers/perf/cxl_pmu.c:344:26: note: in expansion of macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:679:23: note: in definition of macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:51:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      51 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:75:56: note: in expansion of macro '__bf_shf'
      75 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/perf/cxl_pmu.c:344:16: note: in expansion of macro 'FIELD_GET'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:49: note: in expansion of macro 'GENMASK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^~~~~~~
   drivers/perf/cxl_pmu.c:344:26: note: in expansion of macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/perf/../cxl/cxl.h:8,
                    from drivers/perf/../cxl/cxlpci.h:6,
                    from drivers/perf/cxl_pmu.c:23:
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/bitfield.h:98:42: note: in definition of macro '__FIELD_GET'
      98 |                 (typeof(mask))(((reg) & (mask)) >> __bf_shf(mask));     \
         |                                          ^~~~
   drivers/perf/cxl_pmu.c:344:16: note: in expansion of macro 'FIELD_GET'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:49: note: in expansion of macro 'GENMASK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^~~~~~~
   drivers/perf/cxl_pmu.c:344:26: note: in expansion of macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/bitfield.h:98:42: note: in definition of macro '__FIELD_GET'
      98 |                 (typeof(mask))(((reg) & (mask)) >> __bf_shf(mask));     \
         |                                          ^~~~
   drivers/perf/cxl_pmu.c:344:16: note: in expansion of macro 'FIELD_GET'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:49: note: in expansion of macro 'GENMASK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^~~~~~~
   drivers/perf/cxl_pmu.c:344:26: note: in expansion of macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/bitfield.h:47:38: note: in definition of macro '__bf_shf'
      47 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/perf/cxl_pmu.c:344:16: note: in expansion of macro 'FIELD_GET'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:49: note: in expansion of macro 'GENMASK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^~~~~~~
   drivers/perf/cxl_pmu.c:344:26: note: in expansion of macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/bitfield.h:47:38: note: in definition of macro '__bf_shf'
      47 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/perf/cxl_pmu.c:344:16: note: in expansion of macro 'FIELD_GET'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/perf/cxl_pmu.c:258:49: note: in expansion of macro 'GENMASK'
     258 | #define CXL_PMU_ATTR_CONFIG2_CRB_MSK            GENMASK(63, 32)
         |                                                 ^~~~~~~
   drivers/perf/cxl_pmu.c:344:26: note: in expansion of macro 'CXL_PMU_ATTR_CONFIG2_CRB_MSK'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'cxl_pmu_config2_get_crb',
       inlined from 'cxl_pmu_event_start' at drivers/perf/cxl_pmu.c:676:10:
   include/linux/compiler_types.h:699:45: error: call to '__compiletime_assert_649' declared with attribute error: FIELD_GET: mask is zero
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:680:25: note: in definition of macro '__compiletime_assert'
     680 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:69:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      69 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/perf/cxl_pmu.c:344:16: note: in expansion of macro 'FIELD_GET'
     344 |         return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
         |                ^~~~~~~~~
..


vim +/__compiletime_assert_649 +699 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  685  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  686  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  687  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  688  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  689  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  690   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  691   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  692   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  693   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  694   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  695   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  696   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  697   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  698  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @699  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  700  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
