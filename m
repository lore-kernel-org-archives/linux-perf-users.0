Received: from msa.smtpout.orange.fr (msa-215.smtpout.orange.fr [193.252.23.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED1FB656;
	Sun, 14 Jul 2024 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720962901; cv=none; b=TKnM8mPrV5tlOlv3whAmtPErKbqHZkSYjMxpLWvaaNgtgM2ZWXMjU3eaWDixCLxiFhJ084aeat8hS4YdJ3Eg1tRIq1U2PE6MjAooyZ24vZ1ME00FlVkiUBytVImmCELjtifzkNKZZYFEIhKAyT/vm+rXebnAS01/TyE2L+DaWeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720962901; c=relaxed/simple;
	bh=W4H2df2R/MdY3nerVtqR2oDHRHIYH4SFPc28EtGqjDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=az23Xp0f6vLHOEkR1uVHlWaplBTWabJtUGDgLzgjF/Ndw0oyP4QNY+Y/Gk5kpQs/+t6Qg4WkOOG6QCLf4+IpXLfqD0CXPH4FaE5zE82FLB8IRbtkWYP7QnqV7Jlj9dr3PNuBtPAWd1z6ANh5u2MDh2KTepzU11iObjEOUt3D3Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=UtDcZzJ2; arc=none smtp.client-ip=193.252.23.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UtDcZzJ2"
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id SyWpstpWvBzr3SyWqsrCvk; Sun, 14 Jul 2024 14:40:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1720960841;
	bh=jXEol/M69CDfWHWTuc98TPM6NHwESq7AdpoHFdBAkUw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UtDcZzJ2FilDY0fQzyn23s4ytCUtInKbCYmydlkzBvhN2/NDQ3Lm8LKor9/BcJ+Gl
	 0cRaxWl/4loYszrBqsoLpz08q+VNKu9GE5fYAmODovgCzZklt12JWjEpgqiZhe35fm
	 be8oiMQdgZC+UREYuf6e9S19Pttg0K70TjynGdduop3xZbjiEGNx2JQUtR2RUHlR0H
	 rnlUAknUj4Ic+i/Q5w0kpbx1kthcwSDmLJGAH82Exz1EVRXZ15GeDqdhRlZExhOPaU
	 D8EHaifpsos+kTH0Q2cRVUSVa7w6sJgEAuzKYcZNyzvVt/F45bDhmeujJ4Oe7LCHo5
	 QC4u212ytJYVg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Jul 2024 14:40:41 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf/x86/intel/uncore: Constify struct
Date: Sun, 14 Jul 2024 14:40:28 +0200
Message-ID: <9dc5e67d1b19e56c952e740371be9d42a5011c2c.1720960818.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct freerunning_counters' are not modified in these drivers.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  79637	  71836	     16	 151489	  24fc1	arch/x86/events/intel/uncore_snbep.o
  24000	  13628	      0	  37628	   92fc	arch/x86/events/intel/uncore_snb.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  80309	  71196	     16	 151521	  24fe1	arch/x86/events/intel/uncore_snbep.o
  24448	  13180	      0	  37628	   92fc	arch/x86/events/intel/uncore_snb.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 arch/x86/events/intel/uncore.h       |  2 +-
 arch/x86/events/intel/uncore_snb.c   |  8 ++++----
 arch/x86/events/intel/uncore_snbep.c | 16 ++++++++--------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 027ef292c602..b7cdf9b8e88a 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -80,7 +80,7 @@ struct intel_uncore_type {
 	struct intel_uncore_pmu *pmus;
 	struct intel_uncore_ops *ops;
 	struct uncore_event_desc *event_descs;
-	struct freerunning_counters *freerunning;
+	const struct freerunning_counters *freerunning;
 	const struct attribute_group *attr_groups[4];
 	const struct attribute_group **attr_update;
 	struct pmu *pmu; /* for custom pmu ops */
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 9462fd9f3b7a..001ba9230722 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -804,7 +804,7 @@ enum perf_snb_uncore_imc_freerunning_types {
 	SNB_PCI_UNCORE_IMC_FREERUNNING_TYPE_MAX,
 };
 
-static struct freerunning_counters snb_uncore_imc_freerunning[] = {
+static const struct freerunning_counters snb_uncore_imc_freerunning[] = {
 	[SNB_PCI_UNCORE_IMC_DATA_READS]		= { SNB_UNCORE_PCI_IMC_DATA_READS_BASE,
 							0x0, 0x0, 1, 32 },
 	[SNB_PCI_UNCORE_IMC_DATA_WRITES]	= { SNB_UNCORE_PCI_IMC_DATA_WRITES_BASE,
@@ -1435,13 +1435,13 @@ enum perf_tgl_uncore_imc_freerunning_types {
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
@@ -1661,7 +1661,7 @@ enum perf_adl_uncore_imc_freerunning_types {
 	ADL_MMIO_UNCORE_IMC_FREERUNNING_TYPE_MAX
 };
 
-static struct freerunning_counters adl_uncore_imc_freerunning[] = {
+static const struct freerunning_counters adl_uncore_imc_freerunning[] = {
 	[ADL_MMIO_UNCORE_IMC_DATA_TOTAL]	= { 0x40, 0x0, 0x0, 1, 64 },
 	[ADL_MMIO_UNCORE_IMC_DATA_READ]		= { 0x58, 0x0, 0x0, 1, 64 },
 	[ADL_MMIO_UNCORE_IMC_DATA_WRITE]	= { 0xA0, 0x0, 0x0, 1, 64 },
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index ca98744343b8..a88343bbd6a6 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4042,7 +4042,7 @@ enum perf_uncore_iio_freerunning_type_id {
 };
 
 
-static struct freerunning_counters skx_iio_freerunning[] = {
+static const struct freerunning_counters skx_iio_freerunning[] = {
 	[SKX_IIO_MSR_IOCLK]	= { 0xa45, 0x1, 0x20, 1, 36 },
 	[SKX_IIO_MSR_BW]	= { 0xb00, 0x1, 0x10, 8, 36 },
 	[SKX_IIO_MSR_UTIL]	= { 0xb08, 0x1, 0x10, 8, 36 },
@@ -4881,7 +4881,7 @@ enum perf_uncore_snr_iio_freerunning_type_id {
 	SNR_IIO_FREERUNNING_TYPE_MAX,
 };
 
-static struct freerunning_counters snr_iio_freerunning[] = {
+static const struct freerunning_counters snr_iio_freerunning[] = {
 	[SNR_IIO_MSR_IOCLK]	= { 0x1eac, 0x1, 0x10, 1, 48 },
 	[SNR_IIO_MSR_BW_IN]	= { 0x1f00, 0x1, 0x10, 8, 48 },
 };
@@ -5238,7 +5238,7 @@ enum perf_uncore_snr_imc_freerunning_type_id {
 	SNR_IMC_FREERUNNING_TYPE_MAX,
 };
 
-static struct freerunning_counters snr_imc_freerunning[] = {
+static const struct freerunning_counters snr_imc_freerunning[] = {
 	[SNR_IMC_DCLK]	= { 0x22b0, 0x0, 0, 1, 48 },
 	[SNR_IMC_DDR]	= { 0x2290, 0x8, 0, 2, 48 },
 };
@@ -5480,7 +5480,7 @@ static unsigned icx_iio_bw_freerunning_box_offsets[] = {
 	0x0, 0x10, 0x20, 0x90, 0xa0, 0xb0,
 };
 
-static struct freerunning_counters icx_iio_freerunning[] = {
+static const struct freerunning_counters icx_iio_freerunning[] = {
 	[ICX_IIO_MSR_IOCLK]	= { 0xa55, 0x1, 0x20, 1, 48, icx_iio_clk_freerunning_box_offsets },
 	[ICX_IIO_MSR_BW_IN]	= { 0xaa0, 0x1, 0x10, 8, 48, icx_iio_bw_freerunning_box_offsets },
 };
@@ -5838,7 +5838,7 @@ enum perf_uncore_icx_imc_freerunning_type_id {
 	ICX_IMC_FREERUNNING_TYPE_MAX,
 };
 
-static struct freerunning_counters icx_imc_freerunning[] = {
+static const struct freerunning_counters icx_imc_freerunning[] = {
 	[ICX_IMC_DCLK]	= { 0x22b0, 0x0, 0, 1, 48 },
 	[ICX_IMC_DDR]	= { 0x2290, 0x8, 0, 2, 48 },
 	[ICX_IMC_DDRT]	= { 0x22a0, 0x8, 0, 2, 48 },
@@ -6314,7 +6314,7 @@ enum perf_uncore_spr_iio_freerunning_type_id {
 	SPR_IIO_FREERUNNING_TYPE_MAX,
 };
 
-static struct freerunning_counters spr_iio_freerunning[] = {
+static const struct freerunning_counters spr_iio_freerunning[] = {
 	[SPR_IIO_MSR_IOCLK]	= { 0x340e, 0x1, 0x10, 1, 48 },
 	[SPR_IIO_MSR_BW_IN]	= { 0x3800, 0x1, 0x10, 8, 48 },
 	[SPR_IIO_MSR_BW_OUT]	= { 0x3808, 0x1, 0x10, 8, 48 },
@@ -6393,7 +6393,7 @@ enum perf_uncore_spr_imc_freerunning_type_id {
 	SPR_IMC_FREERUNNING_TYPE_MAX,
 };
 
-static struct freerunning_counters spr_imc_freerunning[] = {
+static const struct freerunning_counters spr_imc_freerunning[] = {
 	[SPR_IMC_DCLK]		= { 0x22b0, 0x0, 0, 1, 48 },
 	[SPR_IMC_PQ_CYCLES]	= { 0x2318, 0x8, 0, 2, 48 },
 };
@@ -6744,7 +6744,7 @@ static struct intel_uncore_type *gnr_uncores[UNCORE_GNR_NUM_UNCORE_TYPES] = {
 	NULL,
 };
 
-static struct freerunning_counters gnr_iio_freerunning[] = {
+static const struct freerunning_counters gnr_iio_freerunning[] = {
 	[SPR_IIO_MSR_IOCLK]	= { 0x290e, 0x01, 0x10, 1, 48 },
 	[SPR_IIO_MSR_BW_IN]	= { 0x360e, 0x10, 0x80, 8, 48 },
 	[SPR_IIO_MSR_BW_OUT]	= { 0x2e0e, 0x10, 0x80, 8, 48 },
-- 
2.45.2

