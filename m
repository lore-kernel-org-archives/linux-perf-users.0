Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39BEC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Mar 2022 09:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiC2JdY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Mar 2022 05:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiC2JdX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Mar 2022 05:33:23 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92EC123BEE
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Mar 2022 02:31:39 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u3so23925148wrg.3
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Mar 2022 02:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mol8cznyjFxndyug6ujfLFzjwVmzbwHtru6cjLlZhCo=;
        b=GFSuTgep9fw97+Fe9X/KjoPCWdufLmIv+PeBPByVwYsOgJaC9oTfSCd0l7GqCL8Dcm
         m8zb41DZm1P8YO9lq30AG64cwwH2zk/8ykqC8gqzu7Hsf40oNGcfSR81qWAWYRfISZuu
         kEi0+Zl/BEb3r4oSa56Tx2xjTJSSjgeksL5cpVRBm/Om/fj1Tz+s3i1MvRmO4USSXKQl
         tmiZWCxZxSKACyxnjDO+RyDOs++KxtODBeUci0HlujnEtxVOTnq3dMJ2kmXzhjXwLwir
         IQ24gRhXr9v1dez+6wkgOVcTteaj4BCNTL8VOlNWam4nNG2tFQzn7QNIhUnqvC0OC5o9
         uGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mol8cznyjFxndyug6ujfLFzjwVmzbwHtru6cjLlZhCo=;
        b=t3OdotFlu2oSAL2XiDSnZy6cK6BaEjWvkDTTjnzoDXaxSqXixYVCXbKczkPFh5QPa9
         1TlSFG62TTwtW3IbZB6Kn2Ja4cQ68/vksVxZCz3Um7E+LSmg8TPQUD4CN0M7BXpwSdjz
         IOaMMvtpaFRPfYRC23zOcaq2h6attxcCW6DovvB6lCJSpyikT+bdZ5sw5WT661h6b5Z9
         zAM4XOXDKKRSXpFU4CGHY+9Lgq2LRZ87QmzM0AvQgInncxfTwo2Hr/OnEedLlemJ9+W3
         aFaPM5mfKsXTUHop72r2YiZk8Pt8FUs9YwULI0ohO2fki699SsAGkxu6OjDgZWAUc/ZB
         4ilQ==
X-Gm-Message-State: AOAM533uh9ImBlqHcq47YMdoNmEIeRqh9gDWEXYB4WipAIDTdMATMU3x
        h8VkLjFQBy6QgKQ7fvJqxb1FrQ==
X-Google-Smtp-Source: ABdhPJwTZJc+0rU8LMKH4R6JCPF3SK5AElUoxXMtiJSUpVgNsGc1NvdKq51N3f/Ghl14dUK4u7/0TA==
X-Received: by 2002:a05:6000:181a:b0:205:9051:ab6d with SMTP id m26-20020a056000181a00b002059051ab6dmr29548959wrh.191.1648546298260;
        Tue, 29 Mar 2022 02:31:38 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id y15-20020a056000168f00b002057a9f9f5csm17480711wrd.31.2022.03.29.02.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 02:31:37 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>
Cc:     mptcp@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH perf] perf tools: .git/ORIG_HEAD might not exist
Date:   Tue, 29 Mar 2022 11:31:20 +0200
Message-Id: <20220329093120.4173283-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

It seems it cannot be assumed .git/ORIG_HEAD exists if .git/HEAD is
there.

Indeed, recently our public CI reported[1] the following error when
compiling Perf tool:

  $ cd tools/perf
  $ make -j4 -l4 O=/tmp/(...)/perf DESTDIR=/usr install
  (...)
  make[2]: *** No rule to make target '../../.git/ORIG_HEAD', needed by '/tmp/(...)/perf/PERF-VERSION-FILE'.

This is because apparently[2] Cirrus Ci uses a Git client implemented
purely in Go[3] to perform a clone. Most likely, this tool doesn't
create any .git/ORIG_HEAD file but .git/HEAD is there. The error can
indeed be reproduced by renaming this .git/ORIG_HEAD file while keeping
.git/HEAD. In other words, it means it is not enough to check the
presence of .git/HEAD to assume .git/ORIG_HEAD exists as well.

With the modification here, the version file is always regenerated if
.git/ORIG_HEAD file is not present. But that is not an issue as kernel
devs probably don't use such tools in their dev env and it can be
assumed for them that they have both .git/HEAD and .git/ORIG_HEAD files.

[1] https://cirrus-ci.com/task/5673396527693824?logs=test#L5026
[2] https://cirrus-ci.org/guide/tips-and-tricks/
[3] https://github.com/go-git/go-git

Fixes: 4e666cdb06ee ("perf tools: Fix dependency for version file creation")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/perf/Makefile.perf | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 9c935f86d172..2f64e4904bbb 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1143,10 +1143,12 @@ endif
 # Trick: if ../../.git does not exist - we are building out of tree for example,
 # then force version regeneration:
 #
+GIT-HEAD-PHONY =
 ifeq ($(wildcard ../../.git/HEAD),)
-    GIT-HEAD-PHONY = ../../.git/HEAD ../../.git/ORIG_HEAD
-else
-    GIT-HEAD-PHONY =
+    GIT-HEAD-PHONY += ../../.git/HEAD
+endif
+ifeq ($(wildcard ../../.git/ORIG_HEAD),)
+    GIT-HEAD-PHONY += ../../.git/ORIG_HEAD
 endif
 
 FORCE:

base-commit: ab0809af0bee88b689ba289ec8c40aa2be3a17ec
-- 
2.34.1

