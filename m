Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588158;
	b=t3uPgbxHuBr9f+axJkUzdjd2adYx2o90UQHjKD5D5IDnpbeNBtGzQ9nqhl447PDF0GmG
	 o5lHX4frz5egLyPIZcvrIH3ATzWZMkz4TqkpV/Usi15zf3asJPeY+8vUwkZFGuHJhUeeR
	 0Kr68ge0jp3bhKFgnqc/ffZr2mCqZtn0eVout5Hird5gYSlFyhdGcMzU//jOe6UZymeZc
	 5mgoQQ78LFmB58NAONbYO4diqG1gnjkKNlR5i8UoFQA9FTRF5c0uv9c/Vjq4GoAeYTlcr
	 iGFR2lT8L35CwKi/ON/uFb1ClX2zVreFBG2h8Y77d35IC+6H+Pn6TKpTNzOTTzR5EPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Me5yfIzDRGI7/xvPxV35hthDkGXlSHz/rORd9jtaqKo=;
	b=VsQdwVSUKQMoyt10vPPwPHcPXyWPP5DYJCf0c9ULmXPlFqEubLkSAS+2NFnLYh5xfqfW
	 /Ty/0gB0y4GYag21iT5MKMxQaOXCbqV+uHownYVpm9v1oGhf9iIQtHkoQFTQjVL6I+Sm/
	 Y+x2WqRbxYyhNZZlpEdlKbisBfnIjCa70+jfTHpnrvv6I4WmodHKBqKtoXoLuUNx7C18X
	 LeEEME7Drme2LbqLz8G7YSMb7zh8h+fingskiwjMx9uOy025gbjwjQpIN+3Drc7sOd5F8
	 z3S72xwwO3ebFDU9q02FrSgOJGioIvyvKxlXlcqprF2p2wvUjsEG9A6WUKVo3Vn/l5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AfrOrdF0;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E916074E17
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6E916074E17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AfrOrdF0
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso1739126eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 08:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794588157; x=1795192957; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Me5yfIzDRGI7/xvPxV35hthDkGXlSHz/rORd9jtaqKo=;
        b=AfrOrdF0DbjjjVl2799XgV5rVH458X+uEeRIFQqxiRh3sPFGhMhlN5tALRMgloQ+Es
         /MzkJX2N+Fnc4Pt59wE2tc2Wq3xCxSiotreEvntrxuBr48RNLi4eYg8/6ww2n+QZW0OP
         5hOqtw6JL91rx1jYZDB6UQlS9yPyL6AHvZC1GBBO1iXjNZpXHEt2YelXygvtrzDdbfJR
         seFFNQohfoxFi4f0ChYWSWohj3apGnFzs3pjrjcNy1MGlmQnV5eMSuNOIPenACGQf5kx
         Zx3kLS8E/uM/ButS4AwHfQBchLSnS6SrY4gS7p1H0sWUgG0fiRHakyQloDlkNZTTSo+W
         LYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794588157; x=1795192957;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Me5yfIzDRGI7/xvPxV35hthDkGXlSHz/rORd9jtaqKo=;
        b=gSTcppUutlqFcFmZ+eP2ognUQcquSInaCAKXQ3C/pi7bUldgVeabiDmaSWnS+YRNOu
         fld5BKcKnzaAMh9dPoKVpvPS9CjTBVi9O2w52Lp3ZEaUVqjEj7FHcRNa9FjGVQRf+97q
         uP2457zK7oUzU/xPEzAaMmjSPjD/caIpuGZDXjE0/AeeO9hK/WBbadAyZ72i+YlmfAph
         FChmLyzFGl2zoZwH7kwzSE8Zkyf1sRDjpecWB/WWEAO3gNnyKZLkBBWRXcDz2bBnPNjg
         JsSH3gxBf4i2TrRsSG4Mjaiel5vbdXhu3OdbukFY7dHc9RcAy9HJa7FGU4GKMf1pefx3
         kqiA==
X-Forwarded-Encrypted: i=1; AL+hErFTZtxO0ldFsV03WhKQJb7c1tFM8eEB6vQrfc3trfhbyYFGbhb5FiWoMl3Tx/xshqfG8YJVvg18uYQw9NhOtMyu@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ti00v5L0BYf4lryxmVH1myGRhK9nV4d3BCJtl904Kt3bb1gBn
	drrniO05t6iK1mCWJuggFwwWzFvJfuBKqy9mBBCk8a5cXNTn7PYDMR7WStC5btnIq20yHFcnNaI
	bIDRk2E8OBw==
X-Received: from dlbuy12.prod.google.com ([2002:a05:7022:1e0c:b0:1b0:166c:6a91])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4508:20b0:163:c5eb:d42f
 with SMTP id a92af1059eb24-1b503060401mr2912951c88.5.1794588156804; Fri, 13
 Nov 2026 08:42:36 -0800 (PST)
Date: Fri, 13 Nov 2026 08:41:49 -0800
In-Reply-To: <20261113164152.2095566-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113164152.2095566-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113164152.2095566-19-irogers@google.com>
Subject: [PATCH v13 18/21] perf env: Add __guarded_by and __must_hold annotations
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Add __guarded_by(), __must_hold(), and __must_hold_shared() annotations
to the bpf_progs and cgroups trees and helpers in struct perf_env.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-event.h |  5 +++--
 tools/perf/util/env.c       |  1 +
 tools/perf/util/env.h       | 19 +++++++++++--------
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index da4eeb4a1a73..3f3323f98f49 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -6,11 +6,11 @@
 #include <linux/rbtree.h>
 #include <api/fd/array.h>
 #include <stdio.h>
+#include "env.h"
 
 struct bpf_prog_info;
 struct machine;
 union perf_event;
-struct perf_env;
 struct perf_sample;
 struct perf_session;
 struct record_opts;
@@ -42,7 +42,8 @@ int machine__process_bpf(struct machine *machine, union perf_event *event,
 int evlist__add_bpf_sb_event(struct evlist *evlist, struct perf_env *env);
 void __bpf_event__print_bpf_prog_info(struct perf_bpil *info_linear,
 				      struct perf_env *env,
-				      FILE *fp);
+				      FILE *fp)
+	__must_hold_shared(&env->bpf_progs.lock);
 void bpf_metadata_free(struct bpf_metadata *metadata);
 #else
 static inline int machine__process_bpf(struct machine *machine __maybe_unused,
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 50993b0dedc5..9e8e5d1d822a 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -302,6 +302,7 @@ void perf_env__exit(struct perf_env *env)
 }
 
 void perf_env__init(struct perf_env *env)
+	__context_unsafe(/* initialization */)
 {
 	memset(env, 0, sizeof(*env));
 #ifdef HAVE_LIBBPF_SUPPORT
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 23d35425efe3..6b2083e3640c 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -139,16 +139,16 @@ struct perf_env {
 	 */
 	struct {
 		struct rw_semaphore	lock;
-		struct rb_root		infos;
-		u32			infos_cnt;
-		struct rb_root		btfs;
-		u32			btfs_cnt;
+		struct rb_root		infos __guarded_by(&lock);
+		u32			infos_cnt __guarded_by(&lock);
+		struct rb_root		btfs __guarded_by(&lock);
+		u32			btfs_cnt __guarded_by(&lock);
 	} bpf_progs;
 #endif // HAVE_LIBBPF_SUPPORT
 	/* same reason as above (for perf-top) */
 	struct {
 		struct rw_semaphore	lock;
-		struct rb_root		tree;
+		struct rb_root		tree __guarded_by(&lock);
 	} cgroups;
 
 	/* For fast cpu to numa node lookup via perf_env__numa_node */
@@ -223,7 +223,8 @@ int perf_env__nr_cpus_avail(struct perf_env *env);
 void perf_env__init(struct perf_env *env);
 #ifdef HAVE_LIBBPF_SUPPORT
 bool __perf_env__insert_bpf_prog_info(struct perf_env *env,
-				      struct bpf_prog_info_node *info_node);
+				      struct bpf_prog_info_node *info_node)
+	__must_hold(&env->bpf_progs.lock);
 bool perf_env__insert_bpf_prog_info(struct perf_env *env,
 				    struct bpf_prog_info_node *info_node);
 struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
@@ -233,9 +234,11 @@ void perf_env__iterate_bpf_prog_info(struct perf_env *env,
 						void *data),
 				     void *data);
 bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
-bool __perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
+bool __perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
+	__must_hold(&env->bpf_progs.lock);
 struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
-struct btf_node *__perf_env__find_btf(struct perf_env *env, __u32 btf_id);
+struct btf_node *__perf_env__find_btf(struct perf_env *env, __u32 btf_id)
+	__must_hold_shared(&env->bpf_progs.lock);
 #endif // HAVE_LIBBPF_SUPPORT
 
 int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu);
-- 
2.56.1.703.gf848ed807c-goog

