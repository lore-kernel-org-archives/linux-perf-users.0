Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D166296FC2
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035531; cv=none; b=FNCbLmNwi+bJ+ti490pogv/fxk43UdNSPOtrBdgZChuCMyikIOXpP47PTWMMQvMTju8VaNZ38ewum7cdEhyNiRpyh1y2/56o7IYXUITPq1V7eB+hiVj6Yl2Q1ZMa9IiuDTNKOH9n4HDix2/EIhPuP8tUne5Es6guR+syQXThps8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035531; c=relaxed/simple;
	bh=n73KmiK/kNN5ufQMB3kNSo8ge+ozEbe/HJSdGbtSj0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K5otztpYEatsKdfpJ3Csnioe/oajmDaYNWzz4n9efayzieE4sLBlpsh0wwm0HwlCaiQ+LXGOER+wojofHxQ1fwrH/fzqepA89XxCPZTu/unFZTQWg7K3n+WFrnBbJKE4ctGPPDEpBkRrz9/tnGMkY1UktmnvdjK5C4JV6Iws6m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y4ZGjD0Y; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y4ZGjD0Y"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-308677f7d8cso140774a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 10:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035528; x=1746640328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cD+4f+lnvjGG2DFoE148AKCMlfm6WJypnmmIVtU2xCU=;
        b=Y4ZGjD0Yw56IGXgglKDntCJbVpd05vYGBXDovatPp1zzgALevOb5VPI3Lkf32xyml5
         DtUmDasUcUut7+4c/9mApZs0CIEuZlLiQ5zlWbpeqDMoIBuYUzK8cwODRzc5UJxwcGhL
         PX6x81QaGtp2XEqQE7An+xTfvBwSP0imB1uMNnS7ODWQYvYcXMAwsPdwyNsgzEYxXGQS
         CRbaNtm0umbXVTrRLIWS+t/ZGhjmbR2/Ut1rXSXg6nJ02HQMa1iD/vw/ixVXAib9+Fl3
         kHrfETkhKAqYa33vxMVmbC27UUGQpBig/MmdNt4EHWnxYqoyh3pk8pIappLkLHo+pQ1a
         j38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035528; x=1746640328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cD+4f+lnvjGG2DFoE148AKCMlfm6WJypnmmIVtU2xCU=;
        b=e0JIjFFGiP/IL/+Wcbr7V1fDh/m2chrOj+8bBaaxxzuvPZtiV5sC0dOW1h/qJzL25p
         SOw28MWJ4gE9wI7m5Hpk6R+c1xTlNupGDba4ungNo6q5/Jy0kucbPomHtC4pLg1bfU4K
         wwMHCA8rIjCK+kbm+8JbwEKraOFcQ3/1/sMmVa/pQWOVcKA5xWom1LNJPy+UvMqdhAlO
         p1/7YE0nkJA/SBK76SgKF4GB1pGCXP5JgY+IAZQjbKYkwWf/B8RaiLuWp78hEvq7ZZhN
         fwvmocMjvauQ2eJE1/35isSEIiZ4ED/9M4cSxX4TBybyFf48xMSpUfiJbO7heMm60eoq
         tVcg==
X-Forwarded-Encrypted: i=1; AJvYcCVVGhzWaZBXsApScXprZtbTLt6Mv3WHpPL7PQvF3syDqeTBup41Gv6z8SqjpBxJHvnjJgPUywNZXPw2NfYwP/Nw@vger.kernel.org
X-Gm-Message-State: AOJu0YzyNK4SGbW4jXVISqHzkLUXdcTEJWEU0ld+lUCRDs9ZSjFHvr/G
	6doOiJlmQh5lvB5FwYcXOdoRDfv/h47WOp2AY5t3U5kiBQ2PD95KK4LPpGsvvMLPM3Y7V2idy5/
	mQhyvlQ==
X-Google-Smtp-Source: AGHT+IEtSQE7pShiBcCl/bNRHA2itLNUeOrSRXZm3f4tCByowFROZewilmBcO/UZWo9Xl43LHlwDFWeC6+hr
X-Received: from pjbsb11.prod.google.com ([2002:a17:90b:50cb:b0:2fa:15aa:4d2b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5445:b0:2ef:114d:7bf8
 with SMTP id 98e67ed59e1d1-30a332d5c05mr5146504a91.6.1746035528216; Wed, 30
 Apr 2025 10:52:08 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:50:23 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-36-irogers@google.com>
Subject: [PATCH v2 35/47] perf record: Silence -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
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
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>
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
index f9f31391bddb..c24a945b873d 100644
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
2.49.0.906.g1f30a19c02-goog

