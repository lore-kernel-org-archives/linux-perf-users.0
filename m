Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7082080C8
	for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 21:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747173248; cv=none; b=Mej5zgfMz7MDId4Sb37yJ6SfuLfS7UXlBlOWqU+0fefpYssRxtyYap7tfvYZSJdkN2w/nPIK1B55j5rAV2hCRWLnMgBvwMyxD/tN6iRfwrWjJbRVaAPHJIPsqqNrcQ9GZWRBOpESZ/mOa2W4b7WC9O5DK0CB0h6+wtvyL3Yt5zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747173248; c=relaxed/simple;
	bh=40QKALZCDAdxC2I4RCUouF79EW48OYte1LNp7ZKNIsQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VKUpdfzg+v3rKmdJUXlB1SdGM9jd9F2ws6w4h3D2GIoJhZ/zC5EmuIibP4dKE6wB/Arl7h9dRQtugOh3eqA0BKcNAbAJ5v5q9UHn3HYxnnZpiASb9aucxgiwAuzdvP1XxtLcdY6RfW1+X4moUR0J4Rl3GPzN95GL48gtjDjp2vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1m2zxbJ/; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1m2zxbJ/"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30c4b072631so4572724a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 14:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747173246; x=1747778046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7fXd3bwKMsVTV58ODLndnal7i9Na64IyoboiGNyHuF8=;
        b=1m2zxbJ/p2cIB7HFnZ149CPnUnuA+7gCUQapIlqENC997yJSw+UecETyVUGDfIiSZS
         Z2FqOi0N3N6NbJ8M8VuemCmKqZOi732pVS/0lSFbod9vXMgQ41CSgujEdDKdZ/Qj0UCM
         jW+R/06rcQoM7qAnonZ3fnz56Dn2Fhojno8gShqMbbIrcaQYMB7mIGUg74jXfpG6sb3Z
         AQzQVFFNWd0AISM3xSz9YSVwhQIBBlW3fEcQ/LziuEWjNi4f9dZ/tJEWYN8Pckcm2oG3
         0wu9Rt1ceoI6OBtodYZ6v6I9XUwFAYr6+Ujfej1qcUYDyUhYW7JFNd/Kwh4l9++xGNK3
         A5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747173246; x=1747778046;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7fXd3bwKMsVTV58ODLndnal7i9Na64IyoboiGNyHuF8=;
        b=aAMyRQS6Efy0S3/mxfqLHYHK8bN9P4Ca3m7Ii9uNGZSTqxYeakVnt0aJ/nM1yloMaj
         bcYZ7KpCRCmiPHTzgAqJdV3gdSxnkUchxUysXbLPXVlnDuQ9FaDq7aASAWnCcG2zjOKC
         z9ZR/EW4fHgSp+dGF3W5zzFquTi0pNuOF7AtW/l9sQ/y4fEq2FtC57DT1MOztzleMYI0
         +lk1G3XBYr+BhwRjRsP9P2dUA9aaWUXMSDCRj39YxxuRdPfTQd3qXjaXcyPy8dRDS7I+
         7ctipNMO7dvvnh7YHFBXM4YifMjRh2BREz/mmy51ty7x3ivkSbB0nxQmSZeJmWcERw4e
         uANw==
X-Forwarded-Encrypted: i=1; AJvYcCWE8UXPf2injoVe9nVW8fXxJADhnmf0WIsdkwQZFMHXsE+1BPGN0TtlkjBB9+xbkycrOMhrGgLcRaEdZbuJDGNs@vger.kernel.org
X-Gm-Message-State: AOJu0YyG8xcc6IjixEMUCHY5kgZM4YrIr+ZGEVebTWU+6vRg0wsRhZkD
	ISxABYF1g+IBFhv3IZ1K1356Ehg7wUS+aAtC65rLjloBRJjJDXeluUKMtn9qC21fxFjdsu+ogR1
	PTQ==
X-Google-Smtp-Source: AGHT+IF1Pdt3TrLC1JMdQHnUNLYTkgKgYFba33/us5gzSx8qvo238++158+LVN95N/pxvj7wbVmZyRh9Puo=
X-Received: from pjbcz6.prod.google.com ([2002:a17:90a:d446:b0:2fa:2661:76ac])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a86:b0:2ee:8e75:4aeb
 with SMTP id 98e67ed59e1d1-30e2e5dc9f5mr1720334a91.17.1747173246009; Tue, 13
 May 2025 14:54:06 -0700 (PDT)
Date: Tue, 13 May 2025 14:45:00 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250513215401.2315949-1-ctshao@google.com>
Subject: [PATCH v4 0/3] Fix incorrect counts when count the same uncore event
 multiple time
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, ak@linux.intel.com, 
	howardchu95@gmail.com, yeoreum.yun@arm.com, linux@treblig.org, 
	james.clark@linaro.org, weilin.wang@intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Let's take a look an example, the machine is SKX with 6 IMC devices.

  perf stat -e clockticks,clockticks -I 1000
  #           time             counts unit events
       1.001127430      6,901,503,174      uncore_imc_0/clockticks/
       1.001127430      3,940,896,301      uncore_imc_0/clockticks/
       2.002649722        988,376,876      uncore_imc_0/clockticks/
       2.002649722        988,376,141      uncore_imc_0/clockticks/
       3.004071319      1,000,292,675      uncore_imc_0/clockticks/
       3.004071319      1,000,294,160      uncore_imc_0/clockticks/

1) The events name should not be uniquified.
2) The initial count for the first `clockticks` is doubled.
3) Subsequent count only report for the first IMC device.

The first patch fixes 1) and 3), and the second patch fixes 2).

After these fix:

  perf stat -e clockticks,clockticks -I 1000
  #           time             counts unit events
       1.001127586      4,126,938,857      clockticks
       1.001127586      4,121,564,277      clockticks
       2.001686014      3,953,806,350      clockticks
       2.001686014      3,953,809,541      clockticks
       3.003121403      4,137,750,252      clockticks
       3.003121403      4,137,749,048      clockticks

I also tested `-A`, `--per-socket`, `--per-die` and `--per-core`, all
looks good.

Ian tested `hybrid-merge` and `hwmon`, all looks good as well.

Chun-Tse Shao (1):
  perf test: Add stat uniquifying test

Ian Rogers (2):
  perf evlist: Make uniquifying counter names consistent
  perf parse-events: Use wildcard processing to set an event to merge
    into

 tools/perf/builtin-record.c                   |   7 +-
 tools/perf/builtin-top.c                      |   7 +-
 .../tests/shell/stat+event_uniquifying.sh     |  69 ++++++++
 tools/perf/util/evlist.c                      |  66 +++++---
 tools/perf/util/evlist.h                      |   3 +-
 tools/perf/util/evsel.c                       | 119 ++++++++++++-
 tools/perf/util/evsel.h                       |  11 +-
 tools/perf/util/parse-events.c                |  90 +++++++---
 tools/perf/util/stat-display.c                | 160 ++----------------
 tools/perf/util/stat.c                        |  40 +----
 10 files changed, 332 insertions(+), 240 deletions(-)
 create mode 100755 tools/perf/tests/shell/stat+event_uniquifying.sh

Chun-Tse Shao (1):
  perf test: Add stat uniquifying test

Ian Rogers (2):
  perf evlist: Make uniquifying counter names consistent
  perf parse-events: Use wildcard processing to set an event to merge
    into

 tools/perf/builtin-record.c                   |   7 +-
 tools/perf/builtin-top.c                      |   7 +-
 .../tests/shell/stat+event_uniquifying.sh     |  69 ++++++++
 tools/perf/util/evlist.c                      |  66 +++++---
 tools/perf/util/evlist.h                      |   3 +-
 tools/perf/util/evsel.c                       | 119 ++++++++++++-
 tools/perf/util/evsel.h                       |  11 +-
 tools/perf/util/parse-events.c                |  86 +++++++---
 tools/perf/util/stat-display.c                | 160 ++----------------
 tools/perf/util/stat.c                        |  40 +----
 10 files changed, 328 insertions(+), 240 deletions(-)
 create mode 100755 tools/perf/tests/shell/stat+event_uniquifying.sh

--
v4: Fix a compiling error on patch v3 1/3.

v3: lore.kernel.org/20250512215929.2098240-1-ctshao@google.com
  Rebase with tmp.perf-tools-next. Since most of the conflicts are from
  lore.kernel.org/20250403194337.40202-5-irogers@google.com, tested v3
  patches with:

  perf stat -A -C 0,4-5,8 -e "instructions/cpu=0/,l1d-misses/cpu=4,cpu=5/,inst_retired.any/cpu=8/,cycles" -a sleep 0.1

   Performance counter stats for 'system wide':

  CPU0              682,860      instructions/cpu=0/              #    0.27  insn per cycle
  CPU4               53,774      l1d-misses
  CPU5               18,725      l1d-misses
  CPU8              608,698      inst_retired.any/cpu=8/
  CPU0            2,574,325      cycles
  CPU4            4,267,115      cycles
  CPU5            1,741,536      cycles
  CPU8            1,969,547      cycles

         0.102746958 seconds time elapsed

v2: lore.kernel.org/20250327225651.642965-1-ctshao@google.com
  - Fixes for `hwmon` and `--hybrid-merge`.
  - Add a test for event uniquifying.

v1: lore.kernel.org/20250326234758.480431-1-ctshao@google.com

2.49.0.1045.g170613ef41-goog

