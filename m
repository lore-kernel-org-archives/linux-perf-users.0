Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0826D395DAC;
	Mon, 12 Oct 2026 23:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849581; cv=none; b=Ia/bn7hERaOXUYytBDPTtm5MTjZ/VQ7jPSpAMh4hZe8nL5uBUKxMS8vGL0Q6VGrGgFWYKYZKQNPl33BbxXLe5DmOCCvdKWJMgCpT4MjUYd4VTtt1VNZHwb+vt33Bn+9dO/d6Ybk+Gttu3UNhdMO36EZKeI+cfCxQUWA2Oe2DfiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849581; c=relaxed/simple;
	bh=A83bEUfE7ABmxyA489hn2Rb9oZzTktDBQAXITRhkNXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qiTSUjSGmtf+KuQbBlF9uiXelfwaJY8EtOVg+605M9fwPFa2fj83wgSbc7ColEyCCcPeUk0qWVzOxSedMwhIL1nKeQCgvDYl/9isvi3pOb75vQKJwi0Hvd5XcJdFI7IwP8ypJRcTRnbvUvTgqSSQJq1CniAogel+uhWEaX1JZcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFSOBcde; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFSOBcde"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683911F0089B;
	Mon, 12 Oct 2026 23:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791849579;
	bh=ga/b/LQ63ZBTd0Qy5xjVg+NOh6onBGJXQntG9KkxDHQ=;
	h=From:To:Cc:Subject:Date;
	b=hFSOBcde6+y9TarGJ8sIZTwJMhe0nEP9wMtOf7++qFDvDsotRAlajZBxIy9TCeP4j
	 VVQBlca06kpdFfMjgcVPDeFk0EFcp/neXz2QYrj+JVu9Ck55aqQCA1+nAQMWxwEdkU
	 PS5cy/PupUW3QVo2HZifeLx3eCiT6gjH8DESIDT8KqXrEFcqAYq+3PwZuAFM2Yx4ES
	 qqIoWqvujQWlZ9lOt+byRlwoNyq0RkpeBh+3j7ksA6+0erlL6s96sgZCa4ss35FoWy
	 VRyczOj5qhNEdjQgJhk1MZ6ReO1HOWepjKj70KJBM1PjVXdIGQdE/G4YC6p8/Iox+5
	 P9ETdu/XZLibQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v3 1/4] perf symbol: Fix symbol loading from libbfd
Date: Mon, 12 Oct 2026 16:59:34 -0700
Message-ID: <20261012235938.87912-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dso__load() should return a positive number (number of symbols
loaded) when it succeded to load symbols.  But dso__load_bfd_symbols()
only returns 0 and it's hard to check if it actually loaded symbols or
not.  Let's return the value of dso__has_symbol() and check it in
dso__load() so that it can return 1 for success.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-162540@kernel.org
Fixes: eac9a4342e5447cad ("perf symbols: Try reading the symbol table with libbfd")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/pe-file-parsing.c | 2 +-
 tools/perf/util/libbfd.c           | 2 +-
 tools/perf/util/symbol.c           | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
index 30c7da79e109b480..3979f38bf127c218 100644
--- a/tools/perf/tests/pe-file-parsing.c
+++ b/tools/perf/tests/pe-file-parsing.c
@@ -59,7 +59,7 @@ static int run_dir(const char *d)
 	TEST_ASSERT_VAL("Failed to get dso", dso);
 
 	ret = dso__load_bfd_symbols(dso, debugfile);
-	TEST_ASSERT_VAL("Failed to load symbols", ret == 0);
+	TEST_ASSERT_VAL("Failed to load symbols", ret > 0);
 
 	dso__sort_by_name(dso);
 	sym = dso__find_symbol_by_name(dso, "main", &idx);
diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index a907d7c1ac948808..a4dcb406c79e9cee 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -463,7 +463,7 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
 	symbols__fixup_duplicate(dso__symbols(dso));
 	dso__set_adjust_symbols(dso, true);
 
-	err = 0;
+	err = dso__has_symbols(dso);
 out_free:
 	free(symbols);
 out_close:
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 116870595f75c7dd..2b1c1b8d9652e720 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1921,8 +1921,8 @@ int dso__load(struct dso *dso, struct map *map)
 		if (nsexit)
 			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 
-		if (bfdrc == 0) {
-			ret = 0;
+		if (bfdrc > 0) {
+			ret = 1;
 			break;
 		}
 
-- 
2.56.0.385.gd3acb90ef8-goog

