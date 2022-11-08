Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82438C4332F
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Nov 2022 07:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiKHHgn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Nov 2022 02:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbiKHHg1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Nov 2022 02:36:27 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E05631F97
        for <linux-perf-users@vger.kernel.org>; Mon,  7 Nov 2022 23:36:26 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id c188-20020a25c0c5000000b006d8eba07513so2406824ybf.17
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Nov 2022 23:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fypXC5s+GJmcY7CDMLyT+XFtNB7Xjp9TotzTIy3WOeg=;
        b=RFQfsHnIDHpWmCnVp7oWB/dlG/LSle5NsakxQiW831EphqfLIO67hShWTaPkaY7wfR
         STd+zApFgJEbyUvLuxvD4EXb/kL+iGirFD8ucU9AMzwV4ihlBrZXlnz5cjvAfw+a3nBA
         Je3YTYoxRrQYmHiUxjvPkx3oUXC6f2wirLFG1hMM5LPMlqV0lMe2/Bo2VW8WzpbU2l6W
         RMBKIMPMQt1CfBX/oBOFE38EBMoD7mJlw9kyQxNBo2Ll91Ie7BQ2Qc5x4XzeVHdtPK2k
         SG/m69f1Fm3xjgJavEJ3OUSWeVo2eiybuK/Nem1AyhZNQ7xScIqszLV6xxZEs+U4o4Cx
         kEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fypXC5s+GJmcY7CDMLyT+XFtNB7Xjp9TotzTIy3WOeg=;
        b=MBMmWnCUk03sZfL0mdEaAdjm746iK5BCxr8DA7Vi2tXXlYjxSfFP4qsyTtafsQpQnR
         cLEgEbU2XhQKZh1d4VNV52kee/hu+nCtqbWq70AoZoDay2bkwvjBr5X2rE50rbyYnorD
         MUApn/y7qNUZU2KTm8PiW7jQ3zULr5yGvRxeuMBlfV5rN84EezE3GR+lcN6VeUNV64fh
         UU5FypD/pXTVXj2uHDooV93XJaie6py0JNabSHmkuGR18FAZxtifBmlykyETcvfEqpHw
         RTEqklOuuKfEsj1YNDZuaJskR4/kbeNA6UhblaBMgNY7KmLx9UZlWe3ypUX0lhHV34Cg
         WhuA==
X-Gm-Message-State: ANoB5pl3lr2u5At6SwxP9Vq9QJQz8uI7EHAlvGB/+MSaqCj3oVwQef4e
        iCAO/Va8KX9IC8cQ8+TBngXAEbihPnrM
X-Google-Smtp-Source: AA0mqf4jETz2UWVRQXlwt7m55hk/+EqfiUxjrjtBdYvgwGZRi4Ta5w6Wbs4sawPtIEv0aQSnkXr8qLhRKDJO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a697:9013:186f:ed07])
 (user=irogers job=sendgmr) by 2002:a25:c011:0:b0:6d0:ee14:6287 with SMTP id
 c17-20020a25c011000000b006d0ee146287mr15020385ybf.622.1667892985905; Mon, 07
 Nov 2022 23:36:25 -0800 (PST)
Date:   Mon,  7 Nov 2022 23:35:11 -0800
In-Reply-To: <20221108073518.1154450-1-irogers@google.com>
Message-Id: <20221108073518.1154450-8-irogers@google.com>
Mime-Version: 1.0
References: <20221108073518.1154450-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 07/14] tools lib api: Add missing install headers
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

Headers necessary for the perf build.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index 6629d0fd0130..3e5ef1e0e890 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -103,7 +103,10 @@ install_headers:
 	$(call QUIET_INSTALL, headers) \
 		$(call do_install,cpu.h,$(prefix)/include/api,644); \
 		$(call do_install,debug.h,$(prefix)/include/api,644); \
-		$(call do_install,io.h,$(prefix)/include/api,644);
+		$(call do_install,io.h,$(prefix)/include/api,644); \
+		$(call do_install,fd/array.h,$(prefix)/include/api/fd,644); \
+		$(call do_install,fs/fs.h,$(prefix)/include/api/fs,644);
+		$(call do_install,fs/tracing_path.h,$(prefix)/include/api/fs,644);
 
 install: install_lib install_headers
 
-- 
2.38.1.431.g37b22c650d-goog

