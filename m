Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865783B8BDF;
	Wed,  1 Apr 2026 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077371; cv=none; b=mpNslfZuJJnwUgcnfEAN5X2QJg3Tzst2am3IFc3rigNYik6rvbY8RhxlxIbT0E02sQUzbjb5xh/u2E1fW5tFHWMPSOsgjU+H0xasXpo+BMWhpfTxROx8XslkZiD1eXHA48IkOFl8BGUSjkwnzjtiNVmf52th1I8s1jZgT5ER+zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077371; c=relaxed/simple;
	bh=CuUtIO1rDjW0LE6z+LGQvioLzwgJwbqfuhlQJtlycFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXkQVu73I8t4wwNomAZ52KJaNUQp/HBpTUhHt+NNM1Lb7TyEHinHPHn3A4DQPJOanAywkyi+tAGeHLXfXuTbaEe5U07hGm3+qfpUzqBXHgmisAgD+KzTxEDo502D33vOcMqkilzkwZ+vm0pRe8YQ1rNTI51zzkYGJT/GwP7QkZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qzr2gxlv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qzr2gxlv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3776C4CEF7;
	Wed,  1 Apr 2026 21:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775077371;
	bh=CuUtIO1rDjW0LE6z+LGQvioLzwgJwbqfuhlQJtlycFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qzr2gxlvq/IG6J4csm7mDPOqK8VYeNfPUJw5qZ6xBNBjIwpjdUFKwHHNiV64VKw9I
	 yQ2wXeBOlNP6JGEWj/KTuuEOAlVwtZrNmpaPppggeOG0HTIEpQs3sk+LP6Yw1qA0JR
	 +DPnfUbno6Kd4zH3BOA2PeY3hG4Jgf5q96lcEF5b1fTozytdsSmp71HFJWVgKsVrxU
	 x3/Mv/sthUjdXlyFtxZi3Hy8WGEH8Atr7mMlNArfpK6dk9C0JiMWcJHcQC4p/INmA1
	 tiSavM44uan7/ZovV2hKzlnApdAKvRm1JCxCSLTaHwWwQw1dIxPtxdU8jD6TwIgXAT
	 sFh1DCOEBDjog==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4/4] perf symbol: Add missing libgen.h include to get basename() prototype
Date: Wed,  1 Apr 2026 18:02:03 -0300
Message-ID: <20260401210203.2150651-7-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401210203.2150651-1-acme@kernel.org>
References: <20260401210203.2150651-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This works in some places because there are tricks to prefer a GNU
version instead of the XPG version, but started breaking in some musl
libc systems due to some unrelated change that made libgen.h stop being
included by chance.

Since symbol.h is using basename(), make it include libgen.h.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/make    | 2 +-
 tools/perf/util/symbol.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 6587dc326d1b272e..e12ff6397077806e 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -148,7 +148,7 @@ run += make_extra_tests
 run += make_no_jevents
 run += make_jevents_all
 run += make_no_bpf_skel
-run += make_gen_vmlinux_h
+#run += make_gen_vmlinux_h
 run += make_libperl
 run += make_no_libpython
 run += make_no_scripts
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index c67814d6d6d6f64a..b37ecc2e90f77efe 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -10,6 +10,7 @@
 #include <linux/rbtree.h>
 #include <stdio.h>
 #include <errno.h>
+#include <libgen.h>
 #include "addr_location.h"
 #include "path.h"
 #include "symbol_conf.h"
-- 
2.53.0

