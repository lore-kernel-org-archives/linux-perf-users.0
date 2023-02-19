Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEE2C636CC
	for <linux-perf-users@archiver.kernel.org>; Sun, 19 Feb 2023 09:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjBSJej (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 19 Feb 2023 04:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjBSJe3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 19 Feb 2023 04:34:29 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE24126DE
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Feb 2023 01:33:20 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-53686d8ce27so20566157b3.5
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Feb 2023 01:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IJq6auQeIidM24mfR/8eo3ksFWhAxhvnpDKY7OwBaGQ=;
        b=I7CnQOuWj57M+eY5KPLUsxlKb0JE3mtO9u5wKbbUpyvJmy+FSZG+GD25OOiBvunIGK
         Q2dHAsWmeS/qQ2obRvPvqxghBPvmo9xgjx5OjGAKmTc0mkIK9Y/AldxC7enwDlI4MWTt
         nR/l/y/IJF+yvccRElbcBsPK+/7hGdcJeqKbmIc9JCFFuv9oTrEoI0/ujyZ5AvH92wC/
         EWoa3QlfPbYhWYZYHRA9iDFVl9xjc2KK7BL4RV4MYYfzreMAZCNLDg6ZS77C3hgZ8snp
         OZaDgveoVLXlEl2+8JzeckNGBVk4n0JGZzDd/DNEEguY7CzJddiyOUYqxZVM54HziTNG
         FPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJq6auQeIidM24mfR/8eo3ksFWhAxhvnpDKY7OwBaGQ=;
        b=WNdItlftmjPxIlfyL+AcXUuq5L96DPnsOp43RCkdp+cKsJ+nj84rxosTi/2DSOhrJH
         LnyKr3WxmwLenpzdbt0nBRFDwHTfiSCW1tEHyiIDRr9evGzXJHKHWS95eR8AUYyCQG1V
         cfzckcTycDl7Qt3cDPRa4E3LFCrKYAnjv2zQn3hAa0mqUmIGExyzJPoLsbtqV4w0ndmR
         8FfJgGcZ/Mr4gLR4D7v57cplc8SK8645FhaRy9g1XAUlrPB0gmghxDqZaDgW8RbGRNKF
         Dsx6VgXm+cQw1+172ROJMOtZ1DHknLwOUuYKUKrtuAZKb7K3FwEc9iGhSgKWjIrK8i5g
         XMFw==
X-Gm-Message-State: AO0yUKVG0eRmd7XKgd7b7UqXx/vdfmbuYRLqa3Epk72+Pu2nlyhMVFI8
        7iQi8K5iEV8bZHQHCnRY5f+2Q6R2PiCZ
X-Google-Smtp-Source: AK7set+GnZ9gFfxc43R+jNIxKixL5ZeQEmGo9LILMyNpwr7wkrR1rWIpoCob76eZaJRDrU/m7/FQ6z5YBgsq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a81:af07:0:b0:534:2d49:790a with SMTP id
 n7-20020a81af07000000b005342d49790amr113313ywh.0.1676799199716; Sun, 19 Feb
 2023 01:33:19 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:28 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-32-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 31/51] perf vendor events intel: Refresh westmereep-dp events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Update the westmereep-dp events from 3 to 4. Generation was done
using https://github.com/intel/perfmon.

The most notable change is in corrections to event descriptions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv                      | 2 +-
 tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json         | 2 +-
 .../perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index bc2c4e756f44..1c6eef118e61 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -28,7 +28,7 @@ GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v54,skylake,core
 GenuineIntel-6-55-[01234],v1.29,skylakex,core
 GenuineIntel-6-86,v1.20,snowridgex,core
 GenuineIntel-6-8[CD],v1.10,tigerlake,core
-GenuineIntel-6-2C,v3,westmereep-dp,core
+GenuineIntel-6-2C,v4,westmereep-dp,core
 GenuineIntel-6-25,v3,westmereep-sp,core
 GenuineIntel-6-2F,v3,westmereex,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
index 5c897da3cd6b..4dae735fb636 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
@@ -182,7 +182,7 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "L2 lines alloacated",
+        "BriefDescription": "L2 lines allocated",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.ANY",
         "SampleAfterValue": "100000",
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
index ef635bff1522..f75084309041 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
@@ -56,7 +56,7 @@
         "UMask": "0x80"
     },
     {
-        "BriefDescription": "DTLB misses casued by low part of address",
+        "BriefDescription": "DTLB misses caused by low part of address",
         "EventCode": "0x49",
         "EventName": "DTLB_MISSES.PDE_MISS",
         "SampleAfterValue": "200000",
-- 
2.39.2.637.g21b0678d19-goog

