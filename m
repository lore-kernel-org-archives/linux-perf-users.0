Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BE3C433DB
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Feb 2021 12:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B4B64E36
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Feb 2021 12:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhBOMqJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 Feb 2021 07:46:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:41324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230282AbhBOMqH (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Feb 2021 07:46:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 963C2ACBF;
        Mon, 15 Feb 2021 12:45:25 +0000 (UTC)
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: [PATCH] perf annotate: do not jump after 'k' is pressed
To:     linux-kernel@vger.kernel.org
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Message-ID: <65416cff-4eb6-713c-a174-2aa43fa64332@suse.cz>
Date:   Mon, 15 Feb 2021 13:45:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Do not jump when 'k' is pressed, the cursor show stay where it is.
Right now, it jumps to the currently selected hot instruction.

Signed-off-by: Martin Liška <mliska@suse.cz>
---
  tools/perf/ui/browsers/annotate.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index bd77825fd5a1..35b82caf8090 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -759,7 +759,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
  			continue;
  		case 'k':
  			notes->options->show_linenr = !notes->options->show_linenr;
-			break;
+			continue;
  		case 'H':
  			nd = browser->curr_hot;
  			break;
-- 
2.30.0

