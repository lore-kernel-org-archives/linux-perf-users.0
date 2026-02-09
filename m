Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B833A0EAE
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658891; cv=none; b=sK65YmZixAxXMfzt1KyLiLEOD/xMZStIOI7E/2SyuEYCEzDUwiKBF0WfsyGgu8riQzOSRl9kdYajODU7Y/QqLG9iGjwY+wUl8QX2yaHTxFsjo/Cu7xphihotZjnIbT4dziP6Wo4lsMRsStnOhmvxW8KGfEH0kNmQBLrDU997chU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658891; c=relaxed/simple;
	bh=aQjq5ZG+K+4IDRdwx3pTY3E+EKQeJ5ckSzEJVafaoCs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=igu4N9gqOSiAnNNGVCRv81vPj8iF8XaeDEqbxyaIxy+ZzYsOW3isepw9Jq9FzFmfSp/k/2+hxGeddtkuvVoX6OHv7YwHHax4nw5RBfQ5b0j4rYiGHuLimIrH0TGEnFgC/P0z2Nb9tckr9AWIGVZ4REiscnsEQqNUNIynNCWywjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oDM9tznP; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oDM9tznP"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-123349958b2so6579175c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 09:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770658891; x=1771263691; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9nL/SbpUq3FHuKQYwVp11xXVhE63AKGDgQr9UUbNdNg=;
        b=oDM9tznPRyeYeiq3MefiHe4e2Yv3raEv8/UTNKGOLTXAfTX5Z7BX4+vBeachNpSkv4
         pn3u8Muv5Pg1nOt1HrO9EOftKOnv4i7EDFD+NE4IISs5V7qcUn/aWXrAYAE4jeTbMKIp
         nTPrx5pCshUDAL0OlZagISrZbZMJ3OBITgQ3VuCjZ9FM54U+LPAwuAoLwjfkK4+OA5is
         YVav9iUXqE3ya/z0EWmKXgTUV1mxpsJGB5Pjfyp/DoP3kLKTVx4oACFkynuGcaKZjQBg
         +UO1TiNigvcI6qj2cU0XdrWlDnPWIvG02ALwpgPzU0aYV//CC7DAz0plLv4+S6DHWREu
         2TiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658891; x=1771263691;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nL/SbpUq3FHuKQYwVp11xXVhE63AKGDgQr9UUbNdNg=;
        b=wiF0+lm7w4NiyalJKDuGvggr+brD5wHkpWJqLX4qNiJtw/I4ejmxV9XYZh2pc+NgTg
         drdNGw0kHomS5rNDDG+50qHvbmqJtwYGPAWc34vdqCZ1lncOstKCBTCajrCuZb+hGA9T
         wbadAdKAuez4ajQEIoQr2LUznVAm9YZ2unCuk1pYzGzzvz1cs6v2WsfHrD8Vt1r5CR5z
         kx7yKjHXYt9YVM7DjNkLwRNkdxh/YPOl2XJjYbNgmjwyd4xKYxpxYxeY/bzU1U5e+zOB
         6slGyWxQ5d6uQUhUeb056QWVdIY7KgXt5kUY9p4FppoTZ3XhgOAmnQS2EOntSoTx3dUQ
         jytA==
X-Forwarded-Encrypted: i=1; AJvYcCUXU5mIfJb9DqQzXHx8OwphstBT4JtxWS1/YzCwY8vLTO7Ff3lHstyZpneqA4SGOcOuwywinx8vWBm0RwZoIZsu@vger.kernel.org
X-Gm-Message-State: AOJu0YxEx3GE1Zw+q2/cxnOhgPbosAXq8kk3daBDDf/Fe9P1VhRW5HRs
	ujxwmhh0GiwZtSvEr6Epi7scADUuwJiPJCCRW1ffEdU0qVBdYtPaZ64/NJlc2Xy6MtIzL0dGGs5
	fYCUH6+BMXA==
X-Received: from dlg23.prod.google.com ([2002:a05:7022:797:b0:124:83ee:3e8b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6ba9:b0:11b:ca88:c4f7
 with SMTP id a92af1059eb24-1270402852amr5010549c88.40.1770658890566; Mon, 09
 Feb 2026 09:41:30 -0800 (PST)
Date: Mon,  9 Feb 2026 09:40:29 -0800
In-Reply-To: <20260209174032.4142096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260209174032.4142096-23-irogers@google.com>
Subject: [PATCH v1 22/25] perf evlist: Try to avoid computing evsel from sample
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Leo Yan <leo.yan@arm.com>, Tianyou Li <tianyou.li@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, tanze <tanze@kylinos.cn>, 
	Hrishikesh Suresh <hrishikesh123s@gmail.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Chun-Tse Shao <ctshao@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Chen Ni <nichen@iscas.ac.cn>, Blake Jones <blakejones@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
index 66038d68277e..fd3934a7281e 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -1695,11 +1695,12 @@ static int guest_session__fetch(struct guest_session *gs)
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
2.53.0.239.g8d8fc8a987-goog

