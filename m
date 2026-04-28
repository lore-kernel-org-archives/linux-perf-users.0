Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFF940FDAD;
	Tue, 28 Apr 2026 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387198; cv=none; b=MwNCUdp2tc6F4a38USvFIsGi+PZIX6lwPn35Iav2PbvjSAr3sLaZVqzuIQmTXxKhucfX+d/0xhdPrQI4Im7tBJPLNzAamCUYpryM3OnhfSlYSAXviw2rvBV65BMP/fUaubplU6gAbBx8BJRX1y7SaipFEhC6p7NTOqjU3dzyZQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387198; c=relaxed/simple;
	bh=R2Y9reQb/KcVnC/L/Hwk1juFmLerAODaIPvz6mqQ4Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSt7++Lb6jMh/LXEspL2q/VtWAjsN7TZQdi8jqEbnzqABEXk2lR0T4oBxnUa5qTGvztqdO5wGA/HbMu6OZqXEK8eEMcr5sUHfqUQEQVOCg8nwerscgLv8ww71iJNRhfLYB6w1cWswPM1lwK5yt7UNaQT/3/WXTbRp76uFMt18dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-208-105-007.092.208.pools.vodafone-ip.de ([92.208.105.7] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wHjbE-00000000sA9-1ZRU;
	Tue, 28 Apr 2026 16:39:44 +0200
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
Subject: [PATCH v2 2/3] perf test: fix sys_enter_openat event test for musl
Date: Tue, 28 Apr 2026 16:38:47 +0200
Message-ID: <20260428143920.2466185-3-martin@kaiser.cx>
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

The "syscalls:sys_enter_openat event fields" test calls

openat(AT_FDCWD, "/etc/passwd", O_RDONLY | O_DIRECTORY)

and verifies that the flags of the captured event are matching.
This fails for musl, where the openat syscall wrapper always adds
O_LARGEFILE.

Update the check to allow for additional flags, the access mode flags
must be unchanged.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
- check that access mode is unchanged

 tools/perf/tests/openat-syscall-tp-fields.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 2a139d2781a8..5523cf4e9321 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -120,7 +120,10 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused
 
 				tp_flags = evsel__intval(evsel, &sample, "flags");
 				perf_sample__exit(&sample);
-				if (flags != tp_flags) {
+				/* C library wrapper may set additional flags,
+				   access mode must be unchanged */
+				if ((tp_flags & O_ACCMODE) != (flags & O_ACCMODE) ||
+				    (tp_flags & flags) != flags) {
 					pr_debug("%s: Expected flags=%#x, got %#x\n",
 						 __func__, flags, tp_flags);
 					goto out_delete_evlist;
-- 
2.43.7

