Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F373C76A0;
	Wed, 26 Aug 2026 18:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787770705; cv=none; b=iiYZFaVwez5pTvD8q8WfSa27STheQ0vhYw6e93+YvqWYi6YopzPJiiYTNXi0Lxc1/6i1vhbsJh9fysdcSqoNT7MRTq6U6VQb70DoC/K8/OzP2XVjYR/E+tJSjIM3f6uYoLZz0G4Vwb0KZ0XmSffVJy8eWPnXbIK4QXiGV50/se0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787770705; c=relaxed/simple;
	bh=7yVu7NGuF4jj3EeqtJX7hFsbveOdchtEl9yumj3rivg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V/2ddXBYcYjHDE5zPDVrD8gFsUOeTvw+Z0+6E1afYnQ8xH4mHprhp/t49RZCtIDrnrtrVQF5cjYEL3Ci7Znhr9o2fbwX0MtVsXS6b4/zOwIextHsXCeYih4IZl4jO5aQcaqenpi+nnUeKwljMQiUBcjFr+E1ep9XghfDDUNE4sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jw/vs888; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jw/vs888"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861E11F000E9;
	Wed, 26 Aug 2026 18:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787770697;
	bh=mjcItGCHrnB/ioZeYCgC7spPCZuPgfw0z2OYhAXp9qg=;
	h=From:To:Cc:Subject:Date;
	b=Jw/vs888lHxf3+rtuYMReuArz/1AQYySXX1nB2WyrQyV1H/NWVg7H9HyoLvvU5HEh
	 7x2W2XlRFiz5Mg+9U5C/d0qPcxw1G+IJu/zucEgQXkJWsp5FUMZR/czmTsDtYAvqOO
	 DzuPsaBn/k6X2ThGsqUW7VgxEQLVw59lYuMz4UQWBTXMY0MmGm1fnfsYTuUsp0D9LD
	 IVSdNwTLEc97YsaB9XjVjSQ0QWd24Ed/0QhSe1q//yCuI/He5A58UViq8b3Yrtinqj
	 r3OPn4KGZksq4U3CAlN1L85xSRyCJq1iLv93B2vomXlQeVz5Ak/cn3Y8uNtTp0wTCM
	 sREUEzHQRSJBQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] perf ftrace latency: Do not read trace files when BPF is used
Date: Wed, 26 Aug 2026 11:58:15 -0700
Message-ID: <20260826185815.280451-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've realized that it didn't set up the tracing files when BPF is used
so poll() just returns immediately.  It ends up with calling poll()
unnecessarily in a loop.

BPF still needs the loop to wait for the target process exiting or a
signal from users.  Let's sleep for 1 msec and check that.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-ftrace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 4f881a40c311ae52..e61b9de11e1e41c7 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -1146,6 +1146,11 @@ static int __cmd_latency(struct perf_ftrace *ftrace)
 
 	line[0] = '\0';
 	while (!done) {
+		if (ftrace->target.use_bpf) {
+			usleep(1000);
+			continue;
+		}
+
 		if (poll(&pollfd, 1, -1) < 0)
 			break;
 
-- 
2.55.0.897.gb25b4bd76c-goog

