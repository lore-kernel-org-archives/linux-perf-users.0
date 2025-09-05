Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D53352082;
	Fri,  5 Sep 2025 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093571; cv=none; b=qaLirq3len+pnC2R+m//mfjdyke6lsHxYHS5944yqsii2yyEKaC56+xtpUKro8iuQFtxD6/KuPd9x/sMhlkRzAelIkjvEvj+dSH4CZcvY3OF2ihs5UpAQ6pqR6hpYmfhJAx/YFxWd4+/nVKxF3FfTe2V54vrcar4Zh+VUtnfUQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093571; c=relaxed/simple;
	bh=PEGsZAepDbJ1MMax+RK70rvBZZ7cEtrPsxDd14XsltE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pziNTW8ht485nGfCiGvCVaQNMMhsWwURYVXfybztRSnYiLuJhNXmk2FMnVmgmqQUscVNhB6hsJHGPsWbFmx8FS7StTPCWe8OYP3VUdS313a6pr84/Z78QWPkVmtVWrBBNPh/2KG/kkG5mAPKmRZHMHGl4ZHDwHYysCwezpr0Nns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LzZjwWuP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LzZjwWuP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757093570; x=1788629570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PEGsZAepDbJ1MMax+RK70rvBZZ7cEtrPsxDd14XsltE=;
  b=LzZjwWuPgxs88LrPASaOb/Yap+DukdyTJYK1o4liSqaNUVJtCyfKozYX
   9hSH0xJOVHjNptHxulLiLLKN/rUCIuxT8dRjZM+gcaRJXSdRiYc4UamsD
   F0D39Lg+A5C9vbBxGUqqCcA0BAGQdfE5/bPzwRbe4nI16FnQ0WmA4kfq9
   L2zIJtyniBJMtQ7YX5BLWrz0uCuLlFhptaf8OfYXs4b5MAdQJgYBW7yWo
   Zpa2OC4rR6iLbOmiRWilUEHDbM0KcIEBnMJbMBvzyAZ1uWWdVMuoUb7Sw
   WltTsjJLmfma3VhuXVBjW3UZEPmJANMK2mpH7BGmxfhRIWrLuk8zsLzdJ
   Q==;
X-CSE-ConnectionGUID: taNh6ro6S3+Ik+yhIXNOqA==
X-CSE-MsgGUID: uWL2R67BTpGzm0flV9GL3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59372219"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59372219"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 10:32:49 -0700
X-CSE-ConnectionGUID: 7ITtwuiVSci+xRNqVxN1Bg==
X-CSE-MsgGUID: uE+JJ4AMSi69pWm/gpDqMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="172327495"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 05 Sep 2025 10:32:42 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuaIi-0000fj-0O;
	Fri, 05 Sep 2025 17:32:40 +0000
Date: Sat, 6 Sep 2025 01:31:47 +0800
From: kernel test robot <lkp@intel.com>
To: Jinchao Wang <wangjinchao600@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <202509060154.f5xlnJ2n-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Jinchao-Wang/mm-ksw-add-build-system-support/20250904-082544
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250904002126.1514566-7-wangjinchao600%40gmail.com
patch subject: [PATCH v2 06/18] perf/hw_breakpoint: add arch-independent hw_breakpoint_modify_local()
config: sh-randconfig-001-20250905 (https://download.01.org/0day-ci/archive/20250906/202509060154.f5xlnJ2n-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250906/202509060154.f5xlnJ2n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509060154.f5xlnJ2n-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/events/hw_breakpoint.c: In function 'hw_breakpoint_modify_local':
>> kernel/events/hw_breakpoint.c:994:16: error: implicit declaration of function 'arch_reinstall_hw_breakpoint'; did you mean 'arch_uninstall_hw_breakpoint'? [-Wimplicit-function-declaration]
     994 |         return arch_reinstall_hw_breakpoint(bp);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                arch_uninstall_hw_breakpoint
   kernel/events/hw_breakpoint.c: At top level:
   kernel/events/hw_breakpoint.c:999:12: warning: no previous prototype for 'arch_reinstall_hw_breakpoint' [-Wmissing-prototypes]
     999 | __weak int arch_reinstall_hw_breakpoint(struct perf_event *bp)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +994 kernel/events/hw_breakpoint.c

   985	
   986	int hw_breakpoint_modify_local(struct perf_event *bp, struct perf_event_attr *attr)
   987	{
   988		int err;
   989	
   990		err = hw_breakpoint_arch_parse(bp, attr, counter_arch_bp(bp));
   991		if (err)
   992			return err;
   993	
 > 994		return arch_reinstall_hw_breakpoint(bp);
   995	}
   996	EXPORT_SYMBOL(hw_breakpoint_modify_local);
   997	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
