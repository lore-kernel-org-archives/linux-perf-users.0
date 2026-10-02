Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDD85013C3
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962787; cv=none; b=KSXNId2ZnAiVQ6YDQpSmtG8o2XXWzZTsgVeylbjWSWphW7IqKFxcwpNYOX1ct4zMIlfbm3WEUpcwIwiO8FU//LSD/RNVnGJRapAYzkzosQyq2994nSbHF3F4+Cow17pJB1wNblNqwxSy3wrR7T+dPM1lf26UpVbv8J4IgBazYbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962787; c=relaxed/simple;
	bh=B9UaMXUEzu3GectdPjuOor6tKAniolgn9w8y6yvJqyk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ch8zj2y5YdUAH8/xzbCi+uYgBQ+rNHNi667gZFIpIRRjPAVuzIUM5TcMXe2bbAd8YPIdSSdS8CFQp0fYj3aKvs3S2U2SrDJ9tWdQvH8zf1HccTBw/JEtlidJmI+THte4Svd3COnWiX1G8oYTeXDS064sEniKaTLwlfWtkmHCLgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nyejgZJV; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nyejgZJV"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-14fed306427so2499331c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 10:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790962771; x=1791567571; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7c1mt0z3W07nSZQ8r5yH46wePaDswp/fxIS955AF/VM=;
        b=nyejgZJVdgiH35Sw41guO5MEfKol7uKOsy6iA2ma7oKPgHARCdue7c5CZHK8AiytPu
         2Imi9zRsvN4J16HA151EN0ootsPM2fiTZB946k0pju8ouFfDtP3rxG0zEc5YNXv+r/Cx
         Uu2f9R0EIu7rNMcDepfm20NnCQjh8j/sS+NoVyGn/W48aPnRizltKbAT5iq1t/M93Iox
         vFp42xCUXvPyzZ/Y2wEUfJX/S8Znnc5z6Na8wwo9k1rTHSmpc7eGOKNZaFUs7Arm57Ug
         HsDEKvNKCTMdfTWL/LFk1ri/mQwj9EvuGim7iSxd2WV1MTG6+eJ0t6STdqdgNH4ordFj
         aALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790962771; x=1791567571;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7c1mt0z3W07nSZQ8r5yH46wePaDswp/fxIS955AF/VM=;
        b=HhDNRrm3SXwzY/feDY2chvN3oDBMf8VrwdXMaNKS0mXUVPHRzRQ8+YmkXe2F28Twyb
         kjfeWhZE/y1C1JAIsAzXhOpP6SFWz0kbCy15PpIOzbthQbUGwEmG2Z6pwDG/ZMepIwdG
         up35p6wa72yRQGjSN2CMZv5vynmNct+Uffr3qQkjNi3WE87fhlwcy/+QTJWUodT1188m
         NxfZ/fYu2KZ2J47XkMElJqKFdtcccYAFoD8M+lvKgd8kq1Duk6d4nhvMO6JUrzkkbBgM
         TTWmQztJ9D6DaS0nkpMeShb4VQBSJY0COdlCkEIeIaDpOCi6+2mKtNTVqW48tZ0vM9hA
         LnPg==
X-Forwarded-Encrypted: i=1; AKwUvBy/K4w8pc3tJmbAAXwWnFo/5aMox9le10yeg5eZ5xO3YnjskUXmIScu9CvrOvkU7uNWpHMSgZkAQHjtJU3Ic/Gs@vger.kernel.org
X-Gm-Message-State: AFuF++lEjW/IXu1jc5AYmccBit70YgbYq8yY2cdI+ISceTXyJb6/zMvb
	llpa9+oK4Q27cP4b3OWihNh6esgduNEC5DwMc9S7gQYlywSmCqO7njLtI3Pq23E1O4pmr3izsqx
	lJjqRu1E5Fw==
X-Received: from dlbsv2.prod.google.com ([2002:a05:7022:3a02:b0:14e:e9ff:116a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:a56:20b0:148:4522:560c
 with SMTP id a92af1059eb24-151c32de3e0mr158867c88.11.1790962770251; Fri, 02
 Oct 2026 10:39:30 -0700 (PDT)
Date: Fri,  2 Oct 2026 10:38:41 -0700
In-Reply-To: <20261002173848.3228217-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250424061943.1321025-1-irogers@google.com> <20261002173848.3228217-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002173848.3228217-9-irogers@google.com>
Subject: [PATCH v2 8/8] perf tests: Add build_id_offset test coverage
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org
Cc: ak@linux.intel.com, alexander.shishkin@linux.intel.com, 
	atrajeev@linux.ibm.com, dvyukov@google.com, fzczx123@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, kjain@linux.ibm.com, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, lihuafei1@huawei.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, m.liska@foxlink.cz, mark.rutland@arm.com, 
	martin.liska@hey.com, mpetlan@redhat.com, quic_zhonhan@quicinc.com, 
	scclevenger@os.amperecomputing.com, sesse@google.com, 
	stephen.s.brennan@oracle.com, thomas.falcon@intel.com, 
	yangyicong@hisilicon.com
Content-Type: text/plain; charset="UTF-8"

Test the kernel interface using sys_perf_event_open, test perf inject
--sample-buildids with pipe mode and callchains, and test perf record
--buildid-offset across multiple sampling modes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/Build                      |   1 +
 tools/perf/tests/bid-offset.c               |  60 +++++++
 tools/perf/tests/builtin-test.c             |   1 +
 tools/perf/tests/mmap-thread-lookup.c       |  42 ++++-
 tools/perf/tests/sample-parsing.c           |  68 +++++++-
 tools/perf/tests/shell/inject_bid_offset.sh | 175 ++++++++++++++++++++
 tools/perf/tests/shell/record.sh            |  69 ++++++++
 tools/perf/tests/tests.h                    |   1 +
 8 files changed, 414 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/tests/bid-offset.c
 create mode 100755 tools/perf/tests/shell/inject_bid_offset.sh

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 8fecd5390124..6a9563cc5533 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -64,6 +64,7 @@ perf-test-y += expand-cgroup.o
 perf-test-y += perf-time-to-tsc.o
 perf-test-y += dlfilter-test.o
 perf-test-y += sigtrap.o
+perf-test-y += bid-offset.o
 perf-test-y += event_groups.o
 perf-test-y += hybrid-merge.o
 perf-test-y += symbols.o
diff --git a/tools/perf/tests/bid-offset.c b/tools/perf/tests/bid-offset.c
new file mode 100644
index 000000000000..8c19d818f0b0
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
+		if (errno == EINVAL || errno == EACCES || errno == EPERM) {
+			pr_debug("Kernel does not support or permit PERF_SAMPLE_BUILD_ID_OFFSET\n");
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
+		if (errno == EINVAL || errno == EACCES || errno == EPERM) {
+			pr_debug("Kernel does not support or permit PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET\n");
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
index d2f594921e25..ee7109049a79 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -151,6 +151,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__perf_time_to_tsc,
 	&suite__dlfilter,
 	&suite__sigtrap,
+	&suite__bid_offset,
 	&suite__event_groups,
 	&suite__hybrid_merge,
 	&suite__symbols,
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index dca8bbfe780a..7af0f8697431 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -7,6 +7,7 @@
 #include <pthread.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include <string.h>
 #include "debug.h"
 #include "env.h"
 #include "event.h"
@@ -17,7 +18,10 @@
 #include "symbol.h"
 #include "util/synthetic-events.h"
 #include "thread.h"
+#include "dso.h"
+#include "build-id.h"
 #include <internal/lib.h> // page_size
+#include <internal/rc_check.h>
 
 #define THREADS 4
 
@@ -200,17 +204,51 @@ static int mmap_events(synth_cb synth)
 					.ip = (unsigned long) (td->map + 1),
 				 }, &al);
 
-		thread__put(thread);
-
 		if (!al.map) {
 			pr_debug("failed, couldn't find map\n");
 			err = -1;
+			thread__put(thread);
 			addr_location__exit(&al);
 			break;
 		}
 
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
+					if (!RC_CHK_EQUAL(al2.map, al.map)) {
+						pr_debug("failed, couldn't find map by build id and offset\n");
+						err = -1;
+					}
+					addr_location__exit(&al2);
+				}
+				dso__put(dso);
+			}
+		}
+
+		thread__put(thread);
 		addr_location__exit(&al);
 		if (err)
 			break;
diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index bd30f6d4c31b..d95bbd3587ab 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -218,6 +218,27 @@ static bool samples_same(struct perf_sample *s1,
 		}
 	}
 
+	if (type & PERF_SAMPLE_BUILD_ID_OFFSET) {
+		if (!s1->bid.bid || !s2->bid.bid ||
+		    memcmp(s1->bid.bid, s2->bid.bid, sizeof(*s1->bid.bid))) {
+			pr_debug("Samples differ at 'bid.bid'\n");
+			return false;
+		}
+		COMP(bid.offset);
+	}
+
+	if (type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) {
+		const size_t entry_sz = sizeof(struct perf_sample_build_id_offset);
+
+		COMP(callchain_bids_nr);
+		if (!s1->callchain_bids || !s2->callchain_bids ||
+		    memcmp(s1->callchain_bids, s2->callchain_bids,
+			   s1->callchain_bids_nr * entry_sz)) {
+			pr_debug("Samples differ at 'callchain_bids'\n");
+			return false;
+		}
+	}
+
 	return true;
 }
 
@@ -247,6 +268,45 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
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
+	const struct perf_sample_build_id_offset callchain_bids[] = {
+		{
+			.bid = {
+				.size = 20,
+				.data = {
+					'9', '8', '7', '6', '5', '4', '3', '2', '1', '0',
+					'9', '8', '7', '6', '5', '4', '3', '2', '1', '0',
+				}
+			},
+			.offset = 201,
+		},
+		{
+			.bid = {
+				.size = 20,
+				.data = {
+					'a', 'b', 'c', 'd', 'e', 'f', 'a', 'b', 'c', 'd',
+					'e', 'f', 'a', 'b', 'c', 'd', 'e', 'f', 'a', 'b',
+				}
+			},
+			.offset = 202,
+		},
+		{
+			.bid = {
+				.size = 20,
+				.data = {
+					'f', 'e', 'd', 'c', 'b', 'a', 'f', 'e', 'd', 'c',
+					'b', 'a', 'f', 'e', 'd', 'c', 'b', 'a', 'f', 'e',
+				}
+			},
+			.offset = 203,
+		},
+	};
 	struct regs_dump user_regs = {
 		.abi	= PERF_SAMPLE_REGS_ABI_64,
 		.mask	= sample_regs,
@@ -295,6 +355,12 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 			.size	= sizeof(aux_data),
 			.data	= (void *)aux_data,
 		},
+		.bid		= {
+			.bid = (struct perf_build_id *)&bid,
+			.offset = 119,
+		},
+		.callchain_bids_nr = ARRAY_SIZE(callchain_bids),
+		.callchain_bids = (struct perf_sample_build_id_offset *)callchain_bids,
 	};
 	struct sample_read_value values[] = {{1, 5, 0}, {9, 3, 0}, {2, 7, 0}, {6, 4, 1},};
 	struct sample_read_value packed_values[ARRAY_SIZE(values)];
@@ -547,7 +613,7 @@ static int test__sample_parsing(struct test_suite *test __maybe_unused, int subt
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
index 000000000000..a930f9b92f7e
--- /dev/null
+++ b/tools/perf/tests/shell/inject_bid_offset.sh
@@ -0,0 +1,175 @@
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
+	# Verify symbolization resolves the workload symbol
+	if ! perf report -i "${data2}" --stdio | grep -q "${sym}"; then
+		echo "Record --buildid-offset consistency [Failed - missing ${sym} in perf report]"
+		err=1
+	else
+		echo "Record --buildid-offset consistency [Success]"
+	fi
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
index 01dc3e22fa73..bbb3fd0d2a73 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -740,6 +740,74 @@ test_ratio_to_prev() {
   echo "Basic ratio-to-prev record test [Success]"
 }
 
+check_buildid_offset() {
+  perf report --header -D -i "${perfdata}" 2>/dev/null | grep -q "BUILD_ID_OFFSET"
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
@@ -760,6 +828,7 @@ test_precise_max
 test_callgraph
 test_acr_sampling
 test_ratio_to_prev
+test_buildid_offset
 
 # restore the default value
 ulimit -Sn $default_fd_limit
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 9c96f33483d1..c0a1026c3978 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -176,6 +176,7 @@ DECLARE_SUITE(expand_cgroup_events);
 DECLARE_SUITE(perf_time_to_tsc);
 DECLARE_SUITE(dlfilter);
 DECLARE_SUITE(sigtrap);
+DECLARE_SUITE(bid_offset);
 DECLARE_SUITE(event_groups);
 DECLARE_SUITE(hybrid_merge);
 DECLARE_SUITE(symbols);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

