Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015D5202F71;
	Sun,  1 Feb 2026 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769971445; cv=none; b=BsrRHbaOUxZ7KjtA9Hn/WAYf+f7yXJ8UKdIM61P5IIeemLdizX1IuDPIxezjC/jWa/qg5Gc2kLGNU93L+GbHB5QmpGz6WhVNXQEFnC1a/QlfxPYB9Eep5ctz9KYOh/Z1GUPQ9TpoqUg3pUaTmN8XonD/3Fer03x2Fo+5/yRifp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769971445; c=relaxed/simple;
	bh=zgoHZfkkj0xkhXIu3SUGeGDIU6/8yqR6vkvxzR5nyv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIVFz70G1VwFFuZQxF3D0xiKjzkwIQaknhu9uJaILPL6lVpR+7QCxxUIgrTcVO8+Mw9kvC4ScC48RGYIr+sFUPjVpS1oGhkUsPfoxXLQmGbUCly5i2IYWPfwpdRCxL1d8q9R91qHB4HMfVbugHW7sQ0KhOEFYD9p+Ip/e6ToTfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ip6Ave2e; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ip6Ave2e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769971443; x=1801507443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zgoHZfkkj0xkhXIu3SUGeGDIU6/8yqR6vkvxzR5nyv8=;
  b=Ip6Ave2elU2KVAduQVWFug83ogdgoGd3T9SJV++u1oS61EHVKrxMlfa8
   7+XEEimTrLto9l/j/aMjeKq5hschLRwqTpO5CYYj39FNbb8dL2eCLr+ob
   AFLIHHrrvT4aYVNDC1TJlv1SbnnHBDFNqEmTSP/VqXOS+S0f1ZIk37eUV
   pHDVksyL8KqwT26A7pkySzVxW0Kr6bvHTH+GiPiynvi9A23G+nSyWGwow
   iBuP2oCCkgzXgKrcloD2jsHhGefKHnk3zBL5FTBsX1qOs186AhJqxyLvL
   NvXFatwA1Km4mhQy+64bViSPNW84fbJNAMjACr8Q61Z09bWo/+wtKY6sh
   w==;
X-CSE-ConnectionGUID: vdHgBo9SRZCM4LyiDRoYXw==
X-CSE-MsgGUID: 1yZj3tT6RwaW+joVmuUuSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="71199307"
X-IronPort-AV: E=Sophos;i="6.21,267,1763452800"; 
   d="scan'208";a="71199307"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2026 10:44:02 -0800
X-CSE-ConnectionGUID: 4wyl5vIdS0eNs5v61rrX3A==
X-CSE-MsgGUID: AEHOg8mlT2S0n4j/OjqXnw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 01 Feb 2026 10:44:01 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vmcQQ-00000000ewq-0Ua5;
	Sun, 01 Feb 2026 18:43:58 +0000
Date: Mon, 2 Feb 2026 02:43:48 +0800
From: kernel test robot <lkp@intel.com>
To: Haocheng Yu <yuhaocheng035@gmail.com>, acme@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] perf/core: Fix refcount bug and potential UAF in
 perf_mmap
Message-ID: <202602020208.m7KIjdzW-lkp@intel.com>
References: <20260201113446.4328-1-yuhaocheng035@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201113446.4328-1-yuhaocheng035@gmail.com>

Hi Haocheng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on perf-tools-next/perf-tools-next]
[also build test WARNING on tip/perf/core perf-tools/perf-tools linus/master v6.19-rc7 next-20260130]
[cannot apply to acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haocheng-Yu/perf-core-Fix-refcount-bug-and-potential-UAF-in-perf_mmap/20260201-193746
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20260201113446.4328-1-yuhaocheng035%40gmail.com
patch subject: [PATCH] perf/core: Fix refcount bug and potential UAF in perf_mmap
config: mips-randconfig-r072-20260201 (https://download.01.org/0day-ci/archive/20260202/202602020208.m7KIjdzW-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
smatch version: v0.5.0-8994-gd50c5a4c

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602020208.m7KIjdzW-lkp@intel.com/

smatch warnings:
kernel/events/core.c:7183 perf_mmap() warn: inconsistent indenting

vim +7183 kernel/events/core.c

7b732a75047738 kernel/perf_counter.c Peter Zijlstra          2009-03-23  7131  
37d81828385f8f kernel/perf_counter.c Paul Mackerras          2009-03-23  7132  static int perf_mmap(struct file *file, struct vm_area_struct *vma)
37d81828385f8f kernel/perf_counter.c Paul Mackerras          2009-03-23  7133  {
cdd6c482c9ff9c kernel/perf_event.c   Ingo Molnar             2009-09-21  7134  	struct perf_event *event = file->private_data;
81e026ca47b386 kernel/events/core.c  Thomas Gleixner         2025-08-12  7135  	unsigned long vma_size, nr_pages;
da916e96e2dedc kernel/events/core.c  Peter Zijlstra          2024-10-25  7136  	mapped_f mapped;
5d299897f1e360 kernel/events/core.c  Peter Zijlstra          2025-08-12  7137  	int ret;
d57e34fdd60be7 kernel/perf_event.c   Peter Zijlstra          2010-05-28  7138  
c7920614cebbf2 kernel/perf_event.c   Peter Zijlstra          2010-05-18  7139  	/*
c7920614cebbf2 kernel/perf_event.c   Peter Zijlstra          2010-05-18  7140  	 * Don't allow mmap() of inherited per-task counters. This would
c7920614cebbf2 kernel/perf_event.c   Peter Zijlstra          2010-05-18  7141  	 * create a performance issue due to all children writing to the
76369139ceb955 kernel/events/core.c  Frederic Weisbecker     2011-05-19  7142  	 * same rb.
c7920614cebbf2 kernel/perf_event.c   Peter Zijlstra          2010-05-18  7143  	 */
c7920614cebbf2 kernel/perf_event.c   Peter Zijlstra          2010-05-18  7144  	if (event->cpu == -1 && event->attr.inherit)
c7920614cebbf2 kernel/perf_event.c   Peter Zijlstra          2010-05-18  7145  		return -EINVAL;
4ec8363dfc1451 kernel/events/core.c  Vince Weaver            2011-06-01  7146  
43a21ea81a2400 kernel/perf_counter.c Peter Zijlstra          2009-03-25  7147  	if (!(vma->vm_flags & VM_SHARED))
37d81828385f8f kernel/perf_counter.c Paul Mackerras          2009-03-23  7148  		return -EINVAL;
26cb63ad11e040 kernel/events/core.c  Peter Zijlstra          2013-05-28  7149  
da97e18458fb42 kernel/events/core.c  Joel Fernandes (Google  2019-10-14  7150) 	ret = security_perf_event_read(event);
da97e18458fb42 kernel/events/core.c  Joel Fernandes (Google  2019-10-14  7151) 	if (ret)
da97e18458fb42 kernel/events/core.c  Joel Fernandes (Google  2019-10-14  7152) 		return ret;
26cb63ad11e040 kernel/events/core.c  Peter Zijlstra          2013-05-28  7153  
7b732a75047738 kernel/perf_counter.c Peter Zijlstra          2009-03-23  7154  	vma_size = vma->vm_end - vma->vm_start;
0c8a4e4139adf0 kernel/events/core.c  Peter Zijlstra          2024-11-04  7155  	nr_pages = vma_size / PAGE_SIZE;
ac9721f3f54b27 kernel/perf_event.c   Peter Zijlstra          2010-05-27  7156  
0c8a4e4139adf0 kernel/events/core.c  Peter Zijlstra          2024-11-04  7157  	if (nr_pages > INT_MAX)
0c8a4e4139adf0 kernel/events/core.c  Peter Zijlstra          2024-11-04  7158  		return -ENOMEM;
9a0f05cb368885 kernel/events/core.c  Peter Zijlstra          2011-11-21  7159  
0c8a4e4139adf0 kernel/events/core.c  Peter Zijlstra          2024-11-04  7160  	if (vma_size != PAGE_SIZE * nr_pages)
0c8a4e4139adf0 kernel/events/core.c  Peter Zijlstra          2024-11-04  7161  		return -EINVAL;
45bfb2e50471ab kernel/events/core.c  Peter Zijlstra          2015-01-14  7162  
d23a6dbc0a7174 kernel/events/core.c  Peter Zijlstra          2025-08-12  7163  	scoped_guard (mutex, &event->mmap_mutex) {
da916e96e2dedc kernel/events/core.c  Peter Zijlstra          2024-10-25  7164  		/*
da916e96e2dedc kernel/events/core.c  Peter Zijlstra          2024-10-25  7165  		 * This relies on __pmu_detach_event() taking mmap_mutex after marking
da916e96e2dedc kernel/events/core.c  Peter Zijlstra          2024-10-25  7166  		 * the event REVOKED. Either we observe the state, or __pmu_detach_event()
da916e96e2dedc kernel/events/core.c  Peter Zijlstra          2024-10-25  7167  		 * will detach the rb created here.
da916e96e2dedc kernel/events/core.c  Peter Zijlstra          2024-10-25  7168  		 */
d23a6dbc0a7174 kernel/events/core.c  Peter Zijlstra          2025-08-12  7169  		if (event->state <= PERF_EVENT_STATE_REVOKED)
d23a6dbc0a7174 kernel/events/core.c  Peter Zijlstra          2025-08-12  7170  			return -ENODEV;
37d81828385f8f kernel/perf_counter.c Paul Mackerras          2009-03-23  7171  
5d299897f1e360 kernel/events/core.c  Peter Zijlstra          2025-08-12  7172  		if (vma->vm_pgoff == 0)
5d299897f1e360 kernel/events/core.c  Peter Zijlstra          2025-08-12  7173  			ret = perf_mmap_rb(vma, event, nr_pages);
5d299897f1e360 kernel/events/core.c  Peter Zijlstra          2025-08-12  7174  		else
2aee3768239133 kernel/events/core.c  Peter Zijlstra          2025-08-12  7175  			ret = perf_mmap_aux(vma, event, nr_pages);
07091aade394f6 kernel/events/core.c  Thomas Gleixner         2025-08-02  7176  		if (ret)
07091aade394f6 kernel/events/core.c  Thomas Gleixner         2025-08-02  7177  			return ret;
07091aade394f6 kernel/events/core.c  Thomas Gleixner         2025-08-02  7178  
9bb5d40cd93c9d kernel/events/core.c  Peter Zijlstra          2013-06-04  7179  	/*
9bb5d40cd93c9d kernel/events/core.c  Peter Zijlstra          2013-06-04  7180  	 * Since pinned accounting is per vm we cannot allow fork() to copy our
9bb5d40cd93c9d kernel/events/core.c  Peter Zijlstra          2013-06-04  7181  	 * vma.
9bb5d40cd93c9d kernel/events/core.c  Peter Zijlstra          2013-06-04  7182  	 */
1c71222e5f2393 kernel/events/core.c  Suren Baghdasaryan      2023-01-26 @7183  	vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
37d81828385f8f kernel/perf_counter.c Paul Mackerras          2009-03-23  7184  	vma->vm_ops = &perf_mmap_vmops;
7b732a75047738 kernel/perf_counter.c Peter Zijlstra          2009-03-23  7185  
da916e96e2dedc kernel/events/core.c  Peter Zijlstra          2024-10-25  7186  	mapped = get_mapped(event, event_mapped);
da916e96e2dedc kernel/events/core.c  Peter Zijlstra          2024-10-25  7187  	if (mapped)
da916e96e2dedc kernel/events/core.c  Peter Zijlstra          2024-10-25  7188  		mapped(event, vma->vm_mm);
1e0fb9ec679c92 kernel/events/core.c  Andy Lutomirski         2014-10-24  7189  
f74b9f4ba63ffd kernel/events/core.c  Thomas Gleixner         2025-08-02  7190  	/*
f74b9f4ba63ffd kernel/events/core.c  Thomas Gleixner         2025-08-02  7191  	 * Try to map it into the page table. On fail, invoke
f74b9f4ba63ffd kernel/events/core.c  Thomas Gleixner         2025-08-02  7192  	 * perf_mmap_close() to undo the above, as the callsite expects
f74b9f4ba63ffd kernel/events/core.c  Thomas Gleixner         2025-08-02  7193  	 * full cleanup in this case and therefore does not invoke
f74b9f4ba63ffd kernel/events/core.c  Thomas Gleixner         2025-08-02  7194  	 * vmops::close().
f74b9f4ba63ffd kernel/events/core.c  Thomas Gleixner         2025-08-02  7195  	 */
191759e5ea9f69 kernel/events/core.c  Peter Zijlstra          2025-08-12  7196  	ret = map_range(event->rb, vma);
f74b9f4ba63ffd kernel/events/core.c  Thomas Gleixner         2025-08-02  7197  	if (ret)
f74b9f4ba63ffd kernel/events/core.c  Thomas Gleixner         2025-08-02  7198  		perf_mmap_close(vma);
8f75f689bf8133 kernel/events/core.c  Haocheng Yu             2026-02-01  7199  	}
f74b9f4ba63ffd kernel/events/core.c  Thomas Gleixner         2025-08-02  7200  
7b732a75047738 kernel/perf_counter.c Peter Zijlstra          2009-03-23  7201  	return ret;
37d81828385f8f kernel/perf_counter.c Paul Mackerras          2009-03-23  7202  }
37d81828385f8f kernel/perf_counter.c Paul Mackerras          2009-03-23  7203  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
