Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012068.outbound.protection.outlook.com [40.107.75.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880DB19F424;
	Mon,  1 Sep 2025 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732648; cv=fail; b=FyBxQO6azYpvapnqJJZY/Ot/0MkWByLARG6vkjU12rL0wp/8vZJTub2zODkyAhKWJVhWIuYa56PH6nmhza2mJdUb/AmJ2G+2TZrR0qKbOBd/XIP4suBvl7voBQrneBDiBlwknygDNa3gWg9YLTP6nt3W2J76JZRcqBAAQGmquH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732648; c=relaxed/simple;
	bh=TKzfESVSlMWCDdjEtULsUu+vhum237Llt2TccUeRHkA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JjJYHVYrgwl8u+xvDPJqFYg95kNVK0vWoVNB5XkdwEUkoEyWi5RPW/3izl8luPPOSbqDe1RJZ/DHizoTewCi8tmRUcMBxjjtdSqSqI2hHCAUk3I61QE/cja5YZ9nvH9iEXWAOt1XH48p5NWonFF6hmJz9icHvCpk0Sn939xyy3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=D97emVHR; arc=fail smtp.client-ip=40.107.75.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="D97emVHR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fi1wtiHytBAEoic9cX/BYbdfyDDXyO6I5UfYEOwL/T2lb7MudbUTKVcIgeN5m8V2VoJVwmkQxh5r6FN+o8SDOqXuiwq9t128aQfyXe2XygSQF7/7esbEPylPCmLe9VUbyVudTNK+tNn2V3/S+WG7BsZZ8q4kBlqeIYHGArAIWKkhW4yc4Ds1s4hgYUl4QtVS9lNm+OHkLDHMQ8iKGbADS7Ix8Tc326oY2KxYj6ayZde36KVOuoGr/6UPDw3eYqzBlylwGLKhvQq9nUbrExEImHEXCqJw+31ZzWBI7pUR/WSK+Xeg6fPs7K5ooFCgr/oJzOdnAcsQjlW98ebps/paAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbSx8N15B32jlP96xt9xIEgLydsvD0fw32rsIRzzkIo=;
 b=TntU0IOrHdJSvGo2Zd9iEiAOB0Ghl+loDn6Dg7RYI/sGRzxC4YQ5LyXthz7fPgzRzp2ieCsVg1p2YbFNq1oBFK5KxgPRvB+dtd6pFU9Ff/bLRUvho7ZTkJ1aapPn4c6gW+E8ADus+FjOOBoE7ak4U2ncgiY8Ee/dPQiZ6yGoSH2sBtjHD/av+7MHrD5abBZhBKaPEcWdtV1L7+z0RN98APJDRTKt6UstnEZhD/ResOi2uPsUMEm9TtGefFhN4OJHRrUOrkbEtxiqtu3KtV7JmL1sMfngEWUQkdVS3VHIfWJ3CycazNmGs/h3uI4UuJqD/h/cGmkMomGAWoKdZqqH6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbSx8N15B32jlP96xt9xIEgLydsvD0fw32rsIRzzkIo=;
 b=D97emVHRTFr/deTRE3HyyA6Ep+NeYItpi2o86SK5xIHEvt8TUhVT+Swwt+zwgUyMTEDJCtYfFkYfKMgRr2DQrt/y54mh9JA3lzKgWbjrk4SmvuVTLdCYbhL/F/mqWmsON6fie3tEqytHNmcoJe2c4KbyGfNf5+TFD5PS9DPCewLUJpJbsMnXmNGNeZ3S5MIeZbu9cYAW6xesWXkxrmbIOKx6g1jphC6zxSuGdu/eAHCgrLsUuF/+GSp2rWHyo70J8VTaf6i+aY7ywH7Zu83hxANgDKfXkiqfErwd9nrccF/TOH2oZAXCsFIPWIJ3a+200rGyM4AjamNthzO2IzdGdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TY0PR06MB4982.apcprd06.prod.outlook.com (2603:1096:400:1ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.23; Mon, 1 Sep
 2025 13:17:23 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 13:17:23 +0000
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
Subject: [PATCH] perf/x86/intel: Use guard() instead of mutex_lock() to simplify code
Date: Mon,  1 Sep 2025 21:17:13 +0800
Message-Id: <20250901131714.646988-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0049.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::20) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TY0PR06MB4982:EE_
X-MS-Office365-Filtering-Correlation-Id: 65973626-11fa-45f3-b57f-08dde959e34b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HsX4r19xptwJRH7NWhyX068qLaSyBs70WpSRde37JSX9SJwBExUPCvdIbfu3?=
 =?us-ascii?Q?1VLArSS+Hf/SH6ZcVjD0vUEvP+WpYKBy+PjxO3fW3avXyO3S2qrGvuz9gZGU?=
 =?us-ascii?Q?K9sjUczgs7OMXaMW6XcNAhSEn2VJL4WyQ5T1gNoegbCveMfh9imBFHU9lS/l?=
 =?us-ascii?Q?cfD8zEDrdMOpBSG//btN5aaAcF0GOp7AZXNvuCTkPxtkbdvPG8xDUNg0Lg+P?=
 =?us-ascii?Q?mwQDfgbVRpay1Ob4JwhqMr/gHR4I6VRop6U6t52m6vV+wDzP88giS3uLNYih?=
 =?us-ascii?Q?RHfWzFUunpmOxjfzgdIq8wUMooZj9Kd3MEvU5vunPfsm7YRqAbgv6w2iZgTM?=
 =?us-ascii?Q?V4k7+rQdjIKMA20arrOvnBK7+HcsdjfcDAWkmd5jpnbIOd0Jub1P64M39K1q?=
 =?us-ascii?Q?epB1DiRcAZzbQICd5VHqQOdWlUTWhcLxBMrhp8/2XlL+XIa8Oxb3Wht+aVBm?=
 =?us-ascii?Q?VUDGXn5TpiJ2Rm6TIvyEvmSPwssCGs6JBTV7yzlgc3QsOrwMP+tyQct3lXoV?=
 =?us-ascii?Q?uQ50zzwKf5KaQpZPObyq+gLTwDSsMbWr1uT67ZAJBok5AAihNFPPYu2Gt5mj?=
 =?us-ascii?Q?pUjZwl3kevXsDkeekR7wrmaNAJrqVyLxu7pXzn2efIJCsZn4EbeNmlYkqhvk?=
 =?us-ascii?Q?e7R/8pSx4tC7t15Bp+cIC8TSHS8yEhQq2OcxtId9JCxUAzLB3zNnRKv9ZWQn?=
 =?us-ascii?Q?f6zuQ06Nzy9FN2H1/k7SYVMNhnaW/8gIlT8oHoN0opg9+WuJElZadiwnU8OM?=
 =?us-ascii?Q?cUpfPrH1EYhkc2jTSsMc1LAWrucRfCtK+K+QKMMGBldXfZhX8yMQXAJzME7D?=
 =?us-ascii?Q?lJB7IRnWoi3af5DVam3N/59k53/W92QIHc4jE8TGr6Lnfti8Kv1zd03UBPRq?=
 =?us-ascii?Q?yiW8g/zPFqJnbrogf2B02O06KtATl20B2sjCcU2OBQ18l+vHHkZ0YD1ODC7T?=
 =?us-ascii?Q?MdJ0i9KaltRVqKiOvmNVNJp7B7eW1dROnWFiXp4ZLL+FZ3LduISsu8jFzTUp?=
 =?us-ascii?Q?/dPV5SjMaBkrwASdvnMIn4BM1VLqmTZqAW4R1ZwXCLC35pw6DrGY01mx/aX2?=
 =?us-ascii?Q?fArmOrge7FqT9BWZmPKhYbat3lClGNhEfQ9fH9Hn0GkjCdTMSa4qKpO21fW7?=
 =?us-ascii?Q?34ImiByZeWXequXNy5zmVxts0Bc5YJkG2pglgOaltJQOTB2rEHaVOkDxvI8b?=
 =?us-ascii?Q?Xk0hwDcdcqUHe+87DP3rOwwRpo30BTEjFTzjUglwFJjkFCEX+fvCtnTra5JF?=
 =?us-ascii?Q?q1rxNE+ohP1GhH4pRFG6HjTbU7xT53dB/vLY7NsoSuzeMqcmeEq6ZhLVUz6J?=
 =?us-ascii?Q?m5YP5xDtOuV/4/LkRcV+mgAL5Z848Abgog48lQpHRDCDbNj+s1gPb8etS07Q?=
 =?us-ascii?Q?N4IJ3QrCvhLpUbomv6ZWbjtCDd0gcDPm01H4MXij1zi2vkZhglBBkZx8zv8p?=
 =?us-ascii?Q?oQ6jTEdmLzYde1kepwHBhL1wTGt+wluDKdAIUo/MvD99ChOB1NuY+YNN/PlP?=
 =?us-ascii?Q?RGAgux1nqqLJDp0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?89AiE6vuWcCbYOM/kUvzN2ROG2Us8eoMVr2C29d5PrAMrwIVJhahpV5TXiYt?=
 =?us-ascii?Q?RqzAdLpge5v0J2kmh7zt6j92RxATLs2vJ/SfROnYN/AKLyjkpiubILYQP8XR?=
 =?us-ascii?Q?nt0NCm58AZjSgfarHVx8jACoHjgnrWCe7LRiG9hAHvT1YfxsGO68Uu58M62J?=
 =?us-ascii?Q?qtR/2RE/9nyEvTxYZJ5sTNxbH8ak/QlGo0t3hz+kE3raWRa8UNW1EK6W+gAD?=
 =?us-ascii?Q?6hpUKnmBA8ZMNGxCAMz4i6daoD96v1mFeBqTSZnUcS7/AnawL2UXziEuLRV9?=
 =?us-ascii?Q?9xUKUe1bvbBeFc2gSt662dzvKhQyVt9rsGMevICDcRaT+PPiZDmDBP5tLABh?=
 =?us-ascii?Q?sFEb4FkFl7stokxHEwcfGgAiXfgXMei7tvV36vP8sLsw40kHmcbkXrEb+/vy?=
 =?us-ascii?Q?NdgC0MnB4E+NtEZQ/psxyVCJSmL/GjVVfvOHkQC4CqeEtQ32o6n8Ckb6+JWu?=
 =?us-ascii?Q?E+eQ9v/TIkl6PMpcavJCs7Ck4UUZtXJL5FNxZJ0l2f3IcVCa4P34H6lly3iR?=
 =?us-ascii?Q?peORHSc1Qmy2HCdik4KW8SuYBfD2jzrCfe17ftJ7ODi8p4rITf4M4rBU220f?=
 =?us-ascii?Q?pHfWYQBZ5XQOt+Azc8pBUiXh+WN9a+4fktmOYIDZVzmOs0n/ZfbQdmOahdR6?=
 =?us-ascii?Q?4m9sYe0MgXx7JibPNPmZbRQQ0VkB0f5gVoa74t0rdgt6krMxBd6ILWnYqlty?=
 =?us-ascii?Q?8h2EavpiCQUqjRERN2jTu6fniV9+BLwj/UXTRSRgiyg4dArVtFXFgjHarTkx?=
 =?us-ascii?Q?O+BAu1yMQj/Rrbfe0Yno3hAzDUPJ5su3v72cS5fCochk1PJfftFUOjCxE3ml?=
 =?us-ascii?Q?fxPKSPIRcR8EG31hpL10Xqtn3iRxnxCbDSk7IyKngkBTJwsa6n01wABlp1Jl?=
 =?us-ascii?Q?6SpYh3wnCHPo3hu82x7aUT2RpwADgFhhUSNFWG4VoLZLNvakB/rc9lHiDjex?=
 =?us-ascii?Q?RbdzK/Pr390NgtgRVTKJvDv/t/QPIpCgdlNLpcKAJb/LDXRKudghrKxuTtQw?=
 =?us-ascii?Q?ygRk8MD5iiVvx/7fe40z8FiGMd9srKQ3xP8VVbOKNcHqEe40z6jrLCLmY5/J?=
 =?us-ascii?Q?a0ie4ORiLt9WOdwIzPRojU/vOeMwrF3rsFSRGVSJlYn6KWdzBKhMr/j8lLkh?=
 =?us-ascii?Q?ma35D4WDj3r8ACPRr83mz4fD4vDY9Qc8EgvoJkUGH9jzuMEsT2qpouq2LTbj?=
 =?us-ascii?Q?Zt/jPPJw2KknZqrad6jsdjAqAceypxrmDBT0nqcV/qHVcjeViX3J7aMYRMFP?=
 =?us-ascii?Q?ureVYbqScQ6b9rj2GqktOUOzXOcz96h7K7+L93pDJcYXbZ+HDRhqgaPV+o2O?=
 =?us-ascii?Q?NM4QWNrTx0h6xkMPOSeRlD+GvLbu2lNQSupbnAMQBP3zadCCzySwGrZRslsb?=
 =?us-ascii?Q?ba+6yMb2BABfMWwedujdRINnUpIt6ZC16Cq3c9EqvESFHff03tmFcq3ptjaQ?=
 =?us-ascii?Q?M22+4/z6J9AGuCweYZSuWGBgHrVPXOWZ51Jm2fJs5qxFp2rMaZ4wjz5WCa+o?=
 =?us-ascii?Q?87A0MsNOtybpTu0RhLLimKf+WjKyg/HRruRyE9JYDK1Owg/gs69ZmvLHp07P?=
 =?us-ascii?Q?k/A8uHx5kOm1DIhlpxjdR0Ykzo3PPiCTGGFytwaf?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65973626-11fa-45f3-b57f-08dde959e34b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 13:17:23.3076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWXDhh5sJSs+VjUmg1A7CipEIC3lfQvIVBjrqJm9jcwsqikoPNhzIlH2UHtunffhmd/1/BNyVIMlBI2LVoPpFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB4982

Using guard(mutex) instead of mutex_lock/mutex_unlock pair. Simplifies the
error handling to just return in case of error. No need for the 'done'
label anymore so remove it.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 arch/x86/events/intel/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 28f5468a6ea3..ac88d9535e85 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6107,18 +6107,16 @@ static ssize_t freeze_on_smi_store(struct device *cdev,
 	if (val > 1)
 		return -EINVAL;
 
-	mutex_lock(&freeze_on_smi_mutex);
+	guard(mutex)(&freeze_on_smi_mutex);
 
 	if (x86_pmu.attr_freeze_on_smi == val)
-		goto done;
+		return count;
 
 	x86_pmu.attr_freeze_on_smi = val;
 
 	cpus_read_lock();
 	on_each_cpu(flip_smm_bit, &val, 1);
 	cpus_read_unlock();
-done:
-	mutex_unlock(&freeze_on_smi_mutex);
 
 	return count;
 }
-- 
2.34.1

