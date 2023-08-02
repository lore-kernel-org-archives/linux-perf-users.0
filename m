Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE7CC00528
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Aug 2023 08:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjHBIGI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 2 Aug 2023 04:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjHBIGH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Aug 2023 04:06:07 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9F9E0
        for <linux-perf-users@vger.kernel.org>; Wed,  2 Aug 2023 01:06:06 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-314417861b9so5522596f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Aug 2023 01:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690963564; x=1691568364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFKT0CCXN0CmmHE2x8MUQw5sccSB1SdakxOhkM1UsG4=;
        b=Adz4V7ebnS4I/sTqKU8RSqQEnKbk+n8KbATevT3pt2JKoSYYQPOQxfDEVEBfvip2nx
         AngRsIDgef7MaOxkLUmDETDs6o8j015PBBys0v/5d1MMOsHH3wCG0pMzCQ+boByDZJzW
         WXik2xuDgv/KfsnxBicFvsOoSJVq8bx2MDTxE8SLF1FC9QhLAM1J6Ux9ZeRZzpytge6i
         JbFsreahsXB+e74yq7ZevOSM9Wiyv+5NvC8D+bdJyNm5uYQd2Jz5DFeO+kjORGPLNy5y
         8ND7l4FtK3RsDrDHLAeY5MPDyZWtGoR+6ygXi0vJ9janNWqopEiqBN65X7PN//eY3QbX
         7gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690963564; x=1691568364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFKT0CCXN0CmmHE2x8MUQw5sccSB1SdakxOhkM1UsG4=;
        b=KlTeJenuyryK3WsC0vfi40/WkAwPWhVlOISi8StfjFApTJ2j+C/8qcWU9A3+rBtlT7
         TVj/LVtEu0pNtnZ/Kg5EsI1vy88FYrP8JqzbaNvSgXITPoJQamIVRZ4wyxq7EDIkzvT9
         1tPH6S2njtYwtuLAHnSvTjzJH/Q/WC4BFnZkgvxCInnVTlZHymuoiYPSdrXwoJGpsg7r
         IJjrfwsV3rQ8hUYlbhkx8+avVWtH/t9+EC9ic81iUOr5EwNLrD3uvqW7QB2whGNslW3K
         o/KztjO0rcuzy0+bfAwdCN75m7163/ZYOHBynBzV1jpykODSQQ2vmepNOpHg1aryUCc8
         bf7Q==
X-Gm-Message-State: ABy/qLakKDZc0ua1m1Hp22wrLa+oyD9HgxLmlwH4/BRXj7yk2ER09DTk
        13RLyj3O5KDk8x1UkIcufx+c2w==
X-Google-Smtp-Source: APBJJlG8oarSGyXOlT0EQobPAzvsBrq4qipdC0dcvV40KYMzzWjCixkSHe1ttjuuxvHCGFnvfLcJNg==
X-Received: by 2002:a5d:654b:0:b0:314:1f6:2c24 with SMTP id z11-20020a5d654b000000b0031401f62c24mr4197414wrv.36.1690963564470;
        Wed, 02 Aug 2023 01:06:04 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id z8-20020adfec88000000b0031773a8e5c4sm18156602wrn.37.2023.08.02.01.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 01:06:04 -0700 (PDT)
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
        =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v6 02/10] include: riscv: Fix wrong include guard in riscv_pmu.h
Date:   Wed,  2 Aug 2023 10:03:20 +0200
Message-Id: <20230802080328.1213905-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802080328.1213905-1-alexghiti@rivosinc.com>
References: <20230802080328.1213905-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The current include guard prevents the inclusion of asm/perf_event.h
which uses the same include guard: fix the one in riscv_pmu.h so that it
matches the file name.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 include/linux/perf/riscv_pmu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index 43fc892aa7d9..9f70d94942e0 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -6,8 +6,8 @@
  *
  */
 
-#ifndef _ASM_RISCV_PERF_EVENT_H
-#define _ASM_RISCV_PERF_EVENT_H
+#ifndef _RISCV_PMU_H
+#define _RISCV_PMU_H
 
 #include <linux/perf_event.h>
 #include <linux/ptrace.h>
@@ -81,4 +81,4 @@ int riscv_pmu_get_hpm_info(u32 *hw_ctr_width, u32 *num_hw_ctr);
 
 #endif /* CONFIG_RISCV_PMU */
 
-#endif /* _ASM_RISCV_PERF_EVENT_H */
+#endif /* _RISCV_PMU_H */
-- 
2.39.2

