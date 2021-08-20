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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFB5C4320A
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 13:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0EBA61053
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 13:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240591AbhHTNKd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 09:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238510AbhHTNKd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 09:10:33 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30389C061575;
        Fri, 20 Aug 2021 06:09:55 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id h9so20184688ejs.4;
        Fri, 20 Aug 2021 06:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=amLfY2WyHMkOd7qaXpy+DB72ahvQ2PinE48ltai+NY8=;
        b=rwSw1HOFFZvRjHgzdxD6wIWXmbfC1tIbpjup1mvWgKiVHgnG/r3AedF9t81fLmqkHf
         7E+PAgpDncoeBFUw0R77F9l28gYw3HhpT+ljs2Bh8Z/YJRBKD98iDfhnNH8s8QSRXalX
         sDTXk82uptoHbmO990kyKWxdC3pjMrpD8GLdVICdK3hdyuhBwFbpoMkqI93V/Ks50YF6
         L7ea3Olo1ttG6U2z8BK7eIWxEE0fDmuMYF+b3rTDshcilGXzyMp99bern34TouDOIRXI
         qdhZ8EjFLv31xAJJaz0rHXZyo2N7gtkS9QaUmtj4UPDle/VtHgpRP8SVJTlZa545zR1/
         C2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=amLfY2WyHMkOd7qaXpy+DB72ahvQ2PinE48ltai+NY8=;
        b=l0eFYTs7Ha6zwD/5NYAS3VqJTGEc/MW+lTwibWMyeNy7JUu8YTiSGDwjXgrpkg/3DS
         gZ6gLWrBCXTw8hUujQsLXgJmhe8S4EdfoIOYVsJRPUNzl83EWSP+vNilayK2kunJWQi9
         G41APKscb5Os7MyaSV9uUSBEmKQVkLWgjVWmCpEEIov4X0oxxlyhMSyNYVg7y8WQYO7T
         xyVWJYoO9hGudsTn0UrvkvH/9G7UVmwPwkBGYp8d3oj/2StYDMq2xBpo55lNfdLDcC+K
         C1bKlLuvBc6M+Zx1WYsYB/810/i2YCC9vJRz9SznVL6PIRFFjirUVS2MqXOj7WgQTMYf
         nHUw==
X-Gm-Message-State: AOAM533rEfg5ScZusVjT+7rmehl9f0nZwLTaWT5Gre3AASQuEwc7qOxY
        MNS5ML/kjbeCjjlokImTTF4=
X-Google-Smtp-Source: ABdhPJwigLSzgY4Ua5OOim8zTK83W7SDyxDLR5S3OjVyyHyfHwAly52j9pdy8ZsHMMURT+zQ1mZgxQ==
X-Received: by 2002:a17:906:7154:: with SMTP id z20mr1255396ejj.547.1629464993668;
        Fri, 20 Aug 2021 06:09:53 -0700 (PDT)
Received: from honeypot.. (mob-176-243-242-182.net.vodafone.it. [176.243.242.182])
        by smtp.googlemail.com with ESMTPSA id n2sm3594518edi.32.2021.08.20.06.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 06:09:53 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>, Song Liu <song@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf config: fix caching and memory leak in perf_home_perfconfig
Date:   Fri, 20 Aug 2021 15:08:17 +0200
Message-Id: <20210820130817.740536-1-rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Acaict, perf_home_perfconfig is supposed to cache the result of
home_perfconfig, which returns the default location of perfconfig for
the user, given the HOME environment variable.
However, the current implementation calls home_perfconfig every time
perf_home_perfconfig is called (so no caching is actually performed),
replacing the previous pointer, thus also causing a memory leak.

This patch adds a check of whether either config or failed is set and,
in that case, directly returns config without calling home_perfconfig at
each invocation.

Cc: Jiri Olsa <jolsa@kernel.org>
Fixes: f5f03e19ce14fc31 ("perf config: Add perf_home_perfconfig function")
Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/config.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 63d472b336de21d4..6ab670cdf512507e 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -581,6 +581,9 @@ const char *perf_home_perfconfig(void)
 	static const char *config;
 	static bool failed;
 
+	if (config || failed)
+		return config;
+
 	config = failed ? NULL : home_perfconfig();
 	if (!config)
 		failed = true;
-- 
2.31.1

