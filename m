Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4592C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  4 Apr 2022 22:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242487AbiDDXAO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 4 Apr 2022 19:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237083AbiDDW77 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Apr 2022 18:59:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 074E768F84
        for <linux-perf-users@vger.kernel.org>; Mon,  4 Apr 2022 15:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649110549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=2YI53/qmJAIoDkHGAPD43GpeyzZCGTkf7qFMdGpuYs4=;
        b=LwWafseoyqFCf1R1yQ402tgXGrrle06bjfL/oLnGarBsSI5YMjiEgVb04HpcbEGgntYubI
        tXoAIjSfOZYG+yqn1hRlvcef9AYVXpAe/17DMXe1h/PPVQqz4ykuiPf5JtJ3FIdit8uO06
        coVyEw/bSlODgnFV8Z664nfFJuk/DDo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-8zdN4KIGP7WTtw7zgJrKgA-1; Mon, 04 Apr 2022 18:15:45 -0400
X-MC-Unique: 8zdN4KIGP7WTtw7zgJrKgA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8870280A0AD;
        Mon,  4 Apr 2022 22:15:45 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CD724066CAA;
        Mon,  4 Apr 2022 22:15:44 +0000 (UTC)
From:   Michael Petlan <mpetlan@redhat.com>
To:     linux-perf-users@vger.kernel.org, acme@redhat.com
Cc:     jolsa@kernel.org
Subject: [PATCH 2/2] perf: Add external commands to list-cmds
Date:   Tue,  5 Apr 2022 00:15:41 +0200
Message-Id: <20220404221541.30312-2-mpetlan@redhat.com>
In-Reply-To: <20220404221541.30312-1-mpetlan@redhat.com>
References: <20220404221541.30312-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The `perf --list-cmds` output prints only internal commands, although
there is no reason for that from users' perspective.

Adding the external commands to commands array with NULL function
pointer allows printing all perf commands while not changing the logic
of command handler selection.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/perf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 2f6b67189b42..91eb36ec6f1c 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -55,6 +55,7 @@ struct cmd_struct {
 };
 
 static struct cmd_struct commands[] = {
+	{ "archive",	NULL,	0 },
 	{ "buildid-cache", cmd_buildid_cache, 0 },
 	{ "buildid-list", cmd_buildid_list, 0 },
 	{ "config",	cmd_config,	0 },
@@ -62,6 +63,7 @@ static struct cmd_struct commands[] = {
 	{ "diff",	cmd_diff,	0 },
 	{ "evlist",	cmd_evlist,	0 },
 	{ "help",	cmd_help,	0 },
+	{ "iostat",	NULL,	0 },
 	{ "kallsyms",	cmd_kallsyms,	0 },
 	{ "list",	cmd_list,	0 },
 	{ "record",	cmd_record,	0 },
@@ -360,6 +362,8 @@ static void handle_internal_command(int argc, const char **argv)
 
 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
 		struct cmd_struct *p = commands+i;
+		if (p->fn == NULL)
+			continue;
 		if (strcmp(p->cmd, cmd))
 			continue;
 		exit(run_builtin(p, argc, argv));
-- 
2.18.4

