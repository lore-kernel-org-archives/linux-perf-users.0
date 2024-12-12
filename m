Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FA52594B0;
	Thu, 12 Dec 2024 00:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733963578; cv=none; b=YWU2vg92Wddhaoj8C0NDMdBiJaH5fQA7M9GYD/LBAzNpiOqFoZvFQNra8RLQvj358EVKjlFHCiiFBxkYKcaQB6/QfrdWVC68UhWxkzSxKHT74spvVhbMRwSTzX5tWu2c+Szs2o3yby+8GO+jcBSl6NUjkYt2qzIqD6lZTDBDg4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733963578; c=relaxed/simple;
	bh=oFnD+B4fatlxUC4p8hm2UR/dha2WUanb1LpnKuu6VP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+l0zPA5EcWqAQDmbUFRCb+lu/TPZHA6tPzB+K1kqs37FVUykOWEtjv3OhY/EBsd6q+15Ajp4/fSYWV+0qwqJ8joUpYm3XJeuMztf6ptVJ+e/ZEKFvSMei/2V4m6ArWG28Q3GOmysLM2Mu0VQ90Z49ircClJMXDKBxrfbK9YW2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h8ZHU/39; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h8ZHU/39"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733963575; x=1765499575;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oFnD+B4fatlxUC4p8hm2UR/dha2WUanb1LpnKuu6VP8=;
  b=h8ZHU/39GZSHLzisX1M4Rb9AUjY8yRP4OJVM3FD0hIYKPPqq6Oy/uAJI
   WqtKhQuCm30wtaETaKJq9XqfK+k7cdUg5iKSPVXJmN7+NyhbtW1nvMSRX
   l1KChP7ogjHQmPu0PgxZk4g0/N96bvnaz6HjkPZAGHNw55/3N1X57giOr
   PRPy/Vca4Gx1Qv3hASY88xD7t1SCrJLY0zFF8XqEcTo6NtEpgfyJw+9wk
   TI+3VMkWw8edZD76A1RK27Si87HQuzvWCK7fZm3Qxg5rZym8ytH6zRKAn
   BP79f1XH0PnBIG6RsNinc+qromO7KfgaWuhQCO2MNByGmVT+cVXjMbj9c
   A==;
X-CSE-ConnectionGUID: Dm84ZkqMQ0eC4sICoWLqFA==
X-CSE-MsgGUID: mWERcLsdTtOvtlJfXGnrgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34494445"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="34494445"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 16:32:54 -0800
X-CSE-ConnectionGUID: 74YtXwi4QBic5pDnOW4fdg==
X-CSE-MsgGUID: 1e2w68/DQ3KA7i+fT0nWng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="101046587"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 11 Dec 2024 16:32:49 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLX8I-0007G1-2c;
	Thu, 12 Dec 2024 00:32:46 +0000
Date: Thu, 12 Dec 2024 08:32:22 +0800
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
Message-ID: <202412120855.QLOxIAzg-lkp@intel.com>
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
[also build test ERROR on tip/perf/core perf-tools/perf-tools linus/master v6.13-rc2 next-20241211]
[cannot apply to acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/perf-vendor-events-Update-Alderlake-events-metrics/20241210-064605
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20241209222800.296000-4-irogers%40google.com
patch subject: [PATCH v1 03/22] perf vendor events: Add Arrowlake events/metrics
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241212/202412120855.QLOxIAzg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412120855.QLOxIAzg-lkp@intel.com/

All errors (new ones prefixed by >>):

     PERF_VERSION = 6.12.rc6.g947fa0393dbc
>> tools/perf/pmu-events/pmu-events.c:27919:152: error: 'SUB' undeclared here (not in a function)
   27919 | { 388816 }, /* fp_arith_dispatched.v0\000floating point\000Number of FP-arith-uops dispatched on 1st VEC port (port 0). FP-arith-uops are of type ADD*/SUB*/MUL/FMA*/DPP\000event=0xb3,period=2000003,umask=1\000\00000\000\000 */
         |                                                                                                                                                        ^~~
>> tools/perf/pmu-events/pmu-events.c:27919:156: error: expected expression before '/' token
   27919 | { 388816 }, /* fp_arith_dispatched.v0\000floating point\000Number of FP-arith-uops dispatched on 1st VEC port (port 0). FP-arith-uops are of type ADD*/SUB*/MUL/FMA*/DPP\000event=0xb3,period=2000003,umask=1\000\00000\000\000 */
         |                                                                                                                                                            ^
>> tools/perf/pmu-events/pmu-events.c:27919:169: error: stray '\' in program
   27919 | { 388816 }, /* fp_arith_dispatched.v0\000floating point\000Number of FP-arith-uops dispatched on 1st VEC port (port 0). FP-arith-uops are of type ADD*/SUB*/MUL/FMA*/DPP\000event=0xb3,period=2000003,umask=1\000\00000\000\000 */
         |                                                                                                                                                                         ^
>> tools/perf/pmu-events/pmu-events.c:27919:170: error: exponent has no digits
   27919 | { 388816 }, /* fp_arith_dispatched.v0\000floating point\000Number of FP-arith-uops dispatched on 1st VEC port (port 0). FP-arith-uops are of type ADD*/SUB*/MUL/FMA*/DPP\000event=0xb3,period=2000003,umask=1\000\00000\000\000 */
         |                                                                                                                                                                          ^~~~~~~~
   tools/perf/pmu-events/pmu-events.c:27919:206: error: stray '\' in program
   27919 | { 388816 }, /* fp_arith_dispatched.v0\000floating point\000Number of FP-arith-uops dispatched on 1st VEC port (port 0). FP-arith-uops are of type ADD*/SUB*/MUL/FMA*/DPP\000event=0xb3,period=2000003,umask=1\000\00000\000\000 */
         |                                                                                                                                                                                                              ^
   tools/perf/pmu-events/pmu-events.c:27919:210: error: stray '\' in program
   27919 | { 388816 }, /* fp_arith_dispatched.v0\000floating point\000Number of FP-arith-uops dispatched on 1st VEC port (port 0). FP-arith-uops are of type ADD*/SUB*/MUL/FMA*/DPP\000event=0xb3,period=2000003,umask=1\000\00000\000\000 */
         |                                                                                                                                                                                                                  ^
   tools/perf/pmu-events/pmu-events.c:27919:216: error: stray '\' in program
   27919 | { 388816 }, /* fp_arith_dispatched.v0\000floating point\000Number of FP-arith-uops dispatched on 1st VEC port (port 0). FP-arith-uops are of type ADD*/SUB*/MUL/FMA*/DPP\000event=0xb3,period=2000003,umask=1\000\00000\000\000 */
         |                                                                                                                                                                                                                        ^
   tools/perf/pmu-events/pmu-events.c:27919:220: error: stray '\' in program
   27919 | { 388816 }, /* fp_arith_dispatched.v0\000floating point\000Number of FP-arith-uops dispatched on 1st VEC port (port 0). FP-arith-uops are of type ADD*/SUB*/MUL/FMA*/DPP\000event=0xb3,period=2000003,umask=1\000\00000\000\000 */
         |                                                                                                                                                                                                                            ^
   make[6]: *** [pmu-events/Build:53: tools/perf/pmu-events/pmu-events.o] Error 1
   make[5]: *** [Makefile.perf:765: tools/perf/pmu-events/pmu-events-in.o] Error 2
   make[4]: *** [Makefile.perf:292: sub-make] Error 2
   make[3]: *** [Makefile:76: all] Error 2

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
