Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89032989A3
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035542; cv=none; b=IGpT4eQ/Gw+QKN+WhYg59l1CjyavM603B7d8dfvatKv9USFbyo9+fvxL5xB1wBzsxoNyB1SnDOJSL/qTMmJdUmeHCy/TIaGFJVo81otuWpUese42eW06GT+HIf45OoE9Mj9oiKNPJPNdFelcfpK6j1jbxuZak7Y8dMaVJmPY2Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035542; c=relaxed/simple;
	bh=HPHxz81OxLaecpnlL9lqndi4Kc/aGSQDxqv1zSPPuXY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AWH2sRtyIWqQ2JFI1/Or9oQiX6ekv213vYebZxM62oEVxr3d9R5oxtV7joil0KXi3JpiuOS8/ZVylCypLr35HNtRlXW93jM/mlAzJ+YQahCo+1wB38jO7jbeO2lsoUu0biCDMFqr3N+VFuR55zOSHzoqZJc7Wqnu0YMBGMBM/ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nhD6CQlq; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nhD6CQlq"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3011bee1751so130326a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 10:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035540; x=1746640340; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qemr2dcVwpSLldCyiGlwsuB9xh9m4dXk1i2vOyXbcwI=;
        b=nhD6CQlq7qCiX3HaJmet/Xg0sgA6pHaYII/mROdhbll1aUZcZ70ZSrI8Xj4W4HnOSf
         A1Vfe91c+tyb/QDDqd4mz35HrgvQ0S6X06fi70M0uF8si5RTQeONGrnLJzepldmwCpFw
         LK09eG1qdDp1Z6M1vHx51iDjbFd7BgFFlV1TgwFPsJIgYromHhCptJzYB/V8UPv02jRs
         mLrJkT5WmAZRRsXRvN/zw3ofKIym/GdfBIdM4KRUtwZe0K5aU20Uz/Rqe8ZBMr1DdTdK
         V13YHxJ9GpQigke3i7RUBlU4zVIy+45mkbb3ziI4T+hdSgBgRYp5KquyV1fGgG5ZX1EP
         y8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035540; x=1746640340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qemr2dcVwpSLldCyiGlwsuB9xh9m4dXk1i2vOyXbcwI=;
        b=ISYzt/2K8AzUcYAhSUTwjAGdQwdKiBOavpUivm/uKDlGxkZHnMW4PGmUXirB7wh6Rk
         OPrnZiQIT4rad3FbWUgr5dreEdiAJDzJXBeuAggxJxgqLGmur20dgRByaiPcbz2DJx4j
         SV8jKxlasbL33YuesRRa2ydjeoGt5hqzuhvQR5D7+k8nwWsPhskZtHVzarDZvmBjERrI
         c7YnbDlKBEl8K4CHJOpW1gdAi5B8QFIPtAPcvvPRbwmeiunMJQBJF7ZeO8N7L/xQRK+A
         PAQecbP2ZX2expWVzBtaz/2st8S1bHYpJ2DWeu5luUpc6kllDFQFPpw36jwVa8rp038n
         AGKg==
X-Forwarded-Encrypted: i=1; AJvYcCUhI9SZhDQ7rH6Z2YpL+nSi6CE1S8Ducaz3NMdvjqYHBhN3xf0u+1MioqDySlLY6WdS1zXsjaLgohl7UE7jvF2a@vger.kernel.org
X-Gm-Message-State: AOJu0YxkBBVLK0hlDHKBWpo7uZXT+uM9l+qsRoCTU+1QFM9AdBdE9gz1
	F5xp7ioeCB7wfDHSKgSaG+UnLc3ANIRH9PVPijhbA89H2Wp05tVT+dIHHJKOhUyVjZnv3a+p4LV
	KIwGYYQ==
X-Google-Smtp-Source: AGHT+IGiwVp5/ypPQD3uAZdm6z54NsO/3JK1b7BY6DDnJgXJ1mAvzNplqKCb9spucs6B1RP5GSDw5x90hAhQ
X-Received: from pjbsl12.prod.google.com ([2002:a17:90b:2e0c:b0:2fc:1158:9fe5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f05:b0:308:2b5b:d67f
 with SMTP id 98e67ed59e1d1-30a343e8575mr5995053a91.9.1746035539948; Wed, 30
 Apr 2025 10:52:19 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:50:29 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-42-irogers@google.com>
Subject: [PATCH v2 41/47] perf diff: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/builtin-diff.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index ae490d58af92..9c21ea8f242a 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -243,7 +243,7 @@ static int setup_compute(const struct option *opt, const char *str,
 
 	option = strchr(str, ':');
 	if (option) {
-		unsigned len = option++ - str;
+		size_t len = option++ - str;
 
 		/*
 		 * The str data are not writeable, so we need
@@ -1148,7 +1148,7 @@ static int check_file_brstack(void)
 		d->session = perf_session__new(&d->data, &pdiff.tool);
 		if (IS_ERR(d->session)) {
 			pr_err("Failed to open %s\n", d->data.path);
-			return PTR_ERR(d->session);
+			return (int)PTR_ERR(d->session);
 		}
 
 		has_br_stack = perf_header__has_feat(&d->session->header,
@@ -1179,7 +1179,7 @@ static int __cmd_diff(void)
 	data__for_each_file(i, d) {
 		d->session = perf_session__new(&d->data, &pdiff.tool);
 		if (IS_ERR(d->session)) {
-			ret = PTR_ERR(d->session);
+			ret = (int)PTR_ERR(d->session);
 			pr_err("Failed to open %s\n", d->data.path);
 			goto out_delete;
 		}
@@ -1492,10 +1492,10 @@ static int print_cycles_spark(char *bf, int size, unsigned long *svals, u64 n)
 
 	if (n > NUM_SPARKS)
 		n = NUM_SPARKS;
-	if (all_zero(svals, n))
+	if (all_zero(svals, (int)n))
 		return 0;
 
-	printed = print_spark(bf, size, svals, n);
+	printed = print_spark(bf, size, svals, (int)n);
 	printed += scnprintf(bf + printed, size - printed, " ");
 	return printed;
 }
-- 
2.49.0.906.g1f30a19c02-goog

