Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A8FC64ED6
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Feb 2023 08:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjB1Imz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Feb 2023 03:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjB1Img (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Feb 2023 03:42:36 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD152C661
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 00:42:25 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id s18so5170008pgq.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 00:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JA7VJN/YcBA7IE+nNQeWn+LVdWT4KUb0IqvxyHZoo8o=;
        b=TaKqzF4fkHx5FMQJrc7Qn29J3OPeZcAJPQroEmohQUPT7jJYUmB/Bo6bd1GLmYaM1e
         nWuwUxt4NKDT6UJ+GLYE347CkDV8/VPmso6YmvyLJl0gWLxTQWVlUOlHyoUutACNJ7SK
         9WkIZGUl37Ff166uVCKyhLxwsBULGIvgIUXbVs33/0U09eigKTBx8OOzr5p0ZDKIc4tA
         l9GYgBuSPKr99Og9saGMRoVIAoyPqjD4l0MhZNICab8KrlOmRZJB//5tTiakQHX83yw7
         X+aX1MReDT9UP9Ue3dTxkR0eRg5sAhRYbzNZ7KBjUgk7/ijJiO5qZm7+yCxdlRHGuz67
         3FnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JA7VJN/YcBA7IE+nNQeWn+LVdWT4KUb0IqvxyHZoo8o=;
        b=Ym8n+/kD67FzyrAIzcHbhHMPF5h7laGMvvH57gDo1GSX6dAT4SKY37XZyF19ZYimEM
         rsYTHJyxfI+5j2eyKJgeRbtlAI3EgfjjMr/VgR08C/hC3zvf4HeJV5+6xIFCoEkshqpe
         c+3btiHwQA0lbxaNgj5Ptexmp1eQaBlSvOoYSKUlHKmkyFxuSVe2iOz/DgOQLPCijfJd
         SCbfIzpXuQxL4rgb5EuIy1n61olwiIFH+Ycd4iT3vy8Cqj8zc/IWA30aiescJQsBYFj7
         ps9AWFJG3JCcXRVxIrFrHywIWCMUZ6ooM1BazJraTCd+Uo/vhCIiikTQjVJ6bBYLCYG3
         vFmA==
X-Gm-Message-State: AO0yUKXDQ6XoXzhb3ZyU0EIeDHyWGPn9cRdHkmeR0F0PUDDbwsluEg7n
        uvq1XL/MrE8nfYKSDX/EMMpF/w==
X-Google-Smtp-Source: AK7set9hVj2auAd83YBjpabCLy1tQrIQZQMd0GDf3YnhJgB0ts2wAbaX4IZy0CNgaRZ4P49Ec06uBQ==
X-Received: by 2002:a05:6a00:1:b0:5dc:4b6:b18d with SMTP id h1-20020a056a00000100b005dc04b6b18dmr1350020pfk.26.1677573745013;
        Tue, 28 Feb 2023 00:42:25 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78499000000b005d6fcd8f9desm5681270pfn.94.2023.02.28.00.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 00:42:24 -0800 (PST)
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 05/14] perf kvm: Introduce histograms data structures
Date:   Tue, 28 Feb 2023 16:41:38 +0800
Message-Id: <20230228084147.106167-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228084147.106167-1-leo.yan@linaro.org>
References: <20230228084147.106167-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is a preparation to support histograms in perf kvm tool.  As first
step, this patch defines histograms data structures and initialize them.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c   | 18 ++++++++++++++++++
 tools/perf/util/kvm-stat.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 6eec0db2dda6..4ae54ba4fdaf 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -85,6 +85,20 @@ static struct kvm_event_key keys[] = {
 	{ NULL, NULL }
 };
 
+struct kvm_hists {
+	struct hists		hists;
+	struct perf_hpp_list	list;
+};
+
+static struct kvm_hists kvm_hists;
+
+static int kvm_hists__init(void)
+{
+	__hists__init(&kvm_hists.hists, &kvm_hists.list);
+	perf_hpp_list__init(&kvm_hists.list);
+	return 0;
+}
+
 static const char *get_filename_for_perf_kvm(void)
 {
 	const char *filename;
@@ -957,6 +971,8 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 	set_term_quiet_input(&save);
 	init_kvm_event_record(kvm);
 
+	kvm_hists__init();
+
 	signal(SIGINT, sig_handler);
 	signal(SIGTERM, sig_handler);
 
@@ -1152,6 +1168,8 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
 	init_kvm_event_record(kvm);
 	setup_pager();
 
+	kvm_hists__init();
+
 	ret = read_events(kvm);
 	if (ret)
 		goto exit;
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 40a4b66cfee6..a3219829c448 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -5,6 +5,7 @@
 #ifdef HAVE_KVM_STAT_SUPPORT
 
 #include "tool.h"
+#include "sort.h"
 #include "stat.h"
 #include "record.h"
 
-- 
2.34.1

