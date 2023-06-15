Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065F2EB64D9
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jun 2023 04:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjFOEHi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jun 2023 00:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237679AbjFOEHc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jun 2023 00:07:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46D11715
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jun 2023 21:07:30 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56942667393so17430787b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jun 2023 21:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686802050; x=1689394050;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EGSFse5BO9SaZtO47qLHwozj1QdxYYuFsGDqkkwyYl4=;
        b=eAW7X9o+ZbRUc1+mOuwXgN8xMLhafZ22t4yvIswPDNtFn8tNXX/x6GBqfO71ZdsffB
         IGbhYiz8Eph5SDgAY/HqTDBTTTwwVl/zV0GojBrRf1NnCStxSXVnxQLnCO2aUPOrn8cM
         8SMc3klIdLg0lE3LTql/4Yx7NgcsJfMHA1erciyv26keJXlKt9C45wVlShaAbzQtBjvK
         rROE2cQM87K2oiSooHVwHRK6XWvHoJKS/OYQpEFRI8+YtdpEs7rBo+Wfv+Jlxh2bo1RS
         WlFLtqlNGEoD2uud10r/bxUAz6rou5r98QQttMm4YKhta4cbMSTgZZH6z6ALpUp10pLu
         JX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686802050; x=1689394050;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EGSFse5BO9SaZtO47qLHwozj1QdxYYuFsGDqkkwyYl4=;
        b=kotGhQz2tM+ix4tnnsk1MX2WWaLBGalBMkslMAzxfdzsWCoqrxOVWp2CeIGSyz7yMQ
         qsDTRHej59095ldYbXwyWzMQSbpY5rgohqavqGE6ydRgv1YvJ6gurWdcmbzalq2Ye6XK
         W19r4EEetWTmURIBJ7l/MIE5fDtrHSk/29OuVZ0OzfywlFyoOR2afOWvwgvpCOD5A+jL
         OzyixGvfMl66eGB6vJmapowvpbVnkSZQ1aRA0T1c6N66kU7ceWGO1Zt71vx2RGyTa9Uc
         7rVrGWY8UjVbQLAsL1T1pkIlcPTrrTNLj+W3W5mRyyY94IZ+miuAdwCrADZgbEr/A3fk
         J08A==
X-Gm-Message-State: AC+VfDyzUI41IDTiNS2lFbqFU3gsAYBc9T+tEFfLNmjE8JU1omRbyjTZ
        bCXUm64rlpEAt2HKnzwoPta6BQqbMLvT
X-Google-Smtp-Source: ACHHUZ7+1/TxR7ABD0ZSiwDyEteGbtmLwjQlil4zAgWEyl03F9qS5R79VKY/or1QGHnyh0XDPTiBwsgyZ4WT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:768d:713f:8ce8:1d35])
 (user=irogers job=sendgmr) by 2002:a81:b644:0:b0:569:e04a:239d with SMTP id
 h4-20020a81b644000000b00569e04a239dmr1668459ywk.0.1686802049975; Wed, 14 Jun
 2023 21:07:29 -0700 (PDT)
Date:   Wed, 14 Jun 2023 21:07:14 -0700
Message-Id: <20230615040715.2064350-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 1/2] perf sharded_mutex: Introduce sharded_mutex
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
        Yuan Can <yuancan@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Per object mutexes may come with significant memory cost while a
global mutex can suffer from unnecessary contention. A sharded mutex
is a compromise where objects are hashed and then a particular mutex
for the hash of the object used. Contention can be controlled by the
number of shards.

Signed-off-by: Ian Rogers <irogers@google.com>

v2. Use hashmap.h's hash_bits in case of contention from alignment of
    objects.
---
 tools/perf/util/Build           |  1 +
 tools/perf/util/sharded_mutex.c | 33 +++++++++++++++++++++++++++++++++
 tools/perf/util/sharded_mutex.h | 29 +++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 tools/perf/util/sharded_mutex.c
 create mode 100644 tools/perf/util/sharded_mutex.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index ff2fd1a36bb8..96f4ea1d45c5 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -145,6 +145,7 @@ perf-y += mem2node.o
 perf-y += clockid.o
 perf-y += list_sort.o
 perf-y += mutex.o
+perf-y += sharded_mutex.o
 
 perf-$(CONFIG_LIBBPF) += bpf-loader.o
 perf-$(CONFIG_LIBBPF) += bpf_map.o
diff --git a/tools/perf/util/sharded_mutex.c b/tools/perf/util/sharded_mutex.c
new file mode 100644
index 000000000000..e11e8d0945a7
--- /dev/null
+++ b/tools/perf/util/sharded_mutex.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "sharded_mutex.h"
+
+#include <stdlib.h>
+
+struct sharded_mutex *sharded_mutex__new(size_t num_shards)
+{
+	struct sharded_mutex *result;
+	size_t size;
+	unsigned int bits;
+
+	for (bits = 0; ((size_t)1 << bits) < num_shards; bits++)
+		;
+
+	size = sizeof(*result) + sizeof(struct mutex) * (1 << bits);
+	result = malloc(size);
+	if (!result)
+		return NULL;
+
+	result->cap_bits = bits;
+	for (size_t i = 0; i < ((size_t)1 << bits); i++)
+		mutex_init(&result->mutexes[i]);
+
+	return result;
+}
+
+void sharded_mutex__delete(struct sharded_mutex *sm)
+{
+	for (size_t i = 0; i < ((size_t)1 << sm->cap_bits); i++)
+		mutex_destroy(&sm->mutexes[i]);
+
+	free(sm);
+}
diff --git a/tools/perf/util/sharded_mutex.h b/tools/perf/util/sharded_mutex.h
new file mode 100644
index 000000000000..7325e969eee3
--- /dev/null
+++ b/tools/perf/util/sharded_mutex.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef PERF_SHARDED_MUTEX_H
+#define PERF_SHARDED_MUTEX_H
+
+#include "mutex.h"
+#include "hashmap.h"
+
+/*
+ * In a situation where a lock is needed per object, having a mutex can be
+ * relatively memory expensive (40 bytes on x86-64). If the object can be
+ * constantly hashed, a sharded mutex is an alternative global pool of mutexes
+ * where the mutex is looked up from a hash value. This can lead to collisions
+ * if the number of shards isn't large enough.
+ */
+struct sharded_mutex {
+	/* mutexes array is 1<<cap_bits in size. */
+	unsigned int cap_bits;
+	struct mutex mutexes[];
+};
+
+struct sharded_mutex *sharded_mutex__new(size_t num_shards);
+void sharded_mutex__delete(struct sharded_mutex *sm);
+
+static inline struct mutex *sharded_mutex__get_mutex(struct sharded_mutex *sm, size_t hash)
+{
+	return &sm->mutexes[hash_bits(hash, sm->cap_bits)];
+}
+
+#endif  /* PERF_SHARDED_MUTEX_H */
-- 
2.41.0.162.gfafddb0af9-goog

