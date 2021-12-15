Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEB3C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Dec 2021 16:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244501AbhLOQXF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Dec 2021 11:23:05 -0500
Received: from foss.arm.com ([217.140.110.172]:56850 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244755AbhLOQXD (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Dec 2021 11:23:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E91171474
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Dec 2021 08:23:02 -0800 (PST)
Received: from e126387.extremechicken.org (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9428D3F5A1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Dec 2021 08:23:02 -0800 (PST)
From:   carsten.haitzler@foss.arm.com
To:     linux-perf-users@vger.kernel.org
Subject: [PATCH 09/12] perf test: Add add memcpy test for coresight quality checking
Date:   Wed, 15 Dec 2021 16:22:47 +0000
Message-Id: <20211215162250.70322-9-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215162250.70322-1-carsten.haitzler@foss.arm.com>
References: <20211215162250.70322-1-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Carsten Haitzler <carsten.haitzler@arm.com>

This adds memory bound tests for quality checking perf's aux data
recording.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 tools/perf/tests/shell/coresight_memcpy_1m.sh | 18 +++++++++
 .../perf/tests/shell/coresight_memcpy_32m.sh  | 18 +++++++++
 .../perf/tests/shell/coresight_memcpy_64k.sh  | 18 +++++++++
 .../perf/tests/shell/tools/coresight/Makefile |  3 +-
 .../shell/tools/coresight/memcpy/Makefile     | 29 ++++++++++++++
 .../shell/tools/coresight/memcpy/memcpy.c     | 40 +++++++++++++++++++
 6 files changed, 125 insertions(+), 1 deletion(-)
 create mode 100755 tools/perf/tests/shell/coresight_memcpy_1m.sh
 create mode 100755 tools/perf/tests/shell/coresight_memcpy_32m.sh
 create mode 100755 tools/perf/tests/shell/coresight_memcpy_64k.sh
 create mode 100644 tools/perf/tests/shell/tools/coresight/memcpy/Makefile
 create mode 100644 tools/perf/tests/shell/tools/coresight/memcpy/memcpy.c

diff --git a/tools/perf/tests/shell/coresight_memcpy_1m.sh b/tools/perf/tests/shell/coresight_memcpy_1m.sh
new file mode 100755
index 000000000000..fa1c28d73b66
--- /dev/null
+++ b/tools/perf/tests/shell/coresight_memcpy_1m.sh
@@ -0,0 +1,18 @@
+#!/bin/sh -e
+# Coresight / Memcpy 1M
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="memcpy"
+. $(dirname $0)/lib/coresight.sh
+ARGS="1024 2"
+DATV="1m"
+DATA="$DATD/perf-$TEST-$DATV.data"
+
+perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
+
+perf_dump_aux_verify "$DATA" 39 766 766
+
+err=$?
+exit $err
diff --git a/tools/perf/tests/shell/coresight_memcpy_32m.sh b/tools/perf/tests/shell/coresight_memcpy_32m.sh
new file mode 100755
index 000000000000..4ab5459e3824
--- /dev/null
+++ b/tools/perf/tests/shell/coresight_memcpy_32m.sh
@@ -0,0 +1,18 @@
+#!/bin/sh -e
+# Coresight / Memcpy 32M
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="memcpy"
+. $(dirname $0)/lib/coresight.sh
+ARGS="32768 1"
+DATV="32m"
+DATA="$DATD/perf-$TEST-$DATV.data"
+
+perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
+
+perf_dump_aux_verify "$DATA" 39 7804 7804
+
+err=$?
+exit $err
diff --git a/tools/perf/tests/shell/coresight_memcpy_64k.sh b/tools/perf/tests/shell/coresight_memcpy_64k.sh
new file mode 100755
index 000000000000..5b6ba2a6d394
--- /dev/null
+++ b/tools/perf/tests/shell/coresight_memcpy_64k.sh
@@ -0,0 +1,18 @@
+#!/bin/sh -e
+# Coresight / Memcpy 64K
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="memcpy"
+. $(dirname $0)/lib/coresight.sh
+ARGS="64 40"
+DATV="64k"
+DATA="$DATD/perf-$TEST-$DATV.data"
+
+perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
+
+perf_dump_aux_verify "$DATA" 40 934 934
+
+err=$?
+exit $err
diff --git a/tools/perf/tests/shell/tools/coresight/Makefile b/tools/perf/tests/shell/tools/coresight/Makefile
index a1a752f45c46..99030c889b04 100644
--- a/tools/perf/tests/shell/tools/coresight/Makefile
+++ b/tools/perf/tests/shell/tools/coresight/Makefile
@@ -8,7 +8,8 @@ SUBDIRS = \
 	asm_pure_loop \
 	thread_loop \
 	bubble_sort \
-	bubble_sort_thread
+	bubble_sort_thread \
+        memcpy
 
 all: $(SUBDIRS)
 $(SUBDIRS):
diff --git a/tools/perf/tests/shell/tools/coresight/memcpy/Makefile b/tools/perf/tests/shell/tools/coresight/memcpy/Makefile
new file mode 100644
index 000000000000..7c31fe4ec399
--- /dev/null
+++ b/tools/perf/tests/shell/tools/coresight/memcpy/Makefile
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+include ../Makefile.miniconfig
+
+BIN=memcpy
+LIB=
+
+all: $(BIN)
+
+$(BIN): $(BIN).c
+ifdef CORESIGHT
+ifeq ($(ARCH),arm64)
+	$(Q)$(CC) $(BIN).c -o $(BIN) $(LIB)
+endif
+endif
+
+install-tests: all
+ifdef CORESIGHT
+ifeq ($(ARCH),arm64)
+	$(call QUIET_INSTALL, tests) \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/tools/$(BIN)'; \
+		$(INSTALL) $(BIN) '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/tools/$(BIN)/$(BIN)'
+endif
+endif
+
+clean:
+	$(Q)$(RM) -f $(BIN)
+
+.PHONY: all clean install-tests
diff --git a/tools/perf/tests/shell/tools/coresight/memcpy/memcpy.c b/tools/perf/tests/shell/tools/coresight/memcpy/memcpy.c
new file mode 100644
index 000000000000..1aa0617448ad
--- /dev/null
+++ b/tools/perf/tests/shell/tools/coresight/memcpy/memcpy.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+// Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+
+int main(int argc, char **argv)
+{
+	unsigned long i, len, size;
+	unsigned char *src, *dst;
+	long long v;
+
+	if (argc < 3) {
+		printf("ERR: %s [copysize Kb] [numloops (hundreds)]\n", argv[0]);
+		exit(1);
+	}
+
+	v = atoll(argv[1]);
+	if ((v < 1) || (v > (1024 * 1024))) {
+		printf("ERR: max memory 1GB (1048576 KB)\n");
+		exit(1);
+	}
+	size = v;
+	v = atoll(argv[2]);
+	if ((v < 1) || (v > 40000000000ll)) {
+		printf("ERR: loops 1-40000000000 (hundreds)\n");
+		exit(1);
+	}
+	len = v * 100;
+	src = malloc(size * 1024);
+	dst = malloc(size * 1024);
+	if ((!src) || (!dst)) {
+		printf("ERR: Can't allocate memory\n");
+		exit(1);
+	}
+	for (i = 0; i < len; i++)
+		memcpy(dst, src, size * 1024);
+	return 0;
+}
-- 
2.32.0

