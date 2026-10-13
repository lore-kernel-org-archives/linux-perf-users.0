Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7563C522F10;
	Tue, 13 Oct 2026 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912120; cv=none; b=HUuvJ8EOOtSFknjIooJaTlnHfxVsps+c6rNyK4RxFaAS123Rxb6d4sdjtSr+MxErGMiSeK830sxV7vWsiETT+eNybecGAx6WEAcZkKoFC1PDRJnrGm83+s6HVY8DJ365DBTRXreEIBu74LsKx7fgHVLfY4cJ5P7eJI5kr8TzQNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912120; c=relaxed/simple;
	bh=58yYov3Ry9A+DErpdPbLUhguYgm2IB/sNyOe1wThIlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TV6Adl+EA85oKLLuvrYOiGLULG4Fpvl97i44RScgG4qi+PA4DKSb9UL6LFlc/ySptFxahLk1jF9tnJMCzdZrmJ5sAD44utTjWRtO/WfC9OYXMwI2m6pc4LSKypg8KeQ9KO/9nhr6yYTM6jLndRn+bYEvgQUSGtHMofko6A1/Blw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aucdi1Tf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aucdi1Tf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AF21F0089B;
	Tue, 13 Oct 2026 17:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912119;
	bh=xaWIMWeMuLCXXJfcc40cuENRH3EyENp37ZLlas3fLl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aucdi1TftX+hJUdrM4xEZx40S93875A6XqYug+PnzWSuFd6MugAGCli+0jyM3gkGJ
	 7qtgrIn58/tRNHPyhSYRPaBCEFEaOAHY6ffY4d7RxKm73pSjAMY0ymMjHDIs+fr/6i
	 8PoCypJj6XSA/cFrvNXLtCx2uRpQY6vDBXNFsgadPjN/XmsQ2Kfg/lPjFaIy2+r6gk
	 95hVHI7aFwTt/lIz5gxrLtsq56vKFnQljATlWfza211yqC6K/YXynO0woHYXpOl6EQ
	 3urJw+pSPDOhFbPsSoFPiAr1IGug5pDG7FdJR1Z8ctMmxosQ6N0+U8gtNTQPdzbyCU
	 dFNdG7sej7DNA==
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
Subject: [PATCH v5 04/11] perf symbol: Update symtab type of vmlinux from build-id cache
Date: Tue, 13 Oct 2026 10:21:48 -0700
Message-ID: <20261013172155.160869-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013172155.160869-1-namhyung@kernel.org>
References: <20261013172155.160869-1-namhyung@kernel.org>
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

