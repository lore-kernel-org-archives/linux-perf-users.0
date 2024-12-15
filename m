Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9948D1BDA8F;
	Sun, 15 Dec 2024 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734286368; cv=none; b=bfXuP/VBoTtN8XGQNGELtSUZgiC2wBi8lBbhpIIRWCsi3tPcUfw4WjI/Odr6FoPjeJgz61hZZHX7RlgTAN/01M1ocv1dz0enjY5wTMy9qZwqxxdGAAUFfISlRTfyedlSqEylKqxbHoFjyeH5Tlm73kNLtgMHXJh4YZbdSZ/Foz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734286368; c=relaxed/simple;
	bh=e6fI2ZVl4IzPXnFdTWlY97syscDRQIiFgkHg3JcX4HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPVasE1QeyVtGUbjiDbNuDxVHxMg1RUetkNVTKKslZ0Ff27eGAW/euagMDZDzlcIwI8Qqz+KoCGFt0NQO204vbkBIi4litQIwdcsUep57B3Wt7yPwfgUNF2iSS2sZJeCsBOmvy8C890Y0Fzh3WZq5RY6OWo0X2Bvf1sOF04otds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmwYXs4L; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmwYXs4L"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-725dc290c00so3406070b3a.0;
        Sun, 15 Dec 2024 10:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734286366; x=1734891166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfGyJy7AZeOLJsFch884GnYaUHhnZ6+BK2uA6O0m4MI=;
        b=bmwYXs4LVFCW+JAUMbothD++KiMNM62H8cC0bHzskYPZoidEVRZGxF2BrjeTPtLBCb
         WQBvV1NfqyfOjAErlZP+8manBBZXi6sq3Zd0o5z9GYuRukqDUFRWDwk8Rh+TKq116yKW
         D98GMa135/das4waPe1ZwEUHJLNR6dxToGWQ1bY9O8pbb3uuz44LCwCGFD4aSA61BmeN
         NYD9zNHtkCfJEHHLfk3L0g+DmgsiYf45AJrprvt/R8Qvmoszg5JLILT3+Dp0pL1Q3kJ3
         sqzouua3v2ifI0LwQ6Z2GHukF4b0jGBu6bAhEwEqGp5+I15Ad2VAtV4O6XwKSHcvJApM
         lGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734286366; x=1734891166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfGyJy7AZeOLJsFch884GnYaUHhnZ6+BK2uA6O0m4MI=;
        b=r5Y7UBi7o/PE4nTEdlZVSTqIv2I5Yb75mZegR6rFa0FZGEJZE2BhlKA8jh/kFwgEvK
         BCJ9fjXu6Lf9TD+6UJ2JzRT6mkQjofMUb/aH60RJLXafB5FswTV2igd+2oHEBhuYx8QS
         x5CAjf45NAK5FhZZISgGII3XoqjwiBrzIjR5A98mzBAfW4InJRvmsNUPnmnkDWBspHuB
         o/f0I9GEIi3ogBloMhp+uwCEwNTI2oEaUZOMIQreTAFvJOXFtyLV5YU1PHSrSKhifFkC
         pNeCX0nEAwhQpcherVl7kqTu8Nh+sUtHhIMp7Ws1CRVoowJ8yaVDlRQwa7NZl6ywbEGL
         jUXg==
X-Forwarded-Encrypted: i=1; AJvYcCWW3yVqDtg+L04Nk9toQ3qcgowa3Ytt9di+evGwFbItn73QrItzBkmpUROdvxaar+az0leZbWQgTlth1UKwKspYLw==@vger.kernel.org, AJvYcCX4f8k1QOxwZWxVUxsBpp++oKqHsSbHuDOqked1CKftz3fiW+iehrOW/YklS3UW1WwziR7v397z4FSftYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzpk14mxBSh8M/tM46A6LNvRJfKZYvmAbqhaUqWS8XR9xOhjF3
	sbor1tmHJOxiJEDo7sHR7lWWbggzJfpcw0fJH/r0FbN8sPF60+fS
X-Gm-Gg: ASbGncthJ9G3B4YcBOr29fqkYCljEq+xyog5LcVuSLfQWhMDLOpKuzh09QLDSLuVZ9s
	ymKLLQ+29gjACPrfxK8yEvtebxTelWLwEULStrFbT2gf2qrdRf1j9iPazf8tQIL57ihjevsJHlh
	G9rZIyvsy7wV4UWQ/Z1yG70K/mu3ivTmxLRTXUrZOzpvhHMgoFX/FtlGGIEl1jxKOSjpl+vGPtD
	zBxyovzqTd+veZwEvP5zfmrOLtL+HMZBtdbSpZLvPrq3zpe+s/Cms8/NWQHubu2sHaIGct93WdJ
	89rL8uO4CCLB
X-Google-Smtp-Source: AGHT+IHU4g71VmGhaZj2l7a6OLi55/HQDs+xEbMgzqXKtn47JamJvaAz6y3NloFSZX8Lewoip0P9HA==
X-Received: by 2002:a05:6a20:1593:b0:1d7:e76:6040 with SMTP id adf61e73a8af0-1e1dab8d5afmr17463310637.4.1734286365966;
        Sun, 15 Dec 2024 10:12:45 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90ba0sm2808120a12.16.2024.12.15.10.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 10:12:45 -0800 (PST)
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
Subject: [PATCH v14 06/10] perf record --off-cpu: Disable perf_event's callchain collection
Date: Sun, 15 Dec 2024 10:12:16 -0800
Message-ID: <20241215181220.754822-7-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215181220.754822-1-howardchu95@gmail.com>
References: <20241215181220.754822-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a check in evsel.c that does this:

if (evsel__is_offcpu_event(evsel))
	evsel->core.attr.sample_type &= OFFCPU_SAMPLE_TYPES;

This along with:

 #define OFFCPU_SAMPLE_TYPES  (PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP | \
			      PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
			      PERF_SAMPLE_ID | PERF_SAMPLE_CPU | \
			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_CALLCHAIN | \
			      PERF_SAMPLE_CGROUP)

will tell perf_event to collect callchain.

We don't need the callchain from perf_event when collecting off-cpu
samples, because it's prev's callchain, not next's callchain.

   (perf_event)     (task_storage) (needed)
   prev             next
   |                  |
   ---sched_switch---->

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-8-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/off_cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
index 2dd67c60f211..2a4b7f9b2c4c 100644
--- a/tools/perf/util/off_cpu.h
+++ b/tools/perf/util/off_cpu.h
@@ -13,7 +13,7 @@ struct record_opts;
 #define OFFCPU_SAMPLE_TYPES  (PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP | \
 			      PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
 			      PERF_SAMPLE_ID | PERF_SAMPLE_CPU | \
-			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_CALLCHAIN | \
+			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_RAW | \
 			      PERF_SAMPLE_CGROUP)
 
 
-- 
2.43.0

