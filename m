Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418978;
	b=MnuxeGE+58UY2MdyQld0ccH8DwifBNLsPDjeopDa7HkfcEhHXzzArCHadpqxddelcLWj
	 F8Z+9DcI4W658nFL56dQZ46nnmqDxUaDmyphgP/U1wQyN5ItfWE3riVV12QqBIz3RXKsN
	 1iNfxjX0/1shqors8XigaDEWWrBBsCs46MwV8yE2sTSOm9s4wDfLIMdkgC/r75N2IC1cc
	 Kj4y7bVL4VoBEZUFwiw4wuFvCnMRLicqkhe/SLXfxWBQFoDbyMuWnQiR6p9ueQnyqS5P4
	 QtVlRNBIRYSzVI3ZUGBBciz9ZcLreyWb8g8azeMRZEknq6PEn6cpdVHmVp44TokRJSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ifEz8uTWk3ktGWm2DDAncx2Re2C1GYCFg3s605e8nFw=;
	b=O30MqWd4ivl9sardRFRwINd270RsrELs4AxsHf3E0NgmJOD2lIlIzJ3kC3Iy7nAYrDIl
	 BGOwFCzN5do1OnFkDyG1O+QCVqiJoyig4UnSFINA3h58ABOnhvAuI4AAIyZdyzBIjL40S
	 hKC2lAqO81JU+ROePo15dsDqi9Dgq5e0I97aYgRQopBs16CSzhB09UbuIpQGUko/OWEAB
	 ePE/k09Af/vz9yn+8J4NCw403sCsirsGH/kxXM25ozk/eqY6ukVFyP2BYxGX5RRSeY28u
	 kanx4Y3msXC16ZSUAJjHoka3oXv5djCqL+AsC+cy6v24zA1i10OLdhbt5V7xCVLsDPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oWOZTKY4;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4DE606B4C7
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 17:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F4DE606B4C7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oWOZTKY4
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so6817298eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 09:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794418977; x=1795023777; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ifEz8uTWk3ktGWm2DDAncx2Re2C1GYCFg3s605e8nFw=;
        b=oWOZTKY4Og/1ZMFidHRxjDx0G20jQuYubKf1+Ox+B7rVCJ3q5ezcuzkZ2Fzz5/vnub
         DmtNuvXkX9/oNLkRJydRpBbGQK9jvVh3V3y711epU1B0bL385rBPcpeE2vduvldXJ4Yw
         8DALZ8v50OYsZjP8mnd3hzZhuC8CXVmgx+Tdjmkb+AP9aPNZCTKcaQlNHjU2ZHqFz3Op
         2FyBeNO/mwBIKHJerZoqJgeABS0txETDOBeu3DVVv3G9lU406HCqoHwdSL7VJ9RsufnL
         waz+TDJ/Iqe1fK0d1htZxjVLL3pzsX9XMSwht+ssWTPBNupDDPYPvOXOIs0G8neFziBh
         9wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794418977; x=1795023777;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ifEz8uTWk3ktGWm2DDAncx2Re2C1GYCFg3s605e8nFw=;
        b=LIPWBQ7mU34PJJSdZmq6VwwbY0OZ/0q+Rh0oqlZMQ7bx8VIcamsBygsiBfM+nSk23m
         Y+eQjprwIHjPpJaCs94TNya6hG4Vm3pOccGVb2bWlSmuws5QMlr/a+Kip0WD2jof6neO
         mg6P64mrTk3BE8aOdn4AIYiLw/rqhs07q40LAZJeezlCMVsx/Wfb+44HGS10OYBZda0n
         co5NgBKQZviVlNEWCOVjvzz1uxDCOo1cLAbZ8d9RlTjl/MgtEd1jwon9jyLm+2Q0C1fl
         DsVnyG6QwgZ3A3UFd+5vL15ves51dPnQ5E3NnicuAPtcL8kSf87sHNgNR1qzni3SRhtZ
         bS/Q==
X-Forwarded-Encrypted: i=1; AL+hErF7Z8HnzY9acVidu/bWwl15RoFVXHMJPHS46JL3br4FMTw2uCQMuSFaoCpp9KFRDSUl8VDz9D6xxGiIsm3i3cTc@vger.kernel.org
X-Gm-Message-State: APuU4Z+7Nroq6yfX0pGkIcQ1sRf1bqdkf/hIxf2NfToWFPFXfNl6lLd6
	4NHQyYxleUplS45W2EFOebPFo7SB09Lk6Nl6i4xUpSFGtJW8NvKlKizDWP80q39UgvL6D762nVe
	bIbONuQ7z8A==
X-Received: from dldyr28-n1.prod.google.com ([2002:a05:701b:451c:10b0:15b:1fa2:b32d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ec04:b0:19a:8e3e:530e
 with SMTP id a92af1059eb24-1b3c02f12demr2991230c88.8.1794418976000; Wed, 11
 Nov 2026 09:42:56 -0800 (PST)
Date: Wed, 11 Nov 2026 09:42:09 -0800
In-Reply-To: <20261111174213.3526604-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261111174213.3526604-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111174213.3526604-18-irogers@google.com>
Subject: [PATCH v12 17/20] perf config, intel-tpebs, env: Add __guarded_by and
 __must_hold annotations
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Add __guarded_by() and __must_hold() annotations to static parser and
config state in util/config.c, TPEBS state in util/intel-tpebs.c, and
bpf_progs and cgroups trees in struct perf_env.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-event.h   |  5 ++--
 tools/perf/util/config.c      | 47 +++++++++++++++++++++--------------
 tools/perf/util/env.c         |  1 +
 tools/perf/util/env.h         | 19 ++++++++------
 tools/perf/util/intel-tpebs.c | 18 ++++++++------
 5 files changed, 54 insertions(+), 36 deletions(-)

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
index 287401f159e6..0e6b77a0a5e7 100644
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
@@ -99,8 +113,9 @@ static int get_next_char(void)
 }
 
 static char *parse_value(void)
+	__must_hold(&config_mutex)
 {
-	static char value[1024];
+	static char value[1024] __guarded_by(&config_mutex);
 	int quote = 0, comment = 0, space = 0;
 	size_t len = 0;
 
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
 
@@ -257,10 +275,11 @@ static int get_base_var(char *name)
 }
 
 static int perf_parse_file(config_fn_t fn, void *data)
+	__must_hold(&config_mutex)
 {
 	int comment = 0;
 	int baselen = 0;
-	static char var[MAXNAME];
+	static char var[MAXNAME] __guarded_by(&config_mutex);
 
 	/* U+FEFF Byte Order Mark in UTF8 */
 	static const unsigned char *utf8_bom = (unsigned char *) "\xef\xbb\xbf";
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
index 2edd8297fa1b..d79d42a36a53 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -39,15 +39,16 @@
 bool tpebs_recording;
 enum tpebs_mode tpebs_mode;
 static DEFINE_MUTEX(tpebs_mtx);
-static LIST_HEAD(tpebs_results);
-static pthread_t tpebs_reader_thread;
-static struct child_process tpebs_cmd;
+static struct list_head tpebs_results __guarded_by(&tpebs_mtx) = LIST_HEAD_INIT(tpebs_results);
+static pthread_t tpebs_reader_thread __guarded_by(&tpebs_mtx);
+static struct child_process tpebs_cmd __guarded_by(&tpebs_mtx);
 static struct cond tpebs_cmd_cond = { .cond = PTHREAD_COND_INITIALIZER };
-static int control_fd[2] = { -1, -1 }, ack_fd[2] = { -1, -1 };
-static bool tpebs_stopping;
-static bool tpebs_enabled;
-static bool tpebs_cmd_in_flight;
-static uint64_t tpebs_gen;
+static int control_fd[2] __guarded_by(&tpebs_mtx) = { -1, -1 };
+static int ack_fd[2] __guarded_by(&tpebs_mtx) = { -1, -1 };
+static bool tpebs_stopping __guarded_by(&tpebs_mtx);
+static bool tpebs_enabled __guarded_by(&tpebs_mtx);
+static bool tpebs_cmd_in_flight __guarded_by(&tpebs_mtx);
+static uint64_t tpebs_gen __guarded_by(&tpebs_mtx);
 
 struct tpebs_retire_lat {
 	struct list_head nd;
@@ -67,6 +68,7 @@ static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *evsel)
 	__must_hold(&tpebs_mtx);
 
 static int evsel__tpebs_start_perf_record(struct evsel *evsel)
+	__must_hold(&tpebs_mtx)
 {
 	const char **record_argv;
 	int tpebs_event_size = 0, i = 0, ret;
-- 
2.56.0.542.g3ef89b7020-goog

