Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691D2396D0C
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650997; cv=none; b=naVXaFGB08YdSjbpjqXU/pMDP7OC+OUIPOBfcA8ueKQ2X2UgxuroWoSm6yyVcuxLJ3y4Jt2tmy8dfRbK+Zz0jNDuO1MbeCPiuV1HWUhxzwkWUD3KB0Ib8RcW5GJ25ldXzQaQ9GBgxLNQdi5tTHM0OqL9mGnopDHL4XDCsLLmFp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650997; c=relaxed/simple;
	bh=9T1rvCsALxOjWeP00BekOMFYTLBXW8woYwqkRR3O9HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPTRMLxQsrHsd5/icVkImV6+jkvfLhZ2HJQn9iOTJPzyZJkoPxU4gdGtWYuJt8tAaPgh2L+nw1PgJyIycjbK5pD5uaX2nV50nO0ohWy4+8lvEESm6Y8NT16cmy42dGHbRSpX7IaZ9pYj+xL4TfUJ9+s2tmzfLaDZbqKkpnQPiVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WDPvh8oi; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WDPvh8oi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775650994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/FDyok7Gct/nyBOt42DC7zGYEhAt2O0xoN1lkGESnU=;
	b=WDPvh8oiXIk4D+Rc3p+YhpZYZr2VB7c2ClndCrhNwsArAe7+VxY2QFT+RWVRTBPPidKVsL
	gnp+yKgOZfQj0MEmTx8Lo9AYOpkpWW1LcXY75xzBhF4lyDiVllUmhYf0kBJVBr8fMxVMmO
	04ydKb8YW6/uj78GmiUorwvnTS1FHEc=
From: Usama Arif <usama.arif@linux.dev>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>,
	bpf@vger.kernel.org,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Leo Yan <leo.yan@arm.com>,
	Rob Herring <robh@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 1/4] perf/arm_pmuv3: Fix NULL pointer dereference in armv8pmu_sched_task()
Date: Wed,  8 Apr 2026 05:23:05 -0700
Message-ID: <20260408122307.1360475-1-usama.arif@linux.dev>
In-Reply-To: <20260318171706.2840512-2-puranjay@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Wed, 18 Mar 2026 10:16:55 -0700 Puranjay Mohan <puranjay@kernel.org> wrote:

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
> 
> The bug was introduced by commit fa9d27773873 ("perf: arm_pmu: Kill last
> use of per-CPU cpu_armpmu pointer") which changed the function from
> using the per-CPU cpu_armpmu pointer (always valid) to dereferencing
> pmu_ctx->pmu without adding a NULL check.
> 
> Add a NULL check for pmu_ctx to avoid the crash.
> 
> Fixes: fa9d27773873 ("perf: arm_pmu: Kill last use of per-CPU cpu_armpmu pointer")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  drivers/perf/arm_pmuv3.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 

Acked-by: Usama Arif <usama.arif@linux.dev>
