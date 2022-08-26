Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5196FECAAA6
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Aug 2022 16:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbiHZQpu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Aug 2022 12:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344596AbiHZQpQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Aug 2022 12:45:16 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CC9E1923
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Aug 2022 09:44:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33dd097f993so33868837b3.10
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Aug 2022 09:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=qbxmvtg31vAuyTVNdQtLAo3hOGlbGiTSIFXCXMg0luQ=;
        b=YiNeHiEQB7ZT+byLDsP6gzhAxj4qOcjGxn/TRpfE7J5uDFuiRDDfDWXwSNYZMf71ii
         A042tDGS3mpdCbthoHOppHcp8csVsnoDFYj8uc6vICZfkDKq6ExaozYty4czWI7Od2rm
         rqqyt4D2tilfzdIguqYFmEmgMQUSCyrZllDJTNi1x6gPLiUh8K3O6SXJ6cPf3yMWidsQ
         IITf4xjJM6BQNoO8wUGCfIeOHnAxA4zzC9sC3gH0blsa/anyMgCupQSLxprb9f+dw9kP
         H8qSSU3Gwc46qrepxa0bpb552AkXWP7nh6/fTVf57pE2JAc0X2yzdujYaGSYq+iMD4No
         Ev3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=qbxmvtg31vAuyTVNdQtLAo3hOGlbGiTSIFXCXMg0luQ=;
        b=wEIPfwVRlfXWJRrcLCQ3w7unmDo5QDWwpJZiUQB0F3EIh0qeAjXMvqd1skcEssuGY8
         Ryv8jWX11FCIODE7J9Kpv0R0vx5rc2u8y1bHOp1fdDhfbb9T0r0QXgvIdacr68fsfw4F
         74iU/sETtIMZSD2Dd6Re8Mz8ee+woe1OrzM3rXI9TWXSl0FyogfooPc6FtixqIscxQrG
         LX3TQAJ8fJWOiMTejX1EIddUm845LkBWkt3eoxOh24ogp4CcHJT3GpERZC7izGV9RR4L
         hpavNv5W5yaZ1d2PjX4YjDfIgwvnEaVO2/74P8kbIzbNyeNRG/wMkDm5Wb0dMKs07Ahs
         as2g==
X-Gm-Message-State: ACgBeo3mSaD6sXCMc+upNbhu4XZIFtOONnUvyH+tSnBI1WAdx29DfYMi
        hS6aWnwcErXixUofBIZant+D6ndVvVfR
X-Google-Smtp-Source: AA6agR6GfpMi/GILI+QpU1U4bPsd6a35OdbU6xCyVP9TE8SbGO9dQ/L4McelKKt6Ipqvg8tKYdc1sXGi3MSG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ccb1:c46b:7044:2508])
 (user=irogers job=sendgmr) by 2002:a25:198b:0:b0:690:65bb:9416 with SMTP id
 133-20020a25198b000000b0069065bb9416mr510164ybz.142.1661532272130; Fri, 26
 Aug 2022 09:44:32 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:42:34 -0700
In-Reply-To: <20220826164242.43412-1-irogers@google.com>
Message-Id: <20220826164242.43412-11-irogers@google.com>
Mime-Version: 1.0
References: <20220826164242.43412-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 10/18] perf mmap: Remove unnecessary pthread.h include
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
2.37.2.672.g94769d06f0-goog

