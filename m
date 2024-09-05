Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4EF17BEC2;
	Thu,  5 Sep 2024 19:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725564803; cv=none; b=ttuP13SS4+MHFIUhq/E0Q3NmXXqzjvs6IMRd9tB3O8nJNrd5ZHcAhuLSP5/PbbKo0mntKqdQbG9+whk3XYKHhiVmex+XifAyzryPw9OcDktayLeRRvvIw3BNHDX+TKuEpQ1xCz7X64hIJW5rwFBD9T7fY0+u0YC70Q17z+HAYGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725564803; c=relaxed/simple;
	bh=1Gb7mlQQcs+lT691cLTtVwzE4gzbaqdT7/AcIcL1fLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnIeE/U9YfoPUpp1uVL+f2UgYdSyXHoACcivoxiE2lp53IKh1foh+Abf7HCHcpuQSdGvzR+wHohC1a2VgL4GzmHNntC6V3DKKb15MMdEkKjpbSmnOXObgkkUw3ZTeKvbMJwomwcOKgff9u4y2IJ32RuH1V4szNVne2AnUGqiOZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzAW+8ue; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzAW+8ue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76E9C4CEC3;
	Thu,  5 Sep 2024 19:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725564803;
	bh=1Gb7mlQQcs+lT691cLTtVwzE4gzbaqdT7/AcIcL1fLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FzAW+8ueqSuSy/e62nUDbf3IVyYsvCngfOJiopPZb2CVZ20ZbHi078/xnlK1ZuhD5
	 b7CRW0C1QZKqSHyEN89N6HgbxqfYIea5H/8q31+/Zw/NG7nOwHcnWJGZcFFibmIFGc
	 BFDsX5bGdklbVBIMIJB+D/9H4YoLqzQTC7/Q0Jl1xof+aVFCoiLx366IUEgBcCPm72
	 zRKbiexsG5KorI69jeWo2h+o5boxfcCaOghINFLxsiBcWrCd+6vcfSQ5kd+FLEHOvi
	 Xl2C4Now6hVTUT9YrePNgJy+iqNwxrkaeFh6nPUwh/7/ZFmG6+0PsZjHrk1EIhV9Rh
	 zHiH8N85rGkKg==
Date: Thu, 5 Sep 2024 16:33:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: kan.liang@linux.intel.com
Cc: namhyung@kernel.org, irogers@google.com, jolsa@kernel.org,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf mem: Fix missed p-core mem events on ADL and RPL
Message-ID: <ZtoHgMqNhnDdvAIi@x1>
References: <20240905170737.4070743-1-kan.liang@linux.intel.com>
 <20240905170737.4070743-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905170737.4070743-2-kan.liang@linux.intel.com>

On Thu, Sep 05, 2024 at 10:07:36AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The p-core mem events are missed when launching perf mem record on ADL
> and RPL.
> 
> root@number:~# perf mem record sleep 1
> Memory events are enabled on a subset of CPUs: 16-27
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.032 MB perf.data ]
> root@number:~# perf evlist
> cpu_atom/mem-loads,ldlat=30/P
> cpu_atom/mem-stores/P
> dummy:u
> 
> A variable 'record' in the struct perf_mem_event is to indicate whether
> a mem event in a mem_events[] should be recorded. The current code only
> configure the variable for the first eligible PMU. It's good enough for
> a non-hybrid machine or a hybrid machine which has the same
> mem_events[]. However, if a different mem_events[] is used for different
> PMUs on a hybrid machine, e.g., ADL or RPL, the 'record' for the second
> PMU never get a chance to be set. The mem_events[] of the second PMU
> are always ignored.
> 
> Perf mem doesn't support the per-PMU configuration now. A
> per-PMU mem_events[] 'record' variable doesn't make sense. Make it
> global. That could also avoid searching for the per-PMU mem_events[]
> via perf_pmu__mem_events_ptr every time.
> 
> Fixes: abbdd79b786e ("perf mem: Clean up perf_mem_events__name()")
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Closes: https://lore.kernel.org/lkml/Zthu81fA3kLC2CS2@x1/
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Looks better:

root@number:~# perf report --header-only | grep 'cmdline\|event'
# cmdline : /home/acme/bin/perf mem record ls 
# event : name = cpu_atom/mem-loads,ldlat=30/P, , id = { 500, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511 }, type = 10 (cpu_atom), size = 136, config = 0x5d0 (mem-loads), { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format = ID|LOST, disabled = 1, inherit = 1, freq = 1, enable_on_exec = 1, precise_ip = 3, sample_id_all = 1, { bp_addr, config1 } = 0x1f
# event : name = cpu_atom/mem-stores/P, , id = { 512, 513, 514, 515, 516, 517, 518, 519, 520, 521, 522, 523 }, type = 10 (cpu_atom), size = 136, config = 0x6d0 (mem-stores), { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format = ID|LOST, disabled = 1, inherit = 1, freq = 1, enable_on_exec = 1, precise_ip = 3, sample_id_all = 1
# event : name = cpu_core/mem-loads-aux/, , id = { 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539 }, type = 4 (cpu_core), size = 136, config = 0x8203 (mem-loads-aux), { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format = ID|LOST, disabled = 1, inherit = 1, freq = 1, enable_on_exec = 1, precise_ip = 3, sample_id_all = 1, exclude_guest = 1
# event : name = cpu_core/mem-loads,ldlat=30/, , id = { 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 551, 552, 553, 554, 555, 556 }, type = 4 (cpu_core), size = 136, config = 0x1cd (mem-loads), { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format = ID|LOST, inherit = 1, freq = 1, precise_ip = 2, sample_id_all = 1, exclude_guest = 1, { bp_addr, config1 } = 0x1f
# event : name = cpu_core/mem-stores/P, , id = { 557, 558, 559, 560, 561, 562, 563, 564, 565, 566, 567, 568, 569, 570, 571, 572 }, type = 4 (cpu_core), size = 136, config = 0x2cd (mem-stores), { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format = ID|LOST, disabled = 1, inherit = 1, freq = 1, enable_on_exec = 1, precise_ip = 3, sample_id_all = 1
# event : name = dummy:u, , id = { 573, 574, 575, 576, 577, 578, 579, 580, 581, 582, 583, 584, 585, 586, 587, 588, 589, 590, 591, 592, 593, 594, 595, 596, 597, 598, 599, 600 }, type = 1 (software), size = 136, config = 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq } = 1, sample_type = IP|TID|TIME|ADDR|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format = ID|LOST, inherit = 1, exclude_kernel = 1, exclude_hv = 1, mmap = 1, comm = 1, task = 1, mmap_data = 1, sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1, ksymbol = 1, bpf_event = 1
# intel_pt pmu capabilities: topa_multiple_entries=1, psb_cyc=1, single_range_output=1, mtc_periods=249, ip_filtering=1, output_subsys=0, cr3_filtering=1, psb_periods=3f, event_trace=0, cycle_thresholds=3f, power_event_trace=0, mtc=1, payloads_lip=0, ptwrite=1, num_address_ranges=2, max_subleaf=1, topa_output=1, tnt_disable=0
root@number:~# perf evlist
cpu_atom/mem-loads,ldlat=30/P
cpu_atom/mem-stores/P
cpu_core/mem-loads-aux/
cpu_core/mem-loads,ldlat=30/
cpu_core/mem-stores/P
dummy:u
root@number:~#

But can we reconstruct the events relationship (group, :S, etc) from
what we have in the perf.data header?

- Arnaldo
