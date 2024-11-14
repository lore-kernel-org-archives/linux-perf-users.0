Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9860A175D5D
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600479; cv=none; b=IVeTlNwleE8polnz9J9891/Y9pSih0D8d6qjyoBWva+W0HVVbiP5FTQEoWFvbSUczUCTk7iB5hKZzzj+z/PeEuyIR3DXjtZ/p1H0dzFhWSz1mLwMZr69B5HdD174AB621zPdmo2wJdeQY1TrWmYQy7Lol2BHaHMubzBqr2Zaklw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600479; c=relaxed/simple;
	bh=vox/7I9HXy64CSs6t4vNkMQC1vHy0/BtTjz+mYyu0w4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CTzSChkHhZHSENjTIC+TdDG7cfsUISQPDc4eg6EyJQEIdYnPiLk53u+dqUg0skPqnBY105eslFBW3Jm+ss6zk20ecxqG6v1YAqyaJ2Dyep1618ibmYGd07Iw/oXCSGVjubokbo9PfoIJUwc6dZjiFFKy2FJZP4qpeFguasr1GsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zXBqGA9Q; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zXBqGA9Q"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso111115166b.3
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 08:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731600476; x=1732205276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZIDmacdaeoxrMctjHNzYY2IWDwMQUUPmHl/BySCTPM=;
        b=zXBqGA9QOJLZrUX7PKLi9Zt/3fDXdf+MaXH5ZzAa8X+8GbmUmW9SOzmI6PK5p2Kl/O
         NOqOw6Cz2DPsIzQKwn9V1Z6G/jGGfkVibxNWv9YSeOQq+4vUCk0thY5GcZLme9OG5ajs
         go2NMRW+8NCVI5o/3LYSGxSfmBk6TcMD8TjRPGp2R7NEthwj20uhx304n7cpHxa8LBrS
         DsnD54uH37mDwwtoejq4ejkOEKbqyARmiv26aB/wpgeFN0SI6VYsIx9wdFL7UKHoSZ6D
         5XGUd2U4j46PRHXNmtcahI2X/o+L10ySN7h2W97NIQhgZfK8t7zZkltOre9Dq7cypvau
         GR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731600476; x=1732205276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZIDmacdaeoxrMctjHNzYY2IWDwMQUUPmHl/BySCTPM=;
        b=XwLNXA5+t6YwWmfTGJfQBR2vgYKMCoyMlzpcRPIAKtJHrDcY5H63knWI3R0i491u6+
         +al6oAUiQsrmxxrpl3C8rMgSd5r5kPEAvraUUHdk1xBe2/Xevkk9O/EcuKCZKlmgasd3
         DLDHBOU4lcPZ6b108MIGxi9IFfk1hO0BuH1DKR94PeSdZbw5szM80CbRQGubRqk+LOK4
         jo/XWWeh5FAyrXuar9LzxMwk65Ab+c/ScC9e/gja58Wx9lfethEAI0ElVaGwiKAg/9/B
         EQaM3siQOfAw/v6lz9J6YGFI6Y7MfGPLwWfm/cBLQBr+SUaAXf1jdNRC/9DWZpyUBqqm
         WvVg==
X-Gm-Message-State: AOJu0Yyl1nQfLTfmjgBN1q1i3vr3kgLWKJl792UHao+kuUdsOTM8lX4/
	wI0Xc/GDxx/DvpQaNJr6IR+bdIWvS10uRwkRIRJHBjjDuoFJ/CytnMhQ47nxW4jMbhLIsSL8Jmb
	wWLc=
X-Google-Smtp-Source: AGHT+IEf9e1HGnaMlTOrKHVcGTf+ARYIkun1J3c+M5cnt+i+oOvgSy7pGBonSAWnf2OYE1vCdHAj9Q==
X-Received: by 2002:a17:907:9302:b0:a9a:3f9d:62f8 with SMTP id a640c23a62f3a-aa1f805d27bmr731019566b.19.1731600475958;
        Thu, 14 Nov 2024 08:07:55 -0800 (PST)
Received: from pop-os.. ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e046d76sm77456366b.165.2024.11.14.08.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:07:54 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	thomas.falcon@intel.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] libperf: evlist: Keep evsel idx contiguous on removal
Date: Thu, 14 Nov 2024 16:04:49 +0000
Message-Id: <20241114160450.295844-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114160450.295844-1-james.clark@linaro.org>
References: <20241114160450.295844-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only two places where evsels are removed end up fixing up the index.
Move it into libperf so that it's always done.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/lib/perf/evlist.c            | 17 +++++++------
 tools/lib/perf/tests/test-evlist.c | 41 ++++++++++++++++++++++++++++++
 tools/perf/builtin-record.c        | 18 +++----------
 3 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 83c43dc13313..ffa1a28fb14f 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -52,15 +52,8 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 		 * Empty cpu lists would eventually get opened as "any" so remove
 		 * genuinely empty ones before they're opened in the wrong place.
 		 */
-		if (perf_cpu_map__is_empty(evsel->cpus)) {
-			struct perf_evsel *next = perf_evlist__next(evlist, evsel);
-
+		if (perf_cpu_map__is_empty(evsel->cpus))
 			perf_evlist__remove(evlist, evsel);
-			/* Keep idx contiguous */
-			if (next)
-				list_for_each_entry_from(next, &evlist->entries, node)
-					next->idx--;
-		}
 	} else if (!evsel->own_cpus || evlist->has_user_cpus ||
 		(!evsel->requires_cpu && perf_cpu_map__has_any_cpu(evlist->user_requested_cpus))) {
 		/*
@@ -116,8 +109,16 @@ void perf_evlist__add(struct perf_evlist *evlist,
 void perf_evlist__remove(struct perf_evlist *evlist,
 			 struct perf_evsel *evsel)
 {
+	struct perf_evsel *next = perf_evlist__next(evlist, evsel);
+
 	list_del_init(&evsel->node);
 	evlist->nr_entries -= 1;
+
+	/* Keep idx contiguous */
+	if (!next)
+		return;
+	list_for_each_entry_from(next, &evlist->entries, node)
+		next->idx--;
 }
 
 struct perf_evlist *perf_evlist__new(void)
diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index 10f70cb41ff1..06153820f408 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -571,6 +571,46 @@ static int test_stat_multiplexing(void)
 	return 0;
 }
 
+static int test_list_remove(void)
+{
+	struct perf_evlist *evlist;
+	struct perf_evsel *evsel, *evsel0, *evsel1, *evsel2;
+	struct perf_event_attr attr = {};
+	int idx = 0;
+
+	evlist = perf_evlist__new();
+	__T("failed to create evlist", evlist);
+
+	evsel0 = perf_evsel__new(&attr);
+	__T("failed to create evsel", evsel0);
+	evsel1 = perf_evsel__new(&attr);
+	__T("failed to create evsel", evsel1);
+	evsel2 = perf_evsel__new(&attr);
+	__T("failed to create evsel", evsel2);
+
+	perf_evlist__add(evlist, evsel0);
+	perf_evlist__add(evlist, evsel1);
+	perf_evlist__add(evlist, evsel2);
+
+	idx = 0;
+	perf_evlist__for_each_evsel(evlist, evsel)
+		__T("idx isn't contiguous", evsel->idx == idx++);
+
+	/* Test removing middle */
+	perf_evlist__remove(evlist, evsel1);
+	idx = 0;
+	perf_evlist__for_each_evsel(evlist, evsel)
+		__T("idx isn't contiguous", evsel->idx == idx++);
+
+	/* Test removing end */
+	perf_evlist__remove(evlist, evsel2);
+	idx = 0;
+	perf_evlist__for_each_evsel(evlist, evsel)
+		__T("idx isn't contiguous", evsel->idx == idx++);
+
+	return 0;
+}
+
 int test_evlist(int argc, char **argv)
 {
 	__T_START;
@@ -583,6 +623,7 @@ int test_evlist(int argc, char **argv)
 	test_mmap_thread();
 	test_mmap_cpus();
 	test_stat_multiplexing();
+	test_list_remove();
 
 	__T_END;
 	return tests_failed == 0 ? 0 : -1;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7e99743f7e42..2ebbb0fd0064 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1359,14 +1359,13 @@ static int record__mmap(struct record *rec)
 static int record__open(struct record *rec)
 {
 	char msg[BUFSIZ];
-	struct evsel *pos;
+	struct evsel *pos, *tmp;
 	struct evlist *evlist = rec->evlist;
 	struct perf_session *session = rec->session;
 	struct record_opts *opts = &rec->opts;
 	int rc = 0;
-	bool skipped = false;
 
-	evlist__for_each_entry(evlist, pos) {
+	evlist__for_each_entry_safe(evlist, tmp, pos) {
 try_again:
 		if (evsel__open(pos, pos->core.cpus, pos->core.threads) < 0) {
 			if (evsel__fallback(pos, &opts->target, errno, msg, sizeof(msg))) {
@@ -1383,23 +1382,12 @@ static int record__open(struct record *rec)
 			evsel__open_strerror(pos, &opts->target, errno, msg, sizeof(msg));
 			ui__error("Failure to open event '%s' on PMU '%s' which will be removed.\n%s\n",
 				  evsel__name(pos), evsel__pmu_name(pos), msg);
-			pos->skippable = true;
-			skipped = true;
+			evlist__remove(evlist, pos);
 		} else {
 			pos->supported = true;
 		}
 	}
 
-	if (skipped) {
-		struct evsel *tmp;
-		int idx = 0;
-
-		evlist__for_each_entry_safe(evlist, tmp, pos) {
-			if (pos->skippable)
-				evlist__remove(evlist, pos);
-			pos->core.idx = idx++;
-		}
-	}
 	if (symbol_conf.kptr_restrict && !evlist__exclude_kernel(evlist)) {
 		pr_warning(
 "WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,\n"
-- 
2.34.1

