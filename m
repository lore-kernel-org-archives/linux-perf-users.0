Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC36198E80;
	Tue, 16 Jul 2024 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721143563; cv=none; b=tB4i37VWTtW92guep+v498Sg4iAXxhifac4MZaUX4ruKqsR8zF8a+F0L3jqI3F54nAZ7jJBkIG2+zWxRIyoJ/ETc0z1e3Y25hwA2lowS5HZD9d4Smgg8b2h0yIfujsqQjOpkanrbfJjOZFEkJ+vHGavaafHQM4hqmbREl5PXjLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721143563; c=relaxed/simple;
	bh=NyCosBfwBy5qURWN5oLwWWXVmTmvgHrHdplxiITvdGs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l0DuwudnZDVquAZrt1R1wv/rg1OENoa22DfpuESjcF1afvtGw7QFZFlPGNk/qQbsj9ZeG8P+XuXjsgvzRFL9nhXEBgC/S7bJQQqNQV76zkt5e9wV2JnCDCYAmc0Zp4qdCZ45nf2ZjzpSfTID+ylLOJHRk2iOagSwaw7Zs5BF+O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvLG3EeZ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvLG3EeZ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3678aa359b7so4083234f8f.1;
        Tue, 16 Jul 2024 08:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721143559; x=1721748359; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QRQbAUYaJyWW8VZON0wQ1krgVOJA4xfPpn8BDRdEk5I=;
        b=GvLG3EeZGGJ59Sjh4sjbsGvoBNvbbaU2R23PSJpekVvy8E3WYTKX3luvGBcJm+yy5a
         MnRiq5Q+eSFNbZVbG2EIocXbw/NBqeWfEoIpKLZY6JkSGRAUXGecv1NIN31ge9EtuPwK
         t6Y/LMUNVCWrYFlNJdFONLQ6HeFlw9ZFQdpPWN1Z0EuwpSh3mRgKcxxmHhztbSY9gKFG
         xxp9GhpobfYo8bRrnUeoRvqYTIpyK33/iKhgS1SOjhykpPh6Cw+YFdo97QnBm645AOeG
         ms8PrYMCCpV41BU0RTTC3vm4pD/P+QMsqf33GoDQ3Uii93CQ4ECFzv1e+Qfmj1wXlKX7
         GPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721143559; x=1721748359;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRQbAUYaJyWW8VZON0wQ1krgVOJA4xfPpn8BDRdEk5I=;
        b=KeQdpp3SKOwErVfw59Tv2SNIXImY64zPjBcJIR4xecBoTwC6XEfp+bf88zVqrnOe3Q
         VW21hwAHkBA5sctswKAboJeuxEXePSH7BASp3jvc3LGbOLbxsmvu9iArQ0CQoNy7OXwL
         135jvIiAgUvahkf2eRBhhQJaxEgFzpkg9IRyMOhpRDx1NjuSjUcvoeuifVvWdiQLRL0p
         uJuctdXrEARjJkmJTb8ad6BeWiBXLibzXe2dLplLJdejlBVFDKthlncKHwxwusvxXrgh
         yHa8pcOayOxes6ZOPxbjatlBaCEIuaTHJDFiLaPkmNv5lTX17UPuqBBJkkCSoR5jIupm
         B44w==
X-Forwarded-Encrypted: i=1; AJvYcCWAk12Eeg0cxU9gePSnarXCBuBfwFKzfso1TXrbddC0QVAvhsZ+smVlnUusSasDLnethr7dLZfo6HW0n8i+TzpU6nOxQBD4fLuz1nKAWQ6Z/Q==
X-Gm-Message-State: AOJu0YwtvFSG7Ri47NVKZl8zhhEppaZ3pItztjWhXWq/v79z98QBIBn5
	Z0+BcSP6LLEzSKUiAWrZZ0U/ZBgu1zS1vU5ZXUF1+g9Rl3m7Tb3/
X-Google-Smtp-Source: AGHT+IHY5VQBXK/T70U4KltD63c54iBcQHHAUTnjOGkbAxdOS+c9uaO9+w/Z1ntTItQ/rydDeb0Exg==
X-Received: by 2002:adf:9591:0:b0:366:ee84:6a77 with SMTP id ffacd0b85a97d-36827356e6fmr1537181f8f.3.1721143559212;
        Tue, 16 Jul 2024 08:25:59 -0700 (PDT)
Received: from gmail.com (195-38-112-86.pool.digikabel.hu. [195.38.112.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f23cc5bsm164612415e9.2.2024.07.16.08.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 08:25:58 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 16 Jul 2024 17:25:56 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] Performance events changes for v6.11
Message-ID: <ZpaRBAgN9QLHJ8NZ@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2024-07-16

   # HEAD: fa0c1c9d283b37fdb7fc1dcccbb88fc8f48a4aa4 perf/x86/intel: Add a distinct name for Granite Rapids

Performance events changes for v6.11:

 - Intel PT support enhancements & fixes
 - Fix leaked SIGTRAP events
 - Improve and fix the Intel uncore driver
 - Add support for Intel HBM and CXL uncore counters
 - Add Intel Lake and Arrow Lake support
 - AMD uncore driver fixes
 - Make SIGTRAP and __perf_pending_irq() work on RT
 - Micro-optimizations
 - Misc cleanups and fixes

 Thanks,

	Ingo

------------------>
Adrian Hunter (6):
      perf/x86/intel/pt: Fix a topa_entry base address calculation
      perf/x86/intel/pt: Fix pt_topa_entry_for_page() address calculation
      perf: Fix perf_aux_size() for greater-than 32-bit size
      perf: Prevent passing zero nr_pages to rb_alloc_aux()
      perf: Fix default aux_watermark calculation
      perf: Make rb_alloc_aux() return an error immediately if nr_pages <= 0

Frederic Weisbecker (4):
      task_work: s/task_work_cancel()/task_work_cancel_func()/
      task_work: Introduce task_work_cancel() again
      perf: Fix event leak upon exit
      perf: Fix event leak upon exec and file release

Kan Liang (20):
      perf/x86/uncore: Save the unit control address of all units
      perf/x86/uncore: Support per PMU cpumask
      perf/x86/uncore: Retrieve the unit ID from the unit control RB tree
      perf/x86/uncore: Apply the unit control RB tree to MMIO uncore units
      perf/x86/uncore: Apply the unit control RB tree to MSR uncore units
      perf/x86/uncore: Apply the unit control RB tree to PCI uncore units
      perf/x86/uncore: Cleanup unused unit structure
      perf/x86/intel/uncore: Support HBM and CXL PMON counters
      perf/x86/intel: Support the PEBS event mask
      perf/x86: Support counter mask
      perf/x86: Add Lunar Lake and Arrow Lake support
      perf/x86/intel: Rename model-specific pebs_latency_data functions
      perf/x86/intel: Support new data source for Lunar Lake
      perf/x86: Add config_mask to represent EVENTSEL bitmask
      perf/x86/intel: Support PERFEVTSEL extension
      perf/x86/intel: Support Perfmon MSRs aliasing
      perf/x86/intel/uncore: Fix the bits of the CHA extended umask for SPR
      perf/x86/intel: Hide Topdown metrics events if the feature is not enumerated
      perf/x86/intel/ds: Fix non 0 retire latency on Raptorlake
      perf/x86/intel: Add a distinct name for Granite Rapids

Marco Cavenati (1):
      perf/x86/intel/pt: Fix topa_entry base length

Sandipan Das (2):
      perf/x86/amd/uncore: Avoid PMU registration if counters are unavailable
      perf/x86/amd/uncore: Fix DF and UMC domain identification

Sebastian Andrzej Siewior (7):
      perf: Move irq_work_queue() where the event is prepared.
      task_work: Add TWA_NMI_CURRENT as an additional notify mode.
      perf: Enqueue SIGTRAP always via task_work.
      perf: Shrink the size of the recursion counter.
      perf: Move swevent_htable::recursion into task_struct.
      perf: Don't disable preemption in perf_pending_task().
      perf: Split __perf_pending_irq() out of perf_pending_irq()

Uros Bizjak (1):
      perf/x86/amd: Use try_cmpxchg() in events/amd/{un,}core.c

Zhang Rui (3):
      perf/x86/intel/cstate: Fix Alderlake/Raptorlake/Meteorlake
      perf/x86/intel/cstate: Add Arrowlake support
      perf/x86/intel/cstate: Add Lunarlake support


 arch/x86/events/amd/core.c               |  28 +-
 arch/x86/events/amd/uncore.c             |  36 ++-
 arch/x86/events/core.c                   | 110 ++++----
 arch/x86/events/intel/core.c             | 426 ++++++++++++++++++++++++-------
 arch/x86/events/intel/cstate.c           |  39 ++-
 arch/x86/events/intel/ds.c               | 180 ++++++++++---
 arch/x86/events/intel/knc.c              |   2 +-
 arch/x86/events/intel/p4.c               |  10 +-
 arch/x86/events/intel/p6.c               |   2 +-
 arch/x86/events/intel/pt.c               |   4 +-
 arch/x86/events/intel/pt.h               |   4 +-
 arch/x86/events/intel/uncore.c           |  95 ++++---
 arch/x86/events/intel/uncore.h           |   8 +-
 arch/x86/events/intel/uncore_discovery.c | 312 ++++++++++++++--------
 arch/x86/events/intel/uncore_discovery.h |  22 +-
 arch/x86/events/intel/uncore_snbep.c     | 134 ++++++++--
 arch/x86/events/perf_event.h             |  98 ++++++-
 arch/x86/events/zhaoxin/core.c           |  12 +-
 arch/x86/include/asm/intel_ds.h          |   1 +
 arch/x86/include/asm/msr-index.h         |   6 +
 arch/x86/include/asm/perf_event.h        |   8 +
 include/linux/perf_event.h               |  11 +-
 include/linux/sched.h                    |   7 +
 include/linux/task_work.h                |   4 +-
 include/uapi/linux/perf_event.h          |   6 +-
 kernel/events/callchain.c                |   2 +-
 kernel/events/core.c                     | 125 +++++----
 kernel/events/internal.h                 |   6 +-
 kernel/events/ring_buffer.c              |   7 +-
 kernel/irq/manage.c                      |   2 +-
 kernel/task_work.c                       |  58 ++++-
 security/keys/keyctl.c                   |   2 +-
 32 files changed, 1258 insertions(+), 509 deletions(-)
