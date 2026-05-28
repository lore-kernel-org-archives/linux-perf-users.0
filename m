Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2BD35F19B
	for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 23:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780011909; cv=none; b=WK5sd/QwWNNB5fOmKevPpowK5Xa1tW8b4nnwGfI7PCXXfE5eqwTo8kJY9hQQCKxINE/U+ISpmYGYk4U+cs0LsaLlXLpSBycmvdYh7D0gcL/vNZh4YySc5FgB/IucuKJHQymTum2UjvpNohoxhwBt7Ig7CJDnXHeC9lToqXnu1SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780011909; c=relaxed/simple;
	bh=BFNIglYTU7vaI4Mjs1GEB/r2rmCPtiAEGpG3Ap9tqIU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c4UWQmwmITeG4CtQ4TwClcbHfW8kFHO2Quy95DJMuPMgLNRGsZlb6yFA0oYKqg1nCS9FsF0aCbSrmheUxv8uyhKQqUhZ9qujj6OdnjL6W3tWVVjCzbwfxhXdbXfUQZ3Z1DShWLV0XPWK3BU0n54ik5y7671gpQIQ2sXzHCk39uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bC5JnpX5; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bC5JnpX5"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8397b14a689so8413068b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 16:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780011907; x=1780616707; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hThhPthEZQx+mclXHJCK9VdmCwYLlnmXo2VRHcTae8M=;
        b=bC5JnpX5sZigAC/6eSQDrcSCGt1NUN06PCgFchNYXECgzfVdxAobyiYhG+YzAR+Y1d
         l46vQJy/o0hwIclCtab2DlHQVHoue7BKBM++MfjhB40HQ+/E1WewFhRw1zjfOgDlFQ3o
         Kv0DN+YvCcX92E89NIUWlYzR9YAWgu8zAsuiBYjvSaZdTIYHpkYJitMJmLUhgHoRlrc/
         urUIl7kEloAFScSqduI+G8YHEURFTDSUT38xt1uf3k/f0KFssgov81uLI/kUVJNKqm3C
         FUaZKUffFnPXrwO/v+iB4gCdXJaGsb/Fxhaepwp/swB8X/UD7Y18hOrAhRSjCyn4ERyb
         2btw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780011907; x=1780616707;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hThhPthEZQx+mclXHJCK9VdmCwYLlnmXo2VRHcTae8M=;
        b=OCtIhPattC0Sg04ODSE16HGbLMMHA2ZFSq/r4kuOyycxWwf3R2+uW+F9JaPc/5Rzw3
         86xVIYeXd035+/WW3Bw2QvVQFN6YPmVu7nP+4RPGr74GUkJb/ALUwoD/m5ijZJB0bj5g
         7psIjXLpDdAkF7us1gC3WFWqxqIo3UhKmwCZSoGUK7rf2Qqb0wDYTrRfEmPWj3dhYdak
         tvNjp3jy8m8whCbBTOb12QXSPvP0C9E9VfSarGaaRSjDeFcW8zieFHWBSeiHKy5YxWpa
         mAcIpXwUWH6CuMFoIn9AbwxDkCe3LRWBSGNfKFZ1O2hr3B2x8Jl86+TnhOawGuc0+g/K
         0+Ig==
X-Forwarded-Encrypted: i=1; AFNElJ+jMejd+dUUaOptiu8X4YJNTLXJ+x9Uf9zXyjTRpw9gVhtZA3nhJpi1xzKXwjnmoBpWn6E2qkkatdUYs2hQoPOx@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpfql2RFQyhOvWOpYvK6JM5K7rHezj4dsdjMUDm3p4r6yqcjq/
	2CWIS78yEYnbl+y6jhIy32Wx0NqBaI8VEMCUvXl1lgaDrQkCjwxkrYPRTj6IMeAZXegl5UGUe97
	CTc6wCA==
X-Received: from pfej20.prod.google.com ([2002:aa7:8d14:0:b0:835:4037:1869])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2445:b0:82f:ac48:8342
 with SMTP id d2e1a72fcca58-84212ce85d4mr296942b3a.24.1780011906530; Thu, 28
 May 2026 16:45:06 -0700 (PDT)
Date: Thu, 28 May 2026 16:44:53 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260528234455.434027-1-ctshao@google.com>
Subject: [PATCH v2 0/2] Add IOMMU TLB and interrupt metrics
From: Chun-Tse Shao <ctshao@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Sandipan Das <sandipan.das@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series adds IOMMU Translation Lookaside Buffer (TLB) and
interrupt cache metrics to perf jevents for both AMD and Intel platforms.
This enhances I/O performance observability, allowing fleet-wide monitoring
of IOMMU overhead.

The changes are split into two patches:
1. perf jevents: Add IOMMU metrics for AMD
   - Adds IOMMU TLB and interrupt metrics for Zen 2+ processors using
     standard AMD IOMMU PMU events.
   - Note that pde events on AMD cover both 2M and 1G pages, so 1G pages
     are implicitly included.
   - Added code comments to clarify this hardware detail and fixed
     indentation to match the file's style.

2. perf jevents: Add IOMMU metrics for Intel
   - Adds IOMMU TLB and interrupt metrics using uncore IIO IOMMU events.
   - Supports Emerald Rapids (TLB-only) and Granite Rapids (TLB +
     Interrupt) by dynamically detecting event availability and making
     interrupt metrics optional.
   - Clamped calculated interrupt cache miss metric to zero to prevent
     negative values due to counter multiplexing or sampling skid.

v2:
  Split the changes into separate AMD and Intel commits as requested.

v1: lore.kernel.org/20260527223917.3845056-1-ctshao@google.com

Chun-Tse Shao (2):
  perf jevents: Add IOMMU metrics for AMD
  perf jevents: Add IOMMU metrics for Intel

 tools/perf/pmu-events/amd_metrics.py   | 57 +++++++++++++++++++++++
 tools/perf/pmu-events/intel_metrics.py | 62 ++++++++++++++++++++++++++
 2 files changed, 119 insertions(+)

--
2.54.0.823.g6e5bcc1fc9-goog

