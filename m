Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEDF25C838
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 04:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748493639; cv=none; b=P+/Yl399utKoB6vY40zdhpm9GNG/CqmmstLAsybpCkM1chJwXi9q3CubWlS57/Wrv4PsBxb3jTBCsXCZoAxQCFrmLuC9FYTpXKeHvoCPWm7jsrrRh4NJ106LojqntNOz0OqRSXdAGAjvrIwEBL9B66jecVPc/UlB3pgNEd3nxNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748493639; c=relaxed/simple;
	bh=fbeOTQRo2s34TVovUNwqxb5YEAi96HQ+lyPHyELiZPg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bs6VYeDf5ZYHDUxDZ3M0Wfy9ZK/cb5MCzTetgDpkoVaEk3rvZ3KZEExYxz4JqjHJRGtVm8fNjZm0qYSa9lcEFQQalP9dpGA5UE0RIShBvZOtBPLdUlfPpKrengBM+r73RdRTBuRr1+uT1yZeOZiDawA9qtHQuVapKzD7Fg8y+Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=igIeWODo; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="igIeWODo"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2dfeeccd55fso643849fac.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 21:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748493636; x=1749098436; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ksP3WPbUsU4bQu6Iqr1vG6L+3oh4iwZGBG8EolKM1j8=;
        b=igIeWODoDR8mPjmH37Qk/IDO5fArT175dbwlaw9TH1Wv43AXsqZ4bcLp9L9k8RqYSI
         Q4HMtkHjlETwKMrIFZUa7ALdwqW702pYBM3bnlhbnxep2Tq9fibW25EXZ+y9MNeeYAQA
         BK31x4vpfWLdyrkR/4i9m89sPXyQtgnTskJtIswBv1l5/+G4ciimYl5AituCj8lAFm0c
         S+KmiKjbYCPZh46RDveL0zJzsKdYu/q7tbW1dyRL7KtkKiAM0skGFK29K+Xjh/8lrOss
         PBWSJ6LsLni3IltvvfJ58J0ICCEErFoWmm3WbOcAUsFbm+2Gp4xc0tDgER+2f3O6s8vR
         VtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748493636; x=1749098436;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ksP3WPbUsU4bQu6Iqr1vG6L+3oh4iwZGBG8EolKM1j8=;
        b=HT1q/t7EysVsGdIYBJpio2g7Nh7brn/NGWYSWUzQlNK/Z1WMuC4seyzhv/3B/QCpWp
         2AIyit/P54ZWgS2MWcg1yaVxTnKfYlMihCEcOeBOl7qag01EzS7nn7yZMX3YzHSNbZI2
         DPkggpEyl2lDBwliukmqCDWRQxvlmEcisT/02BHjS5e/XVXfiqR1xS9ND/PUA3Fyob0M
         J2R3amXIbq6K4TLm/XZRyUKSCbPbIkoX4yeCgSFabJmPJR/ybhdWQTJvLjxZXRkKEObm
         HeixW7NPxZTGMXAbokzHmXagU0wx+4k7ppqk2RGvX/WtcVdlZQqKhTRGTrd/FuFqPFEm
         sOhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVhAXr/Alg1p06buvtCXm9i628vyBw87LrDOj6pQuSBdKKRA4YgdHqxlGY7jMbxVw4k8b7FW4JCQA+hblWBKyb@vger.kernel.org
X-Gm-Message-State: AOJu0YxH80tz9kjxryi3akZEL3J3riKhemRQMxktEhGtPZf7rNnZcx8W
	8HWs7U0KjpQePVlBEXFlFYRNH1rz28xxgtgd/tnyNA1IqLS0oi/ahLKqnZZjG/AOsKKC6b6ODZO
	yXO+196Q7zg==
X-Google-Smtp-Source: AGHT+IEqotw9o37/UvpgQTeU0n7IlRVg35AZTMDidm5AqoyD+noNIYgjoLwtSGrirElwgVnuXlF3IvZQ2SJz
X-Received: from oabxd1.prod.google.com ([2002:a05:6870:ce41:b0:2bc:675d:7cf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:4f85:b0:2cc:3e39:7352
 with SMTP id 586e51a60fabf-2e861eae439mr10073887fac.18.1748493636334; Wed, 28
 May 2025 21:40:36 -0700 (PDT)
Date: Wed, 28 May 2025 21:39:51 -0700
In-Reply-To: <20250529044000.759937-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529044000.759937-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529044000.759937-16-irogers@google.com>
Subject: [PATCH v4 15/24] perf session: Add host_env argument to perf_session__new
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

When creating a perf_session the host perf_env may or may not want to
be used. For example, `perf top` uses a host perf_env while `perf
inject` does not. Add a host_env argument to perf_session__new so that
sessions requiring a host perf_env can pass it in. Currently if none
is specified the global perf_env variable is used, but this will
change in later patches.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 3 ++-
 tools/perf/util/session.c   | 5 +++--
 tools/perf/util/session.h   | 5 +++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 17dd0b906898..af065f1b8ed6 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2538,7 +2538,8 @@ int cmd_inject(int argc, const char **argv)
 	inject.tool.auxtrace		= perf_event__repipe_auxtrace;
 	inject.tool.dont_split_sample_group = true;
 	inject.session = __perf_session__new(&data, &inject.tool,
-					     /*trace_event_repipe=*/inject.output.is_pipe);
+					     /*trace_event_repipe=*/inject.output.is_pipe,
+					     /*host_env=*/NULL);
 
 	if (IS_ERR(inject.session)) {
 		ret = PTR_ERR(inject.session);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index beb74d9fcc07..9b477cc73c85 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -137,7 +137,8 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 
 struct perf_session *__perf_session__new(struct perf_data *data,
 					 struct perf_tool *tool,
-					 bool trace_event_repipe)
+					 bool trace_event_repipe,
+					 struct perf_env *host_env)
 {
 	int ret = -ENOMEM;
 	struct perf_session *session = zalloc(sizeof(*session));
@@ -191,7 +192,7 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 				symbol_conf.kallsyms_name = perf_data__kallsyms_name(data);
 		}
 	} else  {
-		session->machines.host.env = &perf_env;
+		session->machines.host.env = host_env ?: &perf_env;
 	}
 	if (session->evlist)
 		session->evlist->session = session;
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 088868f1004a..baa59fab761b 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -109,12 +109,13 @@ struct perf_tool;
 
 struct perf_session *__perf_session__new(struct perf_data *data,
 					 struct perf_tool *tool,
-					 bool trace_event_repipe);
+					 bool trace_event_repipe,
+					 struct perf_env *host_env);
 
 static inline struct perf_session *perf_session__new(struct perf_data *data,
 						     struct perf_tool *tool)
 {
-	return __perf_session__new(data, tool, /*trace_event_repipe=*/false);
+	return __perf_session__new(data, tool, /*trace_event_repipe=*/false, /*host_env=*/NULL);
 }
 
 void perf_session__delete(struct perf_session *session);
-- 
2.49.0.1204.g71687c7c1d-goog

