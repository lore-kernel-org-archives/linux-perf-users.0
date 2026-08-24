Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B661A6808;
	Mon, 24 Aug 2026 23:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787615946; cv=none; b=Wn+Vb42hQQDRSlrrWgi38iyQeKIg7IIendmCb9YnC1q3aZcy+JQgLfaJyjrTVY/1BdLddiEUeDqG3+iHVcvWh5DVQWHP/KQRJ+M+GtYYGTOAeVRFPWNZGaY+o3as/nXSb2rz+l26UIO0sX+afOco/RVEj5/6yrlqht6GHCQm01s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787615946; c=relaxed/simple;
	bh=toWWK63/u0cbEpN+GBCv1cxt3ZWQy061q8KPLqTsbgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfvNJ6t2cgTacsbuhg8MnxQcUHUdw+KF4x/IEhDDX9r40vZMPLIVELFVltL2Twg+l91sVX5Zj0RkNriMMhBCdkMN7fbY237dhAqnLuakUC14IwZnZhsH8vkul+uN0XG+alzlYQiUvPCZa1mvL1lW0R8PmJ+c6Yzef8YXplob8VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=htyeM440; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="htyeM440"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787615945; x=1819151945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=toWWK63/u0cbEpN+GBCv1cxt3ZWQy061q8KPLqTsbgQ=;
  b=htyeM440Znjo4zn0M/qA5mdoD28Gy3ang2x6DYHy207TbBPSjYXd14Cg
   dO5TT0HuHbx4lGyvuRXrNL8WsboRULMSL8WiYRcYSw7TvwI61R1yFpl2K
   EHyrN6rYHe5zQg7qWQmp+hMWQxCJwfgA4rBVK55TFcrgSciQewrUvb2S8
   JFZyT3kIy1M9jNnJyPfCXi/uMDHYYviZsKHKCDi3IFvPRr/MraaWtbO7S
   se9NDpVY+7uhU3FlNR0aCtzNN1pLcwQn+kLxXD31oSrK7kNw+mTwv4M8z
   G8CwH0xpGYZAMX4TeT7RywbOUrj78U2EijhkEeTFPCbVE8+gA0ewXt3WY
   Q==;
X-CSE-ConnectionGUID: BkF6MBFPRcusXfj/AYznsQ==
X-CSE-MsgGUID: KhI3pILNSEWFpQOrOEXKyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98753378"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98753378"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 16:59:04 -0700
X-CSE-ConnectionGUID: 7btRjMSQRzWoyrm6SWnM8g==
X-CSE-MsgGUID: 2Mm0eWs5QMafKNmEkumlcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="262831495"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 24 Aug 2026 16:58:57 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wyeYx-000000004al-3nMF;
	Mon, 24 Aug 2026 23:58:48 +0000
Date: Tue, 25 Aug 2026 07:58:02 +0800
From: kernel test robot <lkp@intel.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, olsajiri@gmail.com, irogers@google.com,
	adrian.hunter@intel.com, james.clark@linaro.org, kpsingh@kernel.org,
	matt@bobrowski.net, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	emil@etsalapatis.com, ihor.solodrai@linux.dev, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com
Cc: oe-kbuild-all@lists.linux.dev, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/bpf: Fix lockless access to parent_event->prog in
 perf_event_alloc()
Message-ID: <202608250735.Idi1PQgE-lkp@intel.com>
References: <20260821014210.18681-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821014210.18681-1-kartikey406@gmail.com>

Hi Deepanshu,

kernel test robot noticed the following build errors:

[auto build test ERROR on perf-tools-next/perf-tools-next]
[also build test ERROR on tip/perf/core perf-tools/perf-tools linus/master v7.2 next-20260821]
[cannot apply to acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Deepanshu-Kartikey/perf-bpf-Fix-lockless-access-to-parent_event-prog-in-perf_event_alloc/20260821-071210
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20260821014210.18681-1-kartikey406%40gmail.com
patch subject: [PATCH] perf/bpf: Fix lockless access to parent_event->prog in perf_event_alloc()
config: arm-randconfig-004-20260825 (https://download.01.org/0day-ci/archive/20260825/202608250735.Idi1PQgE-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260825/202608250735.Idi1PQgE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608250735.Idi1PQgE-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: kernel/events/core.o: in function `__list_add':
>> include/linux/list.h:159:(.text.perf_event_alloc.part.0+0x96c): undefined reference to `bpf_event_mutex'
   arm-linux-gnueabi-ld: drivers/pci/controller/cadence/pcie-cadence-plat.o: in function `cdns_plat_pcie_probe':
   drivers/pci/controller/cadence/pcie-cadence-plat.c:85:(.text.cdns_plat_pcie_probe+0xfc): undefined reference to `cdns_pcie_host_setup'


vim +159 include/linux/list.h

d7c816733d501b5 Kees Cook        2016-08-17  147  
^1da177e4c3f415 Linus Torvalds   2005-04-16  148  /*
^1da177e4c3f415 Linus Torvalds   2005-04-16  149   * Insert a new entry between two known consecutive entries.
^1da177e4c3f415 Linus Torvalds   2005-04-16  150   *
^1da177e4c3f415 Linus Torvalds   2005-04-16  151   * This is only for internal list manipulation where we know
^1da177e4c3f415 Linus Torvalds   2005-04-16  152   * the prev/next entries already!
^1da177e4c3f415 Linus Torvalds   2005-04-16  153   */
^1da177e4c3f415 Linus Torvalds   2005-04-16  154  static inline void __list_add(struct list_head *new,
^1da177e4c3f415 Linus Torvalds   2005-04-16  155  			      struct list_head *prev,
^1da177e4c3f415 Linus Torvalds   2005-04-16  156  			      struct list_head *next)
^1da177e4c3f415 Linus Torvalds   2005-04-16  157  {
d7c816733d501b5 Kees Cook        2016-08-17  158  	if (!__list_add_valid(new, prev, next))
d7c816733d501b5 Kees Cook        2016-08-17 @159  		return;
d7c816733d501b5 Kees Cook        2016-08-17  160  
^1da177e4c3f415 Linus Torvalds   2005-04-16  161  	next->prev = new;
^1da177e4c3f415 Linus Torvalds   2005-04-16  162  	new->next = next;
^1da177e4c3f415 Linus Torvalds   2005-04-16  163  	new->prev = prev;
1c97be677f72b3c Paul E. McKenney 2015-09-20  164  	WRITE_ONCE(prev->next, new);
^1da177e4c3f415 Linus Torvalds   2005-04-16  165  }
^1da177e4c3f415 Linus Torvalds   2005-04-16  166  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
