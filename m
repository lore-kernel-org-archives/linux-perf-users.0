Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D48BC7EE23
	for <linux-perf-users@archiver.kernel.org>; Sun, 26 Feb 2023 04:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjBZEVq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 25 Feb 2023 23:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjBZEVY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 25 Feb 2023 23:21:24 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18121EB72
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Feb 2023 20:21:21 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id v11so9891plz.8
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Feb 2023 20:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIt7hyoJVmNy/7vg+PJWYd0GZkeRWV7lG6iYd+8Wqps=;
        b=QLCZOXZA8bJOvg/e431jWcUuatC2M0BATcQlATzrxK/OSsLRVFfdDyj1Eeien+oMt9
         6/+coTMUrO1gUQZbBlgoa1XDp/TxsSqW1AMGKb1+24q8M7IC43f8GITQ1D0PeK4ZGkTm
         vBjiMeFkdDt0DSZOzhHfzpehFxRRM+3xlsXQcS4n1gmM0YHTbu7geqhO20FWcfuzt6ed
         b1RjfsSpBz4ZerZq5To3SCcuJCDyuz87hWAedKW2Y0/HX7w7aLhz+/72RXBOWSVpP272
         EYem2JG8n4ZCGTHUgNyZ1x/Eo93Ty9tepoF5PP47tIE4cdiE2x5cJ3dY36Pmeg5nmSIn
         4+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIt7hyoJVmNy/7vg+PJWYd0GZkeRWV7lG6iYd+8Wqps=;
        b=WwulO2L7QwpgVAhGWxSjqRfrHr3eN/BRw11VO63GJ7nc3uIi1oFL73xIeHgSA/QCRp
         yidOmWrSOsYhLvEgwdS/DyJKTzS7dY2L0tFksmo0Q6nvotD1FaS+VapB++KDvFxxJYmY
         8BBcdi+kzQvYCGWtSnjGrcgzAQOrY4buzEcoL5fUzGATDZ8fVEU6+eQc7W+qGNkNeyDd
         SG+0kKPG7mH79lwNjikCKEw/TQM5vwhWfLPuNayOECDL7s1+J/DXCViyRXsfps7a6zTL
         zvUEo65qG5eFhtHQXJrU/XrxXqMtt5bv0XPv9TsSkTJ6WBVOkNGeUmd5jA78qmklgbj1
         Oaow==
X-Gm-Message-State: AO0yUKVx8fAMZ6AoyYRVUW68BEwB9CYvrZchwzItGxYhJVc2S7K0SJBf
        G6zJ6NZa/aL5+1+iL0EgHtGhqA==
X-Google-Smtp-Source: AK7set8NFJnLKgBe2EBgoB7Mof6k4BnAkRsqRlxzF43EeTJawxXOGdih/wiXHA78FRAElhuOG0bPEw==
X-Received: by 2002:a17:902:db10:b0:19c:dbce:dce8 with SMTP id m16-20020a170902db1000b0019cdbcedce8mr6942908plx.15.1677385281289;
        Sat, 25 Feb 2023 20:21:21 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id jj2-20020a170903048200b0019aaab3f9d7sm1976036plb.113.2023.02.25.20.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 20:21:20 -0800 (PST)
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
Subject: [PATCH v1 04/14] perf kvm: Use subtraction for comparison metrics
Date:   Sun, 26 Feb 2023 12:20:43 +0800
Message-Id: <20230226042053.1492409-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226042053.1492409-1-leo.yan@linaro.org>
References: <20230226042053.1492409-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently the metrics comparison uses greater operator (>), it returns
the boolean value (0 or 1).

This patch changes to use subtraction as comparison result, which can
be used by histograms sorting.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 62c097a37da9..6eec0db2dda6 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -66,7 +66,7 @@ GET_EVENT_KEY(func, field)						\
 static int cmp_event_ ## func(struct kvm_event *one,			\
 			      struct kvm_event *two, int vcpu)		\
 {									\
-	return get_event_ ##func(one, vcpu) >				\
+	return get_event_ ##func(one, vcpu) -				\
 	       get_event_ ##func(two, vcpu);				\
 }
 
@@ -523,7 +523,7 @@ static void insert_to_result(struct rb_root *result, struct kvm_event *event,
 		p = container_of(*rb, struct kvm_event, rb);
 		parent = *rb;
 
-		if (bigger(event, p, vcpu))
+		if (bigger(event, p, vcpu) > 0)
 			rb = &(*rb)->rb_left;
 		else
 			rb = &(*rb)->rb_right;
-- 
2.34.1

