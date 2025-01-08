Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BDC1DF963;
	Wed,  8 Jan 2025 21:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736370018; cv=none; b=p0m3E5VnF+aK/Wu84eqaT/g4Ta8KClkL0AKyH5Q8kBV/VsIXJP46fLR6/AXGB7xlW9yCGD9dNNwZkstzCJAFx4tJbZKBKPdKMxK41LLFSDnitBSgUWCA1GsXZHQ10Uqh/wy8MGioWuXLl1YRG8jCZiB13FA3Zi0Lp+Req85vmqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736370018; c=relaxed/simple;
	bh=W68rh1RoGFhogIHIdkkOdROhmYawj5Dj6kwqyW1E7H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmwMP6dTzVfELq+Z33GEzYHAa0ydBc24ckf6Tx6fxsQ856nbqM1MTTGWVTlOW2f+VWGOd6RydYNxwuHdVZYji+cwxUIIntCrZrAssEfIqo4K4hXpLpAb/9do7tNmkEt26tEAeyf1Wg/YsQz03AeUHgNXEBP0FYrCG7h9VZswpo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+nLS6eA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+nLS6eA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD668C4CEE4;
	Wed,  8 Jan 2025 21:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736370017;
	bh=W68rh1RoGFhogIHIdkkOdROhmYawj5Dj6kwqyW1E7H0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U+nLS6eAUHQRbZA/qomAp0VItXjo5nXEDfDxV+2KBG2Ew5BtHqP2rj684EsnmmH1U
	 axh/mJo4T/+MnRTBW793ekxW29l+WaBRlgrUt0N9adJ2bYno9YvrSoeWyWgkxpwMY6
	 AlKoVxvKKbX05yoAY5cv2HurlrChwHdb9RECGnvB+fWzvngn+c/3dzfDQfO1mhe9vi
	 FyMy6+n3QLXp+nT3CjoULeacqH6BIhwRGWF1BP/Q6484LZ9Y808dRCKWYQT3dPjA/7
	 gfAcWZvGR7MeVsAl9QhglQYJwKP/zttSJhQsTZnbvTiHABqJSBEWoF8z3qUFdNA4PS
	 M6xna5Q+G3f6A==
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
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 2/2] perf ftrace: Fix display for range of the first bucket
Date: Wed,  8 Jan 2025 13:00:15 -0800
Message-ID: <20250108210015.1188531-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20250108210015.1188531-1-namhyung@kernel.org>
References: <20250108210015.1188531-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When min_latency is not given, it prints 0 - 0.  It should be 0 - 1.

Before:
  $ sudo ./perf ftrace latency -a -T do_futex sleep 1
  #   DURATION     |      COUNT | GRAPH                                          |
       0 -    0 us |        321 | ###########                                    |
  ...

After:
  $ sudo ./perf ftrace latency -a -T do_futex sleep 1
  #   DURATION     |      COUNT | GRAPH                                          |
       0 -    1 us |        699 | ############                                   |
  ...

Fixes: b875b6bf608589 ("perf ftrace latency: Introduce --min-latency to narrow down into a latency range")
Cc: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 90cf2c9915a7e35b..cfd770ec72867d77 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -840,7 +840,7 @@ static void display_histogram(struct perf_ftrace *ftrace, int buckets[])
 	bar_len = buckets[0] * bar_total / total;
 
 	printf("  %4d - %4d %s | %10d | %.*s%*s |\n",
-	       0, min_latency, use_nsec ? "ns" : "us",
+	       0, min_latency ?: 1, use_nsec ? "ns" : "us",
 	       buckets[0], bar_len, bar, bar_total - bar_len, "");
 
 	for (i = 1; i < NUM_BUCKET - 1; i++) {
-- 
2.47.1.613.gc27f4b7a9f-goog

