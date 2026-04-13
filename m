Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE3438F94E;
	Mon, 13 Apr 2026 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776106706; cv=none; b=Ah8cQLORxmh/9+vo4Y4yz5eR9qbVTE9ZdyoTV+HlEX4OYLWrGNMi0eVj3XgzNy2wW61kWa5Yn39LCk0i6vGdzU2NV3KcCCj/xsM7rTKmMvRwkRlXvXF+kgiit5zyYDKd3RZZ+xmoBqtIeyg5RFUewqd1jF3hIKK994Jb7kXLdnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776106706; c=relaxed/simple;
	bh=oWNqShly/dKLm6QH9Zz4OONYsqdxohN3rWDpuNVVnD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZ1nuNywB63jVrDeOyu6HH11tD8qpITJ5EfsvAfvGVDADFbdnaqkmXbzYlTtNWP656wrWtqhOZRTWiupI6KULlddIFQaZt0JLmPVXYbqKy/5EBTQ+gybScsMyuyuTWHRVwqb47k84zm0mrv8G3asRjfKrNqaW/hAcdupyYGUI/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hK8Vv8mF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hK8Vv8mF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064C5C2BCAF;
	Mon, 13 Apr 2026 18:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776106706;
	bh=oWNqShly/dKLm6QH9Zz4OONYsqdxohN3rWDpuNVVnD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hK8Vv8mFgWDEIp9XPGid+4bIdY5R6vAfgVzhC5yYWCbpVPhECmnS2bvbCv5BxyxdM
	 usE7681SvMHyn2wOlNh3VFVCVLOrfc/Xe4wGG+8t4pQZ4g0yMwHEhMXe2YsTQHHrTM
	 z7MP/uKNR0Geo2pb9YqogClOhStG9iRjwNXtC35CdomBUpIKpLOFfmpYKmLLefDPvr
	 QQH3P+VBHZNeZFJzGesa6y28nsQMuRDln61sGFocqRxejcgoUBH4plyc4bjsBAb3o0
	 qOtWLEc091pg2B6yGz7Hdes+cNQJCLpFlpXyrsFZQu4jh/cdU1D6HsI5z42lA5CtTX
	 CvQVceOLPneqQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Leo Yan <leo.yan@arm.com>,
	Rob Herring <robh@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Stephane Eranian <eranian@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Usama Arif <usama.arif@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 1/4] perf/core: Fix NULL pmu_ctx passed to PMU sched_task callback
Date: Mon, 13 Apr 2026 11:57:20 -0700
Message-ID: <20260413185740.3286146-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413185740.3286146-1-puranjay@kernel.org>
References: <20260413185740.3286146-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__perf_pmu_sched_task() passes cpc->task_epc to pmu->sched_task(),
which is NULL when no per-task events exist for this PMU. With CPU-wide
branch-stack events, PMU callbacks that dereference pmu_ctx crash.

On ARM64 this is easily triggered with:

  perf record -b -e cycles -a -- ls

which crashes on the first context switch:

  Unable to handle kernel NULL pointer dereference at virtual address 00[.]
  PC is at armv8pmu_sched_task+0x14/0x50
  Call trace:
    armv8pmu_sched_task+0x14/0x50 (P)
    perf_pmu_sched_task+0xac/0x108
    __perf_event_task_sched_out+0x6c/0xe0

Fall back to &cpc->epc when cpc->task_epc is NULL so the callback
always receives a valid pmu_ctx.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1f5699b339ec..2a8fb78e1347 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3906,7 +3906,8 @@ static void __perf_pmu_sched_task(struct perf_cpu_pmu_context *cpc,
 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 	perf_pmu_disable(pmu);
 
-	pmu->sched_task(cpc->task_epc, task, sched_in);
+	pmu->sched_task(cpc->task_epc ? cpc->task_epc : &cpc->epc,
+			task, sched_in);
 
 	perf_pmu_enable(pmu);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
-- 
2.52.0

