Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49D7C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Dec 2021 02:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243542AbhLHCuP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 7 Dec 2021 21:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243578AbhLHCuM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Dec 2021 21:50:12 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B5FC061756
        for <linux-perf-users@vger.kernel.org>; Tue,  7 Dec 2021 18:46:36 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id d27-20020a25addb000000b005c2355d9052so2151364ybe.3
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Dec 2021 18:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JL9xm0pQGWjwf/D+CorLwzYUYcl9IVQI3NDKsfgtnNk=;
        b=C9P3/WGinLrMKvSFzzif8NHIWpzFbfaMv5OWFjpGjE9dXlDuoJysDeX2XBtpbhdjMM
         fB9RjhQE20ez1WsJo6z5c1F6oWTcAkkMxst0JjdA4+TSNZtJtY+I9QMLZeHmdZyFzYPt
         3qWrer5wb8gPFZtfrQds6mSe4juDZzYBCAa77NA+cDcLqXSaANMtP9nYQqyL11EJXY3a
         wJ6/ZEtGpLzrwpWkqKaFde7Hj6Y37ClqDcM+a/EZfOi+9CCpnzTLNQNyVTlEWp4KJHxX
         m9KPxLkrABZSohO966ruLrh3PVBmeaNHyYdPCzJ7wN2jM+mTWFSUd8zMpJNWjtzaM2Vg
         J3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JL9xm0pQGWjwf/D+CorLwzYUYcl9IVQI3NDKsfgtnNk=;
        b=KojgVFglR/3TeAKRb/X+Ka1tWvhRwtYwawY93KB5n8VH5SOZzEicb9UTi3XBEf706t
         OJuOZ89SuWdSHMkSdvv7EKKHBdZ6U9wMEk6NHpJjuFWsXWofilqRYpDclrFNor0XItHi
         I4b2EPi6ECN0hIznfZUuij6fJToO8Ug1nbSJCN1bnvm0lNZreZPC/DnzcSYhMyORo0vL
         MtokzYlQMLnTJ5LW5M2WQCdu0UfutV9Zwc+ZLbPAIQSi+j7/b1VHZLia6QphnhEpqQW6
         T65098uOrkfNooGb0yq4CEcXtL8q5d15kjoXpQHnrLOG5Z8ghxCMNj3eNVoXWlQYCk5+
         /+AA==
X-Gm-Message-State: AOAM532NSDp2moZABV/Q4ejBfX0412ReTt2v4OhLaAfYKPnTF4vTawsA
        itLsPUx3RlgOZrPqMLCAre3yJh6gnYDv
X-Google-Smtp-Source: ABdhPJyJ0bej87Fe++nEKMg3a/0nS/mAECp36Njxy2YWfSsOX0jck/jJeh25/ElQ7Gfv8JWtc2Ax0+tWpmuM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:57e:1dbb:34b4:8257])
 (user=irogers job=sendgmr) by 2002:a25:cbd7:: with SMTP id
 b206mr55557475ybg.737.1638931596072; Tue, 07 Dec 2021 18:46:36 -0800 (PST)
Date:   Tue,  7 Dec 2021 18:45:55 -0800
In-Reply-To: <20211208024607.1784932-1-irogers@google.com>
Message-Id: <20211208024607.1784932-11-irogers@google.com>
Mime-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 10/22] perf cpumap: Add comments to aggr_cpu_id
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This code is already tested in topology.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index f0121dd4fdcb..edd93e1db36a 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -7,11 +7,20 @@
 #include <internal/cpumap.h>
 #include <perf/cpumap.h>
 
+/** Identify where counts are aggregated, -1 implies not to aggregate. */
 struct aggr_cpu_id {
+	/** A value in the range 0 to number of threads. */
 	int thread;
+	/** The numa node X as read from /sys/devices/system/node/nodeX. */
 	int node;
+	/**
+	 * The socket number as read from
+	 * /sys/devices/system/cpu/cpuX/topology/physical_package_id.
+	 */
 	int socket;
+	/** The die id as read from /sys/devices/system/cpu/cpuX/topology/die_id. */
 	int die;
+	/** The core id as read from /sys/devices/system/cpu/cpuX/topology/core_id. */
 	int core;
 };
 
-- 
2.34.1.400.ga245620fadb-goog

