Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2F6C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Jul 2022 21:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbiGFVG2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Jul 2022 17:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiGFVG2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Jul 2022 17:06:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE71167C1
        for <linux-perf-users@vger.kernel.org>; Wed,  6 Jul 2022 14:06:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c7-20020a258807000000b0066d6839741eso12603889ybl.23
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Jul 2022 14:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=e2ErBVv8qaenTIHwGm6BDHlzGLkSDkG7zT48JUlyYnI=;
        b=pQcEOUnjGosM3FwjtyyePdQ4rz547gcUzlhhrQSACVrGQi+DCeSRewah3af7J025bn
         ZFSF9xT9Kd2OHSeRtz2p4X9p14gtjkluqRyylFvS0Ze6B4KPf4Lv+40tmck2kh9L1Qd2
         dlFPCFeoffGzkW1bpmX4aFKTATWyGe8ajPAVOJDBhtTJJCOC12HO25xgVfhK4U3v0HXH
         LdnIoOmr3Z4zCt4EJ5HqiMpmCDavYlyMwc6BUiAn/lzecxj0s+wGHU5UFMPA2d67qyaR
         +aWS6ReKKRUUcR9RAUXT7QzYh72+C0hJdOapn66oIEU84Y+QYNpuQZ6Ik98u8ljrJr4t
         w0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=e2ErBVv8qaenTIHwGm6BDHlzGLkSDkG7zT48JUlyYnI=;
        b=JXlZWWLqZD+cHucJZLLBEKbj+QmQnhlydRPRIwXgxHyYGwOfeLtw52x7vvNWJ8osW+
         Jy/A7w5D/65Pv0fVDJZVCAym+J6k7sI3um1qpJVhzF7HfvEVE8BGDRM2thC2cHztV4P6
         6DF7V/EcbjrpG/N1SyqjvmzZBo3j60yKKsDmz+UZA40rEMD1etQcjHTzMIzBiP44kx0L
         O71wHv52F0HaC9pnsbo+APnDXrWwhRB/4odBfOQqiCZeEKJ3cJ2ixn2Nf/YHOO736yrO
         AKQYaMIIJ+82V1FVgBUyjPjvdyQmVWjNi7ggr3eHOWGfesPqsppvCx7YPnKtpamo8yzP
         ouwg==
X-Gm-Message-State: AJIora+UxBkUEDaqdK3xWVwsGPFtJ3GbtQE5AgfqGqynQPqw2yPQdBqO
        W/kgTsco9h3xwlLjQ5bab0j0TLEt0Ig=
X-Google-Smtp-Source: AGRyM1vgjtm4BaYhDlSs+0r8gz/TW/c6FhBbWoQPUXmQyhX6ufpPiRdiz8rmvNaWqnqTpwxnDkigT2o/aQA=
X-Received: from mpratt.nyc.corp.google.com ([2620:0:1003:1213:37b2:830a:e7cc:7548])
 (user=mpratt job=sendgmr) by 2002:a25:f905:0:b0:66e:4ebe:d61d with SMTP id
 q5-20020a25f905000000b0066e4ebed61dmr17976220ybe.647.1657141586876; Wed, 06
 Jul 2022 14:06:26 -0700 (PDT)
Date:   Wed,  6 Jul 2022 17:06:13 -0400
Message-Id: <20220706210613.1987767-1-mpratt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH] perf: uapi: fix PERF_RECORD_SAMPLE format documentation
From:   Michael Pratt <mpratt@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Pratt <mpratt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The documented format of PERF_RECORD_SAMPLE does not match the actual
format emitted by perf_output_sample:

* The cgroup field is missing entirely.
* The data_page_size and code_page_size fields are output before the aux
  data, but are documented before.

Fixes: 6546b19f95ac ("perf/core: Add PERF_SAMPLE_CGROUP feature")
Fixes: 8d97e71811aa ("perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE")
Fixes: 995f088efebe ("perf/core: Add support for PERF_SAMPLE_CODE_PAGE_SIZE")
Signed-off-by: Michael Pratt <mpratt@google.com>
---
 include/uapi/linux/perf_event.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index d37629dbad72f..9a0a9a8678558 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -967,10 +967,11 @@ enum perf_event_type {
 	 *	{ u64			abi; # enum perf_sample_regs_abi
 	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
-	 *	{ u64			size;
-	 *	  char			data[size]; } && PERF_SAMPLE_AUX
+	 *	{ u64			cgroup;} && PERF_SAMPLE_CGROUP
 	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
 	 *	{ u64			code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
+	 *	{ u64			size;
+	 *	  char			data[size]; } && PERF_SAMPLE_AUX
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
-- 
2.37.0.rc0.161.g10f37bed90-goog

