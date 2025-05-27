Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2832080C4
	for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 06:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748328145; cv=none; b=PhyQVyA+sUhxJlkGVVVYMaDRt2FQzSxjdaphgx97MlFQT/L7ET2NSKECdt3JygfVhNwcbiKQgYrLGNwCmY2kDfbQHfvyEhhRPQ/evlA2prrQ+nW1yriHkQMFbxRIqVxxo753Wrhdze+ZRLb5pe0gTPE65CimTYj2buv10LQQefg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748328145; c=relaxed/simple;
	bh=PoSIx3oY0LJ9QKqM6N4DaxmQDep27IcY3SKWoO04ZlA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=BS5mdnBi2uTKK8uAJjC6y6RdJVVm5jEOfUk9yDr1YfrjZkpOvCgiapOTQDSdMbimUTdIZ2XWxHJdhm5guu79A72qLEVrArn1e5smpPyQ6NRVdYTlJUpF/i7TjFp7zF0WXIlYClpauvdHABbVnGl47+gfaKlz5aGpaach7kgEuG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nGdaCCw4; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nGdaCCw4"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e7d92c6ebbeso2976460276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 May 2025 23:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748328141; x=1748932941; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XNsWVbZHKMTH+JLxsWG7Haie8oSBX2sugIIaYnA3oGo=;
        b=nGdaCCw4uUF6G7wBksMy6I6vdaq3Y3Fav4f0GsU6Jm3qi4JWFl3y6XkmGNNpfUxP8N
         9xbospaa+847ee6Z+3i3rvXgUuYrSwN7JXgTQrKLABX9JqSpJyXeTd2R1uZM3WMf6X9n
         R4cg2nXxD3uNSqg5CDdGWTltr9LUDvlqSnCiRxcOMpwbWS9dFvp1hNs2SZ0EglkwpyVn
         3Z2Lmm3mRIGzOgWtfb4vU3TgJF9YcG0xmbVaOi5ibDz7rVk23is4fJiOvQS/J7x0Q0PA
         VGpkWEKz5wRP3kT+C72R1nUE6BvQXi+8WcITpg8ahJ91nlKGVfa35jmfW3hywmI4h3PV
         Wvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748328141; x=1748932941;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XNsWVbZHKMTH+JLxsWG7Haie8oSBX2sugIIaYnA3oGo=;
        b=DEv2FUzajdixA1L9/NNYbn7mQNRlX5wkDLiM73RV4nTDk4JeOemW12EeS4yhgkLw6G
         OeDmZNnUEw2G/vm4r+CG9gFpQn3s7yqwWfkk4Gpj1AP/sraRI4o4nXTsgtZYEwsyqpje
         EpKXrFbMx7rIXWPgEeaxvwcFNzUtrpLBBvs8ZaI/zWD7cQA4tAmJ0u5ZjanUnAhFoJvd
         JjQu1yhxu8PHNQk+9TYiryafws8rivG7VObJBNYVOcX0txIj3fIWKF+ZVfCjAftQIm0v
         aM71MKB5F+JtvIMp96KsOd7gT916hD2D9qRUKgi0H7G2QhopAsUUfXI/EMR1wU7U7Fnd
         AIUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQeHEF6zeLPop9srZq3P37WkBV3s3vK8IQIKAK0AHhjv1yRShJopGSD0JavhFhFjuhkUFIo5bB1ezUAbg6u3QW@vger.kernel.org
X-Gm-Message-State: AOJu0YwoEeiQ0dk14h1X1o+XrWi5gBPR+Xi2ODzvc5nz0zhc6O2+5fGj
	hbXBWejbtBCz8vcGVNID24lfrwekI/d6qFynAfUtgcpN35JlSVY4KWECEcwQa8RdP8OuUQ8V/0e
	UBhFEujdaPg==
X-Google-Smtp-Source: AGHT+IHfYe4oI4XOwek2vvEbiP89zehdPT5a0EmY7OUCuHhLrrjgpYB6bXn3UfQb9gmsOs6Ovv3aB3zUDwc2
X-Received: from ybbgy9.prod.google.com ([2002:a05:6902:4489:b0:e7d:c5dd:c1d5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:310f:b0:e7d:5f06:91ff
 with SMTP id 3f1490d57ef6-e7d9189aa34mr11597728276.8.1748328141648; Mon, 26
 May 2025 23:42:21 -0700 (PDT)
Date: Mon, 26 May 2025 23:41:50 -0700
In-Reply-To: <20250527064153.149939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250527064153.149939-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250527064153.149939-9-irogers@google.com>
Subject: [PATCH v1 08/11] perf bench synthesize: Avoid use of global perf_env
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
2.49.0.1151.ga128411c76-goog

