Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA1A4B5AE;
	Sat,  3 Aug 2024 21:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722719615; cv=none; b=YSvpgTnhZBso+iJcGlbhDxpycm6ni8seA5SHJDukigOAfI3ERRxQga5LCXF+vIzuOeSpPv2JbKj/25vGTrCnCYPM7wCTGayESspiqiT/IywOIYs2L26BUcCRNAQJrgr7S92A/QBhC0QA25lGWxfPMPKn6t8hvX16zKpK0rM82YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722719615; c=relaxed/simple;
	bh=Sa77W2mGtTdRYoOM3VRTSR43IiKdEmQY77hNIkja2PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiOTr+jVdlzLZx9vzsLldDFqVyF3pPLOfJnNTFBCl12C0RELpDSszpQ7r2vjKRl/+6srFs5w/ys4za57WTk0cYTqquJCIKEphkFE0c7lmupDLDsVmy18sRP/hjbSIKxZbPe9MBBu8T6S5P9hZMe3II7ySSWcqwPL885QsG3mGY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+Bduktz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+Bduktz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48802C4AF0C;
	Sat,  3 Aug 2024 21:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722719614;
	bh=Sa77W2mGtTdRYoOM3VRTSR43IiKdEmQY77hNIkja2PQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L+Bduktz/9aUD/ukNZaLzAKycBGMH/+aOYWl5/WPPlyA1Hdtve9Vz5mPxZ5EAG7gX
	 mpnfYOG3ht26A7aet5xQ2utmHu7GIEpz/gtfenOi4O9zaIhX/kF3obmGIPPwq+TH8f
	 oyvlcpJH9efThEOlhsg0/dAP9wIbdSzD5GLhaEu94xzpu3k69EzcqP+T4kHMBpqdgz
	 IpSo09x5sjdI1PKxkKfwh+srdBHl35T7F6OqMr0PQU43a1lNUVE/W9u1TiAW1/jrEm
	 cvjPV+qr03ogGz6OPX828xolLIyiKNiZ1eeo+L0rybV4ncHk/PRnN9SIPSMbjBOwa7
	 Ku+rhsnFbOjcw==
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
Subject: [PATCH 1/5] perf annotate: Use al->data_nr if possible
Date: Sat,  3 Aug 2024 14:13:28 -0700
Message-ID: <20240803211332.1107222-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
In-Reply-To: <20240803211332.1107222-1-namhyung@kernel.org>
References: <20240803211332.1107222-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The data_nr keeps the number of entries in al->data[] so it should use
it when it iterates the array.  The notes->src->nr_events should have
the same number but it'd be natural to use al->data_nr.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index a2ee4074f768..91ad948c89d5 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1594,13 +1594,12 @@ bool ui__has_annotation(void)
 
 
 static double annotation_line__max_percent(struct annotation_line *al,
-					   struct annotation *notes,
 					   unsigned int percent_type)
 {
 	double percent_max = 0.0;
 	int i;
 
-	for (i = 0; i < notes->src->nr_events; i++) {
+	for (i = 0; i < al->data_nr; i++) {
 		double percent;
 
 		percent = annotation_data__percent(&al->data[i],
@@ -1672,7 +1671,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 				     void (*obj__write_graph)(void *obj, int graph))
 
 {
-	double percent_max = annotation_line__max_percent(al, notes, percent_type);
+	double percent_max = annotation_line__max_percent(al, percent_type);
 	int pcnt_width = annotation__pcnt_width(notes),
 	    cycles_width = annotation__cycles_width(notes);
 	bool show_title = false;
@@ -1690,7 +1689,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 	if (al->offset != -1 && percent_max != 0.0) {
 		int i;
 
-		for (i = 0; i < notes->src->nr_events; i++) {
+		for (i = 0; i < al->data_nr; i++) {
 			double percent;
 
 			percent = annotation_data__percent(&al->data[i], percent_type);
-- 
2.46.0.rc2.264.g509ed76dc8-goog

