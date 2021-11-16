Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5620C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Nov 2021 05:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E39861B2A
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Nov 2021 05:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbhKPFsg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 16 Nov 2021 00:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbhKPFsV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 Nov 2021 00:48:21 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC636C110F00;
        Mon, 15 Nov 2021 19:43:06 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r23so518240pgu.13;
        Mon, 15 Nov 2021 19:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aJdSZ6OMshOYDRFetJsmDqIzbFQ+ncYaLLKX863U+rQ=;
        b=B/CbNxsiIl7LssZg4EyhZONZdhuiglG3Ns6FHvUEvyxHktTtEQpWk3ItIVlUOJy+28
         5+CWyXihGpWO2qhfaLmKrstargsJXGdSFWmswJrUIhqwXnVyFuaj4ioAH7i6CTtcrAfo
         Pd7X1oAsXA/esTme3MVoMG8pLw64zVvNtOo6ZvhetUlozk6dOEmNC0Ek262+QuKFiaXE
         EyxPB1NWBLWeuRsfqi3crzkG0yic02KHjbXMv5OSD1yOTZCtXBFNphKt6Ldxl0dsbyog
         Fd73Kk34nsdeJhnG459ynTlx97YduFFXOvcPWMVOVk9turZtbHukLWoubstS1QSUl0gq
         uVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aJdSZ6OMshOYDRFetJsmDqIzbFQ+ncYaLLKX863U+rQ=;
        b=EuVR+9Xo8fbm6jecsWSJyFRzynEubQh2ujdNu6KXv0Xs5UKwwh2BTrkk4hy1ScGYhD
         1EsIeRkatSclqL/uyBX5EcVY81+gV4W4Pc28d652rZgODj1v+wYfDIgPiT2sXywxY62t
         VMrF4nxQoVI6XviL1QVvr8mRqvKt2DiWyUsAtpPLTgeBerXtQtktaNYFDC+FANIM6yFu
         S39/d5obPmz05lzT+MSG0JG4cLHrxd6DX0gRFleEgkHX9o0ejQE+Xh3Tvwn5yGFufor4
         l7s8UO8utlzXX9i4bkkfht8uRppiD03k36nAlEKIO0CBsI4HFs79H9wWhfulKT7OCBlR
         MZSw==
X-Gm-Message-State: AOAM530D/E3525CvNf7/LBc4EyIgGYaJhdJXigdhYOAluCd4B1NhbXIx
        KDdYP4OCNJc+zc3SSZyzwWw=
X-Google-Smtp-Source: ABdhPJytN+BCbSo2XoyZL1yfqHBrcw+TjawhXqhoEKScx4RJiH1ISdxQt/lwduHlzaaIdqWLbWSy6w==
X-Received: by 2002:a63:be4e:: with SMTP id g14mr2895099pgo.194.1637034186344;
        Mon, 15 Nov 2021 19:43:06 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q13sm18861701pfj.26.2021.11.15.19.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 19:43:05 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] tools:perf: Remove Unneeded variable
Date:   Tue, 16 Nov 2021 03:42:53 +0000
Message-Id: <20211116034253.154422-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: chiminghao <chi.minghao@zte.com.cn>

Fix the following coccicheck review:
./tools/perf/builtin-trace.c: Remove Unneeded variable

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
---
 tools/perf/builtin-trace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 624ea12ce5ca..4d5106877fcd 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2967,7 +2967,6 @@ static int trace__process_sample(struct perf_tool *tool,
 {
 	struct trace *trace = container_of(tool, struct trace, tool);
 	struct thread *thread;
-	int err = 0;
 
 	tracepoint_handler handler = evsel->handler;
 
@@ -2983,7 +2982,7 @@ static int trace__process_sample(struct perf_tool *tool,
 	}
 out:
 	thread__put(thread);
-	return err;
+	return 0;
 }
 
 static int trace__record(struct trace *trace, int argc, const char **argv)
-- 
2.25.1

