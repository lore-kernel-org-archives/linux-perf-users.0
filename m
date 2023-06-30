Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1BAEB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jun 2023 08:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjF3Imr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 04:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjF3ImT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jun 2023 04:42:19 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4BF3C0D
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 01:41:55 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso2627088e87.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 01:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688114513; x=1690706513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDd0P6Z6Y37kRPaqqHaNAC3kQrjxk6Pu8HaK2zooeKg=;
        b=Y41VrW8/WSTU5UZ0jha3wwL0Ej0Tqd3A2qkgrwAyZodUC/Uz8mWxFXPieMXCL9Qgkc
         aCxnf9L5pPkNT/eeVpj05gNJZy/aSu0i+l4K1alIFaVSt15uuOkO1E6tqT2Jw85snBkt
         eBMVD67kXwSAZmYJxN6xoMJp0H+pOyoW3QN4+hUahcRJSus8PGYrRNm9+d7On6kDNC7b
         g3jjB7S7COhraUHuWtlOaXR0UlBpzLL2bWINQ2J4KfkEAXDJXOOk2OggifnX6rcvyHeG
         nXSybsUY3tIMMztv3/UeobmrRZ0vqFQvg+NAjIoAuQfRago5a4TDxH3y3gIH4MfF24+s
         PliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688114513; x=1690706513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDd0P6Z6Y37kRPaqqHaNAC3kQrjxk6Pu8HaK2zooeKg=;
        b=aR/Bk8tu0mx1kKumt1FaCmNDTvsqiXu2/vFKEZgPCqd/PDULV5+U8iTXCQ9griBjLA
         CRrxoAq9B33pgmXymZVRvmO5fTnr0luykdagSeub1nZcaOC//lwszyDxXlnGlHUlmgMM
         25d4o4QBN5WBpyVkt3RjMnCwSq5O06GRRazJhf+AhH2O6yDpr+rkZ2bedwhkYUob1wgm
         +6NIHZsLCz47mG7bGhFyfiTU6BgorD59dKPDLIVG61gyupMm7WWj4Gh+ut9p4NyKg0BP
         seIkbCXMrfaBImb2L+O5nc8g1DxdRDjxSQUqUVS4VSeEiVsiK9xcOTY0vi/HleowCdmW
         sEkA==
X-Gm-Message-State: ABy/qLYiA23gIqrt3z7VEO2mtR/s4gC+F1VFu0b9CmIf+eNOzUpZoPwp
        1KD/p0pH1IsVqc7T8mLbc4uNsg==
X-Google-Smtp-Source: APBJJlH7485mFBkMkfiINnyjXjrffdesyhHF/v8B35gqPVeTtnbEfcY+mPVgYOVbdZDlPoNQQNysmg==
X-Received: by 2002:a19:8c19:0:b0:4f1:4cdc:ec03 with SMTP id o25-20020a198c19000000b004f14cdcec03mr1476845lfd.18.1688114513557;
        Fri, 30 Jun 2023 01:41:53 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id v11-20020adff68b000000b0031424950a99sm649850wrp.81.2023.06.30.01.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 01:41:53 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 10/10] perf: tests: Adapt mmap-basic.c for riscv
Date:   Fri, 30 Jun 2023 10:30:13 +0200
Message-Id: <20230630083013.102334-11-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630083013.102334-1-alexghiti@rivosinc.com>
References: <20230630083013.102334-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

riscv now supports mmaping hardware counters to userspace so adapt the test
to run on this architecture.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 tools/perf/tests/mmap-basic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index e68ca6229756..f5075ca774f8 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -284,7 +284,7 @@ static struct test_case tests__basic_mmap[] = {
 			 "permissions"),
 	TEST_CASE_REASON("User space counter reading of instructions",
 			 mmap_user_read_instr,
-#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
+#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || __riscv_xlen == 64
 			 "permissions"
 #else
 			 "unsupported"
@@ -292,7 +292,7 @@ static struct test_case tests__basic_mmap[] = {
 		),
 	TEST_CASE_REASON("User space counter reading of cycles",
 			 mmap_user_read_cycles,
-#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
+#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || __riscv_xlen == 64
 			 "permissions"
 #else
 			 "unsupported"
-- 
2.39.2

