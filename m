Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCBCC6FD19
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Mar 2023 11:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjCMLmN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 07:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjCMLls (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Mar 2023 07:41:48 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4050064AAA
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 04:41:16 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so2240345pjv.5
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 04:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678707675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygfxx0XS0Skh5yEpdT4mJzv/3MvrNT373bzz9DkGUB4=;
        b=Wx+waaKfMUU6sOzzAcpMsIz/5BgPy51Sblvw1oxRbHogJwZiGABhiwdqf6tgtxoeoz
         5oLuApkLypxZxAgAxFFdYLgGGYrQ1oxxygX8eLckC+tNwe3Lvmr2hCowAnbpyb9GNbKm
         QvDKXioBA7ru6YXqZwqdYfvJiDCmS9SpsKYfkuO8tOfP25d8qeV3edxXdljXuEqXg6TQ
         O0Z2T6EvHYY/utz6arVSdDaDdJmg8/At3PxKKCDTA70ongM5sI/D4cLdE0498R74b4Ps
         jnATtrCs+a5HB49xL9Vwdt2CaQP0OnVDyXwEFu/AEMLqiLAqQirFqrhQ/TmV7E0M8OXx
         n+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygfxx0XS0Skh5yEpdT4mJzv/3MvrNT373bzz9DkGUB4=;
        b=x9z7WgyjPo2ox+458c4nkHJMTb06Nefalut76RuONN6rPjsoQJDv+rw19O2fbS3KO3
         dXr+jacu/ph3OJhCKB1G3GMKmvfmwufRhV2tdw0uBycYdJcEUxT3DTXIoOYXxamPQwXH
         VOC7/a0ksjjS4HYmDri+64hBTdOOoXN4AslizLmNM67thpOL0EANWJSYp1u3WUGuOuyR
         8F+SOGMRSn043So0gdSeBMoyuOLeFdEKa2IVDXHgByB3bOxcsN/HNL7rB6ywZnphhgOe
         Pr4LN70cq+TmCY6mjzvvjb52ka+bvd7qBT8jICyv7u5oAcM7xRkHJMV5yNQRhJhjswkU
         Z0Vw==
X-Gm-Message-State: AO0yUKUBLOZggSzKI8bv8tsIsr1+QdVLGmsc3TWIWmgwgb4pu66IxjVS
        wgn7Tlxb6hXr7OBpzZoJh+acPA==
X-Google-Smtp-Source: AK7set/Dozj1HoRO5RN3CbjTkCs7qKoMXvP2jNYP2m6mHopQoT7G2BMN6DBnf4OsRGhIq6GidEqVoA==
X-Received: by 2002:a17:90a:3ea3:b0:23b:4614:6f84 with SMTP id k32-20020a17090a3ea300b0023b46146f84mr6304138pjc.28.1678707675655;
        Mon, 13 Mar 2023 04:41:15 -0700 (PDT)
Received: from leoy-huanghe.lan ([156.59.236.112])
        by smtp.gmail.com with ESMTPSA id q21-20020a17090a2e1500b0022335f1dae2sm4281625pjd.22.2023.03.13.04.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:41:15 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 08/16] perf kvm: Parse address location for samples
Date:   Mon, 13 Mar 2023 19:40:10 +0800
Message-Id: <20230313114018.543254-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313114018.543254-1-leo.yan@linaro.org>
References: <20230313114018.543254-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Parse address location for samples and save it into the structure
'perf_kvm_stat', it is to be used by histograms entry.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/builtin-kvm.c   | 5 +++++
 tools/perf/util/kvm-stat.h | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 5ea723fd45a4..fa91c8deb628 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -704,6 +704,11 @@ static int process_sample_event(struct perf_tool *tool,
 	if (skip_sample(kvm, sample))
 		return 0;
 
+	if (machine__resolve(machine, &kvm->al, sample) < 0) {
+		pr_warning("Fail to resolve address location, skip sample.\n");
+		return 0;
+	}
+
 	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
 	if (thread == NULL) {
 		pr_debug("problem processing %d event, skipping it.\n",
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index a53cebe519b3..2d791b04379a 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -7,6 +7,7 @@
 #include "tool.h"
 #include "sort.h"
 #include "stat.h"
+#include "symbol.h"
 #include "record.h"
 
 #define KVM_EVENT_NAME_LEN	40
@@ -88,6 +89,9 @@ struct perf_kvm_stat {
 	const char *sort_key;
 	int trace_vcpu;
 
+	/* Used when process events */
+	struct addr_location al;
+
 	struct exit_reasons_table *exit_reasons;
 	const char *exit_reasons_isa;
 
-- 
2.34.1

