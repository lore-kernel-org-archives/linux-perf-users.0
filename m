Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEB42356B3;
	Mon,  3 Mar 2025 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023490; cv=none; b=ficnG43rO4ezUnUqrZ7Qz+9uXTeDIt9UPmh23m0t3K07eyZJRV0m+KRiLxkZJLiAq6rD/TYKAw2s9RQKWToSWrCsoUPoRApMYGTu9EtzpncUJMuLSvFFJkoj8GMipaIqAtnjuBxWJsYQpEV5PZ4eIoyyqXjT3ps/hpVZStp+5+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023490; c=relaxed/simple;
	bh=4Xm6O4mqOxp36iPtkQwrOmQo86Nd/MpTLAxMfwDI5/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hu+msSWx4fhpin8XFrFDF2PLC5mpBMLRXIdebwpVoqILDDKvW7tCj8Y4CDo+uG3k6qDijwApNHf34qZmcjD5V6Z4nI9b+Vu/+Yl+Z2a7/FdwPbHmhV2Zbn9ohxME8KHoC+eJzhbaHH3za912se9bxY4Po4zgcsNDqj2Rdnnw2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nX4C6Ugy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nX4C6Ugy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E67C4CEE5;
	Mon,  3 Mar 2025 17:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741023489;
	bh=4Xm6O4mqOxp36iPtkQwrOmQo86Nd/MpTLAxMfwDI5/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nX4C6UgyT6wVb3cteQawxmmu+DoK4x7ThQvJVVl8n52WUa5LKPFVrVqb7M2F73tlR
	 LAWtZRHM6uR2ZKhbhO0pdtJECjAjGc/Rzug9qsdnF6fokIK3CqJ5NZxI/dNzqwqBqY
	 w1Rg3TV/36zO6Ybh1kFbyMbhXro74mvWnthEWMnYdBTpFPmReDNuMbiapAbGjFOsAB
	 2LDK3aWjfrdooFzbZWzndaFpM32ArsgbqCd1++4c58SdKWJpqlEXkVqWNzkPh8nL5W
	 IqfIbj7QontYeLX7s8rlzj/I8eDxuR5PL9p5fNGvssKtXr+I3e8tbiLqzJMkAN7spV
	 1R3kHWDw8fNZg==
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
Subject: [PATCH 2/7] perf annotate: Remove unused len parameter from annotation_line__print()
Date: Mon,  3 Mar 2025 09:38:02 -0800
Message-ID: <20250303173807.1765098-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303173807.1765098-1-namhyung@kernel.org>
References: <20250303173807.1765098-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's not used anywhere, let's get rid of it.

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
2.48.1.711.g2feabab25a-goog

