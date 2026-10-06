Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0254F7980;
	Tue,  6 Oct 2026 23:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330198; cv=none; b=NCJSZjyNPbloiGLln/HAP0igHhtHWpxmx3zih3PGoWdJpld8MNlM+iEc1y33ciI0HFx1ju3qx/aL7IBpybP6r19t+m89W4UcpehQqO2LiJLIsut6v7lXs3/d4cEqPjYiBVbyhOsGQ9+CgpDvMkxQk96rg6JEDAZF+7qdltEWBg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330198; c=relaxed/simple;
	bh=IV7TAcJQ9U6RZsc65RnIqs5nUIgpKZkm6o+w8wwASm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bAR534sAlUqCzUlTMfJmvGdzlWer8mPieJRqg/Fs/Gxtum2ptJlixcDPBJLiE7ILqIYJYwdfYpzKGUR9n1FK+HpXWnqHh9wPGzVG+GGn9rq1iTaOiLrkb7/c12kzc6H2ClRYItwG6fTeP/f0ebd/OOOlGpS7swZbGgF3KJk/0FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEWPxmJi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEWPxmJi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CF11F008A1;
	Tue,  6 Oct 2026 23:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791330197;
	bh=aQw9+LesQxZvA+9iLaZIcHIemY4k/zSJn3zEoWnBz7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XEWPxmJix7pYgcqvCyAkziPqkHfaRcXTW/PAD6a0vbqSsYe00FEeu6hb9H4t77SMw
	 c+srxCNQb92i6DvSvhTFZbrKJSNnVxTa1zzVPQTsZDkUjPpMO3D8uGpPp//SHaxBm5
	 v7k9GXqiV+bJ0hYf/BHXssbALy9cWRrHmX7MHl7blpacD3reioBgmerKcb3uX0VpwO
	 Mscz3w5lYrOe82nNVNiQE+avtmxkH+5T4Ndw4FTQU2C8kuMnrHlVa21l2V/+Pg5jO7
	 fUrNPdh7bVSBzIBW/9OKuKrBPoCy4Kc7tmWkpW4gtu5+bY0bg8V/k3ab8+TfqpAP7Q
	 YwP5xyTlslMPw==
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
Subject: [PATCH v2 04/10] perf symbol: Set binary/symtab type for split kallsyms
Date: Tue,  6 Oct 2026 16:43:08 -0700
Message-ID: <20261006234315.920817-5-namhyung@kernel.org>
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

When it creates new DSOs for split kallsyms, set the binary and symtab
type to KALLSYMS properly.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index cf099cbd29f268ec..fc6e4dff282bc2dc 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1099,6 +1099,8 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 				return -1;
 
 			dso__set_kernel(ndso, dso__kernel(dso));
+			dso__set_binary_type(ndso, dso__binary_type(dso));
+			dso__set_symtab_type(ndso, dso__symtab_type(dso));
 			dso__set_loaded(ndso);
 
 			curr_map = map__new2(pos->start, ndso);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

