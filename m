Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B50ECAAD6
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Aug 2022 16:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343568AbiHZQm3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Aug 2022 12:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343791AbiHZQmU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Aug 2022 12:42:20 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D0ADFB5E
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Aug 2022 09:42:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33dbe61eed8so33663997b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Aug 2022 09:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=byVpB80TV/x11qGZZj1V9Hbrrk6J+Ff/Bi0KHWzM1Uo=;
        b=W/VJ5rg3aGuizEVj60WkWyRqB0n4EBZUrHEDpDfRWvuCCWoehnJyi3Rk4VJfX4ZUDJ
         I2qBuJe2t5g52IWnleVkrQQz++kvZNpZPyFEgMwfRm+f7sF4VtcbNJOlWZTi6pCehRIr
         WCC5X6P0Vq6ehNJhHIf9a5DEEgCpOc+aebP+RNnyveFmorCqIWQu2kFfiJlYzI6iz7OI
         YYJXu/LyVg+QaqaArBg3BaR+aYN8AWMqgj9/MKglaxPcrCyRkJ9+U2ORELhlXx8IIb21
         2wnW+TFj9uBCL4tTwo7HjI9gvXNizSNw/kSNLvGjfWNm/dqGnCaCebYOMNsO2V7xYT7p
         3SGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=byVpB80TV/x11qGZZj1V9Hbrrk6J+Ff/Bi0KHWzM1Uo=;
        b=S8XQKIv7tjT7FKFli+n+dZn5unQlgNuRJhMliYXViM0T6wBgO6Uk7tVgHPIV/b6NfL
         BjGGopBFMUN977k7tUCZzobcD5iAR74a8sKBSR/5UZzC3B268dWgxomVMWFfuYgZOT7V
         bo74r7MzExj+wag1QCtBKCqLIhws7MM927c1NdFoOlqDEoumycFukb8lOblVZt/N/4FO
         77q3Srd2z+k2DXpSVqNv6CXF+CpGHu+K7ag5QGiB/P+7c86q9nDKFvJwcEDK4G4f98VE
         o+IHPDcQU/79wqcuMWKd9CnNHjLHpBB739itIb0LhLWMLSrepUET1Qp/lhR3ncndtt1n
         E/bg==
X-Gm-Message-State: ACgBeo3YtEdj1LElYmYMmQRk12YNKK7VQEbliZLI67Z9a9mfDNEyuLP4
        l8TsmZe6s9XNKN/UyRWIZVQqxef+nmOq
X-Google-Smtp-Source: AA6agR6t3Ar57WkibYNIjXdxikxJkwvqy8S0oMCIakUmWXO2vxiyAyZG49JLY3UVp2N9ZoitG2YIlxHWSu8N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ccb1:c46b:7044:2508])
 (user=irogers job=sendgmr) by 2002:a25:ba90:0:b0:68e:de4c:b2e0 with SMTP id
 s16-20020a25ba90000000b0068ede4cb2e0mr484149ybg.528.1661532132627; Fri, 26
 Aug 2022 09:42:12 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:40:14 -0700
In-Reply-To: <20220826164027.42929-1-irogers@google.com>
Message-Id: <20220826164027.42929-6-irogers@google.com>
Mime-Version: 1.0
References: <20220826164027.42929-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 05/18] perf bpf: Remove unused pthread.h include
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

No pthread usage in bpf-event.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-event.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 144a8a24cc69..1bcbd4fb6c66 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -4,7 +4,6 @@
 
 #include <linux/compiler.h>
 #include <linux/rbtree.h>
-#include <pthread.h>
 #include <api/fd/array.h>
 #include <stdio.h>
 
-- 
2.37.2.672.g94769d06f0-goog

