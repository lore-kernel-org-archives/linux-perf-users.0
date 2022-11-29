Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC433C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Nov 2022 19:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbiK2Tan (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Nov 2022 14:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236082AbiK2TaY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Nov 2022 14:30:24 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9593F2630
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Nov 2022 11:29:34 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i10-20020a25f20a000000b006ea4f43c0ddso14248521ybe.21
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Nov 2022 11:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0IUlOBzNYwGwCi/kB8Fps4nNnJDZbsGKlmWKEqCDmL4=;
        b=XvfjvKZWRz3BpkA0IL/xKRzPSSQ0ZNVzAKAZwUyMZTFds48yAOihgfktestrOPCJIG
         5g3Z2g9OzLAOUqkmej5idDjZa8WFQJ2XzhSqKsbP63Bm3EGjgX+nGmuiB0BN0q4JyPFp
         51035iIhlvXvBLbMP+V9tvW2cOexrSnsm+Ogh78MtAezWX5UBLaU+HDC/uHDFXFRARqE
         6mFhSwMQcDTHCXaz7fzxV6O1YE4TDyZYpfuYDYJcqegrb3GZVxK5ESl6DAlQ5j6f7CE4
         WdsB7MIoGBsYPG+kLF3nd7hGmS9QD2GMbeXI8LgSr80S+HBLyum+k0sT1QCAXyAGX8IA
         BhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0IUlOBzNYwGwCi/kB8Fps4nNnJDZbsGKlmWKEqCDmL4=;
        b=XX+W9fZiEu45jO9WNO2S+tiRhFjAah3uUhKqgeiOaANF1VAhefMZfN+DP4O9yUdVC5
         RchmEBQyvdE3b0C+dG38RCXXhoHVtPLHz0xc3x+Sqd9ToacDh9TYzTv2Bhl/PbjSdwcJ
         sGgAD/njaI5MljLn8wWf/sOP/HEnoTmewApI7uX7SXJCxvYObcE1gRtN7Bqa8D89E42o
         7qTdxWYFVEKPnoKRsZWJgKAEltlG/zTWej0dD5eEV8hrUdnKMh9s5tlQCM9SqWvwbqS/
         0+Gm0X3rYOnB1/Dv2NDO4LVbEwUZn3ZzgdkEBdL6Pwp4Nhs/TrYbSGStYlnOIENrLYKa
         GvtA==
X-Gm-Message-State: ANoB5plQfY67xbryBob5dH1vsi6zXR8fDpj6JeOsOuWQRD0WYeLJwsTj
        AXcK8S0h5Np6pEc2gIDZK0vGloIUuSYW
X-Google-Smtp-Source: AA0mqf4kxsZ4UL67ZqkI8S97E4rFaKUqDzyi+0fTNj/ukTeJjZ8XZ8ob+aIirVIuSDmzsxW8PfYgat8up1oy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:788c:ccf4:3670:3362])
 (user=irogers job=sendgmr) by 2002:a25:8e82:0:b0:6d2:70d5:3ed0 with SMTP id
 q2-20020a258e82000000b006d270d53ed0mr56790224ybl.457.1669750173767; Tue, 29
 Nov 2022 11:29:33 -0800 (PST)
Date:   Tue, 29 Nov 2022 11:29:24 -0800
Message-Id: <20221129192924.1580537-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Subject: [PATCH] perf build: Fixes for LIBTRACEEVENT_DYNAMIC
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If LIBTRACEEVENT_DYNAMIC is enabled then avoid the install step for
the plugins. If disabled correct DESTDIR so that the plugins are
installed under <lib>/traceevent/plugins.

Fixes: ef019df01e20 ("perf build: Install libtraceevent locally when building")
Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a17a6ea85e81..f4cd946fe91a 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -884,7 +884,7 @@ $(LIBTRACEEVENT_DYNAMIC_LIST): libtraceevent_plugins
 
 install-traceevent-plugins: libtraceevent_plugins
 	$(Q)$(MAKE) -C $(LIBTRACEEVENT_PLUGINS_DIR) O=$(LIBTRACEEVENT_PLUGINS_OUTPUT) \
-		DESTDIR=$(LIBTRACEEVENT_PLUGINS_DESTDIR) prefix= \
+		DESTDIR=$(DESTDIR_SQ) prefix= \
 		$(LIBTRACEEVENT_FLAGS) install
 endif
 
@@ -1093,7 +1093,11 @@ install-tests: all install-gtk
 		$(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
 	$(Q)$(MAKE) -C tests/shell/coresight install-tests
 
-install-bin: install-tools install-tests install-traceevent-plugins
+install-bin: install-tools install-tests
+
+ifndef LIBTRACEEVENT_DYNAMIC
+install-bin: install-traceevent-plugins
+endif
 
 install: install-bin try-install-man
 
-- 
2.38.1.584.g0f3c55d4c2-goog

