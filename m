Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9418736EA86
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 08:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994125; cv=none; b=TcFkD2KcWex2JZTaDf+Sv/o3vPA/DMvZvki2PypbxqVP+YeL13i9UzjBx3cZ4x5LMtuXaZENRzj33M6+K/Yj1yjND6OmgxTqNOd5R6Hg8Fpw/8nAMJOIYj2ReBHUKx67JeFOo7v/1obPIMEs9mVu2UzyStc9ONLBcYi2d8Ag7lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994125; c=relaxed/simple;
	bh=Xzwaqi3MxVB5LpRoNQFpF/Z6vm7FRECCofxyYpuLxZU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FFx7d5gwNd+DhlwwhpC4VhbBUtESkh4l2TnI24N1cvHc0azOYUJpk4Txucv3QBDaFRJ04fi7hKwk5ghEISuSAA6i6hkq8FKBcqJ38XLZfDB73uywjWCnAWcxH0bKbePDpKYSy7I363iTQNGIfq6HMfExLUkt0GIdICvGyDc2Uy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Aefa2CFz; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aefa2CFz"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-128edc72e5bso5140180c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 01:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773994123; x=1774598923; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oLP4P0VKTFn8urqrVdMPV2/KnVjsudXkFiUT5GUddZQ=;
        b=Aefa2CFzFJJUuPqKsWeOXLoGISTrrzObb7yipWWeTyBgnL+nO7ShSlOdX1yJ3A8mT5
         yqoLIKxXjJqZVSwNcHee5i5ANfaVbYLZNUdhHf2KT3UY+Da5yqLjmqbCfQtkDJeOestb
         8JOL34wy+cRpJ0Tru5OBKt+VsDkWHNZgk7WVD/dtKS3+ZZ4urQvMIgMC5N6zUtAWAwX6
         Mmx1cbnS3P+Nq9fdENNRdAJanMM+ZgS0NmFj1hnk3Ju/dZV4EQHW8nlLbnZHOLSfvcYx
         73G4LtvoMh5QbcqhC8tTj9UGOlQVeUz9357cIqEkElID8zP9ICpIjZI4ZTIL4WBAdrjq
         I3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773994123; x=1774598923;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLP4P0VKTFn8urqrVdMPV2/KnVjsudXkFiUT5GUddZQ=;
        b=HisIzpBSqYieC7TO2GbUk6DWZK8WN4Or7KCc5bInX+BT35evYVTb+n6pHegfCMIwqS
         WlCsVAHU4vZ0XrsJGrFGXZ/qGAXtxfsXzmskqtEf5bzzv2omLlY09sYi627pXqe5r5qV
         Y2Mj81EFfJacYSeHEoTB3knESvvWf06ld1RVuUjzPEGlJ3Nt9g6Am9Yg2fZP/6g6NR2S
         lAVHsLsQ6tyKJG8T8uIn3rfCZtJ179nZIR7MD7d7lXhZ8cQ+2f+sau80WJ+RyVP8CNcR
         4B73nk86rjwl9zd87auvfAk9z0Ko8RxberIsMUm0ZFsiYPu/7jLIJyOaAhsxO61KDOTy
         2YpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI4sGjoCINM70ZCbgHZFmSwlm680tnXYTP5pi6Ukz5dElUNRMclC54BaNiHt9Z7u+Yiu1jX6fnX5N5TeEvyzNK@vger.kernel.org
X-Gm-Message-State: AOJu0YwVgmh6aWLhWIRlA3VWfAlPxN1cm8HSDEalJPilfO0kIjzx5NfI
	O4IWCclocNg2Lb9qImkCsuYM1LyTRc8lHQAg7JUEuzyrZJqUSCMyyyDIDgyFaGtQegNSPt+XCpA
	o0dQPOqoWRw==
X-Received: from dlad15.prod.google.com ([2002:a05:701b:220f:b0:12a:6cae:e730])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:603:b0:128:d5f1:d593
 with SMTP id a92af1059eb24-12a7266c6dfmr1000463c88.1.1773994122455; Fri, 20
 Mar 2026 01:08:42 -0700 (PDT)
Date: Fri, 20 Mar 2026 01:08:11 -0700
In-Reply-To: <20260320080835.724836-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319232334.287517-1-irogers@google.com> <20260320080835.724836-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320080835.724836-3-irogers@google.com>
Subject: [PATCH v3 02/25] perf sample: Make sure perf_sample__init/exit are used
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
 tools/perf/builtin-inject.c      |  5 ++++-
 tools/perf/util/callchain.c      |  1 +
 tools/perf/util/evlist.c         |  5 ++++-
 tools/perf/util/evsel.c          | 34 ++++++++++++++++++++------------
 tools/perf/util/powerpc-vpadtl.c | 10 ++++++----
 tools/perf/util/sample.c         | 10 ++++++++--
 tools/perf/util/sample.h         | 17 ++++++++++------
 tools/perf/util/session.c        | 13 ++++++++----
 8 files changed, 64 insertions(+), 31 deletions(-)

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
 
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 8ff0898799ee..94ae45fd1f27 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1872,6 +1872,7 @@ int sample__merge_deferred_callchain(struct perf_sample *sample_orig,
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
index d1c3396f182f..d1c1b8a59e07 100644
--- a/tools/perf/util/powerpc-vpadtl.c
+++ b/tools/perf/util/powerpc-vpadtl.c
@@ -182,7 +182,9 @@ static int powerpc_vpadtl_sample(struct powerpc_vpadtl_entry *record,
 {
 	struct perf_sample sample;
 	union perf_event event;
+	int ret;
 
+	perf_sample__init(&sample, /*all=*/false);
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

