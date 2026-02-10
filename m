Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63321E1DEC
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 06:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770703427; cv=none; b=nxtYMXLlSU+M648YiDWNarNFxeo5PIbVcBeRPIgKzCaoFhF75kE3Gwve6Kf7+mt5hRDyegVKlOSex0+uifRFAZ9LRdx9eoFy0tTuTCP7mOhrPocqNo1DvhfYWWhycwzx0O9W5yPcKEic+Dc2TrNRfZOAX3+odeH1tENgq8qnjmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770703427; c=relaxed/simple;
	bh=Zfybov18wp+XKF9zfziT3A7XQ8Rz6pik8UZSDbDPmuE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eyB7duBdLidb7YfAkeJFPA5A4nKQBBs//wv4fBu5V1HImYP1zAIBhrNH7eBHBuwJk9aT11QoXo9vEsCwVqwpxEIktyHnO/xMRltOF0l2RLfe24HvEWsuB4NrvLega2GdWW6lOd9N7VIaOaZJwS5Xeg1cj/3Aw9HanlKPPIw4nmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eLIm8aI7; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eLIm8aI7"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba7e98178fso657856eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 22:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770703425; x=1771308225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V+3dGOJiTRqCZMxIxulRVBleFQcYgURizALb+zOiPC8=;
        b=eLIm8aI7ijpTDrCbCG5AunASFG0QfAgezNIcHabBmZCdor070GLr5zQV9KwSNuDyq0
         LT9ZKNKdol6M6KEXpbPXUfiQgcucIocxfT5C6tz7STfAAKAx+OcD/1uux94MQDaq9I8o
         4gfnBAplGlqwk+n3FuIqUgEdKkVNLWzbF1ifHSCJHHgxrIhXPL7AVQF+WyDG74qJfKxZ
         kXBjJ1uO7QqO9MRDWPxAPFMS8TZ95rLBph71e/I4tH1LspPd0YOs/uQRhWiu+MX0e1SA
         9oD50AeEfln4S1J9PGWNRHzdiBSi7Kf+esTYE/aXOoQSKvkfh12Xdm6ElnldsqNYA64e
         3Hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770703425; x=1771308225;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+3dGOJiTRqCZMxIxulRVBleFQcYgURizALb+zOiPC8=;
        b=Vp8TPiApvpBX4W+m1d6AdHQcmp9eWt6NUgBZpf+8JaXpO0vhtT+xkZuqPXzo00fRY1
         oQz4cnDsEGJdA/QDUyoIrnJNnJMIg/NHSYTPp4LkuJP5/m913JymWNy37CPW3dRm36h4
         3NGlRM7RqztR+j+CgO4ybJYrh04WOCPphe8Mq1kF001FxTc6x5ADasSGML5HWSzo6nqt
         XV047UPEciZff5l68Up8SzdoLx8mMBRoUL+9WhH3acbne6nniMjWfOoRbuuWl63noVVh
         nD1tThaHsWhwG7htUt9GNIRWXA7dZ2w+3rsYnee6tPoRZs7kMv1Sx1nf8VV4shOXTvm6
         mCSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpr82x/VAauy7VmlrjpDN7liPC4uAgCwJWDGNWj1VmjZJDtQnAsVQ9Zj1s8F80K+WqebONNAeJBM5SfiVcAW5+@vger.kernel.org
X-Gm-Message-State: AOJu0Yypz27ecx7bhJvX/1gdRnh/hBE4gkkRtT8W8Go3T9e6jJyRYKDX
	+SjrpQ6lGSDU01h+G7y2KUXzuClADDURoYordvtwLdPWYVB6oLcSIdVBG6Fqa3ApbL8SyoqPB5a
	dj7Y0wmR2Tg==
X-Received: from dys18.prod.google.com ([2002:a05:693c:8012:b0:2ba:702b:a4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e426:b0:2b4:5514:38fd
 with SMTP id 5a478bee46e88-2b8567240camr6093868eec.20.1770703424823; Mon, 09
 Feb 2026 22:03:44 -0800 (PST)
Date: Mon,  9 Feb 2026 22:03:25 -0800
In-Reply-To: <aYqHTfCoW1bGmJF4@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aYqHTfCoW1bGmJF4@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260210060331.2233216-1-irogers@google.com>
Subject: [PATCH v9 0/6] perf stat affinity changes
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: acme@kernel.org, adrian.hunter@intel.com, ak@linux.intel.com, 
	alexander.shishkin@linux.intel.com, andres@anarazel.de, 
	dapeng1.mi@linux.intel.com, irogers@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	peterz@infradead.org, thomas.falcon@intel.com, tmricht@linux.ibm.com, 
	yang.lee@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Change how affinities work with evlist__for_each_cpu. Move the
affinity code into the iterator to simplify setting it up. Detect when
affinities will and won't be profitable, for example a tool event and
a regular perf event (or read group) may face less delay from a single
IPI for the event read than from a call to sched_setaffinity. Add a
 --no-affinity flag to perf stat to allow affinities to be disabled.

v9: Fix command line comment for --affinity (Arnaldo, Namhyung)

v8: Rebase, due to minor conflict with:
https://lore.kernel.org/lkml/20260203230733.1474840-1-ctshao@google.com/
https://lore.kernel.org/lkml/20260206222509.982489-1-irogers@google.com/

v7: Revert "perf tool_pmu: More accurately set the cpus for tool
    events" that caused issues with user specified CPUs (Andres Freund
    <andres@anarazel.de>). Fix a null test is prepare_metric so that
    missing events can't trigger segfaults (Andres Freund). Make the
    CPU map propagation improve the CPU maps for tool events that only
    read on index 0, this allows later setting when
    evlist__create_maps is called with the correct user CPUs. Rebase
    previous non-merged affinity changes that hadn't been picked up
    yet.
https://lore.kernel.org/lkml/20260203225129.4077140-1-irogers@google.com/

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
 tools/perf/Documentation/perf-stat.txt  |   5 +
 tools/perf/builtin-stat.c               | 114 ++++++++---------
 tools/perf/util/evlist.c                | 156 +++++++++++++++---------
 tools/perf/util/evlist.h                |  27 ++--
 tools/perf/util/parse-events.c          |  10 +-
 tools/perf/util/pmu.c                   |  23 ++++
 tools/perf/util/pmu.h                   |   3 +
 tools/perf/util/stat-shadow.c           |  24 ++--
 tools/perf/util/tool_pmu.c              |  19 ---
 tools/perf/util/tool_pmu.h              |   1 -
 12 files changed, 250 insertions(+), 170 deletions(-)

-- 
2.53.0.rc2.204.g2597b5adb4-goog

