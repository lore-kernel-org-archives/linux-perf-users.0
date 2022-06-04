Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78746C43334
	for <linux-perf-users@archiver.kernel.org>; Sat,  4 Jun 2022 04:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350545AbiFDEaT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 4 Jun 2022 00:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350594AbiFDEaL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 4 Jun 2022 00:30:11 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EBD59969
        for <linux-perf-users@vger.kernel.org>; Fri,  3 Jun 2022 21:30:02 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 15so8571487pfy.3
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Jun 2022 21:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/anDZ34daG+85MmjwzCfXxdj0aLtzUmSEbQG6hZDGaY=;
        b=ZSgUAjs/iyd+/yOHU9WOOXWFIZAH/tEVcBfbYlRXAWIz72CKAnHcy7II0fLfwcHjgg
         0nlOAhkYTaWLB46m5ZFXlTozKxoQqmDrGs9SMOMgcP9qobe0CUJmMTFs97ZGZ/vVnl+f
         wReklBKF8axeI1h5UHc3pkn6FNNIcFym2A+VmhmkvVcOBxOblrKy/1yEOXc4HTsxwMJs
         4A4zaXTJ5NOtDr5GC3gV1+snpQW+zxiJeAuZHuF9okoC08je2sxSrVF7TrMsajjh5zL8
         pjXDxeUkShl2gYGQ4mn5UU8BG4r9ca/8mrWCnJbptWGYC6x3nOUWdDBBqOT5vcIsQAQd
         NoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/anDZ34daG+85MmjwzCfXxdj0aLtzUmSEbQG6hZDGaY=;
        b=Qf3SaRUtZIWaCzHvkwmORb1FcarGisA43K0SisYJlV5Z/js5y5yxsnIE4BwvXyYPHX
         O0d9hI/8PALJ7Wdf3r9Z1rO0Q34aP+eIs/KlqsD03HIp3GHzckwotc5P+Fr/FTD5QMO+
         JlksaBJ1q9UHgnzELbExDCcg6mfPyE3kKdFCUw1TlAt5DFbC03fLB7M67KmOImYMsl70
         s59qyo5GL+x3avek5+3B+MPsa0DzZgdd0+09uWTu8UwVf0P0sYzVkfk3boRmNP25Bz1s
         FofIaPhYkAqGq+dZfDd75M0eM73YS1ro1GyO+Pzp7yxlosqpBVFFEx9VKiuxzlGMZxR6
         HOcg==
X-Gm-Message-State: AOAM533AaiwK8wYcxChEisrrqHvDwMNw8Ru2+VQHbt8C+UnbqsUtlxr1
        Ap0EwV41ZuWxEvuefk7FbINDkg==
X-Google-Smtp-Source: ABdhPJw3IWosOX54sjK+dNbd2n0Kc3LJ61oEhjOzEXktZyWZSSYxOfr5NiN6efueMz7t0QrZBMsEsg==
X-Received: by 2002:a65:6e8b:0:b0:3ab:a3fb:e95a with SMTP id bm11-20020a656e8b000000b003aba3fbe95amr11435178pgb.433.1654317002236;
        Fri, 03 Jun 2022 21:30:02 -0700 (PDT)
Received: from leo-build-box.lan (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709027b9800b00163d4c3ffabsm6152916pll.304.2022.06.03.21.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 21:30:01 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 14/17] perf c2c: Refactor display string
Date:   Sat,  4 Jun 2022 12:28:17 +0800
Message-Id: <20220604042820.2270916-15-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604042820.2270916-1-leo.yan@linaro.org>
References: <20220604042820.2270916-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The display type is shown by combination the display string array and a
suffix string "HITMs", which is not friendly to extend display for other
sorting type (e.g. extension for peer operations).

This patch moves the suffix string "HITMs" into display string array for
HITM types, so it can allow us to not necessarily to output string
"HITMs" for new incoming display type.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Ian Rogers <irogers@google.com>
Tested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 49a9b8480b41..8b7c1fd35380 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -122,9 +122,9 @@ enum {
 };
 
 static const char *display_str[DISPLAY_MAX] = {
-	[DISPLAY_LCL_HITM] = "Local",
-	[DISPLAY_RMT_HITM] = "Remote",
-	[DISPLAY_TOT_HITM] = "Total",
+	[DISPLAY_LCL_HITM] = "Local HITMs",
+	[DISPLAY_RMT_HITM] = "Remote HITMs",
+	[DISPLAY_TOT_HITM] = "Total HITMs",
 };
 
 static const struct option c2c_options[] = {
@@ -2489,7 +2489,7 @@ static void print_c2c_info(FILE *out, struct perf_session *session)
 		fprintf(out, "%-36s: %s\n", first ? "  Events" : "", evsel__name(evsel));
 		first = false;
 	}
-	fprintf(out, "  Cachelines sort on                : %s HITMs\n",
+	fprintf(out, "  Cachelines sort on                : %s\n",
 		display_str[c2c.display]);
 	fprintf(out, "  Cacheline data grouping           : %s\n", c2c.cl_sort);
 }
@@ -2646,7 +2646,7 @@ static int perf_c2c_browser__title(struct hist_browser *browser,
 {
 	scnprintf(bf, size,
 		  "Shared Data Cache Line Table     "
-		  "(%lu entries, sorted on %s HITMs)",
+		  "(%lu entries, sorted on %s)",
 		  browser->nr_non_filtered_entries,
 		  display_str[c2c.display]);
 	return 0;
-- 
2.25.1

