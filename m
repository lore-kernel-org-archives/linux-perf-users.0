Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEA235C6AB;
	Sun, 18 Oct 2026 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341473; cv=none; b=tWGvSu1arMnHrwUZoETX2uM13wBvKcB94+x/mB8PYb2zTAQtduUVofls3eLz3SItgW44UNHNAipj22LWaueJyFV+K+ezamt9THm1LVlLoEgfElNTMCayGJB7a+jy2WV9Et1FFE2sys7LtrD/KkjX/Xx6HzMRUa4Afq9RUwZXOtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341473; c=relaxed/simple;
	bh=DpiaEKyyetn7z0Th+c9jVPJwpahhDKOyIiwm9yitnzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yr+C3/Hrj+AtZPuWSaENDwAFoWWoCAkxWg8K7wLYelU9bl7gFRTkZGsn4WwmcxMPs7SXjG7ugaTPxOs0fEUZYCzOJGTntFT3hUpxksV0DmDdZdutuKJSxMX/9hqHGSWTV+AQd9PjgvgLlNwj6NKmtgFBXuwtuW0kg1zYf0V932A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elImlUyP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elImlUyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DDB1F000C7;
	Sun, 18 Oct 2026 16:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792341465;
	bh=6YGq4yZnG+/2bw7KcqSLIpCcTYNUV08rW3kH11sSKrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=elImlUyP0sT2ZLbrioombktLVYK8J+7Fb3dTDCTp0p/R/E5/TkiBVegF9fLwZcBqY
	 6hnLW2phKDy7IDPOSm4mcrwxST5I4ZzraKHuY/XLsUhiUMjsNzwsi8EoX+xpadXe69
	 NCxXinAt7l5EWKJ7EpVhMReeLp9D4FvDGuivB7PZ/PM4l01FStFsA9L9jmRArugc61
	 gP782EQb/B86ooA/fm9ZBCeBHBT96CAfahU8KfV3ugIcSlPm5d6Nhlic26g5Pa9OdX
	 XLeYVz0lI2mbL8aR4VtYco82BQDX9i2uxALZcMUZ5B7wIcXphkZk7Jqg3PaAyFVyJR
	 Mm76AZPo4RIPw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v1 3/5] perf tools: Remove NULL check for maps__machine()
Date: Sun, 18 Oct 2026 09:37:39 -0700
Message-ID: <20261018163741.850434-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261018163741.850434-1-namhyung@kernel.org>
References: <20261018163741.850434-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now maps should have a machine, let's get rid of checks for the return
value.  There are already many places to assume it returns non-NULL,
so having this kind of check could give confusion that it can return
NULL (which is not true anymore).

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dlfilter.c | 3 +--
 tools/perf/util/event.c    | 3 ---
 tools/perf/util/map.c      | 9 +++------
 tools/perf/util/python.c   | 2 +-
 4 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index e11e144af62bb979..7e179d1d84d78358 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -233,8 +233,7 @@ static const __u8 *dlfilter__insn(void *ctx, __u32 *len)
 		if (thread__maps(al->thread)) {
 			struct machine *machine = maps__machine(thread__maps(al->thread));
 
-			if (machine)
-				perf_sample__fetch_insn(d->sample, al->thread, machine);
+			perf_sample__fetch_insn(d->sample, al->thread, machine);
 		}
 	}
 
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index ea75816d126a14be..2f80e364659fea71 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -706,9 +706,6 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 	al->cpumode = cpumode;
 	al->filtered = 0;
 
-	if (machine == NULL)
-		return NULL;
-
 	if (cpumode == PERF_RECORD_MISC_KERNEL && perf_host) {
 		al->level = 'k';
 		maps = machine__kernel_maps(machine);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 41cdddc987eee710..d5319ffa88a7477c 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -538,13 +538,10 @@ u64 map__rip_2objdump(const struct map *map, u64 rip)
 	 */
 	if (kmap && is_entry_trampoline(kmap->name) && kmap->kmaps) {
 		struct machine *machine = maps__machine(kmap->kmaps);
+		struct map *kernel_map = machine__kernel_map(machine);
 
-		if (machine) {
-			struct map *kernel_map = machine__kernel_map(machine);
-
-			if (kernel_map)
-				map = kernel_map;
-		}
+		if (kernel_map)
+			map = kernel_map;
 	}
 
 	if (!dso__adjust_symbols(dso))
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 60dbe2dad5eb8073..42c587cd54a527a4 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -4536,7 +4536,7 @@ static PyObject *pyrf_call_return__new(struct call_return *cr)
 	if (cr->thread) {
 		struct maps *maps = thread__maps(cr->thread);
 
-		pevent->machine_pid = maps && maps__machine(maps) ? maps__machine(maps)->pid : 0;
+		pevent->machine_pid = maps ? maps__machine(maps)->pid : 0;
 		pevent->pid = thread__pid(cr->thread);
 		pevent->tid = thread__tid(cr->thread);
 	} else {
-- 
2.56.0.176.g3575e65682-goog

