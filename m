Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05341C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Nov 2022 07:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbiKHHgx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Nov 2022 02:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbiKHHgk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Nov 2022 02:36:40 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805502F650
        for <linux-perf-users@vger.kernel.org>; Mon,  7 Nov 2022 23:36:34 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-348608c1cd3so131176327b3.10
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Nov 2022 23:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lT5QMmKiixUc4hOkx2B5agh6ifSSv8GoT3OYojEFayc=;
        b=D5rnSL7fwnZjkagsZnhZ1GdO69qsrJGRorN4KrU99em/5NRO9j579+EPkMVFKodeyS
         sm1wLT1PqrTnTtXCHVlBvAZdKjpM8wS/5EyH8nA1Z9zzB6L/dNV0fQQ9pJVyixq1vza3
         s9acRiPe03RM2hsKVayAbi7thy7z89CNKDaHX4XZMjUKiKCeX3caYI/LABcb1M3lF31O
         LLTkVxZZfTYGA9YwJlepJGkApQ0KcffUe+kJ5gLez8VPPy//BO4y2qls0JQi2Li7bxDJ
         8qsfDfoXAH8KeweDpmrAVAPqL+z1B08rDsi711HzPQ2l8w2wgAn9T5llDyqNxaz2oycl
         VoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lT5QMmKiixUc4hOkx2B5agh6ifSSv8GoT3OYojEFayc=;
        b=05rh4bEoQRMyqP0e410/FVg4da70tfOwvQ7Ieq7C5303IMHRkZej/EAhWSRCmdhL+H
         PlHKOLaQyOONyH0GZDg0EezzFXdHDJsLUp/AlrALmtdNyNjfIxmveUI+sh+yXiqRribM
         0ibvTk4/s6+FZlvi0TQRSCaPnJu68R4S7UOeIZlwYRQGT3eQl5h7vVTZ3OGb+T3DQCaw
         LOkFPqaKxyMkigWvMpKYlcNy27t7JH4LjFldG5Axj/h0Pdsq42/xx7n2Kfozf7o8DLKL
         NVptC+vIkaTROIi62rmx2Q7WRjrcUXyiUO3aHr3qx7ykoqwnOhLYa8l1WyDsi2eAdeq3
         Xq/w==
X-Gm-Message-State: ACrzQf04o9oN6sVYmR+9qiCmjs0pZHPfbT3iuEn8CNx3mFlmTeWBHMiZ
        zcFh9qbe+9KBBp0O1P1f51lmgUryQg6I
X-Google-Smtp-Source: AMsMyM6U/J8aO36PwiFoLxqr1Umo20wXiES9M06+s5FWWzOGM6KPA+IDE7p+Fy5WZHovQVUTw1ww6sMgrtaN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a697:9013:186f:ed07])
 (user=irogers job=sendgmr) by 2002:a81:ae1a:0:b0:373:5466:d6f1 with SMTP id
 m26-20020a81ae1a000000b003735466d6f1mr32891682ywh.298.1667892993842; Mon, 07
 Nov 2022 23:36:33 -0800 (PST)
Date:   Mon,  7 Nov 2022 23:35:12 -0800
In-Reply-To: <20221108073518.1154450-1-irogers@google.com>
Message-Id: <20221108073518.1154450-9-irogers@google.com>
Mime-Version: 1.0
References: <20221108073518.1154450-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 08/14] tools lib perf: Add missing install headers
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Headers necessary for the perf build. Note, internal headers are also
installed as these are necessary for the build.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/Makefile | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 21df023a2103..1badc0a04676 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -189,13 +189,21 @@ install_lib: libs
 
 install_headers:
 	$(call QUIET_INSTALL, headers) \
+		$(call do_install,include/perf/bpf_perf.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/core.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/cpumap.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/threadmap.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/evlist.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/evsel.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/event.h,$(prefix)/include/perf,644); \
-		$(call do_install,include/perf/mmap.h,$(prefix)/include/perf,644);
+		$(call do_install,include/perf/mmap.h,$(prefix)/include/perf,644); \
+		$(call do_install,include/internal/cpumap.h,$(prefix)/include/internal,644); \
+		$(call do_install,include/internal/evlist.h,$(prefix)/include/internal,644); \
+		$(call do_install,include/internal/evsel.h,$(prefix)/include/internal,644); \
+		$(call do_install,include/internal/lib.h,$(prefix)/include/internal,644); \
+		$(call do_install,include/internal/mmap.h,$(prefix)/include/internal,644); \
+		$(call do_install,include/internal/threadmap.h,$(prefix)/include/internal,644); \
+		$(call do_install,include/internal/xyarray.h,$(prefix)/include/internal,644);
 
 install_pkgconfig: $(LIBPERF_PC)
 	$(call QUIET_INSTALL, $(LIBPERF_PC)) \
-- 
2.38.1.431.g37b22c650d-goog

