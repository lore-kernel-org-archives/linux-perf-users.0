Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4BCC48BE5
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Jun 2021 18:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A01C2613E1
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Jun 2021 18:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhFQSor (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Jun 2021 14:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbhFQSop (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Jun 2021 14:44:45 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93303C061767
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Jun 2021 11:42:36 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id r22-20020a37a8160000b02903ab435911daso2810742qke.20
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Jun 2021 11:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5DjNG/5LrW+h84YK4KYw+ImmLTxQ10GkkIqN1ecfe50=;
        b=U67lanHkkfa0ltY86P0m9Lk89MeEmTbJ+2mZ9Wqd1wYOQ5MgP7PXnYgh0iY/U8haW5
         DQaO04AZkL/bvpONjjQxefNZN6I2pDT6LJ+nm4fSNjlvGETIdULShNNbcyjmu0hmVNW4
         cihAn6VL4SPwgfX3jvOHDr2hJ17hbhADYfnf0x4B7NstfALSrmPgPwo93ItstMBbg6DP
         aHzAL+owhPPtmiV8kUwXrnwMrSVSn5zB3MQBoG/W13kTXPib25bOfH8nWkuDtKn8H2XI
         vN5f/ixpv7jS2hsL0b6EV/oTaeBgoFX5HL4W5fBlH1wbI07LxZwmVseHGk8cBlx3ooYw
         CfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5DjNG/5LrW+h84YK4KYw+ImmLTxQ10GkkIqN1ecfe50=;
        b=r0W24ti8lEpds14N8n6Q823cbDuXAGeDnBrd4TcOTUuiuAGAoZH6m6nwQZDzVr7HE6
         zaVMhvsGSCUb+3q/nMoLayL2BqS1HYUMi4iYHwbQPPKmBYx3orYbzl8j75uSQTlf9xU5
         IU69U4yYYELEw7XCeGbcHyziB1H+ENvNJ/JqMXfFCHnfQcKZzxsT1PRnosIfAO0luG5q
         9WHWZtje2l2RCo+LSx2RfXfdg2TPsIQJjbnlwKSGWWDImmboxYJSIpZrubPzvg+e4IKj
         2jRjTGGAEwJfuoDGkf257vx+GPw0DhKviRvAUorw2EV8Q5MWR29LvjpHeO19L/5bYJ5Y
         NB6A==
X-Gm-Message-State: AOAM533WtxXASy7TeGpFoufPB2uQh5SUFJAfMSy+Y8p3HjhOrj3G7Fn8
        x6JiqkAH/KuHXpaWGK47L2KJ8e/dd7pj
X-Google-Smtp-Source: ABdhPJwzE0fiA+ui94SKI9ag06uXUpN6/xN+13AkJwieIj2mSxVaBw+2ipmvQVZW7nK8sWjK5SCrg5eB0O9I
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ef90:beff:e92f:7ce0])
 (user=irogers job=sendgmr) by 2002:a25:43:: with SMTP id 64mr8267727yba.109.1623955355646;
 Thu, 17 Jun 2021 11:42:35 -0700 (PDT)
Date:   Thu, 17 Jun 2021 11:42:16 -0700
In-Reply-To: <20210617184216.2075588-1-irogers@google.com>
Message-Id: <20210617184216.2075588-4-irogers@google.com>
Mime-Version: 1.0
References: <20210617184216.2075588-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 4/4] perf test: Make stat bpf counters test more robust
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If the test is run on a hypervisor then the cycles event may not be
counted, skip the test in this situation. Fail the test if cycles are
not counted in the subsequent bpf counter run.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index 81d61b6e1208..2aed20dc2262 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -31,7 +31,15 @@ if ! perf stat --bpf-counters true > /dev/null 2>&1; then
 fi
 
 base_cycles=$(perf stat --no-big-num -e cycles -- perf bench sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
+if [ "$base_cycles" == "<not" ]; then
+	echo "Skipping: cycles event not counted"
+	exit 2
+fi
 bpf_cycles=$(perf stat --no-big-num --bpf-counters -e cycles -- perf bench sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
+if [ "$bpf_cycles" == "<not" ]; then
+	echo "Failed: cycles not counted with --bpf-counters"
+	exit 1
+fi
 
 compare_number $base_cycles $bpf_cycles
 exit 0
-- 
2.32.0.288.g62a8d224e6-goog

