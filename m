Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCAC13D265;
	Wed,  7 Aug 2024 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045169; cv=none; b=imkcNrOcQ5x6UabPqh/CRMEOtEYjxgcLj2eMxbA6P4Br2GeVH0odz0jXhbd7d262Z4OD3vtE778Of8oaFyYjXVSuqQd06R+BNVS5LpeBznNg5tTs20bJTaasxTKZue8h5Mgv7/puvgUJaeO/gz62cRi2N+veilj3XJmF8LL/FLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045169; c=relaxed/simple;
	bh=uTLMPRQ7PpsmiGeFp0oCgRjEPLGy5/MRVfn8ELiaifw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpFqDFXOIKejRnIwelaFTOzpiIIO8+ZZu/UMEisFGI9jWswxTLgA5QMBkiEn+9XSs8mAQ/thMGGIa6yPKeeDdcIsEyHLiPkU4/DwbSkwLqcQ/D0Ja3lWLFQLVgdpYMeVR0/mFUe+XRAZZc78YLs4yiJJJhoi5NiBiv9+wlK6+I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZOB1acD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZOB1acD"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc49c0aaffso363125ad.3;
        Wed, 07 Aug 2024 08:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723045167; x=1723649967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfYYj96hxoVP6jblDfVz2LtzuPs3R2O748Dxdho8r5M=;
        b=VZOB1acD61IkDgvN/kgzwTI5lzhqeySF/yRf5RTA+gtcAZalCE69LnWv8t0DWD6XdM
         UbJSl4e9/slC+6zMylh0K6BiBy2u1g89CYUVsuw4i7eWEwhrZW3TwKk8Op7D38mYaPy2
         FY+YpG6gWGh21qGZACEBpkXm9qyAYbc239VbzGiQ+AiGiSDyzkYFo1Ad093njXtJY52f
         atTcKLBMuYBuBoPK0utY2fwl0fq63GbGUr1/jlramGD2OunGukKs/t62iwWf1o50LXZO
         GqOr+dVydscTQ7W6eGze+Q5iZOkzmVTvfubjKJ5EsFx/66batts33E+w9GFfIwmqzQtq
         AeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723045167; x=1723649967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfYYj96hxoVP6jblDfVz2LtzuPs3R2O748Dxdho8r5M=;
        b=tV9bK8ryVfNfxZDclsWPBlbHL/Qn6e8pZR/DFj/ySxR0lBN+QKPyO41H6HqPpd79Fu
         Cz39lApcsTXA+0hq+q120dSxz9jTGaEazUYwahhkRht/UsS1YUfjjJVnQbsiLrEBmUBk
         xq3AMZ3vG38KjDnTkei6GTTZB5PgBssmCE4QofsX8ePhysXxwXP8ClbnSYBP0FGbrAmJ
         L3riyykn+eTNbcWRVOCsbeNoBizxANrtrbqz5Zm3ofRUut8lJI8EGUZzIv06A/0SKC6e
         oup1ZNobMKzlejSVrbjcE9CFT/DN61GnI4eVnsFX8maJZsViXa2KTbV6WFMMORfkEss4
         5+RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQNsrOpFQtdbnbVhYvX9nZR6r9M56cVj0Ok23bcfK/5VmHePI/sksPSx+7pief+6pAE126ScwtzZs3Jfugw66FZCMxz/W9+KOByTU6qeOrtgTjGJUFcLaxpRu9+ZTrPw7cnQC+fsJvTScQOocCfA==
X-Gm-Message-State: AOJu0Yz0BMawUwKSYm0iGORv1f8dsR/MbM4VSjqxKB7OOvPUbMHw0HBc
	HxD2TVugylFBkrw75CWTl0B3PpDJ+Qb+/h4upIXKxqKsw+Gj8XSn
X-Google-Smtp-Source: AGHT+IHVjR96skc6WXo7h94wO9ITTMfQB+lyCbjRrmP+1sXu8qsrVi4PxYaBQXOiVJmcs88YwPrXTQ==
X-Received: by 2002:a17:902:d2d2:b0:1fd:9d0c:998c with SMTP id d9443c01a7336-1ff574e2f50mr199507045ad.56.1723045166791;
        Wed, 07 Aug 2024 08:39:26 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59297329sm108097375ad.247.2024.08.07.08.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 08:39:26 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: namhyung@kernel.org
Cc: irogers@google.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/9] perf record --off-cpu: Parse BPF output embedded data
Date: Wed,  7 Aug 2024 23:38:41 +0800
Message-ID: <20240807153843.3231451-8-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807153843.3231451-1-howardchu95@gmail.com>
References: <20240807153843.3231451-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 tools/perf/builtin-script.c |  5 +++--
 tools/perf/util/evsel.c     | 36 ++++++++++++++++++++++++++++--------
 tools/perf/util/evsel.h     | 13 +++++++++++++
 tools/perf/util/session.c   | 16 +++++++++++++++-
 4 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c16224b1fef3..4145e61b8d38 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -653,7 +653,8 @@ static int perf_session__check_output_opt(struct perf_session *session)
 
 		evlist__for_each_entry(session->evlist, evsel) {
 			not_pipe = true;
-			if (evsel__has_callchain(evsel)) {
+			if (evsel__has_callchain(evsel) ||
+			    evsel__embed_has_callchain(evsel)) {
 				use_callchain = true;
 				break;
 			}
@@ -2295,7 +2296,7 @@ static void process_event(struct perf_script *script,
 	else if (PRINT_FIELD(BRSTACKOFF))
 		perf_sample__fprintf_brstackoff(sample, thread, attr, fp);
 
-	if (evsel__is_bpf_output(evsel) && PRINT_FIELD(BPF_OUTPUT))
+	if (evsel__is_bpf_output(evsel) && !evsel__has_embed(evsel) && PRINT_FIELD(BPF_OUTPUT))
 		perf_sample__fprintf_bpf_output(sample, fp);
 	perf_sample__fprintf_insn(sample, attr, thread, machine, fp, al);
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c1aac09ad0a5..a5a5b3ff16e1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -298,6 +298,7 @@ void evsel__init(struct evsel *evsel,
 	evsel->pmu_name      = NULL;
 	evsel->group_pmu_name = NULL;
 	evsel->skippable     = false;
+	evsel->sample_type_embed = 0;
 }
 
 struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
@@ -440,6 +441,7 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->weak_group = orig->weak_group;
 	evsel->use_config_name = orig->use_config_name;
 	evsel->pmu = orig->pmu;
+	evsel->sample_type_embed = orig->sample_type_embed;
 
 	if (evsel__copy_config_terms(evsel, orig) < 0)
 		goto out_err;
@@ -2589,6 +2591,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	u16 max_size = event->header.size;
 	const void *endp = (void *)event + max_size;
 	u64 sz;
+	bool ip_in_callchain = false;
 
 	/*
 	 * used for cross-endian analysis. See git commit 65014ab3
@@ -2596,14 +2599,27 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
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
+	if (evsel__has_embed(evsel) && evsel__is_bpf_output(evsel) && data->raw_data) {
+		type = evsel->sample_type_embed;
+		array = data->raw_data;
+		/* if callchain is embedded in BPF output, so is ip */
+		if (type & PERF_SAMPLE_CALLCHAIN)
+			ip_in_callchain = true;
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
@@ -2732,6 +2748,10 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
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
index 80b5f6dd868e..0d25e82c6154 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -184,6 +184,9 @@ struct evsel {
 	};
 	/* Is the tool's fd for /proc/pid/stat or /proc/stat. */
 	bool pid_stat;
+
+	/* for samples embedded in BPF output */
+	__u64 sample_type_embed;
 };
 
 struct perf_missing_features {
@@ -469,6 +472,11 @@ static inline bool evsel__is_bpf_output(struct evsel *evsel)
 	return evsel__match(evsel, SOFTWARE, SW_BPF_OUTPUT);
 }
 
+static inline bool evsel__has_embed(struct evsel *evsel)
+{
+	return evsel->sample_type_embed != 0;
+}
+
 static inline bool evsel__is_clock(const struct evsel *evsel)
 {
 	return evsel__match(evsel, SOFTWARE, SW_CPU_CLOCK) ||
@@ -525,6 +533,11 @@ static inline bool evsel__has_callchain(const struct evsel *evsel)
 	       evsel->synth_sample_type & PERF_SAMPLE_CALLCHAIN;
 }
 
+static inline bool evsel__embed_has_callchain(const struct evsel *evsel)
+{
+	return evsel->sample_type_embed & PERF_SAMPLE_CALLCHAIN;
+}
+
 static inline bool evsel__has_br_stack(const struct evsel *evsel)
 {
 	/*
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 5596bed1b8c8..18aa5e0263b7 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1529,6 +1529,16 @@ static int evlist__deliver_sample(struct evlist *evlist, struct perf_tool *tool,
 	u64 sample_type = evsel->core.attr.sample_type;
 	u64 read_format = evsel->core.attr.read_format;
 
+	/* parse sample the second time to get embedded data from raw_data */
+	if (evsel__is_bpf_output(evsel) && evsel__has_embed(evsel) && sample->raw_data) {
+		int err = evsel__parse_sample(evsel, event, sample);
+
+		if (err) {
+			pr_err("failed to parse BPF ouput embedded data, err = %d\n", err);
+			return err;
+		}
+	}
+
 	/* Standard sample delivery. */
 	if (!(sample_type & PERF_SAMPLE_READ))
 		return tool->sample(tool, event, sample, evsel, machine);
@@ -1639,8 +1649,12 @@ static int perf_session__deliver_event(struct perf_session *session,
 				       const char *file_path)
 {
 	struct perf_sample sample;
-	int ret = evlist__parse_sample(session->evlist, event, &sample);
+	int ret;
+
+	/* avoid reading embedded data from raw_data */
+	sample.raw_data = NULL;
 
+	ret = evlist__parse_sample(session->evlist, event, &sample);
 	if (ret) {
 		pr_err("Can't parse sample, err = %d\n", ret);
 		return ret;
-- 
2.45.2

