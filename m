Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF36BC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 May 2022 03:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbiESDUa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 May 2022 23:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiESDUT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 May 2022 23:20:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BF556403
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 20:20:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d188-20020a25cdc5000000b00648429e5ab9so3311052ybf.13
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 20:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1limainpPz/ktpnhi2JQ14ZpISEsYFULN5eyOmNi+Sg=;
        b=pwFiLjJF7F42X0N/SJOqIg+cAOdZbOcMsmo5i34y2KmksTi8MtPUEB0qc2c1HLmR45
         cwJ+5gBpTjYMw6GcKjAMzXgbB1OabmEHtfbVS54w4nOVjbgkSeaHB3iHWUXZHP2ALe3x
         VQEwVtR95jEfnd8/bokpy2LqYaPKYh9gBUuaxoXxMYCUTqaRobWi283YJ3TSSG41nrbt
         qRNBzT0SblEn+0obrQlf3TQmAJZjTysd9Nd3biW0tKlOZmJLCSbwZWbWOTBh/e52vftR
         eMjhM+TnOzRsRXC/6+QLoB7+4aMy32X6UJTMmOW4tvIOHKwWu8jbuidFy/Oo4R3UYu+U
         bfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1limainpPz/ktpnhi2JQ14ZpISEsYFULN5eyOmNi+Sg=;
        b=1yp2WVP6MXiFdrwHgbL2g0akilyuPtLQLbD7iKLMUjl2lpqNeu9OO0r3vFUsFJI6fR
         uaLDVqMMckoEKWuzzhTkCSYN9aRQE7iQij0N/Cn/ZSQlNjda8jKx8rTDLvQsfzA6kl9k
         pD4QA2DqFMQWTyl9PX8mE7qSsDBUozH2RHiUJF55nPNhQu/Ff5UJXWwEd3uAsUPs8TLA
         o2G5RyrkoxUz9kvrezBze+1SdV1w9M/ijejElTgVbg3tlkeGZJWfotPHA9RJCxOcB5h3
         Z91ST0sJ+nSeobQnR7TxK5zEsbzgshobmxWJIiTq0QPbicgg04Hqi67dKiC+xEOH8ffR
         9Sig==
X-Gm-Message-State: AOAM533+60DrbLmSXhUpxqWzvtMA71HuDqtYx9DGRrlFT8hrDKIqajfJ
        C5F1wlnHIMHEuVxhBf3l3EM295vVVHSx
X-Google-Smtp-Source: ABdhPJy8cyFjJSoZ/WeYBph7EUcVHsLsZB60kq0ih2WbPF8sSVl+a37Ci3uckkELeD+m4XbHoiUKuH2yLtsG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a233:bf3c:6ac:2a98])
 (user=irogers job=sendgmr) by 2002:a81:4104:0:b0:2f1:b59f:22a2 with SMTP id
 o4-20020a814104000000b002f1b59f22a2mr2662292ywa.328.1652930416067; Wed, 18
 May 2022 20:20:16 -0700 (PDT)
Date:   Wed, 18 May 2022 20:20:02 -0700
In-Reply-To: <20220519032005.1273691-1-irogers@google.com>
Message-Id: <20220519032005.1273691-3-irogers@google.com>
Mime-Version: 1.0
References: <20220519032005.1273691-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH 2/5] perf stat: Add stat record+report test
From:   Ian Rogers <irogers@google.com>
To:     Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Lv Ruyi <lv.ruyi@zte.com.cn>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This would have caught:
https://lore.kernel.org/linux-perf-users/CAP-5=fWQR=sCuiSMktvUtcbOLidEpUJLCybVF6=BRvORcDOq+g@mail.gmail.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index c7894764d4a6..9313ef2739e0 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -16,6 +16,18 @@ test_default_stat() {
   echo "Basic stat command test [Success]"
 }
 
+test_stat_record_report() {
+  echo "stat record and report test"
+  if ! perf stat record -o - true | perf stat report -i - 2>&1 | \
+    egrep -q "Performance counter stats for 'pipe':"
+  then
+    echo "stat record and report test [Failed]"
+    err=1
+    return
+  fi
+  echo "stat record and report test [Success]"
+}
+
 test_topdown_groups() {
   # Topdown events must be grouped with the slots event first. Test that
   # parse-events reorders this.
@@ -62,6 +74,7 @@ test_topdown_weak_groups() {
 }
 
 test_default_stat
+test_stat_record_report
 test_topdown_groups
 test_topdown_weak_groups
 exit $err
-- 
2.36.1.124.g0e6072fb45-goog

