Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CB91EF084;
	Fri,  8 Nov 2024 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073663; cv=none; b=JvKb6tA4mysWuJCHU3/I62mN08AdaFxC/bCkD0au5J1KGvGrasOyszhFzPVPolifoYHPE1i3qnXsnisAVe6y99grwJSGYWS6NkpoWiqNolX8ZNVOGarOJDuX7Yvtyj8Yetdd1WBWjsoqgQgGe3Hy+7LJaj5ob67yTBmquZuAAXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073663; c=relaxed/simple;
	bh=5tuQIhLYLrmdFUF7osaQlsBi++fNez6g63FsiyDgnHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BhMDRmjRoYYP1bIogBiPqtgO8JFrOkn7f5FukAzXOlVyP7mJXdvEK8pI1sYk/uD+52TphIW0KCrB5jilAPSzer1hl+PvtT6ZxCi1w24pnuSBgrJX5aS5hrbXjF01pXzsQGW2gxmc9HV4pFNIXddx7LvoB150FbgAek/E+wdYa4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccwiiFHh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccwiiFHh"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso25549825e9.0;
        Fri, 08 Nov 2024 05:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731073660; x=1731678460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KsIe4tKwDw18rlGzCIKWB3zmvgLSJBWJguSHhwKJcXA=;
        b=ccwiiFHh1WsPadWzVvvOgJ2CENoXheE6fGzfFGks1X+qkgNGSrTmVFssE8hPZtIOMa
         y/xKyBXqFumQgDmzWYNO8nyPzqOHYt/A5jw5Ws3Du19w2fpLx+itMuNgxgSyxwLtILgz
         UwcOt/IZ7wboz6gWqx4utWIIjG0bDXDPSzdwJKsqgsFwM1ibAmaA+VXUAgo6s6bGmfV2
         K3GICt2VyNh5iotWakOa5pqECnm1ygnrBL7NDhpZDjSmrJGU45Nigjx47d/ZoS9K4RXH
         TA3iqaQ4qpiWZs9yWICUe07U6jAwOBpLKk4bv829vPZOOGaa/LchS9FpbRSdG6WPvpCG
         5ljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731073660; x=1731678460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsIe4tKwDw18rlGzCIKWB3zmvgLSJBWJguSHhwKJcXA=;
        b=mdNRumAjS+MPw1YfXpojIKb0nsrpCrBnWviRRUoLXW4eLZawTuZJxoclRuIp7tRWv9
         rCNxurAdXYUGAYUci/xFm4bxp9vFZyudYjmE3/15Tk+1cPMaNRBOxtwsZ9McR0jny3xY
         MwuOYtP9v0UozFehfthuqEBEugEuqXLzX99ajhC3SREGmlaR12t9SN6IDmgk+ZQMOObr
         25YPjZtZYPEp2jKmd+wtoPUuafzfCFvylLWUTf24hwVZ1erZvbf/N/rdxxdcy10upUHd
         Y622ejk5X/Wdx0ogAxuo+TRry2GAvaeIsSZTyH2YR4OAudqh0fZCLNYk8jtMo+2zdsjJ
         2dow==
X-Forwarded-Encrypted: i=1; AJvYcCXBnmwpGZ0QJEnhmWJteoz3Si3Onx5wKtVqqPOAKc+IVEOAngLF76xcjcjh54oiW3c1/xHoHbzjuzIflNGYOUs=@vger.kernel.org, AJvYcCXKx1g0x4AWV5ghysX2NajEmoY3hW37mXdI1H6w01GHcQ94MBbZlDuKEeH54Tqy3g3L1NUB5XBdE9bP9slS@vger.kernel.org
X-Gm-Message-State: AOJu0YzgQNbIAH0CRO0rI57L8VxBpbpW0yKgtySr0xu5457FdVonjbWa
	dKOQoP6nPfqgk1vFeQpzQn3FRKovK6Bcqyq9QNi5fhvWtfTQs0+7
X-Google-Smtp-Source: AGHT+IGBV/K9g17UrlomSZXt3CV0Ro5BSBwbqEK26k34DyKiySC7XGPzuPWIzwPsTKf4naXH4fjnaw==
X-Received: by 2002:a05:600c:3b12:b0:431:4b88:d407 with SMTP id 5b1f17b1804b1-432b74fec83mr26576155e9.5.1731073659819;
        Fri, 08 Nov 2024 05:47:39 -0800 (PST)
Received: from void.void ([31.210.177.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed997320sm4974190f8f.47.2024.11.08.05.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 05:47:39 -0800 (PST)
From: Andrew Kreimer <algonell@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] perf tools: Fix typos Muliplier -> Multiplier
Date: Fri,  8 Nov 2024 15:47:15 +0200
Message-ID: <20241108134728.25515-1-algonell@gmail.com>
X-Mailer: git-send-email 2.47.0.245.gfacbe4f633
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some typos in fprintf messages.
Fix them via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 tools/perf/util/intel-bts.c | 2 +-
 tools/perf/util/intel-pt.c  | 2 +-
 tools/perf/util/tsc.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 3ea82d5e8d2e..a7c589fecb98 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -808,7 +808,7 @@ static int intel_bts_synth_events(struct intel_bts *bts,
 static const char * const intel_bts_info_fmts[] = {
 	[INTEL_BTS_PMU_TYPE]		= "  PMU Type           %"PRId64"\n",
 	[INTEL_BTS_TIME_SHIFT]		= "  Time Shift         %"PRIu64"\n",
-	[INTEL_BTS_TIME_MULT]		= "  Time Muliplier     %"PRIu64"\n",
+	[INTEL_BTS_TIME_MULT]		= "  Time Multiplier    %"PRIu64"\n",
 	[INTEL_BTS_TIME_ZERO]		= "  Time Zero          %"PRIu64"\n",
 	[INTEL_BTS_CAP_USER_TIME_ZERO]	= "  Cap Time Zero      %"PRId64"\n",
 	[INTEL_BTS_SNAPSHOT_MODE]	= "  Snapshot mode      %"PRId64"\n",
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 3fe67bf652b6..30be6dfe09eb 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -4110,7 +4110,7 @@ static int intel_pt_parse_vm_tm_corr_args(struct intel_pt *pt)
 static const char * const intel_pt_info_fmts[] = {
 	[INTEL_PT_PMU_TYPE]		= "  PMU Type            %"PRId64"\n",
 	[INTEL_PT_TIME_SHIFT]		= "  Time Shift          %"PRIu64"\n",
-	[INTEL_PT_TIME_MULT]		= "  Time Muliplier      %"PRIu64"\n",
+	[INTEL_PT_TIME_MULT]		= "  Time Multiplier     %"PRIu64"\n",
 	[INTEL_PT_TIME_ZERO]		= "  Time Zero           %"PRIu64"\n",
 	[INTEL_PT_CAP_USER_TIME_ZERO]	= "  Cap Time Zero       %"PRId64"\n",
 	[INTEL_PT_TSC_BIT]		= "  TSC bit             %#"PRIx64"\n",
diff --git a/tools/perf/util/tsc.c b/tools/perf/util/tsc.c
index 2e33a20e1e1b..511a517ce613 100644
--- a/tools/perf/util/tsc.c
+++ b/tools/perf/util/tsc.c
@@ -119,7 +119,7 @@ size_t perf_event__fprintf_time_conv(union perf_event *event, FILE *fp)
 	size_t ret;
 
 	ret  = fprintf(fp, "\n... Time Shift      %" PRI_lu64 "\n", tc->time_shift);
-	ret += fprintf(fp, "... Time Muliplier  %" PRI_lu64 "\n", tc->time_mult);
+	ret += fprintf(fp, "... Time Multiplier %" PRI_lu64 "\n", tc->time_mult);
 	ret += fprintf(fp, "... Time Zero       %" PRI_lu64 "\n", tc->time_zero);
 
 	/*
-- 
2.47.0.245.gfacbe4f633

