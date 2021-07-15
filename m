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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8162CC47E4D
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B406613F1
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhGOQK0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhGOQKZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:10:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FC2C061760;
        Thu, 15 Jul 2021 09:07:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id f9so8447276wrq.11;
        Thu, 15 Jul 2021 09:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CSHeuwUTA30JHyvgWYegQDxbsMpdusH7A0XgD14xaKY=;
        b=udfSn2Ao6cSs7/lr1z+u1GZEnCaa/p6EBue5sfEjqFBwnFdDOkkMtd3jX8tmlwN0nI
         PaU6LBdkL3fVa9QHsO71H1p/kxu5PkAsORk1V5uCJUSa2vHfMnmGBjMV//W0dzAeYuQE
         mQs7oofqugBPeFOqeEClNygq3dPAUAiAR3om0XV/fl57z6lOWUGTlVrKMjdGxwJRDjV7
         fIoRj7XpsI+DB6QhX34cZaqgMgGgvOro7htsPI1DHAjkTRXf2CG4FvdED1r9im+W4GJ/
         BCdcCEaTvfxaaZATnsBs71ZuKs4Sluh/Z3ZH6UVM9LqTJR3pKA2XlnFjXDyTs7J6hH8T
         ky6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CSHeuwUTA30JHyvgWYegQDxbsMpdusH7A0XgD14xaKY=;
        b=aZFemu30fejxJoejHvOOb52XmkspbB5W/XGSQp9/YgNkd+Fnzf1AMT+jlF8ZoJ9hcq
         +v+NNX7bcdTF/XfQZyP06DDW4A8oyHHNkc7R2HFtWooTmbIEsPPLQzvVpK4nJWCSVi5f
         qsgeuFu7KmLjwNWKpKRAw3JFeudCH1HNMcNA+M8ssNalUl6u7paCpvrDwIEhOSv14PpK
         saWKdHY6SI6DBERmODK10o4n9UfvjdPLkQ0Bd6ZfvRVThlmrtQ2iIN5zJzRxzO8B3gAM
         FUlCZVyHyE+OmqyDw6hsklvAy+tB8M2eBYejxfXyxxN5xECLxrnya1xh1r/naiZGzIFs
         BFUg==
X-Gm-Message-State: AOAM5312MO4lmQE42z6FEq9Ht5FoOgcOwUwsA+fh690oglgi1dhkRCw5
        7khJaoYgQ4xUnRWMNJeDmwI=
X-Google-Smtp-Source: ABdhPJx+g9k5bs/pqfWeem6a/7Oa+VFqR7TZHc88Xu8ETjFOuSnBcdmV0z3qtSReSsa3rFZS2ZHE/w==
X-Received: by 2002:adf:eb82:: with SMTP id t2mr6513951wrn.337.1626365250797;
        Thu, 15 Jul 2021 09:07:30 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id k13sm7446952wrp.34.2021.07.15.09.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:07:30 -0700 (PDT)
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
Subject: [PATCH 03/20] perf test: session_topology: delete session->evlist
Date:   Thu, 15 Jul 2021 18:07:08 +0200
Message-Id: <822f741f06eb25250fb60686cf30a35f447e9e91.1626343282.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626343282.git.rickyman7@gmail.com>
References: <cover.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports a memory leak related to session->evlist while running
the perf test "41: Session topology".

When perf_data is in write mode, session->evlist is owned by the
caller, which should also take care of deleting it.

This patch adds the missing evlist__delete.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/tests/topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index ec4e3b21b8311f57..b5efe675b321746e 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -61,6 +61,7 @@ static int session_write_header(char *path)
 	TEST_ASSERT_VAL("failed to write header",
 			!perf_session__write_header(session, session->evlist, data.file.fd, true));
 
+	evlist__delete(session->evlist);
 	perf_session__delete(session);
 
 	return 0;
-- 
2.31.1

