Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB38C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 04:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D96860041
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 04:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhHIEdb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 00:33:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58964 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhHIEda (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 00:33:30 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1DEBD21D69;
        Mon,  9 Aug 2021 04:33:10 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FB9C13398;
        Mon,  9 Aug 2021 04:33:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SuyTFQSwEGEfDQAAMHmgww
        (envelope-from <dave@stgolabs.net>); Mon, 09 Aug 2021 04:33:08 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     acme@kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH -tip v2 0/7] perf/bench-futex: Misc updates
Date:   Sun,  8 Aug 2021 21:32:54 -0700
Message-Id: <20210809043301.66002-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Changes from v1: https://lore.kernel.org/lkml/20210806013329.94627-1-dave@stgolabs.net/
- Addressed acme's comments in patch 1.
- Addeded more patches.
- Added more people to the Cc.

A few updates for the futex perf benchmarks.

Please consider for v5.15.

Thanks!

Davidlohr Bueso (7):
  perf/bench-futex: Group test parameters cleanup
  perf/bench-futex: Remove bogus backslash from comment
  perf/bench-futex: Factor out futex_flag
  perf/bench-futex: Add --mlockall parameter
  perf/bench-futex, requeue: Add --broadcast option
  perf/bench-futex, requeue: Robustify futex_wait() handling
  perf/bench-futex, requeue: Add --pi parameter

 tools/perf/bench/futex-hash.c          |  63 +++++-----
 tools/perf/bench/futex-lock-pi.c       |  61 +++++-----
 tools/perf/bench/futex-requeue.c       | 160 ++++++++++++++++++-------
 tools/perf/bench/futex-wake-parallel.c |  67 ++++++-----
 tools/perf/bench/futex-wake.c          |  66 +++++-----
 tools/perf/bench/futex.h               |  55 ++++++++-
 6 files changed, 318 insertions(+), 154 deletions(-)

--
2.26.2

