Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66436278761
	for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748446528; cv=none; b=iU0meRCrqN2Gd7KOSvTHR8ZAMc86nlO90hf4YAnEiQWJGTwC7l08XAfdy2DTOKsH1Q2hbNI9FMQGDAZ6g0wMKiIyGVSDYsREqgVHmdNSOlrcaFxdiHFnvQbLo2aithBPHS52x8iHbdDODUty4ilajVTxMzRi/A6W8iO+oQ06GeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748446528; c=relaxed/simple;
	bh=mPf8dBvx/IZwytsJ14/2EcpgAroqd8TR2fEqG33wk78=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oQXeExal7NtkGFQFY4/iu8ncT+2Jh3w6f2jskMejBaVS4Eir14XiEsMLSk7ssQBjziqUnKNwQgM74vlHD7c/FaVls+FJkQZuFj84zZI7iYqH2xN9RDq8/TWuQvhfoW59Nd6siCAz0ebe9FJGTsnsD6O66r7Jm8Ja8CYdmhupEq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 321561A2D;
	Wed, 28 May 2025 08:35:09 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6CDC63F5A1;
	Wed, 28 May 2025 08:35:24 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH] perf script: Print PERF_AUX_FLAG_COLLISION flag
Date: Wed, 28 May 2025 16:35:19 +0100
Message-Id: <20250528153519.188644-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Print out the collision flag for AUX trace data. This is helpful for
inspecting sample collisions.

After:

  0x217b60@/data_nvme1n1/niayan01/upstream/perf.data [0x40]: event: 11
  .
  . ... raw event: size 64 bytes
  .  0000:  0b 00 00 00 00 00 40 00 d2 ef 3f 00 00 00 00 00  ......@...?.....
  .  0010:  ff 0f 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
  .  0020:  1c 01 00 00 1c 01 00 00 10 bf 38 d6 11 01 00 00  ..........8.....
  .  0030:  03 00 00 00 00 00 00 00 06 00 00 00 00 00 00 00  ................

  3 1176120114960 0x217b60 [0x40]: PERF_RECORD_AUX offset: 0x3fefd2 size: 0xfff flags: 0x8 [C]

The added character '[C]' indicates the collision.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/event.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index c23b77f8f854..2c3081e5c81a 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -448,12 +448,13 @@ int perf_event__exit_del_thread(const struct perf_tool *tool __maybe_unused,
 
 size_t perf_event__fprintf_aux(union perf_event *event, FILE *fp)
 {
-	return fprintf(fp, " offset: %#"PRI_lx64" size: %#"PRI_lx64" flags: %#"PRI_lx64" [%s%s%s]\n",
+	return fprintf(fp, " offset: %#"PRI_lx64" size: %#"PRI_lx64" flags: %#"PRI_lx64" [%s%s%s%s]\n",
 		       event->aux.aux_offset, event->aux.aux_size,
 		       event->aux.flags,
 		       event->aux.flags & PERF_AUX_FLAG_TRUNCATED ? "T" : "",
 		       event->aux.flags & PERF_AUX_FLAG_OVERWRITE ? "O" : "",
-		       event->aux.flags & PERF_AUX_FLAG_PARTIAL   ? "P" : "");
+		       event->aux.flags & PERF_AUX_FLAG_PARTIAL   ? "P" : "",
+		       event->aux.flags & PERF_AUX_FLAG_COLLISION ? "C" : "");
 }
 
 size_t perf_event__fprintf_itrace_start(union perf_event *event, FILE *fp)
-- 
2.34.1

