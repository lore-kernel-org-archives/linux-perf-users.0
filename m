Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0117D3382DC
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258669; cv=none; b=QLpbHnOdsgn8IhRYLlLPd7GghMlxwtRc1ZPNz8qfwAiOWAOm+H9JivdOtXY666XUSY3y3zcQxAr3lXU3c9V3zSU+7GTAUCgfZG4v+X6lLRKx3rJ8HiAO9CdHB6LhpLALt7MpQrRh2OPbOnmwCVKQAUEQ0kuYqHNaPkU1BwrQkxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258669; c=relaxed/simple;
	bh=6O7GVUDcT7mevs1/SjAQ2AAJ6uE3AESFCKiTuJKm9Qw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EOxGq9k6wGTeL4QxJbeQfsBMvEPwYky3AQicaoJ1xWyzs/tAEQgpdNr03OdLU6m1/WcmQdqe8HOQPfPoHiycCf2m38GyWSjxlZaquJU3sqO9N0R7zHeBtKywOcsZeTYlWwCKcLHamcdeH+T4TPvR9oPo5krYOhw9XhoS06hCCo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VPA9ZRBO; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VPA9ZRBO"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-135405e4035so23553889c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 23:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779258666; x=1779863466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OeQ/AdSZhImAW97UlCI2TAvK34SFwwmg6sr44Jc+tb8=;
        b=VPA9ZRBOm+0VApzVNkl7QRBWdiRusK5zbYc3McuAhh3NFakx1ubEAgh64BSz4Hdyga
         ihUgmtd7JtcuH26TZajwruEdA+y/w79u3Fazd8//1CUM+9PuzWkANKDT+/6/BlJ4QgDq
         Vt6uZNlG9oB7ZJ64H7qNB1ilwzNfeVkXNPO4HcCHmmihGv4xiocm/WeTd0ILVE7iHU4M
         2OiEu6LYqhqA505blzit52ewGrg/BmGxlRBTAAvC7HULGuG3U3HJu1ch+eTjlxMwjY/J
         jm1V9WKjq1ZorA5l92+S4C6y9RvUaZfxtBsT1W3/BR6Xh0TmvwFdCkihfEAWNgBYnHGg
         goKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779258666; x=1779863466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OeQ/AdSZhImAW97UlCI2TAvK34SFwwmg6sr44Jc+tb8=;
        b=UYUfwmvuMLTEWLz55R5es3AquY3Oz3Y75ymI+mJhXTTNIjD/xRWptxd3OD2r8Z6J3T
         SKAGBrbW+DGo4sidg0oIuMOWtWPwIF7/oHNsRKKoKzuwIDKAp5WE6AjeBQ+rSejnCoZ9
         XffXL7SZ4lWpFkfZH/m8q/C4szCR7Wt+XxDxf8Hp6f8DdZgPGVKM18cKAxHMPWV1tg/S
         roiK8mdHe/GzP13IqYEafF2EXMJlWTb8I4Zp6i2up6yUVcMtle81j+cnCkxWuRFeiYIv
         ng4Us9dHUJhiubM4FtGVX/g+LIxim6hiAO1GbFbJEvrl97sW/nL7CiAU5ht6EbCnbD+N
         lXzw==
X-Forwarded-Encrypted: i=1; AFNElJ/zM/JqP/UbGjQMbx5PyNHtuDurIBaEIPxriIFifoqr0/Yy3dRxnBzcN5zVqXEUofRI8x//2C976KkZjpuc3Vxz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+jAE6O0uHtbSWhUlchX2GpXUkFBPH/W/c+V6YiBflFf2LHTl+
	q24pwUxTlmKtv6DsW/6iXQ9+NKtj/OnU5v4n1hha+0TDziIoUcHT9gllvnNegh04ioWZ5ozSGil
	39CTg0HRfKA==
X-Received: from dlbts4-n1.prod.google.com ([2002:a05:7022:b044:10b0:135:5a9c:4291])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6992:b0:134:fc89:3686
 with SMTP id a92af1059eb24-1350483f0femr9119950c88.24.1779258665730; Tue, 19
 May 2026 23:31:05 -0700 (PDT)
Date: Tue, 19 May 2026 23:30:50 -0700
In-Reply-To: <20260520063050.3917261-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519080824.3329601-1-irogers@google.com> <20260520063050.3917261-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260520063050.3917261-5-irogers@google.com>
Subject: [PATCH v8 4/4] perf aslr: Strip sample registers
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

Refactor the ASLR tool to strip out only the register dump payload by
masking out the relevant perf_event_attr fields when the delegated
tool is handling the data. struct aslr_evsel_priv maintains the
original perf_event_attr values and is looked up via the
evsel_orig_attrs hashmap.

The inject_aslr.sh test is extended to ensure sampled registers aren't
present after the --aslr pass.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c           |  26 ++++
 tools/perf/tests/shell/inject_aslr.sh |  55 ++++++++
 tools/perf/util/aslr.c                | 187 +++++++++++++++++++-------
 tools/perf/util/aslr.h                |   1 +
 4 files changed, 224 insertions(+), 45 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index f42b315199b3..a34902ff0e77 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -239,6 +239,8 @@ static int perf_event__repipe_attr(const struct perf_tool *tool,
 
 		memcpy(&stripped_event, event, event->header.size);
 		stripped_event.attr.attr.sample_type &= ASLR_SUPPORTED_SAMPLE_TYPE;
+		stripped_event.attr.attr.sample_regs_user = 0;
+		stripped_event.attr.attr.sample_regs_intr = 0;
 		return perf_event__repipe_synth(tool, &stripped_event);
 	}
 
@@ -2470,7 +2472,16 @@ static int __cmd_inject(struct perf_inject *inject)
 			}
 		}
 
+		if (inject->aslr) {
+			struct evsel *evsel;
 
+			evlist__for_each_entry(session->evlist, evsel) {
+				evsel__reset_sample_bit(evsel, REGS_USER);
+				evsel__reset_sample_bit(evsel, REGS_INTR);
+				evsel->core.attr.sample_regs_user = 0;
+				evsel->core.attr.sample_regs_intr = 0;
+			}
+		}
 
 		session->header.data_offset = output_data_offset;
 		session->header.data_size = inject->bytes_written;
@@ -2730,6 +2741,17 @@ int cmd_inject(int argc, const char **argv)
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
 	/* Save original section info before feature bits change */
 	ret = save_section_info(&inject);
 	if (ret)
@@ -2822,6 +2844,10 @@ int cmd_inject(int argc, const char **argv)
 
 		evlist__for_each_entry(inject.session->evlist, evsel) {
 			evsel->core.attr.sample_type &= ASLR_SUPPORTED_SAMPLE_TYPE;
+			evsel__reset_sample_bit(evsel, REGS_USER);
+			evsel__reset_sample_bit(evsel, REGS_INTR);
+			evsel->core.attr.sample_regs_user = 0;
+			evsel->core.attr.sample_regs_intr = 0;
 
 			if (evsel->core.attr.type == PERF_TYPE_BREAKPOINT)
 				evsel->core.attr.bp_addr = 0;
diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/shell/inject_aslr.sh
index d921287e849b..7eaa553371ce 100755
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
index 901b563048fa..457813812a34 100644
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
 struct aslr_tool {
 	/** @tool: The tool implemented here and a pointer to a delegate to process the data. */
 	struct delegate_tool tool;
@@ -54,6 +72,11 @@ struct aslr_tool {
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
@@ -143,9 +166,7 @@ static u64 aslr_tool__remap_address(struct aslr_tool *aslr,
 	key.machine = maps__machine(aslr_thread->maps);
 	key.dso = map__dso(al.map);
 	key.invariant = map__start(al.map) - map__pgoff(al.map);
-	key.pid = (effective_cpumode == PERF_RECORD_MISC_KERNEL ||
-		   effective_cpumode == PERF_RECORD_MISC_GUEST_KERNEL) ?
-		  kernel_pid : aslr_thread->pid_;
+	key.pid = effective_cpumode == PERF_RECORD_MISC_KERNEL ? kernel_pid : aslr_thread->pid_;
 
 	if (hashmap__find(&aslr->remap_addresses, &key, &remapped_invariant_ptr)) {
 		remap_addr = *remapped_invariant_ptr + map__pgoff(al.map) +
@@ -593,6 +614,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 	struct aslr_tool *aslr;
 	struct perf_tool *delegate;
 	int ret;
+	int orig_sample_size;
 	u64 sample_type;
 	struct thread *thread;
 	struct machine *aslr_machine;
@@ -605,12 +627,32 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
+
+	if (evsel__is_dummy_event(evsel))
+		return delegate->sample(delegate, event, sample, evsel, machine);
+
 	ret = -EFAULT;
-	sample_type = evsel->core.attr.sample_type;
+	orig_sample_type = evsel->core.attr.sample_type;
+	orig_regs_user = evsel->core.attr.sample_regs_user;
+	orig_regs_intr = evsel->core.attr.sample_regs_intr;
+
+	if (hashmap__find(&aslr->evsel_orig_attrs, evsel, &priv)) {
+		orig_sample_type = priv->orig_sample_type;
+		orig_regs_user = priv->orig_sample_regs_user;
+		orig_regs_intr = priv->orig_sample_regs_intr;
+	}
+
+	sample_type = orig_sample_type & ASLR_SUPPORTED_SAMPLE_TYPE;
+	sample_type &= ~PERF_SAMPLE_REGS_USER;
+	sample_type &= ~PERF_SAMPLE_REGS_INTR;
 	max_i = (event->header.size - sizeof(struct perf_event_header)) / sizeof(__u64);
 	max_j = (PERF_SAMPLE_MAX_SIZE - sizeof(struct perf_event_header)) / sizeof(__u64);
 	new_event = (union perf_event *)aslr->event_copy;
@@ -659,25 +701,25 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
@@ -711,7 +753,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 			}
 		}
 	}
-	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
+	if (orig_sample_type & PERF_SAMPLE_CALLCHAIN) {
 		u64 nr;
 
 		if (CHECK_BOUNDS(1, 1)) {
@@ -777,7 +819,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 			out_array[j++] = aslr_tool__remap_address(aslr, thread, cpumode, addr);
 		}
 	}
-	if (sample_type & PERF_SAMPLE_RAW) {
+	if (orig_sample_type & PERF_SAMPLE_RAW) {
 		size_t bytes = sizeof(u32) + sample->raw_size;
 		size_t u64_words = (bytes + 7) / 8;
 
@@ -796,7 +838,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 		ret = 0;
 		goto out_put;
 	}
-	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
+	if (orig_sample_type & PERF_SAMPLE_BRANCH_STACK) {
 		u64 nr;
 
 		if (CHECK_BOUNDS(1, 1)) {
@@ -841,7 +883,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 			goto out_put;
 		}
 	}
-	if (sample_type & PERF_SAMPLE_REGS_USER) {
+	if (orig_sample_type & PERF_SAMPLE_REGS_USER) {
 		u64 abi;
 
 		if (CHECK_BOUNDS(1, 0)) {
@@ -850,22 +892,16 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
@@ -898,13 +934,13 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
@@ -913,36 +949,30 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
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
@@ -983,8 +1013,22 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 
 	new_event->sample.header.size = sizeof(struct perf_event_header) + j * sizeof(u64);
 
+	/* Temporarily override evsel attributes to match the stripped new_event format! */
+	orig_sample_size = evsel->sample_size;
+	evsel->sample_size = __evsel__sample_size(sample_type);
+	evsel->core.attr.sample_type = sample_type;
+	evsel->core.attr.sample_regs_user = 0;
+	evsel->core.attr.sample_regs_intr = 0;
+
 	perf_sample__init(&new_sample, /*all=*/ true);
 	ret = evsel__parse_sample(evsel, new_event, &new_sample);
+
+	/* Restore original attributes immediately so trace ingestion never desynchronizes! */
+	evsel->sample_size = orig_sample_size;
+	evsel->core.attr.sample_type = orig_sample_type;
+	evsel->core.attr.sample_regs_user = orig_regs_user;
+	evsel->core.attr.sample_regs_intr = orig_regs_intr;
+
 	if (ret) {
 		perf_sample__exit(&new_sample);
 		goto out_put;
@@ -1010,6 +1054,7 @@ static int aslr_tool__process_attr(const struct perf_tool *tool,
 	struct aslr_tool *aslr;
 	struct perf_tool *delegate;
 	union perf_event *new_event;
+	int err;
 
 	del_tool = container_of(tool, struct delegate_tool, tool);
 	aslr = container_of(del_tool, struct aslr_tool, tool);
@@ -1020,9 +1065,32 @@ static int aslr_tool__process_attr(const struct perf_tool *tool,
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
@@ -1081,6 +1149,9 @@ static void aslr_tool__init(struct aslr_tool *aslr, struct perf_tool *delegate)
 	hashmap__init(&aslr->top_addresses,
 		      top_addresses__hash, top_addresses__equal,
 		      /*ctx=*/NULL);
+	hashmap__init(&aslr->evsel_orig_attrs,
+		      evsel_hash, evsel_equal,
+		      /*ctx=*/NULL);
 
 	aslr->tool.tool.sample	= aslr_tool__process_sample;
 	/* read - reads a counter, okay to delegate. */
@@ -1141,11 +1212,37 @@ void aslr_tool__delete(struct perf_tool *tool)
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

