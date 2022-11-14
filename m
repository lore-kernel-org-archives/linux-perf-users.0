Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44B6C43219
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Nov 2022 18:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237603AbiKNSNo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Nov 2022 13:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238355AbiKNSNc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Nov 2022 13:13:32 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BA51DDCF
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 10:13:29 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-368994f4bc0so112200927b3.14
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 10:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Se2me6lbjg4dS4DNtZbL4NOOrQgzrO1DuLy7bKVPgtE=;
        b=Udp1PTHKxUUEwOqdgvMUBoS44uHDNucmnfPc1wYaH/Eaj3JkdwS1KeKqeAZOzlQrsX
         xBTR9whWAVfnvkCVljv/bx91QT8WQafusEqzylUtudDl/GEJfrd1i1liZVtH2vko+2H5
         bt14BPmXoGjUfQV+rmPJb6f6rY6hfl2pfEz+gPNYzA6vBH8xk2kSlMV1KMpjVvx3w3xM
         CSm1/uSgSEJ6Is8EtJq8s9kT/lnMYVYnsJXysDAQaeu7a6c+4MUZ34saLOmYhKO+lb7k
         G9bJ0JXt9fyiSu2MfOhjnx63lMQi92IweinE5pmYDVc31iZR6FLDggptsMx3AW4BVjmd
         itMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Se2me6lbjg4dS4DNtZbL4NOOrQgzrO1DuLy7bKVPgtE=;
        b=1A+9olCiA6Xxj/26uQJH9Dw9c3YL63dGgu5xsTYmjKnlr0Z1/lLgCSgSTUI5X/prs4
         V7HjITzIUz4iRZ60cgDSaJv+3FJQTXJG/81w+rU511i34jmSpKfQlqrt51sszavvy1EJ
         q6pb4W2dYSoDh1NoLdVXholwwHiHtL/ZvQ89irn99UE+AnawqExy84pXE4Pt7XBqzChN
         HhW1vHhHNx5u5QA/0MxG708b+uJ4M7BIRi+MxQ/SXIIK3ac21lniuHGMG4qCc8YY/20l
         EYGeofhyUPR7FPClvM+2UJFjI2pNEbWZWmlgqWMNqDq+owMeurMnW1L3QHJHjKkt3+XQ
         wcmA==
X-Gm-Message-State: ACrzQf1kpKhCK4c6S4rKf9i4fG1FJ/n81wy0iz9YdgwZNrJdsJ6i3oJC
        d1zL1xUNAVVD4Ps3KxfqzXok2Q9uHqKh
X-Google-Smtp-Source: AMsMyM6nI6HLGD9Jx0YaVytT+hiYtZyokdAdmg0KfsP1deiNrFwkH3PPbJEsSVXR/ANMa312Fb23d8oHANk5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:553:438f:b86a:87f])
 (user=irogers job=sendgmr) by 2002:a81:9214:0:b0:36c:7b94:aa57 with SMTP id
 j20-20020a819214000000b0036c7b94aa57mr63231927ywg.221.1668449608551; Mon, 14
 Nov 2022 10:13:28 -0800 (PST)
Date:   Mon, 14 Nov 2022 10:12:44 -0800
In-Reply-To: <20221114181251.2683871-1-irogers@google.com>
Message-Id: <20221114181251.2683871-3-irogers@google.com>
Mime-Version: 1.0
References: <20221114181251.2683871-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 2/9] tools lib api fs tracing_path: Add scandir alphasort
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

