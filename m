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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D828EC47083
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Jun 2021 22:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8EAD613DE
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Jun 2021 22:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhFBWO2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 2 Jun 2021 18:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhFBWO1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Jun 2021 18:14:27 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495A8C06174A;
        Wed,  2 Jun 2021 15:12:30 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p13-20020a05600c358db029019f44afc845so2503673wmq.3;
        Wed, 02 Jun 2021 15:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PDHp86QEN5vhB4RtZpZVG/Zl2JnNrckM7sNyGAPWl3Y=;
        b=KtO94BoemKgkuUNbAKcBQ8dPqLqhhhPmPEup1lJQ+iZdQsuo7jM3HnG4AqrGS5+zzd
         MpUM1bSFtLm/XEqEIA8q/6ZppvV3yIX12m2gYVMYeFN8FbXbO/DgjJ9P8W+sPY96SUeV
         X55OPFH7aXJ+m6+I0itAHnPS5sNk2yCEL866CnvcXujPfrGA7426iRNImm162EWcVLfg
         3ECmbJ5UDkpTdyfzAqywfHV75cT3ptCaAqiIwubtki0xV+I9BQYGTYQsbLLe/WzR9kd0
         r19DijyuMiIx2BEPoyiY0cULO7WhvwvTd4oyd89VGtQBPLUAOmwGFr8yNM+OgOMIZt23
         nx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PDHp86QEN5vhB4RtZpZVG/Zl2JnNrckM7sNyGAPWl3Y=;
        b=rtGB0sxrvpUcFsszEW964+OFRKhz95m31qIFRTe/iWetk/6gwkIdLt+VBS+OLmimpS
         6Vkzf/WrmDtzKtZZRZL69BdHDpzdp+5Tj3lsZxZf0ywkZdZpy0rp8vNouRl5fx/2WFc0
         ut4ydcTLDRwG8PKWFQPvhtMJYe0KrY0YCwvtMZcTFELwsIvlFesm84Ve92jS9cOEqUpa
         i2Oxv4OUxKqOzyiAeOtzc2mkT+6CzuFQ9/aMckJznfC9No12CNpTlh/h7i4ep0Ih8P2f
         DFK8kckITZf/CV6pLnGy8BhCUeFYkJBcCV5kKFgOSAKG13kXFBa8TPupvDwHNuiTq0cI
         cjaA==
X-Gm-Message-State: AOAM531QRaIVqxNHm65FMi3G1BZi1HztamNx1yGRpyQRIaB/EG0lT65j
        XLcA+/5ndjErsE+LMvm5jz8=
X-Google-Smtp-Source: ABdhPJzE/xf3GJENaMAxBll256r5dzEDoSfJHp+fY8DSIWe+8UjwfffWcwHzwzzN2BbuAGp/VDz6fQ==
X-Received: by 2002:a7b:c005:: with SMTP id c5mr34410627wmb.113.1622671948880;
        Wed, 02 Jun 2021 15:12:28 -0700 (PDT)
Received: from honeypot.epfl.ch ([151.29.82.133])
        by smtp.googlemail.com with ESMTPSA id j1sm875775wmi.44.2021.06.02.15.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 15:12:28 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     Riccardo Mancini <rickyman7@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Fabian Hemmer <copy@copy.sh>,
        Remi Bernon <rbernon@codeweavers.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf symbol-elf: fix memory leak: free sdt_note.args
Date:   Thu,  3 Jun 2021 00:08:33 +0200
Message-Id: <20210602220833.285226-1-rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Reported by ASan.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/symbol-elf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 4c56aa8374344..a73345730ba90 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -2412,6 +2412,7 @@ int cleanup_sdt_note_list(struct list_head *sdt_notes)
 
 	list_for_each_entry_safe(pos, tmp, sdt_notes, note_list) {
 		list_del_init(&pos->note_list);
+		zfree(&pos->args);
 		zfree(&pos->name);
 		zfree(&pos->provider);
 		free(pos);
-- 
2.31.1

