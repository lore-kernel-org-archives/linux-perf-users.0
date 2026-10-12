Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DFD3EFFDB;
	Mon, 12 Oct 2026 23:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848821; cv=none; b=mtIPLCGcNI4qS7ScmsbgHTRfwADNaXQhDMIAfZeieMUyIfYuyYN6qs6T7w6vamfEsS633L1ZN86WbG2LLRziNxX2ROxV6fVy593Wwz594kRx2FmKhlCoVoOcOFdIgWqu1x5G4FtSxKkvRf3xHcfbLLvh4FyilSoRAUOxJNU4N48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848821; c=relaxed/simple;
	bh=ud4WWh8RUuNJmjMxj9NMd03ppEn0qDJz9Tqkf06RD0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hA+Byvk2Ttmr0pIoNFWCTGW+Zwroz9TfOJpsozPCbR7zjczPWn3h6jzBUYAtCg/8HQqM69iracaZv0e6RzNlDFdW1jr6aLcocs2/ugOAIdakCHPmBrkFFFC+slouV3CzOPBs8IxO8kdp34OuaqJnTmJqX6NQlpf9q7/d1JzAK1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MprotaMv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MprotaMv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673211F008A2;
	Mon, 12 Oct 2026 23:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848820;
	bh=nlNWeB+9FkyeYzISPfZxDiG41XzV77zEy8rHeT2l9uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MprotaMvEeSC5NnP0wu5tSbVi3KMx+Vxe4m89GEe/+Csdrzl8ch4ZLGg10dlULVtW
	 81XlUl26WAu0BYHYoRXlT7D3wP1IiGTfocFY7YHE0TJ3LLXBnsF996SZ/m2MOCEpmg
	 z84RenHpziNoAVteq6nVcyP2Xctw8TggCmHRtw+hQVEJlY2uV1sEg6152GuboMRW+H
	 y/nM9QMh9Nf1SVwjUa9sO3N3H/bkaiuqFa8x8K442qZDNgx2/FGDvJjX50J/jqxYuV
	 SmRzcd6Ss0GpLAT4xBtBRouAq9ocB+M8XOI7Iik0hPkk2Z99Rk1d3hZc/meSYUE/Np
	 jUfEUjg+qz7rw==
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
Subject: [PATCH v4 07/10] perf symbol: Set binary type for JIT map DSOs
Date: Mon, 12 Oct 2026 16:46:51 -0700
Message-ID: <20261012234654.60666-8-namhyung@kernel.org>
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

The perf-<pid>.map files contain symbol name of JIT functions.
As they don't have the binary data (instructions) no need to try
for dso_data.  Let's set the binary type regardless of the result
of symbol loading so that it can be ignored.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a7afecb5816c25f8..4a8c298039447cec 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1847,6 +1847,7 @@ int dso__load(struct dso *dso, struct map *map)
 
 	if (perfmap) {
 		ret = dso__load_perf_map(map_path, dso);
+		dso__set_binary_type(dso, DSO_BINARY_TYPE__JAVA_JIT);
 		dso__set_symtab_type(dso, ret > 0
 				? DSO_BINARY_TYPE__JAVA_JIT
 				: DSO_BINARY_TYPE__NOT_FOUND);
-- 
2.56.0.385.gd3acb90ef8-goog

