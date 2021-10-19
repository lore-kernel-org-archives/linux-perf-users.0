Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C855C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 10:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625C060F59
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 10:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbhJSK1a (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Oct 2021 06:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbhJSK1a (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Oct 2021 06:27:30 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEC9C06161C;
        Tue, 19 Oct 2021 03:25:17 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n11so13365991plf.4;
        Tue, 19 Oct 2021 03:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yKZqp1gnUqMV4B15d0MyfsvIb4yG28S5ygx4uhJ8sGk=;
        b=MYLSBM0LIEyIcnRbJwynNL15M3VQAkzUysYs2oZq6pYamJ2J367n7wDaOdlRK7pT/c
         pZ8KuNSDFZtpmZ+8cQQAjrmxIiwXgQ9n3SyMvV7gYjNRpNMirKmDS1F9w20PK6tnua8W
         O3Xv4Ei9LzJKKD1e2PLgqBjWVTcmMe0FzMiUoS4LgFmrJCyzopHJY22EzoR9KWQbg545
         hftDfEZYC1IlvSuLscW7urOTyDFltCst2atgPgSphRG0vSpsHTv6k+muiNKPguiZvcNM
         fOMENYopz30mfrvt69q9kJsnpH+jdJyTa5CXnRi0bNIJcHTIDdEld8DtsmMSPrek3LoO
         np7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yKZqp1gnUqMV4B15d0MyfsvIb4yG28S5ygx4uhJ8sGk=;
        b=KEWloDfNrkK/+QEwlxDFpoQO2KxXq3CCSp5H4Q41NYPinfG3VNlwbnzFIyg5iuVbge
         5LuPJgAruw41g+VK9T4OWTVd0h1usRMWFi/GLFrooKiQrzNj8LnjHyIPL5KXr7fr+ixU
         usF2TqFHzYnaEjTILFq8spSPj/MBZZHxibIB7jKwRF9p3jFM7ZOFCjfPw/JDyAfZ/7rR
         QvL7XrlDJEdLfHvvLsdN3ss4/CNB1d+O2EW6a+aDQAAVBK3xkO6dg2k34QDHj7jFlgsj
         KEQaBSI7ni2nzmYtX2A1GjgXf/YVKmip6B2kqmo9Sh4fUtB9gxRVtF+wy2+DT2txECHg
         EktA==
X-Gm-Message-State: AOAM532UZo1l1JBdWjFBe+ivGZOU4TlkzBvIKMXiq8CJtWMieL2ArcEY
        VpjSqUw/zdq7mbCZHk4Km1A=
X-Google-Smtp-Source: ABdhPJzgqEqZLSBoVNrfbhbRZMVwQmxSn4AaOtRugDglPTMF0Hj49R1HxEBAOrwdf2iPOwnbWXpQ9g==
X-Received: by 2002:a17:90b:1c8f:: with SMTP id oo15mr5470992pjb.169.1634639117134;
        Tue, 19 Oct 2021 03:25:17 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a15sm15815757pfl.182.2021.10.19.03.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 03:25:16 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To:     mingo@redhat.com
Cc:     peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye.guojin@zte.com.cn,
        zealci@zte.com.cn
Subject: [PATCH] perf daemon: remove duplicate include in builtin-daemon.c
Date:   Tue, 19 Oct 2021 10:24:23 +0000
Message-Id: <20211019102423.1016081-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Ye Guojin <ye.guojin@zte.com.cn>

'sys/file.h' included in 'builtin-daemon.c' is duplicated.
it's also included at line 10.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 tools/perf/builtin-daemon.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index c13201fb09c3..6cb3f6cc36d0 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -1121,8 +1121,6 @@ static int setup_config(struct daemon *daemon)
 #ifndef F_TLOCK
 #define F_TLOCK 2
 
-#include <sys/file.h>
-
 static int lockf(int fd, int cmd, off_t len)
 {
 	if (cmd != F_TLOCK || len != 0)
-- 
2.25.1

