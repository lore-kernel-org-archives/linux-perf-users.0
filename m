Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9321C27;
	Tue, 22 Oct 2024 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729593880; cv=none; b=YTXYr3aNLVP4oEubawKIvc9krWJMJq5gexEmBUVJAmTRGCYg3xu2wx/3+q0shM1Xmyw2UffpEsHDnZEdAnz3Z8iHGAcWYpc/ygF0KxrXYCn6Mu10nL/Ql3T0hMI8xDl/jALc5z4tvb4hMedzXUukEwCgSlORSYnJkKuvgzJeGoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729593880; c=relaxed/simple;
	bh=7WFHbjVbOs4TaN/UayhQJmgOYBICu3Yx7s+0zDaefr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCpITgaIHT/l0ArH6mNavJnuP5cgxa0qgTEN9UP0v/ttRwwnMhL/Q+o34/XCWkvrz2lL1RI4RKbcNH9Ivlmfs9TWOZv07GkMZN+gFt6lXl5ET810T65eVicNmjP9LtWjEM4rV4BlEUb1Zk1vztny50WtYsw3pynwusNcuXaFdEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UGTF3Quu; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UGTF3Quu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729593878; x=1761129878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7WFHbjVbOs4TaN/UayhQJmgOYBICu3Yx7s+0zDaefr0=;
  b=UGTF3QuuNDFTDdmU+rd2nkHEBeDMx9QWtKpyg6UymECEFHtN7DMUi/Lr
   3Hym2nQJByXwbovNYgedc7PQecyurz7fNqvUvYuYoq7ugyMz363UHIjkU
   5dIy4DwL8jkDIKLt/gN1HUU5CI7Gi3p5SQ79VmDN9wkvgMq1B23D+mqm0
   w2aY/tWwQzRDlY4TkxcOd6ajAjRNIXHnnHc1uejWVGTCUM4R78ploCCkF
   nLOpE0WSkIjRUDl3L2HA8t9K78MZGewDeyo7NjiTi4FLxOA748mczEhPR
   0tOfabld8CvYMzb75fanDUiSyzPd4p8pDZIMCSLhJySjiqgcejk/I3LIV
   w==;
X-CSE-ConnectionGUID: m5xnthq5TXO30p1OJEVtGg==
X-CSE-MsgGUID: 4DqCcIRKS+6U8w8wkFNicw==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="16748428"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="16748428"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 03:44:37 -0700
X-CSE-ConnectionGUID: AbPWs/vwRgCb54lmhKZG5w==
X-CSE-MsgGUID: V+F5pyG3SkatEu5N+woe0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="110651258"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 22 Oct 2024 03:44:32 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3CNJ-000TRs-1i;
	Tue, 22 Oct 2024 10:44:29 +0000
Date: Tue, 22 Oct 2024 18:43:51 +0800
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
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	James Clark <james.clark@linaro.org>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>,
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 2/5] perf hwmon_pmu: Add a tool PMU exposing events
 from hwmon in sysfs
Message-ID: <202410221809.rM67Lxz0-lkp@intel.com>
References: <20241017063555.366065-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017063555.366065-3-irogers@google.com>

Hi Ian,

kernel test robot noticed the following build errors:

[auto build test ERROR on perf-tools-next/perf-tools-next]
[also build test ERROR on next-20241022]
[cannot apply to tip/perf/core perf-tools/perf-tools linus/master acme/perf/core v6.12-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/tools-api-io-Ensure-line_len_out-is-always-initialized/20241017-143759
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20241017063555.366065-3-irogers%40google.com
patch subject: [PATCH v5 2/5] perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241022/202410221809.rM67Lxz0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410221809.rM67Lxz0-lkp@intel.com/

All errors (new ones prefixed by >>):

   Makefile.config:665: No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR
     PERF_VERSION = 6.12.rc3.gd8463b89755f
>> util/hwmon_pmu.c:175:2: error: call to undeclared library function 'strlcpy' with type 'unsigned long (char *, const char *, unsigned long)'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     175 |         strlcpy(fn_type, filename, sizeof(fn_type));
         |         ^
   util/hwmon_pmu.c:175:2: note: include the header <string.h> or explicitly provide a declaration for 'strlcpy'
   1 error generated.
   make[7]: *** [tools/build/Makefile.build:106: tools/perf/util/hwmon_pmu.o] Error 1
   make[7]: *** Waiting for unfinished jobs....
   make[6]: *** [tools/build/Makefile.build:158: util] Error 2
   make[5]: *** [Makefile.perf:789: tools/perf/perf-util-in.o] Error 2
   make[5]: *** Waiting for unfinished jobs....
   make[4]: *** [Makefile.perf:292: sub-make] Error 2
   make[3]: *** [Makefile:76: all] Error 2

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
