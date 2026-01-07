Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87876207A32
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Jan 2026 06:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768250; cv=none; b=cCv7VIaArj5oPcaGvWkScYFuZl2K8xsrrNDhhnqgZCKwW6cyZ0oERHH+wqnxS4akHkpY8U0x45FWldZ4Hls/YmwyyBGafXuXpWBU3KdG9kVO7sG2D4ez6Fz4jxWcgT+gdK11V9Rnv9yH7+CGr5hcW9ic5Mlw1w67ocn2eyzcKwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768250; c=relaxed/simple;
	bh=Sp0Y+0T3l52GtbLjQnl10tvPYed8+55/Gn9jek0Hlhk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZwDXjWD2o6IySR20UfQ4L4KG6pOITOEKGvVv075nNWkz1J4O56nHp5rRQ+L8vCdEA1sCP8idblL5zUhFvjJ6iKaYTuURuLvSr+E+D4K3jAQEpH/Nt5ifeSzDej7jdpiBDE0YLgkIyb4DxaAQi7rm2VA/Bfq4ReetcKZfPes2xGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDjlfyLG; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDjlfyLG"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-bc09b3d3afeso797633a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jan 2026 22:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767768249; x=1768373049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NzWYMY79C2D/HY+8eCPW7BWUMhBd8/GZBfIDTrzUEgU=;
        b=HDjlfyLGt3noDixYX3ipreKWfKImjVP4uoKYO/SlXtQval4x5nWfnL4FAqqabu6t89
         uk3+1YpKlAx6TRc9TYHNmrx/vdK3S+JxWQ7Z+neF+SqC26JQ+/bvmgBDEph/DxBtYrDf
         uvEdDB0p/0xOzI8cLQi854xaNdrP468QDodxtWiwVANEOCMbO2ib54CXeXoqmlKGWoRU
         5b1x8zqA4kNr2FKx1hFVhUNyqtR+UBO656F/QWZ4ly8vZcAa1lxA+70fH8IiLtg4sSTO
         YdnbqtbhWTBmQjUIFB3lBqh3wM3KEdZvWMaApkCS1y5aCkZVCQ4RiSZIWyg5vmESoyxR
         P23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767768249; x=1768373049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzWYMY79C2D/HY+8eCPW7BWUMhBd8/GZBfIDTrzUEgU=;
        b=RgIfHi7yQpLFbY49iCH5wCvpp6P+T4mAEL3mzAd9osDNETyrmXb1MxldAHPnJcARL5
         e8gL9pDGcacoQv+hYnrYm24kH6vWGdTVFI6H2DBLbaNPOpJu+w+04RA9c2gJUTWq0uHI
         I+h1nTw/Kxa2sRVFe7Jfwqg1dWwZgeLqihhQJuF2CTIxIRKJfBy8cpp+dVLJTKM1u4hT
         a1M8QJpABOeySEs8QtWBs0UBdWuHw2RXu8RmgiL7N+MFG0qcsEzmUSF2D8dBNZOcFbcf
         2C3zl9PlmLIJ5SfBEKYdag0JIHnRGG89i3ns6NVlTkNq0/s2FLD6KI0IOnmu3Hn2kzq2
         HVLg==
X-Forwarded-Encrypted: i=1; AJvYcCWaON50yiI2KZOtLd3vcVYXPUJVNgpk/wgoswZb+irKY/cbhiXln9EX+NSx315L8L4pZkK9/cKbFF7H9430NG3M@vger.kernel.org
X-Gm-Message-State: AOJu0YxPFn7W1aH99MUQ0YQNxmTCm1yMzrgGHGOrkKKTYLKjhejvuptN
	8Uyut5mdTQiN+UdfF6L0utJxWPA3NIyUy5nOTJ44Rh8pKJV+WM2EE9Wd
X-Gm-Gg: AY/fxX5IJKCxNMBDts7RhaYBlOy7c/HNKiTZqznciVNM1QWDUQxPWO2texjEcUUKGO0
	rSHqUAA3ZtdOwcwGWVUtxRDoRcaeLS3a+bykZTekDhtpnM/NTRZozQOKZEa9hoWNoPOr/42+DDP
	9SMA0bb4as5yOMdmo/92q+iUYTFa8aVNVkRw894pRU5jYTc6KB4BQCzVTtebN+IzZXXt0f7kiMy
	MewGttadtUZM3E5s1zFWH+1qrY7N9gBmDwiC/trRRaLqcNxGVXSep+EbTOJIYejMI/9MlyN5E7I
	ayxwSAUz2MXocCgkeFNTgWsvyYMJIXY6wPy0o1U7zeUSyc+JzWUxgD/LGo/PF1xN2276jBts37S
	CZ9j/tP21vMo4sZuwpmDdyWqp2rsN/PIAvZEJEsX53nYHkfHApqi8NtzO0rp66TeyChBdc2mmmV
	GIPELnZS2VlWmLHhTmAu60LgXAER6CxOI/uvYuKQ==
X-Google-Smtp-Source: AGHT+IHJw1AEc1ap9z7fY+r/uVSz4C0L7S5zD/d2Ze8KVerXKjdbAEaIU5iw1nEP/tURA30QJuYSHg==
X-Received: by 2002:a05:6a21:3286:b0:37e:4319:d7c8 with SMTP id adf61e73a8af0-3898f9abb78mr1563552637.75.1767768248661;
        Tue, 06 Jan 2026 22:44:08 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.217])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5de66d1sm3909403b3a.62.2026.01.06.22.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 22:44:04 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Qing Wang <wangqing7171@gmail.com>
Subject: [PATCH] perf/core: Drop an unused parameter 'ctx'
Date: Wed,  7 Jan 2026 14:43:51 +0800
Message-Id: <20260107064351.3682174-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is an unused parameter 'ctx' in perf_event_exit_event(), so drop it.

Fixes: a3c3c66670ce ("perf/core: Fix child_total_time_enabled accounting bug at task exit")
Signed-off-by: Qing Wang <wangqing7171@gmail.com>
---
 kernel/events/core.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index dad0d3d2e85f..d4da96b3ab34 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4584,7 +4584,6 @@ static void perf_event_enable_on_exec(struct perf_event_context *ctx)
 
 static void perf_remove_from_owner(struct perf_event *event);
 static void perf_event_exit_event(struct perf_event *event,
-				  struct perf_event_context *ctx,
 				  struct task_struct *task,
 				  bool revoke);
 
@@ -4613,7 +4612,7 @@ static void perf_event_remove_on_exec(struct perf_event_context *ctx)
 
 		modified = true;
 
-		perf_event_exit_event(event, ctx, ctx->task, false);
+		perf_event_exit_event(event, ctx->task, false);
 	}
 
 	raw_spin_lock_irqsave(&ctx->lock, flags);
@@ -12511,12 +12510,12 @@ int perf_pmu_register(struct pmu *_pmu, const char *name, int type)
 EXPORT_SYMBOL_GPL(perf_pmu_register);
 
 static void __pmu_detach_event(struct pmu *pmu, struct perf_event *event,
-			       struct perf_event_context *ctx)
+			       struct task_struct *task)
 {
 	/*
 	 * De-schedule the event and mark it REVOKED.
 	 */
-	perf_event_exit_event(event, ctx, ctx->task, true);
+	perf_event_exit_event(event, task, true);
 
 	/*
 	 * All _free_event() bits that rely on event->pmu:
@@ -12555,7 +12554,7 @@ static void pmu_detach_event(struct pmu *pmu, struct perf_event *event)
 	struct perf_event_context *ctx;
 
 	ctx = perf_event_ctx_lock(event);
-	__pmu_detach_event(pmu, event, ctx);
+	__pmu_detach_event(pmu, event, ctx->task);
 	perf_event_ctx_unlock(event, ctx);
 
 	scoped_guard (spinlock, &pmu->events_lock)
@@ -14096,11 +14095,9 @@ static void sync_child_event(struct perf_event *child_event,
 		     &parent_event->child_total_time_running);
 }
 
-static void
-perf_event_exit_event(struct perf_event *event,
-		      struct perf_event_context *ctx,
-		      struct task_struct *task,
-		      bool revoke)
+static void perf_event_exit_event(struct perf_event *event,
+				  struct task_struct *task,
+				  bool revoke)
 {
 	struct perf_event *parent_event = event->parent;
 	unsigned long detach_flags = DETACH_EXIT;
@@ -14217,7 +14214,7 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
 		perf_event_task(task, ctx, 0);
 
 	list_for_each_entry_safe(child_event, next, &ctx->event_list, event_entry)
-		perf_event_exit_event(child_event, ctx, exit ? task : NULL, false);
+		perf_event_exit_event(child_event, exit ? task : NULL, false);
 
 	mutex_unlock(&ctx->mutex);
 
-- 
2.34.1

