Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF912C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 01:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA20F611C3
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 01:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbhHFBdu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 5 Aug 2021 21:33:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48016 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbhHFBdu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 Aug 2021 21:33:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0C63D1FD53;
        Fri,  6 Aug 2021 01:33:34 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D88C413DD1;
        Fri,  6 Aug 2021 01:33:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n+EmJ2yRDGFiBgAAMHmgww
        (envelope-from <dave@stgolabs.net>); Fri, 06 Aug 2021 01:33:32 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH -tip 0/3] perf/bench-futex: Misc updates
Date:   Thu,  5 Aug 2021 18:33:26 -0700
Message-Id: <20210806013329.94627-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

A couple of updates for the futex perf benchmarks.

Please consider for v5.15.

Thanks!

Davidlohr Bueso (3):
  perf/bench-futex: Group test parameters cleanup
  perf/bench-futex: Add --mlockall parameter
  perf/bench-futex, requeue: Add --pi parameter

 tools/perf/bench/futex-hash.c          |  77 ++++++++-----
 tools/perf/bench/futex-lock-pi.c       |  75 ++++++++-----
 tools/perf/bench/futex-requeue.c       | 148 ++++++++++++++++++-------
 tools/perf/bench/futex-wake-parallel.c |  78 ++++++++-----
 tools/perf/bench/futex-wake.c          |  77 ++++++++-----
 tools/perf/bench/futex.h               |  40 ++++++-
 6 files changed, 346 insertions(+), 149 deletions(-)

-- 
2.26.2

