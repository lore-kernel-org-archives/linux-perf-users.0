Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB0A33F5A5
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 06:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786601150; cv=none; b=hfaEhgsZly7IRw00+rTEmtX0fgh69NVLIPxJv2pLiWseAevpIbOcdPHZUH07AKxIUtaQR2zpr3K7Nnpl9orwDEc4k1KIAFzQNfvwrlBQ73iEiRaBF3htBbQbzI6tMsXs46UZmjszx/lIIAhdIFYMx8Asv4o0+g+/lsFGTmLJCDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786601150; c=relaxed/simple;
	bh=gd+4LCjUbkx1vP7VWW7agRjbCyduRFoFkXIFhYOn71w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=siM1dmFcos10riYHQafykFVERthi9cdgEpy/n/maKp9kCMMAUU8McJlB5mhqKpPKN4AtZJpak1V54njcgIMSGRRXUYOwkpfuGmI7LlOXT9u+WhF1UsyQi6AIUUU5LKHEdN+xNasXONS6xfQce0it6JYxmej0p2Ku+Bxo9bgI0G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YT8OmAsf; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YT8OmAsf"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3811f512167so2299004a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 23:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786601148; x=1787205948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+DYOovTJldgmLOYu4jYgvpEtdbhEO2kLDnKjhxMcLho=;
        b=YT8OmAsf5ho7jPHZS+E0G90CuH6hAfggfcVXcq26Ohavalz773kRSGkGD2kcJTNusW
         Fvz6bQ5IyEzbFk+5BHsrQ6onV16zYG3DX0x/g3FcKLv77pWkzWoWdlCtdJ9/xPIA91wx
         3bhULHdK/52hYHmDAwmeKvjLBytkDWMYf2Sokwe7wXSXrqTrt9yKjo7IGufnCGD1DOPx
         w1ZBc8atkCApDikiJrrdHPYPhUC5MVvh1Y2d3njXogtAzNJ39D4jtWq4Yy44bN4KW/TR
         7ytizjjaFvWDSoTlTsF9ASTo+UmIWK7GkJb1dDHvTwC4eiBLg+jqZVuqtLadZnZXOA7C
         6eNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786601148; x=1787205948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+DYOovTJldgmLOYu4jYgvpEtdbhEO2kLDnKjhxMcLho=;
        b=ZTUd56x5AgBAtd+NZxEMQVcH65TXUqnRZTR6RS2lAfB5DZVy/3Ekw8in6P7qbLEaXS
         eHWJRM3Az69Qelp7NF7xnRwZL7ywSUm0V3wODNPN/Be1gZcj4XS4L0CZrnk/O4jQKXux
         ZPGbFwtG5jVcq0tKilyhCH+/j53tjSe1Qko9VpR2UBwLq/untLlW8sap9fYAMxT2vSyl
         Ca66YYv9YwwfpTug5Kc6BL5rs+KCZceotvJAbSaC/333wMvj0UnvShom5Zhb+Yiy9xC9
         qKwJaieXl/wRRHYi/6MkBoR3R9wU20HfEWOCe1AFk/pfGuHvYtau/2yl6VeC8luqbXkE
         Cryg==
X-Gm-Message-State: AOJu0YwF/QC7rCCcqI0XhvhJ7exYIJ23nUd1wOkXYZ+bklzbIMx2O0p3
	i7VNqcto6ER8Sx8momnBSLTg2w0/3p7lPZ3R9XTYT0IBbTC7+97TxynQ
X-Gm-Gg: AR+sD12kc382CEfmLFb8FENoRi9KxUNYP6sq6o6cV44SEn30UYEFXF9nHt1vAkgQKxH
	j3GVkhyhN0ExcDpbzRm6emNyewJM7lBQPrMQC/Lu8WUNZGRW3NU8shjcxOSx7a6UZjSeKKGGBi1
	vBKenxqPbzbFwFlrgDKdwecwP5gJTfsEpZ66jTF6xeOpzeFc+9P4Ay1vqKiPGjHgaiyxsmA01E3
	e8lZPScHeQKTTm7w0xxwmrOF8p5JSMjrMS7Id9Kz6lVNE+AHl3B7OGk4uUZuKvWo0J//dowZ8hY
	FHCWGSFugprGIO4aPloWNGhKUWfyDRApF575oUybXbTGkG6VIT6KFOIbeGSWlqoWwPeaYm+6ZkE
	fvgI92i9RewuiEuZRFkjvDevZjH/OlTrlqzslfeOXTtgEp3CxX63JUk+y4eyQ18oDn8J7kyHrVx
	WckJ+RGmLzYNqr9bQ3P5XX8fXeCXJOKJZuMtdf0j/YFV5Y8/ay1fA70afloB0/VFAHSbAmM6zfs
	nzphAVvXthKcGGar6fWudlmcVKDroNnOssXfc0hdPvW+9u/nOFhjg==
X-Received: by 2002:a17:90b:33c6:b0:37f:ed7e:7e42 with SMTP id 98e67ed59e1d1-3931e298274mr3295644a91.14.1786601147820;
        Wed, 12 Aug 2026 23:05:47 -0700 (PDT)
Received: from deepanshu-Legion-Pro-5-16AFR10.. ([2405:201:682f:383f:229c:e2c9:8c03:c9c1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ec0223e31sm3712487eec.25.2026.08.12.23.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 23:05:47 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	olsajiri@gmail.com,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	song@kernel.org,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+651d2774bd1d8395595f@syzkaller.appspotmail.com
Subject: [PATCH v2] perf/bpf: Fix data races in BPF perf event handling
Date: Thu, 13 Aug 2026 11:35:28 +0530
Message-ID: <20260813060528.365959-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix multiple data races involving event->prog field:

1. __perf_event_overflow() reads event->prog twice without
   synchronization creating a TOCTOU race. Fix by using READ_ONCE()
   to capture prog into a local variable and pass it directly to
   bpf_overflow_handler() to avoid a second read inside that function.

2. perf_event_set_bpf_handler() and perf_event_free_bpf_handler()
   perform plain writes to event->prog without WRITE_ONCE(), failing
   to pair with the READ_ONCE() in __perf_event_overflow(). Fix by
   using WRITE_ONCE() in all write paths including
   perf_event_detach_bpf_prog().

3. perf_event_alloc() reads parent_event->prog locklessly during
   fork() which can race with a concurrent detach clearing and freeing
   the prog, potentially causing a NULL pointer dereference or
   use-after-free in bpf_prog_inc(). Fix by holding bpf_event_mutex
   when inheriting the BPF program. Make bpf_event_mutex non-static
   and declare it extern in perf_event.h so it is accessible from
   kernel/events/core.c.

Reported-by: syzbot+651d2774bd1d8395595f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=651d2774bd1d8395595f
Link: https://lore.kernel.org/all/20260811235331.10044-1-kartikey406@gmail.com/T/ [v1]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v2:
- Pass validated prog pointer directly to bpf_overflow_handler()
  to avoid TOCTOU race from second READ_ONCE() inside the handler
- Add WRITE_ONCE() to perf_event_set_bpf_handler() and
  perf_event_free_bpf_handler() to pair with READ_ONCE() in overflow
- Fix lockless access in perf_event_alloc() during fork() by holding
  bpf_event_mutex to prevent concurrent detach UAF
- Make bpf_event_mutex non-static and export via perf_event.h
---
 include/linux/perf_event.h |  2 ++
 kernel/events/core.c       | 23 +++++++++++++----------
 kernel/trace/bpf_trace.c   |  4 ++--
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 48d851fbd8ea..5c6dabb6dccb 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -2136,4 +2136,6 @@ static inline void perf_lopwr_cb(bool mode)
 }
 #endif
 
+extern struct mutex bpf_event_mutex;
+
 #endif /* _LINUX_PERF_EVENT_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index ba5bd6a78fe7..6f8d3b57fa01 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10652,20 +10652,19 @@ static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *r
 #ifdef CONFIG_BPF_SYSCALL
 static int bpf_overflow_handler(struct perf_event *event,
 				struct perf_sample_data *data,
-				struct pt_regs *regs)
+				struct pt_regs *regs,
+				struct bpf_prog *prog)
 {
 	struct bpf_perf_event_data_kern ctx = {
 		.data = data,
 		.event = event,
 	};
-	struct bpf_prog *prog;
 	int ret = 0;
 
 	ctx.regs = perf_arch_bpf_user_pt_regs(regs);
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1))
 		goto out;
 	rcu_read_lock();
-	prog = READ_ONCE(event->prog);
 	if (prog) {
 		perf_prepare_sample(data, event, regs);
 		ret = bpf_prog_run(prog, &ctx);
@@ -10708,7 +10707,7 @@ static inline int perf_event_set_bpf_handler(struct perf_event *event,
 		return -EPROTO;
 	}
 
-	event->prog = prog;
+	WRITE_ONCE(event->prog, prog);
 	event->bpf_cookie = bpf_cookie;
 	return 0;
 }
@@ -10720,7 +10719,7 @@ static inline void perf_event_free_bpf_handler(struct perf_event *event)
 	if (!prog)
 		return;
 
-	event->prog = NULL;
+	WRITE_ONCE(event->prog, NULL);
 	bpf_prog_put(prog);
 }
 #else
@@ -10753,6 +10752,7 @@ static int __perf_event_overflow(struct perf_event *event,
 {
 	int events = atomic_read(&event->event_limit);
 	int ret = 0;
+	struct bpf_prog *prog;
 
 	/*
 	 * Non-sampling counters might still use the PMI to fold short
@@ -10766,8 +10766,9 @@ static int __perf_event_overflow(struct perf_event *event,
 	if (event->attr.aux_pause)
 		perf_event_aux_pause(event->aux_event, true);
 
-	if (event->prog && event->prog->type == BPF_PROG_TYPE_PERF_EVENT &&
-	    !bpf_overflow_handler(event, data, regs))
+	prog = READ_ONCE(event->prog);
+	if (prog && prog->type == BPF_PROG_TYPE_PERF_EVENT &&
+	    !bpf_overflow_handler(event, data, regs, prog))
 		goto out;
 
 	/*
@@ -13433,12 +13434,15 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		overflow_handler = parent_event->overflow_handler;
 		context = parent_event->overflow_handler_context;
 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
-		if (parent_event->prog) {
-			struct bpf_prog *prog = parent_event->prog;
-
+		struct bpf_prog *prog;
+
+		mutex_lock(&bpf_event_mutex);
+		prog = parent_event->prog;
+		if (prog) {
 			bpf_prog_inc(prog);
 			event->prog = prog;
 		}
+		mutex_unlock(&bpf_event_mutex);
 #endif
 	}
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 75495a5c3507..026b5c492115 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1944,7 +1944,7 @@ const struct bpf_verifier_ops perf_event_verifier_ops = {
 const struct bpf_prog_ops perf_event_prog_ops = {
 };
 
-static DEFINE_MUTEX(bpf_event_mutex);
+DEFINE_MUTEX(bpf_event_mutex);
 
 #define BPF_TRACE_MAX_PROGS 64
 
@@ -2018,7 +2018,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 
 put:
 	prog = event->prog;
-	event->prog = NULL;
+	WRITE_ONCE(event->prog, NULL);
 
 unlock:
 	mutex_unlock(&bpf_event_mutex);
-- 
2.43.0

