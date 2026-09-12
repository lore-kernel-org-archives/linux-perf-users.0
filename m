Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E364BEE5F;
	Sat, 12 Sep 2026 05:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789192617; cv=none; b=ClJu5bPY988mxVXlkXsYcVjuU78ssXXx/55UoV1jOG4f4vBpf8GTOJYmXkJManuCdci/k23/R8QE7USnPUO3owncArjbK6+3qoa9N+NBpRD9nKDi+Pgqp+6qWbzNxiOinADb03hIRGJb/f5XoW0LmyLHGY4zcQki03KCGdmb0ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789192617; c=relaxed/simple;
	bh=vQnM29728odeLPAUj1IkvsTep0IjgJjfhRJyY4Jlo0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lKrOroUCgQsG0sUfCUexczA0bMRWShluOnx0kNudMJvKG9OfFkfdrvVW4iqZhdcTIhaToUc8wHNTdKd0JMorYefLaHnCW5cdLgaRF1DbIg2B+f9wLeQF3f3dqHx2nFQ/JGWcPXLgZRrjFhDUSU3oTknA3vfXnOIRtyvEj0fmYEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ng+LJGd0; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ng+LJGd0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=6R
	/b4zS8XP8H6wJrIB34ieHf09qcvPGBexQrQVoZDd8=; b=Ng+LJGd0nXLzn40JJI
	wxdAYdRygXFPQY5piPY2zVEiA/WKXiXS/h2cOdFZv64Al9hKsEvKpoTCLFauKujl
	V+4zXFfv/nBqZl1PVxQNGBA6FEUs0CdkmnmfZemMdOscOpZ64b3WAE/ecxjPMh58
	MIZf18twUYTCGitoBxQ3b0gnw=
Received: from localhost (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCHL2mD6aRqGTEXSQ--.43520S2;
	Sat, 12 Sep 2026 13:56:19 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Su <sh_def@163.com>
Subject: [PATCH] perf synthetic-events: Fix schedstat event lifetime handling
Date: Sat, 12 Sep 2026 14:56:19 +0900
Message-ID: <20260912055619.2284443-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCHL2mD6aRqGTEXSQ--.43520S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFWUur17JrW7ZF1rXFWkWFg_yoW8tr1rpr
	s8u3y3tr1vgw1jg343Jr48J348ur4xXrs3WF1YkryayF1rJr92yFW7KFy5try3ArWkZFy2
	y34qgrnaqFZrJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piHq2tUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6gRfvmqk6YTtIgAA3j

perf_event__synthesize_schedstat() has two event lifetime issues.

After a successful iteration, event is freed but retains its value. If
the next iteration starts with an unrecognized schedstat record type,
neither synthesizer assigns a new value. The stale pointer then passes
the NULL check, may be passed to process(), and is freed again.

In addition, when user_requested_cpus filters out a synthesized event,
the continue path skips free(event), leaking the event.

Make event local to each loop iteration so it always starts as NULL.
Also avoid the filter continue and unconditionally free each synthesized
event at the end of the iteration.

Fixes: c3030995f23b ("perf sched stats: Add record and rawdump support")
Signed-off-by: Hui Su <sh_def@163.com>
---
 tools/perf/util/synthetic-events.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 0c150193cca8..2eac2310a01d 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2817,7 +2817,6 @@ int perf_event__synthesize_schedstat(const struct perf_tool *tool,
 				     struct perf_cpu_map *user_requested_cpus)
 {
 	char *line = NULL, path[PATH_MAX];
-	union perf_event *event = NULL;
 	size_t line_len = 0;
 	char bf[BUFSIZ];
 	__u64 timestamp;
@@ -2858,6 +2857,7 @@ int perf_event__synthesize_schedstat(const struct perf_tool *tool,
 	 * for filtered out cpus.
 	 */
 	for (ch = io__get_char(&io); !io.eof; ch = io__get_char(&io)) {
+		union perf_event *event = NULL;
 		struct perf_cpu this_cpu;
 
 		if (ch == 'c') {
@@ -2872,12 +2872,12 @@ int perf_event__synthesize_schedstat(const struct perf_tool *tool,
 
 		this_cpu.cpu = cpu;
 
-		if (user_requested_cpus && !perf_cpu_map__has(user_requested_cpus, this_cpu))
-			continue;
-
-		if (process(tool, event, NULL, NULL) < 0) {
-			free(event);
-			goto out_free_line;
+		if (!user_requested_cpus ||
+		    perf_cpu_map__has(user_requested_cpus, this_cpu)) {
+			if (process(tool, event, NULL, NULL) < 0) {
+				free(event);
+				goto out_free_line;
+			}
 		}
 
 		free(event);
-- 
2.55.0

