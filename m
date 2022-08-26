Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B8FECAAA3
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Aug 2022 16:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245617AbiHZQoR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Aug 2022 12:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344596AbiHZQnz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Aug 2022 12:43:55 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF12E0962
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Aug 2022 09:43:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33e1114437fso33152167b3.19
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Aug 2022 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=byVpB80TV/x11qGZZj1V9Hbrrk6J+Ff/Bi0KHWzM1Uo=;
        b=ROEzNU2vLJMBQ/ebGwfQ6eGsi2A4XeOX0z4/AtBTW7uH+wvBDbvD9U7dJUuGUu0/t/
         RG9SYRmEyQo81EQ6zm3BjTZyRAd/U+mfJ7acDyId27JWIUA+paGfqTwDijvDB5d96jS4
         0Evlu4LK9nXucMq0urv221+RSew0RsqU7Avx7QFSET/cxIFWkyK8hulDJfmqHHoDNT5d
         xzKrx5b6n0zWGgGV0Vid5qk43WAwDqZ2pDO3Z9r3V/WssKhdPELqolGKQo+4CFfR2Ggh
         H3RSQhX3uRz8yinHvLoTXXd77gH0H5rzVUCKfgzHXTupkv1hVDBVI3XndkxCFQPKiQVA
         mRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=byVpB80TV/x11qGZZj1V9Hbrrk6J+Ff/Bi0KHWzM1Uo=;
        b=34Skg/1D6nR3GDRtjbikoyts+a39Gg92uUr5xQhERy8NMv+0uP6NBHappByIXdM6Y2
         U9PUzC4YwGwvWWy1UslzKnEN10v1jw04H9VCjAL9ANrvoFG0Q6avvJOl8olP635l0U6J
         ScM/gy3niJuYGty/l80TIkohJL/STxxSFE5186zDXDsHC8OSzIrhiB/F5CSI6sBATIJp
         pVZZ+kMD+n8VUHnevrDPUnTF6fI+XfAXJnZF961F0btJm6G2D+VxZ9W/b13gNzac8J+n
         yeyCUlKXIbDnGnq05bOUI7QgjQ3tkBUyo0XhkBwCy+V7jS/KmvVQO2k7lj6sygJoLWXr
         abqA==
X-Gm-Message-State: ACgBeo1OUSqhKCbkEBVhVwmoChShCdIXYxvWzEGZno/edf8huTVb0ULc
        Jip6KEYsUBeJx6D6kW3vjLk9zfB3Hw1s
X-Google-Smtp-Source: AA6agR6+TnZFZIJcRd/XLNKJvnwoJOukG+FHhTf/+Ns3Gs61SwVZyHKl1Nu9OjgbFxM6njZlSR8C8NrDOQey
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ccb1:c46b:7044:2508])
 (user=irogers job=sendgmr) by 2002:a25:afc6:0:b0:695:8a28:1dc6 with SMTP id
 d6-20020a25afc6000000b006958a281dc6mr494579ybj.500.1661532207957; Fri, 26 Aug
 2022 09:43:27 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:42:29 -0700
In-Reply-To: <20220826164242.43412-1-irogers@google.com>
Message-Id: <20220826164242.43412-6-irogers@google.com>
Mime-Version: 1.0
References: <20220826164242.43412-1-irogers@google.com>
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

