Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0BF19E98B;
	Sun,  1 Jun 2025 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748760785; cv=none; b=cGjvcuS3qtp7TiHGWLYUT0YxeEqJGY6lsvAQrMW1arwGCSysW3d9q2KcHLl5D7vrygsb9dFC2u6yl98hrfvf1c/thrxqcRl6C4BfDOwLliq6Svg4EUSsH/TXIKSoq5mD11s4V2SDyOgXh5F0fSlttngo5yOvUeB1BvcyjI7pMVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748760785; c=relaxed/simple;
	bh=HkrML6il0hnxClDP7JZCCS/zpvPHPDWqmrLKm9GftDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmM7soK33oOTE7KEFaXOAYCi5K8vLGnogzKRV7dRy8bpXPmcCfG1nT1pEc+86Pq8H40NeYgLsPLuh3hL2MzkLwJUkCAzQ/EpsoZDfX6NGZeqwYwjU+W3mqX+DS6vvSsjNcRmm7bNx9V19HpbTsQ9EkEMyLW7jH08CVtRbI8ufTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4tyEcVA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4tyEcVA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4A7C4CEFE;
	Sun,  1 Jun 2025 06:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748760785;
	bh=HkrML6il0hnxClDP7JZCCS/zpvPHPDWqmrLKm9GftDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s4tyEcVAhcMmHuOsU8A7b+6dwSEEjvhcnDUD3DhfrBigvrYSVxsZjHZ8Aqyn7UVFN
	 GJriLaxAwraND468br0b5qBz4I2VRb1VDFqAKBwnJqEi6zfbw9/KJEorKyo30LVL67
	 8NnzH1d6awHF3iJrhJ+SuyFynv8uTTwXdPMPgsPD6DxY3CrZDyJkk4kuJ3OqHjajgy
	 l8HO6ekNfs9+6a7DJWcv82HTzrdF/iCpbdw19+xy+1mzO8K3df92zDTeBCAk95Ani1
	 o51aoCCim7lrdZ+kE8KO0T0IQQqzRPyyHHW32C2+r/T7t6KuXoDpdg6g80J62nQrP3
	 v7fA26/YbVKPg==
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
Subject: [PATCH 4/6] perf annotate: Simplify width calculation in annotation_line__write()
Date: Sat, 31 May 2025 23:53:00 -0700
Message-ID: <20250601065302.12531-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250601065302.12531-1-namhyung@kernel.org>
References: <20250601065302.12531-1-namhyung@kernel.org>
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
index 7df726b99541a571..94f73c8944cde519 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1991,6 +1991,7 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 					   symbol_conf.show_nr_samples ? "Samples" : "Percent");
 		}
 	}
+	width -= pcnt_width;
 
 	if (notes->branch) {
 		if (al->cycles && al->cycles->ipc)
@@ -2054,11 +2055,12 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
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
@@ -2067,7 +2069,7 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 			printed = scnprintf(bf, sizeof(bf), "%-*s  ",
 					    notes->src->widths.addr, " ");
 		obj__printf(obj, bf);
-		obj__printf(obj, "%-*s", width - printed - pcnt_width - cycles_width + 1, al->line);
+		obj__printf(obj, "%-*s", width - printed + 1, al->line);
 	} else {
 		u64 addr = al->offset;
 		int color = -1;
@@ -2110,9 +2112,11 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 		if (wops->change_color)
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

