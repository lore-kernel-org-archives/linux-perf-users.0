Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE7DC64EC7
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Feb 2023 08:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjB1Ima (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Feb 2023 03:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjB1ImV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Feb 2023 03:42:21 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316212BF19
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 00:42:14 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id b20so5196749pfo.6
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 00:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpZ5nkw8exH6pwfmixa8Q7/xf5HABCQppgg+JZ7ONP0=;
        b=bkNjJlgsFaniZFnEBrVC/8eR7XRiD8jF4esOwr6DwL9knjpC8TMdYEKIhfajyMVu3J
         zYst4NnOj0018T6y8H1j3/uDZ231VtuNTDe0bQEvH55eOoBvFbQTxaGV08v3J5UWjuXw
         MLV03zzeZfla0MLgVNKobMDfXcgKZ2WURiDMFIV2KOGeVYeiDxUUuFT6HZ5g/RGSb5l/
         AggEFH6S7y5p2YPcXGMq2fTWCAKJSt5sINcKOHiD89iLHQaVykYp5aXrGgV5jVe+6GNJ
         O7UAgaia6gWetzD3UqK1pwwAY7TboLjjlun0m+Gg1FT7IvX0hArrtrXeMHllQlC6SIMt
         eJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JpZ5nkw8exH6pwfmixa8Q7/xf5HABCQppgg+JZ7ONP0=;
        b=s/GvLYScXm5IEjCOACR4oPkb7yEBfDgY6nK+9QKBJDbiN1uMiKMEw6FSvtTdJJ6pf3
         zm0fHse4dL3MWDKh7032OvE4JDIryIky5+A5sU6wypt5MrD6zAQkT0LO7G3T8Dh1Yl/5
         ba5hAPRF5oPyOiFt1PxH3DvHb8Ouk3s+QTYviX0Ic4vAxxi3RbhDuUyRZKC5DvjDRW1d
         gh3Nl3HewSDHO/h12SlKYsj4JplWalYyKW9vb19tlUAfW4FZGNQ7Q4MIUtjWpk618KNt
         6cPh0rw8yXagCG5K6Cstp1F0/jrgSKQd/eHSuI3Xh9h+HsiRwLhMFHTc5iXx559fXprI
         t6qg==
X-Gm-Message-State: AO0yUKXNRhwBnVkH/58JfoA+/s6MOyGfj2Q3bX++QvNA67LyLUm3PKb1
        xn5uy24KVtfD+j9fIdm143UQRw==
X-Google-Smtp-Source: AK7set+wD55KJzTyIXxQ5710IRZ53crBDuVrVE9lHicbaWu3jyLeU6IMpNUa9XCwV4bQmN8bdAnt8w==
X-Received: by 2002:a62:1b02:0:b0:5a8:cb5f:94d4 with SMTP id b2-20020a621b02000000b005a8cb5f94d4mr1388359pfb.32.1677573733361;
        Tue, 28 Feb 2023 00:42:13 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78499000000b005d6fcd8f9desm5681270pfn.94.2023.02.28.00.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 00:42:12 -0800 (PST)
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
Subject: [PATCH v2 02/14] perf kvm: Add pointer to 'perf_kvm_stat' in kvm event
Date:   Tue, 28 Feb 2023 16:41:35 +0800
Message-Id: <20230228084147.106167-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228084147.106167-1-leo.yan@linaro.org>
References: <20230228084147.106167-1-leo.yan@linaro.org>
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

