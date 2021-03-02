Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA72C433DB
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Mar 2021 05:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D68B64EC0
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Mar 2021 05:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbhCCFFV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Mar 2021 00:05:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23037 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1578680AbhCBP03 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 Mar 2021 10:26:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614698702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=l1EErq2Ure6g3ZP+f0TqMild9A+xwG0o9pFCNJA33oM=;
        b=hohJ72qJ6SCH2lgBDShh8FDvh0FQatZkgD35Xyin7UeUVzTJ+nq7bu0BjN0H+7lh9Xl4N8
        1PANOqCVzqyNWOVdSVjIfNbYkXvi9czqgJ1TwrRu6agboOY/U6TPr2ftJkF6z2GxrkuEkH
        vuQFeIUEoB4voqo5cj6Q20NTHyryXJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-tKaoDq7ZP0qfYu1fY9zQ2A-1; Tue, 02 Mar 2021 09:41:24 -0500
X-MC-Unique: tKaoDq7ZP0qfYu1fY9zQ2A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BF0080197A
        for <linux-perf-users@vger.kernel.org>; Tue,  2 Mar 2021 14:41:23 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.40.208.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4162C19C48;
        Tue,  2 Mar 2021 14:41:22 +0000 (UTC)
From:   Michael Petlan <mpetlan@redhat.com>
To:     acme@redhat.com, linux-perf-users@vger.kernel.org
Cc:     jolsa@redhat.com
Subject: [PATCH] perf trace: Fix race in signal handling
Date:   Tue,  2 Mar 2021 15:41:20 +0100
Message-Id: <20210302144120.17362-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since a lot of stuff happens before the SIGINT signal handler is registered
(scanning /proc/*, etc.), on bigger systems, such as Cavium Sabre CN99xx,
it may happen that first interrupt signal is lost and perf isn't correctly
terminated.

The reproduction code might look like the following:

    perf trace -a &
    PERF_PID=$!
    sleep 4
    kill -INT $PERF_PID

The issue has been found on a CN99xx machine with RHEL-8 and the patch fixes
it by registering the signal handlers earlier in the init stage.

Suggested-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Tested-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/builtin-trace.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 85b6a46e85b6..7ec18ff57fc4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3964,9 +3964,6 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 	evlist__config(evlist, &trace->opts, &callchain_param);
 
-	signal(SIGCHLD, sig_handler);
-	signal(SIGINT, sig_handler);
-
 	if (forks) {
 		err = evlist__prepare_workload(evlist, &trace->opts.target, argv, false, NULL);
 		if (err < 0) {
@@ -4827,6 +4824,8 @@ int cmd_trace(int argc, const char **argv)
 
 	signal(SIGSEGV, sighandler_dump_stack);
 	signal(SIGFPE, sighandler_dump_stack);
+	signal(SIGCHLD, sig_handler);
+	signal(SIGINT, sig_handler);
 
 	trace.evlist = evlist__new();
 	trace.sctbl = syscalltbl__new();
-- 
2.18.4

