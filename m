Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E531478E4A
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060026; cv=none; b=YIptrGYgs07vfYKO9QcPEbEG4IN2hndIAUwQnIOYm7QpI94uX9HRDB5mCpTYwrHdqbFy7dmyCh9KSh1Tiwfy7ZmVRBB89NUKtwE0U76CqkDD1yZZgj0dGqy4RCfZN4xSuwvzVIqGNQi0luEVhpOCMTZWGFl4kroTbzl9E4O/nNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060026; c=relaxed/simple;
	bh=abvX/CdYXf1z0V/pYoLfI9bKqCOKdcOm41xIkkZrNoI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i5Na/YqWSRX6oeX2uOPwBpuBjXJ81t+pEpfW0txLUT1qO/n93e7hLz6Zlu1mSaZN2kd7+ZZiA7374KMJf2DHNPB9Wu0rmklC7kKWxxRU7ze3CHp4Q9DGkJNeoBVbxazV8pMpU8nL/84+OxjFEq8yQNM8sOtWgawLto9tAnmcizc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=czs3xc/8; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="czs3xc/8"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12711ec96fbso1128328c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 09:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775060025; x=1775664825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lsV4SuzH+dJOzt/rj3hoFEqVCugrtnIk7rnjy9TZFug=;
        b=czs3xc/8g48uRTNjRURwjpAeVSCwvWNsEkFrxz9W+t9Fa+dNkx7nfisvlQWGkPTn/4
         S2/v2X3Dlcg8oviaCFEu5ORb3AYdt4TcTE5CH2fXoPWCqS+vlyy3XDxs1z+Now24ieBX
         PceV6tK42+xxWqo/Yeho6TGCb47dYIOTC0i5HakluPYo2i7zVU7sKtztyLghDf20JfzY
         ns11+xkKLiK+unZbz9jUKUm6ubUYppgwtDwaJQxp3caSHuL9k9zvmSMc31z07as+dVBu
         Otwjo0ELCKU7R95DiHnywvR+w2ROgfKuMBHrVfs7zkcnA3lZ3jKHau6/IABvZZ3dpYm+
         i2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060025; x=1775664825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lsV4SuzH+dJOzt/rj3hoFEqVCugrtnIk7rnjy9TZFug=;
        b=ZcU1ViFGRFZZApnuJRGFre1QSc5bYpAoLY9ESTGRbjpwMAmW5rIFHyT5RAW5jot3u+
         eH+/0DNpNBfmy853GNJSHjiVBj1NHf5gII9ut7A2jHbGEfr/EJLRgt7FNpsAdH2KY6my
         1u9JNMLvKFMbAUBCjgv3/7Y6vi5JEY5TbuDCQeIX2TbpyN0D9ZPD6l3F+0iJr1Vqd658
         +2KEDi6jORD7x9dd483WpivCu2qGBSTERoZ9cNn37ivf8qEhCp5x8AMqmqY6mGg69vEv
         XevsSTBsSTLxDUMQNIN1pMfwq0Xm+R8VO44IQ7pf4Q9gRlXq2Dc1SsGMoWC223ubFWeX
         wvIw==
X-Forwarded-Encrypted: i=1; AJvYcCVZwnLmfspRpZD/bJK4gmHFVO5E4GmgV6C6VzI61LYtGvd3YHmEwjZBptAfdaE20q6c+BdOYYjifst8G0aP25Qp@vger.kernel.org
X-Gm-Message-State: AOJu0YypqSAuLcqHT1tUB4kMHt/FkR4ZvXmLIx2svWHDJnZKcw5oyHX0
	mgp6DGLSxGX7LdciKfRiQxn6HCozTbQARsrKVSnkpkyReZmSXgmGDphyrYUIWnEVg4AS7o9avRF
	gyj7U2wisyw==
X-Received: from dlbsn4.prod.google.com ([2002:a05:7022:b904:b0:12a:80f3:8f8a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f509:b0:124:9acd:328d
 with SMTP id a92af1059eb24-12be64ed2abmr1358812c88.22.1775060024586; Wed, 01
 Apr 2026 09:13:44 -0700 (PDT)
Date: Wed,  1 Apr 2026 09:13:24 -0700
In-Reply-To: <20260401161324.332356-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260401055206.43187-1-irogers@google.com> <20260401161324.332356-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401161324.332356-9-irogers@google.com>
Subject: [PATCH v4 8/8] perf data convert ctf: Pipe mode improvements
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ashelat@redhat.com, ctshao@google.com, 
	derek.foreman@collabora.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	swapnil.sapkal@amd.com, thomas.falcon@intel.com
Content-Type: text/plain; charset="UTF-8"

Handle the finished_round event. Set up the CTF events when the
feature event desc is read. In pipe mode the attr events will create
the evsels and the feature event desc events will name the evsels. The
CTF events need the evsel name, so wait until feature event descs are
read (in pipe mode) before setting up the events except for tracepoint
events. Handle the tracing_data event so that tracepoint information
is available when setting up tracepoint events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/data-convert-bt.c | 63 +++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 665bf8eea24b..20f8b81c3d9b 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1181,6 +1181,10 @@ static int add_event(struct ctf_writer *cw, struct evsel *evsel)
 	const char *name = evsel__name(evsel);
 	int ret;
 
+	if (evsel->priv) {
+		pr_err("Error: attempt to add already added event %s\n", name);
+		return -1;
+	}
 	pr("Adding event '%s' (type %d)\n", name, evsel->core.attr.type);
 
 	event_class = bt_ctf_event_class_create(name);
@@ -1223,13 +1227,28 @@ static int add_event(struct ctf_writer *cw, struct evsel *evsel)
 	return -1;
 }
 
-static int setup_events(struct ctf_writer *cw, struct perf_session *session)
+enum setup_events_type {
+	SETUP_EVENTS_ALL,
+	SETUP_EVENTS_NOT_TRACEPOINT,
+	SETUP_EVENTS_TRACEPOINT_ONLY,
+};
+
+static int setup_events(struct ctf_writer *cw, struct perf_session *session,
+			enum setup_events_type type)
 {
 	struct evlist *evlist = session->evlist;
 	struct evsel *evsel;
 	int ret;
 
 	evlist__for_each_entry(evlist, evsel) {
+		bool is_tracepoint = evsel->core.attr.type == PERF_TYPE_TRACEPOINT;
+
+		if (is_tracepoint && type == SETUP_EVENTS_NOT_TRACEPOINT)
+			continue;
+
+		if (!is_tracepoint && type == SETUP_EVENTS_TRACEPOINT_ONLY)
+			continue;
+
 		ret = add_event(cw, evsel);
 		if (ret)
 			return ret;
@@ -1418,6 +1437,18 @@ static int process_feature_event(const struct perf_tool *tool,
 		return ret;
 
 	switch (fe->feat_id) {
+	case HEADER_EVENT_DESC:
+		/*
+		 * In non-pipe mode (not here) the evsels combine the desc with
+		 * the perf_event_attr when it is parsed. In pipe mode the
+		 * perf_event_attr events appear first and then the event desc
+		 * feature events that set the names appear after. Once we have
+		 * the full evsel data we can generate the babeltrace
+		 * events. For tracepoint events we still don't have the tracing
+		 * data and so need to wait until the tracing data event to add
+		 * those events to babeltrace.
+		 */
+		return setup_events(cw, session, SETUP_EVENTS_NOT_TRACEPOINT);
 	case HEADER_HOSTNAME:
 		if (session->header.env.hostname) {
 			return bt_ctf_writer_add_environment_field(cw->writer, "host",
@@ -1448,6 +1479,26 @@ static int process_feature_event(const struct perf_tool *tool,
 	return 0;
 }
 
+static int process_tracing_data(const struct perf_tool *tool,
+				struct perf_session *session,
+				union perf_event *event)
+{
+	struct convert *c = container_of(tool, struct convert, tool);
+	struct ctf_writer *cw = &c->writer;
+	int ret;
+
+	ret = perf_event__process_tracing_data(tool, session, event);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Now the attr was set up by the attr event, the name by the feature
+	 * event desc event and the tracepoint data set up above, the tracepoint
+	 * babeltrace events can be added.
+	 */
+	return setup_events(cw, session, SETUP_EVENTS_TRACEPOINT_ONLY);
+}
+
 static int ctf_writer__setup_clock(struct ctf_writer *cw,
 				   struct perf_session *session,
 				   bool tod)
@@ -1677,9 +1728,10 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 	c.tool.exit            = perf_event__process_exit;
 	c.tool.fork            = perf_event__process_fork;
 	c.tool.lost            = perf_event__process_lost;
-	c.tool.tracing_data    = perf_event__process_tracing_data;
+	c.tool.tracing_data    = process_tracing_data;
 	c.tool.build_id        = perf_event__process_build_id;
 	c.tool.namespaces      = perf_event__process_namespaces;
+	c.tool.finished_round  = perf_event__process_finished_round;
 	c.tool.attr            = perf_event__process_attr;
 	c.tool.feature         = process_feature_event;
 	c.tool.ordering_requires_timestamps = true;
@@ -1724,8 +1776,11 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 	if (ctf_writer__setup_env(cw, session))
 		goto free_writer;
 
-	/* CTF events setup */
-	if (setup_events(cw, session))
+	/*
+	 * CTF events setup. Note, in pipe mode no events exist yet (they come
+	 * in via events) and so this does nothing.
+	 */
+	if (setup_events(cw, session, SETUP_EVENTS_ALL))
 		goto free_writer;
 
 	if (opts->all && setup_non_sample_events(cw, session))
-- 
2.53.0.1118.gaef5881109-goog

