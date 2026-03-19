Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7F64014B1
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 23:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773962646; cv=none; b=LKGR58u8j27WHZSXMQinlCKtwf/qnwVKf4CZdfR1yzK97hzzthc1gEZ12VSmEGTyX8ANtGkkU8P+uQ47anaM/7+2dRMT2BxR9PLc0VOitSyE9efmXQ2+JySnBkfeelCP4WGvCBwMVkr6sIz3TAQLYupcAdEp0bFID81+aFVmukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773962646; c=relaxed/simple;
	bh=da9kZFbgZ2WPtd5VACLt5Kz4GVNFk2cHHuwtri+vAe4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PggmUJ7drGrWDOBYgbLtGMN6VDhNEzYMBIPXqxMrMPSIlNVIu7jTt4H140VaOVwl/07u29+KT+Wou9CsLty9pC85I1VznwdbRANKVfu7Sk6Akv7URpgL5kqAqOXvanxnELIwechKIwrffp0n7LknxTbb3KFq2Gb71i2T2i3SzEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l5DD8QZR; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l5DD8QZR"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35ba237d2a1so1197053a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 16:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773962644; x=1774567444; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rxFBTP7Uc7XGPsqUW2Y55ItggKIIf/Ou02Qa4BUhgvs=;
        b=l5DD8QZRQFKVbndhNMQSpf6/SAy0CyMV/893i3hTSxIeknmgbpf4CeQLfJPTKrdj4/
         nL8lIjaQL5I9MVc6eDoivMJiOAfll7+aixK2LtPMM7a8rzfO5RC8RoGJBcn0pRduuP7N
         hwgPNP18U0yGoAhglxQ8fjfSksGutwZe7uDOEHRI4a8xdkYxkcH6QTpmkJ5htEotTInV
         GiC7xXkJkt1nq03v8o6i6hvrdFTm/yCDoGu6RB3WvGnQf1yyOXHe5FzPeiwOdoy4vZoy
         j3Ax9YDb4hU4c6upp4QPqbcQpNotm4AHdL4QwW/zSD+7ri5fHcIUalJlJTZFRKU6dsuk
         RsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773962644; x=1774567444;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rxFBTP7Uc7XGPsqUW2Y55ItggKIIf/Ou02Qa4BUhgvs=;
        b=jr5FCbX8qmmGIqpArXegiXnnj+T7BDdn/tq1TlJ9yhyAGNqbK6joF0GXy1/epulLZS
         DdA42OozgrwFfeag9KRJJEqWJE6OXayTAxrB5HNGSjBr04u8MFp9yxVwNQZjybqqkdnH
         1PtF6qUwnnLOOkb4MVbEe32nxVqAEjoL3QStQSas+KA3v3c1XUZzyA/VOCSq7W9+SVlV
         0/Yyr1kC1jV5fgmuxIefhZeGeJ/wMEMfN7Rvrr0e/BhD4DoRTovKgKZdkYYvbSjrYW8z
         8A/FDbxVa1mWu+f+i27MgAC6ICfdEhoUmQBBOiFhzLmYqBlvXeTHYCV0a52R5dchzDgd
         Ta1g==
X-Forwarded-Encrypted: i=1; AJvYcCWfsLe0iY6be1veSmgeD27YcTHz7Js0MxdKtp+JhIlVy1wQVWCWK4IxSSGuHjuE9CQ7GdPs7DEJ6+MwmBfZGASD@vger.kernel.org
X-Gm-Message-State: AOJu0YwSpRMDVKSByhykptv9HciAfvQ7pa/q81pLuAIEwFBU7xfXfaJk
	nW51PL9QRVsRLAqJFPXigjxYHJRKWZODaTL4YXuBnyvMojE7bVGK3n0oNKi/1w15jp4UJFhbwN+
	rEsMvoca5+g==
X-Received: from pjuf2.prod.google.com ([2002:a17:90a:ce02:b0:35b:9e0a:de3f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a8a:b0:35b:9ab6:1d59
 with SMTP id 98e67ed59e1d1-35bd27f16abmr650514a91.13.1773962644102; Thu, 19
 Mar 2026 16:24:04 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:23:11 -0700
In-Reply-To: <20260319232334.287517-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com> <20260319232334.287517-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260319232334.287517-3-irogers@google.com>
Subject: [PATCH v2 02/25] perf sample: Make sure perf_sample__init/exit are used
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
zfree. Make the error paths in evsel__parse_sample exit the sample.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c |  5 ++++-
 tools/perf/util/evlist.c    |  5 ++++-
 tools/perf/util/evsel.c     | 28 +++++++++++++++++-----------
 tools/perf/util/sample.c    | 10 ++++++++--
 tools/perf/util/session.c   | 13 +++++++++----
 5 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 5b29f4296861..039323908ebf 100644
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
index f59228c1a39e..34ae388750db 100644
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
 
@@ -3586,6 +3589,9 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		return __set_offcpu_sample(data);
 
 	return 0;
+out_efault:
+	perf_sample__exit(data);
+	return -EFAULT;
 }
 
 int evsel__parse_sample_timestamp(struct evsel *evsel, union perf_event *event,
diff --git a/tools/perf/util/sample.c b/tools/perf/util/sample.c
index 8f82aaf1aab6..b04cbad7edd3 100644
--- a/tools/perf/util/sample.c
+++ b/tools/perf/util/sample.c
@@ -21,13 +21,19 @@ void perf_sample__init(struct perf_sample *sample, bool all)
 	} else {
 		sample->user_regs = NULL;
 		sample->intr_regs = NULL;
+		sample->deferred_callchain = false;
+		sample->callchain = NULL;
 	}
 }
 
 void perf_sample__exit(struct perf_sample *sample)
 {
-	free(sample->user_regs);
-	free(sample->intr_regs);
+	zfree(&sample->user_regs);
+	zfree(&sample->intr_regs);
+	if (sample->deferred_callchain) {
+		zfree(&sample->callchain);
+		sample->deferred_callchain = false;
+	}
 }
 
 struct regs_dump *perf_sample__user_regs(struct perf_sample *sample)
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

