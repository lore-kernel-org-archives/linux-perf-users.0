Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79771CAAF
	for <linux-perf-users@vger.kernel.org>; Sun, 12 May 2024 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715511983; cv=none; b=azN4DEIfiNHIuupvptwPDAGUkG3uV4N5hEZqWTij9XSCTiD/F3GAkCAztvrgcU3/KF1MAsoisLk4d3zdjjAv7rje8slAbKv95XQWlqBNs5ZhpfLeC//f/JfSFtNrBbCBXl0NiK94GADtq81dCFPa2q7CDSyBT9rGvxCQjumprYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715511983; c=relaxed/simple;
	bh=UgUrrOb0QcqEXQCT30383Obl8M6KqyfLad61AFt2jiI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qlap5ZVU92QYQF4GDgLgsthqed9b018b/3VyhNV6XJfbg0sKYz+t4p2Z/YdgCVT5OArabnRdJFhbhkaZ5fRwaiAkZS3f1ySmHhEsd18RsyWmqb/lQAHZH9PXMKdWHqCZpqKu9+RrcAmFsValS3dTjDC2esBtprYrPBfq17uyYZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 507871007;
	Sun, 12 May 2024 04:06:45 -0700 (PDT)
Received: from PF4Q20KV.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F2C033F641;
	Sun, 12 May 2024 04:06:16 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	James Clark <james.clark@arm.com>,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH] perf maps: Output debugging info for 'perf test'
Date: Sun, 12 May 2024 12:05:55 +0100
Message-Id: <20240512110555.999-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When run the test case 'maps__merge_in', it reports:

  # perf test -vvv maps__merge_in
     58: maps__merge_in:
  --- start ---
  test child forked, pid 35232
  overlapping maps in bpf_prog_1 (disable tui for more info)
  overlapping maps in bpf_prog_2 (disable tui for more info)
  overlapping maps in bpf_prog_3 (disable tui for more info)
  overlapping maps in bpf_prog_2 (disable tui for more info)
  overlapping maps in bpf_prog_3 (disable tui for more info)
  overlapping maps in kcore1 (disable tui for more info)
  ---- end(0) ----

The log suggests to disable TUI mode for printing verbose log. On the
other hand, 'perf test' always runs without enabling TUI mode.

The flag 'user_browser' is not a bool value. When it's equal or greater
than 1 the tool works in TUI or GUI mode, otherwise, 0 or '-1' means the
tool works as stdio mode. Correct the condition checking for the flag
'user_browser' to print the debugging logs properly.

After:

  # ./perf test -vvv maps__merge_in

   58: maps__merge_in:

  --- start ---
  test child forked, pid 36529
  overlapping maps:
   c8-12c 0 bpf_prog_1
   64-3e8 0 kcore1
   64-c8 0 kcore1
   12c-3e8 c8 kcore1
  overlapping maps:
   1f4-258 0 bpf_prog_2
   12c-3e8 c8 kcore1
   12c-1f4 c8 kcore1
   258-3e8 1f4 kcore1
  ...
  ---- end(0) ----
   58: maps__merge_in                                                  : Ok

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/maps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index ce13145a9f8e..073be9c309f9 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -764,7 +764,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 		if (map__start(pos) >= map__end(new))
 			break;
 
-		if (use_browser) {
+		if (use_browser >= 1) {
 			pr_debug("overlapping maps in %s (disable tui for more info)\n",
 				map__dso(new)->name);
 		} else if (verbose >= 2) {
@@ -787,7 +787,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 			}
 			map__set_end(before, map__start(new));
 
-			if (verbose >= 2 && !use_browser)
+			if (verbose >= 2 && use_browser <= 0)
 				map__fprintf(before, fp);
 		}
 		if (map__end(new) < map__end(pos)) {
@@ -805,7 +805,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 			assert(map__map_ip(pos, map__end(new)) ==
 			       map__map_ip(after, map__end(new)));
 
-			if (verbose >= 2 && !use_browser)
+			if (verbose >= 2 && use_browser <= 0)
 				map__fprintf(after, fp);
 		}
 		/*
-- 
2.39.2

