Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AABC5479D
	for <linux-perf-users@archiver.kernel.org>; Thu,  5 Jan 2023 17:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbjAER1d (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 5 Jan 2023 12:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbjAER1B (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 Jan 2023 12:27:01 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45A259FB6
        for <linux-perf-users@vger.kernel.org>; Thu,  5 Jan 2023 09:23:00 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id bk16so23597488wrb.11
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Jan 2023 09:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcfKvBPEIZCBpfejnS73x0WwQlLjDoYOq2loLUX6TbU=;
        b=KwTi/H999k5fva2x4E5wBta5Rx9fvc3JiOCJaif8gKrNStViCRTQIJjqOJ+RkI+kjG
         bM32qjnNVWALAET3QCG4YDk0O705dgkfl2PfMRQSiKS3cX4asOWiKDNABJ51/Nrp41gg
         fVGpKaGTnNqm8/+uSoIDeG9rZQpdb8V5uGEBQIBWoxCTWSg+0HNSjXEoy9eXdJgQJ6vC
         qVPjg/atlKyDzrkoDWHxsykXvOfgYXqolFnE5HF9jwpodI04uIu8Vn6LMa9H71Xeypmf
         WcIcTR4hfxQ17/9nJ2Xf+ANDx++GsspwhdR256Vf/Fgq9oyh6/wGQuOXh3ZHtAswozK2
         kajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcfKvBPEIZCBpfejnS73x0WwQlLjDoYOq2loLUX6TbU=;
        b=1ciPcAMST2Pjc//pNhDINITTv1VaC7ODFvpmp7XVW92bAxJoKWYAWwO264MEoyjXmG
         yKozDBK0kaPvEEZ48j9vlJA+YvVM2j6YULuNUehH/fLRxPIzTolv8i67jwv/Re5MNmJb
         PfOLQjnZyoI2vY4p6/K6Vu0+OqX5Qj+Eq4EJDspdx9RCeJt/WQHQhAlPwn3EtOXTsCpA
         jxB/F8CdE3+QdoTRsM9J2/2KSvGuzN7EsDlcW2NAIxUeArC+EfbFatwcZTZd1nU0eFnT
         olz/jtZF9R4lNK9yXO+iWNV9W7SW6V3jVGe68cMjWe8t8DwEaBl8rPabcmX2B+LJkOvP
         9qAw==
X-Gm-Message-State: AFqh2kpxqJl5GjboMr7Be420eFo7CN8fwJYSN7Bkd5RY3ICpi3mmGFM3
        oJxfcBVNV1R9V9yD0uJSgIw497r7/2LLZEeo
X-Google-Smtp-Source: AMrXdXsVuG3jlXxidmoUuxedWXclZfrZDMaXokX92TAiPz2xuCOg2zd6+8EV0DNZLOtS/hNregUGCw==
X-Received: by 2002:adf:9dd1:0:b0:242:f3f:28df with SMTP id q17-20020adf9dd1000000b002420f3f28dfmr32911549wre.58.1672939379261;
        Thu, 05 Jan 2023 09:22:59 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:dca6:3efa:4e3:1e42])
        by smtp.gmail.com with ESMTPSA id s13-20020adfdb0d000000b002420dba6447sm37871273wri.59.2023.01.05.09.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 09:22:58 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, acme@kernel.org, irogers@google.com
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH] perf build: Fix build error when NO_LIBBPF=1
Date:   Thu,  5 Jan 2023 17:22:43 +0000
Message-Id: <20230105172243.7238-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Recent updates to perf build result in the following output when cross
compiling to aarch64, with libelf unavailable, and therefore
NO_LIBBPF=1 set.

```
  $make -C tools/perf

  <cut>

  Makefile.config:428: No libelf found. Disables 'probe' tool, jvmti
  and BPF support in 'perf record'. Please install libelf-dev,
  libelf-devel or elfutils-libelf-devel

  <cut>

  libbpf.c:46:10: fatal error: libelf.h: No such file or directory
      46 | #include <libelf.h>
         |          ^~~~~~~~~~
  compilation terminated.

  ./tools/build/Makefile.build:96: recipe for target
  '.tools/perf/libbpf/staticobjs/libbpf.o' failed

```

plus one other include error for <gelf.h>

The issue is that the commit noted below adds libbpf to the prepare:
target but no longer accounts for the NO_LIBBPF define. Additionally
changing the include directories means that even if the libbpf target
build is prevented, bpf headers are missing in other parts of the build.

This patch ensures that in the case of NO_LIBBPF=1, the build target is
changed to a header only target, and the headers are installed, without
attempting to build the libbpf.a target.

Applies to perf/core

Fixes: 746bd29e348f ("perf build: Use tools/lib headers from install path")
Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 tools/perf/Makefile.perf | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 13e7d26e77f0..ee08ecf469f6 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -305,7 +305,11 @@ else
 endif
 LIBBPF_DESTDIR = $(LIBBPF_OUTPUT)
 LIBBPF_INCLUDE = $(LIBBPF_DESTDIR)/include
+ifndef NO_LIBBPF
 LIBBPF = $(LIBBPF_OUTPUT)/libbpf.a
+else
+LIBBPF = $(LIBBPF_INCLUDE)/bpf/bpf.h
+endif
 CFLAGS += -I$(LIBBPF_OUTPUT)/include
 
 ifneq ($(OUTPUT),)
@@ -826,10 +830,16 @@ $(LIBAPI)-clean:
 	$(call QUIET_CLEAN, libapi)
 	$(Q)$(RM) -r -- $(LIBAPI_OUTPUT)
 
+ifndef NO_LIBBPF
 $(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBBPF_DIR) FEATURES_DUMP=$(FEATURE_DUMP_EXPORT) \
 		O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= \
 		$@ install_headers
+else
+$(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
+	$(Q)$(MAKE) -C $(LIBBPF_DIR) OUTPUT=$(LIBBPF_OUTPUT)/ \
+		DESTDIR=$(LIBBPF_DESTDIR) prefix= install_headers
+endif
 
 $(LIBBPF)-clean:
 	$(call QUIET_CLEAN, libbpf)
-- 
2.17.1

