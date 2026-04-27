Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2013AF66E;
	Mon, 27 Apr 2026 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777282686; cv=none; b=mX/FmnRToq2MOF2HJlYBKfBJYUTGLv7H2+f4wkz0jiF7V/Lht65isPk0EHnRvA+lk2uLPcTO8pmK0hFuxdM8ePDTdb70QZ2mUb3uRLKMXh7NBWFz9PpgFGMigSsHj4yNGX9TuJtAc45vGZGnw5FFYUYYp1NXE0xTe094erQCjoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777282686; c=relaxed/simple;
	bh=jEea6Sol4jrwqNMNxceLTISe1gWE205iDYoKM70fdMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLHYTwCimDEpPzTk/JWrVM/zoAA/KbD7ZJdwxsBD4iOMCkpPzZGRTumJB+XIx7FWNduiBVhII32xav1vGRFOyMkocGyGZ781GbCxwenA0KjE/I6eu6QTZl9G/3cBgcsHL/ly2Ubxg5LaKqjCyXCLMezg4vJrcCEJ6WCobt/WtDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-208-105-007.092.208.pools.vodafone-ip.de ([92.208.105.7] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wHHrV-00000000jJc-1uPt;
	Mon, 27 Apr 2026 11:02:41 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/3] perf test: fix nanosleep check in the ftrace test
Date: Mon, 27 Apr 2026 11:01:41 +0200
Message-ID: <20260427090225.794482-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260427090225.794482-1-martin@kaiser.cx>
References: <20260427090225.794482-1-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The perf ftrace test case runs

perf ftrace profile --graph-opts depth=5 sleep 0.1

and checks that the output contains a *clock_nanosleep function with a
count of 1.

This fails on a risc-v system that uses musl as its C library. musl's
nanosleep syscall wrapper uses either the nanosleep or the
clock_nanosleep syscall.

Filter for sys_*nanosleep to allow both syscalls.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 tools/perf/tests/shell/ftrace.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/ftrace.sh b/tools/perf/tests/shell/ftrace.sh
index 7f8aafcbb761..9f6e590f6437 100755
--- a/tools/perf/tests/shell/ftrace.sh
+++ b/tools/perf/tests/shell/ftrace.sh
@@ -71,9 +71,10 @@ test_ftrace_profile() {
     grep ^# "${output}"
     time_re="[[:space:]]+1[[:digit:]]{5}\.[[:digit:]]{3}"
     # 100283.000 100283.000 100283.000          1   __x64_sys_clock_nanosleep
-    # Check for one *clock_nanosleep line with a Count of just 1 that takes a bit more than 0.1 seconds
-    # Strip the _x64_sys part to work with other architectures
-    grep -E "^${time_re}${time_re}${time_re}[[:space:]]+1[[:space:]]+.*clock_nanosleep" "${output}"
+    # Check for one *sys_*nanosleep line with a Count of just 1 that takes a bit more than 0.1 seconds
+    # Strip the _x64_ part to work with other architectures, strip the clock part to support
+    # C libraries that use the nanosleep syscall instead of clock_nanosleep
+    grep -E "^${time_re}${time_re}${time_re}[[:space:]]+1[[:space:]]+.*sys_.*nanosleep" "${output}"
     echo "perf ftrace profile test  [Success]"
 }
 
-- 
2.43.7

