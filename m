Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ED2C4332F
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Nov 2022 00:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbiKQAoU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Nov 2022 19:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbiKQAoQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Nov 2022 19:44:16 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B36391E5
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Nov 2022 16:44:15 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 204-20020a2510d5000000b006be7970889cso60039ybq.21
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Nov 2022 16:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SNMS71QGgMyiDDcWnBqT0Vm7b+FlfXyIrhX2KKNl5vU=;
        b=WRkngDm1nYoGTot/sMk//vv3KXsXqd/uIWKtg/grIq0H+xPrEXDqaBUe0J/gYuNXY8
         epZ7tmWH6ueR2brySRXtPAZdekjSznygksUy9A4cJ/Y+gX+zovyXvzrHqOInNyxhEkHA
         U5yHRo3Fzo9qN7OnPnsipbq9Z3lbjaF+tnmIemeCfFB/QoQUYHby4EgxScXo+gTOU+pK
         SnE2mwS96obcbXoaAFyuSktQ35I2qoCcfnjJTwaxjBXXiXMJSljr97YgCMAHwZ9M2AhW
         x8kBYiUxDUBxKxnjEX22HwDbcFZWbs2EM0AT2sQk/hkURh4GmKZv6I9AE6JKKiEkB1ke
         8zLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNMS71QGgMyiDDcWnBqT0Vm7b+FlfXyIrhX2KKNl5vU=;
        b=tgfrczrCt3G7y8fcWiALnB7Ni6KOzpPXY2QAfEfAFJze8c7VcgQUwZt40qWeoOzxAE
         A+zB5Fjs3dJ8gyY8V9Ovj6BrfNaQUA8bogdLt96NHPMipy+TUQVLYUWfm+YfED9PqLrQ
         lVrHubh6guXbd0mHrT7qPNGLgDwvVE+lXHzt0MsZ4U/7K9VERQdDhePGk3ZPtPKW5eNF
         9ilOnk+GPQsqElKjRU/KLMyj8HtVQQKKGUrqdm++ScaXbuJPmGgBBl6LVPjp56cDeDs/
         R8X5mMGEHeVgKLHtJrYwFtXzuCoX3f0m2gU2Kd+b7vy15+GiwX52fxbssWB4otoWOuMx
         12cg==
X-Gm-Message-State: ANoB5pmRuDhxjKfGBh/5aePZ+SAjEzrWVNyK87Obk8V6zNrfoDB7Fu44
        MguYv81d/RAyd5AUGf7yjzXh6oDZkbr6
X-Google-Smtp-Source: AA0mqf4+Le8z4l+/dOM/XNbLjn6WfB0Io92l349YHxi1tHD+Bh9fprUmk8VeKaN6lsaI7QOT9S/8LvO3GIJ5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c14c:6035:5882:8faa])
 (user=irogers job=sendgmr) by 2002:a0d:e743:0:b0:378:5f13:25d1 with SMTP id
 q64-20020a0de743000000b003785f1325d1mr4585850ywe.192.1668645854440; Wed, 16
 Nov 2022 16:44:14 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:43:51 -0800
In-Reply-To: <20221117004356.279422-1-irogers@google.com>
Message-Id: <20221117004356.279422-2-irogers@google.com>
Mime-Version: 1.0
References: <20221117004356.279422-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH 1/6] tools lib api: clean up install_headers
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add missing backslash that caused an install command to always appear
in build output. Make the install headers more specific.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index 3e5ef1e0e890..3649c7f7ea65 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -100,12 +100,12 @@ install_lib: $(LIBFILE)
 		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
 
 install_headers:
-	$(call QUIET_INSTALL, headers) \
+	$(call QUIET_INSTALL, libapi_headers) \
 		$(call do_install,cpu.h,$(prefix)/include/api,644); \
 		$(call do_install,debug.h,$(prefix)/include/api,644); \
 		$(call do_install,io.h,$(prefix)/include/api,644); \
 		$(call do_install,fd/array.h,$(prefix)/include/api/fd,644); \
-		$(call do_install,fs/fs.h,$(prefix)/include/api/fs,644);
+		$(call do_install,fs/fs.h,$(prefix)/include/api/fs,644); \
 		$(call do_install,fs/tracing_path.h,$(prefix)/include/api/fs,644);
 
 install: install_lib install_headers
-- 
2.38.1.431.g37b22c650d-goog

