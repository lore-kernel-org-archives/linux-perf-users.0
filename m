Received: from mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079904B44B8
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004689; cv=none; b=lema6VQU9BKjz+2l7/yCSCN6TfXgPoCjXVKwRnyH/gEapZ35Gl1uYx/CnZ6rt0Gp/tkswR3Nr+Adw/bk+sMAdM3eSUDb7AxYUZOSjx4JWTZqZNgSD3KE1gzCuSCSbJDLcmL+wJo8sN8PVcXBQMjzyWMmBK4lu5uT174NyYV4/28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004689; c=relaxed/simple;
	bh=5pSiFWfn9FtXDtB9haqe35AB3erEahgV97vrj2RiLjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtScIihZjkqoutUcZn8ZUeAumK5o+VjzAQgjtfW3nbqJBdNlGoX+l2u/YdRMLzh5ajbADqh5LLc5vESybQsgwDLBtB7ehV0B0j9azexKODm2h7ulaytJN5C057z7H1p8fgns0kH2IvAakNclashZA3mxybFIHmGgGRtNOD8vNFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BeOVreaK; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BeOVreaK"
X-Envelope-To: linux-perf-users@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5pSiFWfn9FtXDtB9haqe35AB3erEahgV97vrj2RiLjY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790004684; v=1; x=1790609484;
 b=BeOVreaKPadkAVN7RH84avDUx80HmFDc4+Zs9R2IgHFG0Q7+fuxEsfqIih08e9U8DWpJlg3I
 gSZwgCh0Nk8Zt0G1xIQLi9t/sg4SL7aezRR7k5wIsX5bYb9rzmJgBtupozCni8BY+eNdFTkGQao
 YuqOgq8w6LDBD6yBGS6YGwg0=
X-Envelope-To: linux-perf-users@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 7878989e305dc767;
	Mon, 21 Sep 2026 15:31:24 +0000
X-Mizu-Trace-ID: 7878989e305dc767
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
Subject: [PATCH 2/2] perf/x86/amd/uncore: Free counter slot by index
Date: Mon, 21 Sep 2026 08:30:15 -0700
Message-ID: <20260921153108.2713179-3-usama.arif@linux.dev>
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

amd_uncore_del() scans ctx->events[] from slot zero and attempts a
compare-exchange until it finds the event.

amd_uncore_add() records the slot it claimed in event->hw.idx. Perf
calls ->del() only after a successful ->add(), and the driver never
moves an installed event between slots. The index therefore remains
valid until deletion.

Use the recorded index directly and retain the compare-exchange
ownership check. Warn if it fails, as that means the driver lost track
of the slot.

Deleting all events from a full PMU with N counters now requires N
compare-exchanges instead of N * (N + 1) / 2.

On a host running a production workload in the Meta fleet, amd_uncore_del()
was called 56,575 times per second from mux rotation.

Cc: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 arch/x86/events/amd/uncore.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 53be8efaedc5d..39287640bf1ea 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -246,19 +246,15 @@ static int amd_uncore_add(struct perf_event *event, int flags)
 
 static void amd_uncore_del(struct perf_event *event, int flags)
 {
-	int i;
 	struct amd_uncore_pmu *pmu = event_to_amd_uncore_pmu(event);
 	struct amd_uncore_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
 	struct hw_perf_event *hwc = &event->hw;
+	struct perf_event *old = event;
 
 	event->pmu->stop(event, PERF_EF_UPDATE);
 
-	for (i = 0; i < pmu->num_counters; i++) {
-		struct perf_event *tmp = event;
-
-		if (try_cmpxchg(&ctx->events[i], &tmp, NULL))
-			break;
-	}
+	/* ->del() follows a successful ->add(), so hwc->idx owns this slot. */
+	WARN_ON_ONCE(!try_cmpxchg(&ctx->events[hwc->idx], &old, NULL));
 
 	hwc->idx = -1;
 }
-- 
2.53.0-Meta

