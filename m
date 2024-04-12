Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12090DF55
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Apr 2024 01:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712886649; cv=none; b=O5FmBSSAMWBwf5rHaKmFg0xq5tp9g5f50B9mWNhLnln5gZwJr6KXpxeWAWPtm+ujMT1SuUvw7cYm0ENU6/v1YgkzCBtW6fs7jIssRXigibTcytsQEWpLVcZdcDBGbpv9CoD0hBKyunAuVkg4qncfqaHzdaZBjZN8sA9dGcPcm0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712886649; c=relaxed/simple;
	bh=lLcJXMGYAt18ckXzjBJt3RZcIlon0AJDakZC8+N8M0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iM9qVG/vIzSO+MrSiALbWSV/oFP1zc21wqonD9fZMA4RCljrfVDocT6jNrYR5v/+5uopvPtkMLw6c26DrvmuebqSzipEEAXb7CnuRWRqbww2k+A7fyWsLseHgNdT+NPbj/B9HAUY6NpmVq6WulhBOvtn8xNDrvNBQKhQtmmgEf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=FQ3BuQZb; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="FQ3BuQZb"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78ebc7e1586so148637185a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 18:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1712886646; x=1713491446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2I8ioTIE3St0NCO304/67c5ZZcTg34djE+ltGa2DGgk=;
        b=FQ3BuQZb8LtOhmt890Bmeq2fPTjqyrHlVC00FaR2K+bSiNS5ffhWMIBCbKqWbCoF9a
         yTKEojGuNSBLHgeauasteqnUs7ZXlVqVebsjOuOToLwj2QxBsBLCTIrm1YgnQ4ZdptSY
         Kn0JB14JBHBz64zM4H39qMyt7yft6iJNslfW7EP1u006R86EdrKnRdvwl1GqckKj6Ie2
         bmgYnPNGoRRPQnX0i07qpCzGA/iBz/eNkYm2z65qVVDMY6G7ohPS6eRhxyOMeMtXrw90
         /p4V0rsU/WxnRWomdyk0/CjfkbhOjQ+wcY/Gtshn6HRziwKWDkEIHi6FpxzvGm7vATrB
         pbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712886646; x=1713491446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2I8ioTIE3St0NCO304/67c5ZZcTg34djE+ltGa2DGgk=;
        b=mVdVHnpHNBI3/pQ2yuKQFi98A4OMgZ57bl4R9LClyWos3EJI33p3SjI3AdFhVkxViq
         8L4w4LiSANpZjdy9F+Z/3nRIP0UUj5kLFK9/fg3ovAF/tuSs1J0xplBKMHb6t0DaIjxs
         9JvHhn+xx+dXd+HvuTK6Lf/jltshO2eKByYeHTr7x9CXPRaDBzEvNsqm7EIdd8vQRDrg
         qDLt2FQHVZv0NenDW0cXnFGi48gZIG5ip+42i/ol9h41o3I2UWtkOhIuSXNuTZy/79mp
         HGJjxafsv2J+wPSAoap72HPZeiJKIDu/JTY0bC6wI4RQhmJm9a12mXtWmgptYiPjtwyp
         me2w==
X-Forwarded-Encrypted: i=1; AJvYcCX8xrpDfqmLwqwiMHlIMcuNSzzjaG2MOsIaFIjbs1RHUGmDaN8l7bs1uFWjzoBk+fEQylwV/SqXu6vi8wkl7pWyk+5Np39XczQsbM4CtJ9xNA==
X-Gm-Message-State: AOJu0YyLxXoNXPCA0vhxwp38IWq9Tl8T60KqNqJ41e8oj71IKg+mWsgE
	BSpmH6CU/u5TMGlriFqsHJw3JBeLVCQ7exnZn3WExLDfuVgnq4h/Mq7ZcdMQDQ==
X-Google-Smtp-Source: AGHT+IEpPEvWFpAFcQSe+VQV8imp3rgz2Yo/hr1w0rVz+GPtikTxqKZX7MSio59IOMcIrmeqvbBuxg==
X-Received: by 2002:a05:620a:4589:b0:78e:b996:db93 with SMTP id bp9-20020a05620a458900b0078eb996db93mr3057028qkb.3.1712886646096;
        Thu, 11 Apr 2024 18:50:46 -0700 (PDT)
Received: from ip-172-31-44-15.us-east-2.compute.internal (ec2-52-15-100-147.us-east-2.compute.amazonaws.com. [52.15.100.147])
        by smtp.googlemail.com with ESMTPSA id f10-20020a05620a15aa00b0078d76c1178esm1756677qkk.119.2024.04.11.18.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 18:50:45 -0700 (PDT)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	bpf@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v6 1/7] perf/bpf: Reorder bpf_overflow_handler() ahead of __perf_event_overflow()
Date: Thu, 11 Apr 2024 18:50:13 -0700
Message-Id: <20240412015019.7060-2-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412015019.7060-1-khuey@kylehuey.com>
References: <20240412015019.7060-1-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will allow __perf_event_overflow() to call bpf_overflow_handler().

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 kernel/events/core.c | 183 ++++++++++++++++++++++---------------------
 1 file changed, 92 insertions(+), 91 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 724e6d7e128f..ee025125a681 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9544,6 +9544,98 @@ static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *r
 	return true;
 }
 
+#ifdef CONFIG_BPF_SYSCALL
+static void bpf_overflow_handler(struct perf_event *event,
+				 struct perf_sample_data *data,
+				 struct pt_regs *regs)
+{
+	struct bpf_perf_event_data_kern ctx = {
+		.data = data,
+		.event = event,
+	};
+	struct bpf_prog *prog;
+	int ret = 0;
+
+	ctx.regs = perf_arch_bpf_user_pt_regs(regs);
+	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1))
+		goto out;
+	rcu_read_lock();
+	prog = READ_ONCE(event->prog);
+	if (prog) {
+		perf_prepare_sample(data, event, regs);
+		ret = bpf_prog_run(prog, &ctx);
+	}
+	rcu_read_unlock();
+out:
+	__this_cpu_dec(bpf_prog_active);
+	if (!ret)
+		return;
+
+	event->orig_overflow_handler(event, data, regs);
+}
+
+static int perf_event_set_bpf_handler(struct perf_event *event,
+				      struct bpf_prog *prog,
+				      u64 bpf_cookie)
+{
+	if (event->overflow_handler_context)
+		/* hw breakpoint or kernel counter */
+		return -EINVAL;
+
+	if (event->prog)
+		return -EEXIST;
+
+	if (prog->type != BPF_PROG_TYPE_PERF_EVENT)
+		return -EINVAL;
+
+	if (event->attr.precise_ip &&
+	    prog->call_get_stack &&
+	    (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) ||
+	     event->attr.exclude_callchain_kernel ||
+	     event->attr.exclude_callchain_user)) {
+		/*
+		 * On perf_event with precise_ip, calling bpf_get_stack()
+		 * may trigger unwinder warnings and occasional crashes.
+		 * bpf_get_[stack|stackid] works around this issue by using
+		 * callchain attached to perf_sample_data. If the
+		 * perf_event does not full (kernel and user) callchain
+		 * attached to perf_sample_data, do not allow attaching BPF
+		 * program that calls bpf_get_[stack|stackid].
+		 */
+		return -EPROTO;
+	}
+
+	event->prog = prog;
+	event->bpf_cookie = bpf_cookie;
+	event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
+	WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
+	return 0;
+}
+
+static void perf_event_free_bpf_handler(struct perf_event *event)
+{
+	struct bpf_prog *prog = event->prog;
+
+	if (!prog)
+		return;
+
+	WRITE_ONCE(event->overflow_handler, event->orig_overflow_handler);
+	event->prog = NULL;
+	bpf_prog_put(prog);
+}
+#else
+static int perf_event_set_bpf_handler(struct perf_event *event,
+				      struct bpf_prog *prog,
+				      u64 bpf_cookie)
+{
+	return -EOPNOTSUPP;
+}
+
+static void perf_event_free_bpf_handler(struct perf_event *event)
+{
+}
+#endif
+
 /*
  * Generic event overflow handling, sampling.
  */
@@ -10422,97 +10514,6 @@ static void perf_event_free_filter(struct perf_event *event)
 	ftrace_profile_free_filter(event);
 }
 
-#ifdef CONFIG_BPF_SYSCALL
-static void bpf_overflow_handler(struct perf_event *event,
-				 struct perf_sample_data *data,
-				 struct pt_regs *regs)
-{
-	struct bpf_perf_event_data_kern ctx = {
-		.data = data,
-		.event = event,
-	};
-	struct bpf_prog *prog;
-	int ret = 0;
-
-	ctx.regs = perf_arch_bpf_user_pt_regs(regs);
-	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1))
-		goto out;
-	rcu_read_lock();
-	prog = READ_ONCE(event->prog);
-	if (prog) {
-		perf_prepare_sample(data, event, regs);
-		ret = bpf_prog_run(prog, &ctx);
-	}
-	rcu_read_unlock();
-out:
-	__this_cpu_dec(bpf_prog_active);
-	if (!ret)
-		return;
-
-	event->orig_overflow_handler(event, data, regs);
-}
-
-static int perf_event_set_bpf_handler(struct perf_event *event,
-				      struct bpf_prog *prog,
-				      u64 bpf_cookie)
-{
-	if (event->overflow_handler_context)
-		/* hw breakpoint or kernel counter */
-		return -EINVAL;
-
-	if (event->prog)
-		return -EEXIST;
-
-	if (prog->type != BPF_PROG_TYPE_PERF_EVENT)
-		return -EINVAL;
-
-	if (event->attr.precise_ip &&
-	    prog->call_get_stack &&
-	    (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) ||
-	     event->attr.exclude_callchain_kernel ||
-	     event->attr.exclude_callchain_user)) {
-		/*
-		 * On perf_event with precise_ip, calling bpf_get_stack()
-		 * may trigger unwinder warnings and occasional crashes.
-		 * bpf_get_[stack|stackid] works around this issue by using
-		 * callchain attached to perf_sample_data. If the
-		 * perf_event does not full (kernel and user) callchain
-		 * attached to perf_sample_data, do not allow attaching BPF
-		 * program that calls bpf_get_[stack|stackid].
-		 */
-		return -EPROTO;
-	}
-
-	event->prog = prog;
-	event->bpf_cookie = bpf_cookie;
-	event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
-	WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
-	return 0;
-}
-
-static void perf_event_free_bpf_handler(struct perf_event *event)
-{
-	struct bpf_prog *prog = event->prog;
-
-	if (!prog)
-		return;
-
-	WRITE_ONCE(event->overflow_handler, event->orig_overflow_handler);
-	event->prog = NULL;
-	bpf_prog_put(prog);
-}
-#else
-static int perf_event_set_bpf_handler(struct perf_event *event,
-				      struct bpf_prog *prog,
-				      u64 bpf_cookie)
-{
-	return -EOPNOTSUPP;
-}
-static void perf_event_free_bpf_handler(struct perf_event *event)
-{
-}
-#endif
-
 /*
  * returns true if the event is a tracepoint, or a kprobe/upprobe created
  * with perf_event_open()
-- 
2.34.1

