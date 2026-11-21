Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795231271;
	b=EJ7zJbx8+3drNSt7RAs+q7ZZMf5LxvoHQgJ/dHUvpOQ6Rbr+0aS92WlM0zWvfx6UygvS
	 QjYcVgc7/sLoKhrk3FOqjv0z6nfnOLls6cugjeY3bi01ZSTPrmfsYQIwqwHm5865nK+gx
	 G4R4BCnC5SG5CVD9Z0EY5Hz9nvGcTd63KVEjOSOGSc4aQrmQg4WNAybYGtadQJP7yWpsp
	 Jz27FMgoroxfszms85X5K55D/tyZN5vNgOt3JcyZUH6WRWujQywHLvH1cf4Elovgcyqai
	 IxkKG2RXU8CoN9UrExQPreXR3xzGXuOVroBHlaWztE4IW/LuxtpY6+2FUo+E35gBlAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795231271;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qDstYIZwjnJNsCLpjtvv6m3fHAmfhG1zZzdlxaKkU+M=;
	b=J4mFda7EudRM55il7TvtFHhIeRPaRnjNmef/3ocplDL+55qIlMxtRC1EVtTLr5mquo6T
	 d41t3uen3IyT9nNbYvz+Lxgt/KJHjtFmgoKBLsME1PARLk3CLdyzxUhdJPQuscddsO59u
	 RVjukS+IJpu4IfW3jrgEG0811JmmA6ToaeBF6jCKIUdKHdwyHGLnvucAUmE/+kDr6thob
	 ml21QKC3f3KE3k7RX/eb1TOfEkSNvYDkCfKkEOqIxAvyErwrSmdFKGFfVBJGmENTzJcxx
	 Uml2F4nXmfniOrGVmBILj97KseoUIIO5AdNwgR7nAZXkrJBdzQzioPlsPvA5ZRhNGIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TlxbkInF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE35B606A691;
	Sat, 21 Nov 2026 03:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TlxbkInF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4EE1F000CA;
	Sat, 21 Nov 2026 03:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795231271;
	bh=qDstYIZwjnJNsCLpjtvv6m3fHAmfhG1zZzdlxaKkU+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TlxbkInFdkLzXzicEeyRk/oxYYcBfypPt1woMR7C8UVtNGF5+d3RMQ4/9AQbYrmQL
	 0TT3amCR2Pp4BsP65MqsIcxWcq/W6DAuE2UCcmdgUuOH5TZdmODvWALAJWHXb7Wgi3
	 InIAnWviO8dcG2pXcD98UuF2OPu5nDulcukNnoSEzF0IiazI+QDNxa7B2Ijw+Nqoq9
	 /QQhvDtM+wGPICWA1Bq5eUWG76kdbYHCi2FLCRGuQjT8VUqePFO8b8Sq6zRnS9LHQI
	 4b7+dseju0F0I0qcSMeY2HHm8Fr+cOab2G/UXPDx2+XMoGiA/xwBxNai2bI2WYTLZ5
	 +2UN1G/xp+x/g==
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
Subject: [PATCH v10 03/16] perf annotate: Print the stats after the annotations
Date: Sat, 21 Nov 2026 00:20:39 -0300
Message-ID: <20261121032052.1392234-4-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121032052.1392234-1-acme@kernel.org>
References: <20261121032052.1392234-1-acme@kernel.org>
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
 tools/perf/builtin-annotate.c              | 19 ++++++++++++++-----
 2 files changed, 15 insertions(+), 6 deletions(-)

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
index 7cb7e03d9a21d81b..e768f0fd8d4813de 100644
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
@@ -663,6 +658,17 @@ static int __cmd_annotate(struct perf_annotate *ann)
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
 
@@ -868,6 +874,9 @@ int cmd_annotate(int argc, const char **argv)
 	if (quiet)
 		perf_quiet_option();
 
+	if (annotate.type_stat && !annotate.data_type)
+		pr_warning("Warning: --type-stat needs --data-type\n");
+
 	data.path = input_name;
 
 	perf_tool__init(&annotate.tool, /*ordered_events=*/true);
-- 
2.56.0

