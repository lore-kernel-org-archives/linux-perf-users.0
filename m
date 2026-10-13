Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CC1522F0A;
	Tue, 13 Oct 2026 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912120; cv=none; b=JzvQ0SzehY4e1Za/7lachYySyRPPVILL1Jhv1v2kIeyyFQmADJXnoBBXdwiYT6I7Jx3T5tFr5uE23FREBRnZyZqUaLybClb8Pdwn/Erttj0Dynf6GQY2pD5dGmPZfmSwy9HSXYm8h3BkpeJFPl1nYabApvpB/tffmZ2Q+4mbPUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912120; c=relaxed/simple;
	bh=p+Pb8fAHwkmoljh3Und+iIcTxU+aQN4LTgUgpYnh//o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYO5aWlGTfIIiTC9JY0tkvO1UlMHrsmyscWuRWJP1QWoBit3x+vYwdaoDBA6qRkmhLpxrrfrqfC8oKHDO9uWjvt4L0N3ES0Sh7seN/VzUaFXm4Js6jupvwzge7kaGZknrcJ91SEJ089W9yUlzVY0fdpjYAOXTSywyDNCjN9ZvHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5waaEVw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5waaEVw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308F11F00893;
	Tue, 13 Oct 2026 17:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912119;
	bh=8fU7Am2k4MqueJWHnJoiEzbFd5eIycgw26L/ffNjQJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X5waaEVw1hhf8j+Lh93cCUk0D0cJTvlVdFqJVcZAIWpyNgY+Shr3GuX4xJS5ekyG4
	 K8B+oBg00Asf4R8MJ1Lyt5oVp/hw9p2TRiha0y+dIUTzeK/PAbPvNlOlJx3Hc+Xj7C
	 YGRivoF9+7vetIT0ZVtzYgaO9YUln4PORC10ETGiA6xPO5L/r+W4T0jIdHhKzGWKCZ
	 d0XEC/9oitI3s8OvBzpuPY5+ncSOBKxfkv9yzm8H7sSMSYUeINtkl06P1jB8ZrCjmh
	 7GsSXg5Q45eS/tpsTD8oxWTuXsq4OlZkaucfbOAbzv0rJ9WrXjqsu3ZfLhM+mzoDry
	 SPFYrqNIkbZ6g==
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
Subject: [PATCH v5 05/11] perf symbol: Set binary/symtab type for split kallsyms
Date: Tue, 13 Oct 2026 10:21:49 -0700
Message-ID: <20261013172155.160869-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013172155.160869-1-namhyung@kernel.org>
References: <20261013172155.160869-1-namhyung@kernel.org>
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

