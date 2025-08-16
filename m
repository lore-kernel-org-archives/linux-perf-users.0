Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178DE1D9A5D;
	Sat, 16 Aug 2025 03:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755314208; cv=none; b=WNqm+itGfHOdnpJPCvNSiGCYM1oeyF3oRRO8M5ugJggorM4yDC1WT+x4bRGsq5cG92QKsNjJkRX0PH7QCHn8rK5TZVIyCBvGEg+iadQy26VvryTlPJM+s/jiltTW61QX409o75X14h20pskR9XmZhk5olJerTgR077YPMd/R5SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755314208; c=relaxed/simple;
	bh=UYC9rFsxpN+onryemYIQyLiFHC9fW6/Ag397Hiu3TNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIuFYCEGgBSe/ill6gxzhXxiBZ5+vWid4ERouz7GVnAeSCq0kPhtMF9sWnrWgjQJic2nthPz1rjZY9YEJkcRUNxafX0tpj3k+bDdxPX6wpaXLsbGYZUrgOubJLWsdWhhVJH915iDw9SRH/MyNbcbsSOKBol1YAz6qO4FLQUv7b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JixsBtMd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JixsBtMd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58914C4CEF6;
	Sat, 16 Aug 2025 03:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755314207;
	bh=UYC9rFsxpN+onryemYIQyLiFHC9fW6/Ag397Hiu3TNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JixsBtMd/v3c6N/sjaBx+qF64fzDJ3+8k8p7gG1rSED8BluoH5kMDKbD6tpTn/YFQ
	 PmbdMQB70ip5hEjX8BlIAhbKmq12S2NrxM6ahTazuFnOBixxC/cQwS6/Sa7dUY9HbX
	 R0DTKD0fmVYtLW7Swr7PSnIIigx1v7QIRCCj7SyQQyhuhJ/XHM17zIqH0XD1uYk/iN
	 o2JRq5BgivnnZBGhWb/D6bjXagWRMzEgcv/aGvayfzwd1Xpt0J9nHnfabrBj53MgXX
	 yPO6E3NZchX5/FTxhlt+4Qu0MN38ZM4bJY4dDYX2yH0CPb83XYkCOV7NK3IjZ87kbZ
	 9Mx5VcgJEkS3g==
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
Subject: [PATCH v5 05/12] perf annotate: Simplify width calculation in annotation_line__write()
Date: Fri, 15 Aug 2025 20:16:28 -0700
Message-ID: <20250816031635.25318-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816031635.25318-1-namhyung@kernel.org>
References: <20250816031635.25318-1-namhyung@kernel.org>
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
 tools/perf/util/annotate.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 2544d83a52a0a596..6389292ad8f95d89 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1993,6 +1993,7 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 					   symbol_conf.show_nr_samples ? "Samples" : "Percent");
 		}
 	}
+	width -= pcnt_width;
 
 	if (notes->branch) {
 		if (al->cycles && al->cycles->ipc)
@@ -2056,11 +2057,13 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 			obj__printf(obj, "%*s", ANNOTATION__AVG_IPC_WIDTH, bf);
 		}
 	}
+	width -= cycles_width;
 
 	obj__printf(obj, " ");
+	width -= 1;
 
 	if (!*al->line)
-		obj__printf(obj, "%-*s", width - pcnt_width - cycles_width, " ");
+		obj__printf(obj, "%-*s", width, " ");
 	else if (al->offset == -1) {
 		if (al->line_nr && annotate_opts.show_linenr)
 			printed = scnprintf(bf, sizeof(bf), "%-*d ",
@@ -2069,7 +2072,8 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 			printed = scnprintf(bf, sizeof(bf), "%-*s  ",
 					    notes->src->widths.addr, " ");
 		obj__printf(obj, bf);
-		obj__printf(obj, "%-*s", width - printed - pcnt_width - cycles_width + 1, al->line);
+		width -= printed;
+		obj__printf(obj, "%-*s", width, al->line);
 	} else {
 		u64 addr = al->offset;
 		int color = -1;
@@ -2112,9 +2116,11 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 		if (change_color)
 			obj__set_color(obj, color);
 
+		width -= printed;
+
 		disasm_line__write(disasm_line(al), notes, obj, bf, sizeof(bf), obj__printf, obj__write_graph);
 
-		obj__printf(obj, "%-*s", width - pcnt_width - cycles_width - 3 - printed, bf);
+		obj__printf(obj, "%-*s", width, bf);
 
 		(void)apd;
 	}
-- 
2.50.1

