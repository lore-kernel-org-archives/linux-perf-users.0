Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12FF395DAA
	for <linux-perf-users@vger.kernel.org>; Sun, 16 Aug 2026 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786890161; cv=none; b=C0MFr7IAV7VVWJ8ZVcHqDX5UhVWiVflHEJF/ZuP/FDpFuJhZxvy9FyoM5bqx2d4Oa/QwrCROHUwNV4mB2h175CJHMrCBUkjUS7c6Syc9I39AGwPZV0NpTs3t0OnoyWWJ3B5ewfNsIXyrAzhcRLDwROX+NxmexMk7HJ/4yixf5PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786890161; c=relaxed/simple;
	bh=4X804/qrz0myQkryLvzzCj1bLMSszCuQ0/f+xd3bVww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=USKsR8h0oJSDvoFtuGeP0FV8kA/8L7ht+CplzWboIy54cZ99U2238cRgwgfd18PvcIVRWoutTpUWJ07IUwX2WUhHT9I3R12GndojxFGzv4R54vw7WCIuEY6bSrHjQaZik1cfpXT9hXHrmDDoiTl9qXGIjqDg8QQZBU4kO5rJz+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hj1lW7LI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hj1lW7LI"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso27727895ad.2
        for <linux-perf-users@vger.kernel.org>; Sun, 16 Aug 2026 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786890158; x=1787494958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XsGCXFozT69ITA4eF1crVo3PlInrHxlGF6a27uOAn/o=;
        b=hj1lW7LI26I64h6ti9xd1KxaqgRuJ3V+8p6z9KvdfsfU1PbBwS0dDtBg+6++O9uj6V
         2hOqU06ByT/97M62gIQ83klCbfcIXibVN18qMBE78sQqkyznoHhdSiuhwFoegOhOJ8TS
         ZoncY1jDJ5e8ck/RVFC9k4C9jB962K2KkKjVq3VXzhBFDDsPphB+1JTi3gDcrdajLKj8
         cslMfo4f2e4z6WwxL6JIJFMRMP3mGTa6xWyAbW2JHAy+bx4N2jAau2seo7wNbvSePJEk
         hUQA42qs6iVtYGHiL3DqvKPWOAYis/PfGzc1pDFaLgx4IIYJX3zjk6RVmiMkNsOv15gZ
         M1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786890158; x=1787494958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XsGCXFozT69ITA4eF1crVo3PlInrHxlGF6a27uOAn/o=;
        b=jWZNhguAPXs1zlhAAPLEeinKcwgmswPFrCeC2VLGBPrkSRdYcViVnsysi7vgIwQ/kF
         u79uyAOk9AeswRQWlfBJSH45QI69jPEq5Rn7IKzH/lxaPrB8E/oFgm7Jc4HIatxyQviz
         py79I2HoXrmu/E5sNse0yaR7Yr358bGa7jhOkwcenWRknHlOEEuEW6hKxipXRrRqCV4k
         wdODgXB1ex0tMcbKcFlXwVgwRvkAD4ApSQkb6LipCGALXspLNtmULsBnzynQzC2e379G
         1+uwe9JRXyFTKztwjWk5G9Vi/kuuv8/Q1FM/jjRgl0QC0F46B8vW1Z9hXSgWPw8jcztP
         CQiQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq+n8v7sg1wLQAa4UdDbOJxbPuCREqgI86yyOEd9ySJJ/rMsc/bFnywyIF2ep4QfaoTz+hbV4ZG1y5a4sgurwip@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5bRbt4hiQsfjlf95U7Ew3nwQYuQCliqBKBkD6i1EQIb3RszTQ
	2G44JqT7XMn9bvZtHIfHBU2xaChGDUeTK84cg5DgkjDkc2pbVKvm8gRH
X-Gm-Gg: AR+sD1140hTHqf6dXNUUZiy58qCXT1HMP1NI3AEmSbR1uS+KV9hLhmnpHPJEltxYolI
	CS94vBnLPqgtFmDSOcH9PlchO7xQlgXW6lqMNh0TGLSTYtLV4mX5nxCXLN2EChHbyu0+AVuqORf
	wDa4fNEbA5DnCqr57JmhmxbY0pOHWecoq/71TPvHttrz0GyuO7UTheuQGr0eTkQM/CLgh2x6fGV
	rvJJm9SFt/g3ZR5nAWSCRmVHU0wI2usHdHVieaTQqMfbDrkQZcL7XRc/kcKblmRt/lrIoAiE+8n
	CqqIAwvSpSHulQZ8zZIXKpTfKKWmNss8R54CM1AFeLFQqi4rk7T94ZOj3D3qZG1pL2OWv21cAYh
	jN8WIN0MhcQmhYPpb/R/nkCNe2MaTRPQjVoW5UgBT4UGbrJcQvSVQkItVwLZCtllmNypEHvtnv6
	dw2s9SwnHrp0ZvkQ84edwxXFraCKy+32vnEEIOn+vlBAxCVclfakM9CEc8Cu+TNcszMPhV6W9wX
	nIDdGUG53ibycy2MzY=
X-Received: by 2002:a17:902:da82:b0:2cc:777f:d67c with SMTP id d9443c01a7336-2d3b0d5ed01mr190367395ad.13.1786890157697;
        Sun, 16 Aug 2026 07:22:37 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aebc8199sm26102365ad.74.2026.08.16.07.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 07:22:36 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: will@kernel.org,
	mark.rutland@arm.com,
	sj@kernel.org,
	akpm@linux-foundation.org,
	shuah@kernel.org,
	kunwu.chan@linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [RFC PATCH 0/4] mm/damon/perf: add ARM SPE AUX backend
Date: Sun, 16 Aug 2026 22:22:17 +0800
Message-ID: <20260816142222.689624-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

This series adds an AUX trace-buffer backend to the DAMON perf
observability framework, enabling ARM SPE (Statistical Profiling
Extension) to deliver hardware-sampled access reports into DAMON's
existing SPSC report ring.

Patch 2 touches drivers/perf/arm_spe_pmu.c to expose the PMU matcher.
This change is tightly coupled with the DAMON AUX backend.  ARM SPE
PMU driver maintainers only need to review patch 2.

This series is based on the Ravi's hardware-sampled access reports 
branch [1], and depends on the perf AUX kernel-consumer RFC series [2].
The dependencies is not upstream yet, so this series remains RFC.

Why a dedicated AUX backend
---------------------------
ARM SPE and similar PMUs do not deliver samples through the standard
perf overflow callback.  Instead, they write trace data into an AUX
buffer managed by the perf core.  The AUX buffer is consumed from
process context (kdamond) rather than from NMI, so the existing
overflow-callback path in DAMON cannot be reused.

The backend model adds three operations to the damon_perf_event
lifecycle: init (allocate the AUX buffer), arm (position the consumer
cursor), and drain (parse the SPE packet stream and publish reports).
The backend is selected at event creation time by matching the PMU
object via its event_init callback.

What the series adds
--------------------
Patch 1 introduces the backend operations table, the backend state
fields in damon_perf_event, and the Kconfig options.  ARM SPE must be
built into the kernel; the KUnit test option is separate.

Patch 2 is the ARM SPE backend.  It owns a per-CPU AUX buffer,
decodes the SPE packet stream (the same encoding that perf's
userspace arm-spe-decoder handles), resolves sampled
CONTEXTIDR_EL1 values to tgids under RCU, and publishes synthesized
access reports.  The drain runs before the SPSC ring consumer on
each monitoring interval, and a final drain after event disable
ensures no records are lost.  The backend also modifies the ARM SPE
PMU driver to expose arm_spe_pmu_match() for PMU object matching.

Patch 3 adds byte-exact KUnit tests for the SPE record parser.  The
tests cover load and store records, timestamp terminators, multiple
records in one window, PAD and ALIGNMENT packets at both odd and
aligned positions, extended addresses, bad-packet resynchronization,
truncated records, and records without a virtual address.  A split-
record test verifies that a record spanning two AUX snapshots leaves
the tail unchanged until the terminating packet arrives.

Patch 4 adds a DAMON selftest for the AUX backend.  It checks the
backend integration, the required AUX-before-ring lifecycle ordering,
runs the parser KUnit suite through debugfs, and on an ARM SPE system
creates a live DAMON session with a controlled userspace target,
verifying positive end-to-end pipeline counters and final
enqueue/dequeue closure.

Testing
=======
Tested on Kunpeng 920 (256 CPUs, ARM SPE, kernel 7.1.0-rc5-mm-new-damon+):

  ARM SPE KUnit (spe_parse_one_record):
    16 passed, 0 failed, 0 skipped
    (store record, load record with timestamp, two records, pad-wrapped,
     alignment at odd/aligned positions, bad packet resync, record without
     address, events/source/counter, truncated record retained, truncated
     packet retained, extended address, invalid extended header, pad-only,
     empty window, split record across two snapshots)

  AUX selftest (damon_perf_aux_test.sh arm_spe_0):
    SUMMARY: 52 passed, 0 failed, 0 skipped (Overall PASS)
    callback=58318, valid=58318, enqueue=43390, dequeue=43390,
    match=34049, update=564
    final ring closure: enqueue=43390 dequeue=43390

Known limitations
=================
- AUX_BACKEND_MAX=4: the AUX backend registration table holds at most 4
  backend types.  This is a framework limit, not a per-PMU-instance cap.

- ARM SPE must be built into the kernel (ARM_SPE_PMU=y), not as a
  module, because the backend calls arm_spe_pmu_match() at initcall
  time.

- The AUX buffer is 2 pages (8 KiB).  The SPE hardware pauses when the
  non-overwrite ring is full; the drain frees space and re-enables
  the event.

- CONTEXTIDR_EL1 carries the sampled task's pid, resolved to tgid
  under RCU.  Records without a valid tgid are dropped.

- This series requires the perf AUX kernel API patches [2] to be applied
  first.  These patches are not yet upstream and must be reviewed by the
  perf subsystem maintainers.

References
==========
Link [1]: https://github.com/damonitor/linux.git
          branch: ravi_hw_sampled_access_reports_rfc_v1
          commit: fd968106e5bf

Link [2]: https://lore.kernel.org/all/20260814144927.489172-1-kunwu.chan@linux.dev/
          perf AUX kernel API PATCH Series:
          - perf/core: add AUX buffer ownership for kernel events
          - perf/core: add AUX ring accessors for kernel consumers
          - perf/core: add KUnit tests for AUX kernel-consumer API
          - selftests/perf_events: add userspace AUX regression test
          - selftests/perf_events: add AUX kernel API selftest script


Kunwu Chan (2):
  mm/damon/perf: introduce AUX backend interface and Kconfig
  mm/damon/perf: add AUX trace-buffer PMU backend for ARM SPE

Lian Wang (ProcessMission) (2):
  mm/damon/perf: add KUnit tests for the SPE record parser
  selftests/damon: add DAMON perf AUX backend test

 drivers/perf/arm_spe_pmu.c                    |   8 +
 include/linux/damon.h                         |   5 +
 include/linux/perf/arm_spe_pmu.h              |  11 +
 mm/damon/Kconfig                              |  28 +
 mm/damon/core.c                               |  22 +-
 mm/damon/ops-common.h                         |   6 +-
 mm/damon/perf/Makefile                        |   5 +
 mm/damon/perf/aux_backend.c                   | 121 +++++
 mm/damon/perf/aux_backend.h                   |  72 +++
 mm/damon/perf/spe_backend.c                   | 479 ++++++++++++++++++
 mm/damon/perf/spe_parser.h                    | 109 ++++
 mm/damon/perf/spe_parser_test.c               | 365 +++++++++++++
 mm/damon/vaddr.c                              |  68 ++-
 tools/testing/selftests/damon/Makefile        |   1 +
 .../selftests/damon/damon_perf_aux_test.sh    | 414 +++++++++++++++
 15 files changed, 1704 insertions(+), 10 deletions(-)
 create mode 100644 include/linux/perf/arm_spe_pmu.h
 create mode 100644 mm/damon/perf/aux_backend.c
 create mode 100644 mm/damon/perf/aux_backend.h
 create mode 100644 mm/damon/perf/spe_backend.c
 create mode 100644 mm/damon/perf/spe_parser.h
 create mode 100644 mm/damon/perf/spe_parser_test.c
 create mode 100755 tools/testing/selftests/damon/damon_perf_aux_test.sh

-- 
2.43.0

