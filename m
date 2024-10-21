Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8FD4C8E;
	Mon, 21 Oct 2024 00:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729471534; cv=none; b=nLLskZpimnhUJuoz3nZ5qD35P7aZs6gD9kyQ2PL7m9AVoMBva6BUAVvdQyJIE23BU1+thpX1EcKCkoXFaK6Xsw/yCElB65stucFjivL+bv8rLjggck9tSmaLnS+YZBPcB6O3tl4dOtILoD+tpjRQWpcb8nhd6UDZHadcOYZDZV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729471534; c=relaxed/simple;
	bh=zX3N1d60n3AIuJZwfC7pPNYT00ZeDOB7cX1e1JHUt6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgkO3YGhkC2Oed0HfVq1ujgnyEOuIqwKoBTu8Gh7RJu+2S+CVav/hjOp0LtCNNSea3MrCNw0TJZpjt830nPL403YE/YDEccvJLN/0vpf3vivqIJREzNT8rLNq8esXPFlh9RzvxXLYin1AGDSxNyFZkuN0g+Ads30ER+5CX91G8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6v3fe6T; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6v3fe6T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729471532; x=1761007532;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zX3N1d60n3AIuJZwfC7pPNYT00ZeDOB7cX1e1JHUt6c=;
  b=g6v3fe6T5ytKtNpZrPxTR9VuO20K7lzlG/0GEhgD6WuAZRNV4NIfQcIF
   gtCH3lX7ajzv7CBwpEX7ZHAaSO4lOprn7tX8GoQzQ0snSKf1gJR/Mhy4O
   nBTuqH4xBrzuyk6b1xE7/E2XsE1DstefgIcv93S8B/GcZkEUaPjBUygcH
   5NRgxHbdwdf2NHc8uXwpZc+wPWzGGqocMi0zfvdeM7sjHejn9Z/bUttGL
   e0wgagLX5m/sqR1YXojqacZguEK6WlUB+8XEzW5w9mgdqGkCJCdIal36C
   KE5o/Ja2PZ3oJsWlKbhKn6/ozFkZ06tV57VquO5FN6WgDfYsE3wNMMtkf
   A==;
X-CSE-ConnectionGUID: Z58wfJN/TqSarIx2ceeh6w==
X-CSE-MsgGUID: e/6kBZv5Qn+kqkhPyIatlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="31804018"
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="31804018"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 17:45:31 -0700
X-CSE-ConnectionGUID: 99B1zdIWT/KwEtlUrlwOMA==
X-CSE-MsgGUID: IcarFqj8Rr+rvNHEUas1wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="83952169"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 20 Oct 2024 17:45:26 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2gY0-000Qww-0O;
	Mon, 21 Oct 2024 00:45:24 +0000
Date: Mon, 21 Oct 2024 08:45:00 +0800
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
Message-ID: <202410210800.pNLlo3bN-lkp@intel.com>
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
[also build test ERROR on next-20241018]
[cannot apply to tip/perf/core perf-tools/perf-tools linus/master acme/perf/core v6.12-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/tools-api-io-Ensure-line_len_out-is-always-initialized/20241017-143759
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20241017063555.366065-3-irogers%40google.com
patch subject: [PATCH v5 2/5] perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241021/202410210800.pNLlo3bN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410210800.pNLlo3bN-lkp@intel.com/

All errors (new ones prefixed by >>):

   Makefile.config:665: No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR
     PERF_VERSION = 6.12.rc3.gd8463b89755f
   util/hwmon_pmu.c: In function 'parse_hwmon_filename':
>> util/hwmon_pmu.c:175:9: error: implicit declaration of function 'strlcpy'; did you mean 'strncpy'? [-Werror=implicit-function-declaration]
     175 |         strlcpy(fn_type, filename, sizeof(fn_type));
         |         ^~~~~~~
         |         strncpy
   cc1: all warnings being treated as errors
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
