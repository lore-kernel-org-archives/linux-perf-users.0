Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E982528F9
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212695; cv=none; b=ev36zoQzqAQz1HXjNR/GhY4GvQ2WS86W0DSEEfkqroFnMAUcqGuNsNGu81Sv7gMed44L5tp0gRsH5ViswS7YJMaTKy3GRtWlX9DG4vl6X9EIknOQXP+vG6vtBObEIfGVxQnp1YDkvU2jfW3eoSklfemIvNeNsyNVQ+Kt/b5vOLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212695; c=relaxed/simple;
	bh=2RiYDLwMwo+3o1Rh150ox/2Ds+UQGDsp5SIrdFR/G5M=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=BDLQFjgTVxhpJuGSDJlg0Ry1q02VGiD52Odla3NM+K9H2LKaXHk9JwNulM0WF+OARpyIXCSIro9W2Gw27pBIBK8EZUEclXyv7pr3EFHPpmoaitK93rhQNMd0Mp6ah+NIAgLSRODBeTIbFWLehnSl2ojPGoLuFhtMSqY5GrEkG2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3X1j/jGD; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3X1j/jGD"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f9ac4488b7so36631297b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 10:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739212693; x=1739817493; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iwUMk+OxJTOu35k1pyUFhV6dIHRv3ss2tL9VxoHZRTw=;
        b=3X1j/jGDfor8iDK6LDB3zsLVh164mq1j64xN4YJS6AdK/m8J0E3c685LlsfvIDUaLW
         MlwPHydJhBs4SvhJ07/ZVN0Dnu5cKZlbTgSxbhL3ECwxf8S30omBvH/aFcgj6htn+sEp
         UNCar6OS5a7s7G1KajbYdoKD2Eq4xoJMNG3pW8AckywodsWCSwEo576XySe8CzLrq3Dt
         w/k/AG69jLLPMH2/MIs3oTdsasaZR7T2FWAnfRyDRiv2ZwhCEWF+t97EWp8t5r8q68LZ
         ujQsYRZv1VHT4tI3kAg2Foxc3/xTFNYopR2M6plTBRITxRah9jxGBRjb7tnS4C8Ne+z+
         iW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739212693; x=1739817493;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iwUMk+OxJTOu35k1pyUFhV6dIHRv3ss2tL9VxoHZRTw=;
        b=VBTKaNWQ6AawwYmHZE1CBnbNi5JgPFT5z5bCvl+WwW/GSpK61r0T/VK75LekLZ1HD7
         s+8+swWjOWv6swGcjuvSXomo7RAsGFAzHF8S2w4mFC1lRzOBmA7ohW3oj/2AWQpTnf1g
         OwNy12mMfgjrIjJul7t7ZvmL5z4u46/F6oeXwX6SaVxOmdicRss7PNbmsDMH21tRC866
         CiaIj7rVja2myvRdB6KxMJq1YBrJ17H5yWJclbKjaju0egv+cw8q8aW6UP8EBiErA+T5
         VvBKZcMTrlL2qpMsnehSHsuXNijvbaa60S/CGSJ27RjAhZixV0GMw+lICzRYwhnk0ewT
         77LQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5R1n43DVqYIzbNySTvoMk4TvxDF7q5yDhSyfEONEZVSidd5MUqfJT9IhZ588rIvq4QrF5aA7HpH78OO3nfoma@vger.kernel.org
X-Gm-Message-State: AOJu0YyHML+vDcpaplDZCZmhUXgg/w8+El+yukNMmz9hQbnRfFwV9FH7
	uPrmRMaZz8gzid0qRA7DaHCB2htrzFQPrPrehI0e8pDKe74agFqstCDeKzmiWnTv0kn1OLvtL2t
	FDZdfeA==
X-Google-Smtp-Source: AGHT+IGq49OLNDJnWSh3CcwgE/lcDqLP3G2iWs1LSR4UpSm9e/aM27fBw4XgIenTsEM6jDAN07gwFa/sT5yk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c64e:af58:30d4:168d])
 (user=irogers job=sendgmr) by 2002:a05:690c:45c5:b0:6f9:a9d0:2b20 with SMTP
 id 00721157ae682-6f9b29cdb2amr1485907b3.3.1739212693188; Mon, 10 Feb 2025
 10:38:13 -0800 (PST)
Date: Mon, 10 Feb 2025 10:38:04 -0800
Message-Id: <20250210183808.130522-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Subject: [PATCH v5 0/4] Add support for cpu event term
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Being able to set the cpu mask per event was discussed in the context
of a sysfs event.cpus file is discussed here:
https://lore.kernel.org/lkml/CAP-5=fXXuWchzUK0n5KTH8kamr=DQoEni+bUoo8f-4j8Y+eMBg@mail.gmail.com/
Ultimately Kan preferred to have multiple PMUs with a cpumask each
rather than an event.cpus file per event. It is still useful to have
the cpu event term and so the sysfs part of the original patch series
is dropped.

v5: Purely a rebase.
v4: Add the stat-display output change for zero counters Namhyung
    requested as part of the series:
    https://lore.kernel.org/lkml/Zvx9VbJWtmkcuSBs@google.com/
    This skips zero values for CPUs not in the evsel's cpumask rather
    than the evsel's PMU's cpumask.
v3: Drop sysfs event.cpus file support patch from series.  Reference
    to using cpu to modify uncore events is dropped from the commit
    message. Reference counting issues on the cpumap are addressed.
v2: Add support for multiple cpu terms on an event that are
    merged. For example, an event of "l1d-misses/cpu=4,cpu=5/" will
    now be opened on both CPU 4 and 5 rather than just CPU 4.

Ian Rogers (4):
  libperf cpumap: Add ability to create CPU from a single CPU number
  perf stat: Use counter cpumask to skip zero values
  perf parse-events: Set is_pmu_core for legacy hardware events
  perf parse-events: Add "cpu" term to set the CPU an event is recorded
    on

 tools/lib/perf/cpumap.c                |  10 +++
 tools/lib/perf/include/perf/cpumap.h   |   2 +
 tools/perf/Documentation/perf-list.txt |   9 ++
 tools/perf/tests/event_update.c        |   1 +
 tools/perf/util/evsel_config.h         |   1 +
 tools/perf/util/parse-events.c         | 113 ++++++++++++++++++-------
 tools/perf/util/parse-events.h         |   3 +-
 tools/perf/util/parse-events.l         |   1 +
 tools/perf/util/pmu.c                  |   3 +-
 tools/perf/util/stat-display.c         |  21 +++--
 10 files changed, 125 insertions(+), 39 deletions(-)

-- 
2.48.1.502.g6dc24dfdaf-goog

