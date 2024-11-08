Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3D4194A68;
	Fri,  8 Nov 2024 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731076480; cv=none; b=NjazdfeiHE1UYprDw7p/+g5zN7/z1MiTTgARTk09SjXbKZdeI9TIKUOn9jrvDzqzgFpB1B6Y20JY6zbdYJor7A86TJUzwXwFh9/EHHQmYOaqP7ucxoMsLbepwQlW8OlvQqPCID7oVKUzFH+6yEDirvrWMxTtCafwWikt7zPnb5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731076480; c=relaxed/simple;
	bh=sER8uS3cEhrQnHwrYeJviAnvwCWZIrpRSpQg2JvNrEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bY3xPZKUIroRpg8KkOOBcXzg3YVcy6OXcHoSCotava6jceBZUcD0pK6dZe+k51sNiF4CoSH1rc2FJl38PKMInp2zU/LsKI+bMISXpi45pgqVKJ2ona6tH+fxKcszxbgkqaQ6ZIGqQ9FsE2ryjy6lIjYZKBsXvRXX2VJKbB/S/h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1ABAE339;
	Fri,  8 Nov 2024 06:35:08 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E82403F528;
	Fri,  8 Nov 2024 06:34:36 -0800 (PST)
From: Levi Yun <yeoreum.yun@arm.com>
To: namhyung@kernel.org,
	mark.rutland@arm.com,
	irogers@google.com,
	james.clark2@arm.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nd@arm.com,
	Levi Yun <yeoreum.yun@arm.com>
Subject: [PATCH 1/1] perf/util: initialize is_test value in expr__ctx_new()
Date: Fri,  8 Nov 2024 14:34:25 +0000
Message-Id: <20241108143424.819126-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

when expr_parse_ctx is allocated by expr_ctx_new(),
expr_scanner_ctx->is_test isn't initialize, so it has garbage value.
this can affects the result of expr__parse() return when it parses
non-exist event literal according to garbage value.

use calloc instead of malloc in expr_ctx_new() to fix this.

Fixes: 3340a08354ac ("perf pmu-events: Fix testing with JEVENTS_ARCH=all")
Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
---
 tools/perf/util/expr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 5e3732bc2fa5..bc119501f091 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -285,7 +285,7 @@ struct expr_parse_ctx *expr__ctx_new(void)
 {
 	struct expr_parse_ctx *ctx;

-	ctx = malloc(sizeof(struct expr_parse_ctx));
+	ctx = calloc(1, sizeof(struct expr_parse_ctx));
 	if (!ctx)
 		return NULL;

@@ -294,9 +294,6 @@ struct expr_parse_ctx *expr__ctx_new(void)
 		free(ctx);
 		return NULL;
 	}
-	ctx->sctx.user_requested_cpu_list = NULL;
-	ctx->sctx.runtime = 0;
-	ctx->sctx.system_wide = false;

 	return ctx;
 }
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

