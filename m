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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38804C2B9F4
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Jun 2021 05:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1EB1613E9
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Jun 2021 05:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhFQF6G (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Jun 2021 01:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhFQF6G (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Jun 2021 01:58:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719CAC061574
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Jun 2021 22:55:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l132-20020a25258a0000b029054fc079d46eso4406873ybl.20
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Jun 2021 22:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5AKRc/Tyl7/UWLGnci1bpGmI6p8IqmaAxP2aPTqH0hQ=;
        b=AaZVjgDLLLHop7LLCrszEFvWruoGRBTtwkcJ06RU4YAZ6z5enhXgjIhksmLhY0H8wT
         BLtCZ5jzjQ6n1iJdaXRHEEy58y9aiHjevV8wBtmfgz367K1Bhn2h9iLehvtfwBE3W697
         PM0H94MWQOfjrhv/szi5BG0zBp2dp6fW5Kc/BVkVvLhsNI4eBnSq3XP2Sria27OwbKRY
         BFRW6Xg7VjADyYFyg5uNAs25KARBJ0Ki+rbEsQdKmJpTullgHVEJ2dISStX3w4fkMrtX
         kA3FJ+KKFafBjXePKWD0VRFx/vjBTepJ1b5axf+dTOLbgZDmzHAmQKth9n1MzxFY3tP6
         TFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5AKRc/Tyl7/UWLGnci1bpGmI6p8IqmaAxP2aPTqH0hQ=;
        b=Q3vIawR20tzsSHrMBQMdVa7/2rU7OCuSJiXO7PKsEUJy8dPzRWGrFRjCRwIS8X6Nb+
         4FIKlwVLdQRPBa9GKIYkms0+LpcTmyYRQ3rErBnziVIoiAEbvLDgOW7jVKTbB2gzV6I3
         zkuz5nnStMinBMqBdjONk8g9G0+1mHO0JYR6FNFVCsgp/UpZay0kKr+eQy6mCHscgCiy
         voR5Y+qOTt6KH2fDMTfCNUkKzzZ9tmzZIghUMIKuqdje3yM+LmGrkww0roChXy1yzvQm
         zyQxYnicPj2kFnvUOgE9HOY4+80q+sutR3LDHq8IGE6xcQxNuDFTK8dbkkyrboJwX1+W
         OUAg==
X-Gm-Message-State: AOAM53208q09beCiw9A2j9WcmPEXSU9Fn5MwvgGWHa+9wuZPcbIybV6B
        OeVPatDD7Ip5cGhoTVkyTC72dE1AfdHo
X-Google-Smtp-Source: ABdhPJzSYNbTKM5jaqik1OKzD0OTGqTVbJhv+gfqO2D38kZGM9jxPlCtkOOQjvOWGk5hDVY2i2yhM7pUcsuL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6cac:20e4:fbbd:d6e8])
 (user=irogers job=sendgmr) by 2002:a05:6902:100e:: with SMTP id
 w14mr3902788ybt.232.1623909358554; Wed, 16 Jun 2021 22:55:58 -0700 (PDT)
Date:   Wed, 16 Jun 2021 22:55:54 -0700
Message-Id: <20210617055554.1917997-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH] perf daemon: Avoid msan warnings on send_cmd
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

As a full union is always sent, ensure all bytes of the union are
initialized with memset to avoid msan warnings of use of uninitialized
memory.

An example warning from the daemon test:

Uninitialized bytes in __interceptor_write at offset 71 inside [0x7ffd98da6280, 72)
==11602==WARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0x5597edccdbe4 in ion tools/lib/perf/lib.c:18:6
    #1 0x5597edccdbe4 in writen tools/lib/perf/lib.c:47:9
    #2 0x5597ed221d30 in send_cmd tools/perf/builtin-daemon.c:1376:22
    #3 0x5597ed21b48c in cmd_daemon tools/perf/builtin-daemon.c
    #4 0x5597ed1d6b67 in run_builtin tools/perf/perf.c:313:11
    #5 0x5597ed1d6036 in handle_internal_command tools/perf/perf.c:365:8
    #6 0x5597ed1d6036 in run_argv tools/perf/perf.c:409:2
    #7 0x5597ed1d6036 in main tools/perf/perf.c:539:3

SUMMARY: MemorySanitizer: use-of-uninitialized-value tools/lib/perf/lib.c:18:6 in ion
Exiting

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-daemon.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 61929f63a047..c13201fb09c3 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -1403,8 +1403,10 @@ static int send_cmd(struct daemon *daemon, union cmd *cmd)
 
 static int send_cmd_list(struct daemon *daemon)
 {
-	union cmd cmd = { .cmd = CMD_LIST, };
+	union cmd cmd;
 
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.list.cmd = CMD_LIST;
 	cmd.list.verbose = verbose;
 	cmd.list.csv_sep = daemon->csv_sep ? *daemon->csv_sep : 0;
 
@@ -1432,6 +1434,7 @@ static int __cmd_signal(struct daemon *daemon, struct option parent_options[],
 		return -1;
 	}
 
+	memset(&cmd, 0, sizeof(cmd));
 	cmd.signal.cmd = CMD_SIGNAL,
 	cmd.signal.sig = SIGUSR2;
 	strncpy(cmd.signal.name, name, sizeof(cmd.signal.name) - 1);
@@ -1446,7 +1449,7 @@ static int __cmd_stop(struct daemon *daemon, struct option parent_options[],
 		OPT_PARENT(parent_options),
 		OPT_END()
 	};
-	union cmd cmd = { .cmd = CMD_STOP, };
+	union cmd cmd;
 
 	argc = parse_options(argc, argv, start_options, daemon_usage, 0);
 	if (argc)
@@ -1457,6 +1460,8 @@ static int __cmd_stop(struct daemon *daemon, struct option parent_options[],
 		return -1;
 	}
 
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.cmd = CMD_STOP;
 	return send_cmd(daemon, &cmd);
 }
 
@@ -1470,7 +1475,7 @@ static int __cmd_ping(struct daemon *daemon, struct option parent_options[],
 		OPT_PARENT(parent_options),
 		OPT_END()
 	};
-	union cmd cmd = { .cmd = CMD_PING, };
+	union cmd cmd;
 
 	argc = parse_options(argc, argv, ping_options, daemon_usage, 0);
 	if (argc)
@@ -1481,6 +1486,8 @@ static int __cmd_ping(struct daemon *daemon, struct option parent_options[],
 		return -1;
 	}
 
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.cmd = CMD_PING;
 	scnprintf(cmd.ping.name, sizeof(cmd.ping.name), "%s", name);
 	return send_cmd(daemon, &cmd);
 }
-- 
2.32.0.272.g935e593368-goog

