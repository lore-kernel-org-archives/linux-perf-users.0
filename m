Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E042253B2
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 18:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531951; cv=none; b=Uw5CY2zsucz2C1GPH9IMKU4ap2Hgr32KFRUTWb6Qn+fnevzb79L8tJmOHc8TnxtDoQz6Uc/yrAEiLf1+l8F1u/VbdwHoSU/2Y3YW21asxGx9M/h84muXFu2phmCmf+pEiP8+4qf6vaxBn1QZT+g1Jcc2KtWza1yI8SVNWY7ebyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531951; c=relaxed/simple;
	bh=GsrS8qeXzKP0b1swozMr7frMzZ7NnLPbjichf6bGlrk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=W7ZBKn1JXxFYimeVufIwAFz9sBYtBdD1Jwt3sQ4oiQRpcL34Qtc8hyUtd+c9Z/GjOqSM/UHHtXwj92MaKkIpI2zPlyFUu2wHKJbvRJQPQsB4r1qAeB1ENjwvTdcA1Ex+bk+8v1wWJEV3C4IZIAnCkHz3r3JOiTBiScQTsWARpNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eaB/Rxma; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eaB/Rxma"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-227ed471999so94010435ad.3
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 11:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531949; x=1744136749; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vDLj0IQP1yVrki1oH90jQ2DyuMuIrwQsIyowp6t+/y4=;
        b=eaB/RxmagxqkxnhxUBQTkgXMNOdh7bKC4wtSZhAD/jxSy48KOYMux1gbnPjzIlEEBT
         5MNjfXKE2v/GL66QzVHeyB8a0SdJ8r+xMHXGT0XkbtCBhEe+xr6lSGNlOCSOClJWujpC
         1QJ1wifpG/8Ko9Kkom4+F6c1fWvs3KGYIz9f75SLJt+2dXlk9dovdKAVD+JtogWkP9t8
         wE4ElA4IOrziseEz0kjX3ylpxYpuPk5fp/TQwnUSB9s4yaU/NZhTXCAo0Ry+4ygfxpey
         uvore3CIkfzc9D+IGRQPHYLKWdvWmNPEFKPqagiI6D4B03N36o3505+iz5Lw37LLzgkg
         gI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531949; x=1744136749;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vDLj0IQP1yVrki1oH90jQ2DyuMuIrwQsIyowp6t+/y4=;
        b=JAo4xWdA3M6GUHdaI2l3XPsw4meBfghj7BeeXBJuNyThAXvVztEIL/0X6pUI2aemqy
         Z61hxsYO6vyP9DiWmhz5I6FgdwqZIHNI3vMtvfAAS2G9DwTPmnZOV6BrZvqvBe7/zIQo
         R4K+wsTK1xCCtsu2vw2DtF2iu9BCr3g3oUbIiw7GuyWVyHMVqAx+cSA8S34Wj1h07mn6
         Y4tHlbvMWkUEosxw+zfYjtvkvF+fLO1NkOrkM8WaxfjmO60dSlSnyWDOmP3gp9hsyqw6
         63pkvO97Q7kQCg5hrsi3U57u4GWhO89UtzM/Tm6/aGdOpdgJvxLrjzyvT6eAJoXK1MKg
         3yMw==
X-Forwarded-Encrypted: i=1; AJvYcCXiUjAXG+Du23mbgelEW3YKuX9eVW+dZjNDq1MM17sLfFRGbAuLK0W9Q0gDU4f5eSV9HcW2FxVGx3e0CzjbjWtw@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo3HqmwVM3OuplPgAZcFG5Ju0FoELv9fLiLvaQ5OsbMqDnVXGf
	r8QFZo5bmLjg0VBMRxrjAI+GyklyWoxFrLvvU0hO90kw9kjxKtggOFhG72/dnyBGx3UOjpDU9Rj
	2LG8v0A==
X-Google-Smtp-Source: AGHT+IEZJuX4TsFr7l6BizC2eFmbDLvOe6bGybp18hF5q6m28rSw2y+Y5UI0Uvd4tqhCEc8kI2jIBn3sitnR
X-Received: from plrf10.prod.google.com ([2002:a17:902:ab8a:b0:21f:56e1:c515])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef44:b0:223:66bb:8995
 with SMTP id d9443c01a7336-2295be94340mr55875045ad.20.1743531949041; Tue, 01
 Apr 2025 11:25:49 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:34 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-37-irogers@google.com>
Subject: [PATCH v1 36/48] perf record: Silence -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>, 
	Ben Gainey <ben.gainey@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	Eder Zulian <ezulian@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>, 
	Dirk Gouders <dirk@gouders.net>, Brian Geffon <bgeffon@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Howard Chu <howardchu95@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jann Horn <jannh@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Yang Jihong <yangjihong@bytedance.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Hao Ge <gehao@kylinos.cn>, Tengda Wu <wutengda@huaweicloud.com>, 
	Gabriele Monaco <gmonaco@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Casey Chen <cachen@purestorage.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The clang warning -Wshorten-64-to-32 can be useful to catch
inadvertent truncation. In some instances this truncation can lead to
changing the sign of a result, for example, truncation to return an
int to fit a sort routine. Silence the warning by making the implicit
truncation explicit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c   | 66 ++++++++++++++++++-----------------
 tools/perf/builtin-top.c      |  4 +--
 tools/perf/util/auxtrace.c    |  8 ++---
 tools/perf/util/bpf-filter.c  | 20 +++++------
 tools/perf/util/bpf_off_cpu.c |  4 +--
 tools/perf/util/mmap.c        |  6 ++--
 6 files changed, 55 insertions(+), 53 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ba20bf7c011d..e524b9cae531 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -443,7 +443,7 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
 
 	aio->size += size;
 
-	return size;
+	return (int)size;
 }
 
 static int record__aio_push(struct record *rec, struct mmap *map, off_t *off)
@@ -523,7 +523,7 @@ static int record__aio_parse(const struct option *opt,
 		opts->nr_cblocks = 0;
 	} else {
 		if (str)
-			opts->nr_cblocks = strtol(str, NULL, 0);
+			opts->nr_cblocks = (int)strtol(str, NULL, 0);
 		if (!opts->nr_cblocks)
 			opts->nr_cblocks = nr_cblocks_default;
 	}
@@ -577,15 +577,15 @@ static int record__mmap_flush_parse(const struct option *opt,
 		return 0;
 
 	if (str) {
-		opts->mmap_flush = parse_tag_value(str, tags);
+		opts->mmap_flush = (int)parse_tag_value(str, tags);
 		if (opts->mmap_flush == (int)-1)
-			opts->mmap_flush = strtol(str, NULL, 0);
+			opts->mmap_flush = (int)strtol(str, NULL, 0);
 	}
 
 	if (!opts->mmap_flush)
 		opts->mmap_flush = MMAP_FLUSH_DEFAULT;
 
-	flush_max = evlist__mmap_size(opts->mmap_pages);
+	flush_max = (int)evlist__mmap_size(opts->mmap_pages);
 	flush_max /= 4;
 	if (opts->mmap_flush > flush_max)
 		opts->mmap_flush = flush_max;
@@ -604,7 +604,7 @@ static int record__parse_comp_level(const struct option *opt, const char *str, i
 		opts->comp_level = 0;
 	} else {
 		if (str)
-			opts->comp_level = strtol(str, NULL, 0);
+			opts->comp_level = (unsigned int)strtol(str, NULL, 0);
 		if (!opts->comp_level)
 			opts->comp_level = comp_level_default;
 	}
@@ -1080,11 +1080,12 @@ static int record__thread_data_init_maps(struct record_thread *thread_data, stru
 	struct perf_cpu_map *cpus = evlist->core.all_cpus;
 	bool per_thread = evlist__per_thread(evlist);
 
-	if (per_thread)
+	if (per_thread) {
 		thread_data->nr_mmaps = nr_mmaps;
-	else
-		thread_data->nr_mmaps = bitmap_weight(thread_data->mask->maps.bits,
-						      thread_data->mask->maps.nbits);
+	} else {
+		thread_data->nr_mmaps = (int)bitmap_weight(thread_data->mask->maps.bits,
+						(unsigned int)thread_data->mask->maps.nbits);
+	}
 	if (mmap) {
 		thread_data->maps = zalloc(thread_data->nr_mmaps * sizeof(struct mmap *));
 		if (!thread_data->maps)
@@ -1519,10 +1520,11 @@ static void record__adjust_affinity(struct record *rec, struct mmap *map)
 {
 	if (rec->opts.affinity != PERF_AFFINITY_SYS &&
 	    !bitmap_equal(thread->mask->affinity.bits, map->affinity_mask.bits,
-			  thread->mask->affinity.nbits)) {
-		bitmap_zero(thread->mask->affinity.bits, thread->mask->affinity.nbits);
+			 (unsigned int)thread->mask->affinity.nbits)) {
+		bitmap_zero(thread->mask->affinity.bits,
+			    (unsigned int)thread->mask->affinity.nbits);
 		bitmap_or(thread->mask->affinity.bits, thread->mask->affinity.bits,
-			  map->affinity_mask.bits, thread->mask->affinity.nbits);
+			  map->affinity_mask.bits, (unsigned int)thread->mask->affinity.nbits);
 		sched_setaffinity(0, MMAP_CPU_MASK_BYTES(&thread->mask->affinity),
 					(cpu_set_t *)thread->mask->affinity.bits);
 		if (verbose == 2) {
@@ -1688,7 +1690,7 @@ static void *record__thread(void *arg)
 	thread = arg;
 	thread->tid = gettid();
 
-	err = write(thread->pipes.ack[1], &msg, sizeof(msg));
+	err = (int)write(thread->pipes.ack[1], &msg, sizeof(msg));
 	if (err == -1)
 		pr_warning("threads[%d]: failed to notify on start: %s\n",
 			   thread->tid, strerror(errno));
@@ -1732,7 +1734,7 @@ static void *record__thread(void *arg)
 	}
 	record__mmap_read_all(thread->rec, true);
 
-	err = write(thread->pipes.ack[1], &msg, sizeof(msg));
+	err = (int)write(thread->pipes.ack[1], &msg, sizeof(msg));
 	if (err == -1)
 		pr_warning("threads[%d]: failed to notify on termination: %s\n",
 			   thread->tid, strerror(errno));
@@ -1958,8 +1960,8 @@ static void record__read_lost_samples(struct record *rec)
 			continue;
 		}
 
-		for (int x = 0; x < xyarray__max_x(xy); x++) {
-			for (int y = 0; y < xyarray__max_y(xy); y++) {
+		for (int x = 0; x < (int)xyarray__max_x(xy); x++) {
+			for (int y = 0; y < (int)xyarray__max_y(xy); y++) {
 				struct perf_counts_values count;
 
 				if (perf_evsel__read(&evsel->core, x, y, &count) < 0) {
@@ -2246,7 +2248,7 @@ static int record__terminate_thread(struct record_thread *thread_data)
 
 	close(thread_data->pipes.msg[1]);
 	thread_data->pipes.msg[1] = -1;
-	err = read(thread_data->pipes.ack[0], &ack, sizeof(ack));
+	err = (int)read(thread_data->pipes.ack[0], &ack, sizeof(ack));
 	if (err > 0)
 		pr_debug2("threads[%d]: sent %s\n", tid, thread_msg_tags[ack]);
 	else
@@ -2294,7 +2296,7 @@ static int record__start_threads(struct record *rec)
 			goto out_err;
 		}
 
-		err = read(thread_data[t].pipes.ack[0], &msg, sizeof(msg));
+		err = (int)read(thread_data[t].pipes.ack[0], &msg, sizeof(msg));
 		if (err > 0)
 			pr_debug2("threads[%d]: sent %s\n", rec->thread_data[t].tid,
 				  thread_msg_tags[msg]);
@@ -2409,7 +2411,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	session = perf_session__new(data, tool);
 	if (IS_ERR(session)) {
 		pr_err("Perf session creation failed.\n");
-		return PTR_ERR(session);
+		return (int)PTR_ERR(session);
 	}
 
 	if (record__threads_enabled(rec)) {
@@ -2495,7 +2497,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 	/* Debug message used by test scripts */
 	pr_debug3("perf record done opening and mmapping events\n");
-	session->header.env.comp_mmap_len = session->evlist->core.mmap_len;
+	session->header.env.comp_mmap_len = (u32)session->evlist->core.mmap_len;
 
 	if (rec->opts.kcore) {
 		err = record__kcore_copy(&session->machines.host, data);
@@ -2713,7 +2715,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 			/* re-arm the alarm */
 			if (rec->switch_output.time)
-				alarm(rec->switch_output.time);
+				alarm((unsigned int)rec->switch_output.time);
 		}
 
 		if (hits == thread->samples) {
@@ -2976,7 +2978,7 @@ static int perf_record_config(const char *var, const char *value, void *cb)
 	}
 #ifdef HAVE_AIO_SUPPORT
 	if (!strcmp(var, "record.aio")) {
-		rec->opts.nr_cblocks = strtol(value, NULL, 0);
+		rec->opts.nr_cblocks = (int)strtol(value, NULL, 0);
 		if (!rec->opts.nr_cblocks)
 			rec->opts.nr_cblocks = nr_cblocks_default;
 	}
@@ -3016,7 +3018,7 @@ static int record__parse_affinity(const struct option *opt, const char *str, int
 static int record__mmap_cpu_mask_alloc(struct mmap_cpu_mask *mask, int nr_bits)
 {
 	mask->nbits = nr_bits;
-	mask->bits = bitmap_zalloc(mask->nbits);
+	mask->bits = bitmap_zalloc((int)mask->nbits);
 	if (!mask->bits)
 		return -ENOMEM;
 
@@ -3604,7 +3606,7 @@ static int record__mmap_cpu_mask_init_spec(struct mmap_cpu_mask *mask, const cha
 	if (!cpus)
 		return -ENOMEM;
 
-	bitmap_zero(mask->bits, mask->nbits);
+	bitmap_zero(mask->bits, (unsigned int)mask->nbits);
 	if (record__mmap_cpu_mask_init(mask, cpus))
 		return -ENODEV;
 
@@ -3722,13 +3724,13 @@ static int record__init_thread_masks_spec(struct record *rec, struct perf_cpu_ma
 
 		/* ignore invalid CPUs but do not allow empty masks */
 		if (!bitmap_and(thread_mask.maps.bits, thread_mask.maps.bits,
-				cpus_mask.bits, thread_mask.maps.nbits)) {
+				cpus_mask.bits, (unsigned int)thread_mask.maps.nbits)) {
 			pr_err("Empty maps mask: %s\n", maps_spec[s]);
 			ret = -EINVAL;
 			goto out_free;
 		}
 		if (!bitmap_and(thread_mask.affinity.bits, thread_mask.affinity.bits,
-				cpus_mask.bits, thread_mask.affinity.nbits)) {
+				cpus_mask.bits, (unsigned int)thread_mask.affinity.nbits)) {
 			pr_err("Empty affinity mask: %s\n", affinity_spec[s]);
 			ret = -EINVAL;
 			goto out_free;
@@ -3736,22 +3738,22 @@ static int record__init_thread_masks_spec(struct record *rec, struct perf_cpu_ma
 
 		/* do not allow intersection with other masks (full_mask) */
 		if (bitmap_intersects(thread_mask.maps.bits, full_mask.maps.bits,
-				      thread_mask.maps.nbits)) {
+				      (unsigned int)thread_mask.maps.nbits)) {
 			pr_err("Intersecting maps mask: %s\n", maps_spec[s]);
 			ret = -EINVAL;
 			goto out_free;
 		}
 		if (bitmap_intersects(thread_mask.affinity.bits, full_mask.affinity.bits,
-				      thread_mask.affinity.nbits)) {
+				      (unsigned int)thread_mask.affinity.nbits)) {
 			pr_err("Intersecting affinity mask: %s\n", affinity_spec[s]);
 			ret = -EINVAL;
 			goto out_free;
 		}
 
 		bitmap_or(full_mask.maps.bits, full_mask.maps.bits,
-			  thread_mask.maps.bits, full_mask.maps.nbits);
+			  thread_mask.maps.bits, (unsigned int)full_mask.maps.nbits);
 		bitmap_or(full_mask.affinity.bits, full_mask.affinity.bits,
-			  thread_mask.affinity.bits, full_mask.maps.nbits);
+			  thread_mask.affinity.bits, (unsigned int)full_mask.maps.nbits);
 
 		thread_masks = realloc(rec->thread_masks, (t + 1) * sizeof(struct thread_mask));
 		if (!thread_masks) {
@@ -4101,7 +4103,7 @@ int cmd_record(int argc, const char **argv)
 
 	if (rec->switch_output.time) {
 		signal(SIGALRM, alarm_sig_handler);
-		alarm(rec->switch_output.time);
+		alarm((unsigned int)rec->switch_output.time);
 	}
 
 	if (rec->switch_output.num_files) {
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1061f4eebc3f..b5924724fc74 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -375,7 +375,7 @@ static void prompt_integer(int *target, const char *msg)
 			goto out_free;
 		p++;
 	}
-	tmp = strtoul(buf, NULL, 10);
+	tmp = (int)strtoul(buf, NULL, 10);
 	*target = tmp;
 out_free:
 	free(buf);
@@ -1817,7 +1817,7 @@ int cmd_top(int argc, const char **argv)
 
 	top.session = perf_session__new(NULL, NULL);
 	if (IS_ERR(top.session)) {
-		status = PTR_ERR(top.session);
+		status = (int)PTR_ERR(top.session);
 		top.session = NULL;
 		goto out_delete_evlist;
 	}
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 03211c2623de..0caacd38b538 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -780,7 +780,7 @@ int auxtrace_parse_sample_options(struct auxtrace_record *itr,
 		if (evsel__is_group_leader(evsel)) {
 			has_aux_leader = evsel__is_aux_event(evsel);
 		} else if (has_aux_leader) {
-			evsel->core.attr.aux_sample_size = sz;
+			evsel->core.attr.aux_sample_size = (__u32)sz;
 		}
 	}
 no_opt:
@@ -1647,7 +1647,7 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
 			if (isdigit(*p)) {
 				unsigned int val;
 
-				val = strtoul(p, &endptr, 10);
+				val = (unsigned int)strtoul(p, &endptr, 10);
 				p = endptr;
 				if (!val || val > PERF_ITRACE_MAX_CALLCHAIN_SZ)
 					goto out_err;
@@ -1667,7 +1667,7 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
 			if (isdigit(*p)) {
 				unsigned int val;
 
-				val = strtoul(p, &endptr, 10);
+				val = (unsigned int)strtoul(p, &endptr, 10);
 				p = endptr;
 				if (!val ||
 				    val > PERF_ITRACE_MAX_LAST_BRANCH_SZ)
@@ -2300,7 +2300,7 @@ static int parse_sym_idx(char **inp, int *idx)
 		if (endptr == *inp || num > INT_MAX)
 			return -EINVAL;
 		*inp = endptr;
-		*idx = num;
+		*idx = (int)num;
 	}
 
 	return 0;
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index a4fdf6911ec1..7ad4d5e8fa49 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -217,7 +217,7 @@ static int convert_to_tgid(int tid)
 		return -1;
 	}
 
-	tgid = strtol(p + 6, &q, 0);
+	tgid = (int)strtol(p + 6, &q, 0);
 	free(buf);
 	if (*q != '\n')
 		return -1;
@@ -284,7 +284,7 @@ static void destroy_event_hash(u64 event_id)
  */
 static u64 create_event_hash(struct evsel *evsel)
 {
-	int x, y, fd;
+	int fd;
 	u64 the_id = 0, id;
 
 	fd = get_pinned_fd("event_hash");
@@ -293,8 +293,8 @@ static u64 create_event_hash(struct evsel *evsel)
 		return 0;
 	}
 
-	for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
-		for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
+	for (size_t x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
+		for (size_t y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
 			int ret = ioctl(FD(evsel, x, y), PERF_EVENT_IOC_ID, &id);
 
 			if (ret < 0) {
@@ -444,7 +444,7 @@ static int create_idx_hash(struct evsel *evsel, struct perf_bpf_filter_entry *en
 
 int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 {
-	int i, x, y, fd, ret;
+	int i, fd, ret;
 	struct sample_filter_bpf *skel = NULL;
 	struct bpf_program *prog;
 	struct bpf_link *link;
@@ -485,8 +485,8 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 			goto err;
 		}
 
-		for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
-			for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
+		for (size_t x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
+			for (size_t y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
 				ret = ioctl(FD(evsel, x, y), PERF_EVENT_IOC_SET_BPF, fd);
 				if (ret < 0) {
 					pr_err("Failed to attach perf sample-filter\n");
@@ -519,12 +519,12 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	}
 
 	prog = skel->progs.perf_sample_filter;
-	for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
-		for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
+	for (size_t x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
+		for (size_t y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
 			link = bpf_program__attach_perf_event(prog, FD(evsel, x, y));
 			if (IS_ERR(link)) {
 				pr_err("Failed to attach perf sample-filter program\n");
-				ret = PTR_ERR(link);
+				ret = (int)PTR_ERR(link);
 				goto err;
 			}
 		}
diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 4269b41d1771..3f0a65fb987d 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -164,7 +164,7 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		ntasks = 0;
 		strlist__for_each_entry(pos, pid_slist) {
 			char *end_ptr;
-			int pid = strtol(pos->s, &end_ptr, 10);
+			int pid = (int)strtol(pos->s, &end_ptr, 10);
 
 			if (pid == INT_MIN || pid == INT_MAX ||
 			    (*end_ptr != '\0' && *end_ptr != ','))
@@ -234,7 +234,7 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		strlist__for_each_entry(pos, pid_slist) {
 			char *end_ptr;
 			u32 tgid;
-			int pid = strtol(pos->s, &end_ptr, 10);
+			int pid = (int)strtol(pos->s, &end_ptr, 10);
 
 			if (pid == INT_MIN || pid == INT_MAX ||
 			    (*end_ptr != '\0' && *end_ptr != ','))
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index a34726219af3..b8e8865aeb22 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -31,7 +31,7 @@ void mmap_cpu_mask__scnprintf(struct mmap_cpu_mask *mask, const char *tag)
 	char buf[MASK_SIZE + 1];
 	size_t len;
 
-	len = bitmap_scnprintf(mask->bits, mask->nbits, buf, MASK_SIZE);
+	len = bitmap_scnprintf(mask->bits, (unsigned int)mask->nbits, buf, MASK_SIZE);
 	buf[len] = '\0';
 	pr_debug("%p: %s mask[%zd]: %s\n", mask, tag, mask->nbits, buf);
 }
@@ -165,7 +165,7 @@ static int perf_mmap__aio_mmap(struct mmap *map, struct mmap_params *mp)
 			pr_debug2("failed to allocate data buffer, error %m\n");
 			return -1;
 		}
-		delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
+		delta_max = (int)sysconf(_SC_AIO_PRIO_DELTA_MAX);
 		for (i = 0; i < map->aio.nr_cblocks; ++i) {
 			ret = perf_mmap__aio_alloc(map, i);
 			if (ret == -1) {
@@ -261,7 +261,7 @@ static void build_node_mask(int node, struct mmap_cpu_mask *mask)
 static int perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *mp)
 {
 	map->affinity_mask.nbits = cpu__max_cpu().cpu;
-	map->affinity_mask.bits = bitmap_zalloc(map->affinity_mask.nbits);
+	map->affinity_mask.bits = bitmap_zalloc((int)map->affinity_mask.nbits);
 	if (!map->affinity_mask.bits)
 		return -1;
 
-- 
2.49.0.504.g3bcea36a83-goog

