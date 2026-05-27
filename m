Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08BF3F789C;
	Wed, 27 May 2026 12:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883962; cv=none; b=P9s6bzFGJPfR6kYBmSNUApf/apRUo97X313UQk33lIixETJIHQVrQ6qKCv7fkvLu9Q4spJoRuzF5GH9NBXns50/UllSEDBDWODVqMTQnJwllsCqPkS8TM/CUJ9lyHNb3DVJNIx6N2F1SchRhQe77CVW2J1H78UV9JayMooQ5bhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883962; c=relaxed/simple;
	bh=h3ExjGlQ/IfRfWlCDyhOHXurhQr8Q4T+X+082Em90IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9MI6QXLSPWlyZQuOBV5HjLexkU6KAFUnedJVlV+3c2Fu6nl/UL3Kg8aLB7PdEUSuNDQX5tgs7MEOmL6z+/MN00jEEI8SNQuX5veIsO3crUPajELN3eUeIl27xSOzoojI84n+LglR5IytOgleOezxZtMjdaxncEoIJ9lvaZv97s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfwtHf0f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfwtHf0f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2601F00A3A;
	Wed, 27 May 2026 12:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779883958;
	bh=Gvz8PiwvGk6Y72u5ZGZh0QDA7xEjtRQQxZQEXXA8yJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YfwtHf0fCRwSCsi0j+YSaW/YJZ2YIrGStbHkIksFR7bUuKI0CBtGimWacS+sceB0v
	 3RA84khyfuBEAr35jrluhAudumFm5x4Js412+QPGwuRrWKbO/k1CaPCtlHOM+ZG6Lj
	 ouasmclyuaKE3TJkM1O1Ldlra6/sk2mdoiSXHuIEIQz2kv37voWgJdi/wV8g26lb83
	 GWgi3KODu4gnvHhtn91x7XCiDW46NmRbTWhPQJYaMCFEpzoCXSDsbHG4pmdhdDbYX0
	 HyIb2apud3R6SNaVlE1sbJbUu7JRCb+OEg+u8tdeQgjz8pHHKsxOXNzW2UEYxxFhaE
	 J+252EyBhmNBg==
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
Subject: [PATCH v4 1/4] perf/core: Fix sched_task callbacks for CPU-wide branch stack events
Date: Wed, 27 May 2026 05:11:57 -0700
Message-ID: <20260527121207.2312181-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260527121207.2312181-1-puranjay@kernel.org>
References: <20260527121207.2312181-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_pmu_sched_task() returns early when cpuctx->task_ctx is non-NULL,
deferring to perf_ctx_sched_task_cb() in the context sched_in/out
paths. But perf_ctx_sched_task_cb() only walks the task context's
pmu_ctx_list -- PMUs that have only CPU-wide events are not on that
list and their sched_task callback is silently skipped.

On ARM64 with CPU-wide branch recording:

  perf record -b -e cycles -a -- ls

armv8pmu_sched_task() is skipped whenever the scheduled task has an
unrelated perf event (e.g. a software event), and branch records leak
across task boundaries.

A second problem exists in __perf_pmu_sched_task(): it passes
cpc->task_epc directly to pmu->sched_task(), but task_epc is NULL for
PMUs with only CPU-wide events. When perf_pmu_sched_task() does reach
the loop (because cpuctx->task_ctx is NULL), this causes a NULL
pointer dereference:

  Unable to handle kernel NULL pointer dereference at virtual address 00[.]
  PC is at armv8pmu_sched_task+0x14/0x50
  Call trace:
    armv8pmu_sched_task+0x14/0x50 (P)
    perf_pmu_sched_task+0xac/0x108
    __perf_event_task_sched_out+0x6c/0xe0

Fix both:

 - Remove the blanket early return in perf_pmu_sched_task() when
   cpuctx->task_ctx is set. Instead, skip individual CPCs that have a
   task_epc (those are handled by perf_ctx_sched_task_cb()). CPCs
   without a task_epc are CPU-only and must be handled here.

 - Fall back to &cpc->epc in __perf_pmu_sched_task() when task_epc is
   NULL, so the callback always gets a valid pmu_ctx.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/events/core.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6d1f8bad7e1c..6604f6e8f352 100644
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
@@ -3919,12 +3920,20 @@ static void perf_pmu_sched_task(struct task_struct *prev,
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct perf_cpu_pmu_context *cpc;
 
-	/* cpuctx->task_ctx will be handled in perf_event_context_sched_in/out */
-	if (prev == next || cpuctx->task_ctx)
+	if (prev == next)
 		return;
 
-	list_for_each_entry(cpc, this_cpu_ptr(&sched_cb_list), sched_cb_entry)
+	list_for_each_entry(cpc, this_cpu_ptr(&sched_cb_list), sched_cb_entry) {
+		/*
+		 * PMUs with per-task events are handled by
+		 * perf_ctx_sched_task_cb() via perf_event_context_sched_in/out
+		 * when a task context is active.
+		 */
+		if (cpuctx->task_ctx && cpc->task_epc)
+			continue;
+
 		__perf_pmu_sched_task(cpc, sched_in ? next : prev, sched_in);
+	}
 }
 
 static void perf_event_switch(struct task_struct *task,
-- 
2.53.0-Meta

