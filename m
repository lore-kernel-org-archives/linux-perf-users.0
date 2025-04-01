Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AA122424B
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531939; cv=none; b=GztmpbrYz6zcu+rkx7MdI48AP5KaBNRNqPI1g/R19q1bbg/yCqhXyWQq0jjurAmC4z54a+JAvQs75CUrVTX6lITbzZnfnfeJWLSosgL34Nfxr1wR5/Mxs+Jt3I/5/7h1EsUQmK+XSEllmif5lX+8o5ubHJmGN5bkCPcb3f2w3k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531939; c=relaxed/simple;
	bh=aNEAqY22NVJBLrUvwAfSZyi0jskwYW+fPEnS6UbQ99c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=qp+uEbNSEExWwAIHvLhGfMDN0XsHHDfAShSPRHNSueGrUJXbXQHDfHQRLjdOxTZNUH0LaBHnkxwj/OxYSelIQDxOWE5+1puHrv8f2HlnqJROnsBS54TPIVLAJ198tU5vJNyhdYTqLDueMxlVSu9/Tj7IKP5HL2W4j3IJI20kzGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jbMA+Gx8; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jbMA+Gx8"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30566e34290so1225311a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 11:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531937; x=1744136737; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dEvgMQ7hj1MtC9APrrTa5v1wygWFQPA8AYYV5v13hBc=;
        b=jbMA+Gx8zJKbshaXdKM07m9kIKKOPsS6c1TdWAfxKEP1Kd4hwQvpRQhLY2IOVnd8S5
         fQbshyzHFhuklrJPfMiaN6tD1JpiQ0HzPNdr+pf4POTxu4sIHnTbvxQdryfMd+VIyK1Y
         l9VfdCZOmwKRIieFeQL26bef0SAO3yawOKAoSz785inYjayb9IwukgFkGrqtn7ZbNYab
         Wl8IU85hIabZokSWNAmqo3eyGwPMSWPk+PVC8ynpw+lepbQ1ChIjh13YQwl3QRcE7SzP
         6QHwuGTJQFu5gJ/i1cjPXY1hUn6JSNub/rci5qxvCshWhZJrsN6lvzqfafa0VvhXxbVx
         td9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531937; x=1744136737;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dEvgMQ7hj1MtC9APrrTa5v1wygWFQPA8AYYV5v13hBc=;
        b=lHirjrtvv7uOTJA+RPPkLGpu6Q7O7bTrv+JLaW49GpWKUXYYm2J+Efumb5jd9o6uDg
         pOwuXDr334339fc90/lnSWwdxUJkTYyu4XlUPtmBt0L7cQ82A4J3i9jNFTQi1yUg6FxF
         o73xO+ZqoVQEPZKt248XT6xJmxhFhbsVvEDR8MaEJ3Qr6Rjj3deRocll0e+AL5VbrJ9I
         Kwa+ZNgdpRG+Ip0E3BySaG2Z5Crro3m87oeoFxvfT6JrmywpkLR2UDj+1UQ0TOvKlJeX
         ThNUEMc1gdsSzJ6DkqPXAQiVgHuw5Gcb4qMXNb8HR5bacoJhTsBLd10tJbQrvVDe0M48
         lsfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjszczgwd73zZUBorYYNMpt5GJ1Bv20+8K0h949IYIoH5teYnJN716M3TRkXQd3tbrn3xNKNr3875OZqSChcfe@vger.kernel.org
X-Gm-Message-State: AOJu0YzQOZoN8LNZUtssBjceJ02TEDIBb4I5sYAR+QKNg9N5fIIx9yFS
	Gd6aTBCyt82fJZMHxQp9vnozTk/1o2e7e0u+kXabPDCJJLVpHG4qoZgoXuoBNapKMmtJjq6JvFF
	Mbkkz+A==
X-Google-Smtp-Source: AGHT+IGchPGTFEjtMPMpcg6L5VZPbxRfh8IYI2/637AjZAb1QTVtjp9b4ehxyr3z/adDeoLrSyZxI9FBtMu4
X-Received: from pfih11.prod.google.com ([2002:a05:6a00:218b:b0:736:79d0:fd28])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1493:b0:739:4a30:b900
 with SMTP id d2e1a72fcca58-7398037e24amr19307720b3a.7.1743531936475; Tue, 01
 Apr 2025 11:25:36 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:28 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-31-irogers@google.com>
Subject: [PATCH v1 30/48] perf lock: Silence -Wshorten-64-to-32 warnings
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
2.49.0.504.g3bcea36a83-goog

