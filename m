Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE2BC432BE
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Aug 2021 18:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA4D561004
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Aug 2021 18:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243317AbhHZSt3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 Aug 2021 14:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhHZSt0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Aug 2021 14:49:26 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43569C061757
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Aug 2021 11:48:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z6-20020a257e06000000b0059bad6decfbso3953910ybc.16
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Aug 2021 11:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=574wPISS8tCg0FtWFoBAsPvMx8DTHUTnbYJhfrVYJio=;
        b=KTatZ9VMDNXbGBEpdiDXhavnjCd4AhNRcSs5HyN6PvQQ4DrikRFKaX6+2yrn1BRt7K
         qFf3k+Ea1AEkYlKKDbONBAAUqg+/eXD38NhUz648LYgDhku0c3FwoA8y0pp4mVb7YqQJ
         1TIzoSggKQfPGMjxNy4EKSOaBzYzmHoorS6XdYCP5s1q+dLEptKG9AiP2xEJFMobnK2X
         psc8Jjw3P/d0Mp6R3E7556QjfRAWGzeopeBHV/zO2e/OF6s7kz8V5nYzGAOAr9gT0jP/
         4VIScRdXD15Jj0bTpzqCwwFSN+9EeJpOOn65F5L6iRYCZAid7xIgwEf6bir8K6/FYHSX
         HJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=574wPISS8tCg0FtWFoBAsPvMx8DTHUTnbYJhfrVYJio=;
        b=bPmcaGDI/60AY/ydh98hTRU17aiejgBNJcYk0Ex9Ut1Y1pkGkE7TqjIS8EYCfIgz8H
         eMrSEZF/7CdH0mFU3+TXmuQMd41Ozjd35LLxSsYGtT2Ej9fMbGNPXkJ2ehQB13K1S/LG
         dZ5eBcanS8TbjklXYtrdWcecFNLDfKdiB7/xzvawkkLSWUuc13q9I9kaDMiDJ2ZBYqJh
         lPnwnv+y2LLZQcJlEAGWVDv91etYBgbaw2ecR891VxS4GSmkvDzJdzlmHt38u6U90ode
         Mn/08bSrWzmZMgoIvDP/VM9X63t3GPcwCVo8w0g6eL+sQVhsHG4dmY2mibqSRaPDWQr7
         39Ug==
X-Gm-Message-State: AOAM533YRfrMelSCHKy7W5HgMoq1F/k92/jNsVwa/p00Ih+FK/1qhU1N
        z0sWM0r4WZwc9380Eo0EqCMydJkdw1kZ
X-Google-Smtp-Source: ABdhPJwDbx4iAlZZn6vbjuBMAQdnEevvuznBezeyMZOT9Ba4O/Ekdt0Dvlban2zkpEHcTLpcw1vePG3Y3M5m
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:c034:ab65:973a:f67b])
 (user=irogers job=sendgmr) by 2002:a25:d446:: with SMTP id
 m67mr197590ybf.187.1630003718499; Thu, 26 Aug 2021 11:48:38 -0700 (PDT)
Date:   Thu, 26 Aug 2021 11:48:33 -0700
Message-Id: <20210826184833.408563-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH v2] perf bpf: Fix memory leaks relating to BTF.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

BTF needs to be freed with btf__free.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c  | 2 +-
 tools/perf/util/bpf-event.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index d43f6b5e5169..0bae061b2d6d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1833,7 +1833,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	ret = 0;
 out:
 	free(prog_linfo);
-	free(btf);
+	btf__free(btf);
 	fclose(s);
 	bfd_close(bfdf);
 	return ret;
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index cdecda1ddd36..17a9844e4fbf 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -296,7 +296,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 
 out:
 	free(info_linear);
-	free(btf);
+	btf__free(btf);
 	return err ? -1 : 0;
 }
 
@@ -486,7 +486,7 @@ static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
 	perf_env__fetch_btf(env, btf_id, btf);
 
 out:
-	free(btf);
+	btf__free(btf);
 	close(fd);
 }
 
-- 
2.33.0.259.gc128427fd7-goog

