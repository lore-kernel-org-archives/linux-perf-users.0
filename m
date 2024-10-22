Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220F91C32FD
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618271; cv=none; b=WlP5VToGwBUwKE5bVQaaSD41AuKspRAQQrqlnmempTarUUtQH9wgut52hWzC9AeZzTSBqHMwWsUDDK9lkPdK6PTUQbitYMhggKnrX+/qKDsE3AAYsNXqkzJ6/4uby6vOG9QTZzcEi97Ttq1NeZF8u0wdbTGA4yc+aXQdfHzL6jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618271; c=relaxed/simple;
	bh=3Ry2ZDeSTDeejTE5bU/QIsOgJoWOwBO05hCd6qGy+iQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=aY2xmpv0cafLddtGkqIkNsd05I4uNjkzftQNH9e4E75QwICv2DZMWWVJtk96BAZky2kZf4jgjoxANwh8cTE3WaWM8m1FrvFThPXVx4yCvMM9HItK1plfm5LmlIjZPteUd9QphDt69RX3BZNKESNsH3Xj9EiszRa9CxWYvTsGlRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vhtr1Os6; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhtr1Os6"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6dbbeee08f0so1164567b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 10:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729618269; x=1730223069; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DPqMOcw/gz/9oB1GzsDQOCA1KyL9cUpEHgbKTJ/WmIk=;
        b=vhtr1Os6+WdvFNtt6SXGQ2ZqM2viw3H1ANn3vq3Yutj7NQ0AjVORQSeFqFZ2ydXlk5
         xJ2kP5hH2L12JqM7KQu4rDCXoTw2SSPBlSh7cMgsl1ExUNBIIi350o1nDKbt4+zKAJnq
         S4jHERbTVLCh1SWqz/K6XY0hGK8rxDcKbSk8Pn7HXjeS63G4F6GomyKTLJJmgDyB2ek+
         Gys7K7oRHRDHKUpE0L0o+2OOJGC6KBXZxPUaswbuRv8wkr/z5a3UW2GJEUk0fAcoqx85
         eARlBRyjS8JLLp6E4wrb0mcfK3qhcffCCqIrOX5ATbA1ve9CxwszIr151Ap+Y28hTVj1
         OZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618269; x=1730223069;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DPqMOcw/gz/9oB1GzsDQOCA1KyL9cUpEHgbKTJ/WmIk=;
        b=VCsjYoHseiunywt9CYxINmyvnUWho36NC6U6sqP1XzyRKAdVlfFvrqWZ4NQ64pUT/r
         NXUP3VhzND3d1LIM7pLWi08hd/4zcoze57wit5RVl4uMiI9HQusg+RxoXG8zX7wqAe0K
         Mw1gUKDn1M5IyUiiqQJtwMfmwQ237yj7+vncFvJJ4oGq7dKpz+sGIsymNUobiuVeXbOU
         TC1rBjyw6ZP5xh2a7WBaPIU0BXQca4M/itoxRX9H92m8+rkZVRLL+liOrim79iN4YfSl
         W0gfOomOK7fddgP27NXoRMmvBSVs0GpeDWFoLhYu5ZSYDbM4god/fJTNoQc2hUzGJ1U6
         TWHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBxtCr+1pHYTuMHtuWo5A0M+ZEvTrZbUFgl53QTN5yQgpRuLbVbmmoLVGYM2rBjltv44dP8cuZGmx9Cw1xAwih@vger.kernel.org
X-Gm-Message-State: AOJu0YyxcjySP6+OnRP+TzUNDdfWYRChayr6VBez9kLPwEvA0irvDMeU
	U5jQbpZ4tECNF/0raYsryG2Mile+cH2on/Szo6GRQDbZMjNeFat9eqvgjKq75YvuEvQnB2AGxHz
	vEv+Lgg==
X-Google-Smtp-Source: AGHT+IHBj9SATT1LWVafd+BHC+BE7V5JcH4XBN+jmDAuOFFp3W//F6VmIEMLgXF+lrsJMgBcSKlHr93kBSWB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:57ba:88e0:aaf6:282])
 (user=irogers job=sendgmr) by 2002:a25:c101:0:b0:e2e:317a:d599 with SMTP id
 3f1490d57ef6-e2e317ad75cmr11450276.2.1729618269206; Tue, 22 Oct 2024 10:31:09
 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:30:06 -0700
In-Reply-To: <20241022173015.437550-1-irogers@google.com>
Message-Id: <20241022173015.437550-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022173015.437550-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v3 08/16] perf script: Move script_spec code to trace-event-scripting.c
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
index 1ce7b71f1f46..b838470657d4 100644
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

