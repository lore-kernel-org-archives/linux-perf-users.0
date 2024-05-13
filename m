Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712A34C81;
	Mon, 13 May 2024 06:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715581132; cv=none; b=eSuBbIwFZ5nn5MqL5lz8jCT3qHH2O8EmWU7choRIRuoU/XoPxygKjDCsysB38DiLviQpY3gs9sBI5raWHGVH9UtBEsm2KyntyUvh8kYUHjJ1uBk9kSCUylhr9DWofWnIRAg3aopaMd63CH4UJhFsiGG4RxTnUoU9edSkuUttryE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715581132; c=relaxed/simple;
	bh=Gk6VmF76HZLrQGn1rjBPIIo3n7MlZgoUBYdttRsR1Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y6LQqw9ZDN7SUH8+HHKEdNynNc0F+/2ysHgOsH581cs0gum1r5f9NJuHX2qCft+xaxOxKfl3/YOdfr4kTde+QxAsHrvWIPHx3O/WrfqN8+AXMVCHjgJQmWbegly4A+BfgDrHUwmanUVG8Au82rTC1by+Fy/wxYOsOsoZYBMSfc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJ4jhPM2; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJ4jhPM2"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59a609dd3fso676299466b.0;
        Sun, 12 May 2024 23:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715581129; x=1716185929; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bpNCHKdi23YsbMpYSlsHEWAO9h6Qj7cZkm3c+kyT6U0=;
        b=LJ4jhPM2TJ5t0AVkS4nIe6AXcXQrj/mNDw7NHhWNOK1C8U9t7AFJAOmruuhLrwK+e/
         Zx2QEQqN3SkSD6EW/I8saUdpD+ezRY/ypNZwjhxy2s9RzxED0xs7bKopvFnBCinaZTRN
         +2kph3jtVb2s54D2OHqPqryuaR1hofmsbYtMBewy4IxOjhj3DnWb7UYGeMaSmyQKm2o4
         orOy3mbkGVWJq3kZtaKXyfTJQNxo7X7TJqAPq5NlZJ8ZeD28ox5ZPEhDA40hc0DoMejQ
         xEq82IG4YQsNCQV5up0mZkItlFmDo4HxTGinucj35KJtDIsRl5uAgknUfu1ZJxx+xRFr
         nRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715581129; x=1716185929;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpNCHKdi23YsbMpYSlsHEWAO9h6Qj7cZkm3c+kyT6U0=;
        b=g1B+G+4MIk51PC63utzcsIx0wCIJpe8TyHXgGodurAQbowYf7dU65u22g3ZqaQ7PAY
         482RG7M8yydUFBFQkZZGUc12dhEze87OzgU5Mf9q8QuZ6W615KLHoi9Cd8i3hmPsKlLg
         M7dUsur1QfDOyMzfXVQX7uUrml/ILEm4R1jwOCnIGzR5dXw+Y/hYDEsFpveDjSDymBJr
         p0z/wefUBVMwFFt3coy8MJLMdzgb5/w4K5YBpKXHWeoNJfsxkNawato6okiCSJFIdb66
         mmTcAWKBB1D/Sb04tiLRA6/JUY7hak9VmN7+66Ylp9+4j2hyNs0N2Hno0KGwbUpyghO9
         LIFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZdnonsIwNpHKdrItfAZIPAigK/pgG+cdY7V1jOhxiaHc7Bgm0M+ufhjq+ZzHS1s6JrQ3QdnTQjGonRqoxl7kCIKHLZ0xSTtnNENXkYiM1RA==
X-Gm-Message-State: AOJu0Yzh9CEulg6j+nHYMLfi2EjN2NLR3fZme2NkA/uAKJsRYIDlFSZ4
	WxPsHZ0xqf7sU/WZiDLsbx3GP22WSDBzTua+NaYY1fw8IpTzdYG+BAvNOm6R
X-Google-Smtp-Source: AGHT+IGvN97uv+5VPVcETjyuwMmfCu+pxWUP44myWRmk86L98LzT78rLxDiKUAaoRfc3CXxx3yxvjw==
X-Received: by 2002:a17:906:7748:b0:a59:92b0:e0d3 with SMTP id a640c23a62f3a-a5a118c5393mr849555566b.34.1715581128347;
        Sun, 12 May 2024 23:18:48 -0700 (PDT)
Received: from gmail.com (1F2EF402.unconfigured.pool.telekom.hu. [31.46.244.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a174bdfa1sm547022766b.0.2024.05.12.23.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 23:18:47 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 13 May 2024 08:18:45 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] Performance events changes for v6.10
Message-ID: <ZkGwxW0JArbudf/+@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest perf/core Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2024-05-13

   # HEAD: 854dd99b5ddc9d90e31e5f112462a5994dd31810 perf/bpf: Mark perf_event_set_bpf_handler() and perf_event_free_bpf_handler() as inline too

Perf events changes for v6.10:

 - Combine perf and BPF for fast evalution of HW breakpoint
   conditions.

 - Add LBR capture support outside of hardware events

 - Trigger IO signals for watermark_wakeup

 - Add RAPL support for Intel Arrow Lake and Lunar Lake

 - Optimize frequency-throttling

 - Miscellaneous cleanups & fixes.

 Thanks,

	Ingo

------------------>
Andrii Nakryiko (4):
      perf/x86/amd: Ensure amd_pmu_core_disable_all() is always inlined
      perf/x86/amd: Avoid taking branches before disabling LBR
      perf/x86/amd: Support capturing LBR from software events
      perf/x86/amd: Don't reject non-sampling events with configured LBR

Erick Archer (1):
      perf/x86/rapl: Prefer struct_size() over open coded arithmetic

Ingo Molnar (2):
      perf/bpf: Change the !CONFIG_BPF_SYSCALL stubs to static inlines
      perf/bpf: Mark perf_event_set_bpf_handler() and perf_event_free_bpf_handler() as inline too

Kyle Huey (10):
      perf/bpf: Reorder bpf_overflow_handler() ahead of __perf_event_overflow()
      perf/bpf: Create bpf_overflow_handler() stub for !CONFIG_BPF_SYSCALL
      perf/bpf: Remove #ifdef CONFIG_BPF_SYSCALL from struct perf_event members
      perf/bpf: Call BPF handler directly, not through overflow machinery
      perf/bpf: Remove unneeded uses_default_overflow_handler()
      perf/bpf: Allow a BPF program to suppress all sample side effects
      selftest/bpf: Test a perf BPF program that suppresses side effects
      perf: Move perf_event_fasync() to perf_event.h
      perf/ring_buffer: Trigger IO signals for watermark_wakeup
      selftests/perf_events: Test FASYNC with watermark wakeups

Namhyung Kim (2):
      perf/core: Optimize perf_adjust_freq_unthr_context()
      perf/core: Reduce PMU access to adjust sample freq

Zhang Rui (2):
      perf/x86/rapl: Add support for Intel Arrow Lake
      perf/x86/rapl: Add support for Intel Lunar Lake


 arch/arm/kernel/hw_breakpoint.c                    |   8 +-
 arch/arm64/kernel/hw_breakpoint.c                  |   4 +-
 arch/x86/events/amd/core.c                         |  37 ++-
 arch/x86/events/amd/lbr.c                          |  13 +-
 arch/x86/events/perf_event.h                       |  13 +
 arch/x86/events/rapl.c                             |   7 +-
 include/linux/perf_event.h                         |  37 ++-
 kernel/events/core.c                               | 273 +++++++++++----------
 kernel/events/ring_buffer.c                        |   4 +
 tools/testing/selftests/bpf/prog_tests/perf_skip.c | 137 +++++++++++
 tools/testing/selftests/bpf/progs/test_perf_skip.c |  15 ++
 tools/testing/selftests/perf_events/.gitignore     |   1 +
 tools/testing/selftests/perf_events/Makefile       |   2 +-
 .../selftests/perf_events/watermark_signal.c       | 146 +++++++++++
 14 files changed, 525 insertions(+), 172 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_skip.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_perf_skip.c
 create mode 100644 tools/testing/selftests/perf_events/watermark_signal.c
