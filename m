Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C199B3CFF62
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061648; cv=none; b=T1eLlqO67plATwDJ/ULsrm+DR+RpBE9ERIyB3UveZwpuzPpgx5dkX/ZzYMauwnKYjIktm3RWd6b6dRjYsw6AOJqI66m1IqyL1PnOXCEy51thtgxfoC4oFegqCyhYddzV1y9NTRP0cOnKSuAMLQAycWk0T7KmEhINy+P6A9Auyao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061648; c=relaxed/simple;
	bh=VgExpfNu3lZmKHCmtMpuk7R6+PLBj8nT8rnesfvjB80=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Miu7iIFA9flXeLLq/0aXCPGKrsMSvoX/u8PV9+5RG//b9bh3xO/WG+X0Yvm7t6gJ002ynA1HGinvDYGHD6douVIkBzMz0cHown3CicaculkAUN1ZKEtWZVa+9VUjqPHwV/kmoa1hKlMyJU6mGy97cM7ASCSOhujpK1KX0G4Xie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=noUriIRJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="noUriIRJ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-38dbf293831so3123537a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 13:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784061646; x=1784666446; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+JL9QwVOyJ+VrIoOZFMNaTJLh3RvoRBpKpBm0Mv8ixM=;
        b=noUriIRJd4qq90Y8A/QXlbG6uFJd3wl8djN3yy7uBMIxkKZmc+42V0/87xt6sKkBBD
         1/4K2MccvShR+BM4//xDa4PSrDQN+YkgIg5LRRGHpl2qINUxb84MJuLSNTWiLWEx/GjG
         tmfdRce/M95I3KiEA9wWvjkpV3Hs7C0zCLki1WKiW6qWL0Ve/73+8MUfAmMJzBmGAaeN
         yD5TQkkC0399pjA4wkNdQ1AUqkcwmDny0ldXifD6Qg40F003Yst8ssjrG1xCqtWA43XY
         NYMANLlHSB9FaMZvv3pX5noieWiO9ouzGwNWWdNF0Bfzce55I+gg0bsJf6JPogLu9p2q
         b57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784061646; x=1784666446;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+JL9QwVOyJ+VrIoOZFMNaTJLh3RvoRBpKpBm0Mv8ixM=;
        b=lgtGSh4sZPURKmBnAulVWvrM9BpJPSRtPpk44fVm40CLF2j+0WJmWK4hs5HcNZr/PH
         IN0Qub6ioiitOrAS12XP999MvrUQzdoXaHLnVksuXDa8174+ucKMPy9hxPoxGrthxHId
         02gKNV6kmTmgLEYFloTH2WXA6N41wmg6VSMdWTx+7ZnZ3e1iSBiXvw6/OMaEGbMnUtDr
         +y65e9dEmQZTSl/5YSlqDXa29s3xWf8Hn4N5dyuAheNUwiRztZw0KVebCMJpDUcE9EGt
         Y9I0qeHXMx0Q6UOOE1IwTgWToR7dhVFP9QZdVxmF6p3QcLbjkHSyzUPjn+dH3WDEvSWK
         zG/w==
X-Forwarded-Encrypted: i=1; AHgh+Rq2+qvUMCglYjf9p/gpa7hKKro3g5k9TpRYmCzP591vZajvoKOcng2fG/JxR/6D5L2fINhDx4+QGgVQfn+7uRnM@vger.kernel.org
X-Gm-Message-State: AOJu0YyG19ejW3v+9EE6bCRUSrNoV6T/jh7STdeaALLabXrgXdTjZMVF
	9xAyE81jlkgfPCHzZnsPzn52TKn/XF3hxIACpKH45O+mRZOKGH+Y/dS4dFCcWAKEHZwB9sEQDuh
	FMTutfA==
X-Received: from pjbem12.prod.google.com ([2002:a17:90b:14c:b0:385:fa6c:f60e])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c88:b0:38d:b36e:9824
 with SMTP id 98e67ed59e1d1-38dc7736eb2mr13019942a91.20.1784061645889; Tue, 14
 Jul 2026 13:40:45 -0700 (PDT)
Date: Tue, 14 Jul 2026 13:40:31 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714204044.1952031-1-ctshao@google.com>
Subject: [PATCH v2 0/12] perf vendor events intel: update
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
	mani@kernel.org, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
	irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

Sync the Linux kernel perf PMU events with the latest upstream Intel
perfmon repository.

This patchset includes event and metric updates for Alder Lake, Alder
Lake N, Arrow Lake, Clearwater Forest, Emerald Rapids (including IIO
bandwidth metrics), Grand Ridge, Granite Rapids, Lunar Lake, Meteor
Lake, Panther Lake, and Sierra Forest, as well as adding initial event
support for Nova Lake v1.00.

v2:
 - Fix Novalake CPUID regex in mapfile.csv to match single digit model
   numbers without zero padding (GenuineIntel-18-[13]).

v1: lore.kernel.org/20260713181757.481164-1-ctshao@google.com

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
2.55.0.141.g00534a21ce-goog

