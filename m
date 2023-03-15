Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715A4C61DA4
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Mar 2023 14:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjCOOvv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Mar 2023 10:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjCOOvs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Mar 2023 10:51:48 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE4375A73
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Mar 2023 07:51:42 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j13so3340754pjd.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Mar 2023 07:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678891902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uN7zwUTTarFdEEyI4xavpEstkRipyyWqLXdanEnFXps=;
        b=dz9O6X6Lyg1W6HzzKFOyVtSVCtOcOjX8KUPSQGJc8jHxSUKbFkz/hVeQ0IeO06vNJg
         mdjLv5xdlHfxTFYU/l2wMFk6fROQORw9f+TdY+DE/sAZ0crV5vSB73uh2yg2zN10YTvh
         xVasUftypDkWRNQIu3RitoOknFgaKUxPyubkvgnjtLbhz+rHg3v7VQRqfx+TNBYL5Odu
         HP32DoZ0l++hvqej4Nr9VAXfhQ5G1LsoSoDWqNN0XKHEPG0uxa6+NmguqPg5R8NBVqEt
         EvDpy5BRxuliKIwnNrlkfIjTfxGwpNNVfg40LxE94KDTI91OspTkLzwXiQGu7vtLGkM8
         OGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678891902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uN7zwUTTarFdEEyI4xavpEstkRipyyWqLXdanEnFXps=;
        b=3pjU6aGFkElSUes+j8p+tqEakmW+pcsFVjVmVuZZ5RG2N1uT/OkCT/jMj0VtUPDkM/
         K6J8Nytaf5V8GCkzJjW4uKdNMdLiMBMdBS4zGKOK+KvhoXEyJTMCghyqTy5T9b3uMWpc
         Vix9aqM2sajTtsOXi61rF+BsktjZbHcL/HTlWX8o/l0JhepvCfNRB4hiueWp6r/qRsuf
         jTp/grkKgxl+y8U5KbBlAQUqnd+VywP8cJ3aee9MAtk5nz9pkEik3yo5bbas/90oahRj
         Mls2E2dwC2yBRkzE99Id7A/Vu4lVK+zZWK9Q7irpyhRo8vtrRfSbAro+QQvT86PCHE9M
         1mkQ==
X-Gm-Message-State: AO0yUKVpjQ54pYqI54i0I7V5C+m3nrYyWbKSeCqnYi0ZHYGBgwtuasCU
        LxIRuaknRysSFTWhEUOFgR1nlw==
X-Google-Smtp-Source: AK7set+18F9Edl6g6CLpmAfVo4MglOMwc0eTGR01kSD+KJBuN3gDndbDDHajhADj2FlU+Vq8nRzdUA==
X-Received: by 2002:a17:903:cc:b0:1a0:75bb:2803 with SMTP id x12-20020a17090300cc00b001a075bb2803mr2319315plc.63.1678891901947;
        Wed, 15 Mar 2023 07:51:41 -0700 (PDT)
Received: from leoy-huanghe.lan ([107.151.177.133])
        by smtp.gmail.com with ESMTPSA id kh3-20020a170903064300b0019926c77577sm3781587plb.90.2023.03.15.07.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:51:41 -0700 (PDT)
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
Subject: [PATCH v5 02/16] perf kvm: Add pointer to 'perf_kvm_stat' in kvm event
Date:   Wed, 15 Mar 2023 22:50:58 +0800
Message-Id: <20230315145112.186603-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315145112.186603-1-leo.yan@linaro.org>
References: <20230315145112.186603-1-leo.yan@linaro.org>
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

