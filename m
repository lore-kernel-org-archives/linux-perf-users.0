Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989AA353A8C;
	Sat, 10 Oct 2026 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791619090; cv=none; b=aUe9TIPM/gkmgHsiyeqf8/1a6i+hEwMQPYS0yOgjkoIyBQvYt1CpmnaSRDMyxvN7ovB+5Mw3uRX5AyYapFYU1Rs55qZuVmypW5PH0vXeky64D8NPhLH962QvvktChSbB1zyrEpHsxvJhScC891NvnqpkDTKAXZRKIsYFhXFqFXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791619090; c=relaxed/simple;
	bh=J37svs42/r4uGKH4yeyuwDeow1Bf9E0jUygiEIo7Vwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJL5ePW3cwEvhQPPc7OIvSQG5MS12utlgwOmzsM/Lku3pBkfKgFtyTqH/dMWKA8OXfefKFJlCkGnl5yxYFBimVgGSMBHRpeDfhGlJFs+lmgyGuci5KbQ10mCfyI1zRoibiHdu26xy8YbkuTqSEHfWpUh1XCeDsbyFpa3B+rQhYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0PmJmQS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0PmJmQS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299C11F0089B;
	Sat, 10 Oct 2026 07:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791619089;
	bh=WQkgiktw4p5Q4dlwnkPJxRY1IGw2Motl8U+0qK6m/LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X0PmJmQSHK9+FJdGQPUKTLGoV/GTN0TO437YE/6JdkVcj5foCFn2W2Dkf1aA6NGnr
	 pUhTkO3ayJOhcg3pzbdwB59XHIHStEDc+/2mMMcLzE4+qJBa5bTdj1YLetxt/5k1Z4
	 El65yh7584VwF9+XqvtSPvxm4Ea4U+8ph5u890VO2Cg6iiGGLZ3LCFUeQvhm22hrtn
	 Hrl5hAb4ddnASZSkL17uV+0MzRjJHmqOzwCs3ZKxbXkGHlAIMyaKpL5u8datF91ij+
	 Z5/NrAqPfhAVwtryHOqoHFFwxt4dHS4ruho3iZFjbjTsNtG80IyUc8pYBH33hR/GKQ
	 CUkWZWfzZTBbQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v1 2/2] perf symbol: Add missing symsrc__destroy() for libbfd
Date: Sat, 10 Oct 2026 00:58:00 -0700
Message-ID: <20261010075800.41638-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261010075800.41638-1-namhyung@kernel.org>
References: <20261010075800.41638-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When libbfd loaded symbols and there's a pending syms_ss, it'd be lost
or overwrite existing symbols.  Let's destroy it before breaking the
loop so that it can safely return from the function.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-162540@kernel.org
Fixes: eac9a4342e5447cad ("perf symbols: Try reading the symbol table with libbfd")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 4d6c5d60cbaa693f..4335e6549d0aecf0 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1935,6 +1935,10 @@ int dso__load(struct dso *dso, struct map *map)
 
 		if (bfdrc > 0) {
 			dso__set_symtab_type(dso, symtab_type);
+			if (syms_ss) {
+				symsrc__destroy(syms_ss);
+				syms_ss = NULL;
+			}
 			ret = 1;
 			break;
 		}
-- 
2.55.0

