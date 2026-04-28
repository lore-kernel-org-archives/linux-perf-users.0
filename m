Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE29372661;
	Tue, 28 Apr 2026 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387197; cv=none; b=AM4T2y1x6+1pkHJTcYkZRL/Gc1mBrWh6esLAxlsMTWgB159riWcq8go5j9n/NZxRsOKqcZ3oR6tmHt9ZP6o9i5JiyqnviS3rDWuzejA/AeilsNXHKTSLP3SNc49SOcOI1+RFwEw4l4O8TuxgOPhUkpasjTjAVpPBUCD2zdpnSpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387197; c=relaxed/simple;
	bh=mUfOy5P37zgEHr9nhxuqz5sHOPf523waCXVTZklQgKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N494M8QvRNqWDAQrZUsTiqaaXpPdymNiCMl+KMXcJnJGf2LjIhQSNdRkfReQWtjtAIiLY/ANQUAUBvcDo/dHwXDdJnUV/bo2gF1dfQLQU6BxpXCqMODE6ZISm6e6FA7RqW8oiPbUqAEWywEG2odBf+6WbTDN+QboO9M61keWC3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-208-105-007.092.208.pools.vodafone-ip.de ([92.208.105.7] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wHjbB-00000000sA9-0q64;
	Tue, 28 Apr 2026 16:39:41 +0200
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
Subject: [PATCH v2 0/3] perf: fix some tests for musl
Date: Tue, 28 Apr 2026 16:38:45 +0200
Message-ID: <20260428143920.2466185-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some perf tests for systems that use musl instead of glibc.

v2:
- add Namhyung's Acked-by for patch 1
- stricter flags check for patch 2
- more generic workload in patch 3

Martin Kaiser (3):
  perf test: fix nanosleep check in the ftrace test
  perf test: fix sys_enter_openat event test for musl
  perf test: fix "trace summary" test for musl-based systems

 tools/perf/tests/openat-syscall-tp-fields.c | 5 ++++-
 tools/perf/tests/shell/ftrace.sh            | 7 ++++---
 tools/perf/tests/shell/trace_summary.sh     | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

-- 
2.43.7

