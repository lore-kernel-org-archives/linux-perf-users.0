Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2809C4332F
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 10:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC2AA610A2
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 10:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbhI1Kb0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 06:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240162AbhI1KbZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Sep 2021 06:31:25 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF76C061575;
        Tue, 28 Sep 2021 03:29:46 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id me1so14611995pjb.4;
        Tue, 28 Sep 2021 03:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T3qMAEtfcaghHlWUPWmUJLo1MLuhihC6FaJPqweE7dQ=;
        b=mgiO+E0ax2upDUbbtDrnYK0kGX2R1PgJ+HvHaWI74ZMV+8q8QZy/KeyufrYVCz1xAj
         vG/Fhojg/6v2p9SSZN8Rv5qPUBker4IX60gsGefYDYfEI8pUCLMHIuY9jnUb5oum+doa
         oKBNepFb8SBiPZqb+TM8d7+Dr6Fnx+Cauc+zOPhG9FpVUBjuYhzXdBZ+qniALsi7QnQa
         paJPIjo2A6XvUdRZE3rgSYw6XVxvMIv4iVWP9YqIAZie5dmfR0e+T3NtuZn/Qv2BYDPK
         cu8X1JgOiM/uA2AQZDOSljem942NeYUGQinjakMODRYQvtFEziQJKIEitKqVaqeimdld
         cq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T3qMAEtfcaghHlWUPWmUJLo1MLuhihC6FaJPqweE7dQ=;
        b=7AdO4eXWYBQQGVxVCq/CsqkEzMXtzfvpb8cQcg354LKwTao1SbiQU7Vm9moAE8eGR1
         Kj6TneeAyzMu2E0NZeUQj9tRiE+oUNsPazyyAIrYg5CleARq92tvfkN2QC78h6j/g/ek
         1bbNe2R75ZBpGtR+WfIudzcfqdyQSgysL02kB0dKV5aJijAC5bfiithY+ao/bBPRVpRR
         n05SzTFteHTuAAszRn59DD4sQc77xH7Ge77RPA3cnm9I/mmK9b3IKP9lZWxyD/cjICzJ
         GHzIBcZ1Q+P7BhYtzEb9Lze4BC636X2eaD0X5t3UcATK0+2ViR14Rv7nXEJnZqYoQp9j
         i6Nw==
X-Gm-Message-State: AOAM5324iOA3QMzFB7yxK1ccpyWw+ycvPR+2kfkB9Xyxs1aEFNsS6PRw
        X8dvAszz2MewQQGsT6Ozv+E=
X-Google-Smtp-Source: ABdhPJxcvYiawospPcYUcQj7lGHUEehWcFBnvuFIv4SwS140ilyQvMJmhXGnp9CnLi1gdXWrQJrUyw==
X-Received: by 2002:a17:90a:ca96:: with SMTP id y22mr4740692pjt.115.1632824985647;
        Tue, 28 Sep 2021 03:29:45 -0700 (PDT)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id w1sm10306763pfj.147.2021.09.28.03.29.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Sep 2021 03:29:45 -0700 (PDT)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf jevents: Fix sys_event_tables to be freed like arch_std_events
Date:   Tue, 28 Sep 2021 18:29:38 +0800
Message-Id: <20210928102938.69681-1-likexu@tencent.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Like Xu <likexu@tencent.com>

The compiler reports that free_sys_event_tables() is dead code. But
according to the semantics, the "LIST_HEAD(arch_std_events)" should
also be released, just like we do with 'arch_std_events' in the main().

Fixes: e9d32c1bf0cd7a98 ("perf vendor events: Add support for arch standard events")
Signed-off-by: Like Xu <likexu@tencent.com>
---
 tools/perf/pmu-events/jevents.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 6731b3cf0c2f..7c887d37b893 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -1285,6 +1285,7 @@ int main(int argc, char *argv[])
 	}
 
 	free_arch_std_events();
+	free_sys_event_tables();
 	free(mapfile);
 	return 0;
 
@@ -1306,6 +1307,7 @@ int main(int argc, char *argv[])
 		create_empty_mapping(output_file);
 err_out:
 	free_arch_std_events();
+	free_sys_event_tables();
 	free(mapfile);
 	return ret;
 }
-- 
2.32.0

