Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A1AC6FD1D
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Mar 2023 01:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjC1BmA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 27 Mar 2023 21:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjC1Bl4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Mar 2023 21:41:56 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77542101
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Mar 2023 18:41:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5425c04765dso104524917b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Mar 2023 18:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679967707;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2whu1qno1W8kHsCGkEHqnVJzukiPVbxiNAF9c06UxCw=;
        b=dzIAs3yWxD9SpgkK4CCF49PQD8Zw4LTXKF4G+QesWtXDq5wdN44G9UzTYlL7lEjRUt
         FcZaUmeLeh7UdjPykT4b0MCcZWMp+4dWk8y6AS0Gn61MYeW8uTdDc+9HNNM9YhCrG5k6
         z6lEGiunAyGIVoM36gsdf2Yfsbz1wfwp6gQ+CxC6UQkSN/Wuo2SmJTmURn2Vq0DrDzLi
         Xe5yXFnEpGBnoW0+NU+2i+qZHCVlfrGiWuZwvSzM/qd8fBjvIuNs2qMLEBelBE1DxeVr
         Y8DyyJ5QWcOWHpDdVAlL7zpzsoX/2tPUoVDox+4rTAZBisx51TTtDUPATsagqJY4zrea
         w/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679967707;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2whu1qno1W8kHsCGkEHqnVJzukiPVbxiNAF9c06UxCw=;
        b=g4sP+oMjiuOmZ9/+6IYSZbj978zjUX6kXK6XX8+igSrQ5OV0IZOJrHstoLylS4lw/Z
         hqWF32WAECmL5tiIIH7ohIlmMRVcKRqsBRIZBiI91WTG2Zp/plEUmpT9M/20SYgX6g9Y
         FwcRWA7tjL0HtIs3mUSaz//nZY+VpcXgGeN0HPrXTlMihE9PUtdkPwmOrp098tYELCSZ
         eLjeHpH3fH7XAyMss7dBBwzBsSeVQ0KbqRYJopSPlIv2Mv7fPULjChqEv27zQDwgB3Kn
         cQ5w9QXCKH42alHmRJQ/bp5F9z48XRCWukv2m2RQS0pWvS9mJ2trdK/96oZAK7ZhqsY/
         wuYQ==
X-Gm-Message-State: AAQBX9cvhkJELizohmuMFYaBbHwBPWkorXZXL2zad3jr0HrVPBV111cY
        8YLZZYh2I06aqzM/2p6EgTYk4Gn0u8yX
X-Google-Smtp-Source: AKy350b1a/nh466GprtSUGyffhrOZ45C91uTo++lFce4psNXjIgoG3WvpR2OPr4gdCSrV/EcpF7e2bsmn/jG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a544:20a5:5228:d98f])
 (user=irogers job=sendgmr) by 2002:a05:6902:1245:b0:b77:d2db:5fa4 with SMTP
 id t5-20020a056902124500b00b77d2db5fa4mr8546242ybu.8.1679967707068; Mon, 27
 Mar 2023 18:41:47 -0700 (PDT)
Date:   Mon, 27 Mar 2023 18:40:56 -0700
In-Reply-To: <20230328014058.870413-1-irogers@google.com>
Message-Id: <20230328014058.870413-5-irogers@google.com>
Mime-Version: 1.0
References: <20230328014058.870413-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 4/6] perf version: Use regular verbose flag
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
2.40.0.348.gf938b09366-goog

