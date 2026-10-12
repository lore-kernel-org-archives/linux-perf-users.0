Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EB53750BE;
	Mon, 12 Oct 2026 23:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849581; cv=none; b=FvSLTRY+y9/V6K1DH5GjBqvc/AdL9uxpSTYrm9KmfkIg3+8fVPGohwrEfqzOMPzPwGx5pNoiJ7i4qS45qeBBK1c48y0RRESj0xe5eZ5pa7AJHJ89Wy50BtvY1Q3ttabNfWxHbtkw3LHCaEXqGCtS8T9/BinBlpPSdUHEwS27XFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849581; c=relaxed/simple;
	bh=DAk4M174EFY8iPA9dKZpgAkYXxZtGbmyOHfm/4Ayasw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOzhK0aprACyfUmRNFdRY78oTdPDLHtXeF6yyv4v6/mIYhVcgTcHY+vyHMndFF6XcSQsmAj4rdtftuKVuOrJ1EPJC3WHC9ur3MVRr+pTIgZnOP2mWE8eouKjVDwlRcMvC7ngmc3jZaOgCwjVqPneah8Ndsu95HUxesxzhMk/Pwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8q36RhM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8q36RhM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4741F008A1;
	Mon, 12 Oct 2026 23:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791849580;
	bh=lBx6GBX1936QWcZjx71S1hK+ulNNBMEOxKUh5pyrlTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N8q36RhM22dIj1FDMSgP9fFVIFTa5HDKc4op69eqoJ/RSy3PwqEnNbk7WU1FOnH6Y
	 6NnipL9+HEVFeGH1nN0F0gVDxvMe7xqHf3PVIKjHUfMvOywjMWFrQHLZX35yYWHzX2
	 gO16Y4g8d+WIX8hugMRPdgpX0Q/rjwK0m8kZchOmetUKraWCsmg0ts0+ZV4CY3ZyRQ
	 FNcoGUO92tKUP6po7RQpNNPbeilrIgZyOoYD/aj4okrsDoMC/pAIMU2NHKHCTY4ddd
	 gx+xssoO9ud8H8vlmEuPTRHUVNkOTMOK+flAT0o1dRAocVVAjl2wSF7WT7FjwLO3Fy
	 2P9YeMPFpATvA==
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
Subject: [PATCH v3 2/4] iperf symbol: Add missing symsrc__destroy() for libbfd
Date: Mon, 12 Oct 2026 16:59:35 -0700
Message-ID: <20261012235938.87912-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261012235938.87912-1-namhyung@kernel.org>
References: <20261012235938.87912-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When libbfd loaded symbols and there's a pending syms_ss, it'd be lost
or overwrite existing symbols.  Let's destroy it before breaking the
loop so that it can safely return from the function.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-162540@kernel.org
Fixes: eac9a4342e5447cad ("perf symbols: Try reading the symbol table with libbfd")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 2b1c1b8d9652e720..02845b69ae6b5fcf 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1923,7 +1923,7 @@ int dso__load(struct dso *dso, struct map *map)
 
 		if (bfdrc > 0) {
 			ret = 1;
-			break;
+			goto out_destroy;
 		}
 
 		if (!is_reg || sirc < 0)
@@ -1975,6 +1975,7 @@ int dso__load(struct dso *dso, struct map *map)
 			ret += nr_plt;
 	}
 
+out_destroy:
 	for (; ss_pos > 0; ss_pos--)
 		symsrc__destroy(&ss_[ss_pos - 1]);
 out_free:
-- 
2.56.0.385.gd3acb90ef8-goog

