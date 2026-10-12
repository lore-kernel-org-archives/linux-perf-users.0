Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439DA3E51F0;
	Mon, 12 Oct 2026 23:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848820; cv=none; b=Lm8aqWAvXXoDjCZ4IPNc1Ym1NhX13mj6OFeegsFHa79pMujo1+g47kPuORRmu8sLWCjwW23itRRu/6qFMRLyZUUAu1p26KoWyav3NhGiwjn0VH84QPBsmQRjBKWsb0PiN8Thrpoyi0iQ6CeD4+6jEiJE9XW8YpEXjEfTrTzX30c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848820; c=relaxed/simple;
	bh=58yYov3Ry9A+DErpdPbLUhguYgm2IB/sNyOe1wThIlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOZNnpkUlSGLZER9b4diaX+hIVixqg2v3vWw4xVm5sGGzHW/RoBPBqvaLLc9HlU8d3JV1FQzZba1WJbAM72uCVYFSGczva81qDXVEtIYfVyKPIDKtpsyrP2CDYXlrCmiIOWttyXCTDVhCxKb96mBk9aJEvMhUY5WV1xHwdy41VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdnmCIdx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdnmCIdx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A085D1F008A2;
	Mon, 12 Oct 2026 23:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848818;
	bh=xaWIMWeMuLCXXJfcc40cuENRH3EyENp37ZLlas3fLl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mdnmCIdxEJuyBt4CWWZicrNhUzE2pr80uDFT/GNURo1NBtrwCqh8LmNzgrZFLqc4i
	 1NjBNzDwIl0ABCxZf7gSr83wV3TWKNp9u2h0OA/l8ISLF9ZNr1Ot7W37N+n9d020QU
	 qir+2nwXfbB2Wd8ArD/FpF3oeIzqjeRixVfyoNflOS0t1DzwhGhfceM9oXXxhUt0wN
	 +oEkf6fAK56ptsJx78DANrnIh792EuEI7zZkfPINDkbjSVmDCtbEFXa43Owq2QK8oB
	 +ncq4/J6AhpFxr74b5b1/ft8PQJC6T6OcyBQMwJbChgK02Uq5gy9IcwSJHX/Cj9NK/
	 pNcNWMtFktKVw==
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
Subject: [PATCH v4 03/10] perf symbol: Update symtab type of vmlinux from build-id cache
Date: Mon, 12 Oct 2026 16:46:47 -0700
Message-ID: <20261012234654.60666-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261012234654.60666-1-namhyung@kernel.org>
References: <20261012234654.60666-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently dso__load_vmlinux() sets both binary type and symtab type to
VMLINUX.  To precisely track the symtab type of the kernel dso, update
the type to build-id cache if it's loaded from there.  It won't have
any functional difference though.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 5d98888d068c741a..cf099cbd29f268ec 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2079,7 +2079,7 @@ int dso__load_vmlinux_path(struct dso *dso, struct map *map)
 	if (filename != NULL) {
 		err = dso__load_vmlinux(dso, map, filename, true);
 		if (err > 0)
-			goto out;
+			dso__set_symtab_type(dso, DSO_BINARY_TYPE__BUILD_ID_CACHE);
 	}
 out:
 	return err;
@@ -2235,8 +2235,10 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
 		filename = __dso__build_id_filename(dso, NULL, 0, false, false);
 	if (filename != NULL) {
 		err = dso__load_vmlinux(dso, map, filename, true);
-		if (err > 0)
+		if (err > 0) {
+			dso__set_symtab_type(dso, DSO_BINARY_TYPE__BUILD_ID_CACHE);
 			return err;
+		}
 	}
 
 	if (!symbol_conf.ignore_vmlinux && vmlinux_path != NULL) {
-- 
2.56.0.385.gd3acb90ef8-goog

