Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582380;
	b=Kx0tEbQ4j0A8ktNW5hCHy3XVXkQX6Ibk/uRWuAr8rPtCyqQgAJiA01AD5Armgy7JxU8i
	 qsUqT//+/gIAs326LO1oSPqNlDk+teF0dLoxNvR2UGxf4IfKDd5K0qhpZMfWH2VWv+3dC
	 QRuLXRFA9wn+gTwLbPE+tDQi4qttrJcXU+3+X+zndPSoAQ1L+CreYGe13UiFvAEWsA3cO
	 ii2w+Cjbo6aE9EZOwlgl/dK/NIVSsfEEWP75iI92xyrrrGVU9KhspenM+FAdnMyb7Xwr9
	 15E16aYxaC3RE6/6Qu6NW7/sBQmWBlbNbNhecg3rHp55up0S7wM2NDPUb+qZFgUi8/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582380;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zSkaJp+jm7VGY1BsoqIkTEeAapZepwmppRz6H7Yg+iw=;
	b=qDVv2kSpkfq/CieQRVaLqcpobDvHue7VNs5u8XCl2SgzOdvGA5TKmBwHZnhy7p9iz1f8
	 PhGj/uUUzKqyuEebeDB+wbJYfmsWX48iCNhwiXJ+Rvs8SEmyHXwraX8iu/773y++nAfiI
	 +gQR4AtvyWNG/7iHfKW3LeVsTTDxiFYgLfoMxFap0EoZ/7sbf9uckXVo8U0Pu93DutllF
	 IF1ModCALp8aiz7ZNxidwrk4Cf8n/UIJtky0fJt+bnhnm3t9VitF5HzgJUv78OsN55y+t
	 gcfaa0iGfCtlQj2T15KcC5KHYaVN5+bEcdK+a2DagbLVxhdbjlQj9e/v5yWSjG7vBIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="A8mZ5/b4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1196606A88E;
	Fri, 13 Nov 2026 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8mZ5/b4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697521F000C4;
	Fri, 13 Nov 2026 15:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582379;
	bh=zSkaJp+jm7VGY1BsoqIkTEeAapZepwmppRz6H7Yg+iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A8mZ5/b4AiSvyz6/B/8zSAW1/U9SJynHtgtKejCgG5EpkOD9+YgLt0aLp0SOBjxW2
	 Cadfb9Qu5OxfiGL1P5hVAlvcKdMuAqk/xyk17aBJQ5qt17NW+Ojih1LQXuCBALv0jT
	 wMjV2vpC3gOpoDE8m+yQ250RpaEm/DfUYTBjf35F5ebkLvwIBZJrxGX/PUorR9uu6j
	 KLPl7IjppPs5a0w02rDVmlJouH1qS48Nh19CWUHF3KwYyE0XKKTvqLGaHRmw5q0gSG
	 UYZ1+5RkDK7PyllfB8kQ9AURhVOsJj2DEQ/cjEpTUSGOR8z7kU14zTeZRjBqVUCXM6
	 dx4SvXhdjTyug==
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
Subject: [PATCH v1 06/12] perf annotate: Print the stats after the annotations
Date: Fri, 13 Nov 2026 12:05:47 -0300
Message-ID: <20261113150555.1163049-7-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113150555.1163049-1-acme@kernel.org>
References: <20261113150555.1163049-1-acme@kernel.org>
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
 tools/perf/tests/shell/annotate_stats.sh | 58 ++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 5 deletions(-)
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
index 0000000000000000..82d2becdff141138
--- /dev/null
+++ b/tools/perf/tests/shell/annotate_stats.sh
@@ -0,0 +1,58 @@
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

