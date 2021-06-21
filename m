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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B59C49EA2
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 21:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60AB06128A
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 21:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhFUV7M (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbhFUV7L (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Jun 2021 17:59:11 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66048C061574
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jun 2021 14:56:56 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id 61-20020aed21430000b029024e7e455d67so16790370qtc.16
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jun 2021 14:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=o7AiO7cf+g5j73bnIKC5PyTIHqUoKVu2uLnXWRb97sM=;
        b=ZArou9EpOMHKZdF4JziC2HUFizemZfHZxYohE3H/4NjcwmlquDQ2fdyZIrSB4+jrGa
         qKjnVY3MV7YctoL7xZq2jvEu2DE8x03uMjUTGvi63UUsOqaULaUISvn/ymiX17zzp1iX
         XYw12fKEsRvWK1PQmAa1IbLPJ6XP6a8/qfVSvp3poP9JHGMV+LAR+ou5QzseEkjnAG/R
         qWhObxJnFu16ryTZ0BP7ZKBAO9Qd4bBcKHX4Mqf8nJq70mUuiC4WTpb6qRbdUYj/4lZ3
         pcLQdqdBhNMd57MwVAA5807sijCAQ9PHJaAussOPguyfoICmC6VLJ3dTFDS4qE/2Gqwd
         cBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o7AiO7cf+g5j73bnIKC5PyTIHqUoKVu2uLnXWRb97sM=;
        b=teRyGqTG/qFZGHKadqGGAq1rZKGs5AXyy15OPvlW7mc4rZm6Ayqnz9mUceYALYuVqC
         XRquH6yZ0e67iEcyOTP86ycvquCdU+vKv03rY9Hx7wpmd/uZYdRKXK+05+JgjTSM0yfh
         CmTWbZKEXBtMYPrT+5Vbso4yIL9iNtifTKZqrqu1At6HTA5uqI9U+2CNPKjWfjqY2n/3
         saHj2AImwKJU4PWiR/3y9+oCtD3Gw2BmePJVLpJw+I51dTqCfpD5Yp7kepITtAMAGI5O
         IVim+paB7cd/vfcM5rUKQKuTRxg/7lMhxZ7YNoEW89MXAerA7/hzUPTqt3TvgqnZNz0n
         LDQg==
X-Gm-Message-State: AOAM531ANHvfUwUN7/HvGiJDII2NtJqVoK6NFtYOv1TtV7NX3weeR2PV
        rSmk9f5pgAYrNoo7qq6d/EQlpRN3aBNU
X-Google-Smtp-Source: ABdhPJyGBlSlo07F4G7w4AxwWPsxT8RK5eHECX8mtkRUDvlMQ9S86+4p8nnfQnKE92k781Q430veQF9794kH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ffd6:b7f5:87ee:7be2])
 (user=irogers job=sendgmr) by 2002:a25:cac4:: with SMTP id
 a187mr112611ybg.423.1624312615504; Mon, 21 Jun 2021 14:56:55 -0700 (PDT)
Date:   Mon, 21 Jun 2021 14:56:47 -0700
In-Reply-To: <20210621215648.2991319-1-irogers@google.com>
Message-Id: <20210621215648.2991319-2-irogers@google.com>
Mime-Version: 1.0
References: <20210621215648.2991319-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH v2 2/3] perf test: Add verbose skip output for bpf counters
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

Provide additional context for when the stat bpf counters test skips.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index 22eb31e48ca7..85eb689fe202 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -22,7 +22,13 @@ compare_number()
 }
 
 # skip if --bpf-counters is not supported
-perf stat --bpf-counters true > /dev/null 2>&1 || exit 2
+if ! perf stat --bpf-counters true > /dev/null 2>&1; then
+	if [ "$1" == "-v" ]; then
+		echo "Skipping: --bpf-counters not supported"
+		perf --no-pager stat --bpf-counters true || true
+	fi
+	exit 2
+fi
 
 base_cycles=$(perf stat --no-big-num -e cycles -- perf bench sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
 bpf_cycles=$(perf stat --no-big-num --bpf-counters -e cycles -- perf bench sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
-- 
2.32.0.288.g62a8d224e6-goog

