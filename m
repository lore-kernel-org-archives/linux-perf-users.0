Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C331DC3DA7A
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Jan 2023 06:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjAFGRc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Jan 2023 01:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjAFGQu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Jan 2023 01:16:50 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9C06CFDD
        for <linux-perf-users@vger.kernel.org>; Thu,  5 Jan 2023 22:16:43 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4597b0ff5e9so8904947b3.10
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Jan 2023 22:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1ELKsvqp/CVQlQh6V4i31lh01VunlKiC/zGB5BPQtSo=;
        b=FD+9b2BC7G6wp1RX4Zlmmp4Hb9G65TpW7cDfR3jRy7lIv397XuI2wMBzLeKhNfG3ie
         gaLrkjp+GuVOyruOeqib5Bk7mY6Lhau5XAg/K55bSJx177ozgbSwJPOPoBAlh6iGM1Kc
         0YuuJ7jeGD3vuqwkLJ97g5cfsbkrg2VoyYi4AxI/sFez/XUp+5lmOTIjDOLeNFxTMNBB
         40w2dm1yuZ8CEPgEtqNtT1Tjw6uPXmh/XkkYT/VMEHUGEyqZ1/YSr+V2qfljgx74gUXn
         RtOY7j2U/cYd9F+nAy3ouNrOkRNNC4Q/EZ6/j+/k5HQRy2zM7bx84B7qMwbyxUl8QZps
         N6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ELKsvqp/CVQlQh6V4i31lh01VunlKiC/zGB5BPQtSo=;
        b=ljLJ8PMnAt4lqCiVLty/JRHhn1DT8v17PGZ4jqIM/oZZK0oueLxcufnrglP1aTw8F2
         2pJ0N1OZxoZPslMBNAQFI5fkpYlUV6Pyim8ece2pMWNx/N7vddR8JpHozEGZk9ZiQrid
         6L+Tw4Y98MAC/05eukymCwYAvad2DslzAzA+beqW4Io/wd+egBOLULB7Wt2NI3SeV1XA
         YOjJFZIbJSrVh6mizztOrT/MHbzECY34oNNCjWNTYYolSODCr0yUfUmdwA9U6DezQ97d
         B+JKFurar8Q3GhNubL/S8OtJCayT1rAlpS969vtCGMv6RLKNX2xMdOyxLvZUx18V5tww
         okEw==
X-Gm-Message-State: AFqh2kqPogE9usra7P6GWexjOpTiylDEklzIp1Tde5KkihG9ry5N8ZIK
        FzmKSi5Ii48vziUZNkZgQFx2TPK6J+FZ
X-Google-Smtp-Source: AMrXdXuEa+hE8IGo8QRTwe0GaP5vmgi2S5IZ46ckdBfVNuEnI5WR/9UKlq3NfjLxAuttGhumPk5/Ks0kVfSA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:8775:c864:37e:2f9b])
 (user=irogers job=sendgmr) by 2002:a05:690c:841:b0:480:274c:bfac with SMTP id
 bz1-20020a05690c084100b00480274cbfacmr4305130ywb.104.1672985803154; Thu, 05
 Jan 2023 22:16:43 -0800 (PST)
Date:   Thu,  5 Jan 2023 22:16:31 -0800
Message-Id: <20230106061631.571659-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1] perf build: Fix build error when NO_LIBBPF=1
From:   Ian Rogers <irogers@google.com>
To:     Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, acme@kernel.org, irogers@google.com,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The $(LIBBPF) target should only be a dependency of prepare if the
static version of libbpf is needed. Add a new LIBBPF_STATIC variable
that is set by Makefile.config. Use LIBBPF_STATIC to determine whether
the CFLAGS, etc. need updating and for adding $(LIBBPF) as a prepare
dependency.

As Makefile.config isn't loaded for "clean" as a target, always set
LIBBPF_OUTPUT regardless of whether it is needed for $(LIBBPF). This
is done to minimize conditional logic for $(LIBBPF)-clean.

This issue and an original fix was reported by Mike Leach in:
https://lore.kernel.org/lkml/20230105172243.7238-1-mike.leach@linaro.org/

Fixes: 746bd29e348f ("perf build: Use tools/lib headers from install path")
Reported-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config |  2 ++
 tools/perf/Makefile.perf   | 21 ++++++++++++---------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c2504c39bdcb..7c00ce0a7464 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -602,6 +602,8 @@ ifndef NO_LIBELF
           dummy := $(error Error: No libbpf devel library found, please install libbpf-devel);
         endif
       else
+        # Libbpf will be built as a static library from tools/lib/bpf.
+	LIBBPF_STATIC := 1
 	CFLAGS += -DHAVE_LIBBPF_BTF__LOAD_FROM_KERNEL_BY_ID
         CFLAGS += -DHAVE_LIBBPF_BPF_PROG_LOAD
         CFLAGS += -DHAVE_LIBBPF_BPF_OBJECT__NEXT_PROGRAM
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 13e7d26e77f0..4e370462e7e1 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -303,10 +303,12 @@ ifneq ($(OUTPUT),)
 else
   LIBBPF_OUTPUT = $(CURDIR)/libbpf
 endif
-LIBBPF_DESTDIR = $(LIBBPF_OUTPUT)
-LIBBPF_INCLUDE = $(LIBBPF_DESTDIR)/include
-LIBBPF = $(LIBBPF_OUTPUT)/libbpf.a
-CFLAGS += -I$(LIBBPF_OUTPUT)/include
+ifdef LIBBPF_STATIC
+  LIBBPF_DESTDIR = $(LIBBPF_OUTPUT)
+  LIBBPF_INCLUDE = $(LIBBPF_DESTDIR)/include
+  LIBBPF = $(LIBBPF_OUTPUT)/libbpf.a
+  CFLAGS += -I$(LIBBPF_OUTPUT)/include
+endif
 
 ifneq ($(OUTPUT),)
   LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
@@ -393,10 +395,8 @@ endif
 export PERL_PATH
 
 PERFLIBS = $(LIBAPI) $(LIBPERF) $(LIBSUBCMD) $(LIBSYMBOL)
-ifndef NO_LIBBPF
-  ifndef LIBBPF_DYNAMIC
-    PERFLIBS += $(LIBBPF)
-  endif
+ifdef LIBBPF_STATIC
+  PERFLIBS += $(LIBBPF)
 endif
 
 # We choose to avoid "if .. else if .. else .. endif endif"
@@ -756,12 +756,15 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(arch_errno_name_array) \
 	$(sync_file_range_arrays) \
 	$(LIBAPI) \
-	$(LIBBPF) \
 	$(LIBPERF) \
 	$(LIBSUBCMD) \
 	$(LIBSYMBOL) \
 	bpf-skel
 
+ifdef LIBBPF_STATIC
+prepare: $(LIBBPF)
+endif
+
 $(OUTPUT)%.o: %.c prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
 
-- 
2.39.0.314.g84b9a713c41-goog

