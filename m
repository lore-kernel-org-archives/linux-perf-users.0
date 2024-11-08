Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2D520DD4C;
	Fri,  8 Nov 2024 20:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098515; cv=none; b=J4JLZtlBU6EVrP1GriD9zpO0gw8doIiE6yT/9dvbUkzuLulLAeFiM25e3ynJisS4w9xTx00In0f7Xp45W6tEHn5Pz+0ell+jlttlPYboqgtYTdYuCI77jP4BpMlAyL+rCxASjsYoON1uYeSDxDqiPnwtDR3+5e5tWxKE1YD/GJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098515; c=relaxed/simple;
	bh=8n32HRLtvs6iq3hs0+jZ5tY+Ru8eByqiCSKs7/zhsw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQNEH1bt2bdb2osl90c42uZakYdwahMqco+5mELTvzRo4wwgVR77S3WyJwO8k/7kNkzNtU4+tUizbZWo2xsyLPwIl85FxKZu01Sym8ieVBB0NO5VcANq856qntVWm6ATTao/qqF3+lgYguPfx9PQmY+i4ReAku+CSSqUgKGyOpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFQJEPln; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFQJEPln"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-72061bfec2dso2291534b3a.2;
        Fri, 08 Nov 2024 12:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731098513; x=1731703313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A76AXI5cz8vRJB121bfaR49vMSkcsOiddGBoLtpbHfA=;
        b=hFQJEPlnWgwiQLgyo/LHKpT2I986z9RdMFzR0NFn2o5fgOd6dU7nTSHfMq+Mpb6b8b
         852qfCWH54dWfP4j3mN7lcnuRzbCLJZpafGlFU35xSLVkXU01Ne4HSWJH+/hsOcJvPLU
         DTDX4YJK75Dtj9SaABrNgx1yXU6b2zXLhwHXU7otrbnlf8PeVJqkw7NGy7Bhkhgvcp6e
         UUF/beV7d2Md+S80/SdDyAb4eY8IPVwcDldngnW21vS2lLYAdb6F41l+DekHZfhc51eP
         Iv3Yj86NkVUrIREtZr+/Qd/lzek3tvoPHAKfzAWMZFRuJy2InJ9Ce/h8xBXAssFmmYB4
         YZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731098513; x=1731703313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A76AXI5cz8vRJB121bfaR49vMSkcsOiddGBoLtpbHfA=;
        b=r+wYqAsWPPqiDTBniKrDRNqCGnOhmD6lm72f9NIIkmivaM/no5SV81kzVgIxqwB9Qk
         n5nSOYGPiRLoxcIyS4TcmKw01R2cTZ/ZRg1fhJMc4mADADycSSaQq6YrKYrdZxEm/3v7
         zUCAFItAEA3aFhY21niB/zrbRnSiwEyHEgIw6LFSUTQgpEcnaN77uKqUeC7KTy8TI/tU
         /IYQFM4a3NMo8+4xyCyyYsWXllcur3BzysaNOe9xFmMSZIpJ261H8YoqVfZs8x/y0OPO
         HRx4rt2ipqxwPApm6BFX2JKFocg73SBtearesnZD4s+vlDUOeKqfMaV8Lf7Y4cdGiKuO
         CVTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0SB+rHcFD4kpJuoKRxcg95tFbi+hr0fiGdVhC9T+UTrtZsZsxVUV8ZL9+7TSAje5ist6aOA5xWCYJLSNivvWQUg==@vger.kernel.org, AJvYcCVrpTy9WuM6X7Ly0JnLj8PnbSexx/Xjj4Y8dJmoHMUPjluATd2BkxpD/hP8ldOlMl5d1Ozp61hBV4HQ/t8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH+kF9XUK44X7jt/EUqUv302Wx6+fKvUtyW3XaEyeZUd/qnwE7
	wfUHbeT+HKSR0dBcY1Ob1Xa0VEic2clAp+LWV30+6EtldOlNtoDS
X-Google-Smtp-Source: AGHT+IFHXe9gX6Mr+ftZsG37P4waBj8EMIsdjjpgkgeHJu5nMMDmOTa0A/cI8QSGz7sjXRRocp5BKg==
X-Received: by 2002:a05:6a00:198a:b0:71e:415:c4c6 with SMTP id d2e1a72fcca58-724133d215amr4899283b3a.26.1731098513271;
        Fri, 08 Nov 2024 12:41:53 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffe3sm4221945b3a.2.2024.11.08.12.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 12:41:53 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org,
	peterz@infradead.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mingo@redhat.com,
	mark.rutland@arm.com,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v7 06/10] perf evsel: Assemble offcpu samples
Date: Fri,  8 Nov 2024 12:41:33 -0800
Message-ID: <20241108204137.2444151-7-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108204137.2444151-1-howardchu95@gmail.com>
References: <20241108204137.2444151-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the data in bpf-output samples, to assemble offcpu samples.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/evsel.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 695f831b463d..20f07597fac1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2783,6 +2783,35 @@ static inline bool evsel__has_branch_counters(const struct evsel *evsel)
 	return false;
 }
 
+static int __set_offcpu_sample(struct perf_sample *data)
+{
+	u64 *array = data->raw_data;
+	u32 max_size = data->raw_size, *p32;
+	const void *endp = (void *)array + max_size;
+
+	if (array == NULL)
+		return -EFAULT;
+
+	OVERFLOW_CHECK_u64(array);
+	p32 = (void *)array++;
+	data->pid = p32[0];
+	data->tid = p32[1];
+
+	OVERFLOW_CHECK_u64(array);
+	data->period = *array++;
+
+	OVERFLOW_CHECK_u64(array);
+	data->callchain = (struct ip_callchain *)array++;
+	OVERFLOW_CHECK(array, data->callchain->nr * sizeof(u64), max_size);
+	data->ip = data->callchain->ips[1];
+	array += data->callchain->nr;
+
+	OVERFLOW_CHECK_u64(array);
+	data->cgroup = *array;
+
+	return 0;
+}
+
 int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			struct perf_sample *data)
 {
@@ -3134,6 +3163,9 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array = (void *)array + sz;
 	}
 
+	if (evsel__is_offcpu_event(evsel))
+		return __set_offcpu_sample(data);
+
 	return 0;
 }
 
-- 
2.43.0

