Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A0A2ED159
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374822; cv=none; b=MiPB4x5v6JjTMJTp//TPR0zXDa41+Tw2dJRe6uIko5NXsTaCSHnGbut6JUtCqOa/26/Fhe5Zpk8zyAfPK47gNZ1b+0Emqbgt5joSSL8DN8GKDGovJig+SzBYknfPlRmJ3IC0AznYewPBwyjxX66O0+NRL3wbvKqW2l/ypi9uFKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374822; c=relaxed/simple;
	bh=p4OOtBZXP/hcR4TV7/XmfIwE6bIMEydNNz4oP3ouRxs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=msEJ0K2OakGDW4jz0X3F0zkhkQ9Ij6PD7ItSAtAQjShVWUfCNpf/Aid95W8YOhOxBeNh4atimvJ6RblPReak35JV2Dj+/75W/gimomQkdxmiYb8AuzxFL9+oKsX+X3lmGZml9xsgEonrwSOZ9ao2M/nVfwNFe+ITIraVpHngxGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yRB5xRC6; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yRB5xRC6"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b3bde4d4d5cso931674a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 09:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753374820; x=1753979620; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pi9ebDUjouho2rHSFJP8v3MSTtny3s9gM+6XGmTbhio=;
        b=yRB5xRC6KsfHHdGvQTctpkISHcVtZB2jlMoivve/0sKcoylIIbD/aPgP4v/TsQxN79
         Umv2hBeQHbLz1VNlQszCifwD+y2XoDGIdk3+wMUIgN8xUeHIJXe1YGXM+HqmhM0Y8Bff
         h/Oqsmp8bBe3H3wqYgpkQ7/6UEvhsopxPBM9GiZpse/sGefH3navVLZPpv8oM9wXIIC2
         qlqPxmOUpNme1Iy0w+hp+ioBlxTDBjgiXt5AhY2uaN+NxRjCDdrFSubOfx4omq14iAD1
         ia5tCXson7dQXQrvYKa+L2kMxpWP5Gu4gQb3k4URbXEapcR8z17YiA5QyLJYITDC1ZIL
         Ep3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753374820; x=1753979620;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pi9ebDUjouho2rHSFJP8v3MSTtny3s9gM+6XGmTbhio=;
        b=LFHCYpaO2b9ZhSN8RcWSuSYBzqyxANSMjV3w8AH7WhMRwONKDxfMfXArm9nzi9QU6V
         e2cUXRDIQxkeLUF0eom7rG7GR3C/B4HWfvjzmCkRhUBOlEteQoOxXObP2yCBsAKXE0SJ
         na0gL5Q0yAOyWEMUC/TKkTkNW0RTxoXH9Fiw8WcZvTTe1Z0cb44db0d7oiJyJxmPRi89
         Y6Z5Zdbh/T2Ca6CecvC5t/wUK0W/tB38pigtDVyHxGzu6MRMliGSImUOZO1iP1y/swEy
         mDHOKDuV7DFm2BzpClxPzn7dQq2W0VYcgdCHSCEpHspx/bJ20NYuAfN7I2pkOQLPksv6
         Rw7w==
X-Forwarded-Encrypted: i=1; AJvYcCX5Xx3YYGBde0xjqO30ALNWzHXH5UxbP1nn4UHx+a7mp1MIzTi1GBqhNdLX4dBPi2ZpeEwkp3S88Bd4lkluG68b@vger.kernel.org
X-Gm-Message-State: AOJu0YzwXb9FSKuyZhi+k1SEOwqvN6k13TeKoDG0YT1odNwv8moqdkha
	pDW3SMgalCALcnanwHTrOt1FWt794XSOKjQoj24RF9I5km4c9R3TA9aJ0kJ+WjERG3EwBB+nblg
	MKmO4QNLzAw==
X-Google-Smtp-Source: AGHT+IG3IJiQfngE2nOsi/1oZ1HgGGC1rKZMmthyyeJdII1TqmNowfo99ZzuKSGfMk4oesN7dzTmOC83vFwt
X-Received: from pjbsp12.prod.google.com ([2002:a17:90b:52cc:b0:312:1af5:98c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3909:b0:313:287c:74bd
 with SMTP id 98e67ed59e1d1-31e508579c1mr11346126a91.33.1753374819866; Thu, 24
 Jul 2025 09:33:39 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:32:50 -0700
In-Reply-To: <20250724163302.596743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724163302.596743-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250724163302.596743-11-irogers@google.com>
Subject: [PATCH v6 10/22] perf evlist: Change env variable to session
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Graham Woodward <graham.woodward@arm.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Chun-Tse Shao <ctshao@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Levi Yun <yeoreum.yun@arm.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Matt Fleming <matt@readmodwrite.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The session holds a perf_env pointer env. In UI code container_of is
used to turn the env to a session, but this assumes the session
header's env is in use. Rather than a dubious container_of, hold the
session in the evlist and derive the env from the session with
evsel__env, perf_session__env, etc.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c      |  6 +++++-
 tools/perf/builtin-script.c      |  2 +-
 tools/perf/builtin-top.c         |  2 +-
 tools/perf/tests/topology.c      |  1 +
 tools/perf/ui/browser.h          |  4 ++--
 tools/perf/ui/browsers/header.c  |  4 +---
 tools/perf/ui/browsers/hists.c   |  2 +-
 tools/perf/util/amd-sample-raw.c |  2 +-
 tools/perf/util/arm-spe.c        |  2 +-
 tools/perf/util/evlist.h         |  2 +-
 tools/perf/util/evsel.c          | 12 +++++++++---
 tools/perf/util/evsel.h          |  1 +
 tools/perf/util/header.c         |  2 +-
 tools/perf/util/s390-cpumsf.c    |  2 +-
 tools/perf/util/sample-raw.c     |  7 ++++---
 tools/perf/util/sample-raw.h     |  2 +-
 tools/perf/util/session.c        |  4 +++-
 17 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 704576e46e4b..ada8e0166c78 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1274,6 +1274,8 @@ static int process_attr(const struct perf_tool *tool __maybe_unused,
 			union perf_event *event,
 			struct evlist **pevlist)
 {
+	struct perf_session *session;
+	struct perf_env *env;
 	u64 sample_type;
 	int err;
 
@@ -1286,7 +1288,9 @@ static int process_attr(const struct perf_tool *tool __maybe_unused,
 	 * on events sample_type.
 	 */
 	sample_type = evlist__combined_sample_type(*pevlist);
-	callchain_param_setup(sample_type, perf_env__arch((*pevlist)->env));
+	session = (*pevlist)->session;
+	env = perf_session__env(session);
+	callchain_param_setup(sample_type, perf_env__arch(env));
 	return 0;
 }
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 31cce67217b0..f2b5620165b4 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2534,7 +2534,7 @@ static int process_attr(const struct perf_tool *tool, union perf_event *event,
 	 * on events sample_type.
 	 */
 	sample_type = evlist__combined_sample_type(evlist);
-	callchain_param_setup(sample_type, perf_env__arch((*pevlist)->env));
+	callchain_param_setup(sample_type, perf_env__arch(perf_session__env(scr->session)));
 
 	/* Enable fields for callchain entries */
 	if (symbol_conf.use_callchain &&
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 87d5742b7eb7..2760971d4c97 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1654,7 +1654,6 @@ int cmd_top(int argc, const char **argv)
 			"Couldn't read the cpuid for this machine: %s\n",
 			str_error_r(errno, errbuf, sizeof(errbuf)));
 	}
-	top.evlist->env = &perf_env;
 
 	argc = parse_options(argc, argv, options, top_usage, 0);
 	if (argc)
@@ -1830,6 +1829,7 @@ int cmd_top(int argc, const char **argv)
 		perf_top__update_print_entries(&top);
 		signal(SIGWINCH, winch_sig);
 	}
+	top.session->env = &perf_env;
 
 	top.session = perf_session__new(NULL, NULL);
 	if (IS_ERR(top.session)) {
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index bc7d10630dad..ec01150d208d 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -43,6 +43,7 @@ static int session_write_header(char *path)
 
 	session->evlist = evlist__new_default();
 	TEST_ASSERT_VAL("can't get evlist", session->evlist);
+	session->evlist->session = session;
 
 	perf_header__set_feat(&session->header, HEADER_CPU_TOPOLOGY);
 	perf_header__set_feat(&session->header, HEADER_NRCPUS);
diff --git a/tools/perf/ui/browser.h b/tools/perf/ui/browser.h
index f59ad4f14d33..9d4404f9b87f 100644
--- a/tools/perf/ui/browser.h
+++ b/tools/perf/ui/browser.h
@@ -71,8 +71,8 @@ int ui_browser__help_window(struct ui_browser *browser, const char *text);
 bool ui_browser__dialog_yesno(struct ui_browser *browser, const char *text);
 int ui_browser__input_window(const char *title, const char *text, char *input,
 			     const char *exit_msg, int delay_sec);
-struct perf_env;
-int tui__header_window(struct perf_env *env);
+struct perf_session;
+int tui__header_window(struct perf_session *session);
 
 void ui_browser__argv_seek(struct ui_browser *browser, off_t offset, int whence);
 unsigned int ui_browser__argv_refresh(struct ui_browser *browser);
diff --git a/tools/perf/ui/browsers/header.c b/tools/perf/ui/browsers/header.c
index 2213b4661600..5b5ca32e3eef 100644
--- a/tools/perf/ui/browsers/header.c
+++ b/tools/perf/ui/browsers/header.c
@@ -93,16 +93,14 @@ static int ui__list_menu(int argc, char * const argv[])
 	return list_menu__run(&menu);
 }
 
-int tui__header_window(struct perf_env *env)
+int tui__header_window(struct perf_session *session)
 {
 	int i, argc = 0;
 	char **argv;
-	struct perf_session *session;
 	char *ptr, *pos;
 	size_t size;
 	FILE *fp = open_memstream(&ptr, &size);
 
-	session = container_of(env, struct perf_session, header.env);
 	perf_header__fprintf_info(session, fp, true);
 	fclose(fp);
 
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index d26b925e3d7f..d9d3fb44477a 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3233,7 +3233,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 		case 'i':
 			/* env->arch is NULL for live-mode (i.e. perf top) */
 			if (env->arch)
-				tui__header_window(env);
+				tui__header_window(evsel__session(evsel));
 			continue;
 		case 'F':
 			symbol_conf.filter_relative ^= 1;
diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
index 4b540e6fb42d..b084dee76b1a 100644
--- a/tools/perf/util/amd-sample-raw.c
+++ b/tools/perf/util/amd-sample-raw.c
@@ -354,7 +354,7 @@ static void parse_cpuid(struct perf_env *env)
  */
 bool evlist__has_amd_ibs(struct evlist *evlist)
 {
-	struct perf_env *env = evlist->env;
+	struct perf_env *env = perf_session__env(evlist->session);
 	int ret, nr_pmu_mappings = perf_env__nr_pmu_mappings(env);
 	const char *pmu_mapping = perf_env__pmu_mappings(env);
 	char name[sizeof("ibs_fetch")];
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index d46e0cccac99..8942fa598a84 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -856,7 +856,7 @@ static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
 		const char *cpuid;
 
 		pr_warning_once("Old SPE metadata, re-record to improve decode accuracy\n");
-		cpuid = perf_env__cpuid(spe->session->evlist->env);
+		cpuid = perf_env__cpuid(perf_session__env(spe->session));
 		midr = strtol(cpuid, NULL, 16);
 	} else {
 		/* CPU ID is -1 for per-thread mode */
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index fac1a01ba13f..35c678e5beac 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -71,7 +71,7 @@ struct evlist {
 	struct mmap *overwrite_mmap;
 	struct evsel *selected;
 	struct events_stats stats;
-	struct perf_env	*env;
+	struct perf_session *session;
 	void (*trace_event_sample_raw)(struct evlist *evlist,
 				       union perf_event *event,
 				       struct perf_sample *sample);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3896a04d90af..19d9d6d6a4b2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -48,6 +48,7 @@
 #include "record.h"
 #include "debug.h"
 #include "trace-event.h"
+#include "session.h"
 #include "stat.h"
 #include "string2.h"
 #include "memswap.h"
@@ -3859,11 +3860,16 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			 err, str_error_r(err, sbuf, sizeof(sbuf)), evsel__name(evsel));
 }
 
+struct perf_session *evsel__session(struct evsel *evsel)
+{
+	return evsel && evsel->evlist ? evsel->evlist->session : NULL;
+}
+
 struct perf_env *evsel__env(struct evsel *evsel)
 {
-	if (evsel && evsel->evlist && evsel->evlist->env)
-		return evsel->evlist->env;
-	return &perf_env;
+	struct perf_session *session = evsel__session(evsel);
+
+	return session ? perf_session__env(session) : &perf_env;
 }
 
 static int store_evsel_ids(struct evsel *evsel, struct evlist *evlist)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index b84ee274602d..a2ac6e510d3b 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -539,6 +539,7 @@ static inline bool evsel__is_dummy_event(struct evsel *evsel)
 	       (evsel->core.attr.config == PERF_COUNT_SW_DUMMY);
 }
 
+struct perf_session *evsel__session(struct evsel *evsel);
 struct perf_env *evsel__env(struct evsel *evsel);
 
 int evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 2aba0d829c9e..dcef7f815fa1 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -4225,7 +4225,7 @@ int perf_session__read_header(struct perf_session *session)
 	if (session->evlist == NULL)
 		return -ENOMEM;
 
-	session->evlist->env = &header->env;
+	session->evlist->session = session;
 	session->machines.host.env = &header->env;
 
 	/*
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 0ce52f0280b8..c17dbe232c54 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -1142,7 +1142,7 @@ int s390_cpumsf_process_auxtrace_info(union perf_event *event,
 	sf->machine = &session->machines.host; /* No kvm support */
 	sf->auxtrace_type = auxtrace_info->type;
 	sf->pmu_type = PERF_TYPE_RAW;
-	sf->machine_type = s390_cpumsf_get_type(session->evlist->env->cpuid);
+	sf->machine_type = s390_cpumsf_get_type(perf_session__env(session)->cpuid);
 
 	sf->auxtrace.process_event = s390_cpumsf_process_event;
 	sf->auxtrace.process_auxtrace_event = s390_cpumsf_process_auxtrace_event;
diff --git a/tools/perf/util/sample-raw.c b/tools/perf/util/sample-raw.c
index f3f6bd9d290e..bcf442574d6e 100644
--- a/tools/perf/util/sample-raw.c
+++ b/tools/perf/util/sample-raw.c
@@ -6,15 +6,16 @@
 #include "env.h"
 #include "header.h"
 #include "sample-raw.h"
+#include "session.h"
 
 /*
  * Check platform the perf data file was created on and perform platform
  * specific interpretation.
  */
-void evlist__init_trace_event_sample_raw(struct evlist *evlist)
+void evlist__init_trace_event_sample_raw(struct evlist *evlist, struct perf_env *env)
 {
-	const char *arch_pf = perf_env__arch(evlist->env);
-	const char *cpuid = perf_env__cpuid(evlist->env);
+	const char *arch_pf = perf_env__arch(env);
+	const char *cpuid = perf_env__cpuid(env);
 
 	if (arch_pf && !strcmp("s390", arch_pf))
 		evlist->trace_event_sample_raw = evlist__s390_sample_raw;
diff --git a/tools/perf/util/sample-raw.h b/tools/perf/util/sample-raw.h
index ea01c5811503..896e9a87e373 100644
--- a/tools/perf/util/sample-raw.h
+++ b/tools/perf/util/sample-raw.h
@@ -11,5 +11,5 @@ void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event,
 bool evlist__has_amd_ibs(struct evlist *evlist);
 void evlist__amd_sample_raw(struct evlist *evlist, union perf_event *event,
 			    struct perf_sample *sample);
-void evlist__init_trace_event_sample_raw(struct evlist *evlist);
+void evlist__init_trace_event_sample_raw(struct evlist *evlist, struct perf_env *env);
 #endif /* __PERF_EVLIST_H */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index b09d157f7d04..a851d9130abd 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -177,7 +177,7 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 				perf_session__set_comm_exec(session);
 			}
 
-			evlist__init_trace_event_sample_raw(session->evlist);
+			evlist__init_trace_event_sample_raw(session->evlist, &session->header.env);
 
 			/* Open the directory data. */
 			if (data->is_dir) {
@@ -193,6 +193,8 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 	} else  {
 		session->machines.host.env = &perf_env;
 	}
+	if (session->evlist)
+		session->evlist->session = session;
 
 	session->machines.host.single_address_space =
 		perf_env__single_address_space(session->machines.host.env);
-- 
2.50.0.727.gbf7dc18ff4-goog

