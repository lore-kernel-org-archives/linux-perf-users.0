Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31753C001B0
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 Jul 2023 20:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjGSUbi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 Jul 2023 16:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjGSUbg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Jul 2023 16:31:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D366269E;
        Wed, 19 Jul 2023 13:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24E2F6182E;
        Wed, 19 Jul 2023 20:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B1EC433C8;
        Wed, 19 Jul 2023 20:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689798599;
        bh=uZcDOpOUdyDuQ6U9ajuc/8Rc/FrXXXJ9LEX+YPZLWe8=;
        h=From:To:Cc:Subject:Date:From;
        b=T8PTeatTMnXI1ik7q5KxDNO7PK2m6GQnk+dA2RSt4zOyqj2dKTirSlNJbCPQqJDfi
         vdIs3pUHChOukxR8bOrDLEwjBgfCcvbGD8ziLJeaWm7PJ8t/1zW1n6/qk7qgKDu/tg
         OswoP47l2ElA92Wp+H2C3ni1sbUu2K6mdcWHieCYuZ493GL7WhyTzkQFWt9D/28WPz
         ba6wjE99jQ6AXMg7DIeH9h5cParinKHfoWJKkr6Cn+SX6GX956vrkx/L90cPJHG1K0
         wFtflZT1ULYizXOLQz8WWO5cXYt9DO/wZF70Nh94U3O1YpJaRpD+dMWVD0mv9GYoWL
         s0Dseud/r85ig==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCHES 0/6] Fix some 'perf trace' leaks found with -fsanitize=address.
Date:   Wed, 19 Jul 2023 17:29:45 -0300
Message-ID: <20230719202951.534582-1-acme@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

	Please review/ack, I put it as well on the tmp.perf-tools-next
in the perf-tools-next tree:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=tmp.perf-tools-next

Best regards,

- Arnaldo

Arnaldo Carvalho de Melo (6):
  perf evsel: Free evsel->filter on the destructor
  perf thread: Allow tools to register a thread->priv destructor
  perf trace: Register a thread priv destructor
  perf trace: Really free the evsel->priv area
  perf trace: Free thread_trace->files table
  MAINTAINERS: Add git information for perf-tools and perf-tools-next
    trees/branches

 MAINTAINERS                |  2 ++
 tools/perf/builtin-trace.c | 38 +++++++++++++++++++++++++++++++-------
 tools/perf/util/evsel.c    |  1 +
 tools/perf/util/thread.c   | 11 +++++++++++
 tools/perf/util/thread.h   |  2 ++
 5 files changed, 47 insertions(+), 7 deletions(-)

-- 
2.41.0

