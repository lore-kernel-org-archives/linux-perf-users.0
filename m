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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9441C432BE
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B88D461206
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240642AbhHUJWv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbhHUJWP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:22:15 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A66C06114D;
        Sat, 21 Aug 2021 02:20:27 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i6so17675554edu.1;
        Sat, 21 Aug 2021 02:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Wxxt3YvhYd/zL8RWKEMmopxrwh/epV13mN5cuVdlwQ=;
        b=HvujytgwM4KQkb8ZI9Fpf6wYN7e/cUnmsjvoxkToQuW/QmtAVt7o9vZ2boBbGYOu8B
         LFXAvPRnnLLa2NHgTvfbHkeHY4NyhY9wvzUZoTHpdbGvcPwOpOGhDkTCpJc2pO42O4Yz
         FXBj4sd/9t5Rn3blSDcGnttBarREc0xo4a3RsuMsKQ+A5cf1eNfU2J13Si2I7Kn5bk1E
         d1XBFvzmMSjpehDRSQubuy2cFbtW74/0xCcASKK2VA58W6oLWStSRvYIbMk3n9JXyTAn
         EB5hXUMu+TNihx5JZB9Ew+9Y9B+o0diXjDawUlVc/loxu7Mz8jckW169ItxoS8CG0tV3
         0fVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Wxxt3YvhYd/zL8RWKEMmopxrwh/epV13mN5cuVdlwQ=;
        b=DzArRZe6vOF7J3QGM1j3S8N+Dmo6/VFr01Ru62WVgIyGB6qJI45Zha/8sHC+QOS8IV
         TJHL82Hd1qqYwkSFMj3lpPO+jMgpkCYrGeg5RKXzZQwhS5nKwPIDXeXbXZUNNuBFA7LO
         1lf4i1H5FOE54vGt4FBZRkoduznJvf6Pzpmg3xZysWkQSdjJ9NXOBTpQOjjURdEYGCbU
         6Fq4uzQ6IY55B+06slsWyLbfCOdoTGg2Wl1sB5EFHGf9yfLRY03hg7ijo5QJLlBfYRur
         kYtK5E59GIKwxyDbsPu/V9lUK+Qb7+vvMcBB9EdY5HmNxyxYOPxonQGXUhKJwI2QNj7S
         592A==
X-Gm-Message-State: AOAM533sVFgiJMy0LVhqMFh52y/gs0dhA+BLNeIUxNBcRwQKm18vjKIF
        Ay22QrCq3PGoP9JjCievOEQ=
X-Google-Smtp-Source: ABdhPJznttDiEJ6KkNIBl23JXKkVU2T9HNvOPQgyOzYxqVW8+2RJdTp3KEbk5jSrUrLH7aFi8119/A==
X-Received: by 2002:a05:6402:518f:: with SMTP id q15mr26625616edd.226.1629537626130;
        Sat, 21 Aug 2021 02:20:26 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:25 -0700 (PDT)
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
Subject: [RFC PATCH v1 30/37] perf record: use evlist__open_custom
Date:   Sat, 21 Aug 2021 11:19:36 +0200
Message-Id: <b05793fb68d8e0c50af9a6c600dc70a7f79fb806.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch replace the custom evlist opening implemented in record__open
with the new standard function evlist__open_custom.
Differently from before this patch, in case of a weak group all fds are
closed and then reopened (instead of just closing failing ones).

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/builtin-record.c | 63 ++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index cccc2d0f9977d5b3..dc9a814b2e7906fc 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -882,6 +882,37 @@ static int record__mmap(struct record *rec)
 	return record__mmap_evlist(rec, rec->evlist);
 }
 
+struct record_open_custom_fallback {
+	struct evlist_open_custom_fallback fallback;
+	struct record_opts *opts;
+	bool retry;
+};
+
+static bool record__open_fallback(struct evlist_open_custom_fallback *_fallback,
+				struct evlist *evlist, struct evsel *evsel, int err)
+{
+	char msg[BUFSIZ];
+	struct record_open_custom_fallback *fallback = container_of(_fallback,
+		struct record_open_custom_fallback, fallback);
+
+	if (evsel__fallback(evsel, -err, msg, sizeof(msg))) {
+		if (verbose > 0)
+			ui__warning("%s\n", msg);
+		return true;
+	}
+	if ((err == -EINVAL || err == -EBADF) &&
+		evsel->core.leader != &evsel->core &&
+		evsel->weak_group) {
+		evlist__reset_weak_group(evlist, evsel, true);
+		fallback->retry = true;
+		return false;
+	}
+
+	evsel__open_strerror(evsel, &fallback->opts->target, -err, msg, sizeof(msg));
+	ui__error("%s\n", msg);
+	return false;
+}
+
 static int record__open(struct record *rec)
 {
 	char msg[BUFSIZ];
@@ -890,6 +921,12 @@ static int record__open(struct record *rec)
 	struct perf_session *session = rec->session;
 	struct record_opts *opts = &rec->opts;
 	int rc = 0;
+	struct record_open_custom_fallback cust_fb = {
+		.fallback = {
+			.func = record__open_fallback
+		},
+		.opts = opts
+	};
 
 	/*
 	 * For initial_delay, system wide or a hybrid system, we need to add a
@@ -919,28 +956,12 @@ static int record__open(struct record *rec)
 
 	evlist__config(evlist, opts, &callchain_param);
 
-	evlist__for_each_entry(evlist, pos) {
-try_again:
-		if (evsel__open(pos, pos->core.cpus, pos->core.threads) < 0) {
-			if (evsel__fallback(pos, errno, msg, sizeof(msg))) {
-				if (verbose > 0)
-					ui__warning("%s\n", msg);
-				goto try_again;
-			}
-			if ((errno == EINVAL || errno == EBADF) &&
-			    pos->core.leader != &pos->core &&
-			    pos->weak_group) {
-			        pos = evlist__reset_weak_group(evlist, pos, true);
-				goto try_again;
-			}
-			rc = -errno;
-			evsel__open_strerror(pos, &opts->target, errno, msg, sizeof(msg));
-			ui__error("%s\n", msg);
-			goto out;
-		}
 
-		pos->supported = true;
-	}
+	do {
+		cust_fb.retry = false;
+		rc = evlist__open_custom(evlist, &cust_fb.fallback);
+	} while (cust_fb.retry);
+
 
 	if (symbol_conf.kptr_restrict && !evlist__exclude_kernel(evlist)) {
 		pr_warning(
-- 
2.31.1

