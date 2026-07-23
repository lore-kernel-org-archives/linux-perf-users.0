Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B8E480340;
	Thu, 23 Jul 2026 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784808869; cv=none; b=tnXaRJcZkPikqgTAtubmG7woPUJT7BOzbJI0/Z1cod2IiUqczweTsE3tKao2F7VzgM0OwTOiorRm4aFVwmeN51W5tR3whMpkpiIt1oedycbWUM7s/YHuHzHk2CtGS/2niFHLE5cSLAQNC985uPHTYFbnhNsO4dX/nEDUDNy9+18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784808869; c=relaxed/simple;
	bh=cVetfgDvak7Vk5o1i8+aNk/MvoAHWLIff5wN4eKnAzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2NjnhV/Z1nvetVe7fFzT4wwkQ8ErEhqtn/09CTkSgvEih5P3lcWnjnCB2w5LflSrUG0W9UO55hcy5cgdseKYdmEzwEmWlsiSyOmuQkatLh63X1Xgs8dBOnUOJo8WDwhN05brNviA4qPUPZZBZsNOKaWMLkgU7rhisslcp8+RAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wtNxnFBb; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wtNxnFBb"
Message-ID: <c9e0ec43-5906-43e2-a674-589117d44ce6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784808862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HqzpRenBrC0k573Xz55iMUEOlsnWt7HrE0/NCI0Oux4=;
	b=wtNxnFBbvRysCrVy7Zn+LE1e5eZ/6vy0CWb31IiOnUJOAXHkpwaYeNLv6bnnw4PBachhtk
	48gIzVlZ8lmhK/QQiBO0C9yhjGyP2dTFK1vdpbvj6vDcOBBoc14qAKL93H1Le88reQgaOv
	Fiwhz1foGDDP6K6bf5maTTfCyyy0pIc=
Date: Thu, 23 Jul 2026 13:14:03 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/4] perf/core: Fix sched_task callbacks for CPU-wide
 branch stack events
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Leo Yan <leo.yan@arm.com>,
 Rob Herring <robh@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@linaro.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Shuah Khan <shuah@kernel.org>, Breno Leitao <leitao@debian.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>, Stephane Eranian
 <eranian@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
References: <20260616155716.2631508-1-puranjay@kernel.org>
 <20260616155716.2631508-2-puranjay@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260616155716.2631508-2-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 16/06/2026 16:57, Puranjay Mohan wrote:
> perf_pmu_sched_task() returns early when cpuctx->task_ctx is non-NULL,
> deferring to perf_ctx_sched_task_cb() in the context sched_in/out
> paths. But perf_ctx_sched_task_cb() only walks the task context's
> pmu_ctx_list -- PMUs that have only CPU-wide events are not on that
> list and their sched_task callback is silently skipped.
> 
> On ARM64 with CPU-wide branch recording:
> 
>   perf record -b -e cycles -a -- ls
> 
> armv8pmu_sched_task() is skipped whenever the scheduled task has an
> unrelated perf event (e.g. a software event), and branch records leak
> across task boundaries.
> 
> A second problem exists in __perf_pmu_sched_task(): it passes
> cpc->task_epc directly to pmu->sched_task(), but task_epc is NULL for
> PMUs with only CPU-wide events. When perf_pmu_sched_task() does reach
> the loop (because cpuctx->task_ctx is NULL), this causes a NULL
> pointer dereference:
> 
>   Unable to handle kernel NULL pointer dereference at virtual address 00[.]
>   PC is at armv8pmu_sched_task+0x14/0x50
>   Call trace:
>     armv8pmu_sched_task+0x14/0x50 (P)
>     perf_pmu_sched_task+0xac/0x108
>     __perf_event_task_sched_out+0x6c/0xe0
> 
> Fix both:
> 
>  - Remove the blanket early return in perf_pmu_sched_task() when
>    cpuctx->task_ctx is set. Instead, skip individual CPCs that have a
>    task_epc (those are handled by perf_ctx_sched_task_cb()). CPCs
>    without a task_epc are CPU-only and must be handled here.
> 
>  - Fall back to &cpc->epc in __perf_pmu_sched_task() when task_epc is
>    NULL, so the callback always gets a valid pmu_ctx.
> 
> Fixes: bd2756811766 ("perf: Rewrite core context handling")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/events/core.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
Acked-by: Usama Arif <usama.arif@linux.dev>

