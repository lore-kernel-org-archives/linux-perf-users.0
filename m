Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A33E3DB8;
	Fri,  9 Oct 2026 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791527424; cv=none; b=A4qEX6dwq5hpAa/DfCsAGky96bX3PYdJzqsra0U0dbOrmt+J5Os/qP1eKmWsITsBi3/QFvfjgzvRdAUWISDuJLznPKuDLGYO5K3KBrIxQW2+l0g0BkviuxkS0U48+UI5dWR8jvIVNgqOsivT4vKhH+LcBDYKLQ5gn/kP6nZ76xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791527424; c=relaxed/simple;
	bh=cgoc2FrSAYbnr4rnvAc23RyQ/dBvtmdyziMouGr86ls=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aMUTTJEDVkmxALpLXcKduvepVZ0NLOdyy9Cf9irTfT6Q0wMbIPYsWZRcJIVNazaQyJGwbX+7UBLezifnXlfk4aygOjBYEcyb26OphfpL9srO9QfoeItMvwy0uJTZaq0GmdQDmOBoUb55jgfFOJyNKu3N7Yk5Uew4p0KWmUM99Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O9ZXj4Z0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O9ZXj4Z0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791527423; x=1823063423;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cgoc2FrSAYbnr4rnvAc23RyQ/dBvtmdyziMouGr86ls=;
  b=O9ZXj4Z0MdQSDbj5fn4AJXhSNUcHHlMr4rktFNr4C2uYAi3qfMjkZFcY
   2LwJrKYHg6c2OQp+00fwBRGQJCyAcXmu/cJxPCnKw5qGlaJYiMsSCgKvV
   GK0nBF5KippxT7v+9+gBNIxlR5lrZudUNdn8cRS6x4wSpeyAeQJTUGtZs
   phpVX+kK0SFR/5DTMRlLVep8/lCwWHegg0CVF6bOrOWv8zGU2CjgKB30P
   yJjw2LpzqKWavR7m0dclJhJikZH2V/SLMMAIRqHb3yk1g+9pgiB2KfyBf
   HTgzenjanzex7lJRK90TQxlzmtzDY3BGX7RBhWqORUrI2u3bAQEbftMUN
   w==;
X-CSE-ConnectionGUID: CLalu2x7TcmSo6wkoXTztw==
X-CSE-MsgGUID: /GNSV1l2SSOLy06JsKjHRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="430274"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="430274"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 23:30:22 -0700
X-CSE-ConnectionGUID: SG090tPKRZyURlelV9+U1Q==
X-CSE-MsgGUID: EgAVcAF2SvCNlVXSHHQmnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="604612"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 23:30:21 -0700
Date: Fri, 9 Oct 2026 14:30:17 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Ian Rogers <irogers@google.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi1.lai@intel.com
Subject: [perf-tools-next:tmp.perf-tools-next] [perf vendor events intel]
 31efbec216: perf-stat-tests.UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU.fail
Message-ID: <202610091437.bf2c2d3c-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hello,

kernel test robot noticed "perf-stat-tests.UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU.fail" on:

commit: 31efbec2161d2d31b020b086958e41f35f070a38 ("perf vendor events intel: Update sapphirerapids events from 1.39 to 1.40") https://git.kernel.org/cgit/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next

[test failed on linux-next/master eea3fef32a9cf36abcb5975a5a594e4135a6b026]

in testcase: perf-stat-tests
config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)

If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202610091437.bf2c2d3c-lkp@intel.com

EventName: UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU
2026-10-05 17:15:24 perf stat -e UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU -a sleep 0.1
event syntax error: 'UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU'
                     \___ Bad event name

Unable to find event on a PMU of 'UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU'

event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
                                  \___ value too big for format (umask), maximum is 255

event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
                                  \___ value too big for format (umask), maximum is 255

event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
                                  \___ value too big for format (umask), maximum is 255

event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
                                  \___ value too big for format (umask), maximum is 255

event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
                                  \___ value too big for format (umask), maximum is 255

event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
                                  \___ value too big for format (umask), maximum is 255

event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
                                  \___ value too big for format (umask), maximum is 255

event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
                                  \___ value too big for format (umask), maximum is 255

event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
                                  \___ value too big for format (umask), maximum is 255

event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
                                  \___ value too big for format (umask), maximum is 255
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20261009/202610091437.bf2c2d3c-lkp@intel.com


--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


