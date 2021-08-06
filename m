Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10E1C4320A
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 22:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 886F4610CB
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 22:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245617AbhHFWvv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 18:51:51 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:35418 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244611AbhHFWvt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Aug 2021 18:51:49 -0400
Received: by mail-io1-f53.google.com with SMTP id s184so14577652ios.2;
        Fri, 06 Aug 2021 15:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Hgxz19RdIXBXlB6JUJjJ2L0EQ+QiZ5LkbfFS3m/GYk=;
        b=A3wVp94HsyeUyQdn0pikzsalbPcW1jdq3pd/PX4xOsHnCUl0nJDvoIDRUtylQS+mIV
         yvxV5i/bFlgMmXNCmB5GgiVOMevh3B++2gQyohWF9p69RrKeYZeqcYRggRFw3bOw1dXl
         2TeKqMlPw2x9H1Xy7bIpSqnD/t9gxcTGKB11SL9aosbnpX/LwUW+sA1LGswW+V9qmaAF
         eslam4+s3ccjf4z9pfeLu5yiIUgq199Ia0MhdHzRIs7Y0HnsNuVmoPJhVK04FmNUrIVz
         fEL9VPgo2Ss8YTimGF19TiD1bpKFrZn+rrNJl+/B3VeJxb5yQpegCztSdFa0YRf1GO5b
         WWrw==
X-Gm-Message-State: AOAM530shl+yEt9grZ8i3RfvLuSTQte7UnGisJCrjIDTuV7va2vvn7i7
        Hf02Clp0BCDEhRH6O5FaIw==
X-Google-Smtp-Source: ABdhPJybqm/xp7N1NbKP6o213fl3HnTmjQCNX5M7YLK2eyLxm2rPTJks5eQ7ZIRUluTW84b4OKwFVg==
X-Received: by 2002:a6b:b502:: with SMTP id e2mr734725iof.152.1628290293125;
        Fri, 06 Aug 2021 15:51:33 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id x11sm5670338ilu.3.2021.08.06.15.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 15:51:32 -0700 (PDT)
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
Subject: [PATCH v9 3/3] Documentation: arm64: Document PMU counters access from userspace
Date:   Fri,  6 Aug 2021 16:51:23 -0600
Message-Id: <20210806225123.1958497-4-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210806225123.1958497-1-robh@kernel.org>
References: <20210806225123.1958497-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

Add documentation to describe the access to the pmu hardware counters from
userspace.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v9:
 - No change
v8:
 - Reword that config1:1 must always be set to request user access
v7:
 - Merge into existing arm64 perf.rst
v6:
  - Update the chained event section with attr.config1 details
v2:
  - Update links to test examples

Changes from Raphael's v4:
  - Convert to rSt
  - Update chained event status
  - Add section for heterogeneous systems
---
 Documentation/arm64/perf.rst | 68 +++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/perf.rst b/Documentation/arm64/perf.rst
index b567f177d385..fa8706df2281 100644
--- a/Documentation/arm64/perf.rst
+++ b/Documentation/arm64/perf.rst
@@ -2,7 +2,10 @@
 
 .. _perf_index:
 
-=====================
+====
+Perf
+====
+
 Perf Event Attributes
 =====================
 
@@ -88,3 +91,66 @@ exclude_host. However when using !exclude_hv there is a small blackout
 window at the guest entry/exit where host events are not captured.
 
 On VHE systems there are no blackout windows.
+
+Perf Userspace PMU Hardware Counter Access
+==========================================
+
+Overview
+--------
+The perf userspace tool relies on the PMU to monitor events. It offers an
+abstraction layer over the hardware counters since the underlying
+implementation is cpu-dependent.
+Arm64 allows userspace tools to have access to the registers storing the
+hardware counters' values directly.
+
+This targets specifically self-monitoring tasks in order to reduce the overhead
+by directly accessing the registers without having to go through the kernel.
+
+How-to
+------
+The focus is set on the armv8 PMUv3 which makes sure that the access to the pmu
+registers is enabled and that the userspace has access to the relevant
+information in order to use them.
+
+In order to have access to the hardware counter it is necessary to open the
+event using the perf tool interface with config1:1 attr bit set: the
+sys_perf_event_open syscall returns a fd which can subsequently be used
+with the mmap syscall in order to retrieve a page of memory containing
+information about the event. The PMU driver uses this page to expose to
+the user the hardware counter's index and other necessary data. Using
+this index enables the user to access the PMU registers using the `mrs`
+instruction.
+
+The userspace access is supported in libperf using the perf_evsel__mmap()
+and perf_evsel__read() functions. See `tools/lib/perf/tests/test-evsel.c`_ for
+an example.
+
+About heterogeneous systems
+---------------------------
+On heterogeneous systems such as big.LITTLE, userspace PMU counter access can
+only be enabled when the tasks are pinned to a homogeneous subset of cores and
+the corresponding PMU instance is opened by specifying the 'type' attribute.
+The use of generic event types is not supported in this case.
+
+Have a look at `tools/perf/arch/arm64/tests/user-events.c`_ for an example. It
+can be run using the perf tool to check that the access to the registers works
+correctly from userspace:
+
+.. code-block:: sh
+
+  perf test -v user
+
+About chained events and 64-bit counters
+----------------------------------------
+Chained events are not supported in conjunction with userspace counter
+access. If a 64-bit counter is requested (attr.config1:0) with userspace
+access (attr.config1:1 set), then counter chaining will be disabled. The
+'pmc_width' in the user page will indicate the actual width of the
+counter which could be only 32-bits depending on the event and PMU
+features.
+
+.. Links
+.. _tools/perf/arch/arm64/tests/user-events.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/arch/arm64/tests/user-events.c
+.. _tools/lib/perf/tests/test-evsel.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/perf/tests/test-evsel.c
-- 
2.30.2

