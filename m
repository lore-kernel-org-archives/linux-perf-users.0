Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF131991AF
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723502486; cv=none; b=UD6rwi0h0YUjF/K9cV+WtOqyxmYhJuqPLBbmh+IjK/CuJ4RH654h/LRZD5GIOrUJuM7mY2l+VNiEQrMWdk+HwbUjWVde9Qs6/2oKejzFU+ZN/kzJxzaA2A52BhTIXWXEK1NhWIT8Zca/XYxdGadWgpDrKhdSBCcrvHBEuo9jMCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723502486; c=relaxed/simple;
	bh=1BK8z2XULtdIVPGkiOToSqoTKrPpUjCt/L+mGV60+Fw=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=rigHOU2S9ka6F+pV0/Bee+2LcmYwhPlEm24S0QBkAakMi/ppGVBAjfb8hGmxISdxxQVk0O5T7sQyFC0Zep1Fvf/oiTKSQ7jiBpRlcUb4SMTBDl75MUvRTwoUj4+UirhZnVoOAM3PIeqxuSrOe8kdAdohu9adTuaOVkutk47HcWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AA3lRqLu; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AA3lRqLu"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-66890dbb7b8so112028117b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 15:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723502484; x=1724107284; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pm2t6WwfGgk6gRoXF3WhxnoAzys25tdRXmYv3pSCxpI=;
        b=AA3lRqLu/q63RClJx2w8pAh6tLuG+tHL8yxVGzpywyI0eeacuu6VuLMH7W6jPaXNzS
         4K93mXc0KKbzehQAuHFEKmf/jp4oLfwjk3aihmYy/TaNIMnycPCsasblxg65npYBq1Ov
         JgLRO5R43RWPzj4jofQDnaqn9AS7Y9tg/gS9aETTr5qYqwG9eWvcshuzDRofYe47DLtB
         rXIauQEWo7HEPAkYPRker2qa934aTjB1iDZzpKSEOz2o0IL27bizhFrrt7L+tnQnZU4d
         NjIoqHyJsF1XXli5VSN64C9ykV3sgYDonTzCDPS5FfJKWILcTQiwZGOeKOKfEy12c+9r
         uxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723502484; x=1724107284;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pm2t6WwfGgk6gRoXF3WhxnoAzys25tdRXmYv3pSCxpI=;
        b=q6/Xc3g5UKK34CxyfI8USZeNGcJoJe55mBmcl7UVgpDo3OV1l2UiB5O0MEZ+ebmd1+
         NnLsIJvAMLhlyU9/zhic/gpjtACOlI8n7YnyPo85cGNmxjM0DHC2y4QD+tuMDzJk7A61
         V6lsqqHHOvumdmLhuO3kggASBJfSEzW+3Ydk/rytmxFmlG7roLWdAGCDFAA2tNLuQShm
         cevIHnqyghVw0SckkneI/NWN6fLUoR5YR6RLan8o5AsBR9K/Grd7fqNGIQkLhqBHEY9x
         pna0SFemPmPbDGjcEaXPA48griglJOlxxJxw0ar8nLrumFGq/i4UYUgna9Akkg6V1qnh
         mF/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXg9sTgM71flJacsWnhguxErs1E/mc2FMgSIfxh8/YIbqrjDI10ARai0pDAeTImuYOV8svCotm65G9TCVFEKn7keRQpVBQGp+51vQASs6N5ug==
X-Gm-Message-State: AOJu0YxWjPBbAh5T8FIuMr3dAifybe9F+KQRwSF9c+ydhFVVlkTsVH3N
	T5Q/DdZXUtt6tKs9dz2FvYCvWR8KgEglHAOkHPdO5dWwRrBTLURB0mzY4dEkCY2lvzjauBtnek7
	dzOM5+A==
X-Google-Smtp-Source: AGHT+IE+2pdIWlKTDrJM4PaFie/AQK39qFeKpjTITX2AZ1sbuUVYCU9f+oxlk85knZFdb/1HUYPgA+r9a60z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ae34:31b6:7154:c399])
 (user=irogers job=sendgmr) by 2002:a0d:e4c1:0:b0:615:32e1:d82c with SMTP id
 00721157ae682-6a97732c587mr112287b3.6.1723502483725; Mon, 12 Aug 2024
 15:41:23 -0700 (PDT)
Date: Mon, 12 Aug 2024 15:41:19 -0700
Message-Id: <20240812224119.744968-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v2] perf inject: Inject build ids for entire call chain
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Casey Chen <cachen@purestorage.com>, Tom Zanussi <tzanussi@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The DSO build id is injected when the dso is first encountered but the
checking for first encountered only looks at the sample->ip not the
entire callchain. Use the callchain logic to ensure all build ids are
inserted.

Add a for_each callback style API to callchain with
sample__for_each_callchain_node. Possibly in the future such an API
can avoid the overhead of constructing the call chain list.

Fixes: 454c407ec17a ("perf: add perf-inject builtin")
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
v2. Rebase and add Namhyung's acked-by.
---
 tools/perf/builtin-inject.c | 31 +++++++++++++++++++++++++++++++
 tools/perf/util/callchain.c | 35 +++++++++++++++++++++++++++++++++++
 tools/perf/util/callchain.h |  6 ++++++
 3 files changed, 72 insertions(+)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index ef9cba173dd2..a35bde3f3c09 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -743,6 +743,29 @@ static int dso__inject_build_id(struct dso *dso, const struct perf_tool *tool,
 	return 0;
 }
 
+struct mark_dso_hit_args {
+	const struct perf_tool *tool;
+	struct machine *machine;
+	u8 cpumode;
+};
+
+static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data)
+{
+	struct mark_dso_hit_args *args = data;
+	struct map *map = node->ms.map;
+
+	if (map) {
+		struct dso *dso = map__dso(map);
+
+		if (dso && !dso__hit(dso)) {
+			dso__set_hit(dso);
+			dso__inject_build_id(dso, args->tool, args->machine,
+					     args->cpumode, map__flags(map));
+		}
+	}
+	return 0;
+}
+
 int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *event,
 			       struct perf_sample *sample,
 			       struct evsel *evsel __maybe_unused,
@@ -750,6 +773,11 @@ int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *e
 {
 	struct addr_location al;
 	struct thread *thread;
+	struct mark_dso_hit_args args = {
+		.tool = tool,
+		.machine = machine,
+		.cpumode = sample->cpumode,
+	};
 
 	addr_location__init(&al);
 	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
@@ -769,6 +797,9 @@ int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *e
 		}
 	}
 
+	sample__for_each_callchain_node(thread, evsel, sample, PERF_MAX_STACK_DEPTH,
+					mark_dso_hit_callback, &args);
+
 	thread__put(thread);
 repipe:
 	perf_event__repipe(tool, event, sample, machine);
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 6d075648d2cc..0d608e875fe9 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1797,3 +1797,38 @@ s64 callchain_avg_cycles(struct callchain_node *cnode)
 
 	return cycles;
 }
+
+int sample__for_each_callchain_node(struct thread *thread, struct evsel *evsel,
+				    struct perf_sample *sample, int max_stack,
+				    callchain_iter_fn cb, void *data)
+{
+	struct callchain_cursor *cursor = get_tls_callchain_cursor();
+	int ret;
+
+	if (!cursor)
+		return -ENOMEM;
+
+	/* Fill in the callchain. */
+	ret = thread__resolve_callchain(thread, cursor, evsel, sample,
+					/*parent=*/NULL, /*root_al=*/NULL,
+					max_stack);
+	if (ret)
+		return ret;
+
+	/* Switch from writing the callchain to reading it. */
+	callchain_cursor_commit(cursor);
+
+	while (1) {
+		struct callchain_cursor_node *node = callchain_cursor_current(cursor);
+
+		if (!node)
+			break;
+
+		ret = cb(node, data);
+		if (ret)
+			return ret;
+
+		callchain_cursor_advance(cursor);
+	}
+	return 0;
+}
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index d5c66345ae31..76891f8e2373 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -311,4 +311,10 @@ u64 callchain_total_hits(struct hists *hists);
 
 s64 callchain_avg_cycles(struct callchain_node *cnode);
 
+typedef int (*callchain_iter_fn)(struct callchain_cursor_node *node, void *data);
+
+int sample__for_each_callchain_node(struct thread *thread, struct evsel *evsel,
+				    struct perf_sample *sample, int max_stack,
+				    callchain_iter_fn cb, void *data);
+
 #endif	/* __PERF_CALLCHAIN_H */
-- 
2.46.0.76.ge559c4bf1a-goog

