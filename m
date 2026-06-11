Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247903C1405;
	Thu, 11 Jun 2026 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170932; cv=none; b=Y6JCZRPQlwxxET4+biip6glkjpIxJaKxEvLCMW4sw0OuTAESLg7efAw+qoI3JHQyqhJvh9rOK13wiLhzrjqk0puaRRC/X7kfhyvm4cSGlLcKrY7+CGkSsvsvotMHYB8GxhsjwHqBM/bCtL1OMYhAXMHoq73u/ILVLHTn8lpop3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170932; c=relaxed/simple;
	bh=XoP5nsCUpvm3knp4DP0VbgcP5hqev4yY/dd6IfoLr7c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YuwDv/nS0RN+MBmROmSZ1CmJYi9KoMNuuXHgDgP7o2QaCH2zcBaTfbNdsIGt/9Vwq7RtDlSV2QWUq+yVjJSBC92MVaJHiwGDH0O0G2+fh19fTrTef9qwvu7tKcdI6jeA1n0lVIXNq432iX/hoRka5ZXA9EdmCRL/Ckfx8IP6csI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LLF4DvRo; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LLF4DvRo"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781170918; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=eqR2gnC40YuN5B8Ecc/BJg5HM755ZSava4+bD4ofvco=;
	b=LLF4DvRoueTZiRUp10VSKLkjuYKnA2pWx6FQvzJXm+2TnyI+Xd7lm6LpmamSEL4+oeshoFT978MBd1NXOYDjRh6YlsfjsDdCazC8SpL629dejr1z4+VUILknjzUISwUNozysaKCOxNAtERfdMnOBcrx4zNxxAk4vGXCThG3j1gw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X4dJkGn_1781170909;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0X4dJkGn_1781170909 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Jun 2026 17:41:57 +0800
From: Tianchen Ding <dtcccc@linux.alibaba.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf cpumap: Fix buffer overflow in cpu_map__snprint()
Date: Thu, 11 Jun 2026 17:41:49 +0800
Message-Id: <20260611094149.49731-1-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When SMT is disabled on a large-core-count ARM64 system (e.g., 192
cores), the online CPU list becomes a long sequence of non-contiguous
even numbers (0,2,4,...,382) that cannot be range-compressed. This
string can far exceed the 128-byte stack buffer used by callers like
evlist__warn_user_requested_cpus().

The root cause is that snprintf() returns the number of characters that
*would* have been written if the buffer were large enough, not the
actual number written. When the cumulative return value 'ret' exceeds
'size', the expression 'size - ret' wraps around to a huge value
(since both are size_t / unsigned), causing subsequent snprintf() calls
to write far beyond the buffer boundary, corrupting the stack canary
and resulting in:

WARNING: A requested CPU in '1' is not supported by PMU 'cpu' (CPUs
0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,
52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84,86,) for event 'cycles'
*** stack smashing detected ***: terminated
Aborted (core dumped)

Fix this by adding a bounds check at the top of the loop: once ret
reaches or exceeds size, stop appending. This follows the same pattern
as snprintf() itself - the returned value may exceed size to indicate
truncation occurred, but no out-of-bounds write will happen.

Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
---
 tools/perf/util/cpumap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 21fa781b03cc..8328f18b7a84 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -680,6 +680,9 @@ size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size)
 		struct perf_cpu cpu = { .cpu = INT16_MAX };
 		bool last = i == (int)perf_cpu_map__nr(map);
 
+		if (ret >= size)
+			break;
+
 		if (!last)
 			cpu = perf_cpu_map__cpu(map, i);
 
-- 
2.39.3

