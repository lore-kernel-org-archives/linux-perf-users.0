Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF371FFC59
	for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 06:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748328137; cv=none; b=sI6Pr+t2On9w/xgj5GwvC0eLyBLzD9X2SuqWRc/fjc5Xck+QkFW1rsjLvXhJhE3T8n0fSy7n/OcHVSjCF+5yAc+JkYAoaRq5N1HLFhaxG//5JjJvX8zECvYBsJoKIqkMwx/IXWhQShY318W0rC8p24Q7bEfakwD1xbk1qN/95Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748328137; c=relaxed/simple;
	bh=f+bQ3Jv5bB9u7ogojqWPKsGXPSw5u7vrWgbYZOKwxlY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=BOERh0uUxWdeZLs/wb7w5NeecPshL5DPKIR9x6ZPQxDstC1P6pGGr9m2krrQckISiwtO1q9PlPVHvWMlEN+V5f2onNOlpEUg1qhcNqOYGCxyh+HrgRNkxFlo6GjWPrx0F4ghQGaMMa+HaWLh/dVl31kInHZqAasXNpwOARjpLxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2eLWwFFh; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2eLWwFFh"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22c31b55ac6so37935855ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 May 2025 23:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748328135; x=1748932935; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=osa5wtVgN75Qz2+/E2ShchmseliLYV0sbPvRf6suVCQ=;
        b=2eLWwFFhdTBn45vFEU09Fc+yNBhRtfrjC9sP9B89nBp65td4hMgfvY3bIrGl/9mwY7
         UspsF/x49NJ93FjAm9iOMulQn6dsujprqzJKiMSGicvILSQD1EWk0c2KyyL+ZetBhlx8
         OsJigHMBLtRE0+lO8pqJbxKKQLmwHKPSCb48EmxGHQ2964rIbvt60Yb3B0lX50LS9nYo
         gdc3ZabxoaamPHYHJRWB3QlXLpAIUcl/XKpOagNqDbO1V0gThhHe2DFwZk81h571tT4r
         Hg97UrzzWWdJDtLTpRztcy0AQIL+Xemd9N4EZm0qw41U/xmdklJ0a2CcsjjTfaJIUjQL
         vbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748328135; x=1748932935;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=osa5wtVgN75Qz2+/E2ShchmseliLYV0sbPvRf6suVCQ=;
        b=weC1pYAGJ+4uGwrEUzaUGmWF/eQItQ/55GTUNk8phNPcwCzb9HsGKVyRSagrxwe417
         EmN8DwBksgxAAxZDkyIuEi8ujos6AnHV6aqgu5XrFnQpeBtAXlJhEwvCwykKa5pFsAQq
         QZ0TU36f5mr6j6+tPLjfEeXKFqK0q6fQwuo7fL7jyRy1tgQ7hAxN0RGx0Na1eZv8uGpy
         IQdEqhQXQnDSSHBaCeu6mL8NQ8BaqC+Xne1qsQ5M7ht5dQ+JlzjDe7wVjMQIxY9wfKct
         MVDpuIbYwIXvo+M9bpkxsOUl2Wf5FeI3sU5TCo+JvZe/aOg9Ffq1rD2ghqTVdluTR0Ee
         h5Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVfGaA8aeItrPCCQedl94+BuNkJw96Le66YWFnnTHVu6A6hasso8p8QGBtOJY3phhyRqlKCYP1GCvkHssKrItIu@vger.kernel.org
X-Gm-Message-State: AOJu0YypPhgZdk8nBHKmbDV1/28PhjveQuS/MYefpWsaVZ6zlbh6IC81
	Df8nOIMx/nLlytgwiwAAPa89vxgMVJoGpc9nn7IwUOqxgolP7XphmBp79RMk1EGV3KWpDsISXvV
	nGZCSk8Ac6A==
X-Google-Smtp-Source: AGHT+IHBlK8YqoPMAr7xh9aEs9BuP63hCf3vUPjkswlC+FGyc/S92WE6qVaUgB/MfYWJFOpNBewMgTCnn2Lz
X-Received: from plgf13.prod.google.com ([2002:a17:902:ce8d:b0:234:711c:9397])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2402:b0:234:8aad:73cd
 with SMTP id d9443c01a7336-2348aad7438mr34457945ad.30.1748328134808; Mon, 26
 May 2025 23:42:14 -0700 (PDT)
Date: Mon, 26 May 2025 23:41:47 -0700
In-Reply-To: <20250527064153.149939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250527064153.149939-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250527064153.149939-6-irogers@google.com>
Subject: [PATCH v1 05/11] perf test: Avoid use perf_env
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Weilin Wang <weilin.wang@intel.com>, Michael Petlan <mpetlan@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Chun-Tse Shao <ctshao@google.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

The perf_env global variable holds the host perf_env data but its use
is hit and miss. Switch to using local perf_env variables and ensure
scoped perf_env__init and perf_env__exit. This loses command line
setting of the perf_env, but this doesn't matter for tests. So the
perf_env is fully initialized, clear it with memset in perf_env__init.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/code-reading.c  |  5 +++-
 tools/perf/tests/dlfilter-test.c | 50 ++++++++++++++++++--------------
 tools/perf/util/env.c            |  1 +
 3 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index cf6edbe697b2..4b2461e93b2b 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -651,11 +651,13 @@ static int do_test_code_reading(bool try_kcore)
 	struct dso *dso;
 	const char *events[] = { "cycles", "cycles:u", "cpu-clock", "cpu-clock:u", NULL };
 	int evidx = 0;
+	struct perf_env host_env;
 
 	pid = getpid();
 
 	machine = machine__new_host();
-	machine->env = &perf_env;
+	perf_env__init(&host_env);
+	machine->env = &host_env;
 
 	ret = machine__create_kernel_maps(machine);
 	if (ret < 0) {
@@ -798,6 +800,7 @@ static int do_test_code_reading(bool try_kcore)
 	perf_cpu_map__put(cpus);
 	perf_thread_map__put(threads);
 	machine__delete(machine);
+	perf_env__exit(&host_env);
 
 	return err;
 }
diff --git a/tools/perf/tests/dlfilter-test.c b/tools/perf/tests/dlfilter-test.c
index 54f59d1246bc..6427e3382711 100644
--- a/tools/perf/tests/dlfilter-test.c
+++ b/tools/perf/tests/dlfilter-test.c
@@ -319,11 +319,12 @@ static int run_perf_script(struct test_data *td)
 
 static int test__dlfilter_test(struct test_data *td)
 {
+	struct perf_env host_env;
 	u64 sample_type = TEST_SAMPLE_TYPE;
 	pid_t pid = 12345;
 	pid_t tid = 12346;
 	u64 id = 99;
-	int err;
+	int err = TEST_OK;
 
 	if (get_dlfilters_path(td->name, td->dlfilters, PATH_MAX))
 		return test_result("dlfilters not found", TEST_SKIP);
@@ -353,37 +354,42 @@ static int test__dlfilter_test(struct test_data *td)
 
 	pr_debug("Creating new host machine structure\n");
 	td->machine = machine__new_host();
-	td->machine->env = &perf_env;
+	perf_env__init(&host_env);
+	td->machine->env = &host_env;
 
 	td->fd = creat(td->perf_data_file_name, 0644);
 	if (td->fd < 0)
 		return test_result("Failed to create test perf.data file", TEST_FAIL);
 
 	err = perf_header__write_pipe(td->fd);
-	if (err < 0)
-		return test_result("perf_header__write_pipe() failed", TEST_FAIL);
-
+	if (err < 0) {
+		err = test_result("perf_header__write_pipe() failed", TEST_FAIL);
+		goto out;
+	}
 	err = write_attr(td, sample_type, &id);
-	if (err)
-		return test_result("perf_event__synthesize_attr() failed", TEST_FAIL);
-
-	if (write_comm(td->fd, pid, tid, "test-prog"))
-		return TEST_FAIL;
-
-	if (write_mmap(td->fd, pid, tid, MAP_START, 0x10000, 0, td->prog_file_name))
-		return TEST_FAIL;
-
-	if (write_sample(td, sample_type, id, pid, tid) != TEST_OK)
-		return TEST_FAIL;
-
+	if (err) {
+		err = test_result("perf_event__synthesize_attr() failed", TEST_FAIL);
+		goto out;
+	}
+	if (write_comm(td->fd, pid, tid, "test-prog")) {
+		err = TEST_FAIL;
+		goto out;
+	}
+	if (write_mmap(td->fd, pid, tid, MAP_START, 0x10000, 0, td->prog_file_name)) {
+		err = TEST_FAIL;
+		goto out;
+	}
+	if (write_sample(td, sample_type, id, pid, tid) != TEST_OK) {
+		err = TEST_FAIL;
+		goto out;
+	}
 	if (verbose > 1)
 		system_cmd("%s script -i %s -D", td->perf, td->perf_data_file_name);
 
-	err = run_perf_script(td);
-	if (err)
-		return TEST_FAIL;
-
-	return TEST_OK;
+	err = run_perf_script(td) ? TEST_FAIL : TEST_OK;
+out:
+	perf_env__exit(&host_env);
+	return err;
 }
 
 static void unlink_path(const char *path)
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 36411749e007..b363c933e782 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -254,6 +254,7 @@ void perf_env__exit(struct perf_env *env)
 
 void perf_env__init(struct perf_env *env)
 {
+	memset(env, 0, sizeof(*env));
 #ifdef HAVE_LIBBPF_SUPPORT
 	env->bpf_progs.infos = RB_ROOT;
 	env->bpf_progs.btfs = RB_ROOT;
-- 
2.49.0.1151.ga128411c76-goog

