Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF66C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852D5613B3
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239987AbhKHNkj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:40:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20673 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239986AbhKHNkj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mLBIZm125L57+ih668kkqlf+lsxmgSw9GGGqaIbP6TU=;
        b=BGmw8+MkqyCzScf3LXfOMGKfetHKccCz3ojbDQQTMnPhDY/G61DHG4qTG08nn7KZ4F2lOW
        em5yIwfoPOeMJrYBNQO1tMlLfReaWMFGHloiCEKON7j7Qcyg4q+WRzv8BdtJOmOIvud/N6
        6LcghzJdfKsAcGUgfMwDGHvWZyb2Ol8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-llVziA0hMuGFKPqyOkIe4A-1; Mon, 08 Nov 2021 08:37:53 -0500
X-MC-Unique: llVziA0hMuGFKPqyOkIe4A-1
Received: by mail-wm1-f70.google.com with SMTP id 144-20020a1c0496000000b003305ac0e03aso10152508wme.8
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:37:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mLBIZm125L57+ih668kkqlf+lsxmgSw9GGGqaIbP6TU=;
        b=t9y6fP3p8YZrMJASOjW9QUo9Q8oG7D4FPpYqo/Wwkb/YXUD0iS5DupqiY5AhDsTOSw
         mH+qYuAILlk1WSNj3iTKwYS0JvVUTmuSmM+1z3/01iE56V9WcPsFQIyecSgBB1uAUL9e
         s3/r5HaZv133y9rbCW7zNTmfjAYC4gh3uZEbH/Q4COBOFUvpZm53s3gGzpAf6TfqB4g9
         4w3UkOHk38byY2SmH+PHlrqOuaDAVMaipxEINpzsB1+dEAtvsKQRcztdyyLEZu+aDjxZ
         sU3KmsckiDUokrhM8d6aRCDfloh614Fk6+r20A1/FTQ4Xv97FUwrE/Qa+x3ziJyB6Wdi
         8O1Q==
X-Gm-Message-State: AOAM532bY9ozf+6+lFMSghgxsYkTsq+rmivmc5g2wTr+QawcMJqhvyrp
        3el+4EWAQkIPxvlmkk7jTXsQsS6vpGbuaFs/+Ar/YIBUt75LIlAmuD9HZ4/WP3PoLIu6XYJvoZi
        0jHJP+gI7TpXfq6ur2JAR9MYTilEw2A==
X-Received: by 2002:a5d:550c:: with SMTP id b12mr71919379wrv.427.1636378672399;
        Mon, 08 Nov 2021 05:37:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJ+93794U7Zy0OlVhyhMS20ssi39teEj0SIV5PStd1oeD2zE6im+R41oHOU5OB9i7OgR1dyA==
X-Received: by 2002:a5d:550c:: with SMTP id b12mr71919319wrv.427.1636378671907;
        Mon, 08 Nov 2021 05:37:51 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id o26sm19554923wmc.17.2021.11.08.05.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:37:51 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 05/59] tools api fs: Move in the fncache from perf
Date:   Mon,  8 Nov 2021 14:36:16 +0100
Message-Id: <20211108133710.1352822-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving fncache from perf under libapi.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/api/fs/Build             |  1 +
 tools/lib/api/fs/fncache.c         | 63 ++++++++++++++++++++++++++++++
 tools/lib/api/fs/fs.h              |  2 +
 tools/perf/arch/x86/util/pmu.c     |  1 -
 tools/perf/tests/parse-events.c    |  1 -
 tools/perf/util/Build              |  1 -
 tools/perf/util/fncache.c          | 63 ------------------------------
 tools/perf/util/fncache.h          |  7 ----
 tools/perf/util/pmu-hybrid.c       |  1 -
 tools/perf/util/pmu.c              |  1 -
 tools/perf/util/python-ext-sources |  1 -
 tools/perf/util/srccode.c          | 10 ++++-
 12 files changed, 75 insertions(+), 77 deletions(-)
 create mode 100644 tools/lib/api/fs/fncache.c
 delete mode 100644 tools/perf/util/fncache.c
 delete mode 100644 tools/perf/util/fncache.h

diff --git a/tools/lib/api/fs/Build b/tools/lib/api/fs/Build
index 0f75b28654de..3af4b5265a5f 100644
--- a/tools/lib/api/fs/Build
+++ b/tools/lib/api/fs/Build
@@ -1,3 +1,4 @@
 libapi-y += fs.o
 libapi-y += tracing_path.o
 libapi-y += cgroup.o
+libapi-y += fncache.o
diff --git a/tools/lib/api/fs/fncache.c b/tools/lib/api/fs/fncache.c
new file mode 100644
index 000000000000..7fb4586c341a
--- /dev/null
+++ b/tools/lib/api/fs/fncache.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Manage a cache of file names' existence */
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <linux/list.h>
+#include "fs.h"
+
+struct fncache {
+	struct hlist_node nd;
+	bool res;
+	char name[];
+};
+
+#define FNHSIZE 61
+
+static struct hlist_head fncache_hash[FNHSIZE];
+
+static unsigned shash(const unsigned char *s)
+{
+	unsigned h = 0;
+	while (*s)
+		h = 65599 * h + *s++;
+	return h ^ (h >> 16);
+}
+
+static bool lookup_fncache(const char *name, bool *res)
+{
+	int h = shash((const unsigned char *)name) % FNHSIZE;
+	struct fncache *n;
+
+	hlist_for_each_entry(n, &fncache_hash[h], nd) {
+		if (!strcmp(n->name, name)) {
+			*res = n->res;
+			return true;
+		}
+	}
+	return false;
+}
+
+static void update_fncache(const char *name, bool res)
+{
+	struct fncache *n = malloc(sizeof(struct fncache) + strlen(name) + 1);
+	int h = shash((const unsigned char *)name) % FNHSIZE;
+
+	if (!n)
+		return;
+	strcpy(n->name, name);
+	n->res = res;
+	hlist_add_head(&n->nd, &fncache_hash[h]);
+}
+
+/* No LRU, only use when bounded in some other way. */
+bool file_available(const char *name)
+{
+	bool res;
+
+	if (lookup_fncache(name, &res))
+		return res;
+	res = access(name, R_OK) == 0;
+	update_fncache(name, res);
+	return res;
+}
diff --git a/tools/lib/api/fs/fs.h b/tools/lib/api/fs/fs.h
index aa222ca30311..c42d4ff30ca7 100644
--- a/tools/lib/api/fs/fs.h
+++ b/tools/lib/api/fs/fs.h
@@ -59,4 +59,6 @@ int sysfs__read_str(const char *entry, char **buf, size_t *sizep);
 int sysfs__read_bool(const char *entry, bool *value);
 
 int sysfs__write_int(const char *entry, int value);
+
+bool file_available(const char *name);
 #endif /* __API_FS__ */
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 74d69db1ea99..c875dded65bb 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -13,7 +13,6 @@
 #include "../../../util/intel-pt.h"
 #include "../../../util/intel-bts.h"
 #include "../../../util/pmu.h"
-#include "../../../util/fncache.h"
 
 #define TEMPLATE_ALIAS	"%s/bus/event_source/devices/%s/alias"
 
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 8875e388563e..69381fe1655d 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -9,7 +9,6 @@
 #include "pmu-hybrid.h"
 #include <dirent.h>
 #include <errno.h>
-#include "fncache.h"
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 03d5d6ed7fe4..b93828aacc27 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -52,7 +52,6 @@ perf-y += header.o
 perf-y += callchain.o
 perf-y += values.o
 perf-y += debug.o
-perf-y += fncache.o
 perf-y += machine.o
 perf-y += map.o
 perf-y += pstack.o
diff --git a/tools/perf/util/fncache.c b/tools/perf/util/fncache.c
deleted file mode 100644
index 6225cbc52310..000000000000
--- a/tools/perf/util/fncache.c
+++ /dev/null
@@ -1,63 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* Manage a cache of file names' existence */
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <linux/list.h>
-#include "fncache.h"
-
-struct fncache {
-	struct hlist_node nd;
-	bool res;
-	char name[];
-};
-
-#define FNHSIZE 61
-
-static struct hlist_head fncache_hash[FNHSIZE];
-
-unsigned shash(const unsigned char *s)
-{
-	unsigned h = 0;
-	while (*s)
-		h = 65599 * h + *s++;
-	return h ^ (h >> 16);
-}
-
-static bool lookup_fncache(const char *name, bool *res)
-{
-	int h = shash((const unsigned char *)name) % FNHSIZE;
-	struct fncache *n;
-
-	hlist_for_each_entry(n, &fncache_hash[h], nd) {
-		if (!strcmp(n->name, name)) {
-			*res = n->res;
-			return true;
-		}
-	}
-	return false;
-}
-
-static void update_fncache(const char *name, bool res)
-{
-	struct fncache *n = malloc(sizeof(struct fncache) + strlen(name) + 1);
-	int h = shash((const unsigned char *)name) % FNHSIZE;
-
-	if (!n)
-		return;
-	strcpy(n->name, name);
-	n->res = res;
-	hlist_add_head(&n->nd, &fncache_hash[h]);
-}
-
-/* No LRU, only use when bounded in some other way. */
-bool file_available(const char *name)
-{
-	bool res;
-
-	if (lookup_fncache(name, &res))
-		return res;
-	res = access(name, R_OK) == 0;
-	update_fncache(name, res);
-	return res;
-}
diff --git a/tools/perf/util/fncache.h b/tools/perf/util/fncache.h
deleted file mode 100644
index fe020beaefb1..000000000000
--- a/tools/perf/util/fncache.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef _FCACHE_H
-#define _FCACHE_H 1
-
-unsigned shash(const unsigned char *s);
-bool file_available(const char *name);
-
-#endif
diff --git a/tools/perf/util/pmu-hybrid.c b/tools/perf/util/pmu-hybrid.c
index f51ccaac60ee..65fdce81a384 100644
--- a/tools/perf/util/pmu-hybrid.c
+++ b/tools/perf/util/pmu-hybrid.c
@@ -13,7 +13,6 @@
 #include <stdarg.h>
 #include <locale.h>
 #include <api/fs/fs.h>
-#include "fncache.h"
 #include "pmu-hybrid.h"
 
 LIST_HEAD(perf_pmu__hybrid_pmus);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 55d834160428..13e1835955e0 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -26,7 +26,6 @@
 #include "header.h"
 #include "string2.h"
 #include "strbuf.h"
-#include "fncache.h"
 #include "pmu-hybrid.h"
 
 struct perf_pmu perf_pmu__fake;
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index a685d20165f7..992a76c2af01 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -39,4 +39,3 @@ util/affinity.c
 util/rwsem.c
 util/hashmap.c
 util/pmu-hybrid.c
-util/fncache.c
diff --git a/tools/perf/util/srccode.c b/tools/perf/util/srccode.c
index 476e99896d5e..5c1ff87eb98c 100644
--- a/tools/perf/util/srccode.c
+++ b/tools/perf/util/srccode.c
@@ -16,7 +16,7 @@
 #include "srccode.h"
 #include "debug.h"
 #include <internal/lib.h> // page_size
-#include "fncache.h"
+#include <api/fs/fs.h>
 
 #define MAXSRCCACHE (32*1024*1024)
 #define MAXSRCFILES     64
@@ -86,6 +86,14 @@ static void free_srcfile(struct srcfile *sf)
 	num_srcfiles--;
 }
 
+static unsigned shash(const unsigned char *s)
+{
+	unsigned h = 0;
+	while (*s)
+		h = 65599 * h + *s++;
+	return h ^ (h >> 16);
+}
+
 static struct srcfile *find_srcfile(char *fn)
 {
 	struct stat st;
-- 
2.31.1

