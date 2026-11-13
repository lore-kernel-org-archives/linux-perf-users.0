Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597183;
	b=LrVXctsMpCUV+6G0Bfc/CaICTlj69scurSokoibiMSG8kXa5h9cXj//pt/opkHICwz1j
	 Bd3mAHO8+Wp/NzotZRnMjEGa2cJ/XRtIwOu9hrdhNEd2jMys8Q03y3//IuAmtNGRLNJ2O
	 HVh6pMEBqLoggC9In+d+XovKXELk0pUqVn6I5gyl0qBoSu7usBdRQYoFTicNAGSb5i4LA
	 gYTCQ4LbeJY7FnAES6W+r7v1nK/WGXG39URfNXvu1xy+jeFRmWxA2IFeug7EFv9Z4GFv3
	 C2ROwBgdX9JMrl+xgLaPwohsFG8nefUw6MNYfeTr3Ryx66zH6r+OVjr+PANnhDAwoog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=eAWSWKem9zfHt+XlC1XEIj2qyzJSlOK0o6wdT7kCa6s=;
	b=L1fPEP9DZVU3REAzPfbSUY7+0KgpAmNAuwNo5CNfyjV9Ou/NBLJwnagOB0XGyOYM6Fq+
	 xKarZ2UeWHozYLkTm2jeIkvKZUyKoIvdryQuDd5kQ8dGtZr1U/bTM+ufyTcLHqeJwYm67
	 85P3jXFGcOaj1/OWZYksqbypZyG1ixdxthDuZVEXgMSFjSWi51hv1RSb8ywLxXpKHKEpY
	 tfc1jrjmVrrudBmNegcn8PL/EaQk9mUIgjOcv6wOUgDEk2BX09lta4wnN0hxo2yByVa6J
	 lDalqZwWefE5p7TuEdtbQgNwZV/a2C0IFfhXdhbGVfNMaz9TCsmLzng9j+kmdxucqig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oXY1S+42;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F0D606A330
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96F0D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oXY1S+42
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3724667bc16so785472eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794597182; x=1795201982; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eAWSWKem9zfHt+XlC1XEIj2qyzJSlOK0o6wdT7kCa6s=;
        b=oXY1S+42BV7NNyfWaDuFnEGCkQn8J5xQTP5/OgRXLZzEwu7vpqZjowcORyZEK5+ROV
         wFzDb3MK+Ys8ubJ7UV5d2WJqe+iWZqfbQevoK9Jr3wVmq08kP0h4mxyW3VI/GxVKDgRO
         V9NWdINTSA2zY3MqD2XU/H0ovhSe1vt3KwPse4uS6nDQfk0uFT+0YdLSB2Ix7FKdz+Xw
         Laa48ry1AKbVyd6kEtMb/3m28rJm/piTVtCzWCPzXJIlYl7o4RbflJrp0tQLiEdFknXT
         q5C1qlBNVtLCenZNEAjrscQYPg6b9eSHk+UPMC4NzOqVbfSfpAFzlHCE5g4IRgUoMjlH
         X0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794597182; x=1795201982;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eAWSWKem9zfHt+XlC1XEIj2qyzJSlOK0o6wdT7kCa6s=;
        b=AcRSXMkv9ghUIwWgi2JAaml961EY/lkUkA1+toHa16s3djGrE3xA6Nz1Fjt8LuqZe1
         mNtReA8OOjU3m2ptQkTFu+Kx/tkP9upgM8/cFrAolMt8SsDqV19UhO5gQLDkEK39KC2L
         F46rc4kA9vd1z8Igs5l9O97yuRj+5CtOldrIqk6KwTq7tC32xkgE5C/AUrth4hAtuXeD
         Pt/0kGkOsWhpakWsEwKEKrznLR6Q1RgIxe7eDwhueJ6+cmg28R1oWpsgucpvs720x/HC
         FULMGQbPyoyY1qrN3vwbwthsPUbABLJjxaaRZk8gkim4FZe2YxfpEu/OoT9AQq5Ugi34
         c3FQ==
X-Forwarded-Encrypted: i=1; AL+hErGbo7PmbUj2JyQIgRWLHZdlbBnPCmApAJTTTYUrbomSZAHNXhwtDz+X68+w7B1As5+cd+M8qLCvXVTLcJVMm4mf@vger.kernel.org
X-Gm-Message-State: APuU4Z/sod6X8kqxyIqy2DEToxbI9t16p3F/NMxAjFBbVNimVHDYA30v
	c1MuBRaZ8MQJwCUonJE+CDzhQaIw7s0lGnAKFBxPCCYKAqwxDZxPVvsmrpThg58Jpqv2XRoxLYQ
	1Y6ratcjGUg==
X-Received: from dycnm5.prod.google.com ([2002:a05:7300:d185:b0:35a:c4b6:314b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:20c8:20b0:36a:37:1404
 with SMTP id 5a478bee46e88-37966e3af34mr2810296eec.13.1794597181337; Fri, 13
 Nov 2026 11:13:01 -0800 (PST)
Date: Fri, 13 Nov 2026 11:12:31 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113191234.2509964-1-irogers@google.com>
Subject: [PATCH v3 0/3] perf pmu: Add tool-provided NVMe PMU
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, Daniel Wagner <dwagner@suse.de>, Yuzhuo Jing <yuzhuo@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Tomas Glozar <tglozar@redhat.com>, Michael Jeanson <mjeanson@efficios.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Leo Yan <leo.yan@arm.com>, German Gomez <german.gomez@arm.com>, 
	Anubhav Shelat <ashelat@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series adds a tool-provided PMU for NVMe controllers using libnvme,
following the same pattern as the existing tool, hwmon, and drm PMUs.
Each discovered controller is exposed as an 'nvme_<ctrl>' PMU (with
alias '<ctrl>', e.g. 'nvme_nvme0' and 'nvme0') providing events from
standard NVMe log pages: SMART / Health Information, Endurance Group
Information, Flexible Data Placement (FDP) Statistics, Error
Information, and Zoned Namespaces (ZNS) Changed Zones.

Motivation / Use Cases
======================
While standalone tools such as nvme-cli can dump individual log pages on
demand, exposing NVMe controller log metrics as a perf tool PMU allows
storage metrics (host/media bytes written, write amplification and FDP
efficiency, read/write command counts, controller busy time, error
counters, and device temperature) to be sampled on a unified timeline
alongside CPU hardware counters, kernel/block events, uncore counters,
and hwmon/drm sensors in 'perf stat' (including interval mode '-I', CSV
'-x', JSON '-j', and perf metric formulas), without custom wrapper
scripts. Discovery and log-page probing are gated behind
PERF_TOOL_PMU_TYPE_NVME_MASK so commands that do not request NVMe events
incur zero overhead.

Example Output
==============
Listing available NVMe events (unsupported log pages on the controller
are marked deprecated and hidden from default 'perf list'):

 $ perf list nvme

 List of pre-defined events (to be used in -e or -M):

 nvme:
   smart_crit_comp_time
        [Critical composite temperature time. Unit: nvme_nvme0]
   smart_ctrl_busy_time
        [Controller busy time. Unit: nvme_nvme0]
   smart_data_units_read
        [Data units read (in 1000s of 512-byte units). Unit: nvme_nvme0]
   smart_data_units_written
        [Data units written (in 1000s of 512-byte units). Unit: nvme_nvme0]
   smart_host_read_commands
        [Host read commands. Unit: nvme_nvme0]
   smart_host_write_commands
        [Host write commands. Unit: nvme_nvme0]
   smart_media_errors
        [Media errors. Unit: nvme_nvme0]
   smart_num_err_log_entries
        [Number of error log entries. Unit: nvme_nvme0]
   smart_power_cycles
        [Power cycles. Unit: nvme_nvme0]
   smart_power_on_hours
        [Power on hours. Unit: nvme_nvme0]
   smart_temperature
        [Temperature. Unit: nvme_nvme0]
   smart_unsafe_shutdowns
        [Unsafe shutdowns. Unit: nvme_nvme0]
   smart_warning_temp_time
        [Warning temperature time. Unit: nvme_nvme0]

 $ perf list --details nvme_nvme0/smart_temperature/

 List of pre-defined events (to be used in -e or -M):

 nvme:
   smart_temperature
        [Temperature. Unit: nvme_nvme0]
     nvme_nvme0/config=0x20001/

Interval 'perf stat' output (captured with mocked libnvme SMART log
responses on /dev/nvme0):

 $ perf stat -a -I 500 -e smart_temperature,smart_data_units_read,\
   smart_data_units_written,smart_host_read_commands,\
   smart_host_write_commands -- sleep 1
 #           time             counts unit events
      0.500432960                311 K    smart_temperature
      0.500432960         36,864,000 B    smart_data_units_read
      0.500432960         12,288,000 B    smart_data_units_written
      0.500432960                900      smart_host_read_commands
      0.500432960                270      smart_host_write_commands
      1.001068028                311 K    smart_temperature
      1.001068028         36,864,000 B    smart_data_units_read
      1.001068028         12,288,000 B    smart_data_units_written
      1.001068028                900      smart_host_read_commands
      1.001068028                270      smart_host_write_commands

Changes in v3:
- Remove accidental internal tracking tags from commit messages
  (Christoph Hellwig).
- Document use cases and include actual 'perf list' and 'perf stat'
  example output in the cover letter and Patch 2 commit message, and
  document NVMe events in Documentation/perf-list.txt (Christoph
  Hellwig, Namhyung Kim).
- Rely on $(FEATURE_CHECK_LDFLAGS-libnvme) from pkg-config when building
  test-libnvme.bin instead of hardcoding -lnvme, and add test-libnvme.bin
  to FILES in tools/build/feature/Makefile.
- Report smart_temperature in native Kelvins ('1K') to avoid unsigned
  uint64_t underflow on sub-zero Celsius or 0 K readings; metrics can
  convert Kelvin to Celsius.
- Support advertised 'config=0x...' raw encodings, 'event=<name>', and
  standard event qualifiers ('name=', 'metric-id=', 'cpu='), and guard
  NULL term->config when formatting parse errors.
- Check xyarray__new() allocation failure (-ENOMEM), propagate initial
  log read errors (-EPERM / -EOPNOTSUPP) in evsel__nvme_pmu_open(), and
  bound incremental open error unwind by start_cpu_map_idx.
- Use an aligned union of NVMe log structures in nvme_pmu__read_val(),
  use valid Endurance Group ID 1 (0 is reserved in NVMe) for Endurance
  Group and FDP logs, fix Endurance Group data/media unit scaling to
  billions of bytes ('1000000000B') per NVMe Base Spec, wire up
  perf_pmus__find_by_type() for NVMe PMU types, and propagate
  nvme_pmu__check_alias() errors in perf_pmu__check_alias().
- Expand unit tests to cover alias PMUs, 'event=', 'config=0x...',
  'name=' qualifiers, unit/scale checks, and invalid term rejection.

Changes in v2:
https://lore.kernel.org/linux-perf-users/20260609165726.786694-1-irogers@google.com/
- Include test-libnvme.c in test-all.c and add libnvme to
  FEATURE_PKG_CONFIG.
- Use get_unaligned_le*() helpers when reading NVMe log fields.
- Move baseline initial_values xyarray from tool-owned evsel->priv into
  struct evsel's tool union (evsel->nvme.initial_values) and free it in
  evsel__exit().

v1:
https://lore.kernel.org/linux-perf-users/20260609070348.541964-1-irogers@google.com/

Ian Rogers (3):
  perf build: Add libnvme feature detection
  perf pmu: Implement tool-provided NVMe PMU
  perf tests: Add NVMe PMU event parsing test

 tools/build/Makefile.feature           |   5 +-
 tools/build/feature/Makefile           |   4 +
 tools/build/feature/test-all.c         |   5 +
 tools/build/feature/test-libnvme.c     |  11 +
 tools/perf/Documentation/perf-list.txt |  10 +-
 tools/perf/Makefile.config             |  12 +
 tools/perf/tests/Build                 |   1 +
 tools/perf/tests/builtin-test.c        |   1 +
 tools/perf/tests/nvme_pmu.c            | 303 +++++++++++
 tools/perf/tests/tests.h               |   1 +
 tools/perf/util/Build                  |   1 +
 tools/perf/util/evsel.c                |  13 +-
 tools/perf/util/evsel.h                |   4 +
 tools/perf/util/nvme_pmu.c             | 691 +++++++++++++++++++++++++
 tools/perf/util/nvme_pmu.h             | 144 ++++++
 tools/perf/util/pmu.c                  |  17 +
 tools/perf/util/pmu.h                  |   8 +-
 tools/perf/util/pmus.c                 |  24 +
 tools/perf/util/pmus.h                 |   1 +
 19 files changed, 1250 insertions(+), 6 deletions(-)
 create mode 100644 tools/build/feature/test-libnvme.c
 create mode 100644 tools/perf/tests/nvme_pmu.c
 create mode 100644 tools/perf/util/nvme_pmu.c
 create mode 100644 tools/perf/util/nvme_pmu.h

-- 
2.56.1.703.gf848ed807c-goog

