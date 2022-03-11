Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A3EC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Mar 2022 13:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbiCKNJn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Mar 2022 08:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiCKNJm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Mar 2022 08:09:42 -0500
X-Greylist: delayed 88 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 05:08:38 PST
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDF4136856
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Mar 2022 05:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1647004115;
        bh=+6S3oZhJXthUPbzYWd80fospAGyDMx5urCnGtN8Fuj4=;
        h=From:To:Cc:Subject:Date;
        b=VeUpcS9ONBDZuNJZgPMlxPo+797aszUsjtYXiWhS7pH8WVf6kXnENohq6IBVtlMYH
         +Lrov7m0GrTCiGpH62yeXMuPISf4SNWr4ji9nmW9zEPCs+weMcbUIKYTu40D5KlAjS
         fgT/A6G8icJpOKj41LIar8dT/CnVEEzB1YOmPvbc=
Received: from localhost.localdomain ([111.193.130.237])
        by newxmesmtplogicsvrsza7.qq.com (NewEsmtp) with SMTP
        id 1D0A74D3; Fri, 11 Mar 2022 21:07:16 +0800
X-QQ-mid: xmsmtpt1647004036tazonpkur
Message-ID: <tencent_B5D64530EB9C7DBB8D2C88A0C790F1489D0A@qq.com>
X-QQ-XMAILINFO: NwFwz4tS/C+e9pALN+3gOw5wbLA8/rE6Q24PsFnaXIRlbH5x2WkoOxlvUATV65
         gvv9TH6OGrtSRkWS1pEHG/gES0KULNpUeY/5lnUFbdBdJI9/c9P1bASbItuHS+B4DXkt/ot/pRE3
         OAq1B0EKIsWfuUzX93eAOJor4nR44H6anUgGprjL1/JBvVe5grmInu7JZhjBWanoDIFKr6mBgTm1
         327zIDpACdqS+WSK9JHT2JqUSyMAulKlAVHclyDGycqyNDBK/rjLTLyJX41mHeh/BmP4veascKYL
         cgq2So/6t5WCO71slkwT2820EoHPf5sET/kc7Kn2kLYYJ/O+vY5F108bLEzLOPHsLgH8dywgXw7a
         vyC8Sdu/UvK4D7kMwt9SmLOgvw9z9u49mUhAxZwYx4FTKmg1XvcG04RA8tjiKSm58XQpSGe7BZFU
         OM7LkaVUoXRwVqq0yMWoTzdwxsvobxxeAEgT/IaT/NZgxmXEF2ay5+umMybeJz9aSV1TO1E0lsly
         RSMc3rf5nUfGQKRRcg7UYZw3KMLslV8pxufSiaCm8Niqzv8sJ64RoCtkf1UkPcppoL0RSNi7KLlb
         WYXZSwfaJwm+6Cacp+jkXyweuKSCk9GaJSvDlm+WhpZRsut0PC+ZiyNV3Icl9IWNdaIiV1Kf+S4Z
         aOX3Cpy4AELxeRQPNE1uHBXKklnhCUOrytyQ8oVJWzuWetF+SJyn0k/cOgFQsDGK3kO9DWZGVDop
         0MhdwxsyTB0bfF6aCcn4bFiSvWgteZlo+pnBTno/Ooq1qd8/Wgg2YBKHHziM/LWBQxQtjFYeQaBN
         HKPKrV/oMU+uA/WeSsI95zjOgXP6tLXUsVNSaN2gwHOPpaUyNsyX6twS6gU1fybptcKlDiNHQn7J
         liZklEUq89FmWZUPuvP+/LLXRylOePxeMy/RAbxsOp
From:   Weiguo Li <liwg06@foxmail.com>
To:     dave@stgolabs.net, dbueso@suse.de, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf bench: Fix null check
Date:   Fri, 11 Mar 2022 21:07:16 +0800
X-OQ-MSGID: <20220311130716.257405-1-liwg06@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

We did a null check after "epollfdp = calloc(...)", but we checked
"epollfd" instead of "epollfdp".

Signed-off-by: Weiguo Li <liwg06@foxmail.com>
---
 tools/perf/bench/epoll-ctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
index 740ae764537e..134612bde0cb 100644
--- a/tools/perf/bench/epoll-ctl.c
+++ b/tools/perf/bench/epoll-ctl.c
@@ -106,7 +106,7 @@ static void nest_epollfd(void)
 	printinfo("Nesting level(s): %d\n", nested);
 
 	epollfdp = calloc(nested, sizeof(int));
-	if (!epollfd)
+	if (!epollfdp)
 		err(EXIT_FAILURE, "calloc");
 
 	for (i = 0; i < nested; i++) {
-- 
2.25.1


