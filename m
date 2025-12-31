Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27248189F43
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Dec 2025 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767172513; cv=none; b=FWmG325R3FdX6B2oOej+kro9adk/XjcALNBWKjtNg+1yW2OTZiBmdKGbjUuIbgE3bGj/EqS0IA2cDynR6L+lfkZT74kAeJVTtpHyZeBLdx/WRkmb19IpLhAv0LAPm0fz0dF5X82oCxQySfZyA9k5FPhpgbO2bzVKpT1L4gZRdhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767172513; c=relaxed/simple;
	bh=z+kguRRaqZHMZx2XZis3aztpcnjb4raCwVyceh6uPlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E3FiceUhzYEssjTfmCUMDyLJKdFRxC+rg7N1y4HQr4dkpkWq8AOhdnqdnkUwLZ8ZujmGxv73KxOZ3WkZ1aHweCDldflV4Q4kyJ7se7SFvo4NopB24b9IZ6rENjCd2rZXffPQQ/lTzdzCDWkuiKFYC5vbuS5yPMJ9fTI39avtkv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bytefly.space; spf=pass smtp.mailfrom=bytefly.space; dkim=pass (2048-bit key) header.d=bytefly-space.20230601.gappssmtp.com header.i=@bytefly-space.20230601.gappssmtp.com header.b=uvnixW4k; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bytefly.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytefly.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytefly-space.20230601.gappssmtp.com header.i=@bytefly-space.20230601.gappssmtp.com header.b="uvnixW4k"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a1388cdac3so99076035ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Dec 2025 01:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytefly-space.20230601.gappssmtp.com; s=20230601; t=1767172511; x=1767777311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cqaN5izDEsgH/os+tYDrb4IvKYYnm+SnIE1Vz4Q+hU8=;
        b=uvnixW4kp8r/k1SAGmsf97cvMOvZfQorgwqiamYy1j2YUFgiGePYPMf293FDIt16vL
         cctTLi4WftbO81YZjTnVTNR930LA1FYZK5KN7hnY/RUZ9BHK19Qtge052YBeZ48IMV7c
         dKCnbTq2J5ctaYe2L0BtXmAjzGw+BzXDWInKsdpyqahM/2WbM53QKkFOrf7m3WFPzApI
         Zr4A6GVzc0wL9M5wseg8tjKMgmZ9UqpKeRTve9sNTo7i7i5VWuxa/w6ES7UVpT7czNOf
         8NlxD1Z8RvwMuSpLQ+KAc6m3hXQOPi+VBjBOM+psc1yqC/8DZSH28vTN+6gFvZS6riQA
         R3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767172511; x=1767777311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqaN5izDEsgH/os+tYDrb4IvKYYnm+SnIE1Vz4Q+hU8=;
        b=YZVUrxY0bSl/FBY3NRj3AY0lRjnJQW2hBZPNoyQkUvMTASEJWjilr7/xnDnONi0tni
         8XNlhyUYv5Ndk0Ve0xKk7gaVZTlEDpY+6Q/puHd0qC+o0I23HhMrfa4NaW8AIKXv5IHj
         llZf3LqKhi5oHXh8SvcBcOAvUGILpzGBF55pSN7nfxJehjKYuC1Bfhbk6u6c/begNr27
         j1Qmb/jIUxlmVYDB0pXY2z7YqOYN3SdoQAUU75+ySC/D1JYwU3PlyArYunwKt3yTx4+/
         mTbTVc7TeTn3ePNSIw6C0njMexXlySHpyc4/4E/rurdStbnvQui6Ao283ADfuKdqE3fY
         jgmg==
X-Forwarded-Encrypted: i=1; AJvYcCV0iqcJedbjXWUCHGzSlACv7hWPI3LPajgaRIGxV0IajJbCDlY6vu3L2EICE7PwOMD4f4wPj8on3F55luNfAWBx@vger.kernel.org
X-Gm-Message-State: AOJu0YymqnVA1b2rs5ZPmvODdn/AztlbtsPfvW2XU2B1oRvNEZv4++pq
	hGsj+Pym1wOPOzR6KO7yx8QAOtOjks5nzINr3K+bL96eCebl5qO2beRTvzPSyWVVL60=
X-Gm-Gg: AY/fxX5CCbLGxh1nvK9EhpilZwGrR9tPJg66iixTGlzWRK+9cPxmat38T71PnT9+yds
	RB7QeRUPMQA1f0gLR1FA0BPwxpmmuOnRDPrcHY+ivju3uwZ/Gck8YpXKPgFyJYB2OA1aci93ZrT
	u0GgyrNwVGUfeS2uHo6Zfs1jkZxmQIj0fiP5+G/xKi232AHKdkeBB1kU+oHH56YV24evxDFKS3Y
	TaTlOLVknn0GdURHqaeBxO5w0b5A8g5rtD0EbRfgWaEdbG1GpMEuquE2mMo1aH84RncheG03ZXO
	pmvu7/QxsARSBvjJob5TYMQeMozhxqA5Vuus/wo5xkl1K0noQPiMzk7wI/ejyQjMKNPHoTsNnCl
	P5GHZFBykj9Ey6Ekw8UwXK0dKhQndi0PUnJdpkzS6uQo8JQVo4UutyKbPimeBWM+bA7FtcS0=
X-Google-Smtp-Source: AGHT+IEEHAEmUHoBPsk2VWXa0Bxxl2Wl+1W1VgdLinYqxfVL+B8yrv2/848F+XVxTJyQxSLPq3mDmg==
X-Received: by 2002:a17:902:ce92:b0:2a2:d066:b668 with SMTP id d9443c01a7336-2a2f222adc2mr292537615ad.12.1767172511271;
        Wed, 31 Dec 2025 01:15:11 -0800 (PST)
Received: from xpc ([2400:8902:e002:dec1:95fc:f49b:fe:1151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c666casm319258255ad.3.2025.12.31.01.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 01:15:10 -0800 (PST)
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
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Lisa Robinson <lisa@bytefly.space>
Subject: [PATCH] LoongArch: Fix PMU counter allocation for mixed-type event groups
Date: Wed, 31 Dec 2025 17:15:00 +0800
Message-ID: <20251231091500.530432-1-lisa@bytefly.space>
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
 arch/loongarch/kernel/perf_event.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/kernel/perf_event.c b/arch/loongarch/kernel/perf_event.c
index 9d257c8519c9..82cc08c2b056 100644
--- a/arch/loongarch/kernel/perf_event.c
+++ b/arch/loongarch/kernel/perf_event.c
@@ -633,15 +633,24 @@ static int validate_group(struct perf_event *event)
 
 	memset(&fake_cpuc, 0, sizeof(fake_cpuc));
 
-	if (loongarch_pmu_alloc_counter(&fake_cpuc, &leader->hw) < 0)
+	if ((PERF_TYPE_HARDWARE == leader->attr.type ||
+	     PERF_TYPE_HW_CACHE == leader->attr.type ||
+	     PERF_TYPE_RAW == leader->attr.type) &&
+	    loongarch_pmu_alloc_counter(&fake_cpuc, &leader->hw) < 0)
 		return -EINVAL;
 
 	for_each_sibling_event(sibling, leader) {
-		if (loongarch_pmu_alloc_counter(&fake_cpuc, &sibling->hw) < 0)
+		if ((PERF_TYPE_HARDWARE == sibling->attr.type ||
+		     PERF_TYPE_HW_CACHE == sibling->attr.type ||
+		     PERF_TYPE_RAW == sibling->attr.type) &&
+		    loongarch_pmu_alloc_counter(&fake_cpuc, &sibling->hw) < 0)
 			return -EINVAL;
 	}
 
-	if (loongarch_pmu_alloc_counter(&fake_cpuc, &event->hw) < 0)
+	if ((PERF_TYPE_HARDWARE == event->attr.type ||
+	     PERF_TYPE_HW_CACHE == event->attr.type ||
+	     PERF_TYPE_RAW == event->attr.type) &&
+	    loongarch_pmu_alloc_counter(&fake_cpuc, &event->hw) < 0)
 		return -EINVAL;
 
 	return 0;
-- 
2.52.0

