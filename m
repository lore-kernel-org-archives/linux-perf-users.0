Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884014;
	b=cbrw8DtgcQDHQuJBEY4Xci8TrqdYHHs4kOT9Ma/lzRQy8nT7SiSs2Jy2iJQP4HSaYAwA
	 sqOHLiBbJ3GNAgJjRSGc+TC99fm3Kf4UMOiILtc9MNreEyBXZ9IeaiMByjWnOKJ1kobkX
	 dFLGy1f6fLRoL8ltC/nY+P26vXT4lmbThHda8PUigO6OhY2tRuJ/giklG3rqxWKXcizUq
	 hcAmIgRbsf9VA2vw91aAaiu8mW3frO5U8rktOP1NhX1dLs8ybN4UAU1TzSO2ufpthZSe6
	 0ww5DyIUo5aOJTOHA/t6ctUBhRUlugY/NEtL5tV7xkdf0X3HXvNA97QGHbRFJl1wVRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884014;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CMq1iVvdVXQxngRn6MO8txuC3mJsj1mWiq7wzEMFd44=;
	b=zsx2Jrc5jz5J29V+me80nPcoD6/0SLgA8S4EECw03Z4Cz9Q+yLMtoKVe4ysrZQQWumO5
	 TUolj8iZwaDUXfmzyopJCt/qa9aqgM3XU7QImFNMjrKnXLPSxrKuVEq+edtOsFJbFhtK8
	 Mx4bKybJZYvxHF/tlLuw57uh4ZK+nY0+D2t/c24vYZsyVXgKAdIXE+/9xtG+nFTSCrq7l
	 pwAGVcRTJVpQWmt19udd/2Xqj0sgqfB2eU5GoCsgrAtKFokiTLlnmfUHtVmMLSC+GJGoU
	 hwzGaWvtTlf9BI3Fu8pjLJE0hVSAs3+qOLSx+oDssH3vfS0j26SU9Q/k4viQh5yvrqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f2k7vB98;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1537D606A33B;
	Tue, 17 Nov 2026 02:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f2k7vB98
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FB11F000C5;
	Tue, 17 Nov 2026 02:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794884013;
	bh=CMq1iVvdVXQxngRn6MO8txuC3mJsj1mWiq7wzEMFd44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f2k7vB98TGTN7C4tSn6VMvD9xTXKb7DovWecDoR2+1JhDxK2PUktYqJ6MnBZMocG4
	 Rg4vjm33m4COyLHaQW2lFQ/InH4mBvwMCw8S3TN7DQAGtAwgyRwmnWjp6akrbIr9yS
	 RiPnqDcj3Ff+qw7Cq9dSolyWldAMp/GH4MTfI858VF21Bm9Wm+yw1fIXdlZWO6Nf6n
	 O0WXxWzC6oqzPR+4jhKG/9ABTcYMpFjGDPBopATBaI8QdE/3D/AMIcKNNmY+hg8JtW
	 eidmVszz9plOFHD/cjf4g8OElANzddeGnRwNgSg1jBG82p5xhWLB7hE13IJ3VQXenV
	 x26EVedPGEsMg==
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
Subject: [PATCH v5 07/12] perf annotate: Print the stats after the annotations
Date: Mon, 16 Nov 2026 23:52:59 -0300
Message-ID: <20261117025305.3958882-8-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117025305.3958882-1-acme@kernel.org>
References: <20261117025305.3958882-1-acme@kernel.org>
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

The instruction stats are printed before the loop that accounts them,
so 'perf annotate --code-with-type --insn-stat' always shows zeros.
The data type counters are updated in --code-with-type mode too, but
only --data-type mode accounts their total, so they are incomplete
there.

Print both after the annotation loops, the data type part only with
--data-type.

Fixes: 58824fa0087e1cb7 ("perf annotate: Add --insn-stat option for debugging")
Fixes: 61a9741e9f78c64c ("perf annotate: Add --type-stat option for debugging")
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c            | 10 ++--
 tools/perf/tests/shell/annotate_stats.sh | 64 ++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 5 deletions(-)
 create mode 100755 tools/perf/tests/shell/annotate_stats.sh

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 331adbdbd635917d..973f4950abd6f917 100644
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
@@ -660,6 +655,11 @@ static int __cmd_annotate(struct perf_annotate *ann)
 		hists__find_annotations(hists, pos, ann);
 	}
 
+	if (ann->data_type && ann->type_stat)
+		print_annotate_data_stat(&ann_data_stat);
+	if (ann->insn_stat)
+		print_annotate_item_stat(&ann_insn_stat, "Instruction");
+
 	if (use_browser == 2) {
 		void (*show_annotations)(void);
 
diff --git a/tools/perf/tests/shell/annotate_stats.sh b/tools/perf/tests/shell/annotate_stats.sh
new file mode 100755
index 0000000000000000..fe4891e8535d3944
--- /dev/null
+++ b/tools/perf/tests/shell/annotate_stats.sh
@@ -0,0 +1,64 @@
+#!/bin/bash
+# perf annotate instruction stats test
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
+if ! perf mem record -o "$perfdata" -- perf test -w datasym > /dev/null 2>&1; then
+	echo "FAIL: perf mem record"
+	cleanup
+	exit 1
+fi
+
+if ! perf annotate --code-with-type --insn-stat -i "$perfdata" --stdio \
+		--percent-limit 1 > "$perfout" 2>/dev/null; then
+	echo "FAIL: perf annotate"
+	cleanup
+	exit 1
+fi
+
+# The instruction stats are accounted while the instructions are
+# displayed; printing them before the display loop shows zeros.
+if ! grep -Eq '^total [1-9][0-9]*,' "$perfout"; then
+	echo "FAIL: instruction stats not accounted"
+	cleanup
+	exit 1
+fi
+
+echo "instruction stats accounted"
+cleanup
-- 
2.56.0

