Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FBE3FD123;
	Tue, 28 Apr 2026 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387199; cv=none; b=Yl8HtEWRQN53Wpz9ZXy7gOuSfV/3C8O0d03hyBz+44v409UMwCPka0K4im9u96B4LtTY+eULQUDIu5futQr6vavvuibZ44UoLfDA0MGznz8VyUI4fodK2d4HaRrdmyeJZihU7YoDmVCOOFkA9bxEWGXIPGxBdxw6AJoQFwSgvX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387199; c=relaxed/simple;
	bh=s3VQ/EEBMRgw8u1CpLJ/wyJmX55jlz3z0F8yw4zAbYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDbZOGbyg8BLm7T5pM1KI7DXGucDD1bjMC9mP9mhA2KgFiYgn++KNLRtB8ydYr+/2vzE2fVzrP7JY1mNN+zs9hZfuqswoPqQfqLXek7/Ynt+9oCv5T4TL5XI/11k32Z4NjPgnvTSNKljCKDwsebUc7n2NlpI5IPfoKT3tWIM2q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-208-105-007.092.208.pools.vodafone-ip.de ([92.208.105.7] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wHjbF-00000000sA9-2uNQ;
	Tue, 28 Apr 2026 16:39:45 +0200
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
Subject: [PATCH v2 3/3] perf test: fix "trace summary" test for musl-based systems
Date: Tue, 28 Apr 2026 16:38:48 +0200
Message-ID: <20260428143920.2466185-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428143920.2466185-1-martin@kaiser.cx>
References: <20260428143920.2466185-1-martin@kaiser.cx>
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

Run "cat /dev/null" instead of "true". This creates the required events
regardless of the C library and it works for cat from busybox or from
coreutils.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
- use cat /dev/null, this works for busybox and coreutils

 tools/perf/tests/shell/trace_summary.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/trace_summary.sh b/tools/perf/tests/shell/trace_summary.sh
index 22e2651d5919..b80dea77cec6 100755
--- a/tools/perf/tests/shell/trace_summary.sh
+++ b/tools/perf/tests/shell/trace_summary.sh
@@ -14,7 +14,7 @@ OUTPUT=$(mktemp /tmp/perf_trace_test.XXXXX)
 
 test_perf_trace() {
     args=$1
-    workload="true"
+    workload="cat /dev/null"
     search="^\s*(open|read|close).*[0-9]+%$"
 
     echo "testing: perf trace ${args} -- ${workload}"
-- 
2.43.7

