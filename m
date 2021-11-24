Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB994C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Nov 2021 00:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240598AbhKXAPq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Nov 2021 19:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240589AbhKXAPp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Nov 2021 19:15:45 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC80DC061574
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Nov 2021 16:12:36 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id l14-20020a170903120e00b00143cc292bc3so238891plh.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Nov 2021 16:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yN9AxgVhP403euh96vyR/P6B46ndFdybNrT4U7XWKGA=;
        b=O9McHgH/Odph1UfwBgVrusQu4D4wnX0ek4cbT2T05joLVmnA9D62D9n+LmfYeEb5/Z
         FYICZZWKu72FKhzHlImtfy4+Vz05Bda+Mq2y7IgUgzfuAWOWwG2h9fyouPPxKiw71Tai
         6pMC42SYZW3JLNKU9PY8K37ldxYRgX6y9J6M0jr5eYS5+IEmN6ClFLR3MmDSyjQuEyvY
         18E+HZBBHHeM3ah2hcrWlQYvMKHN29yZNbJXU9Kgxbx2r8bO/M88siQZbsH7YQBAUUjm
         6nfL0PHuD4t0NRd/JfqU7QBaGIWNeC4ti8K+LMDpzN13Iu/P2H5qZ1voKJ0+gTn6c/yV
         D9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yN9AxgVhP403euh96vyR/P6B46ndFdybNrT4U7XWKGA=;
        b=3cm8As0p6SXUYuDgb/AxipfXqtdy7AlJSi8ANH7eckpQ5RGEor6TBjC9NKBgVRHltn
         3linwhAokYIA+QxdmmRHXN2GYJVObxcGleicCparll8ijI4gf3QGwYprUcgZj8nz6RcZ
         rmA61n4FkMhSrxUk67nIg6QsGs4tXeAtt0BHfTCY/YvgruVPz4IHvphRiKAImL8EiPI8
         oyQdiye3piek8tnlcsBwmpO1vBIXMd7a66sIEQUjzZG7d5Btgm5FLGUj6XMNYxFcZsVi
         sF3mHfdxKz7966ineMga0pFYmpvAiXDCB0EPhYQEmkwM4QgEytrooSN6Xz+NdMRvYBGq
         XRaA==
X-Gm-Message-State: AOAM533WOBfthTXmAFOK3nv4eMyI4soJhdoO0Fp8mBXV+tfUGrBF5zsM
        0pIFsTgeZlpP7pV+cmUEJnBSZTQNmojV
X-Google-Smtp-Source: ABdhPJzNEuRRRYrc29XxGDMCWIspDpqFXUsZC0T1lx1Ih2r01Z7AkyiJfWQCCAEP165v2BXeYTAglRSi+vpZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dbab:a6fe:1e3a:91fa])
 (user=irogers job=sendgmr) by 2002:a17:90b:1486:: with SMTP id
 js6mr92355pjb.0.1637712756019; Tue, 23 Nov 2021 16:12:36 -0800 (PST)
Date:   Tue, 23 Nov 2021 16:12:29 -0800
In-Reply-To: <20211124001231.3277836-1-irogers@google.com>
Message-Id: <20211124001231.3277836-2-irogers@google.com>
Mime-Version: 1.0
References: <20211124001231.3277836-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 2/4] perf tools: Fix SMT not detected
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

sysfs__read_int returns 0 on success, and so the fast read path was
always failing.

Fixes: bb629484d924 (perf tools: Simplify checking if SMT is active.)
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/smt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
index 20bacd5972ad..34f1b1b1176c 100644
--- a/tools/perf/util/smt.c
+++ b/tools/perf/util/smt.c
@@ -15,7 +15,7 @@ int smt_on(void)
 	if (cached)
 		return cached_result;
 
-	if (sysfs__read_int("devices/system/cpu/smt/active", &cached_result) > 0)
+	if (sysfs__read_int("devices/system/cpu/smt/active", &cached_result) >= 0)
 		goto done;
 
 	ncpu = sysconf(_SC_NPROCESSORS_CONF);
-- 
2.34.0.rc2.393.gf8c9666880-goog

