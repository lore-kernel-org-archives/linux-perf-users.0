Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6359417A585;
	Fri, 26 Jul 2024 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989725; cv=none; b=GgyGoYqegNx916gczFVkfhofVD1tCgCEZFSvUDpjI0u517A4JobDTa3rF625AFo+1oAlgXNWhVL/KP1MJ1Nq3Bu87rtmXtm4d4Ba+/dC6b3hzWIEtjjvXyVeoiiefsjDtlnQVH4TkwL/lo2leG8ylVfz7o59X0slIaUeR/uamJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989725; c=relaxed/simple;
	bh=V16kSHPoUbY1EjjYptU8X0Q5N5N92bR1n6mtRXw/9Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srlVpFso8TV/hTtb0zObemZ+SelOG4nePwPcuLG84zFuVgPqhkq6FQlplBlgr5v7h1cbfjt8YLUyMLtbfvn0yBuqs9ZlpjqUDwI/GY59RN/0pZDrwjj0OxiZkAMnvvBSTvqRLRzJL+KFDW3cltZPgrWrQTKffTZRnE+AWFFHV6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaNuEknm; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaNuEknm"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-703775e4d5dso455142a34.0;
        Fri, 26 Jul 2024 03:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721989722; x=1722594522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lk7eq/ExJtfJWXdlo7dQbuLEe/sXbvpJ766py9Gb44o=;
        b=TaNuEknmuAxWXi35VX3rp36Px8b6N43+/vSSK1YrwjFSfXYo8SrigluWVs13qnAo7e
         c+6JGcATppsXvCiy+33w5OJNmpupH1htJoa7Q+1OjRxLC+A5296FnNV0EOYaFpMp5j0U
         RM2ogxbWa84q0m0218hQq6VukaI35nCPYzwDTDlYLwJDnAHkAvaEZATnMjRWwICYiKvN
         9LvO8Fyn7o2X2KmVcJdGOJW1XWh2GZT6Pf37TxAvqzAKrD/7fYUJzdcu9oixarFN0d7e
         nDkFWv3RsHr8nR4AAdVzviwNV8esZcodtN2ailyWeSNqs/TRl4TeVXMm0Z/AqU1tRIKU
         3UDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721989722; x=1722594522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lk7eq/ExJtfJWXdlo7dQbuLEe/sXbvpJ766py9Gb44o=;
        b=ADonSoAkjV80hQ9Uvteh6uAcOrRsfRQpg70+CweinBxIW2kJaZyTqsDd/i81YwuwgH
         cHmUGeHD3hj8Q6uuC8xOm9RfkmRpCrTSG9+UY0by2uca5pt9NKnO1NXiKZgfjCoT0ldO
         fDjI2CAFRhsfti+jsnycIL7qIzTV1jlBq7oXXT61Yfrl8HNLKWsL31/zEQXfGx2Yf//W
         jmJAy5xKq8F6YOC1iwbSJpldffdoJspuF6TQkHp8N/fsUfBuES6KwkTScj0675POLsnJ
         NmtOLyKNawFApStrLVyjKAaPj8cn28pHVORIzcRGyZzLr7/Hj2zZxaHgA0A9oZ2uS2cw
         HQ7w==
X-Forwarded-Encrypted: i=1; AJvYcCXDBSY8Sl612GzyM7VXGCmYjqgu4FPuJjAxKw9DrEgREYRBQVcFZVcSV7XHMsRi0C0ETbV1V1VnK2C3zC1alABaz/ttIv9vTQll0xdkbhozCxrJANsA5b2u2pWS5ZvnTYYx5cH3mn0l2fIHtE659A==
X-Gm-Message-State: AOJu0YxfOnY1+qNMg9shl2XMrgRJ1AM8AhWTfNIXjNh3SaBQTEnwXl+f
	Ob/fDs7kBWN7xnR2sVbsxt0oAPKrkde2CKFs6aIOBfYO5qB0K9Mu
X-Google-Smtp-Source: AGHT+IGgnyl97oeF2mpwkdujl8dUOvXmpcrgGtiP6kM8W2xqMfDuy6/w2TqmrW2XUYO95oGWmpjfww==
X-Received: by 2002:a05:6830:6502:b0:704:47db:cd68 with SMTP id 46e09a7af769-7093210c4eamr5589125a34.4.1721989722230;
        Fri, 26 Jul 2024 03:28:42 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f816da89sm2179964a12.20.2024.07.26.03.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 03:28:41 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: namhyung@kernel.org
Cc: irogers@google.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] perf record off-cpu: processing of embedded sample
Date: Fri, 26 Jul 2024 18:28:24 +0800
Message-ID: <20240726102826.787004-4-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726102826.787004-1-howardchu95@gmail.com>
References: <20240726102826.787004-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the first evsel__parse_sample, we parse bpf output as raw samples.
After getting the raw_data, parse it the second time to get the embedded
samples.

Also, because we rely on evlist to dump direct off-cpu samples, if we
evsel__open() a bpf output event on a specific pid, it will fail. So pid = -1 for
every bpf output event.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Suggested-by: Ian Rogers <irogers@google.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 tools/perf/builtin-script.c |  2 +-
 tools/perf/util/evsel.c     | 16 ++++++++++++++--
 tools/perf/util/evsel.h     | 13 +++++++++++++
 tools/perf/util/session.c   | 23 ++++++++++++++++++++++-
 4 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c16224b1fef3..c142fb44817f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -653,7 +653,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
 
 		evlist__for_each_entry(session->evlist, evsel) {
 			not_pipe = true;
-			if (evsel__has_callchain(evsel)) {
+			if (evsel__has_callchain(evsel) || evsel__embed_has_callchain(evsel)) {
 				use_callchain = true;
 				break;
 			}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index bc603193c477..6c64ec475b80 100644
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
@@ -2282,6 +2284,10 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 			test_attr__ready();
 
+			/* BPF output event can only be system-wide, off-cpu filters tasks in BPF */
+			if (evsel__is_bpf_output(evsel))
+				pid = -1;
+
 			/* Debug message used by test scripts */
 			pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
 				pid, perf_cpu_map__cpu(cpus, idx).cpu, group_fd, evsel->open_flags);
@@ -2592,6 +2598,14 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	 */
 	union u64_swap u;
 
+	array = event->sample.array;
+
+	/* use raw_data passed in to read embedded data */
+	if (evsel__has_embed(evsel) && evsel__is_bpf_output(evsel) && data->raw_data) {
+		array = data->raw_data;
+		type = evsel->sample_type_embed;
+	}
+
 	memset(data, 0, sizeof(*data));
 	data->cpu = data->pid = data->tid = -1;
 	data->stream_id = data->id = data->time = -1ULL;
@@ -2607,8 +2621,6 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		return perf_evsel__parse_id_sample(evsel, event, data);
 	}
 
-	array = event->sample.array;
-
 	if (perf_event__check_size(event, evsel->sample_size))
 		return -EFAULT;
 
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
index 5596bed1b8c8..d87d85a3e21e 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1528,6 +1528,23 @@ static int evlist__deliver_sample(struct evlist *evlist, struct perf_tool *tool,
 	/* We know evsel != NULL. */
 	u64 sample_type = evsel->core.attr.sample_type;
 	u64 read_format = evsel->core.attr.read_format;
+	struct perf_sample sample_embed;
+
+	if (evsel__is_bpf_output(evsel) && evsel__has_embed(evsel) &&
+	    sample->raw_data && sample->raw_size - sizeof(__u32) > sizeof(struct perf_event_header)) {
+		int err;
+
+		sample_embed.raw_data = sample->raw_data;
+
+		err = evsel__parse_sample(evsel, event, &sample_embed);
+		if (err) {
+			pr_err("Can't parse BPF-embedded sample, err = %d\n", err);
+			return err;
+		}
+
+		sample_type = evsel->sample_type_embed;
+		sample = &sample_embed;
+	}
 
 	/* Standard sample delivery. */
 	if (!(sample_type & PERF_SAMPLE_READ))
@@ -1639,8 +1656,12 @@ static int perf_session__deliver_event(struct perf_session *session,
 				       const char *file_path)
 {
 	struct perf_sample sample;
-	int ret = evlist__parse_sample(session->evlist, event, &sample);
+	int ret;
+
+	/* set to NULL so we don't accidentally parse BPF-embedded sample */
+	sample.raw_data = NULL;
 
+	ret = evlist__parse_sample(session->evlist, event, &sample);
 	if (ret) {
 		pr_err("Can't parse sample, err = %d\n", ret);
 		return ret;
-- 
2.45.2

