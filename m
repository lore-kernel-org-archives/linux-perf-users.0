Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F327EC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 08:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0D19610FF
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 08:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241394AbhKIIDp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 03:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbhKIIDo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 03:03:44 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8063BC061764;
        Tue,  9 Nov 2021 00:00:59 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id q126so13801029pgq.13;
        Tue, 09 Nov 2021 00:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YY/xWrWdHWoOd2ErQ+giH+QO0ELkWsrHSIUV0eDZ8CM=;
        b=AnDLhyPbGhfJZo97QffKCrFoJXMnBb48Uqb7ULr9S0sLambfLXegt7hN1L91W4g7U9
         ze1dUnFvGySkjt6oOW94ppqSziYah6d4JWJtChBF1DLb4O2hhYVl6mOfKhM+iRkOeVw2
         kbYbNDMRl395HTA8bCQAVzWLdYQ2frMHpNMdsFJN1J0N9z/GzdsGsE4w6E38+G3CLARQ
         vPrIO300rhOCEZCMKJLgzBX281cUfzhRJcsw+XaBNkhQx9bW9Mw/LlXau66jEyhZeAmM
         x2IwnCCYiZiplA7wH/Mrd1r4+QL5pf2H4p9lkJv/RETK5qa36Ijp1XN30NiWaGs3OHsi
         ozOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YY/xWrWdHWoOd2ErQ+giH+QO0ELkWsrHSIUV0eDZ8CM=;
        b=fT9Gpzt3JDnSDRmBvoxYIZ2CCldfbV9LqgB+GLvWsXIJtsyksdht0qrUr7anJdNdbP
         QiOlVGmlAIn7HbtPegzD0cPPvoDh8vB2sEdX+ANKcAPyIeK0KKjZsK6O2TxsICbliIVV
         iwrfNaNJkLebY5W2YfB3FQtwvE6wI0xWWYsRK9fcgwMT3A8gabD+Y4+Y0ZorwaGNmDkg
         G4tstvjXqTvB4EVqzZqb0Llo+aFJYtNKfJ4uuY+yZDTpwaYr1p4xoQ+fCC/ZdyUq/3et
         T+wRjf0AEN5xgpk4ApQVIkx7R8xIF+m/VRwVGuFsVO06nRFAHd7AZsP5CN0ctlv+jtur
         qBeA==
X-Gm-Message-State: AOAM531KzgmCqmCO7vHK8S0zTuE5oUoevcd2ec8OuOi5pmE7SWUtt/Wn
        Rfac5LWET4fGPiNUUykZiLoJ0Q23B6aN8UsYz+o=
X-Google-Smtp-Source: ABdhPJw6rYUByMFJIZHERRo20+KIgnOpFO/AHyJxIfH7+z0hd8yHVzDGlFk8PQPG/CT+ff939LlbrA==
X-Received: by 2002:a62:8683:0:b0:480:edf9:33c0 with SMTP id x125-20020a628683000000b00480edf933c0mr6128136pfd.11.1636444858881;
        Tue, 09 Nov 2021 00:00:58 -0800 (PST)
Received: from localhost.localdomain ([221.221.55.14])
        by smtp.gmail.com with ESMTPSA id c1sm19710396pfv.54.2021.11.09.00.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 00:00:58 -0800 (PST)
From:   Jian Wen <wenjianhn@gmail.com>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jian Wen <wenjianhn@gmail.com>
Subject: [PATCH] Fix usage of open()
Date:   Tue,  9 Nov 2021 16:00:54 +0800
Message-Id: <20211109080054.444997-1-wenjianhn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

O_NONBLOCK is a flag instead of a file mode bit.

Fixes: edcaa47958c7 ("perf daemon: Add 'ping' command")

Signed-off-by: Jian Wen <wenjianhn@gmail.com>
---
 tools/perf/builtin-daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 6cb3f6cc36d0..37d6fcdbb63d 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -531,7 +531,7 @@ static int daemon_session__control(struct daemon_session *session,
 		scnprintf(ack_path, sizeof(ack_path), "%s/%s",
 			  session->base, SESSION_ACK);
 
-		ack = open(ack_path, O_RDONLY, O_NONBLOCK);
+		ack = open(ack_path, O_RDONLY|O_NONBLOCK);
 		if (!ack) {
 			close(control);
 			return -1;
-- 
2.25.1

