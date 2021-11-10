Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63734C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 02:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B52610A2
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 02:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhKJCXk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 21:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhKJCXj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 21:23:39 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E84C061764;
        Tue,  9 Nov 2021 18:20:52 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d3so1216967wrh.8;
        Tue, 09 Nov 2021 18:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bfhSZYPY8T0EFFd6daeUidRct6CZgx2lPa0l7M60k20=;
        b=XVnCSLuz98VltiVH1qCg1yV1rg6yvI5eEdmMp1nuFl6oq0NFez178vKb1THNvDaAHm
         K2wGKWkLNmmAgHRO60zx71lfUoO0HAuu6XYz5ERzWtQ3v264bupf/Eda5kPWgdDhKALa
         KMDSuidOacnlbZclUBtqxmeDrmaOQ8g0GD1B04yqTLjHUCq4VLpRWbVelzC2kR0Ec+Kh
         ltSFK8I1NRq/BlMOu382i6ILh5Av80+GK0aBp/vDZoqnAOs8IrQZygnwSY7sqoBfE1W9
         Q4cN1SHHmVONxSuUZjI2Vce/MD8t6vK9vPhqlH5ANR0cU/iXtPkaPkEdhn1NCeRUtR3r
         KOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bfhSZYPY8T0EFFd6daeUidRct6CZgx2lPa0l7M60k20=;
        b=g2SQDJVO6YKadtdB+5UMGH8hdd+kxVWt24njCHCs2JgLB/EDAgEogaLjHsxrdiyStm
         jXYMJiyl5dKMObfgfjGVJDQ3Pgdlyigv4ty6dL3sl23aQThoo3486HnBZp8Dmhg0RoEp
         gMLkrcCdBvW2Qv6mdstYK7q8WGTUcOlkUtR1qLcjjGVKSA2/8KFWPl1GHoW6vFp+XrU6
         +pYsdYc6kC1tS5nyTpLixakCRGUoMwkKCpWCrcx98P9gF4TquSDai5ge42HSggJ1DMU8
         o1jnehbhjdhkDfJG/w0uRsn3I8H+CHwYQDq9pnI4n/v4gXe5ixxwW7Prl5tawef7Pdas
         LlFQ==
X-Gm-Message-State: AOAM530IXk8i4lfcG0xoSjsGqWNsYwQnIrZ/fnZbUX4g/bqJ5hY8OtdC
        Fep4mnYl+3XGz2bRgMt0GdY=
X-Google-Smtp-Source: ABdhPJwAiqKlbBLI2I/qHy/Zy3wKV2lYE/IyT+SBFWOZDawro/Z0Bz8n3FgjiVEn3c77Z86w4+TGiw==
X-Received: by 2002:adf:d852:: with SMTP id k18mr14725320wrl.391.1636510851412;
        Tue, 09 Nov 2021 18:20:51 -0800 (PST)
Received: from localhost.localdomain ([197.49.136.152])
        by smtp.gmail.com with ESMTPSA id p27sm3870610wmi.28.2021.11.09.18.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 18:20:51 -0800 (PST)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     sohaib.amhmd@gmail.com, irogers@google.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf bench: Fix memory leaks.
Date:   Wed, 10 Nov 2021 04:20:11 +0200
Message-Id: <20211110022012.16620-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports memory leaks while running:
$ perf bench sched all

Fixes: e27454cc6352 ("perf bench: Add sched-messaging.c: Benchmark for
scheduler and IPC mechanisms based on hackbench")

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
Acked-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/sched-messaging.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index 488f6e6ba1a5..fa0ff4ce2b74 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -223,6 +223,8 @@ static unsigned int group(pthread_t *pth,
 		snd_ctx->out_fds[i] = fds[1];
 		if (!thread_mode)
 			close(fds[0]);
+
+		free(ctx);
 	}

 	/* Now we have all the fds, fork the senders */
@@ -239,6 +241,8 @@ static unsigned int group(pthread_t *pth,
 		for (i = 0; i < num_fds; i++)
 			close(snd_ctx->out_fds[i]);

+	free(snd_ctx);
+
 	/* Return number of children to reap */
 	return num_fds * 2;
 }
--
2.25.1

