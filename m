Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90367C64ED6
	for <linux-perf-users@archiver.kernel.org>; Sun, 26 Feb 2023 04:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjBZEVr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 25 Feb 2023 23:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjBZEVf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 25 Feb 2023 23:21:35 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97E7BDFD
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Feb 2023 20:21:25 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id k21-20020a17090aaa1500b002376652e160so3149592pjq.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Feb 2023 20:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JA7VJN/YcBA7IE+nNQeWn+LVdWT4KUb0IqvxyHZoo8o=;
        b=yphIfzPv05IfIc6/1JjUPJ2e4gRqh66jjIcuDpczDTonK4ArNDx4y+So9iG0FMtm+/
         fwWtRRUmcMe1HVG0qrTS8NjNGGMnRU9KhkbxYie5RvfCuq7/FgRvvmaJzxwydmMkjVzu
         UnbD24ww//iKoNLFEDWeX4KsWPKo4L3T05BneHWWd5BqF+AWwutZPpmnBmKMHojrRPmB
         3VFlySGh9zIo3/PNDaXbHTEjGeb1AlwlxtwACkBH6vGUKuLwkSlxdpN1B6TP/nsPqkyW
         qoWK9BoM5ZaMZggeuyCqYR+kDHIyZn/Z6sfAlqzH/yJfPDC6k7RYPGElCxaxc3g+dVXk
         GRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JA7VJN/YcBA7IE+nNQeWn+LVdWT4KUb0IqvxyHZoo8o=;
        b=k7i80tF15FjE6vkgill4OBlhveiGBn7U0c4cvwDBFfAEJJ40BKDLO/xIbLuUdQc7oi
         8HDwSfwVWj/o8vD8VsnFc4mhi3DVkFfbNOrGUYNHjMzV6dkHasaGZ6dfThGMJTyGgAxu
         yrVRmQPfDulS48Okakq9vCcw6WTS3Ucf8rGUWVSctKcwmU+tuE+Z35a4loZcBGFhuvgm
         nE5wruutgKpxJi4kbkb6TR0pmLDP1SPpnKIzExl8gRQvPH5ypc8K9VHQluXjxwTCKLt1
         cKYOt3TRlJmqw15IRQZE19fro4UoXxpaHZBYEGboafLhRfJDFEY297XbuKvRYLd/EFfk
         hfOw==
X-Gm-Message-State: AO0yUKUvtffKt1wmuOL6xgC8wXmRCyS9VEWiN5UOR0YDQ6v1hg0I30Do
        ghJU/HnjYrs7X0QNQ8qOhW3QXQ==
X-Google-Smtp-Source: AK7set8vNeV+3T/sIVqYTTFSdekoL/MKxMsPS57H24aP7VTKLtxQw18XhaGNJw89YOrVjSHLRaRg1A==
X-Received: by 2002:a17:903:2283:b0:19a:ae30:3a42 with SMTP id b3-20020a170903228300b0019aae303a42mr5383543plh.21.1677385285179;
        Sat, 25 Feb 2023 20:21:25 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id jj2-20020a170903048200b0019aaab3f9d7sm1976036plb.113.2023.02.25.20.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 20:21:24 -0800 (PST)
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
Subject: [PATCH v1 05/14] perf kvm: Introduce histograms data structures
Date:   Sun, 26 Feb 2023 12:20:44 +0800
Message-Id: <20230226042053.1492409-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226042053.1492409-1-leo.yan@linaro.org>
References: <20230226042053.1492409-1-leo.yan@linaro.org>
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

