Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A053AB298;
	Thu,  4 Jun 2026 21:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780609775; cv=none; b=mYaodILeVaes1qLPGYWNYXHLL/wCPO2/w63A3fHbvXiH22b34JpLbz7in/UayyjrcseTJFcCxFzYosLgszy6KkWxWxVmV/6AwN5fuTo3+w42y7AhOjSPIef5qgyFnTYQD/6jSGKHdshJ8ywFiI0wvVBYVCYsxa0wH58607U0agc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780609775; c=relaxed/simple;
	bh=v99ERl0mvlavTFiAOqQv/oE8nGh7o84bP2ip0E5pQ3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijQy5yk3uA3oZBi8V5Yi7uvD+Zl1K7Oy3detSEnKAWZ89zObzFb860/PAXCVnemQAEnRvBgFO4PwiTlh0w1v7nHJpsjL+yrQ0IHI4m1juYbfnfKKel5Ama/s5JIpCpkMQ+HOIrljmKTKvwTWD2V8GU6Y27ZBUCYchdhsQo+gD5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSTR/qyK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSTR/qyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED571F00893;
	Thu,  4 Jun 2026 21:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780609774;
	bh=5UAw5XE5RZgXmMye4BK+b2VKFEwiLzlKG3Am1FCVSlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JSTR/qyKXXK8Oehbr+uNLKsFkv+0ZzkPK27s/ZLBsR+Kwl85XejfKGhdSpqfLPpGR
	 fjeSJrorDIABTejer2c1X2dgkg8c560n0pFhy+tdHdwWwAaHi8Z6HBgIBSL10tFdmG
	 zwTdFn9JCCB65SWr5jRIuAk3TYSal7XZRcGSW0h63vSvz7kCGZqchRJ9yEi4tJShQz
	 NvjvYghnlvSe3vnMac3cIsJt/y5VDXN5L9dEJJ8cbIm9djOjB0w8Ixo76xiAsGjOgm
	 myu9mItnxyQEAOkz0/skUa4Qy2BDafBXDNKOEE/ZoldEK5dzgUGTVF+EZOMZi8dp3u
	 Tp3U7pDSf+LYg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 4/4] perf timechart: Remove unnecessary copy of backtrace
Date: Thu,  4 Jun 2026 14:49:30 -0700
Message-ID: <20260604214931.2202322-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260604214931.2202322-1-namhyung@kernel.org>
References: <20260604214931.2202322-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pattern of strdup() and free() is found, and I think it just can
use the original backtrace directly.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-timechart.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 4efac73a714c5e5f..04dbb944a42720b4 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -300,7 +300,7 @@ static void pid_put_sample(struct timechart *tchart, int pid, int type,
 	sample->type = type;
 	sample->next = c->samples;
 	sample->cpu = cpu;
-	sample->backtrace = backtrace ? strdup(backtrace) : NULL;
+	sample->backtrace = backtrace;
 	c->samples = sample;
 
 	if (sample->type == TYPE_RUNNING && end > start && start > 0) {
@@ -429,12 +429,14 @@ static void sched_wakeup(struct timechart *tchart, int cpu, u64 timestamp,
 	struct per_pid *p;
 	struct wake_event *we = zalloc(sizeof(*we));
 
-	if (!we)
+	if (!we) {
+		free((char *)backtrace);
 		return;
+	}
 
 	we->time = timestamp;
 	we->waker = waker;
-	we->backtrace = backtrace ? strdup(backtrace) : NULL;
+	we->backtrace = backtrace;
 
 	if ((flags & TRACE_FLAG_HARDIRQ) || (flags & TRACE_FLAG_SOFTIRQ))
 		we->waker = -1;
@@ -461,20 +463,28 @@ static void sched_switch(struct timechart *tchart, int cpu, u64 timestamp,
 			 const char *backtrace)
 {
 	struct per_pid *p = NULL, *prev_p;
+	bool backtrace_used = false;
 
 	prev_p = find_create_pid(tchart, prev_pid);
 
 	p = find_create_pid(tchart, next_pid);
 
-	if (prev_p->current && prev_p->current->state != TYPE_NONE)
+	if (prev_p->current && prev_p->current->state != TYPE_NONE) {
 		pid_put_sample(tchart, prev_pid, TYPE_RUNNING, cpu,
 			       prev_p->current->state_since, timestamp,
 			       backtrace);
+		backtrace_used = true;
+	}
 	if (p && p->current) {
-		if (p->current->state != TYPE_NONE)
+		if (p->current->state != TYPE_NONE) {
+			if (backtrace && backtrace_used)
+				backtrace = strdup(backtrace);
+
 			pid_put_sample(tchart, next_pid, p->current->state, cpu,
 				       p->current->state_since, timestamp,
 				       backtrace);
+			backtrace_used = true;
+		}
 
 		p->current->state_since = timestamp;
 		p->current->state = TYPE_RUNNING;
@@ -488,6 +498,9 @@ static void sched_switch(struct timechart *tchart, int cpu, u64 timestamp,
 		if (prev_state == 0)
 			prev_p->current->state = TYPE_WAITING;
 	}
+
+	if (!backtrace_used)
+		free((char *)backtrace);
 }
 
 /*
@@ -655,7 +668,6 @@ process_sample_sched_wakeup(struct timechart *tchart,
 
 	backtrace = cat_backtrace(sample, &tchart->session->machines.host);
 	sched_wakeup(tchart, sample->cpu, sample->time, waker, wakee, flags, backtrace);
-	free((char *)backtrace);
 	return 0;
 }
 
@@ -678,7 +690,6 @@ process_sample_sched_switch(struct timechart *tchart,
 	backtrace = cat_backtrace(sample, &tchart->session->machines.host);
 	sched_switch(tchart, sample->cpu, sample->time, prev_pid, next_pid,
 		     prev_state, backtrace);
-	free((char *)backtrace);
 	return 0;
 }
 
-- 
2.54.0.1032.g2f8565e1d1-goog

