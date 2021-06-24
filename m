Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785BFC49EA5
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Jun 2021 23:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51ACA610A2
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Jun 2021 23:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFXXXK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Jun 2021 19:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFXXXJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Jun 2021 19:23:09 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F747C061574;
        Thu, 24 Jun 2021 16:20:48 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso4694230wmj.0;
        Thu, 24 Jun 2021 16:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tynx7/ji7qxXMIJIZtJuHZtyFCUB2offXSh0P39+R2s=;
        b=KcHjN4jUwD8Dd8a9LQS+FhJXk/im8QA5pS/XRMIoKSXIEptGpP2BK42ygSG6TckkIz
         nNvxWu725La9xMqxCdfw/n5pBLrqecdkyZYu2b1ypuWyOEZhzwXIcs/JHv9wFWk48oPc
         LuvXm3l1OmXIhJm1sfhhh7m073uGs7U9XdxY1SjpKmuGA1wecdt2GGCgsPiVKp6oHZAR
         66FkdgqhVMqweyDvuxE9GlkoPXav2KZGNwFDIpmIpA9E/cETcwxR0tQ26Cu2dsPI9iHl
         TBcP/Z9JT10ThTZtLnlMsfhxj6G8bDAYCkiQot5cX+zV/xj7nIDurjA4+NWa4tm7fAD4
         Weig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tynx7/ji7qxXMIJIZtJuHZtyFCUB2offXSh0P39+R2s=;
        b=jfiaCiC4OM1pebDFT14zZkV8w5oS4jeELxsA15wc2jUmNBN3w4QfALVM1CMZ/QX9oe
         RKyoHM48q9bYoyUhkGEcAwPNRmlvWgAa81LSP/Mk61TjHJcztDSY5DrLoLe4gB/FAkIh
         EjtnTxCVjDr7bjM38e7xUd7c/9xoe4N4oICl1xwj/27JDBg8N6LjPkH9rHaqK5GILFrV
         xVNmrUEI8yW+bLwoOc5o+AOE92ptJeOPknyLBk4Qef8qFYdlPM9JWOLdJRX5TWQg5oiR
         d7dA6f5QhfJEmwnxpu1zCW+2km7C5mL82g3TSsGYMgYLItIAlIkcy0jjkpHnfYAejjpQ
         unkg==
X-Gm-Message-State: AOAM530Z+2N86RCDWHlt2AotUG+CFVYHDW1KyDwo+aa0YEP4HzxDPetc
        u8GazGyVJxWMn7RFX60WXyE=
X-Google-Smtp-Source: ABdhPJwAYhz7MV69FZpF2/qyo/m6EeR1vg9UQ3nif0zGzpbYTPjdnC+EAKTTlBbsNcdam8iNw+sXWQ==
X-Received: by 2002:a05:600c:2e53:: with SMTP id q19mr7184074wmf.147.1624576846969;
        Thu, 24 Jun 2021 16:20:46 -0700 (PDT)
Received: from honeypot.epfl.ch ([151.29.44.148])
        by smtp.googlemail.com with ESMTPSA id r10sm4368658wrq.17.2021.06.24.16.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 16:20:46 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf session: add missing evlist__delete when deleting a session
Date:   Fri, 25 Jun 2021 01:19:25 +0200
Message-Id: <20210624231926.212208-1-rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports a memory leak caused by evlist not being deleted on exit in
perf-report, perf-script and perf-data.
The problem is caused by evlist->session not being deleted, which is
allocated in perf_session__read_header, called in perf_session__new if
perf_data is in read mode.
In case of write mode, the session->evlist is filled by the caller.
This patch solves the problem by calling evlist__delete in
perf_session__delete if perf_data is in read mode.

Changes in v2:
 - call evlist__delete from within perf_session__delete

v1: https://lore.kernel.org/lkml/20210621234317.235545-1-rickyman7@gmail.com/

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

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/session.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index e59242c361ce..c36464d94387 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -301,8 +301,11 @@ void perf_session__delete(struct perf_session *session)
 	perf_session__release_decomp_events(session);
 	perf_env__exit(&session->header.env);
 	machines__exit(&session->machines);
-	if (session->data)
+	if (session->data) {
+		if (perf_data__is_read(session->data))
+			evlist__delete(session->evlist);
 		perf_data__close(session->data);
+	}
 	free(session);
 }
 
-- 
2.31.1

