Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794409908;
	b=OTRaVEqRHIg23IHvowytzuXnF2u5V3hOtqwZltOKamcWBc0clNSROMjK9+mIru1lZ4s1
	 W5nj9z203+y+dCP0zYwTIRyNw9VNvTfA8t/s3DLJ6xd3haqoHUCWeKW8xDjpIacGUG7h0
	 1LEoNQYrcrB93ON3tpAjubbD3gLvTxTfbgK6x5UJKyvwQ0tP/H1DkkCqecn67tIuh8BP2
	 +Jk9qNSzpQau3+m5RxxYxMs1sN9JqVJ0CR1GYCL42X2x31SIMBmCKZ/YwdYhLl5D4JBNe
	 lYq+vheKSGfmUWVCbTYVbV+HZqr3N/vUdKga0ajfALHoiMPsdqPkutTH8D3GoDdLP8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409908;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=iikDelh+QqG8oDwjkU5EIhG4J3Ekj2l/k3ZKxWtsExs=;
	b=vhA9hOAGFaoJLwzQBXYtZnCCQCnvdY5FYNDi7y/bwVTbiRNMnVq+XShX1q0OhxAGz845
	 toDI1nrAet3cUijZnpXlZ/5XPq/KGW7OrVKoEgGbJZI/MPT/zgfptf4DhOuNsBHeXh2eU
	 YU2Ra/RFeXJLmCqoZy3Mi7SIlSPhRfcm2Ln8bX+MsDyQYvhNbAfQjG168RJz8iuW0E75n
	 3HIWGz7lEmRicTsJMeDafKaOvE1GsKy95eQKKjMqdBOI6eGChsHnMIkmctN5SC92I85rz
	 evGkzPqCrduwkOBZl30uA7Ld/HsekFZ8t1GwiGXiLh2/Z7dnC7jUuMBZTXaU+UAPTrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BmLpAexw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.37
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011037.outbound.protection.outlook.com [40.93.194.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2153606A321;
	Wed, 11 Nov 2026 15:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2153606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BmLpAexw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgaTRkkOhmDW/pWj2lZh7aX0GIx0BJDwlzHDp/JcgS2DX3mjcALOtmuF/rhWcvhsaTPoQ/wZ/liuIyg+/mwCzicnHsPYEtz61uceyNtdvG0jbIjCAZShQs8AJ13BGZGRQYvcFzCuSy87KBhQwQP0agHvSxhvE34XcsUmmFD1RPcEnsNBgihLVHPAyhURFnvSwBgVlbmlTJYS+7rfyqaJjFPL+8PiLHFvstdS8hGWxGoNaZxPFbrOJm9rnx2o9GaJ6ATcOqiRJB4iU/XverctWx45ID/dTSsr2zd2CAm70v8aXFhA8bwpyv6vJGo5E3p8AaDD/r8UUrQOEQYBktfuSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iikDelh+QqG8oDwjkU5EIhG4J3Ekj2l/k3ZKxWtsExs=;
 b=SVW3rwfJcXIgvtFJcHT83WHWOMIUfZRf2Fib+IMqCP3IB3kV1uvDMp7huhxSxU9csGxns40z/Iob+4D+Um3i87VOybyYypwsb+0sIuye/Azxlo9liiHfT0BQtxFmSlfZlz7AwT1dECeeUdIJ0vzFrP2p3Y7T6B0/00XaS9YnvJEoAwEOBJFwykav8wiPmCfrnZjvkgsQVvuDvRaUiqwV6keL0fdYvq0dzQulEueVtcrPLsI2jTTgo86cVQhlHlrTt0ao/PueNIsDPNYPTrL67dFdAFdhdrUxvIKAIA8HJPWx0qJ9ChcHgSGCIfR1MhFV9whkVBqw7Iybb+nf03SvTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iikDelh+QqG8oDwjkU5EIhG4J3Ekj2l/k3ZKxWtsExs=;
 b=BmLpAexwj/H62ElhWa4ZmhJSZ8A2J38ZtndK/ji7urvVwrU1b/y18PjRc2nHx4FnM6o34DhJ9WRG1w6W+M8mrr3Aqk1yQKNh47ZJA/HnCWYxNIQXaX2hfvtytpkkMX1nh5p36Ed9Z5kdUUy6OwaMDvam5xcnWZ9kchui1f3fcMA=
Received: from CH2PR15CA0002.namprd15.prod.outlook.com (2603:10b6:610:51::12)
 by IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 15:11:37 +0000
Received: from CH01EPF000BE944.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::76) by CH2PR15CA0002.outlook.office365.com
 (2603:10b6:610:51::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 15:11:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE944.mail.protection.outlook.com (10.167.244.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 15:11:37 +0000
Received: from ruby-9366host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 09:11:34 -0600
From: Dhruv Gupta <dhruv.gupta@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <tglx@kernel.org>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<james.clark@linaro.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhruv
 Gupta" <dhruv.gupta@amd.com>
Subject: [RFC PATCH] perf/x86/rapl: Fix a bug caused by overflow timer being calculated using a 200W Max TDP
Date: Wed, 11 Nov 2026 15:10:50 +0000
Message-ID: <20261111151050.329724-1-dhruv.gupta@amd.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE944:EE_|IA1PR12MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: f2cab229-f5aa-4c34-a860-08df400614af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700016|23010399003|10067099003|260925021911599003|260925022911599003|260925021311599003|56012099006|11063799006|261021121427099003|261021123027099003|261026140227099003|261022105027099003|261026121527099003|261028144727099003|261102123227099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4ReYn5aiF/c0tbMIysiygSUVpFPwEr5CtLzKUwRhzt3PJEpbVNikFQgFDkJq2vG1CkjnTYYiG0bxXjfox1n2afoeB/xzysvxlie5J0aNUerHKDttHEaI6qlXfE+2LnBaqLLSY2LCbmVXabALQJia114bIjxZfQX+XWYEvfBAA8ceC8ilie546EM5RxaaHM9bF7iteNzdPv4/NY7gitTd+QPqrWkePrqoEC1vPHmgIm+Dy+VV+l1HtCOZtVJQGDUdSOmyFX4ckG+4TYFCeJfo5ro3C13fZCQ1sX9QlWCPSbTyELV4KI9wAHEWQvrwQgFsnME4LOyBPj0lJAHMD7ev8gJd/zYsvv6k0tfWUAMGyiC36YMlwnYTw2kSYmPDexMIKDYIatzfPzQrF7Q6mCiguj3CI9VBhemYAza/mqi90Jpg3q/6ZM546HVmko124QniH842JwywGHDLM68hGUbyrg2dHXGL1VE6AKkLFUrQtlOtVPVrVAA/BVI0K4y6cIE051lV7MAIzJIbSFfCvAocPuR/TTrCgcpZqkRoB1Yul7V/6GoEKYjtXG+g8SqeuQX5d4F3WjkX2UqxJ3TQKAWPXkG28qfcwdE5DLGzCg2abVQmqYnQRNfjtehBGZQrTZNeqSQ9abmYRY8Lu0rx86Jt8OSeeR3aCkVtrvbgcPUK53tP+BpcEgFdaI+ar5V+Rbghe1mR3DLFUOgfEMASIimD5A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700016)(23010399003)(10067099003)(260925021911599003)(260925022911599003)(260925021311599003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261026140227099003)(261022105027099003)(261026121527099003)(261028144727099003)(261102123227099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PqlvLr+/oueBXKwTBM3y8ozru3uABu4Tji40o7jdq+ob5ATh1U1Z8J76rjlPP5kO63UtIHE0j8fxAVq5wPZkWdtHm3Flif/7d4dR7/yCwbEOjut7c7+EY/tPweDN0XdgzS/5IFXB/Jj8I+vj4b1+ySiWl+O7to3RDYMnDY8dSO4S1V5O8ajH1+kmPPapysBwSR2PgDoKWohp4bfwEEw9RkIVSHUCCPqr+5Kd6+wr9X2OoAQRMOEmFcYOmOdT/e3O41NxA19EFddQdp8oHWj4ncgxlrz3Fqn8d+IHLhzV/Sn+66IicYQl5nUo4VHlX2ykeU98fbafb7YL6NgLR/AMD85Xz19eZwm0QnHxVrJv34Mb8jPGmuNieQng5ozMBXCtW1CtYfODjJLa+2/ZodWY0fn09k91up1VG6x/Ru+MuhdyEFepQYnQ2zGq6L0sLifD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 15:11:37.0370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cab229-f5aa-4c34-a860-08df400614af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE944.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7736

The RAPL energy status counters are 32 bits wide, so the PMU uses an
hrtimer to fold them into the 64-bit event count before they can wrap.
rapl_event_update() sign-extends the 32-bit difference between two
reads, so the counter must advance by less than half of its range
between updates. A larger advance is treated as a negative delta and
the event count goes backwards by 2^32 counter units.

The timer interval is the time it takes to use half the counter range
at a reference power of 200W. Any package that sustains more than 200W
between two expirations therefore loses energy. This applies to every
energy unit, since the interval scales with it: with 2^-16 J units the
interval is 163.84s and at most 32768 J can be accounted per interval,
and with 2^-14 J units it is 655.36s with the same 200W limit. Many
current server processors draw more than that under load.

On an AMD EPYC 9654 (max default TDP 360W) running stress-ng on all
CPUs, the package draws about 346W, or about 56 kJ per 163.84s
interval. Over an 1100s run, "perf stat -a -e power/energy-pkg/"
reported 4294882289.81 Joules, i.e. -85006 J, while reading the same
event every second with "perf stat -I 1000" gave 373745.7 J. The
difference is 458752 J, exactly seven wraps of the 65536 J counter.

This patch raises the reference power to 1000W. With 2^-16 J units the
interval becomes 32.768s, and with 2^-14 J units 131.072s. The cost is
one MSR read per active event per package per interval.

With this change, the same workload run for 300s reports 104062.71 J
with plain "perf stat" and 104062.7 J with "perf stat -I 1000".

Additionally this patch drops the hw-unit check and the 1ms fallback. The
unit is a 5-bit MSR field, so it is always 0-31 and the branch was
always taken. Also the timer is sized from rapl_core_hw_unit instead of
rapl_pkg_hw_unit[0]. Both are filled using the same power-unit MSR field
and are identical.

Signed-off-by: Dhruv Gupta <dhruv.gupta@amd.com>
---
 arch/x86/events/rapl.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 8ed03c32f560..43ac9e1c98b4 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -106,6 +106,7 @@ static const char *const rapl_core_domain_name __initconst = "core";
  */
 #define RAPL_EVENT_MASK	0xFFULL
 #define RAPL_CNTR_WIDTH 32
+#define RAPL_TIMER_REF_WATTS 1000
 
 #define RAPL_EVENT_ATTR_STR(_name, v, str)					\
 static struct perf_pmu_events_attr event_attr_##v = {				\
@@ -639,16 +640,12 @@ static int rapl_check_hw_unit(void)
 
 	/*
 	 * Calculate the timer rate:
-	 * Use reference of 200W for scaling the timeout to avoid counter
-	 * overflows. 200W = 200 Joules/sec
-	 * Divide interval by 2 to avoid lockstep (2 * 100)
-	 * if hw unit is 32, then we use 2 ms 1/200/2
+	 * Use reference of 1000W for scaling the timeout to avoid counter
+	 * overflows. 1000W = 1000 Joules/sec
+	 * Divide interval by 2 to avoid lockstep (2 * RAPL_TIMER_REF_WATTS)
 	 */
-	rapl_timer_ms = 2;
-	if (rapl_pkg_hw_unit[0] < 32) {
-		rapl_timer_ms = (1000 / (2 * 100));
-		rapl_timer_ms *= (1ULL << (32 - rapl_pkg_hw_unit[0] - 1));
-	}
+	rapl_timer_ms = (1000ULL << (32 - rapl_core_hw_unit)) /
+		(2 * RAPL_TIMER_REF_WATTS);
 	return 0;
 }
 
-- 
2.43.0

