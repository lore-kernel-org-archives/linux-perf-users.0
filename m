Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82582FB085
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 22:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763157957; cv=none; b=dFvWdKNB3K8o7RV3FDfRqRIKnCZcfMpW+HNufvvx4Ecf7W2uFJPFEAAFFIwmWydbO2lPi6U7brEtv6Njg3HEETKMXXH/dufnQhDs8uWfmyc5AOWXBAmnrjSVSGUfoNd+laQad+lGb1dXPYv2u/RuWCuC9K1VzCUZGYsK5HwZ8rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763157957; c=relaxed/simple;
	bh=aDrH4oKYNfeCr3V5//ViM24gXgm2++MpreNMqrPPg/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=n5UwjdMl4jqPP2jcg7AvdCJ6Y1CbCR95dRVsR7phe5LB+Ckw9p2FxygfCv68h1q0SanpB7ns/TdxbsFosTPclGaIxM9nMef/i4KVdDmZ0PljrCmXZuv14evBcI2ttI4hQfvjsh4eDpP2gyQbIFuN0XwD9JS/ITvi17tUDDSPQwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RD9Tn+79; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RD9Tn+79"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b6097ca315bso5335723a12.3
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 14:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763157955; x=1763762755; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G/Dp04NwXFVyyPKioCb0fwCSgFJYwh8+bdCYjRLw9UM=;
        b=RD9Tn+79RaD5FIQ7bJ3HWcWcn8+ONVimbIqMI9vEaHS5DvDd69rxUcDcDJjgI8Vkys
         sAtczm2Eb8P4CJuOj0r7y/hHkBuvib+FpuIiAgnr5gD2DQ0P5Y4AFP5aD/g/66A4NMSl
         vpsfJ/0X8mz9TkjcV9/GdLNGIVwgGGC+q1F2pKCIme8DmJPFDzhb1wZOpj0lMb/NkvtZ
         3dQvBT0a1+HdwlIzAxAtPftk1lgGyd7M5sZCZs3jcs7aeYLCTGgq5wzU8UZ0XY/ExlJF
         dQWcxuoeHlqyY+Zlz1He/ZMtt2Y+p3Tsdxs+U/Mt1YGz3WcuSNj9WFVAZjUCsxdkmgVb
         jaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763157955; x=1763762755;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/Dp04NwXFVyyPKioCb0fwCSgFJYwh8+bdCYjRLw9UM=;
        b=msWnHzMmHiJ8cxv+B4P1wAN2+An5Fz9oRL3fwedzQl++5EtKsooJvm0t70OB8b3YwI
         EDqHA4LqzCfp4w6JrrPTa/k/e6BwjgE+lWroThK/07Ev6xk4DwvwhRyYjV9O++DEDbnt
         LGlGbFVDQ6hKuabIkE4ldddoF5JoDQ70N5TYiOeuQeUCAvDmZdLl0SjSxztnV+lHcQih
         d2skQWCzQPo7T0VRBANsIFR3V0X4L5MeYyy/eBr8lcZYj+mDzS9Wm5fVPcXTPDEGoDYO
         EqcGPcUNYui9KhsoBd5UyqpI+HFxim181dsn5p2AZHutQ3SJ868ErXLxkKvg242D0ZxZ
         Xs+g==
X-Forwarded-Encrypted: i=1; AJvYcCUrpgbPnpU+C6k2IdEoa59OcZbAHaC/AU0dkBMX8ZEOWHUX6J2K7p+/7rDV0v6tWz9i4BkXe5bcRfUANT9VMkZf@vger.kernel.org
X-Gm-Message-State: AOJu0YxwpNsGZdkamsySx5NU1hsmXS6O/Wed1dYAz5RU6TBIW1RPNyan
	js/V7PJwxY+YPrvKhI8EBP6Ybtg352/6UpD69DzhW22x4yKck14UgutODhipmQBbNlNsH3msHHl
	7DQHRNwJFNg==
X-Google-Smtp-Source: AGHT+IFDmc09VumVn7uZc3UD5w3Ul48gz3HwaJIKE/tv+hVWjmQe61VSaPqgHpT/6jqL6WRX2YaNC3TCPXsQ
X-Received: from dldnz8.prod.google.com ([2002:a05:701a:ca08:b0:11a:3b81:6bc6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1e05:b0:119:e56c:18a7
 with SMTP id a92af1059eb24-11b40fd760dmr1761472c88.15.1763157954866; Fri, 14
 Nov 2025 14:05:54 -0800 (PST)
Date: Fri, 14 Nov 2025 14:05:46 -0800
In-Reply-To: <20251114220547.496562-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251114220547.496562-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251114220547.496562-2-irogers@google.com>
Subject: [PATCH v1 2/3] perf pmu: Add PMU kind to simplify differentiating
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	James Clark <james.clark@linaro.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rather than perf_pmu__is_xxx calls, and a notion of kind so that a
single call can be used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 1ebcf0242af8..cfcaba3e2e75 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -37,6 +37,19 @@ struct perf_pmu_caps {
 	struct list_head list;
 };
 
+enum pmu_kind {
+	/* A perf event syscall PMU. */
+	PERF_PMU_KIND_PE,
+	/* A perf tool provided DRM PMU. */
+	PERF_PMU_KIND_DRM,
+	/* A perf tool provided HWMON PMU. */
+	PERF_PMU_KIND_HWMON,
+	/* Perf tool provided PMU for tool events like time. */
+	PERF_PMU_KIND_TOOL,
+	/* A testing PMU kind. */
+	PERF_PMU_KIND_FAKE
+};
+
 enum {
 	PERF_PMU_TYPE_PE_START    = 0,
 	PERF_PMU_TYPE_PE_END      = 0xFFFDFFFF,
@@ -306,4 +319,25 @@ void perf_pmu__delete(struct perf_pmu *pmu);
 const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config);
 bool perf_pmu__is_fake(const struct perf_pmu *pmu);
 
+static inline enum pmu_kind perf_pmu__kind(const struct perf_pmu *pmu)
+{
+	__u32 type;
+
+	if (!pmu)
+		return PERF_PMU_KIND_PE;
+
+	type = pmu->type;
+	if (type <= PERF_PMU_TYPE_PE_END)
+		return PERF_PMU_KIND_PE;
+	if (type <= PERF_PMU_TYPE_DRM_END)
+		return PERF_PMU_KIND_DRM;
+	if (type <= PERF_PMU_TYPE_DRM_END)
+		return PERF_PMU_KIND_DRM;
+	if (type <= PERF_PMU_TYPE_HWMON_END)
+		return PERF_PMU_KIND_HWMON;
+	if (type == PERF_PMU_TYPE_TOOL)
+		return PERF_PMU_KIND_TOOL;
+	return PERF_PMU_KIND_FAKE;
+}
+
 #endif /* __PMU_H */
-- 
2.52.0.rc1.455.g30608eb744-goog

