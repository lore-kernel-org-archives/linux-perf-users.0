Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7E421257A
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Jan 2026 02:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767927207; cv=none; b=kci9IfB7Z3iwPiqs0S1itmadh2TNjaRQ8ULhgQeSQfSHWjDq2kZj8wIPhanjBkZkxjmKXhe7TGP6/4n+haDmFY7a85NG8/xOcn2FgkUtiY/Nb88WQ+pqBNTM7GfgptOXyHcOpcpt0empWal78tp/d5NmcDr+9rTxiawfRGk+7v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767927207; c=relaxed/simple;
	bh=jlDI4QhjXX0sm+AzlIRpnFAmVKzlWGzF2ws15pSU3dA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=biml7+n5Eu+hr3ajeTMWR9ws855V8wn8TqIIkwfl5KU5BV8SnbYC4u349vszWIk/Tx8D9d7qHnyDJu2Q/mJGwHKHZHUPuJdJSnOONXZk0+nyR6wVG8F60mfadBYf+j9rki2CdaXwvzYVaLQq+O+d+H2adbaUudGz094K4bhbv3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bytefly.space; spf=pass smtp.mailfrom=bytefly.space; dkim=pass (2048-bit key) header.d=bytefly-space.20230601.gappssmtp.com header.i=@bytefly-space.20230601.gappssmtp.com header.b=jvoAaAAt; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bytefly.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytefly.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytefly-space.20230601.gappssmtp.com header.i=@bytefly-space.20230601.gappssmtp.com header.b="jvoAaAAt"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so3388787b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 18:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytefly-space.20230601.gappssmtp.com; s=20230601; t=1767927204; x=1768532004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uUXH7ztgyQ+0f072AQRkPa8ArAP5onIH7wP+MjdfZtU=;
        b=jvoAaAAt1xXUeol5vazK4wXa1DorGiUoHumw2S3f3yjQkzF2IAzn+HQ7+NAKtYBpVW
         QR0ySO8SQV+9MgRUGy5o8xXAvwGgSRGk/ehtS1wsgFiKBZ10hVLcO3OI60Vh50fGYU7j
         inMoTqhJUqcjPPullTK0veJ93P7l6BpYpYSgFwjx7/QJRInmemBSMD5P8Gn9IFzJg8oS
         Sm16ZjQdgSopo/2u9WMQjHOshP0I36U9Y66Fls9Ef0hfPR9hesHh5HDo2XWuLn30kfCH
         /hKXWcjQzLZ1gCt1vZLEhczKRApYoN9jbCbKHqLjtRkQ3b/810+rxGnTKKpuYxkrAop6
         jdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767927204; x=1768532004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUXH7ztgyQ+0f072AQRkPa8ArAP5onIH7wP+MjdfZtU=;
        b=xFr6jPEMlGPWApTEHYA5tGHAdziu5k7Md3kP08HDvteJ1WSZp5abSAgfo6iaAqZjsF
         mo2ViIIKdVTsCdnDAlC7TIKuEmELkRuVmBI8tiqza91ZgROwU5BF4S4h1vJQrzfxHyNU
         nJjR1bb8ddT2mx7JVfpG9yFvI4vp+EU1qYTHQ1asxzHqlGOUeeO4CXWprzR/HZiqIlX4
         Q/3b9TbjzlPk2ig2gVdpMivJCbiRiN3Sepfsde+mvvvJrjMkQzTGZV8j7US1VZP8ifZp
         MSkIc9SpevN87AR9LXkWtxgD8su9Zb/N1Vuv3nHNEAgqcWIKNzWNSAMaEdAsv6As1C1U
         qyHw==
X-Forwarded-Encrypted: i=1; AJvYcCXCxgH1O/gkwEyGqe/AwVqWmW97slkYbDEHtH/Rvddt04lFrd/DnnMfBfsVSdq31givE2iI7nTV7+/pCHLJrbpe@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf63JdaqvWAc4zJuGGfhTHcF0g3DePM9h2UDsMP5iEzuyFDhca
	U080omqrdjldALflDWklFwpcJokI6t/UGxniss4W7je7YCG2P5kNizeAt5xTfOxq9Hg=
X-Gm-Gg: AY/fxX5v4QO8VFKpCzV5nft9iZJER/37+R3sPTNNR8VQE4N5Js1o6h2UvgLl4KLssNr
	jasUHI9NHMoCOZJuJfKn2qcMoQe3O6e02qs5sL4bWA+AvLKUBIIJXi4mc/CdUoe4n1XNlqkvG3p
	YYFQa+A0n+E/m8mp1jrh+ZgwxUxtohJrgUJ0Xu7L7SIDQoe9kzEA5wmFBUzarmav8Lhz0/Gs5RJ
	BE22W5yRPZZvy9ZMC7fUf4K+7MZN3kqdzH4gVBSOWt68EKu1mKkF+GCT9GkTprUAMsltVxS1Xnh
	P0XXQMfj9/i9AWYpQ/YSiUdBVQ9BoAaE2WRBU6AWE+4T82S1NmLE5L1h3anIcZReDyS+lKFatpE
	vhCQEiP2u4HzXHvkMd2WMHxgpDbDk/aVN8LtTaz/+uy4B3Mx5WsFK9EBncFxmXgvwmckZBuiubi
	1J7w==
X-Google-Smtp-Source: AGHT+IH0HUr0MdRXguipbzsaEA/OlWzBSmlBph10zKzEYjFwr3gALLho1tjkPB9DgVkeAspeCEoTkg==
X-Received: by 2002:a05:6a00:1c9e:b0:7fb:eb9c:66a7 with SMTP id d2e1a72fcca58-81b7f3f2282mr6338630b3a.36.1767927204353;
        Thu, 08 Jan 2026 18:53:24 -0800 (PST)
Received: from xpc ([2400:8902:e002:dec2:6246:24bc:b792:73cd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc9e7e824sm9069051a12.30.2026.01.08.18.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 18:53:23 -0800 (PST)
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
Subject: [PATCH v3] LoongArch: Fix PMU counter allocation for mixed-type event groups
Date: Fri,  9 Jan 2026 10:53:12 +0800
Message-ID: <20260109025312.226700-1-lisa@bytefly.space>
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
is part of the group, the current code still tries to allocate a hardware
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
Changes in v3:
- Fix typo.
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

