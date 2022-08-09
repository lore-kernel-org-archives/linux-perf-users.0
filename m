Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ACBC19F2D
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Aug 2022 22:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiHIWeK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Aug 2022 18:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHIWeJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Aug 2022 18:34:09 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86066564F
        for <linux-perf-users@vger.kernel.org>; Tue,  9 Aug 2022 15:34:07 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z16so15753921wrh.12
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Aug 2022 15:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7ygPyN3BjuyHoA1dkcqPuSkPfSzw1EkRzkFMpTadieo=;
        b=D5zo2V/kXQ7rr5VvJuxKzVjB2jF6Ls63AMCwf5xDtZGmgx3E66Mf7pVVzbHkoljf39
         rV+DVayvKM0ovLaVjHTEJD7qDx477XK3YHtv6Ra/TMnxac4hQVv4HlYQlgr6/VHxWo6u
         l9rvCKZNtGlcLdGJFaO/vn/rW4dQIEu+jzbz1S7xR4z6EQOjsAdNqHEBywRy2GGh38Hr
         qvUgtK4fnMR5lb1lI7Lf1UTtW4mxtQhmUHPqcJMqHLVQ0HEjSnGFdN4VI19C3lwpa6Ca
         tybUxhObwLpbXBMQgxAcvtU6Vb939DtNgmUIlHET/3J+0Yo+59XtHRM2X2o4TiSHGE9W
         E+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7ygPyN3BjuyHoA1dkcqPuSkPfSzw1EkRzkFMpTadieo=;
        b=AwMsFx1bwtyn5wm5EGVUaONAhggypYhyo9utDqabK3SKsqdPApxVbxlj2WYdoa2Na5
         ds9EtjLO0Of04XMhzawaNnbcFlqNOpu0T6m4jbC4PjldXmKSDG42MHtxyCzXU8Zb9Okb
         4RtATVMh0YXLTfsy1jnNDqkbRaa1PK/dWl1ZKnk1FQaxJjKmPIADqM8evBaBbAwZ0pQx
         IU/z/HOf73KAgXkygpPvHgktTuGkZO5Pxgdfg0hqnZz3b7lZyG+YTe6zjEVbJ6fnPXaM
         nfCDOD3HyVtjQRGb9uYsX26OqN7ogjngQTTaZDD3jZQYNBTJXXGHrIEDrbTgD3AOKkvu
         eXNg==
X-Gm-Message-State: ACgBeo2wViX/bzzdOoa90UDB7050Au412yvLT0L6MtT1kJwVI+DSuFUd
        J1yasZ1YoPpGZ5yqUbqtQikNug==
X-Google-Smtp-Source: AA6agR4KxtYHA1aTFiV2XGK7iIRsnRhE/+HBumJ3MHsk6gXM8/MhYAhpMOIcqwuwup9ufJCpAaucqA==
X-Received: by 2002:a5d:6102:0:b0:220:6382:eab1 with SMTP id v2-20020a5d6102000000b002206382eab1mr15254354wrt.539.1660084446299;
        Tue, 09 Aug 2022 15:34:06 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:a6:74a6:5a0e:f3e2])
        by smtp.gmail.com with ESMTPSA id e20-20020a05600c4b9400b003a2cf1ba9e2sm311650wmp.6.2022.08.09.15.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:34:05 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v3 00/13] coresight: Add new API to allocate trace source ID values
Date:   Tue,  9 Aug 2022 23:33:48 +0100
Message-Id: <20220809223401.24599-1-mike.leach@linaro.org>
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

