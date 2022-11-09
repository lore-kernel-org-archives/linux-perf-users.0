Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0714C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Nov 2022 18:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiKISvH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Nov 2022 13:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiKISur (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Nov 2022 13:50:47 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DEC23E9D
        for <linux-perf-users@vger.kernel.org>; Wed,  9 Nov 2022 10:50:33 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t9-20020a5b03c9000000b006cff5077dc9so17453027ybp.3
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Nov 2022 10:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lT5QMmKiixUc4hOkx2B5agh6ifSSv8GoT3OYojEFayc=;
        b=J5iBygppWMyynh3fjd0h1zimuLLVXPLRICNwzhaTkhTCHnJ60j86AFaw/f1brpqElJ
         OEnHLiYHfWemhwcN5jxIbJxJOEmbZB1bZu6qV+GB3URAJAroxMSJsNboaLLx75pLWFY4
         NnLVvhzppfjD2+S4VNkt8wChsyw5+8/Bhz+kEOKVTu6SG4VAHP9zNdmUfTPO4bG1luwk
         CBFaCLcPIZfEBdeRvmSItRq/n4SZckWr3K3IX24HNN+IEsR3wCx5ZpZHzBE2sogc5wRf
         vs2/QeeLSCSvXEaexqvlkFi8GhQp2CBE/eieS1MsnzxjxRc5C6uVIQGMCmWg4Yvx/WTL
         7qaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lT5QMmKiixUc4hOkx2B5agh6ifSSv8GoT3OYojEFayc=;
        b=2eB1lVwq8s3leNB/5oMdfkY5jC9dPCsyMNizsPNdqKmTNofKPGQG1dI1OZJVbZlOPx
         ZmSM/Am3z6gi5KhIDkJ13hT6W2syH52sUGEO/9g9w25L8sT5Q+ZNLljGSu2iXkRzp1OY
         YU0WJuMvLMhdh8UZsmrDWkelth4ut88LRNbb1Gv9pSfdSrTjaftUG1yHO5+Obupc4Z5a
         kNEL5eWZK3zRVO0UipPJEVigHl3qhFek1NNrKtXYWFZdk6yfPyUcCzqnYXTke7TGQLn1
         qpZm0pUiGyU+kjHo8t5ZS6b5kABSIqurpfzXqPVANCdaBPpR4K0As1mKpttOsQ8NXzik
         Iajw==
X-Gm-Message-State: ACrzQf2yII18biWsH04bS2z/rePQSixJVzPIAZA7IO3q+f2o939etNhT
        AsPFt6B26IJtMHGa7JyOOd2lijBKV0Fm
X-Google-Smtp-Source: AMsMyM4N/f2ycS6qQcmparzQwYVX6dleyP6/S0ma7Cd+HCsCnLDoZE6zuY8W1FFoHP1q5N61W1lqeBMzgilI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b06f:a254:5ce9:c442])
 (user=irogers job=sendgmr) by 2002:a25:af12:0:b0:6cb:b5d7:d64d with SMTP id
 a18-20020a25af12000000b006cbb5d7d64dmr60679393ybh.510.1668019832763; Wed, 09
 Nov 2022 10:50:32 -0800 (PST)
Date:   Wed,  9 Nov 2022 10:49:08 -0800
In-Reply-To: <20221109184914.1357295-1-irogers@google.com>
Message-Id: <20221109184914.1357295-9-irogers@google.com>
Mime-Version: 1.0
References: <20221109184914.1357295-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 08/14] tools lib perf: Add missing install headers
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

