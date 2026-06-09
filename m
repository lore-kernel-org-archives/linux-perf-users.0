Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4972749CF
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 07:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988637; cv=none; b=K5Hjyl5lTZM6Kl76rKnxv3Keqi08cpPlb3v9FvNnz+w0kRFAnToPUNr1MZKBGmSCE4ghwa50n/O7qN2B9RtbZAGIwJjEsr78tdmqx3nP3rBtEawmIOMKu8eK9hKezy/LAOOmy/u1dWfTJJG9o9SxOYRlAtRoMHTrnVPKKc/3NHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988637; c=relaxed/simple;
	bh=ObQm8q+T2anbqJFG+T/iyqprTss7RwL4mruS3DRf95g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NOoI9zbNRTFYr2elz3Z21c0sBplCn2tDwdJ7czOFy3zx1OI8w8kKMrW6H9IgbvAXCaZojgY50KbXvRXGMnyMgpWcClIMQ0hKyKC4AZ8qgl2PpqNX750oJ5Udp8cEe8UKElULSy7SB1DYcYbqrncQeLeayOGJYpOPjx550XYNa2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TDAKxCqy; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TDAKxCqy"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13815cb1507so6229081c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 00:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780988635; x=1781593435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JxPb+RxK32jFv/xJSoX/EYo4cdhBkfXrSsqEtmmG9wM=;
        b=TDAKxCqy952NRq+Aqvi7WdpBqU/bDO/hXL4TFNiVfD2EOQV3rRUyS885d5AqJhu+/l
         UID7dv+/VYAPzVG6fTASMuNrB6JCSyhrq2u2rmyDLCfr4bA/iSOB5FWPOGYUSwu0MwKU
         uBHimOln99Ta2jnQxx846r049YR++o192jzEyT9YTOqO4BD6BhlM4vBAUQwest2lsieW
         eUtts0owbhj25hTpRfKUYYpzymMDmKbGDezicTA7CvvPGV6Goe+IJ5qVqnZ2xlse1fFT
         CrKspH6NCtx4TGFQAJ43wIMRKUi58dSfTnDMR6UWHCOgKsE0I/lgftQWaGq65zW7Whwu
         n7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780988635; x=1781593435;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JxPb+RxK32jFv/xJSoX/EYo4cdhBkfXrSsqEtmmG9wM=;
        b=X4NmpcNyU8FGzrLV9081G5L7qSCkSWGB0m49hbHyK64rDqjpF/lpbuETobdJvYfTlt
         sYEbBc08+JE3dC+/rZFp/ZsSBxEJ5xEEr1cbnnFXXhABTC6eDjEO2zIs76X9EgAhHozw
         ftwRppE9qeVa2V9YML5exDO9ig7K7Vvpus8UAhWMXEfdJENMQaJZUjazIOJBOfDGC7Cp
         H6bkfWObNJGnTlt2Jwi1rqHaQP69u2ft3qLHZQ++Zc4go8N7LhhKUwLcQqtcu18N5J1y
         nrFi0a6RzTcmUISPwyp9lvJiNb7/SqK4qlCKPiJK7z6UXaoHaeCUsd/i7EBQBJ4YQnOe
         hKpQ==
X-Forwarded-Encrypted: i=1; AFNElJ/PIniIpADBLHSYT2sv3cLEWYnz/sx0SrhXfV6zwu1/yS+1YHCtriPSrA+T5tryOww4Gs1yJD+2/GW4AftSXCUc@vger.kernel.org
X-Gm-Message-State: AOJu0YxEwF4ji8vxVXW1YrlA1V+OOnHGs0YR0fAxXsnT3R4EYlGIcKPG
	ZQ+cghEWMfl/Ab5Qpv0zmdyDTkGSxvb3QMXAYsUrdtWdG1AUmgImOr/MaKMXMkeC/X0K0TZz+o6
	qVVz04d3dsA==
X-Received: from dlbrx14.prod.google.com ([2002:a05:7022:170e:b0:137:fb92:f7ee])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6613:b0:12c:8e70:c33b
 with SMTP id a92af1059eb24-138066be665mr9925946c88.8.1780988635043; Tue, 09
 Jun 2026 00:03:55 -0700 (PDT)
Date: Tue,  9 Jun 2026 00:03:45 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609070348.541964-1-irogers@google.com>
Subject: [PATCH v1 0/3] perf pmu: Add tool-provided NVMe PMU
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Tomas Glozar <tglozar@redhat.com>, 
	Michael Jeanson <mjeanson@efficios.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Leo Yan <leo.yan@arm.com>, German Gomez <german.gomez@arm.com>, 
	Anubhav Shelat <ashelat@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch series introduces a tool-provided PMU for NVMe devices to expose
various hardware logs as perf events.

Using libnvme, the new nvme_pmu extracts metrics from standard NVMe log pages
including:
- SMART / Health Information (e.g. data units read/written, power cycles,
  temperature)
- Endurance Group Information
- FDP (Flexible Data Placement) Statistics
- Error Information
- Zoned Namespaces (ZNS) Changed Zones

Key features:
- Dynamic probing of supported log pages on /dev/nvmeX. Unsupported events
  are marked as deprecated and hidden from `perf list` by default.
- Generic configuration encoding where the log type, size, and offset are
  encoded directly into the event configuration.
- Correct interval delta tracking using baseline offset snapshots. This mimics
  the behavior of the hwmon PMU, allowing gauges like Temperature to be
  reported instantaneously in `perf stat -I`, while standard counters
  correctly accumulate deltas.
- Robust handling of cross-architecture endianness when reading 128-bit and
  64-bit fields from the NVMe specification.

The series is broken down into:
1. Adding the libnvme feature detection via pkg-config in tools/build.
2. The core implementation of the NVMe tool PMU.
3. A unit test suite verifying the parsing and encoding of the NVMe PMU
   events using a mocked device.

Ian Rogers (3):
  perf build: Add libnvme feature detection
  perf pmu: Implement tool-provided NVMe PMU
  perf tests: Add NVMe PMU event parsing test

 tools/build/Makefile.feature       |   2 +
 tools/build/feature/Makefile       |   3 +
 tools/build/feature/test-libnvme.c |  11 +
 tools/perf/Makefile.config         |  12 +
 tools/perf/tests/Build             |   1 +
 tools/perf/tests/builtin-test.c    |   1 +
 tools/perf/tests/nvme_pmu.c        | 176 ++++++++++
 tools/perf/tests/tests.h           |   1 +
 tools/perf/util/Build              |   1 +
 tools/perf/util/evsel.c            |  11 +-
 tools/perf/util/nvme_pmu.c         | 535 +++++++++++++++++++++++++++++
 tools/perf/util/nvme_pmu.h         | 143 ++++++++
 tools/perf/util/pmu.c              |  15 +
 tools/perf/util/pmu.h              |   8 +-
 tools/perf/util/pmus.c             |  31 +-
 tools/perf/util/pmus.h             |   1 +
 16 files changed, 945 insertions(+), 7 deletions(-)
 create mode 100644 tools/build/feature/test-libnvme.c
 create mode 100644 tools/perf/tests/nvme_pmu.c
 create mode 100644 tools/perf/util/nvme_pmu.c
 create mode 100644 tools/perf/util/nvme_pmu.h

-- 
2.54.0.1064.gd145956f57-goog

