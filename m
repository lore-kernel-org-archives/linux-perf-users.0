Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA2D4414
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643152; cv=none; b=oBF92qcFtP7vRxyPglVvjyZ6D5ix/MecScX1Fjbm6fkI4n3kzYcZEzQQsh8nsINWcD6oP36OsVMjftDzPgbvtNcMnbQ6CnYL2Ceh8kKf1r0IkGkM78EDVtrW8zN0J/UZywSdEBbQghvae9fD4L9rLwAaMiOkknB8Vkq80balEuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643152; c=relaxed/simple;
	bh=vMvZXZT1M5wLPCdrPFvsVuR1bsem/aXlwZguHGKZAgg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SvBfyV3SLkdbn6ddTjYKrd6OJ7lwTZf/YtOimM14s/IvVYG04twQiq/Z77y3Q1B8n/3YL/zuVbsrkJwaSFbEHxCw+O+OHhCfKp9s39lL2cCyjE4N9Hw3AdysgPl5jPEyxdG4szcJUKdAV7ifZUCzOoz8LUjUJzGte0pb8bC76us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UGqexBZY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UGqexBZY"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42795086628so29122425e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 03:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721643149; x=1722247949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tvIqnYuZYV2/+xYtsXtoYvUIcyIYgJiQLbfJZw43cls=;
        b=UGqexBZYwtAJdIytLHRgWKC/3UoEbewd4uV99x2Zr8qXBHlTFZloohnbw5TEX4ly60
         Te62XjZAgDNa6Bn0DCR+VlGf+tZKo54Ga0IxcEY0/HLQG1pCHAQWY6wg/DEuMpeCQzly
         WEjb05Ob5fW5JqLou8AAf2L/GaiszbCvuJbvb9BKOxcAJmDYliaQYm/yj/5kQyxhnj4R
         2i6eq0LfYFuOmoD0/gyCxuofh0xl3gktUVMvtKVfe/ClQu3WLc5qcXXeSs5KpdDl8dlr
         C4xRAAwHltAh9PqkVSsO1J6rna4oSdkp1iusXLH+C5/0QplouCnCZg6TFAhL0GRmwdnJ
         FgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721643149; x=1722247949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tvIqnYuZYV2/+xYtsXtoYvUIcyIYgJiQLbfJZw43cls=;
        b=Dr6OFNdCKRClkTV4ekdoY4Nkf7Q5pfijwv29DcuGhE+nuzTtd+SUnWM+ahJ+gkyS6j
         G84HY/ToEoHVWhVUwQLuJFY2Fv29eF6/hY/TOoCvaQdUvUvc3L6FTxqDn0csibcntEBe
         GzdW0gZCrlB2zFOdSt7Ld1sR0bVxZDUsktlHTv+jDkpokOYo0reVP8fvRgQpFBrcE2lK
         gpIGQ8WTyZQYB6FBSW98X8xDvnzk0cTAjyBPFNmlU84c9OmrQ3z5LZ/A2UFDlHUav9bQ
         E8ah7X8iXJhL4h457ohpFBVZWNRXIi2qi/qsToyQnsQthjzLCmBoRjlBSdjWgjnqCPHS
         5eDw==
X-Forwarded-Encrypted: i=1; AJvYcCWieSNwlvtk2Jb/++Hk/y7N0vQJSQaTrqSFM9GjDWScG628bmjtQhfMPF0mL1fxdddWmO29JL/x8mqb8xYlUYu//FmLUE3ItMSOG5UkzAITVQ==
X-Gm-Message-State: AOJu0Yy4dfDQtD6/0XPnHpCmJ95tOXFQL9ye3g07vMtkXUZ6mPk1cAPg
	FUoOnXivlokwy6UXv49jt6MWxnSIaBdK4q6MPA8rD8UxeJt/K9vlsg6V/MraLds=
X-Google-Smtp-Source: AGHT+IEuuQIrmzIO0zM11jr+yM94YwQ2ufkKLq0ZEfsaM9EANBUdXgXQ01+M4sPvdg9zpdfL46GD+g==
X-Received: by 2002:a05:600c:5103:b0:426:63b8:2cce with SMTP id 5b1f17b1804b1-427dc52063amr39592745e9.7.1721643148703;
        Mon, 22 Jul 2024 03:12:28 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e436sm147993865e9.33.2024.07.22.03.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:12:28 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com
Cc: James Clark <james.clark@linaro.org>,
	James Clark <james.clark@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v6 00/17] coresight: Use per-sink trace ID maps for Perf sessions
Date: Mon, 22 Jul 2024 11:11:42 +0100
Message-Id: <20240722101202.26915-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will allow sessions with more than CORESIGHT_TRACE_IDS_MAX ETMs
as long as there are fewer than that many ETMs connected to each sink.

Each sink owns its own trace ID map, and any Perf session connecting to
that sink will allocate from it, even if the sink is currently in use by
other users. This is similar to the existing behavior where the dynamic
trace IDs are constant as long as there is any concurrent Perf session
active. It's not completely optimal because slightly more IDs will be
used than necessary, but the optimal solution involves tracking the PIDs
of each session and allocating ID maps based on the session owner. This
is difficult to do with the combination of per-thread and per-cpu modes
and some scheduling issues. The complexity of this isn't likely to worth
it because even with multiple users they'd just see a difference in the
ordering of ID allocations rather than hitting any limits (unless the
hardware does have too many ETMs connected to one sink).

Per-thread mode works but only until there are any overlapping IDs, at
which point Perf will error out. Both per-thread mode and sysfs mode are
left to future changes, but both can be added on top of this initial
implementation and only sysfs mode requires further driver changes.

The HW_ID version field hasn't been bumped in order to not break Perf
which already has an error condition for other values of that field.
Instead a new minor version has been added which signifies that there
are new fields but the old fields are backwards compatible.

Changes since v5:
  
  * Hide queue number printout behind -v option
  * Style change in cs_etm__process_aux_output_hw_id()
  * Move new format enum to an earlier commit to reduce churn

Changes since v4:

  * Fix compilation failure when TRACE_ID_DEBUG is set
  * Expand comment about not freeing individual trace IDs in
    free_event_data()

Changes since v3:

  * Fix issue where trace IDs were overwritten by possibly invalid ones
    by Perf in unformatted mode. Now the HW_IDs are also used for
    unformatted mode unless the kernel didn't emit any.
  * Add a commit to check the OpenCSD version.
  * Add a commit to not save invalid IDs in the Perf header.
  * Replace cs_etm_queue's formatted and formatted_set members with a
    single enum which is easier to use.
  * Drop CORESIGHT_TRACE_ID_UNUSED_FLAG as it's no longer needed.
  * Add a commit to print the queue number in the raw dump.
  * Don't assert on the number of unformatted decoders if decoders == 0.


Changes since v2:

  * Rebase on coresight-next 6.10-rc2 (b9b25c8496).
  * Fix double free of csdev if device registration fails.
  * Fix leak of coresight_trace_id_perf_start() if trace ID allocation
    fails.
  * Don't resend HW_ID for sink changes in per-thread mode. The existing
    CPU field on AUX records can be used to track this instead.
  * Tidy function doc for coresight_trace_id_release_all()
  * Drop first two commits now that they are in coresight-next
  * Add a commit to make the trace ID spinlock local to the map

Changes since V1:

 * Rename coresight_device.perf_id_map to perf_sink_id_map.
 * Instead of outputting a HW_ID for each reachable ETM, output
   the sink ID and continue to output only the HW_ID once for
   each mapping.
 * Keep the first two Perf patches so that it applies cleanly
   on coresight-next, although they have been applied on perf-tools-next
 * Add new *_map() functions to the trace ID public API instead of
   modifying existing ones.
 * Collapse "coresight: Pass trace ID map into source enable" into
   "coresight: Use per-sink trace ID maps for Perf sessions" because the
   first commit relied on the default map being accessible which is no
   longer necessary due to the previous bullet point.


James Clark (17):
  perf: cs-etm: Create decoders after both AUX and HW_ID search passes
  perf: cs-etm: Allocate queues for all CPUs
  perf: cs-etm: Move traceid_list to each queue
  perf: cs-etm: Create decoders based on the trace ID mappings
  perf: cs-etm: Only save valid trace IDs into files
  perf: cs-etm: Support version 0.1 of HW_ID packets
  perf: cs-etm: Print queue number in raw trace dump
  perf: cs-etm: Add runtime version check for OpenCSD
  coresight: Remove unused ETM Perf stubs
  coresight: Clarify comments around the PID of the sink owner
  coresight: Move struct coresight_trace_id_map to common header
  coresight: Expose map arguments in trace ID API
  coresight: Make CPU id map a property of a trace ID map
  coresight: Use per-sink trace ID maps for Perf sessions
  coresight: Remove pending trace ID release mechanism
  coresight: Emit sink ID in the HW_ID packets
  coresight: Make trace ID map spinlock local to the map

 drivers/hwtracing/coresight/coresight-core.c  |  37 +-
 drivers/hwtracing/coresight/coresight-dummy.c |   3 +-
 .../hwtracing/coresight/coresight-etm-perf.c  |  43 +-
 .../hwtracing/coresight/coresight-etm-perf.h  |  18 -
 .../coresight/coresight-etm3x-core.c          |   9 +-
 .../coresight/coresight-etm4x-core.c          |   9 +-
 drivers/hwtracing/coresight/coresight-priv.h  |   1 +
 drivers/hwtracing/coresight/coresight-stm.c   |   3 +-
 drivers/hwtracing/coresight/coresight-sysfs.c |   3 +-
 .../hwtracing/coresight/coresight-tmc-etr.c   |   5 +-
 drivers/hwtracing/coresight/coresight-tmc.h   |   5 +-
 drivers/hwtracing/coresight/coresight-tpdm.c  |   3 +-
 .../hwtracing/coresight/coresight-trace-id.c  | 138 ++--
 .../hwtracing/coresight/coresight-trace-id.h  |  70 +-
 include/linux/coresight-pmu.h                 |  17 +-
 include/linux/coresight.h                     |  21 +-
 tools/build/feature/test-libopencsd.c         |   4 +-
 tools/include/linux/coresight-pmu.h           |  17 +-
 tools/perf/Makefile.config                    |   2 +-
 tools/perf/arch/arm/util/cs-etm.c             |  11 +-
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  49 +-
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |   3 +-
 .../util/cs-etm-decoder/cs-etm-min-version.h  |  13 +
 tools/perf/util/cs-etm.c                      | 629 +++++++++++-------
 tools/perf/util/cs-etm.h                      |  12 +-
 25 files changed, 650 insertions(+), 475 deletions(-)
 create mode 100644 tools/perf/util/cs-etm-decoder/cs-etm-min-version.h

-- 
2.34.1

