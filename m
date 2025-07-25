Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E22253F00;
	Fri, 25 Jul 2025 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753472284; cv=none; b=GSz7NO/k3LqSB59cH9a2Do/NkB78cuveV+HsaeXJCFYpcf65NMx149fXOjdJvmNGtWXQxIQD9a6gLyrEm09U6O6p1LX1U5HE99aaHbl222lcxUUX+io3BM2nFjdMrfhcZkpAcG0Sxp3HRaucxz22a6Kz/+kTwRFWjm4IikqfrhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753472284; c=relaxed/simple;
	bh=wQ9L7f8hO9TQ6BvEZdDgbDLshKYzraqvQQQMdZzUV/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuWsR1k8ZXzS6QO9Rql3H8+FO+Vd25aXpUpLE+MvrEKeNov8YMksG2+mOjcazMXi55ZjOJR5PatsYZkCz4Bjtz0GOpp+DA53fuMXrfcpJFiMH86QkY/u1g2Wk8QzaJ2c3tTMGqZMb2JLSU4retyG6Ss6GRIrURUWLpKJ+qKHXcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2WIh1/+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2WIh1/+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F98C4CEF8;
	Fri, 25 Jul 2025 19:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753472283;
	bh=wQ9L7f8hO9TQ6BvEZdDgbDLshKYzraqvQQQMdZzUV/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p2WIh1/+nxQMD4lbCK+Dy6pSEcbo+HQGR9I6k+gzPBTCh9+pSSRcGzKkwogRgrdMo
	 vQ/Sr1zXNRUzm0CafR//XUrH+vSEwiLFDiIBeZYuFqmcdZdh8SwFLql6mXsFISxHhF
	 o9xIGkiXwL2mPwR/N38R4A5mCDsQRWjkLQXFCQG/SzuMc5vGMvQYV+NDNGqpWUdD9g
	 r4do+Hf6ze9DKTtOGbrPWjyT1Z5m+iP/Dzlf2FEaqjZ/CNgeVF8UMe3Pn7QtR5PMBJ
	 D94hvIQy/kNfJMHFqbuxQt7GXBLbWZsbXlTDDZgMPuoFfGw8oa8F1htX4QkkE90Z2g
	 jbIgy8hjEL6fQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v4 4/9] perf annotate: Simplify width calculation in annotation_line__write()
Date: Fri, 25 Jul 2025 12:37:50 -0700
Message-ID: <20250725193755.12276-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250725193755.12276-1-namhyung@kernel.org>
References: <20250725193755.12276-1-namhyung@kernel.org>
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
index c21152710148b68c..d69e406c1bc289cd 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1993,6 +1993,7 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 					   symbol_conf.show_nr_samples ? "Samples" : "Percent");
 		}
 	}
+	width -= pcnt_width;
 
 	if (notes->branch) {
 		if (al->cycles && al->cycles->ipc)
@@ -2056,11 +2057,12 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
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
@@ -2069,7 +2071,7 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 			printed = scnprintf(bf, sizeof(bf), "%-*s  ",
 					    notes->src->widths.addr, " ");
 		obj__printf(obj, bf);
-		obj__printf(obj, "%-*s", width - printed - pcnt_width - cycles_width + 1, al->line);
+		obj__printf(obj, "%-*s", width - printed + 1, al->line);
 	} else {
 		u64 addr = al->offset;
 		int color = -1;
@@ -2112,9 +2114,11 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
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
2.50.1

