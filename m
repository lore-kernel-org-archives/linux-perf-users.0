Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFCBEB64DD
	for <linux-perf-users@archiver.kernel.org>; Mon,  3 Jul 2023 12:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjGCM5E (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Jul 2023 08:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjGCM5E (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Jul 2023 08:57:04 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA212E41
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Jul 2023 05:57:02 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc0981733so42265975e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Jul 2023 05:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688389021; x=1690981021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDd0P6Z6Y37kRPaqqHaNAC3kQrjxk6Pu8HaK2zooeKg=;
        b=Sphcz5qq3+buhzDZsZI3W4+b4HigOS5WU6NMwnUZs/kQbxA9PrbT3K+5o0p+1ABhil
         HZO2QoS68J/YmOLK5ud3i4DoQp3AMTM6ENbWuC5bwUi/1iBU4Y7Thgw0OpAcSzia3XxW
         7ItXaRtwC4HMKc98rtOe9L0V9SB0/dx1QQxnKIUPI8IngESdeojydIjryy66+xXmuhzc
         ipRs+hTSO4xt7oghX+frCZ6A4RWNmu6JY+Hu8WATZZCJX9xr7YrtzPbTUOzLthmSKHpS
         ZCGbCIxrnPm7pyUceyeOfFItc/CioLz+WWoy7ghuQL0R8TiNKRjrg+yuNZ8zvmejwvLm
         Efow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688389021; x=1690981021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDd0P6Z6Y37kRPaqqHaNAC3kQrjxk6Pu8HaK2zooeKg=;
        b=d4mK637i7kwXlnZZn64DtcOR9yKe3Sbs5Dq0wuxktkxREIQMwZcPwAKMGehGDTuTQ3
         7TEflTULBtce2mzPaTcFlIdQX/ltB7ZtAjMmfwGdXSUIYPF4kTh0Zf/xn4HzD9B9dQgK
         0NGn7ptKE/8M2iKyV255nxU3T+OnPzJk673siDk26F7+nVsX91XkwNgzDFzsVEx1FcMx
         dNsuzxMvtBv/hdfvaf4n/ZvE5ixbVdnl+fOMoHWpgX9bf71m3ShnXK0pYPvtcph4BQzH
         dxmDBsnFqVm4+w3jFdOTIXNDLQlhDasNq7lkPeVjEZ0oVMoz1UZfs7Q1kye4IKF0XPhM
         MXFQ==
X-Gm-Message-State: AC+VfDxFJooGufu8wIrAz39F80nJVMaNr0P2RejvoYuqt3jzmP7TlDH3
        u8NaDtwPd5b3D0ttK4hAF7eihQ==
X-Google-Smtp-Source: ACHHUZ6/fBeiAWwj87e60iBk0jsshSg/HXNuUNYk789KVMfnmQErAN4M02VvuTIO86TKRIqfowM8+g==
X-Received: by 2002:a05:600c:2049:b0:3f9:b31d:5689 with SMTP id p9-20020a05600c204900b003f9b31d5689mr7826755wmg.36.1688389021142;
        Mon, 03 Jul 2023 05:57:01 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id n20-20020a7bcbd4000000b003fb739d27aesm18799546wmi.35.2023.07.03.05.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 05:57:00 -0700 (PDT)
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
Subject: [PATCH v4 10/10] perf: tests: Adapt mmap-basic.c for riscv
Date:   Mon,  3 Jul 2023 14:46:47 +0200
Message-Id: <20230703124647.215952-11-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703124647.215952-1-alexghiti@rivosinc.com>
References: <20230703124647.215952-1-alexghiti@rivosinc.com>
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

