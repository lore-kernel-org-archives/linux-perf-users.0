Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477543E9F9E
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 06:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713180; cv=none; b=pIr2gdT6h18CzEb0SNZ4PAMq+Qsw4HsUeD08imlHHtUxVK72UmZxNv2m5ipL+Dyf9lJTCKd23ZcYWxiZagSXKyV7hMrWoM1N4RwVH48D+C9Dru7Dr9DqFKpyNDvZsEFke+7gBGUa8RmvRiXurEGOlC4xpe6iUMOhrZev450sDIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713180; c=relaxed/simple;
	bh=6piizERCZzYOWq5jXV2XG9t3u22hRs7JWPhh6sg00Fc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aFphQUjziNLRtSPJ4puS+bUnrMyuYyIzZVDLa3ZOSLPKrXbOpyMXE3tGszlT0qWo1GNlTEinQACamg97dx6g2V/lhajvJVlC47ShstJihkekxMDpgO+JLadtzG/eAurQWw4UHkO2M7PKwNtqwfX/IMo858cx1lZIG8hv9eBYQ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EYsr0Jp9; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EYsr0Jp9"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39deda201bcso918657a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 23:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789713178; x=1790317978; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4wzxGE12kx6/6XKkvEhnF8dFgypzNeSmABr+sADCRnA=;
        b=EYsr0Jp9nt3XelH3o9nEh94Lruh9eZUsV3v3A6hY7EcWuwgGMcZdVZWN0WU/kiCPkr
         qoBBwpE2P3hXRukbmTIqFxrUCAayE6cdSQ+VEebmUSCdOLTaMbLDYRB6JO8u5x/XkRRb
         VbOqCGZv+RGiEC5CyjiPO9Jh0dADLZBluN8cufFsZqGYVigXqDQ2mDGJdyo+XzIuErZT
         uWQdyUWDKnF9XL3LRAyNHeTSxvq7M4EOYpX21e6pohPxF6nxPwJh7rDtY/D4V+CNTZLq
         d2SOqoBnC4ojs6LxNEoTf/QBz4Xud5rpeFTWH/saC7SGxbgA93HfXCQJd3gX+rco2a2j
         /Uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789713178; x=1790317978;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4wzxGE12kx6/6XKkvEhnF8dFgypzNeSmABr+sADCRnA=;
        b=PMW2xHOOr7lj4lZUB9ahy/jhXQyzIH6ThnNqOB/iqCM0uiWoC92QZ9QZHzp0Is9Efu
         VwOCQpbUfmDkTgymuVp+gU540ZPQMQTlYevdn9i4Iu6nZsjqc8bJ5/eWt30QLJYZIprq
         JbkpwtHVQDHPIPlJYtLi6klV1gCe7FgXLtsvTCblrvm/5ze4A1dWoZpvjpzlHsFOpZQG
         dGKOisNqFUntyIq9Wv7fMwr9xa3nw5uMUfpgSRl3/UeHdDqzGyL5XX36lLGqn9sZxkzZ
         Rl3IOh/mXcLVG0q2JoBq4CWaXkhsaLykXYqsSE3/j5pgu/NYKsbDozcTkdBUoByJwaHD
         bSyg==
X-Forwarded-Encrypted: i=1; AKwUvBwTcIFHeXHCY0bxxDMJusppzLfBWZa48bfdpRlk7Kv9TznE6km5A/GypAxsiRIvmE9VqbFR0IEnQMhz7qfgGxgZ@vger.kernel.org
X-Gm-Message-State: AFuF++l6eRAykXEF56SQnYc30R75EsJ+IT4OBIMHibq58FgMVmB6UQpe
	UlHzqYEuU8ckr9bAjiFxdNb++szYDzT6uKsxXy/lAYlEEQfcW5rUU/D3Ah01PlP2SG2gKBBc3BI
	s2qIuKmfjUA==
X-Received: from dleb12-n2.prod.google.com ([2002:a05:701b:424c:20b0:13c:fe05:89a3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:224c:b0:39b:61f1:8032
 with SMTP id 98e67ed59e1d1-39e54e7c18emr3356695a91.16.1789713178050; Thu, 17
 Sep 2026 23:32:58 -0700 (PDT)
Date: Thu, 17 Sep 2026 23:32:47 -0700
In-Reply-To: <20260918063249.2172589-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918063249.2172589-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918063249.2172589-4-irogers@google.com>
Subject: [PATCH v1 3/5] perf trace-event: Free the global trace_event when a
 command ends
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The tep handle behind trace_event__tp_format() is a process wide cache
of the running kernel's tracepoint formats and nothing ever released
it, as the comment above it had noted since the code was added.

Add trace_event__exit() and call it from run_builtin() next to the
existing perf_config__exit(). By then the builtin has returned, so the
tep_event pointers it handed out, such as the ones cached in
evsel->tp_format, are no longer reachable.

Note that this does not silence every libtraceevent report under
leak sanitizer. Parsing a print fmt drops a token inside the library
itself, and as those allocations are not linked into the handle,
freeing the handle cannot reclaim them.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/perf.c             |  6 ++++++
 tools/perf/util/trace-event.c | 22 +++++++++++++++++-----
 tools/perf/util/trace-event.h |  1 +
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 6c5baa285b13..d60bc929c257 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -32,6 +32,9 @@
 #include "util/build-id.h"
 #include "util/config.h"
 #include "util/debug.h"
+#ifdef HAVE_LIBTRACEEVENT
+#include "util/trace-event.h"
+#endif
 
 const char perf_usage_string[] =
 	"perf [--version] [--help] [OPTIONS] COMMAND [ARGS]";
@@ -379,6 +382,9 @@ static int run_builtin(const struct cmd_struct *p, int argc, const char **argv)
 
 	status = p->fn(argc, argv);
 	perf_config__exit();
+#ifdef HAVE_LIBTRACEEVENT
+	trace_event__exit();
+#endif
 	exit_browser(status);
 
 	if (status)
diff --git a/tools/perf/util/trace-event.c b/tools/perf/util/trace-event.c
index 826f75464171..819542a73f55 100644
--- a/tools/perf/util/trace-event.c
+++ b/tools/perf/util/trace-event.c
@@ -14,11 +14,9 @@
 #include "machine.h"
 
 /*
- * global trace_event object used by trace_event__tp_format
- *
- * TODO There's no cleanup call for this. Add some sort of
- * __exit function support and call trace_event__cleanup
- * there.
+ * Global trace_event object used by trace_event__tp_format. It caches the
+ * tracepoint formats of the running kernel for the lifetime of the command
+ * and is released by trace_event__exit.
  */
 static struct trace_event tevent;
 static bool tevent_initialized;
@@ -75,6 +73,20 @@ void trace_event__cleanup(struct trace_event *t)
 	t->plugin_list = NULL;
 }
 
+/*
+ * Release the global trace_event. Called once the command is done, when the
+ * tep_event pointers handed out by trace_event__tp_format are no longer in
+ * use.
+ */
+void trace_event__exit(void)
+{
+	if (!tevent_initialized)
+		return;
+
+	trace_event__cleanup(&tevent);
+	tevent_initialized = false;
+}
+
 /*
  * Returns NULL and sets errno on failure.
  */
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 720121c74f1d..1c342fce36bb 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -32,6 +32,7 @@ bool have_tracepoints(struct list_head *evlist);
 
 int trace_event__init(struct trace_event *t);
 void trace_event__cleanup(struct trace_event *t);
+void trace_event__exit(void);
 int trace_event__register_resolver(struct machine *machine,
 				   tep_func_resolver_t *func);
 struct tep_event*
-- 
2.55.0.1082.g2b9226bbc0-goog

