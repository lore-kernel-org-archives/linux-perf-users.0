Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3763D9524;
	Mon, 28 Sep 2026 05:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574672; cv=none; b=RNISomArwam2YTPLR6H96JdZw0Oxitkz09GDdpi2LmEoP87JN/Gyt4Ak2iSEPzoXVKRjIKycvMsNivy7SscGWj3BQvsu2P87tC9tPwwSL/qslEu/T2tLGqCGq/pAI9kvg40Um5ULCKlBfpF20ksftJ84RUo2VytKPI5V7zaXMm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574672; c=relaxed/simple;
	bh=BuIZstscGuPPYZ47YGfbp0GoKynwRIFhHUS2vvVUITM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3LsMGCZGudds//v7xRiAc/ux0JlmKjcybLUF0UKillN8j6uzVwVCDSR+X4Q9CDz9fJqMAd25N5bcxOEneSYp3/7uA1l78FRavn9NxhuF4rAdCvksIrOLoL/fCVbF0MevbtGR9ksFa1xXjQJTaHzeEVLkLy+2L02knSE3hYoxUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6iCbGae; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6iCbGae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33F31F0089A;
	Mon, 28 Sep 2026 05:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574667;
	bh=G9Peqxj8xiTTkK0AI/8yjg0PDnf3CtZeH/2td3CpKu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H6iCbGae8EuNX3hFScIEZ9xFyiUA0ArneuKYbZb9DMe5TBvYxmm+RGWHb3mSgmTOk
	 b9FPrYenP1sTAkWnCF/uVerLkj4UQx9e12LyLmrQPQMHBQhYNBza2Ur19BhG+DcvXX
	 MkoFUAN1msZRG4DlLpvUCif2KPDfn2QFhMzvor45jBKr9t8poA0WsEibMLkYXZoJNq
	 1hdMccT/o3e0x39j7XJ47SPeDohWXSopL/mjCUGqG7i6Qd3lRwOQGoqb2yo5IgYcgo
	 Gorumg1N+DMATcla9TChX1eJdw4bMiX71h42YII0awPwZ5mfHNJA171rBNTatFYAxf
	 JXPRU065pWuwg==
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
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v1 7/8] perf tools: Looks symbol file first when check debuginfo
Date: Sun, 27 Sep 2026 22:50:54 -0700
Message-ID: <20260928055055.95144-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928055055.95144-1-namhyung@kernel.org>
References: <20260928055055.95144-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's a high chance that the file containing the symbol table also has
debug information.  Let's check that first before other locations.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dso.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index c36192e7ea557b47..9c8b963906a7e88c 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -2133,6 +2133,18 @@ void dso__find_dbginfo_type(struct dso *dso)
 		return;
 	dso__set_debuginfo_searched(dso);
 
+	/* Maybe debug info is in the same file with the symbol table */
+	path = dso__get_filename(dso, "", &decomp, dso__symtab_type(dso));
+	if (path) {
+		found = filename__has_section(path, ".debug_info");
+		dso__put_filename(dso, path, decomp);
+		if (found) {
+			dso__set_dbginfo_type(dso, dso__symtab_type(dso));
+			return;
+		}
+	}
+
+	/* Otherwise check distro debug locations */
 	for (type = dbginfo_types; *type != DSO_BINARY_TYPE__NOT_FOUND; type++) {
 		path = dso__get_filename(dso, "", &decomp, *type);
 		if (path == NULL)
-- 
2.55.0

