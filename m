Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D2BC77B61
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Apr 2023 20:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjDJU5Q (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Apr 2023 16:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjDJU5P (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Apr 2023 16:57:15 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92509E6F
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Apr 2023 13:57:12 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54c23fab905so107771397b3.14
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Apr 2023 13:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681160232;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6eWdwxWRwdg0pvB9ya1oVsLyAMFn35+DKvPw/ISvipM=;
        b=T98oZDCxgiHCzwDXkKbhGsgymW0xwvMT8iBLAh2F2NvU6OsgmVhIOSlzp1Hx5Yo//u
         Dt5Scfnh6xQoeDKp7Xx910fMdfnDAqA23wDkZ7xJA9/zgCK8kibTcjsOt2A7ibO4od3q
         gi0s9bBpf17h06J0MZlc4G86tkFSRUQLZZRRvoEYayat6eVcKR7n37AyVeynJ/qDIxX4
         kgxq2o1KeJvjNiL3cIMXmTSr+Ux3xx5g8KwxaGd/gLj6KgFTDUCIn7QWUPWpFhx3rL+R
         4RNsAzXPP5KpCaE+gv+d+G9AHjyV13c/gqKYL48LFP0X+8TqwOb+LE2T4Q1u1i2HMcme
         dG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681160232;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6eWdwxWRwdg0pvB9ya1oVsLyAMFn35+DKvPw/ISvipM=;
        b=tVJeAMoMbm4QhqR9Hc3m6r/Pj3ikbFTqpjDwrOWBkns/yCxqeA1bvfjIFrjlHVlfKC
         JnCAQivXmjxw+rfIOhB5doIN2L58ThLOCBww9KfRmZ/JJzeUDe7XdjH+4LYwZC02hbFJ
         2S4jPsCaZOtVx8Hnqm2TIJXUppVGKnbb3w9evEL5zRbJ4HnC1W7ge0js4F/IQreOdecW
         u1z+y4Z4Xy2lEgMwhpMBR3OQHwMvJlV2GYBTPLXamoOtY9FjFY8J34rvse5YAsuzllLx
         YEdzkEyyzXQbwPSNBmknIXo/+vkgiVu5pbpDAkkwYh579JnZCnCyUT1hd1j9gu+slsMR
         Cvkw==
X-Gm-Message-State: AAQBX9dlpDNvUbIdswmhw4RA8aHWeBByuu3gldWD9xk7HW/Ogo7QLU2X
        dILknwgYnj3bQB/Iq475Ba5HihlebE1Z
X-Google-Smtp-Source: AKy350Yhn2aHlm6QXiur02De6NeXu8XVPTzikkL9VweYciL94aEaHYwHofbx50eIZ/EYPXm8Yrrur2nK9KL9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fc51:6a03:541d:a18d])
 (user=irogers job=sendgmr) by 2002:a0d:ec50:0:b0:54d:913b:c9e8 with SMTP id
 r16-20020a0dec50000000b0054d913bc9e8mr4548477ywn.5.1681160231741; Mon, 10 Apr
 2023 13:57:11 -0700 (PDT)
Date:   Mon, 10 Apr 2023 13:56:59 -0700
Message-Id: <20230410205659.3131608-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v1] perf evsel: Avoid segv if delete is called on NULL
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
        Kan Liang <kan.liang@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Seen in "perf stat --bpf-counters --for-each-cgroup test" running in a
container:

libbpf: Failed to bump RLIMIT_MEMLOCK (err = -1), you might need to do it explicitly!
libbpf: Error in bpf_object__probe_loading():Operation not permitted(1). Couldn't load trivial BPF program. Make sure your kernel supports BPF (CONFIG_BPF_SYSCALL=y) and/or that RLIMIT_MEMLOCK is set to big enough value.
libbpf: failed to load object 'bperf_cgroup_bpf'
libbpf: failed to load BPF skeleton 'bperf_cgroup_bpf': -1
Failed to load cgroup skeleton

    #0 0x55f28a650981 in list_empty tools/include/linux/list.h:189
    #1 0x55f28a6593b4 in evsel__exit util/evsel.c:1518
    #2 0x55f28a6596af in evsel__delete util/evsel.c:1544
    #3 0x55f28a89d166 in bperf_cgrp__destroy util/bpf_counter_cgroup.c:283
    #4 0x55f28a899e9a in bpf_counter__destroy util/bpf_counter.c:816
    #5 0x55f28a659455 in evsel__exit util/evsel.c:1520
    #6 0x55f28a6596af in evsel__delete util/evsel.c:1544
    #7 0x55f28a640d4d in evlist__purge util/evlist.c:148
    #8 0x55f28a640ea6 in evlist__delete util/evlist.c:169
    #9 0x55f28a4efbf2 in cmd_stat tools/perf/builtin-stat.c:2598
    #10 0x55f28a6050c2 in run_builtin tools/perf/perf.c:330
    #11 0x55f28a605633 in handle_internal_command tools/perf/perf.c:384
    #12 0x55f28a6059fb in run_argv tools/perf/perf.c:428
    #13 0x55f28a6061d3 in main tools/perf/perf.c:562

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dc3faf005c3b..fe3ce765a4f3 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1541,6 +1541,9 @@ void evsel__exit(struct evsel *evsel)
 
 void evsel__delete(struct evsel *evsel)
 {
+	if (!evsel)
+		return;
+
 	evsel__exit(evsel);
 	free(evsel);
 }
-- 
2.40.0.577.gac1e443424-goog

