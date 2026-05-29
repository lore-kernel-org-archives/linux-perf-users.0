Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F348138B7AA
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 04:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780030329; cv=none; b=kD6KnQRR2wkrLJV4OnG4G/6QTia4WMdiKdsaP2RUWuyB/yKlWTALfW3PDlhGAW6ixAuAYdtQ364zHtzo0o83eu5GDeCiTiBkOPb+r76NhATAcKQihlo0txM3OTSWrKGk6IUk6N/3imXTQaBeXjQ0vB0D1rnb5GvCSqET2TGNaE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780030329; c=relaxed/simple;
	bh=SyKr/qpykzw+1nSuNWsGBD21NzEIyY547qOOmsiq104=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FX4WCJaAij2yvRvIVqV310NTHYtvCW6d7ej2V+n0Ee/mc1kjKfKyV7WC47F6zDJMbyFsrVPnkxauQkkxc+OrzIZcuktG61fKxcD3eW2VdZvtkPX5EsCNDcl1xfFLivyjVYtYVVw4etZZmby8hgp4SnPLg283J9iuKNnefW6/jPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ng1VgV3k; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ng1VgV3k"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c828acf7c1dso18216932a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 21:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780030327; x=1780635127; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+QdZyuZRackb2VtBVrMBKKT6z+vSQ/xbbMeL/+OkwlM=;
        b=Ng1VgV3kpBsDiVtvYytwmBL1cMSemuA8PMTlc8+vG6zMwsZ9vWjYtvc+A99ek7TvUN
         E0CayQGnh8QoHgyGmWrOFZ5ohExZpzFs+pNQ71kzP8jU9yZ4CR5bF0bvQug1iSp3RXyu
         Y17fta3wQSEaOdT6RmchVkQsMQyWHZyEnn5lPfYwPrhZ7I3r43TWPdve5XPYlSJ/7Ii2
         3OzSfXMjfSUUv+EgtLLpNNGcn5LC1nDMowwWxpwVmVnfe3MSpL5m5pdpXHZDOQ8F04XV
         QTqqyslqtj7TBGjbQLfJiDnliY1+as+0t38YltI/0WiXQP1A+K5ThaAgFKDVYXTymOP9
         YnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780030327; x=1780635127;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+QdZyuZRackb2VtBVrMBKKT6z+vSQ/xbbMeL/+OkwlM=;
        b=UKNzEFRvGzZE2jqPoSQ9GyoeLazPGUgXApR52bnPY0jH578gXtGjlx1mB0OXa7VusF
         CykUy+rQMdbBIHB13dE5wrUTCnlYZzDS2HWDHr6fTS+kPTedWqb3ulZgOQruTx68kFn/
         GsnfPIULe6ZfM8chKUOcNHcAK0Bz4wzM6Ruiw+7R0tTWJBBYOqvd39qfjwU4Lu4RS6Bi
         vM2qpKJxyG71MC4ioQxypB8+PHIfI5Aypj0gQ2BPQER6gJWN8VgX2iWFzd9tDUosflew
         eLlchqieK6uF6oKm74bquIOVe0n5ngbg2LgD8DNI7zTTNK0xDfc0EnQfw/GSBYik9WHM
         Gkhg==
X-Forwarded-Encrypted: i=1; AFNElJ+0ZUd8wOIYbz8WXT6SJGYY20Pb+BxOXxlD8G5RkAofGcY1cCLKWH73QHmFzPshUcYlbQGYuwMfqUvFDibereKS@vger.kernel.org
X-Gm-Message-State: AOJu0YyuXSM7gWF+7SUpm6LzyEhurbTrySK0ezxzlfq/UNBx9fon5uGa
	Fh0cezrVt8DkLrNFYkAuvWLv6bGfFVbnDZGsaMWsRnydj5/EM8hKjCwcnzPNByWygQwOksziYNs
	xO6YQd4mBGg==
X-Received: from pgkm12.prod.google.com ([2002:a63:ed4c:0:b0:c82:3e0c:341e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7d9c:b0:3aa:c95f:f67
 with SMTP id adf61e73a8af0-3b411e2806cmr1353106637.35.1780030326813; Thu, 28
 May 2026 21:52:06 -0700 (PDT)
Date: Thu, 28 May 2026 21:51:42 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529045155.311805-1-irogers@google.com>
Subject: [PATCH v1 00/12] perf vendor events intel: update
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Sync with the latest perfmon events from:
https://github.com/intel/perfmon
by running the script:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
and copying the resulting json and mapfile.csv changes into the perf
tree.

Ian Rogers (12):
  perf vendor events intel: Update alderlake events from 1.37 to 1.39
  perf vendor events intel: Update alderlaken events from 1.37 to 1.39
  perf vendor events intel: Update arrowlake events from 1.16 to 1.17
  perf vendor events intel: Update clearwaterforest events and metrics
    from 1.00 to 1.02
  perf vendor events intel: Update emeraldrapids events from 1.21 to
    1.23
  perf vendor events intel: Update grandridge events from 1.11 to 1.12
  perf vendor events intel: Update graniterapids events from 1.17 to
    1.18
  perf vendor events intel: Update lunarlake events from 1.21 to 1.22
  perf vendor events intel: Update meteorlake events from 1.20 to 1.21
  perf vendor events intel: Update pantherlake events from 1.04 to 1.05
  perf vendor events intel: Update sapphirerapids events from 1.36 to
    1.39
  perf vendor events intel: Update sierraforest events from 1.15 to 1.17

 .../pmu-events/arch/x86/alderlake/cache.json  |   85 +
 .../pmu-events/arch/x86/alderlake/memory.json |   64 +
 .../arch/x86/alderlake/pipeline.json          |   54 +
 .../arch/x86/alderlake/virtual-memory.json    |    9 +
 .../pmu-events/arch/x86/alderlaken/cache.json |   50 +
 .../arch/x86/alderlaken/memory.json           |   57 +
 .../arch/x86/alderlaken/pipeline.json         |   48 +
 .../arch/x86/alderlaken/virtual-memory.json   |    8 +
 .../pmu-events/arch/x86/arrowlake/cache.json  |   53 +
 .../arch/x86/arrowlake/floating-point.json    |    9 +
 .../arch/x86/arrowlake/pipeline.json          |   48 +-
 .../arch/x86/clearwaterforest/cache.json      |  525 ++-
 .../arch/x86/clearwaterforest/counter.json    |   79 +-
 .../x86/clearwaterforest/cwf-metrics.json     |  310 ++
 .../x86/clearwaterforest/floating-point.json  |  191 +
 .../arch/x86/clearwaterforest/frontend.json   |  226 ++
 .../arch/x86/clearwaterforest/memory.json     |   92 +
 .../arch/x86/clearwaterforest/other.json      |   20 +
 .../arch/x86/clearwaterforest/pipeline.json   |  829 +++-
 .../x86/clearwaterforest/uncore-cache.json    | 3413 +++++++++++++++++
 .../arch/x86/clearwaterforest/uncore-cxl.json |   31 +
 .../clearwaterforest/uncore-interconnect.json | 1625 ++++++++
 .../arch/x86/clearwaterforest/uncore-io.json  | 1925 ++++++++++
 .../x86/clearwaterforest/uncore-memory.json   |  883 +++++
 .../x86/clearwaterforest/uncore-power.json    |  109 +
 .../x86/clearwaterforest/virtual-memory.json  |   94 +
 .../arch/x86/emeraldrapids/cache.json         |   18 +
 .../pmu-events/arch/x86/grandridge/cache.json |   56 +
 .../arch/x86/grandridge/floating-point.json   |    8 +
 .../arch/x86/grandridge/frontend.json         |   64 +
 .../arch/x86/grandridge/pipeline.json         |   15 +
 .../arch/x86/grandridge/uncore-io.json        |   15 +-
 .../arch/x86/grandridge/uncore-memory.json    |   32 +-
 .../arch/x86/graniterapids/cache.json         |    9 +
 .../pmu-events/arch/x86/lunarlake/cache.json  |   20 +
 .../arch/x86/lunarlake/pipeline.json          |    9 +
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   24 +-
 .../pmu-events/arch/x86/meteorlake/cache.json |   55 +
 .../arch/x86/meteorlake/floating-point.json   |   63 +
 .../arch/x86/meteorlake/memory.json           |   64 +
 .../arch/x86/meteorlake/pipeline.json         |  158 +
 .../arch/x86/meteorlake/virtual-memory.json   |    9 +
 .../arch/x86/pantherlake/cache.json           |  152 +-
 .../arch/x86/pantherlake/frontend.json        |   60 +
 .../arch/x86/pantherlake/memory.json          |   29 +
 .../arch/x86/pantherlake/other.json           |   10 +
 .../arch/x86/pantherlake/pipeline.json        |  231 +-
 .../arch/x86/sapphirerapids/cache.json        |   27 +
 .../arch/x86/sierraforest/cache.json          |   49 +
 .../arch/x86/sierraforest/floating-point.json |   64 +
 .../arch/x86/sierraforest/memory.json         |   57 +
 .../arch/x86/sierraforest/pipeline.json       |  156 +
 .../arch/x86/sierraforest/virtual-memory.json |    8 +
 53 files changed, 12195 insertions(+), 104 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/cwf-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-cxl.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-io.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-power.json

-- 
2.54.0.823.g6e5bcc1fc9-goog

