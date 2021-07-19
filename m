Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB214C07E95
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jul 2021 14:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D935610F7
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jul 2021 14:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhGSONC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Jul 2021 10:13:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27279 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232059AbhGSONA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Jul 2021 10:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626706420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=vn3ipMwDK1MDy8wVT3Gd+hfZl1XsGuxvMDl2lJNjysg=;
        b=JuEsvlizYBeZnOMjqiWtmze6JyrH7YWUoNlgFyk4AUcFs+iFwRet5zDMklPnkwq4pfHSUe
        onx3U+XT4XCoENhgLtnEkOOM46XAwxZJ3PTxsCmdjs14Nvagt6f+t6m1pRcQOFnc8u76r+
        poQYCDWhtdf+heQsl3xAQIkxwZANgvQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-U7a6Q5tIPUqWUJt0kDTAMA-1; Mon, 19 Jul 2021 10:53:38 -0400
X-MC-Unique: U7a6Q5tIPUqWUJt0kDTAMA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C19B91922960;
        Mon, 19 Jul 2021 14:53:37 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.36.110.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6301618F0A;
        Mon, 19 Jul 2021 14:53:35 +0000 (UTC)
From:   Michael Petlan <mpetlan@redhat.com>
To:     acme@redhat.com, linux-perf-users@vger.kernel.org
Cc:     jolsa@redhat.com, jlelli@redhat.com, milian.wolff@kdab.com
Subject: [PATCH] perf machine: Initialize srcline string member in add_location struct
Date:   Mon, 19 Jul 2021 16:53:32 +0200
Message-Id: <20210719145332.29747-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

It's later supposed to be either a correct address or NULL. Without the
initialization, it may contain an undefined value which results in the
following segmentation fault:

  # perf top --sort comm -g --ignore-callees=do_idle

terminates with

  perf: Segmentation fault
  -------- backtrace --------
  perf(+0x417b26)[0x557794f1fb26]
  /lib64/libc.so.6(+0x37400)[0x7f62a0194400]
  /lib64/libc.so.6(+0x15d685)[0x7f62a02ba685]
  /lib64/libc.so.6(__strdup+0x12)[0x7f62a01e6802]
  perf(+0x3769d9)[0x557794e7e9d9]
  perf(+0x376d3a)[0x557794e7ed3a]
  perf(+0x377284)[0x557794e7f284]
  perf(+0x3773e0)[0x557794e7f3e0]
  perf(hist_entry_iter__add+0xc4)[0x557794e80114]
  perf(+0x2799aa)[0x557794d819aa]
  perf(+0x354ec8)[0x557794e5cec8]
  perf(+0x279341)[0x557794d81341]
  /lib64/libpthread.so.0(+0x814a)[0x7f62a27b514a]
  /lib64/libc.so.6(clone+0x43)[0x7f62a0259dc3]

Fixes: 1fb7d06a509e ("perf report: Use srcline from callchain for hist entries")

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Reported-by: Juri Lelli <jlelli@redhat.com>
CC: Milian Wolff <milian.wolff@kdab.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index da19be7da284..44e40bad0e33 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2149,6 +2149,7 @@ static int add_callchain_ip(struct thread *thread,
 
 	al.filtered = 0;
 	al.sym = NULL;
+	al.srcline = NULL;
 	if (!cpumode) {
 		thread__find_cpumode_addr_location(thread, ip, &al);
 	} else {
-- 
2.18.4

