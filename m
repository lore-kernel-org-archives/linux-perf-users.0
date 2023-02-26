Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B151CC64ED6
	for <linux-perf-users@archiver.kernel.org>; Sun, 26 Feb 2023 04:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjBZEWR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 25 Feb 2023 23:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjBZEVp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 25 Feb 2023 23:21:45 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70403CA20
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Feb 2023 20:21:33 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so6875064pjb.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Feb 2023 20:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCXvY3VOyromxWZSsh4iONVhiGPWxZ3OU8P5j9wqMDM=;
        b=DaNxzuvhNXQ4wLJCYxYJ+wm5GTMCmnmX7mKLaXKDpQ/55+I+7Uan/JFCiCyRt25vc9
         wN0dRrC09xps5a0nKV6Yxww+EuFZuq178G7Eh/kj7U2GBoZTCFQ4U9iuyb/hWEq0VizP
         5CFx+8zCFmcfZhizaPIS5ChS8G2rbUatvmxq2er3inqcRB6kb18KJKz6+2ISDgouLrZD
         SjNrXh2mP0TXtK15gpllKaDJaTfA3CNou4LYFtAmygJODh8aA9QTsY1GlW7+43DOQhr9
         6b3B08uFMqKIMnVa4VUL4blCAutgcB8gqWd23/bLXyLGSAlyABo0wNOFcgHpRsq8j+o3
         blPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCXvY3VOyromxWZSsh4iONVhiGPWxZ3OU8P5j9wqMDM=;
        b=tp1E0p2SHmT4bIJUMtfIv/vSwq/NevS06CMf5pkiZoSxqbi1LjIJkBD50288k9/2PB
         wGcOfKGUGWbqReLDl23PWDGStd0BSZ+SSLJyWMZvr+0zhEPlKdxhjLoFVBP/uu2eGUec
         f/4rfpV+ZYs9eQiP1d9VZ+QutYA9l1G68RwnL9n3J72FhloLgEEnz8ALXAqXMhNoB561
         +PYVjhC9Tjc7t3EqeBfx+yWUmZnvavDrHWnQUUgNCZ8vdKmIa/tqxR/W44xdgm/ONB/C
         M+yyu2uZV2uRIs4JOKDdnfiqZenEa/hWI+5CkPGDFa3rDXkXo/xx3H4nedQmAi5SyG7E
         2tYQ==
X-Gm-Message-State: AO0yUKW9I56wqOh7QlTMbzo0GvFZz9i+axdISfeTq5FjE6ma4Djh0oIw
        xwtSr6hblZG6xnVIZYoH0kbojQ==
X-Google-Smtp-Source: AK7set+V2MihlpZmRYi8DJrjsaU7OadR3+v1rZvW4ZJkAo+N6PyadTQpdQRpaf47UjZPBy76vzH15w==
X-Received: by 2002:a17:903:2347:b0:19a:9859:be26 with SMTP id c7-20020a170903234700b0019a9859be26mr4289506plh.22.1677385292839;
        Sat, 25 Feb 2023 20:21:32 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id jj2-20020a170903048200b0019aaab3f9d7sm1976036plb.113.2023.02.25.20.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 20:21:32 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 07/14] perf kvm: Parse address location for samples
Date:   Sun, 26 Feb 2023 12:20:46 +0800
Message-Id: <20230226042053.1492409-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226042053.1492409-1-leo.yan@linaro.org>
References: <20230226042053.1492409-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Parse address location for samples and save it into the structure
'perf_kvm_stat', it is to be used by histograms entry.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c   | 5 +++++
 tools/perf/util/kvm-stat.h | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 779881901a05..a9f467926bdd 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -704,6 +704,11 @@ static int process_sample_event(struct perf_tool *tool,
 	if (skip_sample(kvm, sample))
 		return 0;
 
+	if (machine__resolve(machine, &kvm->al, sample) < 0) {
+		pr_warning("Fail to resolve address location, skip sample.\n");
+		return 0;
+	}
+
 	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
 	if (thread == NULL) {
 		pr_debug("problem processing %d event, skipping it.\n",
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index a3219829c448..80d5c5a9ae31 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -7,6 +7,7 @@
 #include "tool.h"
 #include "sort.h"
 #include "stat.h"
+#include "symbol.h"
 #include "record.h"
 
 struct evsel;
@@ -86,6 +87,9 @@ struct perf_kvm_stat {
 	const char *sort_key;
 	int trace_vcpu;
 
+	/* Used when process events */
+	struct addr_location al;
+
 	struct exit_reasons_table *exit_reasons;
 	const char *exit_reasons_isa;
 
-- 
2.34.1

