Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE71374733
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 01:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772069750; cv=none; b=o3fYiOthD91TPZ/6GNwemYUJoek/EenKgD2OfFlkXlihH7RYt1YTlHfR75XbznSXNHtCuJhKvybCV8f+kjzRxHiphklTFbGXLhbWkeUoBhnFig49JXPAC+LnQAonTtIZmI12afU6YN2rWg71k/9T2nWn9VfbWAQoIt40LBBnmeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772069750; c=relaxed/simple;
	bh=IEvWPW1n7/Kn1d5hPQcRgfvhpDORPss82dHoBLWLewc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=VWPagMIIATqSqP2cpAbD0gN+Fj1/v2LCHxePCIddmM7kJ9RGDECN6cbecfF09i24el74vNtSFEyZXuYePp3XCm+Sg33LOlxrHyqolgW7GPWkK5F2O3yLmcX+NPEEBhGaHKTV9RFe9W9onXv2yU1JAOP/E5U6IVawyLTmCQO6Vfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EejhiDGt; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EejhiDGt"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdceedf659so4143626eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Feb 2026 17:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772069748; x=1772674548; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Ch336a8cLBjghfuvU9mziTIw0yFRPT1LCJ9GsF/8Iw=;
        b=EejhiDGtbs5+VzW+pH//o1wRMk+GqzRBXLVs6FPxBGPA7voWHCzKbefgYtt5wQbuBq
         u+eAA59rA6Q8NJwzMtHLEq8xPVBEod9QgbGRexJvEMLiVCeDZfO88sPyAjlmQ+SkSp0I
         LfikDE0wlKa16tYsGW/bKZGaFjIwmY+jGxwp2JSZFfTDe4o/OD10wgOCkuEQ5zeTYHhe
         og5ozeHKlwsjSzXeFf3Vb5LP7V2isBmdBL/Frf8w+OhNJBDHnL/QycmJl/zVCOWi5mxJ
         lav8yRraDV4p1l30TIw00+7Hl8KShif39j4EcLW9jPE8WLLZfajFHBXSKw4/0vto2xlq
         2nZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772069748; x=1772674548;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ch336a8cLBjghfuvU9mziTIw0yFRPT1LCJ9GsF/8Iw=;
        b=a4jnJQmTtXo0acMc8LcnRM3fJDWV6FWeyLnvDkFTmmWdmzYbgdzTwiYohY8d1MJEAw
         6ge3cjKfyytpZvpTVm/6JYpTnEZco3v2NPNtdVbgmgaXsjDOLlx5gandQPhVxqB6I4UE
         0pth95QBO5qjoom9UDP+YH26mGlk5q2Uy6355gUxdPCBMKCD5RC4phiiOfekMY0QLwP6
         rAiyurRaphY8XBM8m5TM9OINadISAJCpYZ1uaOXAbVT4Gsf4IsIYQJ7Pa2FupupP73MR
         c3wxuqF5IUx07FXZZpptsfUrsS4z6pu4vFuj5UNYuVa6+lpWS7WMgYjmDRBbkxtceWXN
         Ynlg==
X-Forwarded-Encrypted: i=1; AJvYcCXxZTsglfmDzsb5yWkRXCdbK+uZoEKQ4iqGfiQMZA+fAF45EAE2rY3PXI4riQFBb81RNtI9jSCIiuc5dY+VycRw@vger.kernel.org
X-Gm-Message-State: AOJu0YyLcNwuW0SM4Ph/XyfpYQzpSFqwl+NkfRcmK9Uq4uEgGEd+hNe8
	XpRsFnaT+SBnFbxi3j6VZ808IspCm1at6YGhnh9yNU/pB0pG/8v71Bx8/ah0Qg3R0+QPiLpl9mV
	CPCYJwlClEQ==
X-Received: from dybaz38.prod.google.com ([2002:a05:7300:6c26:b0:2ba:9dd4:fd0f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6417:b0:2ba:931e:7021
 with SMTP id 5a478bee46e88-2bd7bd6a485mr7679149eec.34.1772069747865; Wed, 25
 Feb 2026 17:35:47 -0800 (PST)
Date: Wed, 25 Feb 2026 17:35:33 -0800
In-Reply-To: <20260226013534.2028272-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226013534.2028272-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226013534.2028272-5-irogers@google.com>
Subject: [PATCH v1 4/5] perf header: Refactor pipe mode end marker handling
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Derek Foreman <derek.foreman@collabora.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Chun-Tse Shao <ctshao@google.com>, Hrishikesh Suresh <hrishikesh123s@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In non-pipe/data mode the header has a 256-bit bitmap representing
whether a feature is enabled or not. In pipe mode features are written
out in perf_event__synthesize_features as PERF_RECORD_HEADER_FEATURE
events with a special zero sized marker for the last feature. If a new
feature is added the last feature marker event appears as that feature
from old pipe mode perf data. As the event is zero sized it will fail
to be processed and generally terminate perf.

Add a last_feat variable to the header that in non-pipe/data mode is
just HEADER_LAST_FEATURE. In pipe mode compute the last_feat by
handling zero sized feature events, assuming they are the marker and
updating last_feat accordingly. Potentially a feature event could be
zero sized and so still process the feature event, just ignore the
error if it fails.

As perf_event__process_feature can properly handle pipe mode data,
migrate users to it except for report that still wants to group events
with the last feature marker. Make perf_event__process_feature
non-fatal in the case of a newer feature than this version of perf's
HEADER_LAST_FEATURE, which was the behavior all users wanted.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c       | 11 +-----
 tools/perf/builtin-report.c         | 27 ++++++---------
 tools/perf/builtin-script.c         | 11 +-----
 tools/perf/util/data-convert-bt.c   |  9 ++---
 tools/perf/util/data-convert-json.c | 12 +------
 tools/perf/util/header.c            | 53 ++++++++++++++++++++++-------
 tools/perf/util/header.h            |  4 ++-
 tools/perf/util/intel-tpebs.c       | 11 +-----
 8 files changed, 60 insertions(+), 78 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 9c27bb30b708..cf2d2011e148 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -313,15 +313,6 @@ static int process_sample_event(const struct perf_tool *tool,
 	return ret;
 }
 
-static int process_feature_event(const struct perf_tool *tool __maybe_unused,
-				 struct perf_session *session,
-				 union perf_event *event)
-{
-	if (event->feat.feat_id < HEADER_LAST_FEATURE)
-		return perf_event__process_feature(session, event);
-	return 0;
-}
-
 static int hist_entry__stdio_annotate(struct hist_entry *he,
 				    struct evsel *evsel,
 				    struct perf_annotate *ann)
@@ -876,7 +867,7 @@ int cmd_annotate(int argc, const char **argv)
 	annotate.tool.id_index	= perf_event__process_id_index;
 	annotate.tool.auxtrace_info	= perf_event__process_auxtrace_info;
 	annotate.tool.auxtrace	= perf_event__process_auxtrace;
-	annotate.tool.feature	= process_feature_event;
+	annotate.tool.feature	= perf_event__process_feature;
 	annotate.tool.ordering_requires_timestamps = true;
 
 	annotate.session = perf_session__new(&data, &annotate.tool);
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 3b81f4b3dc49..d1163f22648e 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -245,25 +245,18 @@ static int process_feature_event(const struct perf_tool *tool,
 				 union perf_event *event)
 {
 	struct report *rep = container_of(tool, struct report, tool);
+	int ret = perf_event__process_feature(tool, session, event);
 
-	if (event->feat.feat_id < HEADER_LAST_FEATURE)
-		return perf_event__process_feature(session, event);
-
-	if (event->feat.feat_id != HEADER_LAST_FEATURE) {
-		pr_err("failed: wrong feature ID: %" PRI_lu64 "\n",
-		       event->feat.feat_id);
-		return -1;
-	} else if (rep->header_only) {
-		session_done = 1;
+	if (ret == 0 && event->header.size == sizeof(struct perf_record_header_feature) &&
+	    (int)event->feat.feat_id == session->header.last_feat) {
+		/*
+		 * (feat_id = HEADER_LAST_FEATURE) is the end marker which means
+		 * all features are received, now we can force the group if
+		 * needed.
+		 */
+		setup_forced_leader(rep, session->evlist);
 	}
-
-	/*
-	 * (feat_id = HEADER_LAST_FEATURE) is the end marker which
-	 * means all features are received, now we can force the
-	 * group if needed.
-	 */
-	setup_forced_leader(rep, session->evlist);
-	return 0;
+	return ret;
 }
 
 static int process_sample_event(const struct perf_tool *tool,
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 7c743a303507..92b76ff24f16 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3939,15 +3939,6 @@ int process_cpu_map_event(const struct perf_tool *tool,
 	return set_maps(script);
 }
 
-static int process_feature_event(const struct perf_tool *tool __maybe_unused,
-				 struct perf_session *session,
-				 union perf_event *event)
-{
-	if (event->feat.feat_id < HEADER_LAST_FEATURE)
-		return perf_event__process_feature(session, event);
-	return 0;
-}
-
 static int perf_script__process_auxtrace_info(const struct perf_tool *tool,
 					      struct perf_session *session,
 					      union perf_event *event)
@@ -4423,7 +4414,7 @@ int cmd_script(int argc, const char **argv)
 #ifdef HAVE_LIBTRACEEVENT
 	script.tool.tracing_data	 = perf_event__process_tracing_data;
 #endif
-	script.tool.feature		 = process_feature_event;
+	script.tool.feature		 = perf_event__process_feature;
 	script.tool.build_id		 = perf_event__process_build_id;
 	script.tool.id_index		 = perf_event__process_id_index;
 	script.tool.auxtrace_info	 = perf_script__process_auxtrace_info;
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index ba1c8e48d495..665bf8eea24b 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1412,13 +1412,10 @@ static int process_feature_event(const struct perf_tool *tool,
 	struct convert *c = container_of(tool, struct convert, tool);
 	struct ctf_writer *cw = &c->writer;
 	struct perf_record_header_feature *fe = &event->feat;
+	int ret = perf_event__process_feature(tool, session, event);
 
-	if (event->feat.feat_id < HEADER_LAST_FEATURE) {
-		int ret = perf_event__process_feature(session, event);
-
-		if (ret)
-			return ret;
-	}
+	if (ret)
+		return ret;
 
 	switch (fe->feat_id) {
 	case HEADER_HOSTNAME:
diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 6a626322476a..4b1b2f7bed25 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -326,16 +326,6 @@ static void output_headers(struct perf_session *session, struct convert_json *c)
 	output_json_format(out, false, 2, "]");
 }
 
-static int process_feature_event(const struct perf_tool *tool __maybe_unused,
-				 struct perf_session *session,
-				 union perf_event *event)
-{
-	if (event->feat.feat_id < HEADER_LAST_FEATURE)
-		return perf_event__process_feature(session, event);
-
-	return 0;
-}
-
 int bt_convert__perf2json(const char *input_name, const char *output_name,
 		struct perf_data_convert_opts *opts __maybe_unused)
 {
@@ -375,7 +365,7 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
 	c.tool.auxtrace       = perf_event__process_auxtrace;
 	c.tool.event_update   = perf_event__process_event_update;
 	c.tool.attr           = perf_event__process_attr;
-	c.tool.feature        = process_feature_event;
+	c.tool.feature        = perf_event__process_feature;
 	c.tool.ordering_requires_timestamps = true;
 
 	if (opts->all) {
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index fe5d21dde04f..7031f6c6bd66 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3785,11 +3785,11 @@ static int perf_file_section__fprintf_info(struct perf_file_section *section,
 	struct feat_fd ff;
 
 	if (lseek(fd, section->offset, SEEK_SET) == (off_t)-1) {
-		pr_debug("Failed to lseek to %" PRIu64 " offset for feature "
-				"%d, continuing...\n", section->offset, feat);
+		pr_debug("Failed to lseek to %" PRIu64 " offset for feature %s (%d), continuing...\n",
+			 section->offset, header_feat__name(feat), feat);
 		return 0;
 	}
-	if (feat >= HEADER_LAST_FEATURE) {
+	if (feat >= ph->last_feat) {
 		pr_warning("unknown feature %d\n", feat);
 		return 0;
 	}
@@ -3841,7 +3841,7 @@ int perf_header__fprintf_info(struct perf_session *session, FILE *fp, bool full)
 		return 0;
 
 	fprintf(fp, "# missing features: ");
-	for_each_clear_bit(bit, header->adds_features, HEADER_LAST_FEATURE) {
+	for_each_clear_bit(bit, header->adds_features, header->last_feat) {
 		if (bit)
 			fprintf(fp, "%s ", feat_ops[bit].name);
 	}
@@ -4171,7 +4171,7 @@ int perf_header__process_sections(struct perf_header *header, int fd,
 	if (err < 0)
 		goto out_free;
 
-	for_each_set_bit(feat, header->adds_features, HEADER_LAST_FEATURE) {
+	for_each_set_bit(feat, header->adds_features, header->last_feat) {
 		err = process(sec++, header, feat, fd, data);
 		if (err < 0)
 			goto out_free;
@@ -4386,6 +4386,7 @@ int perf_file_header__read(struct perf_file_header *header,
 	ph->data_offset  = header->data.offset;
 	ph->data_size	 = header->data.size;
 	ph->feat_offset  = header->data.offset + header->data.size;
+	ph->last_feat	 = HEADER_LAST_FEATURE;
 	return 0;
 }
 
@@ -4401,8 +4402,8 @@ static int perf_file_section__process(struct perf_file_section *section,
 	};
 
 	if (lseek(fd, section->offset, SEEK_SET) == (off_t)-1) {
-		pr_debug("Failed to lseek to %" PRIu64 " offset for feature "
-			  "%d, continuing...\n", section->offset, feat);
+		pr_debug("Failed to lseek to %" PRIu64 " offset for feature %s (%d), continuing...\n",
+			 section->offset, header_feat__name(feat), feat);
 		return 0;
 	}
 
@@ -4435,6 +4436,8 @@ static int perf_file_header__read_pipe(struct perf_pipe_file_header *header,
 	if (ph->needs_swap)
 		header->size = bswap_64(header->size);
 
+	/* The last feature is written out as a 0 sized event and will update this value. */
+	ph->last_feat = 0;
 	return 0;
 }
 
@@ -4667,31 +4670,55 @@ int perf_session__read_header(struct perf_session *session)
 	return -ENOMEM;
 }
 
-int perf_event__process_feature(struct perf_session *session,
+int perf_event__process_feature(const struct perf_tool *tool __maybe_unused,
+				struct perf_session *session,
 				union perf_event *event)
 {
 	struct feat_fd ff = { .fd = 0 };
 	struct perf_record_header_feature *fe = (struct perf_record_header_feature *)event;
+	struct perf_header *header = &session->header;
 	int type = fe->header.type;
-	u64 feat = fe->feat_id;
+	int feat = (int)fe->feat_id;
 	int ret = 0;
 	bool print = dump_trace;
+	bool last_feature_mark = false;
 
 	if (type < 0 || type >= PERF_RECORD_HEADER_MAX) {
 		pr_warning("invalid record type %d in pipe-mode\n", type);
 		return 0;
 	}
-	if (feat == HEADER_RESERVED || feat >= HEADER_LAST_FEATURE) {
-		pr_warning("invalid record type %d in pipe-mode\n", type);
+	if (feat == HEADER_RESERVED) {
+		pr_warning("invalid reserved record type in pipe-mode\n");
 		return -1;
 	}
+	if (feat >= header->last_feat) {
+		if (event->header.size == sizeof(*fe)) {
+			// Either an unexpected zero size feature or the
+			// HEADER_LAST_FEATURE mark.
+			if (feat > header->last_feat)
+				header->last_feat = min(feat, HEADER_LAST_FEATURE);
+			last_feature_mark = true;
+		} else {
+			// A feature but beyond what is known as in
+			// bounds. Assume the last feature is 1 beyond this
+			// feature.
+			session->header.last_feat = min(feat + 1, HEADER_LAST_FEATURE);
+		}
+	}
+	if (feat >= HEADER_LAST_FEATURE) {
+		pr_warning("unknown feature %d for data file version (%s) in this version of perf (%s)\n",
+			   feat, header->env.version, perf_version_string);
+		return 0;
+	}
 
 	ff.buf  = (void *)fe->data;
 	ff.size = event->header.size - sizeof(*fe);
-	ff.ph = &session->header;
+	ff.ph = header;
 
 	if (feat_ops[feat].process && feat_ops[feat].process(&ff, NULL)) {
-		ret = -1;
+		// Processing failed, ignore when this is the last feature mark.
+		if (!last_feature_mark)
+			ret = -1;
 		goto out;
 	}
 
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index ca22030a1434..41ce663d93ff 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -109,6 +109,7 @@ struct perf_header {
 	u64				data_size;
 	u64				feat_offset;
 	DECLARE_BITMAP(adds_features, HEADER_FEAT_BITS);
+	int				last_feat;
 	struct perf_env 	env;
 };
 
@@ -172,7 +173,8 @@ int perf_header__process_sections(struct perf_header *header, int fd,
 
 int perf_header__fprintf_info(struct perf_session *s, FILE *fp, bool full);
 
-int perf_event__process_feature(struct perf_session *session,
+int perf_event__process_feature(const struct perf_tool *tool,
+				struct perf_session *session,
 				union perf_event *event);
 int perf_event__process_attr(const struct perf_tool *tool, union perf_event *event,
 			     struct evlist **pevlist);
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 3c958d738ca6..f57ea6db02a0 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -217,15 +217,6 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
-static int process_feature_event(const struct perf_tool *tool __maybe_unused,
-				 struct perf_session *session,
-				 union perf_event *event)
-{
-	if (event->feat.feat_id < HEADER_LAST_FEATURE)
-		return perf_event__process_feature(session, event);
-	return 0;
-}
-
 static void *__sample_reader(void *arg __maybe_unused)
 {
 	struct perf_session *session;
@@ -238,7 +229,7 @@ static void *__sample_reader(void *arg __maybe_unused)
 
 	perf_tool__init(&tool, /*ordered_events=*/false);
 	tool.sample = process_sample_event;
-	tool.feature = process_feature_event;
+	tool.feature = perf_event__process_feature;
 	tool.attr = perf_event__process_attr;
 
 	session = perf_session__new(&data, &tool);
-- 
2.53.0.414.gf7e9f6c205-goog

