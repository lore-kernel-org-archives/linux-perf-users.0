Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86322F617C;
	Thu, 21 May 2026 01:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325904; cv=none; b=ucDYbP1tll5ctZdiemthak38vTt5jr83STQ//+BaKrt7I80mV3cv4cvwrr9/aLwd6AovbHVmc1HQWVlj8Nl3EPtcfFB+jn7Va7WuBHoIIDMASBQ3lvFReWP6Ia5lWjxEaI67vp4Ep2vFtaqWWlD4Z4fDZ8u1mnkPXq52JfB4ncA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325904; c=relaxed/simple;
	bh=PW41cv5kXkdVpS3ZUbxhHvzBh07qB1+iU3fAm3UazT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfC+3lCvTmKj/jGzYuj5RRwv7FeWjkv8sOkqsP0enSeS70NwGybp2o9cWuXgnxXhgeG3ss5PKB+9XP65eIsYCCW93Eu0M+KcNUnobRWA2/j7g+C5rhK6YWuZFoQ71NUgWomwvpdJiM6AXjtDH0Adrs7YqnZ9L/KkL2K7TuImHJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQ+Ogf+3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQ+Ogf+3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98ADC1F000E9;
	Thu, 21 May 2026 01:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779325902;
	bh=6Rf93g36W5u+pwfA73fWl4dUNPCQ7xkBt/ZPk9vIo8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JQ+Ogf+3ryLkL9PIYsX6aa1jzAPVrPc0h4umBFVj8eZmfK94D0zKEPBZGCe2Bk6lA
	 8V8HZB7ICrPUbTaRzLdBLn/fAX8NFZo80g12o2vwEjRDliK6xkFK+1qUTRQQKqflSg
	 cMB7t65IbJ5SI2PaZoPneURZj7CsUMdqnNCLiPy/iIBv261rjDmJ/jHZkCOtS7sKPp
	 VAUUetLORDnGxXzvz0Fa4vJdKly9x/wCmzRsaPjiXRNL51qJxudcP+qq7/Sox6Rj+H
	 mK6EnV1/stpSj3cSKGvcvDRfcyMQVGP49+s/yxT8lS4b8S8m8cAd/jwQqVAxlYBUds
	 ahcftPIy/g0uQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot@kernel.org,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 16/27] perf tools: Bounds check perf_event_attr fields against attr.size before printing
Date: Wed, 20 May 2026 22:10:01 -0300
Message-ID: <20260521011027.622268-17-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521011027.622268-1-acme@kernel.org>
References: <20260521011027.622268-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

perf_event_attr__fprintf() accessed all struct fields unconditionally,
but attrs from older perf.data files or BPF-captured syscall payloads
may have a smaller size than the current struct.  Fields beyond the
recorded size contain uninitialized or zero-filled data.

Add size-guarded macros (PRINT_ATTRn, PRINT_ATTRn_bf) that compare
each field's offset against attr->size before accessing it.

Guard the bitfield block (disabled, inherit, ... defer_output) with
attr_size >= 48.  These bitfields share a single __u64 at offset 40,
which is within PERF_ATTR_SIZE_VER0 for validated perf.data attrs,
but BPF-captured attrs from perf trace can have a smaller size when
the tracee passes a minimal struct to sys_perf_event_open.

Also fix the BPF trace path: when perf trace intercepts
sys_perf_event_open via BPF, the program copies PERF_ATTR_SIZE_VER0
bytes when the tracee passes size=0, but leaves the size field as 0.
Set attr->size to PERF_ATTR_SIZE_VER0 in the augmented syscall
handler so the bounds checks match the actual copied size.

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/perf_event_open.c |  20 ++-
 tools/perf/util/perf_event_attr_fprintf.c | 141 ++++++++++++++--------
 2 files changed, 111 insertions(+), 50 deletions(-)

diff --git a/tools/perf/trace/beauty/perf_event_open.c b/tools/perf/trace/beauty/perf_event_open.c
index c1c7445dcff994cb..42a8d2f0e0f161b7 100644
--- a/tools/perf/trace/beauty/perf_event_open.c
+++ b/tools/perf/trace/beauty/perf_event_open.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: LGPL-2.1
+#include <string.h>
 #include "trace/beauty/beauty.h"
 #include "util/evsel_fprintf.h"
 #include <linux/perf_event.h>
@@ -80,7 +81,24 @@ static size_t perf_event_attr___scnprintf(struct perf_event_attr *attr, char *bf
 
 static size_t syscall_arg__scnprintf_augmented_perf_event_attr(struct syscall_arg *arg, char *bf, size_t size)
 {
-	return perf_event_attr___scnprintf((void *)arg->augmented.args->value, bf, size,
+	struct perf_event_attr *attr = (void *)arg->augmented.args->value;
+	struct perf_event_attr local_attr;
+
+	/*
+	 * The BPF program copies PERF_ATTR_SIZE_VER0 bytes when the
+	 * tracee passes size=0, but leaves the size field as 0.
+	 * Copy to a local so we can fix up size without writing to
+	 * the potentially read-only augmented args buffer.
+	 */
+	if (!attr->size) {
+		memcpy(&local_attr, attr, PERF_ATTR_SIZE_VER0);
+		memset((void *)&local_attr + PERF_ATTR_SIZE_VER0, 0,
+		       sizeof(local_attr) - PERF_ATTR_SIZE_VER0);
+		local_attr.size = PERF_ATTR_SIZE_VER0;
+		attr = &local_attr;
+	}
+
+	return perf_event_attr___scnprintf(attr, bf, size,
 					   trace__show_zeros(arg->trace));
 }
 
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 741c3d657a8b6ae7..3933639d76c54bb3 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -275,24 +275,56 @@ static void __p_config_id(struct perf_pmu *pmu, char *buf, size_t size, u32 type
 #define p_type_id(val)		__p_type_id(buf, BUF_SIZE, pmu, val)
 #define p_config_id(val)	__p_config_id(pmu, buf, BUF_SIZE, attr->type, val)
 
-#define PRINT_ATTRn(_n, _f, _p, _a)			\
-do {							\
-	if (_a || attr->_f) {				\
-		_p(attr->_f);				\
-		ret += attr__fprintf(fp, _n, buf, priv);\
-	}						\
+#define PRINT_ATTRn(_n, _f, _p, _a)					\
+do {									\
+	if (attr_size >= offsetof(struct perf_event_attr, _f) +		\
+			 sizeof(attr->_f) &&				\
+	    (_a || attr->_f)) {						\
+		_p(attr->_f);						\
+		ret += attr__fprintf(fp, _n, buf, priv);		\
+	}								\
+} while (0)
+
+/* bitfield members share an offset; most are within PERF_ATTR_SIZE_VER0 */
+#define PRINT_ATTRn_bf(_n, _f, _p, _a)					\
+do {									\
+	if (_a || attr->_f) {						\
+		_p(attr->_f);						\
+		ret += attr__fprintf(fp, _n, buf, priv);		\
+	}								\
 } while (0)
 
 #define PRINT_ATTRf(_f, _p)	PRINT_ATTRn(#_f, _f, _p, false)
+#define PRINT_ATTRf_bf(_f, _p)	PRINT_ATTRn_bf(#_f, _f, _p, false)
 
 int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 			     attr__fprintf_f attr__fprintf, void *priv)
 {
 	struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
+	/*
+	 * size == 0 means ABI0 — the producer didn't set attr.size.
+	 * perf_event__fprintf_attr() may pass the raw mmap'd event
+	 * before the local copy, so default to PERF_ATTR_SIZE_VER0
+	 * (the ABI0 footprint) to avoid reading past the attr into
+	 * the ID array that follows it in HEADER_ATTR events.
+	 */
+	u32 attr_size = attr->size ?: PERF_ATTR_SIZE_VER0;
 	char buf[BUF_SIZE];
 	int ret = 0;
 
-	if (!pmu && (attr->type == PERF_TYPE_HARDWARE || attr->type == PERF_TYPE_HW_CACHE)) {
+	/*
+	 * Cap to what we understand: all callers store the attr in a
+	 * buffer of sizeof(*attr) bytes (perf.data read path copies
+	 * min(attr.size, sizeof), BPF augmented path copies into a
+	 * fixed-size value[] array).  A spoofed attr->size larger
+	 * than sizeof would cause PRINT_ATTRn to read past the
+	 * actual buffer.
+	 */
+	if (attr_size > sizeof(*attr))
+		attr_size = sizeof(*attr);
+
+	if (!pmu && attr_size >= offsetof(struct perf_event_attr, config) + sizeof(attr->config) &&
+	    (attr->type == PERF_TYPE_HARDWARE || attr->type == PERF_TYPE_HW_CACHE)) {
 		u32 extended_type = attr->config >> PERF_PMU_TYPE_SHIFT;
 
 		if (extended_type)
@@ -306,45 +338,53 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(sample_type, p_sample_type);
 	PRINT_ATTRf(read_format, p_read_format);
 
-	PRINT_ATTRf(disabled, p_unsigned);
-	PRINT_ATTRf(inherit, p_unsigned);
-	PRINT_ATTRf(pinned, p_unsigned);
-	PRINT_ATTRf(exclusive, p_unsigned);
-	PRINT_ATTRf(exclude_user, p_unsigned);
-	PRINT_ATTRf(exclude_kernel, p_unsigned);
-	PRINT_ATTRf(exclude_hv, p_unsigned);
-	PRINT_ATTRf(exclude_idle, p_unsigned);
-	PRINT_ATTRf(mmap, p_unsigned);
-	PRINT_ATTRf(comm, p_unsigned);
-	PRINT_ATTRf(freq, p_unsigned);
-	PRINT_ATTRf(inherit_stat, p_unsigned);
-	PRINT_ATTRf(enable_on_exec, p_unsigned);
-	PRINT_ATTRf(task, p_unsigned);
-	PRINT_ATTRf(watermark, p_unsigned);
-	PRINT_ATTRf(precise_ip, p_unsigned);
-	PRINT_ATTRf(mmap_data, p_unsigned);
-	PRINT_ATTRf(sample_id_all, p_unsigned);
-	PRINT_ATTRf(exclude_host, p_unsigned);
-	PRINT_ATTRf(exclude_guest, p_unsigned);
-	PRINT_ATTRf(exclude_callchain_kernel, p_unsigned);
-	PRINT_ATTRf(exclude_callchain_user, p_unsigned);
-	PRINT_ATTRf(mmap2, p_unsigned);
-	PRINT_ATTRf(comm_exec, p_unsigned);
-	PRINT_ATTRf(use_clockid, p_unsigned);
-	PRINT_ATTRf(context_switch, p_unsigned);
-	PRINT_ATTRf(write_backward, p_unsigned);
-	PRINT_ATTRf(namespaces, p_unsigned);
-	PRINT_ATTRf(ksymbol, p_unsigned);
-	PRINT_ATTRf(bpf_event, p_unsigned);
-	PRINT_ATTRf(aux_output, p_unsigned);
-	PRINT_ATTRf(cgroup, p_unsigned);
-	PRINT_ATTRf(text_poke, p_unsigned);
-	PRINT_ATTRf(build_id, p_unsigned);
-	PRINT_ATTRf(inherit_thread, p_unsigned);
-	PRINT_ATTRf(remove_on_exec, p_unsigned);
-	PRINT_ATTRf(sigtrap, p_unsigned);
-	PRINT_ATTRf(defer_callchain, p_unsigned);
-	PRINT_ATTRf(defer_output, p_unsigned);
+	/*
+	 * All bitfields share a single __u64 right after read_format.
+	 * BPF-captured attrs from perf trace may have a small size
+	 * when the tracee passes a minimal struct, so skip the
+	 * entire block when it's not covered.
+	 */
+	if (attr_size >= offsetof(struct perf_event_attr, wakeup_events)) {
+		PRINT_ATTRf_bf(disabled, p_unsigned);
+		PRINT_ATTRf_bf(inherit, p_unsigned);
+		PRINT_ATTRf_bf(pinned, p_unsigned);
+		PRINT_ATTRf_bf(exclusive, p_unsigned);
+		PRINT_ATTRf_bf(exclude_user, p_unsigned);
+		PRINT_ATTRf_bf(exclude_kernel, p_unsigned);
+		PRINT_ATTRf_bf(exclude_hv, p_unsigned);
+		PRINT_ATTRf_bf(exclude_idle, p_unsigned);
+		PRINT_ATTRf_bf(mmap, p_unsigned);
+		PRINT_ATTRf_bf(comm, p_unsigned);
+		PRINT_ATTRf_bf(freq, p_unsigned);
+		PRINT_ATTRf_bf(inherit_stat, p_unsigned);
+		PRINT_ATTRf_bf(enable_on_exec, p_unsigned);
+		PRINT_ATTRf_bf(task, p_unsigned);
+		PRINT_ATTRf_bf(watermark, p_unsigned);
+		PRINT_ATTRf_bf(precise_ip, p_unsigned);
+		PRINT_ATTRf_bf(mmap_data, p_unsigned);
+		PRINT_ATTRf_bf(sample_id_all, p_unsigned);
+		PRINT_ATTRf_bf(exclude_host, p_unsigned);
+		PRINT_ATTRf_bf(exclude_guest, p_unsigned);
+		PRINT_ATTRf_bf(exclude_callchain_kernel, p_unsigned);
+		PRINT_ATTRf_bf(exclude_callchain_user, p_unsigned);
+		PRINT_ATTRf_bf(mmap2, p_unsigned);
+		PRINT_ATTRf_bf(comm_exec, p_unsigned);
+		PRINT_ATTRf_bf(use_clockid, p_unsigned);
+		PRINT_ATTRf_bf(context_switch, p_unsigned);
+		PRINT_ATTRf_bf(write_backward, p_unsigned);
+		PRINT_ATTRf_bf(namespaces, p_unsigned);
+		PRINT_ATTRf_bf(ksymbol, p_unsigned);
+		PRINT_ATTRf_bf(bpf_event, p_unsigned);
+		PRINT_ATTRf_bf(aux_output, p_unsigned);
+		PRINT_ATTRf_bf(cgroup, p_unsigned);
+		PRINT_ATTRf_bf(text_poke, p_unsigned);
+		PRINT_ATTRf_bf(build_id, p_unsigned);
+		PRINT_ATTRf_bf(inherit_thread, p_unsigned);
+		PRINT_ATTRf_bf(remove_on_exec, p_unsigned);
+		PRINT_ATTRf_bf(sigtrap, p_unsigned);
+		PRINT_ATTRf_bf(defer_callchain, p_unsigned);
+		PRINT_ATTRf_bf(defer_output, p_unsigned);
+	}
 
 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned, false);
 	PRINT_ATTRf(bp_type, p_unsigned);
@@ -359,9 +399,12 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(sample_max_stack, p_unsigned);
 	PRINT_ATTRf(aux_sample_size, p_unsigned);
 	PRINT_ATTRf(sig_data, p_unsigned);
-	PRINT_ATTRf(aux_start_paused, p_unsigned);
-	PRINT_ATTRf(aux_pause, p_unsigned);
-	PRINT_ATTRf(aux_resume, p_unsigned);
+	/* aux_{start_paused,pause,resume} are at byte 116, past VER0 */
+	if (attr_size >= offsetof(struct perf_event_attr, sig_data)) {
+		PRINT_ATTRf_bf(aux_start_paused, p_unsigned);
+		PRINT_ATTRf_bf(aux_pause, p_unsigned);
+		PRINT_ATTRf_bf(aux_resume, p_unsigned);
+	}
 
 	return ret;
 }
-- 
2.54.0

