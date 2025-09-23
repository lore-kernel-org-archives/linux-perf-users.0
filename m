Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022118.outbound.protection.outlook.com [52.101.43.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3557E105;
	Tue, 23 Sep 2025 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758663133; cv=fail; b=enVDfcx2tbYg75jv6f10BqeUuerGN3ZAdnqNBuml7vaqeynZkoLv4J4GTOsJvFHx9bXAwMq20YVkpftEXbxP1YpdfsHnFjpQM+A5v0aOI5spqVBtAIiuKGOFIdembSu+nhd2ofPqCrcL7owZLaI6SqfWZqroGzoW7AC/Q7hqJWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758663133; c=relaxed/simple;
	bh=1BOeVqSouXpV4GRMpE6/NnSf2X8ledquOtWV8as801E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RbFov+3sXGHCnHulzrJ6TVbm4tYbkC7TnvuZg0BJbf+qRc+EiAl7bc/4WsC/oU90DXtFNqAlV6CpvZrbS/Q3NRKuNMypJdB8QHDlvU8ErgYoFUmIbsnmZzCzqCpFUpa8/Y+m8VxSYLoqnwhgoYBl5UYZkfRI1bt07kAVxB6zaOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=J91pIz6y; arc=fail smtp.client-ip=52.101.43.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="J91pIz6y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GivrybV+Yd+e7eviB3U5Wdh+GEp98x8f7OLhLFI7DBR02UGAvWCqMx9C6om06r1uueffGfF5q6oCMmkTPFnYlqWP+ah+G544Q+NeXi0ASzx/BiE9ctvdQrEo7acjiYqYmH7VQ6fzOLFuWHw6L5SrOyWfXpiIc9sorx1orDlSBXzFIta7tafBeM56J8mK97peoxLwNRurn87HU69jT7akVjxomR95ukFnryOkGftmsS5e3qKP3FFDTOKsPFlmehN/hgabW4wpnCazBc8X6U2RwaAyWVgKDrSok0FIXtp43t8qhm4cd5G1UmoBrusY2xTkuqio6ZjQCJYxNZ60C9Zasw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdMIxoj2nbYEUxq5H55bZILzk5VZgEUos6oT17Sf3QM=;
 b=s1eVW2P/kCtFY9/XFA4aYoDhg98sV+LKIv3ZXODQXOTaO3/RYJaMx6dK3n613uIbeudsXgc0dY5qRRLc33DRJXJhBadtB509Bju2Dm1NlCUNEXquDZTFO8h3kIBd43cV+t50kzIJMYwWaxcgvu7uoCQOmZQOFanNDiGW9wUELu0pFMCqke/XjiZsAvC02pgBOgr1wURbZCbZoWy2axB84fQ4FHDDRx+oXvr+K5SjOjt+2OxGH9yfyWi9bzENTYq8b51wguH4ZRIagUYS62Y9IR8JEL2bNoo7t3xB29/pgEkZ3iiKaiHAHnVYr0PVyVXGup1OIHs6zJm2F9Yw6tkQ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdMIxoj2nbYEUxq5H55bZILzk5VZgEUos6oT17Sf3QM=;
 b=J91pIz6y6FAaAOS2qx7eBLRow8/eyOWkh0FQkM115g59gNfaxIDUHRadbH2RRSJBkSNrradkbjVUgSKAwdJxZRbuld10td86fTuEigj9NxDokgI5mfyBd1BGG/sx0ItZk7VkDgdadLTKc8oSuoSkYWnBjr7l8YCB6eyTccIj3m8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 MW4PR01MB6497.prod.exchangelabs.com (2603:10b6:303:64::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.19; Tue, 23 Sep 2025 21:32:08 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::86f5:4db2:7ad5:7fc4]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::86f5:4db2:7ad5:7fc4%6]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 21:32:07 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Will Deacon <will@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	dan.carpenter@linaro.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf/dwc_pcie: Fix use of uninitialized variable
Date: Tue, 23 Sep 2025 14:31:36 -0700
Message-ID: <20250923213136.8107-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::21) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|MW4PR01MB6497:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf25c21-3848-4fb9-51ce-08ddfae8a599
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cuLRgVtuNMZea25BRBegmS9ljyhenl+2DcuE+oDIywWikk1/O876fxHl/HMi?=
 =?us-ascii?Q?ceXpg3t14VDImAEdfA5pU9U7rZ7jmIKyU91LUUm+ZCJFdt2YgkeiuBN9bWvk?=
 =?us-ascii?Q?JM5zvVevBIFZMJqEnIWsbxafBkZMmxwHduR9gPGPAGu8p3lc1fFNHdXb8G81?=
 =?us-ascii?Q?wWK4N8HpCSMH23aYr6qcT9ctjCiBSzUkqVUxkEbJHaiBnQnBJ6sYNnjb5/ys?=
 =?us-ascii?Q?4QveixesLRnhWOJr9eOfEuLSu6ebav6Rg/Ao2+9iugGCTSyWV34RZo1ur9rz?=
 =?us-ascii?Q?p9dxwXYlqdd+tQ85zSlQC+zBmOhEkFpx5KFTBgRuI+ybWKnUPh3PyN0Xk4AV?=
 =?us-ascii?Q?1USQI0+qQYIdKi36QMhqZipD0ZU9H9duVuclzcfGnjHM/VEjvxZuHF7vPuM8?=
 =?us-ascii?Q?ri339tx9mnLz3AZn7J+i1MSywBKsw32Mo36k0Tj7KoL6vc8sjzgF4D0Lypze?=
 =?us-ascii?Q?/mGLxMJY6EN3Qs/6bgq/cCIb07yAl31V3xlY4lT1U8XVuYOsa2hgJ3W7S+8C?=
 =?us-ascii?Q?CDlVH3Xiy0JyKHy9Ki5UByCrLWFI4BZuSHXkt9rNPDFQybAx5aRpG0jGjZLY?=
 =?us-ascii?Q?9kyVQDkJh8lxYL3VNlRtDPzzhDKq2pZ9lSjKcKOhbgvatnHHFkZGl5j2FPij?=
 =?us-ascii?Q?WLSdlgoO1+sZQ10OdDMtte6mqqHf15/9LVOGsaCfA+n1SU/Fz7kfWtp2na7F?=
 =?us-ascii?Q?v9Yhps/L94DmuGDDEwXgEgvc801aHstPsjjnNsm7w4iNRga89CfUNpXwWpJn?=
 =?us-ascii?Q?0L9cHPtemS4p9pC7LfuQBGMvTsf8C8YAI/zrE4lav0GxrGhw2Zgr3V6twyCn?=
 =?us-ascii?Q?lMkQ9bbZoJ65MFGit7i1GTwJ7m43X9VsEaJCoNCcxk9VRSWZ4m+mxleNdI0Z?=
 =?us-ascii?Q?qoR0ImBft11rl9jk07PG9Ud3u+eaHJnvlwhAMntNSvYg1frYI8j57TjodlF0?=
 =?us-ascii?Q?M4WC1e5BABbopI/KYktUqnhuj85vDDky5eZOT/F4POX4UBOiE7pkTCvTIZKL?=
 =?us-ascii?Q?NS3dc0G2cWXQA2CycsasakwOAStjJsQDW5L0DkioXETuQKrpFSRGMI4BfgAa?=
 =?us-ascii?Q?1mNUBnutB7+EYpa+UUp1T3T0S9x/YTHdZadv/z0pTSxNos1z3THvgOdVweFc?=
 =?us-ascii?Q?I74lS62apHx7uq7Z9UgbWmLPLtU9p4dQsld31PXORmR0AhRiTA/+mHNBHS5l?=
 =?us-ascii?Q?ST522QsOwwpxgvsJ20CpHrrPZ+ZTPF52T2KVpuo1gD0h1QBVRW1zhBQbJPll?=
 =?us-ascii?Q?YAsOniyprHMfiUIaZZM8wo4gy8w8igqG6L/gYU6RN1WqoA7N/P7vp9VHrOww?=
 =?us-ascii?Q?/uJZnJmjoeGRDIZC/jleDz6l0aHJY1EtdfiY9pCl8witXUzxqJX4c9wNmaEv?=
 =?us-ascii?Q?V/zL0RgbCfEWcSNYmrA2905SEPhcDSpELExfop+a/lDkSvK0PCsn7ferDYvZ?=
 =?us-ascii?Q?58gXgEthEjjBy1MsO3C9b5j2wa+3BUb7pcRK57ebip9gCs2oBKr3oPMDg/UF?=
 =?us-ascii?Q?1xI6xdo6v5JudoY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qzfydYaNdYrHuL4mAVyUG5p/VO+0rwOq5lER6y1Kxs60DZHKd1DDboVsd7DR?=
 =?us-ascii?Q?VlJECp/lnC3m8YCNhRgYb/0qe3D39uqYJgDNhYPCSzmqyHRG0l3N0xvh1f6T?=
 =?us-ascii?Q?+r0bl46Cdq5qH1za8AyNoECmF/tMbRTdpaLliATaD0tax67AqwUKEZUgf/cn?=
 =?us-ascii?Q?mRHSFDMclsSWRtRXL3KxqsE7KuHG96lJM/tGq0W97jimSGXQeXMjZNjpguXk?=
 =?us-ascii?Q?aVSMa5UNBo6iiz41fDEevoNdl/qwe8kAx53Wr/7VQl5s5US3KJCv/ERq3yQN?=
 =?us-ascii?Q?U+zFQ8XauhcQF5FI6rrCC6q9DcVCtPH9taIrfnOPAx+e0huR5BEo8s6Omm4d?=
 =?us-ascii?Q?/uQkG3kmZ2BzVOSocYTO2Z3Dvy75K5lahSpVS2w5kMUaASoFZIr+MUE2035g?=
 =?us-ascii?Q?WA+ozl6VDXb7r+WlZT9sUSiYDJG0ihemUTEGysLQ0hL2vMw3szACydQs9P5j?=
 =?us-ascii?Q?/xiRMsx3c2GvCvRrlc8Po63QQ/fDwOqQf2xooglu7+q0cNgDclcvsgHgcW+9?=
 =?us-ascii?Q?g7e8Rt/K6KSKch2GmSIgwGJXgLDK78BwddH+0q1UXctfNICRxg9f8mALALMA?=
 =?us-ascii?Q?e0fq69ILQ7vwDQuHBmUikK4EGFCwGPnMMsTD1t2pb6myXaf85dzwqo/yjm0p?=
 =?us-ascii?Q?DoPyeDBMEcU9YnVSgPBRCv4AQbh3R5z8wB7Z6bTj4sKrjQjgrmbCKTxbUy01?=
 =?us-ascii?Q?IpP6A1ibw+nlXkFo30PY6Zm9UiEgs5mujB2LsuPeGIssaB0VLUuPI16Gcr5a?=
 =?us-ascii?Q?5vTzNH83UGCYfMbdr4GM2y/7Glc/8TK5SIkiXpU27QwOQMp4jIytTwl58tZX?=
 =?us-ascii?Q?RqtWaVs9mK23MSQp+hOKNme8IwiU7seZ699s3xg/Z9XdBfjc1O1N9j56rqAz?=
 =?us-ascii?Q?fDEAgCqoQB5vHZE8kjBLcjoeNw/WHx93W67oGKIx8FsZv3mu18jCBCntOusX?=
 =?us-ascii?Q?EgoGrABRJyGVL1+JPnd9D9nMyG2grkvrWgUrsvfMKIRsLo31VL8LSnIvEMgp?=
 =?us-ascii?Q?mfBa/hkK3Mr8HWlcgYpVts1v8iRaE+1axBmvuF11ETVsQyuo/f56SkbKlq7m?=
 =?us-ascii?Q?0LIliyRaKZwqFE2+yB2tITme8cTmhUI1hwJf/3uUTY2QGa+R+HkwvD87XQrO?=
 =?us-ascii?Q?kSQwQR1gus52Nvr+HFSTK24GPobZ2Jz6NFdweJ2NJBGMRaK+C2Xu0sddfClt?=
 =?us-ascii?Q?ZOspAE1sN42ETLsNDRxNZ7MNRaRkR607ShtlmdfIVODS77BIa3QDhe2ktkdn?=
 =?us-ascii?Q?ykxVkf6b2T+Nkje6kmEoWl4gZcK55PX4wuWOtea/M5KwCzOcY4FrHWD5dJcK?=
 =?us-ascii?Q?W3xLfsebi/YKvhjcaBs1k6jQ8oFlTMzCr921N1E0ta64RlSPXXIAXqR7oBbv?=
 =?us-ascii?Q?wtS7NWEoa7QFElqPwknOeQ8ZX2EzOUk+Hj+aKqkQ5PtuRjCOLZQZgXx8uXt3?=
 =?us-ascii?Q?uEbgST1Or58LimbTtvwVwe7rIZH5wiqXMJKR6PFh2xj08fMUmPgb8wPlY1AK?=
 =?us-ascii?Q?kzWDdTfx1xtv9Kgqmi6NWfaPfewGcj7mPwSytHRabEnD7uP1EinCgZig43wb?=
 =?us-ascii?Q?5emY0lONZi2BY+TKSGTbwZqCt/Knp+TDtAWfpGmFhxp+CONYjDWLsX87LX44?=
 =?us-ascii?Q?jKDCmeSKgAuqGEIXnRnP7u0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf25c21-3848-4fb9-51ce-08ddfae8a599
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 21:32:07.5957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwZSuAmKSvBgg7tzNl2GgmugY/4LtmZpFe2M7B9ZyyuUkTvA3Tr06YkHR2QActVF9B6qeDTUbAHGkpAzoCDH98f6BmE9/LHJzCmC7VYwDquvGOXTJb60vjr8T9M7MFys
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6497

Fix use of uninitialized variable in group validation code.

Fixes: 71396cfac97d ("perf/dwc_pcie: Support counting multiple lane events in parallel")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202509231223.gZsX6Eio-lkp@intel.com/
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/dwc_pcie_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index d77f767cde89..22f73ac894e9 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -402,7 +402,7 @@ static int dwc_pcie_pmu_validate_group(struct perf_event *event)
 {
 	struct perf_event *sibling, *leader = event->group_leader;
 	DECLARE_BITMAP(val_lane_events, 2 * DWC_PCIE_LANE_MAX_EVENTS_PER_GROUP);
-	bool time_event;
+	bool time_event = false;
 	int type;
 
 	type = DWC_PCIE_EVENT_TYPE(leader);
-- 
2.51.0

