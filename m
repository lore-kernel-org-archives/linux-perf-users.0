Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F85720C464
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 22:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241899; cv=none; b=EPkJlx6LzJDV6NOu8KbSOO27sGh6r5zttkFcshGn6/QlrqurnqDXmDD4PngaU7G0nn8gKN+QHOaJ6QjK3S5AxXHyU7FP6yYCjTjHvwV9OqZu071KM3qVBONNQkKQfJC01GM00xXuruLOxjMfpzzeYsu+joslW1KU3ZxdMbh6GGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241899; c=relaxed/simple;
	bh=7MX0JfCi6kfdsDcBX+OpEjk+nsi28Hr9lMOG3fkqXVQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Mj1iImGdyNWsF8dRLN5/7nlPyvwhIOhd0YhsIAQfzPntySr9cpa/c6v3uTqBzN/X2P4gRIj3aoe2Uxmwa/XyAZiSdZnF/hKXZSLBKtFh2bUsP9TkPEyQnFWHdx4rmyv1OqYMBWwzdzOsPbHXsOeBkT5vhwX9dYxqLi3e2rmnSIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sfz5yGbm; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sfz5yGbm"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2946a143efso563269276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 15:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730241895; x=1730846695; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eC8ob0xZGEdP+WjhTSNLt8FUry/vYoIKckpm7VVq6as=;
        b=Sfz5yGbmHY3L/tcLfkQIdX4NKZOJkIPTurccgMpREx1CDl5BCzU9FkrqIFfZUBYEcI
         U50bwTwYOoPn56e0v4/8XISoz2D3pSf9hTYPW2F3sGXk7kvHvGIqplMYVCTljf+oWnXl
         qgXwMc2YOz2CfNfXYFS9e2V0+t7V6iYYNFiKUN9mLa81JkZujV2SrB8FiDCIT7PhUcYC
         aVk2kTjLsK9jESHIJgB6z8hCD3LhEHqdCtxH/Yy7JCWdFAbYDOck/A5K6MYcxiBFnJBu
         3GYX65DhCWL88DVQLHzWYqPR8dqubHXKGPjmI53+pJheDZkRz/yCvg5RMS6fTUIvMkOt
         AFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730241895; x=1730846695;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eC8ob0xZGEdP+WjhTSNLt8FUry/vYoIKckpm7VVq6as=;
        b=duQ059cDPe1N2rQe92w9qJGv8tTbuv+Q8mkAEXXvalMnj+ap9UMeTi7pIK5qV/nQsP
         WGiOB7O504O7YmgE0Am4oM3jIFfVdJqkSs//zdHFzh7l7d63w/rG6dJU2QFcGXThaMuH
         I8Pk5cZcwjpSrLcRUEpBWsA5WkwCcyrMml8PbeicX5Pl6aw0VHvYl2LqEjAVvwF6fcoo
         gYPD7rsZE794hH3Y3JVgPLCSpgcf/wGzngQOQYO39DQBVOSFUjdEavrb7NT1ppLmJxuY
         Dpm1cK7RaYFWY+rUSu3bZosc/vQiL8n0zVzeBG2T+3GwtJo0+Pq6v74DFtz2+Tv1kbXg
         fGMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDxWYShL/oGZXZCj7nI922qUxT5TlHAh5Oa0aJivHfn9ijm1dvlKdOfJdfl7k3zpGg8mC/TrSsOhIxNPNBg7Ck@vger.kernel.org
X-Gm-Message-State: AOJu0YxBBrL+C8aqGv+d1CkcsYCtjjSjv9YciiH2/W4xv4tSvYVyaF7t
	78v5tNlZfSgHk76X5ecowlcKTMag5k4J4wQPDL7glV0XazsH3FEVl8lF14GypPQ3o3lyTkUTbrM
	og/fTSA==
X-Google-Smtp-Source: AGHT+IFpsK01+CwlbsFoYmQf+BqpjL/htaA+QQZ0SejRORHhBq9z5qQVYVUTr58AHUH++K8/tQNk2lIakI7f
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8991:d3fd:38a7:c282])
 (user=irogers job=sendgmr) by 2002:a25:c50e:0:b0:e30:d5cf:775a with SMTP id
 3f1490d57ef6-e30d5cf7861mr1003276.6.1730241895245; Tue, 29 Oct 2024 15:44:55
 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:44:20 -0700
In-Reply-To: <20241029224431.167623-1-irogers@google.com>
Message-Id: <20241029224431.167623-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029224431.167623-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 08/19] perf script: Move script_spec code to trace-event-scripting.c
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The script_spec code is referenced in util/trace-event-scripting but
the list was in builtin-script, accessed via a function that required
a stub function in python.c. Move all the logic to
trace-event-scripting, with lookup and foreach functions exposed for
builtin-script's benefit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c             | 67 +---------------------
 tools/perf/util/python.c                |  5 --
 tools/perf/util/trace-event-scripting.c | 75 +++++++++++++++++++++++++
 tools/perf/util/trace-event.h           |  3 +-
 4 files changed, 80 insertions(+), 70 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8a510d6412cc..93caaad62be5 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2955,79 +2955,18 @@ static int __cmd_script(struct perf_script *script)
 	return ret;
 }
 
-struct script_spec {
-	struct list_head	node;
-	struct scripting_ops	*ops;
-	char			spec[];
-};
-
-static LIST_HEAD(script_specs);
-
-static struct script_spec *script_spec__new(const char *spec,
-					    struct scripting_ops *ops)
+static int list_available_languages_cb(struct scripting_ops *ops, const char *spec)
 {
-	struct script_spec *s = malloc(sizeof(*s) + strlen(spec) + 1);
-
-	if (s != NULL) {
-		strcpy(s->spec, spec);
-		s->ops = ops;
-	}
-
-	return s;
-}
-
-static void script_spec__add(struct script_spec *s)
-{
-	list_add_tail(&s->node, &script_specs);
-}
-
-static struct script_spec *script_spec__find(const char *spec)
-{
-	struct script_spec *s;
-
-	list_for_each_entry(s, &script_specs, node)
-		if (strcasecmp(s->spec, spec) == 0)
-			return s;
-	return NULL;
-}
-
-int script_spec_register(const char *spec, struct scripting_ops *ops)
-{
-	struct script_spec *s;
-
-	s = script_spec__find(spec);
-	if (s)
-		return -1;
-
-	s = script_spec__new(spec, ops);
-	if (!s)
-		return -1;
-	else
-		script_spec__add(s);
-
+	fprintf(stderr, "  %-42s [%s]\n", spec, ops->name);
 	return 0;
 }
 
-static struct scripting_ops *script_spec__lookup(const char *spec)
-{
-	struct script_spec *s = script_spec__find(spec);
-	if (!s)
-		return NULL;
-
-	return s->ops;
-}
-
 static void list_available_languages(void)
 {
-	struct script_spec *s;
-
 	fprintf(stderr, "\n");
 	fprintf(stderr, "Scripting language extensions (used in "
 		"perf script -s [spec:]script.[spec]):\n\n");
-
-	list_for_each_entry(s, &script_specs, node)
-		fprintf(stderr, "  %-42s [%s]\n", s->spec, s->ops->name);
-
+	script_spec__for_each(&list_available_languages_cb);
 	fprintf(stderr, "\n");
 }
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 0fa8e27769be..3d938fe2de6a 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1305,11 +1305,6 @@ PyMODINIT_FUNC PyInit_perf(void)
 /* The following are stubs to avoid dragging in builtin-* objects. */
 /* TODO: move the code out of the builtin-* file into util. */
 
-int script_spec_register(const char *spec __maybe_unused, struct scripting_ops *ops __maybe_unused)
-{
-	return -1;
-}
-
 arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch __maybe_unused)
 {
 	return NULL;
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index 8abb7a7b6888..ad62d8e5a368 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -24,6 +24,81 @@ unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
 
 struct scripting_context *scripting_context;
 
+struct script_spec {
+	struct list_head	node;
+	struct scripting_ops	*ops;
+	char			spec[];
+};
+
+static LIST_HEAD(script_specs);
+
+static struct script_spec *script_spec__new(const char *spec,
+					    struct scripting_ops *ops)
+{
+	struct script_spec *s = malloc(sizeof(*s) + strlen(spec) + 1);
+
+	if (s != NULL) {
+		strcpy(s->spec, spec);
+		s->ops = ops;
+	}
+
+	return s;
+}
+
+static void script_spec__add(struct script_spec *s)
+{
+	list_add_tail(&s->node, &script_specs);
+}
+
+static struct script_spec *script_spec__find(const char *spec)
+{
+	struct script_spec *s;
+
+	list_for_each_entry(s, &script_specs, node)
+		if (strcasecmp(s->spec, spec) == 0)
+			return s;
+	return NULL;
+}
+
+static int script_spec_register(const char *spec, struct scripting_ops *ops)
+{
+	struct script_spec *s;
+
+	s = script_spec__find(spec);
+	if (s)
+		return -1;
+
+	s = script_spec__new(spec, ops);
+	if (!s)
+		return -1;
+
+	script_spec__add(s);
+	return 0;
+}
+
+struct scripting_ops *script_spec__lookup(const char *spec)
+{
+	struct script_spec *s = script_spec__find(spec);
+
+	if (!s)
+		return NULL;
+
+	return s->ops;
+}
+
+int script_spec__for_each(int (*cb)(struct scripting_ops *ops, const char *spec))
+{
+	struct script_spec *s;
+	int ret = 0;
+
+	list_for_each_entry(s, &script_specs, node) {
+		ret = cb(s->ops, s->spec);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
 void scripting_context__update(struct scripting_context *c,
 			       union perf_event *event,
 			       struct perf_sample *sample,
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index bbf8b26bc8da..81fceaf297ba 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -116,7 +116,8 @@ struct scripting_ops {
 
 extern unsigned int scripting_max_stack;
 
-int script_spec_register(const char *spec, struct scripting_ops *ops);
+struct scripting_ops *script_spec__lookup(const char *spec);
+int script_spec__for_each(int (*cb)(struct scripting_ops *ops, const char *spec));
 
 void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
 		       struct machine *machine);
-- 
2.47.0.163.g1226f6d8fa-goog

