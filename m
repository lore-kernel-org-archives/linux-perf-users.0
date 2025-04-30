Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE2E2882BD
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035499; cv=none; b=KURTT5n5hjrkcniEoHd8nshJRm5yrlWlmtNsM3E0QA+QMoofvPKsKjpMtmRug5e00Qd+4OHozS7W2zilJsASZ5FFQQX4FHPcvqWOXT7vfXexJwJ732LcaDg4EgSDOBr1p35eH2b1q2YUN8qS0LRVxerTsffS2jwqG4Qcj+BuBp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035499; c=relaxed/simple;
	bh=sCPbQWpl2KULh3E4LCAV0bh/JHaMSP/NP3ql5s1b1Do=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uTdtF/G35vRCe2c0nmWlj/6Tom4V+gnc1DqhmPWb08MIRme3KRvSTGE5gukfxxchGrGmFUNCdelGhpjasp+klFLWR/CFu5QHj0o7MdwxyV5RaZJ6jN1BKTPqX5yjt+Bx2qdhWMWtReXmr6kvdskyLDm5wEVGq5+ibWDRknfn+1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QgMt7Vlr; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QgMt7Vlr"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736abba8c5cso202438b3a.2
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 10:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035497; x=1746640297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l9+mjbfIpVuolnm3GMooUNSg/0jE5LZYACjxU5MzkWs=;
        b=QgMt7Vlrr9t0pbtgCFiyn29njbVX9B8DaeHWlVhUcKHrHXeHrBolpLnVNC3gkb1LAD
         CHwW4ehCxFZTfHPAT1zNn59omhoQKL48zspFNxsqyVmRutVfyvcW1nx0ZysaDwStWoPf
         TtVUMnRqhFSqJPQXwrQ1ax7/9s9MlEZdCNElxqKIVvkz6DF3aLTYigpPD/38MOv0Wu1a
         eygNBSENKTlOudjo8U53Ax3wLvmfGx4GxWbVjhSZM113SgTYm22IFHaMcQ0Rw1MzAO2x
         m/sVUHRxpyeczkA/PlB1ewuqTjP/5DUSdgAqlDxwVETGzAZ+R9ghCKLs49cR2L4Nx3Lz
         P97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035497; x=1746640297;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9+mjbfIpVuolnm3GMooUNSg/0jE5LZYACjxU5MzkWs=;
        b=vXzqKbeiAjyTVOm3rhup+A+AmsRJSUuaVm0yrafgDUFebcDGR4ZvU7nqls5bYk0RHx
         mv+4s5VYDVK6pP5o43bOYHuftHqKqnEuxVatYxtloGxzxuFrxmggTSTKnU+3AIQImsjC
         1HmwfL2m861L+3PI6EhbVBQxSoSNLZb4sV/Do5m0ZDapDySy8bMbm0ZHtvmriMj7oJ8q
         23N9bVDQOMw/eT0SdLKop+ayztnLMl2Zude5YBEXWK9b9bYEPwPoYpSjfrjVC45SUBta
         SsXrBaG7GLO2VXV4s1vHypR5LCiyhdLHnCww6DdEbMhtkepgQ1OjESISdHYcKNB9PDOs
         qoMg==
X-Forwarded-Encrypted: i=1; AJvYcCXCU11WBRkP79mrKXOb7eKoOAyx9pOhf+HpLFGrdKtlW/VApdEn85xf8M9d9Ygt/7JWXucxlMR8q4TEHSl23xhD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3tbbNyHUiLof81cYuKRv4r0kxHwj5Saq9pQTbnJyOZdkdMxV2
	4wSlBpK1o2CCNBv8YZcsb1E0g1FrlWo+OlXq5ZedMA6Bqw5QEwm6OAzo0TjojLK/4WQzej2V7GY
	PVni7uA==
X-Google-Smtp-Source: AGHT+IHpf31xgCUhp/bSgmJMIP3K05vEfqw1PLaxr//TR346O2GAWFitRRWNuL9GJdbLUJ5lR6UpoSDbOexs
X-Received: from pfbhc7.prod.google.com ([2002:a05:6a00:6507:b0:736:5012:3564])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:14d1:b0:736:562b:9a9c
 with SMTP id d2e1a72fcca58-74038a9295fmr5722381b3a.18.1746035497149; Wed, 30
 Apr 2025 10:51:37 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:50:08 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-21-irogers@google.com>
Subject: [PATCH v2 20/47] perf dlfilter: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/dlfilters/dlfilter-test-api-v0.c |  4 ++--
 tools/perf/util/dlfilter.c                  | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/dlfilters/dlfilter-test-api-v0.c b/tools/perf/dlfilters/dlfilter-test-api-v0.c
index 4ca2d7b2ea6c..bf2a1a7b3c71 100644
--- a/tools/perf/dlfilters/dlfilter-test-api-v0.c
+++ b/tools/perf/dlfilters/dlfilter-test-api-v0.c
@@ -166,10 +166,10 @@ int start(void **data, void *ctx)
 
 	CHECK(dlargc == 6);
 	CHECK(!strcmp(dlargv[0], "first"));
-	verbose = strtol(dlargv[1], NULL, 0);
+	verbose = (int)strtol(dlargv[1], NULL, 0);
 	d->ip = strtoull(dlargv[2], NULL, 0);
 	d->addr = strtoull(dlargv[3], NULL, 0);
-	d->do_early = strtol(dlargv[4], NULL, 0);
+	d->do_early = (int)strtol(dlargv[4], NULL, 0);
 	CHECK(!strcmp(dlargv[5], "last"));
 
 	pr_debug("%s API\n", __func__);
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index ddacef881af2..0e513ac7feae 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -38,7 +38,7 @@ static void al_to_d_al(struct addr_location *al, struct perf_dlfilter_al *d_al)
 		else
 			d_al->dso = dso__name(dso);
 		d_al->is_64_bit = dso__is_64_bit(dso);
-		d_al->buildid_size = dso__bid(dso)->size;
+		d_al->buildid_size = (__u32)dso__bid(dso)->size;
 		d_al->buildid = dso__bid(dso)->data;
 	} else {
 		d_al->dso = NULL;
@@ -51,9 +51,9 @@ static void al_to_d_al(struct addr_location *al, struct perf_dlfilter_al *d_al)
 		d_al->sym_start = sym->start;
 		d_al->sym_end = sym->end;
 		if (al->addr < sym->end)
-			d_al->symoff = al->addr - sym->start;
+			d_al->symoff = (__u32)(al->addr - sym->start);
 		else if (al->map)
-			d_al->symoff = al->addr - map__start(al->map) - sym->start;
+			d_al->symoff = (__u32)(al->addr - map__start(al->map) - sym->start);
 		else
 			d_al->symoff = 0;
 		d_al->sym_binding = sym->binding;
@@ -290,9 +290,9 @@ static __s32 code_read(__u64 ip, struct map *map, struct machine *machine, void
 	u64 offset = map__map_ip(map, ip);
 
 	if (ip + len >= map__end(map))
-		len = map__end(map) - ip;
+		len = (__u32)(map__end(map) - ip);
 
-	return dso__data_read_offset(map__dso(map), machine, offset, buf, len);
+	return (__s32)dso__data_read_offset(map__dso(map), machine, offset, buf, len);
 }
 
 static __s32 dlfilter__object_code(void *ctx, __u64 ip, void *buf, __u32 len)
-- 
2.49.0.906.g1f30a19c02-goog

