Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE79C4320A
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0491C61101
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbhHUJUt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbhHUJUj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:20:39 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260A5C0613CF;
        Sat, 21 Aug 2021 02:19:58 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lo4so25140207ejb.7;
        Sat, 21 Aug 2021 02:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+U3YOtDAf1VM4NAaGzCL3EE9rWzGI06v0q8Jd39E39o=;
        b=ktuNHDddlmv6ZpVQ6Ty9173/Y6XHmN51si50enIjm1Ed4YGAMA5TuZj47K/myzqHsq
         tcAuUMs9HoEna3lCx95+iKh+zXi0IwjCcP6HDYoA4TbgTbZX7kbSYoU9r2GcC/Zk+k30
         3G7mnYNquwD4KHREHOZSa5xx1HS0C8fj8e/tKiK0E2qJBn0tBvVxHehblAkqOiA3S0ht
         u+Q8D4rT/AtIW7XmnMGBBex03dR3O3DGGs4g/tVj+90ep6DKKSbbi2d8nxO5O3nZ03rU
         NAb2Hu5m1mDXSbd3oq3V2qJ2QMu0zwjZX4lQoStmKbyTYzhRVkFxtvwrOoze+zfRnXQt
         5VnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+U3YOtDAf1VM4NAaGzCL3EE9rWzGI06v0q8Jd39E39o=;
        b=NAerN8LjWS/Lu4wf9D7sjphgenE2z6T1fNQWdWylU6c+c7fiDb2WL1QIcu0t/O8HxC
         rwHyZCrOLm91foOws/KMX5ZG7RyclO3bejFhjxSF2GNDkoC4z1ERpUn0v5xdWmRxLN8q
         UHC5buVERb6onX0FaV2GdgVPSMaCHMQTIJgbnkpCaZntmigBamHZf8b2L9Tr+xYYUbMd
         9GkjHvFWC8FCMqJp15xRiisDSsUm53AZKEcwFf5x42UZ3aWvRMvd6mO4aNPcMOr3u4CT
         eLuBm6cAdwwZqneNBcUMRMyDNuW4TdvmxnV5qAV/GqjBkvvvTcg2yonDfsSInKMCDEgL
         a/rw==
X-Gm-Message-State: AOAM532m4e5aXwXXwlcMvUy7P26M0HC1PgbtnmxXcNCZ7N4vx9qmU0c5
        gGdzhlYrPBcQ9s4xoBHSj9o=
X-Google-Smtp-Source: ABdhPJzWz4zqSl4Wxjq1eHtKykn4YK5Yhk7fNzB2Mp2qMU2rPertjE2XHx3rd4ZyjyzqgfMhtT5Y9w==
X-Received: by 2002:a17:906:c34c:: with SMTP id ci12mr25899953ejb.247.1629537596662;
        Sat, 21 Aug 2021 02:19:56 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:19:56 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH v1 07/37] perf workqueue: add support for setting affinities to workers
Date:   Sat, 21 Aug 2021 11:19:13 +0200
Message-Id: <5e564cefbf2612ff492a77f25ba4289ad3efcee0.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds an interface to workqueue to set affinities to the
underlying threadpool threads.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/workqueue/workqueue.c | 21 +++++++++++++++++++++
 tools/perf/util/workqueue/workqueue.h |  6 ++++++
 2 files changed, 27 insertions(+)

diff --git a/tools/perf/util/workqueue/workqueue.c b/tools/perf/util/workqueue/workqueue.c
index 7daac65abb5d57d1..61f1b6c41deba031 100644
--- a/tools/perf/util/workqueue/workqueue.c
+++ b/tools/perf/util/workqueue/workqueue.c
@@ -50,6 +50,7 @@ static const char * const workqueue_errno_str[] = {
 	"Error executing function in threadpool",
 	"Error stopping the threadpool",
 	"Error starting thread in the threadpool",
+	"Error setting affinity in threadpool",
 	"Error sending message to worker",
 	"Error receiving message from worker",
 	"Received unexpected message from worker",
@@ -758,6 +759,26 @@ int flush_workqueue(struct workqueue_struct *wq)
 	return err;
 }
 
+/**
+ * workqueue_set_affinities - set affinities to all threads in @wq->pool
+ */
+int workqueue_set_affinities(struct workqueue_struct *wq,
+				struct mmap_cpu_mask *affinities)
+{
+	wq->pool_errno = threadpool__set_affinities(wq->pool, affinities);
+	return wq->pool_errno ? -WORKQUEUE_ERROR__POOLAFFINITY : 0;
+}
+
+/**
+ * workqueue_set_affinities - set affinity to thread @tidx in @wq->pool
+ */
+int workqueue_set_affinity(struct workqueue_struct *wq, int tidx,
+				struct mmap_cpu_mask *affinity)
+{
+	wq->pool_errno = threadpool__set_affinity(wq->pool, tidx, affinity);
+	return wq->pool_errno ? -WORKQUEUE_ERROR__POOLAFFINITY : 0;
+}
+
 /**
  * init_work - initialize the @work struct
  */
diff --git a/tools/perf/util/workqueue/workqueue.h b/tools/perf/util/workqueue/workqueue.h
index 7a0eda923df25d85..dc6baee138b22ab2 100644
--- a/tools/perf/util/workqueue/workqueue.h
+++ b/tools/perf/util/workqueue/workqueue.h
@@ -28,6 +28,11 @@ extern int queue_work_on_worker(int tidx, struct workqueue_struct *wq, struct wo
 
 extern int flush_workqueue(struct workqueue_struct *wq);
 
+extern int workqueue_set_affinities(struct workqueue_struct *wq,
+				struct mmap_cpu_mask *affinities);
+extern int workqueue_set_affinity(struct workqueue_struct *wq, int tidx,
+				struct mmap_cpu_mask *affinity);
+
 extern void init_work(struct work_struct *work);
 
 /* parallel_for utility */
@@ -92,6 +97,7 @@ enum {
 	WORKQUEUE_ERROR__POOLEXE,
 	WORKQUEUE_ERROR__POOLSTOP,
 	WORKQUEUE_ERROR__POOLSTARTTHREAD,
+	WORKQUEUE_ERROR__POOLAFFINITY,
 	WORKQUEUE_ERROR__WRITEPIPE,
 	WORKQUEUE_ERROR__READPIPE,
 	WORKQUEUE_ERROR__INVALIDMSG,
-- 
2.31.1

