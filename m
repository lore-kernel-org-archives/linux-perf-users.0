Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD167395ACC;
	Mon, 24 Aug 2026 22:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787612012; cv=none; b=O4srPX5Ci1QQ2VNJA9YAtQ898rBOs1iTI35D4VB1yC+JiJMgfFDhnwJBKxh9X7FqlAy53rk1SXli5236jvvs+pcEiO9jYbnHyd9VJmlBFN781dfkfLqNFUByeHLEBdV40URBCzB2wmpuxmR0BNTfAhWsDYngh8cE6bNlgaxhl9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787612012; c=relaxed/simple;
	bh=OSMMVu7VFL35TTrsovGeLIodUwZe57kclqb8HcBlHhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuptjHwQE2sB6IRSr5gdQkz7+tu1t3MZCy9fwvYaN4IDmRGCHLGhBCDhretSQs33Sk+A+xB5v/Mw4PpAr00HzVKUFEmG4lVNytEe0SeZZ7weVeliB+QwCqdjMQY5MtUmm/xzJ6UKclMDzBjgvU3i0fxACk9mKW0uICaIp7/ssPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TGmuGPiO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TGmuGPiO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787612010; x=1819148010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OSMMVu7VFL35TTrsovGeLIodUwZe57kclqb8HcBlHhs=;
  b=TGmuGPiORJaXY8IUfxuBhky7QgifV5FDWFW+tL5plW+cyVoA3G9sZFVU
   0gnIoJT15TYLwDMgifddMcql1IOMQye99QpnI46pflZpv2LsKA3t2NZBt
   5ZlAeNfNFGZ9xI4V7Dr1S74agvl6qc008T0Ja2y6FEx0kez9nszmkDVJf
   O90GhFl3hVvuoYoRWJfZkr6j2ZHmP/7Wyx/WxlQxWv6x4pZNXcP8W6sz+
   h4YqmgwbQ94NbT0jVmfJOLIlgA0xi33SWshTZVgJmtY+2216QRpylYwqW
   Pj2mtsDhxkOl+kvzNqKOcHMKre7GlcEPtMO8vVxgMj5MLJRGjpTia1MCn
   A==;
X-CSE-ConnectionGUID: 2yeCM9HsRCqOdHJuho7zZA==
X-CSE-MsgGUID: aAgDs5oWQ7q4eoLjJof66Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="99423442"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="99423442"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 15:53:29 -0700
X-CSE-ConnectionGUID: poYr+gngQgCiwcMHZ9VOYw==
X-CSE-MsgGUID: 7cuXLLBMS8KT04O3MlzeWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="291974966"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 24 Aug 2026 15:53:23 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wydXU-000000004Nj-2GVm;
	Mon, 24 Aug 2026 22:53:13 +0000
Date: Tue, 25 Aug 2026 06:52:36 +0800
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
Message-ID: <202608250601.kP2R1VQE-lkp@intel.com>
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
config: sparc-randconfig-002-20260825 (https://download.01.org/0day-ci/archive/20260825/202608250601.kP2R1VQE-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260825/202608250601.kP2R1VQE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608250601.kP2R1VQE-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc64-linux-ld: kernel/events/core.o: in function `perf_event_alloc':
>> kernel/events/core.c:13438:(.text+0x9be0): undefined reference to `bpf_event_mutex'
>> sparc64-linux-ld: kernel/events/core.c:13438:(.text+0x9bec): undefined reference to `bpf_event_mutex'
   sparc64-linux-ld: kernel/events/core.c:13444:(.text+0x9c14): undefined reference to `bpf_event_mutex'


vim +13438 kernel/events/core.c

 13340	
 13341	/*
 13342	 * Allocate and initialize an event structure
 13343	 */
 13344	static struct perf_event *
 13345	perf_event_alloc(struct perf_event_attr *attr, int cpu,
 13346			 struct task_struct *task,
 13347			 struct perf_event *group_leader,
 13348			 struct perf_event *parent_event,
 13349			 perf_overflow_handler_t overflow_handler,
 13350			 void *context, int cgroup_fd)
 13351	{
 13352		struct pmu *pmu;
 13353		struct hw_perf_event *hwc;
 13354		long err = -EINVAL;
 13355		int node;
 13356	
 13357		if ((unsigned)cpu >= nr_cpu_ids) {
 13358			if (!task || cpu != -1)
 13359				return ERR_PTR(-EINVAL);
 13360		}
 13361		if (attr->sigtrap && !task) {
 13362			/* Requires a task: avoid signalling random tasks. */
 13363			return ERR_PTR(-EINVAL);
 13364		}
 13365	
 13366		node = (cpu >= 0) ? cpu_to_node(cpu) : -1;
 13367		struct perf_event *event __free(__free_event) =
 13368			kmem_cache_alloc_node(perf_event_cache, GFP_KERNEL | __GFP_ZERO, node);
 13369		if (!event)
 13370			return ERR_PTR(-ENOMEM);
 13371	
 13372		/*
 13373		 * Single events are their own group leaders, with an
 13374		 * empty sibling list:
 13375		 */
 13376		if (!group_leader)
 13377			group_leader = event;
 13378	
 13379		mutex_init(&event->child_mutex);
 13380		INIT_LIST_HEAD(&event->child_list);
 13381	
 13382		INIT_LIST_HEAD(&event->event_entry);
 13383		INIT_LIST_HEAD(&event->sibling_list);
 13384		INIT_LIST_HEAD(&event->active_list);
 13385		init_event_group(event);
 13386		INIT_LIST_HEAD(&event->rb_entry);
 13387		INIT_LIST_HEAD(&event->active_entry);
 13388		INIT_LIST_HEAD(&event->addr_filters.list);
 13389		INIT_HLIST_NODE(&event->hlist_entry);
 13390		INIT_LIST_HEAD(&event->pmu_list);
 13391	
 13392	
 13393		init_waitqueue_head(&event->waitq);
 13394		init_irq_work(&event->pending_irq, perf_pending_irq);
 13395		event->pending_disable_irq = IRQ_WORK_INIT_HARD(perf_pending_disable);
 13396		init_task_work(&event->pending_task, perf_pending_task);
 13397	
 13398		mutex_init(&event->mmap_mutex);
 13399		raw_spin_lock_init(&event->addr_filters.lock);
 13400	
 13401		atomic_long_set(&event->refcount, 1);
 13402		event->cpu		= cpu;
 13403		event->attr		= *attr;
 13404		event->group_leader	= group_leader;
 13405		event->pmu		= NULL;
 13406		event->oncpu		= -1;
 13407	
 13408		event->parent		= parent_event;
 13409	
 13410		event->ns		= get_pid_ns(task_active_pid_ns(current));
 13411		event->id		= atomic64_inc_return(&perf_event_id);
 13412	
 13413		event->state		= PERF_EVENT_STATE_INACTIVE;
 13414	
 13415		if (parent_event)
 13416			event->event_caps = parent_event->event_caps;
 13417	
 13418		if (task) {
 13419			event->attach_state = PERF_ATTACH_TASK;
 13420			/*
 13421			 * XXX pmu::event_init needs to know what task to account to
 13422			 * and we cannot use the ctx information because we need the
 13423			 * pmu before we get a ctx.
 13424			 */
 13425			event->hw.target = get_task_struct(task);
 13426		}
 13427	
 13428		event->clock = &local_clock;
 13429		if (parent_event)
 13430			event->clock = parent_event->clock;
 13431	
 13432		if (!overflow_handler && parent_event) {
 13433			overflow_handler = parent_event->overflow_handler;
 13434			context = parent_event->overflow_handler_context;
 13435	#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
 13436			struct bpf_prog *prog;
 13437	
 13438			mutex_lock(&bpf_event_mutex);
 13439			prog = parent_event->prog;
 13440			if (prog) {
 13441				bpf_prog_inc(prog);
 13442				event->prog = prog;
 13443			}
 13444			mutex_unlock(&bpf_event_mutex);
 13445	#endif
 13446		}
 13447	
 13448		if (overflow_handler) {
 13449			event->overflow_handler	= overflow_handler;
 13450			event->overflow_handler_context = context;
 13451		} else if (is_write_backward(event)){
 13452			event->overflow_handler = perf_event_output_backward;
 13453			event->overflow_handler_context = NULL;
 13454		} else {
 13455			event->overflow_handler = perf_event_output_forward;
 13456			event->overflow_handler_context = NULL;
 13457		}
 13458	
 13459		perf_event__state_init(event);
 13460	
 13461		pmu = NULL;
 13462	
 13463		hwc = &event->hw;
 13464		hwc->sample_period = attr->sample_period;
 13465		if (is_event_in_freq_mode(event))
 13466			hwc->sample_period = 1;
 13467		hwc->last_period = hwc->sample_period;
 13468	
 13469		local64_set(&hwc->period_left, hwc->sample_period);
 13470	
 13471		/*
 13472		 * We do not support PERF_SAMPLE_READ on inherited events unless
 13473		 * PERF_SAMPLE_TID is also selected, which allows inherited events to
 13474		 * collect per-thread samples.
 13475		 * See perf_output_read().
 13476		 */
 13477		if (has_inherit_and_sample_read(attr) && !(attr->sample_type & PERF_SAMPLE_TID))
 13478			return ERR_PTR(-EINVAL);
 13479	
 13480		if (!has_branch_stack(event))
 13481			event->attr.branch_sample_type = 0;
 13482	
 13483		pmu = perf_init_event(event);
 13484		if (IS_ERR(pmu))
 13485			return (void*)pmu;
 13486	
 13487		/*
 13488		 * The PERF_ATTACH_TASK_DATA is set in the event_init()->hw_config().
 13489		 * The attach should be right after the perf_init_event().
 13490		 * Otherwise, the __free_event() would mistakenly detach the non-exist
 13491		 * perf_ctx_data because of the other errors between them.
 13492		 */
 13493		if (event->attach_state & PERF_ATTACH_TASK_DATA) {
 13494			err = attach_perf_ctx_data(event);
 13495			if (err)
 13496				return ERR_PTR(err);
 13497		}
 13498	
 13499		/*
 13500		 * Disallow uncore-task events. Similarly, disallow uncore-cgroup
 13501		 * events (they don't make sense as the cgroup will be different
 13502		 * on other CPUs in the uncore mask).
 13503		 */
 13504		if (pmu->task_ctx_nr == perf_invalid_context && (task || cgroup_fd != -1))
 13505			return ERR_PTR(-EINVAL);
 13506	
 13507		if (event->attr.aux_output &&
 13508		    (!(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT) ||
 13509		     event->attr.aux_pause || event->attr.aux_resume))
 13510			return ERR_PTR(-EOPNOTSUPP);
 13511	
 13512		if (event->attr.aux_pause && event->attr.aux_resume)
 13513			return ERR_PTR(-EINVAL);
 13514	
 13515		if (event->attr.aux_start_paused) {
 13516			if (!(pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE))
 13517				return ERR_PTR(-EOPNOTSUPP);
 13518			event->hw.aux_paused = 1;
 13519		}
 13520	
 13521		if (cgroup_fd != -1) {
 13522			err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
 13523			if (err)
 13524				return ERR_PTR(err);
 13525		}
 13526	
 13527		err = exclusive_event_init(event);
 13528		if (err)
 13529			return ERR_PTR(err);
 13530	
 13531		if (has_addr_filter(event)) {
 13532			event->addr_filter_ranges = kcalloc(pmu->nr_addr_filters,
 13533							    sizeof(struct perf_addr_filter_range),
 13534							    GFP_KERNEL);
 13535			if (!event->addr_filter_ranges)
 13536				return ERR_PTR(-ENOMEM);
 13537	
 13538			/*
 13539			 * Clone the parent's vma offsets: they are valid until exec()
 13540			 * even if the mm is not shared with the parent.
 13541			 */
 13542			if (event->parent) {
 13543				struct perf_addr_filters_head *ifh = perf_event_addr_filters(event);
 13544	
 13545				raw_spin_lock_irq(&ifh->lock);
 13546				memcpy(event->addr_filter_ranges,
 13547				       event->parent->addr_filter_ranges,
 13548				       pmu->nr_addr_filters * sizeof(struct perf_addr_filter_range));
 13549				raw_spin_unlock_irq(&ifh->lock);
 13550			}
 13551	
 13552			/* force hw sync on the address filters */
 13553			event->addr_filters_gen = 1;
 13554		}
 13555	
 13556		if (!event->parent) {
 13557			if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) {
 13558				err = get_callchain_buffers(attr->sample_max_stack);
 13559				if (err)
 13560					return ERR_PTR(err);
 13561				event->attach_state |= PERF_ATTACH_CALLCHAIN;
 13562			}
 13563		}
 13564	
 13565		err = security_perf_event_alloc(event);
 13566		if (err)
 13567			return ERR_PTR(err);
 13568	
 13569		err = mediated_pmu_account_event(event);
 13570		if (err)
 13571			return ERR_PTR(err);
 13572	
 13573		/* symmetric to unaccount_event() in _free_event() */
 13574		account_event(event);
 13575	
 13576		/*
 13577		 * Event creation should be under SRCU, see perf_pmu_unregister().
 13578		 */
 13579		lockdep_assert_held(&pmus_srcu);
 13580		scoped_guard (spinlock, &pmu->events_lock)
 13581			list_add(&event->pmu_list, &pmu->events);
 13582	
 13583		return_ptr(event);
 13584	}
 13585	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
