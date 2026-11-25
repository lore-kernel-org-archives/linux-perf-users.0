Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587378;
	b=d48biPoo/A3tz8aZAlQd8J9lNoP48NLesbH3eH67cRrmOgXTNotXX7JuriBdMcyHyg4T
	 uOmyawuuQL+85y7bJVKCPxfDJVKNLpR7B8emMgWn5sROoBvuGjZj1o7JM+18hzUnro+Iy
	 u31KcbHJLAJqH4seB+fYgb+Ed6eMN1LPjRzTRz291QsFaX12u0kyVyy0DtJ2bYElnoTjl
	 5+owLIk9FXLP8i1nZ/+hixtnA8c84uXFXCtWk2XHjz0URl6RV/RZlKQtpghWHtr/pmjaZ
	 06ckWlorR9QmOnj0l3MjjDvJvPjVaCrf9aEwVFbTBRUFNiwLsekR1iBOvcO3uhqxwQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=09MAmcu0nJvDv2rEHeASXKSxzXy8pllt4XI/+xpi/1s=;
	b=dSoJnOXmwn8BhuJ++OhkLwE4aDRXCe0+32+TSGqCFPJeUYRkXGLzIftDeyGbXYInLM79
	 EDQDuG3TAYqsnHPJ50+bSPFRKlUto55MhTns+Ypo/dHVFCuAOfyuPxXFfg2DfdIY+Zvx1
	 NjoEOac9ZlN/MLuKWQenGj7zTRrUXiy/c5C+pPRAltTUFp9jGtytGFZ25tN7EGDmNC1QE
	 2Du/9B7Z+9HLtpFVwHagaqDF4U783oQ4Ud6OLMsqOcqaXUBA5KDmlk2a0S8UpoCD/j8gJ
	 WASrwHhPq+MJPu/Vw0LR2OpLECP1WMCXDgwxSxQC/qqX2Vl+SirDepmZ+9wwB1U7jNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hRuoW9J8;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3978460A382E
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 06:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3978460A382E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hRuoW9J8
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-384c78aa0dbso7370460eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 22:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795587377; x=1796192177; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=09MAmcu0nJvDv2rEHeASXKSxzXy8pllt4XI/+xpi/1s=;
        b=hRuoW9J8UJ5yS/JbLIPTKOa778F9ZokFaUcinY54/eCRvUv6mGjwCMD0feOmkcMbLJ
         7/tSKllEbV27lrjk0ZY+RCDtM0uL8at9+R5XeYGH3AmiziDmJdtx9B6UaHGW/VIvV/00
         VedPE+5Z6xF3Z1wOEOz/Io4w8fgtaCQGWPvWqVJzP6AZLyK5Kx/vc7EzMY1E1imbfIKt
         XMcdEpABCqSsMZwhJyT5A0yBC+xGgBW7fWDDgoOEJAUrZJXrZZ8OITnTOnIl0ZCnQ1NB
         LlcHvEUyU5R+tM9y4sTahYg/orpjOBqsXC/TrGgUMsyiLHFFB40cNCohzAldAZ5Zkege
         K1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587377; x=1796192177;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=09MAmcu0nJvDv2rEHeASXKSxzXy8pllt4XI/+xpi/1s=;
        b=MhKdqune9RVOhAlQ4dGjuZSNfZrvZJfqR8yVWCfoHiTDhdrj/2l9vXnczKcor+jxx8
         9gB5l3LPHthdX7LKAHtpUuopSRBYEH51O6hppZ/+dUBGJd3ql92TxthFKTqb8NvGhR8t
         7vTLqqcJQXunyIySUBT6A4r5Fs4CBrckyDELLaZj3q5E8wyS9cSw7EnqUemBynEVwevO
         6M3/vEgwez3cglQTSfgFQ+ry0XqLMtKLKH44TdzAi65aUIYq2bkaUgBZ3ABuNWhIMKdA
         eGh4PgkaGOZIc1mtsKsVlOljvt4APEXudsv0D/drTXEMDpSZ77Q6JcI0VMDHNhTzgxHJ
         E52w==
X-Forwarded-Encrypted: i=1; AL+hErEVvmjYeWjEQhsku4LYfOfoL5cnoBq9tY8aRvf6ftjbDyoJZauIb3dGyw9v+x07M4VLmwpKa0CLR5nUF71R7bMd@vger.kernel.org
X-Gm-Message-State: APuU4Z+F5QXTKlor+raOof5YWrCnuRpH010jTBbJJlg+RdE9qMWlVqQM
	Y2qEO3uT5rRMtHpizusJU1GdCnX+aLECTSYTYEP/nkBdwFTro9601qLLC7gDC9QEFt/d9lDmcAx
	JNJMnfvSKhg==
X-Received: from dyba9.prod.google.com ([2002:a05:693c:63c9:b0:386:a06c:3241])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:c72d:b0:369:f9c4:1fda
 with SMTP id 5a478bee46e88-38570845628mr15750428eec.27.1795587377097; Tue, 24
 Nov 2026 22:16:17 -0800 (PST)
Date: Tue, 24 Nov 2026 22:15:03 -0800
In-Reply-To: <20261125061523.1540234-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125061523.1540234-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125061523.1540234-11-irogers@google.com>
Subject: [RFC PATCH v2 10/30] tracing: Skip internal ftrace frames under CONFIG_UNWINDER_DWARF_CFI
From: Ian Rogers <irogers@google.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org
Cc: jpoimboe@kernel.org, rostedt@goodmis.org, peterz@infradead.org, 
	mingo@redhat.com, tglx@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, mhiramat@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	nathan@kernel.org, llvm@lists.linux.dev, nsc@kernel.org, 
	linux-kbuild@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, ardb@kernel.org, linux-efi@vger.kernel.org, 
	maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, indu.bhagat@oracle.com, jremus@linux.ibm.com, 
	wnliu@google.com, dylanbhatch@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Calibrate ftrace internal stack-trace skip counts under
CONFIG_UNWINDER_DWARF_CFI alongside CONFIG_UNWINDER_ORC so stack traces
captured from tracepoints and function tracers omit internal ftrace
wrapper frames consistently.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/trace/trace.c                | 4 ++--
 kernel/trace/trace_events_trigger.c | 2 +-
 kernel/trace/trace_functions.c      | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 65b9d67647e5..6d36c790c2b0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2156,7 +2156,7 @@ void __ftrace_trace_stack(struct trace_array *tr,
 	 * Add one, for this function and the call to save_stack_trace()
 	 * If regs is set, then these functions will not be in the way.
 	 */
-#ifndef CONFIG_UNWINDER_ORC
+#if !defined(CONFIG_UNWINDER_ORC) && !defined(CONFIG_UNWINDER_DWARF_CFI)
 	if (!regs)
 		skip++;
 #endif
@@ -2258,7 +2258,7 @@ void trace_dump_stack(int skip)
 	if (tracing_disabled || tracing_selftest_running)
 		return;
 
-#ifndef CONFIG_UNWINDER_ORC
+#if !defined(CONFIG_UNWINDER_ORC) && !defined(CONFIG_UNWINDER_DWARF_CFI)
 	/* Skip 1 to skip this function. */
 	skip++;
 #endif
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index a2487ad7fef8..c79df5b526e5 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1597,7 +1597,7 @@ static __init int register_trigger_snapshot_cmd(void) { return 0; }
 #endif /* CONFIG_TRACER_SNAPSHOT */
 
 #ifdef CONFIG_STACKTRACE
-#ifdef CONFIG_UNWINDER_ORC
+#if defined(CONFIG_UNWINDER_ORC) || defined(CONFIG_UNWINDER_DWARF_CFI)
 /* Skip 2:
  *   event_triggers_post_call()
  *   trace_event_raw_event_xxx()
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index acaba990aaaa..d601fdedceaa 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -251,7 +251,7 @@ function_args_trace_call(unsigned long ip, unsigned long parent_ip,
 	ftrace_test_recursion_unlock(bit);
 }
 
-#ifdef CONFIG_UNWINDER_ORC
+#if defined(CONFIG_UNWINDER_ORC) || defined(CONFIG_UNWINDER_DWARF_CFI)
 /*
  * Skip 2:
  *
@@ -602,7 +602,7 @@ ftrace_traceoff(unsigned long ip, unsigned long parent_ip,
 	tracer_tracing_off(tr);
 }
 
-#ifdef CONFIG_UNWINDER_ORC
+#if defined(CONFIG_UNWINDER_ORC) || defined(CONFIG_UNWINDER_DWARF_CFI)
 /*
  * Skip 3:
  *
-- 
2.56.1.831.g720f3f5937-goog

