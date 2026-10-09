Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4AE486415
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Oct 2026 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561637; cv=none; b=kW99z3xRTok4IXvGQlkVBuDutTHrMwWBlHqooJoo57GsXRuc9BnNojID++j0+LKpsKyfbKMYXxN8kFotTIS9y3dY+e0/nCarAn6jZ7g6+BydNIyWr8mDHYosje9q5XcezHFKRmQLgIMQIHPj4JDcDPz/MGrlP+ZDXzXlkzpsmZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561637; c=relaxed/simple;
	bh=prfqxOhc9/KEoCJbfH19gTOOaJtyx7cKCyhJIMnt3H4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s7w5hqygj/zHoPArXIOIdH7788KxRn42SiukD6RyjaYmdPc8r6d3vSUpoqFgc5lzuNR0bKUwcsWOOYWuIatfwTClKb6wq1NLvHuTg7C57cwkf1B3NdL+d/3SBZ3H3BoWglM1sv/ad5Oqa3NledER0I6a1TPn0CnX78TZkXCfke0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdojuEWO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdojuEWO"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e61ac64ec3so21890615ad.2
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Oct 2026 09:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791561634; x=1792166434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sYMwquPepbBZtWu4fIneDCAF+onJ2y2Mb34SckVYi9s=;
        b=KdojuEWO+eMRfYf859UhmDlNR27LQW5za+WNR8LIJ2s9XEUnuqSddXnLvAktQT45sU
         0R5GSbEsMyfhqHGtTojydhsgLr3PiHPNtz+2P6mKRU6RtNE0LpAv3kOEtAhz0bijj/NH
         uc5GYDF3W5aKneraqT1svC59XKuvxdvNqtJ9ZE95pHUN734vij5B8ki14xtiAtkWh5S9
         QREL3Zw5zLQSlz+NcjimkYTFba+djGYexL9FUczTb3MUkrHuRFrvjE/wIvy7GEaPnGYs
         /UUjPh81r55tF0p/KZq/e0sq88jz4Z8ar52jlXLClz5LkN5ueqnGzrRSyCpqGAjY4iZF
         27ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791561634; x=1792166434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sYMwquPepbBZtWu4fIneDCAF+onJ2y2Mb34SckVYi9s=;
        b=Y57WLe6bd9dQsOPifEgvqG2LBWz4o3JB+K0NmuD/Sg1HD6Rr5fMcQbWPwnnTgo/dM4
         IQw3/KN/H2eFsRMmCx/bX5mHvAJyuqOZ3AaTaeOhiks42CIKtObIbpav2QwfLKTXH1BO
         c51oI5mqFUKTg9Ef/Xn20nfEO9Hjtt7UVQBJsrPiMoIoNLxYDJHf4z9p/B3omQg5i2tQ
         BR1jUUca5qWse7JGBqeyHYFYhxorj1gFWvHO8xlnsRqyzu/K2/Liv+INzbFMvV+ZpWyU
         77XC5cu52hl3eJCAH/AApQUXPqB06AltmzoJjvg5OgWbT5KSDFSTGRQCe4OkB/wrAIMD
         PnFw==
X-Forwarded-Encrypted: i=1; AKwUvBywwz9LryBTeCHNdoeACntRzJ2m0LA8X0W/gitpsqseTN+2MACrbhaxnrazuLoU/NXO6UWdsHbK08MKASZ49mUY@vger.kernel.org
X-Gm-Message-State: AFq9FYIjn6o+913vA+WuCkVEzXlYoEcoGrvECrOoEH7zvQ4Qd3dqx12u
	MKpkC/asKTYRl9fNbPBaL5EFIIYLdAmVAXuHkjc7dOEBhvUcbKQU77x/
X-Gm-Gg: AYBFou2LRxDlI24bvH/GU7jUyfNcfu7XMrj984OMso0vkdCAYyk/ahQmbJF/f+TTbYL
	BaaIN1lcP2AiCMblNymOw89CpcrdgYoeGYeCMtAfSYR5CdRFttCs8LNEEUcquE6CKBxgSQSbUd7
	z+sIww8LNge+djbuuy64CN3LcuN3UUV/s6tGyCfQzlmlxNAoLi1CyhOQuMEQiRUIZlDTwsUGbBw
	KZWTg5/G2hoHoRbWMsDSsnTDejS0CNUvBkUA6s5D3DY03n5TyZHKMrKp6hAvCRio8eAUqRENtgT
	7bqmMcna92YTFJj6wmVil5/BznRAbCf/hig8ddizr6N8bn6DoCZzklyNN7PiU15f6sd0qRTzhLv
	2ocjsWtlrFKjFDjidyb5lj55Dl087XuFuCrFArFxUVBFsU9JCN7biAdra3kZi9kObivxUMrB9W0
	wxlR5jHDKq0vr07kEl7DQGRaGVKHli5/MnN4A4+ny9D70Q8i2N3GbJUht6O3TvgM3SmojNwtNcF
	1AB1Kqvf+fUwitT68v17HwRtVB/Sh3lfd0lfwPw
X-Received: by 2002:a17:902:f541:b0:2dd:ad73:c938 with SMTP id d9443c01a7336-2e842abebd7mr21168645ad.25.1791561634324;
        Fri, 09 Oct 2026 09:00:34 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([216.195.201.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cb6sm12333235ad.60.2026.10.09.09.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:00:33 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: sj@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	akpm@linux-foundation.org,
	lianux.mm@gmail.com,
	kunwu.chan@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/5] perf/core: add AUX buffer kernel-consumer API
Date: Fri,  9 Oct 2026 23:59:47 +0800
Message-ID: <20261009160010.1829642-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARM SPE and other tracing PMUs write records directly to perf AUX
buffers.  Unlike ordinary sampling PMUs, they do not necessarily
generate a perf_event_overflow() callback for each record.  A kernel
consumer therefore needs to drain the AUX buffer directly.

Userspace allocates AUX buffers through perf_event_open() and mmap().
Kernel consumers created through perf_event_create_kernel_counter()
currently lack an equivalent interface.

This series adds perf-core APIs for kernel consumers to allocate and
release AUX buffers, read the producer head, copy trace data, and
advance the consumer tail.  The APIs keep perf's internal page layout
private and follow the existing non-overwrite AUX ring-buffer
protocol.  Setup and release serialize buffer attachment and
detachment through event->mmap_mutex; consumers must quiesce before
releasing the buffer.

Patches 1-2 add the ownership, lifecycle, and access APIs.  Patches
3-5 add KUnit tests, a userspace AUX regression test, and a selftest
script.  The first consumer is a DAMON ARM SPE backend, but this
series is independent of DAMON and adds no consumer-specific policy
to perf.

Testing
=======

The series builds cleanly at each step.

arm64 (Kunpeng 920, 256 CPUs, SPEv1.1): built and booted the Image
from this series.  KUnit: pass:39 fail:0 skip:0.  The arm_spe_0
userspace regression test passed, and the AUX head advanced under
live SPE traffic.  Selftest script: 92 passed, 0 failed, 2 skipped.
perf record with arm_spe_0 captured data; dmesg showed no warnings.

x86_64 (vmlinux build, qemu/kvm): KUnit pass:39 fail:0 skip:0,
including KASAN and lockdep (PROVE_LOCKING); 15 repeated boots
produced no splats.  The Intel PT userspace regression test passed.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Changes since v1 [2]:

- Fix double-release in KUnit error cleanup and make the coexistence
  test cleanup failure-safe.
- Make failure-sensitive userspace test outcomes report SKIP rather
  than PASS, read the AUX head after event disable to observe flushed
  trace data, and pass the PMU name from the script to the C test.
- Fix the selftest script exit-status handling, remove the
  /usr/src/linux fallback, and handle Intel PT event modifiers.
- Remove an unnecessary smp_rmb() from the tail update path.

Changes since RFC [1]:

- Serialize AUX teardown under event->mmap_mutex and fix lifetime
  handling around ring_buffer_attach().
- Improve KUnit cleanup and concurrent-release coverage.
- Extend userspace and selftest coverage.
- Document AUX lifecycle, ordering, and cursor validation.

[1] https://lore.kernel.org/linux-perf-users/20260814144927.489172-1-kunwu.chan@linux.dev/
[2] https://lore.kernel.org/all/20261004173458.837842-1-kunwu.chan@gmail.com/


Kunwu Chan (3):
  perf/core: add AUX buffer ownership for kernel events
  perf/core: add AUX ring accessors for kernel consumers
  selftests/perf_events: add AUX kernel API selftest script

Lian Wang (2):
  perf/core: add KUnit tests for AUX kernel-consumer API
  selftests/perf_events: add userspace AUX regression test

 .../userspace-api/perf_ring_buffer.rst        |   62 +-
 include/linux/perf_event.h                    |   18 +
 kernel/events/Makefile                        |    1 +
 kernel/events/aux_kernel_test.c               | 1172 +++++++++++++++++
 kernel/events/core.c                          |  164 +++
 kernel/events/internal.h                      |    6 +
 kernel/events/ring_buffer.c                   |  212 ++-
 lib/Kconfig.debug                             |   14 +
 tools/testing/selftests/perf_events/Makefile  |    2 +
 .../selftests/perf_events/aux_kernel.sh       |  635 +++++++++
 .../perf_events/aux_kernel_usermode.c         |  645 +++++++++
 tools/testing/selftests/perf_events/config    |    2 +
 12 files changed, 2928 insertions(+), 5 deletions(-)
 create mode 100644 kernel/events/aux_kernel_test.c
 create mode 100755 tools/testing/selftests/perf_events/aux_kernel.sh
 create mode 100644 tools/testing/selftests/perf_events/aux_kernel_usermode.c


base-commit: 6350de8671b94afb7691d110f63bcda42f658a69
-- 
2.43.0

