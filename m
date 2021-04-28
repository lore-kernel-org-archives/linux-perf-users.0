Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED7CC433ED
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Apr 2021 09:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D9DE61424
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Apr 2021 09:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbhD1JV0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Apr 2021 05:21:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46633 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230113AbhD1JV0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Apr 2021 05:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619601641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc; bh=A3TsiNBEJNISBAJovT0xbNWwctM6FA0Dxzplw/nnkfw=;
        b=eR2msKkPpoiUr5n1JfHwtIONaEF5sQ8IRY1DormLuQLX8UJJ+H8G4uIgLGOJnPte9qeKsX
        y1ja3sBEmURu14jSwiEnXzjb2CcP7TMKjDCzbhQWFnGc5jAH/hbKej4Xr0//+PaGq0dgSX
        U524AoBUQnvjFr+Z2ZfB07qKeE/JwMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-J_qAmENXNeeLdknvviApoA-1; Wed, 28 Apr 2021 05:20:38 -0400
X-MC-Unique: J_qAmENXNeeLdknvviApoA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1901CC625
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Apr 2021 09:20:37 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.40.208.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0101410023AB;
        Wed, 28 Apr 2021 09:20:25 +0000 (UTC)
From:   Michael Petlan <mpetlan@redhat.com>
To:     acme@redhat.com, jolsa@redhat.com, linux-perf-users@vger.kernel.org
Subject: [PATCH] perf: enable libtraceevent dynamic linking
Date:   Wed, 28 Apr 2021 11:20:23 +0200
Message-Id: <20210428092023.4009-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently we support only static linking with kernel's libtraceevent
(tools/lib/traceevent). This patch adds libtraceevent package detection
and support to link perf with it dynamically.

The libtraceevent package status is displayed with:
$ make VF=1 LIBTRACEEVENT_DYNAMIC=1
...
...                 libtraceevent: [ on  ]

Default behavior remains the same (static linking).

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/build/Makefile.feature             |  1 +
 tools/build/feature/Makefile             |  4 ++++
 tools/build/feature/test-libtraceevent.c | 12 ++++++++++++
 tools/perf/Makefile.config               |  9 +++++++++
 tools/perf/Makefile.perf                 |  8 ++++++--
 5 files changed, 32 insertions(+), 2 deletions(-)
 create mode 100644 tools/build/feature/test-libtraceevent.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 74e255d58d8d..b3221a43fa65 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -52,6 +52,7 @@ FEATURE_TESTS_BASIC :=                  \
         libpython-version               \
         libslang                        \
         libslang-include-subdir         \
+        libtraceevent                   \
         libcrypto                       \
         libunwind                       \
         pthread-attr-setaffinity-np     \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 3e55edb3ea54..ec203e28407f 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -36,6 +36,7 @@ FILES=                                          \
          test-libpython-version.bin             \
          test-libslang.bin                      \
          test-libslang-include-subdir.bin       \
+         test-libtraceevent.bin                 \
          test-libcrypto.bin                     \
          test-libunwind.bin                     \
          test-libunwind-debug-frame.bin         \
@@ -196,6 +197,9 @@ $(OUTPUT)test-libslang.bin:
 $(OUTPUT)test-libslang-include-subdir.bin:
 	$(BUILD) -lslang
 
+$(OUTPUT)test-libtraceevent.bin:
+	$(BUILD) -ltraceevent
+
 $(OUTPUT)test-libcrypto.bin:
 	$(BUILD) -lcrypto
 
diff --git a/tools/build/feature/test-libtraceevent.c b/tools/build/feature/test-libtraceevent.c
new file mode 100644
index 000000000000..416b11ffd4b4
--- /dev/null
+++ b/tools/build/feature/test-libtraceevent.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <traceevent/trace-seq.h>
+
+int main(void)
+{
+	int rv = 0;
+	struct trace_seq s;
+	trace_seq_init(&s);
+	rv += !(s.state == TRACE_SEQ__GOOD);
+	trace_seq_destroy(&s);
+	return rv;
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 3514fe956ed1..99c73a7b6a26 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1079,6 +1079,15 @@ ifdef LIBPFM4
   endif
 endif
 
+ifdef LIBTRACEEVENT_DYNAMIC
+  $(call feature_check,libtraceevent)
+  ifeq ($(feature-libtraceevent), 1)
+    EXTLIBS += -ltraceevent
+  else
+    dummy := $(error Error: No libtraceevent devel library found, please install libtraceevent-devel);
+  endif
+endif
+
 # Among the variables below, these:
 #   perfexecdir
 #   perf_include_dir
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 090fb9d62665..fde8ca22d117 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -128,6 +128,8 @@ include ../scripts/utilities.mak
 #
 # Define BUILD_BPF_SKEL to enable BPF skeletons
 #
+# Define LIBTRACEEVENT_DYNAMIC to enable libtraceevent dynamic linking
+#
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
@@ -309,7 +311,6 @@ endif
 
 LIBTRACEEVENT = $(TE_PATH)libtraceevent.a
 export LIBTRACEEVENT
-
 LIBTRACEEVENT_DYNAMIC_LIST = $(PLUGINS_PATH)libtraceevent-dynamic-list
 
 #
@@ -374,12 +375,15 @@ endif
 
 export PERL_PATH
 
-PERFLIBS = $(LIBAPI) $(LIBTRACEEVENT) $(LIBSUBCMD) $(LIBPERF)
+PERFLIBS = $(LIBAPI) $(LIBSUBCMD) $(LIBPERF)
 ifndef NO_LIBBPF
   ifndef LIBBPF_DYNAMIC
     PERFLIBS += $(LIBBPF)
   endif
 endif
+ifndef LIBTRACEEVENT_DYNAMIC
+  PERFLIBS += $(LIBTRACEEVENT)
+endif
 
 # We choose to avoid "if .. else if .. else .. endif endif"
 # because maintaining the nesting to match is a pain.  If
-- 
2.18.4

