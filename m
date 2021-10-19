Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274BBC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 23:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08A66610D0
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 23:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhJSXVa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Oct 2021 19:21:30 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:35550 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhJSXV3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Oct 2021 19:21:29 -0400
Received: by mail-oo1-f49.google.com with SMTP id s2-20020a4ac102000000b002b722c09046so1485477oop.2;
        Tue, 19 Oct 2021 16:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=12dghxecuswptAmDfd0ZHuFdRzeHyPThhVojetDPh6o=;
        b=5qysKSTjryZafg69nWqo+svSNW9IShHC/rqZ9pAc+0sflEOgpdVuGd04WEOhBWL0Bd
         Ro3CyA2kUYNp11+ZfyoKFBMcR3BCGtONJOeFl0MKya3lhesWHtAIbLdCcbriYFzcWZ3j
         YsespOaLJRxqqDHPJ3QhSQ7DdN9CopE8IPKQhyM0xKuGMwau73dMtOfLtwUmPl0dX3Eb
         BHl8BNkX0x09JDNUfoSapt+PKB9MFT25x1CHDk9zA4GaW90mpFtEPYR+tI+h9Z+Qw4gD
         m7kUqEehw9B4Nt/ImK/g7SXw9PRN7SEZVy66sj4GxeyWXIN7fBQ1o98kVLPFFqYaP1gH
         IkCA==
X-Gm-Message-State: AOAM533zFNrsbTdw7EgYjAhg5fBiZvchoyP7O1dEVcTAx8phzhbOznML
        AcNS69iforQq8Z5AAQnNMQ==
X-Google-Smtp-Source: ABdhPJzW14NWOacuXzgTtPozxy+7kd2SUIhVdBGt/IoOC6+J8igZ64kX72La+2561OK+N4Bvk2vR4A==
X-Received: by 2002:a05:6820:1015:: with SMTP id v21mr7003715oor.47.1634685555920;
        Tue, 19 Oct 2021 16:19:15 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id w141sm118375oif.20.2021.10.19.16.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 16:19:15 -0700 (PDT)
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
        linux-perf-users@vger.kernel.org,
        Raphael Gault <raphael.gault@arm.com>
Subject: [PATCH v11 5/5] Documentation: arm64: Document PMU counters access from userspace
Date:   Tue, 19 Oct 2021 18:19:07 -0500
Message-Id: <20211019231907.1009567-6-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211019231907.1009567-1-robh@kernel.org>
References: <20211019231907.1009567-1-robh@kernel.org>
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
v11:
 - Rework chained event section to reflect 64-bit counter request may
   fail and 32-bit counters may be 64-bit with upper bits UNKNOWN.
v10:
 - Add details on perf_user_access sysctl
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
 Documentation/arm64/perf.rst | 75 +++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/perf.rst b/Documentation/arm64/perf.rst
index b567f177d385..70b9f718ea92 100644
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
 
@@ -88,3 +91,73 @@ exclude_host. However when using !exclude_hv there is a small blackout
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
+In order to have access to the hardware counters, the global sysctl
+kernel/perf_user_access must first be enabled:
+
+.. code-block:: sh
+
+  echo 1 > /proc/sys/kernel/perf_user_access
+
+It is necessary to open the event using the perf tool interface with config1:1
+attr bit set: the sys_perf_event_open syscall returns a fd which can
+subsequently be used with the mmap syscall in order to retrieve a page of memory
+containing information about the event. The PMU driver uses this page to expose
+to the user the hardware counter's index and other necessary data. Using this
+index enables the user to access the PMU registers using the `mrs` instruction.
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
+About chained events and counter sizes
+--------------------------------------
+The user can request either a 32-bit (config1:0 == 0) or 64-bit (config1:0 == 1)
+counter along with userspace access. The sys_perf_event_open syscall will fail
+if a 64-bit counter is requested and the hardware doesn't support 64-bit
+counters. Chained events are not supported in conjunction with userspace counter
+access. If a 32-bit counter is requested on hardware with 64-bit counters, then
+userspace must treat the upper 32-bits read from the counter as UNKNOWN. The
+'pmc_width' field in the user page will indicate the valid width of the counter
+and should be used to mask the upper bits as needed.
+
+.. Links
+.. _tools/perf/arch/arm64/tests/user-events.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/arch/arm64/tests/user-events.c
+.. _tools/lib/perf/tests/test-evsel.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/perf/tests/test-evsel.c
-- 
2.32.0

