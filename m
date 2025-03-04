Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0051DDA3C;
	Tue,  4 Mar 2025 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741055321; cv=none; b=RH4AHqBr/YHta6eIpnczXDxGJM0VvGWE7fTM/OPq0h0Vdz/jTgeqaFDL2hGlM++mcDH8bjDtykUerPyunkVwNgpkmEqGfzwZNv8mVTU/QQGtQeTGtVbh71h12Ivskt7azh725gYwVVxh+9nrXYbjCZAwd/vMTek/9t2AYZZTqJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741055321; c=relaxed/simple;
	bh=RzYrlM88omVGwDNYsMfqIjC0LNHDhGkdys42nQkzM6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVPu6HC4Cb3noAbujLl2MThmqnykQin5jyD7+8K2v/u0ONb5D98fedKkc4zlXYeVlEMXW0OnF+8Ef1bzEAcILGqN/38D/Wcatt1it6P4WLdpEzWDf9/ExR5FCwNnwbfRJiBB7ime+voyGL+5U4a3QmNpVpMnI6+JhKQpmNbBIxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAdbDFL9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAdbDFL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8B4C4CEF0;
	Tue,  4 Mar 2025 02:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741055320;
	bh=RzYrlM88omVGwDNYsMfqIjC0LNHDhGkdys42nQkzM6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BAdbDFL9cy9IOs0L1uQQyN/wVf7j7WMlZPH/K96R53X7xYnW0YaNPpe+BolbGHDtL
	 jAyHdmryB9k1IJsm+fWIbNF7rk8mC8quVQV7CTYlwMQoaqPc4mdAbehoPPhOVBgVRg
	 Wy90ZDj+r8hOk3Yd2TSTLy9e+vQzG08RW0UwMPT6avlvqJcZUfJXeRbb6SKBSVfXG6
	 3J/GD/7UZX+KFRBVzNN0EjmUk7JWGUivyHxw4vNGnf92StBTlE4VNTxIuS4BMcEBPp
	 Yp0xPjPS4KpBGYY5Guw/5KN7UM+W+4AnuMOpjedL0M5f0iOyGH0sdXKa6cWZm7DSuQ
	 b1DpmI6qo87iA==
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
	Thomas Richter <tmricht@linux.ibm.com>,
	Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 5/6] perf test: Add timeout to datasym workload
Date: Mon,  3 Mar 2025 18:28:36 -0800
Message-ID: <20250304022837.1877845-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250304022837.1877845-1-namhyung@kernel.org>
References: <20250304022837.1877845-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike others it has an infinite loop that make it annoying to call.
Make it finish after 1 second and handle command-line argument to change
the setting.

Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Leo Yan <leo.yan@arm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/workloads/datasym.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/workloads/datasym.c b/tools/perf/tests/workloads/datasym.c
index 8e08fc75a973e5f7..8ddb2aa6a049e343 100644
--- a/tools/perf/tests/workloads/datasym.c
+++ b/tools/perf/tests/workloads/datasym.c
@@ -1,3 +1,6 @@
+#include <stdlib.h>
+#include <signal.h>
+#include <unistd.h>
 #include <linux/compiler.h>
 #include "../tests.h"
 
@@ -12,9 +15,25 @@ static buf buf1 = {
 	.reserved[0] = 1,
 };
 
-static int datasym(int argc __maybe_unused, const char **argv __maybe_unused)
+static volatile sig_atomic_t done;
+
+static void sighandler(int sig __maybe_unused)
+{
+	done = 1;
+}
+
+static int datasym(int argc, const char **argv)
 {
-	for (;;) {
+	int sec = 1;
+
+	if (argc > 0)
+		sec = atoi(argv[0]);
+
+	signal(SIGINT, sighandler);
+	signal(SIGALRM, sighandler);
+	alarm(sec);
+
+	while (!done) {
 		buf1.data1++;
 		if (buf1.data1 == 123) {
 			/*
-- 
2.48.1.711.g2feabab25a-goog

