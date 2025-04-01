Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AEC220685
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531920; cv=none; b=ApZ6/0PHBWp50BcnyQTHwhNW5RLEk60e7/gwS4IvThzjMMeOy/zXsqeNhf6GGaMCpJFKjtLZ6WauTWrdTdnXpmBaQqlanV5mY24V1A1SDNDpum8ngudIMnzD76GRXAFLrAWYgQIRI6nSTS4RUOsb+Iqk9fiMw9Nx9KMQMsO79YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531920; c=relaxed/simple;
	bh=aWhjaWaNDxw7ETA3oWWKbhRWDFg1+yjRGI+RbsdYOsU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=thgN/C9JkxssrGIrpI1sbiNo2W7d6Wzcu0eluvZKBUX8tOkCbmYL0yUQQ95HEEpgYq4pbGhGmswnbph7ApGMCOmtFEH7sHi9CxgvVEvdAHChxvX9BGeAhw1/yL0pyB0j/chSi4Wewi8vUzeXrkKMniN7MAMK7iIAT+Ab0oH+aFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SC83FC0z; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SC83FC0z"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff798e8c90so9669530a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 11:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531919; x=1744136719; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PrYWWuE6sPSS+h6suzb5zsvazVTJqNriEiozkF9ksBc=;
        b=SC83FC0zD+JMeZrWLPf7cI24ZcrzVLovtDdmBXH5U85+Ae3X53z6Zq8os+g9TyQqGO
         YHwkqWHFdCnPb98e0QaDdBBoYKinvOFYpk0L1hhj1R72hwL4wpDrdWMt6E8Xw+uinnEd
         c8Y1tZ/9FBIic2+egYjG7drpGlZxCRHKzDtKZvAxI10Tedyzg2mR4h7qax9B5dIbcOJc
         gZZ4cstG97xG5bywZWULDVqq57SpP8jEXsgIl+k/+qRcUO/t0aZhwgaK3Lh/4y1pJT6v
         rZIvvYhtQ72ZG/q9xHibM33F3NusqBzFHFH0LN9oSfBTdg2kd9ueCPmZgYMI3Yc5+iO1
         LwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531919; x=1744136719;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrYWWuE6sPSS+h6suzb5zsvazVTJqNriEiozkF9ksBc=;
        b=Hu5b2gp1HtvI6JoR+6vUhgTKrf5y/1PmXbJviw0Og+dWPkF/TFJzP4FBChQ+Qym49k
         r450ZIhFnduyq0EnewtvYf4uaGh+zwx6SQVb4ojHdmSO1mUsFrkaPeLaAXm+HBSXHFCz
         Ic8NIyfB1PTymhBUowiYKhR4hX8ar4jLWj2yJWPeKczWtfrOvFDmhqVnWd8BZ/VFjjiV
         gZTpiBn7rpTNJfGj3fyUdilhGdd6XwntPxF6jdD4Q1FrqosOphPbhVslWRYGtynLGnYf
         L3co2b41PfYO5U751/LxNzsUsqJLGVMSzzE6k5g+1hbQDk3nFxKNkGBKwxEcCcrSnhfQ
         dFMg==
X-Forwarded-Encrypted: i=1; AJvYcCVlTktjG1iOm3SNFxLpbTa+VejdDGscmk+BB6qtRS+Qhgl/A+JF26ZflvnDw0fOcKj/7qJ5rkHc7upOkOP3OSBF@vger.kernel.org
X-Gm-Message-State: AOJu0YxsKswcX+6kmJGGLqDDIPnEEd5408yxK0uBZvnNOVKesc5A7rAi
	Ml4e7O5VxjJxypuay5RT6BmBhiPS4zhcLEq26RX7IX9L57c3KS8vMEhIsdIDWZCrQ0K8+Qmaqm6
	zEyPhnA==
X-Google-Smtp-Source: AGHT+IE1i0iieUCDh7eWrhy6Ik1SYOR9eTB7LYFda3ROvNxcBt4D/jdzBlQzp5ihSJVDTMonP2rg4A/ftUf8
X-Received: from pfbdf3.prod.google.com ([2002:a05:6a00:4703:b0:739:4820:6f18])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:668c:b0:1f5:97c3:41b9
 with SMTP id adf61e73a8af0-2009f5c4a5emr19263259637.5.1743531918807; Tue, 01
 Apr 2025 11:25:18 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:19 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-22-irogers@google.com>
Subject: [PATCH v1 21/48] perf demangle: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/util/demangle-java.c  | 4 ++--
 tools/perf/util/demangle-ocaml.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/demangle-java.c b/tools/perf/util/demangle-java.c
index ddf33d58bcd3..ee20f4d08765 100644
--- a/tools/perf/util/demangle-java.c
+++ b/tools/perf/util/demangle-java.c
@@ -42,9 +42,9 @@ static const char *base_types['Z' - 'A' + 1] = {
  *	error  : NULL
  */
 static char *
-__demangle_java_sym(const char *str, const char *end, char *buf, int maxlen, int mode)
+__demangle_java_sym(const char *str, const char *end, char *buf, size_t maxlen, int mode)
 {
-	int rlen = 0;
+	size_t rlen = 0;
 	int array = 0;
 	int narg = 0;
 	const char *q;
diff --git a/tools/perf/util/demangle-ocaml.c b/tools/perf/util/demangle-ocaml.c
index 9d707bb60b4b..25fe755df5ab 100644
--- a/tools/perf/util/demangle-ocaml.c
+++ b/tools/perf/util/demangle-ocaml.c
@@ -30,8 +30,7 @@ ocaml_demangle_sym(const char *sym)
 {
 	char *result;
 	int j = 0;
-	int i;
-	int len;
+	size_t i, len;
 
 	if (!ocaml_is_mangled(sym)) {
 		return NULL;
-- 
2.49.0.504.g3bcea36a83-goog

