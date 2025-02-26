Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A072222D4
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581758; cv=none; b=jevrKDcXNx9a1x6A7ZFyIRgIegQvPGMHm6IWaDJXvkA7Z04kG3nYosfU5lyZe3uumRMXIpf6bjCIVqkA6RUIHrBNWE9jkzjWHky87tEYTKL0WYJwTGaOtsskD8IM+Nq7+tVdTMWTUNdlg3S7/26kuNoXjJS01An2hZUdZp9W4pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581758; c=relaxed/simple;
	bh=zuIqAKgte0TNhWMQcUFuXFOS6ml4+tb80DkOVV5ygEE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qEzgh8PheRijMN1R8zM3oVDC8ciMlg9ivm8c4EYud/8Ny+NYcKHkU3PDLnnKDh7y57xGz/U5iPYkqRWYQmDVQ1sZU+Zzr36/owsCcTTZKflKonG6+vY15P/7aigpe303Hh7q4p2sci6Tzh46r3JIOsMFa2HNxb1XNHUYXbYiqS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rwVvg8dt; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rwVvg8dt"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f3ee8a119so3474635f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 06:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740581755; x=1741186555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Lh9ErM/3Q+yhun0mC3IR97PyDjsGz9W3qYuqQOhapo=;
        b=rwVvg8dtSyjqf2cBJQZYtLAdMkjb48y/F25Ks32i8ZC6Jrw6pg1JhcNtpfjTxBUIDz
         tqAzwdl5M56k42XPFbA0V7bRuJb2fRYb76MycjSNk8ay3mcj09DBpaEhs+cmpD105/YC
         Bvlby+uU6pkF3nGCcEKY9FZSTInmumVDbk0s2fiIu+n42Lh550vKYTunV5f2NTcKELRi
         rnWj1QApVPpaX8+ySKH3sImPTNAH8XzLv+PGvkx+h0/UyHunC+3Epwr82Qj5iJyJFSkk
         NpnUBqRhwTFVSIBip0F374k9JlyqBvAs7U9WDtr2S4C3t0FqYF/VUx0iu5+arxvoKAZC
         YJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740581755; x=1741186555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Lh9ErM/3Q+yhun0mC3IR97PyDjsGz9W3qYuqQOhapo=;
        b=cabHxJMpjagkyd0eLd+FdP/H9wVljTbmh0+E1A+dKUh2mev4xligDFSfD5qbTcDcZk
         1cxylsSWYo9oZGbhpDAQwu3o/0JaXN9Y2z9xVyWAuBDyCfHY+Zx1ikyVmepFfGAVPZOQ
         Eb9HVLHqkMXbxYkyDZRN0c/z5b0EuOzMXN7hIBtAJwcHSfk38IBNgB/o9L6TmoZk6DEL
         L0dyMLStDe48vQFOMos0PQK9oPodwKKP9EdfaMbUCHCaP78O6ByvPMsQTannp/mVx5m9
         jEE5Mh5xX5FyR52Nqnqh4SuOY2u8TOJeGYssppfi3KhusOsP5bazg2Y1EnsKVP9b1gvJ
         sDlA==
X-Gm-Message-State: AOJu0YyCAOzTco7I4JUQp3E9+DguBdbZsXQWw3ysV/GDx74zAKyakTQQ
	ugb28dyUtnHNlQgpIqKoRAWDxpF5Meip0FW4kr55yxznGQzYFh5DkTvwMnXXy9lnRj6ay2JZHQx
	DXEE=
X-Gm-Gg: ASbGncs8aQ1IzfpDLHW295c0bD8kj/dcnorNW5eLfaxK8cPdQUmAsOOr3e0PSts/w0O
	htzbXtFB1OSHdoqk2YWkeo6az7bzTNTNSENWwQ2HRkKGgB7RYw7lAUOr51CJR+qBNTAIlpHR705
	mSwG8BBmeOltR5Doo1osGnoe/PnZ4yP+mZ/8xjLmT9O5B+unD3kbtLvhBSXkPjpM76THTfmnItS
	ue2YLr6ROKJ5KCDlcQGXq7jpmvdogiMeJz6iFQr+BoPpOd3IZaQYaqjBK0TgmJ3zm6UZ3kCG+2q
	HyRMtn1ezRNkeUtt+6CTWZkFmOc=
X-Google-Smtp-Source: AGHT+IHSR7ol++tcQ3t55KxpPADDKkuJUrc5pqPg7oVpe58mjcbGDwgbdiIc/J1H2cHUewzyAYI/RA==
X-Received: by 2002:a05:6000:1fa3:b0:38d:d603:ff46 with SMTP id ffacd0b85a97d-38f7d1ffbfemr15478346f8f.14.1740581755300;
        Wed, 26 Feb 2025 06:55:55 -0800 (PST)
Received: from pop-os.lan ([145.224.66.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8e71c0sm5803309f8f.78.2025.02.26.06.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:55:54 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf stat: Fix non-uniquified hybrid legacy events
Date: Wed, 26 Feb 2025 14:55:25 +0000
Message-Id: <20250226145526.632380-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Legacy hybrid events have attr.type == PERF_TYPE_HARDWARE, so they look
like plain legacy events if we only look at attr.type. But legacy events
should still be uniquified if they were opened on a non-legacy PMU. Fix
it by checking if the evsel is hybrid and forcing needs_uniquify
before looking at the attr.type.

This restores PMU names on hybrid systems and also changes "perf stat
metrics (shadow stat) test" from a FAIL back to a SKIP (on hybrid). The
test was gated on "cycles" appearing alone which doesn't happen on
here.

Before:
  $ perf stat -- true
  ...
     <not counted>      instructions:u                           (0.00%)
           162,536      instructions:u            # 0.58  insn per cycle
  ...

After:
  $ perf stat -- true
  ...
      <not counted>      cpu_atom/instructions/u                  (0.00%)
            162,541      cpu_core/instructions/u   # 0.62  insn per cycle
  ...

Fixes: 357b965deba9 ("perf stat: Changes to event name uniquification")
Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---

Changes since V1:
 * Move the existing evsel__is_hybrid() test earlier instead of looking
   at the PMU of the evsel. Looking at the PMU creates a dependency that
   the PMU is assigned which may prevent refactors in the future.

 tools/perf/util/stat-display.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e65c7e9f15d1..e852ac0d9847 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1688,6 +1688,12 @@ static void evsel__set_needs_uniquify(struct evsel *counter, const struct perf_s
 		return;
 	}
 
+	if (!config->hybrid_merge && evsel__is_hybrid(counter)) {
+		/* Unique hybrid counters necessary. */
+		counter->needs_uniquify = true;
+		return;
+	}
+
 	if  (counter->core.attr.type < PERF_TYPE_MAX && counter->core.attr.type != PERF_TYPE_RAW) {
 		/* Legacy event, don't uniquify. */
 		return;
@@ -1705,12 +1711,6 @@ static void evsel__set_needs_uniquify(struct evsel *counter, const struct perf_s
 		return;
 	}
 
-	if (!config->hybrid_merge && evsel__is_hybrid(counter)) {
-		/* Unique hybrid counters necessary. */
-		counter->needs_uniquify = true;
-		return;
-	}
-
 	/*
 	 * Do other non-merged events in the evlist have the same name? If so
 	 * uniquify is necessary.
-- 
2.34.1

