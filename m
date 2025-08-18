Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D483451CE
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543917; cv=none; b=dZYmhXAr3olbtrGWCrVgZmm/npHw2op41Y88i4kEwlNV0IxauX8poWV4Lujet6ohkukI/c/NxLPssFCCdYikLPLDzvPV7SWam7YZ9C6dzi58Tleo/kCxw6RHTKmtYYBDkDYNHvRsDceOdCVL27mX7B5u9x42omNQhPIr07KBZmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543917; c=relaxed/simple;
	bh=mQUy/R7Rtzbiaq4elB3jpRYEzi6LlAKSaPAccWBYTU0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=pak1IBkb+K2bHEsm4uV/2H/+jrXK3vCmef69sjHtAg8E2AsnDniA4zY23SNaeVzbeO2PgiFZ+S1qZOIA8rYaQEfI9u8idbsNmG/mzhr6ynlg3X578vSKyHTzDqXgZh78DlEziwJjZdUJJKL5lTFw0C57n6umMiTpgDUnggv8254=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aMT5YMsT; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aMT5YMsT"
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4b109ab2cbaso126213761cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 12:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755543914; x=1756148714; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c+55fN9RiLmuVRuik+UM5faAm0vumPTB50VeU73svuo=;
        b=aMT5YMsTspDT7GXQ1n80nbX+D/qRcuG7w7FKrRNqKrmfBovw05M2+2npdqf08hflal
         DykOGh03E3kDmWhKBSAb0G4cbFt2r6szWLQtJAageXGQea3EKqt+ZrhaKpnSeHI87Xai
         G4jI/TAFS2KyBFdAevb+AU5F9WsliUwIWP1ZE4ghf/c7DS5bJCdXbDZXeXmBKygCy4qQ
         96HIaBQgiVDxQgKxUc1nALv3QlrC2xrYomT6kNU1Fs15BnUouMc10XhSK6sdKkBd7Ek+
         I7mtRWfLzvT4HUVZDwZ4LhCKBEc6bjDCQj7kxVJi6pF4sIH4x/yFAknMw/MTnbJa0/Yn
         4KSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755543914; x=1756148714;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c+55fN9RiLmuVRuik+UM5faAm0vumPTB50VeU73svuo=;
        b=Ff73/uXZw8QqtRMzEczHJFqDLnV+AvL/P37YJiwvPKbTnZHl0S2aI58qr0zscrDnFQ
         jCVuaLeVWZbd1NMPz8hTalSQa0tNlutCAps4WNJ02K3txZnKQ0pPQQk2a0Xa2Er1o7cn
         toaWvr6yTfPCQTfUrTW48NqI5iEm6JVlDXSxGEbHBnDcaFMWYVpDu3aeE+7hgxl7XH2Y
         2kRExSoWlSL/1ffrV+zYVPvO67LsTHcPBxefWsujjp47lV3axeAKgWA3oy1Mq1il4BZE
         7Q2NNGbPKi+WYn9XJ1/5EoXyS2uJduuLma+YMPsHRhNk9xPyLbqIko/OdQW/fyYSv6VZ
         CoTA==
X-Forwarded-Encrypted: i=1; AJvYcCW8JRvR6azu/AQpPo1Bs2an6ytYT9Wp5PGS2x8oNHbTucdQjceRvbakTRBljQ41kUHzqZQyalSOaUvHbHsg5YAq@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt2e8iKCHxjB7JeUJ+/pk4HcovjzsJw+8WOYytbjNef0qc47dC
	oEYT+beLcmQDHDEW6Jcfmq98tUg3v0AVh8j7Ink18iy50q0QLRJqpd32yismR/qLnrpN4arW7Gw
	OzRbgeWycGA==
X-Google-Smtp-Source: AGHT+IFUZZ/Wi8zIZYymmBNjOsP3U4qb0HfFjq3D4bpjVN7Itx2oR/jRKUd3TBN43DE2ReEAbenpPVCHeCuR
X-Received: from qkbeb14.prod.google.com ([2002:a05:620a:480e:b0:7e6:9841:1022])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:622a:5c87:b0:4b0:7575:7de9
 with SMTP id d75a77b69052e-4b2856a2594mr2661201cf.29.1755543913954; Mon, 18
 Aug 2025 12:05:13 -0700 (PDT)
Date: Mon, 18 Aug 2025 12:03:56 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250818190416.145274-1-irogers@google.com>
Subject: [PATCH v2 00/20] Intel TMA 5.1 metrics and event updates
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Update events from:
v1.31 -> v1.33 for alderlake
v1.09 -> v1.12 for arrowlake
v1.14 -> v1.16 for emeraldrapids
v1.10 -> v1.12 for graniterpaids
v1.14 -> v1.17 for lunarlake
v1.14 -> v1.16 for meteorlake
v1.28 -> v1.30 for sapphirerapids

Update TMA 5.0 to 5.1 removing the slots event workaround as the patch series:
https://lore.kernel.org/lkml/20250719030517.1990983-1-irogers@google.com/
is assumed.

The patches are generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
with pull requests 323 and 324 applied.

v2: Add Thomas Falcon's tested-by. Both Thomas and myself had tested
    v1 on hybrid machines with cpu_atom and cpu_core PMUs. Namhyung
    reported issues on non-hybrid/AMD machines with the fake_pmu test
    - the metrics using those PMUs were failing event parsing. Add a
    patch so that the PMU in a cpu=PMU term is ignored when fake PMUs
    are in use.

Ian Rogers (20):
  perf parse-events: Handle fake PMUs in CPU terms
  perf vendor events: Update alderlake events/metrics
  perf vendor events: Update arrowlake events/metrics
  perf vendor events: Update broadwell metrics
  perf vendor events: Update cascadelakex metrics
  perf vendor events: Update emeraldrapids events/metrics
  perf vendor events: Update grandridge metrics
  perf vendor events: Update graniterapids events/metrics
  perf vendor events: Update haswell metrics
  perf vendor events: Update icelake metrics
  perf vendor events: Update ivybridge/ivytown metrics
  perf vendor events: Update jaketown metrics
  perf vendor events: Update lunarlake events/metrics
  perf vendor events: Update meteorlake events/metrics
  perf vendor events: Update rocketlake metrics
  perf vendor events: Update sandybridge metrics
  perf vendor events: Update sapphirerapids events/metrics
  perf vendor events: Update sierraforest metrics
  perf vendor events: Update skylake metrics
  perf vendor events: Update tigerlake metrics

 .../arch/x86/alderlake/adl-metrics.json       | 104 ++++----
 .../pmu-events/arch/x86/alderlake/cache.json  |  99 ++++----
 .../arch/x86/alderlake/floating-point.json    |  28 +--
 .../arch/x86/alderlake/frontend.json          |  42 ++--
 .../pmu-events/arch/x86/alderlake/memory.json |  12 +-
 .../pmu-events/arch/x86/alderlake/other.json  |   8 +-
 .../arch/x86/alderlake/pipeline.json          | 163 +++++--------
 .../x86/alderlake/uncore-interconnect.json    |   2 -
 .../arch/x86/alderlake/virtual-memory.json    |  40 +--
 .../arch/x86/alderlaken/adln-metrics.json     |  20 +-
 .../x86/alderlaken/uncore-interconnect.json   |   2 -
 .../arch/x86/arrowlake/arl-metrics.json       | 180 ++++++++------
 .../pmu-events/arch/x86/arrowlake/cache.json  | 122 +++++++---
 .../arch/x86/arrowlake/frontend.json          |  40 +--
 .../pmu-events/arch/x86/arrowlake/memory.json |  22 +-
 .../arch/x86/arrowlake/pipeline.json          |  94 +++++---
 .../arch/x86/broadwell/bdw-metrics.json       |  30 +--
 .../arch/x86/broadwellde/bdwde-metrics.json   |  30 +--
 .../arch/x86/broadwellx/bdx-metrics.json      |  33 ++-
 .../arch/x86/cascadelakex/clx-metrics.json    | 139 ++++++++---
 .../arch/x86/emeraldrapids/cache.json         | 100 ++++----
 .../arch/x86/emeraldrapids/emr-metrics.json   | 131 +++++-----
 .../x86/emeraldrapids/floating-point.json     |  43 ++--
 .../arch/x86/emeraldrapids/frontend.json      |  42 ++--
 .../arch/x86/emeraldrapids/memory.json        |  30 +--
 .../arch/x86/emeraldrapids/other.json         |  28 ++-
 .../arch/x86/emeraldrapids/pipeline.json      | 167 +++++--------
 .../arch/x86/emeraldrapids/uncore-memory.json |  82 +++++++
 .../x86/emeraldrapids/virtual-memory.json     |  40 +--
 .../arch/x86/grandridge/grr-metrics.json      |  20 +-
 .../arch/x86/graniterapids/cache.json         | 227 +++++++++++++-----
 .../x86/graniterapids/floating-point.json     |  43 ++--
 .../arch/x86/graniterapids/frontend.json      |  42 ++--
 .../arch/x86/graniterapids/gnr-metrics.json   | 131 +++++-----
 .../arch/x86/graniterapids/memory.json        |  33 ++-
 .../arch/x86/graniterapids/other.json         |  30 ++-
 .../arch/x86/graniterapids/pipeline.json      | 167 ++++++-------
 .../arch/x86/graniterapids/uncore-io.json     |   1 -
 .../arch/x86/graniterapids/uncore-memory.json |  31 ---
 .../x86/graniterapids/virtual-memory.json     |  40 +--
 .../arch/x86/haswell/hsw-metrics.json         |  32 ++-
 .../arch/x86/haswellx/hsx-metrics.json        |  35 ++-
 .../arch/x86/icelake/icl-metrics.json         |  96 ++++----
 .../arch/x86/icelakex/icx-metrics.json        | 155 ++++++++----
 .../arch/x86/ivybridge/ivb-metrics.json       |  30 +--
 .../arch/x86/ivytown/ivt-metrics.json         |  33 ++-
 .../arch/x86/jaketown/jkt-metrics.json        |  20 +-
 .../pmu-events/arch/x86/lunarlake/cache.json  | 104 ++++++--
 .../arch/x86/lunarlake/frontend.json          |  40 +--
 .../arch/x86/lunarlake/lnl-metrics.json       | 216 +++++++++--------
 .../pmu-events/arch/x86/lunarlake/memory.json |  22 +-
 .../arch/x86/lunarlake/pipeline.json          |  85 ++++---
 .../x86/lunarlake/uncore-interconnect.json    |  10 +
 .../arch/x86/lunarlake/uncore-memory.json     |   8 +
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  16 +-
 .../pmu-events/arch/x86/meteorlake/cache.json | 129 +++++-----
 .../arch/x86/meteorlake/floating-point.json   |  28 +--
 .../arch/x86/meteorlake/frontend.json         |  42 ++--
 .../arch/x86/meteorlake/memory.json           |  15 +-
 .../arch/x86/meteorlake/mtl-metrics.json      | 103 ++++----
 .../pmu-events/arch/x86/meteorlake/other.json |   5 +-
 .../arch/x86/meteorlake/pipeline.json         | 173 ++++++-------
 .../arch/x86/meteorlake/virtual-memory.json   |  40 +--
 .../arch/x86/rocketlake/rkl-metrics.json      |  97 ++++----
 .../arch/x86/sandybridge/snb-metrics.json     |  19 +-
 .../arch/x86/sapphirerapids/cache.json        | 100 ++++----
 .../x86/sapphirerapids/floating-point.json    |  43 ++--
 .../arch/x86/sapphirerapids/frontend.json     |  42 ++--
 .../arch/x86/sapphirerapids/memory.json       |  30 +--
 .../arch/x86/sapphirerapids/other.json        |  28 ++-
 .../arch/x86/sapphirerapids/pipeline.json     | 167 +++++--------
 .../arch/x86/sapphirerapids/spr-metrics.json  | 153 +++++++-----
 .../x86/sapphirerapids/uncore-memory.json     |  82 +++++++
 .../x86/sapphirerapids/virtual-memory.json    |  40 +--
 .../arch/x86/sierraforest/srf-metrics.json    |  20 +-
 .../arch/x86/skylake/skl-metrics.json         | 101 +++++---
 .../arch/x86/skylakex/skx-metrics.json        | 101 +++++---
 .../arch/x86/tigerlake/tgl-metrics.json       |  97 ++++----
 tools/perf/util/parse-events.c                | 116 ++++-----
 79 files changed, 2930 insertions(+), 2381 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/uncore-interconnect.json

-- 
2.51.0.rc1.167.g924127e9c0-goog

