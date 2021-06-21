Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AD8C4743C
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 23:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D60C60FE7
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 23:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhFUXqW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Jun 2021 19:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhFUXqV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Jun 2021 19:46:21 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99FCC061574;
        Mon, 21 Jun 2021 16:44:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f15so6032365wro.8;
        Mon, 21 Jun 2021 16:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dkfEivTJ/i26MPVfrBKgtPUKbo9w17uJTMSrgD2eqdY=;
        b=oYVrW9ZO5ZsWfZI7ky1Mi50azrN2wO3BB81Tmwchom8xnc5uqZRVf34P29fNovw2Dz
         ZNQibF1z0lANfFpD1rjk385hAwrl2f2v+fXyjqP8iG2Qr9OwrVdNh4ot0M9YWrJ+jQxA
         EkbnAn0kvMThOcKNIFwUop8kzTSlAV4tkxXRywF/+4mxhAXtaH8v890XlNE54Aqtta6i
         wiWlp+z5eJj6d8wmNiYAd1F94pPQoy3Q2cYE23lNtIgK2T/z3BPjFIBPoxmIqwjurycT
         WIFBW17NpULpCuq29xKvhW07MqzLbBro4s11hf/kCGBYRTEBHMwuZIa89lVQgsML20Cj
         fY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dkfEivTJ/i26MPVfrBKgtPUKbo9w17uJTMSrgD2eqdY=;
        b=epE83YzNBCla7/TUoIrVDJMTJpGmCoaObcz7nblcx6pXOfODl+jy560PQszczTtAMN
         2cDatYQsZOUjM/Hu+uITqwYjfveEqDAv9pqu29lazyd/yPBzxj5T6RBQdT9lIJcE2vEM
         2Mhvke3xGmOSD+mxCA9ylDMaBoHolnuZmaaf898fgsCyiIXLyLbFce8x88a9yZ08pJe8
         c27Tweku0qzJ6QYeExYjnTWqiGbzMkNImIpODUB3GRPp6x4ZOnEeG/212dAVYrO06AvA
         ccyY2UKgP4wacpOn8fL2BFLCZG8lhYz97U70yNVaqecWyGQ9jpMPfq4+OeFlbHhf8ZNt
         RU7A==
X-Gm-Message-State: AOAM530+BTwvApTedoUirlKDeTNfV7WwaXKTnYuK2PxjoejFLBJQLrkY
        qGQpGRhyCfbr7fywTM9Iwy8=
X-Google-Smtp-Source: ABdhPJz2G+xhicVhcujyn9BYWbKTDJZXahzlmrvJ5VgRC+iRhErU8dSXo8i70WHbATY3t7/YrTXiag==
X-Received: by 2002:a05:6000:1a41:: with SMTP id t1mr1043592wry.175.1624319044213;
        Mon, 21 Jun 2021 16:44:04 -0700 (PDT)
Received: from honeypot.. ([151.29.45.200])
        by smtp.googlemail.com with ESMTPSA id n18sm473130wmq.41.2021.06.21.16.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 16:44:03 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] perf: add missing evlist__delete when deleting
Date:   Tue, 22 Jun 2021 01:43:16 +0200
Message-Id: <20210621234317.235545-1-rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports a memory leak caused by evlist not being deleted on exit in
perf-report and perf-script.
The problem is caused by evlist__delete not being called before
perf_session__delete, since the latter does not delete the evlist too.
These two patches add the missing deletes in both perf-report and 
perf-script.

ASan report follows:

$ ./perf script report flamegraph
=================================================================
==227640==ERROR: LeakSanitizer: detected memory leaks

<SNIP unrelated>

Indirect leak of 2704 byte(s) in 1 object(s) allocated from:
    #0 0x4f4137 in calloc (/home/user/linux/tools/perf/perf+0x4f4137)
    #1 0xbe3d56 in zalloc /home/user/linux/tools/lib/perf/../../lib/zalloc.c:8:9
    #2 0x7f999e in evlist__new /home/user/linux/tools/perf/util/evlist.c:77:26
    #3 0x8ad938 in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3797:20
    #4 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
    #5 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
    #6 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
    #7 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
    #8 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
    #9 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
    #10 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
    #11 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)

Indirect leak of 568 byte(s) in 1 object(s) allocated from:
    #0 0x4f4137 in calloc (/home/user/linux/tools/perf/perf+0x4f4137)
    #1 0xbe3d56 in zalloc /home/user/linux/tools/lib/perf/../../lib/zalloc.c:8:9
    #2 0x80ce88 in evsel__new_idx /home/user/linux/tools/perf/util/evsel.c:268:24
    #3 0x8aed93 in evsel__new /home/user/linux/tools/perf/util/evsel.h:210:9
    #4 0x8ae07e in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3853:11
    #5 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
    #6 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
    #7 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
    #8 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
    #9 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
    #10 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
    #11 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
    #12 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)

Indirect leak of 264 byte(s) in 1 object(s) allocated from:
    #0 0x4f4137 in calloc (/home/user/linux/tools/perf/perf+0x4f4137)
    #1 0xbe3d56 in zalloc /home/user/linux/tools/lib/perf/../../lib/zalloc.c:8:9
    #2 0xbe3e70 in xyarray__new /home/user/linux/tools/lib/perf/xyarray.c:10:23
    #3 0xbd7754 in perf_evsel__alloc_id /home/user/linux/tools/lib/perf/evsel.c:361:21
    #4 0x8ae201 in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3871:7
    #5 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
    #6 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
    #7 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
    #8 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
    #9 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
    #10 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
    #11 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
    #12 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)

Indirect leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x4f4137 in calloc (/home/user/linux/tools/perf/perf+0x4f4137)
    #1 0xbe3d56 in zalloc /home/user/linux/tools/lib/perf/../../lib/zalloc.c:8:9
    #2 0xbd77e0 in perf_evsel__alloc_id /home/user/linux/tools/lib/perf/evsel.c:365:14
    #3 0x8ae201 in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3871:7
    #4 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
    #5 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
    #6 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
    #7 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
    #8 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
    #9 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
    #10 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
    #11 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)

Indirect leak of 7 byte(s) in 1 object(s) allocated from:
    #0 0x4b8207 in strdup (/home/user/linux/tools/perf/perf+0x4b8207)
    #1 0x8b4459 in evlist__set_event_name /home/user/linux/tools/perf/util/header.c:2292:16
    #2 0x89d862 in process_event_desc /home/user/linux/tools/perf/util/header.c:2313:3
    #3 0x8af319 in perf_file_section__process /home/user/linux/tools/perf/util/header.c:3651:9
    #4 0x8aa6e9 in perf_header__process_sections /home/user/linux/tools/perf/util/header.c:3427:9
    #5 0x8ae3e7 in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3886:2
    #6 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
    #7 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
    #8 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
    #9 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
    #10 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
    #11 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
    #12 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
    #13 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)

SUMMARY: AddressSanitizer: 3728 byte(s) leaked in 7 allocation(s).

Riccardo Mancini (2):
  perf report: delete evlist when deleting session
  perf script: delete evlist when deleting session

 tools/perf/builtin-report.c | 2 ++
 tools/perf/builtin-script.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.31.1

