Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941380;
	b=V0RnZdgkK0+YPh0q7EzXxbeiwdsESAlzZvYBM0/pm6HAtzGoKOF++auHTpB9ehaVKyBz
	 VGOVs1LR37L3ReU98gWOL7hCK1m+wadPsmIuUwepuLJFxkgwdRJO9Cik4ka6L1vLP/VIL
	 dsYjHrtgDTNKWlNAWLlMDGEePpDWCqOpNq9XKKNSqTqMGclig8fpCPB2KYlE+gL4AMNMa
	 Jshy/6nzy+6Ec7QuAjOChO6bJO7VWBbXg/eo+ziTnhSzo0U+CwvddlwBtVKC8JXP+mX9e
	 ToE7ke/F24dz0FgOB43RlvEO7eNQ1jJ+Ru6Wt3N2HY12hOsT0CVVWeqL09LIz7JxEZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Me5yfIzDRGI7/xvPxV35hthDkGXlSHz/rORd9jtaqKo=;
	b=acQmwVl2UEvK9wVSd3rnpv+J4DGY0osPdnUUmpm8PzoG52TmNCQrh0olIsMXF7PNbVlC
	 e+okj9MLjOibb5FYGCJJQc1Or5bs3RBfrF7SeYjVx3cN9oA4z1ALsH/X5CmYTvLFYfOlR
	 jPj/DVQtnUML44nsgbqPvqHADwPIoAFjtZsZQKKxIVoq7gABfqye96GYcKiPrkE4cYvz+
	 FRo3+80TCtGY0cH1VCdXRIl1hYKtAzSVxxQeQT4ugpvQXgmlEQ7+IWTadFKTnwM5xnJg9
	 z90EvzrloND2dysYvR9SjrEbGbeH/JQVFZi3IJ4Z7MXRvpxczyf/g6/HYvoB0u1FY0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NPE7p+gq;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581F6606A894
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 581F6606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NPE7p+gq
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-370230d93efso599696eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 10:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794941380; x=1795546180; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Me5yfIzDRGI7/xvPxV35hthDkGXlSHz/rORd9jtaqKo=;
        b=NPE7p+gqzDiTWxnAhvtDfrPWDXQNxLzrQDFUcxih2RB0GZCK18MXkca5U+87m7pv2h
         TtcBhNDm+GrY9kemeBzZHsYl2AeSfdetkFzCm/9fpQcqF8HwhU6Fli/D3NO/u0lJ2bun
         Hg6fojW2dlW0IXfS7uW/RT6rp6KM8ieqJHbmtVe13L27bHVVRFdDQurBsaii3Vp+clsW
         fyNjAgz8vdiSray6n974EsJdEh6kAb4G6woSi+PqLXOqV1uMa3xBxm4okQCa+Ru09utd
         /3+eOKWgdR/X7Z2Nv5I2/m99CkBNaqzlfBiO5zR54Wjllecd25Kp85j8B0lgYCTGOk+a
         u9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941380; x=1795546180;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Me5yfIzDRGI7/xvPxV35hthDkGXlSHz/rORd9jtaqKo=;
        b=TfjEcsIEfWdQAYkxk08ARDVcBoP8VmYkgykGsEI3LY3714ett5C0SouXRQ6RvQqgjU
         1T786yLfjzMiIKjCj13IY/AiUExi5fsng9YTgsk59NKqcTOVXuTZlulcdc0Lvdf0Joxe
         NYb4ZFOYQ9IVyrrHdBVHtdin3ydEcS9TKZ+OALCpnE8zbuCoIVc+tTQePNoogwRPL3hT
         AWHY7+SLbUklj3kYlZcyBoIjvfrkDxPGHojdiHfn3hOt8sIKJev2J8GQBgUDvHJCRewa
         vQ4HO5dahEvS/+VLHc3nVcCbJ/wfDFdHMcmRhbWMIgmGiHNQqqizg6uIGREcgSD9uPBO
         Jl6g==
X-Forwarded-Encrypted: i=1; AL+hErGc9KM8IK1x6WwLFXiQ4WEQdTUIojAyf+Gw+1Z2CIx6aaSfumP7a5dGdTuEn/zEevArWJwf9vMV87sk2zCMbUyD@vger.kernel.org
X-Gm-Message-State: APuU4Z86fBJx0agp9fSzDbIuIashpQS0OJyrmxLIePNOwYeTX1ho1bV+
	maMaXt6wr5RNo0eQQvSepmf/2Eov5vws6facd7IhP7OLgeduVJca1Z+3FwLnrmY3TB3SwnPAf77
	UMtuewbwn1A==
X-Received: from dygg15.prod.google.com ([2002:a05:693c:80cf:b0:369:a832:e377])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8944:20b0:36e:8410:ecf6
 with SMTP id 5a478bee46e88-3827f5ad3dfmr294688eec.13.1794941379344; Tue, 17
 Nov 2026 10:49:39 -0800 (PST)
Date: Tue, 17 Nov 2026 10:48:39 -0800
In-Reply-To: <20261117184844.99889-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117184844.99889-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117184844.99889-19-irogers@google.com>
Subject: [PATCH v14 18/23] perf env: Add __guarded_by and __must_hold annotations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
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
2.56.1.703.gf848ed807c-goog

