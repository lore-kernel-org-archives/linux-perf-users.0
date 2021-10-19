Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7410C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 23:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3BDB61156
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 23:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhJSXVW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Oct 2021 19:21:22 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:37710 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhJSXVW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Oct 2021 19:21:22 -0400
Received: by mail-ot1-f41.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso4125224otl.4;
        Tue, 19 Oct 2021 16:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5nsHnaoXk8+Eq2Xg8Mog77Q4uh/2i59CEd9nzRezXh4=;
        b=LyvbxUU+4gHSTmekZCVLQHRGzwpBE8eR97zuyIUMHmNgm5v8VBe3Fa3w2kf6BVmkIJ
         U9xzQYUrzVFlv6xg2R+GiZenPbJn3Oh2WjCwgGlgX0weK8SIAc+2urYfjyDn8J0DJeRq
         eVlO5A0cwPvXKpl5h4Biowj1zHTRpQOtgz1XOmHSBsgYi+iEa95dXodxeU5U/BXwvgEb
         OlPmN0gNZwPzaxht0400K3o/UpBHQz4OfrpFq5Xm59pqhvqRxGo0XlPOeWNcjbxvCXoG
         LRb1p9gvSMPn+PwRPStVLhMMmcomTYaXAHy9H3++KfGbshISnNVatveE42mYAURLLlo4
         L21w==
X-Gm-Message-State: AOAM533N34rCrS5Qz5CBC+ytlAOP3QGkqrD2lMJ8ALYWEWD10yPlfsCl
        Uj298giiPXnDWVKGM9yhnw==
X-Google-Smtp-Source: ABdhPJyE3rEDlADOo0/u2ciFtKjsxe9O6w7eeSObdBN4LU3kLtPb9FiNZ8xTQxzxuLhTZrhHMjHN0w==
X-Received: by 2002:a9d:560c:: with SMTP id e12mr330882oti.160.1634685548723;
        Tue, 19 Oct 2021 16:19:08 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id w141sm118375oif.20.2021.10.19.16.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 16:19:08 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v11 0/5] arm64 userspace counter support
Date:   Tue, 19 Oct 2021 18:19:02 -0500
Message-Id: <20211019231907.1009567-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Another version of arm64 userspace counter access support.

The arm64 support departs from the x86 implementation by requiring the user
to explicitly request user access (via attr.config1) and only enables access
for task bound events. Since usage is explicitly requested, access is
enabled at perf_event_open() rather than on mmap() as that greatly
simplifies the implementation. Rather than trying to lock down the access
as the x86 implementation has been doing, we can start with only a limited
use case enabled and later expand it if needed.

I've run this version thru Vince's perf tests[13] with arm64 support added.
I wish I'd found these tests sooner...

This originally resurrected Raphael's series[1] to enable userspace counter
access on arm64. My previous versions are here[2][3][4][5][6][7][8][9][10][11].
A git branch is here[12].

Changes in v11:
 - User request for 64-bit counters and userspace access will fail on
   open if h/w doesn't support 64-bit counters instead of reporting the
   maximum counter size. The open will also fail if not a task bound
   event.

Changes in v10:
 - Drop changing event_mapped/event_unmapped ops to run on the event's
   current CPU. This won't work for x86 where any thread sharing an mm
   context will have rdpmc enabled. Instead, simply track user access
   events when added to a perf context and use that count.
 - Documentation for the sysctl disable

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
[10] https://lore.kernel.org/all/20210806225123.1958497-1-robh@kernel.org/
[11] https://lore.kernel.org/all/20210914204800.3945732-1-robh@kernel.org/
[12] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git arm64-user-perf-event-v11
[13] https://github.com/deater/perf_event_tests


Raphael Gault (1):
  Documentation: arm64: Document PMU counters access from userspace

Rob Herring (4):
  x86: perf: Move RDPMC event flag to a common definition
  perf: Add a counter for number of user access events in context
  arm64: perf: Add userspace counter access disable switch
  arm64: perf: Enable PMU counter userspace access for perf event

 Documentation/admin-guide/sysctl/kernel.rst |  11 ++
 Documentation/arm64/perf.rst                |  75 ++++++++++-
 arch/arm64/kernel/perf_event.c              | 132 +++++++++++++++++++-
 arch/x86/events/core.c                      |  10 +-
 arch/x86/events/perf_event.h                |   2 +-
 include/linux/perf_event.h                  |  10 ++
 kernel/events/core.c                        |   4 +
 7 files changed, 231 insertions(+), 13 deletions(-)

-- 
2.32.0

