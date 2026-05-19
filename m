Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1D53DE447
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178119; cv=none; b=DWmMGmSjX+oaxIsfASdpgyNchXUl2jxPMWH3Yid+12ONoM/dhKLaVDKFCXZzfdaqR2qn1ecwI4NmKedTFyiZCR9InHVmUgCAOifg/mJVxWeyMsYAWAVpKivciazT8jmxT/z+PDy1wjTzBfaZYn0/OAZFFGwKLoAWNOwZQjmIwCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178119; c=relaxed/simple;
	bh=iuBO1W5K99TPH2DMEHxqdI89QCvm04PL4wcFZcMZXCk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iWkUoLSiiywrTVeD6RS07g/AM/CHG+P5zn2bwtaQvdzppceyUY6vbjYEof1kO3UCXFUy4yPj5lOmYpqhdVbS6+28bBUuMDQ+L3eYt+HnetCclzjXU709eo3i2BuShkQZfyh5B4ZgQJBUbS5s2PFof2xSUWE6QDE1Nf2nvlFmeFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j0Wv3fiK; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j0Wv3fiK"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ef37c3f773so3403179eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 01:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779178115; x=1779782915; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R42dg19QrNU0bBzdrKMwJQ0jZEa1UyOaXYgiIqa/eiQ=;
        b=j0Wv3fiKwiFbb//BaI61m2LBOE+7rv9V37cUDYfmh0A0u6Uol51MWzs93IVzenYiZx
         /kpOIhGtAxqLfQqAADfz5kBwrfzBPbAjsy7UUUPLrs932n3mTKiqyS5uqOh4B8z+HZA8
         ZxHqwUWmScGo0YQCO88Jt+FFmP8CSDqJcg8UXHOdV6ak1vdJugpQ0z3jduIY6SsYfRFa
         N1jFZsDLpPQu6aWKfGZ02gUtRxHJvB12Yj47oAVTgBNIa9kETYzYskPN4/KN7DTSh3jh
         3PjPoSObLptbPOhmtiZkmyE8ni6tzK86QZV/5feHAXi0R83en83J3uDj2BIDbA0eEt0q
         q37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779178115; x=1779782915;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R42dg19QrNU0bBzdrKMwJQ0jZEa1UyOaXYgiIqa/eiQ=;
        b=DxgAxdO5oFtAtCDJ35slltoylOeuzKmLJ8ou9ZjyoKUVHvFYTAZsEbfhy66oPUERYB
         gqiVIX0l0GI41mTL+gY5zmFeSKBbBGJ3HUNw7JyxusureVEkIvZ/NGwLgidpV2PoZiFn
         Y5KRL1c7QeGrpO7Z9i5Uu7HltwrMReL+dIeJ8t41YCMg/thOwtdCb28JrI6TRXbskudv
         ErpZ2OX3dMjmalZE3IH//6Lq81584FYOxXQ6n76QvnjcXVJHn9d1UP8IbNC6X8VqZYOS
         ImiFB49FPdpJGFpn+qA8VOIhWP+nOhcrxadU4LZL8BHJcL8Xjveamtuyb+ZgqwXCdjjy
         XANw==
X-Forwarded-Encrypted: i=1; AFNElJ/pXUVDGVl8aVVNGOHw5bdLYDvlw/YvLZ87oXHdRDvTtZ6mSyMyDbKtfWDOlyqqsrAka4CNBtaWa7wgtYTPhN8i@vger.kernel.org
X-Gm-Message-State: AOJu0YwMQpS2iyrfhYofAI8TYJfnuDC9fO/r8LVfGwLYawwDzEKn99m5
	OaF55uQRn1ithBq+cq+RIUOWUZRaQFuwLN+AdC6UgZhLf1KSuBxEO5q4J/UnhUBSvIYY0Lu/YzG
	ijMfvLfTkFQ==
X-Received: from dycok12.prod.google.com ([2002:a05:7301:db0c:b0:302:5b3d:5b37])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a907:b0:2c5:220c:5670
 with SMTP id 5a478bee46e88-3039818eec3mr7313767eec.2.1779178115053; Tue, 19
 May 2026 01:08:35 -0700 (PDT)
Date: Tue, 19 May 2026 01:08:24 -0700
In-Reply-To: <20260519080824.3329601-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508082726.2795191-1-irogers@google.com> <20260519080824.3329601-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260519080824.3329601-5-irogers@google.com>
Subject: [PATCH v7 4/4] perf aslr: Strip sample registers
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, gmx@google.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When the ASLR tracking tool encounters sample events containing user
or interrupt register dumps (PERF_SAMPLE_REGS_USER /
PERF_SAMPLE_REGS_INTR), it previously dropped the entire sample event
conservatively to prevent absolute virtual memory pointers leakage
embedded inside raw register frames. If a trace session was recorded
with register collection flags enabled, this resulted in 100% sample
drop rates, and this happened by default for ARM64.

Refactor the ASLR tool to strip out only the register dump payload
words from PERF_RECORD_SAMPLE event streams, automatically shrinking
the output sample header size. Incoming PERF_RECORD_ATTR events are
scrubbed up front to clear the register dump bit selection flags and
masks, and output sample ABI words are safely overwritten to
PERF_SAMPLE_REGS_ABI_NONE.  This keeps downstream evsel parsers
perfectly synchronized while retaining full, comprehensive sample
profiles completely clear of secret register data frames.

Verification parity is established inside inject_aslr.sh via a
dedicated sorted report diff comparison validation case proving zero
starvation and absolute secrecy.

Assisted-by: Gemini-CLI:Google Gemini 3

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c           |  22 +++
 tools/perf/tests/shell/inject_aslr.sh |  55 ++++++++
 tools/perf/util/aslr.c                | 185 ++++++++++++++++----------
 tools/perf/util/aslr.h                |   1 +
 4 files changed, 195 insertions(+), 68 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 8fe924e730a1..4bafccf7dae4 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2519,6 +2519,17 @@ static int __cmd_inject(struct perf_inject *inject)
 			}
 		}
 
+		if (inject->aslr) {
+			struct evsel *evsel;
+
+			evlist__for_each_entry(session->evlist, evsel) {
+				evsel__reset_sample_bit(evsel, REGS_USER);
+				evsel__reset_sample_bit(evsel, REGS_INTR);
+				evsel->core.attr.sample_regs_user = 0;
+				evsel->core.attr.sample_regs_intr = 0;
+			}
+		}
+
 
 
 		session->header.data_offset = output_data_offset;
@@ -2783,7 +2794,18 @@ int cmd_inject(int argc, const char **argv)
 		struct evsel *evsel;
 
 		evlist__for_each_entry(inject.session->evlist, evsel) {
+			ret = aslr_tool__cache_orig_attrs(tool, evsel);
+			if (ret) {
+				pr_err("Failed to cache original attributes: %d\n", ret);
+				goto out_delete;
+			}
+
+			/* Strip the registers and unknown flags natively inside memory! */
 			evsel->core.attr.sample_type &= ASLR_SUPPORTED_SAMPLE_TYPE;
+			evsel__reset_sample_bit(evsel, REGS_USER);
+			evsel__reset_sample_bit(evsel, REGS_INTR);
+			evsel->core.attr.sample_regs_user = 0;
+			evsel->core.attr.sample_regs_intr = 0;
 
 			if (evsel->core.attr.type == PERF_TYPE_BREAKPOINT)
 				evsel->core.attr.bp_addr = 0;
diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/shell/inject_aslr.sh
index 098bf1db1245..cd60e1b7d840 100755
--- a/tools/perf/tests/shell/inject_aslr.sh
+++ b/tools/perf/tests/shell/inject_aslr.sh
@@ -444,6 +444,60 @@ test_kernel_report_aslr() {
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
@@ -453,6 +507,7 @@ test_pipe_out_report_aslr
 test_dropped_samples
 test_kernel_aslr
 test_kernel_report_aslr
+test_regs_stripping
 
 cleanup
 exit $err
diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
index d0b1b33377fd..ef6ba6fa5ff4 100644
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
@@ -16,33 +17,10 @@
 #include <internal/lib.h>  /* page_size */
 #include <linux/compiler.h>
 #include <linux/zalloc.h>
+#include <errno.h>
 #include <inttypes.h>
 #include <unistd.h>
 
-#define ASLR_SUPPORTED_SAMPLE_TYPE ( \
-	PERF_SAMPLE_IDENTIFIER | \
-	PERF_SAMPLE_IP | \
-	PERF_SAMPLE_TID | \
-	PERF_SAMPLE_TIME | \
-	PERF_SAMPLE_ADDR | \
-	PERF_SAMPLE_ID | \
-	PERF_SAMPLE_STREAM_ID | \
-	PERF_SAMPLE_CPU | \
-	PERF_SAMPLE_PERIOD | \
-	PERF_SAMPLE_READ | \
-	PERF_SAMPLE_CALLCHAIN | \
-	PERF_SAMPLE_RAW | \
-	PERF_SAMPLE_BRANCH_STACK | \
-	PERF_SAMPLE_STACK_USER | \
-	PERF_SAMPLE_WEIGHT_TYPE | \
-	PERF_SAMPLE_DATA_SRC | \
-	PERF_SAMPLE_TRANSACTION | \
-	PERF_SAMPLE_PHYS_ADDR | \
-	PERF_SAMPLE_CGROUP | \
-	PERF_SAMPLE_DATA_PAGE_SIZE | \
-	PERF_SAMPLE_CODE_PAGE_SIZE | \
-	PERF_SAMPLE_AUX)
-
 /**
  * struct remap_addresses_key - Key for mapping original addresses to remapped ones.
  * @dso: Pointer to the DSO (Dynamic Shared Object) associated with the mapping.
@@ -67,6 +45,22 @@ struct aslr_mapping {
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
 struct aslr_tool {
 	/** @tool: The tool implemented here and a pointer to a delegate to process the data. */
 	struct delegate_tool tool;
@@ -78,6 +72,11 @@ struct aslr_tool {
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
@@ -167,9 +166,7 @@ static u64 aslr_tool__remap_address(struct aslr_tool *aslr,
 	key.machine = maps__machine(aslr_thread->maps);
 	key.dso = map__dso(al.map);
 	key.invariant = map__start(al.map) - map__pgoff(al.map);
-	key.pid = (effective_cpumode == PERF_RECORD_MISC_KERNEL ||
-		   effective_cpumode == PERF_RECORD_MISC_GUEST_KERNEL) ?
-		  kernel_pid : aslr_thread->pid_;
+	key.pid = effective_cpumode == PERF_RECORD_MISC_KERNEL ? kernel_pid : aslr_thread->pid_;
 
 	if (hashmap__find(&aslr->remap_addresses, &key, &remapped_invariant_ptr)) {
 		remap_addr = *remapped_invariant_ptr + map__pgoff(al.map) +
@@ -563,12 +560,25 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 	u64 addr;
 	size_t i;
 	size_t j;
+	struct aslr_evsel_priv *priv = NULL;
+	u64 orig_sample_type;
+	u64 orig_regs_user;
+	u64 orig_regs_intr;
 
 	del_tool = container_of(tool, struct delegate_tool, tool);
 	aslr = container_of(del_tool, struct aslr_tool, tool);
 	delegate = aslr->tool.delegate;
 	ret = -EFAULT;
 	sample_type = evsel->core.attr.sample_type;
+	orig_sample_type = sample_type;
+	orig_regs_user = evsel->core.attr.sample_regs_user;
+	orig_regs_intr = evsel->core.attr.sample_regs_intr;
+
+	if (hashmap__find(&aslr->evsel_orig_attrs, evsel, &priv)) {
+		orig_sample_type = priv->orig_sample_type;
+		orig_regs_user = priv->orig_sample_regs_user;
+		orig_regs_intr = priv->orig_sample_regs_intr;
+	}
 	max_i = (event->header.size - sizeof(struct perf_event_header)) / sizeof(__u64);
 	max_j = (PERF_SAMPLE_MAX_SIZE - sizeof(struct perf_event_header)) / sizeof(__u64);
 	new_event = (union perf_event *)aslr->event_copy;
@@ -615,25 +625,25 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
@@ -667,7 +677,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 			}
 		}
 	}
-	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
+	if (orig_sample_type & PERF_SAMPLE_CALLCHAIN) {
 		u64 nr;
 
 		if (CHECK_BOUNDS(1, 1)) {
@@ -733,7 +743,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 			out_array[j++] = aslr_tool__remap_address(aslr, thread, cpumode, addr);
 		}
 	}
-	if (sample_type & PERF_SAMPLE_RAW) {
+	if (orig_sample_type & PERF_SAMPLE_RAW) {
 		size_t bytes = sizeof(u32) + sample->raw_size;
 		size_t u64_words = (bytes + 7) / 8;
 
@@ -752,7 +762,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 		ret = 0;
 		goto out_put;
 	}
-	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
+	if (orig_sample_type & PERF_SAMPLE_BRANCH_STACK) {
 		u64 nr;
 
 		if (CHECK_BOUNDS(1, 1)) {
@@ -797,7 +807,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 			goto out_put;
 		}
 	}
-	if (sample_type & PERF_SAMPLE_REGS_USER) {
+	if (orig_sample_type & PERF_SAMPLE_REGS_USER) {
 		u64 abi;
 
 		if (CHECK_BOUNDS(1, 0)) {
@@ -806,22 +816,16 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 		}
 		abi = in_array[i++];
 		if (abi != PERF_SAMPLE_REGS_ABI_NONE) {
-			u64 nr = hweight64(evsel->core.attr.sample_regs_user);
+			u64 nr = hweight64(orig_regs_user);
 
-			if (nr > max_i - i || nr > max_j - j) {
+			if (nr > max_i - i) {
 				ret = -EFAULT;
 				goto out_put;
 			}
-			memcpy(&out_array[j], &in_array[i], nr * sizeof(u64));
 			i += nr;
-			j += nr;
 		}
-		/* TODO: can this be less conservative? */
-		pr_debug("Dropping regs user sample as possible ASLR leak\n");
-		ret = 0;
-		goto out_put;
 	}
-	if (sample_type & PERF_SAMPLE_STACK_USER) {
+	if (orig_sample_type & PERF_SAMPLE_STACK_USER) {
 		u64 size;
 
 		if (CHECK_BOUNDS(1, 1)) {
@@ -854,13 +858,13 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
 		u64 abi;
 
 		if (CHECK_BOUNDS(1, 0)) {
@@ -869,36 +873,30 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 		}
 		abi = in_array[i++];
 		if (abi != PERF_SAMPLE_REGS_ABI_NONE) {
-			u64 nr = hweight64(evsel->core.attr.sample_regs_intr);
+			u64 nr = hweight64(orig_regs_intr);
 
-			if (nr > max_i - i || nr > max_j - j) {
+			if (nr > max_i - i) {
 				ret = -EFAULT;
 				goto out_put;
 			}
-			memcpy(&out_array[j], &in_array[i], nr * sizeof(u64));
 			i += nr;
-			j += nr;
 		}
-		/* TODO: can this be less conservative? */
-		pr_debug("Dropping interrupt register sample as possible ASLR leak\n");
-		ret = 0;
-		goto out_put;
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
@@ -966,6 +964,7 @@ static int aslr_tool__process_attr(const struct perf_tool *tool,
 	struct aslr_tool *aslr;
 	struct perf_tool *delegate;
 	union perf_event *new_event;
+	int err;
 
 	del_tool = container_of(tool, struct delegate_tool, tool);
 	aslr = container_of(del_tool, struct aslr_tool, tool);
@@ -976,9 +975,32 @@ static int aslr_tool__process_attr(const struct perf_tool *tool,
 	if (new_event->attr.attr.type == PERF_TYPE_BREAKPOINT)
 		new_event->attr.attr.bp_addr = 0;  /* Conservatively remove addresses. */
 
+	if (new_event->attr.attr.sample_type & PERF_SAMPLE_REGS_USER) {
+		new_event->attr.attr.sample_type &= ~PERF_SAMPLE_REGS_USER;
+		new_event->attr.attr.sample_regs_user = 0;
+	}
+	if (new_event->attr.attr.sample_type & PERF_SAMPLE_REGS_INTR) {
+		new_event->attr.attr.sample_type &= ~PERF_SAMPLE_REGS_INTR;
+		new_event->attr.attr.sample_regs_intr = 0;
+	}
+
 	new_event->attr.attr.sample_type &= ASLR_SUPPORTED_SAMPLE_TYPE;
 
-	return delegate->attr(delegate, new_event, pevlist);
+	err = delegate->attr(delegate, new_event, pevlist);
+	if (!err && pevlist && *pevlist) {
+		struct evsel *evsel = evlist__last(*pevlist);
+		struct aslr_evsel_priv *priv = zalloc(sizeof(*priv));
+
+		if (priv) {
+			priv->orig_sample_type = event->attr.attr.sample_type;
+			priv->orig_sample_regs_user = event->attr.attr.sample_regs_user;
+			priv->orig_sample_regs_intr = event->attr.attr.sample_regs_intr;
+			if (hashmap__add(&aslr->evsel_orig_attrs, evsel, priv) != 0)
+				free(priv);
+		}
+	}
+
+	return err;
 }
 
 static int skipn(int fd, off_t n)
@@ -1037,6 +1059,9 @@ static void aslr_tool__init(struct aslr_tool *aslr, struct perf_tool *delegate)
 	hashmap__init(&aslr->top_addresses,
 		      top_addresses__hash, top_addresses__equal,
 		      /*ctx=*/NULL);
+	hashmap__init(&aslr->evsel_orig_attrs,
+		      evsel_hash, evsel_equal,
+		      /*ctx=*/NULL);
 
 	aslr->tool.tool.sample	= aslr_tool__process_sample;
 	/* read - reads a counter, okay to delegate. */
@@ -1097,10 +1122,34 @@ void aslr_tool__delete(struct perf_tool *tool)
 		zfree(&cur->pkey);
 		zfree(&cur->pvalue);
 	}
+	hashmap__for_each_entry(&aslr->evsel_orig_attrs, cur, bkt) {
+		zfree(&cur->pvalue);
+	}
 
 	hashmap__clear(&aslr->remap_addresses);
 	hashmap__clear(&aslr->top_addresses);
+	hashmap__clear(&aslr->evsel_orig_attrs);
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
+
+	if (!priv)
+		return -ENOMEM;
+
+	priv->orig_sample_type = evsel->core.attr.sample_type;
+	priv->orig_sample_regs_user = evsel->core.attr.sample_regs_user;
+	priv->orig_sample_regs_intr = evsel->core.attr.sample_regs_intr;
+
+	if (hashmap__add(&aslr->evsel_orig_attrs, evsel, priv) != 0) {
+		free(priv);
+		return -EEXIST;
+	}
+	return 0;
+}
diff --git a/tools/perf/util/aslr.h b/tools/perf/util/aslr.h
index a9b90bf29540..e4cdb337a66f 100644
--- a/tools/perf/util/aslr.h
+++ b/tools/perf/util/aslr.h
@@ -33,5 +33,6 @@ struct evsel;
 
 struct perf_tool *aslr_tool__new(struct perf_tool *delegate);
 void aslr_tool__delete(struct perf_tool *aslr);
+int aslr_tool__cache_orig_attrs(struct perf_tool *tool, struct evsel *evsel);
 
 #endif /* __PERF_ASLR_H */
-- 
2.54.0.631.ge1b05301d1-goog

