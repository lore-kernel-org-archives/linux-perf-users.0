Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A88C32771
	for <linux-perf-users@archiver.kernel.org>; Sat, 24 Sep 2022 11:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbiIXLd7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 24 Sep 2022 07:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiIXLd6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 24 Sep 2022 07:33:58 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F63FB484
        for <linux-perf-users@vger.kernel.org>; Sat, 24 Sep 2022 04:33:57 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l10so2304465plb.10
        for <linux-perf-users@vger.kernel.org>; Sat, 24 Sep 2022 04:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=0DmqEWVeIfx21hMNe6tukUIZuj/O+XKYgF8Y5KtyMa4=;
        b=JPyGb0q6RLf+jbIkzwyIgs5Ss1fu4pPv6esvZIq9Qu3L5VGrPOsDFsm4MTiRI+IB6m
         MVxh7FWmdZ576ow4jtG6BBUs+2SHlJwZZShfA1ylPVqV3O3yE5wNaBiYkAck1gwfIl5n
         lKsCzJ/8jkuwM1CYsiRuJDFXvH+7V2Lpw/sMfm9UG7QC4CvaTBp7jYYTm2MAfluQJ5ky
         J3qUkt+bJPrtJSb7Z9rMYj5XHry9cxTBmhxKC0hlCDl/NnwiWAwFBzBGgKfUsYajGQ5c
         vMBKoLLHQ5vYy097/9hgUtki9gvQ/3asTjkNbkl2lw3sOgwOEvcg/y/ZBuAuP66gnbOz
         59EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=0DmqEWVeIfx21hMNe6tukUIZuj/O+XKYgF8Y5KtyMa4=;
        b=OWLyqiPp39g6oS4K0L57UC1okocxScr+vqwpFrq1JRBGsXkuodXpwjbo8QUxbPBV67
         6P+MPLqo8Yz8CYGBnrOtUkR9o5S58TQtECh06yo1TSBn0r2FYYYs9++vdPhnxrsTozDJ
         23y4A93+2RIomeVK/zVREXbCDknWp6YZTkvo2zUpCt5aMcgSMkj3VNkAV7puyp2mhMg9
         cSmBBO5b7oqtz8phC85+Z6BoyNQX4vMNJSSO9bZtRAv1b9hgOD/7jyhc6xvyoSbbF7jT
         5YqSgRg2v8yAjkVDQO72H5Dqbv1J2bg6HkmjIi2UZ5uzKDf4d2OjJ9XCUAc9L40E1Xso
         Uyzg==
X-Gm-Message-State: ACrzQf3vbq+Ly9HnqFZ06a5PJ1bGU0DfYhYmggHtadRGP9YVIjZ2BjJR
        +d7G/RF0RN3LAV9v1Wn+BP8hOg==
X-Google-Smtp-Source: AMsMyM7lZ/jA2HDaObnwd/XVY+VvWfjkRDpLlk7c4s+b8a2DrNg6bDCiWP0CZ6QPossorwONi1+w7A==
X-Received: by 2002:a17:90b:1642:b0:203:1630:c54d with SMTP id il2-20020a17090b164200b002031630c54dmr25673580pjb.122.1664019236793;
        Sat, 24 Sep 2022 04:33:56 -0700 (PDT)
Received: from leoy-huanghe.lan (ec2-13-52-75-203.us-west-1.compute.amazonaws.com. [13.52.75.203])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c94300b00176acd80f69sm7654540pla.102.2022.09.24.04.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 04:33:56 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf record: Fix segmentation fault in record__read_lost_samples()
Date:   Sat, 24 Sep 2022 19:33:46 +0800
Message-Id: <20220924113346.1110909-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Commit a49aa8a54e86 ("perf record: Read and inject LOST_SAMPLES events")
causes segmentation fault when run the "perf mem record" command in
unprivileged mode, the output log is:

  $ ./perf mem record --all-user -o perf_test.data -- ./test_program
  Error:
  Access to performance monitoring and observability operations is limited.
  Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
  access to performance monitoring and observability operations for processes
  without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
  More information can be found at 'Perf events and tool security' document:
  https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
  perf_event_paranoid setting is 4:
    -1: Allow use of (almost) all events by all users
        Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
  >= 0: Disallow raw and ftrace function tracepoint access
  >= 1: Disallow CPU event access
  >= 2: Disallow kernel profiling
  To make the adjusted perf_event_paranoid setting permanent preserve it
  in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)
  perf: Segmentation fault
  Obtained 16 stack frames.
  ./perf(dump_stack+0x31) [0x55b7aa1e8070]
  ./perf(sighandler_dump_stack+0x36) [0x55b7aa1e815e]
  ./perf(+0xc9120) [0x55b7aa0a9120]
  /lib/x86_64-linux-gnu/libc.so.6(+0x4251f) [0x7fd03ef8151f]
  ./perf(+0xccaca) [0x55b7aa0acaca]
  ./perf(+0xcf4ab) [0x55b7aa0af4ab]
  ./perf(cmd_record+0xd50) [0x55b7aa0b28df]
  ./perf(+0x112f77) [0x55b7aa0f2f77]
  ./perf(cmd_mem+0x53b) [0x55b7aa0f406c]
  ./perf(+0x19979c) [0x55b7aa17979c]
  ./perf(+0x199a37) [0x55b7aa179a37]
  ./perf(+0x199b95) [0x55b7aa179b95]
  ./perf(main+0x2c7) [0x55b7aa179fbd]
  /lib/x86_64-linux-gnu/libc.so.6(+0x29d8f) [0x7fd03ef68d8f]
  /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x7f) [0x7fd03ef68e3f]
  ./perf(_start+0x24) [0x55b7aa089974]
  Segmentation fault (core dumped)

In the unprivileged mode perf fails to open PMU event, the function
record__open() returns error and "session->evlist" is NULL; this leads
to segmentation fault when iterates "session->evlist" in the function
record__read_lost_samples().

This patch checks "session->evlist" in record__read_lost_samples(), if
"session->evlist" is NULL then the function directly bails out to avoid
segmentation fault.

Fixes: a49aa8a54e86 ("perf record: Read and inject LOST_SAMPLES events")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-record.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 02e38f50a138..012b46dd4999 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1888,6 +1888,10 @@ static void record__read_lost_samples(struct record *rec)
 	struct perf_record_lost_samples *lost;
 	struct evsel *evsel;
 
+	/* No any event is opened, directly bail out */
+	if (!session->evlist)
+		return;
+
 	lost = zalloc(PERF_SAMPLE_MAX_SIZE);
 	if (lost == NULL) {
 		pr_debug("Memory allocation failed\n");
-- 
2.34.1

