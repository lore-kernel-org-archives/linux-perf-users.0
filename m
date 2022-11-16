Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3427C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Nov 2022 07:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiKPHNI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Nov 2022 02:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKPHNH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Nov 2022 02:13:07 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E9E1F9F2
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Nov 2022 23:13:06 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id t5-20020a5b07c5000000b006dfa2102debso9907568ybq.4
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Nov 2022 23:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rZhTm2sCwM0sd4mB+pucosVTiyv4zqlp4wWT/R2sU44=;
        b=NeVYHzQSh9LPa95VeNyD2erJ5RST3qbDcp39rn2M+WV63VJbLXccHQe0jOp3281h//
         /6QDJStsa5HeC5719ZaHB7dKPIFqJBqwDDDrFvy2JBQFdO9waPThCkNtqp/L8dsBc4Zl
         je1aGmwz5ZpLRBYgX26Ln8BGYlh3RTzfhwGsIJO3BVaVIrYXzvr4K4LAAWJxYvGT5+sU
         0oQCfAFtFchWmcggIp+rTz96cBrbRZVZUb/rV1zk2Wvp5T3s0OowWJ2KL+bqnDxJ3ky0
         cex8DimvjWYivY/yPs+0ZEjDCc3R3QCmzuVRoMis6Igioz0Kmnwbd3NVzMGuYdsRoNg4
         BfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZhTm2sCwM0sd4mB+pucosVTiyv4zqlp4wWT/R2sU44=;
        b=ZfcCva9a4jRdBvm7El81W04/AxzCheJUw89UzT2kkxk8F4o9e5OB3SdRJnNPbmcrwh
         VXKPmYz2v8hv8bYv37hUf4FfxyHJ3IvY+nS10BQ38d+o1XCmtfsdgfePj8xLsrVu6UHq
         /KE85mMCjB8t+/yruAMK5PTgwbJbkdP3E5BOjgfo5Ml6CsBWt6RTsj7Wnv45HIqOzJ0D
         JpHRW/5BB9AG11fOmbwcLo72eCkDH3ABSeuPztcsGH7ZA3M1JbLp/BKJgqjbdFwKRMs0
         Sf2V/8/n+2qPhHm31KzP5S8WjHGboibPcuqGq7E5+NjtqjmpK0Fz5nzNf/b5zkt1PwEY
         fUXw==
X-Gm-Message-State: ANoB5pnX+lHoxRTGShg9pg9JVrh9nTDhTXt2l6Qb4Ut1nMdO/63qdanl
        0mqsjT5opZmVk0oQaExXZD+P+3znb6L5
X-Google-Smtp-Source: AA0mqf4LN7zMZJXkzIGBeqXaFaLoGtCJ64z/NuKcPfkUISn4se81/eXU9lqH0dIC9hkuM7/yCNFurBEsEak4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bf0f:58f3:342e:c1ec])
 (user=irogers job=sendgmr) by 2002:a81:ad7:0:b0:36f:d14a:6158 with SMTP id
 206-20020a810ad7000000b0036fd14a6158mr19697123ywk.325.1668582785931; Tue, 15
 Nov 2022 23:13:05 -0800 (PST)
Date:   Tue, 15 Nov 2022 23:12:56 -0800
In-Reply-To: <20221116071259.2832681-1-irogers@google.com>
Message-Id: <20221116071259.2832681-2-irogers@google.com>
Mime-Version: 1.0
References: <20221116071259.2832681-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 1/4] perf list: Fix asan issue
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

Missed due to the void* being a valid cast.

Fixes: c9367a0658eb ("perf list: Add JSON output option")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index aec139f7fbb2..0450fbfd0a5c 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -466,7 +466,7 @@ int cmd_list(int argc, const char **argv)
 				pr_warning("WARNING: hybrid cputype is not supported!\n");
 		}
 	}
-	print_cb.print_start(&ps);
+	print_cb.print_start(ps);
 
 	if (argc == 0) {
 		default_ps.metrics = true;
-- 
2.38.1.431.g37b22c650d-goog

