Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6065BEEAA56
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Sep 2023 16:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjINQki (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 14 Sep 2023 12:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjINQki (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Sep 2023 12:40:38 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF3CCA
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Sep 2023 09:40:34 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b56dab74bso16678837b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Sep 2023 09:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694709633; x=1695314433; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QYmpNCIo7S1JbJ44ilEiXHeDDJlt6tcG5Ns5Jhd3XZM=;
        b=t6E2bWAbD6/mIrBbqqzKCmGLfD32VYf/of3Uvrzh4rHsKLZ5iXmtkLduOvQU1LvuIT
         wI61AqQTIgXRr9vNVY+K/8uLKWUeTWWT1bLq6A4klhodTg43LhWOFSCIlY+mka0Os6JM
         xPCAgj5PbOSevGuQ5rxo5iKDTNAVEy6nHSxr9L85iZyvA0pyi3rarn5V9qcyKebYoqov
         W8ifisgC+NJWeQ4rb6J7Zru9JrCVn9LUpbz/AdD/dhbux193dVetHs1EdcwD3Teb8iYJ
         yKiYTQPCVehPD/asUx2fGUZTEMxkKW/jDNwDAGI8iIc26GhbrtQnbiRXJLuUQYy7mCF3
         a+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694709633; x=1695314433;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QYmpNCIo7S1JbJ44ilEiXHeDDJlt6tcG5Ns5Jhd3XZM=;
        b=tOHNExT2tcE7uuFVi6QbLOjqCKP6bHCjmg+ZCl9GNWQBuVv+v/H5Q3cL85GUHER/5n
         iEDLCrIaqIKUt+JQcxThXMooILtQ3pFLFLqwLnvE6djYmDJtrS9qt4m+fN8Ag4C3sfX9
         9l+DbNlbZRcivEni39EBssoVh/ixkuEmoodZmt0mp+d4WzP2Wkak2NIcd3aFUDpRQeC4
         mAhjnxt16AzotUTYR/2u5m7k/Cd8awtebuHGZX3FE+lfA+0OPWk3TpYIQYlCflEqJBMr
         Cvpe3mOQBfE21bpsQpAjuzkXtYd1UG3RpjsBarjZ6FmXZpMlEAaUkgsHqVMv2wgFpZSD
         FuNA==
X-Gm-Message-State: AOJu0Yyb9/Kcaf5AUWvu0zyD2PBD5gsgAYudK21u8xX5I638vWiTrFlk
        y4uZlwS+B+lJz9k9I+2waM8oVrjMY6gd
X-Google-Smtp-Source: AGHT+IF4R14T/+uUnZmMx+CGqiHrXqIWyNyHBK0SZp+FnnnCxwWbAN2jr+wYDbqyPBPL12biGairh8K/y6cD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5357:1d03:3084:aacb])
 (user=irogers job=sendgmr) by 2002:a05:6902:1447:b0:d7b:6e08:b432 with SMTP
 id a7-20020a056902144700b00d7b6e08b432mr145533ybv.10.1694709633363; Thu, 14
 Sep 2023 09:40:33 -0700 (PDT)
Date:   Thu, 14 Sep 2023 09:40:28 -0700
Message-Id: <20230914164028.363220-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1] perf parse-events: Fix tracepoint name memory leak
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        He Kuang <hekuang@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fuzzing found that an invalid tracepoint name would create a memory
leak with an address sanitizer build:
```
$ perf stat -e '*:o/' true
event syntax error: '*:o/'
                       \___ parser error
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events

=================================================================
==59380==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 4 byte(s) in 2 object(s) allocated from:
    #0 0x7f38ac07077b in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:439
    #1 0x55f2f41be73b in str util/parse-events.l:49
    #2 0x55f2f41d08e8 in parse_events_lex util/parse-events.l:338
    #3 0x55f2f41dc3b1 in parse_events_parse util/parse-events-bison.c:1464
    #4 0x55f2f410b8b3 in parse_events__scanner util/parse-events.c:1822
    #5 0x55f2f410d1b9 in __parse_events util/parse-events.c:2094
    #6 0x55f2f410e57f in parse_events_option util/parse-events.c:2279
    #7 0x55f2f4427b56 in get_value tools/lib/subcmd/parse-options.c:251
    #8 0x55f2f4428d98 in parse_short_opt tools/lib/subcmd/parse-options.c:351
    #9 0x55f2f4429d80 in parse_options_step tools/lib/subcmd/parse-options.c:539
    #10 0x55f2f442acb9 in parse_options_subcommand tools/lib/subcmd/parse-options.c:654
    #11 0x55f2f3ec99fc in cmd_stat tools/perf/builtin-stat.c:2501
    #12 0x55f2f4093289 in run_builtin tools/perf/perf.c:322
    #13 0x55f2f40937f5 in handle_internal_command tools/perf/perf.c:375
    #14 0x55f2f4093bbd in run_argv tools/perf/perf.c:419
    #15 0x55f2f409412b in main tools/perf/perf.c:535

SUMMARY: AddressSanitizer: 4 byte(s) leaked in 2 allocation(s).
```
Fix by adding the missing destructor.

Fixes: 865582c3f48e ("perf tools: Adds the tracepoint name parsing support")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 786393106ae6..a41c5d265d8e 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -103,6 +103,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %type <list_evsel> groups
 %destructor { free_list_evsel ($$); } <list_evsel>
 %type <tracepoint_name> tracepoint_name
+%destructor { free ($$.sys); free ($$.event); } <tracepoint_name>
 %type <hardware_term> PE_TERM_HW
 %destructor { free ($$.str); } <hardware_term>
 
-- 
2.42.0.283.g2d96d420d3-goog

