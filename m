Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D852DC6FD1D
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Mar 2023 14:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjCOOw5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Mar 2023 10:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjCOOwr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Mar 2023 10:52:47 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E742599C11
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Mar 2023 07:52:19 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d13so9043084pjh.0
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Mar 2023 07:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678891936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxPULJO486xqHJLRx8ubmkrWzwK0iscBf1dUdchHcWA=;
        b=ZG/EslB6f9/yZgtygYyLalr/i45+cTyqD6wRGVjTxOdd7TWk/8vE9TdItJGBNewgvh
         3KbsUsgRWQXrncEp3I3jNl3GYazW55VQF/E1YK7YcNix0tfCf+T4GCHgNBOTkIoeavo5
         152APIwoh4PuPEuyfV2T+1L0ZlK9MmzttdZHQATRNTyFQ9JzwrIl7bBMLnV1DdGZvk7R
         n0MiLIGN+11YRriy+F6haDjrxnbBu2fXfDIp2XP/rlLlZL1dFunykx1yMhHmEU02sriM
         W9dPj2mht+HhvdEYnC+8cqXLqvyIDe/sfVGBaxlezH+Nh0T14MX4032pNzqW9nstfYDD
         MBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678891936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxPULJO486xqHJLRx8ubmkrWzwK0iscBf1dUdchHcWA=;
        b=Zk8FVZ9UZ9+HCJwCM5uZnrUFw4jh5/S6RClzj4SKrdQEx/RvU45Fm+/8pa3IkHOxQh
         XfvI+m1BD1qCEapW8Bl8KBpUcZ/gEcONsrfosc3jjahtmhnAPaTEqqTkay8hOwgJ9DhD
         UMurRhh6VUxVbTZGlsTIDzKZPIw4bLJtSt2dn9z6Ol+9ZGaHxejMa80PwI3O9TsA/8gB
         3GZ1YZIZLDfrebdSEUWLTzGYYYGOQAioJHWq1HuD2Bw3uTo0RhCzFBoHsES4jLmzfscU
         Yqj6TOYKYRNh/NnG0KqIZwzUew5QRlnR3JEMNKlDGQhlb2zdrqS9vwBVF3U14PZOFoPA
         xxfw==
X-Gm-Message-State: AO0yUKUdSUrKiOBelMs+P+V3L4uitZeXs7lA/MwKyy8zZ7zkxEW1WgFs
        uJ03WH9La1oYVztCVoaUu3XcdQ==
X-Google-Smtp-Source: AK7set8ko9n4ei4Die1EmIH61gaaEgOSpmUg0Rela+nxsidAZyB6jjslXFnUZTGMDc+45BGJhugZOQ==
X-Received: by 2002:a17:902:da8d:b0:1a0:6bd4:ea78 with SMTP id j13-20020a170902da8d00b001a06bd4ea78mr3242115plx.31.1678891935892;
        Wed, 15 Mar 2023 07:52:15 -0700 (PDT)
Received: from leoy-huanghe.lan ([107.151.177.133])
        by smtp.gmail.com with ESMTPSA id kh3-20020a170903064300b0019926c77577sm3781587plb.90.2023.03.15.07.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:52:15 -0700 (PDT)
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
Subject: [PATCH v5 08/16] perf kvm: Parse address location for samples
Date:   Wed, 15 Mar 2023 22:51:04 +0800
Message-Id: <20230315145112.186603-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315145112.186603-1-leo.yan@linaro.org>
References: <20230315145112.186603-1-leo.yan@linaro.org>
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
index e2c17662bac7..3b2eab91a9be 100644
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

