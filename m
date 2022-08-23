Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511E5C32772
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Aug 2022 22:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiHWWLk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Aug 2022 18:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiHWWLG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Aug 2022 18:11:06 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB4F74E02
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 15:10:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-333f0d49585so258625217b3.9
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 15:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=hI/abfVc/lpVnBGw0/IBypco5YlPGa9tkPSCqJ9uDZQ=;
        b=a0O0YxQ/mlClsh++0Eih5r8XCyQ2PWf4eHqbSAVf87G0uhjjV4kbUziQxWvdsEefYx
         idvXzO4xoEBWQvhOQHdXgIWgRMQZRpCedNhRsfArcBWCTGaYSh2qqeFdSQaL//ZenxmE
         bnx6vifkA68uo0CDX3CQZ+CSynMjQha/1cR514WJafX1myCBmm7/vRQkqn15p4EBevqQ
         f/SGa4Emdng/0J5qRratt4QhRZaPGGIa1R+oZftnBCVr3OWQORW0vGKyEDtPHlVaXJsa
         XzwqISY11EGfxyIVSGnS84xPYIglUGI3DCk12vMe/00OrB/Kzs2cQbbnW06pEvm+TWBu
         GWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=hI/abfVc/lpVnBGw0/IBypco5YlPGa9tkPSCqJ9uDZQ=;
        b=B5ATftd/9FAAcR7WDg6q6yFBMrcgmECwVO4DA1tTxUtmJSfbp191J5IUViW0t5ZGau
         2VTQWbZ2X0lGqLn053l8jBb+k8cw8zoG3eGL2VuzOgClmjWXm4ceDe5B+xaLMYpf3+o1
         rbKztMPdMAhhASo9jkjM0slYVHZo/8viPeS3WMTIzAougOJisNLCW7eS/5LRMmn32Ti6
         6BD9BuTxgAAdpybAzHSONn2ZNbcYBA0MWFv4FRjdF80FJK2DcSC6CQdyoRGGKtaBxDfm
         7wXXDgNAhrvUVCY89yP8LpFaIcxt0GFW1bo01Tz8OIB95zPLP2ZAMO/fYpIgl36TZewj
         dmEg==
X-Gm-Message-State: ACgBeo3oeSHq590SySg8ze8m6nq9yEpCz/vRvccG3XSuv5DkLF9YR1eX
        1JmQMrB3HTLgYpkrI2RzdCx171eGNnwc
X-Google-Smtp-Source: AA6agR6qFYD5g1FqAqGPVeImurrh/ZkYJjB3EL0kLaZmGTBXEapeVBFxkCQ4lK/axFqO/Hk6hdUZnkE+qyBL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7dbd:c08f:de81:c2a3])
 (user=irogers job=sendgmr) by 2002:a81:d0d:0:b0:333:99b1:44f1 with SMTP id
 13-20020a810d0d000000b0033399b144f1mr26891746ywn.288.1661292628860; Tue, 23
 Aug 2022 15:10:28 -0700 (PDT)
Date:   Tue, 23 Aug 2022 15:09:14 -0700
In-Reply-To: <20220823220922.256001-1-irogers@google.com>
Message-Id: <20220823220922.256001-11-irogers@google.com>
Mime-Version: 1.0
References: <20220823220922.256001-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v2 10/18] perf mmap: Remove unnecessary pthread.h include
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Weiguo Li <liwg06@foxmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The comment says it is for cpu_set_t which isn't used in the header.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/mmap.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index cd8b0777473b..cd4ccec7f361 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -9,7 +9,6 @@
 #include <linux/bitops.h>
 #include <perf/cpumap.h>
 #include <stdbool.h>
-#include <pthread.h> // for cpu_set_t
 #ifdef HAVE_AIO_SUPPORT
 #include <aio.h>
 #endif
-- 
2.37.2.609.g9ff673ca1a-goog

