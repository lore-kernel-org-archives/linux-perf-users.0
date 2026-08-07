Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECA73C4574
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 07:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087125; cv=none; b=rHhz2050VEEO2FTYTWmHFo5Yf3ATG6ZHkpbdIYdRi7OlkKnZqvOqXN8Dk2GlsZ4nd3+huJ8GQ3/SvW2VjK+dxOWbgqAGCAfmAFnXp+YMkwzbTRHDJn8ZKdoC4ckS0JiyFM7iPOH1ZfUBBNh9SPGUBujBXn1xYEXp+XD3uajfcX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087125; c=relaxed/simple;
	bh=LXygP1WyK73KB6sA2epD5GuUK5f4Z9RkXx5rDK/h2YE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=UlZSyHvXJGx6V17fzv2RbHpiwnC5E7wzSosP4E3jzo9NCmP3I7e9eLlj3niNSEfCAsFNwe/CsjMWYEkvj4Skd6/bCCnsjEIVERAu/FpPharSQvO3SUazIoA8mNx5976mXbySB+Ihoj1n8dMiN55BKCKd7wgtd0uiEE0BajXo/Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ez2rKt4M; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ez2rKt4M"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so3286466a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Aug 2026 00:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786087122; x=1786691922; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D49SGCmwUv9DYtsvbQQXcm3d16lOMTvO3Tc7LhywDzU=;
        b=ez2rKt4MmwLFXA38N2A+VKKvVw1AVsAnK2aHq2unK7utoxTIo43y+Yxnh2lRcNIM8O
         su1w4TYoOpRTmkNPlEwLhX+WCpbpEhNHS34WPOehDhd4TFqEP+PvRwglzlXqYAqJ6eGw
         uCogzQsZ98z+hSvII7BGRRMpKK5ruXiLbU5wP4h7sVzAYJLLbZUXmj61HYcHyIbFV+fp
         mMjREMF0xxtrWUm2E0D4ddPJIbtc0x9BWOTLOhoqzdCX9BkfYp9McNi/952y8OgyZJDk
         u0aAgltZNhMkS4xZ/x8Ig33548MI9N2OTqAHvF+K3RXENV9kSFisOKUtb0vYV8aK8RlV
         H/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786087122; x=1786691922;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D49SGCmwUv9DYtsvbQQXcm3d16lOMTvO3Tc7LhywDzU=;
        b=kii4YkTK5n6FItDTcWyk2eFjMFhLQ6ci0PRiLbfFZF1xmszweMSr88/DyL9UBXMDM7
         G2HQv1LT8p7piICDTSwY9JLfn0jaOTLuygB9e7RJAFF5dHF4BSnyXdozDkCnsheMiZ2W
         TiGhdl7o4KNA+WTiqJgprbbUA1i3b9ELWFY4M8vDCCWu+vPdAHUgNvu/MbbITJDpqa1L
         +gh7ymXixmQnwKRH9T4pfjIHQTD9zardadzV+NjQfjiumkIxQlT1F9whWOTL72tnpJi8
         n8d78whmJHK7EXrQ1X0Ozbm6O9l9wVm6OZQ2luLcaoradb2d/bcEVxCY01YEG8Y+L89s
         O2MA==
X-Forwarded-Encrypted: i=1; AHgh+RptetgGTrfKnN2H4H5r76hxpIklMbev+BoqRqc5CL+CYU7dwuXxShpRsAkuWLoobpdXorxN2faIXOD6Qj8t4K4y@vger.kernel.org
X-Gm-Message-State: AOJu0YxxtrWXVuhBIVXLa0Bi5Xhje7z9oGr+I5RDxt3p76HMkQOpzUOW
	YRzaY65a0YWXnDKY4MM1HtKyZF89MaaBRhrUkM7HWl6vgJY079FA4l/n1GrzTXenCI1exZ0nYXe
	byvPJHpOt0w==
X-Received: from dlah26.prod.google.com ([2002:a05:701b:261a:b0:13d:2928:7996])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53cf:b0:37f:b0a9:1a68
 with SMTP id 98e67ed59e1d1-3903c54b340mr21304002a91.7.1786087121801; Fri, 07
 Aug 2026 00:18:41 -0700 (PDT)
Date: Fri,  7 Aug 2026 00:18:18 -0700
In-Reply-To: <20260807071818.718751-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807071818.718751-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807071818.718751-9-irogers@google.com>
Subject: [RFC PATCH v1 8/8] perf tests: Add build_id_offset test coverage
From: Ian Rogers <irogers@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Eric Biggers <ebiggers@kernel.org>, Zecheng Li <zli94@ncsu.edu>, 
	Gabriel Marin <gmx@google.com>, Tengda Wu <wutengda@huaweicloud.com>, 
	Derek Foreman <derek.foreman@collabora.com>, Tanushree Shah <tshah@linux.ibm.com>, 
	Ankur Arora <ankur.a.arora@oracle.com>, Aaron Tomlin <atomlin@atomlin.com>, tanze <tanze@kylinos.cn>, 
	Rui Qi <qirui.001@bytedance.com>, Howard Chu <howardchu95@gmail.com>, 
	Chuck Lever <cel@kernel.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Alessio Podda <aleph.pi.gh@gmail.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Test the kernel interface using sys_perf_event_open, test perf inject
--sample-buildids with pipe mode and callchains, and test perf record
--buildid-offset across multiple sampling modes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/Build                      |   1 +
 tools/perf/tests/bid-offset.c               |  60 +++++++
 tools/perf/tests/builtin-test.c             |   1 +
 tools/perf/tests/mmap-thread-lookup.c       |  36 +++++
 tools/perf/tests/sample-parsing.c           |  37 ++++-
 tools/perf/tests/shell/inject_bid_offset.sh | 170 ++++++++++++++++++++
 tools/perf/tests/shell/record.sh            |  69 ++++++++
 tools/perf/tests/tests.h                    |   1 +
 8 files changed, 374 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/bid-offset.c
 create mode 100755 tools/perf/tests/shell/inject_bid_offset.sh

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 66944a4f4968..f7f8c4deba30 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -64,6 +64,7 @@ perf-test-y += expand-cgroup.o
 perf-test-y += perf-time-to-tsc.o
 perf-test-y += dlfilter-test.o
 perf-test-y += sigtrap.o
+perf-test-y += bid-offset.o
 perf-test-y += event_groups.o
 perf-test-y += symbols.o
 perf-test-y += util.o
diff --git a/tools/perf/tests/bid-offset.c b/tools/perf/tests/bid-offset.c
new file mode 100644
index 000000000000..f7d85491832f
--- /dev/null
+++ b/tools/perf/tests/bid-offset.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "tests.h"
+#include "debug.h"
+#include "evlist.h"
+#include "evsel.h"
+#include <linux/hw_breakpoint.h>
+#include <linux/perf_event.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+#include <errno.h>
+#include "../perf-sys.h"
+
+static int test__bid_offset(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	struct perf_event_attr attr = {
+		.type		= PERF_TYPE_SOFTWARE,
+		.config		= PERF_COUNT_SW_DUMMY,
+		.size		= sizeof(attr),
+		.sample_type	= PERF_SAMPLE_BUILD_ID_OFFSET,
+		.exclude_kernel = 1,
+		.exclude_hv     = 1,
+	};
+	int fd;
+
+	fd = sys_perf_event_open(&attr, /*pid=*/0, /*cpu=*/-1, /*group_fd=*/-1, /*flags=*/0);
+	if (fd < 0) {
+		pr_debug("sys_perf_event_open failed with %d\n", errno);
+		if (errno == EINVAL) {
+			pr_debug("Kernel does not support PERF_SAMPLE_BUILD_ID_OFFSET\n");
+			return TEST_SKIP;
+		}
+		return TEST_FAIL;
+	}
+	close(fd);
+
+	attr.sample_type = PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET;
+	fd = sys_perf_event_open(&attr, /*pid=*/0, /*cpu=*/-1, /*group_fd=*/-1, /*flags=*/0);
+	if (fd < 0) {
+		pr_debug("sys_perf_event_open with callchain failed with %d\n", errno);
+		if (errno == EINVAL) {
+			pr_debug("Kernel does not support PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET\n");
+			return TEST_SKIP;
+		}
+		return TEST_FAIL;
+	}
+	close(fd);
+
+	return TEST_OK;
+}
+
+static struct test_case bid_offset_tests[] = {
+	TEST_CASE_REASON("Test PERF_SAMPLE_BUILD_ID_OFFSET", bid_offset,
+			 "not supported by kernel"),
+	{ .name = NULL, }
+};
+
+struct test_suite suite__bid_offset = {
+	.desc = "Test PERF_SAMPLE_BUILD_ID_OFFSET",
+	.test_cases = bid_offset_tests,
+};
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 41dcfbf874f0..afc9c7efe009 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -148,6 +148,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__perf_time_to_tsc,
 	&suite__dlfilter,
 	&suite__sigtrap,
+	&suite__bid_offset,
 	&suite__event_groups,
 	&suite__symbols,
 	&suite__util,
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index dca8bbfe780a..65c72ed896ac 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -17,6 +17,8 @@
 #include "symbol.h"
 #include "util/synthetic-events.h"
 #include "thread.h"
+#include "dso.h"
+#include "build-id.h"
 #include <internal/lib.h> // page_size
 
 #define THREADS 4
@@ -211,6 +213,40 @@ static int mmap_events(synth_cb synth)
 
 		pr_debug("map %p, addr %" PRIx64 "\n", al.map, map__start(al.map));
 
+		/* Verify lookup by build ID and offset */
+		{
+			struct dso *dso = dso__get(map__dso(al.map));
+
+			if (dso) {
+				const struct build_id *bid = dso__bid(dso);
+
+				if (bid && bid->size > 0) {
+					struct addr_location al2;
+					struct perf_build_id pbid = { .size = bid->size };
+					u64 offset = map__dso_map_ip(al.map,
+								     (unsigned long)(td->map + 1));
+
+					memcpy(pbid.data, bid->data, bid->size);
+					addr_location__init(&al2);
+					thread__find_map(thread, &(struct perf_sample){
+								.cpumode = PERF_RECORD_MISC_USER,
+								.ip = 0,
+								.bid = {
+									.bid = &pbid,
+									.offset = offset,
+								},
+							 }, &al2);
+
+					if (al2.map != al.map) {
+						pr_debug("failed, couldn't find map by build id and offset\n");
+						err = -1;
+					}
+					addr_location__exit(&al2);
+				}
+				dso__put(dso);
+			}
+		}
+
 		addr_location__exit(&al);
 		if (err)
 			break;
diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 20cab91ceaeb..b49b6dcf10cd 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -229,6 +229,36 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 	const u32 raw_data[] = {0x12345678, 0x0a0b0c0d, 0x11020304, 0x05060708, 0 };
 	const u64 data[] = {0x2211443366558877ULL, 0, 0xaabbccddeeff4321ULL};
 	const u64 aux_data[] = {0xa55a, 0, 0xeeddee, 0x0282028202820282};
+	const struct perf_build_id bid = {
+		.size = 20,
+		.data = {
+			'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
+			'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
+		}
+	};
+	const struct perf_build_id callchain_bids[] = {
+		{
+			.size = 20,
+			.data = {
+				'9', '8', '7', '6', '5', '4', '3', '2', '1', '0',
+				'9', '8', '7', '6', '5', '4', '3', '2', '1', '0',
+			}
+		},
+		{
+			.size = 20,
+			.data = {
+				'a', 'b', 'c', 'd', 'e', 'f', 'a', 'b', 'c', 'd',
+				'e', 'f', 'a', 'b', 'c', 'd', 'e', 'f', 'a', 'b',
+			}
+		},
+		{
+			.size = 20,
+			.data = {
+				'f', 'e', 'd', 'c', 'b', 'a', 'f', 'e', 'd', 'c',
+				'b', 'a', 'f', 'e', 'd', 'c', 'b', 'a', 'f', 'e',
+			}
+		},
+	};
 	struct regs_dump user_regs = {
 		.abi	= PERF_SAMPLE_REGS_ABI_64,
 		.mask	= sample_regs,
@@ -277,6 +307,11 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 			.size	= sizeof(aux_data),
 			.data	= (void *)aux_data,
 		},
+		.bid		= {
+			.bid = (struct perf_build_id *)&bid,
+			.offset = 0,
+		},
+		.callchain_bids = (struct perf_build_id *)callchain_bids,
 	};
 	struct sample_read_value values[] = {{1, 5, 0}, {9, 3, 0}, {2, 7, 0}, {6, 4, 1},};
 	struct perf_sample sample_out, sample_out_endian;
@@ -409,7 +444,7 @@ static int test__sample_parsing(struct test_suite *test __maybe_unused, int subt
 	 * were added.  Please actually update the test rather than just change
 	 * the condition below.
 	 */
-	if (PERF_SAMPLE_MAX > PERF_SAMPLE_WEIGHT_STRUCT << 1) {
+	if (PERF_SAMPLE_WEIGHT_STRUCT << 3 < PERF_SAMPLE_MAX) {
 		pr_debug("sample format has changed, some new PERF_SAMPLE_ bit was introduced - test needs updating\n");
 		return -1;
 	}
diff --git a/tools/perf/tests/shell/inject_bid_offset.sh b/tools/perf/tests/shell/inject_bid_offset.sh
new file mode 100755
index 000000000000..eac0a19f24e1
--- /dev/null
+++ b/tools/perf/tests/shell/inject_bid_offset.sh
@@ -0,0 +1,170 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# perf inject --sample-buildids test
+
+set -e
+set -o pipefail
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/perf_has_symbol.sh
+. "${shelldir}"/lib/perf_has_symbol.sh
+
+sym="noploop"
+
+skip_test_missing_symbol ${sym}
+
+temp_dir=$(mktemp -d /tmp/perf-test-bid-offset.XXXXXXXXXX)
+
+prog="perf test -w noploop"
+[ "$(uname -m)" = "s390x" ] && prog="$prog 3"
+err=0
+
+cleanup() {
+	local exit_code=${1:-$?}
+	trap - EXIT TERM INT
+	if [ "${exit_code}" -ne 0 ] || [ "${err}" -ne 0 ]; then
+		echo "Test failed! Preserving temp directory: ${temp_dir}"
+		exit 1
+	fi
+	if [[ "${temp_dir}" =~ ^/tmp/perf-test-bid-offset\. ]]; then
+		rm -rf "${temp_dir}"
+	fi
+	exit 0
+}
+
+trap_cleanup() {
+	local exit_code=$?
+	echo "Unexpected signal in ${FUNCNAME[1]}"
+	cleanup ${exit_code}
+}
+trap trap_cleanup EXIT TERM INT
+
+compare_script() {
+	local orig=$1
+	local bid=$2
+	local msg=$3
+
+	perf script -F -ip -i "${orig}" > "${temp_dir}/script_orig.txt"
+	perf script -F -ip -i "${bid}" > "${temp_dir}/script_bid.txt"
+
+	if ! diff -q "${temp_dir}/script_orig.txt" "${temp_dir}/script_bid.txt"; then
+		echo "${msg} [Failed - perf script output differs]"
+		err=1
+	else
+		echo "${msg} [Success]"
+	fi
+}
+
+compare_report() {
+	local orig=$1
+	local bid=$2
+	local msg=$3
+
+	perf report -i "${orig}" --stdio | grep -v '^#' > "${temp_dir}/report_orig.txt"
+	perf report -i "${bid}" --stdio | grep -v '^#' > "${temp_dir}/report_bid.txt"
+
+	if ! diff -q "${temp_dir}/report_orig.txt" "${temp_dir}/report_bid.txt"; then
+		echo "${msg} [Failed - perf report output differs]"
+		err=1
+	else
+		echo "${msg} [Success]"
+	fi
+}
+
+test_basic() {
+	echo "Test basic build id offset injection"
+	local data="${temp_dir}/perf.data.basic"
+	local data2="${temp_dir}/perf.data2.basic"
+
+	perf record -e task-clock:u -o "${data}" ${prog} >/dev/null 2>&1
+	perf inject --sample-buildids -i "${data}" -o "${data2}" >/dev/null 2>&1
+
+	compare_script "${data}" "${data2}" "Basic injection"
+}
+
+test_callchain() {
+	echo "Test Callchain build id offset injection"
+	local data="${temp_dir}/perf.data.callchain"
+	local data2="${temp_dir}/perf.data2.callchain"
+
+	perf record -g -e task-clock:u -o "${data}" ${prog} >/dev/null 2>&1
+	perf inject --sample-buildids -i "${data}" -o "${data2}" >/dev/null 2>&1
+
+	compare_script "${data}" "${data2}" "Callchain injection"
+}
+
+test_pipe() {
+	echo "Test pipe mode build id offset injection"
+	local data="${temp_dir}/perf.data.pipe"
+	local data2="${temp_dir}/perf.data2.pipe"
+
+	perf record -e task-clock:u -o - ${prog} 2>/dev/null | tee "${data}" | \
+		perf inject --sample-buildids -o "${data2}" >/dev/null 2>&1
+
+	compare_script "${data}" "${data2}" "Pipe mode injection"
+}
+
+test_report() {
+	echo "Test perf report consistency"
+	local data="${temp_dir}/perf.data.report"
+	local data2="${temp_dir}/perf.data2.report"
+
+	perf record -e task-clock:u -o "${data}" ${prog} >/dev/null 2>&1
+	perf inject --sample-buildids -i "${data}" -o "${data2}" >/dev/null 2>&1
+
+	compare_report "${data}" "${data2}" "Report consistency"
+}
+
+test_pipe_report() {
+	echo "Test pipe mode perf report consistency"
+	local data="${temp_dir}/perf.data.pipe_report"
+	local data2="${temp_dir}/perf.data2.pipe_report"
+
+	perf record -e task-clock:u -o - ${prog} 2>/dev/null | tee "${data}" | \
+		perf inject --sample-buildids -o "${data2}" >/dev/null 2>&1
+
+	compare_report "${data}" "${data2}" "Pipe Report consistency"
+}
+
+test_kernel() {
+	echo "Test kernel build id offset injection"
+	local data="${temp_dir}/perf.data.kernel"
+	local data2="${temp_dir}/perf.data2.kernel"
+
+	# Not all systems allow kernel profiling, so we check if it succeeds first
+	if ! perf record -e task-clock:k -o "${data}" ${prog} >/dev/null 2>&1; then
+		echo "Kernel injection [Skipped - permissions or support missing]"
+		return
+	fi
+	perf inject --sample-buildids -i "${data}" -o "${data2}" >/dev/null 2>&1
+
+	compare_script "${data}" "${data2}" "Kernel injection"
+}
+
+test_record_buildid_offset() {
+	echo "Test perf record --buildid-offset consistency"
+	local data="${temp_dir}/perf.data.record_orig"
+	local data2="${temp_dir}/perf.data2.record_bid"
+
+	perf record -e task-clock:u -o "${data}" ${prog} >/dev/null 2>&1
+	# We must have the binaries in .build-id cache, which the first record does natively.
+	# Now record with --buildid-offset.
+	if ! perf record --buildid-offset -e task-clock:u -o "${data2}" \
+	    ${prog} >/dev/null 2>&1; then
+		echo "Record --buildid-offset consistency [Skipped - not supported by kernel]"
+		return
+	fi
+
+	# Compare symbolization
+	compare_report "${data}" "${data2}" "Record --buildid-offset consistency"
+}
+
+test_basic
+test_callchain
+test_pipe
+test_report
+test_pipe_report
+test_kernel
+test_record_buildid_offset
+
+cleanup ${err}
diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 625240809fce..9346741b19c9 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -484,6 +484,74 @@ test_ratio_to_prev() {
   echo "Basic ratio-to-prev record test [Success]"
 }
 
+check_buildid_offset() {
+  perf report -D -i "${perfdata}" -q 2>/dev/null | grep -q "BUILD_ID_OFFSET"
+}
+
+test_buildid_offset() {
+  echo "buildid-offset test"
+  local ret=0
+  perf_record_with_retry "${perfdata}" "check_buildid_offset" "perf test -w thloop" \
+    --buildid-offset || ret=$?
+  if [ $ret -eq 2 ]; then
+    echo "buildid-offset test [Skipped not supported]"
+    return
+  elif [ $ret -eq 1 ]; then
+    echo "buildid-offset test [Failed missing output]"
+    err=1
+    return
+  fi
+
+  # Expand test coverage
+  perf_record_with_retry "${perfdata}" "check_per_thread" "perf test -w thloop" \
+    --buildid-offset --per-thread || ret=$?
+  if [ $ret -ne 0 ]; then
+    echo "buildid-offset test [Failed per-thread]"
+    err=1
+    return
+  fi
+
+  perf_record_with_retry "${perfdata}" "check_system_wide" "perf test -w thloop" \
+    --buildid-offset -aB --synth=no || ret=$?
+  if [ $ret -ne 0 ]; then
+    echo "buildid-offset test [Failed system-wide]"
+    err=1
+    return
+  fi
+
+  perf_record_with_retry "${perfdata}" "check_workload" "perf test -w thloop" \
+    --buildid-offset || ret=$?
+  if [ $ret -ne 0 ]; then
+    echo "buildid-offset test [Failed workload]"
+    err=1
+    return
+  fi
+
+  case $(uname -m)
+  in s390x)
+       cmd_flags="--call-graph dwarf -e cpu-clock";;
+     *)
+       cmd_flags="-g";;
+  esac
+
+  if ! perf record --buildid-offset -o "${perfdata}" $cmd_flags \
+    perf test -w brstack > /dev/null 2>&1
+  then
+    echo "buildid-offset test [Failed callgraph record]"
+    err=1
+    return
+  fi
+
+  if ! perf report -i "${perfdata}" 2>&1 | grep -q "${testsym2}"
+  then
+    echo "buildid-offset test [Failed callgraph missing symbol]"
+    err=1
+    return
+  fi
+
+  echo "buildid-offset test [Success]"
+}
+
 # raise the limit of file descriptors to minimum
 if [[ $default_fd_limit -lt $min_fd_limit ]]; then
        ulimit -Sn $min_fd_limit
@@ -502,6 +570,7 @@ test_precise_max
 test_callgraph
 test_acr_sampling
 test_ratio_to_prev
+test_buildid_offset
 
 # restore the default value
 ulimit -Sn $default_fd_limit
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index cee9e6b62dcc..b718ae148245 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -176,6 +176,7 @@ DECLARE_SUITE(expand_cgroup_events);
 DECLARE_SUITE(perf_time_to_tsc);
 DECLARE_SUITE(dlfilter);
 DECLARE_SUITE(sigtrap);
+DECLARE_SUITE(bid_offset);
 DECLARE_SUITE(event_groups);
 DECLARE_SUITE(symbols);
 DECLARE_SUITE(util);
-- 
2.55.0.679.g6767b8d81c-goog

