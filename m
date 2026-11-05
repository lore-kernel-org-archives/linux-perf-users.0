Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793843276;
	b=Fm0FJPl/APucVA/fKG7IibK3ky0KkzqSuq37dRQoVBfDAPWEP/8/9U1JaA5tY5MnZ2VV
	 fyjsAFrFjHD6PvFdS/jpiVrUiJg7nKKoga77Q5orfGzgg2/EK6z9tQbebxC1sTZVHd64I
	 XS7+R+fdkfdDf7dyFsZ8ITQqy+SRnsIREc71uBEsYkTtx8jJkWS+bEUyf4abDDw33+mR2
	 pJJbOAPII6pwCoHxV02tfKEmDkmhW+XBRStjAjWGCKZ95EwZuDlMa3osuR2q7f3HoMLNu
	 rm5kBHUcS9uzFlMZAWrb4/EgpKoUpkCBXU0mLRlAHFQhrMhiK1cxmkUjTHfc92Mjf3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793843276;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=kalKeHz4b1WciVSS541VQ/8h2ygqFGC8Xteygkp/h7I=;
	b=SJytNQthhXevQ1OlnQx5gm7IyFkfYmHCEU2dM8mRo3vHbO5PD7nI47GFEUS/hF56EYOp
	 adyEhCZ4UZwPht+01WfYj+bAzfenWwFc9o2KSX6Egp7C9U88/u+IgbzG0gtFbQlfc2WeO
	 6qAStYBQwxwBzw7wrYTRHy4of+HvoR0Uk7qHqOART+/WFBPcV9R0NJKxtydmA42ACP1e3
	 UQbMD8mDNOnqUQr/Ch2CgnArquQaurYRYZ5yUWqQIoXEwO1KlPaiC31gQtgPddxOCAKST
	 HYUWeSiycqWlpNieQJZFsRE15JCQUPqtTCTHG9AWpF962CEsYpko3AI8eT27VvtycEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KLTksyDu;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D698606A328;
	Thu,  5 Nov 2026 01:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D698606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KLTksyDu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793843274; x=1825379274;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JKcF5uoUnOYX3yU9/edU7461NqAwwX9bktRSNqowsmc=;
  b=KLTksyDu/M24HNGyNenoXJ0YEqLIa/RwRpoYp2XgOsUowWk4IjUA131C
   w1jczqUGNSMCZIZ2s0neDtdNF0lbSPwFzUQRqbWfmttlpI6oxYS3AjpvX
   N4gqoBoL4bWCrVd3jzRWrqj7JUhyikZo8S7XbXVUMCWxt+QN8QNiOe1OL
   Cx+xLUvr8Q/b66yRv0Qul0fr2ZItZYtGw6S0E8voFTYCWMACLin/7H96s
   Irh3UD/393CQxWh5O1ivREW95JrCMVWY7BBSpBSHdqbmkVyFvI9CrBLHy
   XT0a6cchqdOqRgH/lo6cyIrnX4C5pBmnpgp8uwC3yOYoOny3bDXYwiRJ1
   Q==;
X-CSE-ConnectionGUID: AJ4y09eoQA+dh6t6nfxTVg==
X-CSE-MsgGUID: rdlLkHZdSNy8H3XNuLI1lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2611756"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2611756"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 17:47:53 -0800
X-CSE-ConnectionGUID: jiMWaJVrRhyffksXJPhXFw==
X-CSE-MsgGUID: TBrdxYTtTeKlMmYhrjcbDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="8643408"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 17:47:50 -0800
Date: Thu, 5 Nov 2026 09:47:45 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Ian Rogers <irogers@google.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, yi1.lai@intel.com
Subject: [linus:master] [perf vendor events intel]  31efbec216:
 perf-stat-tests.UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU.fail
Message-ID: <202611050912.2cdf1ff5-lkp@intel.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Hello,

kernel test robot noticed "perf-stat-tests.UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU.fail" on:

commit: 31efbec2161d2d31b020b086958e41f35f070a38 ("perf vendor events intel: Update sapphirerapids events from 1.39 to 1.40") https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c]

in testcase: perf-stat-tests
with following parameters:


config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202611050912.2cdf1ff5-lkp@intel.com


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

    -e, --event <event>   event selector. use 'perf list' to list available events


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20261105/202611050912.2cdf1ff5-lkp@intel.com


--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


