Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0190921CC55
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Jun 2025 04:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751086283; cv=none; b=FT41vZDdSg55lt0+va7TqrujMLguREVDxLwC4yQ8vrEAQMq+E6LguH+wmxhpI8yOXTQg40iYI5ClCKV6xEIzaIcFxukgSIPaOqJjjecnHJ66ZCx50HzZy2WaeNh+7v8TlRGe5CcHBESeVGyaqHEXH2fvRmVfvRlnjE2KWuzeyDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751086283; c=relaxed/simple;
	bh=rzX8B0iDELZ/bYw3/jiUDZsS7oa2ckXn4WeaJ/6cDmI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=gi+LxT0sjeXMtlkMKMwaKF47mDBQ48ecYj+gOtPwDzlFFPDHq4nV3wgypcmNHss3013df9tbL3X/1MVnRMM1ZNSzkb6ktHonxhqKAw5MtOUEkLOvZvo6/3Cz8LuSlEAI3nP4nRYxYPaYPZZy9S7og4MDpg3Plzf+gs6oXwjd7ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1/3EcPu8; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1/3EcPu8"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748cf01de06so1350500b3a.3
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 21:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751086281; x=1751691081; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zuXuLHVC8mUAXN1Rk38gtyje6VxPsjMfZ/jwecza8r0=;
        b=1/3EcPu8SQdH4JsabudDskflkSiQ5Zfk95PGfY7PMHu7zNnePZA1FVi0m8foTnKiXc
         ZY0kraeKLO2DT0UFOMBAQwzoPaKnRZjfXs6fbPnXASF0V1bsgQww5IX30GJ6onEaxt41
         7WquScZRj2k0DJDrknSBMbubMXaTCPjd8+VyrDREBK4VdhSi8eHRq6Lijxo2bGgy5eAy
         3EpjVoc+imwIUh7HMv0yrE2s0Dw2HY6LnX46lJNhQVI6ltyXkbQXyqMe8F7HSOiuo8GN
         UnLfS/M5V4YV5z0WibBccQGrXWDaBHgaD7sxQ/OFpHTLWzVbQrJKZBU1njOjqNiN6Lx/
         Ly7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751086281; x=1751691081;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zuXuLHVC8mUAXN1Rk38gtyje6VxPsjMfZ/jwecza8r0=;
        b=EfUS000EiIzoD09Xr1xQ5hGR31VoTtU1sB9rpz3wQrCY9iQltF93xzLVW/gBTFBxoW
         jbaiuFk+irqYohye3rvs2fLOblFAG7bZG6BNhseW9Cl3uzwfTt3bmM2PKLA711A+4TLC
         gSCRYG1/xwTv2CBq3+Kq4B6rIWKqmOfRvFiHqVIcD4t8fD4s78RKKOF/2QDK1dj4gVnZ
         qR6CCt5/B+BHa1OlLbNQBAk/dIZBf9/dgrFdeD1olUiMw8FLt16Ta87bD4AQ36udD/au
         d77Ml63lRrAbyaIwMqUG3ngKMaUZbVe/uG4Bur0LEAR3pGswzQgYaDMY5wpFZaou7rNN
         utbg==
X-Forwarded-Encrypted: i=1; AJvYcCVoB8tfy1rWh077aY5VzXRrIqgZ8SJ+2EI+Udop630XyQgwJlQJ3OWQVMklFqtWTprG9jPL1AWHQ8QrteuwNIJC@vger.kernel.org
X-Gm-Message-State: AOJu0YxfopraIOqvJGZKRlsTAGSFwehNeLtawnKXm/MeT3OnjIWWp/o2
	MwEKsPYBT1vCxoHhGSuywylZ1qSVlwXzjD+dHIKQm373znAsRR9632IQya0cgKqjmEo25DOes+V
	TmNgXdAeLHQ==
X-Google-Smtp-Source: AGHT+IE0qxcnnxTTWe9CHDCNPjcV2j5Ls+Y8fN+NmEKyKnoatl4vzJ3R6yfnqSJhftKCP5XZWld0LGT3E1t9
X-Received: from pgnb21.prod.google.com ([2002:a63:7155:0:b0:b31:d4af:e567])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9186:b0:21f:5324:340
 with SMTP id adf61e73a8af0-220a17e9b09mr9968310637.41.1751086281226; Fri, 27
 Jun 2025 21:51:21 -0700 (PDT)
Date: Fri, 27 Jun 2025 21:50:13 -0700
In-Reply-To: <20250628045017.1361563-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250628045017.1361563-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628045017.1361563-20-irogers@google.com>
Subject: [PATCH v5 19/23] perf trace: Avoid global perf_env with evsel__env
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
index d52f21afdeb1..da94cd28c8dc 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2904,13 +2904,6 @@ static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sam
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
@@ -2996,8 +2989,9 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
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
2.50.0.727.gbf7dc18ff4-goog

