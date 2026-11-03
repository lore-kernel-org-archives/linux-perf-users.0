Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749552;
	b=xOk21J3xQoSXnRubukqe5mVeiuFYh1JAPYkasxFPD7k1LCO1rIVBGpN8RW8c8pXYAiAN
	 K4wJHtX/7zmoLiZ0j7CwfeEF7g2m/ld/TQ9zgZ30kR1hvff/rik4l4KEuDcunzvOlpzs5
	 4tYHneGtSpwMlIS6CCq8iCianYMGMfzV3IaUztEV/uBGQE5/v2INego2wnG1C0AZGvv+2
	 NGJ+XMW/IUB4CbXsV1SSdh1nY28MZWliaC6kYW0377MYAANBid+AzlQm5d75+LD7wfnY5
	 cQ9FUjs6Kakzu/bjNHq/fC6Vej0+V8IJuS0/gTUJk7H9X+ftxkMTFLCt+Ol8jCVAFPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=mpEaec/6+HShY9aU8N2AFoDeb/QMeu9gxPXq6g3PcSU=;
	b=wr92ssEn+9nUu5bf9KQmmLgxr1zRAZojV+yXeFj1Ln9jdRTZULU4n2VeLw9qPX4mgKp6
	 bZr5d2nTNBnTmqza9GWXRPq8Jf3lw7Ap5FDX5YqcwjOk35yCLKEvVbQX7X9fQ8j5mkBdr
	 WoDLnig5fdfhwa2jGx/8jo+1hhMDvUERO5getY0e+eitjE96drzTDTE0ozdZ1QBT1L8UZ
	 9BNJ0SvMivBwNTVpJX/j7Sre8awnktjp9UVIa4dy/LSTBVDVpm2vq0e2uimoI197Z4iXr
	 gHO/lJ5b+ZynxCBHDjEu5ijnftGiFfu+yKkEd90k/EyQZtIM8BQQxcHZ8CffcuMEjQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dCq66kdC;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF03D606EEB6
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 23:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF03D606EEB6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dCq66kdC
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-359b81ad4e8so129384eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 15:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793749551; x=1794354351; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mpEaec/6+HShY9aU8N2AFoDeb/QMeu9gxPXq6g3PcSU=;
        b=dCq66kdCbpGuKqr5ou9D5jwqwpEushcQY9yXjadwnlXFXxB4ynmMxtxqTwvLp0SiDl
         eMqwPiBLO7BDOw8qZrY3t39JuM0b+N0siswoBWgiOR+aYwDO3Z8fUZDTn+GwlHgGRujb
         gJVedalnhszsK3KuBy5j10qpy6gdtdZU1MSRTNoRE8LwsMwwAvkiZIp7HFzfpNMgA0mT
         +N2RuZMvlvi8thbSvRMJd++KebM10Xpxh1/Ft2fIFUNAIG9r5A7V8Nmik4SKKqXEm3ud
         RPe61M5OqL1e643nI6K+Z72o72SqnbYVWF0fBfqceSQHmBHbYeIn+7dj4vPiGntGEtTG
         GX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749551; x=1794354351;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mpEaec/6+HShY9aU8N2AFoDeb/QMeu9gxPXq6g3PcSU=;
        b=WmGBeBODv0UGGFqdJ1nFIOJ7E6APmmF+LVbXtR103eyMgY72yJMaLxS/N0ScPa01UY
         jU7FXvwr3IT09Ma5dZfGyw04VvzzuSeKYZNUQ+GKzgl1BVyVPBh6r9hxwR2TIKgQ4Aqe
         IQ3E06E/yQ6XdSyuyV9CfCLgJMUuWXf+i9KWiwARpecr8wq6vavSPQt2IdbEPqR9kji1
         Exh2/eakJqW66Gc1C4HF1YMiqxArA3WARzWoIDklbpKYYDgNnsQt9wPXGrfNDv9f7Cvn
         NAZjWhx2IGAAkf3fSf+utFolC1Yr1f1dOv7KnhvKepP30tUKe0GKOHf/cqE6i2XfXRXH
         f2Gw==
X-Gm-Message-State: APuU4Z+wIDfTtXyT4OmPKbM5zvSbhuXgInFurb3Vw6jW2j2hRWqGVH90
	VHYs5kBxIiwEN1vyiufcnGBpgnmWYPoRRLlvW+Jl0w3HMJ02JfcmvehTtqbS32yumDJejZzSXYy
	MnFbZip/XX1Lp7AMzSUP0nSk7WxsenGyQkouFHA6zcxr3hFmxWYmlmteqAa5+SgqZKohuflpjD7
	nx8X4M+DAKBAvQ7IMULe8JYdGEbIS7TTHBjun477QRUoMh+u7rP2DtEdE=
X-Received: from dyx9.prod.google.com ([2002:a05:693c:8209:b0:36a:1148:43f8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6196:20b0:36c:b7b4:407e
 with SMTP id 5a478bee46e88-36cb7b4437fmr519179eec.22.1793749550261; Tue, 03
 Nov 2026 15:45:50 -0800 (PST)
Date: Tue,  3 Nov 2026 15:44:32 -0800
In-Reply-To: <20261103234502.1008382-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103234502.1008382-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103234502.1008382-17-irogers@google.com>
Subject: [PATCH v1 16/41] perf parse-events: Decode metric-id terms when
 adding events
From: Ian Rogers <irogers@google.com>
To: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, John Garry <john.garry@linux.dev>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@arm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ian Rogers <irogers@google.com>
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
 tools/perf/util/parse-events.c |  74 +++++++++++++++++++++-
 tools/perf/util/parse-events.h |   1 +
 3 files changed, 101 insertions(+), 84 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 51dbdeac5e60..b4a978794cc8 100644
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
@@ -1513,7 +1457,7 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
 		parse_events_error__print(&parse_error, events.buf);
 		goto err_out;
 	}
-	ret = decode_all_metric_ids(parsed_evlist, modifier);
+	ret = set_metric_event_names(parsed_evlist, modifier);
 	if (ret)
 		goto err_out;
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 159d847f44ce..1c02c2b90684 100644
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
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 57eabdb97890..bec75c2d7b32 100644
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
2.56.0.385.gac671c819a-goog

