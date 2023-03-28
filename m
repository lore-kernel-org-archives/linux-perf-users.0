Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE73C6FD18
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Mar 2023 23:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjC1X4s (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Mar 2023 19:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjC1X4q (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Mar 2023 19:56:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9311A2
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Mar 2023 16:56:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3-20020a250b03000000b00b5f1fab9897so13699064ybl.19
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Mar 2023 16:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680047780;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=csE2VZEcuZtBLgmcXXy647e0uSJ8df6i+003V2C0jUw=;
        b=Yib8I2uNI+WOJsCh1Q4n8uRnhC1tAuAB8JbPeIlcB5nVB46fTnrkZzX4bjrI7UcS16
         VfeA/8cQUrhsK7bK0usQaCWRJSdq9N9a6c3rcix8RFrv70wWXoK3EUVPDzyU6IvQIMmB
         kBTGnjt9VijE3efrsi0D/w/HohhQmU1FbnNKlGXND9/+92cwfNbKh9irTfujj/1fJLoJ
         xjdEZaRcd9mX1MdQRDRM6WEQZj4tF8vGNcBxmsNyWeg0uzmuvmVFgEUxdjRP8xJaEnl5
         In8K528yb79Cz7HetuZlunZq+rSQcDcPTxHJ9GpRt+WSRtGDjvlhVlwbDju0A9up2zjT
         Z/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680047780;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=csE2VZEcuZtBLgmcXXy647e0uSJ8df6i+003V2C0jUw=;
        b=OjpsQ9f+9jCU/D2TwTS0T2gW6gzdG6fXhyrvV6HA2STg+2XpCCQmYlmmGu/V0ndvxV
         I+BuHuC5wNdKg0HJH4wsDgVvA5apzDE3y0bcdDh4AEIM9KzLij6fWFdaHQgls7pyq/ui
         udcrxDKPINthtL9FUngvHUxAFRVtiS5y9/17Bnkt/Gpj3TQE0CsCf6p6sfJtgwysaSTk
         PPutVOpg3Sb8XLhlW6yp/6xolwsyCcKd7KTJA+zKgIpRGkFKA8qHBdPbMhSHtX0AsDrz
         Wqn8ZeyOJEzn0FItZdoc+DDuSJDMd7xdYPRurlhGxhQaVbS5ULUpx+KLmNfNZkjvQ56P
         nvxw==
X-Gm-Message-State: AAQBX9fgTV2RYiNxuZxPSVKBMr6lMBFjY1BiseWZLq5V7x/4+Z3Kz7jD
        rL+JDG3abrS98LozEZ9U/QYz/QRpPQHd
X-Google-Smtp-Source: AKy350aL9CY1E8m1J8TjEURID2oBqh5mz3wMQUM24lLONZ4M9DkOnMmP+IHYNgSHJ0dcKtyi2L23qYzmmiUX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6519:f0d3:9540:5c31])
 (user=irogers job=sendgmr) by 2002:a25:db91:0:b0:b75:8ac3:d5d9 with SMTP id
 g139-20020a25db91000000b00b758ac3d5d9mr10989074ybf.3.1680047779895; Tue, 28
 Mar 2023 16:56:19 -0700 (PDT)
Date:   Tue, 28 Mar 2023 16:55:39 -0700
In-Reply-To: <20230328235543.1082207-1-irogers@google.com>
Message-Id: <20230328235543.1082207-3-irogers@google.com>
Mime-Version: 1.0
References: <20230328235543.1082207-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 2/6] perf report: Additional config warnings
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, James Clark <james.clark@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Andres Freund <andres@anarazel.de>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If the default_sort_order isn't correctly strdup-ed warn and return an
error. Debug warn if no option is matched.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 6400615b5e98..500f9d8902e7 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -143,6 +143,10 @@ static int report__config(const char *var, const char *value, void *cb)
 
 	if (!strcmp(var, "report.sort_order")) {
 		default_sort_order = strdup(value);
+		if (!default_sort_order) {
+			pr_err("Not enough memory for report.sort_order\n");
+			return -1;
+		}
 		return 0;
 	}
 
@@ -151,6 +155,7 @@ static int report__config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	pr_debug("%s variable unknown, ignoring...", var);
 	return 0;
 }
 
-- 
2.40.0.348.gf938b09366-goog

