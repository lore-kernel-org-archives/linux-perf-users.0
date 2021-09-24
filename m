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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED08BC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Sep 2021 11:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2DC260F9C
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Sep 2021 11:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbhIXMAA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 24 Sep 2021 08:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239965AbhIXMAA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Sep 2021 08:00:00 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FCAC061574;
        Fri, 24 Sep 2021 04:58:27 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id m21so9600076pgu.13;
        Fri, 24 Sep 2021 04:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XUkoX7ayRenN07dB5QBsOD3RtV0frJpcKE347BjmU20=;
        b=C/yol8vv2Ws0HzYoLwnlcIbEZG10a98YfobvCap0kKq94rVm1XewqT7SxAdcJWLJYW
         dwq4eIvvGkZeO42iO9qV7mpE5CxYmWIHjWbIO8G/QkwHC6/U6PzriwZSr5uHbZCa3Bzo
         hfMOKjnph6fQrVu7raRygQriqQ7ZFly510utm/W2oHCkdeR0xzi68pXvbfRBWpBrBfjC
         A20Ass1hfVmwvMlYq+vt4X9B6ultaOuDaEtWWrzLRue9RwTIceEqKSwjk0r4EtC+XP5g
         AmKP/s/E28GN3I+llmgd9mVLrPYAyvnekkzKw60IbKiBN5phh+kZKN/SZszkKP7lywhX
         I8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XUkoX7ayRenN07dB5QBsOD3RtV0frJpcKE347BjmU20=;
        b=waZM+OL5rOZJkNysOAXdBCIYsHP7HGA07po2BmIsmBzbSJy7ZCIt6n2u1zZtWI9nEN
         F8QuCzKVQaq+B9S6IKBlEo3dzD108QohUY3E/IoWEPe8b0qUbvRaL334kbHB3wTjDmT3
         JVOsK4Y8xiVnh8dEq/3nTjrWubDgHROcXI57Stb+0JNZepxLhgDD9ebDBUdd6cW0sXpE
         6MO6dtMTkxDIOtgJMpdv+q7xO746JW8q0RKF/Vorn1zHIWbRChGA4USTIqeTVXETudKO
         ex+mBqeWTZiPDkvo5h6LtIyXO/1CHCu7TxT9BXmr4jYieIHakHEIzvwnQ3hkNLuNtPyY
         pKQQ==
X-Gm-Message-State: AOAM5320cG5ov9S0GuIalQUWgk8S2OwNbs4619wB4jVUpQnX2hYYKzbD
        E6Twa5SMCYOfC4/2vfYbq104HEjxMjOvN48YUA8=
X-Google-Smtp-Source: ABdhPJzSZZIyTBH75s85toleFuWdnD/0DLUif4ivwgQ9Cc8Hd6pSjuiHWrVaHRN8ByfD0N5LzcjMBA==
X-Received: by 2002:a65:428b:: with SMTP id j11mr3401089pgp.301.1632484707103;
        Fri, 24 Sep 2021 04:58:27 -0700 (PDT)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id i8sm11628353pjg.6.2021.09.24.04.58.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Sep 2021 04:58:26 -0700 (PDT)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf config: Refine error message to eliminate confusion
Date:   Fri, 24 Sep 2021 19:58:17 +0800
Message-Id: <20210924115817.58689-1-likexu@tencent.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Like Xu <likexu@tencent.com>

If there is no configuration file at first, the user can
write any pair of "key.subkey=value" to the newly created
configuration file, while value validation against a valid
configurable key is *deferred* until the next execution or
the implied execution of "perf config ... ".

For example:

 $ rm ~/.perfconfig
 $ perf config call-graph.dump-size=65529
 $ cat ~/.perfconfig
 # this file is auto-generated.
 [call-graph]
 	dump-size = 65529
 $ perf config call-graph.dump-size=2048
 callchain: Incorrect stack dump size (max 65528): 65529
 Error: wrong config key-value pair call-graph.dump-size=65529

The user might expect that the second value 2048 is valid
and can be updated to the configuration file, but the error
message is very confusing because the first value 65529 is
not reported as an error during the last configuration.

It is recommended not to change the current behavior of
delayed validation (as more effort is needed), but to refine
the original error message to *clearly indicate* that the
cause of the error is the configuration file.

Signed-off-by: Like Xu <likexu@tencent.com>
---
 tools/perf/util/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 4fb5e90d7a57..60ce5908c664 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -801,7 +801,7 @@ int perf_config_set(struct perf_config_set *set,
 				  section->name, item->name);
 			ret = fn(key, value, data);
 			if (ret < 0) {
-				pr_err("Error: wrong config key-value pair %s=%s\n",
+				pr_err("Error in the given config file: wrong config key-value pair %s=%s\n",
 				       key, value);
 				/*
 				 * Can't be just a 'break', as perf_config_set__for_each_entry()
-- 
2.32.0

