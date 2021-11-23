Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8CFC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Nov 2021 02:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhKWCGy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 Nov 2021 21:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhKWCGx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 Nov 2021 21:06:53 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911C7C061574
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Nov 2021 18:03:46 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id a4-20020a170902ecc400b00142562309c7so8433597plh.6
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Nov 2021 18:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mCG2EkJgLXs3VzB2yS60DRxHDbgccQCeWEISvmdZxAU=;
        b=WhKJhSKtLOE2tXSXLxlXSix7MuLflb/ADC/DKa0qkrU/si5YGPwODFIR2OOWnYRi/o
         p4WmIUvPFdbBTIxqyXxCXq7eNV107o/uVBMVWQF+O6LdYBoOutamgp4qPgaMLBW0QgBs
         A4Sa5nbY6HTO1rzibqh6hbDR/UazhrTAhTEDLBIAioMXhGzkH/42DFDi9H73BBw/9PRf
         PkTUFZhftuOFup9vOBQeJc1UY75XwyZd86PaRQ4c50vxVlKXn6rUR9sv/QwfUXevhGmc
         D5z/5tuspEcNg3vYAYjufqFLjI6xuK3lphVbX4Xdg6rUp4OtU3Bdgd6wsLzM6NSaiAnU
         xJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mCG2EkJgLXs3VzB2yS60DRxHDbgccQCeWEISvmdZxAU=;
        b=oIqmbnj6Q/YqJHLe9NoCg2iLA1U447k8HhynqnCbeZG3bZe9lPZnYbm0JwO9hKAZvz
         JNgAAvw8PWgzjaLnflFqaZxCaSrMlPGYOCNg7nxG+QVFpFNrqHI7oHb0AIP6d8IbYUIw
         QSqZRtrkHuvOzBVdP7jw6ZdfvUhIcXj3jXvcKLBXLVabAdMaV1yW9ZQFbF8ABPpAKNbr
         Z0CNDwcRH5lIThKHFn5i0nhXxLK/D7mzTqypHHZMBU2PgvJb0/+OEORSxABp06XRwO5f
         dfT/q1KbHWQoxEeB4krSshQzlBqjZJcx1aIaL/yTeJuChk0ShP25IuD+n5c+o3JhF5Ji
         w8nQ==
X-Gm-Message-State: AOAM532xyNAGVr9umIYEE8DLn1MDqPD4ip1Y/GpIsEfpmgFhIFDaXGYo
        darmc7QNeK6JR8kCp7GI7WLq3SIII6YN
X-Google-Smtp-Source: ABdhPJzYpwbOCyYeo5AmGM4njFhRvnWsJJKkBrA/U43GJhqP3/h39CsWrtrzFH6YLm6v6YsuJTb9lGBh0w9n
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8e01:f22:909b:4ff])
 (user=irogers job=sendgmr) by 2002:a05:6a00:1344:b0:49f:f357:ac9 with SMTP id
 k4-20020a056a00134400b0049ff3570ac9mr1597645pfu.62.1637633025007; Mon, 22 Nov
 2021 18:03:45 -0800 (PST)
Date:   Mon, 22 Nov 2021 18:03:40 -0800
Message-Id: <20211123020341.3073673-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 1/2] perf test: Enable system wide for metricgroups test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Uncore events as group leaders fail in per-thread mode causing exit
errors. Enable system-wide for metricgroup testing. This fixes the HPC
metric group when tested on skylakex.

Fixes: 4a87dea9e60f ("perf test: Workload test of metric and metricgroups")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metricgroups.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
index de24d374ce24..cb35e488809a 100755
--- a/tools/perf/tests/shell/stat_all_metricgroups.sh
+++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
@@ -6,7 +6,7 @@ set -e
 
 for m in $(perf list --raw-dump metricgroups); do
   echo "Testing $m"
-  perf stat -M "$m" true
+  perf stat -M "$m" -a true
 done
 
 exit 0
-- 
2.34.0.rc2.393.gf8c9666880-goog

