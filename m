Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637CC2BEFEF
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jun 2026 06:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780812592; cv=none; b=l8E6bE65ZQtHycJKK+zGU3dWtVUfwhEpZUOCLt3LUcNazJvWKKJvRPfjzqKGNHRz5GczSY/ZPHDvfQy4BoG4uBMGN3AnXbmf+UcYouwbwtTL4caek9sHRfhdoT/8ZUIVoV4AFVwFoVo0van3GaJ7pLu242K1TJftalhaa8yG9gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780812592; c=relaxed/simple;
	bh=LbxPX3RK3xKQvilXloixSPdh6R6LtLqwYJO6eIXRYYo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nV+D82TrSqOhWGxnsI59m383VPjkPy72uVI9VMQM2W/cHtUrRDSG+OPJgmX1XSXS/NU9pzNhPwyzpf9ZvoKYO+hEEdSoS8dS+ke5W31YupVzgKnDX8i+nKClQwzJHAzKVYLPZYLxjabaCKdKCaEAugDrk9lM6AjbhcWMgfNe13Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ThhxXOZN; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ThhxXOZN"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137f304f564so10051409c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Jun 2026 23:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780812589; x=1781417389; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hx2DG5WauOo+yIqQVIuWzkn1WMI2lmLkmH4M5tYdDjU=;
        b=ThhxXOZNxjkvtx74B4rx6t8lz0hd1P+2rVXt039YIpuof3/uVf/7dWap1XtcEWwgYo
         xBri/KOAF0s0k7Iuxn5Zn33M4YJB7u8ERdQ0jbC/ZcJBJFVPRnrAVoUXPsp0iKnKA7OC
         ux7ur2Eqv1SaKWGZUJ+x2udjNxtt1kbeBLhe4/0GEQx8IIJ1fV9YLiJye4n0zrp29fDQ
         +sKDZwi2i7w9U7pRUogpoHr+rvHq0rZroCS5F1gHy0KLJP6yaiGDDIOSWELgGLVmzYjA
         2vFVUM8cnVRdxybY68iqfTKSk/hbojnnkVvhuwlESTwqI5McjMg6AfFaqwYMdZNkXarc
         JL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780812589; x=1781417389;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hx2DG5WauOo+yIqQVIuWzkn1WMI2lmLkmH4M5tYdDjU=;
        b=QQTH+KtcZO/VeDVKJSS/9pM82LWrTWoSRTfEF0aw2fAUQCV7qgRa0KFFsxxUyBlrqr
         BgRWsv/kebsVouuBI18ImOe4mMLjfFEY03A/1r6sSGbSJSLY3k60fcYNy4uEc3eyJrmS
         C/glcCegfNPW4DfvAeDvWE1YadZKknUxgqUyEPSsWOArMQYm9lDYpeucHULOrp92k/i6
         /Lmk9erHNSSoyojpu0KUUFASZJp7tQYR3SvfknpwdoDf00hxxebolnwFa2uN/EClOF7B
         EHufaZVI06qYIiwt4u23YT2Zs3GfBBjulvfPgo56TJCu14JoHwnZyEOItp9PSOtqEl6N
         /Afw==
X-Forwarded-Encrypted: i=1; AFNElJ9N5pUnyXNW4tAYUVwYk/oeFSTzk412uQWPCq35YiK3ZNtHCXCrSKBvx12H2e7pjlgS1EJqgNbESNl/UHF/6+KI@vger.kernel.org
X-Gm-Message-State: AOJu0YxSX3WpBpr/e9XQij4TQmucuJmkoeY4oWTzLzGykwi2v8XsCmt/
	dlTEl/jtYqv1ugCvaHFVuG68yPcdup5bJ7DHkcUw1ZS29EieCRe596/jZBjxZxUdeU0k8tWWBf/
	lf9kUtCurQQ==
X-Received: from dldoa11.prod.google.com ([2002:a05:701a:ca8b:b0:137:fdb1:854c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:684:b0:132:2486:acb
 with SMTP id a92af1059eb24-138066a7a18mr5411581c88.12.1780812589260; Sat, 06
 Jun 2026 23:09:49 -0700 (PDT)
Date: Sat,  6 Jun 2026 23:09:32 -0700
In-Reply-To: <20260607060933.3274263-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260606151451.2913860-1-irogers@google.com> <20260607060933.3274263-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260607060933.3274263-5-irogers@google.com>
Subject: [PATCH v17 4/5] perf aslr: Strip sample registers
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, gmx@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Extend the ASLR tool stripping helpers to drop register dump payloads
by masking out the relevant perf_event_attr fields (sample_regs_user,
sample_regs_intr) when the delegated tool is handling the data.

struct aslr_evsel_priv maintains the original perf_event_attr values
and is looked up via the evsel_orig_attrs hashmap so that sample sizes
can be properly parsed even when bits are stripped from the pipeline.

This allows us to keep samples that would otherwise be dropped because
they contain registers, while still obfuscating the registers.

Co-developed-by: Gabriel Marin <gmx@google.com>
Signed-off-by: Gabriel Marin <gmx@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/builtin-inject.c |  31 +++-
 tools/perf/util/aslr.c      | 298 ++++++++++++++++++++++++++----------
 tools/perf/util/aslr.h      |   9 +-
 3 files changed, 248 insertions(+), 90 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 6cc9c6dbf608..abb2228bc5bd 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -241,6 +241,9 @@ static int perf_event__repipe_attr(const struct perf_tool *tool,
 	if (ret)
 		return ret;
 
+	if (inject->aslr)
+		aslr_tool__strip_attr_event(event, *pevlist);
+
 	/* If the output isn't a pipe then the attributes will be written as part of the header. */
 	if (!inject->output.is_pipe)
 		return 0;
@@ -279,8 +282,7 @@ static int perf_event__repipe_attr(const struct perf_tool *tool,
 
 	attr.size = sizeof(struct perf_event_attr);
 	attr.sample_type &= ~PERF_SAMPLE_AUX;
-	if (inject->aslr)
-		aslr_tool__strip_attr_event(event, pevlist);
+
 
 	if (inject->itrace_synth_opts.add_last_branch) {
 		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
@@ -2599,6 +2601,10 @@ static int __cmd_inject(struct perf_inject *inject)
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
@@ -2857,6 +2863,18 @@ int cmd_inject(int argc, const char **argv)
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
@@ -2875,10 +2893,17 @@ int cmd_inject(int argc, const char **argv)
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
@@ -2943,8 +2968,6 @@ int cmd_inject(int argc, const char **argv)
 		goto out_delete;
 
 	ret = __cmd_inject(&inject);
-	if (inject.aslr)
-		aslr_tool__strip_evlist(tool, inject.session->evlist);
 
 	guest_session__exit(&inject.guest_session);
 
diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
index 8980599b0158..bf6bb2715357 100644
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
@@ -659,6 +690,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 	struct aslr_tool *aslr;
 	struct perf_tool *delegate;
 	int ret;
+	int orig_sample_size;
 	u64 sample_type;
 	struct thread *thread;
 	struct machine *aslr_machine;
@@ -671,6 +703,10 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 	u64 addr;
 	size_t i;
 	size_t j;
+	struct aslr_evsel_priv *priv = NULL;
+	u64 orig_sample_type;
+	u64 orig_regs_user;
+	u64 orig_regs_intr;
 	bool orig_needs_swap;
 
 	del_tool = container_of(tool, struct delegate_tool, tool);
@@ -683,7 +719,24 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
@@ -736,25 +789,25 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 		i++; \
 	} while (0)
 
-	if (sample_type & PERF_SAMPLE_IDENTIFIER)
+	if (orig_sample_type & PERF_SAMPLE_IDENTIFIER)
 		COPY_U64(); /* id */
-	if (sample_type & PERF_SAMPLE_IP)
+	if (orig_sample_type & PERF_SAMPLE_IP)
 		REMAP_U64(sample->ip);
-	if (sample_type & PERF_SAMPLE_TID)
+	if (orig_sample_type & PERF_SAMPLE_TID)
 		COPY_U64(); /* pid, tid */
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
@@ -789,7 +842,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 			}
 		}
 	}
-	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
+	if (orig_sample_type & PERF_SAMPLE_CALLCHAIN) {
 		u64 nr;
 
 		if (CHECK_BOUNDS(1, 1)) {
@@ -861,7 +914,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 			out_array[j++] = addr;
 		}
 	}
-	if (sample_type & PERF_SAMPLE_RAW) {
+	if (orig_sample_type & PERF_SAMPLE_RAW) {
 		size_t bytes = sizeof(u32) + sample->raw_size;
 		size_t u64_words = (bytes + 7) / 8;
 
@@ -880,7 +933,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 		ret = 0;
 		goto out_put;
 	}
-	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
+	if (orig_sample_type & PERF_SAMPLE_BRANCH_STACK) {
 		u64 nr;
 
 		if (CHECK_BOUNDS(1, 1)) {
@@ -938,19 +991,25 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 			goto out_put;
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
@@ -982,39 +1041,45 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
@@ -1054,11 +1119,20 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 	}
 
 	new_event->sample.header.size = sizeof(struct perf_event_header) + j * sizeof(u64);
-
+	/* Temporarily override evsel attributes to match the stripped new_event format! */
+	evsel->sample_size = __evsel__sample_size(sample_type);
+	evsel->core.attr.sample_type = sample_type;
+	evsel->core.attr.sample_regs_user = 0;
+	evsel->core.attr.sample_regs_intr = 0;
 	perf_sample__init(&new_sample, /*all=*/ true);
 	ret = __evsel__parse_sample(evsel, new_event, &new_sample, orig_needs_swap);
 
 	if (ret) {
+		/* Restore original attributes immediately if parsing fails */
+		evsel->sample_size = orig_sample_size;
+		evsel->core.attr.sample_type = orig_sample_type;
+		evsel->core.attr.sample_regs_user = orig_regs_user;
+		evsel->core.attr.sample_regs_intr = orig_regs_intr;
 		perf_sample__exit(&new_sample);
 		goto out_put;
 	}
@@ -1067,6 +1141,12 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
@@ -1120,43 +1200,44 @@ static int aslr_tool__process_auxtrace_error(const struct perf_tool *tool __mayb
 	return 0;
 }
 
-
-void aslr_tool__strip_attr_event(union perf_event *event, struct evlist **pevlist)
+void aslr_tool__strip_attr_event(union perf_event *event, struct evlist *evlist)
 {
 	struct evsel *evsel;
 	bool needs_swap = false;
 
-	if (pevlist && *pevlist) {
-		evsel = evlist__last(*pevlist);
-		if (evsel)
-			needs_swap = evsel->needs_swap;
-	}
+	if (!evlist)
+		return;
+
+	evsel = evlist__last(evlist);
+	if (evsel)
+		needs_swap = evsel->needs_swap;
 
 	if (event->header.size >= (offsetof(struct perf_record_header_attr,
 					    attr.sample_type) + sizeof(u64))) {
-		u64 st = event->attr.attr.sample_type;
-
-		if (needs_swap)
-			st = bswap_64(st);
-
-		st &= ASLR_SUPPORTED_SAMPLE_TYPE;
+		if (needs_swap) {
+			u64 st = bswap_64(event->attr.attr.sample_type);
 
-		if (needs_swap)
-			st = bswap_64(st);
+			st &= ASLR_SUPPORTED_SAMPLE_TYPE;
+			event->attr.attr.sample_type = bswap_64(st);
+		} else {
+			event->attr.attr.sample_type &= ASLR_SUPPORTED_SAMPLE_TYPE;
+		}
 
-		event->attr.attr.sample_type = st;
+		if (event->header.size >=
+		    (offsetof(struct perf_record_header_attr, attr.sample_regs_user) + sizeof(u64)))
+			event->attr.attr.sample_regs_user = 0;
+		if (event->header.size >=
+		    (offsetof(struct perf_record_header_attr, attr.sample_regs_intr) + sizeof(u64)))
+			event->attr.attr.sample_regs_intr = 0;
 	}
 
 	if (event->header.size >= (offsetof(struct perf_record_header_attr,
 					    attr.type) + sizeof(u32))) {
-		u32 type = event->attr.attr.type;
-
-		if (needs_swap)
-			type = bswap_32(type);
+		u32 type = needs_swap ? bswap_32(event->attr.attr.type) : event->attr.attr.type;
 
 		if (type == PERF_TYPE_BREAKPOINT &&
 		    event->header.size >= (offsetof(struct perf_record_header_attr,
-						    attr.bp_addr) + sizeof(u64))) {
+							attr.bp_addr) + sizeof(u64))) {
 			event->attr.attr.bp_addr = 0;
 		} else if (type >= PERF_TYPE_MAX) {
 			struct perf_pmu *pmu;
@@ -1177,28 +1258,6 @@ void aslr_tool__strip_attr_event(union perf_event *event, struct evlist **pevlis
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
@@ -1212,6 +1271,9 @@ static void aslr_tool__init(struct aslr_tool *aslr, struct perf_tool *delegate)
 	hashmap__init(&aslr->top_addresses,
 		      top_addresses__hash, top_addresses__equal,
 		      /*ctx=*/NULL);
+	hashmap__init(&aslr->evsel_orig_attrs,
+		      evsel_hash, evsel_equal,
+		      /*ctx=*/NULL);
 
 	aslr->tool.tool.sample	= aslr_tool__process_sample;
 	/* read - reads a counter, okay to delegate. */
@@ -1274,9 +1336,13 @@ void aslr_tool__delete(struct perf_tool *tool)
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
 
@@ -1290,3 +1356,69 @@ void aslr_tool__delete(struct perf_tool *tool)
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
2.54.0.1032.g2f8565e1d1-goog

