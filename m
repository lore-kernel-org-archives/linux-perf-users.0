Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DA22575F
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319376; cv=none; b=Xyp1/2vuoSngMOHg+eMOXEy1kLfA47WYZOBhAVHFMflhZqNUGX2rsOkr6e/sEtEUUJ5i0HNe0NE8t5CL9qQqitIFqvdLorC3TDhIHYfjxq7EOuOuAN/uaepzwUisz14GMWRSlVFT2zJ7G2xR3m+5XLhizPBVPXwgfQLti0v2Uvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319376; c=relaxed/simple;
	bh=s4bOpKkEyr3a4raxuApEAoRlDPTKEZCi/jhQ8r/Irq8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ZNUwKEz4cAJ14b+qsM8svPIjV8neXZ/Is0iUtPJS5XIkkqi26pok0a8PrLNTi1f+HJO9drL/fj/iVJzhlqXTjsYXy4WhV0EOvgonkRSf5iD44Wd8dZjLMfaEtpDiCjMZ3b87O+E1qGkXNMLUpCIsKDQ1+jvO+6QapzMUt5Tq3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1smm4ibY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1smm4ibY"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso4240148276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 10:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319373; x=1709924173; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EcOYmXkq65ioOJSl10z1+hp5KpsWk2JUO79k5YV9sVg=;
        b=1smm4ibYfmArau7YMzRBeEjbBm49i/CsXhHDQLRMnS1RoyEUKDp2J9MHSjx31c0wnw
         GVBzZ5UTz1q+uKPf8Wtgcy5R8pvUdm4K03HrtFyuXR+3dABt6bWohBhpaXOXEgSqdQhy
         LD72BL8eMcwEjM9lEdascvpEhbvhGFzmOH31IRbhjpgQFIjZ7nVm276QPjxeArD/1qqY
         GKMX2kaDIMPYzqc8o9ahHHAyx4+W7vQ1F1lKnXykjrct96uGn8ytrtia+KXgo+kO7gd9
         13VE7rlR363nz1h53cMncMSegA/BaQ63r1jxz/4Cw4A+a+Dxi4Q9SBOn4F7yKGzawLXk
         OJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319373; x=1709924173;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EcOYmXkq65ioOJSl10z1+hp5KpsWk2JUO79k5YV9sVg=;
        b=la+KkfxM4vaIh2Yy7FFGccFkUMUrCf3J/GrcNsSX1iyeDYknmizxoGpBti5tFzEakt
         JlcRqeKxi2CEnaT/C0atQNfCIVmLC4knBDu+TYTdiJquzl1TzXU6mF8UVm4ZPonuQaEJ
         Ic5NQGFyfsKDwQq3/MGdpeh/XfS6O58AQfEo9cX3Uwbd5qV6Zt1vIxl5KErKeIbywavO
         hL5NINeWopbT6HgGSCDrmsu0MY8YEp1GTACsHS7Y+55RwI12zz0lKeZcq9pkPzsowLJM
         0zKUf4pxPg8x1eY3b+iDHklZbVJ8COx7X5D+h/55A28xTGK3z+VuDBIjLRkPOFZQ0FqN
         dNVg==
X-Forwarded-Encrypted: i=1; AJvYcCWpKWkWk8JNXeBgvWwxCEr8BTjSC3M6YFrWq0t6Wi9L5vBnoPGwTGfsCSWpJAznxYyj5vxOumYHgIzMS72azT6Kg+AdZZ7CrAUP3ghmcLNV3g==
X-Gm-Message-State: AOJu0YyzJV0ntx+u3TT+V92fGMTg1TnfxOblKsd7enmi3Q3Ed75b6RFC
	mKvV/ruMRnuf8pBFQOrCAYoYdRKVPnhB7proQp2CWX7lU1ZPNhDFD2envEJriIhPH2bh3VPaUrh
	XJ+cOgg==
X-Google-Smtp-Source: AGHT+IEOwR1WhD2r8OkY2eAG5BVEXVGAIhJ03e9RybE9XCQau2Lv0BzDpkHR3mIFTsdrfZQtp0wEQxqkgqKN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a25:aba3:0:b0:dc8:27e6:cde1 with SMTP id
 v32-20020a25aba3000000b00dc827e6cde1mr95220ybi.5.1709319373729; Fri, 01 Mar
 2024 10:56:13 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:39 -0800
Message-Id: <20240301185559.2661241-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 00/20] Python generated Intel metrics
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

The cstate metrics require the event encoding fix of:
https://lore.kernel.org/lkml/20240228170529.4035675-1-irogers@google.com/

The patches should be applied on top of:
https://lore.kernel.org/lkml/20240228175617.4049201-1-irogers@google.com/

v2. Drop the cycles breakdown in favor of having it as a common
    metric, spelling and other improvements suggested by Kan Liang
    <kan.liang@linux.intel.com>.

Ian Rogers (20):
  perf jevents: Add RAPL metrics for all Intel models
  perf jevents: Add idle metric for Intel models
  perf jevents: Add smi metric group for Intel models
  perf jevents: Add tsx metric group for Intel models
  perf jevents: Add CheckPmu to see if a PMU is in loaded json events
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

 tools/perf/pmu-events/intel_metrics.py | 1023 +++++++++++++++++++++++-
 tools/perf/pmu-events/metric.py        |    7 +
 2 files changed, 1027 insertions(+), 3 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog

