Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A74AECAAA6
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Aug 2022 16:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344515AbiHZQqS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Aug 2022 12:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344827AbiHZQpg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Aug 2022 12:45:36 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5EF12AFF
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Aug 2022 09:44:54 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33dc888dc62so33711367b3.4
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Aug 2022 09:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=oUmOqsD5kNY3uiPBG3PIXYxy0Y1/hD+f3VoRJWg9Hxo=;
        b=l/qcbZC3RAYS3zFxyNjj12e+O4lcrnJ7FV4xL7kvxiHF8Mx2n3ltWCkXys/11dJGt1
         ZtiUxresfuHCdlis/U5NZwCCkzDNg0/Hv2cny+WESdnGvvgCEfYe3x6jQ4dLnRR6bq1j
         ACcmaYPV3BGgwcp3616UOPVQmhwjCsvNK4hIKe5IM33LgXZeCFzT9f2I680xt43MkmGd
         I94cqzVZ31/U8I2k/8DGZcC2ePOaSWILMAP1/8YraEkEtg7WGDRTvas1iqlPTezPmt1B
         CgtD6rFxz42PxG8sZJiLdGA+qbsNV5SNGqePaqtEq0vEj7gxVeOxLKrb+hti3xPiYmBv
         PYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=oUmOqsD5kNY3uiPBG3PIXYxy0Y1/hD+f3VoRJWg9Hxo=;
        b=2m+qoxQXPZR2RXXiTEYr114WwF3sYdjNKTGinVrsvM54A5KC95AZUlD6lPViTPs2t/
         jgf8MhCaHMfxiowfoN/r9Jc6n/gxdH4R9ZXj0w2UlH+dutAEf/90cQjESOv3k55ag6iF
         QnX1psZ1gtaLebBa6PP0W55LugWKpD0VEF+24yt1JvvNey8nH0+5IqKIdmQojjIgKl0H
         lxscc74DHUNkXB/1zkIKABaXrVCvoJUBFA57vLWu3TR0V6kNfMoB3/usOXzVeyVqWCTp
         Vd6ordWO07MLLqGB6MzzneD2eSqpG/EoPfCrCwFe0dZXZuf5w5mQERKYvHzxRry+QTH5
         7hdw==
X-Gm-Message-State: ACgBeo0JO9lpdXcWm7dnZHGJYFEwg+wPbu2MWnSVHVFrOAVytF0SZ2z0
        A1u59HIhlur4uzXBOCBI8mezSerx5P2O
X-Google-Smtp-Source: AA6agR5vPhlcXqUl7fZdTgvl9EUqkClaIWVlom6e43OfIEN+lpPk+r9wbUuWqYy6Bba8U5JO6BpI/71vkiYR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ccb1:c46b:7044:2508])
 (user=irogers job=sendgmr) by 2002:a25:cc4:0:b0:67c:228d:284 with SMTP id
 187-20020a250cc4000000b0067c228d0284mr480023ybm.247.1661532293697; Fri, 26
 Aug 2022 09:44:53 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:42:35 -0700
In-Reply-To: <20220826164242.43412-1-irogers@google.com>
Message-Id: <20220826164242.43412-12-irogers@google.com>
Mime-Version: 1.0
References: <20220826164242.43412-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 11/18] perf dso: Update use of pthread mutex
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Weiguo Li <liwg06@foxmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Switch to the use of mutex wrappers that provide better error checking.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c    | 12 ++++++------
 tools/perf/util/dso.h    |  4 ++--
 tools/perf/util/symbol.c |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 5ac13958d1bd..a9789a955403 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -795,7 +795,7 @@ dso_cache__free(struct dso *dso)
 	struct rb_root *root = &dso->data.cache;
 	struct rb_node *next = rb_first(root);
 
-	pthread_mutex_lock(&dso->lock);
+	mutex_lock(&dso->lock);
 	while (next) {
 		struct dso_cache *cache;
 
@@ -804,7 +804,7 @@ dso_cache__free(struct dso *dso)
 		rb_erase(&cache->rb_node, root);
 		free(cache);
 	}
-	pthread_mutex_unlock(&dso->lock);
+	mutex_unlock(&dso->lock);
 }
 
 static struct dso_cache *__dso_cache__find(struct dso *dso, u64 offset)
@@ -841,7 +841,7 @@ dso_cache__insert(struct dso *dso, struct dso_cache *new)
 	struct dso_cache *cache;
 	u64 offset = new->offset;
 
-	pthread_mutex_lock(&dso->lock);
+	mutex_lock(&dso->lock);
 	while (*p != NULL) {
 		u64 end;
 
@@ -862,7 +862,7 @@ dso_cache__insert(struct dso *dso, struct dso_cache *new)
 
 	cache = NULL;
 out:
-	pthread_mutex_unlock(&dso->lock);
+	mutex_unlock(&dso->lock);
 	return cache;
 }
 
@@ -1297,7 +1297,7 @@ struct dso *dso__new_id(const char *name, struct dso_id *id)
 		dso->root = NULL;
 		INIT_LIST_HEAD(&dso->node);
 		INIT_LIST_HEAD(&dso->data.open_entry);
-		pthread_mutex_init(&dso->lock, NULL);
+		mutex_init(&dso->lock);
 		refcount_set(&dso->refcnt, 1);
 	}
 
@@ -1336,7 +1336,7 @@ void dso__delete(struct dso *dso)
 	dso__free_a2l(dso);
 	zfree(&dso->symsrc_filename);
 	nsinfo__zput(dso->nsinfo);
-	pthread_mutex_destroy(&dso->lock);
+	mutex_destroy(&dso->lock);
 	free(dso);
 }
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 66981c7a9a18..58d94175e714 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -2,7 +2,6 @@
 #ifndef __PERF_DSO
 #define __PERF_DSO
 
-#include <pthread.h>
 #include <linux/refcount.h>
 #include <linux/types.h>
 #include <linux/rbtree.h>
@@ -11,6 +10,7 @@
 #include <stdio.h>
 #include <linux/bitops.h>
 #include "build-id.h"
+#include "mutex.h"
 
 struct machine;
 struct map;
@@ -145,7 +145,7 @@ struct dso_cache {
 struct auxtrace_cache;
 
 struct dso {
-	pthread_mutex_t	 lock;
+	struct mutex	 lock;
 	struct list_head node;
 	struct rb_node	 rb_node;	/* rbtree node sorted by long name */
 	struct rb_root	 *root;		/* root of rbtree that rb_node is in */
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a4b22caa7c24..656d9b4dd456 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1800,7 +1800,7 @@ int dso__load(struct dso *dso, struct map *map)
 	}
 
 	nsinfo__mountns_enter(dso->nsinfo, &nsc);
-	pthread_mutex_lock(&dso->lock);
+	mutex_lock(&dso->lock);
 
 	/* check again under the dso->lock */
 	if (dso__loaded(dso)) {
@@ -1964,7 +1964,7 @@ int dso__load(struct dso *dso, struct map *map)
 		ret = 0;
 out:
 	dso__set_loaded(dso);
-	pthread_mutex_unlock(&dso->lock);
+	mutex_unlock(&dso->lock);
 	nsinfo__mountns_exit(&nsc);
 
 	return ret;
-- 
2.37.2.672.g94769d06f0-goog

