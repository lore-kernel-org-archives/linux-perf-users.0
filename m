Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15927225403
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Jun 2025 04:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751086271; cv=none; b=U4+cfTauFEzHcLJVvTYoCr2nL2nVt57Um5byYiTn5EyZI91Z1M1zOFlkHcRP2iYqvsaWBM4kDAoDcb5IYNCqe1JOAKwvR/HVVvHmZATw577K9lYvx179jlZHWXlp9zbsGSQhtX5G9VGDUqrmxruw6B5cdXymPtHHqpA7yR95NeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751086271; c=relaxed/simple;
	bh=DPI9xBrbANtC0AjWx1TXDH9XJ95Ix1xdjFOPHMGqxcc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=u3I3vg7y13o88eDt/J/Wphn0EDhqw4YD60RjjgWwYA1Gx+1CjlebaL0AKsfOt+GR2aI2lSCFkktJCxqGLxo3f29Dkh8gJYLZHNx+qptnOyDiziyJ11hQHhvyDKkw+Too7xBSppnsnGhtRUQ608BdiOK0JIFcXg27da6UxTACkNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I7ohn9uG; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I7ohn9uG"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748fd21468cso2448417b3a.1
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 21:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751086268; x=1751691068; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZlstsLgRGAIldryTkxHrfcOL2Lcf7CF0yH0swczRGA=;
        b=I7ohn9uGUZdLnC9Hsuup1KzPsIqgABRzPCWyjTi7hps+BFH4/oymrtDWE9dIVnzFcZ
         Ud1EYY5wCgvbjacPdawz+uvxMQz0uAZIWf4iJu9LZfE/JrvOlwgp6Rwh1ThSp513wIYb
         7o00v5e73bfr3uDFzcarLYDm4CGMwyscbGjYLZALvFBfsrapSKvkW73/fWDLYB67h858
         PGjuQ5bEY1MqF8OkJj/PDy32Aw7H2vV2v2Od1r3G8ueB2Hhr+h3RyWFUgqjFAQPR0+3L
         stljwkVQLEO47QRvgJaRotdlYsEvRCzm1uylkVUjz5Bk+2v/GBk3BIkjrS9D3GyB5u14
         wNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751086268; x=1751691068;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fZlstsLgRGAIldryTkxHrfcOL2Lcf7CF0yH0swczRGA=;
        b=C44NjprvY9iJhphmrK4YgthOcNVbs+srxPxrpfECPQBM3n3hAp4rfEMOjDAhb0CDGX
         6MZeogSvXVaeZMkGGHcPWQqIj4YNZaOG0oZ41DcnjnFj/QLvZTYgQCj6rQyUsh5Pv3qt
         redA2NFF0CLWLNuGMXhwksSuVcIpqDeaStBm8Y195jAv7i9sY9xAUHPcC8DxNHjJjZfw
         9Yyzpl1hMX7Old9A3qNGzKTvSC4takzuhwtYMg23hrDuYS/106kcY12OCDZa94uhwdeJ
         1tSJMZK11MXG59R7Fnw+EsX+b2Sb8uf6yEcO5bcqfzIjWS/1KavZpyDpQmKC+EsRBsz5
         K4JQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3nDLPkhAff6GA7h7t/5fn4t2AzRDBEtFFd+r2tOdYa23x/gzJGo7AVTPbi94efI7Mtg+L4prFBPCB2W4d3M2s@vger.kernel.org
X-Gm-Message-State: AOJu0YwVdIhXBbCNrR61ewj5j1R7gINIbswUb7nNQGMqIoY/OKtRjbj2
	J10duMF+YxOTykCq/tAu7rUxSL+iUFEwj5I2nqvwTZHu+MmeY+rdNyIbmhiZY1jMZyEly1d2uuP
	aYrk2PdAdQg==
X-Google-Smtp-Source: AGHT+IFNKGPl5tSYmPM5NWTYrrNKaI0ecBZtB0WVfWzlQ7HS7ewyluPy4cBxXUH1WGDmBhKuFKcc+0aSDR0o
X-Received: from pfbdw21.prod.google.com ([2002:a05:6a00:3695:b0:748:df06:a477])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9202:b0:1f5:882e:60f
 with SMTP id adf61e73a8af0-220a12efb84mr8419125637.17.1751086268072; Fri, 27
 Jun 2025 21:51:08 -0700 (PDT)
Date: Fri, 27 Jun 2025 21:50:08 -0700
In-Reply-To: <20250628045017.1361563-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250628045017.1361563-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628045017.1361563-15-irogers@google.com>
Subject: [PATCH v5 14/23] perf session: Add host_env argument to perf_session__new
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
index f73350a3417a..40ba6a94f719 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2539,7 +2539,8 @@ int cmd_inject(int argc, const char **argv)
 	inject.tool.bpf_metadata	= perf_event__repipe_op2_synth;
 	inject.tool.dont_split_sample_group = true;
 	inject.session = __perf_session__new(&data, &inject.tool,
-					     /*trace_event_repipe=*/inject.output.is_pipe);
+					     /*trace_event_repipe=*/inject.output.is_pipe,
+					     /*host_env=*/NULL);
 
 	if (IS_ERR(inject.session)) {
 		ret = PTR_ERR(inject.session);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 29f5d376f65e..39da4ab768a5 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -138,7 +138,8 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 
 struct perf_session *__perf_session__new(struct perf_data *data,
 					 struct perf_tool *tool,
-					 bool trace_event_repipe)
+					 bool trace_event_repipe,
+					 struct perf_env *host_env)
 {
 	int ret = -ENOMEM;
 	struct perf_session *session = zalloc(sizeof(*session));
@@ -192,7 +193,7 @@ struct perf_session *__perf_session__new(struct perf_data *data,
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
2.50.0.727.gbf7dc18ff4-goog

