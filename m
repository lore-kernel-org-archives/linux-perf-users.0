Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181E518EFD1
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 04:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440691; cv=none; b=A3HUt2SpWB9X8DNNIsgZz0w+WVzjrihY3+HuXbticAUs4hhXlcBd0ySVIG/GoPIXwZkNbTvSEXaHhw6D1HrRvpQ/AxbM+2AiH6gaTxPqa74lF0nCzVC8JdeqnmdZbJ+MQZaGAfEuX5VtIMiAoeYVulr+qqGrju3R98PE1+1IJeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440691; c=relaxed/simple;
	bh=4UoujJZnTWWn7eKvPF04ekC/ngpIqDznOj6T67NFaP8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=JHbRXZQosHoR2xpcgy0kKCBmeEVwZDy3vr4iiwG0clo/iIuyAUQXPIYvoeZc+IA5DrWaZQsssCwxAnllUdKXf7UdfSX9CJ+pHbTSuvfJfYTrq2/2VkX6wFxa/TFI8x9flhgX3tzFR0UJCUdL5ksNgIR4gcfXJ/7rG/TmXZLwohc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ZYwbPGm; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ZYwbPGm"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2488490fe4eso23156065ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 21:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440689; x=1757045489; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FxsC/naorM5xTru//pbnhAvP7ObEaVPUG5IbOlXzuNw=;
        b=1ZYwbPGmMKxK5xwhLtaPbBnm85hT905O8XTuAmcfQ347yXQ60/8ucydf0mo+mdlKqX
         9jLhMyek88U3XhGhgxaWo1prqJzXqAc0RE6YKrUezJsmvfLE1vAvNh3wPnISg4tlixK1
         DckwP1txzJp+Yqt5PutrlFeYTF5VcW91rLSZzP2yrjnk1mWrlc8w+wgUq/3s6EG+t5A4
         fnIl5SLF23ZMsRh3+e6c+w51fAhTx5Yb0mJTt4z4ZISO/tYDfxRUENEOConr6lttGbzh
         7gZhc2l5STWcesxR5LDEW87mPtzzFQDL95Zp/jLlRV/bcfviByq3WBGqyK0ad97OhaNS
         C4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440689; x=1757045489;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FxsC/naorM5xTru//pbnhAvP7ObEaVPUG5IbOlXzuNw=;
        b=NO037agt3ed79goPjqNyflAqm4xTRXfoSH2SAj2Dc07jA+cA6C7g4ZrxKDVqhrlj81
         Ku9Zi3oUJzBmM5xcTLcXJtDY1/m0/1nlvnof8v5I+jtH8zzpQpcgY3uAsgU9L/ORFR62
         unlkhcJu4eQzwTERazgByawtVEUg7HcUDf/hwky0nWHBwjKdjCViaHE7MgcL6plCWOl9
         AE+BaKfpR82mfG341gP2n/93Mp/9smU0/9b4hhpGRAPSau8BROB8JADS4SCv+J+3+bqj
         RwJH833H3u2US8tFJkd/ekEfHyeY/4ov+ew+l6xbgkt7/ab5DnwnUlpAMU54FUsS04CD
         FaVA==
X-Forwarded-Encrypted: i=1; AJvYcCVYahJOjx+QT4w249gYRw1kWr32Wdc9K5sH0lFTk8zBAMLi2nn77fgoNnS22YRfPn/ydFtlCaz0tBM7kl3gwVpd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Uyyhu1KxaNA2W/OC8KSbFNHRa9hyrnXh8N0rWiOskcFZp22d
	+/wbMPz/oHYaNKJN8yfyIUadcVTXJFrOhMeXeijq3aVxsKTKZ0nJEIWQYW/znfA2Rrn2foh3ZNb
	n6zpG/NkpXQ==
X-Google-Smtp-Source: AGHT+IG6BQBohxB2EHEPxoIjH66taMfJuusQnHmTa/o4sIHYJOYdjf5dTNhCNbuwbzBXfKqkDuUVhQ9hGxSO
X-Received: from pjbx3.prod.google.com ([2002:a17:90a:3883:b0:327:e021:e61d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1205:b0:248:79d4:93b5
 with SMTP id d9443c01a7336-24879d497a4mr133009805ad.33.1756440689329; Thu, 28
 Aug 2025 21:11:29 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:10:41 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-1-irogers@google.com>
Subject: [PATCH v5 00/22] Python generated Intel metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Generate twenty sets of additional metrics for Intel. Rapl and Idle
metrics aren't specific to Intel but are placed here for ease and
convenience. Smi and tsx metrics are added so they can be dropped from
the per model json files. There are four uncore sets of metrics and
eleven core metrics. Add a CheckPmu function to metric to simplify
detecting the presence of hybrid PMUs in events. Metrics with
experimental events are flagged as experimental in their description.

The patches should be applied on top of:
https://lore.kernel.org/lkml/20250829033138.4166591-1-irogers@google.com/

v5. Rebase. Fix description for smi metric (Kan). Prefix all metric
    names with lpm_ (short for Linux Perf Metric) so that python
    generated metrics are clearly namespaced. Kan requested a
    namespace in his review:
    https://lore.kernel.org/lkml/43548903-b7c8-47c4-b1da-0258293ecbd4@linux.intel.com/

v4. Experimental metric descriptions. Add mesh bandwidth metric. Rebase.
    https://lore.kernel.org/lkml/20240926175035.408668-1-irogers@google.com/

v3. Swap tsx and CheckPMU patches that were in the wrong order. Some
    minor code cleanup changes. Drop reference to merged fix for
    umasks/occ_sel in PCU events and for cstate metrics.
    https://lore.kernel.org/lkml/20240314055919.1979781-1-irogers@google.com/

v2. Drop the cycles breakdown in favor of having it as a common
    metric, spelling and other improvements suggested by Kan Liang
    <kan.liang@linux.intel.com>.
    https://lore.kernel.org/lkml/20240301185559.2661241-1-irogers@google.com/

v1. https://lore.kernel.org/lkml/20240229001806.4158429-1-irogers@google.com/

Ian Rogers (22):
  perf jevents: Add RAPL metrics for all Intel models
  perf jevents: Add idle metric for Intel models
  perf jevents: Add CheckPmu to see if a PMU is in loaded json events
  perf jevents: Add smi metric group for Intel models
  perf jevents: Mark metrics with experimental events as experimental
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
  perf jevents: Add mesh bandwidth saturation metric for Intel

 tools/perf/pmu-events/intel_metrics.py | 1065 +++++++++++++++++++++++-
 tools/perf/pmu-events/metric.py        |   52 ++
 2 files changed, 1114 insertions(+), 3 deletions(-)

-- 
2.51.0.318.gd7df087d1a-goog

