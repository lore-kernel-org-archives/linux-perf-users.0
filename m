Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDE43FFAD5
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 06:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780639590; cv=none; b=BHirqSsXb4kRjt0b7mEUStM2UHkB/F9o90Dzno7TRZpc6lzLUzpdQZGsZyMnbLeCUQJ6SnSD8tHlJ5gxH1vgaoECAf4GZL/WvwCangPyUGOgc1hFOMF6F98d8Vy2T78T8UNIGsxvPxjO5Gj2jBXHDfsk8v9lkwxaaaB8fhJ7HrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780639590; c=relaxed/simple;
	bh=uYN3cFQuRAJz5zi+khLeRs33m/AkjnIiZd2l070EVbo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A0VRU6E8kBQK08K2iPID4f2UNEh56lVxa6TqK85mSA+skzRvNxkt1VZZxqABGd4US7GIR01EhTcujWq80ewTj5+iVmObKB1X5JctG9ErGj9gw2ij1zo8cE1VjUvftI45oFV6I8+WIqBGMd4BZhg0NEcUwrsjKuu4XUuZDZtrovo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uKOV5PjK; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uKOV5PjK"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137f304f564so2820296c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 23:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780639587; x=1781244387; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ijhzJ6QXfj+YsVmPBCYSq3gJf2kxdvccdgGwQNouqM=;
        b=uKOV5PjKHR2cAc8mIeW8Ut0QuToKLa+kijMrQz7aVqGduuCXcyK6X8Lt41BaeXsKEv
         mR+Rqm+6LVFPeUDY8pkTMhes7txJAf/rQQlKosvwq3tGmV3c3h9CdcuU4CGZggLaw8cr
         rLD5qJv1eBJwK+dTidbBaepqjXkI2hGI8StoRtl/y23XPpQgwxW14onScMBgh7NDB96r
         1HsdsHSP8B0qTaFM1iVAQMYdHg34z6mjo7V0kkwfMBAKss52USOTxPl4PY1vLqVIftoO
         8Iged8RwlIy/ksQ9SKKwIaGmcaVV9+rWUUbGY2t79Qo38xd2GNSJ+u7i1E77hvNJvofJ
         qicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780639587; x=1781244387;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ijhzJ6QXfj+YsVmPBCYSq3gJf2kxdvccdgGwQNouqM=;
        b=DkaN2btR3ddljc4ybNUfc6gH3nw/A5EYYtlULBwjAsnWgO86ZvYWsrESFcwDLWfX4d
         /Ts8lhQQNhhZjz8fDA+UjCeIE761LYizfe5gGjf9HcytbuXONkjATc5dCSKADMWh7cNw
         c7ReTuKnEViKkx7fo++CyCWnp1oKv9BY6W/R4tMAC0ahZZzF9GKaCZVP0CtFy1ABLUit
         ZrXGi9dH7RfUj5+29bEJrTot7Wtubvm+WznXB7Gp6KH7UgFp3rlOhxvBnzbUFxPqMGEm
         O7bOPA6uTJ9iCDMrS97G6Xrt9zcxN12l55aK3nuFLXHmC0XozHRs8CGOO88naOSOC3MJ
         jh+A==
X-Forwarded-Encrypted: i=1; AFNElJ8hnzuZk7pxeRkB5tNOpErj425yORomwcsjVxVAQIA5F5FZbvz4lJyDwUNH5FQmyhNZPb7Vb9PzKzH4GQqXvZyB@vger.kernel.org
X-Gm-Message-State: AOJu0YxGbVtpksZ7KbpI1Jqvsqz+hHDPtqYw8o0FDF+DoQrc8m9L42tO
	JgYnyY/ZcpkxAHTvyfOUKa/8WGUgN4cIlQzs7EusNRmniJGco8nOMPoa2lDFSrr86pkGNWaLfCw
	Lkojogb2s2Q==
X-Received: from dlbpt7.prod.google.com ([2002:a05:7022:e807:b0:137:f7df:1f6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ef18:b0:137:1ae1:bc19
 with SMTP id a92af1059eb24-1380666a380mr1025161c88.5.1780639586349; Thu, 04
 Jun 2026 23:06:26 -0700 (PDT)
Date: Thu,  4 Jun 2026 23:06:10 -0700
In-Reply-To: <20260605060610.1529996-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604172850.683329-1-irogers@google.com> <20260605060610.1529996-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605060610.1529996-6-irogers@google.com>
Subject: [PATCH v10 5/5] perf aslr: Strip sample registers
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, gmx@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Refactor the ASLR tool to strip out only the register dump payload
by masking out the relevant perf_event_attr fields when the delegated
tool is handling the data. struct aslr_evsel_priv maintains the
original perf_event_attr values and is looked up via the evsel_orig_attrs
hashmap.

This allows us to keep samples that would otherwise be dropped because
they contain registers, while still obfuscating the registers.

Co-developed-by: Gabriel Marin <gmx@google.com>
Signed-off-by: Gabriel Marin <gmx@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c           |  46 ++++--
 tools/perf/tests/shell/inject_aslr.sh |  55 +++++++
 tools/perf/util/aslr.c                | 208 +++++++++++++++++++++-----
 tools/perf/util/aslr.h                |   4 +
 4 files changed, 264 insertions(+), 49 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 65c7eccccf4d..de315bb334b3 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -253,6 +253,12 @@ static int perf_event__repipe_attr(const struct perf_tool *tool,
 				return -ENOMEM;
 			memcpy(stripped_event, event, event->header.size);
 			stripped_event->attr.attr.sample_type &= ASLR_SUPPORTED_SAMPLE_TYPE;
+			if (stripped_event->attr.attr.size >=
+			    (offsetof(struct perf_event_attr, sample_regs_user) + sizeof(u64)))
+				stripped_event->attr.attr.sample_regs_user = 0;
+			if (stripped_event->attr.attr.size >=
+			    (offsetof(struct perf_event_attr, sample_regs_intr) + sizeof(u64)))
+				stripped_event->attr.attr.sample_regs_intr = 0;
 
 			if (stripped_event->attr.attr.type == PERF_TYPE_BREAKPOINT)
 				stripped_event->attr.attr.bp_addr = 0;
@@ -295,8 +301,13 @@ static int perf_event__repipe_attr(const struct perf_tool *tool,
 
 	attr.size = sizeof(struct perf_event_attr);
 	attr.sample_type &= ~PERF_SAMPLE_AUX;
-	if (inject->aslr)
+	if (inject->aslr) {
 		attr.sample_type &= ASLR_SUPPORTED_SAMPLE_TYPE;
+		if (attr.type == PERF_TYPE_BREAKPOINT)
+			attr.bp_addr = 0;
+		attr.sample_regs_user = 0;
+		attr.sample_regs_intr = 0;
+	}
 
 	if (inject->itrace_synth_opts.add_last_branch) {
 		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
@@ -2618,6 +2629,9 @@ static int __cmd_inject(struct perf_inject *inject)
 
 
 
+		if (inject->aslr)
+			aslr_tool__strip_evlist(inject->session->tool, session->evlist);
+
 		session->header.data_offset = output_data_offset;
 		session->header.data_size = inject->bytes_written;
 		perf_session__inject_header(session, session->evlist, fd, &inj_fc.fc,
@@ -2876,6 +2890,18 @@ int cmd_inject(int argc, const char **argv)
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
@@ -2894,10 +2920,17 @@ int cmd_inject(int argc, const char **argv)
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
@@ -2963,17 +2996,6 @@ int cmd_inject(int argc, const char **argv)
 
 	ret = __cmd_inject(&inject);
 
-	if (inject.aslr) {
-		struct evsel *evsel;
-
-		evlist__for_each_entry(inject.session->evlist, evsel) {
-			evsel->core.attr.sample_type &= ASLR_SUPPORTED_SAMPLE_TYPE;
-
-			if (evsel->core.attr.type == PERF_TYPE_BREAKPOINT)
-				evsel->core.attr.bp_addr = 0;
-		}
-	}
-
 	guest_session__exit(&inject.guest_session);
 
 out_delete:
diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/shell/inject_aslr.sh
index 9dd0a4e5f903..e9ce6891ac12 100755
--- a/tools/perf/tests/shell/inject_aslr.sh
+++ b/tools/perf/tests/shell/inject_aslr.sh
@@ -449,6 +449,60 @@ test_kernel_report_aslr() {
   fi
 }
 
+test_regs_stripping() {
+  echo "Test user register stripping"
+  local rdata="${temp_dir}/perf.data.regs"
+  local rdata2="${temp_dir}/perf.data.regs.injected"
+  local rdata_clean="${temp_dir}/perf.data.regs.clean"
+
+  if ! perf record --user-regs -o "${rdata}" ${prog} > /dev/null 2>&1; then
+    echo "Skipping user registers test as recording failed (unsupported flag/platform)"
+    return
+  fi
+
+  perf inject -b -i "${rdata}" -o "${rdata_clean}"
+  perf inject -v -b --aslr -i "${rdata}" -o "${rdata2}"
+
+  local report1="${temp_dir}/report_regs1"
+  local report2="${temp_dir}/report_regs2"
+  local report1_clean="${temp_dir}/report_regs1.clean"
+  local report2_clean="${temp_dir}/report_regs2.clean"
+  local diff_file="${temp_dir}/diff_regs"
+
+  perf report -i "${rdata_clean}" --stdio > "${report1}" 2>/dev/null || true
+  perf report -i "${rdata2}" --stdio > "${report2}" 2>/dev/null || true
+
+  grep '%' "${report1}" | grep -v '^#' | \
+    grep -v -E '0x[0-9a-f]{8,}|0000000000000000' | \
+    sort > "${report1_clean}" || true
+  grep '%' "${report2}" | grep -v '^#' | \
+    grep -v -E '0x[0-9a-f]{8,}|0000000000000000' | \
+    sort > "${report2_clean}" || true
+
+  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" || true
+
+  if [ ! -s "${report1_clean}" ]; then
+    echo "User registers stripping test [Failed - profile trace starved/empty]"
+    err=1
+    return
+  elif [ -s "${diff_file}" ]; then
+    echo "User registers stripping test [Failed - report parsing differs]"
+    echo "Showing first 20 lines of diff:"
+    head -n 20 "${diff_file}"
+    err=1
+    return
+  fi
+
+  local script_dump="${temp_dir}/script_regs_dump"
+  perf script -D -i "${rdata2}" > "${script_dump}" 2>/dev/null || true
+  if grep -q "PERF_SAMPLE_REGS_USER" "${script_dump}"; then
+    echo "User registers stripping test [Failed - register dumps still present]"
+    err=1
+  else
+    echo "User registers stripping test [Success]"
+  fi
+}
+
 test_basic_aslr
 test_pipe_aslr
 test_callchain_aslr
@@ -458,6 +512,7 @@ test_pipe_out_report_aslr
 test_dropped_samples
 test_kernel_aslr
 test_kernel_report_aslr
+test_regs_stripping
 
 cleanup
 exit $err
diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
index 8cfefa23030d..33b7fca68686 100644
--- a/tools/perf/util/aslr.c
+++ b/tools/perf/util/aslr.c
@@ -5,6 +5,7 @@
 #include "debug.h"
 #include "event.h"
 #include "evsel.h"
+#include "evlist.h"
 #include "machine.h"
 #include "map.h"
 #include "thread.h"
@@ -16,6 +17,7 @@
 #include <internal/lib.h>  /* page_size */
 #include <linux/compiler.h>
 #include <linux/zalloc.h>
+#include <errno.h>
 #include <inttypes.h>
 #include <unistd.h>
 
@@ -43,6 +45,22 @@ struct aslr_mapping {
 	u64 remap_start;
 };
 
+struct aslr_evsel_priv {
+	u64 orig_sample_type;
+	u64 orig_sample_regs_user;
+	u64 orig_sample_regs_intr;
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
 	u64 orig_last_end;
@@ -58,6 +76,11 @@ struct aslr_tool {
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
@@ -613,6 +636,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 	struct aslr_tool *aslr;
 	struct perf_tool *delegate;
 	int ret;
+	int orig_sample_size;
 	u64 sample_type;
 	struct thread *thread;
 	struct machine *aslr_machine;
@@ -626,6 +650,10 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 	size_t i;
 	size_t j;
 	bool orig_needs_swap;
+	struct aslr_evsel_priv *priv = NULL;
+	u64 orig_sample_type;
+	u64 orig_regs_user;
+	u64 orig_regs_intr;
 
 	del_tool = container_of(tool, struct delegate_tool, tool);
 	aslr = container_of(del_tool, struct aslr_tool, tool);
@@ -635,7 +663,23 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
+
 	max_i = (event->header.size - sizeof(struct perf_event_header)) / sizeof(__u64);
 	max_j = (PERF_SAMPLE_MAX_SIZE - sizeof(struct perf_event_header)) / sizeof(__u64);
 	new_event = (union perf_event *)aslr->event_copy;
@@ -684,25 +728,25 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
@@ -736,7 +780,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 			}
 		}
 	}
-	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
+	if (orig_sample_type & PERF_SAMPLE_CALLCHAIN) {
 		u64 nr;
 
 		if (CHECK_BOUNDS(1, 1)) {
@@ -802,7 +846,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 			out_array[j++] = aslr_tool__remap_address(aslr, thread, cpumode, addr);
 		}
 	}
-	if (sample_type & PERF_SAMPLE_RAW) {
+	if (orig_sample_type & PERF_SAMPLE_RAW) {
 		size_t bytes = sizeof(u32) + sample->raw_size;
 		size_t u64_words = (bytes + 7) / 8;
 
@@ -821,7 +865,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 		ret = 0;
 		goto out_put;
 	}
-	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
+	if (orig_sample_type & PERF_SAMPLE_BRANCH_STACK) {
 		u64 nr;
 
 		if (CHECK_BOUNDS(1, 1)) {
@@ -866,19 +910,25 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
@@ -909,39 +959,45 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
@@ -982,6 +1038,12 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 
 	new_event->sample.header.size = sizeof(struct perf_event_header) + j * sizeof(u64);
 
+	/* Temporarily override evsel attributes to match the stripped new_event format! */
+	evsel->sample_size = __evsel__sample_size(sample_type);
+	evsel->core.attr.sample_type = sample_type;
+	evsel->core.attr.sample_regs_user = 0;
+	evsel->core.attr.sample_regs_intr = 0;
+
 	orig_needs_swap = evsel->needs_swap;
 
 	perf_sample__init(&new_sample, /*all=*/ true);
@@ -990,6 +1052,11 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 	evsel->needs_swap = orig_needs_swap;
 
 	if (ret) {
+		/* Restore original attributes immediately if parsing fails */
+		evsel->sample_size = orig_sample_size;
+		evsel->core.attr.sample_type = orig_sample_type;
+		evsel->core.attr.sample_regs_user = orig_regs_user;
+		evsel->core.attr.sample_regs_intr = orig_regs_intr;
 		perf_sample__exit(&new_sample);
 		goto out_put;
 	}
@@ -998,6 +1065,12 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
@@ -1064,6 +1137,9 @@ static void aslr_tool__init(struct aslr_tool *aslr, struct perf_tool *delegate)
 	hashmap__init(&aslr->top_addresses,
 		      top_addresses__hash, top_addresses__equal,
 		      /*ctx=*/NULL);
+	hashmap__init(&aslr->evsel_orig_attrs,
+		      evsel_hash, evsel_equal,
+		      /*ctx=*/NULL);
 
 	aslr->tool.tool.sample	= aslr_tool__process_sample;
 	/* read - reads a counter, okay to delegate. */
@@ -1125,11 +1201,69 @@ void aslr_tool__delete(struct perf_tool *tool)
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
+		evsel__reset_sample_bit(evsel, REGS_USER);
+		evsel__reset_sample_bit(evsel, REGS_INTR);
+		evsel->core.attr.sample_regs_user = 0;
+		evsel->core.attr.sample_regs_intr = 0;
+
+		if (evsel->core.attr.type == PERF_TYPE_BREAKPOINT)
+			evsel->core.attr.bp_addr = 0;
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
+		}
+	}
+}
diff --git a/tools/perf/util/aslr.h b/tools/perf/util/aslr.h
index a9b90bf29540..4c2cffc0e500 100644
--- a/tools/perf/util/aslr.h
+++ b/tools/perf/util/aslr.h
@@ -30,8 +30,12 @@
 
 struct perf_tool;
 struct evsel;
+struct evlist;
 
 struct perf_tool *aslr_tool__new(struct perf_tool *delegate);
 void aslr_tool__delete(struct perf_tool *aslr);
+int aslr_tool__cache_orig_attrs(struct perf_tool *tool, struct evsel *evsel);
+void aslr_tool__strip_evlist(const struct perf_tool *tool, struct evlist *evlist);
+void aslr_tool__restore_evlist(const struct perf_tool *tool, struct evlist *evlist);
 
 #endif /* __PERF_ASLR_H */
-- 
2.54.0.1032.g2f8565e1d1-goog

