Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B081D326D6A;
	Tue,  2 Dec 2025 23:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764719846; cv=none; b=XvyXyCUs0Cazgqcr60RHjs6PoV7q3X8CP8MZjXuaAaHdMlMtanKk7q57hfliCt6pq5ksx7pqWBhxOVOaDj/+sSD5bRQKbMOhGMTwRd1RtBU2bgamC6QYvABmmDa+kPHQIAdZN7GpQfwhK6G1KUZxu9xa96nHdKtcXcyL1NcOHXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764719846; c=relaxed/simple;
	bh=yKYggOYyM1s/vjYzdis17U8F2v/NZUGNksTBzefvIWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W485Ba+QtgMZDMJQlo+qltJJX+XdiKosvk8Uzq9fWWga11C1TmUlbOFBp0/Yc6ZA+/SI3Qz2Rc1IECWyfwfO9m/dil1jRvQrcs0JiKxo99OIvzoDVlXYCpiZZjkPKLJGKAZf3eh561Mg2kDx4Sjs5ChNr58xdORTH5Xi7IBtEAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyV0vACd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyV0vACd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8BDC4CEF1;
	Tue,  2 Dec 2025 23:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764719846;
	bh=yKYggOYyM1s/vjYzdis17U8F2v/NZUGNksTBzefvIWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TyV0vACdkrz/6x92CUtA71Uzc5R13qiYDeoej3AB8wzTAVJznOwwuIxz+lrEVTJ37
	 3PueO/V5sg39b74fAfkwttsMd+kyWhAhtwvy+kNQdGzK7v7+dlR+Es2/oTK4inLgae
	 viCaHD7Z4RIFGIedl5M9y2469q1bHkZG65dkpYyXO9yJkPs/neG6mOey9+0c71e2nc
	 tlOZlhYADSrrjKSBrcpru8zJW9iU+yfrGkGTNQRNYrtm1aBGj+NnGt/LPAslKTU/PK
	 dnH3qHNVUNi1Kg9suAXHLx8ruunI9BMb2yRCnVKS3KmdexkfL/VA4E1AhSRgBv9USF
	 oZpQPPyhoFO6w==
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
Subject: [PATCH v2 4/5] perf tools: Use machine->root_dir to find /proc/kallsyms
Date: Tue,  2 Dec 2025 15:57:17 -0800
Message-ID: <20251202235718.1018752-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
In-Reply-To: <20251202235718.1018752-1-namhyung@kernel.org>
References: <20251202235718.1018752-1-namhyung@kernel.org>
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

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b533fbf17a8b19a3..6ddbf4427c60dace 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2002,6 +2002,7 @@ static char *dso__find_kallsyms(struct dso *dso, struct map *map)
 	char sbuild_id[SBUILD_ID_SIZE];
 	bool is_host = false;
 	char path[PATH_MAX];
+	struct maps *kmaps = map__kmaps(map);
 
 	if (!dso__has_build_id(dso)) {
 		/*
@@ -2038,8 +2039,13 @@ static char *dso__find_kallsyms(struct dso *dso, struct map *map)
 		return strdup(path);
 
 	/* Use current /proc/kallsyms if possible */
-	if (is_host) {
 proc_kallsyms:
+	if (kmaps) {
+		struct machine *machine = maps__machine(kmaps);
+
+		scnprintf(path, sizeof(path), "%s/proc/kallsyms", machine->root_dir);
+		return strdup(path);
+	} else if (is_host) {
 		return strdup("/proc/kallsyms");
 	}
 
-- 
2.52.0.158.g65b55ccf14-goog

