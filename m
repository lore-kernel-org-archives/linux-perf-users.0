Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B0F146A6C
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 01:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979064; cv=none; b=e8YwhRxW/GuzYUq8kjOt+Mdz2gaNguop9vhj9GRZ6dDcX3mNuXzGwIW61ykQvHoc5u2zcuba9Gsgu0Imo59JBBX+WcdoFO55sY6SXIaVKRmKeJFEJskKD3lUUTDZRctiEchVZVGb1k3n4yiyNFw6eBjnmz9N7CecQsUkKZsYHB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979064; c=relaxed/simple;
	bh=tNLAJ2pb8obJOYMSxFIC+cjFcupLOrxX//i30q8z1rA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=Zs4AagO7vEG5YPdQpBioCaRvL2mbko+XuLe8BdVft0dE173lQKT1+N5r0fUAYHjUsYP+SfrnAyzUydGhC8qdCRPL+D2ZG8b9V6MXhqfDpadzFNAFedxcMIPPpNip19TC3wpXWA9qBqkuUSXGcwjFfnDKBUE8JcENYbqY62imMM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gXn1bRk4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gXn1bRk4"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ee4662b307so48803887b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 17:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731979061; x=1732583861; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zn6zJFygLNqQr5gPeWc0c56TIYgfhddx4cdxbohjhZs=;
        b=gXn1bRk4T/FJStWsXCnEhvCzvPyMs5LzhveUCYqPdbPS9UoC998mX7OCNGNjgSf9dd
         U82HyTXtB7P09IvGUPWUF6bzawfqEfIr+KLaTQaZzDPvRU/k0GVQPZK6ljj2NmJ8eoGa
         hpgAIEY62w1C1zfBalRrnpAfloatBw5Eb64QOp56ffqYz2AeGigPloUfWLykIRZKBxqw
         8hG1z3Vg4KNkrLv5G0QCmRrFzAj2MKaK3MyFYKmpi+dlxFT6Nk9+iKUXXqhb5P+/Rf3x
         vUyAUp0T7OU0xfh3e3Kdy74aiAQCEFz0f2+DOHUYcupQ+kuFbZohOK5YfMudEQ/zQRDb
         08PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979061; x=1732583861;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zn6zJFygLNqQr5gPeWc0c56TIYgfhddx4cdxbohjhZs=;
        b=cG6JRm1RCP0+MpTpXRQo80ZF4PX5yEKGx2+NsX3tXVtPzjk/qjooAOOCr/XP5810/j
         NYRUIIvS3yEeK9ZOl9740QOCNvnilZT3pkptGMSW6OT5CEeJmbXQLUYNr+3l28ZmyeLt
         tKXLmBhFeziurAXh2iHImx0HvtnRK9UKuuGvtAcMiBN6bk4qSLOt0Wx/CNCFzT90VZNO
         h5GJUPPvni+I6YHVej2pP2Yf74mAYegr01reptr3cIwvOGWXy+3c/l/KeguYhOF9KZlP
         b3VnEaMBSO6nO6tzIaSnSVaJ8BwmRzyjYjxmpN5GyeLTvBt/E0NkbQN4lPgMz7jPL8og
         TY/A==
X-Forwarded-Encrypted: i=1; AJvYcCVF0a6ZEfs6tAwNIc/T57DjxjsQs7MV2r/Au5y+3g5PikoRsT1tRN96L17hixYQEjVDwC/5YrPEYQxMdLfeDNRr@vger.kernel.org
X-Gm-Message-State: AOJu0YxYcJiXdPf2s8qmhrf8w4pChQCeHG4WIad/okWqvWRIAB4pdlNf
	TP7eg9Pv+V66075dbzWCKWZwQdjBAe4OI/rbXB9OoGh9dcW1uCHpEVPe40SjsIkP+5EVHxlb0bV
	X2/8WUA==
X-Google-Smtp-Source: AGHT+IGSCaZ/uVjD7usDHxw9ALNuw5YvhZD4nY+/OTM4rPAXQXTu362uAegaLMkp3WXzWDceXc5+BMM44IUn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a81:ad0a:0:b0:62c:ea0b:a447 with SMTP id
 00721157ae682-6ee55a3b7ebmr1874697b3.2.1731979060734; Mon, 18 Nov 2024
 17:17:40 -0800 (PST)
Date: Mon, 18 Nov 2024 17:16:31 -0800
In-Reply-To: <20241119011644.971342-1-irogers@google.com>
Message-Id: <20241119011644.971342-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119011644.971342-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v7 09/22] perf script: Move script_spec code to trace-event-scripting.c
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
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

The script_spec code is referenced in util/trace-event-scripting but
the list was in builtin-script, accessed via a function that required
a stub function in python.c. Move all the logic to
trace-event-scripting, with lookup and foreach functions exposed for
builtin-script's benefit.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c             | 67 +---------------------
 tools/perf/util/python.c                |  5 --
 tools/perf/util/trace-event-scripting.c | 75 +++++++++++++++++++++++++
 tools/perf/util/trace-event.h           |  3 +-
 4 files changed, 80 insertions(+), 70 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 0ba1866dbeef..b4deae110dbe 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2956,79 +2956,18 @@ static int __cmd_script(struct perf_script *script)
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
index 7fc3ec5684c3..d157aaa4bb53 100644
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
index d514db1df27f..4b7f0592850b 100644
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
index 79b939f947dd..29cae98695c9 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -113,7 +113,8 @@ struct scripting_ops {
 
 extern unsigned int scripting_max_stack;
 
-int script_spec_register(const char *spec, struct scripting_ops *ops);
+struct scripting_ops *script_spec__lookup(const char *spec);
+int script_spec__for_each(int (*cb)(struct scripting_ops *ops, const char *spec));
 
 void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
 		       struct machine *machine);
-- 
2.47.0.338.g60cca15819-goog

