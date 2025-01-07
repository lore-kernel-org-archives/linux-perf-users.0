Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E721D1DF97A;
	Tue,  7 Jan 2025 22:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736289835; cv=none; b=ONiQhM7yMAbEhcd+/rkaGFqxhxnHGszMMvY1gsIBTdfbO+2MTLINZV/8bqtHNRe1nX4lZQcCdYoPMwERJRyWPuT7mcvANSpWCl8ampl08G8FNFcFevIiwnMvj/YX4Noiz513wc+W5p103kjEMh9iuhyn6pvsC6CfHN2qfCO8qeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736289835; c=relaxed/simple;
	bh=CxAP9KIBte98bEHs4mSlyY+90ae8Qr7epbm9MFksvxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1NVsY7XSY1pP21URzaeZvnfF2WF4J+hsnhepIbmfsN80u3cdUWjWsS6sVGVBZycoqvxJR70bz2mBl7JhMKiFyXl/9aGQPQWMcoghPijQnAeyqvcMchaik3vrrwK5vkMtYpk+BeAAOke/V6UTIjCpszA2EmkeQz5j1TgSww1qVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4fnPfbB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4fnPfbB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65645C4CEE1;
	Tue,  7 Jan 2025 22:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736289834;
	bh=CxAP9KIBte98bEHs4mSlyY+90ae8Qr7epbm9MFksvxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r4fnPfbBkxpOIC28tNZTanC2Ed10K9LguL4fPIXPAd4fnaakO+PJ3ECv+f++x1VpY
	 R2REjnrUXLVV/Cpe8nh6NA2tAkRDYRAiRoLBLZdGwc/vYrYU6fw/y6c+q1UO9cn4nA
	 iukj/49QuGemiXH3yoEs0MUNDzfH9PHdph3RIJ9SRC5wxpjrXZKpA7nISAukA9rqnm
	 2iWVtn5TVywJ/XQwkwHnC3VvlgUokDwIVaj1TDQ1UW3NZFUBsDQ7omnOPtjyGtF1rU
	 mlkrLJprfcnnPVW7riFlyt9T0WCo0W3e1cVQ/2UsZXvYhI+kEtJKWFE3I8BBp6NV/c
	 H6TdCEHlyUiYA==
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
	James Clark <james.clark@linaro.org>
Subject: [PATCH v2 3/3] perf test: Update ftrace test to use --graph-opts
Date: Tue,  7 Jan 2025 14:43:52 -0800
Message-ID: <20250107224352.1128669-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20250107224352.1128669-1-namhyung@kernel.org>
References: <20250107224352.1128669-1-namhyung@kernel.org>
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
Reviewed-by: James Clark <james.clark@linaro.org>
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

