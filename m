Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9691C460C;
	Fri,  3 Jan 2025 23:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735946193; cv=none; b=fvfiEABx5DDlueH8FeUikhcIR066nLtp/gLHI4ofph9P5p3z/opAfQBt6inTyDcot3x0ZF6mGyBaxitaNilYn0yFq+lBYZ4uqiQPJQignVOzJJSgXIJNvUnzNHnwAs4/V8menT9aDpuXuYlJgp7vSEB+Rc5wZVJiDOgFOhSBXP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735946193; c=relaxed/simple;
	bh=Oe1lnciNltoLtMzXVpER/I/Nsg1x+65CD/ZJTAHEw2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1dGQxMxgQyBBrTvPIGux/SGTmG3fjLb+wMFg/QK5Zu49hfCB2IIdaenJ4hfYAb9Cm/qeO+kslM1JWBgLlwoygR21PgU6B9c6zKu/C/V2jNRVa2WF7poxVxbCRD0RjYaf471WGxAqJjI5n3HNk18OVbf4TFO+OfD93syYZEPiHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpLyOCCB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpLyOCCB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088E1C4CEE1;
	Fri,  3 Jan 2025 23:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735946192;
	bh=Oe1lnciNltoLtMzXVpER/I/Nsg1x+65CD/ZJTAHEw2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QpLyOCCBmQqKL2YhTTPHsjHdaaL4PRFtxZ0S/wigMxu2B+oy8vuLkYVLx0W4O1Dz3
	 7TIl6uSZEjR0BIwVbkjfcyVPtmCyAdp0SCQkUEdzv+y+oxJiH9mtlrfmkFS8Fl1fmB
	 Mq8f472gzqO4mRdmP8PS2wVCv09gZ47WdUFxuLO3vl9dEUDGn74yrco6GqwYKZaZm7
	 JVE7eBCfnC2NJ5SIseuPbz67W3lddrK7bxr7TKqlLi/VTlYIt1i0l5Y+U79Xip0P+n
	 hGSK6X7hSmPt9LSnZfefTyVBWYCubMDx8mlJjGED2XtzqrA9oBcBm9++Q+3ejcPf7N
	 r4Hl+yrnaSRUQ==
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
	Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 3/3] perf test: Update ftrace test to use --graph-opts
Date: Fri,  3 Jan 2025 15:16:30 -0800
Message-ID: <20250103231630.928815-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20250103231630.928815-1-namhyung@kernel.org>
References: <20250103231630.928815-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I found it failed on machines with limited memory because 16M byte
per-cpu buffer is too big.  The reason it added the option is not to
miss tracing data.  Thus we can limit the data size by reducing the
function call depth instead of increasing the buffer size to handle the
whole data.

As it used the same option in the test_ftrace_trace() and it was able
to find the sleep function, it should work with the profile subcommand.

Get rid of other grep commands which might be affected by the depth
change.

Cc: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/ftrace.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/ftrace.sh b/tools/perf/tests/shell/ftrace.sh
index 2df05052c324a21c..c243731d2fbf67aa 100755
--- a/tools/perf/tests/shell/ftrace.sh
+++ b/tools/perf/tests/shell/ftrace.sh
@@ -67,11 +67,8 @@ test_ftrace_latency() {
 
 test_ftrace_profile() {
     echo "perf ftrace profile test"
-    perf ftrace profile -m 16M sleep 0.1 > "${output}"
+    perf ftrace profile --graph-opts depth=5 sleep 0.1 > "${output}"
     grep ^# "${output}"
-    grep sleep "${output}"
-    grep schedule "${output}"
-    grep execve "${output}"
     time_re="[[:space:]]+1[[:digit:]]{5}\.[[:digit:]]{3}"
     # 100283.000 100283.000 100283.000          1   __x64_sys_clock_nanosleep
     # Check for one *clock_nanosleep line with a Count of just 1 that takes a bit more than 0.1 seconds
-- 
2.47.1.613.gc27f4b7a9f-goog

