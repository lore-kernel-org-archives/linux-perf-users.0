Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81BB13D509
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 03:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722481975; cv=none; b=OXxcHdURAQT0Q6NbXVakl6Rh4DEuF7WuSnjDopVukx7Hpr8QdT/oNPSd0/UWTU7HY+b0XA3tGmv0pSud3uXnXR2cvod+qNL+Ey0VueSx2wdRN19CMFTnmRYrI6XYmnUWa5vxcRIW9w+Z5MjeAdigVJRyGMqbKhrsG3NkRLsTRfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722481975; c=relaxed/simple;
	bh=h2lAsBTXLxPhRBb3ysA8UFlIfWxaaF+QPO8Uu3qrLJY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=mgNf8qwY6c9hRVGtBQLmtUS1wNezW39Z+Wb6MHfSXVr+ExV90vhbU0rESB5ujij1K3rzu8F43U0VB9Z4ogA0+Afli0Lke0RF6+lj9jk7HvjIM3GS8C2lRs6QFBylIzBwrOdndopafSkLzDVagEA4GKd2aKLmC0ZyNex1F1qQGpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=klhlnBN1; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="klhlnBN1"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03623b24ddso9436287276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 20:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722481973; x=1723086773; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1TvkJFAL9mX5DXtyFw/mukLg8CpbmZFmUTL4HXhsVyM=;
        b=klhlnBN1fDdWROpvFYUIsIdsEzqXgvdJVLvzkex1Z07tZ3MqwcmrWk7nW4cOBYemwX
         5hm3WyQ236d7JJr21ElcVfty0IEBEs0+d7SRrTZ2Qm2e+VdJ0f7+qiXmqP2rXrtykeYB
         mx6ytsb+/p/zIlrFEjdomsl1mBbi6u8KMNaEovlRUDEDjg2F3j2QbSoWJjH0kTmcMCuN
         +P9X/0vfiS85K15wOZLdv8ldXsxzB57erFMvqo9Bz4O0LYHbYc9BR3t+6Y+dh+BSgCIQ
         1vMgK+FH2UeBQtZZebwMom5XUTiM6EHcurwd07ROX3zDYtx3A+BrBLeeCvwsUNBflb6Y
         Hy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722481973; x=1723086773;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1TvkJFAL9mX5DXtyFw/mukLg8CpbmZFmUTL4HXhsVyM=;
        b=uq5XGSRO330HH6Q3MBDtrOYUv9yVEQW0QZSgT0mvW87kcTLokZhTON95vYOFEWHTtb
         qmm83cDihyI4fzZNIQU70E8yxR4Uw5C3UYWJ9YzwdLzqv+jZ55s7yutnhLHVnuEhc2Sa
         Ze3drRzB8EUm7c3a1E7Tf5MdYSS2YPFL7BkzxjKvUU7KBKxsCh3jcoOlfFeYYfe7/Hj2
         KU8584TEd37FOyrg6buGp6P+5v4jc4F2d0SBGFDVwEs+YQv9yGMlaLlXxh9S7w1bTC9m
         29dgssM0oQPAXdNG8K7xAZUFX2iSs5gNaKHgqA/d/GaqDuSL6WSPA50Es7Tmk6MWMPwy
         zUig==
X-Forwarded-Encrypted: i=1; AJvYcCVTexHKQ7Y0lGn1CBX/XLc1/SBNpMAqJi18fDd5aFhLTWKqSF2jHm7aB+Q1r7m+AgUksYy+xIIiRJDGCR2287bS3+jQvbvgwW2CGqaKZ27/6w==
X-Gm-Message-State: AOJu0YwBsRZ7C7Dy14eSwvLL3tfMQPUIXHjJUBWiTMEID8DBRE0hmGfw
	mH34z4y+DMu8jO3CFYSSIYBFRA/gU7gD2QRUklD/7Ck6NmxaJY8vdPtyKrohy9XwQwiMVH+lnxb
	hDW79DQ==
X-Google-Smtp-Source: AGHT+IGHNCTMMoZ5DP43GHhye4Lbei8fvhDvO1XkkgyQZdI91QDtxOsBn7jlRRFTD7pRNrQgCFtK58ZQl5FD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:91b9:a9ed:5ab1:7e4c])
 (user=irogers job=sendgmr) by 2002:a05:6902:2302:b0:e05:ec8f:b497 with SMTP
 id 3f1490d57ef6-e0bcd24dafcmr2509276.4.1722481972662; Wed, 31 Jul 2024
 20:12:52 -0700 (PDT)
Date: Wed, 31 Jul 2024 20:12:49 -0700
Message-Id: <20240801031249.176913-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Subject: [PATCH v1] perf inject: Inject build ids for entire call chain
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
---
 tools/perf/builtin-inject.c | 31 +++++++++++++++++++++++++++++++
 tools/perf/util/callchain.c | 35 +++++++++++++++++++++++++++++++++++
 tools/perf/util/callchain.h |  6 ++++++
 3 files changed, 72 insertions(+)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 7b4a5d56d279..ea5f1d57e7e1 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -743,6 +743,29 @@ static int dso__inject_build_id(struct dso *dso, struct perf_tool *tool,
 	return 0;
 }
 
+struct mark_dso_hit_args {
+	struct perf_tool *tool;
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
 int perf_event__inject_buildid(struct perf_tool *tool, union perf_event *event,
 			       struct perf_sample *sample,
 			       struct evsel *evsel __maybe_unused,
@@ -750,6 +773,11 @@ int perf_event__inject_buildid(struct perf_tool *tool, union perf_event *event,
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
@@ -769,6 +797,9 @@ int perf_event__inject_buildid(struct perf_tool *tool, union perf_event *event,
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
2.46.0.rc2.264.g509ed76dc8-goog

