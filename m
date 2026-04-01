Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8282D949C;
	Wed,  1 Apr 2026 23:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775084711; cv=none; b=h5TCi5gPnLpSaUvsOugk/jxqnLi35Zu7kl1a2W2CiEGCHZA1jlI9hqHq26bGVM7bcALzOSEaNrEzmjsdoohZ96O86Hbh2NGvRul35W2Xetl9TsjxNC6lAniUufhm6lFxo0UvHCM2T+SvYC2pvChbNAzWgMKPGS/DUD/lXmVoNPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775084711; c=relaxed/simple;
	bh=ul9AG2NuU8HDms/7HM8JU1jW4yepxHD6Dmpc6sJ4tV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=csLzmDOdcmFsUfxStNTe1gG64EyOi5mHJwxc+Qgseb4CYURnYnswh18bXYU2lpNNkwbxq/wNouGb9qJ2j+VGLvNJj/1F+m/x7NcVFPD/X+QP7s3i232qhx3sY7tK62sMohDbU0fRycz5gcbOA/cIixCdA98BoGF0ckQ+vzArIaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdOqy6ZG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdOqy6ZG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73614C4CEF7;
	Wed,  1 Apr 2026 23:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775084710;
	bh=ul9AG2NuU8HDms/7HM8JU1jW4yepxHD6Dmpc6sJ4tV8=;
	h=From:To:Cc:Subject:Date:From;
	b=AdOqy6ZGqwOezoQy5SHdIXy6CdpztJtBSVMA8YDpIhCL0zSCjnxvAFS9sR9jGBt2V
	 A+7z6iZvLHdhBlK3Vix31myncsNQscTIC/Fo4JmvgwZoxmupc84v0w2oOTbbvrnKZZ
	 Tc86Io8BCm01nOnLPXMRq+XbUSQzKd9s78HhYFi+Gb94oYE9dx/GAebZym0k2glulG
	 miz4pT1ZrF6ZddCZTQVM9LRrrfhD7TGe2UBiE6eS30gQYtLYo01KX8o+D74wli0okM
	 5Un32W7XWqyzR8dqHycwxcI+Z12dphP2I5Y6aeDVtJxU29O3t7gfGaNTjBxRB7UkYn
	 3E0wDmTaMR3gA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2] perf trace: Skip unnecessary synthesis for summary-only mode
Date: Wed,  1 Apr 2026 16:05:09 -0700
Message-ID: <20260401230509.1013742-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It needs to synthesize task info for the comm name.  The mmap
information is only needed for callchain symbolization which is not used
by the summary mode.  Also total or cgroup summary mode don't require
the task info.  Let's skip the processing if possible.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2) minimize the diff  (Ian)

 tools/perf/builtin-trace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f487fbaa0ad60028..d121640ace6e1456 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2004,9 +2004,13 @@ static int trace__symbols_init(struct trace *trace, int argc, const char **argv,
 	if (err < 0)
 		goto out;
 
+	if (trace->summary_only && trace->summary_mode != SUMMARY__BY_THREAD)
+		goto out;
+
 	err = __machine__synthesize_threads(trace->host, &trace->tool, &trace->opts.target,
 					    evlist->core.threads, trace__tool_process,
-					    /*needs_mmap=*/callchain_param.enabled,
+					    /*needs_mmap=*/callchain_param.enabled &&
+							   !trace->summary_only,
 					    /*mmap_data=*/false,
 					    /*nr_threads_synthesize=*/1);
 out:
-- 
2.53.0.1213.gd9a14994de-goog

