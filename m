Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A241F09AD;
	Sat, 10 Oct 2026 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791656689; cv=none; b=n2X9rlpmX5fo6QCWYY62tiXjw3f0pUFwUi7c5w/zLpttxsGDxpo8lBvYgima0KJUxzXsFoKQATbF3HZ9KbYuUcp0Ua9i5lvCwl7nyrHAo73eVEwsXf9H7xQiQOpCYFH2jmvnDMxGCC1pQNc9cjJrDoqZDLhu4Q4uuUmClQcRmMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791656689; c=relaxed/simple;
	bh=8B+qZU8ZXU0AVBvFcEz5PHDaeTs2vMW+n+284B+4V2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCxG8h8wN6e/zubZjApcm1bUOCrxZ1ATv/SBeimlNE1rPrR/d0JoQR3Kd0jwPxA0SudixglMfUcFkdFRduTboAMtqc33tiLMqTP7JMjrT3r08DClN8cC2s5SSAZZ+ZMffU07pZTf7ssVCpxJC+zCsv+y9/08lhgGAcFBUnhOy4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Np1FLnvF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Np1FLnvF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BED1F000FF;
	Sat, 10 Oct 2026 18:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791656687;
	bh=N4aWXRUwb4RZ/uRKMWGalifNNxGd8g988gxFG5b7VN0=;
	h=From:To:Cc:Subject:Date;
	b=Np1FLnvFWgMJDUBeofJmtb6vAM3KcSeRlN23976ApLRXwBmWNnxEqtFPFjRw8QBsN
	 gRmJAjP9I3TRjwie3rhJDHh0pbg2iyHVAPyur6SPOYGvwNIeUXB5wWruEQD7Jd1mxy
	 JtGQnwuVZgGnISBGUqwHHw/0OA8nr/3dQCp9HNEw7dKjl05JOCUl3ShglhQQU8t4wD
	 I7CByVjLlbLac0OsvT56w8CXgn6MczSphMmeiX1mfUCEWO1ogF4Jj/zGCLGBNRM6RE
	 yhor3J3aoMigOU/ZmtQCf/hNzUVjZnqVpoHJUYUS50dVjHOZoWhtp2iOdUubpez1Q3
	 uU5me5BKoRkRw==
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
Subject: [PATCH v2 1/3] perf symbol: Fix symbol loading from libbfd
Date: Sat, 10 Oct 2026 11:24:37 -0700
Message-ID: <20261010182439.9732-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
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
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/libbfd.c | 2 +-
 tools/perf/util/symbol.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

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
index 5d98888d068c741a..a394e742f9b18812 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1930,8 +1930,8 @@ int dso__load(struct dso *dso, struct map *map)
 		if (nsexit)
 			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 
-		if (bfdrc == 0) {
-			ret = 0;
+		if (bfdrc > 0) {
+			ret = 1;
 			break;
 		}
 
-- 
2.55.0

