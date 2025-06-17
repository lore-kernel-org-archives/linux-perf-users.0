Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13524238151;
	Tue, 17 Jun 2025 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750180930; cv=none; b=YN6GqTUaUksgc8nrJi8dJrvFXGps30w8CHur7UV1JQR4a8oOQDUS9OJoab8rmrjYEDNzL9ujNqQvKem/DiP+OUj+NUa7wcGWc/3mqd2RIFviIfhsGgnpKBLaXQPuCtWN1TwXky/q2N/+dU7lr/W1LzJarBW0yPCe3ooD0EG1gP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750180930; c=relaxed/simple;
	bh=dAVSNu+Tde4EIZyn6qHO1/TlPW7vBbQgxZF7UMNRFnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ow2afREmkFGG936P1BwAchzFE1NEInLLwtS0fyyNa7nhUcrwiA6h7FnjplKxU/JEAPaIZHJK1eKN1O+Nzw/ZOt8h9RlNNIhhVYH6Au5W7kk0beZxL4HO3rYDvnyCCJchnWWCxMRhI80Jyqmt5PVmIW7h9nbRxzfv/dblnYCjhAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NnnzJ31n; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NnnzJ31n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750180929; x=1781716929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dAVSNu+Tde4EIZyn6qHO1/TlPW7vBbQgxZF7UMNRFnM=;
  b=NnnzJ31nAnUx3xZ/pAtNnSj5McRix6llfA7cudsgHml8J/MwKARuBNBl
   KI+eIQ9jIOFNO9HoBeLfkP7LWapISvs4OF6Tp6svS/FweLjgrnh2JPLN8
   3IM+eWkK39cpcD39q0WOvnVOKOGsK7ldxsV/tyDahhEDKAVlcf66T5iiE
   2L8/i1xH25dKfgG0xIwWAp4ICN3whV7HFwy8ACRsyCl99kuykc1OpQ2PM
   YWSzjaEmYycHLwwdGhJAfOyFWI1Yxo+c6PcbqBOgVHfgojY2YB+hsy4Bq
   5fJv9jVhqHwcX2ias/lCRpoIye8Q2A8eY5vyq24+Skct4VeFmAdp/ngBS
   Q==;
X-CSE-ConnectionGUID: UQqZij3VS4WEKhSYyvboRA==
X-CSE-MsgGUID: 0UHJ5ySySj2Ueq4eyQlX5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52465815"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="52465815"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 10:22:09 -0700
X-CSE-ConnectionGUID: wcOuWQMEQViVlxOgO6aEkQ==
X-CSE-MsgGUID: yEpwHbqtQ8aabCl6DtGpBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="153750923"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 17 Jun 2025 10:22:06 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uRa0Z-000Hws-2R;
	Tue, 17 Jun 2025 17:22:03 +0000
Date: Wed, 18 Jun 2025 01:21:35 +0800
From: kernel test robot <lkp@intel.com>
To: Ian Rogers <irogers@google.com>, Eric Biggers <ebiggers@google.com>,
	Yuzhuo Jing <yuzhuo@google.com>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v1 1/3] vdso: Switch get/put unaligned from packed struct
 to memcpy
Message-ID: <202506180158.O3zMMHjh-lkp@intel.com>
References: <20250617005800.1410112-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617005800.1410112-2-irogers@google.com>

Hi Ian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.16-rc2 next-20250617]
[cannot apply to tip/timers/vdso acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/vdso-Switch-get-put-unaligned-from-packed-struct-to-memcpy/20250617-085916
base:   linus/master
patch link:    https://lore.kernel.org/r/20250617005800.1410112-2-irogers%40google.com
patch subject: [PATCH v1 1/3] vdso: Switch get/put unaligned from packed struct to memcpy
config: arm64-randconfig-r133-20250617 (https://download.01.org/0day-ci/archive/20250618/202506180158.O3zMMHjh-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce: (https://download.01.org/0day-ci/archive/20250618/202506180158.O3zMMHjh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506180158.O3zMMHjh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> llvm-readelf: warning: 'arch/arm64/kernel/vdso/vdso.so.dbg': invalid PT_DYNAMIC size (0x118)
>> llvm-readelf: warning: 'arch/arm64/kernel/vdso/vdso.so.dbg': PT_DYNAMIC dynamic table is invalid: SHT_DYNAMIC will be used
   arch/arm64/kernel/vdso/vdso.so.dbg: dynamic relocations are not supported
   make[3]: *** [arch/arm64/kernel/vdso/Makefile:64: arch/arm64/kernel/vdso/vdso.so.dbg] Error 1
   make[3]: Target 'include/generated/vdso-offsets.h' not remade because of errors.
   make[3]: Target 'arch/arm64/kernel/vdso/vdso.so' not remade because of errors.
   make[2]: *** [arch/arm64/Makefile:207: vdso_prepare] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
