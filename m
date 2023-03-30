Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95412C6FD1D
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Mar 2023 18:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjC3SjJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjC3SjI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Mar 2023 14:39:08 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A106D338
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Mar 2023 11:38:52 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d2-20020a170902cec200b001a1e8390831so11548071plg.5
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Mar 2023 11:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680201532;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rc0WsSKhrfezZG14LM0dWooUum9c0MXHA4o6d0x9y1w=;
        b=h0nf3bWtd92qScL1j9hY2/7NM2m8VITXWJ8OnlSeERxoyrf8IKNHQmqeo8SX+snYD1
         DPJMb44DkDtvYiRLt2v2Cj7qwhc7gHtDsZ/7ZehzjHm6nniACa8+WI53rcESu/5tC3yn
         0+JlKwhxebFRGqjDQvbNLt8Rn/uh6DRAWx9FX8WToSBiXDOsuG7u+CbZbxaehdKwBzNw
         gmB33LiiFiVeK3tMewlqfkBP9y8amM3VVszEjlJEdE1tmgGwGhXaM5EfvGw57G17KeHu
         4g9PYsi00nLM41A14C6NFMOfqh8w5CG7xzzbfVn7K8HosZUFC0T5nzJHQti3x0SUokKm
         c3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680201532;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rc0WsSKhrfezZG14LM0dWooUum9c0MXHA4o6d0x9y1w=;
        b=UBM2+vBGL8vwWUUzvOeopj54oeFyVc1eCB8hyeTttDpRS/Y0EQZE9tXd5nzbNaMQw5
         ScjgucIxuLrafhoNo7urD76ptZVCDlCran1Zjl7s6ATdS3w0LJ3+gnPHGMPajLkrLvEK
         5PGa4p3rh13uvWPsDlXjOAlGbgqMwTLzhDeof9n3m8DTWSOJGi5Kic9BzzEe84D0CNIU
         6EY0w8W/nN3vhoGNjfHAgP2RxIy+ubFHk81s5ziToi27zMcKCWDiCORVdw1DLfe4aawk
         GD+Tw/OJ7M8wT0GlNsINLKpO1X7xSHk5EUxO3B1JpAcqKulfVOShrx4hgblLcZ/Sa4PM
         L+iw==
X-Gm-Message-State: AAQBX9cgRlAiFUAUbRwmQBKNOW7RDQuO2fgEofKHYbeXBJ4yqWWQH4CP
        io3EB1ZJglNZ1ZpPLdvfeMLOzHJLZ+aP
X-Google-Smtp-Source: AKy350ZDXa8GoDGRrg5g0i86ixFwbwBcMF9K8wp39rBOS2QnXaKFmX4Ua0dg8GzUqhFJTCSDb3Oa+oxeOrUz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:11ea:eb75:e48c:2c04])
 (user=irogers job=sendgmr) by 2002:a17:90a:600c:b0:240:9d66:cd54 with SMTP id
 y12-20020a17090a600c00b002409d66cd54mr3550317pji.8.1680201532035; Thu, 30 Mar
 2023 11:38:52 -0700 (PDT)
Date:   Thu, 30 Mar 2023 11:38:26 -0700
In-Reply-To: <20230330183827.1412303-1-irogers@google.com>
Message-Id: <20230330183827.1412303-2-irogers@google.com>
Mime-Version: 1.0
References: <20230330183827.1412303-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 2/3] perf block-range: Move debug code behind ifndef NDEBUG
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Make good on a comment and avoid a unused-but-set-variable warning.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/block-range.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/perf/util/block-range.c b/tools/perf/util/block-range.c
index 1be432657501..680e92774d0c 100644
--- a/tools/perf/util/block-range.c
+++ b/tools/perf/util/block-range.c
@@ -11,11 +11,7 @@ struct {
 
 static void block_range__debug(void)
 {
-	/*
-	 * XXX still paranoid for now; see if we can make this depend on
-	 * DEBUG=1 builds.
-	 */
-#if 1
+#ifndef NDEBUG
 	struct rb_node *rb;
 	u64 old = 0; /* NULL isn't executable */
 
-- 
2.40.0.348.gf938b09366-goog

