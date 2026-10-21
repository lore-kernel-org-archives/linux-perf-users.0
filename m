Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602736;
	b=RC1qbPqsVByRPR2L11mQXnla76bOBKwZpGeeMXkwVbI6oN7GTkqknXYnMhulk45UkxAV
	 bOZ8T5ka9MiFUo0SdPQY7rk+sbvEYCiEK9m6/fl5QTlA/LEGtn0zVRFYxkIxxDjvxDkiT
	 1zQQJFvwxHWuh7x4CbLxj1fB6AVs92N21GU3+WsoWR1zthCndPCexh7V01r/bZZ2SiP7s
	 NCjkOce1/AHHqsWrK7CWwAvxGUSmm1jbzsSgTSLKw7jkRJ+PFUYp4YraBQBiOEOvZ1xjB
	 VNn7i9KYhjynw/OIHM7oD5k4qhHVmNMEJc0OdBEEcdVupElpcEU5Nmmf1MONFVRri8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=FQAoTq1ySMg44FAVyZGQcfcvRQE19iF0lwberHA3gKY=;
	b=ve7SE1kugnqlk4hT2jJpGZwb2LyFAt6ZtFf5X0QMg2x87Eb3mIKZc5CbV3uoeDgktWNp
	 57thumtW1mi9s83P6elSj02uAMYXIcQNMdiXVAV/KDthiRODbBBlA433g5IVGegcl1tQi
	 L69WI10Dnp63esbX+q15+a11if/kReQ1xSqox+eXT3dsRKcd5EsBNtrFjYURdnvbPR0q7
	 Mu/8eAo9p71I253WNrVyT4R+D2xM5kKADqyMwf7eRdEvYyeg5+9aQNJ+DeL+iKEq5iWe7
	 xiMbAT+fynPIAta9UBPcOjH/sC5lpqfidB57m4FXZNyw4s3DbjnR+g/gRw54VeN2JBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nuO1XRAI;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBC360A2624
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FBC360A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nuO1XRAI
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso1766845eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 10:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792602735; x=1793207535; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FQAoTq1ySMg44FAVyZGQcfcvRQE19iF0lwberHA3gKY=;
        b=nuO1XRAIQVoK9nbHHDCT6v16qCMJ3a7J7yT4FuICVQrGqLO9LkUny+C0pMN5zzBjyS
         P00+uk1VkmkhpnyHArw37+fwWBJTrMWHUTgx0k42SJ/U+vwbpiYvxZV5Mv7Lf4r3v8as
         +urhwISzUCr/PyFly2ssLnVpjDiPOvFChuaRXbPmFyOdeg2HaQD+AduwRAMe6MQ0vaCQ
         vo6jyaSr0+aIGAwjWGjYhcFVDS6fXm9Wrl26D0x4iIhCR1sjLaTCOQ4XVza4/kASyhZ7
         8SiMDiKdQZf8hCVP62aGz5L1LY1MB4B9qFf0vObOaDoQnWNhrkPlrF1W0Kdip7EENkGJ
         C2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602735; x=1793207535;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FQAoTq1ySMg44FAVyZGQcfcvRQE19iF0lwberHA3gKY=;
        b=Qxkqn3kpFUNVXt1ewQp+MvzzfvhOFup7JpJ65fckBsxcBdMmXPx8iak+qrKsbvU1uA
         ty6njniLCXVqH7BzVvjYuAtrAhL5wHYE5ru8lXhMTPPTqVWmNcenKURVnmKm+QMMrGX5
         T7mIGXiAGFp2PNK3N+KapHUGNQPZGoRcGk3k5g0d7dBNI5P0aF2G2ay8tT7CaPJkVzrn
         JzaHzVxJndjbbumC735v62vf/ivrWBWfpvfQi7066tXEGKrRryMD4EgpYpUwMdBqmi9u
         jmKu89nga2zDVQfEY2AmQuaaZhGYYP49peDm7EV/H0TC13CyMbyoS/kyHUsaC+1XaA9M
         xX6A==
X-Forwarded-Encrypted: i=1; AKwUvBwWPwl3pCbV73Hv74P6pkcsNFt7yCf9O527r/HNUvc8BH4cpIP6xDWrSfcH1RSXqwM2KR0Wy0lgZv45IFHZeLr6@vger.kernel.org
X-Gm-Message-State: AFq9FYJgDZp4gbvm5/D60l0or/o3HtZVQHJifDAn42l83BlZr2TRxcp/
	6lDNmjTKLfc06+YyU5KvHqakIvfaGsPrPlmhuh1VQnTBTFhJ0fPbVt2gwt+du0qafjTI2qncWWZ
	FXVtICMyEHw==
X-Received: from dled6-n2.prod.google.com ([2002:a05:701b:42c6:20b0:191:8b40:a632])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:691:b0:149:d501:b990
 with SMTP id a92af1059eb24-190a599a59fmr4623399c88.25.1792602734703; Wed, 21
 Oct 2026 10:12:14 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:10:41 -0700
In-Reply-To: <20261021171044.155240-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020163640.746159-1-irogers@google.com> <20261021171044.155240-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261021171044.155240-16-irogers@google.com>
Subject: [PATCH v6 15/17] perf config, intel-tpebs, env: Add __guarded_by and
 __must_hold annotations
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Add __guarded_by() and __must_hold() annotations to static parser and
config state in util/config.c, TPEBS state in util/intel-tpebs.c, and
bpf_progs and cgroups trees in struct perf_env.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-event.h   |  5 ++--
 tools/perf/util/config.c      | 43 ++++++++++++++++++++++-------------
 tools/perf/util/env.c         |  1 +
 tools/perf/util/env.h         | 19 +++++++++-------
 tools/perf/util/intel-tpebs.c |  7 +++---
 5 files changed, 46 insertions(+), 29 deletions(-)

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
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 287401f159e6..a55f7062a09b 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -64,15 +64,29 @@ struct perf_stat_config stat_config = {
 
 char buildid_dir[MAXPATHLEN]; /* root dir for buildid, binary cache */
 
-static FILE *config_file;
-static const char *config_file_name;
-static int config_linenr;
-static int config_file_eof;
-static struct perf_config_set *config_set;
+/* Parsing and rewriting share the static parser state. */
+static DEFINE_MUTEX(config_mutex);
+
+/* Serializes whole perf_config__set_variable() updates. */
+static DEFINE_MUTEX(config_update_mutex);
+
+/*
+ * Protects the global config_set. Separate from config_mutex because
+ * initializing config_set parses the config files, which acquires
+ * config_mutex.
+ */
+static DEFINE_MUTEX(config_set_mutex);
+
+static FILE *config_file __guarded_by(&config_mutex);
+static const char *config_file_name __guarded_by(&config_mutex);
+static int config_linenr __guarded_by(&config_mutex);
+static int config_file_eof __guarded_by(&config_mutex);
+static struct perf_config_set *config_set __guarded_by(&config_set_mutex);
 
 const char *config_exclusive_filename;
 
 static int get_next_char(void)
+	__must_hold(&config_mutex)
 {
 	int c;
 	FILE *f;
@@ -99,6 +113,7 @@ static int get_next_char(void)
 }
 
 static char *parse_value(void)
+	__must_hold(&config_mutex)
 {
 	static char value[1024];
 	int quote = 0, comment = 0, space = 0;
@@ -170,6 +185,7 @@ static inline int iskeychar(int c)
 }
 
 static int get_value(config_fn_t fn, void *data, char *name, unsigned int len)
+	__must_hold(&config_mutex)
 {
 	int c;
 	char *value;
@@ -201,6 +217,7 @@ static int get_value(config_fn_t fn, void *data, char *name, unsigned int len)
 }
 
 static int get_extended_base_var(char *name, int baselen, int c)
+	__must_hold(&config_mutex)
 {
 	do {
 		if (c == '\n')
@@ -237,6 +254,7 @@ static int get_extended_base_var(char *name, int baselen, int c)
 }
 
 static int get_base_var(char *name)
+	__must_hold(&config_mutex)
 {
 	int baselen = 0;
 
@@ -257,6 +275,7 @@ static int get_base_var(char *name)
 }
 
 static int perf_parse_file(config_fn_t fn, void *data)
+	__must_hold(&config_mutex)
 {
 	int comment = 0;
 	int baselen = 0;
@@ -549,12 +568,6 @@ int perf_default_config(const char *var, const char *value,
 	return 0;
 }
 
-/* Parsing and rewriting share the static parser state. */
-static DEFINE_MUTEX(config_mutex);
-
-/* Serializes whole perf_config__set_variable() updates. */
-static DEFINE_MUTEX(config_update_mutex);
-
 static int perf_config_from_file(config_fn_t fn, const char *filename, void *data)
 {
 	int ret;
@@ -737,6 +750,7 @@ static int set_value(struct perf_config_item *item, const char *value)
 
 static int collect_config(const char *var, const char *value,
 			  void *perf_config_set)
+	__must_hold(&config_mutex)
 {
 	int ret = -1;
 	char *ptr, *key;
@@ -853,11 +867,8 @@ struct perf_config_set *perf_config_set__load_file(const char *file)
 	return set;
 }
 
-/* Not config_mutex: building the set parses the config files, which takes it. */
-static DEFINE_MUTEX(config_set_mutex);
-
-/* Called with config_set_mutex held. */
 static int perf_config__init(void)
+	__must_hold(&config_set_mutex)
 {
 	if (config_set == NULL)
 		config_set = perf_config_set__new();
@@ -975,7 +986,7 @@ int perf_config__set_variable(const char *var, const char *value)
 
 	/* Static: the parser publishes it as config_file_name. */
 	{
-		static char path[PATH_MAX];
+		static char path[PATH_MAX] __guarded_by(&config_update_mutex);
 		char *user_config = mkpath(path, sizeof(path), "%s/.perfconfig", getenv("HOME"));
 
 		config_filename = config_exclusive_filename ?: user_config;
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
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 1812917bfb85..fb3127aa83ce 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -39,11 +39,11 @@
 bool tpebs_recording;
 enum tpebs_mode tpebs_mode;
 static DEFINE_MUTEX(tpebs_mtx);
-static LIST_HEAD(tpebs_results);
-static pthread_t tpebs_reader_thread;
+static struct list_head tpebs_results __guarded_by(&tpebs_mtx) = LIST_HEAD_INIT(tpebs_results);
+static pthread_t tpebs_reader_thread __guarded_by(&tpebs_mtx);
 static struct child_process tpebs_cmd;
 static int control_fd[2] = { -1, -1 }, ack_fd[2] = { -1, -1 };
-static bool tpebs_stopping;
+static bool tpebs_stopping __guarded_by(&tpebs_mtx);
 
 struct tpebs_retire_lat {
 	struct list_head nd;
@@ -63,6 +63,7 @@ static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *evsel)
 	__must_hold(&tpebs_mtx);
 
 static int evsel__tpebs_start_perf_record(struct evsel *evsel)
+	__must_hold(&tpebs_mtx)
 {
 	const char **record_argv;
 	int tpebs_event_size = 0, i = 0, ret;
-- 
2.56.0.218.g1ec904b173-goog

