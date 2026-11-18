Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039071;
	b=LXxEgFMy4ATwSubIq+RlCUZEWvUSo8J2DJ05pxmSqryc8eOe7VhdOIhMGI2sNIONTD0M
	 L0kSywnmt/uChj3WzUoyoQhdE58hmPc5Yog5Oy1CXBUcQet7w3OdG6lBoYnB5gXbgbcx4
	 TcucV4IjgYa3FePdqyV3ULU6CiUWwxt0+vAxYvz31ugd+Nk/pWTSXPslzbLok8D1ZspV1
	 kbYo/JgK8mAr8AqhAQRXVfuJULph6+K6lg3mvgGAg+MUJygbQCtidwNc7UZQEqDeFJx1p
	 IG+A8ksm77YQRX5LNsmp2kXW2w09CydNoZNBXfKvpMuObXTKBVh2LakLnQYaBtPTsnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039071;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2khjZ2E7Xva6D8F6ans4J6jJKhtPz9tdJhHE3kq/Qz4=;
	b=Q5KmanLFbcydJ8imjD3LpQrWdkMywjhYRIQVX0xY4nnCku1Pcpkv/A0halHP9pwu3+RV
	 SRh9Hizx1T9+ilZGcBMpIPRMixW5uAx64RNAq9jjgEITKtrUJEprBCL/hoCchz1/N0VJK
	 jekYvj0ZZ8ilRiwsrz6ElkL8dOCLC4GucnMHKmPUhn3cr5oL0TmEo64WpMUd9NBp5gVRp
	 EsG9sAwxemEw48s4IHMQhedvCBb2rirmr8plRDBE/Dk4ax5QtKMLgm1bXbUMEPW9t6F++
	 5/GwV35PUJNpU87P3YuPvvRB6SgXkqr/k2E2+naCKAc6YclGxdHAxOvT+Leo5Rv/glQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FU9whtbp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AA2606A31C;
	Wed, 18 Nov 2026 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FU9whtbp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371CC1F000C4;
	Wed, 18 Nov 2026 21:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039071;
	bh=2khjZ2E7Xva6D8F6ans4J6jJKhtPz9tdJhHE3kq/Qz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FU9whtbpOHuc6EKkJg5mE2lsjwMg8IuEJyJ40YIih+OAAEb1Ar758XiiYRZpSajHj
	 f96Rj7ZKmNujGJOg0QK8CK7jOIDZtGCGug4jeaBZoQCdTa+F6aBJmqDJIzllGK3mNN
	 u/Z6Zud1asCiWofitx21RTBmDklfdNBgCO/xO7+Mp+xN5rSwZk/6xJPDaCRonmrVa1
	 EOtibFfB9/RJgwifKpW1OyQ9tFJzkU98Cj1zk+L6yCK+s6W57Btu1tX6jf5Of2MzrM
	 +yAn/tWSUQ42+O40VoMiCv7GnVgLy61j3Ew16dICFgufAVjqorHWQHu+jYJHq2hp27
	 y+WBA9KOtd5Og==
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
Subject: [PATCH v7 08/13] perf annotate: Print the stats after the annotations
Date: Wed, 18 Nov 2026 18:57:10 -0300
Message-ID: <20261118215716.114868-9-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118215716.114868-1-acme@kernel.org>
References: <20261118215716.114868-1-acme@kernel.org>
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

With --code-with-type the instruction stats are printed from
hists__find_annotations() before that event is annotated: the first
event reports zeros and later events can report stale counts.  The data
type total is only counted in --data-type mode, so --type-stat without
it is incomplete too.

Print the stats once after all events have been annotated, warning if
--type-stat is used without --data-type.  Leave the TUI's alternate
screen before printing, so the stats remain on the terminal.

Fixes: 58824fa0087e1cb7 ("perf annotate: Add --insn-stat option for debugging")
Fixes: 61a9741e9f78c64c ("perf annotate: Add --type-stat option for debugging")
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-annotate.txt |  2 +-
 tools/perf/builtin-annotate.c              | 19 ++++--
 tools/perf/tests/shell/annotate_stats.sh   | 69 ++++++++++++++++++++++
 3 files changed, 84 insertions(+), 6 deletions(-)
 create mode 100755 tools/perf/tests/shell/annotate_stats.sh

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index 1a90b09a12d5abb1..d27eff28ba4f6af0 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -169,7 +169,7 @@ include::itrace.txt[]
 	all data types it finds.
 
 --type-stat::
-	Show stats for the data type annotation.
+	Show stats for the data type annotation (with --data-type).
 
 --skip-empty::
 	Do not display empty (or dummy) events.
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 331adbdbd635917d..8ced8a4aebf07709 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -414,11 +414,6 @@ static void hists__find_annotations(struct hists *hists,
 	struct rb_node *nd = rb_first_cached(&hists->entries), *next;
 	int key = K_RIGHT;
 
-	if (ann->type_stat)
-		print_annotate_data_stat(&ann_data_stat);
-	if (ann->insn_stat)
-		print_annotate_item_stat(&ann_insn_stat, "Instruction");
-
 	while (nd) {
 		struct hist_entry *he = rb_entry(nd, struct hist_entry, rb_node);
 		struct annotation *notes;
@@ -660,6 +655,17 @@ static int __cmd_annotate(struct perf_annotate *ann)
 		hists__find_annotations(hists, pos, ann);
 	}
 
+	if (use_browser == 1 && (ann->insn_stat || (ann->data_type && ann->type_stat))) {
+		/* Leave the alternate screen before printing to the terminal. */
+		ui__exit(false);
+		use_browser = 0;
+	}
+
+	if (ann->data_type && ann->type_stat)
+		print_annotate_data_stat(&ann_data_stat);
+	if (ann->insn_stat)
+		print_annotate_item_stat(&ann_insn_stat, "Instruction");
+
 	if (use_browser == 2) {
 		void (*show_annotations)(void);
 
@@ -865,6 +871,9 @@ int cmd_annotate(int argc, const char **argv)
 	if (quiet)
 		perf_quiet_option();
 
+	if (annotate.type_stat && !annotate.data_type)
+		pr_warning("Warning: --type-stat needs --data-type\n");
+
 	data.path = input_name;
 
 	perf_tool__init(&annotate.tool, /*ordered_events=*/true);
diff --git a/tools/perf/tests/shell/annotate_stats.sh b/tools/perf/tests/shell/annotate_stats.sh
new file mode 100755
index 0000000000000000..5af48bf187c5e8f5
--- /dev/null
+++ b/tools/perf/tests/shell/annotate_stats.sh
@@ -0,0 +1,69 @@
+#!/bin/bash
+# perf annotate instruction stats test
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+perfout=$(mktemp /tmp/__perf_test.perf.out.XXXXX)
+perferr=$(mktemp /tmp/__perf_test.perf.err.XXXXX)
+
+cleanup()
+{
+	rm -f "$perfdata" "$perfout" "$perferr"
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
+# No point in recording if the PMU cannot do memory events.
+if ! perf mem record -o /dev/null -- true 2>/dev/null; then
+	echo "Skip: cannot record memory events on this PMU"
+	cleanup
+	exit 2
+fi
+
+if ! perf mem record -o "$perfdata" -- perf test -w datasym > /dev/null 2>&1; then
+	echo "FAIL: perf mem record"
+	cleanup
+	exit 1
+fi
+
+if ! perf annotate --code-with-type --insn-stat -i "$perfdata" --stdio \
+		--percent-limit 1 > "$perfout"; then
+	echo "FAIL: perf annotate"
+	cleanup
+	exit 1
+fi
+
+# The instruction stats are accounted while the instructions are
+# displayed; printing them before the display loop shows zeros.
+if ! grep -Eq '^total [1-9][0-9]*,' "$perfout"; then
+	echo "FAIL: instruction stats not accounted"
+	tail -n 30 "$perfout"
+	cleanup
+	exit 1
+fi
+
+if ! perf annotate --type-stat -i "$perfdata" --stdio > /dev/null 2> "$perferr" ||
+   ! grep -Fxq "Warning: --type-stat needs --data-type" "$perferr"; then
+	echo "FAIL: missing --type-stat warning"
+	tail -n 30 "$perferr"
+	cleanup
+	exit 1
+fi
+
+echo "instruction stats accounted"
+cleanup
-- 
2.56.1

