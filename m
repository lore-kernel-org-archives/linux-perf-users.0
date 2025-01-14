Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8A020F999;
	Tue, 14 Jan 2025 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736889779; cv=none; b=ewqwC/i5c4DvnQdFjygnuICEcG0DbvG6FfdL8yy6jlgqEAUvUWXT1LkhQ2Mgko772vlXVPqBSiyQIRl88jwkLoWZKOe1AUQ4OSoRBvkrul3kWnsZMVO7j2BfFH1jiFC9vEW5fpKVJP14HzINY7JdeHZJyAufKfC5lo21fX/z9p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736889779; c=relaxed/simple;
	bh=NxSCJ2syR3YYbNJ3uryk3tsjg2K+IpnX1WSFOL5GHws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evIgiUy4x4IJG9v3pVT9kQDMoY/QLlTnzJyXojslA0uJtpMcybVZAo4Uj3pwul5i06ikT/7UwYthEYDfQeIhwtjjJDa5OPbDNAfQS6mklrPZDcCKQU65MHSga8MHcZRWYVDOkh7DfI2rCk+LzGMghUFZQSuHIuWIQXkfPGm2lD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CG3y5Zcx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CG3y5Zcx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C30CC4CEE5;
	Tue, 14 Jan 2025 21:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736889778;
	bh=NxSCJ2syR3YYbNJ3uryk3tsjg2K+IpnX1WSFOL5GHws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CG3y5ZcxG9BSLqun5CgVmuEpdF7+XsGqtk90xQWfaoCTbB+dCo0ih7GWXroHd/mJE
	 JdayuVNXjuIoxoVi6+J2YVlyflAuOlxqozqn31N8xmZOmvcqe06rwLCX2UNXy8cZ7w
	 oZaKlObMWZ8xRSDQfXEkMB0Q4hasAbhuGAY89oyHsIlvDNOkKh14FUga036kh+SaSD
	 FTJh13wWIYWgMiMnK/WO2KvGBzr+5cOoDsSXMuIxrbuVH4b3tiSe2sFxnyLcheyXZL
	 7zC042A3asN9xrnfw/OCeOxx8bhHdQKyge5RvNvFGzmSpjjADMzoGLQ+klbMY0jnUH
	 5CldJpnTNDt8w==
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
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH 1/4] perf trace: Allocate syscall stats only if summary is on
Date: Tue, 14 Jan 2025 13:22:53 -0800
Message-ID: <20250114212256.160730-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
In-Reply-To: <20250114212256.160730-1-namhyung@kernel.org>
References: <20250114212256.160730-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The syscall stats are used only when summary is requested.  Let's avoid
unnecessary operations.  Pass 'trace' pointer to check summary and give
output file together.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-trace.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 40dd2dd1320d37a9..0691e817c15b4136 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1523,13 +1523,14 @@ struct thread_trace {
 	struct intlist *syscall_stats;
 };
 
-static struct thread_trace *thread_trace__new(void)
+static struct thread_trace *thread_trace__new(struct trace *trace)
 {
 	struct thread_trace *ttrace =  zalloc(sizeof(struct thread_trace));
 
 	if (ttrace) {
 		ttrace->files.max = -1;
-		ttrace->syscall_stats = intlist__new(NULL);
+		if (trace->summary)
+			ttrace->syscall_stats = intlist__new(NULL);
 	}
 
 	return ttrace;
@@ -1551,7 +1552,7 @@ static void thread_trace__delete(void *pttrace)
 	free(ttrace);
 }
 
-static struct thread_trace *thread__trace(struct thread *thread, FILE *fp)
+static struct thread_trace *thread__trace(struct thread *thread, struct trace *trace)
 {
 	struct thread_trace *ttrace;
 
@@ -1559,7 +1560,7 @@ static struct thread_trace *thread__trace(struct thread *thread, FILE *fp)
 		goto fail;
 
 	if (thread__priv(thread) == NULL)
-		thread__set_priv(thread, thread_trace__new());
+		thread__set_priv(thread, thread_trace__new(trace));
 
 	if (thread__priv(thread) == NULL)
 		goto fail;
@@ -1569,7 +1570,7 @@ static struct thread_trace *thread__trace(struct thread *thread, FILE *fp)
 
 	return ttrace;
 fail:
-	color_fprintf(fp, PERF_COLOR_RED,
+	color_fprintf(trace->output, PERF_COLOR_RED,
 		      "WARNING: not enough memory, dropping samples!\n");
 	return NULL;
 }
@@ -2623,7 +2624,7 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
 		return -1;
 
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
-	ttrace = thread__trace(thread, trace->output);
+	ttrace = thread__trace(thread, trace);
 	if (ttrace == NULL)
 		goto out_put;
 
@@ -2700,7 +2701,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
 		return -1;
 
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
-	ttrace = thread__trace(thread, trace->output);
+	ttrace = thread__trace(thread, trace);
 	/*
 	 * We need to get ttrace just to make sure it is there when syscall__scnprintf_args()
 	 * and the rest of the beautifiers accessing it via struct syscall_arg touches it.
@@ -2772,7 +2773,7 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 		return -1;
 
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
-	ttrace = thread__trace(thread, trace->output);
+	ttrace = thread__trace(thread, trace);
 	if (ttrace == NULL)
 		goto out_put;
 
@@ -2961,7 +2962,7 @@ static int trace__sched_stat_runtime(struct trace *trace, struct evsel *evsel,
 	struct thread *thread = machine__findnew_thread(trace->host,
 							sample->pid,
 							sample->tid);
-	struct thread_trace *ttrace = thread__trace(thread, trace->output);
+	struct thread_trace *ttrace = thread__trace(thread, trace);
 
 	if (ttrace == NULL)
 		goto out_dump;
@@ -3215,7 +3216,7 @@ static int trace__pgfault(struct trace *trace,
 		}
 	}
 
-	ttrace = thread__trace(thread, trace->output);
+	ttrace = thread__trace(thread, trace);
 	if (ttrace == NULL)
 		goto out_put;
 
-- 
2.48.0.rc2.279.g1de40edade-goog

