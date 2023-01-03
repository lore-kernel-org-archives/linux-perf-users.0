Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF0FC3DA7D
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 Jan 2023 07:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjACHKT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 3 Jan 2023 02:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjACHKS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 Jan 2023 02:10:18 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4F2D2C3
        for <linux-perf-users@vger.kernel.org>; Mon,  2 Jan 2023 23:10:17 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v195-20020a252fcc000000b007125383fe0dso30209034ybv.23
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Jan 2023 23:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GAhXO16DITu5mVlsm2RSqQmMHjgDMp5kRheUZ35G9jk=;
        b=HpJzc1mBXMW9s7eW4d43H/CoP2bHxQSjeRu6iAjRL2bVDxTRdZHlKlmxsm3m9+nS6s
         g1rK15i0sLEUWswaOs6aqiVDfAk9DFK6g3kEMyDb2rL0KygrBX56Zjoa0xdbCMPqCGYt
         I6h0XTv7A5w8uOvJf/V8mhXT7DhbVYbhmedQmzpiE+IsShforBpBiKjzwl6l9KrOUIWO
         O1zUaCG2yFX0+yMU0CV9UVsfD+jiPz0SJBGfzAfRHZzDvLV0KlD6O0dCo/mHioDdBJCP
         4S6Pg1kBI1qd1+SHuYAzVKdV94/Wnmatf5/+egilXwkSlApOi2xWddr1CiQ2aTJnM/0S
         frgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GAhXO16DITu5mVlsm2RSqQmMHjgDMp5kRheUZ35G9jk=;
        b=hxeqFjbYw8ZkX9tx5p+HtpN6XIjPbuynMVU+HWNloPIO7++8jyieB95qwINVzgh+Sp
         jzEppggVDD8Rrl6+ptGdpPLQcUAtE5mUmr5TjY1FyYYhvBDLuIj43c+OL9rY4cjzEUOT
         tRBBeLNneV0sk68n5UuRmepnBK1553UDlOgszRB4W/WETPewY8bKLPmTDMq9+mXrK2AE
         R2UOTh7coLZLbexhrUch6fu768vbsObPSK8kpQfLyMcvlsA7jcHS0LfXukcgIFSG3CxR
         xM0x3TLgbnGXDOWNXzUNkQHmneDI9kuvPZ5VWtsMQz75vwjajmT3YPX56wKCJ4Lk7vcz
         XanA==
X-Gm-Message-State: AFqh2krjvT4cA8np0Ls4k98AnjwJ9OKIKO1FYS3Xmg5fxdpw9hrEQdmE
        QPFOzI4JlgBd5kwgmkRmJgo1oOhqwReR
X-Google-Smtp-Source: AMrXdXtoqLVerlgldhQbNBwl7YtcbVFvDns1cF/xd/TR6Zl1sPVsVh/nCZ8+/8XGaQrbdK2p+bIOzqfjwn/q
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ce36:aa68:4ca6:590b])
 (user=irogers job=sendgmr) by 2002:a81:9944:0:b0:410:b7cd:52f7 with SMTP id
 q65-20020a819944000000b00410b7cd52f7mr5895383ywg.520.1672729816858; Mon, 02
 Jan 2023 23:10:16 -0800 (PST)
Date:   Mon,  2 Jan 2023 23:09:16 -0800
Message-Id: <20230103070916.2407873-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH] perf build: Don't propagate subdir to submakes for install_headers
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Torsten Hilbrich <torsten.hilbrich@secunet.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

subdir is added to the OUTPUT which fails as part of building
install_headers when passed from "make -C tools perf_install".

Fixes: 746bd29e348f ("perf build: Use tools/lib headers from install path")
Reported-by: Torsten Hilbrich <torsten.hilbrich@secunet.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 13e7d26e77f0..1e32c93b8042 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -819,7 +819,7 @@ $(patsubst perf-%,%.o,$(PROGRAMS)): $(wildcard */*.h)
 
 $(LIBAPI): FORCE | $(LIBAPI_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBAPI_DIR) O=$(LIBAPI_OUTPUT) \
-		DESTDIR=$(LIBAPI_DESTDIR) prefix= \
+		DESTDIR=$(LIBAPI_DESTDIR) prefix= subdir= \
 		$@ install_headers
 
 $(LIBAPI)-clean:
@@ -828,7 +828,7 @@ $(LIBAPI)-clean:
 
 $(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBBPF_DIR) FEATURES_DUMP=$(FEATURE_DUMP_EXPORT) \
-		O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= \
+		O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= subdir= \
 		$@ install_headers
 
 $(LIBBPF)-clean:
@@ -837,7 +837,7 @@ $(LIBBPF)-clean:
 
 $(LIBPERF): FORCE | $(LIBPERF_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBPERF_DIR) O=$(LIBPERF_OUTPUT) \
-		DESTDIR=$(LIBPERF_DESTDIR) prefix= \
+		DESTDIR=$(LIBPERF_DESTDIR) prefix= subdir= \
 		$@ install_headers
 
 $(LIBPERF)-clean:
@@ -846,7 +846,7 @@ $(LIBPERF)-clean:
 
 $(LIBSUBCMD): FORCE | $(LIBSUBCMD_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBSUBCMD_DIR) O=$(LIBSUBCMD_OUTPUT) \
-		DESTDIR=$(LIBSUBCMD_DESTDIR) prefix= \
+		DESTDIR=$(LIBSUBCMD_DESTDIR) prefix= subdir= \
 		$@ install_headers
 
 $(LIBSUBCMD)-clean:
@@ -855,7 +855,7 @@ $(LIBSUBCMD)-clean:
 
 $(LIBSYMBOL): FORCE | $(LIBSYMBOL_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBSYMBOL_DIR) O=$(LIBSYMBOL_OUTPUT) \
-		DESTDIR=$(LIBSYMBOL_DESTDIR) prefix= \
+		DESTDIR=$(LIBSYMBOL_DESTDIR) prefix= subdir= \
 		$@ install_headers
 
 $(LIBSYMBOL)-clean:
-- 
2.39.0.314.g84b9a713c41-goog

