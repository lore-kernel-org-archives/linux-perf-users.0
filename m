Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41B023BF91;
	Fri,  5 Sep 2025 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089125; cv=none; b=JeyXDqlBo97L6ENXAYSWMCXA9zMGSJ5K/jncWYR1JCXiADTYsRDQNXs9SWKBGWg4W6f6OfLZnpPRearXnO893yn4dI2KA+1Ocs6stGvCbnjF8kUftPg4aGi71hIlPTdpV9V+JpIdUlY2v9/sFQrO/bBkHHQO7ptXXfPS4A7KTUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089125; c=relaxed/simple;
	bh=ehK6v8309NAGVNpv3YQq74SGs25kaSg5kTmdvmyAT68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPTm0KjelDiHKjYgyRNBflSO9vNaLWSCwSdoKM4dEkJ9YBUV2BgHl0uAbeY1ANfY6U4PVikwqSFuP/+eJfOuT8kcBFwY7D6k9nXmeJYcugZCmZuHRmBsyqTAGjwwIILuZnZgihKTH28i/KF+8VV7FaFzwwCI2Ez6mrWzVsnrmOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tn71JmtI; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tn71JmtI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757089124; x=1788625124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ehK6v8309NAGVNpv3YQq74SGs25kaSg5kTmdvmyAT68=;
  b=Tn71JmtIyc3W8wDLn3Nj6U+QFK3swJiJn8plFj68eQKROVZpLfH5xOLB
   i8HhohNfVn8f/DAspCABzwXTCqIJ7nuuo6kWw1t99KFPt3c6WEGRW9KAs
   jxdEcNqGfncCuikj+SLI1lazxJQ5Kid90OZHzU0K38smG1OchisUfMHNx
   w7pSsOw/HSizuttHH0wN+zASlcSUHvTEfsUAmySYM+JIqzXVoxEpnuyy4
   supKnSOFU4F3RkoiH62oEOvXTIsTB/BKbIAC89rOD6zPkA7BQ7YBDnyt1
   HP6r7ErvmnXTkKGdyAniRcXlLFcvcYPoV5PS5Bl6Uu57bGwthF9yHPNAn
   A==;
X-CSE-ConnectionGUID: 4l/nhHI8TzSfaHaGnsYfBw==
X-CSE-MsgGUID: axvZviLzQZCkqa0T4crqqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="70062402"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="70062402"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 09:18:43 -0700
X-CSE-ConnectionGUID: Z6FviSNcQaiHuPqeR2e2Vg==
X-CSE-MsgGUID: 0E2/mkFAQQu9I0wc4t+Uwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="176537467"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 05 Sep 2025 09:18:36 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuZ8z-0000c3-2A;
	Fri, 05 Sep 2025 16:18:33 +0000
Date: Sat, 6 Sep 2025 00:18:20 +0800
From: kernel test robot <lkp@intel.com>
To: Jinchao Wang <wangjinchao600@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: Re: [PATCH v2 06/18] perf/hw_breakpoint: add arch-independent
 hw_breakpoint_modify_local()
Message-ID: <202509052351.KuHBWdAF-lkp@intel.com>
References: <20250904002126.1514566-7-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904002126.1514566-7-wangjinchao600@gmail.com>

Hi Jinchao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Jinchao-Wang/mm-ksw-add-build-system-support/20250904-082544
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250904002126.1514566-7-wangjinchao600%40gmail.com
patch subject: [PATCH v2 06/18] perf/hw_breakpoint: add arch-independent hw_breakpoint_modify_local()
config: sh-randconfig-001-20250905 (https://download.01.org/0day-ci/archive/20250905/202509052351.KuHBWdAF-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250905/202509052351.KuHBWdAF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509052351.KuHBWdAF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/events/hw_breakpoint.c: In function 'hw_breakpoint_modify_local':
   kernel/events/hw_breakpoint.c:994:16: error: implicit declaration of function 'arch_reinstall_hw_breakpoint'; did you mean 'arch_uninstall_hw_breakpoint'? [-Wimplicit-function-declaration]
     994 |         return arch_reinstall_hw_breakpoint(bp);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                arch_uninstall_hw_breakpoint
   kernel/events/hw_breakpoint.c: At top level:
>> kernel/events/hw_breakpoint.c:999:12: warning: no previous prototype for 'arch_reinstall_hw_breakpoint' [-Wmissing-prototypes]
     999 | __weak int arch_reinstall_hw_breakpoint(struct perf_event *bp)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/arch_reinstall_hw_breakpoint +999 kernel/events/hw_breakpoint.c

   997	
   998	/* weak fallback for arches without support */
 > 999	__weak int arch_reinstall_hw_breakpoint(struct perf_event *bp)
  1000	{
  1001		return -EOPNOTSUPP;
  1002	}
  1003	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
