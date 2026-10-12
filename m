Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB4E3E639D;
	Mon, 12 Oct 2026 23:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848820; cv=none; b=tSDVeosoYOK30RD4KB+FfYeCnOoXiV87RswIyPleZkYAFzKdDZAXseE2Cu4aTuUXlJYOny+JVt8039YlgvsKLqsugpY+fMgyQpRkq03lFXi51314+D8/3CI7I0zrk/U5tG41LJQTZqM6OW2Oiiyi0fHp/+vLV0wDB+IMx190eJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848820; c=relaxed/simple;
	bh=p+Pb8fAHwkmoljh3Und+iIcTxU+aQN4LTgUgpYnh//o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwW6xNws7pDKFBXf9aXy/+g5bMXaP2HYf8/ErDc7EUIfVvNE7l3e7Mm2jXxZZlIo/vwqvHLU7HKkJUuteyfJvlUk3e4wYnABDjascxdWDvmUvZU9xXMkfbKeBwHK0lE8YdayNidg1i+qGiSJzUTFcAFMdfPTbq2RjxaHFT8DFEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8iOCqzC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8iOCqzC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0B51F008A6;
	Mon, 12 Oct 2026 23:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848819;
	bh=8fU7Am2k4MqueJWHnJoiEzbFd5eIycgw26L/ffNjQJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j8iOCqzCZ/K0NAoV45raNHwfASjaAZU+7MXXQkFGQVuOmPD/+Z2Gozs+PaJz4+2OA
	 RdNYO9DOivEJdK6k4fKjHX+FG2M6T4a2bm6tj/zGlnzTHacM+RHxpByHy24ip0EPEP
	 PM50+UdBWKkRE7U6UIWTxMoKWKBU2/Bmrb5COB0kaS3fsCwNJ/f9tdovMu0hMxn03y
	 227pM5ohWd4dIcXuf4rhpJGP7N7E/OuNdTYOM2FiXss6rIjWXFM1n976yu99X8Y5hf
	 pTaMfSylNjVoB2XEvmJqCJj8mb84N4LDeq28yG4rM6KNCfN16YtpamwsUiY4zzLOPD
	 6ltL5PsR7K0Gw==
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
Subject: [PATCH v4 04/10] perf symbol: Set binary/symtab type for split kallsyms
Date: Mon, 12 Oct 2026 16:46:48 -0700
Message-ID: <20261012234654.60666-5-namhyung@kernel.org>
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

When it creates new DSOs for split kallsyms, set the binary and symtab
type to KALLSYMS properly.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index cf099cbd29f268ec..56b8d75966133f87 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1099,6 +1099,13 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 				return -1;
 
 			dso__set_kernel(ndso, dso__kernel(dso));
+			if (dso__kernel(dso) == DSO_SPACE__KERNEL_GUEST) {
+				dso__set_binary_type(ndso, DSO_BINARY_TYPE__GUEST_KALLSYMS);
+				dso__set_symtab_type(ndso, DSO_BINARY_TYPE__GUEST_KALLSYMS);
+			} else {
+				dso__set_binary_type(ndso, DSO_BINARY_TYPE__KALLSYMS);
+				dso__set_symtab_type(ndso, DSO_BINARY_TYPE__KALLSYMS);
+			}
 			dso__set_loaded(ndso);
 
 			curr_map = map__new2(pos->start, ndso);
-- 
2.56.0.385.gd3acb90ef8-goog

