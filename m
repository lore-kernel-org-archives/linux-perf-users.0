Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7410632BF44
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 05:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775022740; cv=none; b=HpW0nGiYwiIm23zRYQpSj1tvythF0FbAy39S0JGxEoGLb2mUCmbZGDANGl5QhaTBMl98EkaIfEkXknrJUykBgebC9rJtWLuhBQdyfPYZxMDJ8y44cH2oFlO6mUxOkN2XREbOo6spQl+ttBxbHyHoiRYMXO2WWI8q7+1jM6gtHbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775022740; c=relaxed/simple;
	bh=PXM+BLwlZ8CCfZa0qDaNhAQlRAUx8C2oC9SfyX2/JQY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S/Uvv78s7T8MTm8eyr8UpzuDyx/sP0WueS7t5ALQxg2+qSQaqtaamoB3KbM5jmR/J+fEm36AQDh4H7gdzHFTki2uEpscZM0wMfueB5poGZxZ/un5pKNJtFEeUWHThA6EedrQ/bBdO28qdEYv9RWTYrsxi2Jh4LDOqK6RLMiBy40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dkpR6jOG; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dkpR6jOG"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so8397930eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 22:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775022738; x=1775627538; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NyjU7aHUz6ttRQBqlC/pmKlD/QIAVmXTvilBeudkytQ=;
        b=dkpR6jOG1HQMOUHH0YoDzheoe4LtRx0F6q4zBzhqEBi6AG0aQgOvLavuyNGkFtCUP+
         wlL+J36/kn5wqcrhNoifKOw0HxoulWrmw3uTOnnz8mk0D3ScJzVvPg1hV3DQEFMUTK8M
         XnkX+hdJXXx3a+AOFEvCDWLUJQdKb99qLSeyXjTiFHRntH/JuL0bAw6NOMgvqRrpPcd4
         K9G1anjpwea99JAzPuUWoyfVCvLV2yABie9orZm4ZkoJgjBk+Li+k4+6+t9LLGEq9HGF
         jlDzjjrq7hf2NvmOGqUnDZffeBANZmvXn4phE28CI0h8Y8RWfYWZBk1nYPeRci8fPGOS
         WE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775022738; x=1775627538;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NyjU7aHUz6ttRQBqlC/pmKlD/QIAVmXTvilBeudkytQ=;
        b=oFR5NxyIgDye5ddFIi5YJa0XColRFc45ZHioMJTWwqVYFdNuMmBgH3cpI4zl5bTk2p
         XssB7KrHZPC43h2livBeBZX0e3rjt48qZpCYkPNYoy4VZfnt8KB5qv7zvSDCW8WAw3br
         +GXCI5DEyo3iU1Hfb85V1N1JyvkCiwrROERYUCb0iQqSxNR90xF8jMgH6uDxzVBse4vG
         Kbq9qihA7WLAx8wEe1khiLpC0zbbgS2q40xNtciztkFqyJPgpLT1mGtw3XmDkRG+NKQP
         2GGsrEQNG8U6FC4gAr2Y6fKaIpwuu1TpfQqK5iJBneHGKtif98ynAE7NGaqFMN/0thrO
         dxxw==
X-Forwarded-Encrypted: i=1; AJvYcCUpo0MSV5bCADqFF/E7+vx7euyTaeAC4lh3b8p182GzJB1NWtumMFKWWo8Cuv56NVzVyzELbsXJTKvYS+2bM07k@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8AKKHMgZxphbgFqDjphFxXO58CO6zbnSng4hlE6GD9yHClKxn
	1XFhQ8LJIY9rPMPXShLQ1cXJs2OFKfvYFul/NIeu/w1S7+O94vuv7y1T9Dq+oxXGJkJ0vaB0ggq
	bJhLlTe0RFg==
X-Received: from dyfv12.prod.google.com ([2002:a05:7300:824c:b0:2c9:d825:6f2a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:3013:b0:2c4:ec89:be4
 with SMTP id 5a478bee46e88-2c9333adfc9mr1282518eec.33.1775022737447; Tue, 31
 Mar 2026 22:52:17 -0700 (PDT)
Date: Tue, 31 Mar 2026 22:52:03 -0700
In-Reply-To: <20260401055206.43187-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228065953.3226283-1-irogers@google.com> <20260401055206.43187-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401055206.43187-5-irogers@google.com>
Subject: [PATCH v3 4/7] perf header: Refactor pipe mode end marker handling
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ashelat@redhat.com, ctshao@google.com, 
	derek.foreman@collabora.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	swapnil.sapkal@amd.com, thomas.falcon@intel.com
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
and stop header printing with the last feature marker. Make
perf_event__process_feature non-fatal in the case of a newer feature
than this version of perf's HEADER_LAST_FEATURE, which was the
behavior all users wanted.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c       | 11 +-----
 tools/perf/builtin-report.c         | 27 ++++++-------
 tools/perf/builtin-script.c         | 11 +-----
 tools/perf/util/data-convert-bt.c   |  9 ++---
 tools/perf/util/data-convert-json.c | 12 +-----
 tools/perf/util/header.c            | 59 ++++++++++++++++++++++-------
 tools/perf/util/header.h            |  4 +-
 tools/perf/util/intel-tpebs.c       | 11 +-----
 8 files changed, 67 insertions(+), 77 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 686ad08561d6..530348b6981b 100644
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
@@ -875,7 +866,7 @@ int cmd_annotate(int argc, const char **argv)
 	annotate.tool.id_index	= perf_event__process_id_index;
 	annotate.tool.auxtrace_info	= perf_event__process_auxtrace_info;
 	annotate.tool.auxtrace	= perf_event__process_auxtrace;
-	annotate.tool.feature	= process_feature_event;
+	annotate.tool.feature	= perf_event__process_feature;
 	annotate.tool.ordering_requires_timestamps = true;
 
 	annotate.session = perf_session__new(&data, &annotate.tool);
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 343c0ada5ea1..fd4741be8132 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -245,25 +245,20 @@ static int process_feature_event(const struct perf_tool *tool,
 				 union perf_event *event)
 {
 	struct report *rep = container_of(tool, struct report, tool);
+	int ret = perf_event__process_feature(tool, session, event);
 
-	if (event->feat.feat_id < HEADER_LAST_FEATURE)
-		return perf_event__process_feature(session, event);
+	if (ret == 0 && event->header.size == sizeof(struct perf_record_header_feature) &&
+	    (int)event->feat.feat_id == session->header.last_feat) {
+		/*
+		 * (feat_id = HEADER_LAST_FEATURE) is the end marker which means
+		 * all features are received.
+		 */
+		if (rep->header_only)
+			session_done = 1;
 
-	if (event->feat.feat_id != HEADER_LAST_FEATURE) {
-		pr_err("failed: wrong feature ID: %" PRI_lu64 "\n",
-		       event->feat.feat_id);
-		return -1;
-	} else if (rep->header_only) {
-		session_done = 1;
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
index b80c406d1fc1..4f95448c237a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3943,15 +3943,6 @@ int process_cpu_map_event(const struct perf_tool *tool,
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
@@ -4426,7 +4417,7 @@ int cmd_script(int argc, const char **argv)
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
index fe5d21dde04f..af4b6e3e4e1f 100644
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
 
@@ -4667,31 +4670,61 @@ int perf_session__read_header(struct perf_session *session)
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
+			/*
+			 * Either an unexpected zero size feature or the
+			 * HEADER_LAST_FEATURE mark.
+			 */
+			if (feat > header->last_feat)
+				header->last_feat = min(feat, HEADER_LAST_FEATURE);
+			last_feature_mark = true;
+		} else {
+			/*
+			 * A feature but beyond what is known as in
+			 * bounds. Assume the last feature is 1 beyond this
+			 * feature.
+			 */
+			session->header.last_feat = min(feat + 1, HEADER_LAST_FEATURE);
+		}
+	}
+	if (feat >= HEADER_LAST_FEATURE) {
+		if (!last_feature_mark) {
+			pr_warning("unknown feature %d for data file version (%s) in this version of perf (%s)\n",
+				   feat, header->env.version, perf_version_string);
+		}
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
index 2af5455488b2..8b615dc94e9e 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -216,15 +216,6 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
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
@@ -237,7 +228,7 @@ static void *__sample_reader(void *arg __maybe_unused)
 
 	perf_tool__init(&tool, /*ordered_events=*/false);
 	tool.sample = process_sample_event;
-	tool.feature = process_feature_event;
+	tool.feature = perf_event__process_feature;
 	tool.attr = perf_event__process_attr;
 
 	session = perf_session__new(&data, &tool);
-- 
2.53.0.1118.gaef5881109-goog

