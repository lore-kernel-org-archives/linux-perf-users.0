Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE96B4436;
	Mon, 29 Jul 2024 00:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722213690; cv=none; b=GmH+Xla87KuBzMIyA7EozMw8CXGL24aTvpFk8qnR4G8+KFiykcQy2U60pcNARIN2mYYaKOqCP7arV2NhJ4+2GL+rIAkCkhmiao4TuplJjcEWR3nwwxAn540e+X86uFyFBixSM9L2fOlTVnmG1NNudBnDIqrhisi8ftPThWUTtfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722213690; c=relaxed/simple;
	bh=FzOBSK/8f/GP8yiHn951JyTfNI4xmMPYoNwpO6Dn0o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1ogFO6Lw44sFNyT/8cC6L18D8uhGNVTQ6DG3plFH40L83NyKYl+NUG6yN1GTlFP25yQx0MG9gPG+rIAO98uOBssvM6dYxXdZJUu81q//7eOBjdupZ1682EyZdhxrxlaNd76cnnefKIpxuSeVs8KEsXkGck0Qi+t4HAcUtoX7CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNWYuHpM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNWYuHpM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5747BC4AF12;
	Mon, 29 Jul 2024 00:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722213689;
	bh=FzOBSK/8f/GP8yiHn951JyTfNI4xmMPYoNwpO6Dn0o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vNWYuHpMgYTC5hIJDitvvTkkEnawofUo69FCmFkqH1q3CWXiGJ7tN044HdfzouDsg
	 fmLHZfcdr3H4XGfR7UiTHEMwsP67k5DCYUvGq6VsCYfHjTfZE7eFJLuwu+N/nRRMH/
	 mNoDSdSwCnlaMtRz6o8i2fPjzxot9x7ySkQ4QKcfjtIfCF2b5dfkIlrG8Jp3OddBk2
	 RzofH+HqjPJmeb7UxAXdycGevtbzrmTMyJtXG8hbFOd2ZFcmdXNH4KFeBnNCg39eZs
	 Yk5YCnv4dYMg4Pt01qmmS9pCVoMws3XYsUBiC5iC7G4vBbwson3hxPDfX6WaCWLIvi
	 ug3NNnyH0Aw1g==
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
	Steven Rostedt <rostedt@goodmis.org>,
	Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 2/4] perf ftrace: Factor out check_ftrace_capable()
Date: Sun, 28 Jul 2024 17:41:25 -0700
Message-ID: <20240729004127.238611-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
In-Reply-To: <20240729004127.238611-1-namhyung@kernel.org>
References: <20240729004127.238611-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check is a common part of the ftrace commands, let's move it out.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-ftrace.c | 44 +++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 33c52ebda2fd..978608ecd89c 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -59,6 +59,22 @@ static void ftrace__workload_exec_failed_signal(int signo __maybe_unused,
 	done = true;
 }
 
+static int check_ftrace_capable(void)
+{
+	if (!(perf_cap__capable(CAP_PERFMON) ||
+	      perf_cap__capable(CAP_SYS_ADMIN))) {
+		pr_err("ftrace only works for %s!\n",
+#ifdef HAVE_LIBCAP_SUPPORT
+		"users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
+#else
+		"root"
+#endif
+		);
+		return -1;
+	}
+	return 0;
+}
+
 static int __write_tracing_file(const char *name, const char *val, bool append)
 {
 	char *file;
@@ -586,18 +602,6 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 		.events = POLLIN,
 	};
 
-	if (!(perf_cap__capable(CAP_PERFMON) ||
-	      perf_cap__capable(CAP_SYS_ADMIN))) {
-		pr_err("ftrace only works for %s!\n",
-#ifdef HAVE_LIBCAP_SUPPORT
-		"users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
-#else
-		"root"
-#endif
-		);
-		return -1;
-	}
-
 	select_tracer(ftrace);
 
 	if (reset_tracing_files(ftrace) < 0) {
@@ -902,18 +906,6 @@ static int __cmd_latency(struct perf_ftrace *ftrace)
 	};
 	int buckets[NUM_BUCKET] = { };
 
-	if (!(perf_cap__capable(CAP_PERFMON) ||
-	      perf_cap__capable(CAP_SYS_ADMIN))) {
-		pr_err("ftrace only works for %s!\n",
-#ifdef HAVE_LIBCAP_SUPPORT
-		"users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
-#else
-		"root"
-#endif
-		);
-		return -1;
-	}
-
 	trace_fd = prepare_func_latency(ftrace);
 	if (trace_fd < 0)
 		goto out;
@@ -1220,6 +1212,10 @@ int cmd_ftrace(int argc, const char **argv)
 	signal(SIGCHLD, sig_handler);
 	signal(SIGPIPE, sig_handler);
 
+	ret = check_ftrace_capable();
+	if (ret < 0)
+		return -1;
+
 	ret = perf_config(perf_ftrace_config, &ftrace);
 	if (ret < 0)
 		return -1;
-- 
2.46.0.rc1.232.g9752f9e123-goog

