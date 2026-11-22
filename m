Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795383645;
	b=Uyp3bIgJRXvtq8artD5IUHcr09CZPHM15Rxy3gkK/dsIH56Vq1vkMEj2koqJOO9kU+Ze
	 Ty4sIyOQR1FS334JC4DbGmJk/mxMEvGYIpW0hajXPdNi/d+OXHG5SL8npuBd0p8GRwRYN
	 F0h5gJLAzgNlSZivvTVZEEacXy1enzp2WrnG9GMZ347Wm54JfmrYVnjlkJl2dfbrRWVu9
	 fwKj8C4m7TLkpNVdnabkt3u4N5NopFnfpBRj9ND025yDvh1GYRrq3MWVZDIkSJvIuZcxA
	 dOnIM0IGXynsKuj7jy8s8k0YoE6vLpY9GI48Prdg+Otycv/SfVCFH6id19DtnAB1gPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795383645;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=b6g9MfzuMjAmwz3o1cLa3W5mv51mQSf9ONSSbgcu1Go=;
	b=wu/2izSwvSmXSJmMKUVKoEKkTrxeDKOSnoA9Z7MGaB5DSnDizfsUFLt+KNUBSK6Q6g/4
	 J0kTNmLHpxb+txPMDKvv3teXRuAMqRUb4l+SIULGk2dk/IlZ/1kd0Sco/o/X4kpJ7a3Z1
	 GbV8v/1DWyG40JR5JyqP+4yl/HbytWAgTETwmkio3Khb4plco8bgKzUyhih/QMD8d7d3B
	 6m9f6b6Ch1bLqPEGmvzX1GerP9V17wPxtkLQZbf+2lSLYMvgJP6wIhFus4Fj0DL2Khqog
	 AUwc9GhVgvGasWeZJH8MLnO3dnDFR+3Wnb7NfXemXm4rPpotJUbMVYxUosIxRB7ES4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IhbWXlnL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AEF606A31A;
	Sun, 22 Nov 2026 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IhbWXlnL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED29E1F000CF;
	Sun, 22 Nov 2026 21:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795383644;
	bh=b6g9MfzuMjAmwz3o1cLa3W5mv51mQSf9ONSSbgcu1Go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IhbWXlnLeWS6SckJ3rsPO90r5gAL1lzlW+lfnJQibW1SDR7Af2XPMSvqgAvWQqZzd
	 EHzDBvFp2Gpwk3XBp8OWfqebcQ+q0Ag4Xl0fYnl9lC2Zhj0Oi4KA8x+fMkX1D1rxlx
	 qnbXLBexMk2UhqgwAtSKnWTerp2tkNomt2GnpKGsd23QWAEi2yvyf5SG0OXshIEkwj
	 S8HPhZdxKbfX6xMhMrUUWDEhKGVa6awD7Zv5u4IJraGBT+djbYEmKSIhsrC+EBPnyB
	 ewsAeftdTRP16EiV8bnCOJgbuK9sJInzaHOQ5HIeqc0zlrw5i4bOzNv9qQChs6IR/v
	 h8+PcMIr1niFw==
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
Subject: [PATCH v11 03/19] perf annotate: Print the stats after the annotations
Date: Sun, 22 Nov 2026 18:40:09 -0300
Message-ID: <20261122214025.16769-4-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261122214025.16769-1-acme@kernel.org>
References: <20261122214025.16769-1-acme@kernel.org>
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
 tools/perf/builtin-annotate.c              | 20 +++++++++++++++-----
 2 files changed, 16 insertions(+), 6 deletions(-)

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
index 7cb7e03d9a21d81b..b7f71cc95c0cd4c0 100644
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
@@ -663,6 +658,21 @@ static int __cmd_annotate(struct perf_annotate *ann)
 		hists__find_annotations(hists, pos, ann);
 	}
 
+	if (use_browser == 1 && (ann->insn_stat || ann->type_stat)) {
+		/* Leave the alternate screen before printing to the terminal. */
+		ui__exit(false);
+		use_browser = 0;
+	}
+
+	/* Here use_browser is 0 in stdio and TUI mode, so pr_warning reaches the terminal */
+	if (ann->type_stat && !ann->data_type)
+		pr_warning("Warning: --type-stat needs --data-type\n");
+
+	if (ann->data_type && ann->type_stat)
+		print_annotate_data_stat(&ann_data_stat);
+	if (ann->insn_stat)
+		print_annotate_item_stat(&ann_insn_stat, "Instruction");
+
 	if (use_browser == 2) {
 		void (*show_annotations)(void);
 
-- 
2.56.1

