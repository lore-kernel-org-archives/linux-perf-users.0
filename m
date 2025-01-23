Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AD820B7F0
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 07:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737618427; cv=none; b=EHeIgcOC6HEK8KBslFxpagd3u/5QRUj+OVl/YNCBAjqvtILWk3rAUdWZo/TWsK0uasCWwCKOgNDz1s4cGpOvffErFgSowKU53JjrctGU01mhz/FOlKvMZzP6Yq/mYT1rp9Y16cWmkbqCLJbjSj0GoyIP4iddJh7+Q9m9ydgNeYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737618427; c=relaxed/simple;
	bh=AuTsH0YHOa++0a0gEpAflS+m3ZAbu91QpN5DGy2CKOY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=F2SNn9Wf5MI8Pp/Q3Pnsz5OnE0546ooNuJQmoRc2OY3OUbKz1qkZTI93MtQsy9e8wawb6Ka7LsMnrPh9596TjJmnJh/hDaxCt13JGCy9lpyGZ/dMEwg1HOmShDq+Xw3FI0PUMHuDRMc9yr5XbgqLUzVHKZS/I0MdtLZ3e6o7kAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d0n6VckD; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d0n6VckD"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e5789a8458eso1702437276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 23:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737618425; x=1738223225; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/EdS3qTY+09X5JRTcKpgEWVJ9FaQ49oSPLBxs6KryA=;
        b=d0n6VckDOmVUjBwJ9wbfU4ZId0T4/SkFqtcB70evFI5v6qf6k2t++kzLhr3b0u9iOT
         RDoQBwrQSRJ9rDt0HliXagRNmeJBmilu7dfFJ/y9/EISW2Uo31rn2cZElMFJ1k17J172
         S/o32wvUmQBUZ/zDtfpkARe1L806MmQP22YcsiPy8fy7HZd6AovgFmncGMFis5YxPUvj
         gCgk9GkDde3t+p+QAq3OSYXQ3wmqAOkPI3/+sp2V7QiVctvD1eHG4JP5N6g9QVYGmlJG
         iFIGeuxtMtkKY3qFWiq6nOjYUuYLJ+AAB204iDMaMmzkeNsvJ4Kzx1ksDCkQY3mzjQmc
         owIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737618425; x=1738223225;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/EdS3qTY+09X5JRTcKpgEWVJ9FaQ49oSPLBxs6KryA=;
        b=DjFuEDNyuLsJZFr2i+s/6HyzlnIicJPTzwxD12wudrqUmqUUVGAEOmAzcwEiAXerc5
         JTMVytLoNBuBYfHUWIMZpB/2mYTZEZjcct+Kkzjp9i7LVKAsq4HGXj8zvIFZKWmFeXta
         bUUCiD780Jp8pLeIuj9XIaIUpoOOsjYtYldIbmpOB+6uRmuBgJu3dxIAOyoR3YHRReqk
         hYepCJsEXaTJV28KN5tOulCDOzneVlpJuvYqVQhaqMS9PUalE2RRRR0xYMZH6lvQxHqb
         T+yczP6UpXiey17LH57nVEWN/LcH9UGs4WFPcwGzhqALy0A1mTmDFvKiUMxA/WKTBrz4
         4U9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgBwb5gdiIzyPBDGBGmdHioEm4/yPXasjANsT9Af/Kx12gXWmpqsRmHDC1vEW2kKNhPixazEl2pS5duXNx2dfU@vger.kernel.org
X-Gm-Message-State: AOJu0YwIsvY0LZmDGlCP8D+ik3xtQMQAG4PH4WYBDmCzeJTIYi+cM/QD
	Mmar/YqQPXwra+j95g7qPNH4gUE1lz7xhX2Gx5OdxLDjrrX520q14swGb79PhExcHS30VCi1WSn
	WM/umJg==
X-Google-Smtp-Source: AGHT+IHMAQdwdbEHDozJ5QOQVR6FPmtsPooPKLG29MtxeD9qLiFGcCi8tX3yvDrPEqCugmxty5Z+mz7wStTg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:2fda:d811:ae83:77e0])
 (user=irogers job=sendgmr) by 2002:a81:a884:0:b0:6ee:b693:f752 with SMTP id
 00721157ae682-6f6eb519f22mr487327b3.0.1737618424725; Wed, 22 Jan 2025
 23:47:04 -0800 (PST)
Date: Wed, 22 Jan 2025 23:46:55 -0800
In-Reply-To: <20250123074659.698123-1-irogers@google.com>
Message-Id: <20250123074659.698123-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250123074659.698123-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v2 1/5] perf evsel: Reduce scanning core PMUs in is_hybrid
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

evsel__is_hybrid returns true if there are multiple core PMUs and the
evsel is for a core PMU. Determining the number of core PMUs can
require loading/scanning PMUs. There's no point doing the scanning if
evsel for the is_hybrid test isn't core so reorder the tests to reduce
PMU scanning.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index bc144388f892..ae20691bbfae 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3856,10 +3856,10 @@ void evsel__zero_per_pkg(struct evsel *evsel)
  */
 bool evsel__is_hybrid(const struct evsel *evsel)
 {
-	if (perf_pmus__num_core_pmus() == 1)
+	if (!evsel->core.is_pmu_core)
 		return false;
 
-	return evsel->core.is_pmu_core;
+	return perf_pmus__num_core_pmus() > 1;
 }
 
 struct evsel *evsel__leader(const struct evsel *evsel)
-- 
2.48.1.262.g85cc9f2d1e-goog

