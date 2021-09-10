Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBE2C4332F
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 19:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E340C610C7
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 19:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhIJT3s (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 15:29:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:29551 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbhIJT3h (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Sep 2021 15:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631302103; x=1662838103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DAp64paU3TCuJOhu7apCE+cFKSV+lH5b3Cp62qoHD/M=;
  b=gC4uokdKMMOjufz6zAgK1EjqajKBGz+w/5dIMxBQeoH1UBFFXWvyyf+h
   fguozGkMlDXULc2vgpDLIPY647HfAHJpOwipw7dTZFsJMgZpE3fERSFyE
   A3A6PifCeZ4LWHxiaJXsAaC6aw1Pk5OxA6kzo6AuDZxP0SfgeHVVe1xKW
   B7rdxsKRABbA/RfdAUsoyP/od6mEdptNL0Exo87uWl/R/5hTJ2TJNjHgu
   eS5fcx/8JEWEvYMs27deQVcAOYgJJNXYAZ+luS/KQC4qgRwCi7LnPHkL4
   2k/hnIfyMCXrCsWbPd/jEZyLzr6B17VhmIEOz7zlTxZcn+2ROSwh1VW9a
   g==;
X-IronPort-AV: E=Sophos;i="5.85,283,1624291200"; 
   d="scan'208";a="179706179"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2021 03:28:23 +0800
IronPort-SDR: 71rxKR+WOluqrSvrLCPoMAmwDpWBZY8jnG5RBIAtogwamhtOEh0t/R86S8jaavics2IZwDvF5y
 Y/F8V97Vmizy9nVKXOsMT74t0QioWpPVXGkXGIcw3LU1EpQhT+dj9qAC0KFyxVn8wMd8m3o1Rq
 aI9ZOVT+Q/9AakuyH5Gb9TDlimloovLFskCoEiZgPm4g6e9NUvSrkwtXK2x5XL25B8TzRoiNvt
 cBxKQZcsaX1D97p2tTmwUiSatBh6pC5PRCa7fJyjOK16nHciEJrSRkbdaYTJfp1Uc8MrcAMM6g
 d8OINkCbzv9tepetOC4nnexy
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 12:03:20 -0700
IronPort-SDR: Gp6nfrIAxPnXUZWBQE8ZGO4hoQRY+xfQh7dd87UsREg+elLIcD6Iov/il9cDNn8EnJdndekvqB
 DEbII0uc7YtTV9d5KSVzCDrl8GyjA0NUplaCtybKXKPAfhubO174mcFEqvbk3ckLiuiUMmTuFe
 6GHn2iLGIAGriS3Zr6eGFL78P9oBvENYSoYbgCCCjXNSOl8Mww+xu/8VM2sI9cx33N4+gzjZSg
 /GwXXH4i1FcSgdYrpWhqg4xN3mkce+RY7Hb8pQUUTn7KHiQKztMOly/ITcwOEmLLWObpRmrjSx
 52g=
WDCIronportException: Internal
Received: from unknown (HELO hulk.wdc.com) ([10.225.167.73])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2021 12:28:25 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, devicetree@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [v3 10/10] MAINTAINERS: Add entry for RISC-V PMU drivers
Date:   Fri, 10 Sep 2021 12:27:57 -0700
Message-Id: <20210910192757.2309100-11-atish.patra@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210910192757.2309100-1-atish.patra@wdc.com>
References: <20210910192757.2309100-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add myself and Anup as maintainer for RISC-V PMU drivers.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9af529acb6a6..6a184a4162b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16056,6 +16056,16 @@ S:	Maintained
 F:	drivers/mtd/nand/raw/r852.c
 F:	drivers/mtd/nand/raw/r852.h
 
+RISC-V PMU DRIVERS
+M:	Atish Patra <atish.patra@wdc.com>
+M:	Anup Patel <anup.patel@wdc.com>
+L:	linux-riscv@lists.infradead.org
+S:	Supported
+F:	Documentation/devicetree/bindings/pmu/riscv,pmu.yaml
+F:	drivers/perf/riscv_pmu.c
+F:	drivers/perf/riscv_pmu_legacy.c
+F:	drivers/perf/riscv_pmu_sbi.c
+
 RISC-V ARCHITECTURE
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 M:	Palmer Dabbelt <palmer@dabbelt.com>
-- 
2.31.1

