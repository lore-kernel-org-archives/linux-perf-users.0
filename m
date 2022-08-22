Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFFDC28D13
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Aug 2022 12:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbiHVMjx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 Aug 2022 08:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbiHVMjq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 Aug 2022 08:39:46 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578893AB0A;
        Mon, 22 Aug 2022 05:39:40 -0700 (PDT)
X-QQ-mid: bizesmtp66t1661171967tgy3lb69
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 22 Aug 2022 20:39:26 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: znfcQSa1hKaNDQ1K54b/o4Ju5UJHE6KfcLHm3i98mhNk58L+qECCKxFV007W7
        eDgKUq1XzPzqhlmy+hjz3UKlXZ+bYGz0bysrpbG/hvYKJgT4L7kXx75NQWQyDsWKaly1Ctd
        BMqmLo7+/vRPHk6otPEt5vpHV3QH9fhwolbxrxPcu5bX+fQNPDFOlWYwTVAFL2r8Xxv5UZL
        1hmG4k7FHRT0++QDv+Odn62mp34uQ2agQI+U3SRwANVkbTxrmBccGq/nJXOXrxWtfN5cP5w
        /fG8bZ9z13Oj/0e6elG7pxocpoMdH/JWD7SybYoEITabAcytVOgWiLMBHDsf28mA45LW2Fj
        V3OPL7WoLADRK4KSx6UuEF8FOrM5l/gKdJhosKj2/ouixe9rbdFTC3p1qdbdI+ynQy+epet
        bwLpcXgdnTg=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] tools/perf: fix repeated words in comments
Date:   Mon, 22 Aug 2022 20:39:19 +0800
Message-Id: <20220822123919.32547-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

 Delete the redundant word 'and'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 tools/perf/builtin-trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 897fc504918b..2f7b1111d8e9 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2040,7 +2040,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 
 			/*
  			 * Suppress this argument if its value is zero and
- 			 * and we don't have a string associated in an
+ 			 * we don't have a string associated in an
  			 * strarray for it.
  			 */
 			if (val == 0 &&
@@ -2748,7 +2748,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 
 		/*
 		 * Suppress this argument if its value is zero and
-		 * and we don't have a string associated in an
+		 * we don't have a string associated in an
 		 * strarray for it.
 		 */
 		if (val == 0 &&
-- 
2.36.1

