Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED68C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Sep 2021 22:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B970D61058
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Sep 2021 22:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbhI0WdB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237545AbhI0WdA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Sep 2021 18:33:00 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D550C061575;
        Mon, 27 Sep 2021 15:31:20 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n2so12760027plk.12;
        Mon, 27 Sep 2021 15:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jtohzWpaqkO4tU2pAeEn9Z5yAnnkQyBYiaAEVGUJmac=;
        b=YQicmZtm0w6K2IXXhrqHlHrViMkMyd07v8gqlk365KYOU0spBQS4exom6/om/3WcjL
         c3rp8Lplq7zhtrl0s4verCbiToNLsHwf2N1a46iD1NshaU75szMCfvC2Ve6SDwsAmile
         +5u4+X0gQRA5RO5oMgX4tcmHvGyh2HcFIIut1U5CEBUx0Le4uJJEed+nonnGQWtgP37L
         T+SeFD5Kts1c+1cN0APv5MkHqQ3lTOrH/coOC+73A3h1cEgyRe5Ve4op5yU76WK3rsQ2
         eOLmTij9la89JEoFqJ5mXJhfJVs2vTIfklEBfqmXx/2Be5JjX310tX2FxMta7hW6TxqI
         dpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jtohzWpaqkO4tU2pAeEn9Z5yAnnkQyBYiaAEVGUJmac=;
        b=Scs/Mr+6s3CFUnbAB4jjfodQYj8nLoQxP+XWvsBgJh286eBOva5G+IvpFg1H33kwhM
         r7zX1nUpnDNajEvrBOkG1wBlxAV+CRgKFLA5wONjnD0O/pwsgiiK0rwfu02eK+2+Wu5p
         jz4IulfmLHNpM1hhMpSfi+hNUYY19lYdhNrSt8GlHOOccyctL1l59rbxsVsfRtosd7Wm
         rPxrs57EiPG4Rn58ZzrStAwz/mKdgYoBTPaeYEaDthm0xwBmP4hV0SrkcshOkrwgaY0p
         MKX55PDKi0ayIKWIPQnElIp8W9DJTU+JVtTsBF/pBRgJxFmhZusV1DioDGNdodVg22OS
         mINw==
X-Gm-Message-State: AOAM532zb9V5lK6et2bO4On04biG7lZRJJQbJoBXQNC4yNosGIruLVGA
        fMMwY2AY5XW1cqa58a5ezZM6c6Osa6sbDA==
X-Google-Smtp-Source: ABdhPJx+938LPA9dvs/fmtwyLbAOxayWi/5NhCHKMwzyhefBHQ9RXoTJULKWwqoyToQX5TtiN7Gc6g==
X-Received: by 2002:a17:90a:854b:: with SMTP id a11mr222853pjw.4.1632781880154;
        Mon, 27 Sep 2021 15:31:20 -0700 (PDT)
Received: from titan.corp.tusimple.io ([2601:644:8300:136:a6bb:6dff:feb6:3500])
        by smtp.gmail.com with ESMTPSA id i27sm18081225pfq.184.2021.09.27.15.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 15:31:19 -0700 (PDT)
From:   Jinshan Xiong <jinshan.xiong@gmail.com>
To:     jolsa@redhat.com, arnaldo.melo@gmail.com
Cc:     Jinshan Xiong <jinshan.xiong@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] tools/lib/perf: make the static libperf complete
Date:   Mon, 27 Sep 2021 15:30:26 -0700
Message-Id: <20210927223101.3155964-1-jinshan.xiong@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CABoqRjsUPhJk6A7QOh_9z6zHLyqX=ZZG7gkcEZeui1uO4m7Bbg@mail.gmail.com>
References: <CABoqRjsUPhJk6A7QOh_9z6zHLyqX=ZZG7gkcEZeui1uO4m7Bbg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch makes libperf.a complete. Initially it misses the symbols
fdarray_* that makes it unusable after being installed by:
   $ make install DESTDIR=<install_dir>

Check missing symbols:
   $ nm tools/lib/perf/libperf.a | grep fdarray_
                    U fdarray__add
   0000000000002b3e t fdarray__available_entries
                    U fdarray__exit
                    U fdarray__filter
                    U fdarray__grow
                    U fdarray__init
                    U fdarray__poll

After this patch is applied:
    $ nm tools/lib/perf/libperf-ext.a | grep fdarray_
    00000000000063f7 T fdarray__add
    ......
    00000000000065d4 T fdarray__poll

Signed-off-by: "Jinshan Xiong" <jinshan.xiong@gmail.com>
---
 tools/lib/perf/Makefile | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 08fe6e3c4089..b2f7f4fd7065 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -94,7 +94,8 @@ LIBPERF_A  := $(OUTPUT)libperf.a
 LIBPERF_IN := $(OUTPUT)libperf-in.o
 LIBPERF_PC := $(OUTPUT)libperf.pc
 
-LIBPERF_ALL := $(LIBPERF_A) $(OUTPUT)libperf.so*
+LIBPERF_A_EXT        := $(OUTPUT)libperf-ext.a
+LIBPERF_LIBS_INSTALL := $(LIBPERF_A_EXT) $(OUTPUT)libperf.so*
 
 LIB_DIR := $(srctree)/tools/lib/api/
 
@@ -124,6 +125,9 @@ $(LIBPERF_IN): FORCE
 $(LIBPERF_A): $(LIBPERF_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBPERF_IN)
 
+$(LIBPERF_A_EXT): $(LIBPERF_IN) $(LIBAPI)
+	$(QUIET_AR)$(RM) $@ && $(LD) -r -o libperf-ext.o $^ && $(AR) rcs $@ libperf-ext.o
+
 $(LIBPERF_SO): $(LIBPERF_IN) $(LIBAPI)
 	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libperf.so \
                                     -Wl,--version-script=$(VERSION_SCRIPT) $^ -o $@
@@ -131,7 +135,7 @@ $(LIBPERF_SO): $(LIBPERF_IN) $(LIBAPI)
 	@ln -sf $(@F) $(OUTPUT)libperf.so.$(LIBPERF_VERSION)
 
 
-libs: $(LIBPERF_A) $(LIBPERF_SO) $(LIBPERF_PC)
+libs: $(LIBPERF_A) $(LIBPERF_A_EXT) $(LIBPERF_SO) $(LIBPERF_PC)
 
 all: fixdep
 	$(Q)$(MAKE) libs
@@ -183,9 +187,9 @@ define do_install
 endef
 
 install_lib: libs
-	$(call QUIET_INSTALL, $(LIBPERF_ALL)) \
+	$(call QUIET_INSTALL, $(LIBPERF_LIBS_INSTALL)) \
 		$(call do_install_mkdir,$(libdir_SQ)); \
-		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
+		cp -fpR $(LIBPERF_LIBS_INSTALL) $(DESTDIR)$(libdir_SQ)
 
 install_headers:
 	$(call QUIET_INSTALL, headers) \
-- 
2.30.2

