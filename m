Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE4B2144AE;
	Mon, 10 Mar 2025 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741646968; cv=none; b=Jb3JUF7Oyo9ctBPS09v0YjO5mvjkSsNzkmxH8kq4od422bo8qtDu7wWzOeaZO3HGrTFyygdKVuO+Yb2ABtdEKGGjtPYboabiH43XY0J13bIUd+0LDDLt34bgtC4/SfuxTmzqHISZMxugiZvPs8wbvxLXrtv03XHkFG7N2j5xCpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741646968; c=relaxed/simple;
	bh=1nZKc+HMzsTs1mIFuu7S1fF5pLgo23yrQCVk/XD/6nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+2DVm0GE8Ib1W39S2ep0c7TCnNPXpkcWcZaFSOqQPotT8W234acCRvs8YT9CpaKtj1qCLb8cXYy1LpjFPOVRXKkS3YpEWFnO3wBGomieadnB2GV1JyMXCbvOnxz3HgqbzAP56FeLhhiIOZ3kc/pz0/2IPEvHQguQDqymezuGjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0PHWdKU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0PHWdKU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB5AC4CEEA;
	Mon, 10 Mar 2025 22:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741646968;
	bh=1nZKc+HMzsTs1mIFuu7S1fF5pLgo23yrQCVk/XD/6nM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A0PHWdKUdBuU+jLgMQFbOYy/x5YvhYqQUzjE/j6GGHgNTcGcxj8mBx26GwrBsGDcP
	 HmEfKd8oIy4kSfF1+R2/wrQGTxs91aVlll8xtmBC6GRdddRqgrqL+zgpS4vvIQdVkf
	 CP3wc1hK/BvE9Beak0fMy82Bm+x1PCPOkUf59THxvxfG8RPQNPjT/7a3iTUxv3I/NI
	 cwAJZxIv7Umk8mVjjNRK4Y9Mh9W3RVAFvutRFNA1kYfbDKXDN6quslrbRd7TlAKe4s
	 IggrEjhvoX0sEgvJDoO/fDicx2Zfh1XOsNLLqMkC+leWopj2qIsjgvFaIiMnRFfpCZ
	 Z/ddQTuHipYRw==
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
Subject: [PATCH v2 3/7] perf annotate: Pass annotation_options to annotation_line__print()
Date: Mon, 10 Mar 2025 15:49:21 -0700
Message-ID: <20250310224925.799005-4-namhyung@kernel.org>
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

The annotation_line__print() has many arguments.  But min_percent,
max_lines and percent_type are from struct annotaion_options.  So let's
pass a pointer to the option instead of passing them separately to
reduce the number of function arguments.

Actually it has a recursive call if 'queue' is set.  Add a new option
instance to pass different values for the case.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 2e0f70b4872b475a..469fcc945126f4f7 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -760,13 +760,14 @@ static int disasm_line__print(struct disasm_line *dl, u64 start, int addr_fmt_wi
 
 static int
 annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start,
-		       struct evsel *evsel, int min_pcnt, int printed,
-		       int max_lines, struct annotation_line *queue, int addr_fmt_width,
-		       int percent_type)
+		       struct evsel *evsel, struct annotation_options *opts,
+		       int printed, struct annotation_line *queue, int addr_fmt_width)
 {
 	struct disasm_line *dl = container_of(al, struct disasm_line, al);
 	struct annotation *notes = symbol__annotation(sym);
 	static const char *prev_line;
+	int max_lines = opts->max_lines;
+	int percent_type = opts->percent_type;
 
 	if (al->offset != -1) {
 		double max_percent = 0.0;
@@ -786,19 +787,25 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 		if (al->data_nr > nr_percent)
 			nr_percent = al->data_nr;
 
-		if (max_percent < min_pcnt)
+		if (max_percent < opts->min_pcnt)
 			return -1;
 
 		if (max_lines && printed >= max_lines)
 			return 1;
 
 		if (queue != NULL) {
+			struct annotation_options queue_opts = {
+				.max_lines = 1,
+				.percent_type = percent_type,
+			};
+
 			list_for_each_entry_from(queue, &notes->src->source, node) {
 				if (queue == al)
 					break;
 				annotation_line__print(queue, sym, start, evsel,
-						       0, 0, 1, NULL, addr_fmt_width,
-						       percent_type);
+						       &queue_opts, /*printed=*/0,
+						       /*queue=*/NULL,
+						       addr_fmt_width);
 			}
 		}
 
@@ -1225,8 +1232,7 @@ int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel)
 		}
 
 		err = annotation_line__print(pos, sym, start, evsel,
-					     opts->min_pcnt, printed, opts->max_lines,
-					     queue, addr_fmt_width, opts->percent_type);
+					     opts, printed, queue, addr_fmt_width);
 
 		switch (err) {
 		case 0:
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

