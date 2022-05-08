Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC67C433F5
	for <linux-perf-users@archiver.kernel.org>; Sun,  8 May 2022 09:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbiEHJ3o (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 8 May 2022 05:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiEHJ3b (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 8 May 2022 05:29:31 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712E8117A
        for <linux-perf-users@vger.kernel.org>; Sun,  8 May 2022 02:25:34 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id a191so9688631pge.2
        for <linux-perf-users@vger.kernel.org>; Sun, 08 May 2022 02:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bmjRmkqfDoOUpRbHbH9T/ypo7ZLWljJQ+MADxCAiDDg=;
        b=RlanBAIYEgm91wbA7cPRQpYBtqM6dgSI3Omo6TW7eQu17rOGJa1Udyp4fkVS5XyGSG
         OXjUV6btwYGN3gKeJqaxJ8PjIK0jPh2nLOxHZAH7BYFtA+8LzNqnpi8+0UpGLBD97A5m
         qjX3AWq9PEqTtM1bEQZWiQ8cJzxXvdU8KqLcRdLeHXTaj0HrPz4uHkOCamFZWbIzVlnk
         Vz+KDViYs7iDygYOrqrSQMUH3ZFEiBzD5+cRK71zhpeomAcXD+JedXqFPMjOWRkqn7Jn
         9kV4SAoA532c5a5oytRcHxxEmPaqEyMDsg+DkffMl7rACs1FTgPQpuD2EZJqMwBgWqlz
         IQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bmjRmkqfDoOUpRbHbH9T/ypo7ZLWljJQ+MADxCAiDDg=;
        b=3+aCvRni1a6te2uqB8YFmGzOM96Iw01u6yQG3FA0KCqQfUoEFc7/5NXOFS0j3CR0fS
         3TRHM/2ivT5YcsNzTL6wkcG0PW32ryd6L6L3g/dWgGNJbM7HBKsgR4E8sjFts62xOU5z
         heezLbTXiOt0KEnWTKIHqtPtPbgp3C+aCFfNRiPuvt78dCSBC+zV0qsdAVTEKxMk/py8
         Doreeoz54aFOPuh4FkC9fariebZsG5EU7JR+OHfDrDUmxJ3XbL7d3Leqdik66EgMz5O4
         deN9r9vYDuku7xsz+6jVSuCcvfVyqAZV2EtqsvNO1a9YSv+hrhOnpv9wCCUN4alqqTb5
         hvEw==
X-Gm-Message-State: AOAM532DPq1apgf5UeU30qxpQB/s411ZXap2MfiRPTO695PrcPkfZ6eL
        iNPEiRhPuzyAaHD66z8mKyA76w==
X-Google-Smtp-Source: ABdhPJzxDAEpKJE6XYr9T37crKPOq7CmaQRZLLlvIFev06vHXGfHLsSbInljeBNGWnb6qwwYnOhxdQ==
X-Received: by 2002:a05:6a00:cc4:b0:50d:e9db:6145 with SMTP id b4-20020a056a000cc400b0050de9db6145mr11046427pfv.56.1652001933348;
        Sun, 08 May 2022 02:25:33 -0700 (PDT)
Received: from localhost.localdomain (104-237-153-19.ip.linodeusercontent.com. [104.237.153.19])
        by smtp.gmail.com with ESMTPSA id t63-20020a638142000000b003c14af505f7sm6155088pgd.15.2022.05.08.02.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 02:25:33 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Like Xu <likexu@tencent.com>, Ian Rogers <irogers@google.com>,
        Alyssa Ross <hi@alyssa.is>, Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ali Saidi <alisaidi@amazon.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 08/11] perf c2c: Refactor node header
Date:   Sun,  8 May 2022 17:23:43 +0800
Message-Id: <20220508092346.255826-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508092346.255826-1-leo.yan@linaro.org>
References: <20220508092346.255826-1-leo.yan@linaro.org>
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
index 1e1565e5d396..04f33dc8ca0f 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1653,12 +1653,6 @@ static struct c2c_dimension dim_dso = {
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
@@ -2146,9 +2140,27 @@ static int resort_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
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

