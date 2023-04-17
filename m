Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7798EC77B7A
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 Apr 2023 18:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjDQS1U (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 Apr 2023 14:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjDQS1R (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 Apr 2023 14:27:17 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7F646AF;
        Mon, 17 Apr 2023 11:27:15 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Q0bB8339fz9sW5;
        Mon, 17 Apr 2023 20:27:12 +0200 (CEST)
Date:   Mon, 17 Apr 2023 20:27:07 +0200
From:   Hagen Paul Pfeifer <hagen@jauu.net>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Petar Gligoric <petar.gligoric@rohde-schwarz.com>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] perf script: task-analyzer: Fix spelling mistake
 "miliseconds" -> "millseconds"
Message-ID: <20230417182707.bgvx2os4bbihjamb@ic1101>
X-Key-Id: 98350C22
X-Key-Fingerprint: 490F 557B 6C48 6D7E 5706 2EA2 4A22 8D45 9835 0C22
X-GPG-Key: gpg --recv-keys --keyserver wwwkeys.eu.pgp.net 98350C22
X-Operating-System: Linux ic1101 6.2.0-hgn
References: <20230417174826.52963-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417174826.52963-1-colin.i.king@gmail.com>
X-Rspamd-Queue-Id: 4Q0bB8339fz9sW5
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

* Colin Ian King | 2023-04-17 18:48:26 [+0100]:

>There is a spelling mistake in the help for the --ms option. Fix it.
>
>Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Good catch - thank you Colin!

Acked-by: Hagen Paul Pfeifer <hagen@jauu.net>

