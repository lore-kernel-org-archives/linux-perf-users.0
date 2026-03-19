Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8609341325F
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 23:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773962693; cv=none; b=qm4YNCck4g6iHmIkbrraOehNFYuKgm9TAfQrTCY6cVIO2vz2DhiLJP3UVylsEmeLadu0PuDCuZ8kTImyLfMBcnCYFrrwkMf6OsddxGefrFfwARt1QpY2dD9o+QbLXawBhMWSojtyYcMXdTxfJl1wSdupaQgzC1NYqZ7lVUmYG58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773962693; c=relaxed/simple;
	bh=nQKlfJP7iPPRZwHgkfibxtIFOBIy32Z3EoTWSHNa2g4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rgp6X3WJPu4gNN+W9y3JMXD237BzsHx7qFmCttOP2wc/X94tsEObfCwrqE8jsv5u1f11Bp334Sa5ZyaZ67T1QCcMo3cRTBVlncSqFRikgnmLetdQZjFvfEAzDkq8zb3RXBB8Ppnm3TjkKk5I1t6SKXCt4x3W8Xd8jEyB+1zlC4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bbB+PiVG; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bbB+PiVG"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0d15416b3so2192729eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 16:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773962692; x=1774567492; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M9pkC5P8S36AmhD0fZGvAVfRmdPNACn5tpVw32aG+t0=;
        b=bbB+PiVGpqyluVoAilICVjx6zvZ5vslZJUuSBfoxnyruQuOJrZj1szIOcKIvZ4jAHE
         dMzw+7nNHoD8xlq1/TepyKJ2VICe/UEdrhtSyZlQzV9C2K0OI65SgPoGmGBgj7c6qtfl
         8n0RSWJO42XDKNDWdJdTTbcMdLbD1JNH1efeiMbukazAzP3/BaOuKEXBV9sgroyTHQAK
         iKmQFMKjoHAcpXqT2VCd1X443BWMqXciQO4fgygQHUZ18HOSm3m5FPwq1khP1ktjtOcZ
         eM0rTvYTh/non9ePk3hBuLH+tg0fRWybaYpMY4Pd4ApFuHTUn/KSrMVPclBf7nW47Ydk
         gL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773962692; x=1774567492;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9pkC5P8S36AmhD0fZGvAVfRmdPNACn5tpVw32aG+t0=;
        b=iIYybIfOtIjXgS4bk9BdJrCMv6PNbTlmScR8HSlqgE15WYt9FJOxa4YFsaYkPXfFp9
         Qs/zAQ3nOVV2sMhn1PQOaXwxIP+ePIgdFF1U7DDuqqFP7yXRAKbHzRam5HDgLLS7LeiQ
         m5k0aM2BM4CRDlmgfGDL8al+sb7Ug/OCBA7aTrOoxHr8YsZXQdfdCvMAiSOcCwZXDud0
         Cccr0P9oUxHbqo9Rvz5Y0I6H1iNLrBfR9G1gp+jgdnfY4iIgkpaVXYg5KokhH1KIVqB8
         7qObp19iDQuN8BJS4hskbFgbGaVkz9Eex6y+z5k4CZRHs3aAF9TW94nUWuFH2tmVxHO9
         L6+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCgx/5M//FEtBH8wBarTInBsOh+JcglKDLfkOmy2dlUEpkdsS8/SlLL2sJ49OS2U0wrqL8HQFdBq7xfoowVCli@vger.kernel.org
X-Gm-Message-State: AOJu0YzeZ/eTtsVIeDT/TaUPYlT8jNf+K3WybCkZ/E3SNCLDf6vY9ERI
	aM/i0jDj7eBr9Q0Qx1YPRyrqGggJJt9SRNIchrw8/UFxCrrh5Jc7+lIX4k8skjP3RqLdT31Jz7d
	tbHk/COqH/A==
X-Received: from dybso14.prod.google.com ([2002:a05:7301:690e:b0:2c0:b988:33bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2216:b0:2be:2cfe:68b7
 with SMTP id 5a478bee46e88-2c109622b94mr560778eec.11.1773962691319; Thu, 19
 Mar 2026 16:24:51 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:23:31 -0700
In-Reply-To: <20260319232334.287517-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com> <20260319232334.287517-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260319232334.287517-23-irogers@google.com>
Subject: [PATCH v2 22/25] perf evlist: Try to avoid computing evsel from sample
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

If the sample has an evsel, don't recompute using the sample.id.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c        |  5 +++--
 tools/perf/builtin-top.c           |  4 +++-
 tools/perf/tests/mmap-basic.c      |  4 +++-
 tools/perf/tests/switch-tracking.c |  5 ++++-
 tools/perf/util/intel-pt.c         | 10 +++++++---
 5 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 6e265b66a551..9ea082bccbe6 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -1693,11 +1693,12 @@ static int guest_session__fetch(struct guest_session *gs)
 static int evlist__append_id_sample(struct evlist *evlist, union perf_event *ev,
 				    const struct perf_sample *sample)
 {
-	struct evsel *evsel;
+	struct evsel *evsel = sample->evsel;
 	void *array;
 	int ret;
 
-	evsel = evlist__id2evsel(evlist, sample->id);
+	if (!evsel)
+		evsel = evlist__id2evsel(evlist, sample->id);
 	array = ev;
 
 	if (!evsel) {
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index b89ca48e5d02..faa422e35166 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1163,7 +1163,9 @@ static int deliver_event(struct ordered_events *qe,
 		goto next_event;
 	}
 
-	evsel = evlist__id2evsel(session->evlist, sample.id);
+	evsel = sample.evsel;
+	if (!evsel)
+		evsel = evlist__id2evsel(session->evlist, sample.id);
 	assert(evsel != NULL);
 
 	if (event->header.type == PERF_RECORD_SAMPLE) {
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 3313c236104e..a18d84d858aa 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -142,7 +142,9 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 		}
 
 		err = -1;
-		evsel = evlist__id2evsel(evlist, sample.id);
+		evsel = sample.evsel;
+		if (!evsel)
+			evsel = evlist__id2evsel(evlist, sample.id);
 		perf_sample__exit(&sample);
 		if (evsel == NULL) {
 			pr_debug("event with id %" PRIu64
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index a7ea4b7874be..ed17c3be71c4 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -138,7 +138,10 @@ static int process_sample_event(struct evlist *evlist,
 		goto out;
 	}
 
-	evsel = evlist__id2evsel(evlist, sample.id);
+	evsel = sample.evsel;
+	if (!evsel)
+		evsel = evlist__id2evsel(evlist, sample.id);
+
 	if (evsel == switch_tracking->switch_evsel) {
 		next_tid = perf_sample__intval(&sample, "next_pid");
 		prev_tid = perf_sample__intval(&sample, "prev_pid");
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index dab23a96b1d8..3d759546a7c0 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3421,7 +3421,10 @@ static int intel_pt_process_switch(struct intel_pt *pt,
 {
 	pid_t tid;
 	int cpu, ret;
-	struct evsel *evsel = evlist__id2evsel(pt->session->evlist, sample->id);
+	struct evsel *evsel = sample->evsel;
+
+	if (!evsel)
+		evsel = evlist__id2evsel(pt->session->evlist, sample->id);
 
 	if (evsel != pt->switch_evsel)
 		return 0;
@@ -3611,10 +3614,11 @@ static int intel_pt_process_aux_output_hw_id(struct intel_pt *pt,
 	u64 hw_id = event->aux_output_hw_id.hw_id;
 	struct auxtrace_queue *queue;
 	struct intel_pt_queue *ptq;
-	struct evsel *evsel;
+	struct evsel *evsel = sample->evsel;
 
 	queue = auxtrace_queues__sample_queue(&pt->queues, sample, pt->session);
-	evsel = evlist__id2evsel_strict(pt->session->evlist, sample->id);
+	if (!evsel)
+		evsel = evlist__id2evsel_strict(pt->session->evlist, sample->id);
 	if (!queue || !queue->priv || !evsel || hw_id > INTEL_PT_MAX_PEBS) {
 		pr_err("Bad AUX output hardware ID\n");
 		return -EINVAL;
-- 
2.53.0.959.g497ff81fa9-goog

