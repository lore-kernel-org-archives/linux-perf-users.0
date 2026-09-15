Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3C1468C29;
	Tue, 15 Sep 2026 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458310; cv=none; b=luUNoX+JGvlMqrsX19MXc4uDB4xyo87cmN8W28YV0wTW8ucSl2CqKCvgAaDqkRpPG7FL8Ca5rXDEOCf1nyIHqlNF0gHwXF81DAcs4wKvFMoZ09hQSoZFZYIzrdvemrFhPSDycmR/EV3j8YN7Ho51xjDyy6HspgXzsuXRPuuwVco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458310; c=relaxed/simple;
	bh=cDqgPOBDkp+pNenRD+cQrf3EVGMAts+ORoSOBC79oLc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KCmSGGHSwFg1RSQnWOvrtBHprhWgIoaDAWWnd6x8JL2QqV/AJREj701AlyYUDA3YNH9SjtZ9FalC271TORwWJmL3AAFpQHjVHHNdEg4fR9U9AgvYrS28+TPa3EkN6RNCZ1dwZc2vTEpulN+f2Lif6OIBZkejIUpivS8s1Oig5Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nzqZOSb4; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nzqZOSb4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789458308; x=1820994308;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cDqgPOBDkp+pNenRD+cQrf3EVGMAts+ORoSOBC79oLc=;
  b=nzqZOSb4FwyGCfp0Uy+eaOxjXuJYpA11G+c83mEPVbuKHbzmgwgTg7Z/
   kfQBDYcHviiXefhig0Ihpbh6V+UrAWp1PESF04W2twlN3uVQRzwo4Hk4T
   5TcgY1Jc3TYyGKDvBGOieq7vFxIf2HeqAVvufw3HKOxiqKWwfkC9IGmwq
   KOgaqUR7Jhj3Pn6dIIc+1LpA+MMJQopeoqAyPFV5goFTv8S4XuMrpBpuR
   8IRtFrAdaJ/w5OEPfph7FGPZe/vhrWcVyogp3Uul1+LqJdDK0ZZDvdLXn
   rsONLyJS45fSPKqTmHXY00DuSXzpulB87Ut1kQeU2aUNAqBmsudERyC5K
   w==;
X-CSE-ConnectionGUID: c5Bve2mjR8izp5WCReC9uA==
X-CSE-MsgGUID: G/hU3qe9QFqWXaJhbHV0dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77375983"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77375983"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 00:45:07 -0700
X-CSE-ConnectionGUID: ERFjJc+IRaaJusSfpHcfMg==
X-CSE-MsgGUID: u6OLJtLaQsa5WgMoOlAKgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="278163833"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 00:45:04 -0700
Date: Tue, 15 Sep 2026 15:45:00 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org, yi1.lai@intel.com
Subject: [linus:master] [perf/core]  166f10836a:
 perf-sanity-tests.Object_code_reading.fail
Message-ID: <202609151503.cb02f753-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Hello,

kernel test robot noticed "perf-sanity-tests.Object_code_reading.fail" on:

commit: 166f10836a653dfa280d4335603b52f685b8b1ef ("perf/core: Fix kernel register info leak via hardware skid") https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master 68142f986ff04b2b70b31db00f719bf690f64a9a]

in testcase: perf-sanity-tests
with following parameters:

	perf_compiler: gcc
	group: group-00

config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 20 threads 1 sockets (Commet Lake) with 16G memory

If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202609151503.cb02f753-lkp@intel.com


2026-09-14 10:03:47 sudo ASAN_OPTIONS=fast_unwind_on_malloc=0 /usr/src/linux-perf-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf test 23 -v
 23: Object code reading                                 : Running (1 active)
---- start ----
...
Reading object code for memory address: 0x7f6d46bf44de File is: /usr/lib/x86_64-linux-gnu/libc.so.6
Already tested /usr/lib/x86_64-linux-gnu/libc.so.6 @ 0xff4de - skipping Reading object code for memory address: 0x7f6d46bf44de File is: /usr/lib/x86_64-linux-gnu/libc.so.6
Already tested /usr/lib/x86_64-linux-gnu/libc.so.6 @ 0xff4de - skipping Reading object code for memory address: 0 thread__find_map failed
---- end(-1) ----
 23: Object code reading                                 : FAILED!


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260915/202609151503.cb02f753-lkp@intel.com

This defect was originally reported on the perf/core branch (see https://lore.kernel.org/oe-lkp/202607091054.7c96d6c6-lkp@intel.com/). Since the culprit patch has now been merged into the mainline kernel, we have re-submitted the report to ensure proper tracking.

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


