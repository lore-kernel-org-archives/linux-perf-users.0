Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0513128C3;
	Fri, 16 Jan 2026 03:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768534550; cv=fail; b=lEy4g71jjUW3escXyBT026izj/pyF09NNvswX3HvKKHNOGkCC1G+VQZ99ZMNl01yfen19sOfW0OZXc43oAVBHYzoioi5w5cGr27ZyLRzqxJb3rjaqo0tZl3OJAKh8j7l9mmc6cJ8ItQHCbDK55Z2VhFz/qE2vzqI0mqK+vW1LZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768534550; c=relaxed/simple;
	bh=3I7jLR5QUuSUMjcpRkZF8CBTFEGM8VxwGGnb82rBpTQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHleNCGhYUPHfFTLt+1E7yjFQrANn4ep+sjzQtE2MF1LAofGsVyvOdxUPtWqLciTLML9WGR4gncofQVbr5V5owR2Wvk9IBYMtQabxfqvx+P1DKDuaAcNqy3iJXftEFnQpKlRdsrOTdMBSB8+LElivY+RSOPB3fKmZOyGT/u9RZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YmD7T/0W; arc=fail smtp.client-ip=52.101.52.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YmD7T/0W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eaarz+E8RGopqddvcg5ujpEGNVmRmfLZrPVxaZd2yrg7lBXYkcQMuP5tl67Xi7U0at+UE2J7hLs8DRvFQEo1+30rRPcR1Q4NlNsKGMVeyPa6j1IhJ07LcsSTgIe4j80eFXhHJp05a/WZIo0Z8v4DC068ukz4cUZYXqA5ksL/3n+9OW6hbLYFFodZP7U7/n8KsnMeX5YMhx1XqoackmvJ8loiQgGE+GTQ8N6msVIodET9+UHvfGfmmGucz8eog4/7i+XHH63tADED52aLFRL7b3K+T8LzA4+H9VVN4wk5IRSysp67pll9tPXhUBSAa9Amw+FkK0Im8d3G4TQhxMKxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2YuSBhhGaB6xUBp1FgWSzQbJy5JUfQDlVp4OjvxOL4=;
 b=Tc6hDY1evdSf7d4obfAhmUvIsV/F6UWaorxf/tIfdr3a9pc5vb6T6LqJVB173Eevg1fjv7WrkXxS1T+3LaEn+lDUiSM2GawTCy9xA/YTEwg9GdSrAHkqN3upI504BS+t9/riYUBVEUAQks5yh3svgjAYFomREVN+SenuGqsjEkIi3DgVbjW66J0eNyUi3YEaGDhaaJluQ0ngfJsU34WgINQs/+hW/GzL5stk/PgsKEaNycpZ966S0jvBTP5kcdznLxUIPOIt65xwKdg0OpH5I/UPSqKYBhdiLx42tNj3BYSxJ/+eurmzOGgUrMIhsn+aOlWfPkA+PW85RCWZx3x/3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2YuSBhhGaB6xUBp1FgWSzQbJy5JUfQDlVp4OjvxOL4=;
 b=YmD7T/0WHMtycc87YGaiPaKXemqLUiSoq61V1bU4jXuRq9tv5EUXr3mapexUrO82cQZuUm2WEiDU51ynRz8phbMAUMmFToVrXUhpvgVCs6/ZpB+dI/O2I4FDvr4BW+Rj/WSaQ8ERCmgGAwerHspXi9oZKFXZlBfP1T6ReLrxArY=
Received: from BN9PR03CA0482.namprd03.prod.outlook.com (2603:10b6:408:130::7)
 by SA5PPFCAFD069B8.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 03:35:44 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::65) by BN9PR03CA0482.outlook.office365.com
 (2603:10b6:408:130::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Fri,
 16 Jan 2026 03:35:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 03:35:44 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 21:35:39 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 05/11] perf/amd/ibs: Define macro for ldlat mask
Date: Fri, 16 Jan 2026 03:34:44 +0000
Message-ID: <20260116033450.965-6-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033450.965-1-ravi.bangoria@amd.com>
References: <20260116033450.965-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|SA5PPFCAFD069B8:EE_
X-MS-Office365-Filtering-Correlation-Id: 89fac29c-f62d-4050-034e-08de54b05486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VZXHQkuW9LpAppVatlOPJgrrRW5jDb6eMJiB0Yu6dP858P4gKzgJXnZYni0b?=
 =?us-ascii?Q?HXOogu39T2o/BkrLFDXChcurx4e8dqlmXfcCcZQOw7HlLiK6ZDyc/yzcSbRe?=
 =?us-ascii?Q?F6+C3jK27fkxMEC3wDeBDDH+1jL1qVrZKw0fOD15iR9KlePqxoAhCQ6quMNv?=
 =?us-ascii?Q?rKNi92rXIVeukk7/OIU0QEev6kHxk7Q6084P9AiS3NF+C8oUrSgizZPLLEiX?=
 =?us-ascii?Q?vAti6/lEkCblWfeW00UiI6eWIJxHRTKzxYh31E/dsR7KLHFXS8UkmqXKBE1k?=
 =?us-ascii?Q?TgOWYxtcAJHfNR+1i8oxnJgiKWLuW7D0Ja/MpByDzHmfo991PyqGyLV5m07p?=
 =?us-ascii?Q?rybUfTB2UnMdkIiqIBgFeGRAtZzTHfdH2i+5s5jKwg6QN7gYKBaQVZA0U9HN?=
 =?us-ascii?Q?vQUkrqAWlOiq7yn1jp5VCKunw2mBUUeRz0OoSf5z9ny3YW2sLgi5rqh15Us0?=
 =?us-ascii?Q?IKK+qBiBt/lc82j0xnVrcpDOAblvCRjhLj+POLICTvWeLG2x6alW6gGNKsMc?=
 =?us-ascii?Q?wQZMPQuFFf2i4Iz6XoMk3GVZGkOefHmScOoL2jayoc6LGOgIwAEpnrLkPP7Z?=
 =?us-ascii?Q?0ZLepUOpf6WvOWYD0V1Byu0ICwPnYTzNIofzO+Vp1K/2FgCuWqNfrbVfFXas?=
 =?us-ascii?Q?28iETEa62ddofjYnim06gY8SZ9XGk3nlYeaJyYD2KBxJE9aetckbbLQBA845?=
 =?us-ascii?Q?WwMmIE/Dkkkk3f0oECgyATmedUf7AGa7aPYYk57h0AfomLTJCOHgxXfahidJ?=
 =?us-ascii?Q?kgr+gBR5lSdhDFXrq7wdNy7jP9Vmcx5BdemwJJH2eY40OM26Vo4/nKDnmivS?=
 =?us-ascii?Q?R4GM+GQM+5A2yxM1XVqgDV6QIU05J/oHK957Ovaw5g33njUm13kOYePMEiif?=
 =?us-ascii?Q?GplAIkRCzEOff8TrqvlP40ZdhMRgWfY8i7A98rA6/GYhpoIAbRoQpK3cykRe?=
 =?us-ascii?Q?5OttpVSZrWhe3fqeu2BnkiuV2Ov0N3r07o+kkY2Jw6FMVFv8LQ81YvXYi/fR?=
 =?us-ascii?Q?ZcW3TIkgZT3WU3NIj3ajp5FMWUgtHgSmRh8tKa3P/9rRmgZf7ZBdM+ACBTw0?=
 =?us-ascii?Q?IJpgMuBJ5zr8HUPh9AToTMqPhStk6FpsphQ4tbvy7aqL+TW8iUKi+DYKrdW2?=
 =?us-ascii?Q?kVyuVi2+ANkAoErl7ElP99gTXCv01iM3iibSSKaViIDCEmgyBJRSkagln/lB?=
 =?us-ascii?Q?qKxjtTc6dymq6ABqJ9PmQXq4XeAJW7f0b/nyGtDsbY0CeTwsbb4ash4MlcIf?=
 =?us-ascii?Q?JjTLpxFWe+bng9UAOfk3PAPc2Uddi95G1szPxVnY76EUuiOgROpWFDSbLvyp?=
 =?us-ascii?Q?iBSAYN6XkBKT8TKmSPUpbqSgJAOIFGAasMaApgluaDcpuH+/XYlG9xgyT35x?=
 =?us-ascii?Q?l+SvM2eRPfXY7oA8ueXZQTq95QTcZa8UEgMmrfbHG1sIUWVnIhu44MhKVxrc?=
 =?us-ascii?Q?92Wp9kyHq8Z7ZdDxxGWfyexBskuFKTPYaohdbi66JmShoDRrYYGEusSYqdCC?=
 =?us-ascii?Q?snwo5skOM4QuZdj/kKPlawTjnaVXARdbq2i5rnrZ6ALPf49ldFt+OCK/fR21?=
 =?us-ascii?Q?NL9EbKCKlIKqUjjewOm0H2kuJuHbhp8lzYWn+m1jH1Iv7DFvHc/0H1PNRjxv?=
 =?us-ascii?Q?d8fX0zd//4QYEEiOhucy+fbi0eYi9KM6uteJRmfx3VV+qXRT/S8M216Xg2E3?=
 =?us-ascii?Q?f1lrwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 03:35:44.1800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fac29c-f62d-4050-034e-08de54b05486
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCAFD069B8

Load latency filter threshold is encoded in config1[11:0]. Define a mask
for it instead of hardcoded 0xFFF. Unlike "config" fields whose layout
maps to PERF_{FETCH|OP}_CTL MSR, layout of "config1" is custom defined
so a new set of macros are needed for "config1" fields.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 27b764eee6c7..02e7bffe1208 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -32,6 +32,9 @@ static u32 ibs_caps;
 /* attr.config2 */
 #define IBS_SW_FILTER_MASK	1
 
+/* attr.config1 */
+#define IBS_OP_CONFIG1_LDLAT_MASK		(0xFFFULL <<  0)
+
 /*
  * IBS states:
  *
@@ -274,7 +277,7 @@ static bool perf_ibs_ldlat_event(struct perf_ibs *perf_ibs,
 {
 	return perf_ibs == &perf_ibs_op &&
 	       (ibs_caps & IBS_CAPS_OPLDLAT) &&
-	       (event->attr.config1 & 0xFFF);
+	       (event->attr.config1 & IBS_OP_CONFIG1_LDLAT_MASK);
 }
 
 static int perf_ibs_init(struct perf_event *event)
@@ -349,7 +352,7 @@ static int perf_ibs_init(struct perf_event *event)
 	}
 
 	if (perf_ibs_ldlat_event(perf_ibs, event)) {
-		u64 ldlat = event->attr.config1 & 0xFFF;
+		u64 ldlat = event->attr.config1 & IBS_OP_CONFIG1_LDLAT_MASK;
 
 		if (ldlat < 128 || ldlat > 2048)
 			return -EINVAL;
@@ -1302,7 +1305,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		 * within [128, 2048] range.
 		 */
 		if (!op_data3.ld_op || !op_data3.dc_miss ||
-		    op_data3.dc_miss_lat <= (event->attr.config1 & 0xFFF)) {
+		    op_data3.dc_miss_lat <= (event->attr.config1 & IBS_OP_CONFIG1_LDLAT_MASK)) {
 			throttle = perf_event_account_interrupt(event);
 			goto out;
 		}
-- 
2.43.0

