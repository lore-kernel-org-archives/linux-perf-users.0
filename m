Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5859C76196
	for <linux-perf-users@archiver.kernel.org>; Mon,  3 Apr 2023 21:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjDCVK7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Apr 2023 17:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbjDCVK4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Apr 2023 17:10:56 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7D240CA
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Apr 2023 14:10:41 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id kx3-20020a17090b228300b0023cfd09ed94so14752503pjb.4
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Apr 2023 14:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680556241;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zyk/CdJwNDC7IKrexRQvFlKvUXUTz4IaEWXwnZLm3Y4=;
        b=ddG8fNo5spuvyPOm/6zV9FW1MqK9o8EJEtSo0/692esK9CiDrNwKs/lzRFenCPL6dt
         uVVmjIAa0LkKeevBhrEUkSr5eVPi2VDC74LnAjBDdsn18VT8MLMHWHs+NTlsoeeCFNrL
         4JUXBEEETmiTR9PO1X1KCc/Z4Ar9C5XgNSG7AXpQnBQF68+TGaSGkGRJt11m65j4rIFv
         Ko/YrvdhDAQg1ThqYuI10M/ZbPKFUe9wcAUDekvdO4d4ruy4zBWbgRcTPZkL/qLpR5Nu
         cCyRF1zxHZFjI9amVej3IkoGtRH9SaUNsGLldxoWpQJMMYbs5s/hHwY0HEVMzk6INCpq
         8Xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680556241;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zyk/CdJwNDC7IKrexRQvFlKvUXUTz4IaEWXwnZLm3Y4=;
        b=mAYR4QyLkKktEdFtFKcdZ3jUlml7lGdpgw70vcV0c45vHVUjOQMGIhLBQc6Y86dYrR
         TI27Kt90PYeR8sVKww1dh68mDNB8LtwrSsThO/J9uLW4g8LJaX8R9nz5Ajj9BETWyWEz
         y/xQBqC2qe/2+34M/qaw8Q4/o20OxMsNgiFu5bc4kOyAx8DRi9q+s7wDv980v36hsTET
         RvL9XMM+35dXov5UN4Ns5ZhAslOwGdl2EN2bO4sDlOkn5hAHUqOU+htBt996Vi5vv7Pv
         WYX7INCfbWtjN6yy9FvxbLaPrXjKu5VgtLd0FhNpwe+8QUpn50UcwkwDnkn3ovDmgqQH
         xFoQ==
X-Gm-Message-State: AAQBX9c07etk/BDV6Xd7VqFdhOhaqnLae6RRQjDEbI5ekn+DbJ6bXhus
        TgSM71iXowN8OiCyNQXI9HkxjccjJQz/
X-Google-Smtp-Source: AKy350ZLLTJV9gZYfLhEsplLJBqBSYCwNggDCwuKE12GZfHAxLeZsKfejAdI9dZPfCOPI3h1P+FsKmJhaDgG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9dc:a977:817d:341])
 (user=irogers job=sendgmr) by 2002:a05:6a00:179f:b0:625:cf6d:b272 with SMTP
 id s31-20020a056a00179f00b00625cf6db272mr21131pfg.6.1680556241365; Mon, 03
 Apr 2023 14:10:41 -0700 (PDT)
Date:   Mon,  3 Apr 2023 14:10:21 -0700
In-Reply-To: <20230403211021.1892231-1-irogers@google.com>
Message-Id: <20230403211021.1892231-2-irogers@google.com>
Mime-Version: 1.0
References: <20230403211021.1892231-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 2/2] perf build: Warn for BPF skeletons if endian mismatches
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Done as a warning as I'm not fully confident of the test's robustness
of comparing the macro definition of __BYTE_ORDER__.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index dd203f0a2b7e..4be817ea4a59 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -659,14 +659,17 @@ ifndef NO_BPF_SKEL
   $(call feature_check,clang-bpf-co-re)
   ifeq ($(feature-clang-bpf-co-re), 0)
     dummy := $(error: ERROR: BPF skeletons unsupported. clang too old/not installed or build with NO_BPF_SKEL=1.)
-  else
-    ifeq ($(filter -DHAVE_LIBBPF_SUPPORT, $(CFLAGS)),)
-      dummy := $(error: ERROR: BPF skeletons unsupported. BPF skeleton support requires libbpf or build with NO_BPF_SKEL=1.)
-    else
-      $(call detected,CONFIG_PERF_BPF_SKEL)
-      CFLAGS += -DHAVE_BPF_SKEL
-    endif
   endif
+  ifeq ($(filter -DHAVE_LIBBPF_SUPPORT, $(CFLAGS)),)
+    dummy := $(error: ERROR: BPF skeletons unsupported. BPF skeleton support requires libbpf or build with NO_BPF_SKEL=1.)
+  endif
+  host_byte_order=$(echo ""|$(HOSTCC) -dM -E -|grep __BYTE_ORDER__)
+  target_byte_order=$(echo ""|$(CC) -dM -E -|grep __BYTE_ORDER__)
+  ifneq ($(host_byte_order), $(target_byte_order))
+    $(warning Possibly mismatched host and target endianness may break BPF skeletons)
+  endif
+  $(call detected,CONFIG_PERF_BPF_SKEL)
+  CFLAGS += -DHAVE_BPF_SKEL
 endif
 
 dwarf-post-unwind := 1
-- 
2.40.0.348.gf938b09366-goog

