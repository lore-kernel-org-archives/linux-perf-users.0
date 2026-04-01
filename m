Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A275E3B8D6B;
	Wed,  1 Apr 2026 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775080412; cv=none; b=M0uQOs+7OtXA5l/11Ugo23+kmC08TFaFbKW5h/iWu6+z3tsSsSSIO4kDomCxmWQokIvJLq0CV3MQpBOM/0wCFUSmWE9ByNzhHYSGf9X8KhtcAGpCBWObLZF8NhMy/TRxNubnJoOqm9ggHTAJdZi8J6JdH8qKurFroJK1g3iHBoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775080412; c=relaxed/simple;
	bh=M7WB3lYswcr00K1s3YGCL5C4LQ4Aqix/uW2BdTYGXRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1qKwUJFJ197yTAOagzvlVAVdKad4yQsouiiVGces2SvfrnICXOgl4txxSZysT649AeqAt0mPVmJwsho+Ev8P/4eaD/FLcb9oBMcpIJXoVt/D6Zxni87ZKVf5njt327kP/stBNkcCePNKxpGykkAaN2nwlKoDAjZSfyziKeNFIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPX/O6CA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPX/O6CA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346FFC2BCAF;
	Wed,  1 Apr 2026 21:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775080412;
	bh=M7WB3lYswcr00K1s3YGCL5C4LQ4Aqix/uW2BdTYGXRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MPX/O6CAUB69xlozBrYv94yDOKQn94H8y7nPAtXjEyVtJKA0/2AwsyGdEimh5xAPZ
	 6DfhB8SA434ujcW/JmvIcJAADfqaS5h5hc9Se1GaW5TxdwHPjUmwnDRWMtOF5rlbhh
	 uw8ggYJTbbU+Ylxo80aYd0LUeT4fhr4Z4xwQ2Il6DnQD/fjdr1eltuYiV/kmUM/2Bb
	 ax7Qyj6JhxPTvBCF1ScTolkKzoXy7lo207t5YhfDlI0qVaYa1RQMMYkS6aUyuzddR/
	 im1U6srvpX/yKsCZ/GyltMUUUavHUeqYLGbgFYFaJRSFT/TpOZNlLojjYxf3o5Ltie
	 TwlX+bC38MYuw==
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
Date: Wed,  1 Apr 2026 18:53:06 -0300
Message-ID: <20260401215306.2152898-5-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401215306.2152898-1-acme@kernel.org>
References: <20260401215306.2152898-1-acme@kernel.org>
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

