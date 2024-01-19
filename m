Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C48EDF
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jan 2024 00:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705623256; cv=none; b=mWtmNK0MEBwxA9oUkEWvjtCCGuyjUUW9BSFHWqCH9KCajJrv9ZfZFYUhJ9t9v7ZyVfWv83Wt79nHe/yAtaZffTV62AuRhuxkGhxYQtmJIB1AHlQZ625yhMhb6fIle9F7Ck0V+xNsf0MNm+0ffQmMqND2UZCTNi76Q7CTaUicDrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705623256; c=relaxed/simple;
	bh=BvdPhHhuuf/fRX3SqKFdqqVaVqqf5FQjd8NlByquZYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bDx4/jGML/f2LviL6HpWyfXoZSoPMfWuKDAfqXDuG/+vvrYXEslne0ND9eDTnElHdVXq2Bji0gE3PnyG0/VoSYQ3qAeyxs4+z+dvpYa0B4ueZLjCGzJYWlJhVWOmlvGuJiqCdzLe3YfZETFFbpGGNwvaEnHh77FB0xGBKblxFjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=g5vLseTw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="g5vLseTw"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d5db9eb0e7so1276705ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Jan 2024 16:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1705623253; x=1706228053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goCRlABDp65iNRuy7Fdk99c/XuzP9RSm/x9LjyCmqK8=;
        b=g5vLseTwxcL1+e/Y4krZOtr6EtaiOwYUQSZuxbGwOUr8uMWz/nICL/yTIYe+NmfkvY
         x0lJAgXKVhLVmjFFCntcSbWlM7htz8Hf8jgvRizk46PvmwYOExB+gglUH16J+xor7cWK
         zMRZVkDvkuTiRFwLXPKaqy/+BDIhqynGoWKpZ3BWwurBeWF8yPMB/XyqcKd7IRFd7SfT
         ySZYS+yFFx8GtAVLI0/eTK3Q4KP1MeOChv/suiKL+1Y3mH1Q02gLPRbQvQKQVMcPYyZk
         lz+BPo9Z2og9ZGxLWEERNuffyOYNgJ8NabEbVnG8/VatSP7wWAvrdEoFpd/OlUVYjTPo
         fFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705623253; x=1706228053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goCRlABDp65iNRuy7Fdk99c/XuzP9RSm/x9LjyCmqK8=;
        b=Q9phf0QwlGF+ful77K9/5PD/drHpCsX/DBov40wfdzo+5fq3sA+s8Tv/Wz7NxLgIt2
         Jcs5pd5NL/laP44pr5FmJw+pxmjfByoIfDUOpN+T3QQ/KIkTfHlewUyBvHx7xA72YYla
         kSQ7+zrlZ4Er6DFVELeZD7A7i/8lXUtSxP4rQlfUz1uF1VolSbuIkg2TZO2b8x7xa41O
         4zMjB4Zpy0GoMAto1EoCMOtqIkbv4FM0rTE0Ts7gyFzVXOTZS+8UfWt6MkOkb/do1Dar
         ZtTPttJ17AYQLiY6VwybG1G++du2Wfp1nu7yojX3kuZIbc8GpjPgHQeFFVGcsfij0VN6
         rx+w==
X-Gm-Message-State: AOJu0YwxZe4Px3Mh/O11TcwhPUAxSXdBZq8cpvMykg5rtzyztedslY14
	P/LW3z63UYCPohsoxYNhxpfOP2sdJIv4zc9wcjKpMcytwTi90sNOWR93tYx62g==
X-Google-Smtp-Source: AGHT+IEoWDFJEWLLyfNOOcNAQO69wxXDeoE3NDFE/6nVWcyxeKdTpE9bWKe9TiAUfVBp/hdULye9zQ==
X-Received: by 2002:a17:902:dac6:b0:1d4:441e:7377 with SMTP id q6-20020a170902dac600b001d4441e7377mr1612768plx.40.1705623253562;
        Thu, 18 Jan 2024 16:14:13 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id mj7-20020a1709032b8700b001d1d1ef8be6sm1921238plb.267.2024.01.18.16.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 16:14:13 -0800 (PST)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Song Liu <song@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v4 1/4] perf/bpf: Call bpf handler directly, not through overflow machinery
Date: Thu, 18 Jan 2024 16:13:48 -0800
Message-Id: <20240119001352.9396-2-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119001352.9396-1-khuey@kylehuey.com>
References: <20240119001352.9396-1-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To ultimately allow bpf programs attached to perf events to completely
suppress all of the effects of a perf event overflow (rather than just the
sample output, as they do today), call bpf_overflow_handler() from
__perf_event_overflow() directly rather than modifying struct perf_event's
overflow_handler. Return the bpf program's return value from
bpf_overflow_handler() so that __perf_event_overflow() knows how to
proceed. Remove the now unnecessary orig_overflow_handler from struct
perf_event.

This patch is solely a refactoring and results in no behavior change.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Song Liu <song@kernel.org>
---
 include/linux/perf_event.h |  6 +-----
 kernel/events/core.c       | 28 +++++++++++++++-------------
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d2a15c0c6f8a..c7f54fd74d89 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -810,7 +810,6 @@ struct perf_event {
 	perf_overflow_handler_t		overflow_handler;
 	void				*overflow_handler_context;
 #ifdef CONFIG_BPF_SYSCALL
-	perf_overflow_handler_t		orig_overflow_handler;
 	struct bpf_prog			*prog;
 	u64				bpf_cookie;
 #endif
@@ -1357,10 +1356,7 @@ __is_default_overflow_handler(perf_overflow_handler_t overflow_handler)
 #ifdef CONFIG_BPF_SYSCALL
 static inline bool uses_default_overflow_handler(struct perf_event *event)
 {
-	if (likely(is_default_overflow_handler(event)))
-		return true;
-
-	return __is_default_overflow_handler(event->orig_overflow_handler);
+	return is_default_overflow_handler(event);
 }
 #else
 #define uses_default_overflow_handler(event) \
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f0f0f71213a1..24a718e7eb98 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9548,6 +9548,12 @@ static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *r
 	return true;
 }
 
+#ifdef CONFIG_BPF_SYSCALL
+static int bpf_overflow_handler(struct perf_event *event,
+				struct perf_sample_data *data,
+				struct pt_regs *regs);
+#endif
+
 /*
  * Generic event overflow handling, sampling.
  */
@@ -9617,7 +9623,10 @@ static int __perf_event_overflow(struct perf_event *event,
 		irq_work_queue(&event->pending_irq);
 	}
 
-	READ_ONCE(event->overflow_handler)(event, data, regs);
+#ifdef CONFIG_BPF_SYSCALL
+	if (!(event->prog && !bpf_overflow_handler(event, data, regs)))
+#endif
+		READ_ONCE(event->overflow_handler)(event, data, regs);
 
 	if (*perf_event_fasync(event) && event->pending_kill) {
 		event->pending_wakeup = 1;
@@ -10427,9 +10436,9 @@ static void perf_event_free_filter(struct perf_event *event)
 }
 
 #ifdef CONFIG_BPF_SYSCALL
-static void bpf_overflow_handler(struct perf_event *event,
-				 struct perf_sample_data *data,
-				 struct pt_regs *regs)
+static int bpf_overflow_handler(struct perf_event *event,
+				struct perf_sample_data *data,
+				struct pt_regs *regs)
 {
 	struct bpf_perf_event_data_kern ctx = {
 		.data = data,
@@ -10450,10 +10459,8 @@ static void bpf_overflow_handler(struct perf_event *event,
 	rcu_read_unlock();
 out:
 	__this_cpu_dec(bpf_prog_active);
-	if (!ret)
-		return;
 
-	event->orig_overflow_handler(event, data, regs);
+	return ret;
 }
 
 static int perf_event_set_bpf_handler(struct perf_event *event,
@@ -10489,8 +10496,6 @@ static int perf_event_set_bpf_handler(struct perf_event *event,
 
 	event->prog = prog;
 	event->bpf_cookie = bpf_cookie;
-	event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
-	WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
 	return 0;
 }
 
@@ -10501,7 +10506,6 @@ static void perf_event_free_bpf_handler(struct perf_event *event)
 	if (!prog)
 		return;
 
-	WRITE_ONCE(event->overflow_handler, event->orig_overflow_handler);
 	event->prog = NULL;
 	bpf_prog_put(prog);
 }
@@ -11975,13 +11979,11 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		overflow_handler = parent_event->overflow_handler;
 		context = parent_event->overflow_handler_context;
 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
-		if (overflow_handler == bpf_overflow_handler) {
+		if (parent_event->prog) {
 			struct bpf_prog *prog = parent_event->prog;
 
 			bpf_prog_inc(prog);
 			event->prog = prog;
-			event->orig_overflow_handler =
-				parent_event->orig_overflow_handler;
 		}
 #endif
 	}
-- 
2.34.1

