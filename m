Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F25142A8F;
	Sat, 14 Dec 2024 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734175528; cv=none; b=MCgAgYT7cUi5pa0ZQhv1A6FKVIIo1w0nUR//7xUf+tmBODehdo45XI7mvyKpGSRMH3e4HLghMC9saHggIq1Y/RewRypN1R1NSSgk8XBUJBexG2WnqCc2wQsVmejoB6ydt/EFCsi9IvdtxywrRs7eeiD9x9REl13kQkwWDftbhbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734175528; c=relaxed/simple;
	bh=WIrhc8lgZTYzOMN3sCVepMyea5Ad9uNtxOg0fjPBF6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFqjAv2i9Ehiw9KJHmIfm7zinzNTXaZxfZ/8Kmnm1ZOpC7HHl89g9REAY+D/XplUYbjgrgWxno1J2Ca9A50elxPD2kVbuXMPNwjk0S0rFJRwOxBc/55PgLoauMtr2dSy5sRBErkxqXKp5U+7MOYAnry/au63WTLBk4GQpkjuLlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhUf9tuP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhUf9tuP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734175527; x=1765711527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WIrhc8lgZTYzOMN3sCVepMyea5Ad9uNtxOg0fjPBF6A=;
  b=nhUf9tuPH2EpE/C2Fc1qdri0WlfsOdH2arPRgJEUzMrPIUEDWYQcrv/U
   PKG+9ql9FTUYLTbwkxVFjhe6zYyzRlenP3abvERcpy3Qw3i4HqiY34x9Q
   dX9KHN2Z2pJl2QGjCbwIrwDTcE9gENVbHyl5vY95uuKIkoq0nX8Y0otN0
   TzpQVabpf55Ekgb3//q0ve3ygG5COLaN1sMjZR8XPq+p/nDhVyogiYHw3
   jlo1y+3DCNH1+VRtxjHIkuKcHfK4cWBU26FOkJgg0iN1lVNGqUn2ESsDg
   wcVWFeTFX0Au69EghI3dwUC9AtU5plPXvR1W5uqoPX7ZUXMlbbZd6RZ23
   w==;
X-CSE-ConnectionGUID: HtoC1AebSYKBrvdB/wRmWw==
X-CSE-MsgGUID: nhOx5pJySDay1s/xeNqBrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="52138303"
X-IronPort-AV: E=Sophos;i="6.12,234,1728975600"; 
   d="scan'208";a="52138303"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 03:25:26 -0800
X-CSE-ConnectionGUID: ZgZqYyMmTvSmdIQ6vlVlbw==
X-CSE-MsgGUID: z71IAE+eSFCxbLwuWqyCJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="101855598"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 14 Dec 2024 03:25:22 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMQGt-000Crz-1o;
	Sat, 14 Dec 2024 11:25:19 +0000
Date: Sat, 14 Dec 2024 19:24:30 +0800
From: kernel test robot <lkp@intel.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Weilin Wang <weilin.wang@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1] perf intel-tpebs: Cleanup header
Message-ID: <202412141915.vDvejTWQ-lkp@intel.com>
References: <20241210191823.612631-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210191823.612631-1-irogers@google.com>

Hi Ian,

kernel test robot noticed the following build errors:

[auto build test ERROR on perf-tools-next/perf-tools-next]
[also build test ERROR on tip/perf/core perf-tools/perf-tools linus/master v6.13-rc2 next-20241213]
[cannot apply to acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/perf-intel-tpebs-Cleanup-header/20241211-032044
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20241210191823.612631-1-irogers%40google.com
patch subject: [PATCH v1] perf intel-tpebs: Cleanup header
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241214/202412141915.vDvejTWQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412141915.vDvejTWQ-lkp@intel.com/

All errors (new ones prefixed by >>):

     PERF_VERSION = 6.13.rc1.g19e7440f1089
>> util/intel-tpebs.c:358:10: error: call to undeclared function 'perf_counts'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     358 |         count = perf_counts(evsel->counts, cpu_map_idx, thread);
         |                 ^
>> util/intel-tpebs.c:358:8: error: incompatible integer to pointer conversion assigning to 'struct perf_counts_values *' from 'int' [-Wint-conversion]
     358 |         count = perf_counts(evsel->counts, cpu_map_idx, thread);
         |               ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.
   make[7]: *** [tools/build/Makefile.build:105: tools/perf/util/intel-tpebs.o] Error 1
   make[7]: *** Waiting for unfinished jobs....
   make[6]: *** [tools/build/Makefile.build:158: util] Error 2
   make[5]: *** [Makefile.perf:789: tools/perf/perf-util-in.o] Error 2
   make[5]: *** Waiting for unfinished jobs....
   make[4]: *** [Makefile.perf:292: sub-make] Error 2
   make[3]: *** [Makefile:76: all] Error 2

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
