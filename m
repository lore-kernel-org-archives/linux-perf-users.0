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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F352C12002
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Jul 2021 14:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06F83613E8
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Jul 2021 14:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhGPOPC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbhGPOPB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Jul 2021 10:15:01 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83514C06175F;
        Fri, 16 Jul 2021 07:12:05 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j34so5918240wms.5;
        Fri, 16 Jul 2021 07:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pHO/OuJ19tFgQlImaLECSeFWZFEdjnugOKUNYJ6qjas=;
        b=Ihnytgiyf1ZDDOEAswttF30OscuVa4F4xg4QtRKFYmu9KjBtibGRiliedYD2zwtgg2
         ILgYAA0PZOJVJLTHiMD/9M8qNeleqkhvQb68cn27Jatu1tCwxnH7MY1NT4YJMOOcnDuO
         SuE1vpkAeriB4jHEtHoKo1rnoRUW0maTHdusSU7Q/+7HESyVnPOq5cP/PmD/UkJ/IpkK
         gmrjlx6262qEfGa7v70XRtGEvNlvCg7YFi4QE/njHs06qnKs6yL0AKRyZSfdpxLrSJmB
         Yo52bNZDBHASGeFgKOL9BRpyj1MSIxOnGyJT53IJLCSSI4vw5n4u023h7Unfd1I5vFje
         9iMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pHO/OuJ19tFgQlImaLECSeFWZFEdjnugOKUNYJ6qjas=;
        b=VjsexSdF20T6U8Sc7F9kjypKi4UdgE6lrGyO8l0IenoOHdAOA47ChiJHIvdwP1f/13
         10oQE2PfVEF0mesQsOUpCy5VvYW/NbarseTBge4LdmAtCl4A35YnijY4cTyaV9MQc6aQ
         WyUqm0SOseLA80V2YWLmE/bGXy/HA94D8ibYxcEGDhFRoiG8dDCPNMnH+CghRowmNsUj
         4tYFf6Rq2LSo+IXDcVDsrlO7LTjzE5+03byNxv4p4mE0kwhCPNsn96LbNK7BQVsxZW61
         R9RWOWa5uchLfPHRlaDchmo+J5n1Vwtsovosa0WbaVDDUM5DaLI4hQLaLBbQYhqhK3bS
         fGuw==
X-Gm-Message-State: AOAM533vyfz/61D6Iq8+rovNC7X7NFn7INQt4m4jyHqyTw1YBiXLbZ1T
        1JPRu3ks3u8IPTnnxOTBCIE=
X-Google-Smtp-Source: ABdhPJyXA3L2LOIAr5mUWHvp28X930mFBTDm4GUANPazykCet5ITaCY4PDUFPS4wyQYc2vXbFnYXSw==
X-Received: by 2002:a7b:c4d9:: with SMTP id g25mr16350004wmk.108.1626444723940;
        Fri, 16 Jul 2021 07:12:03 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id v21sm11327787wml.5.2021.07.16.07.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 07:12:03 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] perf data: close all files in close_dir
Date:   Fri, 16 Jul 2021 16:11:20 +0200
Message-Id: <20210716141122.858082-1-rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When using perf report in directory mode, the first file is not closed on
exit, causing a memory leak.
The problem is caused by the iterating variable never reaching 0.

Cc: Jiri Olsa <jolsa@kernel.org>
Fixes: 145520631130bd64 ("perf data: Add perf_data__(create_dir|close_dir) functions")
Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
Hi Arnaldo, 

I think this patch might have gone lost in the mailbox, submerged by
other mails.
I'll take advantage of the resend to add the missing 'Fixes:' tag.

I didn't flag this as v2 since it contains no logical change, let me
know if doing so would've been better.

Changes from first send: 
 - collected ack from Namhyung
 - added Fixes: tag

Original: https://lkml.kernel.org/lkml/20210621214220.167927-1-rickyman7@gmail.com/

Thanks,
Riccardo
---
 tools/perf/util/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 8fca4779ae6a8e90..70b91ce35178c5f9 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -20,7 +20,7 @@
 
 static void close_dir(struct perf_data_file *files, int nr)
 {
-	while (--nr >= 1) {
+	while (--nr >= 0) {
 		close(files[nr].fd);
 		zfree(&files[nr].path);
 	}
-- 
2.23.0

