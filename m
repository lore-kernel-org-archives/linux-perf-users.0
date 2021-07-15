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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A50C1B08C
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 427A9613F0
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhGOQKr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbhGOQKo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:10:44 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79118C06175F;
        Thu, 15 Jul 2021 09:07:50 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso6378406wmh.4;
        Thu, 15 Jul 2021 09:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cghIzfQ97dtrU/lUURxCb3TGIcHuXKBKq9tDNHZZFSs=;
        b=LStyBDuBZifMQihbkJHWh6AoplTJGPdEY2z7yiT5vzNO9de49m1Uk+nlrZVwSAvr8C
         cNyOo6yw8cOwEQLnvMGtVoIX03k64Nh+vpPFRCmtCyq3LZjZix4gr5dlD1K96PDj3cgO
         ZgSbhB8iybKc1xiVX1hjFNyk5HdXklgY2RLv7rl0Kb30cPxXynY6byHsRLl7b1l953gf
         MtQrPi3/z94rsbJclrrtvSJ7KXGYuVZSDH9n5EG/D3xNZDtuZvJ09NreaFPWFA7I9Ezs
         y+v7a/VEgPum+UfYNiNq5BarAMSkprYch8WpaWQKWXDqPM5aZeivlcN2RNi7Zs0pTP4o
         SxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cghIzfQ97dtrU/lUURxCb3TGIcHuXKBKq9tDNHZZFSs=;
        b=q6t3hpU65P60whPaMa35TvC0/a4dzqX6CYq4z7heyzNCFIKcZGsnYMmvLNN4p7XRlY
         6t+tIiOU0WeIl9xhhYkh4PuYFV4gTEcMFuGlEEm1jymMk/yUbmwPfGRHSMMncdH3uC2T
         j3p3KeL9AfftMdLuK34NHP3CFhtEDm1ygitku22EebRpaAMxCrRkBIc20qjCq693cxre
         VDIbdMF5p6Jwey3a26LdyIPvPOuXYJT+Q3b6Iql9/PtpiVGbX+m2o1liyaOABUYB5LGo
         T7BZ8BWyeMDm5NC1jjd7i+ThT1yTDepEuqHyv+8G5c5hLzytfKREv0ThTbuJaqmti21A
         KVDw==
X-Gm-Message-State: AOAM533vUZjo9xBbGnNKWnlTy9II28rqUmNuIO1xWNaRieHfZ9gz7i3n
        OFaDafjLN8wMtiuqLHS1siM=
X-Google-Smtp-Source: ABdhPJwcvXtGYh9CalRPVxXmAmNDqDx0fVXNIU7TVoVAeb7xPQ+cWHya6KARODVX5H2/4/EuG6cm+Q==
X-Received: by 2002:a05:600c:20b:: with SMTP id 11mr11825748wmi.112.1626365269073;
        Thu, 15 Jul 2021 09:07:49 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id k13sm7446952wrp.34.2021.07.15.09.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:07:48 -0700 (PDT)
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
Subject: [PATCH 19/20] perf test: bpf: free obj_buf
Date:   Thu, 15 Jul 2021 18:07:24 +0200
Message-Id: <60f3ca935fe6672e7e866276ce6264c9e26e4c87.1626343282.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626343282.git.rickyman7@gmail.com>
References: <cover.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports some memory leaks when running the perf test
"42: BPF filter".
The first of these leaks is caused by obj_buf never being deallocated in
__test__bpf.

This patch adds the missing free.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/tests/bpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 33bda9c265423547..2cda4a6297e07967 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -276,6 +276,7 @@ static int __test__bpf(int idx)
 	}
 
 out:
+	free(obj_buf);
 	bpf__clear();
 	return ret;
 }
-- 
2.31.1

