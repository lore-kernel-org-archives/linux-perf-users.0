Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D45C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Oct 2021 17:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C55360E09
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Oct 2021 17:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbhJYRZt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 25 Oct 2021 13:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbhJYRZr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Oct 2021 13:25:47 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B315C061745;
        Mon, 25 Oct 2021 10:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=D47mqACLa3AcQRc6qgSnNXuHVEOjdx5l+P+SHXbONJ4=; b=Yt
        U9/G6y6Pv19erawptmCBvu2WNHLmsaVlCJ/BNKfkO9YLPEGNaaDGEPiZm7C3h/4iiwe8x5enmfjqJ
        ZL75/he+V0ANlMxfdM9Z9SR76rM5UmcwDyQJvnzSGij7U1+V9OCz7eYUzsR0XEvIFgRr8vN97ARKN
        5/jxu4ceUGijP075VQxJ01A/WDtTFIbZZo9i+kE9IImmGXPOYuMXnbHnePgkSphzU8QqrZHjX2zj3
        bqApDst0WY2Aa6CwMTxZJ9OwOxJlFhUGOqvyGspXeAMJky76CmgRwS9mI06/NJdI+IPitheL3cEZ3
        wT6bqfDCZXdWsfrs0fm7ThnV50x8erHA==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mf3gu-0007p4-5P; Mon, 25 Oct 2021 18:23:20 +0100
From:   John Keeping <john@metanate.com>
To:     linux-perf-users@vger.kernel.org
Cc:     John Keeping <john@metanate.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] tools/build: drop slang include path in test-all
Date:   Mon, 25 Oct 2021 18:23:13 +0100
Message-Id: <20211025172314.3766032-1-john@metanate.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Commit cbefd24f0aee3 ("tools build: Add test to check if slang.h is in
/usr/include/slang/") added a proper test to check whether slang.h is in
a subdirectory, and commit 1955c8cf5e26b ("perf tools: Don't hardcode
host include path for libslang") removed the include path for
test-libslang.bin but missed test-all.bin.  Apply the same change to
test-all.bin.

Fixes: 1955c8cf5e26 ("perf tools: Don't hardcode host include path for libslang")
Signed-off-by: John Keeping <john@metanate.com>
---
Resending as linux-perf-users wasn't included last time.
MAINTAINERS doesn't include any entries covering this file.

 tools/build/feature/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index d024b5204ba0..71390309f4d7 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -91,7 +91,7 @@ __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(
 ###############################
 
 $(OUTPUT)test-all.bin:
-	$(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -I/usr/include/slang -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd -lcap
+	$(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd -lcap
 
 $(OUTPUT)test-hello.bin:
 	$(BUILD)
-- 
2.33.1

