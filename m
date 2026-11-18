Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794988524;
	b=zonVuwUoGVnw8DQNa/4QDPjHlG78szqYyCtT0h1G/qgyk2mnGhqB9PrW1qALkeuMkLHM
	 Otcf9qqKPq/q+/uj8FT3OwuKMuuAEAfn7Rqu+CGbtXOuRSJJrwcJygY9deBvQu4ik4Fux
	 7TS+su5imbrG4IGh2VgqCnhGRDcLVE/fAYu9eWt+IOkBlPYZ+I9upLek/V89d/8Gymchs
	 YVJ+uefYPWXQxLA3xgFF4FgWutxGHoCAnMS60jQkvT9VO7zsQC1HWK2xiQ5bVb/sORVQ4
	 gF8Mn/vR1PqRroTe5uHeqyLThR5TxTbrea+i55Y91ZQB4ZZ2kd5cSyzJKac7Vy1EAag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794988524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=NqBTWbYhrgJljwUx8WqJhkg4ihbk/Vv19VCK3zrjEUA=;
	b=mF2+p+FQ4mVmrtk16foDo7U5H3/MCVA1O48wZzdhSS7Nj2bWznl5rbMf0r3rM5tR5AZx
	 6vnL4iV0IMaCcXjpNbD7BUEHamFmne3Hwe9vKsgZSWOXyFLXqtdcKH72VRfYySZXKfKEW
	 kzJf9FDfh7ou1MgZZbp8R1H9FT3gA+K7PnnMq0BNHY1N9nBchyLeWWwrh93ErMLP35VNp
	 YkiiCkY/UzEALrnY6tx7hCm7ppxT7tZTK5iMU562MmZtmgtYeTJ+8kUjlOm2cBbPRlb1t
	 vQPtSBLGIgRoHMmWZstSBlmlrSwkvaqm2XRrfcI/L84GnMbruPZUJ4krlKli3sJltEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="d/7Io1VV";
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D5A606A893
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 07:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6D5A606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d/7Io1VV
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-381dc4b8f40so918747eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 23:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794988523; x=1795593323; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NqBTWbYhrgJljwUx8WqJhkg4ihbk/Vv19VCK3zrjEUA=;
        b=d/7Io1VVBbIOEreAOJxktmHodlkVrpBDoA/cprL6W1ywaKOagFc8hIDgnAXixEbFvO
         LQ91kuOgnuSlXwuFi5EKDccqoIS2LazfKOhFsO5RpOmUMoRKDPb+wWY/b4XexsgxeqiD
         V2H5eWb6peY5dY923yYV+grX4rPKTWOHcjIQ9IykbUCJLRvNTXOUdKOuWsuS5r6LFzZU
         FPXN2PGmjNrFP+usqXl+K3tpita1IB7JHUFPLcPzJGJZhwxzAfmdMRFOxV0dCOPQn4+w
         /HnqCg2MQBcChFSXxqUj0o/3R7rpfjnK5VsFWbCcQXuqXUtbfcsieVHze9NApSS5zWQX
         eBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794988523; x=1795593323;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NqBTWbYhrgJljwUx8WqJhkg4ihbk/Vv19VCK3zrjEUA=;
        b=c0Yy0yPlll7tZ3R+6GjMHdeFqbHnF1s7kP6Pph+2XhYdB/w6haJPDPshxsQos+a5BA
         bqfnxa1kSXhx4xlaL+K78bxy/L55fRyXYXGxfLm8ipLHu+DlCwwchrmLNz6t2Un1qjHr
         4hMLKJIcjeEnhbdcWVhJL1sLuDeDJhKBelCQEyK1BqbyLDmWwhA97kBpdaZj/3NPfIdJ
         kgJbE4glTKxilU7NvWmivrmZkOxMGKGt1FtZvPf2qw6FQ/ah63FOvj+3E0zcKhDjBX4H
         hcq0uy0bo4yQHaGKXU8NOhvCihxoirfE2P+SHz8oT3N1mXS+0P875qPA4KD3gXT6XNzV
         lnXA==
X-Forwarded-Encrypted: i=1; AL+hErH5j17wqxLQ7w8VnLJPltYOX3QlPnzr4+SF7My05U6U4Oqh9GJZa9bzooFUUNlW9xrED9eoTT2dGsQ+C6jDOS8q@vger.kernel.org
X-Gm-Message-State: APuU4Z8A18v2YMaeyzcuf8e/5UhJTmcgsAC9pGSHSLxH6cRWqX3YOG0y
	7WbJ2zw8TELv33vva/zF/OGg+J5nljtUwu1OklxQsMDmATcG/GeKxdBiWYyaYfKm+s8wMUiSNvK
	MktiuayEkVg==
X-Received: from dybmw7.prod.google.com ([2002:a05:7300:cd87:b0:382:7604:3dd8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d08c:b0:381:edba:caba
 with SMTP id 5a478bee46e88-38280a385e5mr1870465eec.17.1794988522456; Tue, 17
 Nov 2026 23:55:22 -0800 (PST)
Date: Tue, 17 Nov 2026 23:55:12 -0800
In-Reply-To: <20261118075516.1278903-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261118075516.1278903-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118075516.1278903-2-irogers@google.com>
Subject: [PATCH v1 1/4] perf threads: Don't resurrect removed threads in last_match
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

threads__find() looks up the thread under down_read(&table->lock), drops
the read lock, and then acquires down_write(&table->lock) inside
threads_table_entry__set_last_match() to update table->last_match.

If threads__remove() (or threads__remove_all_threads()) runs in the
window between up_read(&table->lock) and down_write(&table->lock), it
clears table->last_match and deletes the thread from table->shard, only
for threads__find() to overwrite table->last_match with the removed
thread. Subsequent lookups for that tid then return the removed thread
from table->last_match, causing stale event attribution and keeping a
cached reference until another lookup evicts it. In addition,
threads__find() unnecessarily took down_write(&table->lock) to re-set
table->last_match even when last_match already hit.

Only update table->last_match on a cache miss, and recheck under
down_write(&table->lock) that tid still maps to the same struct thread
in table->shard before updating table->last_match.

Fixes: d436f90a64f3 ("perf machine: Move machine's threads into its own abstraction")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/threads.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/threads.c b/tools/perf/util/threads.c
index 5db81b9..736058e 100644
--- a/tools/perf/util/threads.c
+++ b/tools/perf/util/threads.c
@@ -85,10 +85,13 @@ static void __threads_table_entry__set_last_match(struct threads_table_entry *ta
 }
 
 static void threads_table_entry__set_last_match(struct threads_table_entry *table,
-						struct thread *th)
+						pid_t tid, struct thread *th)
 {
+	struct thread *cur;
+
 	down_write(&table->lock);
-	__threads_table_entry__set_last_match(table, th);
+	if (hashmap__find(&table->shard, tid, &cur) && RC_CHK_EQUAL(cur, th))
+		__threads_table_entry__set_last_match(table, th);
 	up_write(&table->lock);
 }
 
@@ -96,16 +99,19 @@ struct thread *threads__find(struct threads *threads, pid_t tid)
 {
 	struct threads_table_entry *table  = threads__table(threads, tid);
 	struct thread *res;
+	bool update_last_match = false;
 
 	down_read(&table->lock);
 	res = __threads_table_entry__get_last_match(table, tid);
 	if (!res) {
-		if (hashmap__find(&table->shard, tid, &res))
+		if (hashmap__find(&table->shard, tid, &res)) {
 			res = thread__get(res);
+			update_last_match = true;
+		}
 	}
 	up_read(&table->lock);
-	if (res)
-		threads_table_entry__set_last_match(table, res);
+	if (update_last_match)
+		threads_table_entry__set_last_match(table, tid, res);
 	return res;
 }
 
-- 
2.56.1.703.gf848ed807c-goog

