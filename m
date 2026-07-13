Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031413090C4
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jul 2026 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966682; cv=none; b=rFgBJNyHuVxLlkZqg0770YRKMQdl7fDxIeeH2uTbUJCvGaEBdK8jNtsOZHiUQY2JVVmplbnsRMAnl3CtcVp7Se6vd/e1aALjOspKqHGf3wGn4WLGMACy9P256xk9HMcgBx3NHJvtB87tIBpjt7GHOJvZ9OdNxG7DGEd2HNn1opA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966682; c=relaxed/simple;
	bh=rQiyBiOpKyTRV7fO0vkBLGPeInXq1ROsScjnk1eEXlI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kZN5cPEmn+r6PWBYo0OTc9YiMZEwQMW1SzLaUxVFvDpbjbt6gSZp8DcT3JQTWZ1VaVLstqSyXRMzUEQ2AMyePYsCdYJN84XNXCpMsK0IFslXg0Z9MpgLj0l7YOCV6ynuCqBkfcQPTzVlY7PlrBtQyHlyAKPLBEW1jaEWF+qAt2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tqF4P5Fm; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tqF4P5Fm"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8484ba00601so173008b3a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jul 2026 11:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783966680; x=1784571480; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ez7IVXjg2XPTbK/zNXL+Hk36lUbHXml3DqnI7Lu6zHM=;
        b=tqF4P5Fmz0/fMeXHr//bp9OWqH5z/+3xZ5FlnfMXuNAcHCwRqgYA5pLqUBdAUo6pCo
         dFW8NsfLfQDZj9KIIPDq5+f7H+bu6IG3DADQr23sUZFszzFIfXhmtlaHFZs5QhtGyJXW
         x87aYCIWyMiBtxYOp0pRrh014hHe1OLvC0sc15WbCpSC2+WlcIwqqVeKmbqEyWnkRHQK
         K8lWVm7VskhiMWocTHaFT/bohtf+RWsmclhTiTc4rnNxzwBY69m0qESN4GBjxV3NX22R
         44B3wSiA06nPRKnTKua8MGgh9NiOHH7HiRJ34dvAKgZW1padp5mBWIWjWYPIm3kP+RPs
         k71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783966680; x=1784571480;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ez7IVXjg2XPTbK/zNXL+Hk36lUbHXml3DqnI7Lu6zHM=;
        b=lUic62PhjkKhM3rob5RI7jBqP1zLSgUann84bJFckChwgR5Nv3fLzUA1V7MIp0YtkL
         nxKaVZO56Sa2WxoExcv1Jo8V2H3VAGLVYk71AHoq1Al7rZCPC87voisjR+VgVZ+D/RPj
         mFw1VIyAMYQzzYRWiS81fjxKs5O60KD8qkiIgVp6i9jPwzFhsINoT7VynCfln72ROjOH
         M0KMqKzfJmI0EVjeoOIa3LuVpoAXy6MO/HKbhXF9eSh8ehJeJ3g8AQtvo3kO626q+u53
         4spm/5/+M74R3PpQHBP4U2TMJBu+32SKksLlzFiYc+BuQWA6iJo448Wvfj9x3GUGdmuG
         +LrA==
X-Forwarded-Encrypted: i=1; AHgh+Rr/Pvevu2lFDqp7JfGoK+mfZsafB9pFUa7ENcYJMFlFX749vIuizu+i6+QrYzfnmkAHChh2VRd9OXBRA+U64ohv@vger.kernel.org
X-Gm-Message-State: AOJu0YwT9epmubFSgo8WNx28CrZ5SU6f4x/aCVpcMMwVa1O44Xhv8oiA
	zsODOhivpaGDVFH0wCq2IFIwhG0NNGXgQNVibIoA0iwkjZs5IOd2oLX1dNmcpGfKuEHgF3Ap6HC
	6YzmxXw==
X-Received: from pfbgl5.prod.google.com ([2002:a05:6a00:84c5:b0:847:7765:a4c3])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3388:b0:847:7010:f3e4
 with SMTP id d2e1a72fcca58-8488971543fmr9846748b3a.25.1783966680010; Mon, 13
 Jul 2026 11:18:00 -0700 (PDT)
Date: Mon, 13 Jul 2026 11:17:45 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260713181757.481164-1-ctshao@google.com>
Subject: [PATCH v1 0/12] perf vendor events intel: update
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
	mani@kernel.org, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
	irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, perry.taylor@intel.com, 
	Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

Sync the Linux kernel perf PMU events with the latest upstream Intel
perfmon repository.

This patchset includes event and metric updates for Alder Lake, Alder
Lake N, Arrow Lake, Clearwater Forest, Emerald Rapids (including IIO
bandwidth metrics), Grand Ridge, Granite Rapids, Lunar Lake, Meteor
Lake, Panther Lake, and Sierra Forest, as well as adding initial event
support for Nova Lake v1.00.

Chun-Tse Shao (12):
  perf vendor events intel: Update alderlake events from 1.39 to 1.40
  perf vendor events intel: Update alderlaken events from 1.39 to 1.40
  perf vendor events intel: Update arrowlake events from 1.19 to 1.20
  perf vendor events intel: Update clearwaterforest events from 1.02 to
    1.04
  perf vendor events intel: Update grandridge events from 1.12 to 1.13
  perf vendor events intel: Update graniterapids events from 1.19 to
    1.20
  perf vendor events intel: Update lunarlake events from 1.25 to 1.26
  perf vendor events intel: Update meteorlake events from 1.21 to 1.22
  perf vendor events intel: Add novalake v1.00 events
  perf vendor events intel: Update pantherlake events from 1.06 to 1.07
  perf vendor events intel: Update sierraforest events from 1.17 to 1.18
  perf vendor events intel: Update emeraldrapids metrics

 .../arch/x86/alderlake/adl-metrics.json       |   80 +-
 .../pmu-events/arch/x86/alderlake/cache.json  |   36 +
 .../arch/x86/alderlake/metricgroups.json      |    2 +-
 .../arch/x86/alderlake/pipeline.json          |    6 +-
 .../pmu-events/arch/x86/alderlaken/cache.json |   32 +
 .../arch/x86/arrowlake/arl-metrics.json       |  152 +-
 .../arch/x86/arrowlake/metricgroups.json      |    2 +-
 .../arch/x86/arrowlake/pipeline.json          |    2 +-
 .../arch/x86/arrowlake/uncore-memory.json     |   84 +-
 .../arch/x86/clearwaterforest/memory.json     |   33 +
 .../arch/x86/clearwaterforest/pipeline.json   |   19 +
 .../clearwaterforest/uncore-interconnect.json |   10 +
 .../x86/clearwaterforest/uncore-memory.json   |    2 +-
 .../arch/x86/emeraldrapids/emr-metrics.json   |  135 +-
 .../arch/x86/emeraldrapids/metricgroups.json  |    2 +-
 .../pmu-events/arch/x86/grandridge/cache.json |   25 +
 .../arch/x86/grandridge/counter.json          |   42 -
 .../arch/x86/grandridge/floating-point.json   |   56 +
 .../arch/x86/grandridge/memory.json           |   57 +
 .../arch/x86/grandridge/pipeline.json         |  140 ++
 .../arch/x86/grandridge/uncore-memory.json    |    2 +-
 .../arch/x86/grandridge/virtual-memory.json   |    8 +
 .../arch/x86/graniterapids/gnr-metrics.json   |  102 +-
 .../arch/x86/graniterapids/metricgroups.json  |    2 +-
 .../arch/x86/graniterapids/pipeline.json      |    2 +-
 .../arch/x86/lunarlake/lnl-metrics.json       |  142 +-
 .../arch/x86/lunarlake/metricgroups.json      |    2 +-
 .../arch/x86/lunarlake/pipeline.json          |    2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   21 +-
 .../pmu-events/arch/x86/meteorlake/cache.json |   11 +-
 .../arch/x86/meteorlake/metricgroups.json     |    2 +-
 .../arch/x86/meteorlake/mtl-metrics.json      |   88 +-
 .../arch/x86/meteorlake/pipeline.json         |    4 +-
 .../arch/x86/meteorlake/uncore-memory.json    |   84 +-
 .../pmu-events/arch/x86/novalake/cache.json   |  749 +++++++
 .../pmu-events/arch/x86/novalake/counter.json |   17 +
 .../arch/x86/novalake/floating-point.json     |  452 ++++
 .../arch/x86/novalake/frontend.json           |  600 +++++
 .../pmu-events/arch/x86/novalake/memory.json  |  299 +++
 .../pmu-events/arch/x86/novalake/other.json   |  144 ++
 .../arch/x86/novalake/pipeline.json           | 1976 +++++++++++++++++
 .../arch/x86/novalake/uncore-memory.json      |   42 +
 .../arch/x86/novalake/virtual-memory.json     |  338 +++
 .../arch/x86/pantherlake/pipeline.json        |    2 +-
 .../arch/x86/sierraforest/counter.json        |   77 -
 .../x86/sierraforest/uncore-interconnect.json |   10 +
 .../arch/x86/sierraforest/uncore-memory.json  |    2 +-
 47 files changed, 5615 insertions(+), 482 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/x86/grandridge/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/novalake/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/novalake/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/novalake/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/novalake/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/novalake/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/novalake/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/novalake/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/novalake/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/novalake/virtual-memory.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/counter.json

-- 
2.55.0.795.g602f6c329a-goog

