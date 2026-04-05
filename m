Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBAA40DFCC;
	Sun,  5 Apr 2026 05:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775366214; cv=none; b=HB5ak+8KoDh9R19Cvfm7XwwqzCYia33EWnJpu9jamfSE9mi+JNxNknqsWuQ1OHkoFnecvu3OFCYvzO0DpM/E+5Z3r7jhYAPLGcM407/qQ+AuSlHiFIKTrYrIsLKmonzDrCkMFuYrfEoQggl4lb+/dFjS8PSNgNy2303a2CV3YkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775366214; c=relaxed/simple;
	bh=HCGjgpSIr8PeZAUrMlZ4NSxZfXH8PXt7nvPfQS4KNiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X3gNSLJIe/KyVivu3Nv0Mq9x1OWQRBQ3dpaRNdWIEQYVFEOm3drqxNnSiSQhCoBp/X6TqLrvTgel9ec3anheLzeEnhITZyKHaseYRYp4dmUm9zyNbaD2VbBSwfu5azixgRgDdDp7Ttz/6SFMTY4+jPIXGv/gK2a8QyOFOtcaeJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDUGR2rH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDUGR2rH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEE8C116C6;
	Sun,  5 Apr 2026 05:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775366213;
	bh=HCGjgpSIr8PeZAUrMlZ4NSxZfXH8PXt7nvPfQS4KNiI=;
	h=From:To:Cc:Subject:Date:From;
	b=IDUGR2rHFdyv455FiOwP2OLezNj6UAsfr68LRw+o0AYoXWyzxHhsbVBWtjeQC3PDi
	 gJ4+09izouHn7ndoRwU0vK0fq/uMP3/1cH8x1koWumGPmRI/y2oFrAeEhCabcX/e9L
	 Mo/cb/hxLF7tUburwAjnTqiFFUw8DJo7xspPb37JxRdKbU22eqOHCuhoRCw1uy62jE
	 DOsH+5LPKdTg0fqEejGdgCbCB+RBEOD+gSboCgTrpETMk4RdDR1C0EU/7rMF/p+WQB
	 HFzPgYoEDghJZMBq5mNC5+OJMcn92sCd3rjPWgBXXi1bcMm50svjFgGzUbxLWKG4mV
	 ZWhfyMrrAMqlA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [PATCH] perf test: Skip sched stats test for !root
Date: Sat,  4 Apr 2026 22:16:44 -0700
Message-ID: <20260405051644.61511-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running perf sched stats requires root and it fails to open the
schedstat file for regular users.  Let's skip the test.

  $ perf sched stats true
  Failed to open /proc/sys/kernel/sched_schedstats

Cc: Swapnil Sapkal <swapnil.sapkal@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/perf_sched_stats.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/tests/shell/perf_sched_stats.sh b/tools/perf/tests/shell/perf_sched_stats.sh
index 2b1410b050d04737..41ee41fbf0253d55 100755
--- a/tools/perf/tests/shell/perf_sched_stats.sh
+++ b/tools/perf/tests/shell/perf_sched_stats.sh
@@ -4,6 +4,11 @@
 
 set -e
 
+if [ "$(id -u)" != 0 ]; then
+  echo "[Skip] No root permission"
+  exit 2
+fi
+
 err=0
 test_perf_sched_stats_record() {
   echo "Basic perf sched stats record test"
-- 
2.53.0

