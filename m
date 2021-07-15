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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B27C47E4D
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8404613F8
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbhGOQKf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhGOQKe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:10:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A985C061766;
        Thu, 15 Jul 2021 09:07:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u1so8528252wrs.1;
        Thu, 15 Jul 2021 09:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tr0/A+TCqI01gAoEmlPY21wDgKunjRfsz3Zqs/6r4Bc=;
        b=bKMjwKlR42cft75pOByaegNKyNHLlcXY8X0ZVOskgs/7lMQencp1vsMJcHaX/6YARR
         Ewl5PT7yb3FentUVZRgvz7cVPSuY9TN5yKjMbOS0Y6yTMAZaY81+siyDsmKeDypiTyrU
         rcNkrcF2icc7EXjIPGQ4LTE9qaltcqJdhrv8M8eW1+fpynhG7QG4l8O43RoKkAvUm1QN
         1ld6w81LiD59wkdeNmg2DIl2WCI9m93iTMc72jc4kddkLsfKGj89ZiMDYWBj9Dr8uUat
         9WXCs01YhB9faozs00s75VG6KUQX0u8zC43hKfs34G1ShMCp8byFVdGS6D1oJVuAKhI1
         +qJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tr0/A+TCqI01gAoEmlPY21wDgKunjRfsz3Zqs/6r4Bc=;
        b=btmBUpsv6LKtfklfaEfQIMuDZ2hy2Td6LXEWCMY+K+Y8dRMoY9F6G0fjHnl7DVNT+Y
         MflS2ijoRKiWhWfVq4YYfYlUDQd1CaUfZXeEcyp92df3g2g+lw9l70zNMZx2hlHLXtLo
         Lsy71wLsEIqxxSHu/Pf6BnAFdrGUfg8GoFfxf1rXVEibp4QB7Dm5V5mxiKOCqvPduWfv
         tew5awfMLAZxVS0gMYsjKl2X4I8wAi7elOQpUdu3h5cBb69oYBnC4V493KIFUREiajgW
         pB6HXP51PvoxwvljGb0skgwAA5sq+SU6YonsfpIkUuLyrJqj5ErN0RcosuTH0YKCzwmU
         gbZw==
X-Gm-Message-State: AOAM533YTg/Fi3XupK62uG4rHI5bTOXS8UoXmYApzcp2XOzPugmTtTo0
        VnpQGqoEoXT7bqZ/zXXDJFA=
X-Google-Smtp-Source: ABdhPJzDwqbTXeQ4OZXT7l6kW2QRUVHGJw/foPm8Hx8o68Bpomgxa/quV6bFoTC0d9t8OEX664SmTA==
X-Received: by 2002:a5d:408d:: with SMTP id o13mr6700452wrp.246.1626365258992;
        Thu, 15 Jul 2021 09:07:38 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id k13sm7446952wrp.34.2021.07.15.09.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:07:38 -0700 (PDT)
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
Subject: [PATCH 10/20] perf inject: close inject.output
Date:   Thu, 15 Jul 2021 18:07:15 +0200
Message-Id: <c06f682afa964687367cf6e92a64ceb49aec76a5.1626343282.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626343282.git.rickyman7@gmail.com>
References: <cover.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports a memory leak when running the perf test
"83: Zstd perf.data compression/decompression", which happens inside
perf-inject.
The bug is caused by inject.output never being closed.

This patch adds the missing perf_data__close.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/builtin-inject.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index ffd2b25039e36e1d..c88c61e7f8ccb6a7 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -993,8 +993,10 @@ int cmd_inject(int argc, const char **argv)
 
 	data.path = inject.input_name;
 	inject.session = perf_session__new(&data, inject.output.is_pipe, &inject.tool);
-	if (IS_ERR(inject.session))
-		return PTR_ERR(inject.session);
+	if (IS_ERR(inject.session)) {
+		ret = PTR_ERR(inject.session);
+		goto out_close_output;
+	}
 
 	if (zstd_init(&(inject.session->zstd_data), 0) < 0)
 		pr_warning("Decompression initialization failed.\n");
@@ -1036,6 +1038,8 @@ int cmd_inject(int argc, const char **argv)
 out_delete:
 	zstd_fini(&(inject.session->zstd_data));
 	perf_session__delete(inject.session);
+out_close_output:
+	perf_data__close(&inject.output);
 	free(inject.itrace_synth_opts.vm_tm_corr_args);
 	return ret;
 }
-- 
2.31.1

