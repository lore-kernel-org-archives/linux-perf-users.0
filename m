Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109033812DB
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 00:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789519521; cv=none; b=aoR27NP+MUlUHPLp4UTO20jf9+nH9k3ufTsIPJF+kTcdtdNoZezM7q6PGt+dHElsAZRT2a5WO+FU9y3wfcUDOHa1qRq6B3BqcKp0FLw6jl9Jje8Hto9MFFf3tkc7OmOpJllhEsmXwOS2TY/HsAu3QPphKNWmMPfKmzVgXiLLINo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789519521; c=relaxed/simple;
	bh=lMY++SgK+PAJrmE/LiZDbpmw7ME2tzesFgDyA4gd00A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r7ekJGLU0CB9KNfvrghydJVLySIiIDLTqoM7j7sESmDIfoSSwWQsnNkHnyPuiwNOihlIO2HunQpavWxIRrksEtOeY7V17jPahwmR8l5UOD/dOJkhAd9jUKnmtwBP4/UlS2HD8glPwuUy9n9L1DYzAoeh9dTXPLs3udrIpqultig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1OMzJRg; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1OMzJRg"
Received: by mail-pz2-f41.google.com with SMTP id 41be03b00d2f7-cc50b9e8a45so260056a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 17:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789519519; x=1790124319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=98CqDsG0IhFZSuG3hDPLFa5iEsa8i7vnG+8QJYAe98A=;
        b=m1OMzJRgiWqnjAI62+B4NQB7kHw2ZJeDMvpZ0zgbaOw2Y5/aUSWvhkftuOBCXwXTZx
         8WGjh1IKbU6dBRL63pHuH9hdT9RImVN8EulvlzU0BY/caMikCIsyT/s7ZqYflFBEesGQ
         SCPfYPtl1j5naP7J32vdrdIWTor6iCg9tPkCWL8Wf2LyJ+2p6sQygD+Q6FwAFaWlPsZ4
         62qp+WDL7Lqf0gvTQmME23Nwr7s887H3WbjD12bvyid/GkzGXxN6Vvo3K9yOyf4yftYY
         v9YtlLsafgdZlRe9GXWt8oX7uuigy7XPfQihypazD6O1uhI+cRQAMzT2UJcGCIvx7V+K
         PYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789519519; x=1790124319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=98CqDsG0IhFZSuG3hDPLFa5iEsa8i7vnG+8QJYAe98A=;
        b=K2ggjeUPw6GDWZNsW24p4sP/L47vcqZkFa+IhbSYymGd4NmcuaW7zRHaitkJP1g01K
         9X9MC6tZbxQ5+pzsPuQLESOSrk1Ga605ypXTmOyJwqvbpdC1nLdjaWW0B3aOKdFztYOv
         3qSDUYkED5P3ijuXXckxoZg5A66RmnIXc3+R61pW8QRRb1REL2+bUB5aLCLGDV1OLBpd
         kNr4loLVPlvrzRWZeeJpztMC7UD/hjpDaaBtxAPHGdXelQ2cQsFSfOLLP+h4jqI0cC6s
         9yNAPaQdvRMxuMxJiMGN6dmzkEB1khb92x1sutwFJ/nn0EMBPeHTg/zxb3CkR5eonwk0
         nTwQ==
X-Gm-Message-State: AFuF++kJFKnvYMbFFgIoMszyY+v+TqhHlLSlW9EAk1JUlePdiuD6c/GH
	y8jq1n6YFwsIR4/RfKkPhKFjQY3HcZ/KYZjhQdlN1doGtBB05uy7tc7i+NwI00tL
X-Gm-Gg: AYBFou3tNmgzctqX00QCwp9viay8zS6hqNqe2vb4fKHxBiIcF1L4WGXTyoddljJ/ti1
	7C+si2ztrM5Kw9n1kgmnY5BgmUCWn/99Q+bvYsylAAa7RpkdoJYIDW54xw7vyDSkCDNy3WRO+m4
	y8jGqGwhpMlpvYSkhPTqfIXkQEjkmyCr445AOXhPVuvCSNeHJsQANbge8+Pp+UwCT/IDbnv9htQ
	twTshAG0amjibwUzfgGm4wtncOZi9V2HMBfpntTATmfFXKPUfYdEELD4yHNJ+1uyyNvkgZloDiv
	5D4e3eG02jQrI3focdwUpCoSIXCTyQtq+lsMZSbgnUbEXsYY7RGlIlkZMYPY2nCGPhpPjzQJqYg
	KGcSauj1GuvHAthqqG3sOXdKD8IcBxA1caXC86ucCzR+gc5ycAgxhsBVH4BaqhtqHwGDqnfy+oS
	2esklNYl178DdjZXXC0IB99h6WGvNnAmcbJs8gnan1SkM0APjPtqkOf34P4S68dFEX/le7sfjdj
	y2KVmee685KFmjgPd/5aga0iIHWGIjSYqpTL2P2VEFEACGRc1uDDhqiIAxIXRFopu5+IT/5+V1B
	oV4U3E/Qc+Pxjl7l5UJAikd8Mx3dY4s4v+4vBRpBaM2JUE2JqXDpRmEYkeU=
X-Received: by 2002:a17:90b:4a51:b0:39d:ee20:1e28 with SMTP id 98e67ed59e1d1-39e1e510f73mr1234289a91.21.1789519519305;
        Tue, 15 Sep 2026 17:45:19 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bc46529sm1207069a91.16.2026.09.15.17.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 17:45:18 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH RESEND] perf/x86/amd/uncore: turn amd_uncore_ctx events into a flexible array
Date: Tue, 15 Sep 2026 17:45:16 -0700
Message-ID: <20260916004516.268192-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The events pointer was kzalloc_node()'d immediately after the parent
struct allocation, with the count (pmu->num_counters) trivially
available beforehand.  Move events to the struct tail as a flexible
array member and fold the two allocations into a single kzalloc_node()
with struct_size(), dropping the separate kfree(ctx->events) in the
free path.

Assisted-by: Claude:Opus-4.7
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/x86/events/amd/uncore.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 7181973b5b12..74b9c92d517a 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -39,11 +39,11 @@ static int pmu_version;
 struct amd_uncore_ctx {
 	int refcnt;
 	int cpu;
-	struct perf_event **events;
 	unsigned long active_mask[BITS_TO_LONGS(NUM_COUNTERS_MAX)];
 	int nr_active;
 	struct hrtimer hrtimer;
 	u64 hrtimer_duration;
+	struct perf_event *events[];
 };
 
 struct amd_uncore_pmu {
@@ -519,10 +519,8 @@ static void amd_uncore_ctx_free(struct amd_uncore *uncore, unsigned int cpu)
 		if (cpu == ctx->cpu)
 			cpumask_clear_cpu(cpu, &pmu->active_mask);
 
-		if (!--ctx->refcnt) {
-			kfree(ctx->events);
+		if (!--ctx->refcnt)
 			kfree(ctx);
-		}
 
 		*per_cpu_ptr(pmu->ctx, cpu) = NULL;
 	}
@@ -567,18 +565,11 @@ static int amd_uncore_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 		/* Allocate context if sibling does not exist */
 		if (!curr) {
 			node = cpu_to_node(cpu);
-			curr = kzalloc_node(sizeof(*curr), GFP_KERNEL, node);
+			curr = kzalloc_node(struct_size(curr, events, pmu->num_counters), GFP_KERNEL, node);
 			if (!curr)
 				goto fail;
 
 			curr->cpu = cpu;
-			curr->events = kzalloc_node(sizeof(*curr->events) *
-						    pmu->num_counters,
-						    GFP_KERNEL, node);
-			if (!curr->events) {
-				kfree(curr);
-				goto fail;
-			}
 
 			amd_uncore_init_hrtimer(curr);
 			curr->hrtimer_duration = (u64)update_interval * NSEC_PER_MSEC;
-- 
2.55.0

