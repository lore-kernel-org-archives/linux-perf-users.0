Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB0B2EACEF
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902713; cv=none; b=DlS2khihNwRT8Kf8yzffUPUSGRYqT+ZTUSRvhBdW4q/8f4ZmLyquKxx9PF5qrGD4Wo8/yfZlcTAC2O2T6iyvlbWQ0v6TeaDFvuptd5q7AVq/pnKHBC8c0LFwQrCxaDnKyWk7h9yqidIACqPQuMMvrxI0RLqcuiGxQs+ltOGi8gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902713; c=relaxed/simple;
	bh=pYfIPqorxDE0R0e1j+wNyGgwgZvWB98Ly7fIhs/gcfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZhaQ4dvVPaFfwuzEWUmFpPlZQ8fH0wqP+u09Y29LdLj6G65rga7m+DrREEYpVlvjpG+q9T77iwmpqYc7R4ibVnOYEFT8fe1OxhNu2S1zg3X05sGR9vcoAdchfChKC9/r/vjbeXLs2Zd7gwlMMido9WpaXH3KvRGxkkvs7b8oThU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1+p02RZ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1+p02RZ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-365312a27abso1290777a91.3
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 06:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777902711; x=1778507511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LzRxffteXPHemRjDMy2wtgMLKIg+EY5vkIJp2WjdWj0=;
        b=B1+p02RZ/RU564lyAniHTq6vP0z6LCZpbbc9v069p4dgj8Yy9AtcECWnTOkY2DgoUe
         yApOiL62FH8i/gFtEMSxiFpO2VT7l7gQDW3LKmzpcePHi/Ys8DzReJf3kFowiqkKnMic
         kgOsXg2XPavpz2pce1ZdA0Z1T1/oEfdrWFQDqZCZVZ6TweK5eitvLiDM2M7Ocq6OmpkV
         TS8d4sWxTbBXOewMQDvrd1a4LuHZbc9xG/Lk1woAajMJxtSBSz93d8KZuDrS4PX+287x
         Oos62oK4Dd9GHo0A8eYQBR6XK4R7U/iDVdZXSwEoP+qQO++dmfAnHNMehtFpKerEq0zl
         FSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777902711; x=1778507511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzRxffteXPHemRjDMy2wtgMLKIg+EY5vkIJp2WjdWj0=;
        b=Ajg0dqdKMFzqjsg9cMBzKf6FRhNS5gyimXcGZNx6HKcjc0jtHQy355T1tMmkoiyt48
         DPFrGyHGWHzQqFIG8wY7KaGtbW+adXwIIDMOmdnAoo8SCPakKd5TeFQNhFjIyfgEgTQO
         6NkFHUAPcUUTZvrP1yRzsR8D1xgzTscWlVaDoMD2WFBL/JdDmqXGgkvcMowubLZUVhkp
         HJvk7nC5wDTEBrAGTyA1ceYyAFipmn6LXkWIndVoINre1ekd6EVPgp2XBON41z4hpgh2
         q6ygOfzWYdvHcNIvPaoY4bjz0ZS9e5ySqvUfhdeWvEBPv96FDm4WvWDuON0TLY+j932c
         rnAA==
X-Gm-Message-State: AOJu0YxI3/IvaIZXQlfVSfXzRwPo9rDjjBKMhJlGWhLagHzUUVSf5g3A
	pC4wCFRlB58oSKDh8tp20i7OcH/M9IufsHuq2+Cqk2XI5LPmV+W9G+8f
X-Gm-Gg: AeBDietIaVqWkn79cxcwaiCGmGxvO9oyUPfPRwsuYlNcp9phzsWSJvwOQUAWY5wu88/
	ZlN5KI74JNVld1f1lXljXrgmJ6qmhI46b7iQLl4Po87nFch4nXKwaSV0mRCcwOIdJW7itnJpYKF
	ceikeGgJ2rmMUl42wKyT6sgvcbdLH4dojBPeFuVUkSLaslWr4zwJ9fxvchffh9EzZ1oLSV6Q7Of
	IvoucpMm6TR5gfAh1t6oLEm9gDwEnbCES7kCbq7AnCfgTF0a6PuBma8M03l5sO3Xdrydlz0+KH+
	zHT1JKEBsSr/rWw0IYQYQ5TJYjH/h83jpUbaefA0zGSc717pWk4jGdkd+Dq18Idsdieaeq0p7JK
	GrFIIXDQeFcOZiymzkV5Dw0vhMG96O+0qKDeX7TClYUx0S/EtHSPU1cnNcob+0/XT8FGuHBYOxc
	qL2vc14KQpAJ06L7j2ronjqRKXY+V6GnZPO9kxMbMi4g==
X-Received: by 2002:a17:90a:ec86:b0:35f:bd29:75b9 with SMTP id 98e67ed59e1d1-3650cee7ca6mr9603800a91.22.1777902711104;
        Mon, 04 May 2026 06:51:51 -0700 (PDT)
Received: from archlinux ([205.254.163.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae15fb6sm109688945ad.43.2026.05.04.06.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:51:50 -0700 (PDT)
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
Subject: [PATCH RESEND] perf/lock: Fix non-atomic max/time and min_time updates in contention_data
Date: Mon,  4 May 2026 19:21:38 +0530
Message-ID: <20260504135138.17050-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.53.0
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
2.53.0

