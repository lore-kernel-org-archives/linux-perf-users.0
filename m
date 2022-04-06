Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF2AC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Apr 2022 17:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbiDFRDw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238199AbiDFRDo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Apr 2022 13:03:44 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0763447F01A
        for <linux-perf-users@vger.kernel.org>; Wed,  6 Apr 2022 07:26:59 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 7so2572004pfu.13
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Apr 2022 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BlaHLYunH8lWogXwwfxKssKzGVm1nfRpO2uSQYLbmK4=;
        b=AycY1YVxDa54nJpBch0AKnr4fQqh/ofZJHis8/uZ7wWJOSQexNGu/TkhQXKuTapuXC
         Oe0RTNTVoKpp9diugvrz243dFZbkcxw/T8tMGwStdU+fCK+j2Ng2TYLu1+PiyS/gV1Wv
         pPHe7/3wW0TWlMBi2i4VpHd/+8ByOIIEpavuN48UycUL5rHNxoliDoxgMBz0j5xkeUby
         u/USPSXfwuWum/duFYlfBDvSJTNM8tLjjX+o3LNlFaLkBgY9VeFNWY5BslVxu2rjmiln
         9DUlBRuW4kl95PYl2NIQkQk0dmE9KaAMyNbVThROAJEVvAq7eOeUYsRJFkfyJywlASMs
         oN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BlaHLYunH8lWogXwwfxKssKzGVm1nfRpO2uSQYLbmK4=;
        b=yJlTOF/YeAKcuc8DSAkPBoELVVVynSBDYpTHDTxuxROiz+VGrPZ4PY0Zu4Hyw24fPW
         tko7ViEmQcJ8cry/n+1UtRbNU4aXBJTbIfea93OUqNr4bATEVLXVxt/ymyZtIOlaKMgj
         kNHQP3y6wiIMx011RVcAAQE7A1HJDN/wI3eQnqkGDPNwoTskRuBlihCTzda0vxkNAMRm
         1bQfDvs6yZNEqdvsqc5F3tt2VcBOde3hh/Ka000yHd3PMu57zlmIwiMpvNphahEcfdN0
         M+b8GOMxhygORhlIe+oH8WMdQ8cp9nmJp8PCLQFU6ByB98gyGmejvQpbMJRPMCNm1/7i
         /v1Q==
X-Gm-Message-State: AOAM532hh/L/6lj3S2QLYL5UMzsXREcd0KHFBHlvqB8RpMenzox5Ifna
        yQw4IicSNaWnkT/jWI2QBn7zPA==
X-Google-Smtp-Source: ABdhPJwaAJtnGiRN+5RAf/ZIeJzHbeGqbgF7hWd3RWch1tryvglddvyOCvMokwbAKr+NAy0lWkH8pw==
X-Received: by 2002:a63:f10c:0:b0:382:623b:3bb9 with SMTP id f12-20020a63f10c000000b00382623b3bb9mr7287904pgi.97.1649255218336;
        Wed, 06 Apr 2022 07:26:58 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id k137-20020a633d8f000000b0039800918b00sm16424151pga.77.2022.04.06.07.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 07:26:57 -0700 (PDT)
From:   Eric Lin <eric.lin@sifive.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, iii@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     paul.walmsley@sifive.com, greentime.hu@sifive.com,
        Eric Lin <eric.lin@sifive.com>
Subject: [PATCH 1/1] perf jitdump: Add riscv64 support.
Date:   Wed,  6 Apr 2022 22:26:06 +0800
Message-Id: <20220406142606.18464-2-eric.lin@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406142606.18464-1-eric.lin@sifive.com>
References: <20220406142606.18464-1-eric.lin@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Signed-off-by: Eric Lin <eric.lin@sifive.com>
---
 tools/perf/arch/riscv/Makefile | 1 +
 tools/perf/util/genelf.h       | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/arch/riscv/Makefile b/tools/perf/arch/riscv/Makefile
index 1aa9dd772489..a8d25d005207 100644
--- a/tools/perf/arch/riscv/Makefile
+++ b/tools/perf/arch/riscv/Makefile
@@ -2,3 +2,4 @@ ifndef NO_DWARF
 PERF_HAVE_DWARF_REGS := 1
 endif
 PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
+PERF_HAVE_JITDUMP := 1
diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
index 3db3293213a9..ae138afe6c56 100644
--- a/tools/perf/util/genelf.h
+++ b/tools/perf/util/genelf.h
@@ -38,6 +38,9 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_ent
 #elif defined(__s390x__)
 #define GEN_ELF_ARCH	EM_S390
 #define GEN_ELF_CLASS	ELFCLASS64
+#elif defined(__riscv) && __riscv_xlen == 64
+#define GEN_ELF_ARCH	EM_RISCV
+#define GEN_ELF_CLASS	ELFCLASS64
 #else
 #error "unsupported architecture"
 #endif
-- 
2.35.1

