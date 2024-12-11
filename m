Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7DF1DCB09;
	Wed, 11 Dec 2024 22:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955936; cv=none; b=gqgF9MbcMXhCkNMYGezT3wyckmV4m75QhdQ+WvZzZTSEAdoceizbmiLqh6oI8AJjgSJHvPZv4l+ODzPmy9zuv0sO2nNBraDxfkSUNy6n3FcjC1ZPUmzM6PXO+ed+TdGZpyjETrlYk2Gp/y4ELbLMxJASISw9Fbvp9uWX4//+jsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955936; c=relaxed/simple;
	bh=5zwcrkCXWGsnxL/5mROAo6TlhYsXoTqe91xEFV/fnQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnI3PhLmcmHv/VDt7e1eEsREtI2TzYoeJvmz8vGsmxN3Ndmul9YpM+rxGk7VbOeIdq2F8jvIe085+FvOOS8OgHAwbRcUQh0D3CImw/Me5XNfT9X1jq2WphgQ9aJ2kAP/vm7GXSu1Ix6+bCaYlBdizCKXYAbSNUnIPsM5gRA7JQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzrpQiiG; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzrpQiiG"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fc8f0598cdso1004321a12.1;
        Wed, 11 Dec 2024 14:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733955934; x=1734560734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wABlX+oSl9ibR4U3vdXkWwVEy/La7xWsUaZ6DFvspKw=;
        b=gzrpQiiGh4PnchR15KQN9scMX/cbwK+KFH4PZVlmJpPQ9pJYLY6IdeN2Tc0f7gGGKo
         m5+FP7bCH5W1ih0PTXbadDHGefu81xsmeS8uzyU18N96Fxgz+TnLGpGrTUcnAXLhUD2w
         aPPMRnCmEyWBJ/4JEsEa6rpXVtUSOVg99hgbai5wmbn6gk8KU1x5axhTO2TvdY/RGchr
         fc5F2urXCXFBWHKPjB8he+BdUHdxSyhVYWvejFYABeM4ocYYD01crgtATkAY57Sk4xjT
         WtKaL+JXkOwlXjfygB4nSo7sBVM2G7cki/5QQD54lfHMm9pKUMNXxUM7beaRNegvw/Cx
         kn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733955934; x=1734560734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wABlX+oSl9ibR4U3vdXkWwVEy/La7xWsUaZ6DFvspKw=;
        b=wbkE5rOIdsHMLbInnqTpKqBXbEQ3F6lKEjl6eubjpRnSn8TTUlN35G0nFZFC9l0ZLw
         raIvfPxITLLevCwpajLpZ0mBsAagCBLpfdUeR1Knx6Vd9nnut7vd+GG7vDhx/Gua0YQ+
         ATCN047BdMl2z1hrYvvfWWhh/GKd7agH/eBBm8IGTrMEFxatZAn6VYoWgazTuxX1JRfm
         c/nf8d+bz/0A9pJ0A8g9gAKm0LUOODPLxys78i6NBGaTK3IhCvkobZZMlCNcaHk1pLbJ
         1aXbDa/cCb+vCTRRh5ppO6TDEDrjkEon+8+3nXOw5F9SZ0UITvkr8pDsOXf2i1c+xaXr
         s0uQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0+WBMP7xYQjE+myimntdGBJEM8lS/U6lvh7kOxd8fsd0ZDsmPd108DsEukrAYdL+f9zEfXW7dsNO9RSmj3XJQUg==@vger.kernel.org, AJvYcCVgle66XrDTZTu67k5+ywxl6pwMVOZPNW2uIYiPBX0/yefIKZCK0qKGDPnYqmz0dGnTrEY6QrRe5bms6pI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRuVEpIfUkw1rxKI33jgg6DiWmwqGXo3uI4I2gbEaiV/0QZpIS
	4Pu0tjyeK6VLjAYKPnJLktlLc3ZAy1Ah8MGroZWvB81zuXoGI9ke
X-Gm-Gg: ASbGncuvbxeFxIpeqli+teaO6qfOD2dToG42sSLFLmMOfsNV/10slPECipsvI5jJ5PN
	fVTpCZ/6+BxIDL668mzU4AVAM0pIk1FqCU2XByd/e+rasAicXg0VkdPy1zpewXmKQcnZGgTiJ0i
	9/gZt3meGaFdmSpqRwnPVBMuoo++muAPGAoK3JSHeBdfisJoPtcxs0tGgjsJNmq6V694Q5/JjIC
	T0g/S63FuzNTlK88ipeoDzmFowM71cqzeAyvxnwqEVIf9c0roEBoNlRyVbx1TrgJu3ACJJaN4SR
	Gz4AvP8FQQ==
X-Google-Smtp-Source: AGHT+IF1POJ8CvQd05I+nERHlFjEC/kK/MgjgOzPZkJWAFewfm4qBkqZad1DLK0QUzqex9LS9dX97Q==
X-Received: by 2002:a17:90b:3eca:b0:2ee:c30f:33c9 with SMTP id 98e67ed59e1d1-2f13ac1c8afmr1521003a91.14.1733955933969;
        Wed, 11 Dec 2024 14:25:33 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef6d1fd68asm11241561a91.36.2024.12.11.14.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:25:33 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v11 01/10] perf evsel: Expose evsel__is_offcpu_event() for future use
Date: Wed, 11 Dec 2024 14:25:19 -0800
Message-ID: <20241211222528.945590-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211222528.945590-1-howardchu95@gmail.com>
References: <20241211222528.945590-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose evsel__is_offcpu_event() so it can be used in
off_cpu_config(), evsel__parse_sample(), and perf script.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-3-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 2 +-
 tools/perf/util/evsel.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6cffba96477e..867da727a486 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1242,7 +1242,7 @@ static void evsel__set_default_freq_period(struct record_opts *opts,
 	}
 }
 
-static bool evsel__is_offcpu_event(struct evsel *evsel)
+bool evsel__is_offcpu_event(struct evsel *evsel)
 {
 	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT);
 }
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 93b6244ec302..f5004f92f0c8 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -553,4 +553,6 @@ u64 evsel__bitfield_swap_branch_flags(u64 value);
 void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 				const char *config_name, u64 val);
 
+bool evsel__is_offcpu_event(struct evsel *evsel);
+
 #endif /* __PERF_EVSEL_H */
-- 
2.43.0

