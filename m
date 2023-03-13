Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A2CC6FD19
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Mar 2023 11:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjCMLmA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 07:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjCMLld (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Mar 2023 07:41:33 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FEA6546B
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 04:41:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so1805180pjz.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 04:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678707667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSdUbtxY1+Pylww6c27L2gmYy3OoEmd30YUAl5uUuD4=;
        b=JdCN4DnjsIz8YM3uGExs6pbkHrIiWnJ/jCXj3wqhLn3yYf0rTHXThsN/8y65TcJYDH
         ORkO3CS9JgQi6TrHXBccQXUpAOoxrP3021V2614gp/rDRlP3XvIYGQMKNzOicBpd25ZY
         1M/Ya7gznDe5xSpPhVONXi38ESzr9rkKoMeRnkyDrc62UjSY4LQ0l9U3SxEo3L4pOI5g
         wkbaVz0+wa8QCUqXc0INVPCGd9WXY/NqWEqahFhnCk4Uzp2aAasqU2mt8UZBzE4roxT6
         j+THZ/H8Vb39Kj59OrEIRBUKLdFZ68n6gMWKI4H9zJaM5ShqvCeI4HPKnC0C/5Cp3PBL
         7BZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSdUbtxY1+Pylww6c27L2gmYy3OoEmd30YUAl5uUuD4=;
        b=B71fbYwyp9QR0ooqaJXkfOzwIQVnenvPEQB5SCoByJ+Rty0USR9tQgRkfGZ6C4HULr
         sszFFhsl109cM35N4Rw6T1IKLbi0eu79qBMTXFe+LOwgO9XvKcsvAsqmJfPZJ1DL+vb2
         O14m5eZgpF9Z+ylvMoJYebc2fdLs/CKUmw1BmIpTj5IGAzUEEoaZSfA23BmEOHhhzCYU
         yqwayahT2r5fKqv2RwDUmZBaEa+Geb4OdLKWW4x2mwtPpTC6HOMGdeXcjlQUohH1ZKGt
         S48038hz71m56BzF4FeUClYIYH1XYPpH1NcZrV/Q6vtaobq7z3WWCVBH1/ED3uqPm913
         EceQ==
X-Gm-Message-State: AO0yUKVH5rXsB8x4kPvijOSE6DOZ708fjggpljarpthPSVDsBbrBlZOl
        l2ZaboR3TkxF4Toj6xAdvaedVg==
X-Google-Smtp-Source: AK7set+I4pJRklsniO4bIb9F5JsmmXbJnyucsWHWv8Gcq4NOTrgG603vO5mGR2pP4FkasqnfbzhYpQ==
X-Received: by 2002:a17:90b:4d04:b0:230:81e9:ebb4 with SMTP id mw4-20020a17090b4d0400b0023081e9ebb4mr33650785pjb.10.1678707667093;
        Mon, 13 Mar 2023 04:41:07 -0700 (PDT)
Received: from leoy-huanghe.lan ([156.59.236.112])
        by smtp.gmail.com with ESMTPSA id q21-20020a17090a2e1500b0022335f1dae2sm4281625pjd.22.2023.03.13.04.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:41:06 -0700 (PDT)
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
Subject: [PATCH v4 06/16] perf kvm: Introduce histograms data structures
Date:   Mon, 13 Mar 2023 19:40:08 +0800
Message-Id: <20230313114018.543254-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313114018.543254-1-leo.yan@linaro.org>
References: <20230313114018.543254-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is a preparation to support histograms in perf kvm tool.  As first
step, this patch defines histograms data structures and initialize them.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/builtin-kvm.c   | 18 ++++++++++++++++++
 tools/perf/util/kvm-stat.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index d400434aa137..384992c8a01a 100644
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
index e84f1cdcfe05..a53cebe519b3 100644
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

