Received: from mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC684A49AD
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004686; cv=none; b=cRHIcWCyYKooKNFgqBhT01yiR4yXKK8zuOY/8yzcGCTQsSQJErHCy5c9c/+1FVvOlFf3pThyXRcTd0SoU0u4OhTJfskxvRXjjPcV2yj7/ZOijEfsJEDYHsw1ExVzK5ciLNM+TwwxXFnjPGtonCu4t2vB7Qr/ZZ7xzxGC9lo2ibM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004686; c=relaxed/simple;
	bh=2SOs8h75Ol8U202CYfr5Ayb6GstSTbHVIntm0QQVLJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcoV5wJbJKNcHc1VoEmgxO2W1G31d5ngczwMpYepfCzU7hWRwiPfPa9LIBoPxWdfls/IL7eKBDFjs9dCiMufZHtuT+WovPCsq4yFhbI2OyIaAhJyrMhsKhF3hLX1ySCCN2b8wnBwQRmkpS9agysQt4lAdsA2ZTNTWBVFuJjXHU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BC/+Pk4n; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BC/+Pk4n"
X-Envelope-To: linux-perf-users@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2SOs8h75Ol8U202CYfr5Ayb6GstSTbHVIntm0QQVLJ0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790004682; v=1; x=1790609482;
 b=BC/+Pk4nZP0sZnmfGgnNKkhDxfuhKNJ+XDCy2yUuLJRYART0vsZ7Ybwc/aiyN4k6KFRscrO2
 TdTyS1ZqtcxK/vg9PB1XbXwIqAoI/PL+TrqASjgQ1EDufXKJVA9TMnQMuJgllu08hGkSbSSiSHA
 t8ErDXoyOhNcyHjYD2ttbHJs=
X-Envelope-To: linux-perf-users@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 530f19e0bc60f4b3;
	Mon, 21 Sep 2026 15:31:21 +0000
X-Mizu-Trace-ID: 530f19e0bc60f4b3
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org,
	tglx@kernel.org,
	x86@kernel.org
Cc: hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 1/2] perf/x86/amd/uncore: Remove redundant event slot scan
Date: Mon, 21 Sep 2026 08:30:14 -0700
Message-ID: <20260921153108.2713179-2-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921153108.2713179-1-usama.arif@linux.dev>
References: <20260921153108.2713179-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amd_uncore_add() first checks the slot recorded in event->hw.idx. If
that misses, it scans ctx->events[] for the event before looking for a
free slot.

Perf serializes ->add() and ->del() for an event. Initialization sets
idx to -1. A successful ->add() claims a slot and records its index
before returning, while ->del() clears the slot before resetting idx.
CPU context migration follows the same delete/add sequence.

Thus an installed event can only reside at the recorded index. If the
direct check misses, the event is not present in ctx->events[].

Remove the redundant scan. This avoids walking all counters before each
new slot search after multiplexing has scheduled an event out.

On a host running a production workload in the Meta fleet, amd_uncore_add()
was called 56,575 times per second from mux rotation. Its 16-counter DF PMU
makes each failed search scan 16 pointers across two cache lines.

Cc: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 arch/x86/events/amd/uncore.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 7181973b5b127..53be8efaedc5d 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -206,17 +206,15 @@ static int amd_uncore_add(struct perf_event *event, int flags)
 	struct amd_uncore_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
 	struct hw_perf_event *hwc = &event->hw;
 
-	/* are we already assigned? */
+	/*
+	 * Perf serializes ->add() and ->del() for an event. A successful
+	 * ->add() records the claimed slot in hwc->idx before returning, and
+	 * ->del() clears that slot before resetting hwc->idx. Therefore, an
+	 * existing assignment must be at hwc->idx.
+	 */
 	if (hwc->idx != -1 && ctx->events[hwc->idx] == event)
 		goto out;
 
-	for (i = 0; i < pmu->num_counters; i++) {
-		if (ctx->events[i] == event) {
-			hwc->idx = i;
-			goto out;
-		}
-	}
-
 	/* if not, take the first available counter */
 	hwc->idx = -1;
 	for (i = 0; i < pmu->num_counters; i++) {
-- 
2.53.0-Meta

