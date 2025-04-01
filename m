Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA0E214221
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531915; cv=none; b=sJkSYqk1Rm84/5QgjXFWENiiYm8YZt5tolMzlELPaNYKFOKw/7W5hO+oZWrXwAPlToULcSv2hQpNJM5oo2q8l1BDc+w7h5+6fo/viUX+ua+vvwp/IXsvvrrR7WOQhkrxdm3exZ67G72mWfclqk15L4u0mK1v3Qn7hWspTtDbuQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531915; c=relaxed/simple;
	bh=T6l6mC3RM0ZrHMfbS2Kf7Hfndu+LH5RVvzgZUQXsNkk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SIc5jXaAQILOGAPBYjBEnwgaTIfrSZelZ2LxvYsK7Ec53E2LA12VIW1jJqxHv9LQU867u/VyR+FEUSLTBtJvijaK0LWH2d42BY8zB1udo8y5iPplPR6OOMri9EkhnQpIRR+v0j1cE8INzzGDP+u0L2oCyZeAfHVujwxyBPdtjqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0VCX2HNS; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0VCX2HNS"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22410b910b0so85650355ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 11:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531913; x=1744136713; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RiHQSegTWQswup2joHhVjAcAClRwR1OKlYt+E6zEsXU=;
        b=0VCX2HNSwwvYNijhwSFI7qVfxTy3P/22SPvRAyRF+m1CnUnXqAPoZcJdnhVs822yUf
         WwGsqHrDwwl8Lkl6i7/hmkGo5PjHbexWgDJVhKQxYv0qI9d8tJV1HoPvOhG4IqQXFaTb
         RZyVJqCIDu+0LbufCpk+cqhFuZbSk4jH8ajZeqdkDY18t922tRH/d7fcZ9PkmAHP599r
         5WqjaOTEOkLYz738j8HnNxKcO1LxO5Qp81iACLfWJULxGnDqmhjuivu4q1WTdcBkD1C9
         KXo9UFdsnFozi+Bb6jTCc5XkBwMquFDDo8qh99xjfQEJuuPl3iZrz+gGiyzTdQNbCPkn
         EhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531913; x=1744136713;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RiHQSegTWQswup2joHhVjAcAClRwR1OKlYt+E6zEsXU=;
        b=J6aMfW9RuH5z3SgytmImG2SAfGyz10s2LIsSAAWuKBsWH0TFAmKoWpUNw+uOw/VKF0
         vKnY9k3hzkN+M9D/wmVEgDs+khQZVj9zywKiSjrULg8bC2GX9y3VPN8MWPPkpcOuIfvr
         rgY29clPHt1p3WbBbV1pvZPMU7ouI0UxgFdM+9EDd21w/2LVIPpZubQmfJxozJ+fHB+9
         PtIaU58CgtmFmAB79eM8UDD/u8nN8B0GBFFOyj3ZTI1KetI88OMTvxGn4Daa8ClLZaHd
         /EH93TYdkK8caBqORkUIGz3Pboek6Mt0umNSFFaBoDE+EqwaAUjVo8oI36vnqwBemv5h
         kU+g==
X-Forwarded-Encrypted: i=1; AJvYcCX8Ihe3ndcH+GYeVdruKxXgxai4xv5i2zMVVc3Mms4rXzsPW4nhylwOPxd9U7J0BliDjGti7wrH1CIYtLcluyEV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2fBESv+EPDkYnvj1nZkbEmRdlpZi2FIBm+fb9aSkubkRvR1B6
	uAiTAnBGHgKD6mahRxVW5Cccbv411QWtoePMYdG4g3AhfCe/Xvc5mXvnnzqaHXLay9no5eQuuSW
	uufz4bg==
X-Google-Smtp-Source: AGHT+IHuVXNTFL1S0fgMH1lBNSWzsF0SZTjMeEvmJ7oxv+GtAlWHclrPyc521uvG/b5yh+eWGUgFdZYNZ6qq
X-Received: from plbjw20.prod.google.com ([2002:a17:903:2794:b0:227:e9e8:7153])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e887:b0:223:f408:c3f8
 with SMTP id d9443c01a7336-2292f960348mr234747405ad.14.1743531912769; Tue, 01
 Apr 2025 11:25:12 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:16 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-19-irogers@google.com>
Subject: [PATCH v1 18/48] perf cs-etm: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/util/cs-etm-base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm-base.c b/tools/perf/util/cs-etm-base.c
index 4abe416e3feb..3aa1ccc9e452 100644
--- a/tools/perf/util/cs-etm-base.c
+++ b/tools/perf/util/cs-etm-base.c
@@ -101,7 +101,7 @@ static int cs_etm__print_cpu_metadata_v1(u64 *val, int *offset)
 
 	magic = val[i + CS_ETM_MAGIC];
 	/* total params to print is NR_PARAMS + common block size for v1 */
-	total_params = val[i + CS_ETM_NR_TRC_PARAMS] + CS_ETM_COMMON_BLK_MAX_V1;
+	total_params = (int)val[i + CS_ETM_NR_TRC_PARAMS] + CS_ETM_COMMON_BLK_MAX_V1;
 
 	if (magic == __perf_cs_etmv3_magic) {
 		for (j = 0; j < total_params; j++, i++) {
@@ -140,7 +140,7 @@ static void cs_etm__print_auxtrace_info(u64 *val, int num)
 {
 	int i, cpu = 0, version, err;
 
-	version = val[0];
+	version = (int)val[0];
 
 	for (i = 0; i < CS_HEADER_VERSION_MAX; i++)
 		fprintf(stdout, cs_etm_global_header_fmts[i], val[i]);
-- 
2.49.0.504.g3bcea36a83-goog

