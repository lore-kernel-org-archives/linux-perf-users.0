Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8DD1547CC;
	Thu, 17 Jul 2025 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745633; cv=none; b=gkzKwVw9L3EMtPq7Hy+lQyg0FFdBtStGrOI1Wdn07FTyO0U0EP+DOpwmjkB9W1i1mzoMgpPAJxBetIpZpDKY3iKU94OXJrE7gHPeyB6iIqKxqi56XWzNfgeamd7juDRTnAtQWmqTKZfNRNrFpfsrARl3BwEbctd6eF4OJnwzq9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745633; c=relaxed/simple;
	bh=mBtBclCHGGf6QUs4GBjgavXvjySSzPF23qcnrqOWjMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FasvCulHJbkAs+vhdJmQwvB6VGMt7UFdxwjgBP5uqDgghFZ7G3992Yb5URCvrLOXKTwncJjtPF8+pd9KMF/dHBqH17RXZn+cNMI1JDKSnGWLuUdToMaRUKUg8T3EfD/wM09TTluHtmy4DLQFkgtged06nw1eKOoOS/Is4TWOf24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AzrE26Sz; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AzrE26Sz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752745631; x=1784281631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mBtBclCHGGf6QUs4GBjgavXvjySSzPF23qcnrqOWjMw=;
  b=AzrE26SzdOp5HfNV3tFt1G/KUZ1iBHIOF96j3V/V+pFndSna6Qhs+Q6k
   QIxEdil8VkiyqPtsV1aRQCeqENiiTBvDwtpfZ1T9wUhRmUQPUHCjp98QF
   sKdDanPmDOPRiaP2FEdRU7pxhVe9q7+Bo31F3ZcJOq4M2M19x4Arx/o1E
   LhXzbOWUHkPV3/gMacIUfe1z6gKN1xuaG9wBpEcG2utEuNYD0S/N1EmzL
   b/vvT6GJxJWCo6aVI7bFrcZHPG8WN9pIrGaToDC3UGk5lAmsyMqiuiZwU
   6qtLEGyCoMxq5hwpMLANB2PWybz6ii1cOutROYHVQyMA1JQYxcrrFmb1e
   w==;
X-CSE-ConnectionGUID: A2DMtR+bQ1qfTv63ak0iSw==
X-CSE-MsgGUID: bQM4maZNQAiLSssW1Y3k9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="80461622"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="80461622"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 02:47:10 -0700
X-CSE-ConnectionGUID: PUY9YsYZSJGoA77VTcqigw==
X-CSE-MsgGUID: +ieSrN+TRDaPLfqdc38VfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="158458484"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 17 Jul 2025 02:47:08 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucLCk-000DUZ-0Y;
	Thu, 17 Jul 2025 09:47:06 +0000
Date: Thu, 17 Jul 2025 17:46:11 +0800
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
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 1/3] tools subcmd: Tighten the filename size in
 check_if_command_finished
Message-ID: <202507171729.UkGLqJBw-lkp@intel.com>
References: <20250716201512.792052-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716201512.792052-1-irogers@google.com>

Hi Ian,

kernel test robot noticed the following build errors:

[auto build test ERROR on perf-tools-next/perf-tools-next]
[also build test ERROR on tip/perf/core perf-tools/perf-tools linus/master v6.16-rc6 next-20250716]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/perf-pmu-Switch-FILENAME_MAX-to-NAME_MAX/20250717-042514
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20250716201512.792052-1-irogers%40google.com
patch subject: [PATCH v1 1/3] tools subcmd: Tighten the filename size in check_if_command_finished
config: arm-randconfig-001-20250717 (https://download.01.org/0day-ci/archive/20250717/202507171729.UkGLqJBw-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 16534d19bf50bde879a83f0ae62875e2c5120e64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250717/202507171729.UkGLqJBw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507171729.UkGLqJBw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> run-command.c:233:20: error: operator '?:' has lower precedence than '+'; '+' will be evaluated first [-Werror,-Wparentheses]
     233 |         char filename[6 + MAX_STRLEN_TYPE(typeof(cmd->pid)) + 7 + 1];
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   run-command.c:228:76: note: expanded from macro 'MAX_STRLEN_TYPE'
     228 | #define MAX_STRLEN_TYPE(type) (sizeof(type) * 8 / 3 + is_signed_type(type) ? 1 : 0)
         |                                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
   run-command.c:233:20: note: place parentheses around the '+' expression to silence this warning
     233 |         char filename[6 + MAX_STRLEN_TYPE(typeof(cmd->pid)) + 7 + 1];
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   run-command.c:228:76: note: expanded from macro 'MAX_STRLEN_TYPE'
     228 | #define MAX_STRLEN_TYPE(type) (sizeof(type) * 8 / 3 + is_signed_type(type) ? 1 : 0)
         |                                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
   run-command.c:233:20: note: place parentheses around the '?:' expression to evaluate it first
     233 |         char filename[6 + MAX_STRLEN_TYPE(typeof(cmd->pid)) + 7 + 1];
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   run-command.c:228:76: note: expanded from macro 'MAX_STRLEN_TYPE'
     228 | #define MAX_STRLEN_TYPE(type) (sizeof(type) * 8 / 3 + is_signed_type(type) ? 1 : 0)
         |                                                       ~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   1 error generated.
   make[6]: *** [tools/build/Makefile.build:85: tools/bpf/resolve_btfids/libsubcmd/run-command.o] Error 1 shuffle=467312727
   make[6]: Target '__build' not remade because of errors.
   make[5]: *** [Makefile:78: tools/bpf/resolve_btfids/libsubcmd/libsubcmd-in.o] Error 2 shuffle=467312727
   make[5]: Target 'tools/bpf/resolve_btfids/libsubcmd/libsubcmd.a' not remade because of errors.
   make[4]: *** [Makefile:56: tools/bpf/resolve_btfids//libsubcmd/libsubcmd.a] Error 2 shuffle=467312727
   make[4]: Target 'all' not remade because of errors.
   make[3]: *** [Makefile:76: bpf/resolve_btfids] Error 2 shuffle=467312727
   make[2]: *** [Makefile:1443: tools/bpf/resolve_btfids] Error 2 shuffle=467312727
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=467312727
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=467312727
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
