Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F21C32772
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Aug 2022 10:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355667AbiHWKoB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Aug 2022 06:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356636AbiHWKmp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Aug 2022 06:42:45 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A610AA4D3
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 02:10:15 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k9so16219983wri.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 02:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=2GEox6su7AoY4+aEAqSxNCHHTvFo9S3YrU+NFgyLh6M=;
        b=q9GKbI0mC9u3ZVdiR0XwtAj2Sv+LW2oXwXZJGh29tpEE9vE4lBN91EtDicNh2CTdG+
         n4eyNcmuhRcY2tkbg/3s24892tRY+K1BRawtSEDJkJDtGeUYd8XiVuzfEDsigrTBPH/j
         1bEprKm4GDguie8AVGxCytQWxmPBjItZKB32Q1uBgRQqwdeFqUQZXh+4jVdrnzAgRAo7
         aaJ0csNmeTUuvvYiwjsnoO3swsFzGoWstLL6ySqPC8nsyWi192VACuWzvjRYWP4qx/N4
         cmCWfeMx/c7MuYuL5dV/tNIp75X0MbRDB4VAFKxLuMjL/KXJQUVtWXJoL6/seswm86Qh
         pWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2GEox6su7AoY4+aEAqSxNCHHTvFo9S3YrU+NFgyLh6M=;
        b=vKpt3E+HaHQp+ixBqmBmncAGHfH5Ystxtng3iyTQS7kR98HICI/gaE1yTccGWu3+Yv
         OyCj4SBGeKhFIM3KJ3q7prl62uJHzgFRmPFtjdNU0AnB20kyKie07WPLvCU3ILrKos90
         pegYbFCZyaioUTPYlKEjhS/+StqrGnQbXmebxuu6SAR0GXRMZApKyc5YjQPdnugQ+7vh
         JkW/Kskg1QdXqHeHzRPEdgiApOYURX0NIdpErjohqk8fgbfRfdAOz+vur0nNw348U/eB
         AzrxFmmykQvQWngsHRJlfhjjHiTx3flRtDBuHSWq6nn6g43kbtY2IejY74OENv5X8uM/
         NW5A==
X-Gm-Message-State: ACgBeo1xiSkphf7KarcdFNcVpq2OR/Hx9u2zGZbOejwArNUYt2zySmMC
        zQIsYwMjVdYpCyFH4gOiNbaOwg==
X-Google-Smtp-Source: AA6agR7Qo0nSag2xxvg7vayzLIp13TZaGsEXPSOjjQe6WSAi9DLEUM0rn2oxZmdfBNRAqc1H4dZF6Q==
X-Received: by 2002:adf:fb0e:0:b0:21a:34a2:5ca9 with SMTP id c14-20020adffb0e000000b0021a34a25ca9mr13092302wrr.472.1661245813218;
        Tue, 23 Aug 2022 02:10:13 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:4553:cf11:6cff:b293])
        by smtp.gmail.com with ESMTPSA id w6-20020adfde86000000b002253d162491sm10760721wrl.52.2022.08.23.02.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 02:10:12 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 00/13]  coresight: Add new API to allocate trace source ID values
Date:   Tue, 23 Aug 2022 10:09:56 +0100
Message-Id: <20220823091009.14121-1-mike.leach@linaro.org>
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

Applies to coresight/next [4d45bc82df66]
Tested on DB410c

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

Mike Leach (13):
  coresight: trace-id: Add API to dynamically assign Trace ID values
  coresight: Remove obsolete Trace ID unniqueness checks
  coresight: stm: Update STM driver to use Trace ID API
  coresight: etm4x: Update ETM4 driver to use Trace ID API
  coresight: etm3x: Update ETM3 driver to use Trace ID API
  coresight: etmX.X: stm: Remove trace_id() callback
  coresight: perf: traceid: Add perf notifiers for Trace ID
  perf: cs-etm: Move mapping of Trace ID and cpu into helper function
  perf: cs-etm: Update record event to use new Trace ID protocol
  kernel: events: Export perf_report_aux_output_id()
  perf: cs-etm: Handle PERF_RECORD_AUX_OUTPUT_HW_ID packet
  coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID
  coresight: trace-id: Add debug & test macros to Trace ID allocation

 drivers/hwtracing/coresight/Makefile          |   2 +-
 drivers/hwtracing/coresight/coresight-core.c  |  49 +--
 .../hwtracing/coresight/coresight-etm-perf.c  |  23 ++
 drivers/hwtracing/coresight/coresight-etm.h   |   3 +-
 .../coresight/coresight-etm3x-core.c          |  92 +++--
 .../coresight/coresight-etm3x-sysfs.c         |  27 +-
 .../coresight/coresight-etm4x-core.c          |  79 ++++-
 .../coresight/coresight-etm4x-sysfs.c         |  27 +-
 drivers/hwtracing/coresight/coresight-etm4x.h |   3 +
 drivers/hwtracing/coresight/coresight-stm.c   |  49 +--
 .../hwtracing/coresight/coresight-trace-id.c  | 266 ++++++++++++++
 .../hwtracing/coresight/coresight-trace-id.h  |  78 +++++
 include/linux/coresight-pmu.h                 |  35 +-
 include/linux/coresight.h                     |   3 -
 kernel/events/core.c                          |   1 +
 tools/include/linux/coresight-pmu.h           |  48 ++-
 tools/perf/arch/arm/util/cs-etm.c             |  21 +-
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   7 +
 tools/perf/util/cs-etm.c                      | 331 +++++++++++++++---
 tools/perf/util/cs-etm.h                      |  14 +-
 20 files changed, 933 insertions(+), 225 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
 create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h

-- 
2.17.1

