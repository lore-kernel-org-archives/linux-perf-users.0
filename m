Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A49C2EB5DF
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374844; cv=none; b=jizTNqHZQCz7/SuG5CDsCaOD10qYYFyoUZyXtS767bL/XbABKm8jRmCN3Ssj4KSKKwy/zpzfbQ+0IS0+EmLkWc8dbUQlqoSFGXWNYDPxrJ1NKKqx7Zui72UfiwkqTxT/tJxXiZJ5vhGlGqCcya4GoX86BFpr/yrFbYv+vM7kyCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374844; c=relaxed/simple;
	bh=i6U8ftE0GheEC5KsTdZQzjMgFHJQer4WjyEZzq14zu4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pqcjJHs8FZa0L829KS/Vgluerh2bnCaGZSBm5Yu7yM9K6TKXKFP1oo09cIvqVja6OkxzOJ60OMeiBrvegO87UtwqNbGtKOgmyewhjfEZ+RwgvBBC/6kJlx2wPvyEs7zVJtHY8KQSnQR5blXmBdToZP+TyFmkHKtNAnK8ERhHcos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QSakDila; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QSakDila"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23824a9bc29so18609995ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 09:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753374843; x=1753979643; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+Lxwmm+nqsslwRWHv17UsJG7rPlnmpUyi3S/jbxfBM=;
        b=QSakDilaUWby/IetO9Fih/BYggkq0Zy3bfU0pLoO7cZLp3GC7cFcqsFEz8Q2abbuHb
         7PkWPhh74hU8FDr2FhTGEfxWQ77TcK78/o6MFbDqXPQQq8AiUZDInmQlIowvgWFqqVb7
         ZrnGua0LSVj1hgqX6aO8aCqBxIwRtmkonpBFgUsR4JoD0Dr8RNP93/tW0y3dxa51IAct
         mB4zldvvufLEH4bv4qhs7SkNRk4MLgNj2Ya7WSiMu7caUfDkreZJ/2pgFFP5U+LdMqY3
         pFxtYuP2HMkyX8PUNn6QdjPf97NXhpdwqbpgJc5ElJHHPUOWjdo/08Pv0Nls2FVq2v2J
         bQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753374843; x=1753979643;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+Lxwmm+nqsslwRWHv17UsJG7rPlnmpUyi3S/jbxfBM=;
        b=wSOcmKJBwkkuT89z/56BsBLzBkUclSjjQdgwCCtlWY/olCkuT3p8U4P2+jMC2jZFft
         lCjid6QOqMrKYzv0A97KlOOCMn3G1tODXaStCx7NrgMT5O92M5Hg6gJBugEizTHw5Uxb
         B5aAx8hAtsQs7bAoHwoJ7aED1HOpdkTzxpCLMi71o0RvlQu+hnfHLu0DNSDRGj6hZW/p
         zBP3WdWWdBpw7tLMivilcItfpu/h/G8o2a5ldnabiBsuXNWjicDiOu5G2CG6HnUDA2xA
         PrC0t+NDKtdnaO2EUZ7o+P1GFM/vqPWbzpfjeVryAU0c3g0ltWgo1Tjdu4Rr14Y090Tb
         od6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlKmLpffPdNZrJofPruilTdBzTZd6654vGXtV3Xg+hAIkXZ6KNQ0CqgMlAwQNbHiIon9DRj5jjGxZvfOCVNG4D@vger.kernel.org
X-Gm-Message-State: AOJu0YxZJvYBDAqJFe2e/PVJlkuJPMWfVqnTKwCzNMQjerqGwcGr62S9
	lPU8Ka/sKHW/AsVAmGOraiVo2joV+uFc90ZgZFsrpm8q1Fi2SvkRGaK5QkE0n0teftk5d/S5cux
	cpalIzzHEfQ==
X-Google-Smtp-Source: AGHT+IG6stcm2xMzqdr2bWYWwNtxudMcIgVhUoAdZRaNmO+ro5zkMJubKjpS0mOvfw0dEHDd2ygGQIYxkGo2
X-Received: from pllj23.prod.google.com ([2002:a17:902:7597:b0:234:bca4:b7b3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:f8c:b0:22e:3c2:d477
 with SMTP id d9443c01a7336-23f9819366emr100620545ad.25.1753374842620; Thu, 24
 Jul 2025 09:34:02 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:32:59 -0700
In-Reply-To: <20250724163302.596743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724163302.596743-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250724163302.596743-20-irogers@google.com>
Subject: [PATCH v6 19/22] perf env: Remove global perf_env
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

The global perf_env was used for the host, but if a perf_env wasn't
easy to come by it was used in a lot of places where potentially
recorded and host data could be confused. Remove the global variable
as now the majority of accesses retrieve the perf_env for the host
from the session.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/perf.c           | 3 ---
 tools/perf/util/bpf-event.c | 2 +-
 tools/perf/util/env.c       | 2 --
 tools/perf/util/env.h       | 2 --
 tools/perf/util/evsel.c     | 2 +-
 tools/perf/util/session.c   | 3 ++-
 6 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index f0617cc41f5f..88c60ecf3395 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -346,12 +346,9 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 		use_pager = 1;
 	commit_pager_choice();
 
-	perf_env__init(&perf_env);
-	perf_env__set_cmdline(&perf_env, argc, argv);
 	status = p->fn(argc, argv);
 	perf_config__exit();
 	exit_browser(status);
-	perf_env__exit(&perf_env);
 
 	if (status)
 		return status & 0xff;
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 664f361ef8c1..5b6d3e899e11 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -549,7 +549,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 	 * for perf-record and perf-report use header.env;
 	 * otherwise, use global perf_env.
 	 */
-	env = session->data ? perf_session__env(session) : &perf_env;
+	env = perf_session__env(session);
 
 	arrays = 1UL << PERF_BPIL_JITED_KSYMS;
 	arrays |= 1UL << PERF_BPIL_JITED_FUNC_LENS;
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index c09159083bf0..c8c248754621 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -19,8 +19,6 @@
 #include "strbuf.h"
 #include "trace/beauty/beauty.h"
 
-struct perf_env perf_env;
-
 #ifdef HAVE_LIBBPF_SUPPORT
 #include "bpf-event.h"
 #include "bpf-utils.h"
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index d8df59072529..e00179787a34 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -150,8 +150,6 @@ enum perf_compress_type {
 struct bpf_prog_info_node;
 struct btf_node;
 
-extern struct perf_env perf_env;
-
 int perf_env__read_core_pmu_caps(struct perf_env *env);
 void perf_env__exit(struct perf_env *env);
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 19d9d6d6a4b2..e4a52f4b0af0 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3869,7 +3869,7 @@ struct perf_env *evsel__env(struct evsel *evsel)
 {
 	struct perf_session *session = evsel__session(evsel);
 
-	return session ? perf_session__env(session) : &perf_env;
+	return session ? perf_session__env(session) : NULL;
 }
 
 static int store_evsel_ids(struct evsel *evsel, struct evlist *evlist)
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 36532329a633..2a79e6844f36 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -192,7 +192,8 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 				symbol_conf.kallsyms_name = perf_data__kallsyms_name(data);
 		}
 	} else  {
-		session->machines.host.env = host_env ?: &perf_env;
+		assert(host_env != NULL);
+		session->machines.host.env = host_env;
 	}
 	if (session->evlist)
 		session->evlist->session = session;
-- 
2.50.0.727.gbf7dc18ff4-goog

