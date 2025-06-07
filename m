Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075E221C166;
	Sat,  7 Jun 2025 23:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749338744; cv=none; b=oAFEuBdVttbgNFVus89r9J1KHCx0N9ql/J7goVkN6JWr9UYUGwA1ymk0ZGkL0RVKsdx7htre9YgmjgvmRxH6zM5J7jt20KnJEKnmbKWT1ondRPbx2/69umZFdkrp8LO2p4OjoIlKvbRqvFXy1ihZ0muJsvbGyrra2jv4z/H9s/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749338744; c=relaxed/simple;
	bh=02vpk/tSqTRNafhW23igVufuqvHJlEzv+Ko4Jf2RXbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKewKvnX/SOzbUHjAFzTK6+tVbhOWO6E6QBfP+0m2wJjamEcJiIVgzmCYe2E2OS194gp6BBFSyMZ7EG0OEV2cei6lfwBHxbgFq7yBwPk+yyaQxPXy4vMeeZ7Octn1Bzy/gxVGFThkGQxMEYU0Mj7zGiNdMGHY4giduFYHFutUr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3fp+vQ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3fp+vQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459B1C4CEF6;
	Sat,  7 Jun 2025 23:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749338743;
	bh=02vpk/tSqTRNafhW23igVufuqvHJlEzv+Ko4Jf2RXbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h3fp+vQ3PZ0A/H8+DsiS5+wGhejkFIj6AKccwh3/TqF2/5CUYLyXuX3Lfydy0cErX
	 lF2UCGyfKub1DC47tYwr1JYVSWRW3NNQNjJmWlEtOlA1PS9w3gDVMUZeSPWfbA0wLJ
	 H9z/yTVk9Ircp28MeDrA0+q28F+eaTuTazffSgtMs/509hXOQcKOOnoSn9Xm/7K0jM
	 ZbN+ptwn6B/XfFrBWQ4egJmrM68gvFjrWMAGky7LRah34jCiN9B8+U/l5UbdzpO+YB
	 CbPnub8etXh5egJoDtQnT5IqiZ4NADcUYb40bMYpTZnQlQKw/ecODw3Y/ryjaAkuDp
	 +7khsq7wO6Wqw==
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
Subject: [PATCH v2 4/7] perf annotate: Simplify width calculation in annotation_line__write()
Date: Sat,  7 Jun 2025 16:25:37 -0700
Message-ID: <20250607232540.89488-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250607232540.89488-1-namhyung@kernel.org>
References: <20250607232540.89488-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The width is updated after each part is printed.  It can skip the output
processing if the total printed size is bigger than the width.

No function changes intended.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 2089feb7c700ac4d..fb7a63b8e253ca9a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1992,6 +1992,7 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 					   symbol_conf.show_nr_samples ? "Samples" : "Percent");
 		}
 	}
+	width -= pcnt_width;
 
 	if (notes->branch) {
 		if (al->cycles && al->cycles->ipc)
@@ -2055,11 +2056,12 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 			obj__printf(obj, "%*s", ANNOTATION__AVG_IPC_WIDTH, bf);
 		}
 	}
+	width -= cycles_width;
 
 	obj__printf(obj, " ");
 
 	if (!*al->line)
-		obj__printf(obj, "%-*s", width - pcnt_width - cycles_width, " ");
+		obj__printf(obj, "%-*s", width, " ");
 	else if (al->offset == -1) {
 		if (al->line_nr && annotate_opts.show_linenr)
 			printed = scnprintf(bf, sizeof(bf), "%-*d ",
@@ -2068,7 +2070,7 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 			printed = scnprintf(bf, sizeof(bf), "%-*s  ",
 					    notes->src->widths.addr, " ");
 		obj__printf(obj, bf);
-		obj__printf(obj, "%-*s", width - printed - pcnt_width - cycles_width + 1, al->line);
+		obj__printf(obj, "%-*s", width - printed + 1, al->line);
 	} else {
 		u64 addr = al->offset;
 		int color = -1;
@@ -2111,9 +2113,11 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 		if (change_color)
 			obj__set_color(obj, color);
 
+		width -= printed + 3;
+
 		disasm_line__write(disasm_line(al), notes, obj, bf, sizeof(bf), obj__printf, obj__write_graph);
 
-		obj__printf(obj, "%-*s", width - pcnt_width - cycles_width - 3 - printed, bf);
+		obj__printf(obj, "%-*s", width, bf);
 
 		(void)apd;
 	}
-- 
2.49.0

