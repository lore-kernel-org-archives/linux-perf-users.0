Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4C8346FB3
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939072; cv=none; b=gJMgSwcj30BvvzgXDCX/KIenVSC7pSMaFYWtkKl1hOZb6r4RgEd+MQ/M8jnupScguwe4HN3F3Oz47ArHmx5hpRf1/91Q0kDeWUUIK4cu+c6LHK2qXT/69UkbBUDL7hMG9Lbhk0hEtWeET7FCfPQbCq6VzwVPT3lEpPTHplRMQbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939072; c=relaxed/simple;
	bh=M3rPYMcpTIRHBZ3NVVSsH8snhyXO8wiBrkIMArVMaI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mlD3Y5xDyq4hr5TxFbvl1BBN1fLftlTEVlwAefz8H4NL5qB82hs6Tnfb9xxdp+7oNimC2PEF2Q8wdJu8/xHlRxt3UjeihcsEDoxz0unr5oPHQZnmu8bHaFlixnA+s6XtjIkcr3LgsJzy/GD8Wl5odpMGQ8owswb9MXRosimINKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X8bADeFq; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X8bADeFq"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d8239so59929765e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 04:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790939065; x=1791543865; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OUfzXk7gzJEOddY/hfe9OLAQHpkFenB0R/fhaQZ1l64=;
        b=X8bADeFqVRNxgGJlzcxreaS5WceTZJ4ZacTy9BPFmi+cXuC2VrQYZgfpZBzYq1VeQ/
         WvRYHnTrv/p3Nle9KwmRTnK089lADt3f4rFsaAuJZ8u7J1y6/qQ4fcXv2B4K1RabL4PP
         n1FqT3oz1WXv9qbsx5f4UlU0hV4IXIzQ3eEIRAYMZ7+KxSUJpiVwR/C1zX6zUUk4S3rx
         a+wh4JWJPTpI+oVfsb1aCgcBYGmMlvfFdUJ94BX5ikub4aFgSUwGf7rZXIyQcU7NMTtj
         LKrGQ/uXubjSX/KsNi9IS8WPlDerVN6j6f7p0eRMm/uBLM/p0ERfGpN29qIJVkrshCc8
         jNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790939065; x=1791543865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OUfzXk7gzJEOddY/hfe9OLAQHpkFenB0R/fhaQZ1l64=;
        b=E3gh3tKwgYd6EKdUQS+PZoWmMeKC8ouJ5VslfNNN99AafhBAhhK+XYUPOUhdWLbAPs
         Bxn5nEEYIneNhs4FlCF6RQhXBD4gv7EVe7Q4JQU1PSIDpvSvGgN1gVHXERQJisoKUw81
         1/yIvMw38jJtBXg85YhHYoevjDb+D3Ltqz4T02fDQJyOdgzTAciHy8+8RB2xWMJUT3ye
         8yNClZ+NgpfX6YPXC4CYErV24vkJi9M7RduQHRbtTEOA1s3DbUKgORGnzZgIczYGSA+i
         PIV9Nz9G1t7ifG4Lap29OJaSpyEp/EdGLg4hZUSWXThCuoX1OvKTcFXJ0qHYgSPrC5EV
         C4tQ==
X-Forwarded-Encrypted: i=1; AKwUvBxnu7hYXz779jkzZzI6e38PiXhjaFlcwtGjxTzPC3esNg3EADKI3qsVNVexnCglJW95D+TE5e26LRLaVLnc0sml@vger.kernel.org
X-Gm-Message-State: AFuF++nDMi9vj9RQbWQyPHpNwngRRWQ0neR00kyKRaAxL6XsIj+OeUk2
	ku0IEznHcjG5Fz4ybvxvGT1dxNl2vXUFLP+RoeuCqoSvsJ1O8SYrMCda955M6/qMnp8=
X-Gm-Gg: AYBFou2/gXizeXyq/2CAvEfkJR/qaq3hCK81Wb/JERgKE3kveRd3S211AkVqFVpeHS7
	yVKLRo0R2VyQSxPU9gU5mm6JcbhyUDVRyJmdyzZtwVSfpg2ra0+J9R86tgbpeaVzaIj4c0DCvf9
	Gbx8/gm0vWHKqumfLrW3sXZej4XqswI+WWTEcs09kgofLuSqFl1UjdJf80b22bNDcmDdeXciFjl
	aRzXaHNG+W1aQWiZJippat+D8XE6PV0T3TgRMOnBDaeywHpecgsFBzXu5sZM4g95N5Upvl9bGW/
	KZIS9A1ONBhHAi+hRhk3CIvajDxalgKS/hxWIB7TFo1rQUoIKFp5QLZ8oOzadkcbuUpptW4pfMv
	OdeVImk5NBfS8wamKGYudwZAMh6QbU1LzkfTEwj+Ivl6W+lzY2KB9h27dsgtxrjfyVy9Oa7keQl
	RYrk3VO1Q5qdPh4f07N0m1lus7fnUf66jJRkca7M3cFOFpHv+xTPdxfPehuVbM61qWxIF5uisZq
	/Rm3y0g/cMuMQ==
X-Received: by 2002:a05:600c:530d:b0:4a0:1e37:ae41 with SMTP id 5b1f17b1804b1-4a0275a22b1mr38311505e9.24.1790939065036;
        Fri, 02 Oct 2026 04:04:25 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280c6597sm75669465e9.9.2026.10.02.04.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 04:04:24 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 02 Oct 2026 12:03:56 +0100
Subject: [PATCH v2 4/4] perf: cs-etm: Respect --no-itrace option
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-james-cs-hw_id-output-failure-v2-4-7a194aa61173@linaro.org>
References: <20261002-james-cs-hw_id-output-failure-v2-0-7a194aa61173@linaro.org>
In-Reply-To: <20261002-james-cs-hw_id-output-failure-v2-0-7a194aa61173@linaro.org>
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

