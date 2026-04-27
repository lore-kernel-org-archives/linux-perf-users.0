Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8794C3B27EF;
	Mon, 27 Apr 2026 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777282708; cv=none; b=DpUBAsiHgArm9K5MpXaSMwbt4mJHl0NYTgzr4ywg863uUwBSQjP36e2sooLrJcaNsFMSrcbg7Q6R7z3bWqs6cviXw7pNOjPqPbcsvQRma0G4NIXPNWkNl14ZBIBYWN3yZK0IEZQQUR3vpDg6cHjPgyF8QE4aMcDZOddZJ7jnWSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777282708; c=relaxed/simple;
	bh=tf9YPH2r8X9YQTzXi6q2vwF2yny9h95Q4y6ed6Pq9Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRU1YOdJ4RDrHZxrpH1hsdqhh5vSAbsX40DUwEme9+u67bb69fgsH5DOb5yIHazlFxMUeyWhSM1x1QV+jXj9rtTNpkH4OFTfdY4L+5dMc9pmkcQOjQ2xRE+1Ku+s5i3KzTh3DwCV8lNpke2jCLp5IledemU8x4j77BvN1zD4LZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-208-105-007.092.208.pools.vodafone-ip.de ([92.208.105.7] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wHHrY-00000000jJc-0IYs;
	Mon, 27 Apr 2026 11:02:44 +0200
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
Subject: [PATCH 3/3] perf test: fix "trace summary" test for musl-based systems
Date: Mon, 27 Apr 2026 11:01:43 +0200
Message-ID: <20260427090225.794482-4-martin@kaiser.cx>
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

The trace summary test calls /bin/true and filters for open, read and
close events. These events are coming from shared library loads.

On a musl system, the loader and libc may point to the same file. true
needs only libc, no further shared libraries are loaded at startup. The
test fails since no open, read and close events are captured.

root@host:~# ldd /bin/true
	/lib/ld-musl-riscv64.so.1 (0x3fb8882000)
	libc.so => /lib/ld-musl-riscv64.so.1 (0x3fb8882000)

root@host:~# file /lib/ld-musl-riscv64.so.1
/lib/ld-musl-riscv64.so.1: symbolic link to /usr/lib/libc.so

root@host:~# strace -f /bin/true
execve("/bin/true", ["/bin/true", ...], ... /* 18 vars */) = 1
set_tid_address(0x3fa1f7bf70)           = 330
mprotect(0x2ad6b8e000, 12288, PROT_READ) = 0
exit_group(0)                           = ?
+++ exited with 0 +++

Run "ps --help" instead of "true". ps needs at least libprocps and we'll
get the events that are needed for the test.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 tools/perf/tests/shell/trace_summary.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/trace_summary.sh b/tools/perf/tests/shell/trace_summary.sh
index 22e2651d5919..03be213bb7bf 100755
--- a/tools/perf/tests/shell/trace_summary.sh
+++ b/tools/perf/tests/shell/trace_summary.sh
@@ -14,7 +14,7 @@ OUTPUT=$(mktemp /tmp/perf_trace_test.XXXXX)
 
 test_perf_trace() {
     args=$1
-    workload="true"
+    workload="ps --help"
     search="^\s*(open|read|close).*[0-9]+%$"
 
     echo "testing: perf trace ${args} -- ${workload}"
-- 
2.43.7

