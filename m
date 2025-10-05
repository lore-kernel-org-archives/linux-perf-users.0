Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5058B29DB99
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Oct 2025 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688720; cv=none; b=DgD+fHhpIRGGv7xF0O8lwn4a90ZHtpSkogx2JJHyH/t6metugGbLCIrv/eBsjp2R39CtDeAtFF2x4PXxlL5ALkEs3kz7rpkIjai9H+C1Kd6aXqcmbKhvH2f3FFoU9pgNAbn+E/aPu3lOeyPFFQa5sZdiyYw1pOD/4kaCFmSvsZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688720; c=relaxed/simple;
	bh=SEzAsSMoNsTTgZvnVHYt1VizCcHn2xa9s9a+H5Ek3tE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NSKwHdjEnIxxxsphiJnJ4T5q5SqwE3XC/ngsU65Y727VSLV0kI/WHgCF1x5SB3c3qf2ilk5xT4hFHXQGoX4OePjXFteXzsWjQ/XJhSajPzgUmoCWzAXP8D+hpf6pcDIx+8hFfFHoJd5+RjkoD90ascLx/BnIwQtcuIOTQqo6ZIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQf5RxTW; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQf5RxTW"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-277f0ea6ee6so52410495ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Oct 2025 11:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688718; x=1760293518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A1sEyHn6hnyRLAXWdXc6uX+CUu0Ko58Z/kC+AsHj6Ww=;
        b=pQf5RxTWSojrJdT2kGzpQtOTkTOm2NUQBRNY76xIJYNtt1Lu+5MI9fGsHdsv2apLfS
         qwgPMLAzC8CbJSaW1KMw5hQkIUWcRxQ07dxBb6kPMPQZ2lEL9VtvWjlXTMJdqVbK9D4U
         rlpho86FlY2JlzL0t7Y0pEOjC96uyMBwNG+4UIsdWEtsQKiNYk20z3KZhRRTQy4i0Bxj
         85JtblP9vU8DB3yPSDOmzoHM6uI8cFJQpy1y8Bh80i25lteIbC5n3DRoSC/RsF9JJVBc
         0X/K51aT/hKZSaO1m57m4+eRkX2gmLpPZtscDlHRSd0sWsmWw3ukylnx1emmA8GiyZJj
         UxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688718; x=1760293518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1sEyHn6hnyRLAXWdXc6uX+CUu0Ko58Z/kC+AsHj6Ww=;
        b=iWP9fh6/k7+ocxUMzyJlBREflV8nw7Y5oPvmSQFF9xRvLA9+JfdHuKW6XKhy0gJ42t
         Oo7hPZMpOWLy9ljH/ly7kP38Kl1Tp26k/jZoY/J/yjN2LnqW5OE41Zb9s9niSF1Prc6a
         oBcLaoMu435kxw49CZJiXmDw0obAKPL7Zn1QjhbiO1VJC9Wgn+Fz0GcFGteN7lEOsYY8
         eCyZ14Oxby//ZylqXX7guDZNabXt7y0HCFRQmW4e1FPHq60l/s8T7sbeJ5eNgv6gJeOD
         l0qGw2IW9yW6+dMsM63UK3blZpUYr1KVuEgCitbVtkH96akreIQcSeJ94gehrHzO/vi6
         33mg==
X-Forwarded-Encrypted: i=1; AJvYcCUzWE5xc+5m6TH/UUvEvJJF1vCFEm3ziGENhs1KBterYXCXcsvhMt3YnMVPy3z7qMEXgv5fFdrrrXska4RiZU44@vger.kernel.org
X-Gm-Message-State: AOJu0YzGOaKcXGrK5+ywPyCI+vCRnMAUvgeo0TAZuTwQumWmFosSrQEq
	kxcv2m67HH5k9Wg3gyXjkX7Walf3YVGd++o6AtSLR80c/npu2HqupTv8W6bjtAsqTHYEoi+vy2W
	JS1j3/a7E4A==
X-Google-Smtp-Source: AGHT+IEJqSApSHd1BhmFoZKe2640Ivz+C2UbgeEfegtwFFBeBPC1PG9Tw96g0Q/q521daG/+L6gEoibM/mJ3
X-Received: from pjbnl7.prod.google.com ([2002:a17:90b:3847:b0:332:8246:26ae])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ac4:b0:32b:dfdb:b27f
 with SMTP id 98e67ed59e1d1-339c2797420mr12552222a91.17.1759688717803; Sun, 05
 Oct 2025 11:25:17 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:23 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-21-irogers@google.com>
Subject: [PATCH v7 20/27] perf evsel: Improvements to __evsel__match
From: Ian Rogers <irogers@google.com>
To: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Ensure both the perf_event_attr and alternate_hw_config are checked in
the match. Don't mask the config if the perf_event_attr isn't a
HARDWARE or HW_CACHE event. Add common early exit cases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 56ebefd075f2..ad11cbfcbff1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1940,16 +1940,19 @@ bool __evsel__match(const struct evsel *evsel, u32 type, u64 config)
 	u32 e_type = evsel->core.attr.type;
 	u64 e_config = evsel->core.attr.config;
 
-	if (e_type != type) {
-		return type == PERF_TYPE_HARDWARE && evsel->pmu && evsel->pmu->is_core &&
-			evsel->alternate_hw_config == config;
-	}
-
-	if ((type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE) &&
-	    perf_pmus__supports_extended_type())
+	if (e_type == type && e_config == config)
+		return true;
+	if (type != PERF_TYPE_HARDWARE && type != PERF_TYPE_HW_CACHE)
+		return false;
+	if ((e_type == PERF_TYPE_HARDWARE || e_type == PERF_TYPE_HW_CACHE) &&
+		perf_pmus__supports_extended_type())
 		e_config &= PERF_HW_EVENT_MASK;
-
-	return e_config == config;
+	if (e_type == type && e_config == config)
+		return true;
+	if (type == PERF_TYPE_HARDWARE && evsel->pmu && evsel->pmu->is_core &&
+	    evsel->alternate_hw_config == config)
+		return true;
+	return false;
 }
 
 int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
-- 
2.51.0.618.g983fd99d29-goog

