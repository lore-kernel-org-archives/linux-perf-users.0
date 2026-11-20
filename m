Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212921;
	b=e6mwxwRiibIiCltCFGiq7St0H5TthSEM/gFrYn1meSya7HG+3u2ITkFUhuuHNMOstlv3
	 TvOtNeCIE0HmU/sDQGBmqGT47Wk8id7zjnFnBYj6y84umQ5CF47I2y/bk9WNQE5dkXZg9
	 vMzP1G/L8pVKIq9rE+rbRlP29Tyh31my911P1locaEzW+cZ3rSjnukuW/8uLQIKARsk2L
	 9U4Absy37vMDQWg+75JA5bdwp5qxsaVbmXldfiK2X4yJX9O2JLsNyEgH3mhyCCQ/SSSBo
	 /cWBX7Y+a43k+fpc2q8KTt0AxU6wW/KakxelNYJXQkq+sz5dt7WpxIoWUdnIN9NFWlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=dMnEbDK8wYGDtn9mWnEYq0107+ljqwGa7pSjkv3/TiM=;
	b=GrsvOhbcTEYDh80Ts/zgm12eKGBooBAEeFEWk5EP+SSBM1uvW0nzupNih3sKJKajUHSH
	 zwThKLsVmfQ0Ra4Qq5cWQzNjsSoPewos6qb3kG74C3vzAjQ0FrS0ugoXjlqugnVI0djHD
	 /+dFOGoPIQJ8ZV4lT21LU7UQxPyljaGjWgXgQ3xbia1JrEbMDM4CzxiX4uTryFcGnhChg
	 leBU4b7Dv1gp5eLD/A2PKngcTmBluwAHnCyoY2mVO94GuR3AhsVBbQGAyNct38eDPksmm
	 8+t7zKNJfCp4Sn5ABQqBLQZE0aaClzGuvLC7tlQ2iasXzCPCVGHyu/jVUjjcwTmGZWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Yg981a8O;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C36606A6B1
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31C36606A6B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Yg981a8O
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2efad644688so13070305ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795212917; x=1795817717; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dMnEbDK8wYGDtn9mWnEYq0107+ljqwGa7pSjkv3/TiM=;
        b=Yg981a8OOKrMjZWrsbdLuIjydDY4TdFSNTo1mnkhm0FEyh63ZVWkUGTXVdcHcG1XyH
         nRz8tk8JvYb8jXz1L/bs8vKcMlZEsiCd3t7AY0PqsgWcb77L+QL6fs1tCg4erJvmixeP
         LIoRbkLEY63mkbMY5RgyAErC1sO62PO7nbXNwXhqf4RuXLI17mbDbVregA9DC6Db2X1v
         u8ZVFvUgw4gjPEk9gsIszgw7c7C/I8Xq/s3oQjLLiJEe1Ga7YzYkorv3YcmdWpl/5Gpv
         UORPFOzz9I1VUc9fVW1+W0uson5dgpW2y0nMUBtkU2ddH6qw5cA2n0FHJZH+o3zTTjgU
         G2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212917; x=1795817717;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dMnEbDK8wYGDtn9mWnEYq0107+ljqwGa7pSjkv3/TiM=;
        b=2aMHKtGSCAmLvEgbFze/CSNBH/4kpxC/v60RqLtO/GyX/r5+ws1kjDvXxnaWZKWlo/
         14G/izhQVVP8GLpPEz1A+NYvG5tqb0pceraOvejH9H2WdflR7WoJVaL2fIEMH0nIMtCk
         ZmdEmjuafseXoHKPylmuAH8nQrjIvqw/Zyto54H1ZNmFGGp0fCVZ8honb8pDHcSfwqsG
         uES6XyGHbALt/Pa2zE9bKYIXAFlN6aTpCVpN4Irh3nvc0BfUcn9CaNuLhU+CpXho0sg+
         EEg0PMx0UVh92xDx5qtQAphGwdxd4Fv1AU+c5JgSYwJ6EGSOl9twOPB3e9efJLTpWHDE
         lqxQ==
X-Gm-Message-State: APuU4Z/2H2GFOwDlezWGyBzAoJpaBjCPGmS/SGQvcmJiEfz/p0gYNmFE
	QFxtGgAPqz+HqkiQto3xjU9awUeQSM3du3knRDHHUj0LMH0YEHessw5WzXT8oI0Iuot5yfjulmA
	sSBxczvYKHg==
X-Received: from pjte4.prod.google.com ([2002:a17:90a:c204:b0:3b4:a73:5d7c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1801:b0:3b3:ffa8:6bc5
 with SMTP id 98e67ed59e1d1-3b41c9823cemr4035343a91.60.1795212917097; Fri, 20
 Nov 2026 14:15:17 -0800 (PST)
Date: Fri, 20 Nov 2026 14:13:21 -0800
In-Reply-To: <20261120221332.2245191-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120221332.2245191-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120221332.2245191-21-irogers@google.com>
Subject: [PATCH v3 20/30] perf parse-events: Decode metric-id terms when
 adding events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Metric events are parsed from an event string where the identifier from
the metric expression is passed as a metric-id term. As characters such
as '@' and ',' can't appear in a term value the metricgroup code encodes
them and, after parsing, walked the parsed evlist replacing each evsel's
metric_id with its decoded version.

Move the encoding and decoding to parse-events.c, adding
parse_events__encode_metric_id() for the metricgroup code, and store the
decoded metric-id on the evsel when it is created in __add_event(). This
avoids rewriting the metric_id of evsels after parsing, leaving
metricgroup with only the replacement of the evsel names of metric
events by friendlier versions of the metric-id. While moving the
decoding, fix the out of bounds check on the encoded character index
and return -EINVAL for a bad encoding.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c  | 110 ++++++++-------------------------
 tools/perf/util/parse-events.c |  82 +++++++++++++++++++++++-
 tools/perf/util/parse-events.h |   1 +
 3 files changed, 108 insertions(+), 85 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 9922445a6d15..08679392bf6d 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -610,57 +610,13 @@ int metricgroup__add_matching_metrics(struct evlist *evlist, bool system_wide)
 					    find_matching_metrics_cb, &args);
 }
 
-static const char *code_characters = ",-=@";
-
-static int encode_metric_id(struct strbuf *sb, const char *x)
-{
-	int ret = 0;
-
-	for (; *x; x++) {
-		const char *c = strchr(code_characters, *x);
-		if (c) {
-			ret = strbuf_addch(sb, '!');
-			if (ret)
-				break;
-
-			ret = strbuf_addch(sb, '0' + (c - code_characters));
-			if (ret)
-				break;
-		} else {
-			ret = strbuf_addch(sb, *x);
-			if (ret)
-				break;
-		}
-	}
-	return ret;
-}
-
-static int decode_metric_id(struct strbuf *sb, const char *x)
-{
-	const char *orig = x;
-	size_t i;
-	char c;
-	int ret;
-
-	for (; *x; x++) {
-		c = *x;
-		if (*x == '!') {
-			x++;
-			i = *x - '0';
-			if (i > strlen(code_characters)) {
-				pr_err("Bad metric-id encoding in: '%s'", orig);
-				return -1;
-			}
-			c = code_characters[i];
-		}
-		ret = strbuf_addch(sb, c);
-		if (ret)
-			return ret;
-	}
-	return 0;
-}
-
-static int decode_all_metric_ids(struct evlist *perf_evlist, const char *modifier)
+/*
+ * The metric events are parsed with a metric-id holding the identifier used in
+ * the metric expression. If the evsel name is just the parsed event, which
+ * contains the encoded metric-id, use the metric-id to give a more friendly
+ * display version.
+ */
+static int set_metric_event_names(struct evlist *perf_evlist, const char *modifier)
 {
 	struct evsel *ev;
 	struct strbuf sb = STRBUF_INIT;
@@ -668,51 +624,39 @@ static int decode_all_metric_ids(struct evlist *perf_evlist, const char *modifie
 	int ret = 0;
 
 	evlist__for_each_entry(perf_evlist, ev) {
-		if (!ev->metric_id)
+		bool has_slash = false;
+
+		if (!ev->metric_id || !strstr(ev->name, "metric-id="))
 			continue;
 
 		ret = strbuf_setlen(&sb, 0);
 		if (ret)
 			break;
 
-		ret = decode_metric_id(&sb, ev->metric_id);
+		ret = strbuf_addstr(&sb, ev->metric_id);
 		if (ret)
 			break;
 
-		free((char *)ev->metric_id);
-		ev->metric_id = strdup(sb.buf);
-		if (!ev->metric_id) {
-			ret = -ENOMEM;
-			break;
+		zfree(&ev->name);
+		for (cur = strchr(sb.buf, '@') ; cur; cur = strchr(++cur, '@')) {
+			*cur = '/';
+			has_slash = true;
 		}
-		/*
-		 * If the name is just the parsed event, use the metric-id to
-		 * give a more friendly display version.
-		 */
-		if (strstr(ev->name, "metric-id=")) {
-			bool has_slash = false;
-
-			zfree(&ev->name);
-			for (cur = strchr(sb.buf, '@') ; cur; cur = strchr(++cur, '@')) {
-				*cur = '/';
-				has_slash = true;
-			}
 
-			if (modifier) {
-				if (!has_slash && !strchr(sb.buf, ':')) {
-					ret = strbuf_addch(&sb, ':');
-					if (ret)
-						break;
-				}
-				ret = strbuf_addstr(&sb, modifier);
+		if (modifier) {
+			if (!has_slash && !strchr(sb.buf, ':')) {
+				ret = strbuf_addch(&sb, ':');
 				if (ret)
 					break;
 			}
-			ev->name = strdup(sb.buf);
-			if (!ev->name) {
-				ret = -ENOMEM;
+			ret = strbuf_addstr(&sb, modifier);
+			if (ret)
 				break;
-			}
+		}
+		ev->name = strdup(sb.buf);
+		if (!ev->name) {
+			ret = -ENOMEM;
+			break;
 		}
 	}
 	strbuf_release(&sb);
@@ -787,7 +731,7 @@ static int metricgroup__build_event_string(struct strbuf *events,
 			ret = strbuf_addstr(events, "/metric-id=");
 			RETURN_IF_NON_ZERO(ret);
 		}
-		ret = encode_metric_id(events, id);
+		ret = parse_events__encode_metric_id(events, id);
 		RETURN_IF_NON_ZERO(ret);
 		ret = strbuf_addstr(events, "/");
 		RETURN_IF_NON_ZERO(ret);
@@ -1514,7 +1458,7 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
 		parse_events_error__print(&parse_error, events.buf);
 		goto err_out;
 	}
-	ret = decode_all_metric_ids(parsed_evlist, modifier);
+	ret = set_metric_event_names(parsed_evlist, modifier);
 	if (ret)
 		goto err_out;
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 0044b6c27ea6..b54ab0604e4e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -171,6 +171,73 @@ static void fix_raw(struct parse_events_terms *config_terms, struct perf_pmu *pm
 	}
 }
 
+/*
+ * Characters that can't appear in a metric-id term value are encoded as '!'
+ * followed by the character's index in this string.
+ */
+static const char *metric_id_code_characters = ",-=@";
+
+/**
+ * parse_events__encode_metric_id - Encode a metric identifier as a metric-id
+ *                                  term value.
+ * @sb: The buffer the encoded identifier is appended to.
+ * @x: The metric identifier to encode.
+ *
+ * Return: 0 on success or the strbuf error.
+ */
+int parse_events__encode_metric_id(struct strbuf *sb, const char *x)
+{
+	int ret = 0;
+
+	for (; *x; x++) {
+		const char *c = strchr(metric_id_code_characters, *x);
+
+		if (c) {
+			ret = strbuf_addch(sb, '!');
+			if (ret)
+				break;
+
+			ret = strbuf_addch(sb, '0' + (c - metric_id_code_characters));
+			if (ret)
+				break;
+		} else {
+			ret = strbuf_addch(sb, *x);
+			if (ret)
+				break;
+		}
+	}
+	return ret;
+}
+
+/*
+ * Decode a metric-id term value encoded by parse_events__encode_metric_id()
+ * into @sb.
+ */
+static int parse_events__decode_metric_id(struct strbuf *sb, const char *x)
+{
+	const char *orig = x;
+	size_t i;
+	char c;
+	int ret;
+
+	for (; *x; x++) {
+		c = *x;
+		if (*x == '!') {
+			x++;
+			i = *x - '0';
+			if (i >= strlen(metric_id_code_characters)) {
+				pr_err("Bad metric-id encoding in: '%s'", orig);
+				return -EINVAL;
+			}
+			c = metric_id_code_characters[i];
+		}
+		ret = strbuf_addch(sb, c);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 static struct evsel *
 __add_event(struct list_head *list, int *idx,
 	    struct perf_event_attr *attr,
@@ -261,7 +328,12 @@ __add_event(struct list_head *list, int *idx,
 	}
 
 	if (metric_id) {
-		evsel->metric_id = strdup(metric_id);
+		struct strbuf sb = STRBUF_INIT;
+		int ret = parse_events__decode_metric_id(&sb, metric_id);
+
+		if (!ret)
+			evsel->metric_id = strdup(sb.buf);
+		strbuf_release(&sb);
 		if (!evsel->metric_id)
 			goto out_err;
 	}
@@ -668,6 +740,7 @@ int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 	struct perf_event_attr attr;
 	LIST_HEAD(config_terms);
 	const char *name;
+	int ret;
 
 	memset(&attr, 0, sizeof(attr));
 	attr.bp_addr = addr;
@@ -698,8 +771,11 @@ int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 
 	name = get_config_name(head_config);
 
-	return add_event(list, parse_state, &attr, name, /*mertic_id=*/NULL,
+	ret = add_event(list, parse_state, &attr, name, /*mertic_id=*/NULL,
 			&config_terms, /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
+	/* Free the config terms if they weren't moved to an evsel. */
+	free_config_terms(&config_terms);
+	return ret;
 }
 
 static int check_type_val(struct parse_events_term *term,
@@ -1624,6 +1700,8 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 			    &config_terms, first_wildcard_match, term_cpu, alternate_hw_config);
 	perf_cpu_map__put(term_cpu);
 	if (!evsel) {
+		/* The config terms weren't moved to an evsel. */
+		free_config_terms(&config_terms);
 		parse_events_terms__exit(&parsed_terms);
 		return -ENOMEM;
 	}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 8df8e3cb69fe..68efbd24df9b 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -245,6 +245,7 @@ int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
 				      const char *name, const char *metric_id,
 				      struct perf_pmu *pmu);
+int parse_events__encode_metric_id(struct strbuf *sb, const char *x);
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			       const char *event_name,
-- 
2.56.1.750.gf70dc682cf-goog

