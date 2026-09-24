Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E80539CCF6
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228278; cv=none; b=f+9E33PKYZtZ7FxTo0l1ujtY4BD4Tt6QFXUj6Lb/1SLZC5g3TwyzGkIqEuL2xFugiylGhQfldTyLhfisCFOLtORv8Udon0Vp1DvZIuHJQ6lWrQpklVqRdKD6KGG9/54JzD8xgLFQ99ucXme4c3XRW9xN3AhoN2gryTnr6WTBZFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228278; c=relaxed/simple;
	bh=fDk5GdApUadjdygFiasINCNUJscGRsJjlV96y1ofym0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=M/D6TFsQ1GxBSrvvAdkIaNFHVDwaKMA1VKgGsk+6NUg5pUiG5oByBJdqc1x+SuCJ4t137fgjjxZy8P7F85X9tfz7nX+PyWOZDCPXxgl5HFXkTRCdzbdNWmTKa/N0V1wzqLE9GJyyZegwDnS05hfhLIRIIHXDGYqCRNPBqwJzeL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g6NHEUnd; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g6NHEUnd"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33713e5e6daso2210118eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 22:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790228273; x=1790833073; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LKcxQKTHQGvqx8RHJW0lxJYngXd64s+UkdCmethd5VY=;
        b=g6NHEUndymsqyHo3g93MaaqABgGKGcT8+g28fX1LLIyHe0V82ROlb328hmuQ5UVnze
         ZjGmCL/iBOBcyjxeYDak83q6s+tgprQFik1ch43vvFElsdOx1+I8w7tUM3/W4qvBVfkw
         phAXYnNms/AE6lZF5Xt/nMc/Wig5Ky41lMHhIWpFLFkkNyUEzi6va5Pujwghowqegca7
         oFyCQnUUCcYCsaMdjy1Bg1xAU6sNaoqP7zYllHeFrV/D9nMhekDhO6KJpf/ydVW24ASS
         KffdxrZFA2i5fchY1nASq5HvXb1fWcMeldpfeeWrMQFKmAP93e8443RRxAPfM1OGjfJn
         sZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790228273; x=1790833073;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LKcxQKTHQGvqx8RHJW0lxJYngXd64s+UkdCmethd5VY=;
        b=xzU+ZC7mmkYNmk53AdFdHRdSzamFAQGoiz9vyXvhjJiyQ1z6sCXw9xhmB+iEzYq6dV
         S0B8HvRERWW72KatnDboMWI6JAhCsZcDgT+CJ6hhz/g8Ch4Ro1ffvjDMRueuA0QKiQ3k
         0n180hrEIyetEdgMyeeiLLlbuGo4LfHLExRGS4FJfatA2Kolq625XtZ+/WpKsLDf56Y/
         0K13Mrgrmk3RaAPpYYS9UjykADK+fdrtSfkNeiE7w2hpgLXdo97jUTaxLLfeFQX2v9NI
         ZpSFnB7VHjXHXeLfFnaXtiiCdEvkdObFQh084zR5LLDgdOaVC1iTlGr+dmjeQA4n2Akb
         dOog==
X-Forwarded-Encrypted: i=1; AKwUvBzh55Pub9BHfUIzNA4/KgpUZ/kX/V03Ga9T7Tj5YaQJGbccT9lOLN3mVusPXWLxgY1iMD4Ay5T2cHlyCRAZm2ra@vger.kernel.org
X-Gm-Message-State: AFuF++m37h/FNWfIeLPmpdAoa8IHadoG1r6b7QzrjELkj9Sq3Zd1v+s1
	/CRemaOgGBj2JzWFBF5sPawFt+AYaYFqNCVtFcZQL9LOxZP0+cNqP1RKIxPW6tyWG6yujTY0bcN
	gjCqYIsbNiw==
X-Received: from dysr15-n2.prod.google.com ([2002:a05:693c:88cf:20b0:33c:183:ed83])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:33a4:b0:33c:6e0:3cd7
 with SMTP id 5a478bee46e88-33ffe341a99mr1039528eec.1.1790228272766; Wed, 23
 Sep 2026 22:37:52 -0700 (PDT)
Date: Wed, 23 Sep 2026 22:36:24 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924053645.3555041-1-irogers@google.com>
Subject: [PATCH v1 00/21] perf vendor events intel: update
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sync the Linux kernel perf PMU event json with the latest upstream
Intel perfmon repository. The updates were created by running:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Ian Rogers (21):
  perf vendor events intel: Update alderlake events from 1.40 to 1.41
  perf vendor events intel: Update alderlaken events from 1.40 to 1.41
  perf vendor events intel: Update arrowlake events from 1.20 to 1.21
  perf vendor events intel: Update broadwell metrics to TMA 5.2
  perf vendor events intel: Update cascadelakex metrics to TMA 5.2
  perf vendor events intel: Update emeraldrapids events from 1.24 to
    1.25
  perf vendor events intel: Update graniterapids events from 1.20 to
    1.21
  perf vendor events intel: Update haswell metrics to TMA 5.2
  perf vendor events intel: Update icelake events to 1.25 and TMA
    metrics to 5.2
  perf vendor events intel: Update icelakex events to 1.31 and TMA
    metrics to 5.2
  perf vendor events intel: Update ivybridge metrics to TMA 5.2
  perf vendor events intel: Update ivytown metrics to TMA 5.2
  perf vendor events intel: Update jaketown metrics to TMA 5.2
  perf vendor events intel: Update meteorlake events from 1.22 to 1.23
  perf vendor events intel: Update novalake events from 1.00 to 1.04
  perf vendor events intel: Update pantherlake events from 1.07 to 1.08
  perf vendor events intel: Update rocketlake events from 1.04 to 1.06
  perf vendor events intel: Update sandybridge metrics to TMA 5.2
  perf vendor events intel: Update sapphirerapids events from 1.39 to
    1.40
  perf vendor events intel: Update skylake metrics to TMA 5.2
  perf vendor events intel: Update tigerlake events to 1.20 and TMA
    metrics to 5.2

 .../pmu-events/arch/x86/alderlake/cache.json  |   4 +-
 .../pmu-events/arch/x86/alderlake/memory.json |  13 +
 .../pmu-events/arch/x86/alderlake/other.json  |  10 +
 .../arch/x86/alderlake/pipeline.json          |   6 +-
 .../pmu-events/arch/x86/alderlaken/cache.json |   4 +-
 .../pmu-events/arch/x86/arrowlake/other.json  |  19 +
 .../arch/x86/arrowlake/pipeline.json          |   8 +-
 .../arch/x86/broadwell/bdw-metrics.json       |  51 +-
 .../arch/x86/broadwell/metricgroups.json      |   3 +-
 .../arch/x86/broadwellde/bdwde-metrics.json   |  49 +-
 .../arch/x86/broadwellde/metricgroups.json    |   3 +-
 .../arch/x86/broadwellx/bdx-metrics.json      |  63 +--
 .../arch/x86/broadwellx/metricgroups.json     |   3 +-
 .../arch/x86/cascadelakex/clx-metrics.json    |  94 ++--
 .../arch/x86/cascadelakex/metricgroups.json   |   3 +-
 .../arch/x86/emeraldrapids/cache.json         |   2 +-
 .../arch/x86/emeraldrapids/memory.json        |  35 ++
 .../arch/x86/emeraldrapids/other.json         |   9 +
 .../arch/x86/emeraldrapids/pipeline.json      |  10 +-
 .../arch/x86/emeraldrapids/uncore-io.json     |  53 +-
 .../arch/x86/graniterapids/other.json         |   9 +
 .../arch/x86/graniterapids/pipeline.json      |   6 +-
 .../arch/x86/graniterapids/uncore-cache.json  |  10 +
 .../arch/x86/graniterapids/uncore-io.json     |  12 +
 .../arch/x86/haswell/hsw-metrics.json         |  49 +-
 .../arch/x86/haswell/metricgroups.json        |   3 +-
 .../arch/x86/haswellx/hsx-metrics.json        |  61 +--
 .../arch/x86/haswellx/metricgroups.json       |   3 +-
 .../arch/x86/icelake/icl-metrics.json         |  84 ++-
 .../pmu-events/arch/x86/icelake/memory.json   |  24 +
 .../arch/x86/icelake/metricgroups.json        |   2 +-
 .../pmu-events/arch/x86/icelake/other.json    |   9 +
 .../pmu-events/arch/x86/icelake/pipeline.json |   9 +-
 .../arch/x86/icelakex/icx-metrics.json        | 101 ++--
 .../pmu-events/arch/x86/icelakex/memory.json  |  24 +
 .../arch/x86/icelakex/metricgroups.json       |   2 +-
 .../pmu-events/arch/x86/icelakex/other.json   |   9 +
 .../arch/x86/icelakex/pipeline.json           |   7 +-
 .../arch/x86/ivybridge/ivb-metrics.json       |  51 +-
 .../arch/x86/ivybridge/metricgroups.json      |   3 +-
 .../arch/x86/ivytown/ivt-metrics.json         |  63 +--
 .../arch/x86/ivytown/metricgroups.json        |   3 +-
 .../arch/x86/jaketown/jkt-metrics.json        |  41 +-
 .../arch/x86/jaketown/metricgroups.json       |   3 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  26 +-
 .../pmu-events/arch/x86/meteorlake/other.json |  10 +
 .../arch/x86/meteorlake/pipeline.json         |   6 +-
 .../pmu-events/arch/x86/novalake/cache.json   | 498 ++++++++++++++++-
 .../arch/x86/novalake/floating-point.json     | 405 ++++++++++++++
 .../arch/x86/novalake/frontend.json           | 147 ++++-
 .../pmu-events/arch/x86/novalake/memory.json  |  24 +
 .../pmu-events/arch/x86/novalake/other.json   | 213 ++++++++
 .../arch/x86/novalake/pipeline.json           | 504 +++++++++++++++++-
 .../arch/x86/novalake/virtual-memory.json     | 173 ++++++
 .../arch/x86/pantherlake/other.json           |  10 +
 .../arch/x86/pantherlake/pipeline.json        |   6 +-
 .../arch/x86/rocketlake/memory.json           |  24 +
 .../arch/x86/rocketlake/metricgroups.json     |   2 +-
 .../pmu-events/arch/x86/rocketlake/other.json |   9 +
 .../arch/x86/rocketlake/pipeline.json         |   9 +-
 .../arch/x86/rocketlake/rkl-metrics.json      |  84 ++-
 .../arch/x86/sandybridge/metricgroups.json    |   3 +-
 .../arch/x86/sandybridge/snb-metrics.json     |  35 +-
 .../arch/x86/sapphirerapids/cache.json        |   2 +-
 .../arch/x86/sapphirerapids/memory.json       |  35 ++
 .../arch/x86/sapphirerapids/metricgroups.json |   2 +-
 .../arch/x86/sapphirerapids/other.json        |   9 +
 .../arch/x86/sapphirerapids/pipeline.json     |  10 +-
 .../arch/x86/sapphirerapids/spr-metrics.json  |  93 ++--
 .../arch/x86/sapphirerapids/uncore-io.json    |  53 +-
 .../arch/x86/skylake/metricgroups.json        |   3 +-
 .../arch/x86/skylake/skl-metrics.json         |  59 +-
 .../arch/x86/skylakex/metricgroups.json       |   3 +-
 .../arch/x86/skylakex/skx-metrics.json        |  94 ++--
 .../arch/x86/tigerlake/metricgroups.json      |   2 +-
 .../pmu-events/arch/x86/tigerlake/other.json  |   9 +
 .../arch/x86/tigerlake/pipeline.json          |   7 +-
 .../arch/x86/tigerlake/tgl-metrics.json       |  82 +--
 78 files changed, 2896 insertions(+), 785 deletions(-)

-- 
2.56.0.rc1.310.g51773c2048-goog

