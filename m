Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2491F2D97A6
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Dec 2025 21:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798439; cv=none; b=cs9TITwL8F8pA3jGh1CDLBL+fbwKwrvuzSI3HMh94KKD8oUALIZXUWsp5zlJEtq6Tqmsl2SMarP+i+3Fdd4IRtycd0n75g1tbitOKsBKofacIITW240K2SBx4NyEvl2QdQI2aD6RvKtMgcGqJN+eYRRnI1113Om8ab2JzuFzb0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798439; c=relaxed/simple;
	bh=Kyld/TH14VvFTwm+4dZFdkYfKcCb+2QzuTXq2FWHP/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b0Kz+O/g+BlMzCV/GltDNe++6hpmQwu9+3Nh8itaxwH1ahXWb44nrx8qC//V/jsW3ycDQX3xPE0CFizYbgwT3VQ+4cht5iKx7cGybObmQ4Iw+7IuYLVbGfmCOPCiA5Y6nAzfSgGJzofTHC6V+VynA6oUNRDPGdriKRalgtg1Dgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZGhmkiYt; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZGhmkiYt"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7c240728e2aso347738b3a.3
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Dec 2025 13:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764798437; x=1765403237; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KVrVKz8Lai23YOYMICxCQxi+2iTcn8EZtLBh+0CJH0s=;
        b=ZGhmkiYtuHMAlODVlJU7YmU5/Vg678OJCd8MoGviHOt0yeZJj2NDNSVDqjGZdeiVck
         C3lYU71iUuCa9x+zAsiZ3mYdppdgmkhJU9CB18IwW1aNTVujd0OU0GzYM3CpniMpjUuz
         VJHeFnNGDT/hi22duhM8YOKjFP2aidX7C3agpF0N1YrgiAK5+mWjvfQn2bgHTFJU5/8m
         95hw83sfFG2gIpYEGvWLAXvOAqOMdD1n34TTOJJefMy/ntGKuDVmAo53xDIidkOjMibf
         C6oN1fjCvcgktybGKy6Ylqni4QZDojZtGmo6CUyFTJQiv6PCc1/U49eSaWt0epCQOtEr
         u3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764798437; x=1765403237;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KVrVKz8Lai23YOYMICxCQxi+2iTcn8EZtLBh+0CJH0s=;
        b=RnO4LaanPTg6ER/07/k4MOTcqHoj7oUbnGfFyozX4pC8UTwQGDGUyI3KnPdHk8Ee9R
         D6DcmPeZlxLyAH+sgnEX+Osif+m6MeMu5kXOM2D4EejYf/i+D2yHAvrA9jZM2ZlMtfIE
         7/F5yffAwWbE1kHZT+pW6AXYERiPhEci2Dgh4upg74l6kYNsoEo4l1MYEJEld8qOVhvp
         J8E+J2lVVCGMRvEVRmupRAl7b8iTMUlTiT4M3SeuoW/Z33ablaqRdtxzVRoK8YKkYWBP
         2BPTkPdMBV8QxlUty9DEjprrmtJO9h+E1wcC1VoggAhgadFi7BkxiDosgtqRa11jucDL
         pKhA==
X-Forwarded-Encrypted: i=1; AJvYcCVHN827NtKh0nHcNePF6HmiQ6QGUNl/O+l+SSsJNwobCHO2fNWLeNEiR7G4tklxet5tjG3SUqhktM/nZc17zgsp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ooCL7ajMnwrrqTuE/6tDU5WGEZgbnwz9JBC64CpoP4Y2WRjl
	nHQlztPVfWMwbB2nttktoutKjAU5VHkO0HaEzKK9jalUrGt5ThPMI2IYNfLO/beJXSS9LteL+6M
	v5jUKSIZioA==
X-Google-Smtp-Source: AGHT+IHQNalAFA0VgFKH+HuXt5tSRXPCzbxo8ZyVDg59kZ29Ina+YFWr1q9VEzg+9t3xXETcoD2Qq+FkDeUj
X-Received: from dlii30.prod.google.com ([2002:a05:7022:419e:b0:119:78ff:fe16])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:390:b0:11a:fe6f:806a
 with SMTP id a92af1059eb24-11df0cc65a1mr3127815c88.31.1764798437402; Wed, 03
 Dec 2025 13:47:17 -0800 (PST)
Date: Wed,  3 Dec 2025 13:47:02 -0800
In-Reply-To: <20251203214706.112174-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251203214706.112174-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.177.g9f829587af-goog
Message-ID: <20251203214706.112174-4-irogers@google.com>
Subject: [PATCH v2 3/7] perf cpumap: Add "any" CPU handling to cpu_map__snprint_mask
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

If the perf_cpu_map is empty or is just the any CPU value, then early
return. Don't process the "any" CPU when creating the bitmap.

Tested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 89570397a4b3..a80845038a5e 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -684,16 +684,21 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
 	unsigned char *bitmap;
 	struct perf_cpu c, last_cpu = perf_cpu_map__max(map);
 
-	if (buf == NULL)
+	if (buf == NULL || size == 0)
 		return 0;
 
+	if (last_cpu.cpu < 0) {
+		buf[0] = '\0';
+		return 0;
+	}
+
 	bitmap = zalloc(last_cpu.cpu / 8 + 1);
 	if (bitmap == NULL) {
 		buf[0] = '\0';
 		return 0;
 	}
 
-	perf_cpu_map__for_each_cpu(c, idx, map)
+	perf_cpu_map__for_each_cpu_skip_any(c, idx, map)
 		bitmap[c.cpu / 8] |= 1 << (c.cpu % 8);
 
 	for (int cpu = last_cpu.cpu / 4 * 4; cpu >= 0; cpu -= 4) {
-- 
2.52.0.177.g9f829587af-goog

