Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A2E12B95
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395929; cv=none; b=AI2R/lvXyAyjGfHQY7pW4S9jPWuApnJE/KOWReVAr/LZDjDc3RaCvJWF27wqaYzREjB5taFTLBeIJ8Kdgcm9ztU7MVbMK6DUM3P7cgLjPU9HT4ESgQzZx/3vUlcXyMSTTAhf+s3i5qLvxTN04zDnfW6EOFfRwscvcM2xPL80TPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395929; c=relaxed/simple;
	bh=SFnRyJCMSz3NfZEXGVAhzmYKO+L+zCZbOzEJqp9PJWE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=eNwBVEpWgydLL4hy01Jqft7BnCqgvRPfvnd3ZXKh19LdjLC8csn+2szUK61+DTiJ+ppexNnZc8/Ut+hwuhBZ9TGh/0xDHglPBmBhGDQpxQD0M0vLM+ihNeFPBMoCzJKCQm+qy5ykLzX17ugoPktS7HsayqQxphNbHZ1kb3/LIrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s8azedEn; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8azedEn"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ee22efe5eeso12976327b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395926; x=1711000726; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YRB7kOoDxawdK6VhegAiSGEkcLRIKP4KVDKeyUalc2o=;
        b=s8azedEn+KepevEJX5SpN2PVrfhM+EzZ2YoM+nqIX+KjwHACI4ScxbPxM4YCPrhREN
         dJCATYpUPo15TipzFE9qx0qUtkFPHXyhMcxORm+e+7P3yOJ93JwZ8OPh/RW/U942RWae
         CFwdqWAjKmskQXT7voGFuSY3kW+ZQ10kllsDy19drUI5sXTcESUt7vBywQZnvXgHb9p0
         Jcal4Ukmhr9O27pKh/HnD1OTA4Ssfc35OC4iLDwNSnIfcC8z2r37B/sDWnn2l4GZMYWT
         B8hngklhgSIaTzbFWpAmm9+7NrX7K7KqyKw0D2Pf1YgFbk35hxeHVUDTGjOXTOFxQzDf
         5AiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395926; x=1711000726;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YRB7kOoDxawdK6VhegAiSGEkcLRIKP4KVDKeyUalc2o=;
        b=XHvLGhOqjt7dHtuZEDkKMcht3uwxj4f3hp07bwlaq7FpzndzqGU5ZuhAPdsW0f9Bmz
         rBh6al6/NJ40UXxb5KmhCTbY8HkTBW5t4IndPvJz/WZu4MQ8hR0UbGu4R8IVDUZQFnMX
         27oofIwqkq6bsYPlHPGrFBVRr4Z5ZKpGQAQAd+vv2+lSJK3Ic2nMWzrSq/cnffTmeofn
         McdeZWB2KxxdHCS/OZ5mRkxrdYjIvT1G28EQedLhloThTyc1FfmzZhIPWpofMPPYpS7w
         okvBUrafnSEtnAaUJKKRuxJvXg6OcFmLWE0bd6nkblBzfvmTgJDgqlo/tPDgqSiNOhNT
         Rb7A==
X-Forwarded-Encrypted: i=1; AJvYcCUY/NuAMdtfKkYF3N06iAXaB31gMNKJB8uilQWlKtWJSjLGfaEAm83Z0rIYkR6E0VP6DbnyH4lF6ba1J9rlpDj0LEbLzRub5EEyeKs083Yhig==
X-Gm-Message-State: AOJu0YwAIBoRGkBAWf6XFj/VV9FMwbQ3+RrO41YJcJgqFXUIPYM1yNS9
	ZcPpps343g30teazedXYeRKMosEoZ3XbYpTeHCUkg2ZyqpFQCV28jMgMiZaCFjAnemS9Joo7b+l
	5SFC06Q==
X-Google-Smtp-Source: AGHT+IESxgUgX1pBvQfMCDwvjsv/KfQ7yj04DfqqVzEGVI0jCFmxm55cadYn7E1/0zQS7Hl11sRsvaJk7u9E
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:240e:b0:dbe:387d:a8ef with SMTP
 id dr14-20020a056902240e00b00dbe387da8efmr22603ybb.1.1710395925934; Wed, 13
 Mar 2024 22:58:45 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:27 -0700
Message-Id: <20240314055839.1975063-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 00/12] Python generated AMD Zen metrics
From: Ian Rogers <irogers@google.com>
To: Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Generate thirteen sets of additional metrics for AMD zen.  Rapl and
Idle metrics aren't specific to AMD but are placed here for ease and
convenience. Uncore L3 metrics are added along with the majority of
core metrics.

The patches should be applied on top of:
https://lore.kernel.org/lkml/20240314055051.1960527-1-irogers@google.com/

v3. Some minor code cleanup changes.
v2. Drop the cycles breakdown in favor of having it as a common
    metric, suggested by Kan Liang <kan.liang@linux.intel.com>.

Ian Rogers (12):
  perf jevents: Add RAPL event metric for AMD zen models
  perf jevents: Add idle metric for AMD zen models
  perf jevents: Add upc metric for uops per cycle for AMD
  perf jevents: Add br metric group for branch statistics on AMD
  perf jevents: Add software prefetch (swpf) metric group for AMD
  perf jevents: Add hardware prefetch (hwpf) metric group for AMD
  perf jevents: Add itlb metric group for AMD
  perf jevents: Add dtlb metric group for AMD
  perf jevents: Add uncore l3 metric group for AMD
  perf jevents: Add load store breakdown metrics ldst for AMD
  perf jevents: Add ILP metrics for AMD
  perf jevents: Add context switch metrics for AMD

 tools/perf/pmu-events/amd_metrics.py | 630 ++++++++++++++++++++++++++-
 1 file changed, 627 insertions(+), 3 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog

