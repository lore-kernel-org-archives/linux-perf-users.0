Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABA3156665
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373046; cv=none; b=rywo8kxNkG/UnLsppQFaS8n0WUaS7KTJ+BCmdtyLCw9rcYT1jgOrAkuB7SZC6XY0Ep2l8yEs5kSelrEptQKlYHEKH6kSXkzz5P8BQjHr6AwsGX61sWviEjwgkmOzlX6M+sJ0szVLv5gkkLQrwvyxiatwmXZpUCyXo63EhMBPSWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373046; c=relaxed/simple;
	bh=ov/TAlvdMAcCcocKl4WI6KQsu/GEvEkh2XbLm61JsHI=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=UzhjZn+RRYqESDBKdPSNsrVpGzmocrQRbtkau4ZHnRmJyBIN/2hK5DiFAoThIeeFqzBGjb+jAelBIDnqjtHO9K6gElqsNpBB58vbJDmQiK18kR477mqODS0jgl0gsD4SzprC0wBENb3WVG3gg+ylXbrugTmQYrTQGHio2Yrw7V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FcrfJlq/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FcrfJlq/"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e21dcc7044so24660517b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373043; x=1727977843; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JvSamZqIAhjdfYEY8+najrPm2eihOyHwiLOs5JRJ4Gc=;
        b=FcrfJlq/oW4a0eRILyvNfgdgRb89uaKLHvffE+oiDx/1u42hRw8go+IWrQK4LGn0Au
         n+LX25FwAhKsYApanmE6pylTox/LgV+C6zHC9jNbcB60tGFqZlKVOhzfCA+yxlG1hHsA
         Ay1+vuOqPBa2zBIfT4Wr6DXedYsNR7iNsh9sBqZJ0zXfWXiFqNvZKYx2IXrw9I/SFYVw
         D50yfDL2C1wxudDJ0Ci7hxAJzkfEG7+yop3Z2mAmkXa9BVSND4uo5brBJz5jEC0U2zA6
         9gLUixOraknHckVNcxvhVuQtYpvJZSC46tQXdz4fbP7aBeTKjpAze2cGsVHIsO7uuFWb
         oVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373043; x=1727977843;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JvSamZqIAhjdfYEY8+najrPm2eihOyHwiLOs5JRJ4Gc=;
        b=vBSL22RRdzAl8TttUMxwN/MSwlmxdWq+1lt3GwOf2AwiqlEP31KGyxht68SQGrJoMi
         bg6q7/FbI6t0DZnzF/TIo7KYmRkdTiAtPD4m3hyIfYlL1lpgqU21/GzJdcpw+LwcVf4V
         qrx2ckzO89dlnkBzzSrUftYe86eMaylWg4PUVulAGP2EPwH1GUyQBgoxq+fVmC5ALR53
         qIfpJQRxNunLhnkxrJi2QL5gHjYidzclYJQcr07bI28ntJ9/P7DZaSUVx0JeDGFoPSmV
         lng8eayoo4nvO2t3RAja/NWBfzW4E5P/mVyz1DEFsIJpx1YCeqzqwAqUp8hDUmJ1XcV9
         FJdA==
X-Forwarded-Encrypted: i=1; AJvYcCUNrFo6t0gP/54rUkKWtezUA37D6FJAs7qybCF6Y/IpxBcwl8WLOxxLXp5wv3OI/XRlBbAkBUN4rfb9knuKgtWv@vger.kernel.org
X-Gm-Message-State: AOJu0YzPvlxKUkrYxwj+7l2SAkVT/zmN6MrOUL+dCCE13ZlG8o/pW45g
	tcteFYHsIbuQUzLvhBzV4xY/1T473UINhmSsJsHbFluMlEZ/qGof3no4APUQULAwMivSBFxKAxj
	mOqUpiw==
X-Google-Smtp-Source: AGHT+IE94gNIgVpsH2JG372X3pJtADKswnMsg7TvS0BThvzWmkQiPK4fbz8enpa0vH5yOF+Hp9JB+rFTzvYS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a25:26cc:0:b0:e1d:7ce:4844 with SMTP id
 3f1490d57ef6-e2604b3bbd2mr342276.4.1727373043021; Thu, 26 Sep 2024 10:50:43
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:13 -0700
Message-Id: <20240926175035.408668-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 00/22] Python generated Intel metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

Generate twenty sets of additional metrics for Intel. Rapl and Idle
metrics aren't specific to Intel but are placed here for ease and
convenience. Smi and tsx metrics are added so they can be dropped from
the per model json files. There are four uncore sets of metrics and
eleven core metrics. Add a CheckPmu function to metric to simplify
detecting the presence of hybrid PMUs in events. Metrics with
experimental events are flagged as experimental in their description.

The patches should be applied on top of:
https://lore.kernel.org/lkml/20240926174101.406874-1-irogers@google.com/

v4. Experimental metric descriptions. Add mesh bandwidth metric. Rebase.
v3. Swap tsx and CheckPMU patches that were in the wrong order. Some
    minor code cleanup changes. Drop reference to merged fix for
    umasks/occ_sel in PCU events and for cstate metrics.
v2. Drop the cycles breakdown in favor of having it as a common
    metric, spelling and other improvements suggested by Kan Liang
    <kan.liang@linux.intel.com>.

Ian Rogers (22):
  perf jevents: Add RAPL metrics for all Intel models
  perf jevents: Add idle metric for Intel models
  perf jevents: Add smi metric group for Intel models
  perf jevents: Add CheckPmu to see if a PMU is in loaded json events
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

 tools/perf/pmu-events/intel_metrics.py | 1046 +++++++++++++++++++++++-
 tools/perf/pmu-events/metric.py        |   52 ++
 2 files changed, 1095 insertions(+), 3 deletions(-)

-- 
2.46.1.824.gd892dcdcdd-goog

