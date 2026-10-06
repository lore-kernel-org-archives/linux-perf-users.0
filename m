Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC874FD299;
	Tue,  6 Oct 2026 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330200; cv=none; b=YHnV6PEewJgRyCQdEAnqb5zp2QR30gmGEZ1M7SeJtPARJ8SluidiSuc4/gEz1sZWGiwBOmbylvr69MToONEVWrhbl81fkhKAQskwh5CPs1GAOvJ8Gz0Yg7gTIjgikX0O1vbMzAscW0qhyXyBxbHbD/eZwrCj/DsiA6WdS2yBT3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330200; c=relaxed/simple;
	bh=QhBknJPSbw2rInCqotrLzg0Mwcsw9rAr95ScCh8CnLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMcDoNb/oRECVSW+Po7H/iPgPMd2XIsY5Aiznbb52DSZHszpq4M3rTmEJdOfBdu7upGSx+74fbseCoDHPUG8bXS2HQQr5ksgPThTON8S29y2ukyVq5jR4jDRs/DIqSTbKGBzEAchbIzVHeK4WZo/5IwMGSqBo+fvuxzBwyp1/Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGa2gmL0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGa2gmL0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034FE1F0089D;
	Tue,  6 Oct 2026 23:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791330199;
	bh=6zybIb8Rpm5u1k21nXaydtJZh+p8i8ULl15B4VJ8Cms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EGa2gmL0JLbGIdOLrr0He4ls90Au4EbPd9advHQ2mH3S+fXMrNVIhvYa0ILIebsk+
	 +Ua+o2G5RhcFf4hPjUmOX2HT8PbXcW4Xjznq86YsH8PngorubBQbRKBIlqcnOTDK4W
	 48WxDJdhDTIhPtGv5d4K0T00Aki0qQp2k2jtaWK5lEg5OL1/Ccju9dhwVCe69Yodyk
	 dDFjEnluu/57PcOF45Z0uN83Bz9FmNUAOxg+HE6Mogend4WUGLm8ag2hrP+RmYaCe7
	 sS1MW4lgEgLQVYJnQ8w8mEHpo7+ni+o0SRBTLU0KK6/4Gu1vhFFSuzoskmxvSSMhGV
	 wA7xQWHjiZTwQ==
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
Subject: [PATCH v2 08/10] perf symbol: Do not set binary type from symtab type
Date: Tue,  6 Oct 2026 16:43:12 -0700
Message-ID: <20261006234315.920817-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20261006234315.920817-1-namhyung@kernel.org>
References: <20261006234315.920817-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DSO binary type is to access the binary (e.g. instruction) data
while symtab type is for the symbol table.  They may or may not be in
the same file.  We should track them separately and correctly.

As special binaries already set their type before loading symbols, leave
the binary type info and only update it when actually opening the DSO.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 389dbd7e5192f4f2..1175cb60f8206757 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1956,19 +1956,6 @@ int dso__load(struct dso *dso, struct map *map)
 
 		if (next_slot) {
 			ss_pos++;
-
-			/*
-			 * The binary type is used to find the file containing
-			 * the executed instructions, so prefer the types that
-			 * refer to the actual object over debug-only files such
-			 * as DSO_BINARY_TYPE__DEBUGLINK.
-			 */
-			if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND ||
-			    symtab_type == DSO_BINARY_TYPE__BUILD_ID_CACHE ||
-			    (symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_DSO &&
-			     dso__binary_type(dso) != DSO_BINARY_TYPE__BUILD_ID_CACHE))
-				dso__set_binary_type(dso, symtab_type);
-
 			if (syms_ss && runtime_ss)
 				break;
 		} else {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

