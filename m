Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E22C6FD1C
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Mar 2023 11:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjCMLmj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 07:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjCMLmI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Mar 2023 07:42:08 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B63E664CC
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 04:41:36 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so11374260pjp.2
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 04:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678707693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgI7sIUXfEuJw5LLT6sg1Fr5x2zyVVOPMU2FeyfJj/s=;
        b=JSIqC98bHXd1HfroD6mo8qc6VuzWGpMiZiOthJxGbxLvgobrPsxvkG5EQWiZDRv19w
         8a/xOu07TOj4EYGKthPFFnp2SbxDfE0fbj3bSEFRiSxL4P/fUXW9F+kDAMPDzWtT/bd2
         SyjB158rjJK1DEIXNp+dd7yq+0P7jv0shgpYeDdvDZF9Nd8dGuuTZ6jkTa5/m6zh2Se0
         uK2kxdbbp1G6x/0vfMELj8w9TzaykirdcTQ5RDv67S9/bX6Zu7e+MLWdq/txA1aLnFB0
         r30Hwq9iMEbBMyK0a5eZwP+lTh0Vyr5MkZDlsVkuwX45BrDeM47pS5tdlHkWbtilq/v7
         7BgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgI7sIUXfEuJw5LLT6sg1Fr5x2zyVVOPMU2FeyfJj/s=;
        b=WbEvaFOt9OGIbZSiiWVj9zwRrUH7iCnfdb9C860neKj/s5cFh8vygRQXLxt4uDU+7V
         lhce7IiBrwS3fFzl27KuE2nHmdGm31dGIOKymSG+6Nr8bb3Nr+48rGDEOuI2jmgRPMrE
         PaQEAnOCbuaWFzNNEMXQaOWLJMyshapjfW3kzLJ3r4vHbprQyU/cORsxeftan6X8KKPl
         GmHlf+scqv0cpszHPWm7JX+b0HpmWFMSAZfPrDuUo4d7snW49glSSYwG6VmLq8/3erkU
         lIklBt5pwg4b+HtwHb7UolURnbsjdiBSnM0jxVmY7QF3lIdotQ0+vxWUDe/Rz2FIBnRC
         agig==
X-Gm-Message-State: AO0yUKXE1aQt5fRycIzi5vh9xK0NGJYXSnMvmMUh5RausC+BBXr7xsmj
        gn751vWrf/WhB/8h0qfynGSOLw==
X-Google-Smtp-Source: AK7set8lj7ygHJaxfEtsTufHlkoST0XAsShMw0uYRCqpWkwxzect/JSVGbVD3bocqyj/ONMhfjXT1Q==
X-Received: by 2002:a17:90a:53:b0:234:d1c:f112 with SMTP id 19-20020a17090a005300b002340d1cf112mr35281110pjb.0.1678707692996;
        Mon, 13 Mar 2023 04:41:32 -0700 (PDT)
Received: from leoy-huanghe.lan ([156.59.236.112])
        by smtp.gmail.com with ESMTPSA id q21-20020a17090a2e1500b0022335f1dae2sm4281625pjd.22.2023.03.13.04.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:41:32 -0700 (PDT)
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
Subject: [PATCH v4 12/16] perf kvm: Polish sorting key
Date:   Mon, 13 Mar 2023 19:40:14 +0800
Message-Id: <20230313114018.543254-13-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313114018.543254-1-leo.yan@linaro.org>
References: <20230313114018.543254-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since histograms supports sorting, the tool doesn't need to maintain the
mapping between the sorting keys and the corresponding comparison
callbacks, therefore, this patch removes structure kvm_event_key.

But we still need to validate the sorting key, this patch uses an array
for sorting keys and renames function select_key() to is_valid_key()
to validate the sorting key passed by user.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c   | 29 ++++++++++-------------------
 tools/perf/util/kvm-stat.h |  8 --------
 2 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index ba3134613bcb..1e9338855239 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -76,15 +76,6 @@ COMPARE_EVENT_KEY(min, stats.min);
 COMPARE_EVENT_KEY(count, stats.n);
 COMPARE_EVENT_KEY(mean, stats.mean);
 
-#define DEF_SORT_NAME_KEY(name, compare_key)				\
-	{ #name, cmp_event_ ## compare_key }
-
-static struct kvm_event_key keys[] = {
-	DEF_SORT_NAME_KEY(sample, count),
-	DEF_SORT_NAME_KEY(time, mean),
-	{ NULL, NULL }
-};
-
 struct kvm_hists {
 	struct hists		hists;
 	struct perf_hpp_list	list;
@@ -757,18 +748,18 @@ static bool handle_kvm_event(struct perf_kvm_stat *kvm,
 	return true;
 }
 
-static bool select_key(struct perf_kvm_stat *kvm)
+static bool is_valid_key(struct perf_kvm_stat *kvm)
 {
-	int i;
+	static const char *key_array[] = {
+		"ev_name", "sample", "time", "max_t", "min_t", "mean_t",
+	};
+	unsigned int i;
 
-	for (i = 0; keys[i].name; i++) {
-		if (!strcmp(keys[i].name, kvm->sort_key)) {
-			kvm->compare = keys[i].key;
+	for (i = 0; i < ARRAY_SIZE(key_array); i++)
+		if (!strcmp(key_array[i], kvm->sort_key))
 			return true;
-		}
-	}
 
-	pr_err("Unknown compare key:%s\n", kvm->sort_key);
+	pr_err("Unsupported sort key: %s\n", kvm->sort_key);
 	return false;
 }
 
@@ -1198,7 +1189,7 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 		return ret;
 
 	if (!verify_vcpu(kvm->trace_vcpu) ||
-	    !select_key(kvm) ||
+	    !is_valid_key(kvm) ||
 	    !register_kvm_events_ops(kvm)) {
 		goto out;
 	}
@@ -1393,7 +1384,7 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
 	if (!verify_vcpu(vcpu))
 		goto exit;
 
-	if (!select_key(kvm))
+	if (!is_valid_key(kvm))
 		goto exit;
 
 	if (!register_kvm_events_ops(kvm))
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 4385be769eee..35d03894fac3 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -49,13 +49,6 @@ struct kvm_event {
 	struct hist_entry he;
 };
 
-typedef int (*key_cmp_fun)(struct kvm_event*, struct kvm_event*, int);
-
-struct kvm_event_key {
-	const char *name;
-	key_cmp_fun key;
-};
-
 struct child_event_ops {
 	void (*get_key)(struct evsel *evsel,
 			struct perf_sample *sample,
@@ -98,7 +91,6 @@ struct perf_kvm_stat {
 	const char *exit_reasons_isa;
 
 	struct kvm_events_ops *events_ops;
-	key_cmp_fun compare;
 
 	u64 total_time;
 	u64 total_count;
-- 
2.34.1

