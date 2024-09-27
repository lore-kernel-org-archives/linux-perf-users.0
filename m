Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C4C1C3F35;
	Fri, 27 Sep 2024 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463252; cv=none; b=DBMIdeIeTFOzSLu3jHIc9tNcI9BZdGAYCRoU4iAcqa/V3b75uFAv2VZnIDPBEHdBqS+vuA8Q+nzOoQDgXNYYsvuWLuk5mOD2sWEBDz1JHJJ30rLdDsvKagkbsxTdGCt3xXOD82a8PWgar9ga05jJVq5UIoJ/xMAMIqdNaeFaWVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463252; c=relaxed/simple;
	bh=adiSf7+Y53/FM4VGaERVGEcSkoSzxS48tNZljvrnWsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1aejU0goG2mJz1qusdId9z4jicXqpPh24pqPLVDcRMPTEFrqTtsyDfgLI6ZR3DFvPfQi9kt/7NBcSQVAJnwJJLUc2Rp0DZ6jrG4gQ2AoA528WamgOb1hJhZOEMK08+G96VEzqDJBbWLek4SHqag6g1pNVUNmhBGpc3NJJvcVvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PF+OITGf; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PF+OITGf"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71970655611so2241041b3a.0;
        Fri, 27 Sep 2024 11:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727463249; x=1728068049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAwY2+33GW304kJV0kB3faCFhgqS9trOgDYnXV+VZt0=;
        b=PF+OITGfE56IqRIzjS5Yjt+cewob77sIo3vJEzUSqaeUsxjs6dLFgpQxT03SFU43sB
         TH7uokbPgw4hxXj0MJg0mOGERQQ3jJ5xlLvHMzeADDrFV74iQQzX/jodUKq46tqydqqO
         DXmBm2ykCD0lEryeqK8Ixxt0ZAAcRixwL6pgIS083ll9W+TZEYQeVIW3nAmbXG+fw/mQ
         BWQdEpgJlSGCvri1nR+ZFyQPYqBzJJEgh+bL81XibC97Zjlvbh9Ya4Sp/K8gGLvLjUnP
         WH1ms6eNPWfQH4JDi3qkanlO7p7DGXWNRcGPVWr//gjOlPo2VYoBONgb+5Brpf7vNpoi
         kWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727463249; x=1728068049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAwY2+33GW304kJV0kB3faCFhgqS9trOgDYnXV+VZt0=;
        b=jd9hdX7xfc87Ixytrjeh8Et9nc2/0APN3o5sfU8lwUz1k24xKfwLIOOVk7Jr1w7h83
         i5Comk91CrW9LhYILzc96YR5ZbhQLDZdIc24ZcqC/H0sjJL3LNnlBdskTx4w0CYSWFS7
         6qleQ75vU4kmFLNFN2uHzh+aip+lXlYdkzPuLkyt+a+3l4i54ETMONpri6k3HqSq8gq1
         3r5jGmk8bGIhO+z8j6CAtiESB0HOOw5Ba6IyAyOjIDiZPg0sMiPUJeIxmxFywVSixGEP
         +Tls+HpSL8JA0WVe/6qFVKURSNeWnKaMEcAQWYjwS4VG1VMJJ5p1wKlL0Xn3EKSH1wOI
         6xzA==
X-Forwarded-Encrypted: i=1; AJvYcCWSuDyy51D4eu+pXgCr5mBsMX9QwdzME3koMAZajzl+1BHxt4SuNim4l4FdcGJDprFQ4LfyGc8kNlFiwAw=@vger.kernel.org, AJvYcCX5P0GGHDiuyY3yrZGFZQNOYVE+TlhKoAOmE81Sgbm5a9MxIZicjLpXMXgPDVTXy3Z3I5CkG2kw611fUCEqJ4S7bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwE3f8kXCASeoHfbcAHMiLqcUe4fFZwdZu1EZbsGzwWPqSc8Ug8
	G2ZBQUpPuH5hf6YhZIDWTZg2dqtKvSymjibITrAkqQn7LTDr/Kni
X-Google-Smtp-Source: AGHT+IFJH1vmFyC+n59Iz0RHu3CWG+QVgdx9LQyeuNYMI2SUrPSq5iNPtBrb/ra4qkTHcQhbXqI6hg==
X-Received: by 2002:a05:6a00:1304:b0:70d:2e24:af75 with SMTP id d2e1a72fcca58-71b26072fc3mr7231715b3a.24.1727463248861;
        Fri, 27 Sep 2024 11:54:08 -0700 (PDT)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264c23b6sm1930244b3a.88.2024.09.27.11.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 11:54:08 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v5 7/8] perf record --off-cpu: Parse BPF output embedded data
Date: Fri, 27 Sep 2024 11:53:39 -0700
Message-ID: <20240927185340.658143-8-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240927185340.658143-1-howardchu95@gmail.com>
References: <20240927185340.658143-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move evsel__is_offcpu_event() to evsel.h

Add a sample_type_embed member to the struct evsel, along with a couple
of helper functions.

In session.c, we parse BPF output embedded samples in a two-step
process.

Initial Parsing: Treat the sample as a regular BPF-output event.

Secondary Parsing: Extract data from raw_data and parse it according to
the sample_type_embed specification. Since the second step relies on the
raw_data obtained in the first step, we must avoid zero-initializing the
sample data after the first step.

Suggested-by: Ian Rogers <irogers@google.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-script.c |  4 ++--
 tools/perf/util/evsel.c     | 39 +++++++++++++++++++++++--------------
 tools/perf/util/evsel.h     |  6 ++++++
 tools/perf/util/session.c   | 12 +++++++++++-
 4 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index a644787fa9e1..9719ffae45d5 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -662,7 +662,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
 
 		evlist__for_each_entry(session->evlist, evsel) {
 			not_pipe = true;
-			if (evsel__has_callchain(evsel)) {
+			if (evsel__has_callchain(evsel) || evsel__is_offcpu_event(evsel)) {
 				use_callchain = true;
 				break;
 			}
@@ -2352,7 +2352,7 @@ static void process_event(struct perf_script *script,
 	else if (PRINT_FIELD(BRSTACKOFF))
 		perf_sample__fprintf_brstackoff(sample, thread, attr, fp);
 
-	if (evsel__is_bpf_output(evsel) && PRINT_FIELD(BPF_OUTPUT))
+	if (evsel__is_bpf_output(evsel) && !evsel__is_offcpu_event(evsel) && PRINT_FIELD(BPF_OUTPUT))
 		perf_sample__fprintf_bpf_output(sample, fp);
 	perf_sample__fprintf_insn(sample, evsel, attr, thread, machine, fp, al);
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 32196e4f0637..4199a1e409f7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1105,11 +1105,6 @@ static void evsel__set_default_freq_period(struct record_opts *opts,
 	}
 }
 
-static bool evsel__is_offcpu_event(struct evsel *evsel)
-{
-	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT);
-}
-
 /*
  * The enable_on_exec/disabled value strategy:
  *
@@ -2677,6 +2672,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	u16 max_size = event->header.size;
 	const void *endp = (void *)event + max_size;
 	u64 sz;
+	bool ip_in_callchain = false;
 
 	/*
 	 * used for cross-endian analysis. See git commit 65014ab3
@@ -2684,14 +2680,25 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	 */
 	union u64_swap u;
 
-	memset(data, 0, sizeof(*data));
-	data->cpu = data->pid = data->tid = -1;
-	data->stream_id = data->id = data->time = -1ULL;
-	data->period = evsel->core.attr.sample_period;
-	data->cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
-	data->misc    = event->header.misc;
-	data->data_src = PERF_MEM_DATA_SRC_NONE;
-	data->vcpu = -1;
+	/*
+	 * For sample data embedded in BPF output, don't clear the sample we read in the first pass,
+	 * and read the embedded data from raw_data in the second pass.
+	 */
+	if (evsel__is_offcpu_event(evsel) && data->raw_data) {
+		type = OFFCPU_EMBEDDED_SAMPLE_TYPES;
+		array = data->raw_data;
+		ip_in_callchain = true;
+	} else { /* for normal samples, clear to zero before reading */
+		array = event->sample.array;
+		memset(data, 0, sizeof(*data));
+		data->cpu = data->pid = data->tid = -1;
+		data->stream_id = data->id = data->time = -1ULL;
+		data->period = evsel->core.attr.sample_period;
+		data->cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
+		data->misc    = event->header.misc;
+		data->data_src = PERF_MEM_DATA_SRC_NONE;
+		data->vcpu = -1;
+	}
 
 	if (event->header.type != PERF_RECORD_SAMPLE) {
 		if (!evsel->core.attr.sample_id_all)
@@ -2699,8 +2706,6 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		return perf_evsel__parse_id_sample(evsel, event, data);
 	}
 
-	array = event->sample.array;
-
 	if (perf_event__check_size(event, evsel->sample_size))
 		return -EFAULT;
 
@@ -2822,6 +2827,10 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		data->callchain = (struct ip_callchain *)array++;
 		if (data->callchain->nr > max_callchain_nr)
 			return -EFAULT;
+
+		if (ip_in_callchain && data->callchain->nr > 1)
+			data->ip = data->callchain->ips[1];
+
 		sz = data->callchain->nr * sizeof(u64);
 		OVERFLOW_CHECK(array, sz, max_size);
 		array = (void *)array + sz;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 3e751ea769ac..6fbf5d4219d1 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -11,6 +11,7 @@
 #include <perf/evsel.h>
 #include "symbol_conf.h"
 #include "pmus.h"
+#include "off_cpu.h"
 
 struct bpf_object;
 struct cgroup;
@@ -580,4 +581,9 @@ u64 evsel__bitfield_swap_branch_flags(u64 value);
 void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 				const char *config_name, u64 val);
 
+static inline bool evsel__is_offcpu_event(struct evsel *evsel)
+{
+	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT);
+}
+
 #endif /* __PERF_EVSEL_H */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index dbaf07bf6c5f..d481bc466131 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1229,6 +1229,16 @@ static int evlist__deliver_sample(struct evlist *evlist, const struct perf_tool
 	u64 sample_type = evsel->core.attr.sample_type;
 	u64 read_format = evsel->core.attr.read_format;
 
+	/* parse sample the second time to get embedded data from raw_data */
+	if (evsel__is_offcpu_event(evsel) && sample->raw_data) {
+		int err = evsel__parse_sample(evsel, event, sample);
+
+		if (err) {
+			pr_err("Failed to parse BPF ouput embedded data, err = %d\n", err);
+			return err;
+		}
+	}
+
 	/* Standard sample delivery. */
 	if (!(sample_type & PERF_SAMPLE_READ))
 		return tool->sample(tool, event, sample, evsel, machine);
@@ -1339,7 +1349,7 @@ static int perf_session__deliver_event(struct perf_session *session,
 				       u64 file_offset,
 				       const char *file_path)
 {
-	struct perf_sample sample;
+	struct perf_sample sample = { .raw_data = NULL }; /* avoid accidental read of embedded data */
 	int ret = evlist__parse_sample(session->evlist, event, &sample);
 
 	if (ret) {
-- 
2.43.0

