Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927EF3F0ABD
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034891; cv=none; b=e05gdAYSMZ/9oW4dBjYLCM4cDGRfx9AvV5Ubq7CV82DGrH3h+2QxLjnEiEW8K8ygWo5ZGHQFpMKmTUxjPD0xOmWWLqxeyNKYTFcPrD8FjXrkmeNNEQB28cj9ZdkjoQOKXHWfQMwQreFit2L2/2Vl/X9ITsLsQVi53WJEdUmEu64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034891; c=relaxed/simple;
	bh=8gTonKYXDgbW7CfmjnA/QyFHVsLxprvd0/qB5LIWIf4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pMDNeaqf/tfm5wHpqaNcQfO+Otx9smznsO39qyzGqKcMmh7jRphyTQIpXlFcEWCc87P3V4XlC3MzZgDYd69RscPVsaVWA77p0gzqJIhfeDrilwDaTqmLjzkLuw/lHLz9pcjztclnZQosfFEteZkCAkiRT8zuontdE3IbmROrERE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hjLvLCfQ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjLvLCfQ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35b8da51b3eso1002877a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 12:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774034883; x=1774639683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F/owc0gzyElO+cMfbM8NSItiqfC0EYb6RNibraaNLvw=;
        b=hjLvLCfQkxuGCkDHKXV/TucnuGmuULhQ5kMpqDkyapS9HMTplnlONAkD/EAfCvoaVO
         b0duhzrhgrhc+/DZmBAqNIpcMPiN9qeJBAiFhBY6Ppe2Pv3I8PN3nUJTDctuxAFBCpq8
         lQ5FclscxSo6q+Wfd2Sa9ab0nfFTQEJ1TRGcT6k8TG+2967e4wRWT0H05HiIUcVbURwt
         ybnL1qz55lg7XKEbiPamBeExZmsW7trPMQST2MrPLoJsGBiIoUEVu1egEy50oA5WJkTD
         xAwmT+a2cSJ+0dbm8LtoNJLAqaPVSzP3CHcJPrGCMEHmD8J48qkRyvrzOfsWqzlNn1qs
         e9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034883; x=1774639683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/owc0gzyElO+cMfbM8NSItiqfC0EYb6RNibraaNLvw=;
        b=NMP6CsxWe1FnA2ZKMUJl56Ux3bQinxyEwxF7fV+ujjhXB5j1bPqJyysyCvzITrJKv9
         RyDZyzpR5jXIl4Vmv2Z959qIxKh1KEjqpd9cqqGAI1j1gz1ZwxyjR/2EsA2Wrq/NvJQz
         qNB/p92O8pjK6jr9NFkIl2UBrnYHc3MDLE9zH2YZ7t2qXcRqCL3IkiLOUwSG1WfG9DqL
         +QGkq6uR1lyzeBPWdu+wJxhCBx3RrVex3Y8QicHhXRBULs47dS4C6kU49SgeTo4cHP3L
         f7AvU3QdAUIQ2cT1/JdOwZD+dh5onoQdQRRY39P74jw8BHIABq480NHIzXbam63Yxx3q
         UUGA==
X-Forwarded-Encrypted: i=1; AJvYcCVSkXzlgUpoTrSeI+kQTMmvFgwTft4HmR82clgfvBebxbNURbfWk9AETOWW5KY089ENxAn7nA4shX08kSHHIX/J@vger.kernel.org
X-Gm-Message-State: AOJu0YxrRS6Reen1wHLYl9NxVqVjgQkD0TvK1TV5XhZY4Hz6I4rThVIH
	6NZhUuKVpuctYx1WlqIxIiysiJ0PpcCh3QXg+mQuUKloKJ9dnIoIPdb+X/rY1ZDBU5vShgf+pvp
	ozx1ERDoESw==
X-Received: from pjub24.prod.google.com ([2002:a17:90a:cc18:b0:35b:9a3b:1f2c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2244:b0:35b:9a22:deb1
 with SMTP id 98e67ed59e1d1-35bd2bcaf7amr3207511a91.8.1774034883313; Fri, 20
 Mar 2026 12:28:03 -0700 (PDT)
Date: Fri, 20 Mar 2026 12:26:04 -0700
In-Reply-To: <20260320192627.368357-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320080835.724836-1-irogers@google.com> <20260320192627.368357-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320192627.368357-3-irogers@google.com>
Subject: [PATCH v4 02/25] perf sample: Make sure perf_sample__init/exit are used
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

The deferred stack trace code wasn't using perf_sample__init/exit. Add
the deferred stack trace clean up to perf_sample__exit which requires
proper NULL initialization in perf_sample__init. Make the
perf_sample__exit robust to being called more than once by using
zfree. Make the error paths in evsel__parse_sample exit the
sample. Add a merged_callchain boolean to capture that callchain is
allocated, deferred_callchain doen't suffice for this. Pack the struct
variables to avoid padding bytes for this.

Similiarly powerpc_vpadtl_sample wasn't using perf_sample__init/exit,
use it for consistency and potential issues with uninitialized
variables.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c        |  6 +++++-
 tools/perf/tests/perf-record.c     |  1 +
 tools/perf/tests/switch-tracking.c |  2 ++
 tools/perf/util/callchain.c        | 10 ++++++---
 tools/perf/util/evlist.c           |  5 ++++-
 tools/perf/util/evsel.c            | 34 ++++++++++++++++++------------
 tools/perf/util/powerpc-vpadtl.c   | 10 +++++----
 tools/perf/util/sample.c           | 10 +++++++--
 tools/perf/util/sample.h           | 17 +++++++++------
 tools/perf/util/session.c          | 13 ++++++++----
 10 files changed, 74 insertions(+), 34 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 5b29f4296861..8b9a0a4097af 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -1087,6 +1087,7 @@ static int perf_inject__sched_stat(const struct perf_tool *tool,
 	struct perf_sample sample_sw;
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
 	u32 pid = evsel__intval(evsel, sample, "pid");
+	int ret;
 
 	list_for_each_entry(ent, &inject->samples, node) {
 		if (pid == ent->tid)
@@ -1103,7 +1104,9 @@ static int perf_inject__sched_stat(const struct perf_tool *tool,
 	perf_event__synthesize_sample(event_sw, evsel->core.attr.sample_type,
 				      evsel->core.attr.read_format, &sample_sw);
 	build_id__mark_dso_hit(tool, event_sw, &sample_sw, evsel, machine);
-	return perf_event__repipe(tool, event_sw, &sample_sw, machine);
+	ret = perf_event__repipe(tool, event_sw, &sample_sw, machine);
+	perf_sample__exit(&sample_sw);
+	return ret;
 }
 #endif
 
@@ -1826,6 +1829,7 @@ static int guest_session__inject_events(struct guest_session *gs, u64 timestamp)
 			return -EINVAL;
 		}
 
+		perf_sample__exit(sample);
 		gs->fetched = false;
 
 		ret = output_bytes(inject, ev, ev->header.size);
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index efbd9cd60c63..7b881f08906d 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -297,6 +297,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 				}
 
 				perf_mmap__consume(&md->core);
+				perf_sample__exit(&sample);
 			}
 			perf_mmap__read_done(&md->core);
 		}
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 15791fcb76b2..72a8289e846d 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -239,11 +239,13 @@ static int add_event(struct evlist *evlist, struct list_head *events,
 
 	if (!sample.time) {
 		pr_debug("event with no time\n");
+		perf_sample__exit(&sample);
 		return -1;
 	}
 
 	node->event_time = sample.time;
 
+	perf_sample__exit(&sample);
 	return 0;
 }
 
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 8ff0898799ee..19c97137103c 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1854,16 +1854,19 @@ int sample__merge_deferred_callchain(struct perf_sample *sample_orig,
 	u64 nr_deferred = sample_callchain->callchain->nr;
 	struct ip_callchain *callchain;
 
+	if (sample_orig->merged_callchain) {
+		/* Already merged. */
+		return -EINVAL;
+	}
+
 	if (sample_orig->callchain->nr < 2) {
 		sample_orig->deferred_callchain = false;
 		return -EINVAL;
 	}
 
 	callchain = calloc(1 + nr_orig + nr_deferred, sizeof(u64));
-	if (callchain == NULL) {
-		sample_orig->deferred_callchain = false;
+	if (callchain == NULL)
 		return -ENOMEM;
-	}
 
 	callchain->nr = nr_orig + nr_deferred;
 	/* copy original including PERF_CONTEXT_USER_DEFERRED (but the cookie) */
@@ -1872,6 +1875,7 @@ int sample__merge_deferred_callchain(struct perf_sample *sample_orig,
 	memcpy(&callchain->ips[nr_orig], sample_callchain->callchain->ips,
 	       nr_deferred * sizeof(u64));
 
+	sample_orig->merged_callchain = true;
 	sample_orig->callchain = callchain;
 	return 0;
 }
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 591bdf0b3e2a..bdb196425071 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1622,8 +1622,11 @@ int evlist__parse_sample(struct evlist *evlist, union perf_event *event, struct
 	struct evsel *evsel = evlist__event2evsel(evlist, event);
 	int ret;
 
-	if (!evsel)
+	if (!evsel) {
+		/* Ensure the sample is okay for perf_sample__exit. */
+		perf_sample__init(sample, /*all=*/false);
 		return -EFAULT;
+	}
 	ret = evsel__parse_sample(evsel, event, sample);
 	if (ret)
 		return ret;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f59228c1a39e..59efe460d9bc 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3067,7 +3067,7 @@ static inline bool overflow(const void *endp, u16 max_size, const void *offset,
 #define OVERFLOW_CHECK(offset, size, max_size)				\
 	do {								\
 		if (overflow(endp, (max_size), (offset), (size)))	\
-			return -EFAULT;					\
+			goto out_efault;				\
 	} while (0)
 
 #define OVERFLOW_CHECK_u64(offset) \
@@ -3199,6 +3199,8 @@ static int __set_offcpu_sample(struct perf_sample *data)
 	data->cgroup = *array;
 
 	return 0;
+out_efault:
+	return -EFAULT;
 }
 
 int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
@@ -3217,7 +3219,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	 */
 	union u64_swap u;
 
-	memset(data, 0, sizeof(*data));
+	perf_sample__init(data, /*all=*/true);
 	data->cpu = data->pid = data->tid = -1;
 	data->stream_id = data->id = data->time = -1ULL;
 	data->period = evsel->core.attr.sample_period;
@@ -3231,25 +3233,26 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 
 		data->callchain = (struct ip_callchain *)&event->callchain_deferred.nr;
 		if (data->callchain->nr > max_callchain_nr)
-			return -EFAULT;
+			goto out_efault;
 
 		data->deferred_cookie = event->callchain_deferred.cookie;
 
 		if (evsel->core.attr.sample_id_all)
 			perf_evsel__parse_id_sample(evsel, event, data);
+
 		return 0;
 	}
 
 	if (event->header.type != PERF_RECORD_SAMPLE) {
-		if (!evsel->core.attr.sample_id_all)
-			return 0;
-		return perf_evsel__parse_id_sample(evsel, event, data);
+		if (evsel->core.attr.sample_id_all)
+			perf_evsel__parse_id_sample(evsel, event, data);
+		return 0;
 	}
 
 	array = event->sample.array;
 
 	if (perf_event__check_size(event, evsel->sample_size))
-		return -EFAULT;
+		goto out_efault;
 
 	if (type & PERF_SAMPLE_IDENTIFIER) {
 		data->id = *array;
@@ -3342,7 +3345,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 					sizeof(struct sample_read_value);
 
 			if (data->read.group.nr > max_group_nr)
-				return -EFAULT;
+				goto out_efault;
 
 			sz = data->read.group.nr * sample_read_value_size(read_format);
 			OVERFLOW_CHECK(array, sz, max_size);
@@ -3370,7 +3373,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		data->callchain = (struct ip_callchain *)array++;
 		callchain_nr = data->callchain->nr;
 		if (callchain_nr > max_callchain_nr)
-			return -EFAULT;
+			goto out_efault;
 		sz = callchain_nr * sizeof(u64);
 		/*
 		 * Save the cookie for the deferred user callchain.  The last 2
@@ -3428,7 +3431,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		data->branch_stack = (struct branch_stack *)array++;
 
 		if (data->branch_stack->nr > max_branch_nr)
-			return -EFAULT;
+			goto out_efault;
 
 		sz = data->branch_stack->nr * sizeof(struct branch_entry);
 		if (evsel__has_branch_hw_idx(evsel)) {
@@ -3505,7 +3508,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			data->user_stack.size = *array++;
 			if (WARN_ONCE(data->user_stack.size > sz,
 				      "user stack dump failure\n"))
-				return -EFAULT;
+				goto out_efault;
 		}
 	}
 
@@ -3582,10 +3585,15 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array = (void *)array + sz;
 	}
 
-	if (evsel__is_offcpu_event(evsel))
-		return __set_offcpu_sample(data);
+	if (evsel__is_offcpu_event(evsel)) {
+		if (__set_offcpu_sample(data))
+			goto out_efault;
+	}
 
 	return 0;
+out_efault:
+	perf_sample__exit(data);
+	return -EFAULT;
 }
 
 int evsel__parse_sample_timestamp(struct evsel *evsel, union perf_event *event,
diff --git a/tools/perf/util/powerpc-vpadtl.c b/tools/perf/util/powerpc-vpadtl.c
index d1c3396f182f..993ab16614c7 100644
--- a/tools/perf/util/powerpc-vpadtl.c
+++ b/tools/perf/util/powerpc-vpadtl.c
@@ -182,7 +182,9 @@ static int powerpc_vpadtl_sample(struct powerpc_vpadtl_entry *record,
 {
 	struct perf_sample sample;
 	union perf_event event;
+	int ret;
 
+	perf_sample__init(&sample, /*all=*/true);
 	sample.ip = be64_to_cpu(record->srr0);
 	sample.period = 1;
 	sample.cpu = cpu;
@@ -198,12 +200,12 @@ static int powerpc_vpadtl_sample(struct powerpc_vpadtl_entry *record,
 	event.sample.header.misc = sample.cpumode;
 	event.sample.header.size = sizeof(struct perf_event_header);
 
-	if (perf_session__deliver_synth_event(vpa->session, &event, &sample)) {
+	ret = perf_session__deliver_synth_event(vpa->session, &event, &sample);
+	if (ret)
 		pr_debug("Failed to create sample for dtl entry\n");
-		return -1;
-	}
 
-	return 0;
+	perf_sample__exit(&sample);
+	return ret;
 }
 
 static int powerpc_vpadtl_get_buffer(struct powerpc_vpadtl_queue *vpaq)
diff --git a/tools/perf/util/sample.c b/tools/perf/util/sample.c
index 8f82aaf1aab6..2a30de4573f6 100644
--- a/tools/perf/util/sample.c
+++ b/tools/perf/util/sample.c
@@ -21,13 +21,19 @@ void perf_sample__init(struct perf_sample *sample, bool all)
 	} else {
 		sample->user_regs = NULL;
 		sample->intr_regs = NULL;
+		sample->merged_callchain = false;
+		sample->callchain = NULL;
 	}
 }
 
 void perf_sample__exit(struct perf_sample *sample)
 {
-	free(sample->user_regs);
-	free(sample->intr_regs);
+	zfree(&sample->user_regs);
+	zfree(&sample->intr_regs);
+	if (sample->merged_callchain) {
+		zfree(&sample->callchain);
+		sample->merged_callchain = false;
+	}
 }
 
 struct regs_dump *perf_sample__user_regs(struct perf_sample *sample)
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 8d4ace0e6594..5809c42631e5 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -155,12 +155,6 @@ struct perf_sample {
 	 *            intel-pt. The instruction itself is held in insn.
 	 */
 	u16 insn_len;
-	/**
-	 * @cpumode: The cpumode from struct perf_event_header misc variable
-	 *           masked with CPUMODE_MASK. Gives user, kernel and hypervisor
-	 *           information.
-	 */
-	u8  cpumode;
 	/** @misc: The entire struct perf_event_header misc variable. */
 	u16 misc;
 	/**
@@ -174,6 +168,12 @@ struct perf_sample {
 	 *           powerpc holds p_stage_cyc.
 	 */
 	u16 weight3;
+	/**
+	 * @cpumode: The cpumode from struct perf_event_header misc variable
+	 *           masked with CPUMODE_MASK. Gives user, kernel and hypervisor
+	 *           information.
+	 */
+	u8  cpumode;
 	/**
 	 * @no_hw_idx: For PERF_SAMPLE_BRANCH_STACK, true when
 	 *             PERF_SAMPLE_BRANCH_HW_INDEX isn't set.
@@ -184,6 +184,11 @@ struct perf_sample {
 	 *                      user callchain marker was encountered.
 	 */
 	bool deferred_callchain;
+	/**
+	 * @merged_callchain: A synthesized merged callchain that is allocated
+	 *                    and needs freeing.
+	 */
+	bool merged_callchain;
 	/**
 	 * @deferred_cookie: Identifier of the deferred callchain in the later
 	 *                   PERF_RECORD_CALLCHAIN_DEFERRED event.
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 4b465abfa36c..c48e840da7d4 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1367,14 +1367,18 @@ static int evlist__deliver_deferred_callchain(struct evlist *evlist,
 	list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list) {
 		struct perf_sample orig_sample;
 
+		perf_sample__init(&orig_sample, /*all=*/false);
 		ret = evlist__parse_sample(evlist, de->event, &orig_sample);
 		if (ret < 0) {
 			pr_err("failed to parse original sample\n");
+			perf_sample__exit(&orig_sample);
 			break;
 		}
 
-		if (sample->tid != orig_sample.tid)
+		if (sample->tid != orig_sample.tid) {
+			perf_sample__exit(&orig_sample);
 			continue;
+		}
 
 		if (event->callchain_deferred.cookie == orig_sample.deferred_cookie)
 			sample__merge_deferred_callchain(&orig_sample, sample);
@@ -1385,9 +1389,7 @@ static int evlist__deliver_deferred_callchain(struct evlist *evlist,
 		ret = evlist__deliver_sample(evlist, tool, de->event,
 					     &orig_sample, evsel, machine);
 
-		if (orig_sample.deferred_callchain)
-			free(orig_sample.callchain);
-
+		perf_sample__exit(&orig_sample);
 		list_del(&de->list);
 		free(de->event);
 		free(de);
@@ -1414,9 +1416,11 @@ static int session__flush_deferred_samples(struct perf_session *session,
 	list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list) {
 		struct perf_sample sample;
 
+		perf_sample__init(&sample, /*all=*/false);
 		ret = evlist__parse_sample(evlist, de->event, &sample);
 		if (ret < 0) {
 			pr_err("failed to parse original sample\n");
+			perf_sample__exit(&sample);
 			break;
 		}
 
@@ -1424,6 +1428,7 @@ static int session__flush_deferred_samples(struct perf_session *session,
 		ret = evlist__deliver_sample(evlist, tool, de->event,
 					     &sample, evsel, machine);
 
+		perf_sample__exit(&sample);
 		list_del(&de->list);
 		free(de->event);
 		free(de);
-- 
2.53.0.959.g497ff81fa9-goog

