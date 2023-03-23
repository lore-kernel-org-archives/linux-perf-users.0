Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B64C6FD1C
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Mar 2023 02:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjCWCuK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Mar 2023 22:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCWCuJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Mar 2023 22:50:09 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF9C1F5F7;
        Wed, 22 Mar 2023 19:50:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso598222pjb.2;
        Wed, 22 Mar 2023 19:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679539808; x=1682131808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=a4keVKlJNdo1j4qFYE//r1eDE0ShQaX85E5D5pockwg=;
        b=WlxaKMdUWP6NF61Enqgn/cZbbwYafq7NXQi9eUxKsSptIGlgpjqSHnPEFHCeawJuk9
         X5gAh/gM5rAO0kYp2M09Zezh7woZMiofK14yeFb84H1r0Xt2XmgGYhegj3yOOyh4nUFk
         3AwLAdYWC70mD5rSB9KykDG9n2d/jVyW+az2+jNJCOq2PcxakBGU7ELXtFfHURtHCbP+
         LFWAdIZJJjrDhXBRPmD4z4+eyb6JSGzMD2p/lp7au5mK7vpdtQxeZfVmRAQhLsMzeINe
         LrH9+sQvV325fqlDdaOmIs4N16W89Sp51neKpM/rAsJLGRyqWNsiCe9SesWq+CYHnaKw
         YoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679539808; x=1682131808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4keVKlJNdo1j4qFYE//r1eDE0ShQaX85E5D5pockwg=;
        b=RbEYUxx1ONA3RHHY2MD9lNQ5xW6MBN2kpXlGKX0D4kJsdfmvbm1C7ImpM1le4Og6d7
         r9AwrSYtcOhqOVzkEdqzMWjFv98kFWOm1Z/01xNDkcZmqXjPV9y8e9sJSSviCmESneTe
         OrjSZq8wXJ4q0u7lQMQmvhSZuxDX4aXgLb3fonSIyV1TZ3mVrbKqz7zcEKbTfyit/ZXa
         SqBQkTdf4uWYkPv9Bbz9uM0FtjHtvu35loxbNqy5X1iRR0uLu3fLGKj6whU0NDJe4Rdt
         Xqxkkr/Q9M0cXb9ElkEcGckAqKV086aoUVxu2vE4v4KYkS4xFiwDT4FMF2DYJ+eDM7br
         9Okg==
X-Gm-Message-State: AO0yUKXPlj423v2dFS+sqMf7YIA+9X1UEsMNQz3gA7UxRDaurE8kYNuf
        hEX9BYRJ0w9AN4cgmG+5xsI=
X-Google-Smtp-Source: AK7set/ezdzcrTsE9YggmSOhJq3msvgSPLQjU+Vex3eUzm6YN+Mlj0bCQCBskj4eL0u/kirscVBfQQ==
X-Received: by 2002:a17:902:da8b:b0:1a1:a273:1812 with SMTP id j11-20020a170902da8b00b001a1a2731812mr5420072plx.45.1679539807527;
        Wed, 22 Mar 2023 19:50:07 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:44b0:9957:6acc:41b5:fbeb])
        by smtp.gmail.com with ESMTPSA id ji17-20020a170903325100b00199023c688esm11274738plb.26.2023.03.22.19.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 19:50:07 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf hist: Improve srcfile sort key performance (really)
Date:   Wed, 22 Mar 2023 19:50:05 -0700
Message-Id: <20230323025005.191239-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The earlier commit f0cdde28fecc ("perf hist: Improve srcfile sort key
performance") updated the srcfile logic but missed to change the ->cmp()
callback which is called for every sample.  It should use the same logic
like in the srcline to speed up the processing because it'd return the
same information repeatedly for the same address.  The real processing
will be done in sort__srcfile_collapse().

Fixes: pf0cdde28fecc ("perf hist: Improve srcfile sort key performance")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/sort.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index e11e68ecf0a2..2b5cc8e4aa6e 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -657,12 +657,7 @@ static char *hist_entry__get_srcfile(struct hist_entry *e)
 static int64_t
 sort__srcfile_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	if (!left->srcfile)
-		left->srcfile = hist_entry__get_srcfile(left);
-	if (!right->srcfile)
-		right->srcfile = hist_entry__get_srcfile(right);
-
-	return strcmp(right->srcfile, left->srcfile);
+	return sort__srcline_cmp(left, right);
 }
 
 static int64_t
-- 
2.40.0.rc1.284.g88254d51c5-goog

