Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794706889;
	b=afwRZEX7pHAtRDgQj6IEGP5HoTmWqqurWfyIarSRbUihZq5qXyNJQeh6SK7jzfznDf9M
	 lQ+Ii6GipP8ko08aTyybpoMduX6mJlUf1agEAwpIoTSNJf1H8nCdFSzRAhn2fu+O0FBj8
	 Pr7QvxINXCNnXjQYGps21AoQHwbuxxmjsrSrHLIel8NX/pM05ozOpSzKbK+oK1NWbbrjq
	 WdkyEl0PT+TI01oi7sQ4qVCJIgkmsDHKcxJVpDt0225qJAIVAQsutAfa+wFLsG5UI2Pla
	 idX3TCiB9uscYkD4ckmbnH4gz8JLiBQN9c6Ez6sBRk7BDM6QmQbbnU1mNHkfHLk/TQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706889;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CPRuPdbTgWzGWGpOkDp04avXYG/mCAE3FTmDm2VUafY=;
	b=b9RtkgrxDf7wSlKi9TVuH1IHIKH/pBxMROrQqtK10rwPyX8fbZeQWb5jLoHX6yDgwDS5
	 ibWrS2Cmi4CxPl89tDXCbUgRvaCYd+3h3Sl2EWJg0xKuRcuT4fN25Z7kYX2c/t9HOr2Ls
	 wIf+XT4fgKQ/JyMPX3e23+0l7XHdlDUD6/X054vWIZIO8i9uX+KbJYvoSe3v2+qPSkRm3
	 RfnPpFb2uasOjlel9FiWducuXyqHcMFT9VcbtCksgPkNA6unQpZcZbXrroktKZqRQX4fU
	 vodmjhpw5SpafJ8taiSJSOkbeK0rBpgyHiWg2Tp621dmwRsNOzg/Y7WJ84kDwSmEiFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4BhVx2m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08508606A89A;
	Sun, 15 Nov 2026 01:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4BhVx2m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDF81F000C4;
	Sun, 15 Nov 2026 01:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794706888;
	bh=CPRuPdbTgWzGWGpOkDp04avXYG/mCAE3FTmDm2VUafY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N4BhVx2m8/DjQzxXZxegTOfSlMdAcOGVhQcujzdyNMwTse7D9XoE2bmryoY48Xa8X
	 krtZ0pyvoSQ5BLX8OJLpbfeh/KIqB+bkNsD5EhcyAthJ463vvVdDHL5P9gpHX0iFIQ
	 Kkqhrbaku42JdEGMQHOTAI62ArnhkVkr1GP0gKPFL2kALSXRdKHQwzk9cMHAPTezPW
	 r0Wgt7yFFVDApWs0HdgSmWiZhhYBpufIXoyLWQwf+EvWdLGLS73DrbOcPCzmVMocoF
	 CtGK+XjPypTbiUT2ysEbDamXw4rPSmLyTqKdlUKFJxaxbRjzpFweYZHjvJ1auof3F3
	 1gd/Ew7OkHCow==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 07/12] perf annotate: Print the stats after the annotations
Date: Sat, 14 Nov 2026 22:40:55 -0300
Message-ID: <20261115014102.2879372-8-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115014102.2879372-1-acme@kernel.org>
References: <20261115014102.2879372-1-acme@kernel.org>
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

