Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AE3293730
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035513; cv=none; b=eeDGQ7d5geOt/Xam5429DznD7f9Mq1odp7UL2Qjy5zWooXoAZzU9oW/hvQFxKzFoQjZEeTGA8VAp34655wfFtkkjQFFMBb5RbwNzDI4q7VGMJbtpDn0sj/MGPHUy8+YwC/DFkBa4m0LmrldQuYyRdZRA24CBn4/gh0R+KKnbCTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035513; c=relaxed/simple;
	bh=cRmg9Uhy/kSRny4v9VxENzuNJ6XDnUaDzdD6WOoauU4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HWMelS77ap8KkD/CDNpheZN4++fv2WjpakMaWyCGo9DYS74ZWlp7LCihp8n0EWLtlvS8ZtrG8NYC2+WmOR1FQkuPqLzFVfxdlZMN1y1HmHkMeQ64f1FT/iR2sLCj7kGbDiHMT64+sF7qg/dSM9JW341WmQ1B90QMzvPv66gEYjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pl7vcDP8; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pl7vcDP8"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b1c654f620dso117041a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 10:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035512; x=1746640312; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eLABi1cAYEw9fAUdNsHNLvlLHNMrUQ32W3A6QzBe7uI=;
        b=pl7vcDP8iDP1YhOiVhyQULrqZork/ulbJNyYHiF5avBDiaKGhRo13plo/b98rTi2+/
         g6DVCZHGf6/0rzuDG72amp1gM/l4k3Thad8sdrw4pfkNvJo94XqtV1m1GKr3giUzRyNl
         jxyLazF5LAQoD87gOeE9V68TR282M3BUN+eurO64K3O2zUJOiOl4b+XdM6sV1ZBRyMCB
         9m0B2vWTvzZCyx5qaEYXjMmpANk14We3wg0b1CNefN0wBuTgvoponbOhTnr4DTuvMWDY
         1NBA+ntw9NrSN7C3P3n4C8lJ78DOeYrzCf1HYsB2CAFmnvCtEACux43pFObG/MMrXfCT
         ryXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035512; x=1746640312;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eLABi1cAYEw9fAUdNsHNLvlLHNMrUQ32W3A6QzBe7uI=;
        b=Fo6l967dLafDXsknzJOxz6a58e9O/EOIR8upGZ4Ozbroyfk8iZmgRrfAHSkCCEBWgB
         UhLXua+xHIPHatZZVGmueLYz3nOQSSIrsDchDDFHUtm4IrXG/qvcoZPVyqDNStaM/EzQ
         72anqX86n3cMIN9vInKYECcvhtCj3iNAS4AuzHQ04/Tfq370Gci6GiBwG/6GUpJ2P1M5
         nIwBCHL/daKLHOII/YvW6JL4rR++Zk95kJ0muRpZwJZSBIlZGXNEi2oufOxi0hv9wrLD
         NpphdjYwptau+Wmr8DH+sKuzWif1avGCUe25ex4qnzSwC9Z//aP07rV35Pp3lfKQGVon
         EEMw==
X-Forwarded-Encrypted: i=1; AJvYcCXnKOznP+ek/wmDOqDzAT6nAE7Mo70+QtDf+blCGq20nOkP1IjwF2KW67ZcarRd/qK/jsAfhFnwhWk7JRG+DNXe@vger.kernel.org
X-Gm-Message-State: AOJu0YyQpDMWjEOSpxaM5rLSOrGyIdyj85Un6SNHDG07Wj7JsxZArPzo
	xb+7zY8ozsqG2hAP+jfC3++NwMGaVGk4PGpRaulIxaXdfjobUWjPnLlwgqO/j3eYVNnjkV02w7R
	ucnR7uQ==
X-Google-Smtp-Source: AGHT+IGIUuzSwqqdo5HW7am+AeE4/a6b6jacfSJCk8vxA7uRt24KCIqbt8SNuwNGgHLKwxFchcrFLUe52XI7
X-Received: from pgam20.prod.google.com ([2002:a05:6a02:2b54:b0:b0b:2c1f:b8b3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6f05:b0:1ee:e33d:f477
 with SMTP id adf61e73a8af0-20ba6ff8e7emr145936637.15.1746035511348; Wed, 30
 Apr 2025 10:51:51 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:50:15 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-28-irogers@google.com>
Subject: [PATCH v2 27/47] perf kwork: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/builtin-kwork.c      | 11 +++++------
 tools/perf/util/bpf_kwork_top.c |  2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index c41a68d073de..cc5488cb98e4 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -1574,8 +1574,7 @@ static void top_print_per_cpu_load(struct perf_kwork *kwork)
 		load = stat->cpus_runtime[i].load;
 		if (test_bit(i, stat->all_cpus_bitmap) && total) {
 			load_ratio = load * 10000 / total;
-			load_width = PRINT_CPU_USAGE_HIST_WIDTH *
-				load_ratio / 10000;
+			load_width = (int)(PRINT_CPU_USAGE_HIST_WIDTH * load_ratio / 10000);
 
 			printf("%%Cpu%-*d[%.*s%.*s %*.*f%%]\n",
 			       PRINT_CPU_WIDTH, i,
@@ -1595,7 +1594,7 @@ static void top_print_cpu_usage(struct perf_kwork *kwork)
 	u64 idle_time = stat->cpus_runtime[MAX_NR_CPUS].idle;
 	u64 hardirq_time = stat->cpus_runtime[MAX_NR_CPUS].irq;
 	u64 softirq_time = stat->cpus_runtime[MAX_NR_CPUS].softirq;
-	int cpus_nr = bitmap_weight(stat->all_cpus_bitmap, MAX_NR_CPUS);
+	int cpus_nr = (int)bitmap_weight(stat->all_cpus_bitmap, MAX_NR_CPUS);
 	u64 cpus_total_time = stat->cpus_runtime[MAX_NR_CPUS].total;
 
 	printf("Total  : %*.*f ms, %d cpus\n",
@@ -1801,7 +1800,7 @@ static int perf_kwork__read_events(struct perf_kwork *kwork)
 	session = perf_session__new(&data, &kwork->tool);
 	if (IS_ERR(session)) {
 		pr_debug("Error creating perf session\n");
-		return PTR_ERR(session);
+		return (int)PTR_ERR(session);
 	}
 
 	symbol__init(&session->header.env);
@@ -2088,8 +2087,8 @@ static void top_calc_cpu_usage(struct perf_kwork *kwork)
 
 		top_subtract_irq_runtime(kwork, work);
 
-		work->cpu_usage = work->total_runtime * 10000 /
-			stat->cpus_runtime[work->cpu].total;
+		work->cpu_usage = (u32)(work->total_runtime *
+					10000 / stat->cpus_runtime[work->cpu].total);
 
 		top_calc_idle_time(kwork, work);
 next:
diff --git a/tools/perf/util/bpf_kwork_top.c b/tools/perf/util/bpf_kwork_top.c
index b6f187dd9136..808d0c84d26d 100644
--- a/tools/perf/util/bpf_kwork_top.c
+++ b/tools/perf/util/bpf_kwork_top.c
@@ -219,7 +219,7 @@ static void read_task_info(struct kwork_work *work)
 	int fd;
 	struct task_data data;
 	struct task_key key = {
-		.pid = work->id,
+		.pid = (__u32)work->id,
 		.cpu = work->cpu,
 	};
 
-- 
2.49.0.906.g1f30a19c02-goog

