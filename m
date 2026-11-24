Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543574;
	b=vlxpYXaw0UKUt/GyeuwjFAlYLj2Naee9wQmS7PW/NHW41Pz9yxaDDQDEQpiR0DHHC34I
	 NcT3vzP5Rksw9XEFt25HHkj48Goy0WBu8u5zFH2S/JHwAuwSi/t3SaFC8lINLbarUCfje
	 VYgOuCuYSkvB1cvsmuwoWSlFEeocXODGWz2DvAPX1inelfa9ko5D0Eq2zAkIpPzfLR8v1
	 KEMCTKhh35uFZKx0T1j8W3Pc0Bgwitif7wzSdbF3yyLFArSZyVPC+33qiCsbj5gCWm7Bv
	 CXL48YgHV7O9pkhMaw6s0vbPLJQln497yj0ygfSrypesqWmku2l/UwCP1bTYa+CjLAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=7ck3bvYq0JuHR0KSTuGO+L4BO12ACxxKzaaMbVsIpNc=;
	b=cAFNe7//IdPvtq/puI55hfo114Cxtp1ZY2u5G7IXtAG4hejEeDdpjkX0imUh4Hjc4ooR
	 e24xqtNHtuhM05vts/u0asi2Cpvffub81y2sPeQQLjmjrHN3zRU9a+94lxGjo3FKwKlst
	 QIWdM3YQXYr6QdtemcBv0ip+ZPB/CaqU8z29UIvZXzNyxuCIdgJ2wOaVuPTLSu7HiE3la
	 x3zQhtZEYn7G6fEb/a8ysMNUddqTiDwdkel3XXYd4aMp3ulHwCpMR5XD5VrKdXOUMrdv4
	 MI/AgWbx0U6LJILM50pEeHZyUcw89EpMs65esc0SOmcwiL657spMZcyiF0yUXTmOXFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WQl8PXbZ;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82123606A68C
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 18:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82123606A68C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WQl8PXbZ
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c4d58203e40so332210866b.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 10:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795543573; x=1796148373; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ck3bvYq0JuHR0KSTuGO+L4BO12ACxxKzaaMbVsIpNc=;
        b=WQl8PXbZ7xZLEvlGiDAQFntP7QoZBCdkBXdWYN/4Vep1KISFeiKajc87q8HRv6mhWA
         Jj+3p3H9e+Q7Bqsg6faEL4UTeOL+JkIOmJXSBxCZ3Xr/gSekNVeVkPAwhgaVsBt2wodq
         5z7ohlYFuNcU/OIF90MQ/zMt8yQWKyQulz/k5ozAzH+Jdej5tT+48Mp+jcCEdkU6Ui0X
         13EeXsJGImlljbwyJbAgy9QGNUm2hTumW2+5Um7M4jzbPGVl4sCHjFuVnDMD3DWmpmPp
         TVxMMdWPyDcpr7yCP7grTLAUKR+S/rzllL1JEEfDJiS7TmqXEf7+DP1USoXj5lk6lfpR
         JAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795543573; x=1796148373;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ck3bvYq0JuHR0KSTuGO+L4BO12ACxxKzaaMbVsIpNc=;
        b=cX/yjvFnjJGcVrp2d/1PDp3WhqVY8OlcqRD/05ZYwEHVTDGggTw9ytIRZ/Y+Qk4l7n
         li2Rmg7lZrw22iMFPVs2/2cFr0CcDldCR9Zw8fjD3jF7jKw50Fx86V50LynRl/XIsnMU
         No8t2HaGlTmSetW5frdVw04+nOsaIRYEe+SaeWVQly3aiKbu6/3H6ELD1Oc16+znaByH
         DvD9znGrBo7aN/+0F+Yx+xiiN04LjAapE/AVW23R9Nhedpt8WKrv81SyPsREwdT//LAg
         AOa0lv8gO++9xxrHxQWVRnlfN2DlNydQpj/M0bug1p6yEJLhXGLzG8Daf+LawQcKxWeI
         454A==
X-Forwarded-Encrypted: i=1; AL+hErHQ+0PJZURvNGYhpBppfH/0INDleM+tjtfyCIloD9D8T+56W55vviO6OuXYOxt1W5xGWr9rXQy+6ljuRTiCvXh+@vger.kernel.org
X-Gm-Message-State: APuU4Z9Cv9ModycaUZlYUZSzDIe3l16zJdRUouQM/lO+blymGo68c/AV
	8Qm9ym2McswmxzgZQPjwvm7utorhdM5btw6rpS3XzBaXW0er1AIrtPrG29msdAvhoanZAhJOrQ=
	=
X-Received: from ejoq20.prod.google.com ([2002:a17:906:5414:b0:c3f:f39:e5c9])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:4fc4:b0:c51:24a3:208
 with SMTP id a640c23a62f3a-c513a5da66bmr1211717066b.9.1795543572522; Tue, 24
 Nov 2026 10:06:12 -0800 (PST)
Date: Tue, 24 Nov 2026 18:06:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.663.g77904e546d
Message-ID: <20261124180611.75836-1-dmnk@google.com>
Subject: [PATCH v2] perf/core: check perf_allow_kernel() in PERF_EVENT_IOC_SET_FILTER
From: Dominik Maier <dmnk@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, dmnk+artist@google.com
Content-Type: text/plain; charset="UTF-8"

Under perf_event_paranoid = 2, an unprivileged caller can open a
task-scoped counting trace event (including tracepoints and tracefs
uprobes) with attr.exclude_kernel = 1 and attach trace event filters via
PERF_EVENT_IOC_SET_FILTER without passing perf_allow_kernel(). Trace
event filter predicates are parsed by create_filter() and support kernel
symbol and address matching (such as the .function modifier), exposing
kernel address information to callers that are not allowed kernel
profiling.

Require perf_allow_kernel() before applying trace event filters in
perf_event_set_filter().

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Dominik Maier <dmnk@google.com>
---
v2:
- Gate trace event filtering in perf_event_set_filter() with
  perf_allow_kernel() instead of only checking kallsyms_show_value() on
  numeric .function predicates in trace_events_filter.c (Steven Rostedt).
- v1: https://lore.kernel.org/linux-trace-kernel/20261119192233.2664654-1-dmnk@google.com/

Found with AI-assisted code review; tested in QEMU across root and
unprivileged callers at perf_event_paranoid = 1 and 2, and build-tested
with CONFIG_EVENT_TRACING both enabled and disabled.
 kernel/events/core.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e870f12c3ad8..e053de4c164c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12371,22 +12371,28 @@ static int perf_event_set_filter(struct perf_event *event, void __user *arg)
 
 #ifdef CONFIG_EVENT_TRACING
 	if (perf_event_is_tracing(event)) {
-		struct perf_event_context *ctx = event->ctx;
+		ret = perf_allow_kernel();
+		if (!ret) {
+			struct perf_event_context *ctx = event->ctx;
 
-		/*
-		 * Beware, here be dragons!!
-		 *
-		 * the tracepoint muck will deadlock against ctx->mutex, but
-		 * the tracepoint stuff does not actually need it. So
-		 * temporarily drop ctx->mutex. As per perf_event_ctx_lock() we
-		 * already have a reference on ctx.
-		 *
-		 * This can result in event getting moved to a different ctx,
-		 * but that does not affect the tracepoint state.
-		 */
-		mutex_unlock(&ctx->mutex);
-		ret = ftrace_profile_set_filter(event, event->attr.config, filter_str);
-		mutex_lock(&ctx->mutex);
+			/*
+			 * Beware, here be dragons!!
+			 *
+			 * the tracepoint muck will deadlock against ctx->mutex,
+			 * but the tracepoint stuff does not actually need it.
+			 * So temporarily drop ctx->mutex. As per
+			 * perf_event_ctx_lock() we already have a reference on
+			 * ctx.
+			 *
+			 * This can result in event getting moved to a different
+			 * ctx, but that does not affect the tracepoint state.
+			 */
+			mutex_unlock(&ctx->mutex);
+			ret = ftrace_profile_set_filter(event,
+							event->attr.config,
+							filter_str);
+			mutex_lock(&ctx->mutex);
+		}
 	} else
 #endif
 	if (has_addr_filter(event))
-- 
2.56.1.831.g720f3f5937-goog

