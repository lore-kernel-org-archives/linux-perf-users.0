Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C96D4071FC
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687488; cv=none; b=BzPyMRXlDggF3uSle0LFouxkgG/Js0xUgaaG7KesJOMWvEMWPjq3glz0bx1NqIwpl3bzYrLGOrkbI9lvdVPzwsP11OwXTduJfPPJ42UqjNPFIIji7SzQEVHNZBsU7jCeZw/SI9MHxN1jgDYqyzvERV3dOpS/pGUBum0LD4TOIqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687488; c=relaxed/simple;
	bh=sIG1sZq388bX+ywtCVx6NJ6ZLVfGhOLcbIHFGPcGd7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KdqLRfS0KyWF0ZW7A6PZuI4fwzRCIDRLM34eZDgYUC+8z4bNLjwyBJ5vGV8v8mQs7JB7vb1Ut8W1xCV52ebHNd3of7+SCe5PA1UbGW6mkx+pqFple8QVrfXbbrGNY4uDWWX4egSPBNM0h6Bo49EMBBw4Eg3J8siYiWSYAfPsGUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YG+Z+XVj; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YG+Z+XVj"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304d0d0b28eso6148811eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 12:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780687485; x=1781292285; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qjhW64zGz9RxWtMTboHYNsltLK9zGL2IjNrMPx9PH58=;
        b=YG+Z+XVjour+MKsRUBqxuxrMekpGl5YoIMonxpFlTB3lOOrrbs8I3MwG0i1hnRb5nn
         kvj3e3OZeC+j74kKfQ+aJPI6X3xnIsGzld6YeJRy5yC/EgsAx26J5UwoZVy1KzJHzMfl
         /ircCTo9jS8k6xkpj/MB0i/zGds0rlCTAlrNfALM2IzwuxG/mvtDrhBm07AHWIITf8no
         sPxY8bvh+Wj6LmR0V33jHz3BJpDWY7qLoEpW9z8kPvQOIYL3hANrwIXWzgZAfqOxMKH/
         FdKqCQKsnrq3NLtqUYBtHIehKeRoQFGH/JNyo2Iq/8JSJZ5ww1U754eqMbbSi3fA5u/a
         91Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780687485; x=1781292285;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qjhW64zGz9RxWtMTboHYNsltLK9zGL2IjNrMPx9PH58=;
        b=MisRvNKWowfElJJkgauybarqtKE8xjvQazU7bMHruKp6ent4FeVajSewiFsyoa2/Ip
         nllp7LEER1MDvyAPwRxBd6pevkd9k1CEqHnZ3ddTS3P8nv4uKrwOU2a2iGaEiO2twzPs
         S4quZI85/MDqMkrkaka8SYUIxI8MVR+Hu6PgSy3KnkzUYbk1T6FTIdAv8fAO0ybHqzOC
         jX7QBalzB2cR2UjZLhSpRotaDFC0mHPZLWMdrnXxW0ucDNKDZvsgMSJJDqBrwENsGS14
         SkqAvJoFxXGJnpqPYvA3+EbRnmQlxbYzhVeKdax7SE9emyjqEBQTP3suCS1lXHElji6H
         iO0w==
X-Forwarded-Encrypted: i=1; AFNElJ+Ey2yZHBRsxIZgyWMncjRntCGrwWOk7y0+t4uwXiYJR56qkTD87TT/KhPSZ3Yjo89RmKNFjWuvMzWv4a3W96AE@vger.kernel.org
X-Gm-Message-State: AOJu0YwfSPRhN2MPBgLoF4uFA9jf+5+amYKAdR69WuwOA4o2tHMiZB/I
	MXCJK0L6zxmXSN43NdmL1RPv4Ii8WSgG0CONiTwaQa5qcuoQTi6aJWkWhLm+dlts2t+C8F/mDJB
	+nOg0EVISWQ==
X-Received: from dybph5.prod.google.com ([2002:a05:7301:4185:b0:2ed:8f25:962c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:134a:b0:2de:cc07:e99
 with SMTP id 5a478bee46e88-3077b357e08mr2673642eec.7.1780687485014; Fri, 05
 Jun 2026 12:24:45 -0700 (PDT)
Date: Fri,  5 Jun 2026 12:24:25 -0700
In-Reply-To: <20260605192425.2523260-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605185215.2359881-1-irogers@google.com> <20260605192425.2523260-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605192425.2523260-6-irogers@google.com>
Subject: [PATCH v12 5/5] perf aslr: Strip sample registers
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
 4 files changed, 263 insertions(+), 50 deletions(-)

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
index d8ded16ba905..21d306a0ff2f 100755
--- a/tools/perf/tests/shell/inject_aslr.sh
+++ b/tools/perf/tests/shell/inject_aslr.sh
@@ -450,6 +450,60 @@ test_kernel_report_aslr() {
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
@@ -459,6 +513,7 @@ test_pipe_out_report_aslr
 test_dropped_samples
 test_kernel_aslr
 test_kernel_report_aslr
+test_regs_stripping
 
 cleanup ${err}
 exit $err
diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
index dece5fb43dd8..14c8589d7453 100644
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
@@ -625,7 +649,10 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 	u64 addr;
 	size_t i;
 	size_t j;
-
+	struct aslr_evsel_priv *priv = NULL;
+	u64 orig_sample_type;
+	u64 orig_regs_user;
+	u64 orig_regs_intr;
 	del_tool = container_of(tool, struct delegate_tool, tool);
 	aslr = container_of(del_tool, struct aslr_tool, tool);
 	delegate = aslr->tool.delegate;
@@ -634,7 +661,23 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
@@ -683,25 +726,25 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
@@ -735,7 +778,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 			}
 		}
 	}
-	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
+	if (orig_sample_type & PERF_SAMPLE_CALLCHAIN) {
 		u64 nr;
 
 		if (CHECK_BOUNDS(1, 1)) {
@@ -801,7 +844,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 			out_array[j++] = aslr_tool__remap_address(aslr, thread, cpumode, addr);
 		}
 	}
-	if (sample_type & PERF_SAMPLE_RAW) {
+	if (orig_sample_type & PERF_SAMPLE_RAW) {
 		size_t bytes = sizeof(u32) + sample->raw_size;
 		size_t u64_words = (bytes + 7) / 8;
 
@@ -820,7 +863,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 		ret = 0;
 		goto out_put;
 	}
-	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
+	if (orig_sample_type & PERF_SAMPLE_BRANCH_STACK) {
 		u64 nr;
 
 		if (CHECK_BOUNDS(1, 1)) {
@@ -865,19 +908,25 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
@@ -908,39 +957,45 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
@@ -981,10 +1036,20 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 
 	new_event->sample.header.size = sizeof(struct perf_event_header) + j * sizeof(u64);
 
+	/* Temporarily override evsel attributes to match the stripped new_event format! */
+	evsel->sample_size = __evsel__sample_size(sample_type);
+	evsel->core.attr.sample_type = sample_type;
+	evsel->core.attr.sample_regs_user = 0;
+	evsel->core.attr.sample_regs_intr = 0;
 	perf_sample__init(&new_sample, /*all=*/ true);
 	ret = evsel__parse_sample(evsel, new_event, &new_sample);
 
 	if (ret) {
+		/* Restore original attributes immediately if parsing fails */
+		evsel->sample_size = orig_sample_size;
+		evsel->core.attr.sample_type = orig_sample_type;
+		evsel->core.attr.sample_regs_user = orig_regs_user;
+		evsel->core.attr.sample_regs_intr = orig_regs_intr;
 		perf_sample__exit(&new_sample);
 		goto out_put;
 	}
@@ -993,6 +1058,12 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
@@ -1059,6 +1130,9 @@ static void aslr_tool__init(struct aslr_tool *aslr, struct perf_tool *delegate)
 	hashmap__init(&aslr->top_addresses,
 		      top_addresses__hash, top_addresses__equal,
 		      /*ctx=*/NULL);
+	hashmap__init(&aslr->evsel_orig_attrs,
+		      evsel_hash, evsel_equal,
+		      /*ctx=*/NULL);
 
 	aslr->tool.tool.sample	= aslr_tool__process_sample;
 	/* read - reads a counter, okay to delegate. */
@@ -1120,11 +1194,69 @@ void aslr_tool__delete(struct perf_tool *tool)
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

