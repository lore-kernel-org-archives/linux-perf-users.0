Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1ACC32771
	for <linux-perf-users@archiver.kernel.org>; Sun, 25 Sep 2022 02:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiIYC7R (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 24 Sep 2022 22:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiIYC7M (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 24 Sep 2022 22:59:12 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21E243E40
        for <linux-perf-users@vger.kernel.org>; Sat, 24 Sep 2022 19:59:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id l10so3409554plb.10
        for <linux-perf-users@vger.kernel.org>; Sat, 24 Sep 2022 19:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=OS4UYZ8DIUkJDvQP5tRmIq0ewNPcm5dr1beINkDXglI=;
        b=pMsNwRcTsrUwx4709l7bBQopVh9p8cTyUX4+N6zn0nGWfJ8aUJeAL6mO0gTX6Fasms
         v6I78Uu9UXJKgF9koM9Gqx2WiZ9DClMxdqnvUt/Qo2o2CF6QPdvNcnnS1J68fBRHlbAw
         1ELy3Qr8uuE/wKvYsVvHYLnEmfvYXtu//PF3eBf37gXTqz9SdeNH0Qt8Rf5LoVmeECOG
         E1eJmnL8Ko/RY4KPHkoIGJVVSUbb0CHJ0Zk0ZMs01k4+9bKxesewUk4QsDCjk40Ih3q9
         W5daZ9pOk/mE+CjCMPmT+2PpcxG/n3BcT6VvlGFxksLSc3bYw/U2+ptcBKiw1MCgLIbM
         PP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OS4UYZ8DIUkJDvQP5tRmIq0ewNPcm5dr1beINkDXglI=;
        b=yFyN5jUMhIcNUUI9IvTUFI98Z5duqR5EBVBLCmCEF+QwzVkS4bZHTkAKHeHmp9I/aI
         6QHuorOPtVMl/+FF1IbGRsz2D4umlaYCnET0mKNDhwp/ZJ6zc08K1XJ2GrY8sJF9U+S5
         9EhHZe4GzHR/Ttfqxe41w5dNSdAoBcRg627BIVHX7wEICkzgKK++hIhRyHXE1Mve4/5B
         htw/UbpSpNy9m1lmb6NwIRXe3We9JgEYsXWXwhKZ4Qf4Elr4BM3TnGWCcK0867QymvDG
         Nb7Prcl4YmjMscgV9FWXYlTS++xn7FlQxq9yIn4fb0EqQejmgK2MK6JhpeF27RH33PF0
         BgrA==
X-Gm-Message-State: ACrzQf15HSkmOI3juV5b1MRPsSZXfU+9hKNYizTd+9qV2n6hgv46c6bM
        jbt6bIC0GZWfU7IECXGbBIcZUg==
X-Google-Smtp-Source: AMsMyM5joIJtYlA+twvlOzLjCdbWpan9i8/RzhsZZqMGnmVHxEZzaYDb9ZC1IigVr9ymwVaW1/gj5w==
X-Received: by 2002:a17:90a:1b6e:b0:1f5:1902:af92 with SMTP id q101-20020a17090a1b6e00b001f51902af92mr29852232pjq.238.1664074751300;
        Sat, 24 Sep 2022 19:59:11 -0700 (PDT)
Received: from leoy-huanghe.lan ([137.184.34.254])
        by smtp.gmail.com with ESMTPSA id z11-20020a170903018b00b0016bf5557690sm8409198plg.4.2022.09.24.19.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 19:59:10 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 1/2] perf subcmd: Set environment variable "PREFIX"
Date:   Sun, 25 Sep 2022 10:58:34 +0800
Message-Id: <20220925025835.70364-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220925025835.70364-1-leo.yan@linaro.org>
References: <20220925025835.70364-1-leo.yan@linaro.org>
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

