Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1518C132132
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Aug 2024 05:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723096011; cv=none; b=V56mIXJMxfC41E0sPne4eqHfI7ShHJuFhwzxdIEZ7CbgvTctjPT5yjzrpbm0NChBgXtIKlQAibotXVgGWmimyjUPn36GhgAGhW2IFrIqEl4ue7ipIwHSjDG8TP9DqKxNDTtkUVglGZN3Has/EtFRddgeaXrHqixH0lXV9EoV/fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723096011; c=relaxed/simple;
	bh=XMuzxWNLy4JcG0352WdrQfStjb7YFcSO6FaG6wFI6dg=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=IqfJNqWw4NevU12JHOPr22OVq9b1MnfL7okebULma3TDDP+fkKsvjjGg7aGE39Q9DS3nHaBX+ikTFBDdkkhFP3LJfWr3b9dP660PL1KGs+pAoS25Khtwn9ofG8SrpLtRTVJ1qUp/h1SPiSTofGzRZhoCoTC6NbEc9sdcYT79OcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w4RwegVI; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w4RwegVI"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0879957a99so897361276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Aug 2024 22:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723096009; x=1723700809; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2b24D5yX2jyTfCEQNBQox9B5upHsbl5IU7cz+NiuWTY=;
        b=w4RwegVI/UHGp8/qbiBjyjrffDfd3NFmuvktLm7dB//JFIw54f4PHRa0rB1NCTA94d
         oGe02guQZvrC83pOdcofI3STb2QY5BC9aX94whLdRzpGcrw+dh4lPS+NWWcUrNN2hovN
         Uz9CRqIXzTmaAT3QoiU19NPbHs062V8BHpaRqBkUdASBIR665nitGbvx62n+EzC74OWZ
         lBFakvwapkAUc2smJ0+Xp7qH6hS8q99dwLWUBjx+iZyEkNcysWoMzFOMhXcLTpC4j+Fy
         Omyn4X7iRP81BM3CmbFxfhVxVOvvZuzV7I/CwLnyUgRxNNZfrGygp1rM+agNaJD1MYzB
         k2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723096009; x=1723700809;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2b24D5yX2jyTfCEQNBQox9B5upHsbl5IU7cz+NiuWTY=;
        b=DrtZl8ejnQ7+kyLW+8lC7Jq5kWedpBGHdRDi53KS7CYAytlH0EbIN1MovKaK/oLgHj
         4ZFkSu4pumRGh+kJ5nLjrNeJmbUgOEIfLb4DSRFBY82XVNy3FLSc0NNx7w+u09MJ4isQ
         /Errdbi0v3YL870is6eudvgk7BdmQKh9KVXUO2dVhaqp8AiJMscNNwqQWKPUSFLRoLce
         PGcBI90drzaV4RxOYkJMgTmtEst7i5J6YsO2+kJFkZBtKgx1hjvEQRY+B+ViKMV5q3w+
         1aJSHqD5DUfCR4I790jBwaye732glwdX9DbsAuCmFXSqSZ2At5WofCx2vos9a5yqfTF0
         GC2A==
X-Forwarded-Encrypted: i=1; AJvYcCWWcRHQ59PePYQBBv6XVuRwmlZNG2juU++WdJSwoVkjo/3VgAXqq6Kw62pqM9f9JOXbWDMPXzwrXO1JfVzpikN+qoZpTs/cpdEFLci4neL32w==
X-Gm-Message-State: AOJu0YzSYIRBrFtbd5v5LGks2nXgAUgGGY3Ucx9hOj7hx/uYTxMfAWhh
	wto5sKwYFV63nKoPSaKJuwtj54ufwZ2TVnBW579HPZ9KaNm4aK0qTxokyTPn1sv5QMmJpHnxmS5
	VsVyfmg==
X-Google-Smtp-Source: AGHT+IF+tvCz+OuhUdzpDXFChKuDmo5KNKSzYT5mAu+9Qla7y5t6R/XUcpZN7eQYyaI44hnsm7zk90P9R8mZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b5fd:72d8:6b88:65f6])
 (user=irogers job=sendgmr) by 2002:a25:2606:0:b0:e02:c478:c8b9 with SMTP id
 3f1490d57ef6-e0e9dbbf453mr1485276.12.1723096008901; Wed, 07 Aug 2024 22:46:48
 -0700 (PDT)
Date: Wed,  7 Aug 2024 22:46:43 -0700
Message-Id: <20240808054644.1286065-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Subject: [PATCH v1 1/2] perf callchain: Fix stitch LBR memory leaks
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Anne Macedo <retpolanne@posteo.net>, 
	Changbin Du <changbin.du@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The callchain_cursor_node has a map_symbol whose maps and map
variables are reference counted. Ensure these values use a _get
routine to increment the refernece counts and use map_symbol__exit to
release the reference counts. Do similar for thread's prev_lbr_cursor,
but save the size of the prev_lbr_cursor array so that it may be
iterated.

Ensure that when stitch_nodes are placed on the free list the
map_symbols are exited. Fix resolve_lbr_callchain_sample by replacing
list_replace_init to list_splice_init, so the whole list is moved and
nodes aren't leaked.

A reproduction of the memory leaks is possible with a leak sanitizer
build in the perf report command of:
```
$ perf record -e cycles --call-graph lbr perf test -w thloop
$ perf report --stitch-lbr
```

Fixes: ff165628d726 ("perf callchain: Stitch LBR call stack")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 17 +++++++++++++++--
 tools/perf/util/thread.c  |  4 ++++
 tools/perf/util/thread.h  |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 8477edefc299..706be5e4a076 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2270,8 +2270,12 @@ static void save_lbr_cursor_node(struct thread *thread,
 		cursor->curr = cursor->first;
 	else
 		cursor->curr = cursor->curr->next;
+
+	map_symbol__exit(&lbr_stitch->prev_lbr_cursor[idx].ms);
 	memcpy(&lbr_stitch->prev_lbr_cursor[idx], cursor->curr,
 	       sizeof(struct callchain_cursor_node));
+	lbr_stitch->prev_lbr_cursor[idx].ms.maps = maps__get(cursor->curr->ms.maps);
+	lbr_stitch->prev_lbr_cursor[idx].ms.map = map__get(cursor->curr->ms.map);
 
 	lbr_stitch->prev_lbr_cursor[idx].valid = true;
 	cursor->pos++;
@@ -2482,6 +2486,9 @@ static bool has_stitched_lbr(struct thread *thread,
 		memcpy(&stitch_node->cursor, &lbr_stitch->prev_lbr_cursor[i],
 		       sizeof(struct callchain_cursor_node));
 
+		stitch_node->cursor.ms.maps = maps__get(lbr_stitch->prev_lbr_cursor[i].ms.maps);
+		stitch_node->cursor.ms.map = map__get(lbr_stitch->prev_lbr_cursor[i].ms.map);
+
 		if (callee)
 			list_add(&stitch_node->node, &lbr_stitch->lists);
 		else
@@ -2505,6 +2512,8 @@ static bool alloc_lbr_stitch(struct thread *thread, unsigned int max_lbr)
 	if (!thread__lbr_stitch(thread)->prev_lbr_cursor)
 		goto free_lbr_stitch;
 
+	thread__lbr_stitch(thread)->prev_lbr_cursor_size = max_lbr + 1;
+
 	INIT_LIST_HEAD(&thread__lbr_stitch(thread)->lists);
 	INIT_LIST_HEAD(&thread__lbr_stitch(thread)->free_lists);
 
@@ -2560,8 +2569,12 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 						max_lbr, callee);
 
 		if (!stitched_lbr && !list_empty(&lbr_stitch->lists)) {
-			list_replace_init(&lbr_stitch->lists,
-					  &lbr_stitch->free_lists);
+			struct stitch_list *stitch_node;
+
+			list_for_each_entry(stitch_node, &lbr_stitch->lists, node)
+				map_symbol__exit(&stitch_node->cursor.ms);
+
+			list_splice_init(&lbr_stitch->lists, &lbr_stitch->free_lists);
 		}
 		memcpy(&lbr_stitch->prev_sample, sample, sizeof(*sample));
 	}
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 87c59aa9fe38..0ffdd52d86d7 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -476,6 +476,7 @@ void thread__free_stitch_list(struct thread *thread)
 		return;
 
 	list_for_each_entry_safe(pos, tmp, &lbr_stitch->lists, node) {
+		map_symbol__exit(&pos->cursor.ms);
 		list_del_init(&pos->node);
 		free(pos);
 	}
@@ -485,6 +486,9 @@ void thread__free_stitch_list(struct thread *thread)
 		free(pos);
 	}
 
+	for (unsigned int i = 0 ; i < lbr_stitch->prev_lbr_cursor_size; i++)
+		map_symbol__exit(&lbr_stitch->prev_lbr_cursor[i].ms);
+
 	zfree(&lbr_stitch->prev_lbr_cursor);
 	free(thread__lbr_stitch(thread));
 	thread__set_lbr_stitch(thread, NULL);
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 8b4a3c69bad1..6cbf6eb2812e 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -26,6 +26,7 @@ struct lbr_stitch {
 	struct list_head		free_lists;
 	struct perf_sample		prev_sample;
 	struct callchain_cursor_node	*prev_lbr_cursor;
+	unsigned int prev_lbr_cursor_size;
 };
 
 DECLARE_RC_STRUCT(thread) {
-- 
2.46.0.rc2.264.g509ed76dc8-goog

