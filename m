Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B52C43334
	for <linux-perf-users@archiver.kernel.org>; Fri,  1 Jul 2022 18:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiGASVb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 1 Jul 2022 14:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiGASVa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 1 Jul 2022 14:21:30 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15731A3AC
        for <linux-perf-users@vger.kernel.org>; Fri,  1 Jul 2022 11:21:28 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id k14so3095914plh.4
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Jul 2022 11:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zWAndBPU/YBRNnP7iW5mGKvMtcz8VndtaaAnNCQfy9k=;
        b=ZW27MIhtPvBFpjZeiPNkxlAe7Kq6vAdIV6fc5YmBqLRNcJDb9ov6iJ7VpIB26ZnpDN
         FWIVfAOukpxsETvidZcCXoddzqRDHwpIlQcCcxYOzjDaBG0LbEnsWgn1be3Gv0kv4j7r
         Dz/HJzOfExPOediDoAKC1FPl/8UUd8zeEHYZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zWAndBPU/YBRNnP7iW5mGKvMtcz8VndtaaAnNCQfy9k=;
        b=VLAMbSrDgu/Gdozq+s3gEH6xOqU8nhzfR8qBV3la0++H3MVgi1YszD98YvnFzVo7fr
         LCIJEJcawmrJO3r/v8IyA9uYqFKa0Tia1rKM6drRzB1V7FG18mjiVgfT99kZtPAA9CQ+
         lKE8nA519z9Xd7dClpmrzmSoSfebIz3fqky6DuonZG6b3Jg9xJrxJwITTGQE/KCL9ss+
         Rg39kisAB/oAeS4UarOB2Ca+F2jdz0hCeBAtJTv0gRRofjDQI+1vLK+HI5SPbyzGriuE
         FVmor5RuG/1vn1bYQF1l2NKcjtV4fTq/rOPcx5vvgf1+ryL+HL3Ao8wID3kOzESYnpVO
         s75w==
X-Gm-Message-State: AJIora+2edNauwMt18VNPJfcuRjJotkowrYGQSlXnJUIkcGqTXLHmAoY
        UFomNy9q66DrmBFdYXqSD15axhwm/RpT9WQv
X-Google-Smtp-Source: AGRyM1tKXEyY57JI4ZOQHqx08RV9uduSeVWzNHQJ4yQI/LrFKPD3zxLoXur7ZuHp1jIiKS85YkDnWg==
X-Received: by 2002:a17:90b:4a4e:b0:1ec:beae:6f33 with SMTP id lb14-20020a17090b4a4e00b001ecbeae6f33mr19621048pjb.185.1656699688298;
        Fri, 01 Jul 2022 11:21:28 -0700 (PDT)
Received: from localhost ([2601:644:200:2b2:96e:bcc8:8ad7:1761])
        by smtp.gmail.com with ESMTPSA id gz4-20020a17090b0ec400b001ec4f258028sm6865954pjb.55.2022.07.01.11.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 11:21:27 -0700 (PDT)
From:   Ivan Babrou <ivan@cloudflare.com>
To:     linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Ivan Babrou <ivan@cloudflare.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Ian Rogers <irogers@google.com>,
        Fangrui Song <maskray@google.com>
Subject: [PATCH] perf unwind: fix unitialized offset on aarch64
Date:   Fri,  1 Jul 2022 11:20:46 -0700
Message-Id: <20220701182046.12589-1-ivan@cloudflare.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Commit dc2cf4ca866f uncovered the following issue on aarch64:

    util/unwind-libunwind-local.c: In function 'find_proc_info':
    util/unwind-libunwind-local.c:386:28: error: 'offset' may be used uninitialized in this function [-Werror=maybe-uninitialized]
    386 |                         if (ofs > 0) {
        |                            ^
    util/unwind-libunwind-local.c:199:22: note: 'offset' was declared here
    199 |         u64 address, offset;
        |                      ^~~~~~
    util/unwind-libunwind-local.c:371:20: error: 'offset' may be used uninitialized in this function [-Werror=maybe-uninitialized]
    371 |                 if (ofs <= 0) {
        |                    ^
    util/unwind-libunwind-local.c:199:22: note: 'offset' was declared here
    199 |         u64 address, offset;
        |                      ^~~~~~
    util/unwind-libunwind-local.c:363:20: error: 'offset' may be used uninitialized in this function [-Werror=maybe-uninitialized]
    363 |                 if (ofs <= 0) {
        |                    ^
    util/unwind-libunwind-local.c:199:22: note: 'offset' was declared here
    199 |         u64 address, offset;
        |                      ^~~~~~
    In file included from util/libunwind/arm64.c:37:

Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
Fixes: dc2cf4ca866f
---
 tools/perf/util/unwind-libunwind-local.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 37622699c91a..eaa8fa4b34f3 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -197,7 +197,7 @@ static int elf_section_address_and_offset(int fd, const char *name, u64 *address
 #ifndef NO_LIBUNWIND_DEBUG_FRAME
 static u64 elf_section_offset(int fd, const char *name)
 {
-	u64 address, offset;
+	u64 address, offset = 0;
 
 	if (elf_section_address_and_offset(fd, name, &address, &offset))
 		return 0;
-- 
2.36.1

