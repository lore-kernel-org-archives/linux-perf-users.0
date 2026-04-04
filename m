Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A41330B3B
	for <linux-perf-users@vger.kernel.org>; Sat,  4 Apr 2026 03:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775274222; cv=none; b=szyE5wfMg0D6MhONdGfuuAzGlLM6z9RO21pfNa905b0E9m/hEynVALM+OHEHSszHzNzvq86hhbvYXOl642aoocXDUaYGc2ArNY6okd9vS8hj+lsbhNX/bwtsX+XPWGEf68V/rZ//QH6IX7Vh90B5CYdglYR8L+F34A9w5hl9OgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775274222; c=relaxed/simple;
	bh=XxJjf4fEXEx+i4A4Cly0amFYTUzF0E8GUbx7yzl2BQ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bUPBxl/btJ9T4JI4OTU8WpNlaVof0RgHn3G4CmFf0SAhMbKlzmJq2vFuObY5AXVhSGbljgTmAZHIKbrPA2RavdzAfE2XOfOXn66ZclR0OfR3KtkazgEuaTCUpJSNb9n37yqdF1kynHMob7JWVsv3h8f4hGzJ5L1MDh7nCw6sUGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XEorRrZK; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XEorRrZK"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bda35eab74so2764912eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 20:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775274219; x=1775879019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t8d/eNKZCOxSFQtfh8z2A6Tanb/X7MRyyQglbaRxPQQ=;
        b=XEorRrZKCG+Orh+/rezDfxmpLGCsdTshWcwv1jDJ8NW1hUFAwPX/kWQUxV9oGFQ9zF
         90AGS7E8TLvE2tbsTPh2+q88Qc43t2t7/yyg87acUcPLzO3VQXXYe6GarWmrQFw6W+XK
         6vATC47jLZgmMIuXSEaizo8woTG4XDg1EbwTMHoi2JA5dTcarS9R94kQ/q3DmKxdRIwj
         +Fz3D63/gHRPcaKMh4owDTD5dMdIwXh1GOJaThVTjAGmGg2//zMKjA7MqE3YZfoqFB27
         svwMFaJRaXwGqazbtiXCsp8FJ19oPK9/fLt/rD+RJnAY4oiPs3U4FuaUhZ2Cj1IVZeZi
         AjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775274219; x=1775879019;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8d/eNKZCOxSFQtfh8z2A6Tanb/X7MRyyQglbaRxPQQ=;
        b=bE6Y3jO67u9QACibtAJA7Pomjr/4xN1RsdIFXqegRvDLhTjv0RAPPauCLGh30x0qSR
         YXQIsXtZF7xYmRxCy6WhhofwzXsf8ijnGhe7xCd4yI/uDA7c6Spl7eKM7PUBYwNxM/nD
         kfWcaceNrZgOnnOzGKmvlckv7mqxQVv8RpXF7P1KQcUTArGSw3Svpwu86eW0UjdIxBxG
         Emjf+9n5spmRE4Nri86Jt2cUzmvY4TwlEBe7FBo4egQ7KK31Tlzl+N/vrxaSMXiYIMM5
         HNxp9z6acfe7YzX2mK2tUoyyPmLTKxtsbBaPzmCP2vD7RXwEcW3s4NEUi2kEyctS7TY/
         feLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI+iR+lNdphQW5502HqdmdBL7B/hXTC+LPGCuaGakrUZh0JyoEgZaeRSrQ1OOXdAuMjeZVX7ywlBFkFoDcY4L8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/qEvAw9Dom6hqS3Oxw87089zC8fxCA6Pt+0+8GgI+oaqmg4eC
	n2SAZXTwlsk7eZ6P90guG6yc1XC7v7AAKKj0YOByp9w12A4oxvOAGUV618aJ90s14wfRnNspukk
	YvBWwzJT97w==
X-Received: from dlbsw11.prod.google.com ([2002:a05:7022:3a8b:b0:128:d5fb:9499])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4591:b0:12a:6abf:ab1c
 with SMTP id a92af1059eb24-12bfaf4e6b7mr2106270c88.11.1775274219211; Fri, 03
 Apr 2026 20:43:39 -0700 (PDT)
Date: Fri,  3 Apr 2026 20:43:02 -0700
In-Reply-To: <20260404034325.3172592-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403204017.2919994-1-irogers@google.com> <20260404034325.3172592-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260404034325.3172592-3-irogers@google.com>
Subject: [PATCH v6 02/25] perf sample: Make sure perf_sample__init/exit are used
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

Similarly guest_session__inject_events in builtin-inject wasn't using
perf_sample_init/exit. The lifetime management for fetched events is
somewhat complex there, but when an event is fetched the sample should
be initialized and needs exiting on error. The sample may be left in
place so that future injects have access to it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c        | 55 +++++++++++++++++++++---------
 tools/perf/tests/perf-record.c     |  1 +
 tools/perf/tests/switch-tracking.c |  2 ++
 tools/perf/util/callchain.c        | 10 ++++--
 tools/perf/util/evlist.c           |  5 ++-
 tools/perf/util/evsel.c            | 34 +++++++++++-------
 tools/perf/util/powerpc-vpadtl.c   | 10 +++---
 tools/perf/util/sample.c           | 10 ++++--
 tools/perf/util/sample.h           | 17 +++++----
 tools/perf/util/session.c          | 13 ++++---
 10 files changed, 108 insertions(+), 49 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 5b29f4296861..d63191ae4c5b 100644
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
 
@@ -1648,6 +1651,7 @@ static int guest_session__fetch(struct guest_session *gs)
 	size_t hdr_sz = sizeof(*hdr);
 	ssize_t ret;
 
+	perf_sample__init(&gs->ev.sample, /*all=*/false);
 	buf = gs->ev.event_buf;
 	if (!buf) {
 		buf = malloc(PERF_SAMPLE_MAX_SIZE);
@@ -1745,18 +1749,24 @@ static int guest_session__inject_events(struct guest_session *gs, u64 timestamp)
 		if (!gs->fetched) {
 			ret = guest_session__fetch(gs);
 			if (ret)
-				return ret;
+				break;
 			gs->fetched = true;
 		}
 
 		ev = gs->ev.event;
 		sample = &gs->ev.sample;
 
-		if (!ev->header.size)
-			return 0; /* EOF */
-
-		if (sample->time > timestamp)
-			return 0;
+		if (!ev->header.size) {
+			/* EOF */
+			perf_sample__exit(&gs->ev.sample);
+			gs->fetched = false;
+			ret = 0;
+			break;
+		}
+		if (sample->time > timestamp) {
+			ret = 0;
+			break;
+		}
 
 		/* Change cpumode to guest */
 		cpumode = ev->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
@@ -1779,12 +1789,14 @@ static int guest_session__inject_events(struct guest_session *gs, u64 timestamp)
 
 		if (id_hdr_size & 7) {
 			pr_err("Bad id_hdr_size %u\n", id_hdr_size);
-			return -EINVAL;
+			ret = -EINVAL;
+			break;
 		}
 
 		if (ev->header.size & 7) {
 			pr_err("Bad event size %u\n", ev->header.size);
-			return -EINVAL;
+			ret = -EINVAL;
+			break;
 		}
 
 		/* Remove guest id sample */
@@ -1792,14 +1804,16 @@ static int guest_session__inject_events(struct guest_session *gs, u64 timestamp)
 
 		if (ev->header.size & 7) {
 			pr_err("Bad raw event size %u\n", ev->header.size);
-			return -EINVAL;
+			ret = -EINVAL;
+			break;
 		}
 
 		guest_id = guest_session__lookup_id(gs, id);
 		if (!guest_id) {
 			pr_err("Guest event with unknown id %llu\n",
 			       (unsigned long long)id);
-			return -EINVAL;
+			ret = -EINVAL;
+			break;
 		}
 
 		/* Change to host ID to avoid conflicting ID values */
@@ -1819,19 +1833,28 @@ static int guest_session__inject_events(struct guest_session *gs, u64 timestamp)
 		/* New id sample with new ID and CPU */
 		ret = evlist__append_id_sample(inject->session->evlist, ev, sample);
 		if (ret)
-			return ret;
+			break;
 
 		if (ev->header.size & 7) {
 			pr_err("Bad new event size %u\n", ev->header.size);
-			return -EINVAL;
+			ret = -EINVAL;
+			break;
 		}
 
-		gs->fetched = false;
-
 		ret = output_bytes(inject, ev, ev->header.size);
 		if (ret)
-			return ret;
+			break;
+
+		/* Reset for next guest session event fetch. */
+		perf_sample__exit(sample);
+		gs->fetched = false;
 	}
+	if (ret && gs->fetched) {
+		/* Clear saved sample state on error. */
+		perf_sample__exit(&gs->ev.sample);
+		gs->fetched = false;
+	}
+	return ret;
 }
 
 static int guest_session__flush_events(struct guest_session *gs)
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index c6e31ab8a6b8..ad44cc68820b 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -300,6 +300,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
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
index f879b84f8ff9..f031cbbeeba8 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1901,16 +1901,19 @@ int sample__merge_deferred_callchain(struct perf_sample *sample_orig,
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
@@ -1919,6 +1922,7 @@ int sample__merge_deferred_callchain(struct perf_sample *sample_orig,
 	memcpy(&callchain->ips[nr_orig], sample_callchain->callchain->ips,
 	       nr_deferred * sizeof(u64));
 
+	sample_orig->merged_callchain = true;
 	sample_orig->callchain = callchain;
 	return 0;
 }
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c702741a9173..f46e1d40bad7 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1632,8 +1632,11 @@ int evlist__parse_sample(struct evlist *evlist, union perf_event *event, struct
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
index 1281af056cec..df2392713edb 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3073,7 +3073,7 @@ static inline bool overflow(const void *endp, u16 max_size, const void *offset,
 #define OVERFLOW_CHECK(offset, size, max_size)				\
 	do {								\
 		if (overflow(endp, (max_size), (offset), (size)))	\
-			return -EFAULT;					\
+			goto out_efault;				\
 	} while (0)
 
 #define OVERFLOW_CHECK_u64(offset) \
@@ -3205,6 +3205,8 @@ static int __set_offcpu_sample(struct perf_sample *data)
 	data->cgroup = *array;
 
 	return 0;
+out_efault:
+	return -EFAULT;
 }
 
 int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
@@ -3223,7 +3225,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	 */
 	union u64_swap u;
 
-	memset(data, 0, sizeof(*data));
+	perf_sample__init(data, /*all=*/true);
 	data->cpu = data->pid = data->tid = -1;
 	data->stream_id = data->id = data->time = -1ULL;
 	data->period = evsel->core.attr.sample_period;
@@ -3237,25 +3239,26 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 
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
@@ -3348,7 +3351,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 					sizeof(struct sample_read_value);
 
 			if (data->read.group.nr > max_group_nr)
-				return -EFAULT;
+				goto out_efault;
 
 			sz = data->read.group.nr * sample_read_value_size(read_format);
 			OVERFLOW_CHECK(array, sz, max_size);
@@ -3376,7 +3379,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		data->callchain = (struct ip_callchain *)array++;
 		callchain_nr = data->callchain->nr;
 		if (callchain_nr > max_callchain_nr)
-			return -EFAULT;
+			goto out_efault;
 		sz = callchain_nr * sizeof(u64);
 		/*
 		 * Save the cookie for the deferred user callchain.  The last 2
@@ -3434,7 +3437,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		data->branch_stack = (struct branch_stack *)array++;
 
 		if (data->branch_stack->nr > max_branch_nr)
-			return -EFAULT;
+			goto out_efault;
 
 		sz = data->branch_stack->nr * sizeof(struct branch_entry);
 		if (evsel__has_branch_hw_idx(evsel)) {
@@ -3511,7 +3514,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			data->user_stack.size = *array++;
 			if (WARN_ONCE(data->user_stack.size > sz,
 				      "user stack dump failure\n"))
-				return -EFAULT;
+				goto out_efault;
 		}
 	}
 
@@ -3588,10 +3591,15 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
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
index 3a911c70cd0e..53fb2e628b71 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1374,14 +1374,18 @@ static int evlist__deliver_deferred_callchain(struct evlist *evlist,
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
@@ -1392,9 +1396,7 @@ static int evlist__deliver_deferred_callchain(struct evlist *evlist,
 		ret = evlist__deliver_sample(evlist, tool, de->event,
 					     &orig_sample, evsel, machine);
 
-		if (orig_sample.deferred_callchain)
-			free(orig_sample.callchain);
-
+		perf_sample__exit(&orig_sample);
 		list_del(&de->list);
 		free(de->event);
 		free(de);
@@ -1421,9 +1423,11 @@ static int session__flush_deferred_samples(struct perf_session *session,
 	list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list) {
 		struct perf_sample sample;
 
+		perf_sample__init(&sample, /*all=*/false);
 		ret = evlist__parse_sample(evlist, de->event, &sample);
 		if (ret < 0) {
 			pr_err("failed to parse original sample\n");
+			perf_sample__exit(&sample);
 			break;
 		}
 
@@ -1431,6 +1435,7 @@ static int session__flush_deferred_samples(struct perf_session *session,
 		ret = evlist__deliver_sample(evlist, tool, de->event,
 					     &sample, evsel, machine);
 
+		perf_sample__exit(&sample);
 		list_del(&de->list);
 		free(de->event);
 		free(de);
-- 
2.53.0.1213.gd9a14994de-goog

