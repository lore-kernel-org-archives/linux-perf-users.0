Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53401A2545;
	Thu,  3 Jul 2025 01:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507385; cv=none; b=adkwWLatEpV4S33hprPEHAIknFuGk9d7qn93hCxbq3i1KD4oZmZ6fYOB/euX/+FZ1YYDlbzqMjWCvEFjn9s2WvkfTZqNPB5bzm/OVdUj1IisQHH4kgm6sVD0SXeshy5zO1SRhECeQ0TikCR15PJmlxN5PfqC2UfA2WjExok+PFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507385; c=relaxed/simple;
	bh=dWEA9ZdTPWOFgxHfGqwXTpZdPwdHlpg76bVqV0LyIzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXQC3srU4qasgNlXMJ+EepCIs2UQ1t7XyXPBl/Brp8CE9B0c0q4uxieFA6UeFW0zz8aO+YRB9+clJpoNVAX2Z6x5iNl/tBSZtmk35+dxuYTbXCQuOvHIYWFuzO3z8Nd2s2YwyIce9RqvfonA96I5zrdR2NaDecyk3UPM9lRSIaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEckU2sv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEckU2sv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4050CC4CEED;
	Thu,  3 Jul 2025 01:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751507384;
	bh=dWEA9ZdTPWOFgxHfGqwXTpZdPwdHlpg76bVqV0LyIzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bEckU2svP7L2afnRVqMefL+Jxr9gIvZAOKNFdaIIMXSCnumr0yJW9h9lO/6NqEwFx
	 TZe1dy9a8bOrnNdAs1X+rZNRpzofwnk2iZrevV63r0qjqhq3cDr+6hLfEn8n1UmaHV
	 jjJK5wFbS/DfO3w6fFX79ATrvxMLL+nw9zPyzx9ytdcSpQRkTW3Ei5dAzn5QQt9iH0
	 8jOtyQWO1wG/dsz0GguAjg6TAuVnxz6WznTXqJHymLbpi1y6UUWXeGIlkOECD4Rpk8
	 KujEeU41r+pMuVowPd3k7u3QcWXSs8Yba6vzhBLeiMZPi6zFY9ZXcHRoTfs80vffA+
	 wDT04wg2352GA==
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
Subject: [PATCH 3/8] perf sched: Fix memory leaks in 'perf sched map'
Date: Wed,  2 Jul 2025 18:49:37 -0700
Message-ID: <20250703014942.1369397-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250703014942.1369397-1-namhyung@kernel.org>
References: <20250703014942.1369397-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It maintains per-cpu pointers for the current thread but it doesn't
release the refcounts.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-sched.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index fa4052e040201105..b73989fb6acef8d6 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1634,6 +1634,7 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	const char *color = PERF_COLOR_NORMAL;
 	char stimestamp[32];
 	const char *str;
+	int ret = -1;
 
 	BUG_ON(this_cpu.cpu >= MAX_CPUS || this_cpu.cpu < 0);
 
@@ -1664,17 +1665,20 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	sched_in = map__findnew_thread(sched, machine, -1, next_pid);
 	sched_out = map__findnew_thread(sched, machine, -1, prev_pid);
 	if (sched_in == NULL || sched_out == NULL)
-		return -1;
+		goto out;
 
 	tr = thread__get_runtime(sched_in);
-	if (tr == NULL) {
-		thread__put(sched_in);
-		return -1;
-	}
+	if (tr == NULL)
+		goto out;
+
+	thread__put(sched->curr_thread[this_cpu.cpu]);
+	thread__put(sched->curr_out_thread[this_cpu.cpu]);
 
 	sched->curr_thread[this_cpu.cpu] = thread__get(sched_in);
 	sched->curr_out_thread[this_cpu.cpu] = thread__get(sched_out);
 
+	ret = 0;
+
 	str = thread__comm_str(sched_in);
 	new_shortname = 0;
 	if (!tr->shortname[0]) {
@@ -1769,12 +1773,10 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	color_fprintf(stdout, color, "\n");
 
 out:
-	if (sched->map.task_name)
-		thread__put(sched_out);
-
+	thread__put(sched_out);
 	thread__put(sched_in);
 
-	return 0;
+	return ret;
 }
 
 static int process_sched_switch_event(const struct perf_tool *tool,
@@ -3556,10 +3558,10 @@ static int perf_sched__map(struct perf_sched *sched)
 
 	sched->curr_out_thread = calloc(MAX_CPUS, sizeof(*(sched->curr_out_thread)));
 	if (!sched->curr_out_thread)
-		return rc;
+		goto out_free_curr_thread;
 
 	if (setup_cpus_switch_event(sched))
-		goto out_free_curr_thread;
+		goto out_free_curr_out_thread;
 
 	if (setup_map_cpus(sched))
 		goto out_free_cpus_switch_event;
@@ -3590,7 +3592,14 @@ static int perf_sched__map(struct perf_sched *sched)
 out_free_cpus_switch_event:
 	free_cpus_switch_event(sched);
 
+out_free_curr_out_thread:
+	for (int i = 0; i < MAX_CPUS; i++)
+		thread__put(sched->curr_out_thread[i]);
+	zfree(&sched->curr_out_thread);
+
 out_free_curr_thread:
+	for (int i = 0; i < MAX_CPUS; i++)
+		thread__put(sched->curr_thread[i]);
 	zfree(&sched->curr_thread);
 	return rc;
 }
-- 
2.50.0.727.gbf7dc18ff4-goog

