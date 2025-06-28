Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6470A227E88
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Jun 2025 04:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751086277; cv=none; b=T0BTIXzn/kKSeYnn/Ys/useagmd2HqQ0Kny3JAYZteWCcu57NTpzbuATlGgoyS5fUj2QWEuX99J5aIs8TW95LnIVQpvEzW3eZ8AW8j32JSG6NOkrPSkhvj6nPdjbzQmJ1FzPxuOFatz1vka+GyVkWTkMkOrroIyTtv7NBAbY0IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751086277; c=relaxed/simple;
	bh=zGchUZyMYUCy/6PHXS8H+m2lCEi8DBVV81961z39iQw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HmTGM4GqcxPUEk22FcIIykfs6aJ5K8f3GWYi5K9vBK+ODZoktnlkd42GnEnLsHM0lxhJLHdzSDt6paax0wMe1Z18KI6kN8VrrIO3q+vMSDv/Q26J4v6z5Zjyhxa1l4naLnwlMKwTeTNf+fflGXkNlDuIEUF8BEXjJaDvWScmG1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iBDi2wrB; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iBDi2wrB"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-749177ad09fso261661b3a.2
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 21:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751086276; x=1751691076; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cvuoZnm1u6Z7ygBbcSi7UYy9ZWPAMHjuY40VrWoNoYQ=;
        b=iBDi2wrBHXwxBFFk2rIY74ulFF2MTvMeVDACciklkRsde44daejnlrQM7xfrl/n1Vg
         h4C8vhyoit1aCfsK4O65zfxexCQLBsPgWp0bN7lqOd3fKRYRP7ICY1a+sbvXnNXs+aTb
         Fc94pLSeQKsQ5e+m3CDqs0HyoBDN8xAOUpF4efjzXbQ4lkJc/4zCLOlAGtBnuK69FkR1
         5XOccDHwTVNsfVxsd2OQj70F1ONQsuXhxgnncKNopebUT7bMHxwOYGtcgBiTdGX9uOmF
         zWwPhlaMCxk8BMf+YXOipdRBja5BFEamafKgJyGcqTPn0iF7xykHwADrHI2iLfN58G+2
         0UgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751086276; x=1751691076;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cvuoZnm1u6Z7ygBbcSi7UYy9ZWPAMHjuY40VrWoNoYQ=;
        b=C6GOXh6/9KhwYPpMcksZnZaa/vPbJ3S2IDsJipZXrPQEg5R70JppvZ8cHZNveZUYuv
         FGvEAYdmMLFrGB1JfUczShQ1ZMJUQ4eAnMxdsLC97UAF8GuyajHqxDBIaD3eokbf7ne3
         GjwEqeKYMJ9Bjn5GO4IlYm/FySKn2XFJxOntmETG6yghwv5hvh4btKWBuiN3bR5CuTrJ
         R6/ypDdlBhvCPLQMMajYN49WdV4EQnv7rZpNQU8o1IC2Smv6wb8qRLvPm6+cdd697+VO
         mB0Lze9WH2f73em7yHetzAy9waSVTqDMmu4fArGBOs5Gfe2WvS1H7DJsp2hR+LyawTWF
         KgyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR2GB0f9nmBQWDAkIsR3oXouOkAIxGekZFidyyruJ5VyX5FdhfNmI24rg8Z7d58UNlBzxOe5uvbBDcoVyu+j97@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4tpW01brTvQVZQqlC0XjfdgP1XsaUFN+QHVzpL9+fBXTpu5QC
	ANOfNsEyRHMbEEigSaosNr3JQiDTYVuuzjAp2MEpnlzirqKBs3v0OxHMNauLtBehcK2EeSBQz+E
	wJH0dc8fwhg==
X-Google-Smtp-Source: AGHT+IEnY7Srvt5+zaQSY2UdlJWR8Wngw1SuG4VzVZ4q22R7wFABlrnlHOdX4NDruJ7IcnjBV/CPKw+ouxTj
X-Received: from pfop21.prod.google.com ([2002:a05:6a00:b55:b0:746:1fcb:a9cc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:23cb:b0:736:4d05:2e2e
 with SMTP id d2e1a72fcca58-74af6e60f24mr7840029b3a.6.1751086273528; Fri, 27
 Jun 2025 21:51:13 -0700 (PDT)
Date: Fri, 27 Jun 2025 21:50:10 -0700
In-Reply-To: <20250628045017.1361563-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250628045017.1361563-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628045017.1361563-17-irogers@google.com>
Subject: [PATCH v5 16/23] perf bench synthesize: Avoid use of global perf_env
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

The benchmark doesn't use a data file and so the header perf_env isn't
used. Stack allocate a host perf_env for use to avoid the use of the
global perf_env.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/synthesize.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
index 9b333276cbdb..79d99ba50284 100644
--- a/tools/perf/bench/synthesize.c
+++ b/tools/perf/bench/synthesize.c
@@ -114,10 +114,13 @@ static int run_single_threaded(void)
 		.pid = "self",
 	};
 	struct perf_thread_map *threads;
+	struct perf_env host_env;
 	int err;
 
 	perf_set_singlethreaded();
-	session = perf_session__new(NULL, NULL);
+	perf_env__init(&host_env);
+	session = __perf_session__new(/*data=*/NULL, /*tool=*/NULL,
+				      /*trace_event_repipe=*/false, &host_env);
 	if (IS_ERR(session)) {
 		pr_err("Session creation failed.\n");
 		return PTR_ERR(session);
@@ -144,6 +147,7 @@ static int run_single_threaded(void)
 		perf_thread_map__put(threads);
 
 	perf_session__delete(session);
+	perf_env__exit(&host_env);
 	return err;
 }
 
@@ -154,17 +158,21 @@ static int do_run_multi_threaded(struct target *target,
 	u64 runtime_us;
 	unsigned int i;
 	double time_average, time_stddev, event_average, event_stddev;
-	int err;
+	int err = 0;
 	struct stats time_stats, event_stats;
 	struct perf_session *session;
+	struct perf_env host_env;
 
+	perf_env__init(&host_env);
 	init_stats(&time_stats);
 	init_stats(&event_stats);
 	for (i = 0; i < multi_iterations; i++) {
-		session = perf_session__new(NULL, NULL);
-		if (IS_ERR(session))
-			return PTR_ERR(session);
-
+		session = __perf_session__new(/*data=*/NULL, /*tool=*/NULL,
+					      /*trace_event_repipe=*/false, &host_env);
+		if (IS_ERR(session)) {
+			err = PTR_ERR(session);
+			goto err_out;
+		}
 		atomic_set(&event_count, 0);
 		gettimeofday(&start, NULL);
 		err = __machine__synthesize_threads(&session->machines.host,
@@ -173,10 +181,8 @@ static int do_run_multi_threaded(struct target *target,
 						process_synthesized_event,
 						true, false,
 						nr_threads_synthesize);
-		if (err) {
-			perf_session__delete(session);
-			return err;
-		}
+		if (err)
+			goto err_out;
 
 		gettimeofday(&end, NULL);
 		timersub(&end, &start, &diff);
@@ -198,7 +204,9 @@ static int do_run_multi_threaded(struct target *target,
 
 	printf("    Average time per event %.3f usec\n",
 		time_average / event_average);
-	return 0;
+err_out:
+	perf_env__exit(&host_env);
+	return err;
 }
 
 static int run_multi_threaded(void)
-- 
2.50.0.727.gbf7dc18ff4-goog

