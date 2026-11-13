Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590283;
	b=s6Vp9M0VoMMf0PV2QcaWKnNnENcomxRLcbTwVIh/jxUVsZvvmu4fEUch0r8rgXsGN03s
	 R4a9xRDKK617/L9G9RAI+y+c96VPrF21WrC0RBQClWPglerNZnMekFSp5mTVj1UfS/pCd
	 erCjxJlFZDYOZJ7g/Vj0Hx6ugLbbiEnZCGDmNTRVOEwKR0JQLRYoHxlcHlfhMOaKNFCoR
	 oz+rJw2MltncOXTQAWxSeappkfsS2DaJSDGcm+Ih3DzXpofSEmSTOJcRBXC0BomarEooY
	 lup3yen3dfcHb0uHJe2ta3mlfVgbiIPfzaODNA3Oye4fGGP78TUVMJCuPNHulW0lr8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=2SfMrExRCRyFy0hfb7g3hD05HOFxBQLA5/MwITCosTw=;
	b=MjmiLgVs34/fIZ/rkvG1IMnJ5YHV9F+xLFd4bUYq/B+BXvkk14+kiBb/AFHjltakTb/A
	 AOLIY4HTpC2SBomkg75bQ39k2djeOossTxP9HLjwQQ252Yp+Pf+/qdh4ur5HQasOxQC1Z
	 IWsOzrWgHfnbS9Ix1mOk87osRr9lEleTAHYRyHCwEIN/nLXa30GrAOx5RPIDf3hDmgxI+
	 65Tkd5J4FV39ZX3IWLcmeaNxqgDiZX5hexZu4YyQnMrEqlwsz24kjMoA/Mko3I8SWHnGp
	 Dg2DGTJUhDBpO//cC/DKcX1osPE263MOu/Txros/rFkyUXAwHm68NLKkUG24L1YRbkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BAeCBnNj;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E37606B229
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15E37606B229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BAeCBnNj
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1b3b5b49cabso1105481c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 09:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794590282; x=1795195082; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2SfMrExRCRyFy0hfb7g3hD05HOFxBQLA5/MwITCosTw=;
        b=BAeCBnNjKdvkWBww/TiJYwsSIF6NAbnPV/IFRoNrCMkZGdIqz0FcAPSpyVBBDXnawa
         +FSdti8pik0DUt4vgI65arL6k+FPP+H0juUEcO+D7gU0irPoF9J4LFis0EG5ZWuPL5kY
         GlWG3FGlMqtUSB35mXEPhLkbsxRkVxabIbHZQIj6S7+4mKDzEnkKhWegxnCp14JMniME
         D/UormhR4r5F/FfczUygHsxPowSAQk1HDOJvhT3RC+0NDNvkwgibWobGVr4roHMzVNtJ
         Yrig6at3Olr/nMLxANfh4gMwEp5Vn542TObmnIt3CapsmmnQFIHzNZPuof9mY5L0CeKH
         MidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590282; x=1795195082;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2SfMrExRCRyFy0hfb7g3hD05HOFxBQLA5/MwITCosTw=;
        b=lrDlZbAAJb500XA/6iGJpfSVxdBltnHZItQMq0uZ25DZjwNf/8bmJxG1OLTPbSzeRb
         r9zIo8tcR1FtSQniI9roK36H33r3zcHQN9n8GzYhiigxEHlGlNPrJhsqmxvJtEAM2Xk9
         dHKO3DN5mz2beTD8ac0Rr8OSV0WveIbuglXLyDazwEoVRlL4ONjJ2bR1GKtwyW7VZsXK
         dkim+m9RBxno1uHg0me08g9x/+AKl48sPyDptX6RYsDu/KuoYahJeEoCYDIMMsTh5lIw
         B1xDPghxZVHeT9WwIWB3j8W5A5X6UK8vbNc8x/THNFag0g0k33mj7zihsr7BkGXwuWTz
         GsJA==
X-Forwarded-Encrypted: i=1; AL+hErGxo8eRBs+muS75W3ErRZuFTN9S1Q7NvyDet/uYJ0hh77Rp5Nlwj0HLW3CmeD2/KnpaN+y7YUHdbVkud+jr/rN7@vger.kernel.org
X-Gm-Message-State: APuU4Z/p1Y3u3OK2ndBXTrFTGcZBWkAcCMjY3XLL/fyBAxQC8sG//2Rm
	MOYMBWCnFNsGX31YZRSlY/K/IDp3UY3Izg17UavRnJi2FrSUxZXrulhVjtmfw0dvMtFhs8CeAVY
	ufwJy3zkdxQ==
X-Received: from dloo2.prod.google.com ([2002:a05:7023:a42:b0:16c:e5e1:c650])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4544:20b0:1b2:42eb:7e11
 with SMTP id a92af1059eb24-1b503112340mr2710891c88.26.1794590281776; Fri, 13
 Nov 2026 09:18:01 -0800 (PST)
Date: Fri, 13 Nov 2026 09:17:14 -0800
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
Message-ID: <20261113171734.2188066-4-irogers@google.com>
Subject: [PATCH v4 03/23] perf tools: Remove perf_singlethreaded
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, haghdoost@uber.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

perf_singlethreaded bypassed pthread_rwlock operations in struct
rw_semaphore by default unless callers manually toggled
perf_set_multithreaded(). Because uncontended pthread_rwlock operations
in userspace are cheap, keeping a global single-threaded bypass flag is
unnecessary and prevents rw_semaphore trylock operations from detecting
locks already held on the current call stack during OOM shrinking.

Remove perf_singlethreaded, perf_set_singlethreaded(), and
perf_set_multithreaded() so rw_semaphore always uses pthread_rwlock_t
(or struct mutex when RWS_ERRORCHECK is enabled), and guard di_cache in
util/annotate.c with a mutex instead of asserting perf_singlethreaded.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/synthesize.c |  7 -----
 tools/perf/builtin-record.c   |  5 +---
 tools/perf/builtin-script.c   |  2 --
 tools/perf/builtin-top.c      |  6 -----
 tools/perf/util/annotate.c    | 50 ++++++++++++++++++++---------------
 tools/perf/util/rwsem.c       |  9 +++----
 tools/perf/util/util.c        | 12 ---------
 tools/perf/util/util.h        |  5 ----
 8 files changed, 34 insertions(+), 62 deletions(-)

diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
index 265d49a913d9..31bdf07ebb50 100644
--- a/tools/perf/bench/synthesize.c
+++ b/tools/perf/bench/synthesize.c
@@ -118,7 +118,6 @@ static int run_single_threaded(void)
 	struct perf_env host_env;
 	int err;
 
-	perf_set_singlethreaded();
 	perf_env__init(&host_env);
 	session = __perf_session__new(/*data=*/NULL, /*tool=*/NULL,
 				      /*trace_event_repipe=*/false, &host_env);
@@ -231,11 +230,6 @@ static int run_multi_threaded(void)
 	for (nr_threads_synthesize = min_threads;
 	     nr_threads_synthesize <= max_threads;
 	     nr_threads_synthesize++) {
-		if (nr_threads_synthesize == 1)
-			perf_set_singlethreaded();
-		else
-			perf_set_multithreaded();
-
 		printf("  Number of synthesis threads: %u\n",
 			nr_threads_synthesize);
 
@@ -243,7 +237,6 @@ static int run_multi_threaded(void)
 		if (err)
 			return err;
 	}
-	perf_set_singlethreaded();
 	return 0;
 }
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ad81458989b5..55a14dbe458b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2210,7 +2210,6 @@ static int record__synthesize(struct record *rec, bool tail)
 
 	if (rec->opts.nr_threads_synthesize > 1) {
 		mutex_init(&synth_lock);
-		perf_set_multithreaded();
 		f = process_locked_synthesized_event;
 	}
 
@@ -2223,10 +2222,8 @@ static int record__synthesize(struct record *rec, bool tail)
 						    rec->opts.nr_threads_synthesize);
 	}
 
-	if (rec->opts.nr_threads_synthesize > 1) {
-		perf_set_singlethreaded();
+	if (rec->opts.nr_threads_synthesize > 1)
 		mutex_destroy(&synth_lock);
-	}
 
 out:
 	return err;
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b6691ebb1b4e..393c8d45d917 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -4361,8 +4361,6 @@ int cmd_script(int argc, const char **argv)
 	};
 	struct perf_env *env;
 
-	perf_set_singlethreaded();
-
 	argc = parse_options_subcommand(argc, argv, options, NULL, script_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index a3442d2d6edf..ff2f928fe515 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1269,9 +1269,6 @@ static int __cmd_top(struct perf_top *top)
 	if (perf_session__register_idle_thread(top->session) < 0)
 		return ret;
 
-	if (top->nr_threads_synthesize > 1)
-		perf_set_multithreaded();
-
 	init_process_thread(top);
 
 	if (opts->record_namespaces)
@@ -1300,8 +1297,6 @@ static int __cmd_top(struct perf_top *top)
 				    evlist__core(top->evlist)->threads, true, false,
 				    top->nr_threads_synthesize);
 
-	perf_set_multithreaded();
-
 	if (perf_hpp_list.socket) {
 		ret = perf_env__read_cpu_topology_map(perf_session__env(top->session));
 		if (ret < 0) {
@@ -1400,7 +1395,6 @@ static int __cmd_top(struct perf_top *top)
 out_join_thread:
 	cond_signal(&top->qe.cond);
 	pthread_join(thread_process, NULL);
-	perf_set_singlethreaded();
 	exit_process_thread(top);
 	return ret;
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 86a4beec6528..529d27e2ef63 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -35,6 +35,7 @@
 #include "string2.h"
 #include "dwarf-regs.h"
 #include "util/event.h"
+#include "util/mutex.h"
 #include "util/sharded_mutex.h"
 #include "arch/common.h"
 #include "namespaces.h"
@@ -2825,18 +2826,27 @@ u64 annotate_calc_pcrel(struct map_symbol *ms, u64 ip, int offset,
 	return map__rip_2objdump(ms->map, addr);
 }
 
+static DEFINE_MUTEX(di_cache_lock);
+
 static struct debuginfo_cache {
 	struct dso *dso;
 	struct debuginfo *dbg;
-} di_cache;
+} di_cache GUARDED_BY(di_cache_lock);
 
 void debuginfo_cache__delete(void)
 {
-	dso__put(di_cache.dso);
-	di_cache.dso = NULL;
+	struct dso *dso;
+	struct debuginfo *dbg;
 
-	debuginfo__delete(di_cache.dbg);
+	mutex_lock(&di_cache_lock);
+	dso = di_cache.dso;
+	dbg = di_cache.dbg;
+	di_cache.dso = NULL;
 	di_cache.dbg = NULL;
+	mutex_unlock(&di_cache_lock);
+
+	dso__put(dso);
+	debuginfo__delete(dbg);
 }
 
 static struct annotated_data_type *
@@ -2946,30 +2956,23 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	struct evsel *evsel = hists_to_evsel(he->hists);
 	const struct arch *arch;
 	struct disasm_line *dl;
-	struct annotated_data_type *mem_type;
+	struct annotated_data_type *mem_type = NULL;
 	struct annotated_item_stat *istat;
 	u64 ip = he->ip;
 
+	mutex_lock(&di_cache_lock);
 	ann_data_stat.total++;
 
 	if (ms->map == NULL || ms->sym == NULL) {
 		ann_data_stat.no_sym++;
-		return NULL;
+		goto out_unlock;
 	}
 
 	if (!symbol_conf.init_annotation) {
 		ann_data_stat.no_sym++;
-		return NULL;
+		goto out_unlock;
 	}
 
-	/*
-	 * di_cache holds a pair of values, but code below assumes
-	 * di_cache.dso can be compared/updated and di_cache.dbg can be
-	 * read/updated independently from each other. That assumption only
-	 * holds in single threaded code.
-	 */
-	assert(perf_singlethreaded);
-
 	if (map__dso(ms->map) != di_cache.dso) {
 		dso__put(di_cache.dso);
 		di_cache.dso = dso__get(map__dso(ms->map));
@@ -2980,13 +2983,13 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 
 	if (di_cache.dbg == NULL) {
 		ann_data_stat.no_dbginfo++;
-		return NULL;
+		goto out_unlock;
 	}
 
 	/* Make sure it has the disasm of the function */
 	if (symbol__annotate(ms, evsel, &arch) < 0) {
 		ann_data_stat.no_insn++;
-		return NULL;
+		goto out_unlock;
 	}
 
 	/*
@@ -2996,14 +2999,17 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	dl = find_disasm_line(ms->sym, ip, /*allow_update=*/true);
 	if (dl == NULL) {
 		ann_data_stat.no_insn++;
-		return NULL;
+		goto out_unlock;
 	}
 
 retry:
 	mem_type = __hist_entry__get_data_type(he, arch, di_cache.dbg, dl,
 					       &he->mem_type_off);
-	if (mem_type)
-		return mem_type == NO_TYPE ? NULL : mem_type;
+	if (mem_type) {
+		if (mem_type == NO_TYPE)
+			mem_type = NULL;
+		goto out_unlock;
+	}
 
 	/*
 	 * Some instructions can be fused and the actual memory access came
@@ -3026,7 +3032,9 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	istat = annotate_data_stat(&ann_insn_stat, dl->ins.name);
 	if (istat)
 		istat->bad++;
-	return NULL;
+out_unlock:
+	mutex_unlock(&di_cache_lock);
+	return mem_type;
 }
 
 /* Basic block traversal (BFS) data structure */
diff --git a/tools/perf/util/rwsem.c b/tools/perf/util/rwsem.c
index 9d26832398db..1d15c0e3732b 100644
--- a/tools/perf/util/rwsem.c
+++ b/tools/perf/util/rwsem.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "util.h"
 #include "rwsem.h"
 
 #if RWS_ERRORCHECK
@@ -33,7 +32,7 @@ int down_read(struct rw_semaphore *sem)
 	mutex_lock(&sem->mtx);
 	return 0;
 #else
-	return perf_singlethreaded ? 0 : pthread_rwlock_rdlock(&sem->lock);
+	return pthread_rwlock_rdlock(&sem->lock);
 #endif
 }
 
@@ -44,7 +43,7 @@ int up_read(struct rw_semaphore *sem)
 	mutex_unlock(&sem->mtx);
 	return 0;
 #else
-	return perf_singlethreaded ? 0 : pthread_rwlock_unlock(&sem->lock);
+	return pthread_rwlock_unlock(&sem->lock);
 #endif
 }
 
@@ -55,7 +54,7 @@ int down_write(struct rw_semaphore *sem)
 	mutex_lock(&sem->mtx);
 	return 0;
 #else
-	return perf_singlethreaded ? 0 : pthread_rwlock_wrlock(&sem->lock);
+	return pthread_rwlock_wrlock(&sem->lock);
 #endif
 }
 
@@ -66,6 +65,6 @@ int up_write(struct rw_semaphore *sem)
 	mutex_unlock(&sem->mtx);
 	return 0;
 #else
-	return perf_singlethreaded ? 0 : pthread_rwlock_unlock(&sem->lock);
+	return pthread_rwlock_unlock(&sem->lock);
 #endif
 }
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 8f7cd32f524d..2f2674d17887 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -31,18 +31,6 @@
 
 const char *input_name;
 
-bool perf_singlethreaded = true;
-
-void perf_set_singlethreaded(void)
-{
-	perf_singlethreaded = true;
-}
-
-void perf_set_multithreaded(void)
-{
-	perf_singlethreaded = false;
-}
-
 int sysctl_perf_event_max_stack = PERF_MAX_STACK_DEPTH;
 int sysctl_perf_event_max_contexts_per_stack = PERF_MAX_CONTEXTS_PER_STACK;
 
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index f8f1ff603c72..2321abfae2a4 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -59,11 +59,6 @@ int scandirat(int dirfd, const char *dirp,
 	      int (*compar)(const struct dirent **, const struct dirent **));
 #endif
 
-extern bool perf_singlethreaded;
-
-void perf_set_singlethreaded(void);
-void perf_set_multithreaded(void);
-
 char *perf_exe(char *buf, int len);
 
 #ifndef O_CLOEXEC
-- 
2.56.1.703.gf848ed807c-goog

