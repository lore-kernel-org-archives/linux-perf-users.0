Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BF6C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 Nov 2021 08:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 511BF61AED
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 Nov 2021 08:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhKSIuA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 19 Nov 2021 03:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhKSIuA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 19 Nov 2021 03:50:00 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E1CC061574;
        Fri, 19 Nov 2021 00:46:58 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o29so7757314wms.2;
        Fri, 19 Nov 2021 00:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q2AGt3Hhuo+kAQaGBlgUEMx5wCq5Mqmhpu3MWgiIMGQ=;
        b=iPR4/f0HaRn2XLVu9CQYuIPxaPnZ88rG3z2R1dtnLt5KYnk/xWbFIWIDjOsKcyTjbv
         WFpeywLdzxuA/oZmu1xlotIUNBIIU5YgI3fggQdFYFtBJOzsZUiv5a2QMauw6pXJDu41
         2YvgtZxBul8ZSQdgaAPVr0JS4dFwriE50rrd/aCIIH7wyOpMBcapftIZaf5136Jz4+PR
         XHzoB8eA6uea93FnTRUkKxXUVmw+mz4p+JC2M32xaWivtm9fAKZgFYPdvvUMmAfHWl3P
         tOskOlxNbw3Qw3bcB2+5PZz+b8LCCheTBa0OKU6bhF/quQiaGmq0vv2UfXqB4BnhTqnK
         lbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q2AGt3Hhuo+kAQaGBlgUEMx5wCq5Mqmhpu3MWgiIMGQ=;
        b=PunA6rG06DmscLNfIcb+hxLFJr2xdRhgC0KbgwNx8OZo96eDj72bXaeiCJxYEcz+JD
         GX5qT+EjJsfWX2rCJ0RrG7Aj3x9tVgtbJAtNTU05d9LlLN8Ik4Os5t9Z1znCcs16YG/N
         8BB4NosWHYFJ8gvu412ifMEYsadGOqztt5LGp6wVxpYkTUxOQrIbPVju6BG46AzGUdVg
         S97GN3qxv2RX1LTbXqcMWYKE63cEbQjesU0DS6tlxIciiwuBE4sIFT8ec3c0B0c3jmAN
         3qC2x/dV6Rr6F1PEKPJDrZAkC9RPxAhD0SqMbom8DeqyuwwFkeA52Egw60d05uL/ID9E
         OBMg==
X-Gm-Message-State: AOAM533RDbVzLm8SEMyqBQc4/EX4FIKjD7gr2datRCkzcX4c9ed695Qi
        bNsbzVflFsCzwYs/vAObOpI=
X-Google-Smtp-Source: ABdhPJwXutOfbJdhoahNUSmWWI5X+qlf33p6E/qR7A9lWKpHwyFbjgvF5vJYCRKcVfHvCVBTP0qMNA==
X-Received: by 2002:a05:600c:1d91:: with SMTP id p17mr4753563wms.193.1637311617078;
        Fri, 19 Nov 2021 00:46:57 -0800 (PST)
Received: from localhost.localdomain ([197.49.250.127])
        by smtp.gmail.com with ESMTPSA id o8sm2288090wrm.67.2021.11.19.00.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 00:46:56 -0800 (PST)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     sohaib.amhmd@gmail.com, irogers@google.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf_counter tools: Fix memory leaks of add_cmdname()
Date:   Fri, 19 Nov 2021 10:46:36 +0200
Message-Id: <20211119084637.178890-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports some memory leaks when running:

$ perf xyz

This patch adds the missing clean_cmdnames()

Fixes: 078006012401 ("perf_counter tools: add in basic glue from Git")

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 tools/lib/subcmd/help.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index bf02d62a3b2b..4a433f4d19a1 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -187,6 +187,7 @@ static void list_commands_in_dir(struct cmdnames *cmds,
 
 		add_cmdname(cmds, de->d_name + prefix_len, entlen);
 	}
+	clean_cmdnames(cmds);
 	closedir(dir);
 	free(buf);
 }
-- 
2.25.1

