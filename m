Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E72C61DA4
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Mar 2023 11:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjCMLku (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 07:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjCMLks (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Mar 2023 07:40:48 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7BA64226
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 04:40:47 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id rj10so1125636pjb.4
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 04:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678707647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uN7zwUTTarFdEEyI4xavpEstkRipyyWqLXdanEnFXps=;
        b=ys+dsTy2vh5IRMXu/71+ZQS9QxgiwshRjarRfNFvlFiW60uTbW/yU0lWs+E37FB4qz
         VSPJHNbcO33USpFkL/q9Adz8H03Zhlk0Q3tIsXazE/d9+g8USW9+18mTPEORCn6mP9wx
         JF1xEietU5qPMMzExkFMe/Q1aL0hz7F5EL2rxl6sh3mclaE+XDHgej7K0aEcXF/fl2tQ
         k01DVC2W2dXjTDnptjKW/fRRstP2X41ql9tXQKTnmvbDl/QR3Of8lQuxNexFkTPbfVaN
         IERCN2JEGZC1Sp4Gw2tU8tbCM85A9E2bqYLC42pgd8r309b/27IP4+aWTujQPYJtuOE2
         oWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uN7zwUTTarFdEEyI4xavpEstkRipyyWqLXdanEnFXps=;
        b=snKtuUdVWceJrdtwU2rIzzjwQBJ1Go9mQwOdC0hByBDCESrXczMIBx4eF0e2H5/ArJ
         MHgxr5hU+PDZkvwSajuGRjQIuspHB8rK5v1f8XJ2s5Ts3JYaa+ccubexSHG1qNu0zjJ/
         KT4DSQ8T2aD5rKEL9uKsm/egG4zm/NQw3NhlKGkw2Q6/giwAYjd0SRMaRqL5+ZAoxo6A
         2bwF8+QDSc00DCNaTLYvKt6Ui0fCSvMaGRI1zYDkJoqBqC7BjGXgSW/XxxeJAMjnGnMa
         YOYkJN17QtPEDHmuNdAnW31s8swENcw31mP7f7bvrGBog6Q+xVLxIBBv5UagN2dsD4ee
         j2Ug==
X-Gm-Message-State: AO0yUKVYptf6DxUagsngP/sIoPEL1tpefIS/Axp+4HdeABNhfhPdqgeG
        dZMJhY1WjdLmvtOHOWGZRdYpEg==
X-Google-Smtp-Source: AK7set9XabVkPC0XB7oQedZ03RgD/a3sbthW1LOnLfUx8dkqc7s8K45x5xD5S1HL2sqJ+GK0fRCdqQ==
X-Received: by 2002:a17:90a:ec13:b0:23d:9ae:a49a with SMTP id l19-20020a17090aec1300b0023d09aea49amr2896119pjy.30.1678707647136;
        Mon, 13 Mar 2023 04:40:47 -0700 (PDT)
Received: from leoy-huanghe.lan ([156.59.236.112])
        by smtp.gmail.com with ESMTPSA id q21-20020a17090a2e1500b0022335f1dae2sm4281625pjd.22.2023.03.13.04.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:40:46 -0700 (PDT)
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
Subject: [PATCH v4 02/16] perf kvm: Add pointer to 'perf_kvm_stat' in kvm event
Date:   Mon, 13 Mar 2023 19:40:04 +0800
Message-Id: <20230313114018.543254-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313114018.543254-1-leo.yan@linaro.org>
References: <20230313114018.543254-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Sometimes, handling kvm events needs to base on global variables, e.g.
when read event counts we need to know the target vcpu ID; the global
variables are stored in structure perf_kvm_stat.

This patch adds add a 'perf_kvm_stat' pointer in kvm event structure,
it is to be used by later refactoring.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/builtin-kvm.c   | 6 ++++--
 tools/perf/util/kvm-stat.h | 5 +++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 0172e5b0d26e..3d2560ec6b37 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -209,7 +209,8 @@ static bool kvm_event_expand(struct kvm_event *event, int vcpu_id)
 	return true;
 }
 
-static struct kvm_event *kvm_alloc_init_event(struct event_key *key)
+static struct kvm_event *kvm_alloc_init_event(struct perf_kvm_stat *kvm,
+					      struct event_key *key)
 {
 	struct kvm_event *event;
 
@@ -219,6 +220,7 @@ static struct kvm_event *kvm_alloc_init_event(struct event_key *key)
 		return NULL;
 	}
 
+	event->perf_kvm = kvm;
 	event->key = *key;
 	init_stats(&event->total.stats);
 	return event;
@@ -238,7 +240,7 @@ static struct kvm_event *find_create_kvm_event(struct perf_kvm_stat *kvm,
 			return event;
 	}
 
-	event = kvm_alloc_init_event(key);
+	event = kvm_alloc_init_event(kvm, key);
 	if (!event)
 		return NULL;
 
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 6f0fa05b62b6..40a4b66cfee6 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -24,10 +24,13 @@ struct kvm_event_stats {
 	struct stats stats;
 };
 
+struct perf_kvm_stat;
+
 struct kvm_event {
 	struct list_head hash_entry;
 	struct rb_node rb;
 
+	struct perf_kvm_stat *perf_kvm;
 	struct event_key key;
 
 	struct kvm_event_stats total;
@@ -44,8 +47,6 @@ struct kvm_event_key {
 	key_cmp_fun key;
 };
 
-struct perf_kvm_stat;
-
 struct child_event_ops {
 	void (*get_key)(struct evsel *evsel,
 			struct perf_sample *sample,
-- 
2.34.1

