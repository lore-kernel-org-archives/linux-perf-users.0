Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8FEC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Mar 2022 20:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350270AbiCHUvG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Mar 2022 15:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350235AbiCHUvE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Mar 2022 15:51:04 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D06E32996
        for <linux-perf-users@vger.kernel.org>; Tue,  8 Mar 2022 12:50:06 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u1so30390651wrg.11
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Mar 2022 12:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zbxC61+D53doyFQ7PA8Wz9hik1u0auVx2uX6w7PSQB8=;
        b=iHtryZYXqO9iYD2CshdOD95lHixbFlVCg3fB1qicchNGd1hZIYjO1a3vaykoegZMWt
         byggGjnQPDSAtJfPhDw+Jo1OoUvnnuGBgllxYQ4UY12oWTA0tjRMBemOmkbtF0Xxpwsf
         xayKEX2WHLtA6QOuBaUOvZTEvQSyPrWjvChUpkj4/kVCxmUGWiIvZmdZttvwYwH15I/N
         TkITPsV4EVHXuhhIT1My4zplwID9xaO1TG0uUGSbqV6hCcYGrRn6brMaoLxy+kjkVSv9
         OK5ZvKj7F0VZPnm0uXZZE7g61531f8mmPVgfEG1Vc0lIYWavONGWBdUH95/jEDpk4dq/
         iCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zbxC61+D53doyFQ7PA8Wz9hik1u0auVx2uX6w7PSQB8=;
        b=tqA671oYg7ST6L6rQ5QzmluDi5zm0vixoivCtE3stNaBhWNhqZeU6tWiMrrZM5+qOA
         QpWjoLBD+wUs0XmzPKP+Gupm7PsWgIL56oA/Lk7pVLMWQxKpDTBYMceaO2+6umNT8ll5
         xEDnozCVY3cvgfHypAVL+LXH/IEikssLBxS0SUDdd1u36PFXXDHnJXbb9ki8NV9jL3/V
         j95F5J8eYHVFHLjQi2aVEG/nPaZsaYRiq6t43rbNeftDa/ohUS9o0JHL4Qkt0+qq4www
         1IVfYvJOh1WEuVbysqAgEDANWn0t4+Tv5UJ8/igGuJGCH+NwmKxXA7iTkXt3307gB1wf
         nL4A==
X-Gm-Message-State: AOAM533l5PpkCOzhGxOe5Hr1KnHvLbGumFc26FxKfl2nqtKrf6YdG3p2
        aunfHXEo6106hlD6C5rgIfo08A==
X-Google-Smtp-Source: ABdhPJx/eazJnDjwJs+zGcscB1Z8JTMKmmP/awems14ZHFh0gwjLLtzawI7cVwx4inupqh25yUsf5g==
X-Received: by 2002:adf:d1c4:0:b0:203:6d79:f15 with SMTP id b4-20020adfd1c4000000b002036d790f15mr3256113wrd.489.1646772605082;
        Tue, 08 Mar 2022 12:50:05 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:546d:7d59:1703:bf96])
        by smtp.gmail.com with ESMTPSA id p26-20020a1c741a000000b00389ab9a53c8sm3245758wmc.36.2022.03.08.12.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 12:50:04 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH 00/10] coresight: Add new API to allocate trace source ID values
Date:   Tue,  8 Mar 2022 20:49:50 +0000
Message-Id: <20220308205000.27646-1-mike.leach@linaro.org>
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

perf handling is changed so that the ID associated with the CPU is read
from sysfs. The ID allocator is notified when perf events start and stop
so CPU based IDs are kept constant throughout any perf session.

For the ETMx.x devices IDs are allocated on certain events
a) When using sysfs, an ID will be allocated on hardware enable, and freed
when the sysfs reset is written.
b) When using perf, ID is allocated on hardware enable, and freed on
hardware disable.

For both cases the ID is allocated when sysfs is read to get the current
trace ID. This ensures that consistent decode metadata can be extracted
from the system where this read occurs before device enable.

Note: This patchset breaks backward compatibility for perf record.
Because the method for generating the AUXTRACE_INFO meta data has
changed, using an older perf record will result in metadata that
does not match the trace IDs used in the recorded trace data.
This mismatch will cause subsequent decode to fail. Older versions of
perf will still be able to decode data generated by the updated system.


Applies to coresight/next [b54f53bc11a5]
Tested on DB410c

Mike Leach (10):
  coresight: trace-id: Add API to dynamically assign trace ID values
  coresight: trace-id: Set up source trace ID map for system
  coresight: stm: Update STM driver to use Trace ID api
  coresight: etm4x: Use trace ID API to dynamically allocate trace ID
  coresight: etm3x: Use trace ID API to allocate IDs
  coresight: perf: traceid: Add perf notifiers for trace ID
  perf: cs-etm: Update event to read trace ID from sysfs
  coresight: Remove legacy Trace ID allocation mechanism
  coresight: etmX.X: stm: Remove unused legacy source trace ID ops
  coresight: trace-id: Add debug & test macros to trace id allocation

 drivers/hwtracing/coresight/Makefile          |   2 +-
 drivers/hwtracing/coresight/coresight-core.c  |  64 ++---
 .../hwtracing/coresight/coresight-etm-perf.c  |  16 +-
 drivers/hwtracing/coresight/coresight-etm.h   |   3 +-
 .../coresight/coresight-etm3x-core.c          |  93 ++++---
 .../coresight/coresight-etm3x-sysfs.c         |  28 +-
 .../coresight/coresight-etm4x-core.c          |  63 ++++-
 .../coresight/coresight-etm4x-sysfs.c         |  32 ++-
 drivers/hwtracing/coresight/coresight-etm4x.h |   3 +
 drivers/hwtracing/coresight/coresight-priv.h  |   1 +
 drivers/hwtracing/coresight/coresight-stm.c   |  49 +---
 .../hwtracing/coresight/coresight-trace-id.c  | 255 ++++++++++++++++++
 .../hwtracing/coresight/coresight-trace-id.h  |  69 +++++
 include/linux/coresight-pmu.h                 |  12 -
 include/linux/coresight.h                     |   3 -
 tools/perf/arch/arm/util/cs-etm.c             |  12 +-
 16 files changed, 530 insertions(+), 175 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
 create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h

-- 
2.17.1

