Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3AAEB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jun 2023 08:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjF3IkR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 04:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjF3Ijx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jun 2023 04:39:53 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8068B1FFA
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 01:39:52 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fafe87c6fbso2536197e87.3
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 01:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688114391; x=1690706391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOVYMufG9/FqBaKJMl/ssTpZw9h9Tbb5FABAwd0Y76o=;
        b=EBbwFVdpIP6AbRzaCcRxUMVywY4aT8TXXYQBzuXycm69Am66X12dUUj6ysptXYgNIr
         kGTOqS2hMSiKkr9t8z64Utml0NDzDblWb9Ih06lJFn88rRYmLS/ZPqlg6vNJLf55epe+
         mfrndHAolhwfEvfAkLITFEqkTzZdBDYfiD5T/qT4GIQHOmdzObxuWC0UwwP9TFrFmFpM
         bOPDk4nWuDmSYim/muDHyo6QJDgHMVwWgX305aJ7W6a9SKOfVaW1r9NQOFu5pEKK5lfc
         w7NUfhwrRVI6RlDSQw5InTNym6I+xWKhvZhPrW4P4cphlohLHplbvosEpLUxq3VL/KAk
         2BsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688114391; x=1690706391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOVYMufG9/FqBaKJMl/ssTpZw9h9Tbb5FABAwd0Y76o=;
        b=gzZABUItvj6q2K77aCVY9M0wLVJ36Qa163t0C3N/vJ2KodF5JJjTEsiCx6KLLkbk6O
         0sd0y1VJUzkaZ+j0UPlTn5gWkFtKoMiJ4/mFOVGVOoFPnIZlggxAcd0Mj7YZwZAro55C
         EWOdhcUZ1BxUdKgeWZsmSDIrPRWki1qFEcDCOOABWMziMIEmB0NxgwF6A7QLf3dK8u2i
         ofAMBe/4MxsyMDP91uGOVPIUTJcMpqyZmQZ6mbHs9i0oWYHdTMvvoyvoYDSpquFBh5aK
         gXza5ZXp6QoF1h9y2lhtwxQ2xySj+PY0SkCznGCbIptZg6gbRqUQ20Ug4kQi1cOb0Qym
         q+Lg==
X-Gm-Message-State: ABy/qLYzQ0OsSudIYVnGvQO3D4yWBaajGxXiry2QkUCzkA8MX+XzWIfa
        hOwDwASbNdVnzL9uIDLiU4J0MA==
X-Google-Smtp-Source: APBJJlGNGYeNhgyNFQCIWRKRLA0RLNxSwiPewnnuJneE3RkbWYcI3Hv4y5MnEIudbxWchriJpKLCFg==
X-Received: by 2002:a05:6512:31d4:b0:4f8:5f32:b1da with SMTP id j20-20020a05651231d400b004f85f32b1damr2010376lfe.24.1688114390713;
        Fri, 30 Jun 2023 01:39:50 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id l6-20020adff486000000b00313fd294d6csm9704615wro.7.2023.06.30.01.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 01:39:50 -0700 (PDT)
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
Subject: [PATCH v3 08/10] Documentation: admin-guide: Add riscv sysctl_perf_user_access
Date:   Fri, 30 Jun 2023 10:30:11 +0200
Message-Id: <20230630083013.102334-9-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630083013.102334-1-alexghiti@rivosinc.com>
References: <20230630083013.102334-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

riscv now uses this sysctl so document its usage for this architecture.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 26 +++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index d85d90f5d000..c376692b372b 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -941,16 +941,34 @@ enabled, otherwise writing to this file will return ``-EBUSY``.
 The default value is 8.
 
 
-perf_user_access (arm64 only)
-=================================
+perf_user_access (arm64 and riscv only)
+=======================================
+
+Controls user space access for reading perf event counters.
 
-Controls user space access for reading perf event counters. When set to 1,
-user space can read performance monitor counter registers directly.
+arm64
+=====
 
 The default value is 0 (access disabled).
+When set to 1, user space can read performance monitor counter registers
+directly.
 
 See Documentation/arm64/perf.rst for more information.
 
+riscv
+=====
+
+When set to 0, user access is disabled.
+
+When set to 1, user space can read performance monitor counter registers
+directly only through perf, any direct access without perf intervention will
+trigger an illegal instruction.
+
+The default value is 2, which enables legacy mode (user space has direct
+access to cycle and insret CSRs only). Note that this legacy value
+is deprecated and will be removed once all userspace applications are fixed.
+
+Note that the time CSR is for now always accessible to all modes.
 
 pid_max
 =======
-- 
2.39.2

