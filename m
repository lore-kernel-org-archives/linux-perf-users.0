Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9438AC6FD1C
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Mar 2023 18:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCVSbV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Mar 2023 14:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCVSbU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Mar 2023 14:31:20 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1975DEC2
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Mar 2023 11:31:17 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5446a91c40cso196965777b3.18
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Mar 2023 11:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679509877;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=34HlRQ1gcT2PlbL5hNFUNzD09FdwupW3+W5oKaTfGaY=;
        b=O0ViQe40TcY2A2J5cOabGBkGWQFtQspdCzkuQGVKNBhk7eetQCd72+6SxKbvBrkiUa
         PwErLKNGgWnWENtj1/HFLWHB+v8wjh0J4eBFkyrirgLenO0pH/ZG+NJQvQS/PaKqUUpx
         sk2l+rNOjKtuLWW04Qi+MLUtrJXX5nJQgvGCQV08OH6uwzLnIJxaQB5y4yuslBq8u7Eu
         lAFGCUMXRucgaTcK6/79iEGD3uTUkBeCbj2pyQIcMbVn1P0kkrtp+L9VzGWeCyBCvSoZ
         FDcUQXIrhIbNl5lTCuF761xhMrlazDZ/mp/hE56rv6qkYwdDysTOnZMDtwzxw299LnUI
         WAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679509877;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=34HlRQ1gcT2PlbL5hNFUNzD09FdwupW3+W5oKaTfGaY=;
        b=FLatfHItQGXs4QL9ba3T+T0tWagBHnZmy9T+E7cKgTXEFMBX17uSdwIjoRFBuavtRy
         fh9GpwYfabmGCl2Z41TLw6fvRWcjOe/mm4IDvnpL1lmoUM3pJ63/xhqpjzRpt9xIF2Ti
         hkH1Be4RAC3B4tf2Kd9bdUsxtrzXWsq3QNadpeWmmM69IjBH3J3PKUwNr2ElB9JwTtlh
         ESWEpdZ2JcaNZiLiVoKAYufg9uanbg607pRHe10B7bCoPddrv570nqUhRvFRME3lBZdn
         5FvW5y59XoSvPluaGlWsQe1iov/odGJ31oZEedzLhOdrH6qnKzXExFXRWWV4O8SEqxYA
         E2zg==
X-Gm-Message-State: AAQBX9cpXAtc1QdH6asc7dOpBlasl9ZP2GJtA+n9xiapLvt8N6hvWpg5
        NVQbIbP2g89mBh/Qht+besoKQyvTRBev
X-Google-Smtp-Source: AKy350YE7oxuhEOv3jwpAZPCZUoetgVOYeJAI4ABDQxnsPk4ZLX67WhN/2TPmuC7mynE2Gw1s8tvhxSJx4PB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6fe2:153b:3323:a17])
 (user=irogers job=sendgmr) by 2002:a05:6902:1083:b0:b67:d295:d614 with SMTP
 id v3-20020a056902108300b00b67d295d614mr402792ybu.12.1679509876553; Wed, 22
 Mar 2023 11:31:16 -0700 (PDT)
Date:   Wed, 22 Mar 2023 11:31:08 -0700
Message-Id: <20230322183108.1380882-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH] perf build: Add warning for when vmlinux.h generation fails
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The warning advises on the NO_BPF_SKEL=1 option.

Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index ed6b6a070f79..48aba186ceb5 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1072,7 +1072,11 @@ VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
 
 $(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
 ifeq ($(VMLINUX_H),)
-	$(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@
+	$(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@ || \
+	(echo "Failure to generate vmlinux.h needed for the recommended BPF skeleton support." && \
+	echo "To disable this use the build option NO_BPF_SKEL=1." && \
+	echo "Alternatively point at a pre-generated vmlinux.h with VMLINUX_H=<path>." && \
+	false)
 else
 	$(Q)cp "$(VMLINUX_H)" $@
 endif
-- 
2.40.0.rc1.284.g88254d51c5-goog

