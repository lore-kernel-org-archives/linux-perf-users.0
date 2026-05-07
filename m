Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDBF33A6F1
	for <linux-perf-users@vger.kernel.org>; Thu,  7 May 2026 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179373; cv=none; b=Z1VMYdJ81dA6C2UPCThTMKkuI8oLs2SDXeaGJGuNBETh98pvyzrC1a3bNYOa5uaODYHn9VV7Rtc03EsNDi1mKG8Gv5ATBTHgNXkvAwbgbDITajwe/08CV//vsvjcZrb4BmAXJOp2RKCfhlxazI7wVVu//M3pJluWkVqgFfRX/9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179373; c=relaxed/simple;
	bh=c+3opmxIH4DLfjXxSKulQKhrGuenddLurBJ2Uoc+vXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e010QE+wmuWpbpXBljhakZ2C2WDDir38oaFxLk+mn7PAU3W9ZFTA3SOQTcnFQRMx35AtG2miC9ptQu5ATAoZzyh2MLUoZCz/FAr+iHCHcpjivKs2ht/P/Lr5a0xexaROvSf9v8xAaFEIHwxDEkLHGWMWW7DkxmgR1urlDaHyuUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lct7fJjZ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lct7fJjZ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-366087480d8so970043a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 07 May 2026 11:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778179371; x=1778784171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GLbDA5dUP8vgYaSGZyctZknfu5NA4leOLY3uMdguNYA=;
        b=lct7fJjZBYJ31+qe5c//W+fNO8/RNynrYkgh9XV8MOOb9F54zfr9GR+wHs3T6iJDry
         zS6GAApXBtsc92f3lnCfH8MtVUbx0WDoyZ0fimFeCO2AYUepGHmk0ifXJc7pJCXSlytD
         C2fvCRgC2XP43NtBz/3q5Z4JON7PaxNzb+3eTdZtuac3Z3W/ammTveJ6AC3HBhte/fkq
         5vwY4YvRVwAx9GwsTZ0ODDqBqa8o5h5Xsgvw96gpUsyi+1IuVHFwe3EQkksByq2r9vsN
         VdF7B7+BApQHqk4R/a3IveJi4fxUpAskbx+sWxL5JNbSSW69UgR2m6DrazG5cQDMUcxz
         Dltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778179371; x=1778784171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLbDA5dUP8vgYaSGZyctZknfu5NA4leOLY3uMdguNYA=;
        b=ngbOnWeNdAZq53LjhHtMqSnByZdYwrfFQwjQ34YkGdRPNqaB0Ur6lLcfnbXyOX79Fn
         kmlucWTpEb8V/XtTVZAo+n3Oij5481TwDM9wOOatJvQ9NEwY8fSi7215RA8WsGcMPRnP
         fDkSibM6N0XH9oZibwW49dg0sM7+SLqWZCdJcFUWA5wQb54hrnddEWtkWzxEGCWAVJLx
         e8gdqPUq+MxIF9n7cAJ5KJvR7G26WbTqA08kwIyHMQU+u7K6EuNCCA2U/kqyLbCfTn2Y
         1exa62A6eldafaznk6tx+U1+RhewZEam9afA7C4yQhZ/P4MK7i2sPe/mhMHWVT5yhq8m
         iMcg==
X-Gm-Message-State: AOJu0YwMcXgVSJDta3vcsVHwCgQ5qFq/o+ZQHU962d3yVEmIab9a2Eej
	DUP23sFhNJRKuAFr4OCncKzHkiVdf6mAAs3fIPreOm+z0+Rvo6+UgLYi
X-Gm-Gg: Acq92OEUAqFO03veAHDUdxad3I51qW2qAJ4yIPVplReMlSGiZAwD/hZhppQBuDh0sPu
	UJGSOpfEFQm3Mvbld3myKmgMOWXM9fzDtOP6FmBE7wknMNWD6NtGsifu0TLk0h9CcOtOS9qG+mF
	xkV8uHuvfwznMZNAerp3tx8d0o39nOaQ8gkag+BACuoXbeo2403ePxXdr545g4bb1qbFiTV+WsM
	fO9y1683QONaiAVmlSh5yyOhcll2u41JsIr6lWDbg1fR0H/6325CTSpTHpVYLPlXYt535WXDrEG
	/+0R9FpNM5ujybLNzYndXezV/MARf3QCu3ATkqWMIQV7avTRXHeYVkfMVTZtUoIc8vpqqZb7qjS
	GodsktGma4ATUtK6B5N4HrhnUDtvXC7W+y1Szs2CqOBJmaNeUvV3A7bk5TszJKTVJjQp76a4phH
	DJeeE1t1diaoGUKazkzOny6IS2iTSrCR2PpOKgJBClNw==
X-Received: by 2002:a17:90b:3846:b0:366:33a6:9926 with SMTP id 98e67ed59e1d1-36633a69cfamr1834848a91.18.1778179371533;
        Thu, 07 May 2026 11:42:51 -0700 (PDT)
Received: from archlinux ([205.254.163.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-366478fb189sm118708a91.16.2026.05.07.11.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:42:51 -0700 (PDT)
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
Date: Fri,  8 May 2026 00:12:37 +0530
Message-ID: <20260507184238.65280-1-suchitkarunakaran@gmail.com>
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

