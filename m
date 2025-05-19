Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B821EB18A
	for <linux-perf-users@vger.kernel.org>; Mon, 19 May 2025 19:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747684329; cv=none; b=rMUkq84tLw4vZHuyYe1AWCATFMqb2YINgGJt+2WXvZ6qp39XePEmSOZfjfPwXCRYPm5XLVptCq9ISQpdjKBd58xfQZNPVPtHxRt+zaFOAGrzHi02BKlgYnc6SB/TQmVG6SUxOepWE691BTDJPfnS2yAxFMHs6Cu+DYr8jalgcnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747684329; c=relaxed/simple;
	bh=F91uGFNuS9ze+k4o3LzvwL3EVQh99OWk2GUUQpppF5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nU2VRoi3hDAJ7bchYTkrrI/7jVDZtWsJkIM91IXECGbhKE3H6IK31PJ0sEJjyoePpqTQ0Ln9m0SLOz4f8AW5DPPX/ZSBcgMtZHDdfcm2QL38fbgBu2MMQyqfAzterFzZxP3TOqtytK52JPVsUEjasWeo4gBsRsiupLcrioThb34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wh1i6VJg; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wh1i6VJg"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b1fdf8f67e6so3082405a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 19 May 2025 12:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747684327; x=1748289127; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B88KQis10sHy3aFQlUkzgjmtvbJRuQpEiX14gbvKHas=;
        b=wh1i6VJgacMSkeorv8+ocAWh3vUr0QpUnauM5PUBa4Su5e6OXTZXAFjT4M3yrFI72R
         VwWC/xuf9sm/T2CcVQYHATgs8kvwOlGNdzMwV2Ue0+6v69c1iT5hstZxqVgvTPx+BAkf
         vdVdOKLoh0TybMUvCA6ZBQX2u8+wjfHsMasLg+VrbSrDX/62x2MSHPP4WzN01PiUyxDI
         xXeBEySYmJ88Sto8hEiPlwnZsPrOUWL7etOAkbMeFFMNhK6FE5dKAdRIzHN3zVZA9gcn
         g1XygW655CW9ky0hs1s4XdvDMY5pFNy1EvT4EA/V0uDBOa1TVxN4BMIr1tj4rM1ef1la
         tSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747684327; x=1748289127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B88KQis10sHy3aFQlUkzgjmtvbJRuQpEiX14gbvKHas=;
        b=WUWGFHi6WJ1izGXXFK55crjchA2N2D2umIE01jPLBRMzthjT5jGzHxTNIUiTyvjx9c
         QoUmcytMTI8x8RvFXK7vdUxrE0qxXw69K7Vc3YPb/gRTkYWNy0xIufPHr4sJ4YFxX9wr
         f0ChjOr0LwiVLf0cuafCWwBfv6+OopjM3vwIeWkLLKmEb/UBdTmbb7WjL+clRFyg3/Ym
         wg3ahY56YZVi2edVONjLsItiJ299a1iRIVLoelVi9mVWD46tkQR3JQSE8i0ye5mQIcYj
         yJBplhVTTPJLoKR/N+HGYjlbEX2eHo2LjRPKmjPGohYXF8/5Sdd+T4PBcBCLhelagUCD
         3QDg==
X-Forwarded-Encrypted: i=1; AJvYcCVcxMIztSOI/IreagGE2G0tlgwGRV4CRhBoRt5WwN3MQMRpdhYNxq8MmW4uepMpGILQpMPimKE93DJdzv/XnZmW@vger.kernel.org
X-Gm-Message-State: AOJu0YxyHFRyFolB6jAYZpgs5bctWihHqs5bprzbieOIQrHQ/UJKjev2
	L5kosHhrhZwywuek70oltQENlK34WBOU+o31whMIhmnHjxkgJyBoyr4fHIzbsXUE+9sufhF8vDp
	nzakA8o59PQ==
X-Google-Smtp-Source: AGHT+IGNKB0kTAILEX+H7U3c+Jevs+vPzolX2bExHW6YHAb/rS7vZwLc48G926qGoOnOZVWAucjqNObd1hy7
X-Received: from plka5.prod.google.com ([2002:a17:903:f85:b0:22e:154a:6dba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2449:b0:231:c2e8:89df
 with SMTP id d9443c01a7336-231d4535a98mr219436745ad.28.1747684327179; Mon, 19
 May 2025 12:52:07 -0700 (PDT)
Date: Mon, 19 May 2025 12:51:39 -0700
In-Reply-To: <20250519195148.1708988-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250519195148.1708988-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250519195148.1708988-3-irogers@google.com>
Subject: [PATCH v3 2/7] libperf threadmap: Add perf_thread_map__idx
From: Ian Rogers <irogers@google.com>
To: Gautam Menghani <gautam@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Allow computation of thread map index from a PID. Note, with a
perf_cpu_map the sorted nature allows for a binary search to compute
the index which isn't currently possible with a perf_thread_map as
they aren't guaranteed sorted.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/perf/threadmap.h |  1 +
 tools/lib/perf/threadmap.c              | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/lib/perf/include/perf/threadmap.h b/tools/lib/perf/include/perf/threadmap.h
index 8b40e7777cea..44deb815b817 100644
--- a/tools/lib/perf/include/perf/threadmap.h
+++ b/tools/lib/perf/include/perf/threadmap.h
@@ -14,6 +14,7 @@ LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map, int idx,
 LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, int idx);
 LIBPERF_API int perf_thread_map__nr(struct perf_thread_map *threads);
 LIBPERF_API pid_t perf_thread_map__pid(struct perf_thread_map *map, int idx);
+LIBPERF_API int perf_thread_map__idx(struct perf_thread_map *map, pid_t pid);
 
 LIBPERF_API struct perf_thread_map *perf_thread_map__get(struct perf_thread_map *map);
 LIBPERF_API void perf_thread_map__put(struct perf_thread_map *map);
diff --git a/tools/lib/perf/threadmap.c b/tools/lib/perf/threadmap.c
index 3ca9ba4987fc..db431b036f57 100644
--- a/tools/lib/perf/threadmap.c
+++ b/tools/lib/perf/threadmap.c
@@ -104,3 +104,15 @@ pid_t perf_thread_map__pid(struct perf_thread_map *map, int idx)
 
 	return map->map[idx].pid;
 }
+
+int perf_thread_map__idx(struct perf_thread_map *threads, pid_t pid)
+{
+	if (!threads)
+		return pid == -1 ? 0 : -1;
+
+	for (int i = 0; i < threads->nr; ++i) {
+		if (threads->map[i].pid == pid)
+			return i;
+	}
+	return -1;
+}
-- 
2.49.0.1101.gccaa498523-goog

