Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ED4C87FDC
	for <linux-perf-users@archiver.kernel.org>; Fri,  9 Jun 2023 04:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238449AbjFIEdO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 9 Jun 2023 00:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238437AbjFIEdC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Jun 2023 00:33:02 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC473590
        for <linux-perf-users@vger.kernel.org>; Thu,  8 Jun 2023 21:32:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-569fee67d9dso30528377b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jun 2023 21:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686285175; x=1688877175;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ASHCbqrtMwwghLa6ldqtFIr9DVtYxGlsru2IeiO0chg=;
        b=zI3WfmrJTWofT6Q5ncQ6jKrXFR1E3mo9Hit36AdOzyBeM6PnVVNbAQ0WNi65k/+zcA
         pR2aXpJwJaskgwdpY+kRv/hyUfkVL91tivrmkolRVBjmQdoGjBGJK8oZSBVLsoqMge2S
         m/lWXRXuPDMh/9dfkqwUN7EO5npxmr1P+sWYJUgYfC7vyvYirx7VbhA7HDJw1f+GYZ1K
         URTRPQTOWSQMbs0l9jWvaD1fHKYrDJLDjBvCQUkYBykXnnQniZAFVt+rref9n3kl/MF0
         jAgELj+szWLc9gT7BHTUJeXYu9loowgmmr1rSX6Hfxtz8VUyMus1WO5K8VcaKT/GzcZQ
         nf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686285175; x=1688877175;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ASHCbqrtMwwghLa6ldqtFIr9DVtYxGlsru2IeiO0chg=;
        b=Jl6daSrIWfnVjQx5sebunDVnosLROcJ+2iHcjNqcf8PRn5RnVnkZpem2YP6RJe+jDx
         J8+tQFeuLS7Zme/Quu0fwd5OGJ0+Pm0LhX/mO3zlCxnmNwm7tcUhdzXghtl80nY0iolv
         39YcNJXAuigHF+bY0rLIt7ViXDfYGRZjMDB0O17mF861flOESH5qHf8Lltz/2E3JUnsN
         uk0lNZLaGR16U4DveOkQF4l+IlXNJFzGlsRxp6cz0nUHQhpFesVrNZR2lU1jMiw0XPqF
         ZaaiesbCKoz1sMLbwpvXqSfZHZ4I3SFeFluF3FlAD6DOKuvutMq2skaszEEoEcLYUnUs
         ZgRQ==
X-Gm-Message-State: AC+VfDzzx08asj94DY+2VxCtXBl6kBjQnU1c9KEsS0Z2s9lYdc8kA2fP
        T3wti84TMSeWFBbBMmc4L6jimybFo93p
X-Google-Smtp-Source: ACHHUZ4iB6nP+HsqtQdFaFGqIVReKInr9ZAzZ0P6gBKiMmd7L9cSwiggbWzNxk1AoADQfIFADF2Se2xAo5yp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a81:ae59:0:b0:557:616:7d63 with SMTP id
 g25-20020a81ae59000000b0055706167d63mr538367ywk.1.1686285175731; Thu, 08 Jun
 2023 21:32:55 -0700 (PDT)
Date:   Thu,  8 Jun 2023 21:32:40 -0700
In-Reply-To: <20230609043240.43890-1-irogers@google.com>
Message-Id: <20230609043240.43890-5-irogers@google.com>
Mime-Version: 1.0
References: <20230609043240.43890-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v3 4/4] perf build: Filter out BTF sources without a .BTF section
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If generating vmlinux.h, make the code to generate it more tolerant by
filtering out paths to kernels that lack a .BTF section.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f1840af195c0..e440793fc6ca 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -193,6 +193,7 @@ FLEX    ?= flex
 BISON   ?= bison
 STRIP   = strip
 AWK     = awk
+READELF ?= readelf
 
 # include Makefile.config by default and rule out
 # non-config cases
@@ -1080,12 +1081,34 @@ $(BPFTOOL): | $(SKEL_TMP_OUT)
 	$(Q)CFLAGS= $(MAKE) -C ../bpf/bpftool \
 		OUTPUT=$(SKEL_TMP_OUT)/ bootstrap
 
-VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
+# Paths to search for a kernel to generate vmlinux.h from.
+VMLINUX_BTF_ELF_PATHS ?= $(if $(O),$(O)/vmlinux)			\
 		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
 		     ../../vmlinux					\
-		     /sys/kernel/btf/vmlinux				\
 		     /boot/vmlinux-$(shell uname -r)
-VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
+
+# Paths to BTF information.
+VMLINUX_BTF_BTF_PATHS ?= /sys/kernel/btf/vmlinux
+
+# Filter out kernels that don't exist or without a BTF section.
+VMLINUX_BTF_ELF_ABSPATHS ?= $(abspath $(wildcard $(VMLINUX_BTF_ELF_PATHS)))
+VMLINUX_BTF_PATHS ?= $(shell for file in $(VMLINUX_BTF_ELF_ABSPATHS); \
+			do \
+				if [ -f $$file ] && ($(READELF) -S "$$file" | grep -q .BTF); \
+				then \
+					echo "$$file"; \
+				fi; \
+			done) \
+			$(wildcard $(VMLINUX_BTF_BTF_PATHS))
+
+# Select the first as the source of vmlinux.h.
+VMLINUX_BTF ?= $(firstword $(VMLINUX_BTF_PATHS))
+
+ifeq ($(VMLINUX_H),)
+  ifeq ($(VMLINUX_BTF),)
+    $(error Missing bpftool input for generating vmlinux.h)
+  endif
+endif
 
 $(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
 ifeq ($(VMLINUX_H),)
-- 
2.41.0.162.gfafddb0af9-goog

