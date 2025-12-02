Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E944302143;
	Tue,  2 Dec 2025 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764663408; cv=none; b=oGO3xeykVR6fE1RR1Mibad4WgcDyVqiuB/n+3NOfTfN8q0dcQ3Bv/tqZvWMh6TSmyMxMHANHT0skIHvK1GQym4RgtYHLuu8pxAlxRc1ALmCA90+liBF7Ypb3rg+6iVaiff9p3zp6PpJXd782jjQY8HyLIBl5msM0SqTbv4WmCGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764663408; c=relaxed/simple;
	bh=94tAKDZ53sl6q3FUT31bWUB3s4TUzwZR3kG3Xd3nFxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRDPAUsMGtD7XeUBMi2L+HuUZv0IroUiDxJrYUWqXtn6iK9FJPCvtLH5z+tIwnJkHKtltQMh/9PKv1kIWwOl+JjVYuA3O8g8RBSPS0VjiUg1VIuDIOIC9ee8OoJxQ6VVTUQKdMfr/h9HnU8kHliL4EFU6yAVbEh7vvVq8x7MUr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sB0eSrBf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sB0eSrBf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F55C19423;
	Tue,  2 Dec 2025 08:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764663406;
	bh=94tAKDZ53sl6q3FUT31bWUB3s4TUzwZR3kG3Xd3nFxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sB0eSrBfNT3siGqy0H65ugClxhI4/HzODBLHsahhxN16DoGTHbE6nHR2mrMSWH8Xy
	 Zn/4T4PaVxXnPPMxtfSbZ8i6EL60MGkF02ZExv6J0f1NuiHBm7kaJn407WR/f6wmMj
	 4/JI3ghdoIJ9NM8ohB7VBaaRpbwTEvTnx3k7FE4LbxwxNRGCyYM6l42WjpyAjt6Kls
	 z4nZkudVz008KT1e5jmkhlRgA0NlQXy4ciCu3k0eDRTLKaem/CEP6cXnUOo0gJvy2c
	 y6j+pvyBUWVP6XxW3Veb/qBfcSPz6GHt0VEtsFnSfZgRK+Oya0FkqtYzbCao1qcIWD
	 gmxwEfpHZhk+A==
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
Subject: [PATCH 1/5] perf tools: Mark split kallsyms DSOs as loaded
Date: Tue,  2 Dec 2025 00:16:41 -0800
Message-ID: <20251202081645.931527-2-namhyung@kernel.org>
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

The maps__split_kallsyms() will split symbols to module DSOs if it comes
from a module.  It also handled some unusual kernel symbols after modules
by creating new kernel maps like "[kernel].0".

But they are pseudo DSOs to have those unexpected symbols.  They should
not be considered as unloaded kernel DSOs.  Otherwise the dso__load()
for them will end up calling dso__load_kallsyms() and then
maps__split_kallsyms() again and again.

Fixes: 2e538c4a1847291cf ("perf tools: Improve kernel/modules symbol lookup")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index d8fc5ea77f849326..5a38435d90c96092 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -972,6 +972,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 				return -1;
 
 			dso__set_kernel(ndso, dso__kernel(dso));
+			dso__set_loaded(ndso);
 
 			curr_map = map__new2(pos->start, ndso);
 			if (curr_map == NULL) {
-- 
2.52.0.158.g65b55ccf14-goog

