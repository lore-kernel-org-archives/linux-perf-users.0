Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC09C77B75
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 May 2023 20:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbjEVUld (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 May 2023 16:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjEVUla (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 May 2023 16:41:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFA893
        for <linux-perf-users@vger.kernel.org>; Mon, 22 May 2023 13:41:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561ec541330so99171137b3.2
        for <linux-perf-users@vger.kernel.org>; Mon, 22 May 2023 13:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684788088; x=1687380088;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t771rJNSVAj7o7+OMhJ7kA2vXmw4aWdm5rm5xvuQqrM=;
        b=Pd8vKAkglEA/vs1vv4AHMGxBFRjMm2JVyfFC02xpYvgem5n4T96gLa7/AofEdDMVcK
         M16XMthYd2njQSr8xBBBaXAYSgMhNcn9AaTOJu7T5WV6NyRi9v1bIGiF+LuAaJikRUXn
         qqhuZzlUKQkDS6aPTv8UeR0ELjgWx9BV5y9gAC80RcJhR8L+tU7nhXtL9TL2XhBJeZTo
         nJ74+N/9bC9FZs3iEMAU0axokktTZmGVv9hOU5myYM4HnCPvrN5/WCHKbWIyBKa8pxdW
         8plw+mUUO9L74VhZEFSVE5dskRfW46pkk+Y/+7CxhPI8sR/xB5cuOFXsy6n+qb9WOg6a
         MCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684788088; x=1687380088;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t771rJNSVAj7o7+OMhJ7kA2vXmw4aWdm5rm5xvuQqrM=;
        b=YbTm3kXuAj0RbluU4/W8mpU4BpiiAQhyQIONs3kjIkkKCXpjOYkeAxUpSWJG3Ea4W0
         O75rYfJtjRFBlwyfAjyWt/bxYf+6SqBUJmn1bygJVrcFu5hYBI/lsAa3EPVcVFB7rTtg
         FlixKlJDD4b1Cie1nwm1cl/kfwgl3ljCr2EpsNQlP0xhPS5dwsL9KL4skUG/BnIUtWrJ
         K2Rg8sZs26EIT4EbioLYo2oce/0FCRO1alPN5cnXhuNK5YujoQ1h9FSMILyJc7dVBqD8
         /EeYCh6NHpKVMg2epAkfOlI/a/9MRWll/tLWUQ6OOrcKfCihb0B2I2mhZlRa4WGmL7jD
         /XOw==
X-Gm-Message-State: AC+VfDwanwkE0od13MOwvORRjh/teZvHCQyrZw5v1WGEv/SaH8T3O29w
        B1gwkuYP8PnzJSyQSujzQzcWSSJpo4R8
X-Google-Smtp-Source: ACHHUZ5snNbV50e86O5mFJKR8jdVm1YSHOzNE/IUHr35dMMsJ6rkgXM2DVpJSX+nXJWG9SI4uzb2BNk0kHSH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:33a6:6e42:aa97:9ab4])
 (user=irogers job=sendgmr) by 2002:a81:b717:0:b0:560:d237:43dc with SMTP id
 v23-20020a81b717000000b00560d23743dcmr7419490ywh.3.1684788087862; Mon, 22 May
 2023 13:41:27 -0700 (PDT)
Date:   Mon, 22 May 2023 13:40:45 -0700
In-Reply-To: <20230522204047.800543-1-irogers@google.com>
Message-Id: <20230522204047.800543-2-irogers@google.com>
Mime-Version: 1.0
References: <20230522204047.800543-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 1/3] perf build: Add ability to build with a generated vmlinux.h
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

Commit a887466562b4 ("perf bpf skels: Stop using vmlinux.h generated
from BTF, use subset of used structs + CO-RE") made it so that
vmlinux.h was uncondtionally included from
tools/perf/util/vmlinux.h. This change reverts part of that change (so
that vmlinux.h is once again generated) and makes it so that the
vmlinux.h used at build time is selected from the VMLINUX_H
variable. By default the VMLINUX_H variable is set to the vmlinux.h
added in change a887466562b4, but if GEN_VMLINUX_H=1 is passed on the
build command line then the previous generation behavior kicks in.

The build with GEN_VMLINUX_H=1 currently fails with:
```
util/bpf_skel/lock_contention.bpf.c:419:8: error: redefinition of 'rq'
struct rq {};
       ^
/tmp/perf/util/bpf_skel/.tmp/../vmlinux.h:45630:8: note: previous definition is here
struct rq {
       ^
1 error generated.
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config                       |  4 ++++
 tools/perf/Makefile.perf                         | 16 +++++++++++++++-
 tools/perf/util/bpf_skel/.gitignore              |  1 +
 tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h |  0
 4 files changed, 20 insertions(+), 1 deletion(-)
 rename tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h (100%)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 70268442f7ee..636ab725ae70 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -680,6 +680,10 @@ ifdef BUILD_BPF_SKEL
   CFLAGS += -DHAVE_BPF_SKEL
 endif
 
+ifndef GEN_VMLINUX_H
+  VMLINUX_H=$(src-perf)/util/bpf_skel/vmlinux/vmlinux.h
+endif
+
 dwarf-post-unwind := 1
 dwarf-post-unwind-text := BUG
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 1593c5dcaa9e..968b95070798 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1081,7 +1081,21 @@ $(BPFTOOL): | $(SKEL_TMP_OUT)
 	$(Q)CFLAGS= $(MAKE) -C ../bpf/bpftool \
 		OUTPUT=$(SKEL_TMP_OUT)/ bootstrap
 
-$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) | $(SKEL_TMP_OUT)
+VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
+		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
+		     ../../vmlinux					\
+		     /sys/kernel/btf/vmlinux				\
+		     /boot/vmlinux-$(shell uname -r)
+VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
+
+$(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
+ifeq ($(VMLINUX_H),)
+	$(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@
+else
+	$(Q)cp "$(VMLINUX_H)" $@
+endif
+
+$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h | $(SKEL_TMP_OUT)
 	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -Wall -Werror $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
 	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@ && $(LLVM_STRIP) -g $@
 
diff --git a/tools/perf/util/bpf_skel/.gitignore b/tools/perf/util/bpf_skel/.gitignore
index 7a1c832825de..cd01455e1b53 100644
--- a/tools/perf/util/bpf_skel/.gitignore
+++ b/tools/perf/util/bpf_skel/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 .tmp
 *.skel.h
+vmlinux.h
diff --git a/tools/perf/util/bpf_skel/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
similarity index 100%
rename from tools/perf/util/bpf_skel/vmlinux.h
rename to tools/perf/util/bpf_skel/vmlinux/vmlinux.h
-- 
2.40.1.698.g37aff9b760-goog

