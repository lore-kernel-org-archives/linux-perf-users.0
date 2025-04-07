Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4D721C163;
	Mon,  7 Apr 2025 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744058444; cv=none; b=YquQbU/MB3FusqPg5oIKljXUSDJ7vnxrc6uUrtvujcpoWCTuuOwpBky55BEvrezMSKAs7jwdqI4EWSxGxPM1XG/zIx2eJdYElJqPOMZAFyW18Gypzy5WM/WGNmrc2A/qgwiHb2EPdE2tB71jik1//NUtIBNYuwW53O3xKQ/6YOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744058444; c=relaxed/simple;
	bh=R/iykXm3KGSwjKZxScFlKn0pKd41QSyd1jKVT7l1uVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGBqLCxUbja3pdfzW5HJvjbDuBqGZ9mllGqggz9MomZ3IRC8naEfI/70Wc39WJ7YTeAEZqO/yNjccSpXKdTi9SJaMkWzFhUlpArp8cFpOyHc80PrbWVSTnBsQs1KOwNKv6KuXfoI28lqrqe6ZLe8ND5c1TIOl/+Q5udqXdjBto4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PEHMXwVb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PEHMXwVb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744058440; x=1775594440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R/iykXm3KGSwjKZxScFlKn0pKd41QSyd1jKVT7l1uVc=;
  b=PEHMXwVbPVT2GCFFjYeW01abyS9wmsHAw5WEarykR0fKXIHrMs5YDIdc
   zLXa6XXrE+sq9l04FZaU6frGFaG9x/evw2yoDAq8QXIQh2KhS5meHDcU7
   9w79b/yjQ3X8em3MAsAim/MPXcB1EKAbJPZb4BQJ+DSWaj+roYhum9iZI
   8CYN3mQOZWmOyM56D8iETgx4AUK/uwZGZxLxegV1fBudojr7snPA6CS0M
   sRtu2jR4X3HCL+fXRaG/7eZ690qikFx9QW57EgjVnwIypvd7Oba94pSU5
   5M+OehoIsXZEXzhA1COirbU91cJowWG+mTJknOQi5VngH4jSUUz8qg8xp
   g==;
X-CSE-ConnectionGUID: 8BGuo6asSNe6u/XEuom6OA==
X-CSE-MsgGUID: VJnFsI+nTM6Z7AfhuGfRfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="44716111"
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="44716111"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 13:40:39 -0700
X-CSE-ConnectionGUID: j/QaJQJ9SN+MJ1y7ziQY7A==
X-CSE-MsgGUID: gaaAwajISzSKU7kGInRnZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="127929980"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 07 Apr 2025 13:40:34 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u1tGh-0003ov-29;
	Mon, 07 Apr 2025 20:40:31 +0000
Date: Tue, 8 Apr 2025 04:39:49 +0800
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
	Weilin Wang <weilin.wang@intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	John Garry <john.g.garry@oracle.com>,
	Howard Chu <howardchu95@gmail.com>, Levi Yun <yeoreum.yun@arm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 13/16] perf intel-tpebs: Use stats for retirement
 latency statistics
Message-ID: <202504080043.E3FPjBvv-lkp@intel.com>
References: <20250407050101.1389825-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407050101.1389825-14-irogers@google.com>

Hi Ian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on perf-tools-next/perf-tools-next]
[also build test WARNING on perf-tools/perf-tools linus/master v6.15-rc1 next-20250407]
[cannot apply to tip/perf/core acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/perf-intel-tpebs-Cleanup-header/20250407-130741
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20250407050101.1389825-14-irogers%40google.com
patch subject: [PATCH v2 13/16] perf intel-tpebs: Use stats for retirement latency statistics
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504080043.E3FPjBvv-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> tools/perf/util/intel-tpebs.c: stat.h is included more than once.

vim +21 tools/perf/util/intel-tpebs.c

  > 21	#include "stat.h"
    22	#include "tool.h"
    23	#include "cpumap.h"
    24	#include "metricgroup.h"
  > 25	#include "stat.h"
  > 26	#include <sys/stat.h>
    27	#include <sys/file.h>
    28	#include <poll.h>
    29	#include <math.h>
    30	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
