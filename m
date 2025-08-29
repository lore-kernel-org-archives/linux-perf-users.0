Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012038.outbound.protection.outlook.com [52.101.126.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB65B284899;
	Fri, 29 Aug 2025 11:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468115; cv=fail; b=m8E9Gecy9+t32qbAHaNrVgY0iQSrEc0IcIQg+GQoZZvf3sAh4i3HM9XzQWGr0VJnwtCrA7r/N5Z//2fDdLPDEXu2PcHFAfiI/Inn52ud/HT4XwcT5e+TzFHdDEYbv5P7s34wDiGpUYrnzWsVOhUVzb9lH77Hwro8PJiXgvpnIqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468115; c=relaxed/simple;
	bh=CRJhTx3WJOPuhf4p5o5vR71+/WZm6pLrxQOPPse5pKE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZVz4HWlNncjWQgsI0bE0pIOcffmrD6LxX/efa+YDtrlIn7j3fU0NUrLVkm2jfko2j1zs04wtsUSye7Z1sY45t8Y0+EMRqq9/SMGTrvzcPOgSgee0yXpcgF7hI41z37KcBUEpnfQKuTu2S3c1WpSW/xASpNVpsNHfOq1Tz/1ANAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=LPHzWeyB; arc=fail smtp.client-ip=52.101.126.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="LPHzWeyB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neqASQbEk57p81qqLTY4PmoIqyDMwnN+Iau8b6uzr/eCXltGZlqxtlVd08kdFFVrLESeWqhmbye5Wni+SAYEkfGj6fH+8N9wCsPpkG6Qq6H16l8Dlf4vV293nptAef9xDfvf0EY1seHyaSTqplSIdFVauuUdsnxsZtTPwBPX+8vsht2bSsxJ6gwF8hM+91sS/NIqcewoPLa1fXIrDCdIdS27KHGLLWcVdin9goTW5coJWtqHBpOPmaYfbZDAPncl8d61xMTxWBc9Hn2mocR2ieN+JoRf5CinYNE2U0iO6JTn/UHg8khyh0r2UvqI+xfoDjrkWN0D4EGlcsyhBPaFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fsluq+jyFvHM5NBajfmsTkVdNS4AZPXnW+rRuiCqWk=;
 b=ZIIBo41/IPs7jz4Z903hEvXR+Ow9B632sUpyiqzSeFo9MUID6T1WoONQVK7290qmCKxP/18Y++XPqDw4GvbtxvlziibgKJubTgQhHHeEzfXpimsxwDbCx8/4h3o3sXqQT33vGjVONv15vJwQoM13/ggX700e17va9ZYLbP8cZJXqYSKlVN3a7ka3og8F8ry36zLpl2XNgPai7eBhtHvGEU5EvtnyxtOlq1PMVSfFdSYXSvQJHu4afepiKeJk92EibLI+345cvJtFujkXtmKcOGhe2Gz3+sxHHS2xjOue9ESJB6tpNf+rOinBUWeZ60oaO+IbivbtyO2Vyf1xD9AxLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fsluq+jyFvHM5NBajfmsTkVdNS4AZPXnW+rRuiCqWk=;
 b=LPHzWeyBtwd8TuohymA7yXnXDVe8RteZM6sAowUPUg/pi8COQAR0wk1w69mHF4cn741w3FEfW8G59UHkhKtkg4dq9QVeTEIIhaKWDTZLxpdRfZQZzAmYRcWcPZC+9EW2sVzA9gy2jjh+J25kbCcuISy4DwYPMl3zdDwK63cCwwlWTXpSzu4fsnnvi/M30JtEzdZXYwtdVTD1JtAQboX82N1swo5r4PEOu0+SIJw0P0fr32C+4sGsXxKZneRS0KaoytA4jP8zJZlhkn2bagBzAUqUXBaDgwU/hOQCynKWOyT02UsLsSL6OiWs8UNjOwykVAbgVzNiu6YpjFvndFggJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYZPR06MB6770.apcprd06.prod.outlook.com (2603:1096:400:45e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 11:48:31 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9073.014; Fri, 29 Aug 2025
 11:48:30 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
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
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] perf/x86: Use guard(mutex) instead of mutex_lock() to simplify code
Date: Fri, 29 Aug 2025 19:48:16 +0800
Message-Id: <20250829114816.650576-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0006.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::11) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYZPR06MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: aaad6001-6a61-434c-f865-08dde6f1f921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RI+LuEWkI7sluAwEl9N+rzrTr+FvD2gd7Pv5gN/8x83hM42MGkhn1h+JI+Md?=
 =?us-ascii?Q?zaacgWmU9qCYlnGwmDyKvA09xEV1oe3ZvoBDlrGvYPXj0qM1gKOu+9kaWyRm?=
 =?us-ascii?Q?jyxhOI4PQKkYT70owO0JqpQq5SGlr0DVMvuCtadS39ra9YdYVOdMcmer3LVX?=
 =?us-ascii?Q?I1ufe5LSUEyiLGaJl8envNTiMLgoochc8VJiTh6IBt8VWGqhvLOdnDjA1lNA?=
 =?us-ascii?Q?lYWBEx7KEiKLyHe0eNsdppCCW209x59c/4CkjZCagm3+7Pg36ZH8tCMygUAf?=
 =?us-ascii?Q?unRBQqRX5AOY2CQGij4VGybzfRYMlDLx4OFfKXHCdqjwocHvUZCrt+mx4CB2?=
 =?us-ascii?Q?qc0maYkcvZqbUiXCrJ8ZzvS3gp06x+s8xVN5Ax4hlG2xHeAYCOgQTqTxLS+h?=
 =?us-ascii?Q?TLVMOvLEPKrSuSStVPWtLRyj5zWkjJktB0SHpLSUJyvD8kT+FuUKE46TegxQ?=
 =?us-ascii?Q?RjiEWzlLLWb9xKqZv4BfZqCWr2pt8/m4rg+LxiqUjR2zZvY29hpiVoYZKSaQ?=
 =?us-ascii?Q?BTjQqMthHa0IkZTwRayMfw64gS+Wh8Pz9NPEg8g1LZoJwxKeIpXB5PwhHRvJ?=
 =?us-ascii?Q?7nz5gsZzBX2Khig1fin0tGqmL3XO6dQJhjpKbM/rufMfxhWEaa0LFUVxjIRU?=
 =?us-ascii?Q?KgzqAP8LxCZgXxO6OGOX01DgHzEQ04wDNIUBTJGhoMABjaxDCgOFbgu05kkn?=
 =?us-ascii?Q?FPyUAfUExfw4P1xKE4sVDJg3TUnraWqbpFSJNQ/S84RouhS2838e8MNDO4m9?=
 =?us-ascii?Q?93c3OxDVohFj/tS+K+38jk4/dD55zGooJ13akgYYB8iM+NDe3wiiJZeJIGj4?=
 =?us-ascii?Q?sZGK8QL6+HTxE7YZr0CCs69I5LfRZCaqDJpBBUSL9N5iWdEj3GJci27RUv8D?=
 =?us-ascii?Q?BIGVdT987jH3V4jDZXn87C/CNU25eXFVzQgdy8+I/1Wk6Q2nS+L1tlMONKxz?=
 =?us-ascii?Q?9FwbXqbVtRni/zLrxS2oENis/4iUP48oVhO5k07DeFjFNQnazCWAC/8wc37t?=
 =?us-ascii?Q?O7gripY4y9OVt/Wy0OJ97dTxOY5uD+/O53rG+iJc3RU6eUpvMAnLB2pBUFib?=
 =?us-ascii?Q?qK24tfYQfxICpluygnly6zFKFGwKlPvVj2lPMFh/b0za5aUsozFTXJMl5LM4?=
 =?us-ascii?Q?sbyxg9wVZFFhnEGIhzyUqQlV6nwlBEL5bLf+bBQHDmydZy6pTZdB8jPcsKIm?=
 =?us-ascii?Q?ZNC6uveOvRmv00ZI51+SXrXNBrS83YbyaPRxSz30yk0hFbqTFuUXVC70+Qpy?=
 =?us-ascii?Q?Zf/Tie4D7OJDBMnb/LYDlWR7ZOXllJfi4vgGxISOQUjOHpmO/ZaqAV/Dh+Xs?=
 =?us-ascii?Q?W69tan1v4rrXlaw5Pr/s2v+Iud3X+9AjDdh+qQl8oLTnTW+h3ZTK4y+Tm0aZ?=
 =?us-ascii?Q?jKzyQyhwtmXJIx4gEt+unAJFRC0GFMagkPlBbtWryqWlFlYFaOlxTDlj363+?=
 =?us-ascii?Q?z/lvDuaeHIM0JqSuzftwj26hfrA6ucJqw0eSYayR7FM6GPKVVaslXA2KPWdZ?=
 =?us-ascii?Q?Uh4gS0Swc07yHYo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L2ZHsaRIsyZ8uB41zwLw9Aal7v61pqbbjN9+r3hT3g1C3ysfSiJ7g5tnJcY2?=
 =?us-ascii?Q?QfYvphGP+7Z+RXzq9+rqpKjCbKtE755Si6pIHD9naCBUBrpH6JdiGZK/xCOl?=
 =?us-ascii?Q?X+hO4Z0GsA5KWGzN1UNAkB6fsBb/DoMEkIgudG7hazzGeM0lufGzEN1Of4Np?=
 =?us-ascii?Q?HYdaNnR+cNMOfmS+qGBBUkugnDEAkM+mSUFRFZqXe679bMPMwbZPMiCP5KIV?=
 =?us-ascii?Q?m/Np3sKznhUkPMFcYmc0Dz4UtIssvWZKXv+5rxSVJ/W72CzDQPEqzGcfi3K3?=
 =?us-ascii?Q?9uTzcPJtgt0qchgAyctpO+DV3Dh3fq8AnS/Fpm1G8eOVVyZ0PURmRZu37fQ7?=
 =?us-ascii?Q?vTYlSst0xEKn1B5Ds8RvQu6N8zJZajYialikfGNVoOVZqLVCGGv9nJVs6KPS?=
 =?us-ascii?Q?va7bNS8ybJf8m/R4KRNfN2KGIWVlfciTK7IttIVS2BUJruTzwlpsdadfdOG8?=
 =?us-ascii?Q?ROWxZ2t+9XTQ75B7ANWuOKu7RC+ZNm42j3vI/4iNQYdA03bfFssU8DGNCDwJ?=
 =?us-ascii?Q?8JeQGpc+t/AZCNyjWN5ekc+OYKn0hzQwPmYZazq0iyZ9YOo1MYxfTFh4Fddw?=
 =?us-ascii?Q?3V8TXBit2niysJlDqiBISijrGvpFeK2tTLXziaod7mrYm1u9W79X6rzugEVs?=
 =?us-ascii?Q?ggh7xJ81SQTdMXF8MxoOb7kJWDgorys+DMMVjslXXb8He3lg3v5WxWeZdwim?=
 =?us-ascii?Q?uzF5UDGVrCvBMmwh3J6zQ5eAlAePh734GY0KniMXkT8ggN6/l5FvH0IWYdGY?=
 =?us-ascii?Q?NiBaiCL2nStJEojDC5lzpCfC6J1nbjo5dVRVkHZkOhu13tZ17y0l5AtLqt9F?=
 =?us-ascii?Q?BTSuH/4Icd0a2DPJNlmy6b9Y1Rg5EngwoC4vBPLxJb2ktnLgkDPmQSlCvMOP?=
 =?us-ascii?Q?hDOSN86Nn/uiq6CjUBKW3dF0mx8iFpwWu31vFLFSDHX8M9xkk688u9FnZ7Dw?=
 =?us-ascii?Q?mcq7t05g0Wj+R/MkFlgepZ154pm/t3CQEy3aMoT7jaxKFP/eiGtJdpY//ghx?=
 =?us-ascii?Q?d/vhjE/ErSgHJ5n9VEI0N4LVRgudX3TwM9/nIZE6jOePn1tmPkzJrHjlgs2W?=
 =?us-ascii?Q?jliYQMUm77WUFU8NgdP9YpjCqo4SMvmtpFtJwWYZb1XH99whnNb7zS/9TwQk?=
 =?us-ascii?Q?IsGxJ14Aa37l0CTagT1uHHDQtnhNNLL/9JolXMFP4rx3U9knnpt56aUzmxS/?=
 =?us-ascii?Q?GkJZFjRY46aslCxKqSeRUgwrksABuSCVgKN3Naq/2i6Nn71z/YzOq1/CX3+h?=
 =?us-ascii?Q?Bentm+X6byGt2Lj53U/rfchGvaqqutFK+n8TVTxnkBIaVCNPmDmp8VQWLatV?=
 =?us-ascii?Q?w5ouq5U20WkIh0ROnUlV46iDsdMHo/W9U/E7dB+aYYKbh4GnbB0+lBFwrZl4?=
 =?us-ascii?Q?eJcniFa2NbLnHK2uBTvh4CUmM716myvj7ur+asVR/8SR/zejP4chSJk7sduR?=
 =?us-ascii?Q?b9gVV95rUY5/wQo5yiFHWySjqTfO2ub3ZNK9Oo+UAXVXGQFL5BuJMDo84NSz?=
 =?us-ascii?Q?WpS4ZiO/s51UtYPkrWzYV3O5bZvcKNg/taRPp8sc/F1S2ixxIO0FnpxnP/AW?=
 =?us-ascii?Q?cpwYXZF1VVz/fhvGeognNrLokai3CB/WY5pAroJD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaad6001-6a61-434c-f865-08dde6f1f921
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 11:48:30.5368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0CDPGsjI9V8iLIc2q6npRKDpu33YHSIGmXjyYWnqvO8Fm/ARF1sBP/QeuGjCtZzgMM3l4H9WaW4xY0Zeljiig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6770

Using guard(mutex) and scoped_guard() instead of mutex_lock/mutex_unlock
pair. Simplifies the error handling to just return in case of error. No
need for the fail_unlock: label anymore so remove it.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 arch/x86/events/core.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 745caa6c15a3..107bed5c9d71 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -411,7 +411,7 @@ int x86_reserve_hardware(void)
 	int err = 0;
 
 	if (!atomic_inc_not_zero(&pmc_refcount)) {
-		mutex_lock(&pmc_reserve_mutex);
+		guard(mutex)(&pmc_reserve_mutex);
 		if (atomic_read(&pmc_refcount) == 0) {
 			if (!reserve_pmc_hardware()) {
 				err = -EBUSY;
@@ -422,7 +422,6 @@ int x86_reserve_hardware(void)
 		}
 		if (!err)
 			atomic_inc(&pmc_refcount);
-		mutex_unlock(&pmc_reserve_mutex);
 	}
 
 	return err;
@@ -444,8 +443,6 @@ void x86_release_hardware(void)
  */
 int x86_add_exclusive(unsigned int what)
 {
-	int i;
-
 	/*
 	 * When lbr_pt_coexist we allow PT to coexist with either LBR or BTS.
 	 * LBR and BTS are still mutually exclusive.
@@ -454,22 +451,18 @@ int x86_add_exclusive(unsigned int what)
 		goto out;
 
 	if (!atomic_inc_not_zero(&x86_pmu.lbr_exclusive[what])) {
-		mutex_lock(&pmc_reserve_mutex);
-		for (i = 0; i < ARRAY_SIZE(x86_pmu.lbr_exclusive); i++) {
-			if (i != what && atomic_read(&x86_pmu.lbr_exclusive[i]))
-				goto fail_unlock;
+		scoped_guard(mutex, &pmc_reserve_mutex) {
+			for (int i = 0; i < ARRAY_SIZE(x86_pmu.lbr_exclusive); i++) {
+				if (i != what && atomic_read(&x86_pmu.lbr_exclusive[i]))
+					return -EBUSY;
+			}
+			atomic_inc(&x86_pmu.lbr_exclusive[what]);
 		}
-		atomic_inc(&x86_pmu.lbr_exclusive[what]);
-		mutex_unlock(&pmc_reserve_mutex);
 	}
 
 out:
 	atomic_inc(&active_events);
 	return 0;
-
-fail_unlock:
-	mutex_unlock(&pmc_reserve_mutex);
-	return -EBUSY;
 }
 
 void x86_del_exclusive(unsigned int what)
-- 
2.34.1

