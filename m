Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749579;
	b=LLZfRJ1v0mChowqp4sSBm0Lkh1BnJwNe02+BaiRxY6ZAOtJQ3hrsKRTIMrYeeaRcl2mS
	 8CkM6ockulwmUICHFKKWbF/wsdz/9sghRtOac+g90NE/2yR9wZskgy3mUReTuKIT+7BVG
	 lEgKvSLd1crj4FYO7mFJIBu5KK98w11qf6hCsx88MZZ8kUOrlWq6RMhBlzzooZI1KUF+8
	 YQKD6CLVUGQClSflL+Yu5XK0s9rdQlYHCbRbNZ8V3hEke0QYOrBUf0aAy1aivM3VDGPhz
	 iEvzdPKQMqGMNLvDYGS5jggL0LQ7LrYI2QxDXGzG3Lz/5hO5fSploTuvjNVIkoe8PlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749579;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=90Ulmni/ZtUVR/D26nwZSwYtw/VrVoB150k+Z34XCvc=;
	b=vnIwRFiQLssKtULCg0IXiLvaunPTnt54E3NtyworyFiR5zRBG1qBhwqox5IuHzYpffos
	 EdoD0p0y1bir9hqzJny5u+kcs6XnMcgm07PagcuDWITNNcLRbGis6BGVXmrhDZVC4oOGA
	 uWRluu7koMacNNSLBw+5H6NvpzsLaBdTwij5XGDQ5G4uEKuzaztvD4Q1D+rhN7r3L9bsU
	 l0MKFnbtIPmGfL10gjyuwpi4NDZYIzgQrQRapSHr9Hew5jOMg+jP5rVVLBepf4kltr3sV
	 kgd9j2tTTlPJ57Pj/FcOhuoAlIIZlDDl6DKhnNEenO+wH9WBzMmfSG9PbubDHbZ43ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fQDYyqUT;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1686083603
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 23:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD1686083603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fQDYyqUT
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1383723dfddso300885c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 15:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793749578; x=1794354378; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=90Ulmni/ZtUVR/D26nwZSwYtw/VrVoB150k+Z34XCvc=;
        b=fQDYyqUT6kvU0totc9BlyS+qdjENNBGjR1VpQl6hFeaq2sDXGtVbsqBoF0s5KoFeku
         rhLeopPlpBaYweKsDTZtxuAFA4fUb0dkWEpwnwdZkihSkbzFPxSv3qLB8l4mkDco7fDB
         o31MvBNrJLDtdpm7pKdnFFaDLxMZH7hwjHIhKnabnyeVEqARkdXndfgZVrmvVpksRpOS
         Ft1w1koCxxWkBLbsv5CIE0vjqq1vkpfskx33WpOQCmhSNeiEvmZDAwCnG4A7pS8jsBRU
         SjZDJvACiZVDq8fgBRP3+CFcn2ryktHXg1klbqlqG2AqOFyCLuCrNrwmWk3chRNcFykn
         ew+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749578; x=1794354378;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=90Ulmni/ZtUVR/D26nwZSwYtw/VrVoB150k+Z34XCvc=;
        b=ioqkEpRvMfQGppSm7Fsqjhklh/GAf8TZ6MUpyAmQe+D59HIxzX4RbZ6tFOr7J3cizD
         bbypf0Q0xVrsG2lXxpnpLlIj1bIZmz0bGj1G+MEIQHS0Fuo+q7lQFu5gl84kU0dDf1OW
         VWk7wrPSxcGq6uh5yu23N6d0zR7zj1xtDS4jWLyBd2WSaGZaUGFi6S3ba1w2UE9dXV1R
         TPHVKfHlx500WTmabJx1NkyqM1O+V4D1pAGVDYmMu+AlYjkbNB4PYZ8cj6bzG0RnHIEE
         m1M2qCgHBTWjqY1KlNj5SIhi28kWpDcEDBOeNQBJNi2o2o25pxREUmCvT/WzYTm3DXCD
         c47Q==
X-Gm-Message-State: APuU4Z/U9QeG7BR9mQtN4myxes1mtzMN3zdadsSPhC8hh9LpAXpEELWl
	CZmrmuP0XRCU3B2GmeaY/MIiU2wQh7UteRp2Qk7vpWsV0bLNLGaX+yvMIpJhd3HEY1nzPBjgg1W
	Gdu32ASyM0U+F6bJBtQE+gP1mUvGlM1nSaRpavU0+sqGzc+EnpNLjbnsKKhwBcvj4HocFZLE1mC
	H1s88r+r5JFWDMthDZlQS6MzuLdLOi4dgqwIQhJaNzKhQgCa697NVjdig=
X-Received: from dlbvv4.prod.google.com ([2002:a05:7022:5f04:b0:19d:594d:1e8b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:29b:b0:151:94a6:6f5f
 with SMTP id a92af1059eb24-1ac5c3699aamr20517954c88.10.1793749577431; Tue, 03
 Nov 2026 15:46:17 -0800 (PST)
Date: Tue,  3 Nov 2026 15:44:42 -0800
In-Reply-To: <20261103234502.1008382-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103234502.1008382-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103234502.1008382-27-irogers@google.com>
Subject: [PATCH v1 26/41] perf pmus: Expose duplicate uncore PMU scanning helpers
From: Ian Rogers <irogers@google.com>
To: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, John Garry <john.garry@linux.dev>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@arm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Export perf_pmus__scan_skip_duplicates() and add
perf_pmu__num_duplicates() to count numbered PMU instances sharing a
common prefix (such as uncore_imc_0..uncore_imc_7) so subcommands like
'perf sysinfo' can collapse duplicate uncore PMUs by default and report
their instance count.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 25 ++++++++++++++++++++++++-
 tools/perf/util/pmus.h | 19 +++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 908959abbd3d..aa088c9c9aec 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -484,7 +484,7 @@ struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmus *pmus,
 	return NULL;
 }
 
-static struct perf_pmu *
+struct perf_pmu *
 perf_pmus__scan_skip_duplicates(struct perf_pmus *pmus, struct perf_pmu *pmu)
 {
 	bool use_core_pmus = !pmu || pmu->is_core;
@@ -522,6 +522,29 @@ perf_pmus__scan_skip_duplicates(struct perf_pmus *pmus, struct perf_pmu *pmu)
 	return NULL;
 }
 
+size_t perf_pmu__num_duplicates(const struct perf_pmu *pmu)
+{
+	const struct list_head *head;
+	const struct perf_pmu *pos = pmu;
+	size_t base_len;
+	size_t count = 1;
+
+	if (!pmu || !pmu->pmus)
+		return 1;
+
+	head = pmu->is_core ? &pmu->pmus->core_pmus : &pmu->pmus->other_pmus;
+	base_len = pmu_name_len_no_suffix(pmu->name ?: "");
+	list_for_each_entry_continue(pos, head, list) {
+		size_t pos_len = pmu_name_len_no_suffix(pos->name ?: "");
+
+		if (pos_len != base_len ||
+		    strncmp(pmu->name ?: "", pos->name ?: "", base_len))
+			break;
+		count++;
+	}
+	return count;
+}
+
 struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmus *pmus,
 					       struct perf_pmu *pmu, const char *compat)
 {
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 2b784cf648f3..9790be2d60a5 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -134,6 +134,24 @@ struct perf_pmu *perf_pmus__scan(struct perf_pmus *pmus, struct perf_pmu *pmu);
  */
 struct perf_pmu *perf_pmus__scan_core(struct perf_pmus *pmus, struct perf_pmu *pmu);
 
+/**
+ * perf_pmus__scan_skip_duplicates() - Iterate over PMUs in @pmus, skipping
+ *                                     numbered duplicate instances.
+ * @pmus: The PMU collection to scan.
+ * @pmu: Previous PMU returned, or NULL to start from the first PMU.
+ *
+ * Return: Next distinct prefix struct perf_pmu, or NULL when done.
+ */
+struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmus *pmus, struct perf_pmu *pmu);
+
+/**
+ * perf_pmu__num_duplicates() - Count consecutive PMUs sharing @pmu's prefix.
+ * @pmu: Representative PMU returned by perf_pmus__scan_skip_duplicates().
+ *
+ * Return: Number of PMU instances (including @pmu) sharing its base name.
+ */
+size_t perf_pmu__num_duplicates(const struct perf_pmu *pmu);
+
 /**
  * perf_pmus__scan_for_event() - Iterate over PMUs in @pmus that have @event.
  * @pmus: The PMU collection to scan.
@@ -260,6 +278,7 @@ struct perf_pmu *perf_pmus__add_test_hwmon_pmu(struct perf_pmus *pmus,
  * Return: Pointer to the fake struct perf_pmu.
  */
 struct perf_pmu *perf_pmus__fake_pmu(void);
+
 /**
  * perf_pmus__find_core_pmu() - Return the first core PMU in @pmus.
  * @pmus: The PMU collection to search.
-- 
2.56.0.385.gac671c819a-goog

