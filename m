Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CEC41F7C1;
	Mon, 27 Jul 2026 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169040; cv=none; b=exCjgm7iBSylaOS5K7g71e2osMG7Qj752Wm6/OoXvvzEy8mFEROEAgDqCP2js+lTpegIeXjDMiZVTrAFPQKnnyD+mk8edjMkQmdhzNfyrf5+QSf6p9J/LVT9wXN89OySYc1pUQQXmFZstEN++hWRd6/JqePpDyZv1PtAieKw1/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169040; c=relaxed/simple;
	bh=AEtbDWtvb93p1eXwA1WrUkw15W8R3+XunhzMfYqolKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1Fz1iUKxhePbrZ0QtWkj+rzpOYmMzGujYUVVTC3WoIsYcPKPPvTi/vyOGpdh5Eu6RFsu2fRt5RBkmbuinxrTqB4hgPMRzo292MDDsrnz8sJW4hRym9mOyjAzK/Nl36apuJecOeUiZl8idgrB2dUBIzWn/hgfs6uiJMmtHaPyfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HobigPYi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HobigPYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374A61F00A3E;
	Mon, 27 Jul 2026 16:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785169038;
	bh=yA6hLocKK0yR+nyMnaUumBiuRmS1AQukayAxpT90q64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HobigPYi0INS56yK2FQqm6oT01xgxKx+eQoy5yWUR3kCgHtOAg2ppqHPXnUTe89BJ
	 e69rDRNbSEBanbPNtO43cYK2/lMxkk6CGkG+PdHJIvih3lwPJgPls4UKlQ2KwkBDHc
	 IZ1lq79fjAJxrH8JOjogOCbb/AIvSrztKIjBgBndRncX4WdVm9XPCpgiF9RW2jKg4W
	 eRo9fvhO9mGTdxyjv+4a5UkvBZ2fBeCQ1ltJHNfEje4l+4x2w9SN+ySMg4eQXvubic
	 /iY/QODlXCCmMca/4Sj2ynW/c3fgOUoFPHLPPswIxJ/qyOq8DJrMLzMPDQVxmjCVC2
	 iO3lQaUcpNFuA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 1/5] perf thread-stack: Fix heap buffer overflow on branch stack wrap copy
Date: Mon, 27 Jul 2026 13:17:01 -0300
Message-ID: <20260727161705.64807-2-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727161705.64807-1-acme@kernel.org>
References: <20260727161705.64807-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

thread_stack__br_sample() copies the wrap-around portion of the branch
stack ring buffer with:

  nr = min(ts->br_stack_pos, sz);
  memcpy(be, &src->entries[0], bsz * ts->br_stack_pos);

'nr' is correctly bounded to min(br_stack_pos, sz) but the memcpy uses
the unbounded ts->br_stack_pos directly.  When br_stack_pos exceeds
the remaining destination space 'sz', this writes past the destination
buffer.

Use 'nr' (the bounded value) in the memcpy size, matching the pattern
of the first memcpy in the same function.

Fixes: 86d67180b920 ("perf thread-stack: Add branch stack support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index c5ce741b07446482..1360f44421ef8bb8 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -642,7 +642,7 @@ void thread_stack__br_sample(struct thread *thread, int cpu,
 		sz -= nr;
 		be = &dst->entries[nr];
 		nr = min(ts->br_stack_pos, sz);
-		memcpy(be, &src->entries[0], bsz * ts->br_stack_pos);
+		memcpy(be, &src->entries[0], bsz * nr);
 	}
 }
 
-- 
2.55.0

