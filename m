Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD071C77B6E
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 Apr 2023 18:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjDLSZi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 Apr 2023 14:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjDLSZh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Apr 2023 14:25:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AFB524B
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Apr 2023 11:25:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id si1so993886ejb.10
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Apr 2023 11:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681323934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CuIFotn6NkH7GwEEzQQr9HJ+DXKSTCuSFqxJ6fR/3kA=;
        b=ATMcEVcTkob+LcbJqtdwy2WIbtWe0ZURi2omODM7WulW7y+EbYjCndB/hvU0dAKb8U
         yVWtPevyBc7M6Oo6wYVYvHYYBaz2o4RWdqNF71klQJAGVb2lE4pBK63PqfMiuKzfmXAy
         xSWzhU0RRX8gd+9wJJ6UQNFZrXAWVgZwbeLrvcm2WTSmzd9cj2URNeVJNmnqkT4VK4LF
         SKt+iJmOa5pWjcyzdtbvola9LJhSjjy1qwuTbrWY+y1FJd55w6PCRnoBLaiS9TpGMoR4
         sbhgkQyT9SQx7+JU3q2lsq9Hhovy41+5I/wsulmnOXMaNjlOpL0jVXEJzUFEF/VY+Mmg
         sEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681323934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuIFotn6NkH7GwEEzQQr9HJ+DXKSTCuSFqxJ6fR/3kA=;
        b=krMU0c+pXd6bcV6iJqmo0GEmH7YtP7+xtO+IgK3PKCTPBfT/SZ9QdLir+jtqeiiUoY
         Mu32plfInCcGFgvUMHeksYIVl0vqVIsvNbV0PMX/q+gG9CcdzGWGlmqINGU6JEP2HaNR
         SuLejqD3/DhqWNOai5k8FTgnVwZdZTDwAlKJ8VjAHN+cUn4SO5Oly2U9rSN5OosEvzNw
         YmY/P56sMdO5J3zNDGz49I+WmHzwluihewOPiBgXB7s5xJRaHkaCZWYmEqWTVTbbPZeo
         9tNFUdJasaBjEqKp13NomdhP9OScu+FztuqV4/1thRnEcgLgCSKF8f4kQyo5BtwrEVVh
         DkhQ==
X-Gm-Message-State: AAQBX9fqKKH4CnjACKf0uPS5VS/Z25vr23pFXS+oGMi7edzg4s6/p2EX
        kw0Tay/XSPZ5CKZm9p/j1JODUP4EfDc=
X-Google-Smtp-Source: AKy350bT3WRbhm3K3XAjzLuGMqtnjOVFCp88+dJPTChLDLc13GP15bkHO+OWRXXwPDpqHgmsdStvog==
X-Received: by 2002:a17:906:4406:b0:933:4dc8:972d with SMTP id x6-20020a170906440600b009334dc8972dmr14705383ejo.20.1681323934348;
        Wed, 12 Apr 2023 11:25:34 -0700 (PDT)
Received: from erthalion.local (dslb-094-223-160-134.094.223.pools.vodafone-ip.de. [94.223.160.134])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906b09000b0092be390b51asm7549638ejy.113.2023.04.12.11.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:25:33 -0700 (PDT)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        mingo@redhat.com, jolsa@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [RFC PATCH] perf stat: Separate bperf from bpf_profiler
Date:   Wed, 12 Apr 2023 20:23:16 +0200
Message-Id: <20230412182316.11628-1-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

It seems that perf stat -b <prog id> doesn't produce any results:

    $ perf stat -e cycles -b 4 -I 10000 -vvv
    Control descriptor is not initialized
    cycles: 0 0 0
                time        counts unit      events
	10.007641640    <not supported>      cycles

Looks like this happens because fentry/fexit progs are getting loaded, but the
corresponding perf event is not enabled and not added into the events bpf map.
I think there is some mixing up between two type of bpf support, one for bperf
and one for bpf_profiler. Both are identified via evsel__is_bpf, based on which
perf events are enabled, but for the latter (bpf_profiler) a perf event is
required. Using evsel__is_bperf to check only bperf produces expected results:

    $ perf stat -e cycles -b 4 -I 10000 -vvv
    Control descriptor is not initialized
    ------------------------------------------------------------
    perf_event_attr:
      size                             136
      sample_type                      IDENTIFIER
      read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
      disabled                         1
      exclude_guest                    1
    ------------------------------------------------------------
    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 3
    ------------------------------------------------------------
    [...perf_event_attr for other CPUs...]
    ------------------------------------------------------------
    cycles: 309426 169009 169009
		time             counts unit events
	10.010091271             309426      cycles

The final numbers correspond (at least in the level of magnitude) to the
same metric obtained via bpftool.

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 tools/perf/builtin-stat.c | 4 ++--
 tools/perf/util/evsel.h   | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d3cbee7460f..23b8d684ca6 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -712,7 +712,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		counter->reset_group = false;
 		if (bpf_counter__load(counter, &target))
 			return -1;
-		if (!evsel__is_bpf(counter))
+		if (!(evsel__is_bperf(counter)))
 			all_counters_use_bpf = false;
 	}
 
@@ -728,7 +728,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 		if (counter->reset_group || counter->errored)
 			continue;
-		if (evsel__is_bpf(counter))
+		if (evsel__is_bperf(counter))
 			continue;
 try_again:
 		if (create_perf_stat_counter(counter, &stat_config, &target,
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 68072ec655c..f0aa17dcf3d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -269,6 +269,11 @@ static inline bool evsel__is_bpf(struct evsel *evsel)
 	return evsel->bpf_counter_ops != NULL;
 }
 
+static inline bool evsel__is_bperf(struct evsel *evsel)
+{
+	return evsel->bpf_counter_ops != NULL && list_empty(&evsel->bpf_counter_list);
+}
+
 #define EVSEL__MAX_ALIASES 8
 
 extern const char *const evsel__hw_cache[PERF_COUNT_HW_CACHE_MAX][EVSEL__MAX_ALIASES];
-- 
2.32.0

