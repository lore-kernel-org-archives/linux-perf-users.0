Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB37388E66;
	Wed, 29 Apr 2026 07:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777448122; cv=none; b=RQHwBNxFinImnEgsHu7ngIVsWReIQk+IajpjQ0KU9s0dc211GsDrbu6MbgrB2bHBjiRNwAqQ7X/hFVggqwwlBkMvJxnWYXnylfu897yehEzPVs45EYLfmECIy1SzW586OQ4NUdea4Ox39+SL2PkbqLZadIjZo3/KQg25BLmBaUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777448122; c=relaxed/simple;
	bh=W4gorgHOBFnTTarrUFzsyVhpRuxTmosBpRiQbwTl39o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbexKr/PcKJyJFk2A1VQDrig2huPtL8BIC7aBZRCYInjtrH1cofEBQMsPbPu7wuO0CS+xfmMaU2PVaJkRVnGi4rmjs1a8aatnWSL341mGwVjmLoJbta+oxXlXQsTg+Udu893u6YVGBtRjvfZt3enaRWlGrRFYNnTiPkbhYurfnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MlWVCty8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MlWVCty8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777448121; x=1808984121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W4gorgHOBFnTTarrUFzsyVhpRuxTmosBpRiQbwTl39o=;
  b=MlWVCty8w3rqBXlUwdB7ygp2CNjIpr+Uy/6j3m2a+xP6DIudDp3HBm5l
   dPTpRyQqu3EEUNEFR8rAv5Ph/aeAR+0ljrkMnY/41k89BvFwFggNV2zMh
   yxhJaIgW7PB9SEzWA5v8mFgxiKUfA9TdltnVYFedokCjBV0NigJgiu1VF
   YHn3JfjoTGSvyUaBb8DDNJl4qTIhLiBQ3afO7tQFC0cqFbIyrun+DK0G7
   d5XXckaa/KrBK2mfqPpd4T4OsvHAagITgwxhMwI20/lgE4+25Av8zI0MC
   uNijjzxz9PqNeh3nfAnvpG0/z2FlhTEj6/V4U8zIyQiBwINn48FxrieQL
   g==;
X-CSE-ConnectionGUID: hBwBEcPFRrOFxG6rA4GIug==
X-CSE-MsgGUID: wHiYY4CgQIGzrBjU5ucUAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="89749067"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="89749067"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 00:35:20 -0700
X-CSE-ConnectionGUID: GfP8DhSkQ1y88KjSb/MFsg==
X-CSE-MsgGUID: 8mx1qONiRXK0/5MhnCPH+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="231543616"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 29 Apr 2026 00:35:17 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wHzRy-00000000Ake-0ygz;
	Wed, 29 Apr 2026 07:35:14 +0000
Date: Wed, 29 Apr 2026 15:34:34 +0800
From: kernel test robot <lkp@intel.com>
To: Minwoo Ahn <mwahn402@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Jinkyu Jeong <jinkyu@yonsei.ac.kr>, Minwoo Ahn <mwahn402@gmail.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/core: Fix sampling period inconsistency across CPU
 migration
Message-ID: <202604291520.xGDlzjFN-lkp@intel.com>
References: <20260428115317.22839-1-mwahn402@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428115317.22839-1-mwahn402@gmail.com>

Hi Minwoo,

kernel test robot noticed the following build errors:

[auto build test ERROR on perf-tools-next/perf-tools-next]
[also build test ERROR on tip/perf/core perf-tools/perf-tools linus/master v7.1-rc1 next-20260428]
[cannot apply to acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Minwoo-Ahn/perf-core-Fix-sampling-period-inconsistency-across-CPU-migration/20260429-115721
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20260428115317.22839-1-mwahn402%40gmail.com
patch subject: [PATCH] perf/core: Fix sampling period inconsistency across CPU migration
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20260429/202604291520.xGDlzjFN-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260429/202604291520.xGDlzjFN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604291520.xGDlzjFN-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:95,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/sched.h:64,
                    from kernel/sched/rq-offsets.c:5:
>> include/linux/perf_event.h:1166:9: error: unknown type name 'local64_t'; did you mean 'local_t'?
    1166 |         local64_t                       period_left;
         |         ^~~~~~~~~
         |         local_t
   make[3]: *** [scripts/Makefile.build:184: kernel/sched/rq-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1337: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +1166 include/linux/perf_event.h

  1153	
  1154	#define perf_event_equal_task_ctx(a1, a2)	\
  1155		((a1)->config == (a2)->config &&	\
  1156		 (a1)->sample_period == (a2)->sample_period)
  1157	
  1158	/**
  1159	 * struct perf_task_context - per-task software event context
  1160	 *
  1161	 * Shared across per-CPU perf_event instances of the same task to
  1162	 * preserve period_left across CPU migrations.
  1163	 */
  1164	struct perf_task_context {
  1165		refcount_t			refcount;
> 1166		local64_t			period_left;
  1167	};
  1168	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
