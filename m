Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8230AC433FE
	for <linux-perf-users@archiver.kernel.org>; Sun, 12 Dec 2021 13:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhLLNrm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 12 Dec 2021 08:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbhLLNri (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 12 Dec 2021 08:47:38 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDD9C061751
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Dec 2021 05:47:37 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v1so44559781edx.2
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Dec 2021 05:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rK1kg3BdhZ6vLWzAC/NJououZjpKNDWOeE95mIOHLwM=;
        b=ldSwe0RjVRHsN8mMDq8u31wWcE0Ai3OmoE/gzxo9Ee3YJREu6xjReDIro45Uk+mZC2
         PUXywo8tMs4T/Z4qdwrFNYHQJqX33Vf94B7C+Cn2wILZncUXqKm2UaB9Ce3cBG94cD8Z
         MGUbvOpVuxJxWf16wDm5LzPjN4vKr7vWLQSixfUtE/MPP5NYnx9RoVcl69krk4qWV7QO
         RgZZ3FcjcJxFsmliE3cuLA0+KRzOzL2sKhDiiO5gaCX6X0dr2iAYBq6sTJd768vj0mT5
         9fc5XLoSOOq31k7MYQg7DWH2doGIhUEuYsc5vrpgrU8K8yMOBdC7ZwhpHa5R8FAFNCDS
         UEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rK1kg3BdhZ6vLWzAC/NJououZjpKNDWOeE95mIOHLwM=;
        b=TNKGVH2K19mHTUbmN48TS+Q8IypajV/hJhXfDplSQ+Z/I2bQadf5E8sAFbcD+IrvNe
         rAi53FDSXgnxBhFmPR83ZXmi5tH8SWW2mnHmAE2jNY/p5MVFm9VsdJ0G5B22Q8A1ftH0
         Qk/yCU1X+ypYBVoaGYx5+MA5++9f0AaPWKta68dpW+JEcZKDxYHY24Wi/VxJSDV6RJi9
         wInqCcW0feoMwXyTmXIy5zwQ5zozEbWmZuR4cJLRyGM6jW+DQNrCIPZguTz+89wOPRRf
         4KM+uQ4glZYl7ClmUSsi2beb0d0WT7X5/DWsk2fm4iWv+oNgZLuPJGTxgHIv0PCaK+q7
         aaAg==
X-Gm-Message-State: AOAM532/H/XXrCOCMe7hgFhDwUU04RG4qtn5AEjFgNntNkab7I/+amfg
        oM+87q5P9zswO9TWz4H3lTWwmw==
X-Google-Smtp-Source: ABdhPJzjWwtlbpO7/42zB/Kq1uP/6C0lh8G/iFpj6GJmFlQsf7lZb5/ZwrXmB5hFGU/usI1ePolpfw==
X-Received: by 2002:a50:e0c9:: with SMTP id j9mr56003635edl.336.1639316855926;
        Sun, 12 Dec 2021 05:47:35 -0800 (PST)
Received: from localhost ([104.245.96.202])
        by smtp.gmail.com with ESMTPSA id i4sm4082449ejz.122.2021.12.12.05.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 05:47:35 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/2] perf evlist: Don't run perf in non-root PID namespace when launch workload
Date:   Sun, 12 Dec 2021 21:47:21 +0800
Message-Id: <20211212134721.1721245-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211212134721.1721245-1-leo.yan@linaro.org>
References: <20211212134721.1721245-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

In function evlist__prepare_workload(), after perf forks a child process
and launches a workload in the created process, it needs to retrieve
process and namespace related info via '/proc/$PID/' node.

The process folders under 'proc' file system use the PID number from the
root PID namespace, when perf tool runs in non-root PID namespace and
creates new process for profiled program, this leads to the perf tool
wrongly gather process info since it uses PID from non-root namespace to
access nodes under '/proc'.

Let's see an example:

  unshare --fork --pid perf record -e cs_etm//u -a -- test_program

This command runs perf tool and the profiled program 'test_program' in
the non-root PID namespace.  When perf tool launches 'test_program',
e.g. the forked PID number is 2, perf tool retrieves process info for
'test_program' from the folder '/proc/2'.  But '/proc/2' is actually for
a kernel thread so perf tool wrongly gather info for 'test_program'.

To fix this issue, we don't allow perf tool runs in non-root PID
namespace when it launches workload and reports error in this
case.  This can notify users to run the perf tool in root PID namespace
to gather correct info for profiled program.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/evlist.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 5f92319ce258..bdf79a97db66 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -11,6 +11,7 @@
 #include <poll.h>
 #include "cpumap.h"
 #include "util/mmap.h"
+#include "util/namespaces.h"
 #include "thread_map.h"
 #include "target.h"
 #include "evlist.h"
@@ -1364,6 +1365,12 @@ int evlist__prepare_workload(struct evlist *evlist, struct target *target, const
 	int child_ready_pipe[2], go_pipe[2];
 	char bf;
 
+	if (!nsinfo__is_in_root_namespace()) {
+		pr_err("Perf runs in non-root PID namespace; please run perf tool ");
+		pr_err("in the root PID namespace for gathering process info.\n");
+		return -EPERM;
+	}
+
 	if (pipe(child_ready_pipe) < 0) {
 		perror("failed to create 'ready' pipe");
 		return -1;
-- 
2.25.1

