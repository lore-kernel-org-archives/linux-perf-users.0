Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28DF2C237C
	for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780170763; cv=none; b=HuPLFTQas7iANsECSKUbqTvrf/XdzHD0Flx4C8mWvK6+CIdJAgfGh/z2jrA939oQ0fP2CFReby8fV3mG0ARTCe/Mx/o9lFTsoHC0DEjHRAyE4oRwZLXGN8mIhPnaDRp/ol1kzWQr8ykraltbfpTedAlPy4qtJO7sOfnqBq8ThzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780170763; c=relaxed/simple;
	bh=rvq5LDbnJDIRErmZhFttXSQwgqS/gTbMhyWFrdYdZx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZMUOLwGx3PqnsKV37+k7kLQUiUe65T0+1W1mYcmwRI2K1Ng2LxRpr0Z/UM9wd1iSRaZVmGyMnaTEmbrpcggXswZUbbbmXl9TmfRn/vFqPevjUela9D/r6tNn9j/7Ze9tru/foU3ktD6TYCcBAfuoN8Jefuqct2J1prvASb/awXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyTyOKOQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyTyOKOQ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0c379e8ffso627455ad.3
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 12:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780170761; x=1780775561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9yRI8S7rO7BEyLKlLy7cyQrxqSvUTXdcDj9hT1MZ8+U=;
        b=OyTyOKOQ9kJooeKDowc/luTNWBvqmSKqZ19rd7U1NoUPrCUGysGcKnRbsPCnpSGELa
         ihnNw385ztwyMlEyeDAV9We3lkqsVMRPkMqJDAStjhPb32yrRnOITKgh8mvVwY3JBLaB
         DnZoyPfGQxJ9RqtDwXp+I5yqe6kynYp4ITOQWGZ1wVrqL7x8TFlZigFatDqlVWae46FG
         MS9wSKGURjZd8WZIxn6cFUTBSnSYouo5Oi9iJCJzeoWFya2wBy92eDWhA8qQVsgHfhLe
         7bfX3kIYHXWl6MwRoa7luByv1Q23sc1dcxL7DsQp4mv8TRuR6Ll0lf20qAheEV77IAA3
         4CVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780170761; x=1780775561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yRI8S7rO7BEyLKlLy7cyQrxqSvUTXdcDj9hT1MZ8+U=;
        b=rFi+5RyybpSobrgXHDs+UcEGwV5zwy/luaz4fHbiIXZY/kPI2R8lVKRNIix2ITbCgL
         +G2q6+zNP2B2rJbgFCv2m9xSbTXxsGpvtTsiTbwt8NpeHKS3zyLpAWin3YY2mHDTqDjW
         WmuDwUoA30PNuT5/fcr73i1w3blxxEt9VEYfqvujMC+krrsc9q3CjmYotEyNGxauq6wb
         2aK5Y6Drvc+OuG/Zk998QgkxrfsgmoSnTJkFwgIwkUGdLgtiphbc2+LufuKVhv+xAXK0
         RfKilNOcjn8OanBb0faMWK7PCz+/jqDOXc29ajFk32G6yfXNB11/yugUSV+p2BqbsQ1Y
         O49Q==
X-Gm-Message-State: AOJu0YyEJz7yOW41mhVZjlw/MXUY1dgKJWbM+2G/D9XD77E90jANU0R0
	LwT6Vi9487HDmbJw5e9LFrkOvT2h+U/LUecyXgW20JIKJ2PNfKYEoQGU
X-Gm-Gg: Acq92OGE/CX91Gq5Yu5kNWq26MMVzGt5Bb3jhzEVH0GIw+LBCbk9oqcDLPdmOz8NLGI
	EQjwH6mxEdPmdJ9pyY4ye9IFCrNW8uCv77quh16MZB/9UxpcbEar8g83RjXxYk2xrU+dOxBVXMD
	/nwTFAmsAj5K/ZZgQpXhEpKyav/2IGk1mfUVaHY99LAqahAgQfTIZpjwXSLxC3RCPAiwFM9AElY
	uBVna76sNySrpvFNr4zey8NIZE1mvPbSKwzC+Qb1WBj3XUOOFWzHRZBvxVvOPXhqj4NSxjfrOyo
	L2JmbpVOeSJ9Gft9qGFC+uXnA1aBTAWcaqNVMOsquSYI15pnGSu71AR9rzF2XfFF+mRvEK5RO1W
	iYHyWUcyyjA16d4M+9LSihhbK+VaEDsmbjDixUN4hae5tFbxX4tDQC1BlUTsbzaAaQQn3zsbHi8
	vHQLLbTfagebMj4zIiPUDhqigLGzh/4oCx7tLOCJ9hlhU=
X-Received: by 2002:a17:903:2409:b0:2bc:a52c:c8fa with SMTP id d9443c01a7336-2bf3685a533mr64533095ad.26.1780170761238;
        Sat, 30 May 2026 12:52:41 -0700 (PDT)
Received: from archlinux ([205.254.163.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c4dd4csm58343345ad.78.2026.05.30.12.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 12:52:40 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH 1/2] perf/lock: Fix non-atomic max/time and min_time updates in contention_data
Date: Sun, 31 May 2026 01:22:30 +0530
Message-ID: <20260530195230.69382-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The update_contention_data() had a FIXME noting that max_time and
min_time updates lacked atomicity. Two CPUs could simultaneously
read a stale value, pass the comparison check and race on the
write-back, with the smaller value potentially overwriting the
larger one and silently corrupting the statistics.

Fix this by replacing the bare conditional assignments with a
bpf_loop()-based CAS retry loop. Each field tracks its own
convergence independently via max_done/min_done flags in cas_ctx,
so a successful CAS on one field is never retried even if the
other field needs more attempts.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 50 +++++++++++++++++--
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 96e7d853b9ed..5c8431be674a 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -175,6 +175,13 @@ struct mm_struct___new {
 	struct rw_semaphore mmap_lock;
 } __attribute__((preserve_access_index));
 
+struct cas_ctx {
+	struct contention_data *data;
+	u64 duration;
+	int max_done;
+	int min_done;
+};
+
 extern struct kmem_cache *bpf_get_kmem_cache(u64 addr) __ksym __weak;
 
 /* control flags */
@@ -486,16 +493,49 @@ static inline s32 get_owner_stack_id(u64 *stacktrace)
 	return -1;
 }
 
+static long cas_min_max_cb(u64 idx, void *arg)
+{
+	struct cas_ctx *ctx = arg;
+
+	if (!ctx->max_done) {
+		u64 old_max = ctx->data->max_time;
+		if (old_max >= ctx->duration) {
+			ctx->max_done = 1;
+		} else {
+			u64 r = __sync_val_compare_and_swap(
+				&ctx->data->max_time, old_max, ctx->duration);
+			if (r == old_max)
+				ctx->max_done = 1;
+		}
+	}
+
+	if (!ctx->min_done) {
+		u64 old_min = ctx->data->min_time;
+		if (old_min <= ctx->duration) {
+			ctx->min_done = 1;
+		} else {
+			u64 r = __sync_val_compare_and_swap(
+				&ctx->data->min_time, old_min, ctx->duration);
+			if (r == old_min)
+				ctx->min_done = 1;
+		}
+	}
+
+	return (ctx->max_done && ctx->min_done) ? 1 : 0;
+}
+
 static inline void update_contention_data(struct contention_data *data, u64 duration, u32 count)
 {
 	__sync_fetch_and_add(&data->total_time, duration);
 	__sync_fetch_and_add(&data->count, count);
 
-	/* FIXME: need atomic operations */
-	if (data->max_time < duration)
-		data->max_time = duration;
-	if (data->min_time > duration)
-		data->min_time = duration;
+	struct cas_ctx ctx = {
+		.data     = data,
+		.duration = duration,
+		.max_done = 0,
+		.min_done = 0,
+	};
+	bpf_loop(64, cas_min_max_cb, &ctx, 0);
 }
 
 static inline void update_owner_stat(u32 id, u64 duration, u32 flags)
-- 
2.54.0

