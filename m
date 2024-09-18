Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B803C171E65;
	Wed, 18 Sep 2024 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726663546; cv=none; b=ksqMz1nepe+DkXVPOD+yNkL13PFhNhwi/QuCN7mFmxI+P1ViWyKEpc1VHLCbbCH8ANk4lfayzEHix4ok0l16JvBpL1Ue3zVeDqw90x14E2P4tk6t33rzE4jCdC2RyNvnz0mI5totIkM2tzGO4/AlAQMp8h/NspoisFUcUbHCuvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726663546; c=relaxed/simple;
	bh=fXyJ35SpCN1FAyPpXAOSyhzad64jsNoR7VARAS9JzD0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DLAoNmslTX/l6P8EL8OV1JpUT3seminoLjNDjem+TZWy7qs+lvOMAhwrgJ/JF5wQdkIiBfcLBfsOh3rdUjMR5FBqfqvZ9PPr4HtxLqZgyAKZyROIrnq/vJ6jaAQ+gR2XvRUfEZjyWqyYDEpA90srjfTOuA+d/1BWCCwMvxzLv4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMWqwqzv; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMWqwqzv"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374bd0da617so4679956f8f.3;
        Wed, 18 Sep 2024 05:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726663543; x=1727268343; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=g7pZC+UJuqikd0Axulm78T5NX2CLY7JbLTeL64mHdJY=;
        b=WMWqwqzvKKXCkL+SlSok0OWh09skzRf1vE4z4Rs7+kOYOd+0V/0DYp4IdI+UUnga6o
         r1gJ9jTPSslXXdCZgpDg9L0zzKb2vSje9/niEnAOze6WVr1oorGM98RS+gIKUubm28Y/
         5b0/OnNHhha/5jkblEGceIQsQuU5Z4GoLPSO4Wng1y3WDBER5JWmCOta13DG+3JnYG5H
         nmDvy/43x2qk5kJYSqguTx6ABQ3LK3dkWEKLenDSYW7dk5IJx38DkiJYvlXZW630wOJU
         yOJq2s5K5dWicd6wZgtFZGd5ZcXhMevPvyCk1alIEw2mxYYss6j6dpp8NEJWe1+idYBt
         N7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726663543; x=1727268343;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7pZC+UJuqikd0Axulm78T5NX2CLY7JbLTeL64mHdJY=;
        b=RNqUDtQf47S/cYunGFpJX56Z/qJa6N0vaeSBKxNntCqc4Iz9xQFaqLl6JM5tvkKh+S
         fic8FzGtHAsEtr4fgql/6fnvVKcgXER1Y6DCvN/JZiUV8WXUQx8tXzECxjuS0ns7zxaI
         Bm5WOgMqi9sPdhuIyiSZjQxtKzJNaDk7AW9u8HXk1i4HhmmHlnFBWFI5h5lzR66HW4VS
         vv4mLCZrikJfKaQ3vbBZYOu8Ptn18OfVDeIgNFSA7SNEPVnGvqHFUYVnyl4Vk2oWhvyA
         gZCX1Ssljkc6i1MmoocP/0N+xRlkaCo04LDLnDmaf+1jjKNFGw0XcPSepWDN5M/OLrDl
         aR3w==
X-Forwarded-Encrypted: i=1; AJvYcCXsDlLsc7yscVHsWD61DVnSwzaI8nPGf9hwRDhk5u22MS4SD7zAVuXELdftYtu3BIDLebwSU3nBSCD25ix+pdJV@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlzrv1dGNgVnMgi+DvdEQj3U55LDFCyuAU+biOJtoHbF97tYGL
	lcQxC5cFOLPHdhzWZPg7Nf9Q0fzofvhKDWfN4YmRrI2I5jKD0aUD
X-Google-Smtp-Source: AGHT+IGBX0KUDMIr/jZbBuayUPel3GWDws49CvNTuYKEyrH1HqVlYiuTSb+I7bXF2LysNJXWIzU6ww==
X-Received: by 2002:a5d:4dc2:0:b0:371:8e8b:39d4 with SMTP id ffacd0b85a97d-378c2d026eamr14060520f8f.28.1726663542376;
        Wed, 18 Sep 2024 05:45:42 -0700 (PDT)
Received: from gmail.com (1F2EF419.nat.pool.telekom.hu. [31.46.244.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e704f261esm16161805e9.26.2024.09.18.05.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 05:45:41 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 18 Sep 2024 14:45:39 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] Performance events changes for v6.12
Message-ID: <ZurLc9qEjBH9MkvK@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2024-09-18

   # HEAD: 5e645f31139183ac9a282238da18ca6bbc1c6f4a Merge branch 'perf/urgent' into perf/core, to pick up fixes

   [ Merge note: this pull request depends on you having pulled perf-urgent-2024-09-18 already. ]

Performance events changes for v6.12:

 - Implement per-PMU context rescheduling to significantly improve single-PMU
   performance, and related cleanups/fixes. (by Peter Zijlstra and Namhyung Kim)

 - Fix ancient bug resulting in a lot of events being dropped erroneously
   at higher sampling frequencies. (by Luo Gengkun)

 - uprobes enhancements:

     - Implement RCU-protected hot path optimizations for better performance:

         "For baseline vs SRCU, peak througput increased from 3.7 M/s (million uprobe
          triggerings per second) up to about 8 M/s. For uretprobes it's a bit more
          modest with bump from 2.4 M/s to 5 M/s.

          For SRCU vs RCU Tasks Trace, peak throughput for uprobes increases further from
          8 M/s to 10.3 M/s (+28%!), and for uretprobes from 5.3 M/s to 5.8 M/s (+11%),
          as we have more work to do on uretprobes side.

          Even single-thread (no contention) performance is slightly better: 3.276 M/s to
          3.396 M/s (+3.5%) for uprobes, and 2.055 M/s to 2.174 M/s (+5.8%)
          for uretprobes."

          (by Andrii Nakryiko et al)

     - Document mmap_lock, don't abuse get_user_pages_remote(). (by Oleg Nesterov)

     - Cleanups & fixes to prepare for future work:

        - Remove uprobe_register_refctr()
	- Simplify error handling for alloc_uprobe()
        - Make uprobe_register() return struct uprobe *
        - Fold __uprobe_unregister() into uprobe_unregister()
        - Shift put_uprobe() from delete_uprobe() to uprobe_unregister()
        - BPF: Fix use-after-free in bpf_uprobe_multi_link_attach()

          (by Oleg Nesterov)

 - New feature & ABI extension: allow events to use PERF_SAMPLE READ with
   inheritance, enabling sample based profiling of a group of counters over
   a hierarchy of processes or threads.  (by Ben Gainey)

 - Intel uncore & power events updates:

      - Add Arrow Lake and Lunar Lake support
      - Add PERF_EV_CAP_READ_SCOPE
      - Clean up and enhance cpumask and hotplug support

        (by Kan Liang)

      - Add LNL uncore iMC freerunning support
      - Use D0:F0 as a default device

        (by Zhenyu Wang)

 - Intel PT: fix AUX snapshot handling race. (by Adrian Hunter)

 - Misc fixes and cleanups. (by James Clark, Jiri Olsa, Oleg Nesterov and Peter Zijlstra)

Thanks,

	Ingo

------------------>

Adrian Hunter (1):
      perf/x86/intel/pt: Fix sampling synchronization

Andrii Nakryiko (7):
      perf,x86: avoid missing caller address in stack traces captured in uprobe
      uprobes: simplify error handling for alloc_uprobe()
      uprobes: revamp uprobe refcounting and lifetime management
      uprobes: protected uprobe lifetime with SRCU
      uprobes: get rid of enum uprobe_filter_ctx in uprobe filter callbacks
      uprobes: travers uprobe's consumer list locklessly under SRCU protection
      uprobes: perform lockless SRCU-protected uprobes_tree lookup

Ben Gainey (2):
      perf: Rename perf_event_context.nr_pending to nr_no_switch_fast.
      perf: Support PERF_SAMPLE_READ with inherit

Ingo Molnar (2):
      Merge branch 'perf/urgent' into perf/core, to pick up fixes
      Merge branch 'perf/urgent' into perf/core, to pick up fixes

James Clark (1):
      perf/x86/intel/bts: Fix comment about default perf_event_paranoid setting

Jiri Olsa (1):
      selftests/bpf: fix uprobe.path leak in bpf_testmod

Kan Liang (8):
      perf/x86/intel/uncore: Add Arrow Lake support
      perf/x86/intel/uncore: Factor out common MMIO init and ops functions
      perf/x86/intel/uncore: Add Lunar Lake support
      perf: Generic hotplug support for a PMU with a scope
      perf: Add PERF_EV_CAP_READ_SCOPE
      perf/x86/intel/cstate: Clean up cpumask and hotplug
      iommu/vt-d: Clean up cpumask and hotplug for perfmon
      dmaengine: idxd: Clean up cpumask and hotplug for perfmon

Luo Gengkun (1):
      perf/core: Fix small negative period being ignored

Namhyung Kim (1):
      perf: Really fix event_function_call() locking

Oleg Nesterov (8):
      uprobes: document the usage of mm->mmap_lock
      uprobes: is_trap_at_addr: don't use get_user_pages_remote()
      uprobes: kill uprobe_register_refctr()
      uprobes: make uprobe_register() return struct uprobe *
      uprobes: change uprobe_register() to use uprobe_unregister() instead of __uprobe_unregister()
      uprobes: fold __uprobe_unregister() into uprobe_unregister()
      uprobes: shift put_uprobe() from delete_uprobe() to uprobe_unregister()
      bpf: Fix use-after-free in bpf_uprobe_multi_link_attach()

Peter Zijlstra (8):
      perf/x86: Add hw_perf_event::aux_config
      perf: Optimize context reschedule for single PMU cases
      perf: Extract a few helpers
      perf: Fix event_function_call() locking
      perf: Add context time freeze
      perf: Optimize __pmu_ctx_sched_out()
      perf/uprobe: split uprobe_unregister()
      rbtree: provide rb_find_rcu() / rb_find_add_rcu()

Zhenyu Wang (2):
      perf/x86/intel/uncore: Add LNL uncore iMC freerunning support
      perf/x86/intel/uncore: Use D0:F0 as a default device

 arch/x86/events/core.c                                |  63 +++++++++++++++++++
 arch/x86/events/intel/bts.c                           |   3 -
 arch/x86/events/intel/cstate.c                        | 142 ++-----------------------------------------
 arch/x86/events/intel/pt.c                            |  29 +++++----
 arch/x86/events/intel/uncore.c                        |   9 +++
 arch/x86/events/intel/uncore.h                        |   2 +
 arch/x86/events/intel/uncore_snb.c                    | 185 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 drivers/dma/idxd/idxd.h                               |   7 ---
 drivers/dma/idxd/init.c                               |   3 -
 drivers/dma/idxd/perfmon.c                            |  98 +-----------------------------
 drivers/iommu/intel/iommu.h                           |   2 -
 drivers/iommu/intel/perfmon.c                         | 111 +---------------------------------
 include/linux/cpuhotplug.h                            |   2 -
 include/linux/perf_event.h                            |  32 +++++++++-
 include/linux/rbtree.h                                |  67 +++++++++++++++++++++
 include/linux/uprobes.h                               |  48 ++++++++-------
 kernel/events/core.c                                  | 586 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------
 kernel/events/uprobes.c                               | 505 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------------------
 kernel/trace/bpf_trace.c                              |  38 ++++++------
 kernel/trace/trace_uprobe.c                           |  44 +++++++-------
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c |  27 +++++----
 21 files changed, 1146 insertions(+), 857 deletions(-)
