Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1446CC6FA8E
	for <linux-perf-users@archiver.kernel.org>; Sun, 26 Feb 2023 04:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjBZEVR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 25 Feb 2023 23:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjBZEVP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 25 Feb 2023 23:21:15 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086DEC16D
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Feb 2023 20:21:14 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id i5so1843571pla.2
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Feb 2023 20:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpZ5nkw8exH6pwfmixa8Q7/xf5HABCQppgg+JZ7ONP0=;
        b=hK6xtK0P+jdDy+P5lKMWHE4668MH19RL3AO3pqibo0WUV5zMY4MaoRrYR2uxTjfVjG
         Pha2OP+A0X8Q5sqoQZj0EpFZS9fKVPCzOJwI/6JUIebAngQCEd14aJ1u3yDpqzFO3CpG
         e1CoMW6O7S/jJrpkvCSxFbWz1Uyo8KBclfAVgSpD86+lOpoSVlFnXJF72E2UPwy5QVIm
         MCbqV/JrqyPCNZhGZkGcb77JK0UQ+JsgJfNPZex+AuUQgdnjY5sICBtSBsa7Av6vSZUn
         IfiT1+GVe79nfFRDw50GGsJGluI/FFYPUvvgEEv8/mVYpgd+/Jhm0AgNXJ2nzWJJjFSR
         /jDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JpZ5nkw8exH6pwfmixa8Q7/xf5HABCQppgg+JZ7ONP0=;
        b=fmAoI0SzmzmzF/wjz3vrH6gdK9uWC1UdFOV3CHHYx0iyHKTRf78iJ1OPPiAiah5QGM
         6VR5wjw6z4SwyS1RqpjeaO6thl2IH0BISj3tWw/9wUSZKxAZvkWgEoet1gE5kyzzpozG
         yUf4KFn6IsGiYjXE8Jj1wn5UijSHj+JvOo65UtwGJuGhCO753G+HuhWEwdwhI6gufAIg
         +jjboIR8xFOG+5ljCPsXKY3kdTLCLnmX/ZFxS1+sPt/k5QRGLjyXL/2NCcIZ65OG2Xly
         W23qjZIg5EUqdxyuq30DiNE1GKaIRznW8hM1zAgeUTGxCWLQX+NRCA/BDecMzQb1cVi3
         hWdA==
X-Gm-Message-State: AO0yUKVU4Az4lp6EvIf1fv+f51YoC8yKeR2rYXRqy2XAQx4FgBQmshSn
        NkH0n5zxLycLP3gXZsDN7nGEdw==
X-Google-Smtp-Source: AK7set8Rw6G5gGFspCo7/rafoJ5m63fbiew7+V0e7kuxuc5Ui/qx5oWz4YB7Gu918mbOFbH9wgXNEA==
X-Received: by 2002:a17:903:2347:b0:19b:64bb:d546 with SMTP id c7-20020a170903234700b0019b64bbd546mr4820182plh.18.1677385273638;
        Sat, 25 Feb 2023 20:21:13 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id jj2-20020a170903048200b0019aaab3f9d7sm1976036plb.113.2023.02.25.20.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 20:21:13 -0800 (PST)
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
Subject: [PATCH v1 02/14] perf kvm: Add pointer to 'perf_kvm_stat' in kvm event
Date:   Sun, 26 Feb 2023 12:20:41 +0800
Message-Id: <20230226042053.1492409-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226042053.1492409-1-leo.yan@linaro.org>
References: <20230226042053.1492409-1-leo.yan@linaro.org>
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

