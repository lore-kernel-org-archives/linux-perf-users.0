Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C13EC7EE23
	for <linux-perf-users@archiver.kernel.org>; Thu,  8 Jun 2023 23:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237302AbjFHXaJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 8 Jun 2023 19:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237379AbjFHX3s (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Jun 2023 19:29:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAF13580
        for <linux-perf-users@vger.kernel.org>; Thu,  8 Jun 2023 16:29:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5655d99da53so25389637b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jun 2023 16:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686266976; x=1688858976;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HYQaZtuHl/SxeGLPx3KYJtDk+ilAjOX/gkAdD1/27NA=;
        b=fBJl3wcz+FnbBgSbRGxXixBnK3jNLSuIKoFf166vI/z37Q4wIcVYPmW50NKtSp9UgF
         rvr7Vycm6Wb545G0pPRanvDdHAxrKWNJYkGc8Cmt8RYCACXwUGF/iIgTa75YwhW6PV8M
         mKbs+2jj1XRyRcyBNZLzm3S68U4QfnBSrHCRrxCTe8VZcEJxXqnwaqFgKSsS9LhNsvdM
         tl5boNkQ9DOfVLIFy8QP8zuGyB+ZRB6QpW44Y8AgMfKg/dSL2Zi7fb7dxcr7cS8GtvBr
         vUG+miDiAkxObR0Wne3r2jVUorOhIbFbcFXuzN7/NEbTmZrBQnQK7BN7zEnfzQDZf8N8
         FOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686266976; x=1688858976;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HYQaZtuHl/SxeGLPx3KYJtDk+ilAjOX/gkAdD1/27NA=;
        b=aqXP+D60nHjyts+ynxCaftz4v7Oz/Hf1Tyrhb5pST+rVEs5f4/yDeerkA/UjTjLgFx
         ctMj6XMoOZBzvka+6x7cnCrar6iGOEtc0oaojR7SfZNqQPFcmT+8dCsqURXnBSBlJ8Tz
         o8exi7hWCdbwU3+oFQIIukLQRLxMCYoZ+qgFJ0G0AOoqMnuU0CLRqJsBjw0WGrjucuSy
         Y1K6eEe5SdPHfjtpuifBrlCM/gI8JxTZ+jsGlDVgwBXLD6p59l2uF+QtlsJ55ZkdhLD0
         pB/nXDlUwIb7t5w0Z3+/lRjHsXWIiWth2LmpyKflLuNQXO1SCowVRdN/zl7Vcaqw61BU
         JGIg==
X-Gm-Message-State: AC+VfDzHznc5ZrLGmraof3adu5MyWJsR9JeBIwjgEVZqFaiGuaX5MBT8
        EPPyrpxVR8xFHvSUMNrboKmudYPx8PyU
X-Google-Smtp-Source: ACHHUZ7PFDauXoTjxwgQr/iJ4YUhlHM8t/3S93+ayPur0CSD8Tq5qW6atfbI5j1wzr7n1r7hPNg/mO9mlqzf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a05:690c:2901:b0:55d:9e7c:72c0 with SMTP
 id eg1-20020a05690c290100b0055d9e7c72c0mr648158ywb.0.1686266976710; Thu, 08
 Jun 2023 16:29:36 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:28:07 -0700
In-Reply-To: <20230608232823.4027869-1-irogers@google.com>
Message-Id: <20230608232823.4027869-11-irogers@google.com>
Mime-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 10/26] perf header: Ensure bitmaps are freed
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

memory_node bitmaps need a bitmap_free to avoid memory leaks. Caught
by leak sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index d85b39079c31..3db7c1fae71e 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1389,6 +1389,14 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
 	return 0;
 }
 
+static void memory_node__delete_nodes(struct memory_node *nodesp, u64 cnt)
+{
+	for (u64 i = 0; i < cnt; i++)
+		bitmap_free(nodesp[i].set);
+
+	free(nodesp);
+}
+
 static int memory_node__sort(const void *a, const void *b)
 {
 	const struct memory_node *na = a;
@@ -1449,7 +1457,7 @@ static int build_mem_topology(struct memory_node **nodesp, u64 *cntp)
 		*nodesp = nodes;
 		qsort(nodes, cnt, sizeof(nodes[0]), memory_node__sort);
 	} else
-		free(nodes);
+		memory_node__delete_nodes(nodes, cnt);
 
 	return ret;
 }
@@ -1516,7 +1524,7 @@ static int write_mem_topology(struct feat_fd *ff __maybe_unused,
 	}
 
 out:
-	free(nodes);
+	memory_node__delete_nodes(nodes, nr);
 	return ret;
 }
 
-- 
2.41.0.162.gfafddb0af9-goog

