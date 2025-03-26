Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0934F5E0
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Mar 2025 03:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742961068; cv=none; b=j09HRxOw+os0rTbn2cftM8ZRWLNwUySIpcrd2ofX82sgGn/yL3hpSdGJTTb9O0NO0fPnCSMi/ZQpEwRYsRCvAudIq0+4amZ+1Hmqrk5A2mjlxSjuGWBSyvpN7KsOeKUBOq9aeg81tpDlgumCtA0giHkxQHDHhw3UMoudKmSffYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742961068; c=relaxed/simple;
	bh=OrNdDDtLr7sWANp1hVQxXXdW61TAcKhwpU/lYJV6sUI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LyW8BXmMJZKcg+F7Sm+m1O+DjQFYi5cqdR9iblHBEZcLKFo6LNhg8YYY4+2hcZcq920oMRR8ZlpFt84O81yPxhkO44QV3N+3CjtvaSUYtghgr2oyj8oNrvAtIDpdeuGHZFOvgdGLJ3txz9ZYhy+37Tjl4HCDpha2essSE1PW5UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kP+WiVAL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kP+WiVAL"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2264e5b2b7cso96545835ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 20:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742961065; x=1743565865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q4SBEUeVaxUtokJPIUYjJGAnoRWPInWE392dc3Q7SjQ=;
        b=kP+WiVAL/hBksX9PeSCEeTC9pI+ufxHlTmST9OMttl2oawKvio/fsP6ASgBtkIJZNK
         6UUzIb42Pk7LtMaybxX+jXRmIBPdpIoLJrze1uEaxjRYHcyH8b/tXwN2SccqdJgY6QdR
         TE08jrUdbT2TLT72lk637xZ/5O5ta86T9UeRbEMvfnZnYYvG0jMX7fHnQs1wJHLOHTFB
         +hYxZ0xz7edWUx1V6NUpJ369sCttLG6AvgWiG+CRgo5V/Xqhnbsy2/PXayMaYORoHtvG
         MNWsj5fE+k2CDk2CYwwa7ByXriKXAAXFtrYKgLXG0TERRjfY5OFL8jzNC6F6x6i+IWX0
         /YZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742961065; x=1743565865;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q4SBEUeVaxUtokJPIUYjJGAnoRWPInWE392dc3Q7SjQ=;
        b=t2irM5U0H8bX5ZRv1e8Edb/pgPbLZD9k3hNoOMOsych076T/scTXgnAeINgUyM7SJ/
         2cgQ1lM5+db9psI3EbGXEbRqefgKgxSiVXEsbmHMsgRHPr7fYJHsmqYyNSCISQJrUqrH
         BSjTTEBzdh1/qjfFtx8ObPi6voqIrEpxCxxOBYw+uq1cFsCRgv0XFHGnEA1zRg/RAZE3
         9KcAsv8K9N/9cWq2ze+6D3HCAuDTYUTOlmaT0AVP0UvViB/V66Iyhoz6iaOtxGnNWqck
         ZMm9DbHdRNhTjHdHrJd1ztDY0ZaN6imLTjM1i7kyEsohFny7PCCaXxOQSfkWcoMgBNn/
         oHnw==
X-Forwarded-Encrypted: i=1; AJvYcCXa4Ry2Dq5aDbuSpyejjwlv2wGfcop9OxkhqTQZpBCtYAUUXjJE3GBvDFxiMSZoh9xtZBf2rJI/AbFwVUIiJkKc@vger.kernel.org
X-Gm-Message-State: AOJu0YxMlGugLFro0DjkG4qz6zVWDMYHyK2HKtsVy4NVdyZHx88AwpKr
	PzLoYYNCNmwO8F6BD4Bxrcws7eSh0IzpGrc3jMVxcbP7iZSuafqzl1Ec9TQQzuJKU43/DVP+i24
	Jp2rf4Q==
X-Google-Smtp-Source: AGHT+IFX6TAUq+5C9170e0/iEjt+LX7tYFuOYRqyp7uoH5Mv47EnjgV63qQG1LlVmvC8atTnWkrS5Orlfjl2
X-Received: from pffk14.prod.google.com ([2002:aa7:88ce:0:b0:730:8e17:ed13])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4602:b0:739:56c2:b661
 with SMTP id d2e1a72fcca58-73956c2b9efmr534037b3a.12.1742961065431; Tue, 25
 Mar 2025 20:51:05 -0700 (PDT)
Date: Tue, 25 Mar 2025 20:50:41 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326035045.129440-1-irogers@google.com>
Subject: [PATCH v2 0/4] Add support for a DRM tool like PMU
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Junhao He <hejunhao3@huawei.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

DRM clients expose information through usage stats as documented in
Documentation/gpu/drm-usage-stats.rst (available online at
https://docs.kernel.org/gpu/drm-usage-stats.html). Add a tool like
PMU, similar to the hwmon PMU, that exposes DRM information.

v2: Add support to only scan hwmon and drm PMUs if the event or PMU
wildcard can match. Add a test as requested by Namhyung. Add file
comments.

v1:
https://lore.kernel.org/lkml/20250211071727.364389-1-irogers@google.com/

Ian Rogers (4):
  perf parse-events: Avoid scanning PMUs that can't contain events
  perf parse-events: Avoid scanning PMUs that can't match a wildcard
  perf drm_pmu: Add a tool like PMU to expose DRM information
  perf tests: Add a DRM PMU test

 tools/perf/tests/shell/drm_pmu.sh |  77 ++++
 tools/perf/util/Build             |   1 +
 tools/perf/util/drm_pmu.c         | 689 ++++++++++++++++++++++++++++++
 tools/perf/util/drm_pmu.h         |  39 ++
 tools/perf/util/evsel.c           |   9 +
 tools/perf/util/parse-events.c    |  30 +-
 tools/perf/util/pmu.c             |  15 +
 tools/perf/util/pmu.h             |   4 +-
 tools/perf/util/pmus.c            | 101 ++++-
 tools/perf/util/pmus.h            |   2 +
 10 files changed, 951 insertions(+), 16 deletions(-)
 create mode 100755 tools/perf/tests/shell/drm_pmu.sh
 create mode 100644 tools/perf/util/drm_pmu.c
 create mode 100644 tools/perf/util/drm_pmu.h

-- 
2.49.0.395.g12beb8f557-goog

