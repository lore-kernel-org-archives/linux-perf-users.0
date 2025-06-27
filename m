Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE3E20E31B
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052267; cv=none; b=W40BVRcwpiHFnTNr5pdRtyllkPg79V++ppFR0Wp/qd92Y/mMiQiAtt/7hNBO92hBh0utb/2Z1A1qIhczFLsEuX8zz/azPUhCD0npr0PvAfpqc/RAYRdWIv+gWZ26mJ39iLvGnPbjtasfgOII82H7DdthoptjyPR94fA2SorCOVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052267; c=relaxed/simple;
	bh=iY7+1w4ffuJmT53JhOUOvGs8aNHT70CLlG9C1dLwHio=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=aeCllLrCashUje8Zd7lf7XAGu8OWblKvuyLGx+9fQKFyRWOgoIvZUhCrYrtJeuI/O9DV96RBY4c5OQD6+Dj3tCn9QE+1Ds2KPBVBW3iCSBF4x65KQFGZJTcjA2j0KcqOLA+l1pmm0zDXqiz9zRgNXztmB0TFIkyBAYhiN+LJNn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZIe0wc7; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZIe0wc7"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2eb60594e8so178153a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 12:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751052266; x=1751657066; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4jlp7VVoQZ0r1uOBhIqm+MKIwWsotQYqLXFEbR3D1pU=;
        b=aZIe0wc7CPfNpauCDGhvM0uXpw9pgABk+jo3fcPclN3PA0Sh9PNX/PPqKe1hts66MC
         YFL1UrIJGLi1TjZjDYN45ojEwaPwagLHlIq8zq/nvr5YoC7vuVOXUecyJmWT/Rr9bn+b
         KD2QePndgp6KSJJr5zsWW/fKK9nBEe2wW/eENwLrHIDhzwNpdxWVtEcv/KlEidPr2qlh
         wWcSUrXkc82kyyPp/m0uM7xXOCbsr4QxPkGdwmgM7tvgKpfs5DnIthjG+4WajKK16x2u
         5Q1tlEPFfd3kEtGEJF2KInwU9XA7BzZvwlV6dwOfgPvYR3miG0ZvmfaoOKaABk3wuctM
         a9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751052266; x=1751657066;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4jlp7VVoQZ0r1uOBhIqm+MKIwWsotQYqLXFEbR3D1pU=;
        b=SDuQCal2ZAdC72GHdqBdzIYKss70sVm+trVxAORQ5NqBjHJYZXp7e4HCru+aYF9/zV
         uQFPawoOxcrFXPXnVtBmty9PHgKsfZ5x1hHm8zFmNVmGG/rxrdfx3KfAS3aWtJKDlIdP
         AVEqwKIJznK27jQTK1byYSh5BuUTVdFBk1IMqRY64nQcpa1EOx+Y5NuW5MR1ErYEwufY
         BA77tWSws4YcglIBE0r0KbkmquDeL0GbKSK2fo87pujbGl1NmKdx6k5+TFi0LoALnI5k
         /IflJ7rmcjB4ThYB0YakL1OOx31Na2wUqXj7eqcOMZV9zICp/0BNGp1SB82Fh77vupxi
         DoaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4YJXO+VNG7cHXmI4S8GX+qJzcgVy0Pg26KyCSQ24zYJBzW4EJv6zuMyrsr1l98tEdmtiLnHj2Xd17+iMHtVvR@vger.kernel.org
X-Gm-Message-State: AOJu0YyoomGWbhrI9owSTWnPVCxEnln2tu4PDJwWTHODhLceyAHa8/7Z
	QBW/Ioc+bRVcIS8kfm4QdJdFN4MSUeBJyigqOdQ2SArLY51wUoHa4b8XeW/bvrpXhUPr1i1EzMJ
	Rz0H95TLUSw==
X-Google-Smtp-Source: AGHT+IHKqQl/ML2/Sm+hnm9pOg2bqes0L29RyOq2eO+4SeKL4TtFginStwz4h+krXnUL/zlqroi8Xw2mxAXH
X-Received: from pjv3.prod.google.com ([2002:a17:90b:5643:b0:313:2213:1f54])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d87:b0:312:e9d:3ff2
 with SMTP id 98e67ed59e1d1-318c8ec50bamr6593923a91.7.1751052265996; Fri, 27
 Jun 2025 12:24:25 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:24:07 -0700
In-Reply-To: <20250627192417.1157736-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627192417.1157736-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627192417.1157736-3-irogers@google.com>
Subject: [PATCH v1 02/12] perf stat: Avoid buffer overflow to the aggregation map
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Blake Jones <blakejones@google.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Song Liu <song@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

CPUs may be created and passed to perf_stat__get_aggr (via
config->aggr_get_id), such as in the stat display
should_skip_zero_counter. There may be no such aggr_id, for example,
if running with a thread. Add a missing bound check and just create
IDs for these cases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 50fc53adb7e4..803bdcf89c0d 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1365,7 +1365,7 @@ static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
 	struct aggr_cpu_id id;
 
 	/* per-process mode - should use global aggr mode */
-	if (cpu.cpu == -1)
+	if (cpu.cpu == -1 || cpu.cpu >= config->cpus_aggr_map->nr)
 		return get_id(config, cpu);
 
 	if (aggr_cpu_id__is_empty(&config->cpus_aggr_map->map[cpu.cpu]))
-- 
2.50.0.727.gbf7dc18ff4-goog

