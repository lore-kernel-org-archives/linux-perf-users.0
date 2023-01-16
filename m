Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC25C46467
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 Jan 2023 12:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjAPMto (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 Jan 2023 07:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjAPMth (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 Jan 2023 07:49:37 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4A31E5CF
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Jan 2023 04:49:35 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so23542885wmb.2
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Jan 2023 04:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VhFDx2nLBEQMMGIEbt94FqGKjkWBbT2r5ofKpofV8U=;
        b=gep+o26ySUGKCJouCtnEiKeRZTysmrP7hZD0wbxSv7HvY7KFLTP8/Fn5K6PflMi8Bi
         FpiwnalTbFNNXFJcc6mY16P+euUvQFx+IjH/O3Qrt7T1VP7CUMLMOI6OnhxsI4AXlc+W
         4p0bzVDbXWzJM1hi44GXYRDBqgfToCMm+2RYRpX7ZF60shDOGJ8QhhTDFM8muolLu+Dj
         xoywtB0tW9DREri6yudY12noIG1Bg1zh8Bi6XFW6ncQBQ/F0nCb26FrsLoFWhY9P90tH
         TRLn4HKirSLvC7dxHagjRZ8B/2Pj3Fpoj7AUswtXBpgcLsoYlywze/d7dgDnjJTV/goM
         RMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VhFDx2nLBEQMMGIEbt94FqGKjkWBbT2r5ofKpofV8U=;
        b=H6rOwNoobU7hPRvN4td66ku50JnBaEFO82/JEZZ104XoYuhVONu5wt08boBbio5WY7
         d/LCiA0VNkI9vsQRlRfMAJwBl9yzoIE02Uhf2lNUZREmsQRHjxhEAZYEOrUEQwdoAKWT
         7MD+JzBoS5KfvcfbM8L9bBuRioSf40nQTLei9nETqMEtAZaCyFoUZTvpsRpquLNlCFvS
         6mNj5l4Uwqo4WbuChfIzIMummrvlZVgRTu04AaRwELejWi//wzvRknqiNKZDkO8T+bmk
         g7q1bq0he7b0Uj94420WqLZh+xRAizj2mkvifWXQVUjlWd5TJ2y1gNaJUfvzfAITYcyh
         Ahqw==
X-Gm-Message-State: AFqh2krwibDxrs5lh+MI3TpJo80e/YFwdtLQZmxF9xm5vbKi8T8m2Cl4
        IB2aeksEdv9kR6r0dNVVHQKPxw==
X-Google-Smtp-Source: AMrXdXsH2o1/jAjcizTMqinL9MOnwoOFTZCu6DcvFg51I/SRnTCEVPZVHyym2iPLyURuNnAqq1YwHQ==
X-Received: by 2002:a05:600c:5405:b0:3da:632:a8d with SMTP id he5-20020a05600c540500b003da06320a8dmr17563341wmb.10.1673873374138;
        Mon, 16 Jan 2023 04:49:34 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:6c91:710d:9433:e868])
        by smtp.gmail.com with ESMTPSA id fl12-20020a05600c0b8c00b003dab40f9eafsm6896832wmb.35.2023.01.16.04.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:49:33 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 00/15]  coresight: Add new API to allocate trace source ID values
Date:   Mon, 16 Jan 2023 12:49:13 +0000
Message-Id: <20230116124928.5440-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The current method for allocating trace source ID values to sources is
to use a fixed algorithm for CPU based sources of (cpu_num * 2 + 0x10).
The STM is allocated ID 0x1.

This fixed algorithm is used in both the CoreSight driver code, and by
perf when writing the trace metadata in the AUXTRACE_INFO record.

The method needs replacing as currently:-
1. It is inefficient in using available IDs.
2. Does not scale to larger systems with many cores and the algorithm
has no limits so will generate invalid trace IDs for cpu number > 44.

Additionally requirements to allocate additional system IDs on some
systems have been seen.

This patch set  introduces an API that allows the allocation of trace IDs
in a dynamic manner.

Architecturally reserved IDs are never allocated, and the system is
limited to allocating only valid IDs.

Each of the current trace sources ETM3.x, ETM4.x and STM is updated to use
the new API.

For the ETMx.x devices IDs are allocated on certain events
a) When using sysfs, an ID will be allocated on hardware enable, or a read of
sysfs TRCTRACEID register and freed when the sysfs reset is written.

b) When using perf, ID is allocated on during setup AUX event, and freed on
event free. IDs are communicated using the AUX_OUTPUT_HW_ID packet.
The ID allocator is notified when perf sessions start and stop
so CPU based IDs are kept constant throughout any perf session.


Note: This patchset breaks some backward compatibility for perf record and
perf report.

The version of the AUXTRACE_INFO has been updated to reflect the fact that
the trace source IDs are generated differently. This will
mean older versions of perf report cannot decode the newer file.

Appies to coresight/next

Changes since v6:
1) Export perf_report_aux_output_id() Acked by Peter,
2) Update to ETMv3 docs requested by suzuki
3) rebased and re-tested on coresight/next (6.2-rc2)

Changes since v5: (requested by suzuki)
1) Prefer odd ID values for system IDs to avoid overlap with legacy CPU IDs
2) Some style changes

Changes since v4:
1) update to ensure that compiling after each individual patch added still
works - ie. git bisect not broken through the patchset..

2) Revision to some of the now redundant code in cs-etm (James)

3) Comments and other minor fixes requested by Suzuki.

Changes since v3:
1) Fixed aarch32 build error in ETM3.x driver.
Reported-by: kernel test robot <lkp@intel.com>

Changes since v2:
1) Improved backward compatibility: (requested by James)

Using the new version of perf on an old kernel will generate a usable file
legacy metadata values are set by the new perf and will be used if mew
ID packets are not present in the file.

Using an older version of perf / simpleperf on an updated kernel may still
work. The trace ID allocator has been updated to use the legacy ID values
where possible, so generated file and used trace IDs will match up to the
point where the legacy algorithm is broken anyway.

2) Various changes to the ID allocator and ID packet format.
(suggested by Suzuki)

3) per CPU ID info in allocator now stored as atomic type to allow a passive read
without taking the allocator spinlock. perf flow now allocates and releases ID
values in setup_aux / free_event. Device enable and event enable use the passive
read to set the allocated values. This simplifies the locking mechanisms on the
perf run and fixes issues that arose with locking dependencies.

Changes since v1:
(after feedback & discussion with Mathieu & Suzuki).

1) API has changed. The global trace ID map is managed internally, so it
is no longer passed in to the API functions.

2) perf record does not use sysfs to find the trace IDs. These are now
output as AUX_OUTPUT_HW_ID events. The drivers, perf record, and perf report
have been updated accordingly to generate and handle these events.

Mike Leach (15):
  coresight: trace-id: Add API to dynamically assign Trace ID values
  coresight: Remove obsolete Trace ID unniqueness checks
  coresight: perf: traceid: Add perf ID allocation and notifiers
  coresight: stm: Update STM driver to use Trace ID API
  coresight: etm4x: Update ETM4 driver to use Trace ID API
  coresight: etm3x: Update ETM3 driver to use Trace ID API
  coresight: etmX.X: stm: Remove trace_id() callback
  coresight: trace id: Remove legacy get trace ID function.
  perf: cs-etm: Move mapping of Trace ID and cpu into helper function
  perf: cs-etm: Update record event to use new Trace ID protocol
  kernel: events: Export perf_report_aux_output_id()
  perf: cs-etm: Handle PERF_RECORD_AUX_OUTPUT_HW_ID packet
  coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID
  coresight: trace-id: Add debug & test macros to Trace ID allocation
  coresight: etm3x: docs: Alter sysfs documentation for trace id updates

 .../testing/sysfs-bus-coresight-devices-etm3x |   2 +-
 drivers/hwtracing/coresight/Makefile          |   2 +-
 drivers/hwtracing/coresight/coresight-core.c  |  45 ---
 .../hwtracing/coresight/coresight-etm-perf.c  |  23 ++
 drivers/hwtracing/coresight/coresight-etm.h   |   3 +-
 .../coresight/coresight-etm3x-core.c          |  93 +++--
 .../coresight/coresight-etm3x-sysfs.c         |  27 +-
 .../coresight/coresight-etm4x-core.c          |  73 +++-
 .../coresight/coresight-etm4x-sysfs.c         |  27 +-
 drivers/hwtracing/coresight/coresight-etm4x.h |   3 +
 drivers/hwtracing/coresight/coresight-stm.c   |  49 +--
 .../hwtracing/coresight/coresight-trace-id.c  | 298 ++++++++++++++++
 .../hwtracing/coresight/coresight-trace-id.h  | 156 +++++++++
 include/linux/coresight-pmu.h                 |  34 +-
 include/linux/coresight.h                     |   3 -
 kernel/events/core.c                          |   1 +
 tools/include/linux/coresight-pmu.h           |  48 ++-
 tools/perf/arch/arm/util/cs-etm.c             |  21 +-
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   7 +
 tools/perf/util/cs-etm.c                      | 325 +++++++++++++++---
 tools/perf/util/cs-etm.h                      |  14 +-
 21 files changed, 1024 insertions(+), 230 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
 create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h

-- 
2.17.1

