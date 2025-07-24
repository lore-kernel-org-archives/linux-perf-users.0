Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2A02ED840
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374828; cv=none; b=lAp3YW8Miq7RpGCujDGXCrOnpx8+C4IEBC+KkmPwtl/uBF9p/QbhwsJMOct9Ml6Id7U3KTVxQmGdSU0NO4/OvB16l3k3JmHx5ta/V1hEb0gxqxbEATbR9zSYnqgqBPPsH+v1Yv/3BmATXhPa90p1D0iK+fFt8pye0iavuxH6QIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374828; c=relaxed/simple;
	bh=7nZIiiIn++uSLOhLUk9vUxm/WKkVS4OwTThT0yMdM0E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hrXWqDbs8EBFKKv2VqR65fZ7QlqkDv4534OpAOhS89WVSAWSlOWJncd2tsxWXP/BQIbjBUUyEy2aBorrqCzt2LCE3IxK7OOaErW0uXbI9Q5UDU1cqZgZ22kbQIEIuc0BgftC2pCK+8WsLd5qFwIszJMxWGj2WYQpxsdMOK9nBOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TpilkqaT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TpilkqaT"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3132e7266d3so1174801a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 09:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753374825; x=1753979625; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j4ATCR3gS0GLP8ySUZk5tVezlk+x+k580IPZRgyjTI4=;
        b=TpilkqaTdbDDH09JCjiCEAC/Nq8x9xJjwblexJu2esFnjc4qGNRUcBq6yeTmg2goHA
         3aC1xRq269Oai10uaoEioAMZgmUSqYcxb/Bp9oPPl71vQS972v1HW9fGx09uhIX1/yhF
         gQPu5ubOYOo9+CBAGKc2apJFHGjHpW9y3le0C9IJiCSFV9p/mJQ1Rb4UbZ4HTPD8a2iH
         /hEVCnjdyc1RAS3dglMkihLxqz1bd5CFdtz0OfzAuwd21mcsqoq30++5keCmNuYa7jaK
         yVTRYs4ZEa73oeLcHVbf6y//jEoym+hcfWbp+Z7/jnVsXGokZC4IQp/FWC7KNtdIS2Do
         LFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753374825; x=1753979625;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4ATCR3gS0GLP8ySUZk5tVezlk+x+k580IPZRgyjTI4=;
        b=D+qH3ZrtfZ3WM0EiVgjqUZtMX5Zxc7+4Js3BvNEQV1Iy4MgkwOriP0Aw1Y7zwVKdrr
         I5B24GCecFw9pWiHqRPKzixUkMj6r8XRXXKUKq4qoSGQuvyfWJ+3MBjbh9nzMeHEAp5l
         orhz7E2Wh19ivTm5tz0H+JC/PphokzJWbXu0GZHDUCWAcnXlos0oteIV/jt6KvYWcFSd
         I8ifkNjQ5LKtPdyMwK0YIULF5uSKEQJRXrU0qPEqJhzQ07zu4qkG6qTJxSbfFIIkVOCq
         ZfsJaX77kIMShxaASoJHru+0+UFYR9FQWZX/jyLlplkAbqdh+rACh9bnzcnUVwh96Uu4
         1Tbg==
X-Forwarded-Encrypted: i=1; AJvYcCWOEqPus80f6fu6thqaZ/pkA+fpGqWhmAsCARyqkdIMkp0fWvC9dzoFeMPuZDZMSJYRrF1c94wXP2HXDdN7xhKA@vger.kernel.org
X-Gm-Message-State: AOJu0YwjTjW/8OmwkbxMUOzwJ/NZvQqqA0ltI+fbJgEtTln5GvTTYlJe
	ERFbFd6UDFStiAJmEcYcq0TCvufFqSl6JhV860k6XI7/j+AIV3P0STS4UIScnpbsg3LMzC1UaKL
	rBEa+Vrjlng==
X-Google-Smtp-Source: AGHT+IG9P+0/1FRepvIABmSkJ3cwZnJnUD4EaW9KMNoS8pG7zfn4lxon2/8z1BpHnrz4L3+dyy5Bk56cT/Y1
X-Received: from pjbsd5.prod.google.com ([2002:a17:90b:5145:b0:311:485b:d057])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:582e:b0:313:14b5:2538
 with SMTP id 98e67ed59e1d1-31e50859d80mr9985080a91.35.1753374824262; Thu, 24
 Jul 2025 09:33:44 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:32:52 -0700
In-Reply-To: <20250724163302.596743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724163302.596743-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250724163302.596743-13-irogers@google.com>
Subject: [PATCH v6 12/22] perf test: Avoid use perf_env
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
index 6efb6b4bbcce..0ec7004f90fe 100644
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
@@ -791,6 +793,7 @@ static int do_test_code_reading(bool try_kcore)
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
index ee51378fb0d9..c09159083bf0 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -271,6 +271,7 @@ void perf_env__exit(struct perf_env *env)
 
 void perf_env__init(struct perf_env *env)
 {
+	memset(env, 0, sizeof(*env));
 #ifdef HAVE_LIBBPF_SUPPORT
 	env->bpf_progs.infos = RB_ROOT;
 	env->bpf_progs.btfs = RB_ROOT;
-- 
2.50.0.727.gbf7dc18ff4-goog

