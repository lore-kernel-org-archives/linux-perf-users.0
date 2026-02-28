Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903F234574B
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Feb 2026 07:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772262024; cv=none; b=dNj2CRYADSoFfU8XzOtF7jK6y/Qz5N6828sxMoGn1ZEokRcbwqDyGf0qTvnIasKvgFNQYATenOBkn8lw4zWpY7STVwZDT/19L9aqNz7to1KD+bW2jaFJT+aYyY/oFIJQPPg241KhJrVc7QG+xbAQhizJwOQ9xUaFzoT8zx1/ZTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772262024; c=relaxed/simple;
	bh=C+BNnrCCmJA4FL3QKjxBkSimosch1QmHNVNHpMakgjQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mZvDV1mNVUs8kVgIr/vnlpa9gDFPUEAxrp4falZAhKV/5TFakqxFVFsORNgUEHOyqXmYJJSJotUcIi2BgzhEVs3xgwkKJjT7N/ebVPc+Ad47Fnqd9ftqOofARthKCM4t4ZfV7DPqnhlFYLhCzU7iyfUAqTlPvTIG2LLlbSr4ifY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=STMUiEQ/; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="STMUiEQ/"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdc87facf6so2913046eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Feb 2026 23:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772262021; x=1772866821; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wydvp72L5ex8AMv7NN/10Q5kEpk3VQLHsgnYQce3iPI=;
        b=STMUiEQ/USIFeRf6PKTcS5iFGRAXfy96UCjCsH+7Ieb1moLSCYG6iayTnROGxkCU0F
         0jf6ms2YKl8DhFOMchZu2LEI9coG5Gig5Xyk/2u4J/ZLjYlsHhxugWG9sIS0pwWWTWsr
         VGuO7Iwzgh7bdzNod4YT5qVSBTPq/ASQJKbHYoB5KPWK3XKdh8lJSg8cc8QmH9WHF7QF
         VqliSWbszp+x9IqxuOal6YcwPZJ2HJ2vxt9cYOcaA0tUfJggkMWHNFmQROq9qaorFw6b
         DosOFHNKVqWpvDb49+Jpd/vcYUsvU1qaQ+uAj+/RTpBc1tScJSbQ05ZpglPx10X/IPSr
         a8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772262021; x=1772866821;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wydvp72L5ex8AMv7NN/10Q5kEpk3VQLHsgnYQce3iPI=;
        b=UPzGZ83jlK/cvK/UoSEeGUvBTyI1/q1RzHKgQBgilPjfZoEgkbcmOEh+e/DEFY1XX1
         i6enbhML+DtH3/Frg9t7gzHaGsnBVgzkz9oQ2Rxgegklnotyz1LkF/IRAV1QSgpi/AJr
         2MKGu/VuUMNVbbPXrIU1NbBYHmrfyQASG+wxJrPFQ+W6eXJ/8284/admdGNqABoA+9c/
         qCmHsPVPi7GVzWfJAA7JTrD3kTRgYz6to0mpUpT0qdCvo90kQk6168R1IQS5EEn17LyE
         EcWbmPs3KsgI3WZ8BbkEAstXgFio4GHwVAadoNxBk4tsIDA8Glu/wvLmzk4OAy2MXHsu
         cs3g==
X-Forwarded-Encrypted: i=1; AJvYcCUafbEEEEjgsIow5n+56IXuUmun1pgoJFZVVksF4Z8PQSB56VjtjaOe1zJWmDKXg+PlsW3a1ARNPmmPoQgQXldc@vger.kernel.org
X-Gm-Message-State: AOJu0Yycs4nTD+JEI3J+bi4cEFSQGE2ZBjP73M/92Qy+Mm9/LG88pYyQ
	dA0gAp5iCHC52/maoq3cSSwhqnU3oVg+OZ7G9u01qDTp2ofKEK5SjGbKll7w0Xt9mbn6TAqX0sc
	cTQLomYdT3A==
X-Received: from dybcr37.prod.google.com ([2002:a05:7300:aca5:b0:2ba:6ffb:dc6e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a187:b0:2ae:51fa:b7ec
 with SMTP id 5a478bee46e88-2bde1cbdeebmr1958091eec.25.1772262020261; Fri, 27
 Feb 2026 23:00:20 -0800 (PST)
Date: Fri, 27 Feb 2026 22:59:53 -0800
In-Reply-To: <20260228065953.3226283-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228065953.3226283-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228065953.3226283-8-irogers@google.com>
Subject: [PATCH v2 7/7] perf data convert ctf: Pipe mode improvements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Derek Foreman <derek.foreman@collabora.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Chun-Tse Shao <ctshao@google.com>, Hrishikesh Suresh <hrishikesh123s@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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
 tools/perf/util/data-convert-bt.c | 54 +++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 665bf8eea24b..5d35e9822b8f 100644
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
@@ -1725,7 +1773,7 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 		goto free_writer;
 
 	/* CTF events setup */
-	if (setup_events(cw, session))
+	if (setup_events(cw, session, SETUP_EVENTS_ALL))
 		goto free_writer;
 
 	if (opts->all && setup_non_sample_events(cw, session))
-- 
2.53.0.473.g4a7958ca14-goog

