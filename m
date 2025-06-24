Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1154F307496
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 23:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807144; cv=none; b=UgBWejJoPU/manHUx1Y53AmP5dc4HDVxl8nb7HUFWD7JSVtbwdW4k+Z0pQoxobbU8hnRSSvCQoDnx7S1jCPQjQoDmxv37TiFsj52SADnkNBwz7DS2KesYGooOCkS1NtIoPDT9bMp1auN9hGv/LE+LXcVjmXYrhwTAR+vNA23HB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807144; c=relaxed/simple;
	bh=qsd+J5obkf/JJPWjGyBw6D2rofd/ROvvLqQ/ikiIxws=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UNS0gizCDvqxsReBfSsCNxkvViwYefYr9LeDuADpY+VNBbgZK0jNyHm68vCpsTTF6OkdIS4brX/IjXNnwITzf818XOx4QFUvQWBDLQuqEST91uSoSeB0LsUAIhRQj8RkftQfSDohmVhqIoWOvefRlnFdogy3ziI/o0ACuuXu+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FCAKFo6r; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FCAKFo6r"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7425efba1a3so251759b3a.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 16:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750807142; x=1751411942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pngvqSmCovapbXdYFYPO9SgyKEbtBPIrkfwlrt81RZ0=;
        b=FCAKFo6rxAwpqw1D95y3R5wTVVWRO7J4Cm/vD49uCvkk5oFHYHcI+hPsYEESHjCGim
         b4F+A30bRBiConuFHZFHdU8RXXWbQmMbMXZbdwZi7sxg3SGQXv2sTGXUBAlGWjQuCOtl
         +IRqHdN8fI51+DmyZbW1f0UF6AusfG9j/4Y9XyywBCzmES3BHt9KTnvx5kxLTqMXP0gp
         ZdKnF9AOgZT4oRPtCwee4t69DujvWFxXLP6GHITKP+CYMWCucbdKijxuDr7dCSGIrx3m
         oLzT7KJ7deEPM503AyfvdVDLfWt2LeDgOjlWYmg2RtH0ZxKqwchhzm+nSdbISxAKUqbJ
         1ZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750807142; x=1751411942;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pngvqSmCovapbXdYFYPO9SgyKEbtBPIrkfwlrt81RZ0=;
        b=woXgOTXzSQrO/hTG/k/k/MZ/4+ieSW1XytW6lZ+ZwjKr4r4LTkgFQMMxaYrwpegdzp
         o9nf9UTjcJDHVaOPNG0DDPPzvX7OWVpYcd3Q3LFpBW85zFQrpjZgvzDeCkbtDfUayUnW
         XB2s3CTilKo1R2MUvbcI5fpajWlUMpdrTeSKh+e7a7umViZ8ek0eZb7P6dTKUpL1VnfL
         6QE3cW5pXqWIpgmMDBfvwfvuQjVUoWfdm6I4BGn7evMblOKSunMK5U65DGOp6UR0Ke9q
         qi/PpKwxMCODHXAHxDrUTdR0RQDkm0N+Pm1ww5Wq78bxkrRK+LTrexK3tu5oAasnfNQD
         W3Og==
X-Forwarded-Encrypted: i=1; AJvYcCXyzJRD53hHdP7L8THMetdC2KiVOqC+5bI4TWB1t2oqCDcvBcKQi4dd+BnaIrceisohY2Ap9JVlrWtJPKpRv+cf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx96BE2rAF7OQuio0Z4LQC41qaPTbFhmqaCv6X0z6ZC+dNEdon5
	lcO99SWRPoZW2nB6TGjORdZWK2J3Ih1WgKajYq0y31KJ/I5+s5tuXiJeRkxLp3l4UfVtbspLbPl
	784/wd2gVaw==
X-Google-Smtp-Source: AGHT+IFV3B9OhuWzDeSllzGXDR7OZvOBgi6Pi0GJ0cqbrlPswzFv236wUfDx8y9GXBFd4lYwDCtu44HkGh5n
X-Received: from pfbki22.prod.google.com ([2002:a05:6a00:9496:b0:748:da37:7e37])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1891:b0:744:a240:fb1b
 with SMTP id d2e1a72fcca58-74ad4bf80dcmr1309549b3a.5.1750807142180; Tue, 24
 Jun 2025 16:19:02 -0700 (PDT)
Date: Tue, 24 Jun 2025 16:18:34 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250624231837.179536-1-irogers@google.com>
Subject: [PATCH v4 0/3] Add support for a DRM tool like PMU
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Junhao He <hejunhao3@huawei.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, matthew.olson@intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

DRM clients expose information through usage stats as documented in
Documentation/gpu/drm-usage-stats.rst (available online at
https://docs.kernel.org/gpu/drm-usage-stats.html). Add a tool like
PMU, similar to the hwmon PMU, that exposes DRM information.

v4: Rebase over changes like the auto merge stat to first wildcard PMU
    change and the clean up of tool PMU initialization.

v3: Minor tweak to the test so the skip (exit 2) doesn't trigger the
    trap cleanup.

v2: Add support to only scan hwmon and drm PMUs if the event or PMU
    wildcard can match. Add a test as requested by Namhyung. Add file
    comments.

v1:
https://lore.kernel.org/lkml/20250211071727.364389-1-irogers@google.com/

Ian Rogers (3):
  perf parse-events: Avoid scanning PMUs that can't contain events
  perf drm_pmu: Add a tool like PMU to expose DRM information
  perf tests: Add a DRM PMU test

 tools/perf/tests/shell/drm_pmu.sh |  78 ++++
 tools/perf/util/Build             |   1 +
 tools/perf/util/drm_pmu.c         | 686 ++++++++++++++++++++++++++++++
 tools/perf/util/drm_pmu.h         |  39 ++
 tools/perf/util/evsel.c           |   9 +
 tools/perf/util/parse-events.c    |  33 +-
 tools/perf/util/pmu.c             |  15 +
 tools/perf/util/pmu.h             |   4 +-
 tools/perf/util/pmus.c            | 101 ++++-
 tools/perf/util/pmus.h            |   2 +
 10 files changed, 951 insertions(+), 17 deletions(-)
 create mode 100755 tools/perf/tests/shell/drm_pmu.sh
 create mode 100644 tools/perf/util/drm_pmu.c
 create mode 100644 tools/perf/util/drm_pmu.h

-- 
2.50.0.727.gbf7dc18ff4-goog

