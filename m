Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794872837;
	b=Ey6nfZBJny5DKWxPW8EdbEucSyuznAdULC2ik7JTfDfnptDjI2tGd0MnarahuxiTCvMn
	 9HCLHDG4Sy2I+Yj/SPLA+5gW5oOc0qQ+BW2gyim/+znLDUhcwtlGoCdRwJD5AulIYQzHT
	 qizpHuyXj9uVZwE3J36Xz99xT27Np/raJmnZb6HHQxnBBGd7htH6Xf5y6a6GJKSYYib1+
	 G79cZWel6G81j4SMSVEka6bLGRtRBpmLue9+3kr3VV38+jwUn+yMmrkn7Gjr1LrQywkB2
	 TtofEYMNZ9DFoJTmiSHTTRm8m2irv03hy6USWE44hmBcd5rNxMH/o5P+Jht0k8EtdVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794872837;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zz/HiMv55g8Y5OMStvrfD2E88l5WqKEH7KOXzdiQlwU=;
	b=Juz75YP4usNEtdYWAunRfesPUwPhJebpuuFWz4Zug9Enb0ohVpNv+oqLM7JTjYltSDRm
	 hbGeTBvgprCXWSeq3HCGwVhahNXtxbrXaal89x33qLI9GP+kRrKY8MeaTqqQ5FLNAQfgQ
	 CMWG+bmGytTvBt2eHqWhd+Jh7XVzcLHT0nlUgC17+7lsSFv1XEp18sZWTbtidJbepo6lJ
	 6F6BuXxtS1GHjksY4ERYNexSrnPRaXyFmWnnaS6c1J/cRmhIKNw26S77WUj8TKtS47Nmy
	 /VZxakEKV2WsyIZhoaHkD66wOsBSqD29WkteMIdfL0PA/EgRpYape9la2XK/F4MleOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i3StzSC8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6C9606A335;
	Mon, 16 Nov 2026 23:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i3StzSC8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325C11F000C5;
	Mon, 16 Nov 2026 23:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794872836;
	bh=zz/HiMv55g8Y5OMStvrfD2E88l5WqKEH7KOXzdiQlwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i3StzSC8PMffy1Fj8bX6NCc/aTWLEXBXuKop2JFj2sMM6X+E6FT/Eg+Tm8DMBp5w9
	 OwoOcM4vWBEQ2ZsgB7LqKEzpAPt2ROa00MudUYziE4gWP1m6z/xgZ9OePQYO/rZ33S
	 CZ23VSgfRYKp3wXDGZ/AgusPbSRQL8hxLtVEvXERy+cjjpws7+0ek9GkImLrvCGaqP
	 Mo9207SxrmtYypUaQSOSABNbeGOXv4xbCO3h3Zk/UnOkQMx0q+CQwl/Ez4ix81f1FA
	 qvevlTxwyD2lPnb9Hw3M9GU7J7GvImNfolSzhJ/Y09BOgr4G77MC6TSjrqlg1F7JE+
	 5/Li6Oyhhem8A==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v4 04/12] perf tests: Exercise the flexible array member path
Date: Mon, 16 Nov 2026 20:46:50 -0300
Message-ID: <20261116234659.3950531-5-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116234659.3950531-1-acme@kernel.org>
References: <20261116234659.3950531-1-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No test covered find_flex_array() and get_flex_array_member().  Add a
flex_array workload that keeps a struct with a trailing data[] behind a
global pointer, and a test that checks the accesses past the struct size
are resolved and named after the flexible array member.  The test skips
on 32-bit PIE builds, which load globals through the GOT.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c               |  1 +
 .../perf/tests/shell/data_type_flex_array.sh  | 70 +++++++++++++++++++
 tools/perf/tests/tests.h                      |  1 +
 tools/perf/tests/workloads/Build              |  2 +
 tools/perf/tests/workloads/flex_array.c       | 54 ++++++++++++++
 5 files changed, 128 insertions(+)
 create mode 100755 tools/perf/tests/shell/data_type_flex_array.sh
 create mode 100644 tools/perf/tests/workloads/flex_array.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 299e07bd16a5a53f..18311673b231e657 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -200,6 +200,7 @@ static struct test_workload *workloads[] = {
 	&workload__callchain,
 	&workload__false_sharing,
 	&workload__global_data,
+	&workload__flex_array,
 
 #ifdef HAVE_RUST_SUPPORT
 	&workload__code_with_type,
diff --git a/tools/perf/tests/shell/data_type_flex_array.sh b/tools/perf/tests/shell/data_type_flex_array.sh
new file mode 100755
index 0000000000000000..8d6b277991aea96e
--- /dev/null
+++ b/tools/perf/tests/shell/data_type_flex_array.sh
@@ -0,0 +1,70 @@
+#!/bin/bash
+# perf data type profiling tests for flexible array members
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+perfout=$(mktemp /tmp/__perf_test.perf.out.XXXXX)
+
+cleanup()
+{
+	rm -f "$perfdata" "$perfout"
+	trap - EXIT TERM INT
+}
+
+trap_cleanup()
+{
+	echo "Unexpected signal in ${FUNCNAME[1]}"
+	cleanup
+	exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+if ! perf check feature -q dwarf; then
+	echo "Skip: no DWARF (libdw) support"
+	cleanup
+	exit 2
+fi
+
+# 32-bit PIE loads globals through the GOT, which the resolver does not follow
+if [ "$(getconf LONG_BIT)" = 32 ] &&
+   [ "$(od -An -tx1 -j16 -N2 "$(command -v perf)" | awk '{print $1}')" = 03 ]; then
+	echo "Skip: 32-bit PIE uses GOT-relative global accesses"
+	cleanup
+	exit 2
+fi
+
+# No point in recording if the PMU cannot do memory events.
+if perf mem record -o /dev/null -- true 2>&1 | \
+		grep -q "failed: no PMU supports the memory events"; then
+	cleanup
+	exit 2
+fi
+if ! perf mem record -o /dev/null -- true 2>/dev/null; then
+	echo "Skip: cannot record memory events on this PMU"
+	cleanup
+	exit 2
+fi
+
+if ! perf mem record -o "$perfdata" -- perf test -w flex_array 1 > /dev/null 2>&1; then
+	echo "FAIL: perf mem record"
+	cleanup
+	exit 1
+fi
+
+if ! perf annotate --code-with-type -i "$perfdata" --stdio \
+		--percent-limit 1 > "$perfout" 2>/dev/null; then
+	echo "FAIL: perf annotate"
+	cleanup
+	exit 1
+fi
+
+if ! grep -Fq "# data-type: struct flex +0x4 (data)" "$perfout"; then
+	echo "FAIL: flexible array member not resolved"
+	cleanup
+	exit 1
+fi
+
+echo "flexible array member resolved"
+cleanup
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index bbd23dd7e0455a9d..f99910b0f8d93a82 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -273,6 +273,7 @@ DECLARE_WORKLOAD(deterministic);
 DECLARE_WORKLOAD(callchain);
 DECLARE_WORKLOAD(false_sharing);
 DECLARE_WORKLOAD(global_data);
+DECLARE_WORKLOAD(flex_array);
 
 #ifdef HAVE_RUST_SUPPORT
 DECLARE_WORKLOAD(code_with_type);
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 03017aaaaa0bec32..74a0cbe49dc93533 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -18,6 +18,7 @@ perf-test-y += deterministic.o
 perf-test-y += callchain.o
 perf-test-y += false_sharing.o
 perf-test-y += global_data.o
+perf-test-y += flex_array.o
 
 ifeq ($(CONFIG_RUST_SUPPORT),y)
     perf-test-y += code_with_type.o
@@ -37,3 +38,4 @@ CFLAGS_named_threads.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_callchain.o        = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_false_sharing.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_global_data.o      = -g -O0 -fno-inline -U_FORTIFY_SOURCE
+CFLAGS_flex_array.o       = -g -O0 -fno-inline -U_FORTIFY_SOURCE
diff --git a/tools/perf/tests/workloads/flex_array.c b/tools/perf/tests/workloads/flex_array.c
new file mode 100644
index 0000000000000000..20f9b0ec17969909
--- /dev/null
+++ b/tools/perf/tests/workloads/flex_array.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Flexible array member workload for data type profiling: the accesses to
+ * the array are past the end of the struct, where the resolver has to find
+ * the flexible array member.
+ *
+ * See tests/shell/data_type_flex_array.sh.
+ */
+#include <signal.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <linux/compiler.h>
+#include "../tests.h"
+
+struct flex {
+	int len;
+	char data[];
+};
+
+static struct flex *gp;
+static volatile unsigned long flex_sink;
+static volatile sig_atomic_t done;
+
+static void sighandler(int sig __maybe_unused)
+{
+	done = 1;
+}
+
+static int flex_array(int argc, const char **argv)
+{
+	unsigned long sum = 0;
+	int sec = 1;
+
+	if (argc > 0)
+		sec = atoi(argv[0]);
+
+	gp = calloc(1, sizeof(*gp) + 4096);
+	if (gp == NULL)
+		return 1;
+	gp->len = 4096;
+
+	signal(SIGINT, sighandler);
+	signal(SIGALRM, sighandler);
+	alarm(sec);
+
+	while (!done) {
+		sum += gp->data[3];
+		gp->data[5] = 1;
+	}
+	flex_sink = sum;
+	return 0;
+}
+
+DEFINE_WORKLOAD(flex_array);
-- 
2.56.0

