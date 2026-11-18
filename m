Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795037220;
	b=XYkX8SuoHqpQGas76MYDP1iQD2FUO6Deupbc/obDCQouB9XUjjbGSws/P2BusfhUIho9
	 LT8qCUVBKegXp0lvj6vyVipN46EXoORj7t8Myw67HNnjWP5JuJgnPKahTj14nwQ6dsa8v
	 ZTXhiIw2HqK5rv2ST9GYl1d1cDqC9yZ8YFFdpkNnE1DvwAjn0/B8dWMqas6AG6vszieLj
	 ls4QigE8XuGM02+LOu+wZb57G+DYE1fOwdCsO6jocgzY47KNWzpln2gVl1KsiAEuJZR4O
	 Y8Zoc6UTZbAu3XYfE4trGpSNLRIgylff6mgFFAMJpozzwHPkHyeCiWrfnLTP/hcNU5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795037220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=1bS4ZwGQg8uJ+f7Y+a2FFJOJtfKOuwyuAYnXgPVM07A=;
	b=JfY0NGpxkri8POTlf58pPmc302fgXLso18Epi5V/dCUMfUF8nQYcoQhn2zi44sxu6BBF
	 tdBcLGqCpHBaBjt4mLDPghLJeC0MeRw7Ir+5SGOkonkSWMEvjmgUTHsTGtu5s9FWeFv7y
	 NndmfU9KVs3/90R7hpBLxC7FKBzett64kjBSrcQGD2M1Dl+dko5AEX7yRNwdrVNIqHfve
	 oYfVy866//a3ocVWfB/D5MhKzWwfIFbj4JWcZa536QPdQm2vahYX6IevddbXECDaFrS7T
	 hFzS/lesMK4YvXdaocSTyuTTjocXzAz2RXqNQ3b2/Bu6fqiciTjMKJSdlT/rOQZq0vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="ae4s22r/";
	arc=none smtp.remote-ip=209.85.160.69
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC894606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 21:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC894606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ae4s22r/
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-45e6091d8a1so1082268fac.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 13:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795037218; x=1795642018; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1bS4ZwGQg8uJ+f7Y+a2FFJOJtfKOuwyuAYnXgPVM07A=;
        b=ae4s22r/sYFADCDDv5hLEpMhWoeb3vC1D05D1SQWEfBl5Gel9c3/eFlDModFC5YHur
         jaevPBUbV1ZcUZBw7ReRyGa5KA6uMp4+lstqkC/NPiUfmY2HhqEi1sntbJqgo30RVmrl
         3ubUfXfNMzSiOAjZZ83J5bM55CmOQejgAL20XkPgCx5EyUGVZUveKCXQNQKjAd0nL1So
         YrX+a38Qe79kE1yLCrkJB63HQiA8XlZ48Zwjg2cMGGchZFE9SI9uqERafx/vLv5wdNuA
         OeO93vuC0KgBL6JMEGXDwIVe2a8W4gBL2N8TMACu/Kbbyv54UaHe1HarjlzmJ8Xisx2u
         Woqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795037218; x=1795642018;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1bS4ZwGQg8uJ+f7Y+a2FFJOJtfKOuwyuAYnXgPVM07A=;
        b=MPgMVkPeV6ByKhPdrvRfaReSVUcDKK66ittuXvt1RgiR7B1y78Amrd7z4PTGm52HnW
         dvdhBM1Ju8oOP4whtX7oa+TUXZyK7hjAOaIr5TF1nYo5NaGcNHKFbCUm4ebaTrehHxYo
         zCbxRPV2cs6c40m8TKX9DHb9otWOSMC166uleCOhUqR8mWAWvcwvFhUzQ59lAzPXhjEw
         NEsa+3jnU01oUZ8z06tzbYoUm2uLhqYBk+poMdFHM1qrUDwSvUr2dJ/2AHjbwXhZ1jhS
         RrDkP8I9p/k0nUxmh1Hfwphwp+u86nNweoXLaeBM42s+bbG+DxHVJ43HHFgwdUfk3Rk6
         FqBQ==
X-Forwarded-Encrypted: i=1; AL+hErHH0mdPDztpPlKy1Mnb3KEDufmi0fKyAyVFRAqMBSJ+QbGw2SkHKK6duDwCStVn9U3G5HYZxLC7MIkUhIGxaudi@vger.kernel.org
X-Gm-Message-State: APuU4Z8F5gVJQGfe7nSGl4CYFLFG6vD1q+82XenwdjwLVAY6vLwWqBAZ
	9zn31P+/0/vI+0BO7H9kW+GEOIiIJ0zR4mc/CAMoQ+iXUAW3MtcUXXpS7lnvYTThpL4sKBUWySh
	DDX8ang==
X-Received: from iocre7-n1.prod.google.com ([2002:a05:6602:87c7:10b0:9e8:de6c:a5a3])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:87d1:b0:571:a186:d6b9
 with SMTP id 5614622812f47-57740b4759cmr4859253b6e.13.1795037218323; Wed, 18
 Nov 2026 13:26:58 -0800 (PST)
Date: Wed, 18 Nov 2026 13:26:52 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118212655.2262601-1-ctshao@google.com>
Subject: [PATCH v1 0/3] perf vendor events intel: update
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

Sync Intel PMU JSON event files with the latest Intel perfmon repository
(https://github.com/intel/perfmon/commit/1e224c0fd9d9):
- Add Diamond Rapids (DMR) v1.00 events
- Update Lunar Lake (LNL) events from v1.26 to v1.27
- Update Nova Lake (NVL) events from v1.04 to v1.05

Chun-Tse Shao (3):
  perf vendor events intel: Add diamondrapids v1.00 events
  perf vendor events intel: Update lunarlake events from 1.26 to 1.27
  perf vendor events intel: Update novalake events from 1.04 to 1.05

 .../arch/x86/diamondrapids/cache.json         |  952 +++++++++++
 .../arch/x86/diamondrapids/counter.json       |   52 +
 .../x86/diamondrapids/floating-point.json     |  419 +++++
 .../arch/x86/diamondrapids/frontend.json      |  458 ++++++
 .../arch/x86/diamondrapids/memory.json        |  295 ++++
 .../arch/x86/diamondrapids/other.json         |  777 +++++++++
 .../arch/x86/diamondrapids/pipeline.json      | 1423 +++++++++++++++++
 .../arch/x86/diamondrapids/uncore-cache.json  |  292 ++++
 .../arch/x86/diamondrapids/uncore-cxl.json    |   22 +
 .../diamondrapids/uncore-interconnect.json    |  218 +++
 .../arch/x86/diamondrapids/uncore-io.json     |  386 +++++
 .../arch/x86/diamondrapids/uncore-memory.json |  939 +++++++++++
 .../x86/diamondrapids/virtual-memory.json     |  266 +++
 .../pmu-events/arch/x86/lunarlake/cache.json  |    2 +-
 .../pmu-events/arch/x86/lunarlake/memory.json |   27 +-
 .../pmu-events/arch/x86/lunarlake/other.json  |   19 +
 .../arch/x86/lunarlake/pipeline.json          |   44 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |    5 +-
 .../pmu-events/arch/x86/novalake/cache.json   |   13 +-
 .../pmu-events/arch/x86/novalake/counter.json |    5 +
 .../arch/x86/novalake/floating-point.json     |    4 +-
 .../pmu-events/arch/x86/novalake/memory.json  |   39 +-
 .../pmu-events/arch/x86/novalake/other.json   |   84 +
 .../arch/x86/novalake/pipeline.json           |   75 +
 .../arch/x86/novalake/uncore-cache.json       |   11 +
 25 files changed, 6814 insertions(+), 13 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/uncore-cxl.json
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/uncore-io.json
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/virtual-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/novalake/uncore-cache.json

-- 
2.56.1.708.g77570a6a1d-goog

