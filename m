Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05004C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 22:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D643D610CB
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 22:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhHFWvo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 18:51:44 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:34534 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbhHFWvo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Aug 2021 18:51:44 -0400
Received: by mail-io1-f43.google.com with SMTP id i7so8296853iow.1;
        Fri, 06 Aug 2021 15:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8oTOX5UKRcKwRtyxPU4JY7BhGYOImlGPViKIREQZZ9E=;
        b=osb9lxwTyTqTmnyYueVyb586q6xgQ1oDayo8BBuhIo2H1L3zTLKiq0zESHB9rbWOCB
         gsyBPkZt8bbVCJg7Xx9fnMfTeR9vDtb7gRjzM/zxzw0V8GVo/wvYY8GbkL8+iED3+diw
         W3lpu6WEmDX94D/XjZpSMyzdDaXusP7FokN4J9CscijhYGLE5NiX37ttErVd16dkTqNu
         BDD7MqbhJux3h7ue/Vwx437VgFmFX6FBFGB9B54wP3MN26BESZqtMUEiCLhuJoaKhyM8
         y2CqDW2wYIgNM8WezBvzZZAK/UuDIT2mo7fuxhDNOwqohh/6MUFrFKSqMGXmNILy7ebm
         ydLg==
X-Gm-Message-State: AOAM530frLw9GnngEocqNierkfkIy1kxPOr5LJjTe0xHG3G/hQujaMyU
        R0G6a+t+lZBEnn/zov2M9g==
X-Google-Smtp-Source: ABdhPJz6kn3RnAeRpdhNsQ8o4BoGB7NWJk3dP9MjIMaRLvX6Y1KGDoNPus+S9DKBkoGD2fBI+YSv8g==
X-Received: by 2002:a5e:924a:: with SMTP id z10mr58037iop.35.1628290286591;
        Fri, 06 Aug 2021 15:51:26 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id x11sm5670338ilu.3.2021.08.06.15.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 15:51:26 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v9 0/3] arm64 userspace counter support
Date:   Fri,  6 Aug 2021 16:51:20 -0600
Message-Id: <20210806225123.1958497-1-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Will, Mark,

This depends on:

https://lore.kernel.org/lkml/20210728230230.1911468-1-robh@kernel.org/

Go review that first, thanks!

Another version of arm64 userspace counter access support. This is just the
Arm bits as Arnaldo asked to send the tools bits separately.

The Arm implementation departs from the x86 implementation by requiring
the user to always explicitly request user access (via attr.config1) and
only enables access for task bound events. Rather than trying to lock
down the access as the x86 implementation has been doing, we can start
with only a limited use case enabled and later expand it if needed.

This originally resurrected Raphael's series[1] to enable userspace counter
access on arm64. My previous versions are here[2][3][4][5][6][7][8][9].

Changes in v9:
 - Reworked x86 and perf core to handle user access tracking and call
   .event_mapped() and .event_unmapped() on the CPU with the event like
   other changes to events.
 - Use sysctl instead of sysfs to disable user access.

Changes in v8:
 - Restrict user access to thread bound events which simplifies the
   implementation. A couple of perf core changes (patches 1 and 2) are
   needed to do this.
 - Always require the user to request userspace access.

Changes in v7:
 - Handling of dirty counter leakage and reworking of context switch and
   user access enabling. The .sched_task hook and undef instruction handler
   are now utilized. (Patch 3)
 - Add a userspace disable switch like x86. (Patch 5)

Changes in v6:
 - Reworking of the handling of 64-bit counters and user access. There's
   a new config1 flag to request user access. This takes priority over
   the 64-bit flag and the user will get the maximum size the h/w
   supports without chaining.
 - The libperf evsel mmap struct is stored in its own xyarray
 - New tests for user 64-bit and 32-bit counters
 - Rebase to v5.12-rc2

Changes in v5:
 - Limit enabling/disabling access to CPUs associated with the PMU
   (supported_cpus) and with the mm_struct matching current->active_mm.
   The x86 method of using mm_cpumask doesn't work for arm64 as it is not
   updated.
 - Only set cap_user_rdpmc if event is on current cpu. See patch 2.
 - Create an mmap for every event in an evsel. This results in some changes
   to the libperf mmap API from the last version.
 - Rebase to v5.11-rc2

Changes in v4:
 - Dropped 'arm64: pmu: Add hook to handle pmu-related undefined instructions'.
   The onus is on userspace to pin itself to a homogeneous subset of CPUs
   and avoid any aborts on heterogeneous systems, so the hook is not needed.
 - Make perf_evsel__mmap() take pages rather than bytes for size
 - Fix building arm64 heterogeneous test.

Changes in v3:
 - Dropped removing x86 rdpmc test until libperf tests can run via 'perf test'
 - Added verbose prints for tests
 - Split adding perf_evsel__mmap() to separate patch

The following changes to the arm64 support have been made compared to
Raphael's last version:

The major change is support for heterogeneous systems with some
restrictions. Specifically, userspace must pin itself to like CPUs, open
a specific PMU by type, and use h/w specific events. The tests have been
reworked to demonstrate this.

Chained events are not supported. The problem with supporting chained
events was there's no way to distinguish between a chained event and a
native 64-bit counter. We could add some flag, but do self monitoring
processes really need that? Native 64-bit counters are supported if the
PMU h/w has support. As there's already an explicit ABI to request 64-bit
counters, userspace can request 64-bit counters and if user
access is not enabled, then it must retry with 32-bit counters.

Prior versions broke the build on arm32 (surprisingly never caught by
0-day). As a result, event_mapped and event_unmapped implementations have
been moved into the arm64 code.

There was a bug in that pmc_width was not set in the user page. The tests
now check for this.

The documentation has been converted to rST. I've added sections on
chained events and heterogeneous.

Rob

[1] https://lore.kernel.org/r/20190822144220.27860-1-raphael.gault@arm.com/
[2] https://lore.kernel.org/r/20200707205333.624938-1-robh@kernel.org/
[3] https://lore.kernel.org/r/20200828205614.3391252-1-robh@kernel.org/
[4] https://lore.kernel.org/r/20200911215118.2887710-1-robh@kernel.org/
[5] https://lore.kernel.org/r/20201001140116.651970-1-robh@kernel.org/
[6] https://lore.kernel.org/r/20210114020605.3943992-1-robh@kernel.org/
[7] https://lore.kernel.org/r/20210311000837.3630499-1-robh@kernel.org/
[8] https://lore.kernel.org/r/20210420031511.2348977-1-robh@kernel.org/
[9] https://lore.kernel.org/r/20210517195405.3079458-1-robh@kernel.org/

Raphael Gault (1):
  Documentation: arm64: Document PMU counters access from userspace

Rob Herring (2):
  arm64: perf: Add userspace counter access disable switch
  arm64: perf: Enable PMU counter userspace access for perf event

 Documentation/arm64/perf.rst   |  68 ++++++++++++++-
 arch/arm64/kernel/perf_event.c | 154 +++++++++++++++++++++++++++++++--
 include/linux/perf/arm_pmu.h   |   6 ++
 3 files changed, 219 insertions(+), 9 deletions(-)

-- 
2.30.2

