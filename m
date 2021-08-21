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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD48C4320A
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C81961156
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbhHUJUb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbhHUJUa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:20:30 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63EEC061575;
        Sat, 21 Aug 2021 02:19:50 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id mf2so6671166ejb.9;
        Sat, 21 Aug 2021 02:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mbPZDp/xkJGnPgN5FrjhXWQn3CwvReLDj7zmHU7fpVM=;
        b=Q4cdAiRLpALsYo/BGM1e4/Df3zq8rBBfAO6wg/DJ7kxr5ekEoVLYHJHMt4ye1YZzw9
         50RWVjwqc86ZX2sWywYTM4z8YL8egBA5ZkfA0u88cittsY0xVyrdlcEwDMxmV49JEuJR
         Qnb17XXmligG5zNmGsEf/Kn7bhTnhASE7QnRiWgBW+3G06cI6p7Tpyb9SwZ4DCQOjuk/
         cxdtXV/gsgBQnc3fOGty4aP8QPmL7fBR2daZ3OzX5JITg1eOROUBgPy6L8wlQ98Ys5uD
         xjas/+qU8KloLKPJhGacXcVQVzG9U5YyuegS+005sigqFUGEB73OdcoenbSAW3jHtbe9
         2N5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mbPZDp/xkJGnPgN5FrjhXWQn3CwvReLDj7zmHU7fpVM=;
        b=OebV9gypuPZsUfJfBvLWa6GZqZRTHKosPnT3Z1nTDg1hzZ4Uh9JIVpfQutBZwb3KLJ
         FQR2bypNLS2Ed/yodBLJz9LopZDXokRBlEva0KRCpkibO9UZi2P83lRAClIYOrfWWqw9
         c6rqMUa+AQPRQx1w8TlnteVHTFSZCZftpH4UZH6jvqVOZbO9roExV9Lh9nMD3jO53Eh1
         TMBkZmgxMtMM4oQ4GdRYu9OqvqnKu6F8uDgr7EpoGb2SjpdkuxG5GOQ7QsLYs2JLCdER
         /FupAVB9RUFap3IYginjBrf9RJU6HJOfnI0ZtKizXKlJM3VgoJHuvSzKeAoxKIVx96pK
         GKog==
X-Gm-Message-State: AOAM530xwLsxhiaEU5wNJmeu6G/IH60nSL00LTqvNw8jQw8zZfEt7UkW
        kchy86JeHGTM4hYfV+7C79U=
X-Google-Smtp-Source: ABdhPJwnXCQolY4RrQa1SsJmvAPCgz0c5ncMp/XmzMtNZc2mg1+lNkceGOFyikTiuyHLZLUkYTQ1sA==
X-Received: by 2002:a17:906:3b54:: with SMTP id h20mr22119315ejf.436.1629537589196;
        Sat, 21 Aug 2021 02:19:49 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:19:48 -0700 (PDT)
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
Subject: [RFC PATCH v1 02/37] libperf cpumap: improve max function
Date:   Sat, 21 Aug 2021 11:19:08 +0200
Message-Id: <fb79f02e7b86ea8044d563adb1e9890c906f982f.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From commit 7074674e7338863e ("perf cpumap: Maintain cpumaps ordered and
without dups"), perf_cpu_map elements are sorted in ascending order.

This patch improves the perf_cpu_map__max function by returning the last
element.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/lib/perf/cpumap.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index fb633272be3aaed9..80e03b2f0c60cce7 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -284,14 +284,10 @@ int perf_cpu_map__idx(struct perf_cpu_map *cpus, int cpu)
 
 int perf_cpu_map__max(struct perf_cpu_map *map)
 {
-	int i, max = -1;
-
-	for (i = 0; i < map->nr; i++) {
-		if (map->map[i] > max)
-			max = map->map[i];
-	}
-
-	return max;
+	if (map->nr > 0)
+		return map->map[map->nr-1];
+	else
+		return -1;
 }
 
 /*
-- 
2.31.1

