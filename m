Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A026AC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 19:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CFD061139
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 19:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241938AbhI1Tyn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 15:54:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56361 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242589AbhI1Tym (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Sep 2021 15:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632858782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=b5Pr+HGo0VsJRt4BRSo/Ay3yDNn7rHBhRVyf1dECUj4=;
        b=dSMxXe8RTYoSO4jV7VHGm8EbEtQm7t20+p0S1rDbgvirRcnWHamWOQbrNR2c76Dol4QaGX
        ODXeQGG9C+ezZzP727C8TmDjDWXT4DCbX4EkxpscX2yWgRJxymwFHVTtXN0VScq6sseKsb
        Qyu3EE0M7L87lo/cSHFckhBa3Q8ebwg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-jcVJbAa8OECAgkqLVqMIwQ-1; Tue, 28 Sep 2021 15:52:56 -0400
X-MC-Unique: jcVJbAa8OECAgkqLVqMIwQ-1
Received: by mail-ed1-f69.google.com with SMTP id r11-20020aa7cfcb000000b003d4fbd652b9so22989930edy.14
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Sep 2021 12:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b5Pr+HGo0VsJRt4BRSo/Ay3yDNn7rHBhRVyf1dECUj4=;
        b=gdfJDbjBQVYGnmtRcoRoa7kMNUiZBIyNkIkIWjbxJc0RpxNNoThCZzCcS/jJyDWbgG
         ptOanjbi1L+st4hZyeoSelTzvEmytI1mKdN4f7GgH2vqpkShC4UrY8ud104Y/8LqhD80
         dUN6dzYco+JU31t5bVd/Sp5y0tKUQVAByrv3g+b4pUj1Egya4xnN673SHS0oTldjf9Qd
         wk3nAFJ6vo95U2sbdNASp56jsLSgEsjtbQDYU8mTgUo83rFOccGbhf5Gph6VxJyyPiUC
         3mtM+6gL36aFcy8M+L6KqriI/VkK8IFFTgedk06lZsEk7nDdj/QTwVKjUdwdDAzK2jW6
         9ngw==
X-Gm-Message-State: AOAM532jU2kcXI0cmDvGU40iLixXoKF1YIn5q7QcqvYN4wqrcyE3IZda
        EWb5ZP6dhJf9wKyizLTdduGUZBEF2lkVh28+Q7Q+SQI56gXSWU+ztSGcwuwj3XXyijByDTAgUot
        cJZUKBIkhpIZkZADf/V5/HZH4OA7RJQ==
X-Received: by 2002:a50:e004:: with SMTP id e4mr9787456edl.246.1632858774919;
        Tue, 28 Sep 2021 12:52:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHmN/IaKKY1y6HHuNeHi6O+hxb9oUUc4ARbmAi39L5zYMJRrfpZIoddpfzhH47CeZ1iL0zLg==
X-Received: by 2002:a50:e004:: with SMTP id e4mr9787434edl.246.1632858774710;
        Tue, 28 Sep 2021 12:52:54 -0700 (PDT)
Received: from krava.cust.in.nbox.cz ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id i4sm31036edt.29.2021.09.28.12.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 12:52:54 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Wielaard <mjw@redhat.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf tools: Fix compilation on powerpc
Date:   Tue, 28 Sep 2021 21:52:53 +0200
Message-Id: <20210928195253.1267023-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Got following build fail on powerpc:

    CC      arch/powerpc/util/skip-callchain-idx.o
  In function ‘check_return_reg’,
      inlined from ‘check_return_addr’ at arch/powerpc/util/skip-callchain-idx.c:213:7,
      inlined from ‘arch_skip_callchain_idx’ at arch/powerpc/util/skip-callchain-idx.c:265:7:
  arch/powerpc/util/skip-callchain-idx.c:54:18: error: ‘dwarf_frame_register’ accessing 96 bytes \
  in a region of size 64 [-Werror=stringop-overflow=]
     54 |         result = dwarf_frame_register(frame, ra_regno, ops_mem, &ops, &nops);
        |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  arch/powerpc/util/skip-callchain-idx.c: In function ‘arch_skip_callchain_idx’:
  arch/powerpc/util/skip-callchain-idx.c:54:18: note: referencing argument 3 of type ‘Dwarf_Op *’
  In file included from /usr/include/elfutils/libdwfl.h:32,
                   from arch/powerpc/util/skip-callchain-idx.c:10:
  /usr/include/elfutils/libdw.h:1069:12: note: in a call to function ‘dwarf_frame_register’
   1069 | extern int dwarf_frame_register (Dwarf_Frame *frame, int regno,
        |            ^~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

The dwarf_frame_register args changed with [1],
Updating ops_mem accordingly.

[1] https://sourceware.org/git/?p=elfutils.git;a=commit;h=5621fe5443da23112170235dd5cac161e5c75e65

Cc: Mark Wielaard <mjw@redhat.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Jiri Olsa <jolsa@redhat.com>
---
 tools/perf/arch/powerpc/util/skip-callchain-idx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index 3018a054526a..20cd6244863b 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -45,7 +45,7 @@ static const Dwfl_Callbacks offline_callbacks = {
  */
 static int check_return_reg(int ra_regno, Dwarf_Frame *frame)
 {
-	Dwarf_Op ops_mem[2];
+	Dwarf_Op ops_mem[3];
 	Dwarf_Op dummy;
 	Dwarf_Op *ops = &dummy;
 	size_t nops;
-- 
2.31.1

