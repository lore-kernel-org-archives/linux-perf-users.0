Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB76194AE6
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 20:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434226; cv=none; b=QYIK0szYs66607uJ14HazriNXsPegrkHQg/GSK0zPkWZyOy2w1FJO2WXwgfQDAh72Wl0sN8AY2sUkXdClyLEPc5c6evjZMrz6SlyTEpfH6cwwXhN46+NXjd/SXcqZyao4aLyenmWQYw/5Qd/wuilBH5umc2bWfKeLL7sseN0jsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434226; c=relaxed/simple;
	bh=jw50PdePtNwHlCvc+bRhx4v0PUa680BXOXn9x9VaU9I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=X2IvyqYf+zezY7ihn8fenhw5mIzIbqSPlJVd8Qfmf4JesZmVuG3NPTb7LqobEJ8ZdZ1dIaNK4rlDBqYSd2g4vj7Z8TjEzPcFsTlZzI7T+ajx0V7ld64J7G4FCsFYVOjURP9jJC25LRW8We1LfiU0SRxPRKqsxFs4wvmQvq2GpNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cPnruzxS; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cPnruzxS"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64399573fd3so120484257b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 13:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434224; x=1720039024; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vrdMNoiFFUZEExlDYLQu2XN7mf/7jGflPKRAGmMgvbw=;
        b=cPnruzxStiraOwR+I0e56thyrtHfcR8S1m0dHBnZLFSZEMN6g24AG6shWbakLR+fVI
         iMeHjvFLyVm5YqwizRuJMESw2E6jMWg/LEld0GPVWmeLsSBk8+oqr6UmZ3I5ZlEihczR
         lUXCT6neupykafM/cY9h87sAjG5KwfcizP3yfDszuFYhLrvBCCR8NKDJ17MBeytR3WmQ
         aYjTAVhysS6YbNG8O4YpfMhOzuC3ROlCsnRuYHToOT8MWAX2WwxJZ6byYxOxPHcIMS72
         MPVM+i5uqYr+7vgIZbTi/nHS6N5TURMz9VvRW/3GaeUPW08kOf8Hzexb7xQrrgOcnDrk
         Ezhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434224; x=1720039024;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrdMNoiFFUZEExlDYLQu2XN7mf/7jGflPKRAGmMgvbw=;
        b=OC/DThz4kex+ecbekXCzW1/FLC5RVQ0PQ0gzw5EkZOx8MI0UW+c2PXA8uHOpFEhv1Y
         or/zclRPcxn+euy4G19tHIF3dga8BLzpHjZUanSGdDIp1DL0GgofnVeuIcf3ksPQ/aC8
         pQt4swP6fIz7A+EcWAAeAYhn5EI6xdgkfk569P3moRox1+QC0YoYHrkLrBDPdjQSD/+N
         nIbxSaW1tcA8eCkPYXLmlXe+LOpnyW3k0u33FWOAvamZqrBIVF9uGptVdWeeUQig8/TT
         bKcSJ3OOjDsNcZ1hvXvG/819bXFbwX98NabNmXRpqt7gWTtrrv8Vw+aXIUjnu/RvZX9a
         aUyw==
X-Forwarded-Encrypted: i=1; AJvYcCVHCatvNu+EEbVikdUWcdFXqiNlHpIR+k46q7iXeYv1RSXyNSbdIArbQXCfkED9iClgfH23ERpeRePjC9Rp2bBLd3lWs8VGu7AUcblIS1I5Qg==
X-Gm-Message-State: AOJu0Yxfh5v1fp2l+CkygaQDVseLIz/h9o69+lQ6TQN+zYC5Xzh+NvZp
	iLB25B64P9ZfWikR5DdaI7ZEt32j3S0nVTH832BSrGOS4vWO2FWZr9MWCENRhgG9dbkYjA95M2e
	eOh3yJg==
X-Google-Smtp-Source: AGHT+IFJNfUbOLTOw4W+ifqZL1EPRWAknY5XU63OBzUVNvhQfs6vw/sK5MXeWYhyTs1Q3k7ti40koZYKHOMj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b13:b0:e03:31ec:8a1d with SMTP
 id 3f1490d57ef6-e0331ec8a7cmr236269276.3.1719434224345; Wed, 26 Jun 2024
 13:37:04 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:13 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 11/27] perf record: Use perf_tool__init
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 33 ++++++++++++++++++++-------------
 tools/perf/util/tool.c      | 10 +++++-----
 tools/perf/util/tool.h      |  6 ++++++
 3 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e8677f9e1ccb..4b9309b4c07e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -193,6 +193,15 @@ static const char *affinity_tags[PERF_AFFINITY_MAX] = {
 	"SYS", "NODE", "CPU"
 };
 
+static int build_id__process_mmap(const struct perf_tool *tool, union perf_event *event,
+				  struct perf_sample *sample, struct machine *machine);
+static int build_id__process_mmap2(const struct perf_tool *tool, union perf_event *event,
+				   struct perf_sample *sample, struct machine *machine);
+static int process_timestamp_boundary(const struct perf_tool *tool,
+				      union perf_event *event,
+				      struct perf_sample *sample,
+				      struct machine *machine);
+
 #ifndef HAVE_GETTID
 static inline pid_t gettid(void)
 {
@@ -1458,7 +1467,7 @@ static int process_buildids(struct record *rec)
 	 * first/last samples.
 	 */
 	if (rec->buildid_all && !rec->timestamp_boundary)
-		rec->tool.sample = NULL;
+		rec->tool.sample = process_event_sample_stub;
 
 	return perf_session__process_events(session);
 }
@@ -2386,6 +2395,16 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		signal(SIGUSR2, SIG_IGN);
 	}
 
+	perf_tool__init(tool, /*ordered_events=*/true);
+	tool->sample		= process_sample_event;
+	tool->fork		= perf_event__process_fork;
+	tool->exit		= perf_event__process_exit;
+	tool->comm		= perf_event__process_comm;
+	tool->namespaces	= perf_event__process_namespaces;
+	tool->mmap		= build_id__process_mmap;
+	tool->mmap2		= build_id__process_mmap2;
+	tool->itrace_start	= process_timestamp_boundary;
+	tool->aux		= process_timestamp_boundary;
 	session = perf_session__new(data, tool);
 	if (IS_ERR(session)) {
 		pr_err("Perf session creation failed.\n");
@@ -3326,18 +3345,6 @@ static struct record record = {
 		.ctl_fd_ack          = -1,
 		.synth               = PERF_SYNTH_ALL,
 	},
-	.tool = {
-		.sample		= process_sample_event,
-		.fork		= perf_event__process_fork,
-		.exit		= perf_event__process_exit,
-		.comm		= perf_event__process_comm,
-		.namespaces	= perf_event__process_namespaces,
-		.mmap		= build_id__process_mmap,
-		.mmap2		= build_id__process_mmap2,
-		.itrace_start	= process_timestamp_boundary,
-		.aux		= process_timestamp_boundary,
-		.ordered_events	= true,
-	},
 };
 
 const char record_callchain_help[] = CALLCHAIN_RECORD_HELP
diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index cbd9b888bd73..a4ca16e5eefe 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -99,11 +99,11 @@ static int process_event_synth_event_update_stub(const struct perf_tool *tool __
 	return 0;
 }
 
-static int process_event_sample_stub(const struct perf_tool *tool __maybe_unused,
-				     union perf_event *event __maybe_unused,
-				     struct perf_sample *sample __maybe_unused,
-				     struct evsel *evsel __maybe_unused,
-				     struct machine *machine __maybe_unused)
+int process_event_sample_stub(const struct perf_tool *tool __maybe_unused,
+			      union perf_event *event __maybe_unused,
+			      struct perf_sample *sample __maybe_unused,
+			      struct evsel *evsel __maybe_unused,
+			      struct machine *machine __maybe_unused)
 {
 	dump_printf(": unhandled!\n");
 	return 0;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 897c6c44b6b2..fb7e32d98dda 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -93,4 +93,10 @@ void perf_tool__fill_defaults(struct perf_tool *tool);
 
 bool perf_tool__compressed_is_stub(const struct perf_tool *tool);
 
+int process_event_sample_stub(const struct perf_tool *tool,
+			      union perf_event *event,
+			      struct perf_sample *sample,
+			      struct evsel *evsel,
+			      struct machine *machine);
+
 #endif /* __PERF_TOOL_H */
-- 
2.45.2.741.gdbec12cfda-goog

