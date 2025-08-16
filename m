Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422701DC988;
	Sat, 16 Aug 2025 03:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755314208; cv=none; b=mWGW7Cx75gcA5H1LEWaj5oEA35XiHJQ1pEVqr+pe7v2MwgeYy7f2HxhcKZbk03ujVRxaLNPeAYPRVjStutK2GawzbuzTUG4UXKA2QDsCwmukuUHHLvEYC3M39+afOwnRT3MKBrWo6cFVl3uwXHuhCrSk4ypJll68u1D8pigQgVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755314208; c=relaxed/simple;
	bh=6t1acRc6hqOEWUSOnk4iV6/B/TzQ0IIv9Z8zDuepklk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTb02n/RzF55HUdLmWwdSqW6Sm3CMwBoHMur8ywYNDbQEu3bGQdWMTpTf0+CqbPYEfdNgZtAvFDkVPoMeZfkfII5Pdc5+YKdVsEdtsULlaj3eNqtdGCMgPzZHObS3BTuJz0ehwF7Noc2/mQJTyxiXqCGxYMP0VgV7VqKIGihKS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovI02Pui; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovI02Pui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7DAC4CEEB;
	Sat, 16 Aug 2025 03:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755314208;
	bh=6t1acRc6hqOEWUSOnk4iV6/B/TzQ0IIv9Z8zDuepklk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ovI02PuiO26hJuDHcPi97m3nCgMuh+m6GypYr9uDsTEUCNrnJLtXk1RXubwIOI+D4
	 /p3V4a4A9pQYS3Igoh8jwuixZ4lfPA82YbemOoH5NZEb9x3an30At1vR90cDuR1jZf
	 onpY+FeETInPZmp0wtHgv8Y2osW7/QoE5G8Pfwq59Bt6/zy87WEtmNbu0QWFF0uOB1
	 Th2V17oGbOVFt0LDlxnyV2MigjsfsMt1JlfpKOmkGZB2LVko77dKxhFTR6tYJ3OpyB
	 VfPmvkjKkmFCcduhZUH2T268qAXekB8MbIcrZDtw6q3+pp3DGpd07jiTLPC4pXKuXP
	 FGukVk+iHI+LA==
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
Subject: [PATCH v5 06/12] perf annotate: Return printed number from disasm_line__write()
Date: Fri, 15 Aug 2025 20:16:29 -0700
Message-ID: <20250816031635.25318-7-namhyung@kernel.org>
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

Like other print functions, make disasm_line__write() return the number
of printed characters.  It'll be used to skip unnecessary operations
when the screen is full.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 6389292ad8f95d89..698bc4f559e83043 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1743,7 +1743,7 @@ static double annotation_line__max_percent(struct annotation_line *al,
 	return percent_max;
 }
 
-static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
+static int disasm_line__write(struct disasm_line *dl, struct annotation *notes,
 			       void *obj, char *bf, size_t size,
 			       void (*obj__printf)(void *obj, const char *fmt, ...),
 			       void (*obj__write_graph)(void *obj, int graph))
@@ -1771,8 +1771,8 @@ static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
 		obj__printf(obj, "  ");
 	}
 
-	disasm_line__scnprintf(dl, bf, size, !annotate_opts.use_offset,
-			       notes->src->widths.max_ins_name);
+	return disasm_line__scnprintf(dl, bf, size, !annotate_opts.use_offset,
+				      notes->src->widths.max_ins_name) + 2;
 }
 
 static void ipc_coverage_string(char *bf, int size, struct annotation *notes)
-- 
2.50.1

