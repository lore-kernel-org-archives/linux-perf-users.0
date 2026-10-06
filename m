Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B9A4EFFCA;
	Tue,  6 Oct 2026 23:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330198; cv=none; b=QehGv/pJR8VWIHRDwktjAbnV3OBgvylIqRBI4dtK2tM+VTahhe10evSfnTRFZUUbd8HN9waJvPtZuitGK83u/t87YRP9f3c4TzEN9nXzwJ94cK4wu4/jJK649V1OXLuK7RoAmCbjgQG/Or1KHkpAIogxWTc2gjJ5uQes8q+qkuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330198; c=relaxed/simple;
	bh=kHMYBwOxKALcIgA2i31cQNoQFEMseDCxpnQspihU6lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PN1fjrHKOyzCOC9PXb5uT+6X2pajiyghMFiHCIaLXGY+9PPGIoYERMobur2fbJvk5/VX2sTACTPcLhad+OPsu0fBDXIPXoIpj5Hp4saDveU81Pis8a+Iw2nQr0cnwvXy6zoLMYMormNE8pS0GebarptgJcexqRHO5kWRwrVR09Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abef6p5g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abef6p5g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D8D1F0089E;
	Tue,  6 Oct 2026 23:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791330197;
	bh=7Da8wURD0WnwA9OQdH7RvQZApt2CV9ebUxVFum4B11I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=abef6p5g4naT2b11sCOakB3dauzjt8hOOGGtabiCq2lAjDfqJssqIPfbI+ERThR2o
	 qAtZabJ6jpfkQmSSRD5bRGbjmxxfU4KWv/Rv07TdgQIQeH2saIwqaSctk/Dwz9orjK
	 WG76LprSAGd3I1GaH9zH5j4sv3vcKwQS8xgh8v9miaw3t2RajYMr5hjBobYwzk5lJE
	 wkHgmvy395GjwecSy3NxGQv5eQlUW9m5kAYOvrv+hgf1ok4uhxNHjAqweFH+/tSbX2
	 hvJHTkWnf1LKtlrB23hyQG3GQ5ryIOVhBL/W2iCGJsAJI3NEKjB7IDo6DSIqbo+3xj
	 E94wJTs6+8wkg==
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
Subject: [PATCH v2 03/10] perf symbol: Update symtab type of vmlinux from build-id cache
Date: Tue,  6 Oct 2026 16:43:07 -0700
Message-ID: <20261006234315.920817-4-namhyung@kernel.org>
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

Currently dso__load_vmlinux() sets both binary type and symtab type to
VMLINUX.  To precisely track the symtab type of the kernel dso, update
the type to build-id cache if it's loaded from there.  It won't have
any functional difference though.

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
2.56.0.rc1.315.gc6ed9934b7-goog

