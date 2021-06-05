Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490B1C47082
	for <linux-perf-users@archiver.kernel.org>; Sat,  5 Jun 2021 15:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C9BE60720
	for <linux-perf-users@archiver.kernel.org>; Sat,  5 Jun 2021 15:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhFEP7J (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 5 Jun 2021 11:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhFEP7J (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 5 Jun 2021 11:59:09 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C11C061766;
        Sat,  5 Jun 2021 08:57:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t7so11555078lff.0;
        Sat, 05 Jun 2021 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lkML3ZAMsm0s3/+lOpUdSc7KyrgtFH46mJj2cAwl5k4=;
        b=sP8tqdSdxMUZB87WmlpAvxl17NXemziWgZIj0RPlt2IxLegXseL2dFEgAlOO4FWNXx
         ihOIW+wWXBs7eMS65kCiWhuyxBjUz72ESlQC5oRvCh3H3SdETSpTASyrkSOGQ8Yw/J4h
         /phxNAQ5P/ysPoDQw8+6cNi/YRK+zf7eEvFWnnnSq7Ti3z4re8RtRDaQhdmgQQE8NKoE
         DMCfc/8Xk4lc7otRIp+V5tXUiL6Hg0yeNJ4DW0Jnk6lRUlodhU+uB5WHg/TKuHfKHb2k
         mmqcpNqWEDgnxMBEUUk/zkuiufRqKRBjZcgoVW7+7130ZkcuOq7bAuuvJqBwitYH5nbF
         hpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lkML3ZAMsm0s3/+lOpUdSc7KyrgtFH46mJj2cAwl5k4=;
        b=QwKvgGnpL2TV6QZViBh9+4KpGUMySUL6ySnh8j05sC6KntosPoc99O+25LxTsb9O9l
         OV8BO6XIzb7wv4VyO9P6usoLsSZqx8BgqR0hweHgwtBXoLyjZIp974KInKgyiL5q3EXl
         9l+Fc5DuFZ9Vi7z8oODdwrgG0ZpxwddUQVlOJ2tO+4N49xUYQMxffivqqieFLTPtNmsN
         +nVKhjwwZToieZ4PaHULvSfsygYQBmTnumpA5NxKAGy6OOo1bhiF85Uc3MqrFae/lA0i
         lK4g2bOSnT4ixypaJDr0J6sDRm4R3Xr1KocT6VwNzpTJif1vl1Hyavsi2Qy19PnADDvZ
         wgYQ==
X-Gm-Message-State: AOAM531w2NVIswdySht1rSWfKOXchxhXYTYl8Aa8ySlB52pOYQf5VeJH
        W+zeeGu/rBcd3vAfw3sFGj4=
X-Google-Smtp-Source: ABdhPJyXieTIH80Qeq8+Dd+Oe3aki0v0rhhRYRoFth5xjHb7eSTmvRTPSydoc/E9Z5ZyjqrD4meijQ==
X-Received: by 2002:ac2:5e36:: with SMTP id o22mr6443077lfg.320.1622908633316;
        Sat, 05 Jun 2021 08:57:13 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id w15sm146264lfq.94.2021.06.05.08.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 08:57:13 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 3/4] perf/x86/intel/uncore: Constify freerunning_counters
Date:   Sat,  5 Jun 2021 17:56:52 +0200
Message-Id: <20210605155653.21850-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210605155653.21850-1-rikard.falkeborn@gmail.com>
References: <20210605155653.21850-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

These are never modified, so make them const to allow the compiler to
put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 arch/x86/events/intel/uncore.h       |  4 ++--
 arch/x86/events/intel/uncore_snb.c   |  6 +++---
 arch/x86/events/intel/uncore_snbep.c | 14 +++++++-------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 83b25a7b8c27..6a7f0104bb38 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -79,7 +79,7 @@ struct intel_uncore_type {
 	struct intel_uncore_pmu *pmus;
 	const struct intel_uncore_ops *ops;
 	struct uncore_event_desc *event_descs;
-	struct freerunning_counters *freerunning;
+	const struct freerunning_counters *freerunning;
 	const struct attribute_group *attr_groups[4];
 	const struct attribute_group **attr_update;
 	struct pmu *pmu; /* for custom pmu ops */
@@ -175,7 +175,7 @@ struct freerunning_counters {
 	unsigned int box_offset;
 	unsigned int num_counters;
 	unsigned int bits;
-	unsigned *box_offsets;
+	const unsigned *box_offsets;
 };
 
 struct intel_uncore_topology {
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 3eff6f1a5b99..475e48b7a686 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -603,7 +603,7 @@ enum perf_snb_uncore_imc_freerunning_types {
 	SNB_PCI_UNCORE_IMC_FREERUNNING_TYPE_MAX,
 };
 
-static struct freerunning_counters snb_uncore_imc_freerunning[] = {
+static const struct freerunning_counters snb_uncore_imc_freerunning[] = {
 	[SNB_PCI_UNCORE_IMC_DATA_READS]		= { SNB_UNCORE_PCI_IMC_DATA_READS_BASE,
 							0x0, 0x0, 1, 32 },
 	[SNB_PCI_UNCORE_IMC_DATA_WRITES]	= { SNB_UNCORE_PCI_IMC_DATA_WRITES_BASE,
@@ -1344,13 +1344,13 @@ enum perf_tgl_uncore_imc_freerunning_types {
 	TGL_MMIO_UNCORE_IMC_FREERUNNING_TYPE_MAX
 };
 
-static struct freerunning_counters tgl_l_uncore_imc_freerunning[] = {
+static const struct freerunning_counters tgl_l_uncore_imc_freerunning[] = {
 	[TGL_MMIO_UNCORE_IMC_DATA_TOTAL]	= { 0x5040, 0x0, 0x0, 1, 64 },
 	[TGL_MMIO_UNCORE_IMC_DATA_READ]		= { 0x5058, 0x0, 0x0, 1, 64 },
 	[TGL_MMIO_UNCORE_IMC_DATA_WRITE]	= { 0x50A0, 0x0, 0x0, 1, 64 },
 };
 
-static struct freerunning_counters tgl_uncore_imc_freerunning[] = {
+static const struct freerunning_counters tgl_uncore_imc_freerunning[] = {
 	[TGL_MMIO_UNCORE_IMC_DATA_TOTAL]	= { 0xd840, 0x0, 0x0, 1, 64 },
 	[TGL_MMIO_UNCORE_IMC_DATA_READ]		= { 0xd858, 0x0, 0x0, 1, 64 },
 	[TGL_MMIO_UNCORE_IMC_DATA_WRITE]	= { 0xd8A0, 0x0, 0x0, 1, 64 },
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index b5b22fe473d8..507bb83e1463 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3885,7 +3885,7 @@ enum perf_uncore_iio_freerunning_type_id {
 };
 
 
-static struct freerunning_counters skx_iio_freerunning[] = {
+static const struct freerunning_counters skx_iio_freerunning[] = {
 	[SKX_IIO_MSR_IOCLK]	= { 0xa45, 0x1, 0x20, 1, 36 },
 	[SKX_IIO_MSR_BW]	= { 0xb00, 0x1, 0x10, 8, 36 },
 	[SKX_IIO_MSR_UTIL]	= { 0xb08, 0x1, 0x10, 8, 36 },
@@ -4588,7 +4588,7 @@ enum perf_uncore_snr_iio_freerunning_type_id {
 	SNR_IIO_FREERUNNING_TYPE_MAX,
 };
 
-static struct freerunning_counters snr_iio_freerunning[] = {
+static const struct freerunning_counters snr_iio_freerunning[] = {
 	[SNR_IIO_MSR_IOCLK]	= { 0x1eac, 0x1, 0x10, 1, 48 },
 	[SNR_IIO_MSR_BW_IN]	= { 0x1f00, 0x1, 0x10, 8, 48 },
 };
@@ -4931,7 +4931,7 @@ enum perf_uncore_snr_imc_freerunning_type_id {
 	SNR_IMC_FREERUNNING_TYPE_MAX,
 };
 
-static struct freerunning_counters snr_imc_freerunning[] = {
+static const struct freerunning_counters snr_imc_freerunning[] = {
 	[SNR_IMC_DCLK]	= { 0x22b0, 0x0, 0, 1, 48 },
 	[SNR_IMC_DDR]	= { 0x2290, 0x8, 0, 2, 48 },
 };
@@ -5153,15 +5153,15 @@ enum perf_uncore_icx_iio_freerunning_type_id {
 	ICX_IIO_FREERUNNING_TYPE_MAX,
 };
 
-static unsigned icx_iio_clk_freerunning_box_offsets[] = {
+static const unsigned icx_iio_clk_freerunning_box_offsets[] = {
 	0x0, 0x20, 0x40, 0x90, 0xb0, 0xd0,
 };
 
-static unsigned icx_iio_bw_freerunning_box_offsets[] = {
+static const unsigned icx_iio_bw_freerunning_box_offsets[] = {
 	0x0, 0x10, 0x20, 0x90, 0xa0, 0xb0,
 };
 
-static struct freerunning_counters icx_iio_freerunning[] = {
+static const struct freerunning_counters icx_iio_freerunning[] = {
 	[ICX_IIO_MSR_IOCLK]	= { 0xa55, 0x1, 0x20, 1, 48, icx_iio_clk_freerunning_box_offsets },
 	[ICX_IIO_MSR_BW_IN]	= { 0xaa0, 0x1, 0x10, 8, 48, icx_iio_bw_freerunning_box_offsets },
 };
@@ -5443,7 +5443,7 @@ enum perf_uncore_icx_imc_freerunning_type_id {
 	ICX_IMC_FREERUNNING_TYPE_MAX,
 };
 
-static struct freerunning_counters icx_imc_freerunning[] = {
+static const struct freerunning_counters icx_imc_freerunning[] = {
 	[ICX_IMC_DCLK]	= { 0x22b0, 0x0, 0, 1, 48 },
 	[ICX_IMC_DDR]	= { 0x2290, 0x8, 0, 2, 48 },
 	[ICX_IMC_DDRT]	= { 0x22a0, 0x8, 0, 2, 48 },
-- 
2.31.1

