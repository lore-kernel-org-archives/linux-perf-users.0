Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C5533CEA8
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196111; cv=none; b=D8pwm9AWK2c3N5jlneR2Qmaa0y9fcalRe5zf74ZA67oXrdG1pNnrTB8NGngra5IkEISxGu/ItvnD/CXAcLbQNA7MXO2pibd2DwHSZnI2ZCbNEd5luCJxErHmnCk0390UHLefcI3oNFTslKCyOCkcAJt0c5yX3Hv1ffZYK9b4fWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196111; c=relaxed/simple;
	bh=nQxMpkfq5Q8mE8JoTONlDnj/0pHVNWmfnSSCyrkIt9o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=re4MNOzauQyhGGnLcl3iFSfqTAvxfKorUuUkf4+IvSJCgYIw4jgUCHTuh0Wv1tFBKYy/SgCMd+YMrlBQEvBOzE8wczEBpuHyz4seY3IeW64eAYyhj8t+ErPbdigB65YoOWPGAn24dDvjOdzmnDQ0HGVv4STr2i5M0uSZcW+KVVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iq9Mq3Yh; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iq9Mq3Yh"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-138404c4b85so4741c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 09:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781196106; x=1781800906; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MDhBC1Y3QwI9bKL6scOv0oXRuRuyEmYvdtDqTHjuBQg=;
        b=iq9Mq3Yh0SEKzGBLSE+qg+JCeEBHYFCfeuzr455Lj3lQjnHVQ1FmCw0vUJQRVqyCGO
         k4vFlDwCD8S0uq5NgzaaPLGPha3EF72MXmmFHTYsoIe8xGw463kg7DJhbSVo0xBFsWsc
         La2F43lV9sMKxa1yJSS8sSlc9anSXurb4Tx4ETKClTMTa/8VD7p6e17q5t2uoDpY7dTz
         o/UjeckQ9PcsAh6o5v7yYcCFZSNFh1HrY78wVKG967CojHolNm4tn9PGCWmdI1zKlm8t
         rT7Nmx1sgmdW13HaZ7eNuWXDCnaU4dXrK8D9BLtPhXKLK4rrmaSHUABpRUlHUjStWUg5
         LbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781196106; x=1781800906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MDhBC1Y3QwI9bKL6scOv0oXRuRuyEmYvdtDqTHjuBQg=;
        b=LzJVDia0nzH/bFi6y/wr/+k9ldcpcfETFMrB93njN3eObzq9EGYxF82tPuazhWAvu7
         NCG7FoS9y0llstJnW93nZYqzV102t8Hp+ICwiUQ5h+XlqGib2iassaFlTxelZam5U/7h
         8vtXSfddxMTIv6pHiajJv64sdXbfM4Nlga5OVVVPSaNHl1udJe1VcinE2lnStHwQgKyh
         rLmc7Wz4U56xXqC56qbG+b4gQiuiFii0ZvAmWOn18pBiHojUWX7m5WA8pUwsIUpBhV5p
         YwX+vi6cEhIqoMul9y0jNzUvzQaJs99RSdoYuMLCoFn8yo2LYY6yeC1EWuX8Im/sFPDh
         Vn+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/eIE9rxK4jolj6fvWKFcznuC0+cOvoenbcr6HX/hvJkwlz7xWQZetCt2NF/OyRmUEwH2wbmOaJ/99Fp5y3DtoD@vger.kernel.org
X-Gm-Message-State: AOJu0Yz19mqnZgP+YFSRqiK8gWaWrMcVDLTRO4rb/gVXEC8iJYfktYJw
	NLqwjWTLV+98dy+53ZOaibWjdVRJk0aUZAAHR6fMTYJeY7TSSXI4Gbfefk5bWJ9ZBe0YBjNPsUb
	aVED/9OSkDw==
X-Received: from dlec3-n2.prod.google.com ([2002:a05:701b:4283:20b0:138:11e7:3ba1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6624:b0:138:4023:8b7
 with SMTP id a92af1059eb24-13842169cc4mr2091986c88.14.1781196105911; Thu, 11
 Jun 2026 09:41:45 -0700 (PDT)
Date: Thu, 11 Jun 2026 09:41:21 -0700
In-Reply-To: <20260611164122.3974068-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260608054841.3856224-1-irogers@google.com> <20260611164122.3974068-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260611164122.3974068-5-irogers@google.com>
Subject: [PATCH v20 4/5] perf aslr: Strip sample registers
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, gmx@google.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Extend the ASLR tool stripping helpers to drop register dump payloads
by masking out the relevant perf_event_attr fields (sample_regs_user,
sample_regs_intr) when the delegated tool is handling the data.

struct aslr_evsel_priv maintains the original perf_event_attr values
and is looked up via the evsel_orig_attrs hashmap so that sample sizes
can be properly parsed even when bits are stripped from the pipeline.
This is critical for bounded array copying within aslr_tool__process_sample,
which relies on orig_sample_type to determine exactly which fields were
captured by the kernel before any stripping occurred.

This allows us to keep samples that would otherwise be dropped because
they contain registers, while still obfuscating the registers.

Co-developed-by: Gabriel Marin <gmx@google.com>
Signed-off-by: Gabriel Marin <gmx@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/builtin-inject.c |  28 +++-
 tools/perf/util/aslr.c      | 263 +++++++++++++++++++++++++++---------
 tools/perf/util/aslr.h      |   9 +-
 3 files changed, 230 insertions(+), 70 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 8bb37095e2de..6d6cce4765a7 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -248,7 +248,7 @@ static int perf_event__repipe_attr(const struct perf_tool *tool,
 		if (!aslr_event)
 			return -ENOMEM;
 		memcpy(aslr_event, event, event->header.size);
-		aslr_tool__strip_attr_event(aslr_event, pevlist);
+		aslr_tool__strip_attr_event(aslr_event, *pevlist);
 		event = aslr_event;
 	}
 
@@ -297,6 +297,7 @@ static int perf_event__repipe_attr(const struct perf_tool *tool,
 	attr.size = sizeof(struct perf_event_attr);
 	attr.sample_type &= ~PERF_SAMPLE_AUX;
 
+
 	if (inject->itrace_synth_opts.add_last_branch) {
 		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
 		attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
@@ -2617,6 +2618,10 @@ static int __cmd_inject(struct perf_inject *inject)
 				evsel->core.attr.exclude_callchain_user = 0;
 			}
 		}
+
+		if (inject->aslr)
+			aslr_tool__strip_evlist(inject->session->tool, session->evlist);
+
 		session->header.data_offset = output_data_offset;
 		session->header.data_size = inject->bytes_written;
 		perf_session__inject_header(session, session->evlist, fd, &inj_fc.fc,
@@ -2875,6 +2880,18 @@ int cmd_inject(int argc, const char **argv)
 	if (zstd_init(&(inject.session->zstd_data), 0) < 0)
 		pr_warning("Decompression initialization failed.\n");
 
+	if (inject.aslr) {
+		struct evsel *evsel;
+
+		evlist__for_each_entry(inject.session->evlist, evsel) {
+			ret = aslr_tool__cache_orig_attrs(tool, evsel);
+			if (ret) {
+				pr_err("Failed to cache original attributes: %d\n", ret);
+				goto out_delete;
+			}
+		}
+	}
+
 	/* Save original section info before feature bits change */
 	ret = save_section_info(&inject);
 	if (ret)
@@ -2893,10 +2910,17 @@ int cmd_inject(int argc, const char **argv)
 		 * the input.
 		 */
 		if (!data.is_pipe) {
+			if (inject.aslr)
+				aslr_tool__strip_evlist(tool, inject.session->evlist);
+
 			ret = perf_event__synthesize_for_pipe(&inject.tool,
 							      inject.session,
 							      &inject.output,
 							      perf_event__repipe);
+
+			if (inject.aslr)
+				aslr_tool__restore_evlist(tool, inject.session->evlist);
+
 			if (ret < 0)
 				goto out_delete;
 		}
@@ -2961,8 +2985,6 @@ int cmd_inject(int argc, const char **argv)
 		goto out_delete;
 
 	ret = __cmd_inject(&inject);
-	if (inject.aslr)
-		aslr_tool__strip_evlist(tool, inject.session->evlist);
 
 	guest_session__exit(&inject.guest_session);
 
diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
index c4602a43e04f..64d447565a1f 100644
--- a/tools/perf/util/aslr.c
+++ b/tools/perf/util/aslr.c
@@ -18,6 +18,7 @@
 #include <internal/lib.h>  /* page_size */
 #include <linux/compiler.h>
 #include <linux/zalloc.h>
+#include <errno.h>
 #include <inttypes.h>
 #include <unistd.h>
 #include <byteswap.h>
@@ -46,6 +47,23 @@ struct aslr_mapping {
 	u64 remap_start;
 };
 
+struct aslr_evsel_priv {
+	u64 orig_sample_type;
+	u64 orig_sample_regs_user;
+	u64 orig_sample_regs_intr;
+	int orig_sample_size;
+};
+
+static size_t evsel_hash(long key, void *ctx __maybe_unused)
+{
+	return (size_t)key;
+}
+
+static bool evsel_equal(long key1, long key2, void *ctx __maybe_unused)
+{
+	return key1 == key2;
+}
+
 struct process_top_address {
 	u64 remapped_max;
 };
@@ -60,6 +78,11 @@ struct aslr_tool {
 	struct hashmap remap_addresses;
 	/** @top_addresses: mapping from process to max remapped address. */
 	struct hashmap top_addresses;
+	/**
+	 * @evsel_orig_attrs: mapping from evsel pointer to its original
+	 *                    unstripped sample_type and registers bitmasks.
+	 */
+	struct hashmap evsel_orig_attrs;
 };
 
 static const pid_t kernel_pid = -1;
@@ -123,6 +146,8 @@ static u64 aslr_tool__remap_address(struct aslr_tool *aslr,
 	u64 *remapped_invariant_ptr = NULL;
 	u64 remap_addr = 0;
 	u8 effective_cpumode = cpumode;
+	struct dso *dso;
+	const char *dso_name;
 
 	if (!aslr_thread)
 		return 0; /* No thread. */
@@ -148,9 +173,15 @@ static u64 aslr_tool__remap_address(struct aslr_tool *aslr,
 		}
 	}
 
+	dso = map__dso(al.map);
+	dso_name = dso ? dso__long_name(dso) : NULL;
+
 	key.machine = maps__machine(thread__maps(aslr_thread));
-	key.dso = map__dso(al.map);
-	key.invariant = map__start(al.map) - map__pgoff(al.map);
+	key.dso = dso;
+	if (dso && !is_anon_memory(dso_name) && !is_no_dso_memory(dso_name))
+		key.invariant = map__start(al.map) - map__pgoff(al.map);
+	else
+		key.invariant = map__start(al.map);
 	key.pid = (effective_cpumode == PERF_RECORD_MISC_KERNEL ||
 		   effective_cpumode == PERF_RECORD_MISC_GUEST_KERNEL) ?
 		  kernel_pid : thread__pid(aslr_thread);
@@ -676,6 +707,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 	struct aslr_tool *aslr;
 	struct perf_tool *delegate;
 	int ret;
+	int orig_sample_size;
 	u64 sample_type;
 	struct thread *thread;
 	struct machine *aslr_machine;
@@ -693,6 +725,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 	u64 orig_regs_user;
 	u64 orig_regs_intr;
 
+
 	del_tool = container_of(tool, struct delegate_tool, tool);
 	aslr = container_of(del_tool, struct aslr_tool, tool);
 	delegate = aslr->tool.delegate;
@@ -703,7 +736,24 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 		return delegate->sample(delegate, event, sample, machine);
 
 	ret = -EFAULT;
-	sample_type = evsel->core.attr.sample_type;
+
+	if (hashmap__find(&aslr->evsel_orig_attrs, evsel, &priv)) {
+		orig_sample_type = priv->orig_sample_type;
+		orig_regs_user = priv->orig_sample_regs_user;
+		orig_regs_intr = priv->orig_sample_regs_intr;
+	} else {
+		orig_sample_type = evsel->core.attr.sample_type;
+		orig_regs_user = evsel->core.attr.sample_regs_user;
+		orig_regs_intr = evsel->core.attr.sample_regs_intr;
+	}
+
+	orig_sample_size = evsel->sample_size;
+
+	sample_type = orig_sample_type;
+	sample_type &= ~PERF_SAMPLE_REGS_USER;
+	sample_type &= ~PERF_SAMPLE_REGS_INTR;
+	sample_type &= ASLR_SUPPORTED_SAMPLE_TYPE;
+
 	max_i = (event->header.size - sizeof(struct perf_event_header)) / sizeof(__u64);
 	max_j = (PERF_SAMPLE_MAX_SIZE - sizeof(struct perf_event_header)) / sizeof(__u64);
 	new_event = (union perf_event *)aslr->event_copy;
@@ -754,11 +804,11 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 		i++; \
 	} while (0)
 
-	if (sample_type & PERF_SAMPLE_IDENTIFIER)
+	if (orig_sample_type & PERF_SAMPLE_IDENTIFIER)
 		COPY_U64(); /* id */
-	if (sample_type & PERF_SAMPLE_IP)
+	if (orig_sample_type & PERF_SAMPLE_IP)
 		REMAP_U64(sample->ip);
-	if (sample_type & PERF_SAMPLE_TID) {
+	if (orig_sample_type & PERF_SAMPLE_TID) {
 		union {
 			u64 val64;
 			u32 val32[2];
@@ -773,19 +823,19 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 		out_array[j++] = u.val64;
 		i++;
 	}
-	if (sample_type & PERF_SAMPLE_TIME)
+	if (orig_sample_type & PERF_SAMPLE_TIME)
 		COPY_U64(); /* time */
-	if (sample_type & PERF_SAMPLE_ADDR)
+	if (orig_sample_type & PERF_SAMPLE_ADDR)
 		REMAP_U64(sample->addr);
-	if (sample_type & PERF_SAMPLE_ID)
+	if (orig_sample_type & PERF_SAMPLE_ID)
 		COPY_U64(); /* id */
-	if (sample_type & PERF_SAMPLE_STREAM_ID)
+	if (orig_sample_type & PERF_SAMPLE_STREAM_ID)
 		COPY_U64(); /* stream_id */
-	if (sample_type & PERF_SAMPLE_CPU)
+	if (orig_sample_type & PERF_SAMPLE_CPU)
 		COPY_U64(); /* cpu, res */
-	if (sample_type & PERF_SAMPLE_PERIOD)
+	if (orig_sample_type & PERF_SAMPLE_PERIOD)
 		COPY_U64(); /* period */
-	if (sample_type & PERF_SAMPLE_READ) {
+	if (orig_sample_type & PERF_SAMPLE_READ) {
 		if ((evsel->core.attr.read_format & PERF_FORMAT_GROUP) == 0) {
 			COPY_U64(); /* value */
 			if (evsel->core.attr.read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
@@ -818,7 +868,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 			}
 		}
 	}
-	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
+	if (orig_sample_type & PERF_SAMPLE_CALLCHAIN) {
 		u64 nr;
 
 		if (CHECK_BOUNDS(1, 1)) {
@@ -884,7 +934,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 			out_array[j++] = addr;
 		}
 	}
-	if (sample_type & PERF_SAMPLE_RAW) {
+	if (orig_sample_type & PERF_SAMPLE_RAW) {
 		size_t bytes = sizeof(u32) + sample->raw_size;
 		size_t u64_words = (bytes + 7) / 8;
 
@@ -903,7 +953,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 		ret = 0;
 		goto out_put;
 	}
-	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
+	if (orig_sample_type & PERF_SAMPLE_BRANCH_STACK) {
 		u64 nr;
 
 		if (CHECK_BOUNDS(1, 1)) {
@@ -944,19 +994,25 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 				COPY_U64();
 		}
 	}
-	if (sample_type & PERF_SAMPLE_REGS_USER) {
+	if (orig_sample_type & PERF_SAMPLE_REGS_USER) {
+		u64 abi;
+
 		if (CHECK_BOUNDS(1, 0)) {
 			ret = -EFAULT;
 			goto out_put;
 		}
-		/* abi */
-		COPY_U64();
-		/* TODO: can this be less conservative? */
-		pr_debug("Dropping regs user sample as possible ASLR leak\n");
-		ret = 0;
-		goto out_put;
+		abi = in_array[i++];
+		if (abi != PERF_SAMPLE_REGS_ABI_NONE) {
+			u64 nr = hweight64(orig_regs_user);
+
+			if (nr > max_i - i) {
+				ret = -EFAULT;
+				goto out_put;
+			}
+			i += nr;
+		}
 	}
-	if (sample_type & PERF_SAMPLE_STACK_USER) {
+	if (orig_sample_type & PERF_SAMPLE_STACK_USER) {
 		u64 size;
 
 		if (CHECK_BOUNDS(1, 1)) {
@@ -986,39 +1042,45 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 		ret = 0;
 		goto out_put;
 	}
-	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE)
+	if (orig_sample_type & PERF_SAMPLE_WEIGHT_TYPE)
 		COPY_U64(); /* perf_sample_weight */
-	if (sample_type & PERF_SAMPLE_DATA_SRC)
+	if (orig_sample_type & PERF_SAMPLE_DATA_SRC)
 		COPY_U64(); /* data_src */
-	if (sample_type & PERF_SAMPLE_TRANSACTION)
+	if (orig_sample_type & PERF_SAMPLE_TRANSACTION)
 		COPY_U64(); /* transaction */
-	if (sample_type & PERF_SAMPLE_REGS_INTR) {
+	if (orig_sample_type & PERF_SAMPLE_REGS_INTR) {
+		u64 abi;
+
 		if (CHECK_BOUNDS(1, 0)) {
 			ret = -EFAULT;
 			goto out_put;
 		}
-		/* abi */
-		COPY_U64();
-		/* TODO: can this be less conservative? */
-		pr_debug("Dropping interrupt register sample as possible ASLR leak\n");
-		ret = 0;
-		goto out_put;
+		abi = in_array[i++];
+		if (abi != PERF_SAMPLE_REGS_ABI_NONE) {
+			u64 nr = hweight64(orig_regs_intr);
+
+			if (nr > max_i - i) {
+				ret = -EFAULT;
+				goto out_put;
+			}
+			i += nr;
+		}
 	}
-	if (sample_type & PERF_SAMPLE_PHYS_ADDR) {
+	if (orig_sample_type & PERF_SAMPLE_PHYS_ADDR) {
 		COPY_U64(); /* phys_addr */
 		/* TODO: can this be less conservative? */
 		pr_debug("Dropping physical address sample as possible ASLR leak\n");
 		ret = 0;
 		goto out_put;
 	}
-	if (sample_type & PERF_SAMPLE_CGROUP)
+	if (orig_sample_type & PERF_SAMPLE_CGROUP)
 		COPY_U64(); /* cgroup */
-	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
+	if (orig_sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
 		COPY_U64(); /* data_page_size */
-	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
+	if (orig_sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
 		COPY_U64(); /* code_page_size */
 
-	if (sample_type & PERF_SAMPLE_AUX) {
+	if (orig_sample_type & PERF_SAMPLE_AUX) {
 		u64 size;
 
 		if (CHECK_BOUNDS(1, 1)) {
@@ -1058,11 +1120,20 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 	}
 
 	new_event->sample.header.size = sizeof(struct perf_event_header) + j * sizeof(u64);
-
+	/* Temporarily override evsel attributes to match the stripped new_event format! */
+	evsel->sample_size = __evsel__sample_size(sample_type);
+	evsel->core.attr.sample_type = sample_type;
+	evsel->core.attr.sample_regs_user = 0;
+	evsel->core.attr.sample_regs_intr = 0;
 	perf_sample__init(&new_sample, /*all=*/ true);
 	ret = __evsel__parse_sample(evsel, new_event, &new_sample, /*needs_swap=*/false);
 
 	if (ret) {
+		/* Restore original attributes immediately if parsing fails */
+		evsel->sample_size = orig_sample_size;
+		evsel->core.attr.sample_type = orig_sample_type;
+		evsel->core.attr.sample_regs_user = orig_regs_user;
+		evsel->core.attr.sample_regs_intr = orig_regs_intr;
 		perf_sample__exit(&new_sample);
 		goto out_put;
 	}
@@ -1071,6 +1142,12 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 	ret = delegate->sample(delegate, new_event, &new_sample, machine);
 	perf_sample__exit(&new_sample);
 
+	/* Restore original attributes so trace ingestion never desynchronizes! */
+	evsel->sample_size = orig_sample_size;
+	evsel->core.attr.sample_type = orig_sample_type;
+	evsel->core.attr.sample_regs_user = orig_regs_user;
+	evsel->core.attr.sample_regs_intr = orig_regs_intr;
+
 out_put:
 	thread__put(thread);
 	return ret;
@@ -1124,15 +1201,22 @@ static int aslr_tool__process_auxtrace_error(const struct perf_tool *tool __mayb
 	return 0;
 }
 
-
-void aslr_tool__strip_attr_event(union perf_event *event, struct evlist **pevlist __maybe_unused)
+void aslr_tool__strip_attr_event(union perf_event *event, struct evlist *evlist)
 {
 	u32 attr_size;
 
+	if (!evlist)
+		return;
+
 	attr_size = event->attr.attr.size ?: PERF_ATTR_SIZE_VER0;
 
 	if (attr_size >= (offsetof(struct perf_event_attr, sample_type) + sizeof(u64))) {
 		event->attr.attr.sample_type &= ASLR_SUPPORTED_SAMPLE_TYPE;
+
+		if (attr_size >= (offsetof(struct perf_event_attr, sample_regs_user) + sizeof(u64)))
+			event->attr.attr.sample_regs_user = 0;
+		if (attr_size >= (offsetof(struct perf_event_attr, sample_regs_intr) + sizeof(u64)))
+			event->attr.attr.sample_regs_intr = 0;
 	}
 
 	if (attr_size >= (offsetof(struct perf_event_attr, type) + sizeof(u32))) {
@@ -1156,28 +1240,6 @@ void aslr_tool__strip_attr_event(union perf_event *event, struct evlist **pevlis
 	}
 }
 
-void aslr_tool__strip_evlist(struct perf_tool *tool __maybe_unused,
-			     struct evlist *evlist)
-{
-	struct evsel *evsel;
-
-	evlist__for_each_entry(evlist, evsel) {
-		evsel->core.attr.sample_type &= ASLR_SUPPORTED_SAMPLE_TYPE;
-
-		if (evsel->core.attr.type == PERF_TYPE_BREAKPOINT)
-			evsel->core.attr.bp_addr = 0;
-		else if (evsel->core.attr.type >= PERF_TYPE_MAX) {
-			struct perf_pmu *pmu = perf_pmus__find_by_type(evsel->core.attr.type);
-
-			if (pmu && (!strcmp(pmu->name, "kprobe") ||
-				    !strcmp(pmu->name, "uprobe"))) {
-				evsel->core.attr.config1 = 0;
-				evsel->core.attr.config2 = 0;
-			}
-		}
-	}
-}
-
 static void aslr_tool__init(struct aslr_tool *aslr, struct perf_tool *delegate)
 {
 	delegate_tool__init(&aslr->tool, delegate);
@@ -1191,6 +1253,9 @@ static void aslr_tool__init(struct aslr_tool *aslr, struct perf_tool *delegate)
 	hashmap__init(&aslr->top_addresses,
 		      top_addresses__hash, top_addresses__equal,
 		      /*ctx=*/NULL);
+	hashmap__init(&aslr->evsel_orig_attrs,
+		      evsel_hash, evsel_equal,
+		      /*ctx=*/NULL);
 
 	aslr->tool.tool.sample	= aslr_tool__process_sample;
 	/* read - reads a counter, okay to delegate. */
@@ -1253,9 +1318,13 @@ void aslr_tool__delete(struct perf_tool *tool)
 		zfree(&cur->pkey);
 		zfree(&cur->pvalue);
 	}
+	hashmap__for_each_entry(&aslr->evsel_orig_attrs, cur, bkt) {
+		zfree(&cur->pvalue);
+	}
 
 	hashmap__clear(&aslr->remap_addresses);
 	hashmap__clear(&aslr->top_addresses);
+	hashmap__clear(&aslr->evsel_orig_attrs);
 	aslr_tool__destroy_machines_priv(&aslr->machines);
 	machines__destroy_kernel_maps(&aslr->machines);
 
@@ -1269,3 +1338,69 @@ void aslr_tool__delete(struct perf_tool *tool)
 	machines__exit(&aslr->machines);
 	free(aslr);
 }
+
+int aslr_tool__cache_orig_attrs(struct perf_tool *tool, struct evsel *evsel)
+{
+	struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool);
+	struct aslr_tool *aslr = container_of(del_tool, struct aslr_tool, tool);
+	struct aslr_evsel_priv *priv = zalloc(sizeof(*priv));
+	int err;
+
+	if (!priv)
+		return -ENOMEM;
+
+	priv->orig_sample_type = evsel->core.attr.sample_type;
+	priv->orig_sample_regs_user = evsel->core.attr.sample_regs_user;
+	priv->orig_sample_regs_intr = evsel->core.attr.sample_regs_intr;
+	priv->orig_sample_size = evsel->sample_size;
+
+	err = hashmap__add(&aslr->evsel_orig_attrs, evsel, priv);
+	if (err) {
+		free(priv);
+		return err;
+	}
+	return 0;
+}
+
+void aslr_tool__strip_evlist(const struct perf_tool *tool __maybe_unused, struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		evsel->core.attr.sample_type &= ASLR_SUPPORTED_SAMPLE_TYPE;
+		evsel->core.attr.sample_regs_user = 0;
+		evsel->core.attr.sample_regs_intr = 0;
+		evsel->sample_size = __evsel__sample_size(evsel->core.attr.sample_type);
+		evsel__calc_id_pos(evsel);
+
+		if (evsel->core.attr.type == PERF_TYPE_BREAKPOINT) {
+			evsel->core.attr.bp_addr = 0;
+		} else if (evsel->core.attr.type >= PERF_TYPE_MAX) {
+			struct perf_pmu *pmu = perf_pmus__find_by_type(evsel->core.attr.type);
+
+			if (pmu && (!strcmp(pmu->name, "kprobe") ||
+				    !strcmp(pmu->name, "uprobe"))) {
+				evsel->core.attr.config1 = 0;
+				evsel->core.attr.config2 = 0;
+			}
+		}
+	}
+}
+
+void aslr_tool__restore_evlist(const struct perf_tool *tool, struct evlist *evlist)
+{
+	const struct delegate_tool *del_tool = container_of(tool, const struct delegate_tool, tool);
+	const struct aslr_tool *aslr = container_of(del_tool, const struct aslr_tool, tool);
+	struct evsel *evsel;
+	struct aslr_evsel_priv *priv;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (hashmap__find(&aslr->evsel_orig_attrs, evsel, &priv)) {
+			evsel->core.attr.sample_type = priv->orig_sample_type;
+			evsel->core.attr.sample_regs_user = priv->orig_sample_regs_user;
+			evsel->core.attr.sample_regs_intr = priv->orig_sample_regs_intr;
+			evsel->sample_size = priv->orig_sample_size;
+			evsel__calc_id_pos(evsel);
+		}
+	}
+}
diff --git a/tools/perf/util/aslr.h b/tools/perf/util/aslr.h
index 2b82f711bc67..522e31c8e2c0 100644
--- a/tools/perf/util/aslr.h
+++ b/tools/perf/util/aslr.h
@@ -34,8 +34,11 @@ struct evlist;
 union perf_event;
 
 struct perf_tool *aslr_tool__new(struct perf_tool *delegate);
-void aslr_tool__delete(struct perf_tool *aslr);
-void aslr_tool__strip_attr_event(union perf_event *event, struct evlist **pevlist);
-void aslr_tool__strip_evlist(struct perf_tool *tool, struct evlist *evlist);
+void aslr_tool__delete(struct perf_tool *tool);
+
+void aslr_tool__strip_attr_event(union perf_event *event, struct evlist *evlist);
+int aslr_tool__cache_orig_attrs(struct perf_tool *tool, struct evsel *evsel);
+void aslr_tool__strip_evlist(const struct perf_tool *tool, struct evlist *evlist);
+void aslr_tool__restore_evlist(const struct perf_tool *tool, struct evlist *evlist);
 
 #endif /* __PERF_ASLR_H */
-- 
2.54.0.1099.g489fc7bff1-goog

