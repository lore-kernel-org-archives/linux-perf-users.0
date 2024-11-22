Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1CA175D45;
	Fri, 22 Nov 2024 04:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732250338; cv=none; b=one/I5iAJWXruvgib/L1Nr2ABpvsnzqee9c/AGSZrwJOKYBjKb6cSG+tknwChQo3ksu1GKvgiOPlJ+Yqhr4esN9MPD4uKRdcvRAXZELJqhOtN3VFYAkj38CsHB/mfIzJYAHIdtwCuLabl5LTlnX3dBw1n4K7j5F44DprQ5CRT3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732250338; c=relaxed/simple;
	bh=vccFHYr8ZR9cgyM4HGgwFgDtARhDnJAfANCV1e9IKOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WaMoKI5MWXFOMP/Vl7pafwABrLfdNQF4Lu0F4QG44jB4zvnXErlwZ+GKfqVp2Q5J5UqCWdtbQpfteztGqXXr/n9u+FvpnS9Kpfbvyfklo62B9quH9sE6AjOY+TYSL4x7ef2Vx96EqQrchuaG8sBqdJ7KJkuxccUpfSuBnRz/6Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEG/6jOl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEG/6jOl"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21288402a26so16202985ad.0;
        Thu, 21 Nov 2024 20:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732250335; x=1732855135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBlhrPHwwByaR2iQ3j+uYlOmJcTMAeh7R4Wsq+6yt50=;
        b=mEG/6jOlGHtxwRp96XnYJdi/vzV6Auh2UUaR6ONvfrcULEX8vDZeUsZemv8d680GT6
         uK3eR4nxsMdkFlWfWHBB1NX8uBxKzDnuQru9otnWsA4FjcEwDHm/A2Q0KnbgfWewjoZR
         D95ejupCtYnlTbKgP00x2Lr1AjzdfAEzgpphKnZ1RGaZJvyLHuMBLjC0E/FMq6TI1Xag
         6TIR5HDziJAt19G2+dCB8sjGyUBQWirC84bReVW+TMtSWY5+n0ZdgwYMZLey8hC9r0ew
         9IdOJME8/KteI12Dw+g2DVXHxZjLkMXOJzilOs4+/TN/moleTo5p0el1h3yhwjZaW4V5
         rgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732250335; x=1732855135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBlhrPHwwByaR2iQ3j+uYlOmJcTMAeh7R4Wsq+6yt50=;
        b=i2Jrkq0r9rcsdybVY2543kTSrgvwpf6sL73gQs2yzBGIp24BYp2tacCGNiVtOauZeQ
         uTft1VFaYkwAfxBFd2Xbw8OeYfVFBCjMoBanR6fsx8BoBVCPzxt+z/J0UZNhuXdt+4tn
         ptEyIolHU18Xbyg4hRGDy47pqMBMYBAULt09Uv/vu+OUDO08lVT5sENUrmPQj1zgeCBY
         Ci9zMMEc7svoqIykWYc4jRtcmeSldvu7FVkJAPFpTOEhIC+QZVo2S7f/BPE947H5JBTp
         d5NaJZOKyBQjSiM9CvOtpMcTQ3Xll6DA8RJWWcxy5svj0TpNFye2qhw2kHDPDbH2+muc
         w7Rw==
X-Forwarded-Encrypted: i=1; AJvYcCV1SXqkqBmNowwUCUzWRioqPj+9RLLLvHqSMhZnkL9cl+ltv9HdU/E53xkLK3CCQgGD3oDK4yfoAAz1xR8=@vger.kernel.org, AJvYcCXCZUXTYLJJtVXqINt/HrKUGYnduPyi0lsrkWoyLcKmWB4UJ8AD5MiUn6m9l7yT7x+QcXSAk4TqSiBM+f04wo3Fow==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/AWmUblOSqSVfqPIh2iISxMRYLy/sSn856NOcJDScUsCYgqkR
	yYSOJ3/cyMjDaGB9OcFbvVHcYkGgclf5yF3WgcbnU9fqnc0qTrdd
X-Gm-Gg: ASbGncucRCu6eFzY+M13v6/OekSVDh6KEEPedr7e3P1525h0Tsm1OOW7RXKQVA/PTra
	BZUU6z298v8J5cNZvlHbxYJWwxoHv/++ISQdYmpjMTs29MhxwJIBMZwrambvsByVxvEOEikjfah
	ORFNrNANEl2pZLqBObnW75m4/wZHrWFCWHKwQIdtskYGuT2UUBGXObuK6BUSGcEQhU+ZAtynGL8
	kKrKEKh5OYOMYd2OSQW89qFSrjgVkg8egF6iAY+0RQ+rV2PixDsbENT7BZIhtVkHMn2MRUy8OZy
	au4xNvdxlOM=
X-Google-Smtp-Source: AGHT+IHIqoWLIXPnm5MeU74XzSsIm2/O9Rr3IPv3Q5s77pnEkhraKsXuMvxngzkgcBCuqpT08tDHGg==
X-Received: by 2002:a17:902:dac8:b0:211:e686:760 with SMTP id d9443c01a7336-2129f2a53a6mr25806335ad.53.1732250335525;
        Thu, 21 Nov 2024 20:38:55 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc1544bsm6638135ad.193.2024.11.21.20.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 20:38:55 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v9 07/10] perf record --off-cpu: Disable perf_event's callchain collection
Date: Thu, 21 Nov 2024 20:38:37 -0800
Message-ID: <20241122043840.217453-8-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122043840.217453-1-howardchu95@gmail.com>
References: <20241122043840.217453-1-howardchu95@gmail.com>
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
index c6edc0f7c40d..f07ab2e36317 100644
--- a/tools/perf/util/off_cpu.h
+++ b/tools/perf/util/off_cpu.h
@@ -13,7 +13,7 @@ struct record_opts;
 #define OFFCPU_SAMPLE_TYPES  (PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP | \
 			      PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
 			      PERF_SAMPLE_ID | PERF_SAMPLE_CPU | \
-			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_CALLCHAIN | \
+			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_RAW | \
 			      PERF_SAMPLE_CGROUP)
 
 #define OFFCPU_THRESH 500000ull
-- 
2.43.0

