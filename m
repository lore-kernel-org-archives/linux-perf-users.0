Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49D014A83
	for <linux-perf-users@vger.kernel.org>; Wed,  8 May 2024 03:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715140393; cv=none; b=O2B8aVgwtLWPczBcaiZ+2qdYjLFSOzqoHJDfEvuX3DwOsKB8D8tBViX/1FVxqMF37QHWaWuEspbcrcZIptlXwqzAwOsU/lqmhPND+3hLgFR/51ZFi/2y0lGleJ5Kkz2AGitgJwYChm1BAOvL2iCJbRNpoiX3kUTBYE4DeVGsRGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715140393; c=relaxed/simple;
	bh=ROPg/gfI2eavy9Z1CPY638eJak5zjeWpfDVytTAIiTE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=aglh1N30SqT30lKyLi3IIFvfzO0DkmWINQpPVRO73UH3jWKS3BfnY7ccIMlLcarU72M+HWx0cc92yWP2xZHPvIdq8v/fO5Th+GJZoCphiMFOGEps423CxEShu9z6Cv+PLLLRG0OaDUIsulLx8Huog7igc1By+rokWjo+A3Dr02c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dFWc5Iuj; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dFWc5Iuj"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6204c4f4240so52664057b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 07 May 2024 20:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715140391; x=1715745191; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mufc51TKTvUTkAvo+jJkjhWq+JDNmar0wgLRYKt6Lnw=;
        b=dFWc5Iujjrakmamh04ul7wfeuL1tbmoMQX/iZLg/wUlvTtwt4X51eyuww/GHDVLvp9
         JgyHeg7VAOUuHQWHxRMsll7mthFr1TuwgaanwHQruIi7v42dTeWTgBzDelmxBbdkwnMS
         lepr/s/D5JfVzl4KJxxJ/+c1Mzw5DG5UEqbX4zmomHHj28+/hU7Kfq+2Grd8yIejc04S
         gsiYj1MPtBdJXkJDI2Xr0vI9uownUSuov7gXi0tuRJc6DR6/cEWadbe2252BjKTmNgTY
         60l7iQpF+wlys6S5egSzMlBKY6RDk7vMm95qouyDZw+aFGRXtkwD+ao5O64r6zLtJMrf
         wiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715140391; x=1715745191;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mufc51TKTvUTkAvo+jJkjhWq+JDNmar0wgLRYKt6Lnw=;
        b=M8BwP89n8Zajcy9f1u/IOJsFER/jT4APDWdRMNj17+2hYLxv3wxC9dtS41H0Q+stxD
         12HZCUBFGJGPfNy5YWjEA6ZbanlVa4y0V1G46T0cw7MxI4UQp08uiDmA5yrJIvI5pXtC
         WvwnntLLAaBNSp0TRLli410yg2fylwjYgXXhEqbGcgouzw7lxtwysVPmCpooo8cWq+aD
         HddSgfGn0RFYyPti1U5634xWAlbYAJNv8OFEzkSLOH0gWB5oqNZr8XVDf2YJuUKJneqw
         JrqsM7pVXhAPBCtnIzYmonkgLgwPvLtGQhgRBH4woazhCn8LRpqMPUqXRAwGCz0R2yfd
         054g==
X-Forwarded-Encrypted: i=1; AJvYcCWMNuS3pgmbAzNjYwBlay7qRjKgwcTETjzIBqfrFwEwbN6skjYEJh2V3+b+2LbC3iBYgpiPAQtPZh8+ZM+7QXLKlE6P0PMyU20JSqzGI2aiRA==
X-Gm-Message-State: AOJu0YyLF2BWOfF1rg1K2fXOAuCsTv7mdwx561DSes+30HpfjD3aCDBJ
	enGFBvVITCJv+h4ispE5HDX1Q3z8EhnaD5VIV1v9O0xRv3FeRIsQbMm3hP0MVr9L6w5uXkygG8p
	6hxDkKw==
X-Google-Smtp-Source: AGHT+IEig+LG6Dz276JK7E7u4akAR3x+i2ywHtItBHE9xxlwABAkOAUt+KeEphX6wlCTPwCgxtBd70QZTXQF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:56f9:40dc:113f:ba3])
 (user=irogers job=sendgmr) by 2002:a0d:db05:0:b0:61a:d0d1:1813 with SMTP id
 00721157ae682-62085a332d4mr3619277b3.2.1715140390933; Tue, 07 May 2024
 20:53:10 -0700 (PDT)
Date: Tue,  7 May 2024 20:52:57 -0700
Message-Id: <20240508035301.1554434-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 0/4] Segv and RC checking fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Resolve issues found with address and leak sanitizer by running 'perf
top' and 'perf mem'.

Ian Rogers (4):
  perf ui browser: Avoid segv on title
  perf comm: Fix comm_str__put for reference count checking
  perf report: Avoid segv in report__setup_sample_type
  perf thread: Fixes to thread__new

 tools/perf/builtin-report.c |  2 +-
 tools/perf/ui/browser.c     |  2 +-
 tools/perf/util/comm.c      | 45 +++++++++++++++++++++++++------------
 tools/perf/util/thread.c    | 14 +++++-------
 4 files changed, 38 insertions(+), 25 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

