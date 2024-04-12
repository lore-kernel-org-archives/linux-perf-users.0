Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61163168DE
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Apr 2024 01:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712886657; cv=none; b=M3hsqvfzAziin5wa6+iiv93sZqAjiZqpVzExc+VYV78OiKfwK/qKzCKXn2O6ryAAAC8OytYMdnKb34eFZ8E4UNGtOyR5W58S7b660F8lgDL/VKeutU5EKiW+EosLAsHuTvZWHAmBLHjEchIT9IySeuAqmuhwuEg5BG+ldwqtF+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712886657; c=relaxed/simple;
	bh=NRmEZmEzOcudL2cLJi5SCwBCdAXkrrS/5QKylKnvPRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NTwSrXOKS9eYh75YUd2cE4h8II47XHD2Hbde6u2kVC/zG3GXfiKzjDcskQnGMbVk419742sMXp9g/cvMrX+m4UiGN9nqu1sTIYZZbaVYsUy3nubQeegskjZUr+xTLCESxmGdcxj8mvUbgHQwShZVYkJ+MAcEaVFA3tm9nndcxUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=Xn8JkP7N; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="Xn8JkP7N"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78d57bd577dso33818485a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 18:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1712886655; x=1713491455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmAdJT3ZUCPeWfD1wo8jRuZywHZwwpve3RZWOW9haf0=;
        b=Xn8JkP7NU04LMLIgfilXIt3KHG4T6B1Vtz1uXM2qEKoiTj8FPRP5gA63Z4JLuoTKPa
         BUCWI7e4/gN7/ilOtU16JGX26IzFpvJhhRBiifpadbzRHLLNNWEz77cpp/tY5gns7cFx
         8f2/jiQ7kCpX4O9YskqqC9JsIQclJSMMziIFEKlzvOq4Dj33AT0moOJSK9wzjhpDcYoV
         2CGc8CYJNxGvgbZZifH8HPnX0bJnIyQRxFvt6+mW+opRh3QdiRdXr6+3MlH8+Lc+0ALI
         OYfgCe3oNsJ1PLp5eqiTM2Ehbs4QEtt4dwhtjWozsOXZ/Ej0ZcrY8tkoNTYEJ9jpDfXF
         Cpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712886655; x=1713491455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmAdJT3ZUCPeWfD1wo8jRuZywHZwwpve3RZWOW9haf0=;
        b=S+ZGpuBCmYIKWq9mo1GOt2JpTa2SIlqQThKcbpk4vh7Qv/L8KCRL9h1wmF9Mdtf4Dv
         o8+QFArJPiR/azyed0SAYASFm1XlcMAnPR3fFKol9auupu6vz1sJc/Kvwm+HovMkvzlt
         85iKvUB1FqZiXeh4qgtqsVynWla5UBkOH3YEGvns7QTmavP2cFBfsxxT5S3pBfMi/cNH
         7AhJXvHKa2z+TWfFlii0asyJ4kEZx9ybEdU7pupY0i7ouchl+R/Mysm2Hm4YcOwMxhez
         cp/fQ7zuWiwza9xzRUOTxaUljKouRpiXicSks0Ndp33KvfmJpLcoFYLoeOS/tHwWPVCC
         gXAg==
X-Forwarded-Encrypted: i=1; AJvYcCUBwwpogANPVU/l4v3T9tPQ/Nuw94yF/aliHLB3wpfI6nDaJIIuWQm+0AwbXyIHj5qhrWfJw1LF5Ib9jL5M59nbA0NYAbnCpJN0p8xopttjoA==
X-Gm-Message-State: AOJu0YwT0aLI7fVdHsHK+aAZByW64gTkl5qum5QSOa5EQisNh0oKJ/R+
	5gFRxgd+shd1xS6fWO4FbG2XxwrSzY+R87e3WvWpV4DNcONxAvT0Wtk5JI4tVQ==
X-Google-Smtp-Source: AGHT+IH1CdfzeVz3pZajhCl9CVe8VCWrOdYFKQJn9dqM+zf6JXUpBa7+69QfvqWLEhWCHiBE2XF4sw==
X-Received: by 2002:a05:620a:2211:b0:78d:68d6:c1e9 with SMTP id m17-20020a05620a221100b0078d68d6c1e9mr1314228qkh.47.1712886655388;
        Thu, 11 Apr 2024 18:50:55 -0700 (PDT)
Received: from ip-172-31-44-15.us-east-2.compute.internal (ec2-52-15-100-147.us-east-2.compute.amazonaws.com. [52.15.100.147])
        by smtp.googlemail.com with ESMTPSA id f10-20020a05620a15aa00b0078d76c1178esm1756677qkk.119.2024.04.11.18.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 18:50:55 -0700 (PDT)
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
	Will Deacon <will@kernel.org>,
	Song Liu <song@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v6 5/7] perf/bpf: Remove unneeded uses_default_overflow_handler()
Date: Thu, 11 Apr 2024 18:50:17 -0700
Message-Id: <20240412015019.7060-6-khuey@kylehuey.com>
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

Now that struct perf_event's orig_overflow_handler is gone, there's no need
for the functions and macros to support looking past overflow_handler to
orig_overflow_handler.

This patch is solely a refactoring and results in no behavior change.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/arm/kernel/hw_breakpoint.c   |  8 ++++----
 arch/arm64/kernel/hw_breakpoint.c |  4 ++--
 include/linux/perf_event.h        | 17 +++--------------
 3 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index dc0fb7a81371..054e9199f30d 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -626,7 +626,7 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 	hw->address &= ~alignment_mask;
 	hw->ctrl.len <<= offset;
 
-	if (uses_default_overflow_handler(bp)) {
+	if (is_default_overflow_handler(bp)) {
 		/*
 		 * Mismatch breakpoints are required for single-stepping
 		 * breakpoints.
@@ -798,7 +798,7 @@ static void watchpoint_handler(unsigned long addr, unsigned int fsr,
 		 * Otherwise, insert a temporary mismatch breakpoint so that
 		 * we can single-step over the watchpoint trigger.
 		 */
-		if (!uses_default_overflow_handler(wp))
+		if (!is_default_overflow_handler(wp))
 			continue;
 step:
 		enable_single_step(wp, instruction_pointer(regs));
@@ -811,7 +811,7 @@ static void watchpoint_handler(unsigned long addr, unsigned int fsr,
 		info->trigger = addr;
 		pr_debug("watchpoint fired: address = 0x%x\n", info->trigger);
 		perf_bp_event(wp, regs);
-		if (uses_default_overflow_handler(wp))
+		if (is_default_overflow_handler(wp))
 			enable_single_step(wp, instruction_pointer(regs));
 	}
 
@@ -886,7 +886,7 @@ static void breakpoint_handler(unsigned long unknown, struct pt_regs *regs)
 			info->trigger = addr;
 			pr_debug("breakpoint fired: address = 0x%x\n", addr);
 			perf_bp_event(bp, regs);
-			if (uses_default_overflow_handler(bp))
+			if (is_default_overflow_handler(bp))
 				enable_single_step(bp, addr);
 			goto unlock;
 		}
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 2f5755192c2b..722ac45f9f7b 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -655,7 +655,7 @@ static int breakpoint_handler(unsigned long unused, unsigned long esr,
 		perf_bp_event(bp, regs);
 
 		/* Do we need to handle the stepping? */
-		if (uses_default_overflow_handler(bp))
+		if (is_default_overflow_handler(bp))
 			step = 1;
 unlock:
 		rcu_read_unlock();
@@ -734,7 +734,7 @@ static u64 get_distance_from_watchpoint(unsigned long addr, u64 val,
 static int watchpoint_report(struct perf_event *wp, unsigned long addr,
 			     struct pt_regs *regs)
 {
-	int step = uses_default_overflow_handler(wp);
+	int step = is_default_overflow_handler(wp);
 	struct arch_hw_breakpoint *info = counter_arch_bp(wp);
 
 	info->trigger = addr;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 65ad1294218f..13a2b05cc431 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1339,8 +1339,10 @@ extern int perf_event_output(struct perf_event *event,
 			     struct pt_regs *regs);
 
 static inline bool
-__is_default_overflow_handler(perf_overflow_handler_t overflow_handler)
+is_default_overflow_handler(struct perf_event *event)
 {
+	perf_overflow_handler_t overflow_handler = event->overflow_handler;
+
 	if (likely(overflow_handler == perf_event_output_forward))
 		return true;
 	if (unlikely(overflow_handler == perf_event_output_backward))
@@ -1348,19 +1350,6 @@ __is_default_overflow_handler(perf_overflow_handler_t overflow_handler)
 	return false;
 }
 
-#define is_default_overflow_handler(event) \
-	__is_default_overflow_handler((event)->overflow_handler)
-
-#ifdef CONFIG_BPF_SYSCALL
-static inline bool uses_default_overflow_handler(struct perf_event *event)
-{
-	return is_default_overflow_handler(event);
-}
-#else
-#define uses_default_overflow_handler(event) \
-	is_default_overflow_handler(event)
-#endif
-
 extern void
 perf_event_header__init_id(struct perf_event_header *header,
 			   struct perf_sample_data *data,
-- 
2.34.1

