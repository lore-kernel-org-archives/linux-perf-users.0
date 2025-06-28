Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97DD2222D5
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Jun 2025 04:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751086261; cv=none; b=pqCU0a2IosiHK5K9SIn10PVn1PGM145Z2DXREbhjIwcFEfaFMHRqosgBJNeyts+SWKxM4Jl1wg/dv16isTg+7YMEybrK9ltWUKA0ItDTmCJnJGMQKmsCHToJ+gFMSY6JcCymtabZ93XEsrwBaRPQzkZRnH2u8GOZXiTf186MUmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751086261; c=relaxed/simple;
	bh=zld8u2aUntHwWVLcqYGsjfz18gqy3sE21GfAwQ2A4og=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HPXf5zAOdfSAUll4NJFF8JhGN4XIuJibqAmrfbCncWGXbSlghQW17+I6g9eAmkeOK7kF5sxAc19RZX7j0tQxfwy7J+4DtblaovBrc5KHedTPcc/nyM7GpOUrpiCjAaSQQ9y+AkS5tq4VC97r2d7IDWsCpual0yDmpS6FcO1MZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m83AGzSs; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m83AGzSs"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748f13ef248so481242b3a.3
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 21:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751086259; x=1751691059; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DMI97uZu0xVTActQ5VqzwsLdtjEz1oIqfwYO1zi5T/w=;
        b=m83AGzSs1bMepSB9wMuQf72V19i58FslbNac2y5R9EG4GaabMhX2G7TfA/4cDZSHpd
         Br7DxHz2d0m8aEwIgzXxKzm5dLv4Lr4CBlDbIQI6Q/O7b+x7mqNLOvELOvvYLAj3UnbG
         80cBn+j6Uxy4cIvCxGdV06+l8m2DxRgEe4Lf3s810XA1oBvdIELRYQhVo2Z1fHoTXM2c
         PMR4aZkZm1pK/h8haE+LYX6pcDjC3Boy76pMVm1Duvvqhi7HASeSyL4JSuqgNwrkYivM
         J4ww2dovjhQMw97QcDNhjxTP1uFKF2etozGsPlswKI5b1SeyGol5uhlxew/DD/ESZpU5
         b5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751086259; x=1751691059;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DMI97uZu0xVTActQ5VqzwsLdtjEz1oIqfwYO1zi5T/w=;
        b=JwfWPJg60pF3i4vu0yM25B0UlNZZ94/L3e7OsfvYKp73GjyVvXe1Z0wI0EpsJuAyHV
         qALZ8cWKukqJ61YxRKY2eWjZhwYRHpeZhBVFu4W5Vrt7BRL4mlZJYVbdoAWwmz4sQYAz
         AnDO9b6Etc6xu7XBAo6/e62z1i4wJs/HHwpun1+jbKGCH2YpaYS9bzU2rkoh7jAG3JtX
         rh9SB5aoFUgAQ9LnDSOJqti2cNjXuxACn5PHV9+d78iIYO1qxgbCiAUAKQd/BIR2CJnL
         HSnxD6jHzN9kXKKmRVFKZw3X1HOb3TRDNgHoVbZ+WH9DAiA+aQRquZ3FLltgvZDnrjwt
         XhOw==
X-Forwarded-Encrypted: i=1; AJvYcCVoVzmmdinSJDEEWz73wZxjv+NMvMOgbMmK8j189xtzmQcjA1FdmU/jbF/uEa/894ovunZsJhgspY53wPbdwOeQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyJZBOOqKQghXVd9l/NcUvMvaI0glWeNMz77+mlErltl5uxIgj2
	C2Uzd1PaVr5LGkOhwbStwcGH3JS+/KgYz5h3IfxEGZPqGEiN5+8W5UTtDxhvvKvlxIKJq7SocDz
	u512Yy7t6kA==
X-Google-Smtp-Source: AGHT+IH1BScBx6vJzRt0VeNppu+SsTR4FsyBOv15AwXFrWSby58ouKxE4a/gCiqIyNSNoYfuU0r1Og/qgGQa
X-Received: from pfbdo6.prod.google.com ([2002:a05:6a00:4a06:b0:749:1d32:aa78])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:88c7:0:b0:742:ae7e:7da8
 with SMTP id d2e1a72fcca58-74af6ee4838mr8593184b3a.8.1751086259182; Fri, 27
 Jun 2025 21:50:59 -0700 (PDT)
Date: Fri, 27 Jun 2025 21:50:04 -0700
In-Reply-To: <20250628045017.1361563-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250628045017.1361563-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628045017.1361563-11-irogers@google.com>
Subject: [PATCH v5 10/23] perf session: Add an env pointer for the current perf_env
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

Initialize to `&header.env`. This will later allow the env value to be
changed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/session.c | 3 ++-
 tools/perf/util/session.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index b09d157f7d04..e39a1df7c044 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -156,6 +156,7 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 			     ordered_events__deliver_event, NULL);
 
 	perf_env__init(&session->header.env);
+	session->env = &session->header.env;
 	if (data) {
 		ret = perf_data__open(data);
 		if (ret < 0)
@@ -2750,5 +2751,5 @@ int perf_session__dsos_hit_all(struct perf_session *session)
 
 struct perf_env *perf_session__env(struct perf_session *session)
 {
-	return &session->header.env;
+	return session->env;
 }
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index e7f7464b838f..088868f1004a 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -45,6 +45,8 @@ struct perf_session {
 	struct perf_header	header;
 	/** @machines: Machines within the session a host and 0 or more guests. */
 	struct machines		machines;
+	/** @env: The perf_env being worked with, either from a data file or the host's. */
+	struct perf_env		*env;
 	/** @evlist: List of evsels/events of the session. */
 	struct evlist	*evlist;
 	/** @auxtrace: callbacks to allow AUX area data decoding. */
-- 
2.50.0.727.gbf7dc18ff4-goog

