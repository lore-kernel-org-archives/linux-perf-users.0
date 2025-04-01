Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A084322156E
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531913; cv=none; b=qDBaMZVTUF+glHVh76bE5C0Ymb+yslhxhNggcchxtBkORKEYyGfdFamkzx+BS3oBpI30O1VAJZbmz7TrEcaBLnZ878ZjCbdZ69KpB+bSNWTe0VC7BnsZ5fTEeyBrCrgVese1WJy9ja8wzacpEUpWOuu7V9o2RzdVO6cQlfz7ATg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531913; c=relaxed/simple;
	bh=NVp48ELe3NGN2lOoGPuvwT3sT1wygzjzD2ZhMUU85No=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=BjfLevGdnlooLrPauMifJ9eEXz+v1QYgoRNzTb9DNE65zGQYJxBZI6ZxWJni1miOYhSASTWy3C6AsqhOnNxLhyVG3lAFtfOxwxXbz0TSMpW1c76uzVyTJOskNmnByB7PQEZrwvcBta5hE4K/eQ0qB15ixPNSlht+6HQ+pZcRqrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1b06Rgp/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1b06Rgp/"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-229170fbe74so87831615ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 11:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531911; x=1744136711; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E5DAxMj62L/j12CYFGazizxFtELcthjcSJ5gr2Eyr0M=;
        b=1b06Rgp/l9Lyofzk/fvBbSZRrHiDcPjfQiOoJi0jFlw21albRrf48TKDQ53O7aZEiR
         ukmZ7zZ4SV/79iVKeJCoVu/Wo3g5U7pWY7o/pdPS/Pw6ksFMB1M3s5J9i8LePXRxD9CS
         mYDR6NMiBjUHDTGqkE2j6TtIbNhXJ43N8yH/yZ/I0YOtUdukoioITZtQz/Vm98qLCGN3
         jmD06mbFejDZPJBeAtMi/fokflr2UsPYl1xG3jbNgUe8JeewdVcTw9wjKSebC5YQB2MY
         Lhl+D3tBjf1ZV2XGxebdF8iwJBK1koBi2k4eQ5FUs0ri3jX2FphNjGNdAZZFgXIAN5XZ
         FLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531911; x=1744136711;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5DAxMj62L/j12CYFGazizxFtELcthjcSJ5gr2Eyr0M=;
        b=MYGjxTCzDe8qvbu0b7rgAgDsafiJIEPXBCsW/UhV9V43IcVKJHywzzdriNRVlp+f0u
         v00M60GRzikycxRTP3lmDx7zDTUk91KDsauVbsdE/uwKDKUrFZhlXW/h5gD+ScOCDscV
         /SW5kYgzGoPWydUjwwxzwbwQoPnktKY2MIq7CzsMI58W4P5fsLqKFrTD7+d8Yh9sFPxK
         csiLkpX6SaaqyVnEalRgHT/A9azKME+kHudZZEwSrVGUstggdlZZ6ZE8tMWYFNjIW6Ep
         3n977Lt55qygrfh96YChbPS5prPK1YCPyKxFAPRyNl3ujSoEd79Af7md1+MwmKPk8yrP
         9LyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL9Kuzfs+3eYbidAgbze64k7+u7E9/DyHVdbi4Lsml+bxcpuxBXHI6JmLqMLtR6xCToWJVTK6+nRO0gm25+nDe@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn9VQUl8f6ZAe2P5VlaQbJQaVyIKVtEUvbOvf5MKgjmY64EWmP
	AGn8yHNMTvbRpc1hyzWY7eOEva6Afw19gxXgqU2No0N2KxSJ45UF4LZoJQNZNIppBJNThaZtDm3
	hq9H6OQ==
X-Google-Smtp-Source: AGHT+IFFVoMjOxd6ofNhkni8FG6rogh/sedArmlUwSWu1eoBjUbWyPSvmEKMEQvbfnCT2dlrbfnCjpnKbLRm
X-Received: from plbmm3.prod.google.com ([2002:a17:903:a03:b0:223:3ab:e4a0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d548:b0:223:5ca1:3b0b
 with SMTP id d9443c01a7336-2292f9f1990mr231538075ad.40.1743531911025; Tue, 01
 Apr 2025 11:25:11 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:15 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-18-irogers@google.com>
Subject: [PATCH v1 17/48] perf s390: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/util/s390-sample-raw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index 335217bb532b..7e5c1448ea6b 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -202,7 +202,7 @@ static void s390_cpumcfdg_dump(struct perf_pmu *pmu, struct perf_sample *sample)
 		color_fprintf(stdout, color, "    [%#08zx] Counterset:%d"
 			      " Counters:%d\n", offset, ce.set, ce.ctr);
 		for (i = 0, p = (u64 *)(cep + 1); i < ce.ctr; ++i, ++p) {
-			char *ev_name = get_counter_name(ce.set, i, pmu);
+			char *ev_name = get_counter_name(ce.set, (int)i, pmu);
 
 			color_fprintf(stdout, color,
 				      "\tCounter:%03zd %s Value:%#018"PRIx64"\n", i,
@@ -258,7 +258,7 @@ static void s390_pai_all_dump(struct evsel *evsel, struct perf_sample *sample)
 		p += sizeof(pai_data.event_val);
 		offset += sizeof(pai_data.event_val);
 
-		ev_name = get_counter_name(evsel->core.attr.config,
+		ev_name = get_counter_name((int)evsel->core.attr.config,
 					   pai_data.event_nr, evsel->pmu);
 		color_fprintf(stdout, color, "\tCounter:%03d %s Value:%#018"PRIx64"\n",
 			      pai_data.event_nr, ev_name ?: "<unknown>",
-- 
2.49.0.504.g3bcea36a83-goog

