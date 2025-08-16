Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBE618DF9D;
	Sat, 16 Aug 2025 03:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755314206; cv=none; b=bsLFIe5W7gZKdbBYzCezCSYw2d5LvyQ+ulUdrXfBD5zqH5oCOooxn/8eCaJfNwczeF6KIL3aJ7A07AiPypx01tTYxqK5FUv1X7zTmMsiqeB7IakCtuCWALDmZ92xqF1JwiZy/0SnidVlUKAEE5VxLIJ9qnyyhAzjdjVfwo5A16k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755314206; c=relaxed/simple;
	bh=QECyPubR/tntQ5r5osUsf57sJgrlHghmrbJxowtVoQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=od9VoXOXQKQle3IezBu1DZiTIVoElYeDsRA9qnMh9UGTIBw64fYX2+LAx1yz0QCIF2d6pWpU/nk7FZ3+Qq08X0i9gP1cFQjpCvcIomkrtbkQ/vX7hgTUMeOL2zER4i2bf1lPZTFgxHr8IuCbqrSMHXfz8gUravmkYbbFPp9p+cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvP7pgQz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvP7pgQz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9428C4CEF5;
	Sat, 16 Aug 2025 03:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755314206;
	bh=QECyPubR/tntQ5r5osUsf57sJgrlHghmrbJxowtVoQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QvP7pgQzHQ7AuYhQocI+ideIDY+T+fp33uT5nuSbWIKgpTw+AUTYYv4SiAeUyDQVp
	 XGc8PERp4zVazgWykwwe5mTQD4WdkCCaY85Bk39eNoZRMOjSIIFpBhJoFDO4Nj2D7K
	 5CaKl9zkh6ys0LIxfWg7Db7qZFDbW6tXev5E2RcqxbQwopXgbkYu40IVFA+MuZczU0
	 v2y6Hbv5s2NKdIF5hk7HFCxLqgTKTP7qVeJZSj1wEUiCi0OGeZQEJQ0B0kPunxKn/Y
	 27H8jjikg8vVos7Zyx2jObJApw0VIveCn+rGsApBJtVvubXxFxuNwOmg60yebqUVsq
	 gC0pf4PsdsjKg==
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
Subject: [PATCH v5 02/12] perf annotate: Remove annotation_print_data.start
Date: Fri, 15 Aug 2025 20:16:25 -0700
Message-ID: <20250816031635.25318-3-namhyung@kernel.org>
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

The start field is to control whether the output shows full address or
offset from the function start.  But actually it can be changed
dynamically in annotation__toggle_full_addr().  The informaiton should
be available through struct annotation.  Let's use it directly.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0dd475a744b6dfac..b699e14102b0587a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -770,7 +770,6 @@ struct annotation_print_data {
 	struct evsel *evsel;
 	struct arch *arch;
 	struct debuginfo *dbg;
-	u64 start;
 	int addr_fmt_width;
 };
 
@@ -845,7 +844,7 @@ annotation_line__print(struct annotation_line *al, struct annotation_print_data
 
 		printf(" : ");
 
-		disasm_line__print(dl, apd->start, apd->addr_fmt_width);
+		disasm_line__print(dl, notes->src->start, apd->addr_fmt_width);
 
 		if (opts->code_with_type && apd->dbg) {
 			struct annotated_data_type *data_type;
@@ -1230,7 +1229,6 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
 	struct annotation_print_data apd = {
 		.he = he,
 		.evsel = evsel,
-		.start = map__rip_2objdump(map, sym->start),
 	};
 	int printed = 2, queue_len = 0;
 	int more = 0;
@@ -1267,7 +1265,7 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
 		symbol__annotate_hits(sym, evsel);
 
 	apd.addr_fmt_width = annotated_source__addr_fmt_width(&notes->src->source,
-							      apd.start);
+							      notes->src->start);
 	evsel__get_arch(evsel, &apd.arch);
 	apd.dbg = debuginfo__new(filename);
 
-- 
2.50.1

