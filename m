Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D771C2B9F8
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 May 2021 16:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D699B61408
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 May 2021 16:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhEYQLq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 25 May 2021 12:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhEYQLp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 May 2021 12:11:45 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF88C061574;
        Tue, 25 May 2021 09:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=nbSDM8JefRc8OvYh1pCNpmTBA1KFb7T/8MPpBSggPqk=; b=VjaNLPg4qVr5DU+63xuwtcXxrl
        1f6KeVcRAWlodcm0hye8l5fanLdk8z7eCZYz7t/6lD9Z/F9TsMyMA9hRFuVz0LCQGfRexn7ea/DG/
        sbFSQSmpDUPfq+R+PkTDCWmJGClwsDfdebkhY8cdLsmVLM5CZ7SqtrNWJnqeFa10FgSY=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1llZd3-0001Mu-11; Tue, 25 May 2021 18:10:01 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf jevents: fix getting maximum number of fds
Date:   Tue, 25 May 2021 18:07:58 +0200
Message-Id: <20210525160758.97829-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On some hosts, rlim.rlim_max can be returned as RLIM_INFINITY.
By casting it to int, it is interpreted as -1, which will cause get_maxfds
to return 0, causing "Invalid argument" errors in nftw() calls.
Fix this by casting the second argument of min() to rlim_t instead.

Fixes: 80eeb67fe577 ("perf jevents: Program to convert JSON file")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 tools/perf/pmu-events/jevents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index ed4f0bd72e5a..412565027fbb 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -960,7 +960,7 @@ static int get_maxfds(void)
 	struct rlimit rlim;
 
 	if (getrlimit(RLIMIT_NOFILE, &rlim) == 0)
-		return min((int)rlim.rlim_max / 2, 512);
+		return min(rlim.rlim_max / 2, (rlim_t)512);
 
 	return 512;
 }
-- 
2.30.1

