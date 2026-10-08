Received: from va-2-113.ptr.blmpb.com (va-2-113.ptr.blmpb.com [209.127.231.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF5831F99A
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Oct 2026 05:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791436963; cv=none; b=KheWRuJC9jbU6PqstlWDUq09TOUubphXFNK6qpE84jpyEcz7CQ3eYmxT5QlNln6fGJ1MMFbMVIVIKyw0nOon2RV7di8Qx2dLVdBeP8f8fbQFE+0Y+mrqt6r9D14IgnVKRyvEvLr69lrLZGkcFJ2uvG3p68yYCcCL0qq7HJXa7G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791436963; c=relaxed/simple;
	bh=fskBAk7DodstGk6bvofIn3sTwHBA47U6PTjs/Rg4jto=;
	h=Content-Type:To:From:Message-Id:Mime-Version:Date:Cc:Subject; b=ZWaucpa/nmFW9eCjUsJje4V7+Gj+K6ibtTwTGwLq//dn2PDviuxKMEEWlsKFW6TVl7ETYj9Kv8UnOuvNVhQ+Ka2ytOFB6Re+9pm7XledAsONVf3m06Sex6JIaxWDMm/F9GIfaCDaLfUJSKA6CyZBJS42bUHoE/WqPhLghq4GTRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=afQDiwwL; arc=none smtp.client-ip=209.127.231.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="afQDiwwL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1791436949; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=OC/8gcm378zdCLGBCsxZGDMgTVsIaJlN9sB1GbVS2X4=;
 b=afQDiwwLVUn0sX3WReZyjPPyqLDqub819hocoTBz2+LrQwDlWVwxjyvoE+tnm5w5cZi2Nx
 ZXflCWe7Zl7omd9Fk4VcYM1wehtpVMikbkaPTX88aCRF5XYleNChRkSQCCwTIrtDR0nqtr
 +d74dQ5RfAAnlwfBtfZGFRyNDrNATaEy4gv3xUtBtdGFyciSLPts5WEMZnqQU26b1vRTMW
 sq/OBvpfYUNRRE3IBc2+26hiCF9urEH7ktXrzhf0o7Li5HBhPV9lMnWfBz73ZeVlIZTU55
 VHzCUZobWrd+sy8h+x7qKXgsyNBwQNpLiFqyeVb/fk1ZHnsrKXevJzTJhoQtew==
Content-Type: text/plain; charset=UTF-8
To: <peterz@infradead.org>
From: "Guixiong Wei" <weiguixiong@bytedance.com>
X-Mailer: git-send-email 2.55.0
X-Lms-Return-Path: <lba+26ac72893+334426+vger.kernel.org+weiguixiong@bytedance.com>
Message-Id: <20261008051953.6293-2-weiguixiong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu,  8 Oct 2026 13:19:54 +0800
Content-Transfer-Encoding: 7bit
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>
Cc: "Guixiong Wei" <weiguixiong@bytedance.com>, 
	"Ingo Molnar" <mingo@redhat.com>, 
	"Arnaldo Carvalho de Melo" <acme@kernel.org>, 
	"Namhyung Kim" <namhyung@kernel.org>, 
	"Mark Rutland" <mark.rutland@arm.com>, 
	"Alexander Shishkin" <alexander.shishkin@linux.intel.com>, 
	"Jiri Olsa" <jolsa@kernel.org>, "Ian Rogers" <irogers@google.com>, 
	"Adrian Hunter" <adrian.hunter@intel.com>, 
	"James Clark" <james.clark@linaro.org>, 
	"Thomas Gleixner" <tglx@kernel.org>, "Borislav Petkov" <bp@alien8.de>, 
	"Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, "Zide Chen" <zide.chen@intel.com>, 
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf/x86/intel/uncore: Fix DMR CXL CM invert filter

The DMR CXL CM PMU places its invert filter at config bit 21 and its
9-bit threshold at bits 23-31. However, dmr_uncore_cxlcm uses
GENERIC_PMON_RAW_EVENT_MASK, which covers the threshold through the
generic bit 23 invert field and bits 24-31 threshold field, but does not
include the relocated invert bit. As a result, uncore_pmu_event_init()
silently clears bit 21 and inv=1 programs the same configuration as
inv=0.

Add bit 21 to a DMR CXL CM-specific event mask so the requested invert
filter reaches hardware.

Fixes: 6daf2c35b835 ("perf/x86/intel/uncore: Add IMH PMON support for Diamond Rapids")
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
---
 arch/x86/events/intel/uncore_snbep.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index a97cd029db366..1b460cf27a10f 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -474,6 +474,9 @@
 /* DMR */
 #define DMR_IMH1_HIOP_MMIO_BASE			0x1ffff6ae7000
 #define DMR_HIOP_MMIO_SIZE			0x8000
+#define DMR_CXLCM_PMON_CTL_INVERT		BIT(21)
+#define DMR_CXLCM_PMON_RAW_EVENT_MASK		(GENERIC_PMON_RAW_EVENT_MASK | \
+						 DMR_CXLCM_PMON_CTL_INVERT)
 #define DMR_CXLCM_EVENT_MASK_EXT		0xf
 #define DMR_HAMVF_EVENT_MASK_EXT		0xffffffff
 #define DMR_PCIE4_EVENT_MASK_EXT		0xffffff
@@ -6696,7 +6699,7 @@ static struct event_constraint dmr_uncore_cxlcm_constraints[] = {
 
 static struct intel_uncore_type dmr_uncore_cxlcm = {
 	.name			= "cxlcm",
-	.event_mask		= GENERIC_PMON_RAW_EVENT_MASK,
+	.event_mask		= DMR_CXLCM_PMON_RAW_EVENT_MASK,
 	.event_mask_ext		= DMR_CXLCM_EVENT_MASK_EXT,
 	.constraints		= dmr_uncore_cxlcm_constraints,
 	.format_group		= &dmr_cxlcm_uncore_format_group,
-- 
2.50.1 (Apple Git-155)
