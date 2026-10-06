Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70FB311C36
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 03:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791258160; cv=none; b=WxiEGBMyLzNVr1BOV/tggj2BOqPVNlzmXU2CLkFWrFK9KIsqnpcUfJzvFUThG+mQLZsqMl0EPmbHRxv/W64XHkTxNEBY3Znzh9KQRDBX68hszJGHIejvqS5upmnaq9KUwpSASfeGA8oNoPUhdq6Hrudnna/bFtiCbdz6fTpVHyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791258160; c=relaxed/simple;
	bh=RTgP9+sWPMyfgkJD/FfsZNoAQrNeTZ+KCMoL3s17ZPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XrGgZOU7iUW2l0quXrqPPWBSS+f2tyyAbG4zm+pX+qeIO3TzDxRO2In79tzoZn/yH9D0wIbDanMxKPn8IcDCDr+1xMqOv682YgsYMbdFV4XzNOa6oJjiuRGyVDBUW3t8EpgJ8OvsBzeX1H3N/ooHpCqg2rBBioAT+3ZDH9+rEwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r1RsA2ew; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1RsA2ew"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-34ef8f66a6bso92475eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Oct 2026 20:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791258157; x=1791862957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uo2HOyWuoDD3hXkfI+UlBGgqqdtNqBn3w59zm1nSdVo=;
        b=r1RsA2ewgSRp/jUBK0D6x+DaTyaZdCDy0PBkg8zr7vcGj9uwMrW8ASu3AIHFznwwKa
         QMcNHcMefRhz4WgPPWcwPBzYSnOQFgwo90jC6yHSLAhcyAgrGMKHAS5rydqi+zNQUWBD
         VU9AZvgVSmVoDBhRey+MgPWOlf2YbolMbqPxa046RUqHgaKYxccdt5m8WxmChTO319Ya
         f3XThzzQcWJ1MIdsnKx3SSBSPYTXztmIY6ES0kZWTul9hmbzcax4gyT+i2U0Or5xUf7g
         UC5USGH/kg/71quhM7PL/RRoouePOy8jOvF8s1+pGaTn/T1ZWCstbwTB+wV4miAVUBpB
         zgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791258157; x=1791862957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uo2HOyWuoDD3hXkfI+UlBGgqqdtNqBn3w59zm1nSdVo=;
        b=BXgVMF8f3sFbGn9RduWjdrSXftqzJNLtcmnK5yvFKYgIQbnlg7AmR8CfhpKZQWWMfG
         St/VNrxNwFPm5AIjky1qVBPsFlnpm3P8Qb0pL136xbYGBXf2dQtrJY8hftVYL+UUoE7s
         5NUQRN5JPV5NY5J1EL9NSp7IKs/FAFhGHm7MA0fbYznZNAuqz/aHt2LLi5UcCVAqwHG0
         c50or8XVonT1BusJbMczt4sJhfBzvDkThgfjkomhcHjGzidPp75Lfh81Hf/KqJnO1CYf
         U1HEsNLCN0URuT6vLkHsCj4HP1JfGVD1DDBu2UvbFKbnRmJAbXlO39vlm0I+BwMnd3/s
         hAug==
X-Gm-Message-State: AFuF++lLCcdBpLV6f17IT0B5+D1nXwVPlet98Y09kAOzOoFTKa/XVgUs
	Zy5Vty3lRJjHzSKFmdZJc1BCWriJTu2fxQRsNpjMK9LLy2Grk52nHWbeiwB6lGIPKcs=
X-Gm-Gg: AYBFou3HzcJX01cIurDLILqSbq4z7cjvvbpBsIcnNvTJcmh+u0NcIjN1lCIAIg66yQp
	OgLm8QatCucYLIVJfAS2lxJKq0l97axtKoo5pLMF4Rwfs66L1NUdEqBf6n6vB38GJHdVwhrKaaq
	qYCBumnTASOFOIXImbrH9NleP7ECWLP0VwQ9eFUMeTFiW/KDpgmp6kMWNHLCv+poMCD8QAa84RQ
	YVkcqZmbbj//SG4JWK7uHTag5XdTwENePvoTUoBGruBr+NzbZSgA1JgnQGAtiL9uPVMlTh/h1ee
	Dj/tdh3FyWvUPOs3C35ssj4DGdEU9m1RRi6TJe+Svj8+n+XVEqKkfh0SRDOwXm0ODy2LN7JwPQq
	6L1WoL8Ljx8KrpNxtW3tyjjLECFLx12zejHOyKRl9x+UJ7Hd5vLqLa0PSvqTy8sU/gy4Dt2e0k8
	/RroMybzg7v9XNN7Q3wmeHbPVx83kZk+r2WaOQPBOuhQCzzuotYy4nQbbGcD12HnQcElQJ7RsVS
	XJ4vQz4jBjGbBBA8SZoBIPKb5Iw9iLR0WRgw7Dit78=
X-Received: by 2002:a05:7300:fe81:b0:33c:e74:4625 with SMTP id 5a478bee46e88-3514e3368aemr7379eec.28.1791258157387;
        Mon, 05 Oct 2026 20:42:37 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35146a3e021sm3269450eec.15.2026.10.05.20.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 20:42:36 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	co+8a0b9fcf1e087762@bugs.sh
Subject: [PATCH] perf/core: Protect put_ctx() wakeup with RCU
Date: Tue,  6 Oct 2026 11:42:24 +0800
Message-ID: <20261006034224.3014697-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

put_ctx() drops a context reference before checking ctx->task in its
non-final branch. perf_event_open() can break an inherited context
relationship in find_get_context() while a concurrent close() drops the
context's final reference, allowing free_ctx() to run before the
post-decrement read. A reproducer triggers this on an unmodified KASAN
kernel:

  BUG: KASAN: slab-use-after-free in put_ctx+0x213/0x220
  Read of size 8 at addr ffff88801ef4b480 by task poc/5714
  CPU: 2 UID: 65534 PID: 5714 Comm: poc
  Call Trace:
   ...
   put_ctx (kernel/events/core.c:1394)
   find_get_context (kernel/events/core.c:5135)
   __do_sys_perf_event_open (kernel/events/core.c:14083)
   do_syscall_64 (arch/x86/entry/syscall_64.c:84)
   ...
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

Hold an RCU read-side lock across the decrement and wakeup decision so
free_ctx() cannot reclaim the context until the access completes.

Fixes: 59f3aa4a3ee2 ("perf: Simplify perf_event_free_task() wait")
Reported-by: <co+8a0b9fcf1e087762@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 kernel/events/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fe33fe1..2fec17a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1383,6 +1383,7 @@ static void free_ctx(struct rcu_head *head)
 
 static void put_ctx(struct perf_event_context *ctx)
 {
+	rcu_read_lock();
 	if (refcount_dec_and_test(&ctx->refcount)) {
 		if (ctx->parent_ctx)
 			put_ctx(ctx->parent_ctx);
@@ -1394,6 +1395,7 @@ static void put_ctx(struct perf_event_context *ctx)
 		if (ctx->task == TASK_TOMBSTONE)
 			wake_up_var(&ctx->refcount);
 	}
+	rcu_read_unlock();
 }
 
 /*
