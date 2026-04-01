Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3230E3290A9
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 05:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775022755; cv=none; b=TkvvkwxTz2mICgs9vmw6+GPGNG1a9d6ut1foFqmPTTdI+KmvhT11g9FIvLKHN0mk/jgB2GoHD49SElzzvTQhV/LO0HyBEejIeyQr29ZrvRs5thH2XZYbBEeNrdsTF9MDE6I0gaVOyoePO5DguSzZvAyab/xwRRH8gAy5HKzU/E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775022755; c=relaxed/simple;
	bh=o5xdluZsrMJ7DmiLpE5klINFe897EnRtMQxNqOa85TI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tEI+jfZYvVlmy1XYe9OIEQcLgv+lmHTz/YYSarHdICRh7lEw3O8qR7iQ3kxgNAyazq+GkRLpE7tsfGhqn6E/S60fcCA+eQ9Hy8FmzciuoxIYBuar6I8plIHz8+SX64dtBjaW6g2yAMkqQqYXS7wAowVeNAYFEgN9v2lZmqTwLRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c9d7g47e; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c9d7g47e"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-128ba70cc99so5194937c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 22:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775022743; x=1775627543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aCiawvq0YbBPoCrfosUh1ZpIc6Ul2Vv8tg6tsPj9Kmg=;
        b=c9d7g47eNnIZ64cuHgA5wKD7ktn6Ap0xT8znVSzhDuqfKJHUGmYbf/sMWKKE0ae2Sg
         e5gVihIUSQ/RhqHBg99Bw1TZupPJrRlhArhnGlbzoGA9l9kOf39TqpgzOsMlycJkOsnh
         rAHD/OiuzKLjsoE+gYLLtRTaQpnVaqHQBaicszBPD2/DUaYHsvrrOsjIDABEBgjVB3D7
         3klh+mBqCa3U6HA4D5oIRVySu8fwaaX2DxZh8kN9cSM0ee692EKWijPniGBR4Ecf68r9
         meCFVAmB3r1iI/hM1LvrgFvZV4AcTlUIwfEffxY91X97xKDdE8wmAZbSF70nsVI9jMX+
         IYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775022743; x=1775627543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aCiawvq0YbBPoCrfosUh1ZpIc6Ul2Vv8tg6tsPj9Kmg=;
        b=PBiA7aVfXknbfMyYFsxfYqXzVPZ4QdDIMjb6hBeW7pOOne4Xyb4d6a1u6LHaMJEK5d
         UPVW1DSun9j4tAxINk5aACZVT2yFB7R8r1gJzCAv8cdv9ZyxFONj2Qtk1Fa6F3P3ywuB
         3jP12S/eVY+9ksDKNBWaSGu4SLAIM7VdEKguKPHUPcgIzte2ukzNfm7MoyGNDlI86Oq4
         Zv3DF2bExNaT8Mjtqce2VwiWKjvqawdQbEFwRNKO5cfUrChhzOY8aYsdXI9zPlASni2F
         IlxmHyyjcEBpbKzeHFZ2ABcks7l4bktGip/yPHTuE7OUU5DZAcY05Rtr60NvNTIC3hVI
         f5dw==
X-Forwarded-Encrypted: i=1; AJvYcCUAehImtB+tiQ5EHYZ8WiKvXBzuAy+bIQdNKn66m5ZFCmaSsHR7MgIzG+775fbq1Bs2aQQuyyGzClpqCd2TcU6C@vger.kernel.org
X-Gm-Message-State: AOJu0YwTEYPad2ZjwICwEdyI4WHv/vgG8wDlFu7Ir/vbUrP7xvNwPc7V
	DNFIxhRahD/OGEgrWgLp6rXx99w7YCUryNXH1GErAolA5fGMf0Du+Cij2iNr6LpCXc/qXVcb4oN
	0ljVSo6YULg==
X-Received: from dlnn3.prod.google.com ([2002:a05:7022:6183:b0:12a:b9fd:1f69])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea30:b0:128:ea68:27f1
 with SMTP id a92af1059eb24-12be6512241mr1299806c88.23.1775022743276; Tue, 31
 Mar 2026 22:52:23 -0700 (PDT)
Date: Tue, 31 Mar 2026 22:52:06 -0700
In-Reply-To: <20260401055206.43187-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228065953.3226283-1-irogers@google.com> <20260401055206.43187-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401055206.43187-8-irogers@google.com>
Subject: [PATCH v3 7/7] perf data convert ctf: Pipe mode improvements
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
 tools/perf/util/data-convert-bt.c | 59 ++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 665bf8eea24b..892e24acc44d 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1223,13 +1223,28 @@ static int add_event(struct ctf_writer *cw, struct evsel *evsel)
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
@@ -1418,6 +1433,18 @@ static int process_feature_event(const struct perf_tool *tool,
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
@@ -1448,6 +1475,26 @@ static int process_feature_event(const struct perf_tool *tool,
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
@@ -1677,9 +1724,10 @@ int bt_convert__perf2ctf(const char *input, const char *path,
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
@@ -1724,8 +1772,11 @@ int bt_convert__perf2ctf(const char *input, const char *path,
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

