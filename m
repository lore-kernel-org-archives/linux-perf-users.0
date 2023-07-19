Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE42EC001B0
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 Jul 2023 20:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjGSUcO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 Jul 2023 16:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjGSUcK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Jul 2023 16:32:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DB2268D;
        Wed, 19 Jul 2023 13:31:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BC3B61828;
        Wed, 19 Jul 2023 20:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044B0C433C7;
        Wed, 19 Jul 2023 20:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689798605;
        bh=BRr5z+/T35P0lcuwuDmZU0RVzfr8a7oe2vprcDbwtgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eLuzMdK34w6j5GXTkBaVLYSnwgF5Bu10EGq7KZeJhZlqE3HnYBLVm4IEb4roVyTwh
         zaRJeQThJ4AwDxoFLo0FHsKfpHb/hroAwkE9/sVSKF+KehTyNo1IXC9GgO16PNNwSo
         HBP8mGWr+glXWHk2ty88qBhpLeRNDRCESsWRzJ5g08Mh0YRpsPldwoJMrGo9TmUciG
         +utjq8ZVV6cRUKH6fodglvjSjZPdTtx5cMD7pQPNig3MKUkA0/xdJ4AK+8/zSQ0IS4
         mq0EjGOhSMVIPY1VS4KDrmfwBkQ4g2fjvDt7VpeYtNF26daSz6+Q/2j2sJr+nbs9JD
         zo/T8JyH7hO/A==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/6] perf thread: Allow tools to register a thread->priv destructor
Date:   Wed, 19 Jul 2023 17:29:47 -0300
Message-ID: <20230719202951.534582-3-acme@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719202951.534582-1-acme@kernel.org>
References: <20230719202951.534582-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that when thread__delete() runs it can be called and free stuff tools
stashed into thread->priv, like 'perf trace' does and will use this
new facility to plug some leaks.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread.c | 11 +++++++++++
 tools/perf/util/thread.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 0b166404c5c365cf..35dd4e716e411da9 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -80,6 +80,13 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 	return NULL;
 }
 
+static void (*thread__priv_destructor)(void *priv);
+
+void thread__set_priv_destructor(void (*destructor)(void *priv))
+{
+	thread__priv_destructor = destructor;
+}
+
 void thread__delete(struct thread *thread)
 {
 	struct namespaces *namespaces, *tmp_namespaces;
@@ -112,6 +119,10 @@ void thread__delete(struct thread *thread)
 	exit_rwsem(thread__namespaces_lock(thread));
 	exit_rwsem(thread__comm_lock(thread));
 	thread__free_stitch_list(thread);
+
+	if (thread__priv_destructor)
+		thread__priv_destructor(thread__priv(thread));
+
 	RC_CHK_FREE(thread);
 }
 
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 9068a21ce0fa1b0f..e79225a0ea46b789 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -71,6 +71,8 @@ struct thread *thread__new(pid_t pid, pid_t tid);
 int thread__init_maps(struct thread *thread, struct machine *machine);
 void thread__delete(struct thread *thread);
 
+void thread__set_priv_destructor(void (*destructor)(void *priv));
+
 struct thread *thread__get(struct thread *thread);
 void thread__put(struct thread *thread);
 
-- 
2.41.0

