Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A756ECAAD8
	for <linux-perf-users@archiver.kernel.org>; Sun, 18 Sep 2022 03:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiIRDPm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 17 Sep 2022 23:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiIRDPe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 17 Sep 2022 23:15:34 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D6D22BEE
        for <linux-perf-users@vger.kernel.org>; Sat, 17 Sep 2022 20:15:33 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id b21so24996348plz.7
        for <linux-perf-users@vger.kernel.org>; Sat, 17 Sep 2022 20:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=OS4UYZ8DIUkJDvQP5tRmIq0ewNPcm5dr1beINkDXglI=;
        b=TeaGBrs24ZanM/HhDvim4InqF+clK+TEuKanEY4Qnu85x12T07n0VtWqplkYIXJTBC
         KttvxGMKbG6aQBKsS054AZX2oJhYt04ZGPmzG0f5KhpStYZFmo9JyJtbqnCDNyAp0aw3
         jn9VEoaZ0ohW5CEc6Wcr20EsxRBYSyj3/XE1H1CQOc5fLzSQiBPxypWF0W3vjV+UNQsO
         pGhGPA0FBc/sicFLqBS+GtoGo1ulND4DtvVJ3zlWkK2HssBqR5yentQEqwtbzmVVkw2U
         lp5k3pI3Mac9pQ+MaDouf9II8T6wMl7Utk19PBxxiMXdcgw4OszWSI0LAAYXTulaujkL
         X3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OS4UYZ8DIUkJDvQP5tRmIq0ewNPcm5dr1beINkDXglI=;
        b=AmHzJ06CgiLMyYrlhGQv+3G7iYixy4kzlJ1gSE+QBP+hwESoBf2WQYBX3ZRO1rJtHX
         vE73WzG7r96TQPE8bGeZIu1JU4bdU1IC0poTf1pnKewvQ4B9qfT4d78fkFmy9SpvbfuE
         R1MupTXsoMrNECrEfl/g7ecVOSBMrCU5yPzoUOxBkqiIA1PsVKeWzK1Pu3B//lhyFV73
         7rbucuq4p7SwpmWROA9iHt+PPQkinjfnF5pP/rg6QVhjrayNEcBoWwgX4L2++WU7H0To
         YDQNZxlZEkJf85Wv5akWRIXrtanEahHsAPhbRWCNTo1qwHc6xI52WKHpKmW2msyXZD8D
         JjzQ==
X-Gm-Message-State: ACrzQf3AcgcDQa+YV8lLn6M40hxgFIB99OP1hV/6Tmuc+gKZAmwMR9Ak
        mUoBHnnyvo/ghW68t83RRiKQIA==
X-Google-Smtp-Source: AMsMyM7qxFQRgCk07DjoucrzWeRWhfxIw3/DC+osQydxwrq/UjTjNm9dpGDI8OYLwiSRCKpbM1Y4/Q==
X-Received: by 2002:a17:90a:c782:b0:202:c73e:5488 with SMTP id gn2-20020a17090ac78200b00202c73e5488mr23516835pjb.202.1663470932638;
        Sat, 17 Sep 2022 20:15:32 -0700 (PDT)
Received: from leoy-yangtze.lan (45.78.11.189.16clouds.com. [45.78.11.189])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090301cd00b00177f4ef7970sm17822647plh.11.2022.09.17.20.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 20:15:32 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 1/2] perf subcmd: Set environment variable "PREFIX"
Date:   Sun, 18 Sep 2022 11:15:23 +0800
Message-Id: <20220918031524.26719-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220918031524.26719-1-leo.yan@linaro.org>
References: <20220918031524.26719-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Set environment variable "PREFIX", it will be used by invoked shell
script, e.g. the shell script uses it to find lib paths.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/lib/subcmd/exec-cmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/subcmd/exec-cmd.c b/tools/lib/subcmd/exec-cmd.c
index 33e94fb83986..5dbea456973e 100644
--- a/tools/lib/subcmd/exec-cmd.c
+++ b/tools/lib/subcmd/exec-cmd.c
@@ -24,6 +24,9 @@ void exec_cmd_init(const char *exec_name, const char *prefix,
 	subcmd_config.prefix		= prefix;
 	subcmd_config.exec_path		= exec_path;
 	subcmd_config.exec_path_env	= exec_path_env;
+
+	/* Setup environment variable for invoked shell script. */
+	setenv("PREFIX", prefix, 1);
 }
 
 #define is_dir_sep(c) ((c) == '/')
-- 
2.34.1

