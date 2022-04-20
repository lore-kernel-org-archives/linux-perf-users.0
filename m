Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8E8C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Apr 2022 17:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381256AbiDTRqH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Apr 2022 13:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378786AbiDTRqH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Apr 2022 13:46:07 -0400
Received: from euporie.uberspace.de (euporie.uberspace.de [185.26.156.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8F247076
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Apr 2022 10:43:18 -0700 (PDT)
Received: (qmail 24508 invoked by uid 989); 20 Apr 2022 17:43:16 -0000
Authentication-Results: euporie.uberspace.de;
        auth=pass (plain)
From:   Florian Fischer <florian.fischer@muhq.space>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v5] perf list: print all available tool events
Date:   Wed, 20 Apr 2022 19:42:43 +0200
Message-Id: <20220420174244.1741958-1-florian.fischer@muhq.space>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <YmA4byoEa3QBNeST@kernel.org>
References: <YmA4byoEa3QBNeST@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: +
X-Rspamd-Report: BAYES_SPAM(0.000069) R_MISSING_CHARSET(0.5) MIME_GOOD(-0.1) MID_CONTAINS_FROM(1)
X-Rspamd-Score: 1.400069
Received: from unknown (HELO unkown) (::1)
        by euporie.uberspace.de (Haraka/2.8.28) with ESMTPSA; Wed, 20 Apr 2022 19:43:16 +0200
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

>> Introduce names for the new tool events 'user_time' and 'system_time'.
> 
> Before:
> 
> duration_time                                      [Tool event]
> 
> After:
> 
> $ perf list | grep Tool
> duration_time OR                                   [Tool event]
> user_time OR                                       [Tool event]
> system_time OR                                     [Tool event]
> $
> 
> So now we have that extraneous "OR", can you please take a look?
> Probably needs to check if there is an alias?
> 
> - Arnaldo

Sorry about that. Exactly as you guessed the code was missing a check if the tool
event actually has an alias.

Fixed Output:

$ perf list | grep Tool
  duration_time                                   [Tool event]
  user_time                                       [Tool event]
  system_time                                     [Tool event]

[v5]: Add missing alias check.

Florian Fischer

