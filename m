Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244374;
	b=iKUgWuGaJAHWdnvTeTLdFoSbY4z3YR7Kc5PgS77EEKP2BAOibGWQLxLG6/1LXOWG7k43
	 5CCwq0W1+7arY9eEc+i3RL81UMiEoxmSdiMfBiIU/DK6Sv/ZuEfbR+lACrtdP9rYjjARb
	 /QJkQ+EnJu3S7HBsd8mE+gllX5LgE8CgFzP3D/9fAvyFVrG0zE4lGApm/GmehVQQbze/i
	 oLXZ873yhxG8sRIjxIkfo+c0/Gbaf1YuldyLv8lECheGuWm12VESKxdLiFG+2/UO4ZhXy
	 T6xZmEL75b84TQjKgjnmmRXuncZTmKlnqa6yz5/5cuarVMboeIltPr0uKlkdjGMLYvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=pze2mI1oPViyxi8zWkxc4AfiCW0ffatK6SkO5RyHMS4=;
	b=KkNPxDkhjcWbpeCBtrC4VBWeefwxiSZyOGyTdSe3qvOJhsfCsRS4ku7ShyLVh+T9mnuJ
	 r0L7KOJBtQXFyRSvnLD4/0O8rZyhAgx3jH4pI8Lg3CZ0gu5o4vtUus3T2NdHptNpeSwGI
	 wNdFgT9Ac0n6n2GEHXKEk7Hzsc3Oanz2Sv2iOaIYsPDOmz6Dh9kZcnuPBrSRxmKsDlkMU
	 gbFJjqhTxb0UZXvnZybhk5iJ5jOowNl85M7Yz9EAT6iwQh0NLBH9BnnfX2J6PvjA7oBHE
	 8JZFgmcDLhpO6gYoaY+aoOW7gW5nNyuPM4IlmUKuzIk3dGHsBQtzQz2m436eJkZS/iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a7ocDBOO;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3187F606A32C
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 06:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3187F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a7ocDBOO
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2f045e399acso13289005ad.2
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795244373; x=1795849173; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pze2mI1oPViyxi8zWkxc4AfiCW0ffatK6SkO5RyHMS4=;
        b=a7ocDBOO2Cv03qvrsbdiPkg/5yOraPoDlqk9q33aTZm1vMvtDCi3QmGtsSaS3VZsVQ
         2cMFbjba6BOH6yncCRimEerHCCzDsCo0k0wbym2aqivi+8cyMZs7f+wD70o+uYBcD8Ax
         DoS8vJVXR6VCmJSSXCOgCt8xrUz0L/6QDTRNXzCF07Yl5d1b82+3TM72b/BD5bBazC3m
         utNXGus711O1hEdtECfAvBu8wqiJmSIYxMHVk6EJX8HYsp4q9Ub0hiijyJ0KwCfjmd8Y
         f+EO1ARCJuZ5WzzERLa7bfy3AUaKuuVzRJEHk2vWQc/urrjkQsO6As68EriyYgv0xEGr
         qCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244373; x=1795849173;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pze2mI1oPViyxi8zWkxc4AfiCW0ffatK6SkO5RyHMS4=;
        b=bzXfvNQ0F9sV+CBwJbHhHf8jl62Yysb8fgIL3IReTuWj0Fe3my0pfU7zvwwxocZdQO
         +QTpE3ocgJHz3ZOChBKrYODpsmROcKO8ZqjWefUw2ajsxIrRl6QmZIiIV+W/zkXELpdN
         khP6NHgHocWk4w6/zaK+HltJSumSKvXSFAMPNlxn4fCYLLY01wxoKlAhGoKzn+odmDbZ
         TKFBfymCkhAjAuU3KWg2mlHjhWBBejeOTRlpZZZfvNTvcUGyiNfd3VYq8PqTPUpVO3mp
         5e3be8EJyyhjfdbHc4fq3VOujkkImkuNuYdrtp4ccV2LE4w5Xo/VR9p6QOnW0LpuGrs9
         qD5A==
X-Forwarded-Encrypted: i=1; AL+hErFdN32yU7N0yfdMulpZ20EcYK05fiIZqRjjqDeYjiIE0xq8DMueRASE8lNCFCLunzkwEmxAxD2VcIXRwa7rXgE7@vger.kernel.org
X-Gm-Message-State: APuU4Z9uuVtrLfg9Ekca+uM9IiOTxSNx3DaI5MQh6FWlOEY7qmLYt/2o
	8APtOjRrxeRSFjVPnaSF7g6cYav5ttNFFKhLEwFl5Dp/IhNF2dxQTa2nLUBpMH4dEkIGGgZ5g4W
	AVcUS395mZQ==
X-Received: from plbmq7.prod.google.com ([2002:a17:902:fd47:b0:2ef:ceca:4005])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a0e:b0:2ee:1c51:7eaf
 with SMTP id d9443c01a7336-2f03f20b203mr57198655ad.31.1795244373110; Fri, 20
 Nov 2026 22:59:33 -0800 (PST)
Date: Fri, 20 Nov 2026 22:58:07 -0800
In-Reply-To: <20261121065813.4143649-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261121065813.4143649-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121065813.4143649-19-irogers@google.com>
Subject: [PATCH v15 18/23] perf env: Add __guarded_by and __must_hold annotations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
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
2.56.1.750.gf70dc682cf-goog

