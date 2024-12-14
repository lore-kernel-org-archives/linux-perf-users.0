Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76E329CEF;
	Sat, 14 Dec 2024 22:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734217059; cv=none; b=hQKF4g4Pnr7aoo3bgdZQzFkzPQcZ7b7esfKt3puBwTwsphSYtf9tjqe3IVr6HMsqr31CnjfNmxXWVloji4cKaIE4GZMGKT7k8VNOw1Xee1mBHGf06cPg0/D96TuAcfQXZQ4yWmh6MN9UdeFHGs+khuQlEIrZ2LKG97LFSQADKDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734217059; c=relaxed/simple;
	bh=aWeQCtEExRvJcyKuPBU3WPE5Oa/U1K5TMCkAI/IQLb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k72TDs5j5JrAwog0nYDqvZ5giFxLpie9Ydn0fn6MugMmtqhviRtPPKaZfEb2MvVJSpuXyN2GAsmxxmOMSiA9jh4BKb5VPupV68ILtQ8AyQUZbU5Gf/bPLjGe/MI7ZqD5xSBHehku7q8UBwwrlPkfABUOEJ5f+BR3Djnp2g5hyM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8OoWHg/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8OoWHg/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734217058; x=1765753058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aWeQCtEExRvJcyKuPBU3WPE5Oa/U1K5TMCkAI/IQLb0=;
  b=i8OoWHg/eEEQ4bijXdB+qABLmHc4jZd02IC4SXJbOrQAGZkV9qp3IN3N
   Ysvh3NWiMlOjZPCxxdn7eYxBOdd38K+yfDmRLyw0flDGu90J+O2n6nSl8
   BboQ1MZ5FQgZdJgM0nEQq0nwOrh2HC/uav7JEQe1SUwy3mGmNLYO0gQl2
   ipCnkIGOKL2w0RaQ9UJqn32Sp9bwKQ9gIJLlyLKF7HFpNz05M5gxxjbDA
   KFBqyCdMRxQEUdtM2CCrGnS+AyL5A1ighM4944t8D/UvpJ8pM3V69cj3V
   C9xGEV1cxiSfGhp/DF8xaocEytGis96zmapb8O0I1pT4hc9hMvHFNsIXo
   Q==;
X-CSE-ConnectionGUID: 8EWbRBCrSByhpNV1Q1YUiQ==
X-CSE-MsgGUID: 11P1WZ4DT7yBEm8ad3CFXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11286"; a="38326054"
X-IronPort-AV: E=Sophos;i="6.12,235,1728975600"; 
   d="scan'208";a="38326054"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 14:57:38 -0800
X-CSE-ConnectionGUID: SJY3DBdBQma0PKestw+KtA==
X-CSE-MsgGUID: HaJhIgK2TGicmhAZna6hkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134198452"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 14 Dec 2024 14:57:33 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMb4k-000DIo-01;
	Sat, 14 Dec 2024 22:57:30 +0000
Date: Sun, 15 Dec 2024 06:57:09 +0800
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
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Edward Baker <edward.baker@intel.com>,
	Michael Petlan <mpetlan@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 03/22] perf vendor events: Add Arrowlake events/metrics
Message-ID: <202412150635.sGYwFvX2-lkp@intel.com>
References: <20241209222800.296000-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209222800.296000-4-irogers@google.com>

Hi Ian,

kernel test robot noticed the following build errors:

[auto build test ERROR on perf-tools-next/perf-tools-next]
[also build test ERROR on tip/perf/core perf-tools/perf-tools linus/master v6.13-rc2 next-20241213]
[cannot apply to acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/perf-vendor-events-Update-Alderlake-events-metrics/20241210-064605
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20241209222800.296000-4-irogers%40google.com
patch subject: [PATCH v1 03/22] perf vendor events: Add Arrowlake events/metrics
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241215/202412150635.sGYwFvX2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412150635.sGYwFvX2-lkp@intel.com/

All errors (new ones prefixed by >>):

     PERF_VERSION = 6.12.rc6.g947fa0393dbc
>> tools/perf/pmu-events/pmu-events.c:27919:156: error: expected expression
    27919 | { 388816 }, /* fp_arith_dispatched.v0\000floating point\000Number of FP-arith-uops dispatched on 1st VEC port (port 0). FP-arith-uops are of type ADD*/SUB*/MUL/FMA*/DPP\000event=0xb3,period=2000003,umask=1\000\00000\000\000 */
          |                                                                                                                                                            ^
>> tools/perf/pmu-events/pmu-events.c:27919:152: error: use of undeclared identifier 'SUB'
    27919 | { 388816 }, /* fp_arith_dispatched.v0\000floating point\000Number of FP-arith-uops dispatched on 1st VEC port (port 0). FP-arith-uops are of type ADD*/SUB*/MUL/FMA*/DPP\000event=0xb3,period=2000003,umask=1\000\00000\000\000 */
          |                                                                                                                                                        ^
>> tools/perf/pmu-events/pmu-events.c:27919:157: error: use of undeclared identifier 'MUL'
    27919 | { 388816 }, /* fp_arith_dispatched.v0\000floating point\000Number of FP-arith-uops dispatched on 1st VEC port (port 0). FP-arith-uops are of type ADD*/SUB*/MUL/FMA*/DPP\000event=0xb3,period=2000003,umask=1\000\00000\000\000 */
          |                                                                                                                                                             ^
>> tools/perf/pmu-events/pmu-events.c:27919:161: error: use of undeclared identifier 'FMA'
    27919 | { 388816 }, /* fp_arith_dispatched.v0\000floating point\000Number of FP-arith-uops dispatched on 1st VEC port (port 0). FP-arith-uops are of type ADD*/SUB*/MUL/FMA*/DPP\000event=0xb3,period=2000003,umask=1\000\00000\000\000 */
          |                                                                                                                                                                 ^
   tools/perf/pmu-events/pmu-events.c:27919:165: error: expected expression
    27919 | { 388816 }, /* fp_arith_dispatched.v0\000floating point\000Number of FP-arith-uops dispatched on 1st VEC port (port 0). FP-arith-uops are of type ADD*/SUB*/MUL/FMA*/DPP\000event=0xb3,period=2000003,umask=1\000\00000\000\000 */
          |                                                                                                                                                                     ^
>> tools/perf/pmu-events/pmu-events.c:27919:166: error: use of undeclared identifier 'DPP'
    27919 | { 388816 }, /* fp_arith_dispatched.v0\000floating point\000Number of FP-arith-uops dispatched on 1st VEC port (port 0). FP-arith-uops are of type ADD*/SUB*/MUL/FMA*/DPP\000event=0xb3,period=2000003,umask=1\000\00000\000\000 */
          |                                                                                                                                                                      ^
>> tools/perf/pmu-events/pmu-events.c:28343:21: error: invalid application of 'sizeof' to an incomplete type 'const struct compact_pmu_event[]'
    28343 |      .num_entries = ARRAY_SIZE(pmu_events__arrowlake_cpu_core),
          |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   tools/include/linux/kernel.h:103:32: note: expanded from macro 'ARRAY_SIZE'
     103 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                ^~~~~
>> tools/perf/pmu-events/pmu-events.c:75461:15: error: invalid application of 'sizeof' to an incomplete type 'const struct pmu_table_entry[]'
    75461 |                 .num_pmus = ARRAY_SIZE(pmu_events__arrowlake)
          |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   tools/include/linux/kernel.h:103:32: note: expanded from macro 'ARRAY_SIZE'
     103 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                ^~~~~
   8 errors generated.
   make[6]: *** [pmu-events/Build:53: tools/perf/pmu-events/pmu-events.o] Error 1
   make[5]: *** [Makefile.perf:765: tools/perf/pmu-events/pmu-events-in.o] Error 2
   make[4]: *** [Makefile.perf:292: sub-make] Error 2
   make[3]: *** [Makefile:76: all] Error 2

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
