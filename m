Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4C41095B
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165745; cv=none; b=SLPCeSH6oz+o8G82BLKKOL1D11pMwCowyMkeb3+LAdeZg14ASEELrCmCGmQd2jhhqiWZz7K2TcPbL4WjJ58OTXiYnRGiVIC61nvwPYy/HwsCfKg5mayvE2Z4lrzD57XWeuQaQJRGuIArYwI7tHXHSXaIr4z0qihnchal7iAP66w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165745; c=relaxed/simple;
	bh=w/dBhGtqOiet87mj9CIQnP4Eds9GW8q+8jq3/Y99j+Q=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=Iaoo1ZhHF0dc5gdvm3hUGhxxSzuvhGkovxipTUyCxaEmUEC8vU+QrQRN7yK+IZxfxbFCTjvnIztHTRBkke4M0P7pSWdBNWdKbGVKnBzgJfm6T2FafXeeWcMEIaunr3n151+wNL+EE2X2BRjqu5rqJkojHor1gnRVoQsNvBc+Dvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c8EToDgm; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c8EToDgm"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc746178515so523218276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165742; x=1709770542; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dcL9AcUcVelYgbT04eVXrPkevsg/BMkfHE93xGttlPQ=;
        b=c8EToDgm3weolB5MosjoVzxiKMjJhwCczhCLU6c4JRdhkzC+UTLpnTzNV5ofHhZxCh
         n3VM45pP3GyRjTswNoq8WK3EJSISyzG550UXdZXecDQUJofvpuWWzznR0aLx/6pvlAhl
         mdrHq5dSkDTTSjGQvyCbSB2X8wy2mFReBpe7OEsI4g0LzRuGX+BhAMEUjtGUzdbnxrpX
         5DL9wlB4X4Vy0upWgubY3KYcjtRcx+jvR3mYvjcNw2pT8NDsTJDPNiZs4moGrm+GP7J/
         BZXYNjzx/ZePPvtbkzSmG2xWPsdn1rSM6nPA01zAoV8vyG7STB6c0/E+uBDXpnrHQRi9
         bTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165742; x=1709770542;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dcL9AcUcVelYgbT04eVXrPkevsg/BMkfHE93xGttlPQ=;
        b=LpDYSxcrxzLTA+zHruMLNw3J7MZGJPwsANMt/10Ln5sRMvZYggWJwRfCVeErJEVo9g
         lCViWLGyfC/eklJJFqQt+BI9sno6y/G4PnVc8A3Pn0UEE+BvkT+VWO0KOy0Yom52xr09
         wOrO9C6nGVu8pHv8bbYEmZkPhNfvd4b+ijc5F6duPH3f19f1mVSzlzfNlJMTdpZ0gTzP
         4YAUFlsQEuN4KfUcHeg370Q22XutIoXkJptMwP+hSa61oAh3GwN4oE19vO9lWOu3xH8P
         RNCbW9+LScundIkAtjC7OF+FKr0kYolCr3wBdAvPE22STPFncEkMzRjdrU9OP3qbHTpZ
         HTEA==
X-Forwarded-Encrypted: i=1; AJvYcCXj+aichmZlOxjr6UZ7D9jM8WSEsKA+pCJsUYw+SgkOyN7mYY97RGTxuEtcgvjHNJHjevjqKJLogN3Qcqp9hMwWnKAWaleo7wISXDQX2YPAnA==
X-Gm-Message-State: AOJu0Yy8MULR78fgsQ6HDNFa0qY9M9g0jukWpF8Ms6cGOSfGQm1WOeOd
	KfgWom/pVLGEHZgQdX6ZyR8lFfSGf71j6W3770/92642bgBtX9hBXagNdtanPkYJDq9F3VOvI4n
	2P/PV0A==
X-Google-Smtp-Source: AGHT+IGND6Qa1OhIK+/LURQLPHsXWevjR53gBA3AGOP9QOSuPeaerLixCesSaoA8q007Yg/DowVW9VFapZST
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:250d:b0:dc6:f877:ea7b with SMTP
 id dt13-20020a056902250d00b00dc6f877ea7bmr198122ybb.9.1709165742694; Wed, 28
 Feb 2024 16:15:42 -0800 (PST)
Date: Wed, 28 Feb 2024 16:15:24 -0800
Message-Id: <20240229001537.4158049-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 00/13] Python generated AMD Zen metrics
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
https://lore.kernel.org/lkml/20240228175617.4049201-1-irogers@google.com/

Ian Rogers (13):
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
  perf jevents: Add cycles breakdown metric for AMD

 tools/perf/pmu-events/amd_metrics.py | 642 ++++++++++++++++++++++++++-
 1 file changed, 639 insertions(+), 3 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog

