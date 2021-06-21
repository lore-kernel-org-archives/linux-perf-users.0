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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95302C49EA5
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 21:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 793F461360
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 21:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhFUV7O (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbhFUV7N (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Jun 2021 17:59:13 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECD3C061756
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jun 2021 14:56:58 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id q20-20020a0cf5d40000b029027498137223so3525510qvm.15
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jun 2021 14:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gKtEXdH2Nx268P6rXxdFqr+OoxaI6ttnIQOvnZF/0dA=;
        b=P/rlbyxwsp6ZshUS6sfulzKZK7nUGluueOk8obRwKeSTExQb0SYgYYv4hyYUm8XkI8
         OvlWjFYjQfucnhGYRaUBWm17KPz7zQtqe0m5X78EuMa6F970tM62fsSoD+14b4tD6gEV
         aSpxVYIas/gHuPY1o+jb0MPYJ7XKlOV49MKAVKjJSIIoGqN9HEYJ0zvFmb2I0RUE7eiI
         /xYaQACjzYqKH3zb1N3vHv5ZSzW0G9Bs/fPZm0NAv2Pc2uYrs4iudmmyDR5oBkrk6lV+
         fjfOmZTzA1PZS4/O2Pht6T17q7HuDnXhQiX/y5Mg0Q1mvEwDAxvkuepxxE3qfkDukyzc
         SJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gKtEXdH2Nx268P6rXxdFqr+OoxaI6ttnIQOvnZF/0dA=;
        b=fVIohlZWQiSu3ycoH2k17ZWoMzGdougsVM46F44Ko6Gz5tyxk/1e6phA1DcixlVihI
         cuusjyvNanhze1VFYvNDTGf+mscjaXu4SKABMWFlFReGDEhCKjcG1TvqtlfWNJCdtQ4s
         rvH+iJwMb/Ok3/qdHvYli+nDBAWBwAiBcbPc4qnCxgniVDeQijJnmor15KgwB6b7EMgN
         H3eGUmqJYFOm+9yQRTDxddF8QkvpQy7FZA749PjVYqgIRrJmW/ydcnWB1pTs9UCCG4jL
         dvfa1fle1GClkwln4Wfa1czGGO7U33pyJ56woJNZDBgBltHIlUpwqirBpeoXTj8/1TKl
         mlUg==
X-Gm-Message-State: AOAM532/xR+zdmyZ/UJ8QLEOGyrmVnCuXSwUuU6+xppKB1TW1UNiGi68
        hsb0xiLJLHzQVLbZ8KvIzuUqrZ4TdmOi
X-Google-Smtp-Source: ABdhPJzgyeCAgazYmeNf8rJ2OwwEv8oUVZtJVF6ZWaW32G4LBTJ7DhWecTIa0hW5LwFJz5dih8yLnCCDJJui
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ffd6:b7f5:87ee:7be2])
 (user=irogers job=sendgmr) by 2002:a05:6214:20e3:: with SMTP id
 3mr22082009qvk.48.1624312617995; Mon, 21 Jun 2021 14:56:57 -0700 (PDT)
Date:   Mon, 21 Jun 2021 14:56:48 -0700
In-Reply-To: <20210621215648.2991319-1-irogers@google.com>
Message-Id: <20210621215648.2991319-3-irogers@google.com>
Mime-Version: 1.0
References: <20210621215648.2991319-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH v2 3/3] perf test: Make stat bpf counters test more robust
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
index 85eb689fe202..6b156dd85469 100755
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

