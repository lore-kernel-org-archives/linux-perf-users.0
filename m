Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606556;
	b=BLnmqXAst8aG0hkHQ87o1hyI0qITv2rOJwLGzWBWzAiMdwNrDc9UUwAbKzMdUmWLhpfk
	 Ibboff4xIPeH3j5AEIGNa/Bakxe1lHQ+YundesgeD9wXK0EB+qSQ69axTwiaAcHsMg5aU
	 bx5NZhNSxtndhzgTkGYCNNv4Flo5WaLYEXNVkOyj5LXJMKYSO4oSK5oA1Xs2Qn19W2oLK
	 ZJgT/SylZ486+FAyuICFlfT64aNgnOcBj9isi/c4diy+odz2f+76PKX4Ue2t7NsIxNqkZ
	 BmKwwVLBoHSpdlQu+7jWQ0rV7kZioMD2QzyDBzWHR7ZlxoM6EvYqWkOf5rUxwwY7qQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Lo+j+iHMT8qE0wPCakw8s/IRh6qon0bzXQhbCYnKkRQ=;
	b=4RjVzKiyaTJMotvEoEQuonlwjM+kilXiq9XGWYlrb9k73vKTJfVgNh9c+QqAaXGvZPFb
	 bqFyuPn6bJi/U5y1ZYchQQ1B5dsnOcPdc5M1okZ6aJqWpMhcoCPYU7G3f8fbBLWVuRhXw
	 uh8/luE7mfvZU6kYrRN9hnsVxVyR3DjS9rL9w636qcaUU1wNFpXn92GwmXAv/9CLBUGJl
	 bpUUjddKEuuy+501vUVCH3+meEu3UvcW6dSJFmpnB4jX11om1ZsaDZ8ISB6Sh4iCKcG1R
	 sviQSJSieXiaNg5LaOvIq9k9A2vSIBySNbrcmfYd51rPz+iXFNvdrKGwPzCPSrETjTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e01ZT7jl;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD9A606A887
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BD9A606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e01ZT7jl
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ae72da2f57so2306071a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794606555; x=1795211355; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lo+j+iHMT8qE0wPCakw8s/IRh6qon0bzXQhbCYnKkRQ=;
        b=e01ZT7jlNllaZ4BpDqA71jnQmH2xDu6ka6XmkftHuAfg2QQgBRAD5RwOUS08ab4doh
         49fC1gnb68KyeY4laElWlgje7rxYAzGJuTWt/UXpugS1Fsf0WnqqT38b99Knjs9DqhUL
         rA9rU0XDPclWUCLpjOWCu7sKJugD1TTVHbWi45gUthpDbaA5ytvOO1VWX+gze0CjPWgO
         QeepRZ6HGI6O8WW1bAGbN/ymp2/it43POxLYNIHQOMP+Gy++qK5q4+g4FMt62wUi22dr
         IMUB44RVu3l8kFdMI8Za98Jw/sA4sFiL/8FSNLkdU+2PhBQiL18mMgLd661l1PQeuoku
         S/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606555; x=1795211355;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lo+j+iHMT8qE0wPCakw8s/IRh6qon0bzXQhbCYnKkRQ=;
        b=MITu4xPP8sc8naUXh4XAOOsze5LWKtJ0ujCmM//UOOE41N7N+UA35PdWJPlB3LocKq
         NZY1d7iOZg1W94iQlv8oDbpKemXTfwr7iCqnlFtv6e81vww5+7GcBsQP+qEPaINyscT1
         9/2VETynwozYPtkBgKtTbJEkNej+LL4mx8/8NPIybIK8sIcqY2G+zpucoW/9ds41ukUo
         yYwn6MPNB8JbBbioXPGRSFR1fg1h0Wl2jlnAWc5wTSqivFi08+IGk4eIaCAo1DXPAQED
         g1jOuzPw5osDGv64FGoIW8NN9R1EtC4LuLehRHd9AixyvF5Bs78gfpoznb2oXFfSC+26
         AU+w==
X-Forwarded-Encrypted: i=1; AL+hErF7e1JnFjuvroB/EiXVv+LlTSsVF/qvoehtLn5OepifSZfmAqpNGStbbDf2XDOk2YuP0veHcxvkPIF/tbraSrGO@vger.kernel.org
X-Gm-Message-State: APuU4Z9Zqes0+qkZq9oYaOOIQ4MHOdcRsD4CAzx8mUPJYqPJNcFjutnE
	7kU+LMVj5dLU9oojxYzY1HkNS7RwmvQxqXW6vidmVMlD2l1kxMkNfJUBqa2IQm690q8Bln9xt9n
	kO68JZttlaw==
X-Received: from pgp8-n2.prod.google.com ([2002:a05:6a02:62c8:20b0:cdb:5946:2351])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:54cb:b0:3ac:a139:1b14
 with SMTP id 98e67ed59e1d1-3b1b0d39a69mr3217639a91.57.1794606554564; Fri, 13
 Nov 2026 13:49:14 -0800 (PST)
Date: Fri, 13 Nov 2026 13:48:25 -0800
In-Reply-To: <20261113214850.3329699-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113214850.3329699-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113214850.3329699-2-irogers@google.com>
Subject: [PATCH v1 01/26] perf threads: Fix uninitialized pointer put when
 thread removal misses
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Unlike hashmap_insert(), hashmap_delete() leaves old_key and old_value
untouched when the requested key is not present in the map. In
threads__remove() and threads__remove_all_threads(), old_value was left
uninitialized and passed unconditionally to thread__put() without
checking hashmap__delete()'s return value. If the thread is not present
in the shard, thread__put() dereferences uninitialized stack memory.

Initialize old_value to NULL and only call thread__put() when
hashmap__delete() returns true.

Fixes: 412a2ff473ac ("perf threads: Switch from rbtree to hashmap")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/threads.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/threads.c b/tools/perf/util/threads.c
index 6ca0b178fb6c..98cf7edaf748 100644
--- a/tools/perf/util/threads.c
+++ b/tools/perf/util/threads.c
@@ -142,10 +142,10 @@ void threads__remove_all_threads(struct threads *threads)
 		down_write(&table->lock);
 		__threads_table_entry__set_last_match(table, NULL);
 		hashmap__for_each_entry_safe(&table->shard, cur, tmp, bkt) {
-			struct thread *old_value;
+			struct thread *old_value = NULL;
 
-			hashmap__delete(&table->shard, cur->key, /*old_key=*/NULL, &old_value);
-			thread__put(old_value);
+			if (hashmap__delete(&table->shard, cur->key, /*old_key=*/NULL, &old_value))
+				thread__put(old_value);
 		}
 		up_write(&table->lock);
 	}
@@ -154,14 +154,14 @@ void threads__remove_all_threads(struct threads *threads)
 void threads__remove(struct threads *threads, struct thread *thread)
 {
 	struct threads_table_entry *table  = threads__table(threads, thread__tid(thread));
-	struct thread *old_value;
+	struct thread *old_value = NULL;
 
 	down_write(&table->lock);
 	if (table->last_match && RC_CHK_EQUAL(table->last_match, thread))
 		__threads_table_entry__set_last_match(table, NULL);
 
-	hashmap__delete(&table->shard, thread__tid(thread), /*old_key=*/NULL, &old_value);
-	thread__put(old_value);
+	if (hashmap__delete(&table->shard, thread__tid(thread), /*old_key=*/NULL, &old_value))
+		thread__put(old_value);
 	up_write(&table->lock);
 }
 
-- 
2.56.1.703.gf848ed807c-goog

