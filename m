Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96A52144A3;
	Wed,  5 Feb 2025 20:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738788885; cv=none; b=nKpHwf1XUxLtinTro1yZo0x35fWvLO0DUpDAINAQc/Nsr5YA7YuzI+sqC4dpp92av+eU2hbMsPOh+VA+wroK7ce6UyseW47011noLgMZ6oUBX0Exk3yeVxVHE7SCBMc5MbrQLUbHyxaMIE+cc8+2A3DnVT4yKknq/PxUFz/CHQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738788885; c=relaxed/simple;
	bh=/CbTKhO1vIKko2EDqbn2o86kZt9yDBeYWk+0kvM0ou0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wl5LsIE+ifpgFmKnK35FpMr75as0neDzFBBZ2Zyt4idoG9lL1ZAVizhIvDE0Dl6q0ZUgNx5MIdOeF7g+coDZ8kOgzM+uGSLrzpDFEIktY4k0Vgi8zrR/AKJpG8HTe3jNxKawl7K9XX9slVuFsIf33DEwRbCzzIVegS0smhDwmHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGS7P5OO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGS7P5OO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E12C4CEE5;
	Wed,  5 Feb 2025 20:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738788885;
	bh=/CbTKhO1vIKko2EDqbn2o86kZt9yDBeYWk+0kvM0ou0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bGS7P5OOhbiHvh9GgjuxaScq7m1GoZ25+scPmRfYgtwDNbUklSMYu7MV/wiQvVGnw
	 L+6kmp7OJA3vWqOgYl1YwDn8FmEYkLG72RPcKT9uYOeqbSZgwjljOQVL9qNd3CcbSL
	 3ojlgPhYTR5RuYEpf6Z8QkComP05vYx9pxLipnH/hBJZPZUR7QuD9tERFmhYSaVyzu
	 QNBQfCNVsVsdiDM3iM5cJ4GGLx9YfaJHxYE28QNUmBbctqG3nbcNYMXsiPyLridN1M
	 9vNo7qV6Iei3+z755GNiMTEHBMdY+S5l9w/7tv/G51CzIbqCYvhI+bk0VxOEOPrcrq
	 fO+jgnnVv829Q==
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
Subject: [PATCH v3 1/4] perf trace: Allocate syscall stats only if summary is on
Date: Wed,  5 Feb 2025 12:54:40 -0800
Message-ID: <20250205205443.1986408-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250205205443.1986408-1-namhyung@kernel.org>
References: <20250205205443.1986408-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The syscall stats are used only when summary is requested.  Let's avoid
unnecessary operations.  While at it, let's pass 'trace' pointer
directly instead of passing 'output' file pointer and 'summary' option
in the 'trace' separately.

Acked-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-trace.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ac97632f13dc8f7c..7e0324a2e9182088 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1522,13 +1522,14 @@ struct thread_trace {
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
@@ -1550,7 +1551,7 @@ static void thread_trace__delete(void *pttrace)
 	free(ttrace);
 }
 
-static struct thread_trace *thread__trace(struct thread *thread, FILE *fp)
+static struct thread_trace *thread__trace(struct thread *thread, struct trace *trace)
 {
 	struct thread_trace *ttrace;
 
@@ -1558,7 +1559,7 @@ static struct thread_trace *thread__trace(struct thread *thread, FILE *fp)
 		goto fail;
 
 	if (thread__priv(thread) == NULL)
-		thread__set_priv(thread, thread_trace__new());
+		thread__set_priv(thread, thread_trace__new(trace));
 
 	if (thread__priv(thread) == NULL)
 		goto fail;
@@ -1568,7 +1569,7 @@ static struct thread_trace *thread__trace(struct thread *thread, FILE *fp)
 
 	return ttrace;
 fail:
-	color_fprintf(fp, PERF_COLOR_RED,
+	color_fprintf(trace->output, PERF_COLOR_RED,
 		      "WARNING: not enough memory, dropping samples!\n");
 	return NULL;
 }
@@ -2622,7 +2623,7 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
 		return -1;
 
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
-	ttrace = thread__trace(thread, trace->output);
+	ttrace = thread__trace(thread, trace);
 	if (ttrace == NULL)
 		goto out_put;
 
@@ -2699,7 +2700,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
 		return -1;
 
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
-	ttrace = thread__trace(thread, trace->output);
+	ttrace = thread__trace(thread, trace);
 	/*
 	 * We need to get ttrace just to make sure it is there when syscall__scnprintf_args()
 	 * and the rest of the beautifiers accessing it via struct syscall_arg touches it.
@@ -2771,7 +2772,7 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 		return -1;
 
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
-	ttrace = thread__trace(thread, trace->output);
+	ttrace = thread__trace(thread, trace);
 	if (ttrace == NULL)
 		goto out_put;
 
@@ -2960,7 +2961,7 @@ static int trace__sched_stat_runtime(struct trace *trace, struct evsel *evsel,
 	struct thread *thread = machine__findnew_thread(trace->host,
 							sample->pid,
 							sample->tid);
-	struct thread_trace *ttrace = thread__trace(thread, trace->output);
+	struct thread_trace *ttrace = thread__trace(thread, trace);
 
 	if (ttrace == NULL)
 		goto out_dump;
@@ -3214,7 +3215,7 @@ static int trace__pgfault(struct trace *trace,
 		}
 	}
 
-	ttrace = thread__trace(thread, trace->output);
+	ttrace = thread__trace(thread, trace);
 	if (ttrace == NULL)
 		goto out_put;
 
-- 
2.48.1.502.g6dc24dfdaf-goog

