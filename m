Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B20F1527A3
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jul 2024 23:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720481005; cv=none; b=PS4Xm2iZFDL3M7aWdUSfrVEj2dX+5SAqbwwx0weMmWHO8Y41JAT+QbaZeTk5pg/oIhZHBgyFzQPvIMFe5hz4c1QveiMZoJJM0DLzY27bE1xZ59FGvxLuZpITHt9escqealTAv6m8x3zDUFErJUP56pBY0PIg2hhClab+OFxYCgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720481005; c=relaxed/simple;
	bh=6psedXWiVhgGXMWXvYNxOstdCMvuxEuuwfA7iWcmcGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+oIUUHs9e9wfwyV8tlx9DaiqVQzrlTNkM+TB1zvJzZahUe/GIxMf+5+t0JhOWuREs0DqC00HjihquNISt577otTQBRcGcQqkIiwxZ8R8lvi65tNBe2KBZzwjH9UA6ek8VlpCJH6Rli/Mr4Ise3plpjr8N43DRjiXYynFzeIPVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=J7fz5MBP; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="J7fz5MBP"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-25e919bec9eso762408fac.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jul 2024 16:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1720481002; x=1721085802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPQjFOQJrmmumJb1CUQeupQXr/aSCBOnaBJ4NRUg9Dk=;
        b=J7fz5MBPnO7ZcRAM1NEBK6HhCyqgLuxeeR7JFnPDgN0OT786Ey2UmZztDThJ8+7xac
         G0hOt/ezroK3iASmFcIqkXLxKqWUlT+3zePAzfq+1AalgBgWQevISLNC6v5SixHWnaZj
         q93g9mgVht9kZ8oKP3IUt9b3p0j7eAWxZblRsOysCEhG2F8NI+QezNw4FFf9jFT2N+Ak
         rPyqs7UDXYwbKhTj3OiIwyr4qTC2E1yrh8mroiIyw202hk0J3FKfcuKIYVjDNnwLg4EG
         aXmpcIhzZI04j2xQFsln2mjjEWZXC20kcXyFkNgmv/F7Q5XDkGk8rd+/20zKFu7l3CCi
         H6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720481002; x=1721085802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPQjFOQJrmmumJb1CUQeupQXr/aSCBOnaBJ4NRUg9Dk=;
        b=kTriw5UwkXahpMiWnfhxJSwrMlFTP45FE9IT6N00xgmW2lPn7o2PrqH0u+2XRIfqNX
         AyXj08MN12g01idvXH41t+OtAuKgK/1YMVqlFkUXJOzcV0yPB7Pdrr07TUZXuYXII1+5
         /2VqV+wEdbSTSWV9i/TylJh+vlCxBSa7AvHyYKKrOg8TglpUaIoKOt82nTESwCJZaDog
         Cl2i6Eqnt96PFn8OcET/kDJKue+EszUmzlQKsYfpZn0u0RkGPdGyA5Z4hQLz2wipLeuz
         8jO0+VMk46A8X2c/k6N4BWEKGaD3bgzFGiO+xlS7h8fHCKjO45Fk1CwFRGkQ1mF0AkWK
         Ikaw==
X-Gm-Message-State: AOJu0YyxwftnZkvlO1GQdloAGCrdMQlbmdhF3gVINopgzJ1ovqaUsgSs
	ugPkron+JIA1bArTI6H6R6gIQcnUdEsdQrMURbml/JlJNU4i9LE7U47H8K2vQFFtD48l+5CPk92
	JEsR6dsbJwK3kt1ZH9gopUFBneziYLlBuTXLtWvwU3FG8wWlCaviAULGaO/gXAg/ZtyMLSa0r4D
	wK/iN1mnCt+8CHg1SKWWdfTmytu8arOmBtvkPtQHAO+HKlExIjLrpg8W4=
X-Google-Smtp-Source: AGHT+IHgvnicgkruRjYUzVyfO9REfGDXS1M/onpZY0ms8UA43OsIKnZ+wnQ7WF0Kfvrq6b8u0H6N7A==
X-Received: by 2002:a05:6871:24e0:b0:25e:56a:9665 with SMTP id 586e51a60fabf-25eaebc6866mr612181fac.43.1720481001985;
        Mon, 08 Jul 2024 16:23:21 -0700 (PDT)
Received: from dev-cachen.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70b438bfa86sm437775b3a.47.2024.07.08.16.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 16:23:21 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yzhong@purestorage.com,
	Casey Chen <cachen@purestorage.com>
Subject: [PATCH] debug patch for perf report segfault
Date: Mon,  8 Jul 2024 17:23:02 -0600
Message-ID: <20240708232302.15267-3-cachen@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708232302.15267-1-cachen@purestorage.com>
References: <20240708232302.15267-1-cachen@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Debug patch to apply on 0dd5041c9a0e ("perf addr_location: Add
init/exit/copy functions")

---
 tools/perf/util/callchain.c | 4 ++++
 tools/perf/util/callchain.h | 9 +++++++++
 tools/perf/util/machine.c   | 8 ++++++--
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index b0dafc758173..2c1d9b8ff8d9 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1067,6 +1067,10 @@ int callchain_cursor_append(struct callchain_cursor *cursor,
 	node->ip = ip;
 	map__zput(node->ms.map);
 	node->ms = *ms;
+    if (ms && !ms->maps) {
+        pr_info("%s addr of node->ms %p ms %p has no maps map %p symbol %p\n",
+                __func__, &node->ms, ms, ms->map, ms->sym);
+    }
 	node->ms.map = map__get(node->ms.map);
 	node->branch = branch;
 	node->nr_loop_iter = nr_loop_iter;
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index d95615daed73..8bba51be33a9 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -6,6 +6,7 @@
 #include <linux/rbtree.h>
 #include "map_symbol.h"
 #include "branch.h"
+#include "debug.h"
 
 struct addr_location;
 struct evsel;
@@ -213,6 +214,14 @@ static inline void callchain_cursor_commit(struct callchain_cursor *cursor)
 {
 	cursor->curr = cursor->first;
 	cursor->pos = 0;
+    if (cursor->curr) {
+       struct callchain_cursor_node *curr = cursor->curr;
+       struct map_symbol *ms = &curr->ms;
+          if (ms && !ms->maps) {
+            pr_info("%s: cursor %p curr %p ms %p\n", __func__, cursor, curr, ms);
+            dump_stack();
+          }
+    }
 }
 
 /* Cursor reading iteration helpers */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 9fcf357a4d53..e6c90bb6b842 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2357,6 +2357,10 @@ static int add_callchain_ip(struct thread *thread,
 			goto out;
 		}
 		thread__find_symbol(thread, *cpumode, ip, &al);
+        if (!al.maps) {
+            pr_info("%s: i'm here! al.map %p al.sym %p ip >= PERF_CONTEXT_MAX: %d cpumode %d ip 0x%lx\n",
+                    __func__, al.map, al.sym, ip >= PERF_CONTEXT_MAX, *cpumode, ip);
+        }
 	}
 
 	if (al.sym != NULL) {
@@ -2384,8 +2388,8 @@ static int add_callchain_ip(struct thread *thread,
 	ms.map = map__get(al.map);
 	ms.sym = al.sym;
 
-	if (!branch && append_inlines(cursor, &ms, ip) == 0)
-		goto out;
+//	if (!branch && append_inlines(cursor, &ms, ip) == 0)
+//		goto out;
 
 	srcline = callchain_srcline(&ms, al.addr);
 	err = callchain_cursor_append(cursor, ip, &ms,
-- 
2.34.1

