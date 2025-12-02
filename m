Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F9331D38F;
	Tue,  2 Dec 2025 23:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764719844; cv=none; b=HhxCrozo63LYAIiaCttgjmIsO6TsNXtjy9meelRqr8iuKGMbmP8VDGO0A7VVAn7XNWrOSxvnAdV2K5y13ijrGxdrRvmyNsXvZrWly0fXZ6V5YbkWYA2L6ka2XQ8CeMvIiIXxgusmx+Qgps+qbAnts2BXzDset3pLtuuIH0k8L5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764719844; c=relaxed/simple;
	bh=GgE0ihyHqq9jRfijKuxZ9Os1YfSIUzFHqD2EGHzEb+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRJpHrPRicI8gX3eKa0A9ETgFDK6oqI3atLeDI0vGN8UK8CeNaxSfCevxkBWWk0bp/mljPFdSS6lI+JFKc4S1q3prU5GVejZazoeZmKzEK9/svr7QHe2eLuwc9RvL63CqqFToF+qhYdER2LxknUZnpClq46JzP2tZY3ofmTkLc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhAdjJfV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhAdjJfV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D00C19422;
	Tue,  2 Dec 2025 23:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764719843;
	bh=GgE0ihyHqq9jRfijKuxZ9Os1YfSIUzFHqD2EGHzEb+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EhAdjJfVakueV2YGiTtYWO7ibBcNNRYorBDeN7MtF/rUvJ/kX7qhVyZHSNpobO4I8
	 ZcGFAC4SY1c7UPIyXzLs9XI0DFNx2iNNqlAMMAt7Lqj7O946LiJaGOXmnNqA6VpVWV
	 pIw5vjEAR/ldr675HtJdnC/+f4rHxS35gumRCNrJz+Hgg95OygCBRkvGQY5hiZtc+G
	 AhA3OkVf8SR5+bhE283eh/zM0IDPh082nDNrP++mT5D/rh+MKGuKnOu8Gah93DC5b0
	 f1fbrUiRc8tetp0dcMkkhPOmWdBWDA19WwXOai3rByVFRC1MhgUPctiUCovFeqJago
	 htZuQGwDnFJKg==
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
Subject: [PATCH v2 2/5] perf tools: Fix split kallsyms DSO counting
Date: Tue,  2 Dec 2025 15:57:15 -0800
Message-ID: <20251202235718.1018752-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
In-Reply-To: <20251202235718.1018752-1-namhyung@kernel.org>
References: <20251202235718.1018752-1-namhyung@kernel.org>
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
Reviewed-by: Ian Rogers <irogers@google.com>
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

