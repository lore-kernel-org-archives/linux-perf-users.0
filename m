Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962F925DB09
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 04:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748493650; cv=none; b=L2WbyCoN1mbW75v6YiDz+w7K0mMIWi94vi96I2AOm2n/WDTGId/o9QD1OhlK5oWQCNjaeqlzzFaXedYdO5KxtyScVA6diTZB0BzwHQuhehrP++YiTVJ8/ZFKXuIA6f7oxYFLxMwUSkyLxCAGoVuNNcf4fVNYr97DDp2JtpoCUEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748493650; c=relaxed/simple;
	bh=I0KfEuSKoaW88SLE2xfX/II6kEnnhOycNjsY3UTEYsQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=k5dMyBDiX0VjqlzyFiemFL6NLtQCHxRs+ntsElhDdZbl5tbtfUmOiSCIiK4R19a2O+BLJ0iwDTp0AJ2mNs24DKPCsLf2AcDBjYPdH1CUriAMUoY0zjfgvGD96d3fOfTXdIahlDPALlzZWoCODocLzjGDPr1Isk+XqFp5a9wH6j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q3art21V; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q3art21V"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2e90e7f170eso76247fac.3
        for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 21:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748493647; x=1749098447; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LL4UI9Ak9yHPX0+RiSe0aBEBn7zdKmhXGNAKhA0mqbU=;
        b=q3art21VYRkppJt/szZbXS1Z8E2IiTKMY0FtY8aN/WHTqNihZdnMs4YoBLs92O3NOE
         kdzC2LFHkBU2GQEZPPhethQIg2L8+kaCZ65Q56LfsVlLcLOP8jV2XCQ/XTmU1zENgjir
         fQNwYq4kf6z4c63ZDq2zznHwFFFsRMq26kYTw2caMsSfMpxsXcZUtXTZHMa+r0ypylbI
         J+vgC4bzbXoh7UcM9A7WSsfR35dyLBsOkAyvNp+BD46Sv1Gb4SSW/74u8/htBkL2BjGN
         kBlSmMlrjjO3YeohIcj9Baxm49V4FzolhQuG37dHlot+RiK/7sIiGbIzPVQvWXPAUsV0
         Xspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748493647; x=1749098447;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LL4UI9Ak9yHPX0+RiSe0aBEBn7zdKmhXGNAKhA0mqbU=;
        b=fSZe5ru9iwI9IfrwjzDw1L62OA728K6eQMbcX4Rx8ratltglWitIwCsjJPrYo+ZosK
         X/pOtP0jKXXzXDVnqyhIIUGBJtvPHUc1iwwByuC4ieJsstJb9H/NEVDHIAP3S7CC0ecn
         KfD7HjgNULLYK1Uda81p8D6NBqnHX8M+n2Ar3FibyQ5yayVFNXlKaGzgiZT8sHfS1m4s
         Deby8hmzLn5d3me8Rr69lonm34jhQ4uCA6Jwjh5649b0Qy6O9w3FnsTDBbWgM1FKttIv
         Y14xoVM6I781Ku3s96Mh5TX3nTNIKUnnn+xanWGocfQM6Y9XUQn8/WjFPah3oKjnrTwB
         JFeA==
X-Forwarded-Encrypted: i=1; AJvYcCXnMkntURbti+j26hWFKKpvihB5kpFIlSh/Cjyc6jshhdvo9yKUeef73OjUXGZmPklhMDxiDrWRPQ25sX1y+9OA@vger.kernel.org
X-Gm-Message-State: AOJu0YwLB9MjxlSAwNBHPBsPhO9j95V/2Uzamx0Bx72tv9mWqmaq143z
	eRJYasFRuH8u6O3nYUcMVNW1w6cutnIRzoSTXsmEYCMltjDxdriY7wWXvKKM8QsDwprxiuYxPnO
	bDCTyf8Ndag==
X-Google-Smtp-Source: AGHT+IF/B4xbYCms04sU6/ziRl8z3n1U/RtRzWjX1PIW5CRINULWhPl3JsZ83qpBCY7gPqUUQKJwe7n6GeO8
X-Received: from oabqw14.prod.google.com ([2002:a05:6870:6f0e:b0:2d6:b51:2d37])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:8005:b0:2d4:d820:6d82
 with SMTP id 586e51a60fabf-2e8e10cd09bmr2652554fac.26.1748493646684; Wed, 28
 May 2025 21:40:46 -0700 (PDT)
Date: Wed, 28 May 2025 21:39:56 -0700
In-Reply-To: <20250529044000.759937-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529044000.759937-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529044000.759937-21-irogers@google.com>
Subject: [PATCH v4 20/24] perf trace: Avoid global perf_env with evsel__env
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Graham Woodward <graham.woodward@arm.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Chun-Tse Shao <ctshao@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

There is no session in perf trace unless in replay mode, so in host
mode no session can be associated with the evlist. If the evsel__env
call fails resort to the host_env that's part of the trace. Remove
errno_to_name as it becomes a called once 1-line function once the
argument is turned into a perf_env, just call perf_env__arch_strerrno
directly.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index af1cb6a5ba1c..bf374844e200 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2901,13 +2901,6 @@ static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sam
 	return sample__fprintf_callchain(sample, 38, print_opts, get_tls_callchain_cursor(), symbol_conf.bt_stop_list, trace->output);
 }
 
-static const char *errno_to_name(struct evsel *evsel, int err)
-{
-	struct perf_env *env = evsel__env(evsel);
-
-	return perf_env__arch_strerrno(env, err);
-}
-
 static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 			   union perf_event *event __maybe_unused,
 			   struct perf_sample *sample)
@@ -2993,8 +2986,9 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	} else if (ret < 0) {
 errno_print: {
 		char bf[STRERR_BUFSIZE];
-		const char *emsg = str_error_r(-ret, bf, sizeof(bf)),
-			   *e = errno_to_name(evsel, -ret);
+		struct perf_env *env = evsel__env(evsel) ?: &trace->host_env;
+		const char *emsg = str_error_r(-ret, bf, sizeof(bf));
+		const char *e = perf_env__arch_strerrno(env, err);
 
 		fprintf(trace->output, "-1 %s (%s)", e, emsg);
 	}
-- 
2.49.0.1204.g71687c7c1d-goog

