Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5855240961E
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 16:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590996; cv=none; b=sbTwvpQSfjhavOtpnADhZtB1zBmC/YjR9B5IrceDSD+BMoYugQCbCORcuhE4Ca4mWwho2dO0/jG8yeYNR/ywaOo4o08GT0ameV6/LGWFneiBl/uSugO4kAY3OCFgi0IqwowYB2S0YRZdrYdVQRJ4zRI//sutaPTTjhsCzvbFL1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590996; c=relaxed/simple;
	bh=S//dvOBs/USieF1vXWpNPbPuhuIfEQr4R8jo7tO7zf4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U7SikoumeI9IAa/GR054N+puoMGKexPbEYIFC9Yr3Bp7hQM2fWcEV3GT1Dm6D0re6LwTNSw61P3gqAQce8yNur0XF7Hw33Dc1kAF6cBeRA6nFDNp0X0jB6XVTMJujoJGodcrLLD/dw+Gll+98ieIA7mTq0x2Y9DZjy6IsijIYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a6gPaQVH; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a6gPaQVH"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137f304f564so116397c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 09:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780590994; x=1781195794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XCZcSKYNKaSrihd7vUWodA5r8ht64vt3LOLPQyq/or8=;
        b=a6gPaQVHjCeyo9/RLk3DGy+MujCzdCUkpQGtfpEJ7tMZN6zYl7t9Rkk9tADgW5ZNmn
         BL/AsKhp1gh67wk45DGbWxfv8ld3sVsgBAT+h5a6QNJie4vB9eVR/viq4wMf4ykfQo2n
         j+7m4PMhOzkH8t/SFTOSIqf4shidtl+OyzFM7K41djiHwPlrdBMAqUMeQj/jEunUY/Je
         bH3iZQC+eK2Cy3yJU+8H3kKnANm2L7PDY6wtwEED6K5kIkkptOh14P0IIPYx+Ecd2cIx
         uN7lAnW7r4HFKQ8slByFqxQpLFgjEmqCcYMB6nDLs7sTjwAY0WiV/UzmCYoaXYy6k4JH
         HgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780590994; x=1781195794;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCZcSKYNKaSrihd7vUWodA5r8ht64vt3LOLPQyq/or8=;
        b=d2cNnwx4qENjydAItQL/NlAUsINb9mPombOmEbm8PTCHxD5Nt14PTO9aiAx+PTtgQn
         XEYyNLQyBXY62peWyue0ioK82roFL6etyigvwfSFKexyqNVReOt8SMLuPQTp2iQLwMhK
         dAoonrpJNHZbCvg/H0GrSZU2y767drZ+OYW813nKjA/4bsZNhbTEqpovO52b2AuF8y9i
         F+/RvxFyqFGuLYQP4ELO3OBAnzG7hajd/W1aOETXKBkv9lfJgSrfh9e4RNd3fREBMr5t
         P1i4duHCfWvKocDhyw1U1lqd/yKOnSXGqF76/nC5YxP6/Ei1wSSwxaP10Xp9ylBneotq
         g61w==
X-Forwarded-Encrypted: i=1; AFNElJ/QyTzzWkrSzkHgoVbkAU/MCzie76xT+f8jhOI8Y4uFMl1T3NXR5druHjTsHbe4vmDEXeuNkQuLBWTSjUTDVptV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3L2iazhp0vNSxV+8zvL3gKxiuASXhC9PZkDpULBdTC9GOZOEy
	XXqRoFw5ijflSerPYcFiMsRghVihV4NjSxMpXvc2sjZ3lHxlTOJo9PQGCq/XzU/Km7TFr2NISCo
	YTLAymwYFYQ==
X-Received: from dlbep4.prod.google.com ([2002:a05:7022:1084:b0:132:d312:88dc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701a:c951:b0:137:fb3f:8b65
 with SMTP id a92af1059eb24-137fb3f8e2dmr3326779c88.10.1780590994051; Thu, 04
 Jun 2026 09:36:34 -0700 (PDT)
Date: Thu,  4 Jun 2026 09:36:26 -0700
In-Reply-To: <20260604163627.501078-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602174129.3192312-1-irogers@google.com> <20260604163627.501078-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604163627.501078-2-irogers@google.com>
Subject: [PATCH v9 1/2] perf pmu: Recognize 'default_core' as a core PMU and
 document matching
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

The is_pmu_core function checks if a PMU name corresponds to a core
CPU PMU. However, it currently fails to recognize "default_core" as
a core PMU.

When "default_core" is used, the PMU scanning fallback in pmus.c
scans the "other_pmus" list. This scan is slow and always misses because
"default_core" is a core PMU, leading to unnecessary overhead.

Update is_pmu_core to recognize "default_core" directly. Additionally,
document the different matching approaches (exact name for x86/s390,
sysfs-based cpus file check for ARM/hybrid) to clarify how core PMUs are
classified.

Also, explicitly treat "default_core" as `all_pmus` in `setup_metric_events()`
to preserve the original metric resolution behavior for this pseudo-PMU.

Assisted-by: Gemini-CLI:Google Gemini 3.1 Pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c |  3 ++-
 tools/perf/util/pmu.c         | 19 ++++++++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 5a489e97c413..c2ce3e53aaee 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -295,7 +295,8 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 	const char *metric_id;
 	struct evsel *ev;
 	size_t ids_size, matched_events, i;
-	bool all_pmus = !strcmp(pmu, "all") || perf_pmus__num_core_pmus() == 1 || !is_pmu_core(pmu);
+	bool all_pmus = !strcmp(pmu, "all") || !strcmp(pmu, "default_core") ||
+			perf_pmus__num_core_pmus() == 1 || !is_pmu_core(pmu);
 
 	*out_metric_events = NULL;
 	ids_size = hashmap__size(ids);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 23337d2fa281..9994709ef12b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2029,9 +2029,26 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 	return 0;
 }
 
+/**
+ * is_pmu_core() - Check if the given PMU name corresponds to a core CPU PMU.
+ * @name: The PMU name to check.
+ *
+ * Core PMUs can be identified by:
+ * 1. Exact name match:
+ *    - "cpu": Typically used on x86 architectures.
+ *    - "cpum_cf": Typically used on s390 architectures (CPU Measurement Counter Facility).
+ *    - "default_core": A generic name used to refer to the default core PMU.
+ * 2. Sysfs file existence check (is_sysfs_pmu_core):
+ *    - Typically used on ARM systems or Intel hybrid architectures (e.g., "cpu_atom",
+ *      "cpu_core"). This approach checks if the sysfs directory for the PMU
+ *      contains a "cpus" file.
+ */
 bool is_pmu_core(const char *name)
 {
-	return !strcmp(name, "cpu") || !strcmp(name, "cpum_cf") || is_sysfs_pmu_core(name);
+	return !strcmp(name, "cpu") ||
+	       !strcmp(name, "cpum_cf") ||
+	       !strcmp(name, "default_core") ||
+	       is_sysfs_pmu_core(name);
 }
 
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
-- 
2.54.0.1032.g2f8565e1d1-goog

