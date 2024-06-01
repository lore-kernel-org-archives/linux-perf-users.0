Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A24D8C04;
	Sat,  1 Jun 2024 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717248513; cv=none; b=P4hfYy4q261J99tW1XZN5CImR2NZTSOaz7lBocdgufSIz+HEqUDWzhL/PSG8ihfhG5IOZ0YA7U3I4pvLc5U1tjID060FwKv0zySF2i0cSiJiAUP6pAxC0vpLdnNl8O5tJyy+EjeZ/ruQv4cczcL6evLPf3VKqqEoMWWia3nFluQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717248513; c=relaxed/simple;
	bh=D59jnmVQMhCNl55Pkwv0majNLLAp15FV0PALvzWaA2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZLSqK3ikiCZtb5LRwnTww+376Bi4B/H/OZr/P2u2RxjkT/X1Ru/trqLw2ndNpATAJgxGdE9MC5xLyqrFFO5oojmx8xd1aKyzjxHCOpKULE2wLQiuThyp90EodUzxNrH4OUCoj5Rpak5ZR4RtJ6SwmxGTyQePYgZCEf58jAxqz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sn9rkqu4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sn9rkqu4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717248511; x=1748784511;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D59jnmVQMhCNl55Pkwv0majNLLAp15FV0PALvzWaA2Q=;
  b=Sn9rkqu4s4Q9rG88qbXValkefQpPwsJbIWseAL9skcainiYB1hRUubrx
   3ij8soqwvGsQRrdMprVOf01jgqbAwpC0BaWyz9DTVQ1RcSAf8r/QtLxsM
   9qu/08xMgq7RAuMdFGpRqvKon1gtDO71vA1wJ8jZvwj7k6A6GzP/2fBmZ
   J+hoopWkX7U/B4Qd/21Y9E5JbklfMYIXdJ+tmlXblNLkpE17yzgNk+neS
   qH/pWQI5KD4W4UhIIhKBE80E4nJ5F2jM5Gao2bnZDq5BYkDfElEmyhI6J
   QZKyk+NZ4ueAhgK/dq3URJt4Uvy4nthfK+1mN5U3FRSMAnQu7YOZhR8Jx
   A==;
X-CSE-ConnectionGUID: AeSG0bbMSNiUbOKctBig0A==
X-CSE-MsgGUID: FzyomtUGQjCbD5SFcYPW6A==
X-IronPort-AV: E=McAfee;i="6600,9927,11090"; a="17636684"
X-IronPort-AV: E=Sophos;i="6.08,207,1712646000"; 
   d="scan'208";a="17636684"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2024 06:28:31 -0700
X-CSE-ConnectionGUID: VUgAXcZJSS2qpLFK8gkM7Q==
X-CSE-MsgGUID: QA43emCHShOWnAJco8uRRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,207,1712646000"; 
   d="scan'208";a="36526002"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 01 Jun 2024 06:28:26 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sDOmV-000Iur-2L;
	Sat, 01 Jun 2024 13:28:23 +0000
Date: Sat, 1 Jun 2024 21:27:31 +0800
From: kernel test robot <lkp@intel.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, dev.mbstr@gmail.com,
	samuel.holland@sifive.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ruanjinjie@huawei.com
Subject: Re: [PATCH] riscv: stacktrace: Add USER_STACKTRACE support
Message-ID: <202406012109.PDAjXm2i-lkp@intel.com>
References: <20240531083258.386709-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531083258.386709-1-ruanjinjie@huawei.com>

Hi Jinjie,

kernel test robot noticed the following build warnings:

[auto build test WARNING on perf-tools-next/perf-tools-next]
[also build test WARNING on tip/perf/core perf-tools/perf-tools linus/master acme/perf/core v6.10-rc1 next-20240531]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jinjie-Ruan/riscv-stacktrace-Add-USER_STACKTRACE-support/20240531-163624
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20240531083258.386709-1-ruanjinjie%40huawei.com
patch subject: [PATCH] riscv: stacktrace: Add USER_STACKTRACE support
config: riscv-randconfig-r061-20240601 (https://download.01.org/0day-ci/archive/20240601/202406012109.PDAjXm2i-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406012109.PDAjXm2i-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> arch/riscv/kernel/stacktrace.c:188:16-18: WARNING !A || A && B is equivalent to !A || B

vim +188 arch/riscv/kernel/stacktrace.c

   164	
   165	/*
   166	 * Get the return address for a single stackframe and return a pointer to the
   167	 * next frame tail.
   168	 */
   169	static unsigned long unwind_user_frame(stack_trace_consume_fn consume_entry,
   170					       void *cookie, unsigned long fp,
   171					       unsigned long reg_ra)
   172	{
   173		struct stackframe buftail;
   174		unsigned long ra = 0;
   175		unsigned long __user *user_frame_tail =
   176			(unsigned long __user *)(fp - sizeof(struct stackframe));
   177	
   178		/* Check accessibility of one struct frame_tail beyond */
   179		if (!access_ok(user_frame_tail, sizeof(buftail)))
   180			return 0;
   181		if (__copy_from_user_inatomic(&buftail, user_frame_tail,
   182					      sizeof(buftail)))
   183			return 0;
   184	
   185		ra = reg_ra ? : buftail.ra;
   186	
   187		fp = buftail.fp;
 > 188		if (!ra || (ra && !consume_entry(cookie, ra)))
   189			return 0;
   190	
   191		return fp;
   192	}
   193	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
