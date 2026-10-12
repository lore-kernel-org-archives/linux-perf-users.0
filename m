Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD143A9871;
	Mon, 12 Oct 2026 05:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791782770; cv=none; b=DXEko9xkp0ZOTsdlGcvSrJd71NqcqBAw+fMo7i3GsEnozT/rFKWED1owd9tl1u3o/7xgNfuZq6z+k5ubtZWM4jchD55s8g1DSbWWIlacqAf0xgGyuKTxsM2TLBAxO2vx1vWOCdHEEQ5pCuwe8BKALpNBqveU/5KUAhWWWVZZ600=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791782770; c=relaxed/simple;
	bh=+iahA6FY8T9iawzE3Im28pjNeLHqV3cJ6/i00TEhN5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kALz0q7G0cn48cU2EYzFcxKisZcBTeqtavKojzeN3E2Z8Ed/2cnut/v/8+JYZt+HftIJtRm2ipyF+Z/Kg3EAXHLupFcLACEVw+70DnB4OJ0xNXOggEh3S/3SKHWbLwX/G08NG5nGl4taL0SR6xMmVYhDv27mnJnxMko1x15j5Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oo0pDzQA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oo0pDzQA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82331F008A0;
	Mon, 12 Oct 2026 05:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791782769;
	bh=Ki5E2qaJ0V5oQAeX8c4xKNOkY/w+Sv2nj6sBXz0B96c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oo0pDzQAhFHxpH3fzJiOC0id4cZZnusB1xFhJHrG1FrKvF4QJE71uH3pX2IMeK9ek
	 SqZlUdDqW2XHmeb/LnzF3rt1ro9CJCnzhr4M1udSt8M5idzqjR9quRujcS98axukO4
	 CE/VSPp/OMyak0wGejV0lYuWjOEdwHMlZbLByqJMVx2pG1lSJyfLpF7e/NpxpKuUpv
	 ITEVrTZH+go6g6dVHtR9u8g1LDOmMzXATyMrqSBCP4FNhR9hxJEY8cP18bfptjah8L
	 ReefwaO4C8RPTx3gowK/zXEsTQaSXgW4j1Q/RN3kqRWIe/ndPIhoHbJiCFfkwKzzwL
	 BECgot8th5jiQ==
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
Subject: [PATCH v3 03/10] perf symbol: Update symtab type of vmlinux from build-id cache
Date: Sun, 11 Oct 2026 22:25:54 -0700
Message-ID: <20261012052601.13920-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012052601.13920-1-namhyung@kernel.org>
References: <20261012052601.13920-1-namhyung@kernel.org>
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
2.55.0

