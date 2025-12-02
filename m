Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED73302177;
	Tue,  2 Dec 2025 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764663408; cv=none; b=Qp9btFid6RsXAYzktQllYYkqhXqulHViW/CC5s0+pVyQ+dZlTYNjHUy4Jfm/yFIFwcAFqv0JKIunREp/ug92G8dpq4D+l4ZNWEs8zoHvF1kRRm4EVenJSRRmyTot8TAxU8GpAjmfpdOSuSf2Mkpt8wA86WCRyxFQABZBp4BGlNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764663408; c=relaxed/simple;
	bh=6AHEiPJOEAyaqlW9GQvpF6pPbppvNp0fzLe1GEZEqfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XR6IlSn4eCipN3UWHuQZPM4XITqLgHRN5UO6fCLqG2+CPBiVq5iYbhz3d2U5qbU2XVuSx6Mmv5Sgn/AwprlzmrCaQrfQkvQtz5fFoQXRpKyCwgtCfN899GGpf+QjGVL3YUungBtGzEhI6F5cTbZByJaCdrY/NjpP9u6yWY1x+SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zls31T/N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zls31T/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015B4C19424;
	Tue,  2 Dec 2025 08:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764663408;
	bh=6AHEiPJOEAyaqlW9GQvpF6pPbppvNp0fzLe1GEZEqfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zls31T/NVzmjBzBSl0KjoxmgO2f2TyAKP0m8n9xfVzMtu9Lk5Nm2L7oI7LpzS1VJd
	 dTOF8JLAG9AgbIYO+9FI3wz4d019QgoIPsT7u7l7VImiYlAf4uaJyAqCwgYBnSAQ/3
	 ceLMGLP/wpDqixut3fBXruXolITLV/MHi5GKA93TiN/S/+7dpSHD06WSpfRTV4ayRD
	 o2N6rhxtoK3TuZL8iz85rvaoPHPHYftnVV5Ryp/gsWN06SRixeBiKmOyoOgmfBMZKz
	 vDWtcE2dZTscQOBtCU2bgyp6Nvwspi+0Hq4QuPYKlu6ykHjAzH3hX324XLqO1vPQAN
	 w/uHYxcqdWCyg==
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
Subject: [PATCH 4/5] perf tools: Use machine->root_dir to find /proc/kallsyms
Date: Tue,  2 Dec 2025 00:16:44 -0800
Message-ID: <20251202081645.931527-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
In-Reply-To: <20251202081645.931527-1-namhyung@kernel.org>
References: <20251202081645.931527-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is for test functions to find the kallsyms correctly.  It can find
the machine from the kernel maps and use its root_dir.  This is helpful
to setup fake /proc directory for testing.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b533fbf17a8b19a3..e90ecfd286043aa4 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2002,6 +2002,7 @@ static char *dso__find_kallsyms(struct dso *dso, struct map *map)
 	char sbuild_id[SBUILD_ID_SIZE];
 	bool is_host = false;
 	char path[PATH_MAX];
+	struct kmap *kmap = map__kmap(map);
 
 	if (!dso__has_build_id(dso)) {
 		/*
@@ -2038,8 +2039,13 @@ static char *dso__find_kallsyms(struct dso *dso, struct map *map)
 		return strdup(path);
 
 	/* Use current /proc/kallsyms if possible */
-	if (is_host) {
 proc_kallsyms:
+	if (kmap && kmap->kmaps) {
+		struct machine *machine = maps__machine(kmap->kmaps);
+
+		scnprintf(path, sizeof(path), "%s/proc/kallsyms", machine->root_dir);
+		return strdup(path);
+	} else if (is_host) {
 		return strdup("/proc/kallsyms");
 	}
 
-- 
2.52.0.158.g65b55ccf14-goog

