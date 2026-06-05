Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85283355F41;
	Fri,  5 Jun 2026 23:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780703493; cv=none; b=keEpzdQNPkpKOWQsBGsQ1c9cf+P3rFGVk+eiWkDMZhaesIg3uu4aKxSufK4hhS5Ydc72PnaqyoOJ4CY4PuGqPcp2znIv3BGB7iboRmc7jvBEnJgcAK9p6AMshm6wSre9SDV17YPfMdkVfNM9ZaFrY9kRL8PZ0qpG+YwsGNRjF+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780703493; c=relaxed/simple;
	bh=stNG02Xz90MbJxDFRcGqSCxkDT6VHn2rJNnAoC1gzG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KJnif/DFM/FOCyN52qgi+PubQui6GQAwzIR/cI1puqlM84YhmoyvsgQ9HWSJjKt5gUMy/5D4eEkYP6qqEmNql31Wt7oetHCy4LjKWh5/+B/l3GfY+i2B5Ke8O3LYTaEvkGxFACIVfFDyWKUz1ur1aWbSZR/8w5hrlW6oNP3+bpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXJ6Qls7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXJ6Qls7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55541F00893;
	Fri,  5 Jun 2026 23:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780703492;
	bh=2U/UFgj5wRuNMYCsy4wU86gSUgfgNjrRCVPqtSajdsU=;
	h=From:To:Cc:Subject:Date;
	b=iXJ6Qls7O3aPkh6NhPOIUHNuNBH/DHBg0AcN1al65E2yLml0XlKiiHPCIG95KyaLK
	 fIsNwr1U3vD0MB+7fy+acQ9xlEstdRl1UQrYfuKVC7oHPuktz4VEjFFmChu8J5iOcE
	 SpyUAiKTni+PjR/89DiZaTmhsP4izUzxpVtvzZHbpJn0qZzDzK2fhTnqcstw5fObMW
	 M+Wu/7BFulFOcquJjbO/4aF3sWKdmAGBKf35IqTj3JpJJ/x3ymPpezHtH2zwzry94Q
	 gxAhb1QTspDcUMVSlkQ7nDgj8N2H68O2Jj6BWGxUlV2xhmlZvpmJxaLqwHiv8kOIJo
	 iYrFn0wv35nTQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 0/4] perf timechart: Fix memory leaks
Date: Fri,  5 Jun 2026 16:51:27 -0700
Message-ID: <20260605235131.2440270-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patchset fixes memory leaks in the perf timechart code.
I've extended and verified the timechart test with ASAN.

v2)
 * use zfree() and explicit clear for potential misuse  (Arnaldo)
 * fix a wrong condition in the draw_wakeups()  (Sashiko)
 * move misplaced hunk in the second commit to the first
 
While it doesn't depend on my other timechart patch series [1], fixing
the memory leaks entirely requires some work there.  So I'd suggest
applying this after the previous work.

Thanks,
Namhyung

[1] https://lore.kernel.org/r/20260604214931.2202322-1-namhyung@kernel.org


Namhyung Kim (4):
  perf timechart: Release event samples at the end
  perf timechart: Fix memory leaks during record
  perf timechart: Fix memory leaks in draw_wakeups()
  perf test: Update perf timechart test

 tools/perf/builtin-timechart.c      | 105 ++++++++++++++++++++++++----
 tools/perf/tests/shell/timechart.sh |  24 ++++---
 2 files changed, 106 insertions(+), 23 deletions(-)

-- 
2.54.0.1032.g2f8565e1d1-goog

