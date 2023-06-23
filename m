Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691E7EB64DD
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 04:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjFWEO6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 00:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjFWEO2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 00:14:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047F6268A
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 21:14:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bd5f9d084c9so360047276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 21:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687493662; x=1690085662;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ai2lt5OXlbg2xibr5qc+Wf7Z0ZxmmScMUvbx2hwx4o=;
        b=i6JMRQKJse9xdriW6sN1y3oU7Pmdm0X/tfZLFVuGr7Qy5Xvv6Bk2LiBt6lGdWaN2m5
         WkOHxDeZ5GFOwfdEyr8yKNo6xUAr0SKyujoJ2vYt0MUH50G524NCf+IU6TWfk3LbfE7F
         m1qOHpsF6yNlWremKE+D63U+q84y57TzPt0Y9djKgU80NXuNlflx3+DmEZ50zz3G1Y3q
         6qZEnyKYtMyjy2Ly46Cnv79i5ZSNFGLmqTCYo/7K1Zlz9oo2pMmmukJ0zWVUzJzM7Vq6
         6o3yon9f3xJIMgIyY120p/xIbAf84PMc9cvDW/ics5umym/bom1SzjhELttNr7xzasjI
         n/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687493662; x=1690085662;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ai2lt5OXlbg2xibr5qc+Wf7Z0ZxmmScMUvbx2hwx4o=;
        b=MU98qgeX5r7PpvNma16c+lRousOWnxkX43K4B0sW1EIhAzuZE9duvbGugLb6nakQ+j
         2pSc3eqrWKQYwsw6Zjd9px/toopqYjKX0zfZ8+j4KxXiWuiprsw7bRQ20VCep4zu+vVq
         nO5h+qxAkbT8EPyJB4u6NXhBBftkTdwR3pEBQdQCxj2AEjpM4ocwwZ13IKie+xE+oa/r
         dQmoTFbhorz9K8crpdOjupdmaiCXejuAR+PtOankFPxYbTKyReRXAjnaLUEf9RrBtEyW
         6UkGXV+PHvcAsdg51h6IDz7gs9p8KTGr9VV2QjcOAPxhQtFGfGYqJGWWrqdrbpYQuI7t
         lflg==
X-Gm-Message-State: AC+VfDx9VCgPu3vKH4Ii+1x0WfA4y9oPANgxuLltNO58+1vHt/l/oAu9
        bsKsQKXj2cj+ybyNwTOwEbueNk0gik/y
X-Google-Smtp-Source: ACHHUZ4av1Md+P50HHhit3siIeZinqjGeMjKrlX3Hguw5x3mNqN/hkSq5KyK0AqscXGomtYmaoVFKFdwLala
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a25:8046:0:b0:bd7:545e:ab35 with SMTP id
 a6-20020a258046000000b00bd7545eab35mr8897557ybn.10.1687493662218; Thu, 22 Jun
 2023 21:14:22 -0700 (PDT)
Date:   Thu, 22 Jun 2023 21:14:05 -0700
In-Reply-To: <20230623041405.4039475-1-irogers@google.com>
Message-Id: <20230623041405.4039475-5-irogers@google.com>
Mime-Version: 1.0
References: <20230623041405.4039475-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v4 4/4] perf build: Filter out BTF sources without a .BTF section
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
Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Makefile.perf | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 80d772cc5fcb..8f442419a895 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -197,6 +197,7 @@ FLEX    ?= flex
 BISON   ?= bison
 STRIP   = strip
 AWK     = awk
+READELF ?= readelf
 
 # include Makefile.config by default and rule out
 # non-config cases
@@ -1084,12 +1085,34 @@ $(BPFTOOL): | $(SKEL_TMP_OUT)
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

