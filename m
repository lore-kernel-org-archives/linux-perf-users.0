Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B201C32796
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Aug 2022 15:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239163AbiHXPkD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 Aug 2022 11:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239362AbiHXPkA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Aug 2022 11:40:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5CFA1B9
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Aug 2022 08:39:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33580e26058so296914997b3.4
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Aug 2022 08:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=gT8uGhkPz2QVnzj86f2E281NRyIthHuKkag96DoN/yw=;
        b=U+0X/kZRQHBs+6EtDK9G1mX43K8ZAL3xn0/TBI+PnH4qGB93szqa60OnaP41kr8dzw
         9QxineCg1olwLiYSqDFtsZ/DL3qt5W6eR5TCTrDzlgG3t20vGrl7TtoTaTPJqh4ejp+V
         fOBK2QoavsAeGxc7ZOPJaBPfbn80gRsXO59+l5v0lcwdEKd7o+h2LPa4qhnAKzksgMVp
         ALL9gtkdn2WUP3jETGiY5QAO1PyxVdYdDQa49bK9WeoWn4gACgU7UhjQ1Dlnp3z9npl2
         34gO4ZNZnH69GdlCJG3fu7eOy9UXPpE5LPOovQZYlMf6sex3WDh4WqxhHDj1zxBHDbcA
         ANMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=gT8uGhkPz2QVnzj86f2E281NRyIthHuKkag96DoN/yw=;
        b=23jt1v5gx9+4pg/kuKGc4tinyCXzdqb4w76iRwqUv5CHDIY1O+VhjdBzBGVNIh/hW5
         4apKS1zaQykqJWsz2h9DrP9ieD4T6cmRSF8sGvGI4jOKV0zxeEA2ueYoifwDvFypjyzx
         BV77lZtQBHfNpx7nIqC0ZTt/mg5CP9VaFmVbZ4EpFPpJ3oG+2MptdR/zcjH109aygkss
         k3gGkB+lKW022y0P6XJYwDzn8N8ykVDioGmgQsmKLQmZqgPbunp9UQ/mBq5r1RGbCqyr
         mDoDwGuT2MJjRtiATdOTlgoqcmy7ucuNp3ca8RXsIhfBKtzZg4hTdu1juuEM91c42aYj
         J0wg==
X-Gm-Message-State: ACgBeo0fq4DixCk+XWXD+vANMKLkMpEa7khJGKQI1g8TX64M0ssjHNR+
        YBt+C6ScjM6X34I3UE5s74KWrn9zBZ0h
X-Google-Smtp-Source: AA6agR5ogga8EEBaYLPmvldmteYhwwTHUME0yqOv74tlcAU5d3CrXbpxfPBzolFdoMRAia3otbb1SmJYRf3r
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ab82:a348:500d:1fc4])
 (user=irogers job=sendgmr) by 2002:a25:84cd:0:b0:67a:699e:4e84 with SMTP id
 x13-20020a2584cd000000b0067a699e4e84mr27914790ybm.407.1661355595376; Wed, 24
 Aug 2022 08:39:55 -0700 (PDT)
Date:   Wed, 24 Aug 2022 08:38:48 -0700
In-Reply-To: <20220824153901.488576-1-irogers@google.com>
Message-Id: <20220824153901.488576-6-irogers@google.com>
Mime-Version: 1.0
References: <20220824153901.488576-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v3 05/18] perf bpf: Remove unused pthread.h include
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
2.37.2.609.g9ff673ca1a-goog

