Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADA3C4332F
	for <linux-perf-users@archiver.kernel.org>; Sat, 17 Dec 2022 22:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiLQWwE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 17 Dec 2022 17:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQWwC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 17 Dec 2022 17:52:02 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E5AFCF3;
        Sat, 17 Dec 2022 14:52:01 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id w26so3971691pfj.6;
        Sat, 17 Dec 2022 14:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AWLW65I8qjKVa0Ai5KVgxGMrzsCA8DgxU3k5GOi6ig8=;
        b=JdOQaL6gxjvrbbgRNKp7HR5WSKuNJ4so3SdZR78PQrOmjbj/sfRV5RZVhCflkAWioq
         aZMZ0w8DuM3ZudF2l7CgdK6nSreJHzRfEiQkVysAtcUd3sQuuOl1xNIsHVvzC/L41iWz
         oDsz8BlJaElg7p6IIGh4Fi2ZFdesTW+Dv06HimxsS2TUjwgUBascpgpicqqj7N+3/eoZ
         bNX2h6Xw7i2AsWyg0Kb6AtWqhVyI8lBrqY1K/5ZqZqxRazpr9TcgfDO2Y6BpKqfT8eBM
         FVQjjc/D84cT3noOlqH0UsGA18qNmaKyORlOWER2Nz+4lhT+3jTg0bOI/39qhVWG2Iqx
         /6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWLW65I8qjKVa0Ai5KVgxGMrzsCA8DgxU3k5GOi6ig8=;
        b=gBu8k2+9PqEfqwMyxUba0LHSi17E3ndxkzWDxIhAMdTtuDWgEHaqHpxZzpyRgj10os
         7BiOfisdrurQxjuvYYsiaHZTvvFlOka4h0bowK2tZc6ACh7AoOhhMSH7yk2M/9YknRvM
         tnP7bdXbiIT5u1HilvQdk8EXIBJONy0pPGxzOIwuGIMrNaXp+daHE/ut83Ff/5a9vNGd
         rcq6k8sxGJF6pKrT3itjHaFE3urc5sQdzdHA5maafTLWRZMLUIRMd1h9CPI/88JJPqhJ
         uzf0JY0V2LbXXx21XhzT9niQXy8jac5KpSLFqE3nhA/6a+hBY+H8mAuQ7veov0ns5Aqt
         0aYA==
X-Gm-Message-State: AFqh2kpTdi/bCLVTWDGQUgOfrbaUxY9iZBV/O0H/uRFADARoQng181k/
        pRNpg02kG1gKmVQ/0n5QJGRSd34Q+ksb+A==
X-Google-Smtp-Source: AMrXdXu5X+t9idHr7HL06hCtiQIwOE8RBSPyz+tzknz1s19c1QA5usboGiydiIShrQ9Ir9YjxNq3aw==
X-Received: by 2002:aa7:953a:0:b0:57d:8b30:db0a with SMTP id c26-20020aa7953a000000b0057d8b30db0amr5053486pfp.9.1671317521218;
        Sat, 17 Dec 2022 14:52:01 -0800 (PST)
Received: from WRT-WX9.. ([103.135.102.144])
        by smtp.gmail.com with ESMTPSA id e26-20020a63745a000000b00477bfac06b7sm3508103pgn.34.2022.12.17.14.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 14:52:00 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH] perf: makefile: add .DELETE_ON_ERROR special target
Date:   Sun, 18 Dec 2022 06:51:51 +0800
Message-Id: <20221217225151.90387-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

As kbuild, this adds .DELETE_ON_ERROR special target to clean up
partially updated files on error. A known issue is the empty vmlinux.h
generted by bpftool if it failed to dump btf info.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 tools/perf/Makefile.perf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 9b7886ce0674..13e7d26e77f0 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1151,3 +1151,6 @@ FORCE:
 .PHONY: archheaders
 
 endif # force_fixdep
+
+# Delete partially updated (corrupted) files on error
+.DELETE_ON_ERROR:
-- 
2.37.2

