Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C73E207A15
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739363082; cv=none; b=muOJEovsLNB4zJ01xwmw4LzrV6N7VYjQO1YWXdgmBNyG/rpRe8z7e4is6apoQQHOZxBW349UXhaTqMyBvc3pcoVgmNJlaVxuQGNdvQWHKiEim0AxHgGHU2K0qUNauDRHVCLSeBZV1y5FF+YN3zCDk8kDfEJKbmtic40kXmKlx3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739363082; c=relaxed/simple;
	bh=Jj5P7lsHwRRACyRdpFpJidnBldboUVSsGulb+KW5U8U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lt2+iGKbCDFj0MjcPMIMpfR9weGfVwJOI+vUt16joD4qgvQ5y26QBuhD32YWdFMPYIOn3DC6GEdT3NaslVvj7wOHiA2wCPKejp8LeOi8j/Wa46Gav9esL5i8Zaf611/ZRkrcQ1hBBpb2VIHVgGHi2kd4LrVd0dEzDui7wcVvjys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C+acD+PF; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+acD+PF"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38dd91c313bso2129393f8f.3
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 04:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739363078; x=1739967878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c5dUatvfzva4ZYttIH7CzveR/pu2c86Tt8pcZSDn9PI=;
        b=C+acD+PFVYJ+3arHmrXYE/HTSFPsox4GB97uD6bAmO/iqifBcAXE+1gx52F1epmZnl
         QG86fvQHW4/pCYdJD8yS9yScahhIKEaa3KT8EX4pO1AuFFK39f9Wki6DJOYFmmm9cDJS
         04s7ShnmQZ++PfvBeIImtl4moXFmuyp4JcfDOc/ftJ78GTEHUX3C5T+L6X45XodAA43c
         +hKxPzm+NcsZiW1xpNz5kA1zgsUAYA4c7HKWU2nXkCDDOUfrmooQlL9FfZkdVuOMh5xs
         1HtTT3FHYBDl/QqMfUhpx3ksIyNeYYanL5njFHzC0/BgJV/riJmXErvFUly7eFGGwDZe
         WNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739363078; x=1739967878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5dUatvfzva4ZYttIH7CzveR/pu2c86Tt8pcZSDn9PI=;
        b=aLqUWAKNz4e2sSqwH/kGeh4Md4KVNAw/jvs4bLYqyvChK7nDmAHedC9xfAHRVpW+BZ
         XzNtPovAv2tZ1V7IigfBCZmmgKO8TKlBjnhcimkv5S4N7vzeg05UxHckf7LVK+XcNZ2y
         UCvjnijIYp9uQ1OjDVmxpypPPsGdt5/eFAt48y+toHvEP08XGj1lk6js2WoJ8ObksNW5
         anYUfBHPRBSkj94V3PbJfnlapkP0x3+iGOutthzaqHcBwFVVhoSIydSQ8XveW414oJ+5
         rmfgpvSAc8eDpY6dxEAEjl+HzWrwKiWf24YX6i4bAu6YO3hxpzpdFQsm3QOf1AP2FHNS
         5GIQ==
X-Gm-Message-State: AOJu0Yy7JmCNPlsLiaQ/FgY290Sa2+Ibbrz90xNmHBOSm1ULLJr0u2o3
	lIQFjD4JEvlLW7/Sb8d92fkassJue1f9rof56Np7Guu+JSu+lWKMck6XJpFqQmSzryPTyMulp6i
	NCkw=
X-Gm-Gg: ASbGnct8r8toCBRk7bJlLKIfq3FGHPkS62sQJ74K0I9WJL1ckZDf5W0sQbLwmit2XeY
	ksGh7UDksJCp/JZl1L57om0kyBmvtE1FRFk7gztGFwA/iEIN6Wmrkq1FdPDwLlBJienahooY1gt
	RFALUxpU/rQ2AXH6cAuevkcQ6Od84gp4c8MVJow/ytvVUuy3BrB0+oTzJlf0yp9uKbHMs5w7tlG
	MWXi4l33Yj2YjB460KXOaaNnad74QWvTG109mvBoc6BW6S2xHYZw59Ri81/e6VBZkp6JPww1vDa
	Oiol6y/FKU/LyrQ=
X-Google-Smtp-Source: AGHT+IHURBlQWis9afi1mL83V75xfgS+gg8SDfHCPxDC8+IXutihLiENYqrtgOOvxV5P7aw+tiwlCw==
X-Received: by 2002:a05:6000:144e:b0:38d:dcc4:1dcb with SMTP id ffacd0b85a97d-38dea3c42e9mr2448660f8f.2.1739363078483;
        Wed, 12 Feb 2025 04:24:38 -0800 (PST)
Received: from pop-os.. ([145.224.90.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38ddbfbb4ffsm9287276f8f.94.2025.02.12.04.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 04:24:38 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org
Cc: Robin.Murphy@arm.com,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf stat: Fix non-uniquified hybrid legacy events
Date: Wed, 12 Feb 2025 12:24:12 +0000
Message-Id: <20250212122413.1184503-1-james.clark@linaro.org>
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
should still be uniquified if they were opened on a non-legacy PMU.
Previously we looked at the PMU type to determine legacy vs hybrid
events here so revert this particular check to how it was before the
linked fixes commit.

counter->pmu doesn't need to be null checked twice, in fact it is
required for any kind of uniquification so make that a separate check.

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
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/stat-display.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e65c7e9f15d1..eae34ba95f59 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1688,12 +1688,17 @@ static void evsel__set_needs_uniquify(struct evsel *counter, const struct perf_s
 		return;
 	}
 
-	if  (counter->core.attr.type < PERF_TYPE_MAX && counter->core.attr.type != PERF_TYPE_RAW) {
+	if (!counter->pmu) {
+		/* evsel__uniquify_counter() uses counter->pmu for the name */
+		return;
+	}
+
+	if (counter->pmu->type < PERF_TYPE_MAX && counter->pmu->type != PERF_TYPE_RAW) {
 		/* Legacy event, don't uniquify. */
 		return;
 	}
 
-	if (counter->pmu && counter->pmu->is_core &&
+	if (counter->pmu->is_core &&
 	    counter->alternate_hw_config != PERF_COUNT_HW_MAX) {
 		/* A sysfs or json event replacing a legacy event, don't uniquify. */
 		return;
-- 
2.34.1

