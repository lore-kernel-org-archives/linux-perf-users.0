Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBE520C026
	for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748328148; cv=none; b=lYaY59Noq5cuK4sOrCvCpXuK1PBt6q3HQ1A1CklRDP3WbJfTzvoaUmtp76TrH8yks612m9VBNdhKoBdbwzHRPoSTGfgJTT+2ewuEm0Vp9w65/ZSB4ODmYDtX/Ba2+UEE7mpoWxkDBHcZowiji3NHWOGdemliYf55JjnbKKTp2Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748328148; c=relaxed/simple;
	bh=yzNjmX59kG3whaHqOQeIyuVjWBTgpcE+Yqv8MqV6DW4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=OxwRuUaZ/cLSKn0SE9YKCQHvV8TViOaUYKHLpr2fzBIw1s/jrEbdS3fxSI6pjvyXk2PPFaWkFV5Tu51IR2NrZOe43UYk5trLBpSE/SQhoPF75vzk85DBQZKTBMV2hJy3cit8BuABjzRJCMUK3VJYSlnit8Q/RdDo+pkIQDh+WlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QHjOhigz; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QHjOhigz"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7429f7f9ee3so2091242b3a.2
        for <linux-perf-users@vger.kernel.org>; Mon, 26 May 2025 23:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748328146; x=1748932946; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9243hlKBPdeZ1Gi9lTPRhe1+dSif74gAofzJyXdpiIE=;
        b=QHjOhigzIpkUOsnfBD84ZkeOtMWjFns4xmzlp+oUmNVxEj9HeFSgZo/yV5CjnzP6JT
         bp3aUPWbcGpSODOfo8fnnSUKf8M0zboTcBBu6VNIQeaAX/cfcPX/jeImBn4eyTU9Kj1e
         YrkCHmE8Nm67Z1058NSz7rdKZtXUL9wspi7ZqiFKQH3d9TmW0m1UjehsGfNaDPJzgxab
         lp0iHOg33VSZVObtnbHKVbdwRrREl8fK3LUjxt2uLXg7VzJ8R9UE1DDDEJWQofm9WQ0H
         y45pHpLEiE8eIduywGg+t8TXxW8iixfEXe/J49gTAubB/lfwUZZyaMuZYS2byk45KpdR
         ymXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748328146; x=1748932946;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9243hlKBPdeZ1Gi9lTPRhe1+dSif74gAofzJyXdpiIE=;
        b=Xw+DKC0sonOk6whpb4aYbyM1ISZGJQ1xilrWAS0XdZfDAeCQk8OcK9HTRO8XAlC2Ib
         MIt9eyE2ygpWZbZBhnL5rUlLQsf0qrbY/o2Pp6zEepSBEnYxeLObXRCRhWVS2/xv28+d
         j3aDyXHLj+s/9yYvpVp4z00S66aAN+nVyfwI1+uCG5jqqBy7BJd1tMLPAy1whaNfDzf+
         OA4J+JlHvoksBn/k8+vceGLOE4Enx3QFmRxoKI3gPp/moyx3M3EyoBhOaweZYwjIPb0i
         wfOSpYKtWraQ3htR7w77l4Wsr4hk6pBluBzymk0vjrXp9N5a0si5IaVB9amNfDcK97pu
         es/Q==
X-Forwarded-Encrypted: i=1; AJvYcCULWD+V77FNQ6it2JtUpx+S9R9X2PLFTKzBGb5ijH0PUEW8xMhCUQn4dhmYfSuPwrJJ0Cw1UduLx7SZWaBIeJpW@vger.kernel.org
X-Gm-Message-State: AOJu0YzlVXV7klUn5EBrqElcR9M5+wZwOqPTE10tQkFdfOpjiTEtrkTX
	dErzn+sRykB9SAJPfHRk1+7GU+GqOsMWPKNrCNoldEiHEVDyLWqbE9+FupWuNivLkryI6XA9153
	fPM5hM/SmyA==
X-Google-Smtp-Source: AGHT+IFSaCGMgzGcQR5sH0WwCDihQ6b4O7L/EdB23UzxzbsOhbA+EnKf4bgJh66renmbJCUXk6BdAwgRNDxo
X-Received: from pfbjc32.prod.google.com ([2002:a05:6a00:6ca0:b0:736:b315:f15e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4646:b0:742:ae7e:7da8
 with SMTP id d2e1a72fcca58-745fdfcc5e9mr17415149b3a.8.1748328145586; Mon, 26
 May 2025 23:42:25 -0700 (PDT)
Date: Mon, 26 May 2025 23:41:52 -0700
In-Reply-To: <20250527064153.149939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250527064153.149939-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250527064153.149939-11-irogers@google.com>
Subject: [PATCH v1 10/11] perf auxtrace: Pass perf_env from session through to
 mmap read
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

 auxtrace_mmap__read and auxtrace_mmap__read_snapshot end up calling
 `evsel__env(NULL)` which returns the global perf_env variable for the
 host. Their only call is in perf record. Rather than use the global
 variable pass through the perf_env for `perf record`.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c |  8 ++++++--
 tools/perf/util/auxtrace.c  | 13 +++++++------
 tools/perf/util/auxtrace.h  |  6 ++++--
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 406b2166a3e9..3f5b9add43d5 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -773,7 +773,9 @@ static int record__auxtrace_mmap_read(struct record *rec,
 {
 	int ret;
 
-	ret = auxtrace_mmap__read(map, rec->itr, &rec->tool,
+	ret = auxtrace_mmap__read(map, rec->itr,
+				  perf_session__env(rec->session),
+				  &rec->tool,
 				  record__process_auxtrace);
 	if (ret < 0)
 		return ret;
@@ -789,7 +791,9 @@ static int record__auxtrace_mmap_read_snapshot(struct record *rec,
 {
 	int ret;
 
-	ret = auxtrace_mmap__read_snapshot(map, rec->itr, &rec->tool,
+	ret = auxtrace_mmap__read_snapshot(map, rec->itr,
+					   perf_session__env(rec->session),
+					   &rec->tool,
 					   record__process_auxtrace,
 					   rec->opts.auxtrace_snapshot_size);
 	if (ret < 0)
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 03211c2623de..ebd32f1b8f12 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1890,7 +1890,7 @@ int __weak compat_auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
 }
 
 static int __auxtrace_mmap__read(struct mmap *map,
-				 struct auxtrace_record *itr,
+				 struct auxtrace_record *itr, struct perf_env *env,
 				 const struct perf_tool *tool, process_auxtrace_t fn,
 				 bool snapshot, size_t snapshot_size)
 {
@@ -1900,7 +1900,7 @@ static int __auxtrace_mmap__read(struct mmap *map,
 	size_t size, head_off, old_off, len1, len2, padding;
 	union perf_event ev;
 	void *data1, *data2;
-	int kernel_is_64_bit = perf_env__kernel_is_64_bit(evsel__env(NULL));
+	int kernel_is_64_bit = perf_env__kernel_is_64_bit(env);
 
 	head = auxtrace_mmap__read_head(mm, kernel_is_64_bit);
 
@@ -2002,17 +2002,18 @@ static int __auxtrace_mmap__read(struct mmap *map,
 }
 
 int auxtrace_mmap__read(struct mmap *map, struct auxtrace_record *itr,
-			const struct perf_tool *tool, process_auxtrace_t fn)
+			struct perf_env *env, const struct perf_tool *tool,
+			process_auxtrace_t fn)
 {
-	return __auxtrace_mmap__read(map, itr, tool, fn, false, 0);
+	return __auxtrace_mmap__read(map, itr, env, tool, fn, false, 0);
 }
 
 int auxtrace_mmap__read_snapshot(struct mmap *map,
-				 struct auxtrace_record *itr,
+				 struct auxtrace_record *itr, struct perf_env *env,
 				 const struct perf_tool *tool, process_auxtrace_t fn,
 				 size_t snapshot_size)
 {
-	return __auxtrace_mmap__read(map, itr, tool, fn, true, snapshot_size);
+	return __auxtrace_mmap__read(map, itr, env, tool, fn, true, snapshot_size);
 }
 
 /**
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index b0db84d27b25..f001cbb68f8e 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -23,6 +23,7 @@ union perf_event;
 struct perf_session;
 struct evlist;
 struct evsel;
+struct perf_env;
 struct perf_tool;
 struct mmap;
 struct perf_sample;
@@ -512,10 +513,11 @@ typedef int (*process_auxtrace_t)(const struct perf_tool *tool,
 				  size_t len1, void *data2, size_t len2);
 
 int auxtrace_mmap__read(struct mmap *map, struct auxtrace_record *itr,
-			const struct perf_tool *tool, process_auxtrace_t fn);
+			struct perf_env *env, const struct perf_tool *tool,
+			process_auxtrace_t fn);
 
 int auxtrace_mmap__read_snapshot(struct mmap *map,
-				 struct auxtrace_record *itr,
+				 struct auxtrace_record *itr, struct perf_env *env,
 				 const struct perf_tool *tool, process_auxtrace_t fn,
 				 size_t snapshot_size);
 
-- 
2.49.0.1151.ga128411c76-goog

