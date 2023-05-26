Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ADAC77B73
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 May 2023 21:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244277AbjEZV4T (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 May 2023 17:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244289AbjEZVzy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 May 2023 17:55:54 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CDB10D4
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 14:55:27 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565ba5667d5so16860167b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 14:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685138105; x=1687730105;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o9BuxLyiQzY2TC1wkUXo7pk2ilQpQDkXjoqwEb1YJT0=;
        b=W4bgolXSBG/aM6AAMIrVWP8PxrTIfod6JPer3GBXCt/gN9PGx6HtMZdQ92CeOZsa0h
         zto7T/TZcJU13XvCS1fJ3zC6gCHGwi9hu2T0yxjiibFt6RECA9r3Sm8v5SJXfJBG97Ob
         BCsF752HlXeNrbkdvQt7a8CLZpmFgZXROjXeJJRreDjpnMem33Z1uV3WQBI/0HLWTR0j
         GXD8vnRftGkrCiB7DlrqDFo03fWiwGOSSE44isOVGB3aRZH9yf0ugO+Rc6OTMgAYVbr6
         5W83aTlVpMuuuAGLVnulvKdPmZ2MZOn6osFHjw3ZjUJYvdKSndmvenGnm6z4+pzlL2PS
         1drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138105; x=1687730105;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o9BuxLyiQzY2TC1wkUXo7pk2ilQpQDkXjoqwEb1YJT0=;
        b=a+yemGNEjEvDAQTReauOJFLo/iGwVmMr39jQj0+yWla3TEY69T3VVLZHchBXIxrVwm
         14HINAfSHH6u029IlTkegqVmnlHacYEOe43petiFVkv2wc6IPrE+VTFX/AzLuNQEfaFj
         dJfWEe9gvYWVGWtR7RaiwBWoo2MzXaQi1tTJrqkWKjbP3pCNo7na5cPKZ24PKUWBPoSZ
         ADEqzgcTxyTe10/zUIDd6yzJjVkMfuzuUSMi2VbegiWNqwQzhkwkgXoqUpCEqyn/MbI6
         hbGugrjAhvlAjv+Zkb9CBjUX3KcZ0X3SbPiQXSdw4MG938MS53Mnri1itOUAk1I3Jw90
         Jn2w==
X-Gm-Message-State: AC+VfDxDTcfze354TDkiD9ZljfB5J2jpxQB2w0Xmgfv8qd4KSCv+xJCA
        dXDrTV0belQ6kJgEp1R9YrgUfs2F0LFe
X-Google-Smtp-Source: ACHHUZ53ZLD5rWItTLlXnBT5M5rNiiWHb6EfXc4TAHoG/yypTknS6qdXXrehh+0oWJXgSwo1bZOSR4eZx8H7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:d20d:0:b0:561:8fc0:24af with SMTP id
 x13-20020a81d20d000000b005618fc024afmr1776134ywi.9.1685138105639; Fri, 26 May
 2023 14:55:05 -0700 (PDT)
Date:   Fri, 26 May 2023 14:53:58 -0700
In-Reply-To: <20230526215410.2435674-1-irogers@google.com>
Message-Id: <20230526215410.2435674-24-irogers@google.com>
Mime-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v4 23/35] perf stat: Avoid hybrid PMU list
From:   Ian Rogers <irogers@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf_pmu__is_hybrid implicitly uses the hybrid PMU list. Instead
return false if hybrid isn't present, if it is then see if any evsel's
PMUs are core.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/stat-display.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ede0477d958a..78ce7095dbcb 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -19,7 +19,7 @@
 #include <api/fs/fs.h>
 #include "util.h"
 #include "iostat.h"
-#include "pmu-hybrid.h"
+#include "pmu.h"
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
@@ -680,11 +680,12 @@ static bool evlist__has_hybrid(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
+	if (!perf_pmu__has_hybrid())
+		return false;
+
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->pmu_name &&
-		    perf_pmu__is_hybrid(evsel->pmu_name)) {
+		if (evsel->core.is_pmu_core)
 			return true;
-		}
 	}
 
 	return false;
-- 
2.41.0.rc0.172.g3f132b7071-goog

