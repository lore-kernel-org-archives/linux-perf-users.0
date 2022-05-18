Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D65C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 May 2022 05:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiERF6n (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 May 2022 01:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiERF6e (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 May 2022 01:58:34 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D9DC0388
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 22:58:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n8so833128plh.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 22:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VGM/bEGraxiyYz5sJxhipNVYwSAuDPrN7YJAla+bigE=;
        b=IpXNl8dm2aOvNaOOjpOKE4+kQa64lm1nqTPvuWLysojfMy+Ax66dtC+ELIOxOH4uLF
         Oe+1QJMiHtbVXAqjbrD6xmjvYI6tGUlhne3JRsR2iI8oni5sfRSlQk1wFsFo1GQw67Q7
         Nck2EHWL6Lh7TwSN2uEyGpve54uvxk5Y5ixO5HX/+SS0pAKAf534uZQvHvQXbBz8VfwT
         yrqRZ6nMjh3ZjqOw5tkBuC41z8bWqP5a3GciPA0vAddfjqGjpXMDV5nfrV68mZk14akf
         mGzPEPZtJ1D9B9QbtM71Y+LghGWOqHlGOOUJiEk4mYSRQECIsRAXxSfEcquFkTRs25y1
         VcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VGM/bEGraxiyYz5sJxhipNVYwSAuDPrN7YJAla+bigE=;
        b=4M03rWpSAi5tG/ukqLDpPZ4ZW5cAdCGrGyptJLwRVCaal8QRITm1+e1TmmxyQp3Pke
         lUdnV9ff1PkbATNZI64ABsS5tBqHrx9cCIRZN1cFjKCDb1s0ibNQLRMXfkfAvncO0nI1
         i5shBF6OqUXuECfQdZsa68w5KV0/LaPfF0YtpP15Ff87PupcYz0VUD/Ma0i6WP3QcKKp
         2N5LUpADMqXpnWJVL0ZdlOSPm/hZJ6YDEzZAipwmWSEt3rJ3Qweke8MQz0SJHOrTGtr0
         Z+/3NY6gh2SNcuE7QSIdIrV9E5PVupX77XVraiHb1EkfBSg06UQulwboaxUpM10dKnZa
         yJ7A==
X-Gm-Message-State: AOAM531/njeCjhd1px2b9CSoPxOMQ+pXn0XXF9VUruGdIQ0myndTlrbk
        +MzHq558vBbsp3mmrspxtAIPSw==
X-Google-Smtp-Source: ABdhPJyhLbR6ODACRKr7nE+PBu14rq2aoR/Tm6xqOmHUKzLal9kezvc3cQVKQ4wq3faFhognnFkLuw==
X-Received: by 2002:a17:90b:3901:b0:1dc:5a24:691 with SMTP id ob1-20020a17090b390100b001dc5a240691mr40309047pjb.40.1652853511645;
        Tue, 17 May 2022 22:58:31 -0700 (PDT)
Received: from localhost.localdomain (n058152048195.netvigator.com. [58.152.48.195])
        by smtp.gmail.com with ESMTPSA id cp16-20020a170902e79000b0015e8d4eb2c2sm627127plb.268.2022.05.17.22.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 22:58:31 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Like Xu <likexu@tencent.com>, Alyssa Ross <hi@alyssa.is>,
        Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Adam Li <adamli@amperemail.onmicrosoft.com>,
        Li Huafei <lihuafei1@huawei.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 08/11] perf c2c: Refactor node header
Date:   Wed, 18 May 2022 13:57:26 +0800
Message-Id: <20220518055729.1869566-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518055729.1869566-1-leo.yan@linaro.org>
References: <20220518055729.1869566-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The node header array contains 3 items, each item is used for one of
the 3 flavors for node accessing info.  To extend sorting on other
snooping type and not always stick to HITMs, the second header string
"Node{cpus %hitms %stores}" should be adjusted (e.g. it's changed as
"Node{cpus %peer %stores}").

For this reason, this patch changes the node header array to three
flat variables and uses switch-case in function setup_nodes_header(),
thus it is easier for altering the header string.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index ace7ead4ab75..757a79442a52 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1651,12 +1651,6 @@ static struct c2c_dimension dim_dso = {
 	.se		= &sort_dso,
 };
 
-static struct c2c_header header_node[3] = {
-	HEADER_LOW("Node"),
-	HEADER_LOW("Node{cpus %hitms %stores}"),
-	HEADER_LOW("Node{cpu list}"),
-};
-
 static struct c2c_dimension dim_node = {
 	.name		= "node",
 	.cmp		= empty_cmp,
@@ -2144,9 +2138,27 @@ static int resort_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
 	return 0;
 }
 
+static struct c2c_header header_node_0 = HEADER_LOW("Node");
+static struct c2c_header header_node_1 = HEADER_LOW("Node{cpus %hitms %stores}");
+static struct c2c_header header_node_2 = HEADER_LOW("Node{cpu list}");
+
 static void setup_nodes_header(void)
 {
-	dim_node.header = header_node[c2c.node_info];
+	switch (c2c.node_info) {
+	case 0:
+		dim_node.header = header_node_0;
+		break;
+	case 1:
+		dim_node.header = header_node_1;
+		break;
+	case 2:
+		dim_node.header = header_node_2;
+		break;
+	default:
+		break;
+	}
+
+	return;
 }
 
 static int setup_nodes(struct perf_session *session)
-- 
2.25.1

