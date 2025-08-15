Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9851330E0E0;
	Fri, 15 Aug 2025 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276084; cv=none; b=vC+VITfKItpxt0CgBeRkKEvCUE5hxX37cm+910MIk5xZdSEwp4qbXUa4EoHFEspI3i1+mSjhgfxn7eufUZ1VU6ragx+ClVw3acV9NUJmvxJzqoR8Av5103uwxp5zL9UJxk+Gn7+mF9DH24TcXgeMVoDh9ZXxpZTGZw9WI04bXl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276084; c=relaxed/simple;
	bh=G2+P3O6+HLhnBVQKWNhl2UUxxMGZ0VVsYc3ID5h45Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DDA/kdozqp7PN9wCapp3ZZEQoO9o6qvDG61H+6WxHQ/cqQtL8KHPdgW7NIIXsVJDW8LSiY9C2m2E2bEOgl96SbFsJlWUsCrvq7fwh5JBWMci9MnKjawfPvsKDc6uiq4qZ+PE67A1x5SqWd00Y0m+hkNxppC9MvDqRPQTPfj0rbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDiV3e+t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDiV3e+t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F3BC4CEEB;
	Fri, 15 Aug 2025 16:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755276084;
	bh=G2+P3O6+HLhnBVQKWNhl2UUxxMGZ0VVsYc3ID5h45Iw=;
	h=From:To:Cc:Subject:Date:From;
	b=lDiV3e+tdZFs6/MLz3byswVkxq0TaLGXDks3m5jgdNg6nlNdwKdFutbKfeFI0wDJC
	 Aephdy6X2FPnZXa9vkFCQxTfK32MrghDPXs64FLU46tyFIR9SnrSyEVWO37NEFjsX2
	 OVh6HKlWyYmnTYjrWCrAq2E0b0SfQB32ItqbSQ/BlwsoZULbeETibXCzDXFiRk4NeP
	 ZdkIlM5VEExmBLpCGPx+IiXzrFJMiOwsLU9mpTK4eDn6Q7wUXDX8mRzdjUBxquIRb7
	 BW8eCobPrJKqN4JZKfxwJK/pYffcZffDdslrCPD58owRDT8rQ/OYF1p+oYNO0f2+2W
	 SqVGryGW8gsfw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH for-v6.17] perf test: Fix a build error in x86 topdown test
Date: Fri, 15 Aug 2025 09:41:22 -0700
Message-ID: <20250815164122.289651-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's an environment that caused the following build error.  Include
"debug.h" (under util directory) to fix it.

  arch/x86/tests/topdown.c: In function 'event_cb':
  arch/x86/tests/topdown.c:53:25: error: implicit declaration of function 'pr_debug'
                                         [-Werror=implicit-function-declaration]
     53 |                         pr_debug("Broken topdown information for '%s'\n", evsel__name(evsel));
        |                         ^~~~~~~~
  cc1: all warnings being treated as errors

Fixes: 5b546de9cc177936 ("perf topdown: Use attribute to see an event is a topdown metic or slots")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/x86/tests/topdown.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/tests/topdown.c
index 8d0ea7a4bbc1cd46..1eba3b4594ef2ba9 100644
--- a/tools/perf/arch/x86/tests/topdown.c
+++ b/tools/perf/arch/x86/tests/topdown.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "arch-tests.h"
 #include "../util/topdown.h"
+#include "debug.h"
 #include "evlist.h"
 #include "parse-events.h"
 #include "pmu.h"
-- 
2.51.0.rc1.163.g2494970778-goog

