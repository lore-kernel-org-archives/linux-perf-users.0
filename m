Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB953074AD;
	Tue,  2 Dec 2025 08:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764663409; cv=none; b=RFCzwWpXZzI28tUyK/9TlP436jf3DoFwBx58T3n4DNP63TvNnZhZHGTuNKj+K6a7ZfZvxwZzjxHGFV4YUjI45MafeM5S7tZN0EaetDe/mDIxtfDWsFNxadySOwCj/n3Di+HA4bx4xuh448QxvRg3CG7hHWD1WxhjzACFVKHgs9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764663409; c=relaxed/simple;
	bh=cJYrSZRBNS/uIDIhx1MbRM83RbT4+ih0odaIDbvq8yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlyZz9smKaXShSmEPzeZpTkNOYKObL6HP9RqwGO42iqThTvb9jUhvw9yJD/t+u2/zDVXFUUq5bblXzJ6B91NA1q9za2Jt/bGm38yikgIYY4H6vDiUj/cjxTdlvttzbSYchvqv/FDmq/UELDICSvBB7S0zZFmN/f7ZtSsUjxEEU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGsCQ33W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGsCQ33W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F35C116D0;
	Tue,  2 Dec 2025 08:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764663407;
	bh=cJYrSZRBNS/uIDIhx1MbRM83RbT4+ih0odaIDbvq8yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nGsCQ33WUNWD55tmboWzgL7LACpTnSPlsNfKYLR251TWwG74SkebVGMW4EvyNvUGz
	 5RlUPDrHIHOVkSih86VyhfZdP5RdyEaOCkdJuAt7ajq+ip8xPBAUufthf827Nksi+J
	 X5EPhvoCO4g9RJFkO/rsas5b+NzIhfb81jv9duqPfc38YKAdJEFxb5KZJvaV8bGRh5
	 dMNyuj3NQPwLGyRdMERjbkSeSBCNgkU2FaYwT6k7fsu0iENNV1EOof4Vi/jieICVt2
	 TbFL37XJ8CDe1pRCWYamYm7zwyn7F6TuFAgiWUVQUj4nliEpb88QZu0c3YBwIz42hk
	 m4y1G/zTGntuw==
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
Subject: [PATCH 2/5] perf tools: Fix split kallsyms DSO counting
Date: Tue,  2 Dec 2025 00:16:42 -0800
Message-ID: <20251202081645.931527-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
In-Reply-To: <20251202081645.931527-1-namhyung@kernel.org>
References: <20251202081645.931527-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's counted twice as it's increased after calling maps__insert().  I
guess we want to increase it only after it's added properly.

Fixes: 2e538c4a1847291cf ("perf tools: Improve kernel/modules symbol lookup")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 5a38435d90c96092..8eea49c50453d13a 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -960,11 +960,11 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			if (dso__kernel(dso) == DSO_SPACE__KERNEL_GUEST)
 				snprintf(dso_name, sizeof(dso_name),
 					"[guest.kernel].%d",
-					kernel_range++);
+					kernel_range);
 			else
 				snprintf(dso_name, sizeof(dso_name),
 					"[kernel].%d",
-					kernel_range++);
+					kernel_range);
 
 			ndso = dso__new(dso_name);
 			map__zput(curr_map);
-- 
2.52.0.158.g65b55ccf14-goog

