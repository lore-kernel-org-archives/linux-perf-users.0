From: Oliver Yang <yangoliver@gmail.com>
Subject: [PATCH] Fix build failures of python/perf.so.
Date: Mon, 22 Jul 2013 19:45:59 +0800
Message-ID: <1374493559-11139-1-git-send-email-yangoliver@gmail.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:52983 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767Ab3GVLq0 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 22 Jul 2013 07:46:26 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@ghostprotocols.net
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Oliver Yang <yangoliver@gmail.com>

If gcc and python are not under the standard path, it could cause
the build failure of perf.so.

Signed-off-by: Oliver Yang <yangoliver@gmail.com>
---
 tools/perf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index 641fccd..9f88f6f 100644
--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -151,7 +151,7 @@ PYTHON_EXT_SRCS := $(shell grep -v ^\# util/python-ext-sources)
 PYTHON_EXT_DEPS := util/python-ext-sources util/setup.py $(LIBTRACEEVENT) $(LIBLK)
 
 $(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS)
-	$(QUIET_GEN)CFLAGS='$(CFLAGS)' $(PYTHON_WORD) util/setup.py \
+	$(QUIET_GEN)CFLAGS='$(CROSS_COMPILE)' '$(CFLAGS)' $(PYTHON_WORD) util/setup.py \
 	  --quiet build_ext; \
 	mkdir -p $(OUTPUT)python && \
 	cp $(PYTHON_EXTBUILD_LIB)perf.so $(OUTPUT)python/
-- 
1.8.1.2
