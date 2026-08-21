Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F9D3C3BED
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305857; cv=none; b=lTAmMemu2nJJP/gjek1fsOfZaoCvoIXO3chp48CfyhmbSAzIYtnludc7TLONMO9cZhLsXbLCW1CCT1GctUuydsjfkVbLStZ1MLZhBpiV0Ro8koCZgis6vav2c0uOZx04M5yIcXWTXjlt/4mGh91OiTh4IELCJl4Tw7BnN+tCwsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305857; c=relaxed/simple;
	bh=eLC8UWZIkmq+sG72ewDJLEWgWUKo/OduZ+n7icvyCCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jojQBc4wjWb3TNdgCZjraxfZJSpg6ky4YCwWjHxwiat6mndM+w7fm1xA0dITRR7q8S3lygLOtC37y2a8RlJ64EB/UzAwEdjcFEs+52Y9Cf8D07ZGVmBJRuMGMat0jKKME+ymx9TeF0zgIzC1Z/YZPqsE9p+pIoYCUDAFSL0NTRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uufovCjf; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uufovCjf"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso330858f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 02:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787305846; x=1787910646; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tSigklk0YY/8y8Y825wPuagaBgws2jxeudbXBTBNYx8=;
        b=uufovCjfjM3Y3ZWBFs+4nE6yOiAM+KbYR5xxxuDsbvF8izdfOAqQZlBBHo/WApuzWL
         fUUOx85NX3DPkkCJRTtK3qfizHRZ6qav3TNR9wza+YNUYOW0WgIgEhcrPjlTdvwsLcAq
         9JRYxjCCet5xkl2wpYm4cJqcB4aX4pKiFi/DAIv526FZ5Qlq8Uk/UueaI6DQsIMcSqCW
         sleayPTYfzWdwlPJtQSb08RNu2mfAY6nFKRPbIiqI5IN+8EyKmVFbEieq93ujPSL/I02
         XNIZK1AtTM3eCTqpEV//HjSTas+/bm9NYB7gEBnRqLT339KqNBzb8oWD2uB09e0wTac/
         M8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787305846; x=1787910646;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tSigklk0YY/8y8Y825wPuagaBgws2jxeudbXBTBNYx8=;
        b=bLicdnxV+4cRkimQu2yUZFVuPukyv4/yshW0Ht4hrGhb7K1Di6jSgCiFHKhnYBCMog
         n5aADevXiC2Ifs0sU8g8nCED3tBOBcIZ3G0sH8rYsP7RjeRs/tu/VH1hYjqqe8HlKq4h
         iVZhG24aDJoz6hIL8NjYYm8gehmvMFbt8ZxoXUHjFs/2zTvmO1tOnvIysgql+PPhJ7Fk
         M39hVYYBn6jccdqrLR7hMku/dpcLADX8N2a7inVCZTUooNav2KqinUP0aKLbpiriclSH
         M/1BDNeqZXr1rTzwlCPOeWs/OLAS6Grm7Pl53OqRI/5EHxI6YWO4i/Bh+mJkCfUdN+nC
         Gk1A==
X-Forwarded-Encrypted: i=1; AHgh+RoPT1fqVqa8IqrztR0lmiX2adAx2s2pYZNbj6u7925YQ3k22+hhduQ6v0boguy1BXqvzK0ez33ccCAF726z6Sel@vger.kernel.org
X-Gm-Message-State: AFuF++nWjRYSXMXyVnRpPkUAVPzxO6x/RNYRsYdIwA+PtRLy+huzpXHa
	0lk0opgFK51F0gFji03yaUZMop1qFdpRZxG5s/9o5BRe/l3yfVnyY7mpOfLoceUlVqs=
X-Gm-Gg: AR+sD10RPJGSYRciD7G32n7weJf7j4GCUCiU006PfMqziItCfla5DvvT0NDC3SHnLba
	+yNES7SsabdnL21I5lHzi5BQQPvvthbYFHzOvoDvrjzbXOV3sgEDG11DxAlakIodm0EIueF+3PO
	bACOjE7OUNV3sY0GrF7rYIgQP5az7/OZSdHoCDWsi76Qftb4lJlZjKcCvLgNNbKTJSVXvMJMTrK
	+ED22p4vuk1iXRJJ+eYF9r5M1nHI9eBruC0UPp4YvEZgFRxnovJslP66CDOfvwF+E7gHPVdAfBV
	bClbICzIwZQ2vamsqYCE38EZmPXJ+KAuEtbsoLB0eSH7vG6DFKcBKfgX83yzPfOSaPbgzcJFoKR
	QIDG5F/LWnv4DgZ7ygj5hXWnKEeuBnGQw+l7Dl1ak39g66JQrFrAvqi/8iMMgfl6fR4Rw5iCOPq
	KVcQuoQXP/CN2dFGBSWvUROGGNcBQ5hEMin1FDXbBwBok9uUlB0/uCM8Vcr9pq+VyQ
X-Received: by 2002:adf:e193:0:b0:47f:e760:e5b9 with SMTP id ffacd0b85a97d-482c0ba3a3amr7830202f8f.18.1787305846313;
        Fri, 21 Aug 2026 02:50:46 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c3775sm14474284f8f.26.2026.08.21.02.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 02:50:45 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 21 Aug 2026 10:50:32 +0100
Subject: [PATCH 4/6] perf: cs-etm: Respect --no-itrace option
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-james-cs-hw_id-output-failure-v1-4-9d532ddabcc3@linaro.org>
References: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
In-Reply-To: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
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

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/auxtrace.c |  2 +-
 tools/perf/util/auxtrace.h |  1 +
 tools/perf/util/cs-etm.c   | 66 +++++++++++++++++++++++++---------------------
 3 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index e3c770b46e94..caa53056d349 100644
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
index 971b817d3396..47fb97136836 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -651,6 +651,7 @@ void auxtrace__free(struct perf_session *session);
 bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
 				 struct evsel *evsel);
 u64 auxtrace_synth_id_range_start(struct evsel *evsel);
+bool auxtrace__dont_decode(struct perf_session *session);
 
 #define ITRACE_HELP \
 "				i[period]:    		synthesize instructions events\n" \
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index dd15e91b7b38..22884c9fdff8 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -969,7 +969,7 @@ static int cs_etm__flush_events(struct perf_session *session,
 	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
 						   struct cs_etm_auxtrace,
 						   auxtrace);
-	if (dump_trace)
+	if (dump_trace || auxtrace__dont_decode(session))
 		return 0;
 
 	if (!tool->ordered_events)
@@ -3040,7 +3040,7 @@ static int cs_etm__process_event(struct perf_session *session,
 						   struct cs_etm_auxtrace,
 						   auxtrace);
 
-	if (dump_trace)
+	if (dump_trace || auxtrace__dont_decode(session))
 		return 0;
 
 	if (!tool->ordered_events) {
@@ -3603,27 +3603,49 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
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
@@ -3682,13 +3704,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
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
@@ -3698,7 +3713,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 
 	err = auxtrace_queues__init_nr(&etm->queues, max_cpu + 1);
 	if (err)
-		goto err_free_etm;
+		goto err_free_metadata;
 
 	for (unsigned int j = 0; j < etm->queues.nr_queues; ++j) {
 		err = cs_etm__setup_queue(etm, &etm->queues.queue_array[j], j);
@@ -3736,7 +3751,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	etm->session = session;
 
 	etm->num_cpu = num_cpu;
-	etm->pmu_type = (unsigned int) ((ptr[CS_PMU_TYPE_CPUS] >> 32) & 0xffffffff);
 	etm->snapshot_mode = (ptr[CS_ETM_SNAPSHOT] != 0);
 	etm->metadata = metadata;
 	etm->auxtrace_type = auxtrace_info->type;
@@ -3763,14 +3777,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
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
@@ -3853,13 +3859,13 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 
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

