Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D3E3A1D14;
	Fri,  6 Feb 2026 12:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770379313; cv=none; b=fbA2FdpRbcFeA03LRSDPoSUkp6pBpVYTSuap+5zFkZuEMmKT9xH4iCbz3eILXdASp6kHfp3ocMVirIBVz5I9RADa/wuV/MT42YhVG1Ts257nFndZn0Tajsp9MqwPI4e+ouglCPwsrkM1evzX9p/xE06lQwDkPMfhexW/pPfGYJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770379313; c=relaxed/simple;
	bh=P5dSQdSgy4uF8f5LF4N4SpKaivTUNjGUROox89C8hbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHPFAxV89A4I8A3KLQ7VkbD2GxaRn3l+QKsHHYK2PJTaWY0cao3LrgDVOB1PcOKpyKsMcif737qBbslRjo1KWtpoX9BI12T6rnhS5rL/km7Kv54+nsngkS/RDmx7cLhB2BTVefWOQn1SrvYS22S69WhQdepAI5TPHnAxsOIejaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Epgpm4bA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Epgpm4bA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=lCH8chaQf9RRMTpM3+xc/voeuNJjRfJtUu3/kFntkL0=; b=Epgpm4bA5DgZFJAQLNO3Tri2yO
	vnFIfHaIMxCfzpKAyv8ggKYNwhAxZYjl76poHyvSzlq9D/JQuxdfXyZGB8MyHkc4dkGvsfQXUEKMx
	EufUt1bmVPHxq3GKY1rEXvmhmz+sIuOLLh7m1vtD3ueCCFSBpRz3OzGIXC0OxQRMnKcsvRxOWnvKY
	T+qaShyU4eDJAV31w118RQo7SVQuyqKNPn8vxCArIjDRagSjyVHSrDn2HIFF7ksaQ1u6pM2QEFILp
	3TEujy3xPNLVyQFCqSYFYNSBtS2o5/6hEe5z4Jr1cxeeP+GtxawniERK3pshp1WYvbog/0V50s2/W
	fkK1k9JA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1voKWa-0078zT-HM; Fri, 06 Feb 2026 12:01:25 +0000
Date: Fri, 6 Feb 2026 04:01:19 -0800
From: Breno Leitao <leitao@debian.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, Denis Yaroshevskiy <dyaroshev@meta.com>
Subject: Re: [PATCH] perf stat: Fix crash on arm64
Message-ID: <aYXPZfaO7Sa80iIM@gmail.com>
References: <20260205-perf_stat-v1-1-e433b0c918af@debian.org>
 <CAP-5=fW2iUbaZRX789SaJNGXk1VhGg0igLukb6SAosKiA-f1tA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW2iUbaZRX789SaJNGXk1VhGg0igLukb6SAosKiA-f1tA@mail.gmail.com>
X-Debian-User: leitao

Hello Ian, thanks for the quick reply!

On Thu, Feb 05, 2026 at 08:59:07AM -0800, Ian Rogers wrote:
> On Thu, Feb 5, 2026 at 3:46 AM Breno Leitao <leitao@debian.org> wrote:
> >
> > Perf stat is crashing on arm64 hosts with the following issue:
> >
> >         # make -C tools/perf DEBUG=1
> >         # perf stat sleep 1
> >         perf: util/evsel.c:2034: get_group_fd: Assertion `!(!leader->core.fd)' failed.
> >         [1]    1220794 IOT instruction (core dumped)  ./perf stat
> >
> > The sorting function introduced by commit a745c0831c15c ("perf stat:
> > Sort default events/metrics") compares events based on their individual
> > properties. This can cause events from different groups to be
> > interleaved, resulting in group members appearing before their leaders
> > in the sorted evlist.
> 
> Hi, sorry for the issue. I can see what you're saying but why is this
> an arm64 issue?

Sorry, It's not ARM64-specific - the bug is in the generic sort code.
It just happens to manifest on ARM64.

> The legacy Default metrics are common to all
> architectures:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/arch/common/common/metrics.json?h=perf-tools-next
> 
> > When the iterator opens events in list order, a group member may be
> > processed before its leader has been opened.
> >
> > For example, CPU_CYCLES (idx=32) with leader STALL_SLOT_BACKEND (idx=37)
> > could be sorted before its leader, causing the crash when CPU_CYCLES
> > tries to get its group fd from the not-yet-opened leader.
> 
> Which metric is this?

These are ARM neoverse metrics, they can be found in
tools/perf/pmu-events/arch/arm64/arm/neoverse-n*

> > Fix this by comparing events based on their leader's attributes instead
> > of their own attributes when the events are in different groups. This
> > ensures all members of a group share the same sort key as their leader,
> > keeping groups together and guaranteeing leaders are opened before their
> > members.
> 
> This makes sense but I'm not understanding why this problem wasn't
> seen previously. I'm guessing that in a metric like
> backend_cycles_idle:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/arch/common/common/metrics.json?h=perf-tools-next#n63
> ```
>         "BriefDescription": "Backend stalls per cycle",
>         "MetricExpr": "stalled\\-cycles\\-backend / cpu\\-cycles",
>         "MetricGroup": "Default",
>         "MetricName": "backend_cycles_idle",
>         "MetricThreshold": "backend_cycles_idle > 0.2",
>         "DefaultShowEvents": "1"
> ```

I was able to limit this to the following json:

  [
      {
          "ArchStdEvent": "backend_bound",
          "MetricExpr": "(100 * ((STALL_SLOT_BACKEND / (CPU_CYCLES * #slots)) - ((BR_MIS_PRED * 3) / CPU_CYCLES)))"
      },
      {
          "ArchStdEvent": "frontend_bound",
          "MetricExpr": "(100 * (((STALL_SLOT_FRONTEND) / (CPU_CYCLES * #slots)) - (BR_MIS_PRED / CPU_CYCLES)))"
      }
  ]

and then

	# ./tools/perf/perf stat -v sleep 0.01
	Using CPUID 0x00000000410fd4f0
	metric expr 100 * (STALL_SLOT_BACKEND / (CPU_CYCLES * #slots) - BR_MIS_PRED * 3 / CPU_CYCLES) for backend_bound
	metric expr 100 * (STALL_SLOT_FRONTEND / (CPU_CYCLES * #slots) - BR_MIS_PRED / CPU_CYCLES) for frontend_bound
	metric expr (software@cpu\-clock\,name\=cpu\-clock@ if #target_cpu else software@task\-clock\,name\=task\-clock@) / (duration_time * 1e9) for CPUs_utilized
	metric expr stalled\-cycles\-backend / cpu\-cycles for backend_cycles_idle
	metric expr stalled\-cycles\-backend / cpu\-cycles for backend_cycles_idle
	metric expr branches / (software@cpu\-clock\,name\=cpu\-clock@ if #target_cpu else software@task\-clock\,name\=task\-clock@) for branch_frequency
	metric expr branch\-misses / branches for branch_miss_rate
	metric expr branch\-misses / branches for branch_miss_rate
	metric expr software@context\-switches\,name\=context\-switches@ * 1e9 / (software@cpu\-clock\,name\=cpu\-clock@ if #target_cpu else software@task\-clock\,name\=task\-clock@) for cs_per_second
	metric expr cpu\-cycles / (software@cpu\-clock\,name\=cpu\-clock@ if #target_cpu else software@task\-clock\,name\=task\-clock@) for cycles_frequency
	metric expr stalled\-cycles\-frontend / cpu\-cycles for frontend_cycles_idle
	metric expr stalled\-cycles\-frontend / cpu\-cycles for frontend_cycles_idle
	metric expr instructions / cpu\-cycles for insn_per_cycle
	metric expr instructions / cpu\-cycles for insn_per_cycle
	metric expr software@cpu\-migrations\,name\=cpu\-migrations@ * 1e9 / (software@cpu\-clock\,name\=cpu\-clock@ if #target_cpu else software@task\-clock\,name\=task\-clock@) for migrations_per_second
	metric expr software@page\-faults\,name\=page\-faults@ * 1e9 / (software@cpu\-clock\,name\=cpu\-clock@ if #target_cpu else software@task\-clock\,name\=task\-clock@) for page_faults_per_second
	metric expr max(stalled\-cycles\-frontend, stalled\-cycles\-backend) / instructions for stalled_cycles_per_instruction
	hwmon_pmu: failure to open '/sys/class/hwmon/hwmon4/name'
	hwmon_pmu: failure to open '/sys/class/hwmon/hwmon5/name'
	hwmon_pmu: failure to open '/sys/class/hwmon/hwmon3/name'
	found event software@context-switches,name=context-switches@
	found event duration_time
	found event software@page-faults,name=page-faults@
	found event software@task-clock,name=task-clock@
	found event cpu-cycles
	found event branches
	found event software@cpu-migrations,name=cpu-migrations@
	Parsing metric events 'software/context-switches,name=context-switches,metric-id=software!3context!1switches!0name!2context!1switches!3/,software/page-faults,name=page-faults,metric-id=software!3page!1faults!0name!2page!1faults!3/,software/task-clock,name=task-clock,metric-id=software!3task!1clock!0name!2task!1clock!3/,cpu-cycles/metric-id=cpu!1cycles/,branches/metric-id=branches/,software/cpu-migrations,name=cpu-migrations,metric-id=software!3cpu!1migrations!0name!2cpu!1migrations!3/,duration_time'
	cpu-cycles -> armv8_pmuv3_0/metric-id=cpu!1cycles,cpu-cycles/
	branches -> armv8_pmuv3_0/metric-id=branches,branches/
	duration_time -> tool/duration_time/
	found event STALL_SLOT_FRONTEND
	found event duration_time
	found event BR_MIS_PRED
	found event CPU_CYCLES
	Parsing metric events '{STALL_SLOT_FRONTEND/metric-id=STALL_SLOT_FRONTEND/,BR_MIS_PRED/metric-id=BR_MIS_PRED/,CPU_CYCLES/metric-id=CPU_CYCLES/}:W,duration_time'
	STALL_SLOT_FRONTEND -> armv8_pmuv3_0/metric-id=STALL_SLOT_FRONTEND,STALL_SLOT_FRONTEND/
	BR_MIS_PRED -> armv8_pmuv3_0/metric-id=BR_MIS_PRED,BR_MIS_PRED/
	CPU_CYCLES -> armv8_pmuv3_0/metric-id=CPU_CYCLES,CPU_CYCLES/
	duration_time -> tool/duration_time/
	Matched metric-id STALL_SLOT_FRONTEND to STALL_SLOT_FRONTEND
	Matched metric-id BR_MIS_PRED to BR_MIS_PRED
	Matched metric-id CPU_CYCLES to CPU_CYCLES
	Matched metric-id duration_time to duration_time
	found event STALL_SLOT_BACKEND
	found event duration_time
	found event BR_MIS_PRED
	found event CPU_CYCLES
	Parsing metric events '{STALL_SLOT_BACKEND/metric-id=STALL_SLOT_BACKEND/,BR_MIS_PRED/metric-id=BR_MIS_PRED/,CPU_CYCLES/metric-id=CPU_CYCLES/}:W,duration_time'
	STALL_SLOT_BACKEND -> armv8_pmuv3_0/metric-id=STALL_SLOT_BACKEND,STALL_SLOT_BACKEND/
	BR_MIS_PRED -> armv8_pmuv3_0/metric-id=BR_MIS_PRED,BR_MIS_PRED/
	CPU_CYCLES -> armv8_pmuv3_0/metric-id=CPU_CYCLES,CPU_CYCLES/
	duration_time -> tool/duration_time/
	Matched metric-id STALL_SLOT_BACKEND to STALL_SLOT_BACKEND
	Matched metric-id BR_MIS_PRED to BR_MIS_PRED
	Matched metric-id CPU_CYCLES to CPU_CYCLES
	Matched metric-id duration_time to duration_time
	found event duration_time
	found event stalled-cycles-backend
	found event instructions
	found event stalled-cycles-frontend
	Parsing metric events '{stalled-cycles-backend/metric-id=stalled!1cycles!1backend/,instructions/metric-id=instructions/,stalled-cycles-frontend/metric-id=stalled!1cycles!1frontend/}:W,duration_time'
	stalled-cycles-backend -> armv8_pmuv3_0/metric-id=stalled!1cycles!1backend,stalled-cycles-backend/
	instructions -> armv8_pmuv3_0/metric-id=instructions,instructions/
	stalled-cycles-frontend -> armv8_pmuv3_0/metric-id=stalled!1cycles!1frontend,stalled-cycles-frontend/
	duration_time -> tool/duration_time/
	Matched metric-id stalled-cycles-backend to stalled-cycles-backend
	Matched metric-id instructions to instructions
	Matched metric-id stalled-cycles-frontend to stalled-cycles-frontend
	Matched metric-id duration_time to duration_time
	Matched metric-id software@page-faults,name=page-faults@ to page-faults
	Matched metric-id software@task-clock,name=task-clock@ to task-clock
	Matched metric-id software@task-clock,name=task-clock@ to task-clock
	Matched metric-id software@cpu-migrations,name=cpu-migrations@ to cpu-migrations
	found event duration_time
	found event cpu-cycles
	found event instructions
	Parsing metric events '{cpu-cycles/metric-id=cpu!1cycles/,instructions/metric-id=instructions/}:W,duration_time'
	cpu-cycles -> armv8_pmuv3_0/metric-id=cpu!1cycles,cpu-cycles/
	instructions -> armv8_pmuv3_0/metric-id=instructions,instructions/
	duration_time -> tool/duration_time/
	Matched metric-id cpu-cycles to cpu-cycles
	Matched metric-id instructions to instructions
	Matched metric-id duration_time to duration_time
	found event duration_time
	found event cpu-cycles
	found event stalled-cycles-frontend
	Parsing metric events '{cpu-cycles/metric-id=cpu!1cycles/,stalled-cycles-frontend/metric-id=stalled!1cycles!1frontend/}:W,duration_time'
	cpu-cycles -> armv8_pmuv3_0/metric-id=cpu!1cycles,cpu-cycles/
	stalled-cycles-frontend -> armv8_pmuv3_0/metric-id=stalled!1cycles!1frontend,stalled-cycles-frontend/
	duration_time -> tool/duration_time/
	Matched metric-id cpu-cycles to cpu-cycles
	Matched metric-id stalled-cycles-frontend to stalled-cycles-frontend
	Matched metric-id duration_time to duration_time
	Matched metric-id software@task-clock,name=task-clock@ to task-clock
	Matched metric-id cpu-cycles to cpu-cycles
	Matched metric-id software@context-switches,name=context-switches@ to context-switches
	Matched metric-id software@task-clock,name=task-clock@ to task-clock
	found event duration_time
	found event branch-misses
	found event branches
	Parsing metric events '{branch-misses/metric-id=branch!1misses/,branches/metric-id=branches/}:W,duration_time'
	branch-misses -> armv8_pmuv3_0/metric-id=branch!1misses,branch-misses/
	branches -> armv8_pmuv3_0/metric-id=branches,branches/
	duration_time -> tool/duration_time/
	Matched metric-id branch-misses to branch-misses
	Matched metric-id branches to branches
	Matched metric-id duration_time to duration_time
	Matched metric-id software@task-clock,name=task-clock@ to task-clock
	Matched metric-id branches to branches
	found event duration_time
	found event cpu-cycles
	found event stalled-cycles-backend
	Parsing metric events '{cpu-cycles/metric-id=cpu!1cycles/,stalled-cycles-backend/metric-id=stalled!1cycles!1backend/}:W,duration_time'
	cpu-cycles -> armv8_pmuv3_0/metric-id=cpu!1cycles,cpu-cycles/
	stalled-cycles-backend -> armv8_pmuv3_0/metric-id=stalled!1cycles!1backend,stalled-cycles-backend/
	duration_time -> tool/duration_time/
	Matched metric-id cpu-cycles to cpu-cycles
	Matched metric-id stalled-cycles-backend to stalled-cycles-backend
	Matched metric-id duration_time to duration_time
	Matched metric-id software@task-clock,name=task-clock@ to task-clock
	Matched metric-id duration_time to duration_time
	copying metric event for cgroup 'root': context-switches (idx=0)
	copying metric event for cgroup 'root': page-faults (idx=1)
	copying metric event for cgroup 'root': task-clock (idx=2)
	copying metric event for cgroup 'root': cpu-cycles (idx=3)
	copying metric event for cgroup 'root': branches (idx=4)
	copying metric event for cgroup 'root': cpu-migrations (idx=5)
	copying metric event for cgroup 'root': STALL_SLOT_FRONTEND (idx=7)
	copying metric event for cgroup 'root': stalled-cycles-backend (idx=29)
	copying metric event for cgroup 'root': STALL_SLOT_BACKEND (idx=11)
	copying metric event for cgroup 'root': stalled-cycles-backend (idx=15)
	copying metric event for cgroup 'root': instructions (idx=20)
	copying metric event for cgroup 'root': stalled-cycles-frontend (idx=23)
	copying metric event for cgroup 'root': branch-misses (idx=25)
	copying metric event for cgroup 'root': context-switches (idx=6)
	copying metric event for cgroup 'root': page-faults (idx=8)
	copying metric event for cgroup 'root': task-clock (idx=9)
	copying metric event for cgroup 'root': cpu-cycles (idx=13)
	copying metric event for cgroup 'root': branches (idx=12)
	copying metric event for cgroup 'root': cpu-migrations (idx=7)
	copying metric event for cgroup 'root': STALL_SLOT_FRONTEND (idx=25)
	copying metric event for cgroup 'root': stalled-cycles-backend (idx=19)
	copying metric event for cgroup 'root': STALL_SLOT_BACKEND (idx=29)
	copying metric event for cgroup 'root': stalled-cycles-backend (idx=20)
	copying metric event for cgroup 'root': instructions (idx=15)
	copying metric event for cgroup 'root': stalled-cycles-frontend (idx=17)
	copying metric event for cgroup 'root': branch-misses (idx=10)
	Control descriptor is not initialized
	perf: util/evsel.c:2034: get_group_fd: Assertion `!(!leader->core.fd)' failed.
	[1]    832866 IOT instruction (core dumped)  ./tools/perf/perf stat -v sleep 0.01


> The PMUs for cpu-cycles and stalled-cycles differ? This may mean we
> also need to be smarting in determining PMUs for legacy events.
> 
> It'd be interesting to see what events are coming from the kernel, e.g.:
> ```
> $ ls /sys/bus/event_source/devices/*/events

# ls /sys/bus/event_source/devices/*/events
	/sys/bus/event_source/devices/armv8_pmuv3_0/events:
	br_mis_pred          cti_trigout7        l1d_tlb_refill      l2d_tlb_refill         mem_access_checked_wr  stall_backend_mem
	br_mis_pred_retired  dtlb_walk           l1i_cache           l3d_cache              memory_error           stall_frontend
	br_pred              exc_return          l1i_cache_lmiss     l3d_cache_allocate     op_retired             stall_slot
	br_retired           exc_taken           l1i_cache_refill    l3d_cache_lmiss_rd     op_spec                stall_slot_backend
	bus_access           inst_retired        l1i_tlb             l3d_cache_refill       remote_access          stall_slot_frontend
	bus_cycles           inst_spec           l1i_tlb_refill      ld_align_lat           sample_collision       trb_wrap
	cid_write_retired    itlb_walk           l2d_cache           ldst_align_lat         sample_feed            trcextout0
	cnt_cycles           l1d_cache           l2d_cache_allocate  ll_cache_miss_rd       sample_filtrate        trcextout1
	cpu_cycles           l1d_cache_lmiss_rd  l2d_cache_lmiss_rd  ll_cache_rd            sample_pop             trcextout2
	cti_trigout4         l1d_cache_refill    l2d_cache_refill    mem_access             st_align_lat           trcextout3
	cti_trigout5         l1d_cache_wb        l2d_cache_wb        mem_access_checked     stall                  ttbr_write_retired
	cti_trigout6         l1d_tlb             l2d_tlb             mem_access_checked_rd  stall_backend

	/sys/bus/event_source/devices/cs_etm/events:
	autofdo

	/sys/bus/event_source/devices/nvidia_cnvlink_pmu_0/events:
	cycles        rd_bytes_rem     rd_cum_outs_rem  rd_req_rem       total_bytes_rem  total_req_rem  wr_bytes_rem  wr_req_rem
	rd_bytes_loc  rd_cum_outs_loc  rd_req_loc       total_bytes_loc  total_req_loc    wr_bytes_loc   wr_req_loc

	/sys/bus/event_source/devices/nvidia_nvlink_c2c0_pmu_0/events:
	cycles        rd_bytes_rem     rd_cum_outs_rem  rd_req_rem       total_bytes_rem  total_req_rem  wr_bytes_rem  wr_req_rem
	rd_bytes_loc  rd_cum_outs_loc  rd_req_loc       total_bytes_loc  total_req_loc    wr_bytes_loc   wr_req_loc

	/sys/bus/event_source/devices/nvidia_nvlink_c2c1_pmu_0/events:
	cycles        rd_bytes_rem     rd_cum_outs_rem  rd_req_rem       total_bytes_rem  total_req_rem  wr_bytes_rem  wr_req_rem
	rd_bytes_loc  rd_cum_outs_loc  rd_req_loc       total_bytes_loc  total_req_loc    wr_bytes_loc   wr_req_loc

	/sys/bus/event_source/devices/nvidia_pcie_pmu_0/events:
	cycles        rd_bytes_rem     rd_cum_outs_rem  rd_req_rem       total_bytes_rem  total_req_rem  wr_bytes_rem  wr_req_rem
	rd_bytes_loc  rd_cum_outs_loc  rd_req_loc       total_bytes_loc  total_req_loc    wr_bytes_loc   wr_req_loc

	/sys/bus/event_source/devices/nvidia_scf_pmu_0/events:
	bus_cycles           gmem_rd_data                  scf_cache                socket_1_rd_access       socket_2_wb_data
	cmem_rd_access       gmem_rd_outstanding           scf_cache_allocate       socket_1_rd_data         socket_2_wr_access
	cmem_rd_data         gmem_wb_access                scf_cache_refill         socket_1_rd_outstanding  socket_2_wr_data
	cmem_rd_outstanding  gmem_wb_data                  scf_cache_wb             socket_1_wb_access       socket_3_rd_access
	cmem_wb_access       gmem_wr_access                socket_0_rd_access       socket_1_wb_data         socket_3_rd_data
	cmem_wb_data         gmem_wr_data                  socket_0_rd_data         socket_1_wr_access       socket_3_rd_outstanding
	cmem_wr_access       gmem_wr_total_bytes           socket_0_rd_outstanding  socket_1_wr_data         socket_3_wb_access
	cmem_wr_data         remote_socket_rd_access       socket_0_wb_access       socket_2_rd_access       socket_3_wb_data
	cmem_wr_total_bytes  remote_socket_rd_data         socket_0_wb_data         socket_2_rd_data         socket_3_wr_access
	cycles               remote_socket_rd_outstanding  socket_0_wr_access       socket_2_rd_outstanding  socket_3_wr_data
	gmem_rd_access       remote_socket_wr_total_bytes  socket_0_wr_data         socket_2_wb_access

	/sys/bus/event_source/devices/smmuv3_pmcg_11002/events:
	config_cache_miss  config_struct_access  cycles  pcie_ats_trans_rq  tlb_miss  transaction  trans_table_walk_access

	/sys/bus/event_source/devices/smmuv3_pmcg_11042/events:
	cycles  pcie_ats_trans_passed  tlb_miss  transaction

	/sys/bus/event_source/devices/smmuv3_pmcg_11062/events:
	cycles  pcie_ats_trans_passed  tlb_miss  transaction

	/sys/bus/event_source/devices/smmuv3_pmcg_11082/events:
	cycles  pcie_ats_trans_passed  tlb_miss  transaction

	/sys/bus/event_source/devices/smmuv3_pmcg_110a2/events:
	cycles  pcie_ats_trans_passed  tlb_miss  transaction

	/sys/bus/event_source/devices/smmuv3_pmcg_12002/events:
	config_cache_miss  config_struct_access  cycles  pcie_ats_trans_rq  tlb_miss  transaction  trans_table_walk_access

	/sys/bus/event_source/devices/smmuv3_pmcg_12042/events:
	cycles  pcie_ats_trans_passed  tlb_miss  transaction

	/sys/bus/event_source/devices/smmuv3_pmcg_12062/events:
	cycles  pcie_ats_trans_passed  tlb_miss  transaction

	/sys/bus/event_source/devices/smmuv3_pmcg_12082/events:
	cycles  pcie_ats_trans_passed  tlb_miss  transaction

	/sys/bus/event_source/devices/smmuv3_pmcg_120a2/events:
	cycles  pcie_ats_trans_passed  tlb_miss  transaction

	/sys/bus/event_source/devices/smmuv3_pmcg_15002/events:
	config_cache_miss  config_struct_access  cycles  pcie_ats_trans_rq  tlb_miss  transaction  trans_table_walk_access

	/sys/bus/event_source/devices/smmuv3_pmcg_15042/events:
	cycles  pcie_ats_trans_passed  tlb_miss  transaction

	/sys/bus/event_source/devices/smmuv3_pmcg_15062/events:
	cycles  pcie_ats_trans_passed  tlb_miss  transaction

	/sys/bus/event_source/devices/smmuv3_pmcg_15082/events:
	cycles  pcie_ats_trans_passed  tlb_miss  transaction

	/sys/bus/event_source/devices/smmuv3_pmcg_150a2/events:
	cycles  pcie_ats_trans_passed  tlb_miss  transaction

	/sys/bus/event_source/devices/smmuv3_pmcg_16002/events:
	config_cache_miss  config_struct_access  cycles  pcie_ats_trans_rq  tlb_miss  transaction  trans_table_walk_access

	/sys/bus/event_source/devices/smmuv3_pmcg_16042/events:
	cycles  pcie_ats_trans_passed  tlb_miss  transaction

	/sys/bus/event_source/devices/smmuv3_pmcg_16062/events:
	cycles  pcie_ats_trans_passed  tlb_miss  transaction

	/sys/bus/event_source/devices/smmuv3_pmcg_5002/events:
	config_cache_miss  config_struct_access  cycles  pcie_ats_trans_rq  tlb_miss  transaction  trans_table_walk_access

	/sys/bus/event_source/devices/smmuv3_pmcg_5042/events:
	cycles  pcie_ats_trans_passed  tlb_miss  transaction

	/sys/bus/event_source/devices/smmuv3_pmcg_5062/events:
	cycles  pcie_ats_trans_passed  tlb_miss  transaction


> ```
> and the cpuid to match it up with the json.
> ```
> $ perf stat -v sleep 1 2>&1 |head -1

	# perf stat -v sleep 1 2>&1 |head -1
	Using CPUID 0x00000000410fd4f0

> this information is in the verbose output too:
> ```
> $ perf stat -vv sleep 1

	------------------------------------------------------------
	perf_event_attr:
	type                             4294967294 (tool)
	size                             144
	config                           0x1 (duration_time)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
	disabled                         1
	inherit                          1
	enable_on_exec                   1
	------------------------------------------------------------
	------------------------------------------------------------
	perf_event_attr:
	type                             4294967294 (tool)
	size                             144
	config                           0x1 (duration_time)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
	disabled                         1
	inherit                          1
	enable_on_exec                   1
	------------------------------------------------------------
	------------------------------------------------------------
	perf_event_attr:
	type                             4294967294 (tool)
	size                             144
	config                           0x1 (duration_time)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
	disabled                         1
	inherit                          1
	enable_on_exec                   1
	------------------------------------------------------------
	------------------------------------------------------------
	perf_event_attr:
	type                             4294967294 (tool)
	size                             144
	config                           0x1 (duration_time)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
	disabled                         1
	inherit                          1
	enable_on_exec                   1
	------------------------------------------------------------
	------------------------------------------------------------
	perf_event_attr:
	type                             4294967294 (tool)
	size                             144
	config                           0x1 (duration_time)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
	disabled                         1
	inherit                          1
	enable_on_exec                   1
	------------------------------------------------------------
	------------------------------------------------------------
	perf_event_attr:
	type                             4294967294 (tool)
	size                             144
	config                           0x1 (duration_time)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
	disabled                         1
	inherit                          1
	enable_on_exec                   1
	------------------------------------------------------------
	------------------------------------------------------------
	perf_event_attr:
	type                             1 (PERF_TYPE_SOFTWARE)
	size                             144
	config                           0x3 (PERF_COUNT_SW_CONTEXT_SWITCHES)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
	disabled                         1
	inherit                          1
	enable_on_exec                   1
	------------------------------------------------------------
	sys_perf_event_open: pid 865887  cpu -1  group_fd -1  flags 0x8 = 3
	------------------------------------------------------------
	perf_event_attr:
	type                             1 (PERF_TYPE_SOFTWARE)
	size                             144
	config                           0x4 (PERF_COUNT_SW_CPU_MIGRATIONS)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
	disabled                         1
	inherit                          1
	enable_on_exec                   1
	------------------------------------------------------------
	sys_perf_event_open: pid 865887  cpu -1  group_fd -1  flags 0x8 = 4
	------------------------------------------------------------
	perf_event_attr:
	type                             1 (PERF_TYPE_SOFTWARE)
	size                             144
	config                           0x2 (PERF_COUNT_SW_PAGE_FAULTS)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
	disabled                         1
	inherit                          1
	enable_on_exec                   1
	------------------------------------------------------------
	sys_perf_event_open: pid 865887  cpu -1  group_fd -1  flags 0x8 = 5
	------------------------------------------------------------
	perf_event_attr:
	type                             1 (PERF_TYPE_SOFTWARE)
	size                             144
	config                           0x1 (PERF_COUNT_SW_TASK_CLOCK)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
	disabled                         1
	inherit                          1
	enable_on_exec                   1
	------------------------------------------------------------
	sys_perf_event_open: pid 865887  cpu -1  group_fd -1  flags 0x8 = 7
	------------------------------------------------------------
	perf_event_attr:
	type                             0 (PERF_TYPE_HARDWARE)
	size                             144
	config                           0x5 (PERF_COUNT_HW_BRANCH_MISSES)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
	disabled                         1
	inherit                          1
	enable_on_exec                   1
	------------------------------------------------------------
	sys_perf_event_open: pid 865887  cpu -1  group_fd -1  flags 0x8 = 8
	------------------------------------------------------------
	perf_event_attr:
	type                             0 (PERF_TYPE_HARDWARE)
	size                             144
	config                           0x4 (PERF_COUNT_HW_BRANCH_INSTRUCTIONS)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
	inherit                          1
	------------------------------------------------------------
	sys_perf_event_open: pid 865887  cpu -1  group_fd 8  flags 0x8 = 9
	------------------------------------------------------------
	perf_event_attr:
	type                             0 (PERF_TYPE_HARDWARE)
	size                             144
	config                           0x4 (PERF_COUNT_HW_BRANCH_INSTRUCTIONS)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
	disabled                         1
	inherit                          1
	enable_on_exec                   1
	------------------------------------------------------------
	sys_perf_event_open: pid 865887  cpu -1  group_fd -1  flags 0x8 = 10
	------------------------------------------------------------
	perf_event_attr:
	type                             0 (PERF_TYPE_HARDWARE)
	size                             144
	config                           0 (PERF_COUNT_HW_CPU_CYCLES)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
	disabled                         1
	inherit                          1
	enable_on_exec                   1
	------------------------------------------------------------
	sys_perf_event_open: pid 865887  cpu -1  group_fd -1  flags 0x8 = 11
	------------------------------------------------------------
	perf_event_attr:
	type                             0 (PERF_TYPE_HARDWARE)
	size                             144
	config                           0 (PERF_COUNT_HW_CPU_CYCLES)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
	disabled                         1
	inherit                          1
	enable_on_exec                   1
	------------------------------------------------------------
	sys_perf_event_open: pid 865887  cpu -1  group_fd -1  flags 0x8 = 12
	------------------------------------------------------------
	perf_event_attr:
	type                             0 (PERF_TYPE_HARDWARE)
	size                             144
	config                           0x1 (PERF_COUNT_HW_INSTRUCTIONS)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
	inherit                          1
	------------------------------------------------------------
	sys_perf_event_open: pid 865887  cpu -1  group_fd 12  flags 0x8 = 13
	------------------------------------------------------------
	perf_event_attr:
	type                             0 (PERF_TYPE_HARDWARE)
	size                             144
	config                           0 (PERF_COUNT_HW_CPU_CYCLES)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
	disabled                         1
	inherit                          1
	enable_on_exec                   1
	------------------------------------------------------------
	sys_perf_event_open: pid 865887  cpu -1  group_fd -1  flags 0x8 = 14
	------------------------------------------------------------
	perf_event_attr:
	type                             0 (PERF_TYPE_HARDWARE)
	size                             144
	config                           0x7 (PERF_COUNT_HW_STALLED_CYCLES_FRONTEND)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
	inherit                          1
	------------------------------------------------------------
	sys_perf_event_open: pid 865887  cpu -1  group_fd 14  flags 0x8 = 15
	------------------------------------------------------------
	perf_event_attr:
	type                             0 (PERF_TYPE_HARDWARE)
	size                             144
	config                           0 (PERF_COUNT_HW_CPU_CYCLES)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
	disabled                         1
	inherit                          1
	enable_on_exec                   1
	------------------------------------------------------------
	sys_perf_event_open: pid 865887  cpu -1  group_fd -1  flags 0x8 = 16
	------------------------------------------------------------
	perf_event_attr:
	type                             0 (PERF_TYPE_HARDWARE)
	size                             144
	config                           0x8 (PERF_COUNT_HW_STALLED_CYCLES_BACKEND)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
	inherit                          1
	------------------------------------------------------------
	sys_perf_event_open: pid 865887  cpu -1  group_fd 16  flags 0x8 = 17
	------------------------------------------------------------
	perf_event_attr:
	type                             0 (PERF_TYPE_HARDWARE)
	size                             144
	config                           0x8 (PERF_COUNT_HW_STALLED_CYCLES_BACKEND)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
	disabled                         1
	inherit                          1
	enable_on_exec                   1
	------------------------------------------------------------
	sys_perf_event_open: pid 865887  cpu -1  group_fd -1  flags 0x8 = 18
	------------------------------------------------------------
	perf_event_attr:
	type                             0 (PERF_TYPE_HARDWARE)
	size                             144
	config                           0x1 (PERF_COUNT_HW_INSTRUCTIONS)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
	inherit                          1
	------------------------------------------------------------
	sys_perf_event_open: pid 865887  cpu -1  group_fd 18  flags 0x8 = 19
	------------------------------------------------------------
	perf_event_attr:
	type                             0 (PERF_TYPE_HARDWARE)
	size                             144
	config                           0x7 (PERF_COUNT_HW_STALLED_CYCLES_FRONTEND)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
	inherit                          1
	------------------------------------------------------------
	sys_perf_event_open: pid 865887  cpu -1  group_fd 18  flags 0x8 = 20
	------------------------------------------------------------
	perf_event_attr:
	type                             4294967294 (tool)
	size                             144
	config                           0x1 (duration_time)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
	disabled                         1
	inherit                          1
	enable_on_exec                   1
	------------------------------------------------------------
	------------------------------------------------------------
	perf_event_attr:
	type                             4294967294 (tool)
	size                             144
	config                           0x1 (duration_time)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
	disabled                         1
	inherit                          1
	enable_on_exec                   1
	------------------------------------------------------------
	------------------------------------------------------------
	perf_event_attr:
	type                             4294967294 (tool)
	size                             144
	config                           0x1 (duration_time)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
	disabled                         1
	inherit                          1
	enable_on_exec                   1
	------------------------------------------------------------
	------------------------------------------------------------
	perf_event_attr:
	type                             4294967294 (tool)
	size                             144
	config                           0x1 (duration_time)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
	disabled                         1
	inherit                          1
	enable_on_exec                   1
	------------------------------------------------------------
	------------------------------------------------------------
	perf_event_attr:
	type                             10 (armv8_pmuv3_0)
	size                             144
	config                           0x10 (br_mis_pred)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
	disabled                         1
	inherit                          1
	enable_on_exec                   1
	------------------------------------------------------------
	sys_perf_event_open: pid 865887  cpu -1  group_fd -1  flags 0x8 = 21
	------------------------------------------------------------
	perf_event_attr:
	type                             10 (armv8_pmuv3_0)
	size                             144
	config                           0x3b (op_spec)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
	inherit                          1
	------------------------------------------------------------
	sys_perf_event_open: pid 865887  cpu -1  group_fd 21  flags 0x8 = 22
	------------------------------------------------------------
	perf_event_attr:
	type                             10 (armv8_pmuv3_0)
	size                             144
	config                           0x3f (stall_slot)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
	inherit                          1
	------------------------------------------------------------
	sys_perf_event_open: pid 865887  cpu -1  group_fd 21  flags 0x8 = 23
	------------------------------------------------------------
	perf_event_attr:
	type                             10 (armv8_pmuv3_0)
	size                             144
	config                           0x11 (cpu_cycles)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
	inherit                          1
	------------------------------------------------------------
	sys_perf_event_open: pid 865887  cpu -1  group_fd 21  flags 0x8 = 24
	------------------------------------------------------------
	perf_event_attr:
	type                             10 (armv8_pmuv3_0)
	size                             144
	config                           0x3a (op_retired)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
	inherit                          1
	------------------------------------------------------------
	sys_perf_event_open: pid 865887  cpu -1  group_fd 21  flags 0x8 = 25
	------------------------------------------------------------
	perf_event_attr:
	type                             10 (armv8_pmuv3_0)
	size                             144
	config                           0x11 (cpu_cycles)
	sample_type                      IDENTIFIER
	read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
	inherit                          1
	------------------------------------------------------------

Thanks for your help,
--breno
