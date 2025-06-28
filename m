Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AA7222585
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Jun 2025 04:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751086263; cv=none; b=UaSLKc0uN3ijeZQKsp1GbCqGtmI9pttTY0uLd5Zyw4mrVN7wqpAU3ozKodr8stT+bntUZO/nzwJ982n02xQc4MuGWn/NBnXgmrtRrBbvhU20yIPodNZU1dprp7fKJ/FMzxpK8NnGKr16htA6LqYcwPHJtAFrfITKP//0AnxB5B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751086263; c=relaxed/simple;
	bh=1LZGMWTHze8TY3G0ikrz2u0m1pSzabfYAWfQ5jh9Q6s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rq5QaNr7ee0+anzqdbVLE/tRsIFOr4vQfzqCEgohHf06UItG+7CKeiHMBPJhUJ8od92cHONTVxZh/SCReVL0uz2xPneEJlvpEfP1QhZ2EKcBAy+oiIx5oFBjqOGCcBbPqrsrEsJs9ejjJK7w3KEgpAy52UWfWYRDByarF2cIDQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1tLAgHIp; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1tLAgHIp"
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-60d3f6ca90eso333324eaf.2
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 21:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751086261; x=1751691061; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vY0eUbYXtmF+t+TY6dxfjdCllkKtrQTihwoCq+bVxxQ=;
        b=1tLAgHIpBu27DcL2mTPSv4cloPcU3NGlcjf1Cx/VKaI+TL69g4awF60jJYOxQMMK//
         v74byPHPeHq2GSXA/4z3VDEkDHJOR+5mwvIdrp4qHmcI64cSFvqwZ2iPbfjohsfQCnHU
         uuOQLXiTmZizMSdAYFoTPfXE5MluVrIBzLxbVTiw3LhbCZ8nRk+j5i9OMEHmb0eIGd7/
         Feguweakh7fJE4HW8TmboqOT4gKYLpLdBDqyRafsnS3cKZrApQ615x6pURh200KLxC/D
         RRxzpurefWzKBC12G/5+82NnNmMpReZ0q5hMIPfHGEHgjtm+s4h4aJMTF120clzMpK9V
         /uHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751086261; x=1751691061;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vY0eUbYXtmF+t+TY6dxfjdCllkKtrQTihwoCq+bVxxQ=;
        b=U3ldsF8fyoPw9Ghk+1Kiyt3wy1L/rm+VxLtw4KgYNK3zoKxvLCCNv20yUdMAGVw/Ad
         RACmtybhm2RT2ym/j26oLsxSAsJbYmXimQ38fBUdSWQ78gHqv3wLW9Jtt+fMMe12TeMT
         VHOdxwc3JBnYBC54F+iSfYZC1gO3RLJXTu7CDoub5GykZTaBG+rHNU63QAZrN3fK2DoG
         uxeaqApy/qcznJUbMU1s4G6e/cQtFMX4fe4P1+WTJEtIgvOg7vrvZoxqzHSUTuDZpxck
         HsB6np/47HqKKaS1UjkUdWLAMcF21xSJAc/OpCEwkFA19QJMunn4Hgj8euYZw8Sn2lb0
         lK3g==
X-Forwarded-Encrypted: i=1; AJvYcCUtO0hWiSRaUeC3CquWjzOScS6vG8X6FeMUvBD9vp06w4IiIZnGlRG0dB3pyZIcSBGBopJF+RP6Kygkf1AH7xm0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/mgEzheNGIgvhupk01HZfkW+V1ZTc7YRcZsbLChwZVCcanIYn
	gq2pwwbKLVy6KgHjPA9/TM/p+I11tevjum+m5JvwhTbaMDM6OC41DWFJAA0CvA8nOyobZGgkaeh
	/D5PzsDn/yA==
X-Google-Smtp-Source: AGHT+IE+a4QtJs5jJ0mKFHpLVUIqiUu2BIry1+qnZU9jpTyic0dsLZYYkxF7DtYL5f/plkjvSxLO6AcPs5y/
X-Received: from oabvz18.prod.google.com ([2002:a05:6871:a412:b0:2eb:dbe3:399c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:2113:b0:2bc:716c:4622
 with SMTP id 586e51a60fabf-2efed7c1ffdmr3661467fac.38.1751086261010; Fri, 27
 Jun 2025 21:51:01 -0700 (PDT)
Date: Fri, 27 Jun 2025 21:50:05 -0700
In-Reply-To: <20250628045017.1361563-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250628045017.1361563-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628045017.1361563-12-irogers@google.com>
Subject: [PATCH v5 11/23] perf evlist: Change env variable to session
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
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
index 8a452353c867..2c25eda4be26 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2535,7 +2535,7 @@ static int process_attr(const struct perf_tool *tool, union perf_event *event,
 	 * on events sample_type.
 	 */
 	sample_type = evlist__combined_sample_type(evlist);
-	callchain_param_setup(sample_type, perf_env__arch((*pevlist)->env));
+	callchain_param_setup(sample_type, perf_env__arch(perf_session__env(scr->session)));
 
 	/* Enable fields for callchain entries */
 	if (symbol_conf.use_callchain &&
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 84b223a94dcf..72f9be5a3b30 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1654,7 +1654,6 @@ int cmd_top(int argc, const char **argv)
 			"Couldn't read the cpuid for this machine: %s\n",
 			str_error_r(errno, errbuf, sizeof(errbuf)));
 	}
-	top.evlist->env = &perf_env;
 
 	argc = parse_options(argc, argv, options, top_usage, 0);
 	if (argc)
@@ -1822,6 +1821,7 @@ int cmd_top(int argc, const char **argv)
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
index 85859708393e..121879aef60f 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -70,7 +70,7 @@ struct evlist {
 	struct mmap *overwrite_mmap;
 	struct evsel *selected;
 	struct events_stats stats;
-	struct perf_env	*env;
+	struct perf_session *session;
 	void (*trace_event_sample_raw)(struct evlist *evlist,
 				       union perf_event *event,
 				       struct perf_sample *sample);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d55482f094bf..24c93ea5ba0a 100644
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
@@ -3839,11 +3840,16 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
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
index 6dbc9690e0c9..847acf9f6795 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -537,6 +537,7 @@ static inline bool evsel__is_dummy_event(struct evsel *evsel)
 	       (evsel->core.attr.config == PERF_COUNT_SW_DUMMY);
 }
 
+struct perf_session *evsel__session(struct evsel *evsel);
 struct perf_env *evsel__env(struct evsel *evsel);
 
 int evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 44941b3adddd..c10eec0e9251 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -4213,7 +4213,7 @@ int perf_session__read_header(struct perf_session *session)
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
index e39a1df7c044..29f5d376f65e 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -178,7 +178,7 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 				perf_session__set_comm_exec(session);
 			}
 
-			evlist__init_trace_event_sample_raw(session->evlist);
+			evlist__init_trace_event_sample_raw(session->evlist, &session->header.env);
 
 			/* Open the directory data. */
 			if (data->is_dir) {
@@ -194,6 +194,8 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 	} else  {
 		session->machines.host.env = &perf_env;
 	}
+	if (session->evlist)
+		session->evlist->session = session;
 
 	session->machines.host.single_address_space =
 		perf_env__single_address_space(session->machines.host.env);
-- 
2.50.0.727.gbf7dc18ff4-goog

