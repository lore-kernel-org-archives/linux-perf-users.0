Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1B9D512
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395979; cv=none; b=VMMwUa79JTOCiuvUSbJJp//OGbZi4D+9puxxqiVTMEVnD9RH6b7gOu3O0n3U+gJew5UUdarq+RsipSsP6MVqbeww8OffbIFKNXpYaBcfD3m4rHIVflBUQwxwwO/LPIisEyQwIDnOra7g0ANX2RZxUdnz2F4HNLgp400og09Griw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395979; c=relaxed/simple;
	bh=LyYWkoBF0P1c0DOJICMXfmzvr8RS4ew644VymSLO8fA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=imhGluqjmhIJwv6lzxM3+84tSE8flK7UE4VLZ0p1tSKlVFGA71hkJop8wZ7CRo4foqd5MvegOYETwwt+WHxZDBnnqrrzmEPd5cezVEO0SSLXpMVToCS8wT+Ab5HMn7ka5fSRqeL+zsAW1GBDhhoHcK+yktdl+QP9bw8w3MoC2n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ACyDRM0e; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ACyDRM0e"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dce775fa8adso906535276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395976; x=1711000776; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mYqX63qH2QI08KtgPVfUX9rzA4k+k/gYXO7veJ+nMnQ=;
        b=ACyDRM0e02e2SgqyWcd9BfpqF1kMGRSxKNjiJHRwErhEtuonpns9rYfyjBGeE6xug/
         5P9tdmDuIng0orDjaLi869wOqV/sy4c/RsfEBnEZZfhU4vSX9saYbqXLv06GeMjZskKa
         BT73C6uvCXGeNTJzS1oo4FH3MP0XJWt1178Ma3vqv4LbFoP7UhNeb9LSmAcQVpTZdFyy
         O2kyAIZlxtW7cxpzrEcg9ZXyYbbCFuHojmk4X/uJ5fQJ8N8dGF2YbSQTU92/UKm7xD6R
         Ov6eUNCwbDZuZ2apIxU1Bbel9bI4r7FZdsi8AM23BBoPy5m915Fe5n6ZVhlWhmAZ5wCz
         1niA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395976; x=1711000776;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mYqX63qH2QI08KtgPVfUX9rzA4k+k/gYXO7veJ+nMnQ=;
        b=EkQxS9UDrEHoNKMKF8F7hgr1T63Y0PF7VaTGb4ndQDi3W8oSMHNnjT0KtB54YRHBku
         1z1NA4Wnl/+SDfUA4gvDWJMlEL6aPN59qGKPKM2MAXBE124Nxv1xQHItAYOJViROYeLe
         +UxxBXH8b/HT6c0zLHjgYZvRnUbo9S46j32xvFyxDwjlmIrJrYRuLIHNNExz3cdzkcDt
         iXVUcUBrLyx8O4gm1t+ByOKkLXo/H2tA+IQ0tEN4iYRbErpNke1ZxQMj+Rf+GE0uD7sz
         jvuj81HaO+VhlIeJUowToqpD+4LuHMx4fAxo1YQcPnykUFxrtCYrEXRazwR/6Loqd+LX
         8E1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwYWNwDo0PJSOOl8Fc39UYkRkuQ6wFxNlAsApm+P/zwuKRR0/FMqb65KL1jRGrov1ZKG/9+ONMzXw1K6sUE3H0Icdlq89WTHPrnj46a7yKqQ==
X-Gm-Message-State: AOJu0Yw4ce/6dC97GF3wDmbqUYyb0VrvQzlik0lqLDk0+8ckHLUOxDsI
	8uCX2N8wB89UmiBB0WGQoCGtbQBPvshkG6Sf6idgzTVsRA8C8ZaSxo/fVFr3fOg9WJguBItKU+9
	TFXETcg==
X-Google-Smtp-Source: AGHT+IFBVRs2U0wkLF7xsLHWNZwSFSKC6tIGeoNNo9vmrHamsC+zOe3HgJ6keKdUYtHfpNieEtLOLv0MgajX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:220e:b0:dcb:bc80:8333 with SMTP
 id dm14-20020a056902220e00b00dcbbc808333mr212152ybb.13.1710395976722; Wed, 13
 Mar 2024 22:59:36 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:59 -0700
Message-Id: <20240314055919.1979781-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 00/20] Python generated Intel metrics
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Generate nineteen sets of additional metrics for Intel. Rapl and Idle
metrics aren't specific to Intel but are placed here for ease and
convenience. Smi and tsx metrics are added so they can be dropped from
the per model json files. There are four uncore sets of metrics and
eleven core metrics. Add a CheckPmu function to metric to simplify
detecting the presence of hybrid PMUs in events.

The patches should be applied on top of:
https://lore.kernel.org/lkml/20240314055051.1960527-1-irogers@google.com/

v3. Swap tsx and CheckPMU patches that were in the wrong order. Some
    minor code cleanup changes. Drop reference to merged fix for
    umasks/occ_sel in PCU events and for cstate metrics.
v2. Drop the cycles breakdown in favor of having it as a common
    metric, spelling and other improvements suggested by Kan Liang
    <kan.liang@linux.intel.com>.

Ian Rogers (20):
  perf jevents: Add RAPL metrics for all Intel models
  perf jevents: Add idle metric for Intel models
  perf jevents: Add smi metric group for Intel models
  perf jevents: Add CheckPmu to see if a PMU is in loaded json events
  perf jevents: Add tsx metric group for Intel models
  perf jevents: Add br metric group for branch statistics on Intel
  perf jevents: Add software prefetch (swpf) metric group for Intel
  perf jevents: Add ports metric group giving utilization on Intel
  perf jevents: Add L2 metrics for Intel
  perf jevents: Add load store breakdown metrics ldst for Intel
  perf jevents: Add ILP metrics for Intel
  perf jevents: Add context switch metrics for Intel
  perf jevents: Add FPU metrics for Intel
  perf jevents: Add Miss Level Parallelism (MLP) metric for Intel
  perf jevents: Add mem_bw metric for Intel
  perf jevents: Add local/remote "mem" breakdown metrics for Intel
  perf jevents: Add dir breakdown metrics for Intel
  perf jevents: Add C-State metrics from the PCU PMU for Intel
  perf jevents: Add local/remote miss latency metrics for Intel
  perf jevents: Add upi_bw metric for Intel

 tools/perf/pmu-events/intel_metrics.py | 1022 +++++++++++++++++++++++-
 tools/perf/pmu-events/metric.py        |    8 +
 2 files changed, 1027 insertions(+), 3 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog

