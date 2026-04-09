Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88330175A93;
	Thu,  9 Apr 2026 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775733898; cv=none; b=GeHlTzlabMV9XE32mAhk+EYJ45CQ08ne4fn49cBf5Xo5ZYOe7MDM7ybNukV9CGl/DSf5litBj5wB2/1nrxFinqHn3BS5cQzgRy0UZCbWndhr8jl6L3W1kem/RMAv2XmAir6jf7TFSUU8sGMk+zmPKP0x4rRA3JEixXw8h8VDt20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775733898; c=relaxed/simple;
	bh=HW235KFpjxbKvTk+WbTpyUdPgeAVRwPuLJY5veTJkmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DinfLShIIwoVIwmMIS7SsJTTAJboL3lQ6q20/eZUaDUyspPrCEhCLcr4roHES4ElLnPZnMt49GdXUOS7sWFSbUtCjE5TTtexVfNG6fd7VFwiDLvA7HkENbKkDd6hT0Kcjl/de5cxFfZrAowlX6mhjONp4yKCarB9guroU8H84Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MgaSFhU9; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MgaSFhU9"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1818E2E98;
	Thu,  9 Apr 2026 04:24:50 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66E053F632;
	Thu,  9 Apr 2026 04:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775733895; bh=HW235KFpjxbKvTk+WbTpyUdPgeAVRwPuLJY5veTJkmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MgaSFhU9wXsL9zjTQF337jQVFlBf0oLy4vD54DYAxMiZy9QaQXdCtRRSM6lNzjm7F
	 3pcPS5GyUE9NXWHm2gnn0rw+TJ1T4Bmq9xK0TG3OI6zcbldMwhU5bNi3Gx0Fr7VC4r
	 2CSnXBKqomALzglM9nDb23FJC0vpiVkBJLUyM7G0=
Date: Thu, 9 Apr 2026 12:24:53 +0100
From: Leo Yan <leo.yan@arm.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Rob Herring <robh@kernel.org>, Breno Leitao <leitao@debian.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, kernel-team@meta.com,
	James Clark <James.Clark@arm.com>
Subject: Re: [PATCH v2 1/4] perf/arm_pmuv3: Fix NULL pointer dereference in
 armv8pmu_sched_task()
Message-ID: <20260409112453.GR356832@e132581.arm.com>
References: <20260318171706.2840512-1-puranjay@kernel.org>
 <20260318171706.2840512-2-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318171706.2840512-2-puranjay@kernel.org>

Hi Puranjay,

On Wed, Mar 18, 2026 at 10:16:55AM -0700, Puranjay Mohan wrote:
> This is easily triggered with:
> 
>   perf record -b -e cycles -a -- ls
> 
> which crashes on the first context switch with:
> 
>   Unable to handle kernel NULL pointer dereference at virtual address 00[.]
>   PC is at armv8pmu_sched_task+0x14/0x50
>   LR is at perf_pmu_sched_task+0xac/0x108
>   Call trace:
>     armv8pmu_sched_task+0x14/0x50 (P)
>     perf_pmu_sched_task+0xac/0x108
>     __perf_event_task_sched_out+0x6c/0xe0
>     prepare_task_switch+0x120/0x268
>     __schedule+0x1e8/0x828
>     ...
> 
> perf_pmu_sched_task() invokes the PMU sched callback with cpc->task_epc,
> which is NULL when no per-task events exist for this PMU. With CPU-wide
> branch-stack events, armv8pmu_sched_task() is still registered and
> dereferences pmu_ctx->pmu unconditionally, causing the crash.

Would not this is a bug in perf core layer that it should properly
pass &cpc->epc for CPU wide trace?

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 89b40e439717..a8cd0a26effa 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3906,7 +3906,8 @@ static void __perf_pmu_sched_task(struct perf_cpu_pmu_context *cpc,
        perf_ctx_lock(cpuctx, cpuctx->task_ctx);
        perf_pmu_disable(pmu);

-       pmu->sched_task(cpc->task_epc, task, sched_in);
+       pmu->sched_task(cpc->task_epc ? cpc->task_epc : &cpc->epc,
+                       task, sched_in);

        perf_pmu_enable(pmu);
        perf_ctx_unlock(cpuctx, cpuctx->task_ctx);


I checked other archs, most of them don't use the parameter *pmu_ctx
so the issue never hits.

My understanding is that for CPU-wide (or system-wide) tracing, we still
need to invalidate the branch record on a task switch so that a branch
stack is recorded within the same context.

Thanks,
Leo
