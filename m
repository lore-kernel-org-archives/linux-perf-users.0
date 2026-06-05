Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7EB3D3309;
	Fri,  5 Jun 2026 23:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780701117; cv=none; b=kAJZVkfQPtGHMVxc/rQ1M6ztllgpnwjARc8y01ZJgi7TbYbnThrBmpDyddDcJQR7bL3hM6uJd55vRGHNTIxCGbtBiOFuGGWwcnS3BwLiNbkSbZJvX6l/5vBV+MmA5piU5ZM5Y3qR/xUZoWdPlOF1fJ7sZgipZEKFKC/H+7NQtr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780701117; c=relaxed/simple;
	bh=LHxX0fTEQe77HQqNK7/bC+crJ1B03mJ5P5Mjn7/GZOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=trFo2gf4gSnX2b3BUXKmuYa8MTs8yl2mNjyuD7Lv1UT/GYTm7SV0uIpzfIdW7os9vZRE/xrHlfo7JQKBSbMMWFdfnntvKpn6pr/NQ/DgU7ydB+uVL8VrlhNBMl/zwCq9JHxW0jy5PomPNUbnKulCRs3509MiiwDGByYahafpYRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgM5j4Og; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgM5j4Og"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995241F00893;
	Fri,  5 Jun 2026 23:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780701115;
	bh=zT4qTVpu7408vshWLJ89gkFxND+7xvqMOlyO5pVsxv4=;
	h=From:To:Cc:Subject:Date;
	b=hgM5j4OgKBCQh3a8skcKhAo9QhzoXSBjjuemvLz9pS29ne+XhgWX4R8y/AgPA/WMe
	 0B3x7drNzJ62oIBhZE3AuRVWaHK2HPP9x+nXoBHc0i4Xzdi81CeO3CF5XGqjaaaqdS
	 NfJ4zh1pvQXk6w/39mDfTTFqe5wmLjOujOMxuXUZDwb4TACfpvNHhLPPRaIGsMlKl7
	 oTdIGchoGB9SSYjhojtVJ8El2V56cRrfs3/AJUGn6sV8xJzEpszw/d00Bw8yHPFSFv
	 Bh1q93iNfRuELSxQ8ENmfnJ59P0sf5owgO5j8PiFaY6RIn6XHnKpLxri9H6vJau6uJ
	 ehZiF13vbho0Q==
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
Subject: [PATCH 0/4] perf timechart: Fix memory leaks
Date: Fri,  5 Jun 2026 16:11:51 -0700
Message-ID: <20260605231155.2415760-1-namhyung@kernel.org>
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

Thanks,
Namhyung


Namhyung Kim (4):
  perf timechart: Release event samples at the end
  perf timechart: Fix memory leaks during record
  perf timechart: Fix memory leaks in draw_wakeups()
  perf test: Update perf timechart test

 tools/perf/builtin-timechart.c      | 93 ++++++++++++++++++++++++-----
 tools/perf/tests/shell/timechart.sh | 24 +++++---
 2 files changed, 94 insertions(+), 23 deletions(-)

-- 
2.54.0.1032.g2f8565e1d1-goog

