Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1710C64ED6
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Feb 2023 11:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjB1Lx6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Feb 2023 06:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjB1Lxz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Feb 2023 06:53:55 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214E61B306
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 03:53:35 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id c23so9507941pjo.4
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 03:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dV9q9AQ7PpikYhUvBV5aI2kpk7FdoFpdqjCf8IW8jGw=;
        b=bCcgKbxuDOTflQKpoQhNx01CaIPNoYsiLM9Ib/2v90GsIsckcYB9ufRIPxmbyEXCKf
         qRMUwfQTsYit5fncJpmA3lwmlhki1UH51NQXi9Idyd9SQVNXxHWRPtfu3IyWgGOBBB2o
         7CbqDr3twqzrQ5UDaiiq3vucmOjVD1LCHlQqhwVIMLNsVsVLvNeUWxTkmcI3Utt+ydTe
         4L9Z2TysgigWiYg5G+32ZAdszy8K2yoIHSDpaInj5cCQYjoC1qOUqFEAj4tyjlRKMDNZ
         5Eeb5bD7P4u4s48MsDLNSBoH5Jv1gTgwOmRNJ5gwmsmQYL+qQ78CAaNne7xY9uKGcK3S
         IK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dV9q9AQ7PpikYhUvBV5aI2kpk7FdoFpdqjCf8IW8jGw=;
        b=3hRrHW5GD+eNe15zr2y46g1OBYMFj0uiJlwTO0rYhwwyjwvXnlOdcbXPuU1g1RjcYi
         qIkTKfncsvSMN/1V+4VoRokzCbFZ8W3O3X2Xwp9mqG5SSwERDohHDefXUaEUXrOQV0Xp
         32xRw72muoFheBzwdG+9Jq/RzWHexx5V595VfRiv5z7TBABZlSmS37/ulWUN5mdF3rMH
         ZcnVb6A7x6Jq20lEKwfHu9JaEtc0LZOtC/90Fps1jXRUxIepu9uPmUPvOTFOwF8l+UQK
         qvqNkHFBSBYEK9Vdwl4aZ1lEFtwIcrUQTkANp+M9OsyhgG37SmBg9w0VCrUdttMVVF8+
         oAZg==
X-Gm-Message-State: AO0yUKWvnpeCBonKZ+5S1dzwfZ137Z9JQkCd6agywoA2nIy9ffpQ6NQ1
        N144qpxyzh669U7VNyIPIFw9OA==
X-Google-Smtp-Source: AK7set93eWAJkgjHhW+UMztvbrVGCIilaOO8+EZEgmfBkfUxiVw5qkcsFtxCKI/KkVzq55wdoXqCNQ==
X-Received: by 2002:a17:90a:850a:b0:238:b70:b94 with SMTP id l10-20020a17090a850a00b002380b700b94mr3194461pjn.11.1677585208190;
        Tue, 28 Feb 2023 03:53:28 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id gk8-20020a17090b118800b002339491ead6sm7922317pjb.5.2023.02.28.03.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:53:27 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 07/14] perf kvm: Parse address location for samples
Date:   Tue, 28 Feb 2023 19:51:18 +0800
Message-Id: <20230228115125.144172-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228115125.144172-1-leo.yan@linaro.org>
References: <20230228115125.144172-1-leo.yan@linaro.org>
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
index 779881901a05..a9f467926bdd 100644
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
index a3219829c448..80d5c5a9ae31 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -7,6 +7,7 @@
 #include "tool.h"
 #include "sort.h"
 #include "stat.h"
+#include "symbol.h"
 #include "record.h"
 
 struct evsel;
@@ -86,6 +87,9 @@ struct perf_kvm_stat {
 	const char *sort_key;
 	int trace_vcpu;
 
+	/* Used when process events */
+	struct addr_location al;
+
 	struct exit_reasons_table *exit_reasons;
 	const char *exit_reasons_isa;
 
-- 
2.34.1

