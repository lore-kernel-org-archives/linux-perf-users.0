Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699F535C6A9;
	Mon,  5 Oct 2026 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182061; cv=none; b=lnxG/RlkVoAa3VFAqbN6ZA0+24drDkoKM4O8//jObzs4iu9j/9m2zhZMTdmI681KxLMZA7SKA/zZWxTWahZsD3l/beRro6O2mltLKiwT9MD1PeK70hddtkv191500mdWZieA6kr80tppeMoz4DVWMpZs0QZ6MF6NS/AsxgIOABw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182061; c=relaxed/simple;
	bh=BjYrwy+RP0SRjcfagMES2G2S6agmGbXunh5QTums8ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKbDbOf/dRnOKCCvo2ndp6fxoX//gxvs0V8f2MZPTkjV75/61QLKn7mL8hNn2tUe4Sb/xirBt/l495E4gZWiJ1MqbcOzAWtvQl4jpE0nPEPK88W3amY/D/CWfWFaU5dydNvjA/BYlym9WGY+SV1D9sNs4I8Uf0mJsWgyJVYbmP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdR4yoRm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdR4yoRm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D501F0089D;
	Mon,  5 Oct 2026 06:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791182060;
	bh=5UmdOC+6WqKzz6CVHgKOtSE5HvSwycnx2qHnwCQOFKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AdR4yoRmBEVs4ODf4W+NYp65Ngt9VjooRCCvlSM7zI4iYM8U2aIzAQAb9EeeAtffB
	 J80AD8qCf4ClqaGhxy6P12TM6CMC2Q1IOnE5MgRTXY5Wp2GCjwHWgGIGUcPV5Guwjl
	 +0O42gtbPu6WiJtE9NUImP1MGureINfZrY8tCZwmd4j6vQg5RPiKOEL43nxeGUvPCd
	 z+gxti2ZGaOFRluwujZ4yevMRwOqKjzGYAzh5UfYBNXhBZ85LV9FKcnm4/bGQ3GCOv
	 6M8zKMZMOxySyP1zZzG9cK0OUylqO9Xgm2vs2o7Hj89UH4HmEKxNFH9/ATUa9Ez3FK
	 nKEbdPlNYCURw==
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
Subject: [PATCH v1 6/7] perf symbol: Set binary type for JIT map DSOs
Date: Sun,  4 Oct 2026 23:34:10 -0700
Message-ID: <20261005063411.114244-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005063411.114244-1-namhyung@kernel.org>
References: <20261005063411.114244-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The perf-<pid>.map files contain symbol name of JIT functions.
As they don't have the binary data (instructions) no need to try
for dso_data.  Let's set the binary type regardless of the result
of symbol loading so that it can be ignored.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 02b096ccbc60ac2a..389dbd7e5192f4f2 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1859,6 +1859,7 @@ int dso__load(struct dso *dso, struct map *map)
 
 	if (perfmap) {
 		ret = dso__load_perf_map(map_path, dso);
+		dso__set_binary_type(dso, DSO_BINARY_TYPE__JAVA_JIT);
 		dso__set_symtab_type(dso, ret > 0
 				? DSO_BINARY_TYPE__JAVA_JIT
 				: DSO_BINARY_TYPE__NOT_FOUND);
-- 
2.55.0

