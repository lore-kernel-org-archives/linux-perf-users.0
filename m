Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5A41CEADB;
	Thu, 19 Feb 2026 00:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771461859; cv=none; b=PLHVSvNCs6GvkPk0FJhCyP3xxDrjIBZq19sG11vxH1BlVmaMErBEGpvP/tqWaVEiFyVv22wLwJDKQ6M1EnxWMtwWO7/t+Zz2l9ddk8LWvOdJuI87pceABA5/h0aHYBBOdBJhvD4XLdmuMNjoLXduIx8aTQAsltZbH7s1zP57duw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771461859; c=relaxed/simple;
	bh=9vYTY/O5HTPoSVtF4Av6VcIeMqAGtxvui8rx98HXlgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tlu5vcqGGEwmrbEyseT1IxPAWNWlkHmMGWHmwH+kSnOYFAORsNBGoXwTa96D82L5GVh0C/PaeUDygYoaJIbpQWAZ1Ks0ppeOKuMBZ+9tWIF9m1JnzVD6uUO3uzWfjyFu7LuyBhC/0R6smw6E30NJGso6MEFExrdhRzp+tdYvDU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qF5tZ3+M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qF5tZ3+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E22C116D0;
	Thu, 19 Feb 2026 00:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771461859;
	bh=9vYTY/O5HTPoSVtF4Av6VcIeMqAGtxvui8rx98HXlgo=;
	h=From:To:Cc:Subject:Date:From;
	b=qF5tZ3+MGS69JRbO99nIeBteyM2EJVGIcAcOL/7rqNpS0SCmjn9QYnDoMMie6cNKw
	 FaajCYMHgSIl/gy4hXYNyLo5yLhTGsxqeYMbfuc3IqKzbCbn2c8jlAl4n+rMHAW6fX
	 b9PCkEyxq35Le71fv69mPNUYJBnl3S9mN1xmwKTlFtta3MbWZ3IJvSXJXc4qktjVe5
	 e08Muswewp+NVITByFYhoVG3Y9UuMhR8FSQlZ3hsa4y8K5K/tTICGhrmyy7ejM8n6S
	 useCOvv8ql2loXmGY5UN/2phIrrYMlvkYDGVCv7kgJDYY53cliNsd+npsGkg5Uz1nH
	 FtDAQmVtRH9EQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 1/2] perf bench: Fix initialization of union
Date: Wed, 18 Feb 2026 16:44:16 -0800
Message-ID: <20260219004417.188434-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent compilers don't initialize all members (or the largest member) in
an union.  Instead it seems to set the first member only.  So some perf
bench output shows invalid numbers like below on my system with GCC 15.

Before:
  $ perf bench mem mmap
  # Running 'mem/mmap' benchmark:
  # function 'demand' (Demand loaded mmap())
  # Copying 1MB bytes ...

         0.011127 bytes/sec
  # function 'populate' (Eagerly populated mmap())
  # Copying 1MB bytes ...

         0.011127 bytes/sec

After:
  $ perf bench mem mmap
  # Running 'mem/mmap' benchmark:
  # function 'demand' (Demand loaded mmap())
  # Copying 1MB bytes ...

         2.209417 GB/sec
  # function 'populate' (Eagerly populated mmap())
  # Copying 1MB bytes ...

         7.875504 GB/sec

Because the first member of bench_clock is u64 ('cycles'), the default
struct timeval wasn't fully initialized.  Let's use memset to reset the
whole memory.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/bench/mem-functions.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
index 2908a3a796c932d0..676c8d18f4c2e259 100644
--- a/tools/perf/bench/mem-functions.c
+++ b/tools/perf/bench/mem-functions.c
@@ -193,9 +193,10 @@ static void __bench_mem_function(struct bench_mem_info *info, struct bench_param
 {
 	const struct function *r = &info->functions[r_idx];
 	double result_bps = 0.0;
-	union bench_clock rt = { 0 };
+	union bench_clock rt;
 	void *src = NULL, *dst = NULL;
 
+	memset(&rt, 0, sizeof(rt));
 	printf("# function '%s' (%s)\n", r->name, r->desc);
 
 	if (r->fn.init && r->fn.init(info, p, &src, &dst))
-- 
2.53.0.335.g19a08e0c02-goog

