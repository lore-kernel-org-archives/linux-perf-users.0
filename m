Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02BF35CB9C
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770159099; cv=none; b=OKDUFh0C6XTDO/EHxv2UhEn8/DBdRtGKAWWW3jfFc8ZCdWcroed7MPU9YPKiMoohMYOnnSGjYUVWZxzIFTYa+o0qDDt6SmImhPoT6ggBWW9QDed1Vam3NtdultsAWCvDqo9cg26degkBFG694qWFcVqhlEYZIeCIV88LxEezAAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770159099; c=relaxed/simple;
	bh=h/1vsRHU3S+xdCR+nLYZJVp1yyxzxQCwHkXUJFrO+x0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=LfskFu4Oo9s/lZIhT85j/Uchj8qhjy3KCKacihi0M4JSpn/7ndiQUbYQDcHcdE21nQ01Y0F+sKEpEvBycGpvHadf49JBWXkbeGE/Vnw2Er0GEas/PffHfsCR6a6l1GJdZoZmR1YBrnWKqPABG4nfhF00tEOOFAjHdQamqHABbac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tL1yx3gL; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tL1yx3gL"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b8343aa8a9so262130eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 14:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770159097; x=1770763897; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+EFbiW8bWL0xb8B2HqTNtuWO9Q87rV9NmMjNfPWayjw=;
        b=tL1yx3gLH2JiVjRB4+LNl5RCMxc/2ZeXty7m10grMkYiOP14LxAGJVbo8+WfwOAnyX
         jvStU9RKCGpTV2gRcFL+BwIlCalyq42id/ivcZQAX8bMYFx1Sug6aUWbmUDtQ9HAExGw
         TVEdjoKFqOrND0FRVUPBOXd3zSx1OV6eWhGvmiMlXOM69YozDd/YGcDVi7LmrSrvHtqK
         GQoe9bK30MzSbVp5aCPbm4DhUgCFefII1zxu1svSoJ/IzGCRExzkAVi6g/wMto8LBq39
         nPWSN3/ZDz8jtSpEU4cPNBSWv8683XRldboh2a+udI/Pk+nzjboxvyiWHlXkPyCJPz8F
         r3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770159097; x=1770763897;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+EFbiW8bWL0xb8B2HqTNtuWO9Q87rV9NmMjNfPWayjw=;
        b=sJPgRoJveq0LwgYugBfSsXY7jpCcFbK3v29Z5ZXANuRcVQSEVhYRBa0HUkuOcjforv
         rdf38lUMAcEp1YVbaYbiLWqpy1bZjTlMugxPWvOJGM1xnfI6Nq+76YzaqRPQ3UTd6zGx
         EO/mXkNQXVB3ibhI0qhGQ6vmlW2XyhQDs3e+KikSjrQfS1hvQsxw3tppFruP8Nvi0kBk
         dQzvQ7qUrwKbVMEd3I6OtYjX52EYwk2wS0p7qZFbq5sxl/zCEEIR3tErPOoEWqPzVEcY
         NFEyPC12SN9HxLuJHtgXH30HK13s0tO54eHZib/dckQY1SPtULCJO4E/b2h0Rb7qWXQI
         O44w==
X-Forwarded-Encrypted: i=1; AJvYcCUDKlmfRn0fJ01qCHEor5tPSbKvvNeDSAstDVennJkE2INcOe7dahI2oGxoZ4hm4xE9NVDOiuKopfEpoTXgkp8/@vger.kernel.org
X-Gm-Message-State: AOJu0YzoKozWmFgdNme3L63uz7lV3N+lhVakDmQQxRMlkE/5V80zDNDS
	fTea8tTMj5NDbPNjfzF8+7YCmz1QlAhW1sFTRjDSsMCxWTyYvY7huBWscOHXSn/8VmMVc/k6Cqm
	Baxm36wpgRA==
X-Received: from dycmg16.prod.google.com ([2002:a05:693c:2510:b0:2b7:f4a6:656d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:df4a:b0:2b7:4118:88aa
 with SMTP id 5a478bee46e88-2b832a3eed8mr424949eec.35.1770159096961; Tue, 03
 Feb 2026 14:51:36 -0800 (PST)
Date: Tue,  3 Feb 2026 14:51:23 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203225129.4077140-1-irogers@google.com>
Subject: [PATCH v7 0/6] perf stat affinity changes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Andres Freund <andres@anarazel.de>
Content-Type: text/plain; charset="UTF-8"

Change how affinities work with evlist__for_each_cpu. Move the
affinity code into the iterator to simplify setting it up. Detect when
affinities will and won't be profitable, for example a tool event and
a regular perf event (or read group) may face less delay from a single
IPI for the event read than from a call to sched_setaffinity. Add a
 --no-affinity flag to perf stat to allow affinities to be disabled.

v7: Revert "perf tool_pmu: More accurately set the cpus for tool
    events" that caused issues with user specified CPUs (Andres Freund
    <andres@anarazel.de>). Fix a null test is prepare_metric so that
    missing events can't trigger segfaults (Andres Freund). Make the
    CPU map propagation improve the CPU maps for tool events that only
    read on index 0, this allows later setting when
    evlist__create_maps is called with the correct user CPUs. Rebase
    previous non-merged affinity changes that hadn't been picked up
    yet.

v6: Drop merged tool event change. Move TPEBS fix into its own patch
    1st.
https://lore.kernel.org/lkml/20260108212652.768875-1-irogers@google.com/

v5: Drop merged changes. Move tool event reading to first
    patch. Change --no-affinity flag to --affinity/--no-affinity flag.
https://lore.kernel.org/lkml/20251118211326.1840989-1-irogers@google.com/
    On v5 there was discussion with Andi Kleen who points out that
    affinities will work better with real time priorities but using
    this requires privileges.

v4: Rebase. Add patch to reduce scope of walltime_nsec_stats now that
    the legacy metric code is no more. Minor tweak to the ru_stats
    clean up.
https://lore.kernel.org/lkml/20251113180517.44096-1-irogers@google.com/

v3: Add affinity clean ups and read tool events last.
https://lore.kernel.org/lkml/20251106071241.141234-1-irogers@google.com/

v2: Fixed an aggregation index issue:
https://lore.kernel.org/lkml/20251104234148.3103176-2-irogers@google.com/

v1:
https://lore.kernel.org/lkml/20251104053449.1208800-1-irogers@google.com/

Ian Rogers (6):
  Revert "perf tool_pmu: More accurately set the cpus for tool events"
  perf stat-shadow: In prepare_metric fix guard on reading NULL
    perf_stat_evsel
  perf evlist: Special map propagation for tool events that read on 1
    CPU
  perf evlist: Missing TPEBS close in evlist__close
  perf evlist: Reduce affinity use and move into iterator, fix no
    affinity
  perf stat: Add no-affinity flag

 tools/lib/perf/evlist.c                 |  36 +++++-
 tools/lib/perf/include/internal/evsel.h |   2 +
 tools/perf/Documentation/perf-stat.txt  |   4 +
 tools/perf/builtin-stat.c               | 114 ++++++++---------
 tools/perf/util/evlist.c                | 156 +++++++++++++++---------
 tools/perf/util/evlist.h                |  27 ++--
 tools/perf/util/parse-events.c          |  10 +-
 tools/perf/util/pmu.c                   |  23 ++++
 tools/perf/util/pmu.h                   |   3 +
 tools/perf/util/stat-shadow.c           |   7 +-
 tools/perf/util/tool_pmu.c              |  19 ---
 tools/perf/util/tool_pmu.h              |   1 -
 12 files changed, 237 insertions(+), 165 deletions(-)

-- 
2.53.0.rc2.204.g2597b5adb4-goog

