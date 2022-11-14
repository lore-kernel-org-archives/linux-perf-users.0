Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3209C433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Nov 2022 21:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbiKNVI3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Nov 2022 16:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237480AbiKNVIV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Nov 2022 16:08:21 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF9B647B
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 13:08:15 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id k16-20020a635a50000000b0042986056df6so6326670pgm.2
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 13:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Se2me6lbjg4dS4DNtZbL4NOOrQgzrO1DuLy7bKVPgtE=;
        b=pSM7kTnmOSbosw8Hcy1wsfrOJtWX0Vk4M1VXbCfpBsnal65+1d2sh4Bhl/sPSG3WjZ
         oRq//RYKeswTfgFYSJ4Nv7F1CorCaBz6F1obJiSvGR021sk3+MiS3J0CKDoAThtT7mNL
         c5XvgVjLnyw/ULU0aatlPRu9cxq7LW4TyrQHf9201uJ5GhHD/OrtslM86NlZo0FNpgY0
         JcPC2nd67BGMddaSuKOAOFjPZjksyqaw2aj3O89nIhPVu/bl9Ccf1tqlOp2uQFr7akdO
         lj4Eu321mO/ZVaguwrY9uNagHeDPUAhFSZNIxiC1unT6sMrpC8hTQ/YF+wfl+wWOmNCc
         RtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Se2me6lbjg4dS4DNtZbL4NOOrQgzrO1DuLy7bKVPgtE=;
        b=i0cDZpV9DQdvoLTNejJEW7FcjlLx0V44e+J49VxWXMq+dQRob6rTT8R8mO6yqvc9dK
         ae0KjCQEAT8cXh0BVilsWqgJ6p4q3b0vlBNLdsNdG2YQPL/XLbdH5YlNpKvRxVpT0wOj
         8QWodeBJ3uViFwYADRCawuC9PfIA319bo+USvk7JErlFqPjt5FsLkEB094cAzLK6y2L0
         3S0RAbszFuXe+Mqo2VtL8xqw47OK6vS+MVl0+WcLS9GhMbVIT63FxQI5ypYHlH7QSYvK
         wSzeGFESpIEns9S2B3nOD+TwkcVCpECoGROSA+dMMfCN+ubYaTHf5VvB2NDohLc3iHCL
         yMNQ==
X-Gm-Message-State: ANoB5pmyP7+Ra2N4NbYQx4Cm63QuNtmc1fuXvTd+8gHeXAR80ofc8Uwt
        ehzn8PcCeR4Vetufjqj8SOo6T1KwMDy9
X-Google-Smtp-Source: AA0mqf6Z9g60XXYxfp7n+hZq20oXkSrKY1lCSw9Obhp7yu+rX+Z5SlNdIamZ+6QNg/KExsAVnRH1hkcLDMw5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:553:438f:b86a:87f])
 (user=irogers job=sendgmr) by 2002:aa7:8a41:0:b0:561:70b3:6a6 with SMTP id
 n1-20020aa78a41000000b0056170b306a6mr15444394pfa.25.1668460094565; Mon, 14
 Nov 2022 13:08:14 -0800 (PST)
Date:   Mon, 14 Nov 2022 13:07:16 -0800
In-Reply-To: <20221114210723.2749751-1-irogers@google.com>
Message-Id: <20221114210723.2749751-4-irogers@google.com>
Mime-Version: 1.0
References: <20221114210723.2749751-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v3 03/10] tools lib api fs tracing_path: Add scandir alphasort
From:   Ian Rogers <irogers@google.com>
To:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

tracing_events__opendir allows iteration over files in
<debugfs>/tracing/events but with an arbitrary sort order. Add a
scandir alternative where the results are alphabetically sorted.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/fs/tracing_path.c | 16 ++++++++++++++++
 tools/lib/api/fs/tracing_path.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/tools/lib/api/fs/tracing_path.c b/tools/lib/api/fs/tracing_path.c
index 5afb11b30fca..b8e457c841ab 100644
--- a/tools/lib/api/fs/tracing_path.c
+++ b/tools/lib/api/fs/tracing_path.c
@@ -113,6 +113,22 @@ DIR *tracing_events__opendir(void)
 	return dir;
 }
 
+int tracing_events__scandir_alphasort(struct dirent ***namelist)
+{
+	char *path = get_tracing_file("events");
+	int ret;
+
+	if (!path) {
+		*namelist = NULL;
+		return 0;
+	}
+
+	ret = scandir(path, namelist, NULL, alphasort);
+	put_events_file(path);
+
+	return ret;
+}
+
 int tracing_path__strerror_open_tp(int err, char *buf, size_t size,
 				   const char *sys, const char *name)
 {
diff --git a/tools/lib/api/fs/tracing_path.h b/tools/lib/api/fs/tracing_path.h
index a19136b086dc..fc6347c11deb 100644
--- a/tools/lib/api/fs/tracing_path.h
+++ b/tools/lib/api/fs/tracing_path.h
@@ -6,6 +6,7 @@
 #include <dirent.h>
 
 DIR *tracing_events__opendir(void);
+int tracing_events__scandir_alphasort(struct dirent ***namelist);
 
 void tracing_path_set(const char *mountpoint);
 const char *tracing_path_mount(void);
-- 
2.38.1.431.g37b22c650d-goog

