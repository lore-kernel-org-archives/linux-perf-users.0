Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23EC1474B2
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Aug 2024 06:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723877129; cv=none; b=R08yeXXOfCldY6qW+CSmwFaa4ln6r5N8UYYmzC9dx7Mnd21QEWmqh6nyvpwrGiq8zJdbxV3prFD8Js4TLR0/hHyBCJtp99YnznI3+uUvg94ICZBlrwXiWzwfXeMSHqji/yutvk5z2DxXLrbRtAfHgvc0c2rmaAe3goP17WMo8sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723877129; c=relaxed/simple;
	bh=QpBMD0kpQEm4CD5YL7HRhIq6xDSHfb8hYh4/L55BjQc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=eCbdkDND/7RtMyJu211wxKxR8nAgCb/tMr6O0D3VehCccQEq3OZRqu9r/35LFgu1bZHhtYsn0V82vxgDoPB9ErY9WEbb2WhyXThdvnfazmpPrVHsBlaJJWwRdBQMyhx/9ut7M1mXr3jakPtykAbOU/pMUZxxKdGbGzaP0CSgLpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fi1vJOJd; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fi1vJOJd"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b3fec974e5so15609977b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 23:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723877127; x=1724481927; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXAXn6xK+PoC88ZvEgDZdmJIFm+dzHlxN2g70itgLKc=;
        b=Fi1vJOJdQyo9LwmqEgOhUeK8mHIm0f/ugIhWjlZBS61KhFf5e9+e95W1qH5ku0eLSR
         /xVIIeAIKjPb/wPfYfJB1b78n92ZhDGuKcfU2nf0mo7ztA0siEfJ7SM6T77nBk2iuJvg
         k8uyrwUH5Rsru7HPI5gzCT1AMkJBaDM7CPmY8RhN+SFcRctYS4pGMlIOcUrB+LAs6a/4
         S262DYnga7bNJ+f3vFEuv//kNGCcc0+iKySEVAbHRXsknNKpSmZJd48Ko8oVjr4Ei83F
         HgZ9aR1BS/3v9xV4WpJSF7zUOZqJ2wO6e2lu+UIJ0DPpd1JieLe9bZmQLSpQa2YattER
         M9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723877127; x=1724481927;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXAXn6xK+PoC88ZvEgDZdmJIFm+dzHlxN2g70itgLKc=;
        b=rZ8r+vVmDsVJeUktgIFZScaZ8ssb2wm9WYc2aqWR8xQh6rHZ0wU2NYKO1xTvWpfuft
         IwdW8r5eiETeI/cKCoQHQm0ADDdciFtvh9DNyxL4CBQXSiQbs37yFbw/e5sbr1fl2ZZs
         Td36bh1Z/8su0Ocfl7lMYYTeJjFoWqq0luBLq3DHeASz3QDLoHZRDtaPhNddBOryOr+X
         sKN8aSS5vZedEb7hpJLp9EZ9JTQCyVUCnxpICSjzk14yaPO77NHRUvs0+dTwfG1d23AU
         JEEMrjQ6+DaA6Pp6oaQZAFCoaayiXCtKThNbZPnQ62VSSwwvrCt44QO3aB8zdsh52lTH
         Ywyw==
X-Forwarded-Encrypted: i=1; AJvYcCXfA+nk+cXe6pMRWSqyONzdkbuw8H7UlHS5/mFM1cu71Qj/OD9rKfvDfidWp9ZG2P0Ojkqva/kJwV57LhqGK03CxbOIhkY4Lcn3YErYMkMmgQ==
X-Gm-Message-State: AOJu0Yw1Zkh7qQq5bvSm3s++OTxkz26NKyBWWz/+1ldHDFaP2HSY58ML
	24EE/8IwfkzzR49PNSG+SLJ6x58pdPLoxwlniS9kp1u+uDZqFBdGcw/zaJPUdd38IjSUO0axLLM
	PL3OtRQ==
X-Google-Smtp-Source: AGHT+IHFxN3N3woVEej46v2pH2bwTVupl8ivX7TTlOLLLegLEBpZrn01gXlXNRoWkgjVqXDLt123ujpFj/uJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:78c9:5e58:734f:c59f])
 (user=irogers job=sendgmr) by 2002:a05:690c:460b:b0:6b0:d571:3533 with SMTP
 id 00721157ae682-6b1bbb4af15mr1175187b3.7.1723877127009; Fri, 16 Aug 2024
 23:45:27 -0700 (PDT)
Date: Fri, 16 Aug 2024 23:44:40 -0700
In-Reply-To: <20240817064442.2152089-1-irogers@google.com>
Message-Id: <20240817064442.2152089-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240817064442.2152089-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Subject: [PATCH v1 11/13] perf inject: Add new mmap2-buildid-all option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Casey Chen <cachen@purestorage.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yunseong Kim <yskelg@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Anne Macedo <retpolanne@posteo.net>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add an option that allows all mmap or mmap2 events to be rewritten as
mmap2 events with build IDs. This is similar to the existing
-b/--build-ids and --buildid-all options except instead of adding a
build_id event an existing mmap/mmap2 event is used as a template and
a new mmap2 event synthesized from it. As mmap2 events are typical
this avoids the insertion of build_id events.

Add test coverage to the pipe test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c         | 88 ++++++++++++++++++++++++++++-
 tools/perf/tests/shell/pipe_test.sh |  1 +
 tools/perf/util/synthetic-events.c  | 57 +++++++++++++++++++
 tools/perf/util/synthetic-events.h  | 11 ++++
 4 files changed, 154 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 84a4bdb5cb0a..86425cade30e 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -107,6 +107,7 @@ enum build_id_rewrite_style {
 	BID_RWS__NONE = 0,
 	BID_RWS__INJECT_HEADER_LAZY,
 	BID_RWS__INJECT_HEADER_ALL,
+	BID_RWS__MMAP2_BUILDID_ALL,
 };
 
 struct perf_inject {
@@ -147,6 +148,16 @@ static int dso__inject_build_id(const struct perf_tool *tool,
 				__u16 misc,
 				const char *filename,
 				struct dso *dso, u32 flags);
+static int dso__inject_mmap2_build_id(const struct perf_tool *tool,
+				      struct perf_sample *sample,
+				      struct machine *machine,
+				      const struct evsel *evsel,
+				      __u16 misc,
+				      __u32 pid, __u32 tid,
+				      __u64 start, __u64 len, __u64 pgoff,
+				      struct dso *dso,
+				      __u32 prot, __u32 flags,
+				      const char *filename);
 
 static int output_bytes(struct perf_inject *inject, void *buf, size_t sz)
 {
@@ -162,6 +173,7 @@ static int output_bytes(struct perf_inject *inject, void *buf, size_t sz)
 
 static int perf_event__repipe_synth(const struct perf_tool *tool,
 				    union perf_event *event)
+
 {
 	struct perf_inject *inject = container_of(tool, struct perf_inject,
 						  tool);
@@ -454,7 +466,9 @@ static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
 					  union perf_event *event,
 					  struct perf_sample *sample,
 					  struct machine *machine,
-					  __u32 pid, __u32 tid, __u32 flags,
+					  __u32 pid, __u32 tid,
+					  __u64 start, __u64 len, __u64 pgoff,
+					  __u32 flags, __u32 prot,
 					  const char *filename,
 					  const struct dso_id *dso_id,
 					  int (*perf_event_process)(const struct perf_tool *tool,
@@ -525,6 +539,26 @@ static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
 			return err;
 		}
 	}
+	if ((inject->build_id_style == BID_RWS__MMAP2_BUILDID_ALL) &&
+	    !(event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)) {
+		struct evsel *evsel = evlist__event2evsel(inject->session->evlist, event);
+
+		if (evsel && !dso_sought) {
+			dso = findnew_dso(pid, tid, filename, dso_id, machine);
+			dso_sought = true;
+		}
+		if (evsel && dso &&
+		    !dso__inject_mmap2_build_id(tool, sample, machine, evsel,
+						sample->cpumode | PERF_RECORD_MISC_MMAP_BUILD_ID,
+						pid, tid, start, len, pgoff,
+						dso,
+						prot, flags,
+						filename)) {
+			/* Injected mmap2 so no need to repipe. */
+			dso__put(dso);
+			return 0;
+		}
+	}
 	dso__put(dso);
 	return perf_event__repipe(tool, event, sample, machine);
 }
@@ -536,7 +570,9 @@ static int perf_event__repipe_mmap(const struct perf_tool *tool,
 {
 	return perf_event__repipe_common_mmap(
 		tool, event, sample, machine,
-		event->mmap.pid, event->mmap.tid, /*flags=*/0,
+		event->mmap.pid, event->mmap.tid,
+		event->mmap.start, event->mmap.len, event->mmap.pgoff,
+		/*flags=*/0, PROT_EXEC,
 		event->mmap.filename, /*dso_id=*/NULL,
 		perf_event__process_mmap);
 }
@@ -559,7 +595,9 @@ static int perf_event__repipe_mmap2(const struct perf_tool *tool,
 
 	return perf_event__repipe_common_mmap(
 		tool, event, sample, machine,
-		event->mmap2.pid, event->mmap2.tid, event->mmap2.flags,
+		event->mmap2.pid, event->mmap2.tid,
+		event->mmap2.start, event->mmap2.len, event->mmap2.pgoff,
+		event->mmap2.flags, event->mmap2.prot,
 		event->mmap2.filename, dso_id,
 		perf_event__process_mmap2);
 }
@@ -748,6 +786,45 @@ static int dso__inject_build_id(const struct perf_tool *tool,
 	return 0;
 }
 
+static int dso__inject_mmap2_build_id(const struct perf_tool *tool,
+				      struct perf_sample *sample,
+				      struct machine *machine,
+				      const struct evsel *evsel,
+				      __u16 misc,
+				      __u32 pid, __u32 tid,
+				      __u64 start, __u64 len, __u64 pgoff,
+				      struct dso *dso,
+				      __u32 prot, __u32 flags,
+				      const char *filename)
+{
+	int err;
+
+	/* Return to repipe anonymous maps. */
+	if (is_anon_memory(filename) || flags & MAP_HUGETLB)
+		return 1;
+	if (is_no_dso_memory(filename))
+		return 1;
+
+	if (dso__read_build_id(dso)) {
+		pr_debug("no build_id found for %s\n", filename);
+		return -1;
+	}
+
+	err = perf_event__synthesize_mmap2_build_id(tool, sample, machine,
+						    perf_event__repipe,
+						    evsel,
+						    misc, pid, tid,
+						    start, len, pgoff,
+						    dso__bid(dso),
+						    prot, flags,
+						    filename);
+	if (err) {
+		pr_err("Can't synthesize build_id event for %s\n", filename);
+		return -1;
+	}
+	return 0;
+}
+
 static int mark_dso_hit(const struct perf_tool *tool,
 			struct perf_sample *sample,
 			struct machine *machine,
@@ -2257,12 +2334,15 @@ int cmd_inject(int argc, const char **argv)
 	const char *known_build_ids = NULL;
 	bool build_ids;
 	bool build_id_all;
+	bool mmap2_build_id_all;
 
 	struct option options[] = {
 		OPT_BOOLEAN('b', "build-ids", &build_ids,
 			    "Inject build-ids into the output stream"),
 		OPT_BOOLEAN(0, "buildid-all", &build_id_all,
 			    "Inject build-ids of all DSOs into the output stream"),
+		OPT_BOOLEAN(0, "mmap2-buildid-all", &mmap2_build_id_all,
+			    "Rewrite all mmap events as mmap2 events with build IDs"),
 		OPT_STRING(0, "known-build-ids", &known_build_ids,
 			   "buildid path [,buildid path...]",
 			   "build-ids to use for given paths"),
@@ -2359,6 +2439,8 @@ int cmd_inject(int argc, const char **argv)
 			return -1;
 		}
 	}
+	if (mmap2_build_id_all)
+		inject.build_id_style = BID_RWS__MMAP2_BUILDID_ALL;
 	if (build_ids)
 		inject.build_id_style = BID_RWS__INJECT_HEADER_LAZY;
 	if (build_id_all)
diff --git a/tools/perf/tests/shell/pipe_test.sh b/tools/perf/tests/shell/pipe_test.sh
index ad10012fdc29..1cacd6f15bcb 100755
--- a/tools/perf/tests/shell/pipe_test.sh
+++ b/tools/perf/tests/shell/pipe_test.sh
@@ -92,6 +92,7 @@ test_inject_bids() {
 test_record_report
 test_inject_bids -b
 test_inject_bids --buildid-all
+test_inject_bids --mmap2-buildid-all
 
 cleanup
 exit $err
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 6bb62e4e2d5d..a58444c4aed1 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2266,6 +2266,63 @@ int perf_event__synthesize_build_id(const struct perf_tool *tool,
 
 		ev.header.size += ret;
 	}
+
+	return process(tool, &ev, sample, machine);
+}
+
+int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
+					  struct perf_sample *sample,
+					  struct machine *machine,
+					  perf_event__handler_t process,
+					  const struct evsel *evsel,
+					  __u16 misc,
+					  __u32 pid, __u32 tid,
+					  __u64 start, __u64 len, __u64 pgoff,
+					  const struct build_id *bid,
+					  __u32 prot, __u32 flags,
+					  const char *filename)
+{
+	union perf_event ev;
+	size_t ev_len;
+	void *array;
+	int ret;
+
+	ev_len = sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + strlen(filename) + 1;
+	ev_len = PERF_ALIGN(ev_len, sizeof(u64));
+
+	memset(&ev, 0, ev_len);
+
+	ev.mmap2.header.type = PERF_RECORD_MMAP2;
+	ev.mmap2.header.misc = misc | PERF_RECORD_MISC_MMAP_BUILD_ID;
+	ev.mmap2.header.size = ev_len;
+
+	ev.mmap2.pid = pid;
+	ev.mmap2.tid = tid;
+	ev.mmap2.start = start;
+	ev.mmap2.len = len;
+	ev.mmap2.pgoff = pgoff;
+
+	ev.mmap2.build_id_size = min(bid->size, sizeof(ev.mmap2.build_id));
+	memcpy(ev.mmap2.build_id, bid->data, ev.mmap2.build_id_size);
+
+	ev.mmap2.prot = prot;
+	ev.mmap2.flags = flags;
+
+	memcpy(ev.mmap2.filename, filename, min(strlen(filename), sizeof(ev.mmap.filename)));
+
+	array = &ev;
+	array += ev.header.size;
+	ret = perf_event__synthesize_id_sample(array, evsel->core.attr.sample_type, sample);
+	if (ret < 0)
+		return ret;
+
+	if (ret & 7) {
+		pr_err("Bad id sample size %d\n", ret);
+		return -EINVAL;
+	}
+
+	ev.header.size += ret;
+
 	return process(tool, &ev, sample, machine);
 }
 
diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
index 795bf3e18396..b9c936b5cfeb 100644
--- a/tools/perf/util/synthetic-events.h
+++ b/tools/perf/util/synthetic-events.h
@@ -54,6 +54,17 @@ int perf_event__synthesize_build_id(const struct perf_tool *tool,
 				    __u16 misc,
 				    const struct build_id *bid,
 				    const char *filename);
+int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
+					  struct perf_sample *sample,
+					  struct machine *machine,
+					  perf_event__handler_t process,
+					  const struct evsel *evsel,
+					  __u16 misc,
+					  __u32 pid, __u32 tid,
+					  __u64 start, __u64 len, __u64 pgoff,
+					  const struct build_id *bid,
+					  __u32 prot, __u32 flags,
+					  const char *filename);
 int perf_event__synthesize_cpu_map(const struct perf_tool *tool, const struct perf_cpu_map *cpus, perf_event__handler_t process, struct machine *machine);
 int perf_event__synthesize_event_update_cpus(const struct perf_tool *tool, struct evsel *evsel, perf_event__handler_t process);
 int perf_event__synthesize_event_update_name(const struct perf_tool *tool, struct evsel *evsel, perf_event__handler_t process);
-- 
2.46.0.184.g6999bdac58-goog

