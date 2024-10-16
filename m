Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E8E18C323
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 04:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052696; cv=none; b=HVAO2cM6oD07PPoEc8DOi9i/xbqK7Lo6LPhK7yowqJHw3snjbPlzYx3hg/PXHxV3EsxDwmjBCaljqHI3aurqpYmgb4ta2CaCfiL76xFJV16mqGqP+ATEwd5WzOUu92rBjjY0sexvgMX6vzRgOMVRcF9rJOD7ObqQ23FehbITWGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052696; c=relaxed/simple;
	bh=tzlKt/xEu5otGWCZvc+6lY/D07Nniiv63xyh7KE0+EE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=E0EROqO6eITYIYoFf6Rn1zixAFQT559J9rt/z+olVWQ06SCOfmZY2fgkb5BkuC4zKB6jEVBuvekIYgW+W1K3revmgzU2+D8bYNFApZ+G6wk2qykaTPelFDIrENrhqbg1Tkn5P05VIAeTzaX+IWRarx+1QmkkBtXteamxJeErJfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jU+h/4Wa; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jU+h/4Wa"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3497c8eb0so9640267b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 21:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729052693; x=1729657493; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wUCgc+yh1v+6ab10mK41hwbEx+6NETQ8lxM12doIl4U=;
        b=jU+h/4WahAkNcpyuMp0CdWxIzbMD64qJ4/B8bXBEgw1TU56X+Ler42EdoIxwbebtIv
         LQM3uK0Lik8cp7jnpyZwdBpGbiNzQh7FrDjgwaD0zwWNN2Qc52ZOHG+vNWwHaBn0wrx3
         FSTfnevUjd5hjejf33Da4KTgiSSSWje54Um6iAQhzVV9BW+WdgenHW10S6DRFsq4BKI3
         CQC0C5uHxJpo1jRj4dcXiPd1Z38m2XYG5qzDUAxVTVqVeqQRFFWPJfeNz4lYmI7IMYEw
         i7vgmvituxriQNSbxZS4uLytR/2sEQ2HXjQo34e/Dw5QLFoOvTbMQD66i5tw2/5Lfn3V
         VpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729052693; x=1729657493;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUCgc+yh1v+6ab10mK41hwbEx+6NETQ8lxM12doIl4U=;
        b=Z+1xdzXxT6QgbXMRrGO/jS2yDKLvOGD2nCQ3/sTTWN89eD4zkvHFN+Vmsx8N5E+YHq
         4C5NZWRP6h8zHTK5HfUtF/wnHyex9hOyxgmRAbE/fOVNPGZNruS+YH6a3bBwbozFc61D
         qw1LhVTrBv4FmFi9ELwMiyQaxiZC3iKhRuBmjrgJGtN4nQMNwpkgaBA260WrK10rU5oB
         3spZsxyoWGEEY/GxnoaFzyZCJHWlKqC7J3Nrz0e7eEMNNZgI2kupbNzMjAfszc8sbMMy
         TISHybzCJk0R+cvyuAjuKDqs4Zo3ZSzpk2rRpPmw0eM4bGYkks0bsbb5w7tBz99iw4+S
         53Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXEHSuWzrsrAjsLLLrq5hS2FDterlhgCOnRYYB5oBy+qyRcYUCvm2+gfqDt8OXhDDx30YwO6Fe6KK2MIx0S2Df7@vger.kernel.org
X-Gm-Message-State: AOJu0YzJMtRvSr7NO7SRSF6tBzgd4UKd+UIYI6LH4rahpMXGbhe21vXD
	LvKEUHpwWxYm8hofFRfsLrOB+MxDmu6Fiej8Y3wzW+54Xh2i9CSrOhI42EDZ4k6ftecBO2Hzy/8
	3NO7nJw==
X-Google-Smtp-Source: AGHT+IHxlINltYDsw7498D30y2bJcc3xb1Of/WNilHeA1HO9MrBoD+DTz+ppZUt5pIoJcfRZuyDwf6Pgr/OD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:690c:3587:b0:68e:8de6:617c with SMTP
 id 00721157ae682-6e3d3aacfc0mr526637b3.5.1729052693654; Tue, 15 Oct 2024
 21:24:53 -0700 (PDT)
Date: Tue, 15 Oct 2024 21:24:07 -0700
In-Reply-To: <20241016042415.7552-1-irogers@google.com>
Message-Id: <20241016042415.7552-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016042415.7552-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 08/16] perf script: Move script_spec code to trace-event-scripting.c
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
2.47.0.rc1.288.g06298d1525-goog

