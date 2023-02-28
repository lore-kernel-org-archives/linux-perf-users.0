Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB853C64ED6
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Feb 2023 08:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjB1ImW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Feb 2023 03:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjB1ImS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Feb 2023 03:42:18 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7147E2BED3
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 00:42:10 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id y10so5185751pfi.8
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 00:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6XdpHkz8A8bOxvOk1eGAORWD0fU8Q/VwNFknF3nlZE=;
        b=mWqhXspGGie2v+/qH4efLRdPLhBL9yNjeEj0DmwmCPSWJ5RpzlqS2O8qUH225jkUAl
         bmVpuSeh+jt7e2gbU343J/lvD2b7ylgYWtQ+MmZdt+X/0Acq9OF6l+ePyjlnc/5WqK0b
         80UjTmv12TkEBMbogN2UL6Pn2SCalynD7CFcbB0dKctUTiZ4wKQuJYAV634+28EHa95C
         xFKEHNpqjCUKyZiy5HwXm1YyKfS13/mqe5OB0L7fRZi7KMoJSXcBJTO4BHKfvQFYigeD
         vZPVx6nt8f5MczzD+2n2Gqqta5Eeb4AehPe6nGl2qwPsSpN1qErcugXGyZ1pv8CeacUY
         HZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6XdpHkz8A8bOxvOk1eGAORWD0fU8Q/VwNFknF3nlZE=;
        b=6IVpylP1NrDhHn+Uskfc46ewFWrKNQyLYU2QSscgX559bt6k4k2w0cPHsD3RIGJfi4
         rm717570Pn6HoPGWgOqeeidTSwR7jA/FQEj8PtF/AvQym68vE1IcV0VGX2R0AotOB1b/
         fdnJJ4INCIcgVQGuZAAUvgR3u1pZHabiocj+HEMnyq4afU+Jit/DFFqwYO9N4KKz3tIw
         iEVYthlkNmMwcyIaPbBLkWrCq7ADu4HenQWkEqY1vGjHUHaUwZ8EOBTJgAOv4K7xYTIc
         XxYf6oHk+IQEc2SM1jLE8lJgjO4MsBDBP26Uec7RiBkobBYDLylGBW/sxH5psAoV1dEw
         9KgQ==
X-Gm-Message-State: AO0yUKUVX9h/Pwnct7DUYXPbUwZcfikKKATcSQEbMzyZaQfiJnUGheYv
        sGQ8DVpV5KV/dyDdLSCqlQZdRg==
X-Google-Smtp-Source: AK7set+PRP5y4J2uOON7M98lN9JQTTyBpJxYB4d3EKe49ySCFAeA87aonnG+GQu1FJMLh9w7L3CFNQ==
X-Received: by 2002:aa7:9d84:0:b0:5e1:255b:6fc4 with SMTP id f4-20020aa79d84000000b005e1255b6fc4mr1848131pfq.30.1677573729648;
        Tue, 28 Feb 2023 00:42:09 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78499000000b005d6fcd8f9desm5681270pfn.94.2023.02.28.00.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 00:42:09 -0800 (PST)
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
Subject: [PATCH v2 01/14] perf kvm: Refactor overall statistics
Date:   Tue, 28 Feb 2023 16:41:34 +0800
Message-Id: <20230228084147.106167-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228084147.106167-1-leo.yan@linaro.org>
References: <20230228084147.106167-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently the tool computes overall statistics when sort the results.
This patch refactors overall statistics during events processing,
therefore, the function update_total_coun() is not needed anymore, an
extra benefit is we can de-couple code between the statistics and the
sorting.

This patch is not expected any functionality changes.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 641e739c717c..0172e5b0d26e 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -278,9 +278,14 @@ static double kvm_event_rel_stddev(int vcpu_id, struct kvm_event *event)
 				avg_stats(&kvm_stats->stats));
 }
 
-static bool update_kvm_event(struct kvm_event *event, int vcpu_id,
+static bool update_kvm_event(struct perf_kvm_stat *kvm,
+			     struct kvm_event *event, int vcpu_id,
 			     u64 time_diff)
 {
+	/* Update overall statistics */
+	kvm->total_count++;
+	kvm->total_time += time_diff;
+
 	if (vcpu_id == -1) {
 		kvm_update_event_stats(&event->total, time_diff);
 		return true;
@@ -399,7 +404,7 @@ static bool handle_end_event(struct perf_kvm_stat *kvm,
 		}
 	}
 
-	return update_kvm_event(event, vcpu, time_diff);
+	return update_kvm_event(kvm, event, vcpu, time_diff);
 }
 
 static
@@ -526,15 +531,6 @@ static void insert_to_result(struct rb_root *result, struct kvm_event *event,
 	rb_insert_color(&event->rb, result);
 }
 
-static void
-update_total_count(struct perf_kvm_stat *kvm, struct kvm_event *event)
-{
-	int vcpu = kvm->trace_vcpu;
-
-	kvm->total_count += get_event_count(event, vcpu);
-	kvm->total_time += get_event_time(event, vcpu);
-}
-
 static bool event_is_valid(struct kvm_event *event, int vcpu)
 {
 	return !!get_event_count(event, vcpu);
@@ -549,7 +545,6 @@ static void sort_result(struct perf_kvm_stat *kvm)
 	for (i = 0; i < EVENTS_CACHE_SIZE; i++) {
 		list_for_each_entry(event, &kvm->kvm_events_cache[i], hash_entry) {
 			if (event_is_valid(event, vcpu)) {
-				update_total_count(kvm, event);
 				insert_to_result(&kvm->result, event,
 						 kvm->compare, vcpu);
 			}
-- 
2.34.1

