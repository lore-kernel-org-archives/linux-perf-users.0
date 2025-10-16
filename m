Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326DF3043C4;
	Thu, 16 Oct 2025 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760612878; cv=none; b=gMQXgmKX33MW6ceTDmx83IZUCAuZ/WdUowSw1IaFhF1XD9+2SFO4qC1LhXtAjCdOoqLjBZOJP3FhtvZUNS9R02bnM71rwJT5ZPW3KAWp6vRJsGawnAOP96GNJdVys8OWHJtgqgZDTT+z7XJeBG9WagAKtXr81uAu2ZKhl3CaKrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760612878; c=relaxed/simple;
	bh=X9aFNc43N2mIzbQN88dQuc9eSgi7CWull+Rn9afMSbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7XBm9MvwzskXVABkyp/TKf8ewbqvBtQ9VKQjSvAXA8Gw8LRSL8OuBi7g0mzfpzzGwjZ/Io71pcEQbJZiX59pwjrIiEhiObOuIS2f3y25hO8kQLVH3fMqx/CL37tVezbaRGJoAsr7MTkkFu7CBC7dAtfR8dLEapnTCdu1ilvamk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SPrsZ/im; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPrsZ/im"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760612876; x=1792148876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X9aFNc43N2mIzbQN88dQuc9eSgi7CWull+Rn9afMSbY=;
  b=SPrsZ/imOuhtKtKQHeKRR4Xbr3M/pwmOfCyN+ZshfFtOdkbEcvo9M0Cu
   20yERfPoIgUHjLvfnJNGqRYTlNW+foM+1DxUd1vPZ7Eq8kFb84/Q6SnDf
   ben313AlZnOhF7LKq7RFda0ka8Vnbuj5B2soO+WW82M9RPU4ZQQc0oam5
   N7neNB3O/pYsxysjL5+8D6PQ7Om4gX5gwzdhwMT3pXxeWYe3y2qUtdJNa
   NHp5DUNc8lvPPL8PHQoYMSzRYakHzU9mY7PYdGPNvsQzUBEaBW0UBl7cZ
   pXfjPJhhRQ+V4GhtSNROj9dvccanxqRid7L3ZtlbjSC4lAeLOkNMax51V
   g==;
X-CSE-ConnectionGUID: Jqb53TaeR02tm2Kb8A3eww==
X-CSE-MsgGUID: MthZLAT1Sby0nGRd1BaitA==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62011186"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="62011186"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 04:07:55 -0700
X-CSE-ConnectionGUID: ci2VY5XdR1OYxkSl6SuILg==
X-CSE-MsgGUID: +Wi3BTgZSgu3rjkmdKn1pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="181557081"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 16 Oct 2025 04:07:48 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9Lox-0004jL-1a;
	Thu, 16 Oct 2025 11:07:17 +0000
Date: Thu, 16 Oct 2025 19:05:27 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Takaya Saeki <takayas@google.com>, Tom Zanussi <zanussi@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ian Rogers <irogers@google.com>,
	Douglas Raillard <douglas.raillard@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3 03/13] perf: tracing: Simplify
 perf_sysenter_enable/disable() with guards
Message-ID: <202510161858.5hz4HLnc-lkp@intel.com>
References: <20251015173548.540984239@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015173548.540984239@kernel.org>

Hi Steven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.18-rc1 next-20251015]
[cannot apply to trace/for-next acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Make-trace_user_fault_read-exposed-to-rest-of-tracing/20251016-014059
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251015173548.540984239%40kernel.org
patch subject: [PATCH v3 03/13] perf: tracing: Simplify perf_sysenter_enable/disable() with guards
config: x86_64-randconfig-r073-20251016 (https://download.01.org/0day-ci/archive/20251016/202510161858.5hz4HLnc-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251016/202510161858.5hz4HLnc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510161858.5hz4HLnc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/trace_syscalls.c:1018:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1018 |         if (!sys_perf_refcount_enter) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_syscalls.c:1027:9: note: uninitialized use occurs here
    1027 |         return ret;
         |                ^~~
   kernel/trace/trace_syscalls.c:1018:2: note: remove the 'if' if its condition is always true
    1018 |         if (!sys_perf_refcount_enter) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_syscalls.c:1012:9: note: initialize the variable 'ret' to silence this warning
    1012 |         int ret;
         |                ^
         |                 = 0
   kernel/trace/trace_syscalls.c:1123:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1123 |         if (!sys_perf_refcount_exit) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_syscalls.c:1132:9: note: uninitialized use occurs here
    1132 |         return ret;
         |                ^~~
   kernel/trace/trace_syscalls.c:1123:2: note: remove the 'if' if its condition is always true
    1123 |         if (!sys_perf_refcount_exit) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_syscalls.c:1117:9: note: initialize the variable 'ret' to silence this warning
    1117 |         int ret;
         |                ^
         |                 = 0
   2 warnings generated.


vim +1018 kernel/trace/trace_syscalls.c

  1009	
  1010	static int perf_sysenter_enable(struct trace_event_call *call)
  1011	{
  1012		int ret;
  1013		int num;
  1014	
  1015		num = ((struct syscall_metadata *)call->data)->syscall_nr;
  1016	
  1017		guard(mutex)(&syscall_trace_lock);
> 1018		if (!sys_perf_refcount_enter) {
  1019			ret = register_trace_sys_enter(perf_syscall_enter, NULL);
  1020			if (ret) {
  1021				pr_info("event trace: Could not activate syscall entry trace point");
  1022				return ret;
  1023			}
  1024		}
  1025		set_bit(num, enabled_perf_enter_syscalls);
  1026		sys_perf_refcount_enter++;
  1027		return ret;
  1028	}
  1029	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
