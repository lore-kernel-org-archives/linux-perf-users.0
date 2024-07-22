Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3392B16D300
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 10:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643176; cv=none; b=AU7wdMI6Xqh2DBg+8O08yyTpcAxJ5+JOL9OpQEIHQ6xIJAnItmvCWVHqrTSvVjUNapIXMttBezwjSpdOwgwxPjZtb7NI4nusj3MNM+nCPB4QLJDvVaPU1FXIAWq1H3ZqzCmvKhfM+OtgHyxNmFnKOEWmFv92wmU+3TCxx+qBnMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643176; c=relaxed/simple;
	bh=nFFI9RKICO7tZQAb/+UsQYDgk3RpA4xkmXJTM26/t0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pm6g8xWDxo+CWbLfcUMdd26J4PvNdWmw184TrwEVLYDg92DDbmvSLafnQ69LhCbKFYSgFraeuTEeF82AMZOM2oLIBwcZiQGttNad4CFOAAIlngORvYhESKHx79bhVAxsZSl0/2rS7ZqjGYH7hNNuKwVU06HCyV8jzYQ86tuOtAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZYk+9vfW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZYk+9vfW"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42797bcfc77so30818115e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 03:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721643173; x=1722247973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBWFBM+gp3e/C9sPG7aaILEvO32vZCwGZx3iasW4K4Q=;
        b=ZYk+9vfW70TrHJT++buTGw65uA45+55wFkvT8C7HvjCZgzIst6c5V8d2mHPZOvlSsi
         MJVlX0nXaV2YZfz346HkmlXZ5gbZ/3sQroEKpbA/ARDyGRmdHqvdTe8OLPRRwspVRT2H
         /4P4p8/2DVAtuYtIQRGX6sup3xh7wgRbeG/QoHyxKm0nr/lXB7FXGRrUCf/S6NwjEn9K
         ZcdCA8FJuvQ1UYV4OCKejlsca3fDiSH3pOdbAm8jkz7p7fCP3pNn5EgDFQEHZLiHty8h
         HbtDeF3HFCWz04Lf6uv2IqlJkoosyMv0KdSfv0vIfePHvi5C4YygTJGDA0AUtYlmAXW6
         83NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721643173; x=1722247973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBWFBM+gp3e/C9sPG7aaILEvO32vZCwGZx3iasW4K4Q=;
        b=emHnKcM3IBPQk0UTvTYHCR0HRqm8aLCUhnn5bm/7B0t0gNAw0yWfKMe9YPi/k+1Mim
         jpZkRpQiypxtxsi/goxzzNlo9jVPA3JYbb3N/P4V6Y8U8bBvWh7uILK9Nje0+jkGN86c
         6JjNUE9MoPeSoSkHwSEEONZddYIhKCH+w1nGoA4mljqtylhDzJQZ+5PFy5dr9xqcfL0j
         zGb8Nre9jZmfio6nQxSHQGYsPGkty706mXIGEb55m2syPqRZdvLV04uNqzD8WH6feiIE
         0I3keGkNkt5F54yy4Tp5fFg+p7xdvGKvuRtKc75bBZuj1GDuUVOJ7i3AI9EVvv1ce/uX
         R+DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgiajTY0V3vWYCq0zQUgeeAT3MtC/ychae7/l7bInf7MU1VN/QIuV8Gnb6fVgV/P6FPa3ZGgxbr8v1O0e/l+1JoeS7Xp9UoBWGGU+27EjeMg==
X-Gm-Message-State: AOJu0YzjXYGQxdSf8DqCq4YCG0G2IFSmxKdazQYWa6WmyHWWhXaG4O6j
	OCuRdjsO76yJq8QhVEgRufca/+MJG8f7WqixmGtq13P80sqd/yHuvB1r9utVIcM=
X-Google-Smtp-Source: AGHT+IGYIdyL3I1JnwUVfQo4oAyFcYwPdf4bNyN/KdL9IsI3rZiBMwNwH2ZruyyHUHfolR/1azJbfQ==
X-Received: by 2002:a05:600c:4751:b0:426:62c6:4341 with SMTP id 5b1f17b1804b1-427dc52e886mr46427815e9.20.1721643173518;
        Mon, 22 Jul 2024 03:12:53 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e436sm147993865e9.33.2024.07.22.03.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:12:53 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com
Cc: James Clark <james.clark@arm.com>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v6 05/17] perf: cs-etm: Only save valid trace IDs into files
Date: Mon, 22 Jul 2024 11:11:47 +0100
Message-Id: <20240722101202.26915-6-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722101202.26915-1-james.clark@linaro.org>
References: <20240722101202.26915-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Clark <james.clark@arm.com>

This isn't a bug because Perf always masks with
CORESIGHT_TRACE_ID_VAL_MASK before using these values, but to avoid it
looking like it could be, make an effort to not save bad values.

Signed-off-by: James Clark <james.clark@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index b0118546cd4d..14b8afabce3a 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -643,7 +643,8 @@ static bool cs_etm_is_ete(struct perf_pmu *cs_etm_pmu, struct perf_cpu cpu)
 
 static __u64 cs_etm_get_legacy_trace_id(struct perf_cpu cpu)
 {
-	return CORESIGHT_LEGACY_CPU_TRACE_ID(cpu.cpu);
+	/* Wrap at 48 so that invalid trace IDs aren't saved into files. */
+	return CORESIGHT_LEGACY_CPU_TRACE_ID(cpu.cpu % 48);
 }
 
 static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr, struct perf_cpu cpu)
-- 
2.34.1

