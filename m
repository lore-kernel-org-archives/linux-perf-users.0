Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FE0463B66
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 07:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581984; cv=none; b=JARJgq1e3/9zWqRQM9F/2UzlYYnORcsfML/VIpq+agdxzkTTXj4jYzHtItiVLZR4iA3kNYFI+pUQ5z6CArkyOc6VCQuGDlH/SaB8w3SyO+U/vo7uVzy8tVFOGeRwC4J+JMNOMXDXhHLsXaVAvOSwW0vW3t3LP0ct15/jS5BdF0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581984; c=relaxed/simple;
	bh=qS/64s7UXV7s5YZeFdYFiGpnPxcTWtQ0bA1KPXpc0is=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uxHjXCCmuzQYchC4I1PF5ALTv4xgmCb9JgFhu5k3xJDcO/itkX/zKFUHDuc3cBI4o5zAKRfKjWi3ujRzM5d6SFRb03+zaD8wUuHawe8H8LXZwBFZhKnaewMjSFcZZFqOCBo7DZaF/v8RXroeXAPCOMXP77oRqpSnyys6O6uIVm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hLUs/kyE; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hLUs/kyE"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1438492fb40so4051533c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 00:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790581982; x=1791186782; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kkotL9Czw56dRjk8bud34JjwcyKP/v3GUZy4zR9ty8o=;
        b=hLUs/kyEekm8HFNC/oLPg604bP+1udBY+vulgLME+jHTUTamwP+IaLMLfRjCL1LhTd
         PWsqb7yGPNfSlie5Hn00IuNWhYLJL9t3f79Z+e8FVjZR/DSYk635JNYUj9xXWiiao1QM
         Dopkbtm8s1tnbRNwszHQom3SDmR0gsLbp0kmzFYLnXtw68V/0xHyXOSljqX6HquukrL8
         sUazPAkekLbtT+AXT2JnB2UnYjlXNqJ2SoBoxYd0dG1JYqEcKxysZjLewJeR7nzrxnXt
         mS7qOV4aSpZo7OLMwHm0VHREE3YzCTgWyDpDYwhHDvCWp0WQoYCynD7hhbGOALmKuXwk
         PB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790581982; x=1791186782;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kkotL9Czw56dRjk8bud34JjwcyKP/v3GUZy4zR9ty8o=;
        b=YSe4JHiHWmjN8ah6iuB0gslaplD2YDiF8BqaqpXElALPMqhfTvxtcAj/2ty13lwmHN
         0ojR01P/k9f6K2Q77LzhOqyR5D4cfbMGUwvn8LQ6qMhq+GWQTecZm2cOUHUqutw3lzQj
         +vWJYdnH6K6IafdCaJdovt++KAZ0vWKoS3TwHEuNakEJm9q8OIvMqabC3OucoiW36R18
         2cqVfErZ3WrZbTylG9xR9JTDIVZ3fypZgYKs+qyl29eC6zpONfg7+RQUd1oYRWaCaYsO
         /3t2IoJeG1sBqTAlc6O9akjXvXRIDTWg6wxAvLFGqlyjWQZxic4dMpcrCZ7O6BpKMuNw
         CiQA==
X-Forwarded-Encrypted: i=1; AKwUvByCERjo8T3A2nL+Sv9hNLjl6BlvOBHp5YiYlEoKknCpEljfF8s4uGNe2B40IfCjj1f/6K4QL13tRHP6pA3RATyb@vger.kernel.org
X-Gm-Message-State: AFuF++k76vcKRqPtligZAeX1kc8RSflWG9L+z7awqmFwC79ofsnyPpTh
	1siGqmQI93gpoBedVdXvgkHAr8ndQirBBS2AWTxyKiN4gWffEJTAstOGAQ5UvAmZ1UpfkvpWuog
	+ysIM7oddMw==
X-Received: from dlbrl23.prod.google.com ([2002:a05:7022:f517:b0:144:d3ca:4610])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4343:b0:143:26ed:2dd4
 with SMTP id a92af1059eb24-146cfcd91c7mr7485512c88.30.1790581981253; Mon, 28
 Sep 2026 00:53:01 -0700 (PDT)
Date: Mon, 28 Sep 2026 00:52:36 -0700
In-Reply-To: <20260928075237.3055101-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928075237.3055101-7-irogers@google.com>
Subject: [PATCH v1 6/7] perf session: Periodically shrink symbols and DSOs
 during event processing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alireza Haghdoost <haghdoost@uber.com>
Content-Type: text/plain; charset="UTF-8"

Add periodic calls to perf_session__shrink() so that both live profiling
and trace-processing commands reclaim unused symbol and DSO memory:

- In perf_session__deliver_event(), trigger perf_session__shrink()
  every 16,384 events, or after at least 512 events when at least
  65,536 new symbols have been inserted across DSOs (tracked via
  symbols__inserted_cnt()). This bounds memory usage for session-based
  commands such as 'perf script' and 'perf report' even on short traces
  that load many large binaries, while giving hot symbols in newly
  loaded DSOs a window to be marked SYMBOL_FLAG_ACCESSED.
- In perf_top__resort_hists(), call perf_session__shrink() on each
  display refresh cycle so 'perf top' periodically ages out unused
  symbols and DSOs.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c  |  2 ++
 tools/perf/util/session.c | 16 ++++++++++++++++
 tools/perf/util/session.h | 10 ++++++++++
 tools/perf/util/symbol.c  | 15 +++++++++++++++
 tools/perf/util/symbol.h  |  1 +
 5 files changed, 44 insertions(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index dd1e475bb4dd..c96530f33fe4 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -320,6 +320,8 @@ static void perf_top__resort_hists(struct perf_top *t)
 	evlist__for_each_entry(evlist, pos) {
 		evsel__output_resort(pos, NULL);
 	}
+
+	perf_session__shrink(t->session);
 }
 
 static void perf_top__print_sym_table(struct perf_top *top)
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 555d940a866a..74a564c6589b 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -164,6 +164,7 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 	session->tool   = tool;
 	session->decomp_data.zstd_decomp = &session->zstd_data;
 	session->active_decomp = &session->decomp_data;
+	session->last_symbols_inserted = symbols__inserted_cnt();
 	INIT_LIST_HEAD(&session->auxtrace_index);
 	perf_env__init(&session->header.env);
 	if (machines__init(&session->machines, session))
@@ -2351,6 +2352,19 @@ static int perf_session__deliver_event(struct perf_session *session,
 
 	if (dump_trace && sample.aux_sample.size)
 		auxtrace__dump_auxtrace_sample(session, &sample);
+
+	/*
+	 * Periodically reclaim unreferenced symbols, DSO caches, and cold DSOs
+	 * during event processing (e.g., perf script, perf report). Trigger
+	 * either every 16,384 events, or after at least 512 events when more
+	 * than 65,536 symbols have been newly loaded across DSOs.
+	 */
+	session->events_since_shrink++;
+	if (session->events_since_shrink >= 16384 ||
+	    (session->events_since_shrink >= 512 &&
+	     symbols__inserted_cnt() - session->last_symbols_inserted >= 65536)) {
+		perf_session__shrink(session);
+	}
 out:
 	perf_sample__exit(&sample);
 	return ret;
@@ -3945,6 +3959,8 @@ size_t perf_session__shrink(struct perf_session *session)
 	if (!session)
 		return 0;
 
+	session->events_since_shrink = 0;
+	session->last_symbols_inserted = symbols__inserted_cnt();
 	return machines__shrink(&session->machines);
 }
 
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 4b223c2cee7f..030d5e931160 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -95,6 +95,16 @@ struct perf_session {
 	struct decomp_data	decomp_data;
 	/** @active_decomp: Currently active decompression context. */
 	struct decomp_data	*active_decomp;
+	/**
+	 * @events_since_shrink: Number of events delivered via
+	 * perf_session__deliver_event() since the last perf_session__shrink().
+	 */
+	u64			events_since_shrink;
+	/**
+	 * @last_symbols_inserted: Snapshot of symbols__inserted_cnt() taken at
+	 * the last perf_session__shrink() pass.
+	 */
+	unsigned long		last_symbols_inserted;
 };
 
 struct decomp {
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 33cfd86156d2..57894c3dc5b5 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -623,6 +623,20 @@ static void symbol__set_idle(struct symbol *sym, bool idle)
 	} while (!atomic_compare_exchange_weak(&RC_CHK_ACCESS(sym)->flags, &old_flags, new_flags));
 }
 
+static atomic_ulong symbols_inserted_cnt;
+
+/**
+ * symbols__inserted_cnt - Return cumulative count of symbols inserted.
+ *
+ * Monotonically increasing counter incremented each time a symbol is inserted
+ * into a struct symbols collection. Used by perf_session__deliver_event() to
+ * detect burst symbol loading across large DSOs and trigger periodic shrinking.
+ */
+unsigned long symbols__inserted_cnt(void)
+{
+	return atomic_load_explicit(&symbols_inserted_cnt, memory_order_relaxed);
+}
+
 int __symbols__insert(struct symbols *symbols, struct symbol *sym)
 {
 	if (symbols->cnt == symbols->allocated) {
@@ -644,6 +658,7 @@ int __symbols__insert(struct symbols *symbols, struct symbol *sym)
 
 	symbols->symbols[symbols->cnt++] = sym;
 	symbols->sorted_by_name = false;
+	atomic_fetch_add_explicit(&symbols_inserted_cnt, 1, memory_order_relaxed);
 	return 0;
 }
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index a76613c43ba9..783d9735aa3f 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -162,6 +162,7 @@ void symbols__exit(struct symbols *symbols);
 void symbols__delete(struct symbols *symbols);
 void symbols__sort_read_lock(struct symbols *symbols) SHARED_LOCK_FUNCTION(symbols->lock);
 size_t symbols__shrink(struct symbols *symbols);
+unsigned long symbols__inserted_cnt(void);
 
 static inline refcount_t *symbol__refcnt(struct symbol *sym)
 {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

