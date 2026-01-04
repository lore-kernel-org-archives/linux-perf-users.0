Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8237722B8B0
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Jan 2026 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767543823; cv=none; b=LUyxLVVAfCciOMAbNykijESDKYM+6P811z9mCow2OtxYGXpq7I+pCwSVpqHayfrK2p4Rp/N9luSmKjs5sBeyLZYMZv++AfRar5r/Nlf60Vdvp4Z2HKrKzn75Js1g4d7CNYkUbMN8BDlmf3SgroPrA3d2KrgFBLIgHu4uAJYuFf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767543823; c=relaxed/simple;
	bh=eXy8dJxgdO4IOADeWzWF2vncup0JjrNG9ubJINT0K5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EK8uAosCvzRdZIwhL3MNk6E5Iajj6hzl5wIOgPqt4QCt2JRZLlNYsNflp7CuwBL58fU4YiDUrD7h1OeagZP/j0NZnun8QBB8Pdc3Xe7zdtBLBTOobMI3tY4OquRRttEPp+qfusl8F8gpSO2eH4aaWp95s8QaVvlUdTqw5eu3rYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bytefly.space; spf=pass smtp.mailfrom=bytefly.space; dkim=pass (2048-bit key) header.d=bytefly-space.20230601.gappssmtp.com header.i=@bytefly-space.20230601.gappssmtp.com header.b=uAqeE51c; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bytefly.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytefly.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytefly-space.20230601.gappssmtp.com header.i=@bytefly-space.20230601.gappssmtp.com header.b="uAqeE51c"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c363eb612so13689523a91.0
        for <linux-perf-users@vger.kernel.org>; Sun, 04 Jan 2026 08:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytefly-space.20230601.gappssmtp.com; s=20230601; t=1767543821; x=1768148621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EiSxz2yDPnHRK0lKIWI7snTOOhCOMT5nNtbjzhr1fj0=;
        b=uAqeE51cQ3eLSGoNddSoUAWQYJSMx0WVncUb5XglG136FeCk1G9IgIldBIs8iQ+1/3
         BrKZeq2s9iEaWpKFlWnXGhU+kclejMULLHJtTUMv2QYXDpKUGA7DrEnrYRI83jw7S1Kq
         0S+27yyRNdCtJ3AiueBDYbDUvh5An9Z/ii4J+SQumBpDR+8R5Wegb79r+3Smr0PaEHY2
         bsbKb0CgQ7MaoJ4HS6iKREUHZ+oxgZdPZEf3/mqHvtDC0N+/k2gKmE/9WcAMIIAx7hII
         MP9oklZkQz2XezW2196FHCrGXJngOA0m3y5CswwpDc9fat1h7c0j1k22PHVOAttwXyhG
         zctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767543821; x=1768148621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiSxz2yDPnHRK0lKIWI7snTOOhCOMT5nNtbjzhr1fj0=;
        b=Il1rCRMPDpkjgvw3Px5HAYXQ+95SZrvi2Jv4sQnMbayp4RHX3Zm5dn6Y/mCQ9PrR3B
         20eiI4erBOmC0BtIxzAqIq9naGwd5Sc6j1ImLoHTipJWwM3329RwzhbVPF7RtDwJopzM
         lQ/kSIizgNTvE+s2X6WpW4z99BUgCfCxAGCzGqpm+YYei/2aj1bViU/aPnUGh/uMjc1G
         ryVIFQFpYClB30vqXFfDfDrMETpAegp1vRqK1qjmhvWCqvE5bFFQ6xUmLINARFAptW9P
         iqui52nb+Vi7CUvD4cPqNPAqXEbeWo+ValdwXBgcKXn0FBrxHUk763WYqOH2ZrLRKH+m
         8RqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXdPWxtoZgI29F5t01Zb+DssP8I6758NoaiIsBuTMT1f+07cRwr+habkrgf6rLAw2g+YtkAI/VgDZisfhAeAFJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxPadFFyYpE3HEwwmK+iyE3DVCHj4RJY+M4cb/S+RZxT5aOXLaf
	VDnK3Ba0sh4f4GGAu3EhJqklTAbEGLClSskokeC3GB/e032Mfm3E0OXskCWJ5ry3NCk=
X-Gm-Gg: AY/fxX4/wl6eTlCRCzl6Q89BddivuczfRM81w8dwE+f76+Ypx0noC5scjJcOpQ+mnq1
	aC4zUMx4v51IAznQPDJ2ZWQPQekIK116JYz4O5C2+KIv+GpiWVmkkuFj0crxnRe5+Q8TFF34Tiz
	ZaquIYxfNAoFY4DuhVlyRe03QooxJJauAXwM4d5VdW1FE1JMt0ki7p+vZSrB4mlqVeVZnGJaztD
	Bj9arf6ixo9nSuyH7xi8NM9ZeX08eM9KSsqG0W1wasS1rASaBj+GG1LI+TvzPP2jlutRSJvFrV/
	C+r59Z4JOaOQX0liIGkwpQB01WeVD4Hn1x4e4InMM0LyoIp2R2W+kg6+UXfCMT7PpZ+LSrkueER
	wU+JcekUA7drNbmviawsSqfTbaBOhyAJb9Ks5sEn7mXFd8YhKiJxa/q2GBBLkU3M5orPrMUBMI8
	EJFQ==
X-Google-Smtp-Source: AGHT+IFIt0L/lSx8x4bwgvwsbukxt5schrdOqEBeVjh0PRwngkl52ZaA4mBXXVo3bGBUMETqo7YQkQ==
X-Received: by 2002:a17:90b:2fc5:b0:33b:a906:e40 with SMTP id 98e67ed59e1d1-34e92137cd4mr33880998a91.2.1767543820504;
        Sun, 04 Jan 2026 08:23:40 -0800 (PST)
Received: from xpc ([2400:8902:e002:dec2:6246:24bc:b792:73cd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79a17fdesm40021606a12.8.2026.01.04.08.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 08:23:40 -0800 (PST)
From: Lisa Robinson <lisa@bytefly.space>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	WANG Xuerui <kernel@xen0n.name>,
	dapeng1.mi@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Lisa Robinson <lisa@bytefly.space>
Subject: [PATCH v2] LoongArch: Fix PMU counter allocation for mixed-type event groups
Date: Mon,  5 Jan 2026 00:23:04 +0800
Message-ID: <20260104162304.64604-1-lisa@bytefly.space>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When validating a perf event group, validate_group() unconditionally
attempts to allocate hardware PMU counters for the leader, sibling
events and the new event being added.

This is incorrect for mixed-type groups. If a PERF_TYPE_SOFTWARE event
ispart of the group, the current code still tries to allocate a hardware
PMU counter for it, which can wrongly consume hardware PMU resources and
cause spurious allocation failures.

Fix this by only allocating PMU counters for hardware events during group
validation, and skipping software events.

A trimmed down reproducer is as simple as this:

  #include <stdio.h>
  #include <assert.h>
  #include <unistd.h>
  #include <string.h>
  #include <sys/syscall.h>
  #include <linux/perf_event.h>

  int
  main (int argc, char *argv[])
  {
  	struct perf_event_attr attr = { 0 };
  	int fds[5];

  	attr.disabled = 1;
  	attr.exclude_kernel = 1;
  	attr.exclude_hv = 1;
  	attr.read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
  		PERF_FORMAT_TOTAL_TIME_RUNNING | PERF_FORMAT_ID | PERF_FORMAT_GROUP;
  	attr.size = sizeof (attr);

  	attr.type = PERF_TYPE_SOFTWARE;
  	attr.config = PERF_COUNT_SW_DUMMY;
  	fds[0] = syscall (SYS_perf_event_open, &attr, 0, -1, -1, 0);
  	assert (fds[0] >= 0);

  	attr.type = PERF_TYPE_HARDWARE;
  	attr.config = PERF_COUNT_HW_CPU_CYCLES;
  	fds[1] = syscall (SYS_perf_event_open, &attr, 0, -1, fds[0], 0);
  	assert (fds[1] >= 0);

  	attr.type = PERF_TYPE_HARDWARE;
  	attr.config = PERF_COUNT_HW_INSTRUCTIONS;
  	fds[2] = syscall (SYS_perf_event_open, &attr, 0, -1, fds[0], 0);
  	assert (fds[2] >= 0);

  	attr.type = PERF_TYPE_HARDWARE;
  	attr.config = PERF_COUNT_HW_BRANCH_MISSES;
  	fds[3] = syscall (SYS_perf_event_open, &attr, 0, -1, fds[0], 0);
  	assert (fds[3] >= 0);

  	attr.type = PERF_TYPE_HARDWARE;
  	attr.config = PERF_COUNT_HW_CACHE_REFERENCES;
  	fds[4] = syscall (SYS_perf_event_open, &attr, 0, -1, fds[0], 0);
  	assert (fds[4] >= 0);

  	printf ("PASSED\n");

  	return 0;
  }

Fixes: b37042b2bb7c ("LoongArch: Add perf events support")
Signed-off-by: Lisa Robinson <lisa@bytefly.space>
---
Changes in v2:
- Factor out duplicated perf event type checks into an inline helper.
---
 arch/loongarch/kernel/perf_event.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/kernel/perf_event.c b/arch/loongarch/kernel/perf_event.c
index 9d257c8519c9..e34a6fb33e11 100644
--- a/arch/loongarch/kernel/perf_event.c
+++ b/arch/loongarch/kernel/perf_event.c
@@ -626,6 +626,18 @@ static const struct loongarch_perf_event *loongarch_pmu_map_cache_event(u64 conf
 	return pev;
 }
 
+static inline bool loongarch_pmu_event_requires_counter(const struct perf_event *event)
+{
+	switch (event->attr.type) {
+	case PERF_TYPE_HARDWARE:
+	case PERF_TYPE_HW_CACHE:
+	case PERF_TYPE_RAW:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int validate_group(struct perf_event *event)
 {
 	struct cpu_hw_events fake_cpuc;
@@ -633,15 +645,18 @@ static int validate_group(struct perf_event *event)
 
 	memset(&fake_cpuc, 0, sizeof(fake_cpuc));
 
-	if (loongarch_pmu_alloc_counter(&fake_cpuc, &leader->hw) < 0)
+	if (loongarch_pmu_event_requires_counter(leader) &&
+	    loongarch_pmu_alloc_counter(&fake_cpuc, &leader->hw) < 0)
 		return -EINVAL;
 
 	for_each_sibling_event(sibling, leader) {
-		if (loongarch_pmu_alloc_counter(&fake_cpuc, &sibling->hw) < 0)
+		if (loongarch_pmu_event_requires_counter(sibling) &&
+		    loongarch_pmu_alloc_counter(&fake_cpuc, &sibling->hw) < 0)
 			return -EINVAL;
 	}
 
-	if (loongarch_pmu_alloc_counter(&fake_cpuc, &event->hw) < 0)
+	if (loongarch_pmu_event_requires_counter(event) &&
+	    loongarch_pmu_alloc_counter(&fake_cpuc, &event->hw) < 0)
 		return -EINVAL;
 
 	return 0;
-- 
2.52.0

