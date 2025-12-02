Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8267E29E10C
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764694427; cv=none; b=lR54Oq1d/ssDrAo/EOIZXZaXquw31A5yptnQeawPjAnXvZmpr6LxpBKSr92aAC9ymdg8ORwjl6ePmK20CETcrWpp8GcNNAbuc6u+27Q9FZi1LVzDt5/PHq5zV8C7+zZxbXnq9ytsBDiLoyDEHNa6hzNUMl27kYFSKVIvkaWJUGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764694427; c=relaxed/simple;
	bh=77SzexNPEzVdad1dhqQ1mMmq8wyAgOayAk8nIyG6rA4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=S9gz/FizAJlrmf46SLrPqVC7mQM4SNK/SIEhlAp3mxWbWUzv5JlgU5jtdY1LgPRfZetGEfm+QGMZGWY1jHXJ035w6kvDoabad50YsqmjuKH/Uc1mZ1ImVRzU+8P45CVWplPMIUlslPkF0de6Y59g3CBTO4kMefiZPkTPNwtQmUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XEyLypAt; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XEyLypAt"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297dabf9fd0so74297325ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 08:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764694426; x=1765299226; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7xR1eg9dXteMerxR6K6VL4zybm40g9HpEFF/wXzaips=;
        b=XEyLypAtM4/PdmBqbBjz4REy/l3KeIM6twIRp1WCWYyp9ySwiXFmFNTPnX6fyZaL8o
         DfkpBCAcFHYFP4OnoDJfEHjxbdC/r+4vN78jZEsKqfjwF2k3wNc6AdmIoHSuWTzoRoLd
         IjCOpQXnYkGHZ506V+B4LwEdeXE9KqO+1CiV0ApHw37M+HV0xggaRXyOInReQUcye92J
         MmjieJyuNKF767/i/hGeCnG3mDgpKsnshTvL/cjEuSQabF6f7GSX52WzSqY0KMykcKga
         OB1bqDbXev3ugx9yjcPAkeMhkzYQ6GHUZy9FNOYC46mwT7+pr5TLyxUd/fqbcCBZ7DIA
         cWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764694426; x=1765299226;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7xR1eg9dXteMerxR6K6VL4zybm40g9HpEFF/wXzaips=;
        b=s1Un7Pw4eMx/jmFPVQe0xy6z4RnrWkfyaW+6X/mtWWOfv6x+TTwaAvWK3ONVSQ0AWo
         ohs9ROAiWkxZPo6tJ7TpntRskCb6F6Qy7oqn+jSo/WI+3NwCLV8dAViNSczilpuD7pcT
         BE+Fb8J62cM4jlio/jKg5hy2tk0cEcv+6PTvqweNwYjxD/TKC2F+Pu6lAIQMKc3aUQCW
         C1Nr2NYgIaS+9fYHk2VYdhJucgbkn2fvLvB9gwDFEuW7Y9J/yWsIqwqrEgHVffAZVZZl
         AH8YzcnnQDyJun5iSuKebROU4qkeWhB34lZzvhB9sJeOvTF0uuqgR6WcZYuS4cMx3B/w
         29Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVT0Zl7xIt/6A2r0EJEQV+ZqXzFFpwAj8qAzJipadNBDD8t7qgiFAvMkVZdqSf5N6U+oSSVMQj90i5wQWcy7sQP@vger.kernel.org
X-Gm-Message-State: AOJu0YwLAzF4yVE+Sg9dFv2zn8y/ECK0mGsWwj86N/jPfuaPaU50BGQO
	aLhPmb5pSeBl9JYQO/hXndPBGXyGUJ/o1/tfsZjgI00wP/NWQTQlc+sDs5Hx9aukdbsYHMAj2df
	RYrd2q6j5tg==
X-Google-Smtp-Source: AGHT+IG/g7hIB6kSH7pTGiy/Z6Mh+2b+sjehXKpsQ8AnVWCTMgJWEkyzlPfgyInh8X8qAiAJwrZyjFkHqg1D
X-Received: from dlnn2.prod.google.com ([2002:a05:7022:6182:b0:11b:d561:bbf5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6629:b0:119:e56b:91d3
 with SMTP id a92af1059eb24-11defc9c27amr47390c88.4.1764694425718; Tue, 02 Dec
 2025 08:53:45 -0800 (PST)
Date: Tue,  2 Dec 2025 08:53:31 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202165340.555375-1-irogers@google.com>
Subject: [PATCH v1 0/9] Updated Intel events and metric unit fixes
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Update the Intel events using the script:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
pulling in 8 updates to event data and a metric unit fix.

Ian Rogers (9):
  perf vendor events intel: Update alderlake events from 1.34 to 1.35
  perf vendor events intel: Update arrowlake events from 1.13 to 1.14
  perf vendor events intel: Update cascadelakex metric units
  perf vendor events intel: Update graniterapids events from 1.15 to
    1.16
  perf vendor events intel: Update icelakex events from 1.28 to 1.30
  perf vendor events intel: Update lunarlake events from 1.18 to 1.19
  perf vendor events intel: Update meteorlake events from 1.17 to 1.18
  perf vendor events intel: Update pantherlake events from 1.00 to 1.02
  perf vendor events intel: Update sierraforest events from 1.12 to 1.13

 .../pmu-events/arch/x86/alderlake/cache.json  |  16 +-
 .../arch/x86/alderlake/pipeline.json          |   6 +-
 .../pmu-events/arch/x86/alderlaken/cache.json |  16 +-
 .../arch/x86/alderlaken/pipeline.json         |   6 +-
 .../pmu-events/arch/x86/arrowlake/cache.json  | 337 ++++++++++++++++-
 .../arch/x86/arrowlake/floating-point.json    |  73 ++++
 .../arch/x86/arrowlake/frontend.json          |  72 ++++
 .../pmu-events/arch/x86/arrowlake/memory.json |  64 ++++
 .../pmu-events/arch/x86/arrowlake/other.json  | 119 ++++++
 .../arch/x86/arrowlake/pipeline.json          | 350 ++++++++++++++++++
 .../arch/x86/arrowlake/virtual-memory.json    | 113 ++++++
 .../arch/x86/cascadelakex/uncore-cache.json   |   2 +-
 .../arch/x86/cascadelakex/uncore-memory.json  |  12 +-
 .../arch/x86/graniterapids/cache.json         |   4 +-
 .../arch/x86/graniterapids/uncore-cache.json  |   9 +
 .../arch/x86/icelakex/uncore-cache.json       |   4 +-
 .../pmu-events/arch/x86/lunarlake/cache.json  |  20 +-
 .../pmu-events/arch/x86/lunarlake/other.json  |   1 +
 .../arch/x86/lunarlake/pipeline.json          |  26 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  18 +-
 .../pmu-events/arch/x86/meteorlake/cache.json |  20 +-
 .../arch/x86/pantherlake/cache.json           |  38 ++
 .../arch/x86/pantherlake/floating-point.json  |  73 ++++
 .../arch/x86/pantherlake/memory.json          |   9 +
 .../arch/x86/pantherlake/pipeline.json        | 305 ++++++++++++++-
 .../arch/x86/sierraforest/cache.json          |  20 +-
 .../arch/x86/sierraforest/uncore-cache.json   |   9 +
 27 files changed, 1650 insertions(+), 92 deletions(-)

-- 
2.52.0.158.g65b55ccf14-goog

