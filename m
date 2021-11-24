Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FEFC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Nov 2021 00:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240640AbhKXAPy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Nov 2021 19:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240626AbhKXAPt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Nov 2021 19:15:49 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7B7C061748
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Nov 2021 16:12:41 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id j204-20020a2523d5000000b005c21574c704so1330019ybj.13
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Nov 2021 16:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FMQLoym76yTY3cbbWiDyiD1lX2+hK6fXMJaMyVRGwOw=;
        b=AWpUKpb0KSKbrdbu1mh+AZEdbD+zBfEYhRuXEbgQK9NfvoamznxsfGEEbYA8nASbV/
         a2q8tfmH4+V2b9kjV7Gukpa0sA8UAS2H7TqqdHOGiXpeQ2vi9eLnl1+E6b/3ug697CZD
         X8fwy7sPB738DUXZGtK6p80xo41z5nRIgdJV8mwNeHR5WIOaADIM07kFD6eXOXm4sEFz
         Ed+naMEDGutYnicCbdjqVcPsVFa9lwA3qbF2xBJSLiRdz4I1s0xu9pSpLkHuRN3vkpNC
         r3dA1dqeeZ/W2Zi9eKzl+k81rL3FWD8/TXEWV5vmkHENeMwkj+3hIT/RFoVLtw7AZe2F
         uWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FMQLoym76yTY3cbbWiDyiD1lX2+hK6fXMJaMyVRGwOw=;
        b=5xgoJjYGgapdAMig6JF+EG1AwZlOm2ElSNO3T91rEnEjIfMwX9lEOhuc5IGVLxYRvP
         VXXFBYn81nT2ZXPub0swAI6AW2qrx2I5ysAAQdewvywK1pCcnoNnnYk0kE9b3amql3B0
         Hs1JH8UwNijNMxwsqEePtwrHZFEFvz8CU81yePjCvF43WdMB2SKbH5nraKqqSzdduW5t
         Is8xrh9HNGJCAD2FCg7dleuNcfFMaHN3JdallNzUwX62wCNwXChN222wiYIpSrkTo9SC
         3OY/UxyofFgR/7mqj9lpEhSb3ZDRwZRdoNMy76mdQZ5+GDxlbPhn85DM9TzGAyfpwbAG
         AzHw==
X-Gm-Message-State: AOAM533kopA2UbA6BePwNQYaSnyqRd2ALg0elB2dE/aK2L8dM8Z/OpRk
        lE5Te53xlumBDPzmc1Nwiun3a+DQD7LA
X-Google-Smtp-Source: ABdhPJxfbN5bm4/pMvsei3gAQF3f1rEdcQiM4aXoXXoyppKvaGYqByDhM/DKgh6lj3OCKDycrutx7xdSbaCq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dbab:a6fe:1e3a:91fa])
 (user=irogers job=sendgmr) by 2002:a25:8006:: with SMTP id
 m6mr10964861ybk.488.1637712760261; Tue, 23 Nov 2021 16:12:40 -0800 (PST)
Date:   Tue, 23 Nov 2021 16:12:31 -0800
In-Reply-To: <20211124001231.3277836-1-irogers@google.com>
Message-Id: <20211124001231.3277836-4-irogers@google.com>
Mime-Version: 1.0
References: <20211124001231.3277836-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 4/4] perf tools: Probe non-deprecated sysfs path 1st
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Following Documentation/ABI/stable/sysfs-devices-system-cpu the
/sys/devices/system/cpu/cpuX/topology/core_cpus is deprecated in favor
of thread_siblings, so probe thread_siblings before falling back on
core_cpus.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/smt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
index 2636be65305a..2b0a36ebf27a 100644
--- a/tools/perf/util/smt.c
+++ b/tools/perf/util/smt.c
@@ -79,11 +79,10 @@ int smt_on(void)
 		char fn[256];
 
 		snprintf(fn, sizeof fn,
-			"devices/system/cpu/cpu%d/topology/core_cpus", cpu);
+			"devices/system/cpu/cpu%d/topology/thread_siblings", cpu);
 		if (sysfs__read_str(fn, &str, &strlen) < 0) {
 			snprintf(fn, sizeof fn,
-				"devices/system/cpu/cpu%d/topology/thread_siblings",
-				cpu);
+				"devices/system/cpu/cpu%d/topology/core_cpus", cpu);
 			if (sysfs__read_str(fn, &str, &strlen) < 0)
 				continue;
 		}
-- 
2.34.0.rc2.393.gf8c9666880-goog

