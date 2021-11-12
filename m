Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A13DC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 12:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EFA761078
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 12:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbhKLM7N (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 Nov 2021 07:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbhKLM7N (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Nov 2021 07:59:13 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B001FC061766;
        Fri, 12 Nov 2021 04:56:22 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b13so8380776plg.2;
        Fri, 12 Nov 2021 04:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g+fNIRpzo2sLghB9sgoem/xkpimyK2WeQcIa3G2jAk4=;
        b=fFO+dQTOs7hF8CbwuxCH4FypYoZgO/F/ddXxMphcWjE90BQyQat7ruVbGemFIe4AKh
         CxFrcjbnyTbLRW/7XQZvNhRm1ZocSXgLYT9JXytm3hTcpTczxYLYXuvXfEZYS1u7XD7l
         xesgJRb8PzZiwdxnpCGWfiNndBnOPOWo2eP7N9VS0gKfz+6BAOmaqoIoy0ach36ZOLxw
         jW6uW3bHmnYuzRMWCjzwkWJSK9HFpBklzpR8+7sagza5I5Dh8mvigZ1I5A78i63pc3lW
         5QzBMmzWyzdfZuBLPhmLI5jWSLgLnReQ9yoqZznJMwjtpAhFGtn1IMn4MODP7HOGeJ7C
         QC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g+fNIRpzo2sLghB9sgoem/xkpimyK2WeQcIa3G2jAk4=;
        b=QWpEtZB+bbCsYfi5b1lWqNhjU1s90prussoaEDRpBeAAydcNgI6lfVkoXVXg9CqU2c
         V4c4l0cPK7VoocPMV0uIkOPBAcO6hYlU+x/hh1yNkJ5MuhJ3Gdmve80L8Ijpb0WAUXy2
         M7UaL8X/M5A78T6tAQtsDUCy6n2YSM9EPJaGyaeYfHOXgDn+fWIeKp91cKZUyFyQQXpj
         cEW4+hpVzc8vfb/rXew0fzmroYME+iDXMwPpLbP7+qd6y7u3ic+Zk3DlKk0bidsjM6Wj
         Pwiw5yh2lq9Fsk0iO/vUefZv0XCy/SumiiPVCdeciMYnPPquBj+iJjapFp5xW6+LMF0d
         Sj3g==
X-Gm-Message-State: AOAM531mn8SRBBPhMuyP7ZedCyB7MDdzEBrPrTY3iqeU7wQXHEK/I6Lv
        vNHnzEHu4UUEBbBd8Q2i7gc=
X-Google-Smtp-Source: ABdhPJyoZUkmCjbtpH0+fi3C6/PtsN9O2NdWoKUkvRPZ0eNm/ux/A61mh9WH0+NaN4S5cdh/MICkVA==
X-Received: by 2002:a17:902:7c02:b0:143:9d6a:8e42 with SMTP id x2-20020a1709027c0200b001439d6a8e42mr7739240pll.80.1636721782272;
        Fri, 12 Nov 2021 04:56:22 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q9sm7206553pfj.88.2021.11.12.04.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 04:56:21 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     acme@kernel.org
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, kan.liang@linux.intel.com, irogers@google.com,
        deng.changcheng@zte.com.cn, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] perf tools: remove unneeded variable
Date:   Fri, 12 Nov 2021 12:56:15 +0000
Message-Id: <20211112125615.10504-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Fix the following coccicheck review:
./tools/perf/util/perf_event_attr_fprintf.c: 97: 5-8: Unneeded variable

Remove unneeded variable used to store return value.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 tools/perf/util/perf_event_attr_fprintf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 47b7531f51da..111180bcd466 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -94,7 +94,6 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 			     attr__fprintf_f attr__fprintf, void *priv)
 {
 	char buf[BUF_SIZE];
-	int ret = 0;
 
 	PRINT_ATTRf(type, p_unsigned);
 	PRINT_ATTRf(size, p_unsigned);
@@ -155,5 +154,5 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(aux_sample_size, p_unsigned);
 	PRINT_ATTRf(sig_data, p_unsigned);
 
-	return ret;
+	return 0;
 }
-- 
2.25.1

