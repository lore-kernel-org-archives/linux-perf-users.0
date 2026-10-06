Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99A94FC8C7;
	Tue,  6 Oct 2026 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330200; cv=none; b=KoVVKd0gT1YLFh3dg7LK2ztVjk390EcwIHsIEp/a/JCje870O8nCABVEaSvmVktK1R6adNIr7ftH/LOVOXsGFXT3y+DutIJxcWRo74HS8tjKOZ9NpqRhGdz2+bH2QGyHPRZ8Dg8vXt9aZvOJzT1w4jIazOCcvZIxFAmkPH6D8pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330200; c=relaxed/simple;
	bh=FNnCSJ7G5veRwJeZR/6jqs4iDxb+YZfoTwhq9Bqi4r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fknAky9ZcTazMp0eAG6PwEGLRTszltaFXFK3nX1q6ZgUvFEkG6Owf7Et1nbxjs4jNUgyc8zb61isn1RVeVFK4hi7gCOWnogFvswxBPXnYZig0EXOgI7iqx6ccUA2vyQVQfhGaTx3SWm+sgRTJ8Y162csJx4wnfIdDRiYH5R+0lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvTmRsbk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvTmRsbk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913191F008A0;
	Tue,  6 Oct 2026 23:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791330198;
	bh=OH8h5TlC66/ZGKebQqOfl+seUgHHGZvhxM9ycBQQmwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jvTmRsbka3BctNCmqKnERACqMnn9Lv4i8RK8OlTa+x1hJfwSlYAfVenhyqwNx1uL7
	 x/+PlVdEyuly+omsALAIRQ17BlozjGAWKrTZqyFXNDeqvHDqUiibuzWwpbFECs8LhM
	 iXWJv2YId0yXuQFIF8fHed3HMf8Eq7iyd7OC77nhrYfNTmWX1Sb+GSzf1BqlrN3jMf
	 KzdJHkv2cAYh6jtiywSszl9BD44HoPjzeDX3Dova9sHSNff3aJzlC9Ak9WyChC5yLG
	 HAEqwJQcZHy7SrApveAXU3bBiL6atSH+wy4Dqe44kcDz11snjHrFXtkURIoPw0qHJw
	 /WqPJw1IL8f7A==
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
Subject: [PATCH v2 07/10] perf symbol: Set binary type for JIT map DSOs
Date: Tue,  6 Oct 2026 16:43:11 -0700
Message-ID: <20261006234315.920817-8-namhyung@kernel.org>
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
2.56.0.rc1.315.gc6ed9934b7-goog

