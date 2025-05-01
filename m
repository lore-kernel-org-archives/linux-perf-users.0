Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70172356DE;
	Thu,  1 May 2025 02:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746066505; cv=none; b=Uf+4+SmBPoPbE8A+gc1J0uVi3Quf6DxYT7+bkpVfvg0pnIZR14qr9+EmnIlwnPCa7X+/3DUesOem4HH+5xyMiNeErEdTRSFNcVhJvkpNAZ6KH9vyLdYybNmei4Lh4GG2jt0ctha+bsPKwAvze0Ra6gJiQu/hpdQDN+QTq2+ausg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746066505; c=relaxed/simple;
	bh=Grz3UB4vnKUWYIaF0oX6/68Fsz+qYXnAONgbVsmT5L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnP9VCIHKOmg7O+VpYaBu5yeu3CB3apEmUTIWkpgu0OzR9Jj2/M3gDxguGpemLTmWuVFPQQqBWiDkZsTene0EnaG9MR82pTB2Vj6AC+7+nReQyneZwcnjRCzatOQ635FkRD3Hqq0BPh8JPd9KYreHo67TLn7Ytd/563HMGlC1gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hL0miSHS; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hL0miSHS"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736aa9d0f2aso804096b3a.0;
        Wed, 30 Apr 2025 19:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746066503; x=1746671303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pp9bvoYC1HVNo7F+IfC04BEtYRP27VaZRbTXVY0Kr+Q=;
        b=hL0miSHSHmHkUjP7VquRDpIOJPrYFLVVETbxrw8wPAB/QxLUzEF99blCepSbt+iCS2
         V3pYhybuITOyA1cmcJno5/eNJvNtaoQyBLmg5JL8zTCb/Js00UyLNeXBxkp7r2epSzRr
         7nwybmBBKNnkm450iJ0YQYvkHEEkW07D/ii/Q88xEuwalXfi3NX8SCndgfnWrcVX9baa
         bOCvQNWLroXvnxlj/UzI1UOJdmFnK68fv8csO1AVO+qR83Ot2Z1sXRrOcc/tz8A2Z4Dl
         pYC3+o1UyttnrjmaVjgf8CAzeGXiGwEPujVw+z/xWAZxYqLpYa/6WiQbYHWR/hd7T37O
         f1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746066503; x=1746671303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pp9bvoYC1HVNo7F+IfC04BEtYRP27VaZRbTXVY0Kr+Q=;
        b=mwBygwJu499oXgVOUd3CnW7JfEdJbnNgRIEHUduwyhYpgG58NWSsW7ZN5/13288tJV
         qANabn79DwvdVQKQZ2YtVSR9/aCkCCiFJAcDEIX7gmDeL6jZhzTqbhF33121+Fn23gmE
         0ilRQFA3tNOTk5L6x2Ri02ky/Wscd054gQUUxE5O+Y8rSOiJ/B8iJhaVihxGrtGiCQlj
         YD3L3BkstelEgTNUxvl2z8d1Z1pAxsBb2jOTyRwHajXJ9c9EgaXKqiIOLwj186RcIaHE
         nuVlwNrFVP7n2pqEFLOCDVGqxm/LyCZ0YFbwdgussjc23/WsjsQfSooTUv6eyY41VKjW
         3FKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ7wZjZyqeh9Mlu1US3MZiES7XLjC+VzTAvLfhP7tpacKGX4gJ4TPQbN2VCkkY1S+m3rW9OVa7kE6eyc2bWOZfYg==@vger.kernel.org, AJvYcCXnyJoHg0IqMMOoLyP9OcR5MV0Fk27gP7Lm5Ot0wuKF4wQseRUTpt4hrHAZjUDj10Nc80qYnAQ5lh8OqpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL2mXzA66zUGlrHYIbaNgC7qmbz2k5f0NQj5e2dNyoVLomVPYV
	uzAe3JodA06L4MNTtCfvjUAs+ZTEWhMQzz5nmijPJYHzd+crivTI
X-Gm-Gg: ASbGncurTqCu6kxfyOP6duVT/jZvPFXLnNrIja/EuxSh2gGZZS188MbzljJVZYPDJJR
	hrhKIXCWlCJ6NAjFAeLX/PSAzbcsM7hYKHhXYFwhieYQsBhAGTwa4ae6vgx3kOaMoh5aq0qn4YH
	rWn97DjSrt+0rbhv+z2JGLqaS4+DQuBehakW3vQMkKPZgXWOYMbso/mWkc4z9jzv5fiHKB7cN8U
	zPAABYeAd9alIYtsOSkiP9mshzSOvKggDlWQIPI5nQyvMUuhE594UpEq8Yqn3aE16dKpLiidk5M
	YuAJqCSl4kRIjX12u17tpYiOjZjnGCissaHAReml3WrRUsUm7nRbrxlw3VTUpnrL2fLRERr5a4r
	Wz+5QQHB5jw==
X-Google-Smtp-Source: AGHT+IGC15hbaC94Tt6bIjlRvVzNyq6MOLBhUHtckC7dTNYpg5EQ7HoxtJSOCnczvFU9fclrkx2dWQ==
X-Received: by 2002:a05:6a00:2348:b0:736:4644:86ee with SMTP id d2e1a72fcca58-740477a3273mr1806201b3a.14.1746066503122;
        Wed, 30 Apr 2025 19:28:23 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a8fbe7sm2459599b3a.160.2025.04.30.19.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 19:28:22 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gautam@linux.ibm.com,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v16 06/10] perf record --off-cpu: Disable perf_event's callchain collection
Date: Wed, 30 Apr 2025 19:28:04 -0700
Message-ID: <20250501022809.449767-7-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250501022809.449767-1-howardchu95@gmail.com>
References: <20250501022809.449767-1-howardchu95@gmail.com>
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

Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
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
2.45.2

