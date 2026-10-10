Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823E2341057;
	Sat, 10 Oct 2026 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791619090; cv=none; b=Gnefj+1uK1RkGxcw4gcxP/S9/L8azF89QXK0+pID8ZxWzM08VsOjQuCYsb6gFezs69brban5bwkNfaCJXtlq3s4/+yLb4hEy3jm9JeLg89GgzsyVhjTQj8/pRXM9hV4YBt/dkkefzQN9g7sEyPaClEdeiX8YSNL0oTVn8W2qHGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791619090; c=relaxed/simple;
	bh=5GfVGCGwoCCpX5T0M8pQ9DG44BzKzNiT/t4tdF2gPDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cFanB3upybM2SevV3wUilFYm7eLJQShMOaoJMsQ5SojbVo9/oOSXn4J0rw7UDY2+g5UPmZcA00rjYtFKmr5VAoNADHB9w28lo9fnIksO31TTucnJ3SIiQIMYtR+j2xhT0GfV1gMSfeFY9Ft6bclFqefSxnBCzhahAz/MhUF4Iqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBep84uz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBep84uz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7BD1F000FF;
	Sat, 10 Oct 2026 07:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791619089;
	bh=VmjZk25X57G2fa60zsfj1f6r04JNhjNp/z5dODCsypI=;
	h=From:To:Cc:Subject:Date;
	b=jBep84uzXwH9AsDjMV1PaqZGo5gDiirYqc4MmiDl9As9f8L7eXLGpZ+OefzXXaecf
	 ZNxbGRgtGy8sFY/zG+WNM+Ra8SzIuKASkE++d9RpFWygxfzdQcKLrhFzo5NbcI2Yal
	 /2WL/amjNvq/jerkSeOoAyTCzP+HXJP+d0XHd8NMO+phVh8QgENJMLzPUkzrONSbsX
	 LFxLrSGwHdIOSlmEdqa5t6T2ktu2mZ4Nlosao59JjBnQGVBQw31y64g3DQak2SaMOl
	 4eANzYYkHrZ4LH1442Xqclaoejpoocn0EdCbFQmUZ6Jrfpr6Bv+04185966v2bBHeT
	 /rj2++yVFBVMw==
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
Subject: [PATCH v1 1/2] perf symbol: Fix symbol loading from libbfd
Date: Sat, 10 Oct 2026 00:57:59 -0700
Message-ID: <20261010075800.41638-1-namhyung@kernel.org>
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
index 1175cb60f8206757..4d6c5d60cbaa693f 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1933,9 +1933,9 @@ int dso__load(struct dso *dso, struct map *map)
 		if (nsexit)
 			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 
-		if (bfdrc == 0) {
+		if (bfdrc > 0) {
 			dso__set_symtab_type(dso, symtab_type);
-			ret = 0;
+			ret = 1;
 			break;
 		}
 
-- 
2.55.0

