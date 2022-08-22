Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98B6C28D13
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Aug 2022 21:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiHVVeE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 Aug 2022 17:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236898AbiHVVeD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 Aug 2022 17:34:03 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F00B4F194
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Aug 2022 14:34:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-333b218f2cbso206750027b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Aug 2022 14:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=PjKTkSpXN7z/1vO6BY9+ZapPx/17h+7Me4eIBkw8jXs=;
        b=tJw8ADOvD+JfoFv1mCrbL8K9kKBzqqJ1EKt8KjQblt7okK8atz7gbBE6d7S3t4H0i+
         3WifvVOXU8+vcq7InqpZxvC+4schTKAqIGm6pIGyHvoDfrUlZXYxpi/ols/FVXI7jJdw
         3bbaqhAW1NVUtEoMy5gI5wXpTNl5MHAw5Uo+tR5DqZmFvhWiLzAAuTiQG+qJeQmRfvp/
         YBpOIjq9X82GrRPGTW2fvGV3f7FwCISfZcRscWGJuW5z+wz1eNbl8fftQK2nqcDNYzAx
         TJ7qJuZtHsQKseBizo3gNLa3lUe+hzMv4yU7qNyhMGT1wM1dF0W3HKnNzQV30DfLVK5x
         UA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=PjKTkSpXN7z/1vO6BY9+ZapPx/17h+7Me4eIBkw8jXs=;
        b=cyHuu3yAOz1pl2Rcgk4UhdyzmhzYaIhjoR5eWXbIaTWT0stYOYUPkC9Mdg3pu4wscJ
         Z/iHwT7AZxO6lPCQccYAXaE1euyNivCpUTB9k76bg6kllZjuKeFlHCWRTgyrxa5bYjdI
         jy8apXlM5bWR7wJKH10sS3xOZRzNAQ1Bnyf3OAuww9hDg494RKmWFyOiUscJLEGtjLuL
         J+MX46bRn/Gruoy+LHImlawJQpoB0GpPEWfF6GKTavK9bMnGBKbJJpcJaeOWxDplwgQ5
         hTupOMR9Ok8Cv93Ak4p4/fbczc0TAvPyNhbg3RVXw/QrAjvaCdKo/I/N8GYry/FGKhMM
         +xkA==
X-Gm-Message-State: ACgBeo08eC1g905F9Dgo9t30zwen97QanWoPfBhN4vTEknCI79YBHMUh
        iUxOlPESJNXmUgZ9QLS/gGStHunfbLde
X-Google-Smtp-Source: AA6agR6xatGqBGUTcHv4+qKQeK4H3e5wE2VOPYMYZxC/z3a/ux9ueLbCKnh/zlVXmCFy7KgAZCcd0b9ZUOrd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:2768:cfe4:142e:cbca])
 (user=irogers job=sendgmr) by 2002:a25:5051:0:b0:68f:f31f:b590 with SMTP id
 e78-20020a255051000000b0068ff31fb590mr19311377ybb.569.1661204041297; Mon, 22
 Aug 2022 14:34:01 -0700 (PDT)
Date:   Mon, 22 Aug 2022 14:33:51 -0700
Message-Id: <20220822213352.75721-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v1 1/2] perf stat: Clear reset_group for each stat run
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If a weak group is broken then the reset_group flag remains set for
the next run. Having reset_group set means the counter isn't created
and ultimately a segfault.

A simple reproduction of this is:
perf stat -r2 -e '{cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles}:W
which will be added as a test in the next patch.

Fixes: 4804e0111662 ("perf stat: Use affinity for opening events")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7fb81a44672d..54cd29d07ca8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -826,6 +826,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	}
 
 	evlist__for_each_entry(evsel_list, counter) {
+		counter->reset_group = false;
 		if (bpf_counter__load(counter, &target))
 			return -1;
 		if (!evsel__is_bpf(counter))
-- 
2.37.2.609.g9ff673ca1a-goog

