Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAD348551E
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939743; cv=none; b=t+uqw/QYfH2eL33g6xoPP9xpz9L4K76EXwPoN9LXOTz71HFkdhsLcOsatjkuZvMnq73tZEju6CjaLIeh1Kpf9tTiJX+DXQ/8DOGS77qK82350H/DCKP6CuokbnBKSh4yUtXvlMrqSZOGibcwswM/5sU4NLHh+PutZ+QbiWwNNMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939743; c=relaxed/simple;
	bh=M3rPYMcpTIRHBZ3NVVSsH8snhyXO8wiBrkIMArVMaI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CK6gIbo/wAZm7JEiTqHxLXUB3/lFXGGNI47QsYsQ23lebpTi4foXbMXdsbofo2zek30J3pPAgUFAIFbAX1eAzX3Zsacvz+9QCLua7iaDEqM/KlgubqSPiOo6Py2SlVDbmq4pne7jkof7nQWXVfe8NcNWvx5cUtE0PMj6bWRusz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gEe+QpTm; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gEe+QpTm"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so41972945e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 04:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790939732; x=1791544532; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OUfzXk7gzJEOddY/hfe9OLAQHpkFenB0R/fhaQZ1l64=;
        b=gEe+QpTmNePj+81ejwBEnb6ufcwPNt/OXBvu31fxtSL+GMxUdcOrKW3TZ5PwXGPTD7
         5tGbL8/oU/HtEO5aLvCxqEvAR8lYzyMXAgR7e0H0zu46Svfcw3tHuUKsy/sdNSfmWu6d
         DrNV8I4jcIxnnU+zRbdd7ii+snFEuVtn9R/5grbP3KVVWDucHr9oy7TleI8k04Q2fLAt
         VHYTmITWbwQOTgCX5ERgIHAtBive+PsWtwFejZSP99HEoMKUesjBR2M/eFYDs1aVMf1/
         3lNe5e2ZyRluOIYkrmDAAFuvegOpwVzo7nowAcTIfT9tn3sYeeztRFFOqhdhLKRg91mx
         GprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790939732; x=1791544532;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OUfzXk7gzJEOddY/hfe9OLAQHpkFenB0R/fhaQZ1l64=;
        b=MYXds9jV2KkJ1f8N7efOY1lJ/GpHL8XnhzkHfhjmhx1yvDaYqSkrrWl3aHcpsYikmG
         i0Th6QDIxs/PXV/auG28B6MWrl4jPfex99xbYfF7VLR5DCgiXA4bGha+zqQIsV1aB1Ak
         wfgFOMidEBNi7GqEgi6FI6KwGN40qgKTGo54CsOzuiEpBJwCGQ0aMvFKGfYFP1/6qbGb
         14MLDD+MloqqLXbVjdbwLQcd5bhXiUlHure7wQHi9dnGBsClYzW2voi+khUNE/DdO0qf
         JlLiTJzuAB4Fj8KWi+5MhNXywqFcBM4lruoBgvlSzP7pvMlRXEVNPndF7jkY8mlZzRgx
         Vvxw==
X-Forwarded-Encrypted: i=1; AKwUvBxg0kD4mKi7RuI4TdfaXMFqn5K1ybr2wyBua00lSbFV/Bx4Xn+oUKnZ8PAEqXLrjjijVVW2Pqa8q0XT1oT3ee6T@vger.kernel.org
X-Gm-Message-State: AFuF++n61Z8jxuo1LcbC6mvUf+cYLSLy8IWJWLT0c8yNGpVJBbjPVDJt
	VTZJx1c2HLlOhOuBlD7HJxgilUs4ZMpHbm04Dk6mdZpWlYEr9J+WU9lflaEbYOD5vEg=
X-Gm-Gg: AYBFou08osk+lFjOys1OUr0wa1PwPGoIOJA6R1os4jDZ7M1UnX2jT/0xpnNahLDhv93
	A4NTHqGPvyWcT5Hcm/N+hliT9LktaDHAPpoFqeEmPuvfsz4PSIrD0FBKGwUmLaHCHCgifthrsT+
	lyQfKyLUuv8Q2JegxmxsIBmQBSzkol+O/+zogsmltAljU8qUse/In4t+oxCi51PG9d4I5dK1KpG
	qbPeTT6VCuBNQ0UVH0IZyUxUKZIwocncrZJVM0gDB1mao9VejNA03tFUIsTxV+QMpYaK/ohjm8G
	Go5f1UiMnb4f0xV11mcueqtN5Z36ZEQxkAFIdjbj6P7HG1l9XljB7WBf+GFSGWcHEcCJ4pHzWtH
	cSc/WxS/J+58QxM0pyVGU3S3Hqtla+9o4AUEgD5aui585L53KDVYlMetCmyVlAfOUE3D6jmvHFa
	Q3WRM1suFRXsF3F4ZEoDcVwkfqoTv17JFmY9LIjzb3TAA6TGcBRAzdNBA+Ib+YKkm4OxhIU8uvw
	g==
X-Received: by 2002:a05:600c:4e8e:b0:49f:ce78:3561 with SMTP id 5b1f17b1804b1-4a02759b360mr45109215e9.18.1790939731921;
        Fri, 02 Oct 2026 04:15:31 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38306dd4sm4752986f8f.43.2026.10.02.04.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 04:15:31 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 02 Oct 2026 12:15:14 +0100
Subject: [PATCH v3 4/4] perf: cs-etm: Respect --no-itrace option
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-james-cs-hw_id-output-failure-v3-4-1d8b6ef339c8@linaro.org>
References: <20261002-james-cs-hw_id-output-failure-v3-0-1d8b6ef339c8@linaro.org>
In-Reply-To: <20261002-james-cs-hw_id-output-failure-v3-0-1d8b6ef339c8@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

If there is a bug in decoding then Perf will exit early and you can't
investigate by using the raw dump mode. Make the --no-itrace option stop
Coresight decoding after printing the aux header so decode errors don't
stop the rest of the samples being printed.

pmu_type and evsel_is_auxtrace need to be set so that the
unleader_auxtrace() behavior is the same as without --no-itrace.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/auxtrace.c |  2 +-
 tools/perf/util/auxtrace.h |  1 +
 tools/perf/util/cs-etm.c   | 66 +++++++++++++++++++++++++---------------------
 3 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index ed2113190785..2557cbec37b3 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -123,7 +123,7 @@ static int evlist__regroup(struct evlist *evlist, struct evsel *leader, struct e
 	return 0;
 }
 
-static bool auxtrace__dont_decode(struct perf_session *session)
+bool auxtrace__dont_decode(struct perf_session *session)
 {
 	return !session->itrace_synth_opts ||
 	       session->itrace_synth_opts->dont_decode;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 5012bead1b92..c29a8444f08e 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -650,6 +650,7 @@ void auxtrace__free(struct perf_session *session);
 bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
 				 struct evsel *evsel);
 u64 auxtrace_synth_id_range_start(struct evsel *evsel);
+bool auxtrace__dont_decode(struct perf_session *session);
 
 #define ITRACE_HELP \
 "				i[period]:    		synthesize instructions events\n" \
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index c0152549e3e2..bdcf94813129 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -965,7 +965,7 @@ static int cs_etm__flush_events(struct perf_session *session,
 	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
 						   struct cs_etm_auxtrace,
 						   auxtrace);
-	if (dump_trace)
+	if (dump_trace || auxtrace__dont_decode(session))
 		return 0;
 
 	if (!tool->ordered_events)
@@ -3002,7 +3002,7 @@ static int cs_etm__process_event(struct perf_session *session,
 						   struct cs_etm_auxtrace,
 						   auxtrace);
 
-	if (dump_trace)
+	if (dump_trace || auxtrace__dont_decode(session))
 		return 0;
 
 	if (!tool->ordered_events) {
@@ -3552,27 +3552,49 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	int err = 0;
 	int aux_hw_id_found;
 	int i;
-	u64 *ptr = NULL;
+	u64 *ptr = (u64 *) auxtrace_info->priv;
 	u64 **metadata = NULL;
 
-	/* First the global part */
-	ptr = (u64 *) auxtrace_info->priv;
-	num_cpu = ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
+	etm = zalloc(sizeof(*etm));
+	if (!etm)
+		return -ENOMEM;
+
+	session->auxtrace = &etm->auxtrace;
+	etm->auxtrace.free = cs_etm__free;
+	etm->auxtrace.evsel_is_auxtrace = cs_etm__evsel_is_auxtrace;
+	etm->auxtrace.process_event = cs_etm__process_event;
+	etm->auxtrace.process_auxtrace_event = cs_etm__process_auxtrace_event;
+	etm->auxtrace.flush_events = cs_etm__flush_events;
+	etm->auxtrace.free_events = cs_etm__free_events;
+	etm->pmu_type = (unsigned int) ((ptr[CS_PMU_TYPE_CPUS] >> 32) & 0xffffffff);
+
+	/*
+	 * Don't go further than the minimum required to identify this event as
+	 * auxtrace with cs_etm__evsel_is_auxtrace() so unleader_auxtrace()
+	 * works.
+	 */
+	if (auxtrace__dont_decode(session))
+		return 0;
 
 	/*
 	 * Bound num_cpu by the event size: the global header consumes
 	 * CS_ETM_HEADER_SIZE bytes, and each CPU needs at least one u64
 	 * metadata entry after that.
 	 */
+	num_cpu = ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
 	priv_size = total_size - event_header_size - INFO_HEADER_SIZE -
 		    CS_ETM_HEADER_SIZE;
 	if (num_cpu <= 0 || priv_size <= 0 ||
-	    num_cpu > priv_size / (int)sizeof(u64))
-		return -EINVAL;
+	    num_cpu > priv_size / (int)sizeof(u64)) {
+		err = -EINVAL;
+		goto err_free_etm;
+	}
 
 	metadata = zalloc(sizeof(*metadata) * num_cpu);
-	if (!metadata)
-		return -ENOMEM;
+	if (!metadata) {
+		err = -ENOMEM;
+		goto err_free_etm;
+	}
 
 	/* Start parsing after the common part of the header */
 	i = CS_HEADER_VERSION_MAX;
@@ -3631,13 +3653,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 		goto err_free_metadata;
 	}
 
-	etm = zalloc(sizeof(*etm));
-
-	if (!etm) {
-		err = -ENOMEM;
-		goto err_free_metadata;
-	}
-
 	/*
 	 * As all the ETMs run at the same exception level, the system should
 	 * have the same PID format crossing CPUs.  So cache the PID format
@@ -3647,7 +3662,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 
 	err = auxtrace_queues__init_nr(&etm->queues, max_cpu + 1);
 	if (err)
-		goto err_free_etm;
+		goto err_free_metadata;
 
 	for (unsigned int j = 0; j < etm->queues.nr_queues; ++j) {
 		err = cs_etm__setup_queue(etm, &etm->queues.queue_array[j], j);
@@ -3685,7 +3700,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	etm->session = session;
 
 	etm->num_cpu = num_cpu;
-	etm->pmu_type = (unsigned int) ((ptr[CS_PMU_TYPE_CPUS] >> 32) & 0xffffffff);
 	etm->snapshot_mode = (ptr[CS_ETM_SNAPSHOT] != 0);
 	etm->metadata = metadata;
 	etm->auxtrace_type = auxtrace_info->type;
@@ -3712,14 +3726,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 			    "you can specify the itrace option 'T' for timestamp decoding\n"
 			    "if the Coresight timestamp on the platform is same with the kernel time.\n\n");
 
-	etm->auxtrace.process_event = cs_etm__process_event;
-	etm->auxtrace.process_auxtrace_event = cs_etm__process_auxtrace_event;
-	etm->auxtrace.flush_events = cs_etm__flush_events;
-	etm->auxtrace.free_events = cs_etm__free_events;
-	etm->auxtrace.free = cs_etm__free;
-	etm->auxtrace.evsel_is_auxtrace = cs_etm__evsel_is_auxtrace;
-	session->auxtrace = &etm->auxtrace;
-
 	cs_etm__setup_timeless_decoding(etm);
 
 	etm->tc.time_shift = tc->time_shift;
@@ -3797,13 +3803,13 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 
 err_free_queues:
 	cs_etm__free_queues(etm);
-	session->auxtrace = NULL;
-err_free_etm:
-	zfree(&etm);
 err_free_metadata:
 	/* No need to check @metadata[j], free(NULL) is supported */
 	for (int j = 0; j < num_cpu; j++)
 		zfree(&metadata[j]);
 	zfree(&metadata);
+err_free_etm:
+	session->auxtrace = NULL;
+	zfree(&etm);
 	return err;
 }

-- 
2.43.0

