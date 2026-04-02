Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78071A6813;
	Thu,  2 Apr 2026 00:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775089225; cv=none; b=kTtuzhb68bD4s7xrnFfL4Um8uoo8bmd3yff4SHoMjF+Ty/hzSQO0k0hUaYln+YoIqfol7PrMgcTGpcXkvRMirf4Ju/ExKryShQ7GH1qnE9KbMzLAPuiI+xWD8kNyfRvFurJ3NSfobfu+uEWt2vQ7LczYRFBCb+LnGDpt4lJTwBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775089225; c=relaxed/simple;
	bh=M7WB3lYswcr00K1s3YGCL5C4LQ4Aqix/uW2BdTYGXRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oatsCH+z/+K1RcW2by4z/v3+lR8KQIV1h3SIXpFR37ep3tEEcQdOzAX8Wo8j3O4WrhrucMnDvp7cTOe3dT12TbT2419OOmMV7LJ0CUJuVEwzyc9+bhBERfsJhEMCB9trmMuJxLxXn8yECuAOZCT9/oTwbE2hLLeRminJ614/L3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CI6+9AtS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CI6+9AtS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20F2C2BCB0;
	Thu,  2 Apr 2026 00:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775089223;
	bh=M7WB3lYswcr00K1s3YGCL5C4LQ4Aqix/uW2BdTYGXRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CI6+9AtSy+HLeTslb5xw2juV04C4Vf2pdpfc/HjxK9g7YXwF76pY3nHrvaz1hhiDC
	 kTvC79W1m1iilLxiQmj5ZE8cG+JQprIscq7GRX1FBxIeWkTXlEDRZzXdVLMNKTAB1S
	 18GF9fUPkXuifnnItfZb8hRvwPYHqH/3oOQfusBL82qA86y59nK9wR6et+//57IEgo
	 9ewWz0230zE/TvVCcTcG+ZBFfUpmmKlEqUzROWPKiZqpe3TcNBVeelnzmYlYoI8PCb
	 ZuEwe9A30Ugn0R6EzSkCyesBfJLrvLbhAIr+TrcSwQAh4z3inMawa4issvP9f0X32b
	 7HLaoWN85xPmw==
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
Date: Wed,  1 Apr 2026 21:17:40 -0300
Message-ID: <20260402001740.2220481-5-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402001740.2220481-1-acme@kernel.org>
References: <20260402001740.2220481-1-acme@kernel.org>
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
 tools/perf/util/symbol.h | 1 +
 1 file changed, 1 insertion(+)

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

