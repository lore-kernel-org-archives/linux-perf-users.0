Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB7729E10C
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764694446; cv=none; b=eX74Y/ah2g0dYhMns9XYfuS64KlfMbkA+QS1baKjbUutoTRB39t0rwaAUlum/WP3YNMc/vXvSp9XKRwqqV3mMSyCcVmU+NgKVajKnknYa7nco6Gf5/Nma+18OsqVRy28sTLjb8C2zns5nXcVZlR5SvqJvCqEeO3y1EzJdOmPgGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764694446; c=relaxed/simple;
	bh=nNHcs0DUB7nf7hwDPKvXK0WgDHVPc0TmWK+BLYEYkxE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rqYCgyBA+pMUtue0GbJyOEwk8vq9XjvUH3z4xZHFTS8WJJ4oLBigL+i49CFbKfKZgnuQWa1BCfVHFEmJyq/8Vr+5T+w8Ow7PV5ZanGi6pxRPFH2DBhW72R+4dRcKDkdHauTDHYYw9smp1VqXrrkx28jOQ8TW7QiHd409uoewqjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NMjRysav; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NMjRysav"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b471737e673so6399457a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 08:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764694445; x=1765299245; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=irZdGfd8l7RF6Kc9iRoeY7vDXGKKY13eJTFmZePo56w=;
        b=NMjRysavUqMm5zGN9Y6YHvM9f6lmmxqNxCJLNlJSh+zxpB8zGPJSs+UNs1nu7UfZ6L
         uGLG9VE4VN5HoX51VUyBq4KuF15RejyjyJcOZEJSusakxYzW0Jvx8bT0WJEWBVywRUyS
         HdkLbDZzPHVxTMk4ZpjrFnFkI98OGM/FUCt/9OsZXXh2SHmtigyAvlyVOPNgwL6T3LuE
         AIb+sxG2f8GjbvX6xqgmWP8XgcAnKJ5mEkPd4fNTWzhSWxXKzEVnn8Tsjz3gR2WTWkkd
         YkMNY9Py7z+NU2RA9tNrlUYx8pu/wHmt8HUl4Pezt0k0RrEb4mxLdbcIfV9B5BN9BRTL
         McyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764694445; x=1765299245;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irZdGfd8l7RF6Kc9iRoeY7vDXGKKY13eJTFmZePo56w=;
        b=Rk5vDEPtTbFmZN6CanjNJcSXdMw0k0IMv3fqq1fRXthEzgsrHLPzy4QBqzOZ1AG35s
         xGqO3vxJ7KN3r6n/8H8txxE9ENkvA/wxG+KgPL8lCqFfSEafFJ7ollm4IoulcV1kE3UH
         x0E107j2G6DTp+IyTFlysr+XrGyR7ZIqA+isjHpZM0Dv//MsCv6RqxeRg36qmGLep/ob
         8NN+3oJKREic3f9SIxvkLUCZh+0IGZSIrc1VxW5ueWnFoSR8sFLbhYTblS33Ar6DY6q+
         NvtHYUWAWUPlcWHq0YzLt/HBrgQnGM6icoBm1hj5ZF9/vMCNkZWdO3IR4g5oNsLAx8tI
         8Y1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQGkaa811UIiP0MXYx1FspLL4TEPEUKpG3U5N563BPHM1Lxnb6tXSQBpi/5dTQDNoGmTZDmpJqLIgRtOcxBv4E@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh0zDRRH8skOrGYhtf8rhnc6Fs1yiB3Gptj/RE6ZxRG68zrtZJ
	OqYC997T1qVvYAh1V62VzWd+z12+cu1fYFFAfRilXgD8T3tbHao1PZAts14UQXoUtWTB0mNeq4c
	lesVQ7Y499g==
X-Google-Smtp-Source: AGHT+IHasCsTFFNuFK8U+eEuZifZCySUnoDldQOFvcoXy3aa3Owv43vySatqlY/9lc3UaPXgdPXzfpuQg73I
X-Received: from dycw15.prod.google.com ([2002:a05:7300:214f:b0:2a9:3665:8636])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:4315:b0:2a9:97bd:a844
 with SMTP id 5a478bee46e88-2ab8fb312d8mr97107eec.21.1764694444413; Tue, 02
 Dec 2025 08:54:04 -0800 (PST)
Date: Tue,  2 Dec 2025 08:53:34 -0800
In-Reply-To: <20251202165340.555375-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202165340.555375-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202165340.555375-4-irogers@google.com>
Subject: [PATCH v1 3/9] perf vendor events intel: Update cascadelakex metric units
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

The updated metrics were published in:
https://github.com/intel/perfmon/pull/348/commits/2dce436130ddfb8b442fc373d103f970de26cb78

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/cascadelakex/uncore-cache.json          |  2 +-
 .../arch/x86/cascadelakex/uncore-memory.json         | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json
index c9596e18ec09..30390d734051 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json
@@ -22,7 +22,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "LLC misses - Uncacheable reads (from cpu) . Derived from unc_cha_tor_inserts.ia_miss",
+        "BriefDescription": "LLC misses - Uncacheable reads (from cpu). Derived from unc_cha_tor_inserts.ia_miss",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.UNCACHEABLE",
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
index 265cdf334f6a..aafa7af46e69 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
@@ -316,32 +316,32 @@
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Intel Optane DC persistent memory bandwidth read (MB/sec). Derived from unc_m_pmm_rpq_inserts",
+        "BriefDescription": "Intel Optane DC persistent memory bandwidth read (MiB/sec). Derived from unc_m_pmm_rpq_inserts",
         "Counter": "0,1,2,3",
         "EventCode": "0xE3",
         "EventName": "UNC_M_PMM_BANDWIDTH.READ",
         "PerPkg": "1",
-        "ScaleUnit": "6.103515625E-5MB/sec",
+        "ScaleUnit": "6.103515625E-5MiB/sec",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Intel Optane DC persistent memory bandwidth total (MB/sec). Derived from unc_m_pmm_rpq_inserts",
+        "BriefDescription": "Intel Optane DC persistent memory bandwidth total (MiB/sec). Derived from unc_m_pmm_rpq_inserts",
         "Counter": "0,1,2,3",
         "EventCode": "0xE3",
         "EventName": "UNC_M_PMM_BANDWIDTH.TOTAL",
         "MetricExpr": "UNC_M_PMM_RPQ_INSERTS + UNC_M_PMM_WPQ_INSERTS",
         "MetricName": "UNC_M_PMM_BANDWIDTH.TOTAL",
         "PerPkg": "1",
-        "ScaleUnit": "6.103515625E-5MB/sec",
+        "ScaleUnit": "6.103515625E-5MiB/sec",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Intel Optane DC persistent memory bandwidth write (MB/sec). Derived from unc_m_pmm_wpq_inserts",
+        "BriefDescription": "Intel Optane DC persistent memory bandwidth write (MiB/sec). Derived from unc_m_pmm_wpq_inserts",
         "Counter": "0,1,2,3",
         "EventCode": "0xE7",
         "EventName": "UNC_M_PMM_BANDWIDTH.WRITE",
         "PerPkg": "1",
-        "ScaleUnit": "6.103515625E-5MB/sec",
+        "ScaleUnit": "6.103515625E-5MiB/sec",
         "Unit": "iMC"
     },
     {
-- 
2.52.0.158.g65b55ccf14-goog

