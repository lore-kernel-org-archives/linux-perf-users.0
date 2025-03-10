Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAC51EE029;
	Mon, 10 Mar 2025 22:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741646967; cv=none; b=D2NaH5riHS1bUwAN5n7yTe/S7mwpq2NtTB1CFaoHk7AaZGL8MNVr37gtiJb/DIhwcyA79pEdjr53fqE6+cm1ZQs6PCNRHiD0n+ziSnIz6GX+FGRe4lUc11+Q5tlCh6XX0Q2rV1t61WVzo5oYTt3ZMdg+v+OwCRagiyZSbwXBm+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741646967; c=relaxed/simple;
	bh=vjxhXZObDe/YGwl7C2BasihkJhsbIAq/zZ7sz4JcQp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uD1JATG2eyyR3qY4qjMXzGs2ssrhQTBXlYvd0xAuV+GHessa1i+U9Yd51LS2vWyjlcYecOnEhruErbAmySDLf8NJeBpAi1JKfEoM7x+Vz2y5u/3K1X4x7Oe+eWZA/g2deIgWm8iP/OuomPdGIP0w/ur4dLgTOFeZpfnkgd1BROk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sffrUcAb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sffrUcAb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB59C4CEEF;
	Mon, 10 Mar 2025 22:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741646967;
	bh=vjxhXZObDe/YGwl7C2BasihkJhsbIAq/zZ7sz4JcQp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sffrUcAbIGzVjO+aAJZave71WeFm8bAdWZ/QVR36wwb4w2MJQ3PFsqSdf8qGzfUp1
	 NwcuQp5Mie8kYJTNND0R8KZcIxonY8pBKG6VITWhUo34iqIc1AJf0cGbYgX3kp3Z4W
	 FMJOTrKQPToRtl9ZlQA26fS4Pvy8eAI11JbB9SpIoBJJwKeXakPDryi+KYI6LU6sCk
	 w1jwFzk7G1c5qrxhM6yRLMh8+/ICyWI4Mpmqw6/8brG1XTb20wVVOwSxZ6ZKrlV3LG
	 mLt6biR33nMGmtzLAD71Ex/JfUVJRtM1C8lPLUI1s6fV52eeVs/7+CUFjTUYFxgglv
	 Zky4JZGy1aVhA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH v2 2/7] perf annotate: Remove unused len parameter from annotation_line__print()
Date: Mon, 10 Mar 2025 15:49:20 -0700
Message-ID: <20250310224925.799005-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250310224925.799005-1-namhyung@kernel.org>
References: <20250310224925.799005-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's not used anywhere, let's get rid of it.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 31bb326b07a68e46..2e0f70b4872b475a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -760,7 +760,7 @@ static int disasm_line__print(struct disasm_line *dl, u64 start, int addr_fmt_wi
 
 static int
 annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start,
-		       struct evsel *evsel, u64 len, int min_pcnt, int printed,
+		       struct evsel *evsel, int min_pcnt, int printed,
 		       int max_lines, struct annotation_line *queue, int addr_fmt_width,
 		       int percent_type)
 {
@@ -796,7 +796,7 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 			list_for_each_entry_from(queue, &notes->src->source, node) {
 				if (queue == al)
 					break;
-				annotation_line__print(queue, sym, start, evsel, len,
+				annotation_line__print(queue, sym, start, evsel,
 						       0, 0, 1, NULL, addr_fmt_width,
 						       percent_type);
 			}
@@ -1183,7 +1183,6 @@ int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel)
 	int printed = 2, queue_len = 0, addr_fmt_width;
 	int more = 0;
 	bool context = opts->context;
-	u64 len;
 	int width = annotation__pcnt_width(notes);
 	int graph_dotted_len;
 	char buf[512];
@@ -1197,8 +1196,6 @@ int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel)
 	else
 		d_filename = basename(filename);
 
-	len = symbol__size(sym);
-
 	if (evsel__is_group_event(evsel)) {
 		evsel__group_desc(evsel, buf, sizeof(buf));
 		evsel_name = buf;
@@ -1227,7 +1224,7 @@ int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel)
 			queue_len = 0;
 		}
 
-		err = annotation_line__print(pos, sym, start, evsel, len,
+		err = annotation_line__print(pos, sym, start, evsel,
 					     opts->min_pcnt, printed, opts->max_lines,
 					     queue, addr_fmt_width, opts->percent_type);
 
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

