Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB33F20F9;
	Fri,  9 Oct 2026 06:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526171; cv=none; b=XsQM3bkgKpZJ/m5Ah9Tlp9F1kCyt9I6WTHkURa4/mC9F6eLlbbf8S4PaVr/lYe/Bxm33Tk5bkofpoNHpNjnGIowxxlFOhZhcau4XhmArz95cBss8vOqzg9QZ9GTzEqMPsxLJS3+uZcatujAZKeOOtFW0HdXXUOJz86wZpXSx0R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526171; c=relaxed/simple;
	bh=haHcrETyXq1EIFWp9NkhjpYbZBWmtl3Pqcn1miobr34=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fjTd5IKy+TwnV5sTbfKFaUOBQCGZ9NKqqmoDmhZIuSixhwAeZmckAW3sT9r/KOx2R+QF34G6pTxv5QZ/3hmjXSBMDz/knbmEKisLJ2lOmLLEfozDLlc2kXURewL5QgpDbawtjoBDl6OKp3OKtZ+cHEpv3Fu7xUIoejaljV0MR4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4SFcGzn; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4SFcGzn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791526171; x=1823062171;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=haHcrETyXq1EIFWp9NkhjpYbZBWmtl3Pqcn1miobr34=;
  b=g4SFcGznuGbG7aUa/GQQBxPGLtOhfQuQvlMwoQ2MPv1m9K+uUupGHRAt
   clAZ1MpD7X2RUzKT3Bwe9yGGoTgOPJznLfUKoY6YHSw2vaWUN6PLkL5SR
   lm+nQMHhvBjFkY/1SDQkgklFej8R9agNknupJ159baEhXRsKLgm+FRYY+
   jrfMhqj9fDkJKYkEQY8+BllxP/x+HlY3ifu5Tdhze7V7Opvmw5sZlCffH
   pnqoaWyRu4cpOGf8WHt1YaXmAxuJd420T6jP0vsz8K3TOhg24QE7mvg9x
   d6uVhbQcFKy3AH4wNNQGHgdcbs9a10G/eT6Ttr86QxJc336OSNLEB+f0q
   g==;
X-CSE-ConnectionGUID: DDDtW7/xR/6pB/g2alPgzQ==
X-CSE-MsgGUID: oBJrp7NpRhOJSIVYIoWBBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="321249"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="321249"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 23:09:30 -0700
X-CSE-ConnectionGUID: BhgHLy27Q9yrw7V7vJhx5g==
X-CSE-MsgGUID: AefPeosAQFac5XyzwdfvYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="340243"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 23:09:28 -0700
Date: Fri, 9 Oct 2026 14:09:24 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Ian Rogers <irogers@google.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi1.lai@intel.com
Subject: [perf-tools-next:tmp.perf-tools-next] [perf vendor events intel]
 3c989481ee: perf-sanity-tests.x86_topdown.topdown_events.fail
Message-ID: <202610091243.76a68f01-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Hello,

kernel test robot noticed "perf-sanity-tests.x86_topdown.topdown_events.fail" on:

commit: 3c989481ee3cc22ac5d34e73862a4016af770710 ("perf vendor events intel: Update emeraldrapids events from 1.24 to 1.25") https://git.kernel.org/cgit/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next

[test failed on linux-next/master f0406245cb9855e6318335a8a223551354291a46]

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: gcc
	group: group-02


config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 256 threads 4 sockets INTEL(R) XEON(R) PLATINUM 8592+ (Emerald Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202610091243.76a68f01-lkp@intel.com

2026-10-04 03:23:58 sudo ASAN_OPTIONS=fast_unwind_on_malloc=0 /usr/src/linux-perf-x86_64-rhel-9.4-bpf-3c989481ee3cc22ac5d34e73862a4016af770710/tools/perf/perf test 77 -v
 77: x86 topdown                                                                                               :
 77.1: topdown events                                                                                          : Running (4 active)
---- start ----
...
event syntax error: 'cpu/mem_trans_retired.load_latency/'
                     \___ Bad event or PMU ...
event syntax error: '..atency/'
                                  \___ expected numeric value ...
event syntax error: '..atency/'
                                  \___ expected numeric value ...
WARNING: events were regrouped to match PMUs evlist after sorting/fixing: '{slots,cpu/topdown-bad-spec/}'
---- end(-1) ----
 77.1: topdown events                                                                                          : FAILED!
 77.2: topdown sorting                                                                                         : Ok
 77.3: topdown slots injection                                                                                 : Ok
 77.4: topdown metrics_clear no extra slots                                                                    : Ok


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20261009/202610091243.76a68f01-lkp@intel.com



--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

