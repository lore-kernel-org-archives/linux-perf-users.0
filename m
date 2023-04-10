Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1046CC76196
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Apr 2023 16:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjDJQ0b (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Apr 2023 12:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjDJQ0Y (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Apr 2023 12:26:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D590A1BF2
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Apr 2023 09:26:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 184-20020a2515c1000000b009419f64f6afso6203729ybv.2
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Apr 2023 09:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681143963;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FAKcvnru9LhkR//8Z23t2DNVEpqXFn8ayozPZi4Bsbc=;
        b=ZlxrVPlBY21wSaZW+DAvl8tIqVC9Zo6H8PbzHQaBLlqimhq2OYMcRSxpTkFMKjIntJ
         NLpyQg2qoR08VuuU6TLKhNfr0Vi8XuDSw9b6WcUihXYPlnOADt3M90QDgI1OBzkkNTce
         gJFase72Q/ZB4K2s42u6O/xU1Ey0stnH/eFqKzZ5xhkED/d8wQZ2SxHBrf+hNevH4oKr
         HAfU6UB4BVpW57ZSQ21BLke3U0ohRzoPIHtGzuBepgXeeXktWGKaDaRdB0cE4eQer/Ot
         8/cJX1AzT50llbES/wXAMnv5WoWJiTbGD05fucJnPO8AzYCOCgfIWU3DIfml7FS9hmZB
         QSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681143963;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAKcvnru9LhkR//8Z23t2DNVEpqXFn8ayozPZi4Bsbc=;
        b=O80+Msql80dAkM8PK4x0Ae7ybQDKx/kpeaLiKoXfPKyRGQZvOQxe/Yf03e85i9Q0R0
         Bgkj8iB6Bam7mLjTg0PP59AeztqxDBn8ssuYxGHpkRbOFvz3pTrsye3ZltjhN2SL/7ju
         NzY+r8AZFmSfewu0uZViDS+ToIKhwaVneoEEGtoVlj5OSwMGG3rcS9nkiqnHySekrn9m
         s4+DRWGwc1DRFo+kgv3pqtIqYRXC6ssTBELPoouff7qP1fGLfQs+NVyKs1lwEkzR9EQb
         8IjolbRpsJ9M95DwRYmXI71dAbtP2phBSDy7PBqnRJllYgqS/PnUyjpZgqozxk5Nwe0J
         nd5g==
X-Gm-Message-State: AAQBX9dkW1I+Iem8F8djxnz69gWRezZ/PXyyGVWwJlKtxEZZ/CoXgPd0
        n7+deDCm7FX00N/crUDkrYPqX2If5SkC
X-Google-Smtp-Source: AKy350YhUo6COduyV7IGvsxdXTy/uJRIZ7HQAkSp4QlAlHDO8Gcg9suPG52L1YdLMyG6tq5CZEdWZsPB2R8e
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fc51:6a03:541d:a18d])
 (user=irogers job=sendgmr) by 2002:a25:da56:0:b0:b4a:3896:bc17 with SMTP id
 n83-20020a25da56000000b00b4a3896bc17mr5458791ybf.0.1681143962891; Mon, 10 Apr
 2023 09:26:02 -0700 (PDT)
Date:   Mon, 10 Apr 2023 09:25:09 -0700
In-Reply-To: <20230410162511.3055900-1-irogers@google.com>
Message-Id: <20230410162511.3055900-5-irogers@google.com>
Mime-Version: 1.0
References: <20230410162511.3055900-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v2 4/6] perf version: Use regular verbose flag
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Raul Silvera <rsilvera@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Chengdong Li <chengdongli@tencent.com>,
        Denis Nikitin <denik@chromium.org>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Remove additional version_verbose flag by using the existing verbose
variable.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-version.c | 5 ++---
 tools/perf/perf.c            | 2 +-
 tools/perf/perf.h            | 1 -
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index 4a43043ca8ef..1872c90a6667 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "builtin.h"
 #include "color.h"
+#include "util/debug.h"
 #include "util/header.h"
 #include <tools/config.h>
 #include <stdbool.h>
@@ -8,8 +9,6 @@
 #include <string.h>
 #include <subcmd/parse-options.h>
 
-int version_verbose;
-
 struct version {
 	bool	build_options;
 };
@@ -92,7 +91,7 @@ int cmd_version(int argc, const char **argv)
 
 	printf("perf version %s\n", perf_version_string);
 
-	if (version.build_options || version_verbose == 1)
+	if (version.build_options || verbose > 0)
 		library_status();
 
 	return 0;
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 997bb9ea5ebc..441c354b8304 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -212,7 +212,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 
 		if (!strcmp(cmd, "-vv")) {
 			(*argv)[0] = "version";
-			version_verbose = 1;
+			verbose = 1;
 			break;
 		}
 
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 20e9b93f8a39..989eb17ec474 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -18,5 +18,4 @@ enum perf_affinity {
 	PERF_AFFINITY_MAX
 };
 
-extern int version_verbose;
 #endif
-- 
2.40.0.577.gac1e443424-goog

