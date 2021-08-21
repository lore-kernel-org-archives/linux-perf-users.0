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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB43EC432BE
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90DCA61186
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbhHUJWy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbhHUJWc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:22:32 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B341C061151;
        Sat, 21 Aug 2021 02:20:31 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id bo19so17596097edb.9;
        Sat, 21 Aug 2021 02:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QZgLUS1D1n1+osF5QCdhScd9/ZmMYRc9ErCmnvjzL/o=;
        b=aXZ7T+Da/te6Uru6w9k13v1OvEQIVyjAlHMvzTX1OMB1TOzHXd+8FIUWDnImHdut8v
         l+7P9LQmIPxcWjI/fQRy70tNtZTXRVS2hjJ/2Wm9E2H3LQY9hw2lP+mzh/wwJYjGVx1V
         wUBLO4h6zs6iUTlaKnA5C9m1KAw2ry+zadZNW/rZA59ZBGltah2VSaO8fFfFUmQlP5DE
         32iOqmlLqady8+ykIaJ39vxA7U8Z1ua7WuGasHmSdqDVx35ADu1tjWt5Gc+/h4LJ9nBg
         eUUpBKLqvQHHulayj4Y9gpax7ySY36ciDJy1ftqJgK2PXlzpNpqhNE9ExgrqFCx30Ooh
         TRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QZgLUS1D1n1+osF5QCdhScd9/ZmMYRc9ErCmnvjzL/o=;
        b=C5nOZxzdZWtnCu8ngwhwgBp6KngZMV2TRbs1Bk5Rp4O5ynMwJzIrPW3bG8aE4zcSQ6
         Cy4eyLuOvt82ZWsxhmShlwBSjK0kAG2MLbulTGHAb86uYuZ0E74F+E5Fco0VuOqU1HYn
         TIA0yhViMJiz0AQKiHYFNBtNv3HZFNPvtIquSeaOFabhSkRi81JxBhdwbHrTrh6DFdGU
         l9emkudzXp2D5mX0KfpZgNeR149+OZZwexA9YJu32Hti7xVe0Hcph0dzvPaTkTxxdlBP
         tP9RWBqIjyxjMp27d5xCMZaoLJWJe5qMqPJm8xUV/5hKFxrl/M2t1CvK5Fj2/ed8rAma
         m5qg==
X-Gm-Message-State: AOAM5321AXtLQcRJ+rE/VML2xraMTXIvw+jFAD6UtZ8NCgZgcMD38NBc
        Vk89AWaQxKmrf1vEa2ARVPYbIW6dO0vRamxe0Ck=
X-Google-Smtp-Source: ABdhPJxh7kN8bNFHQBGgpqoc5aZ+/dAV5K9rlk7/zXzEEDSfwpFCqGS1UFt2jkbnAsHgE0Y2v1LI3g==
X-Received: by 2002:a05:6402:1011:: with SMTP id c17mr26254970edu.144.1629537629951;
        Sat, 21 Aug 2021 02:20:29 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:29 -0700 (PDT)
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
Subject: [RFC PATCH v1 33/37] perf record: pin threads to monitored cpus if enough threads available
Date:   Sat, 21 Aug 2021 11:19:39 +0200
Message-Id: <d2218d8fc69eb7c9e85454af5065523f86c37ff1.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch sets the affinity of the workqueue threads to pin them to
each monitored CPU in case the --threads option is set with enough
threads and evlist multithreading is enabled.

This yields a better performance for the evlist operations, since
affinity need not be sent by each thread everytime.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/builtin-record.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7802a0e25f631fac..e2d2445e05d7c07a 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2945,6 +2945,16 @@ int cmd_record(int argc, const char **argv)
 			pr_err("setup_global_workqueue: %s\n", errbuf);
 			goto out;
 		}
+
+		if ((int)rec->opts.nr_threads >= rec->evlist->core.all_cpus->nr
+				&& rec->opts.multithreaded_evlist) {
+			err = workqueue_set_affinities_cpu(global_wq, rec->evlist->core.all_cpus);
+			if (err) {
+				workqueue_strerror(global_wq, err, errbuf, sizeof(errbuf));
+				pr_err("workqueue_set_affinities_cpu: %s\n", errbuf);
+				goto out;
+			}
+		}
 	}
 
 	err = __cmd_record(&record, argc, argv);
-- 
2.31.1

