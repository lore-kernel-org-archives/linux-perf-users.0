Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1DC29374A
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035518; cv=none; b=Of68AFEzoFGm2kShXtumRFpV+pRQEg0rglL/cA35sOGZgOM5AgyH7BXaRtjWY7idouw5vHiFWt6qX5verJQIbtyHN0QyFsyN5ywtDRy4zDt9u9CoRLpzfopNp2uI7DH8K9uEK/6vblhlmRIHRhillQIgAmEzXkHZBPe7xfRj7Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035518; c=relaxed/simple;
	bh=9l2dMOM7UimoBEXqUwjoRi9BOwrL79JE0K1FOZ1eTn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C5MyoubHfpRACQftCMehhIa8iz8iwegsbX0YD+eFTK7jqz+3PteLN93TaSUkzBqr0i5fJHQTIQeQ9FjmXSFNHZVVm0etLhXsBiqoa62bPe0CqeJ3AoiQN9bE1hZFcq3eo8uNMj1ZI8kyGUh1i2pfHhXXuBQhJi7uUwaX4eV9EZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G0h3BZMY; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G0h3BZMY"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-afd1e7f52f7so51099a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 10:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035516; x=1746640316; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IyLcztOS6ND7VNkEzmFW3p+zRnL5x5BHhQ/NtraX+jQ=;
        b=G0h3BZMYvR+3hm3gUmIM0t/jZzuDyB3TVvfkuYWFueUNVqlkAYycoUSP2iyPzlXQOQ
         9QuuaPoqQwF3qVIe5fTvuE/lEf3w8PcCylNmYP6FtOzJ57YXen6ikWppVb3R7RqR0lv8
         v0NEcQLF8UTjATdqjXh/qeCriYBaKm2bT1UWkwqSgjVRkRRdvbxAl2Doq7vCyNuGt3yh
         a+8oDI0lFRhNmUBOtDaSqMXz8040ujHL2e7S9C74YJE5uxbPCYR7SrJ51IwvtgfsIDGx
         MAgHIAp66725tS7wcRDfQs94faL0Mu0yZKALwGCpHBJTshLfS27GmAOENujFRaZXOVQ4
         3zVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035516; x=1746640316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IyLcztOS6ND7VNkEzmFW3p+zRnL5x5BHhQ/NtraX+jQ=;
        b=QnoK4PrnSzyEv6xbMPHm0SykjcJSPkOnR4illcwznuxVBn2SuKCv1WZqJGruw4XIb2
         Q0L/lVe5RFEogxZP7kLRN70BKvzNYsQ+9pxSBh+fNfuxZTrXqeGnCkL4CCgPMre6HpGG
         oH5zxSyRKiFHE2ggWalelrA3vqs3OYe+GQldo5HolPcLLP+13EdDZLZqT3B3IqI4EH5e
         Hu+2TS0D9ZX9oeSv5o3kX10ktlpHQl9jqOYw4tdSsrrxPXsk5gpoRysdaVkJE9vW53jP
         mYo5ZveBoliQIFHPYp4Zv3hd0BBwbhQCSrQ1ABXRmMdoTdt7sO37enWQrzNiZDQcPrTt
         Xi+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPPhA/Thh26POEWfpp38Sk0fxsr8HttJ9RSeWGyLQoivAlfXe8qON57XSBq8/A8hpofssxDsXndx8QgkwuCHcQ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn4D6YgBJrE6fGudrDBENQIKMrDYqwGO2JQsApG6jUIXmnb7Pe
	XLCzU+MEW4n+WuNhQXLI0KzOyAqYCIJyqJHqShUto2R9sdhx8CQum3J0C9c5gM3eSKMqAcATHad
	MiuCmhw==
X-Google-Smtp-Source: AGHT+IG/bAJeuyUUIqze0k4zWjdHDhymwu1QrCFfccFUxqYIawKUgDvs/Fgjiy4LZ5RieT7vyM2xLY3z/Lt1
X-Received: from pgam9.prod.google.com ([2002:a05:6a02:2b49:b0:af2:54b0:c8d5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:33a3:b0:1f5:852a:dd81
 with SMTP id adf61e73a8af0-20aa41848a9mr5512244637.34.1746035515853; Wed, 30
 Apr 2025 10:51:55 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:50:17 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-30-irogers@google.com>
Subject: [PATCH v2 29/47] perf lock: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/builtin-lock.c             | 16 ++++++++--------
 tools/perf/util/bpf_lock_contention.c | 17 +++++++++--------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 05e7bc30488a..0f7e627394aa 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -569,7 +569,7 @@ static int report_lock_acquire_event(struct evsel *evsel,
 	struct lock_seq_stat *seq;
 	const char *name = evsel__strval(evsel, sample, "name");
 	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
-	int flag = evsel__intval(evsel, sample, "flags");
+	int flag = (int)evsel__intval(evsel, sample, "flags");
 	u64 key;
 	int ret;
 
@@ -837,7 +837,7 @@ static int get_symbol_name_offset(struct map *map, struct symbol *sym, u64 ip,
 	if (offset)
 		return scnprintf(buf, size, "%s+%#lx", sym->name, offset);
 	else
-		return strlcpy(buf, sym->name, size);
+		return (int)strlcpy(buf, sym->name, size);
 }
 static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sample,
 				  char *buf, int size)
@@ -968,7 +968,7 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 	struct thread_stat *ts;
 	struct lock_seq_stat *seq;
 	u64 addr = evsel__intval(evsel, sample, "lock_addr");
-	unsigned int flags = evsel__intval(evsel, sample, "flags");
+	unsigned int flags = (unsigned int)evsel__intval(evsel, sample, "flags");
 	u64 key;
 	int i, ret;
 	static bool kmap_loaded;
@@ -1303,7 +1303,7 @@ static void print_result(void)
 				struct thread *t;
 
 				/* st->addr contains tid of thread */
-				t = perf_session__findnew(session, st->addr);
+				t = perf_session__findnew(session, (int)st->addr);
 				name = thread__comm_str(t);
 			}
 
@@ -1638,7 +1638,7 @@ static void print_lock_stat_stdio(struct lock_contention *con, struct lock_stat
 		fprintf(lock_output, "  %10s   %s\n", get_type_flags_name(st->flags), st->name);
 		break;
 	case LOCK_AGGR_TASK:
-		pid = st->addr;
+		pid = (int)st->addr;
 		t = perf_session__findnew(session, pid);
 		fprintf(lock_output, "  %10d   %s\n",
 			pid, pid == -1 ? "Unknown" : thread__comm_str(t));
@@ -1691,7 +1691,7 @@ static void print_lock_stat_csv(struct lock_contention *con, struct lock_stat *s
 			fprintf(lock_output, "\n");
 		break;
 	case LOCK_AGGR_TASK:
-		pid = st->addr;
+		pid = (int)st->addr;
 		t = perf_session__findnew(session, pid);
 		fprintf(lock_output, "%d%s %s\n", pid, sep,
 			pid == -1 ? "Unknown" : thread__comm_str(t));
@@ -1870,7 +1870,7 @@ static int __cmd_report(bool display_info)
 	session = perf_session__new(&data, &eops);
 	if (IS_ERR(session)) {
 		pr_err("Initializing perf session failed\n");
-		return PTR_ERR(session);
+		return (int)PTR_ERR(session);
 	}
 
 	symbol_conf.allow_aliases = true;
@@ -2023,7 +2023,7 @@ static int __cmd_contention(int argc, const char **argv)
 	session = perf_session__new(use_bpf ? NULL : &data, &eops);
 	if (IS_ERR(session)) {
 		pr_err("Initializing perf session failed\n");
-		err = PTR_ERR(session);
+		err = (int)PTR_ERR(session);
 		session = NULL;
 		goto out_delete;
 	}
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 5af8f6d1bc95..5a7a820000d4 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -54,7 +54,7 @@ static void check_slab_cache_iter(struct lock_contention *con)
 
 	has_slab_iter = true;
 
-	bpf_map__set_max_entries(skel->maps.slab_caches, con->map_nr_entries);
+	bpf_map__set_max_entries(skel->maps.slab_caches, (__u32)con->map_nr_entries);
 out:
 	btf__free(btf);
 }
@@ -123,23 +123,24 @@ int lock_contention_prepare(struct lock_contention *con)
 	}
 
 	bpf_map__set_value_size(skel->maps.stacks, con->max_stack * sizeof(u64));
-	bpf_map__set_max_entries(skel->maps.lock_stat, con->map_nr_entries);
-	bpf_map__set_max_entries(skel->maps.tstamp, con->map_nr_entries);
+	bpf_map__set_max_entries(skel->maps.lock_stat, (__u32)con->map_nr_entries);
+	bpf_map__set_max_entries(skel->maps.tstamp, (__u32)con->map_nr_entries);
 
 	if (con->aggr_mode == LOCK_AGGR_TASK)
-		bpf_map__set_max_entries(skel->maps.task_data, con->map_nr_entries);
+		bpf_map__set_max_entries(skel->maps.task_data, (__u32)con->map_nr_entries);
 	else
 		bpf_map__set_max_entries(skel->maps.task_data, 1);
 
 	if (con->save_callstack) {
-		bpf_map__set_max_entries(skel->maps.stacks, con->map_nr_entries);
+		bpf_map__set_max_entries(skel->maps.stacks, (__u32)con->map_nr_entries);
 		if (con->owner) {
 			bpf_map__set_value_size(skel->maps.stack_buf, con->max_stack * sizeof(u64));
 			bpf_map__set_key_size(skel->maps.owner_stacks,
 						con->max_stack * sizeof(u64));
-			bpf_map__set_max_entries(skel->maps.owner_stacks, con->map_nr_entries);
-			bpf_map__set_max_entries(skel->maps.owner_data, con->map_nr_entries);
-			bpf_map__set_max_entries(skel->maps.owner_stat, con->map_nr_entries);
+			bpf_map__set_max_entries(skel->maps.owner_stacks,
+						 (__u32)con->map_nr_entries);
+			bpf_map__set_max_entries(skel->maps.owner_data, (__u32)con->map_nr_entries);
+			bpf_map__set_max_entries(skel->maps.owner_stat, (__u32)con->map_nr_entries);
 			skel->rodata->max_stack = con->max_stack;
 		}
 	} else {
-- 
2.49.0.906.g1f30a19c02-goog

