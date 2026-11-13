Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590280;
	b=bPgYayVKMlb6yomZFWMXo6SL21F7TOdD7LnEF4sZwR5gkvzE2qgF+s0WFgZa32QlXWKQ
	 WPK68CgohAlaslWqK5/R5JUj03kqtz0V2FtbIOI6ELxRYwV1+SLBJNZ0qntcyc7/9wmwm
	 IC4nq7MFZROAQu4pokxUjVyRe/Ipak5JQzw+TtuqvZAZI/V9V6hvczglw3uR2S9yni3z8
	 RyRsBNLCu8B6+GF1Oj1Htl5bxpaVDekIgCtrpoaUaYxI44Iz+XwxsuWQo0FKQ7vO8Q3gj
	 6yH2AUmGRE/a5qPvNTkNMOm2QPIwcXZZJ0WLKiQ6P9B052XrbCNLWajbS9Mo7WMHCZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=nHgv6a3hA/GCMYg2RN4u4+quJsc0ftn7ytRR3fNbMco=;
	b=1NbzA7W1J86jlg/wMbDClz4/f3f/aHdpxCMadKEh0YwYPX83yAdzdBgnB01lu++vIZA0
	 ld9JijNonQbMwh2BnjevIb1nqQkoZ87y4LY+oRGjTaMgG3N1U99jcrYXBvhQM1EHv5IZT
	 p2zzjqtPQAobazbeUJJZqI77+efaO9M6ReXkJc/+sLVwWkyaqahNIiiNbayIXsjMl0vi0
	 7ByhHLiFrg4hG3Ml/C36OTMCjKy7SZ38LPK4gUZQ1T6vpVQy5WkAk8+eTUIvm09ZZNDkM
	 Js0PkaupX6fqhCw2H1jC5L9Nxts3SyYYwtCPKVy1oHd14V87E4vW33WczJedQvxkc4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gxjEkPGu;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E90606CED0
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87E90606CED0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gxjEkPGu
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1383723dfddso1328438c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 09:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794590280; x=1795195080; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nHgv6a3hA/GCMYg2RN4u4+quJsc0ftn7ytRR3fNbMco=;
        b=gxjEkPGuNJdN2A8Fi3icBkRYrPWEkqTFNkkiXZFokKFdyf4fFkwWpvd4SvZOkCumyR
         hcplTE/tkMYHvqJz6/MZ44rSj9vQEzo0qrAbTG3yrvph2xrp6FXXgqzTlXXWT50z7L/N
         +59jDAy000tE1uu+kFFBK15cFyM3/dIE/pnyTeCV8kRNrbseWn+DIVnG4ZQNv074vPZ9
         Lg6R6rWQqO4CJJSdFWaz1ug+Np67YPsl7VlClygyUjag8coWiHSTNyzE6JzZJZMsHy6k
         hQ3xnbqROMJUxAR+mZQhKhlCeHX+wOcKGYiuvabrat3mDhuCavX491h+y1h9hd5gZbcc
         kjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590280; x=1795195080;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nHgv6a3hA/GCMYg2RN4u4+quJsc0ftn7ytRR3fNbMco=;
        b=1FVj6EMUcRQ2SUSRPs5NxuS4XHL3hqCnMew84yHJOp9Hz9ym+bfq3iLy1l3hGpaxTi
         PAvJMDt5HwCam1EdubjGTtWPCyR9PqqIm3n4W++syDZ+A/KS2euLCsphlrSELPnXMxFq
         hq0+WYH/gU371jwxUOANQ4zF7rFuhidqtNKic6w2OlJlIx6Xz1O+6xWb/svIsA1Z/FVl
         OoYvrnew2nERkc08/X3dFzRD8ITH15RxO0n3TdxrmByxUzXNhBbEjYC27Y0OucRF7VDT
         HxtXT6Bpi4dGcj1weiB1gV+ZXqKsQoxEm0obTC44SbMl+MPeSxxMRaFK7rHDwxLnU1wl
         ilXg==
X-Forwarded-Encrypted: i=1; AL+hErF22h+edNKdDeWWfukeQVknPdLuJvp9D5XQllH9d/IGtvs9wVggJ1zRJUDTmiYs8UAcBgSMNlpdHcHv2J2thcA1@vger.kernel.org
X-Gm-Message-State: APuU4Z+x/QWE7qLadsjvilhpWgJOv/3GYj53CLlsh1cHbaaIvNa9PSaF
	XmIVErlDoaaLVBsp47GfZalIwIUadmOlbQK3QpDLVYylA/bot5EUvPGW94sVavubNbMdlSOeccn
	xIKunADIiVw==
X-Received: from dlam22-n2.prod.google.com ([2002:a05:701b:2096:20b0:1b2:3edb:a716])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4583:10b0:1b2:42e3:e5d7
 with SMTP id a92af1059eb24-1b5031320femr2706606c88.34.1794590279276; Fri, 13
 Nov 2026 09:17:59 -0800 (PST)
Date: Fri, 13 Nov 2026 09:17:13 -0800
In-Reply-To: <20261113171734.2188066-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110220803.2503416-1-irogers@google.com> <20261113171734.2188066-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113171734.2188066-3-irogers@google.com>
Subject: [PATCH v4 02/23] perf threads: Avoid table->lock self-deadlock in threads__for_each_thread()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, haghdoost@uber.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

threads__for_each_thread() holds down_read(&table->lock) while invoking
its callback fn(). Callbacks such as perf_session__e_machine_cb() call
thread__e_machine_endian(), which calls machine__findnew_thread(machine,
pid, pid) when pid != tid. Both threads__find() (via
threads_table_entry__set_last_match()) and threads__findnew() acquire
down_write(&table->lock) on pid's shard, triggering a read-to-write
self-deadlock whenever pid and tid hash to the same shard.

Snapshot each shard's threads with thread__get() references (using a
stack buffer with a heap fallback for large shards) and release
table->lock before invoking fn(), matching maps__load_maps().

Fixes: d436f90a64f3 ("perf machine: Move machine's threads into its own abstraction")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/threads.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/threads.c b/tools/perf/util/threads.c
index 6ca0b178fb6c..5db81b9debb5 100644
--- a/tools/perf/util/threads.c
+++ b/tools/perf/util/threads.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <stdlib.h>
+#include <linux/kernel.h>
 #include "threads.h"
 #include "machine.h"
 #include "thread.h"
@@ -171,20 +174,38 @@ int threads__for_each_thread(struct threads *threads,
 {
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads_table_entry *table = &threads->table[i];
+		struct thread *stack_threads[32];
+		struct thread **shard_threads = stack_threads;
 		struct hashmap_entry *cur;
-		size_t bkt;
+		size_t bkt, cnt, idx = 0;
+		int rc = 0;
 
 		down_read(&table->lock);
-		hashmap__for_each_entry(&table->shard, cur, bkt) {
-			int rc = fn((struct thread *)cur->pvalue, data);
-
-			if (rc != 0) {
+		cnt = hashmap__size(&table->shard);
+		if (cnt == 0) {
+			up_read(&table->lock);
+			continue;
+		}
+		if (cnt > ARRAY_SIZE(stack_threads)) {
+			shard_threads = malloc(cnt * sizeof(*shard_threads));
+			if (!shard_threads) {
 				up_read(&table->lock);
-				return rc;
+				return -ENOMEM;
 			}
 		}
+		hashmap__for_each_entry(&table->shard, cur, bkt)
+			shard_threads[idx++] = thread__get((struct thread *)cur->pvalue);
 		up_read(&table->lock);
+
+		for (size_t j = 0; j < idx; j++) {
+			if (rc == 0)
+				rc = fn(shard_threads[j], data);
+			thread__put(shard_threads[j]);
+		}
+		if (shard_threads != stack_threads)
+			free(shard_threads);
+		if (rc != 0)
+			return rc;
 	}
 	return 0;
-
 }
-- 
2.56.1.703.gf848ed807c-goog

