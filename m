Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F2213D52E;
	Thu, 12 Dec 2024 02:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733970292; cv=none; b=PdbQXRZbRz9pizFRsdfbAv+xN7awFaEMhjylMB2LXUeTAOY4gbEd3uTboGpzLj08I2CoLDyS4k97LFHP+MRkc2OJrzrmk9rnYh2YMeNLi6H7VSd5yZRiBgQUsyy359p2GpjyQKhY82yHbodPMU7m1t8XY1tB41uW1yc9hcBoM98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733970292; c=relaxed/simple;
	bh=5zwcrkCXWGsnxL/5mROAo6TlhYsXoTqe91xEFV/fnQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jy+XTd6ypcBPQXV9dubVz2O+6JQZO9HaiBFSR8y+XhSXVD8H4ZfIto1VgREt0KVnLkZT4QekFIvZ+ASZ9YQj8CMZUaroYlu18x9xm05nFnJXlg71KrUbtKNh5X6JXSQEpanbDmrYKHLKAQfeu86aCDec4oj8b9GTX4cHN8uNn4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3nLmZAl; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3nLmZAl"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7f4325168c8so80854a12.1;
        Wed, 11 Dec 2024 18:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733970289; x=1734575089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wABlX+oSl9ibR4U3vdXkWwVEy/La7xWsUaZ6DFvspKw=;
        b=i3nLmZAlt6j8DpcH8Ws+2b0IuxS+hcDlgt1xzyDwdJ9TZ6wp3LL2axekIEjhN1e4vp
         Dc5ZhMe7amg8ZY4KmY1K5qkqoHxnlvOvcNUjWRuMIO/EHGzVVgEQvoPNtyz62aATEV/o
         QG/gQVrRQsa4/NIStBf91f+KfooInE6sPF2GDamCr0tPo7mdaFPdqXdvvt/a86Agqf2U
         n3gcPV9nXUFLU4CQt5fNHpJP5eiXPpCJsvpyF7aT7dPH4G9d2vzzoxYflCxY7GrzU06H
         Hm0VvANhmqnPkwWUQDjmhLN9Hfp3jGGn7TKj7wDBkMYzQY+DQlzAXz4V/gARUYcEFM1k
         2YeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733970289; x=1734575089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wABlX+oSl9ibR4U3vdXkWwVEy/La7xWsUaZ6DFvspKw=;
        b=vDfSGTYRUZ5bpkLWwrIxpWIUn3mNNFo6GjkpEVEPBf4otgK093C/vqXoHtKnONRE+c
         bx0uGY++KNiKKIEjbPlte4VHYX9Rp6hY1prZIvXdztjy0n7HNznBATcbOcg+atSqvbET
         oF4OPsPsY05qOi75NQgwls0/iCojVzdwwnrNwNECDi68a2+VoG04U1xeSebXW+iqCtth
         n7EUiDV57Hmesw5RF75IKzePyDsDMfF7yIpswOMa/Yt2TLgZizd5IM9Qzu5SRbu2YcZc
         yniQSo0Zqan3mwFBiGqFc1nEdPuhyTeNOUVRHuxR35KCuMQb1pNHVMl9CY4X6fGsSg6j
         iFww==
X-Forwarded-Encrypted: i=1; AJvYcCW+4LYtGiVJODTSdjoE1iPiclemYrD1P58y6557puO4iw/m71s7OffgP+30I9qVrdrr2KMUDpypHK/AVM8=@vger.kernel.org, AJvYcCWMAs6HY04FJzeHQiGBK17Bs7WUsb9bnFC8cJDUxw8Eyh/jh2vXbviMRE/20L+3JLPPG7swZGdByLvt+G7husVQsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWSajAlY6p19s/KfkhnGNPvgdqMTnaZbo8cSYPghxDNXO7xbRT
	W8xKI5tnKgjt2vTxS5Ao5pGMXLyfTCVx8Cy58y2Q8bW06hKM6jQm
X-Gm-Gg: ASbGncvivIRZWORsV6RnnixNku90j+NimmnTHvMd2t7UBV83pScMXnBDIMSRPipiomi
	C1TxXK+mxNMoLpi+zeM1f7kwm+hQtujjVJM/4TS8dPqATwy+igtIFsxVntIMxnlxZDO1CiWKG6D
	CLotVLQbXjDaM/Dk9d60gerCzH9sW/zIoH3dp1V7Y3TlV+U0qUwVlGMfpVuVn9vbmNqUYnBI/p3
	SNPRLSWARppfP+Hl89WT3D13MSzngHAXCtpZRyoHLqAxi44mixjNaaQ2Q+7SaMadLOIKXo3NmIG
	q9lZpnM9QI3F
X-Google-Smtp-Source: AGHT+IELXO60Bkh4b1mndJoBmPnXdfq6ZucHN67LrRRe4LU1C0jC34ARCKyyjKcMMDGnIY7QGNL+HQ==
X-Received: by 2002:a17:90b:48cd:b0:2ee:fc08:1bc1 with SMTP id 98e67ed59e1d1-2f128044e4dmr8387605a91.37.1733970289370;
        Wed, 11 Dec 2024 18:24:49 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142daeb5asm112583a91.12.2024.12.11.18.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 18:24:49 -0800 (PST)
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
Subject: [PATCH v12 01/10] perf evsel: Expose evsel__is_offcpu_event() for future use
Date: Wed, 11 Dec 2024 18:24:11 -0800
Message-ID: <20241212022420.1035999-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212022420.1035999-1-howardchu95@gmail.com>
References: <20241212022420.1035999-1-howardchu95@gmail.com>
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

