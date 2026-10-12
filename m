Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9BF36826B;
	Mon, 12 Oct 2026 05:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783025; cv=none; b=XN7Y2OJ8u3m97qotj+ln3dvyMbj/ZPhjtBSAmvzkNikzlJSzhIyMhD/TFV2AMXMko0ke8n8hLOdcjhHSrXlVtA7FBtsNfxYemzDhFqfE/GTSqkZx+h6wWjGidGSpSEF2gFT95YZRDaXJZ4/s+LqPybVcZNHHLbC/QWdEmvq0nw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783025; c=relaxed/simple;
	bh=bmz8IC9+K6/CfMD0fyia/BV5uZ+3fCwpmYepfieqGuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKe5l9TNGhv4fFrHo2l9DeMIrAxxNhA5t5JTZ0BypQolgzL7QuR4YV8SBfK3vvZxQpa4kjKLVVV/VlYL2gYWOCfOy4ZetFG8K0ns5Qzy8XIYZsXRtHsZ4WbF3J6tgCAmO9IfMGnRADNnKkavKGMa0gBxs0tMatJ5zeTogXalvfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nc4XkEsx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nc4XkEsx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9316F1F0089C;
	Mon, 12 Oct 2026 05:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791783024;
	bh=HrsYvW3XFdrbe1HBO2TsFNOpcul4gg3TTUwZw5QEG24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nc4XkEsxQzMItN/dJ+FSeQL6+Znvx650hG6P0F0OtZfDsqmmHn5dHzKcrqEmAZIFt
	 R/0rUcwTLS4Kk7eFjORzns+YC/lu1HsGPhEwGmJr3O1rGy7La3ZnPpfnp4wvCT/Edi
	 6a8g9m8xtBi0OFaTCuyn2ticF8+xImeW3AP/FLGFDFR2XsVBKQGcM9mMu8WLl4Yipt
	 wtvl7JN9qSYC3io6olgRbdSUsImuxEjTk2VyYzJe/sPUEyhH58XgaivIC+rqHEZxft
	 rKgsEgsDvI+5IU8IAT0WPG0S6uiECeB/SlsCniq/L8TWQ5onr6zCiW2iajDTXTcGY6
	 DXt5DRHXYklLA==
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
Subject: [PATCH v2 3/4] perf symbol: Set dso symtab type for libbfd
Date: Sun, 11 Oct 2026 22:30:12 -0700
Message-ID: <20261012053013.14378-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012053013.14378-1-namhyung@kernel.org>
References: <20261012053013.14378-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It missed to set the dso symtab type when the symbols are loaded by
libbfd.  When it happens both syms_ss and runtime_ss may not be set
and won't call dso__load_sym().

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 55a4b59195a08be5..b63fa3c03f0e732c 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1931,6 +1931,7 @@ int dso__load(struct dso *dso, struct map *map)
 			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 
 		if (bfdrc > 0) {
+			dso__set_symtab_type(dso, symtab_type);
 			ret = 1;
 			goto out_destroy;
 		}
-- 
2.55.0

