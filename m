Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197861D4333
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Nov 2024 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883304; cv=fail; b=qXxe1jJigkfw+vEK5vDop0zkn7BUu0wHC+2v1JGdFvGCyCwXfLa2MubBdhENo4DNO4jR/ATa9T733otrdJhQAWzIKHPGMn/Dp0doe84bo67aSjf1QglZokQaU+U2hkIPKmMWuDUMR2HFmcWuTSzCsoy5jOv4jopQV1pMtB4qIHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883304; c=relaxed/simple;
	bh=ptRa55KJLfkVfLkgh8K5UcICvZV5ldJgO32xIEm0pnE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=b/JvzLKOK0fE/O6v1cC5ZoJ1twsGsvMOd6v1jSSMZ9TguCMOOIZLEaGjcFBjDyUd47XuRZ2acJ/onkLvdFjM99sBxEb1PxzVgiMgaolFog9fPx7uKpDmGgxHq6UrqJys8uJQ9QlW1DAOjMpfOoQQLJ4KHOIJeiSCy3d8trWEfwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hysuAq8w; arc=fail smtp.client-ip=40.107.22.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hysuAq8w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7KM7nXdGo3LAAfB8AI625yummPcqPR2I4KivwapOmQQ5F7EfjG6W4ltzov7MqlZ6NSJSCVl1uk/cqcyAdv8zh0RVSgc/fsTIUEMm55ZI+t1rd+EArzaZQsIcgpp2OPIqbjYKCDhPvcXEujBSzljDETqMg+CalLRMwqsxXU9XB/HzDB/GY7RMBHyWmZSETDAUUrZKc5MyzVjudYuEiTzeCzpOqJkOdZCHZtHLgG7VoKIRIIdiO2QvSTUnGJ7UePrm2C5XeK+aWKCqThNSr1ZF8/CjcFUAutDMS1VQC69O3Hnd7Ac8jgzySklZ6RUHJ3IS0fGyVz5z0rWS1zhO/8wLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7kFemyxM8n9Hg6vLiksXKFcSk0q/fOaPRYkE3mgmeQ=;
 b=HFrdaEIByZfVmwp0MPJJzRsebStoxciS+xKiZOcEbi3QsymKk34GoWQX7oEybVUI8lfuFquOJ4+AzO1eo5Hsa1L+ti0FvUKND8NnHblACYwb5LjVtTEzIl1RNdCC/T+HGuclxCqw6dqEJ7ynNTt1gvc/3mhcg62hjwwbrpjkSkpBDSbu+/xB+asE/VfxxMoZCdKHitPPUsWNwwuhXlUKZuVnw7BT1jKOu0l4L9wIb/I24DXVYbxdjEbTd2INUcEmIQZesj+iY5uoIrmyUQzrdA5VzccL1/l0B0HSNPE72bIdxykF6oQHhq8eEQYPNLbevAV+tREY/hjL3LbrDi/JZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7kFemyxM8n9Hg6vLiksXKFcSk0q/fOaPRYkE3mgmeQ=;
 b=hysuAq8wwpxDqUNi9n16BG7fz8xGRS2KyL+FqKEz9ywpw04VLRp2f6UrKfsQhXXYsrC+5q3pJTAzf+O/hDnQp4FeuDzvtUJXoRryGzISuTiO7ehwE79KK2Bh9Zsorrp6Rqj/uAW79ssvFVm37qe3XarEp9YbfdRXUqe8VavE9qxZZPAra7z4oTWoUe/c5x/FaZLGo6d6OCGzL13x4kUBfLFuDbFTp9p2Immdq6UXcVWhAUH+1ZOPMzP3I70g1tSJYa21yt7lRpr60E50DQx+zhSl0RRuul9UysbqbbO87M7PoTDwZviZvA9GLbrutx3b/jP9K3aEUU7M/LI2Wk86tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GV1PR04MB10251.eurprd04.prod.outlook.com (2603:10a6:150:1aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 08:54:58 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%6]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 08:54:58 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	john.g.garry@oracle.com,
	sandipan.das@amd.com,
	bgray@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH] perf jevents: fix breakage when do perf stat on system metric
Date: Wed,  6 Nov 2024 16:54:41 +0800
Message-Id: <20241106085441.3945502-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0086.apcprd03.prod.outlook.com
 (2603:1096:4:7c::14) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|GV1PR04MB10251:EE_
X-MS-Office365-Filtering-Correlation-Id: fbad3b2c-d636-4bf4-941b-08dcfe40b11d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BtD/NFn0GVrploYBRjvUvm6dqRMvLawPvlD1iBKysjkpg7d4eabcg7pdJXTJ?=
 =?us-ascii?Q?oiyskUsusaHy1r0KEnbtmvD3JfCbHfSlzQn8FZn1GeqNaQ/DvfjSYnL9TcPv?=
 =?us-ascii?Q?yqxbeMJ79TU6hhhPPAz1TDryshAyJkOe1lWMF7KhEDuqgwI6V+SbLwmELn+L?=
 =?us-ascii?Q?MUxynVnvAVZtkbGPNB5UPj6euxpthEVb+Zbtnn5dFRIZrgDB0X2Q9fl3Cr05?=
 =?us-ascii?Q?DR9x8Gtfx56s4XyFRW3tuaDQ50Q72S3uBErSuLh44INKU3dagrmGXAQlv1S9?=
 =?us-ascii?Q?rnsWyJX82NPo6y6UIR3Wshw4GlY+SCoNeojmMtf1snmHQ745NRxjsNSzeZnd?=
 =?us-ascii?Q?VmifotexIDKKtZfgMepjSY21CU3CiUBlLSN0Jl0FKi2CMAsafCXLuA8/wR2s?=
 =?us-ascii?Q?FVJEs2d1lE02Zyr+iWPQBFT6lecQiEFtR/+9kydIZ5Ss9xTkk1L66Qn/u9nT?=
 =?us-ascii?Q?w86A1Q+qtjymJeumsywlXPQm2k6fSGO6FQpjWilKErfywQnuX4orp228y0zW?=
 =?us-ascii?Q?/LBX6SXauBSZBzFx/1a+Ox0sflArp4BnRGcCMOuAugNeFZjeKH+1ME5sVmuX?=
 =?us-ascii?Q?3TaTsImPZvaqN4xUWH9OhW8ZoiKPs5InTyNrKGMD171mzZeh4yUX2YO5lz+b?=
 =?us-ascii?Q?WLnTfvoDaFahnkmUHHNasf+EfMpvfRXHUiI9UlvWmn7FNJKJvtuJlap1sEaM?=
 =?us-ascii?Q?84OyAD22Di6eA66uwUe3XliSUqd4aKE3tLyrwH4eDSDSnBT+sbbwUJ2MiK0c?=
 =?us-ascii?Q?n9VTLQGRggoPWgIesaCVoni06eAzQFG+h92tgzRi0RULk8Ue5oW6fB4tQTT5?=
 =?us-ascii?Q?J8a5QGG8nIcEQ/5pqV+UW5jmB69uQZ96/UaCnrirabuFOJbaqTO9X2F+8aU3?=
 =?us-ascii?Q?wEqKs2byWcZibyrQl8XsQGOu9tKUETJ5NypT3zeyj/npYC5gu7GuAZC1zkHy?=
 =?us-ascii?Q?9GcGid8tauO+6XzkJirbq8trYiD7aQGfOhpnC7LOzTDFb6OIu7k3u4bSkDsM?=
 =?us-ascii?Q?R4rgMhTrmCiaqLsE62yiww2bYpc8nzEFBqCVaCgjxQlYlNiu2chHrSSfsNi4?=
 =?us-ascii?Q?XvYcTVvh+iQkRN4hUA8brfSqrn6X71cD6oURTfPVTs0O1sjx5eQiPT+HCodN?=
 =?us-ascii?Q?FJ92gWWsDaLQHAwLEvgp3dGwfxr7XbvD2HtPoiIcBNfUKXr/lKvGBuV72hpj?=
 =?us-ascii?Q?ZANGijHoVXz4e2jmda468S7xWYzAILrudVVX+iaDihirPdR6/9G1v058K6f9?=
 =?us-ascii?Q?E4N8KFSq1Gb8kFO67/5AfiZDey6JjCum1e+x2jjBt7u2UX+LnUR+/r5WveCE?=
 =?us-ascii?Q?lY9j4WiAqkZzXcWQZmaPyizcmNMvXw6yR2FulZ5az2brgdN+ZLzu1XPwesOL?=
 =?us-ascii?Q?knx2ToXtNyWQsPvaL5TdZ9loPyCH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fi8xH8haesd06TsP29xN/3We9xIGOx68Dgb2VbOiXXQUxETCKjBlPNW0X0JM?=
 =?us-ascii?Q?o5s3I9a4ZeIVgfPKcFCZAlMmxolJnmzj5NwCAw/Kzi3lZFBKtL7/zqtFr/44?=
 =?us-ascii?Q?JjFhdtsEQVXIJBkI7iorCbKQYC36cgaaJ3KH+rU8d5RlU9QgVY0uFWqcTbPr?=
 =?us-ascii?Q?o5nE+y/yAKUdNPRhKEkS9Dq0ZJrYLflZAS/TL+FrbOKevwE1jU2ChpclEg5R?=
 =?us-ascii?Q?bYm/yFb3r1geGNe2TE2Hbiu/h5jyBFnEEm/VrQMxeUXMpBWj+81ZEoGPfWPi?=
 =?us-ascii?Q?AewdZOwZoEulpEBxSJDn/FZpA+9Luyn0FFfc5CvB1NH163LBBjQbJN0xkm/B?=
 =?us-ascii?Q?lS1k10+t+s7V2uZ22qBpMUN3biSdM0U2gDxnG06XrUeMMExkYxe9xj+aIQXn?=
 =?us-ascii?Q?glHST9pM0lyIlc3RaEJ4ushom41QQ2Tap9Dmlv8M8v88/UEzlQ8zmARdpMeh?=
 =?us-ascii?Q?0/vLFLXRMbkAeGro5ceUmjlSxAzA34K8TCmWibsu30sWnovqBxRvTqyNN6Eh?=
 =?us-ascii?Q?hS2h7XEk/0YVW5JlsRuyVB4ryFjrjsKprYOl3brYatIMj9lOTfTB4DxypsZX?=
 =?us-ascii?Q?wBerhkw1rzEHwVEuKKtJqxAlJlPMgb2LnED/ZGjLG17VMUscbOyzWlMZfB/m?=
 =?us-ascii?Q?rsqGKAoMeJSTvXEqWd/XktnlJexlCHaKyK6l2LsDDZET+RAJbVh43W/w9Mbi?=
 =?us-ascii?Q?3mOYDiSrNfaIsnv8t7oT5iiJjCwuWEhDS4n5D9tlSsEI+/HKlYXtvBaAvdQ3?=
 =?us-ascii?Q?3fsdagSi/buDA/ZsNcj+e9FLGL7gfPC+w0ZuwE2kJ8gezchx5NAAeh9+V5dg?=
 =?us-ascii?Q?MJJ2O1noY0ZN7o/K+Dj8jlYVTp34ALDJATg/S1Lf1FiEAQx0YwhcAdoWyPLt?=
 =?us-ascii?Q?0XsXldqhTEBVkUDBWARCRzyLb189O3VipiWm3jQORRI+B0wHJyKV/eranj/I?=
 =?us-ascii?Q?oOLbM82MetXegKpLd2I9l2VU3Ib5/zc7CQSt2//VJ4XNXPqH17WTq2s73syv?=
 =?us-ascii?Q?kb+jB7Wh+UEbpb3Lw0zhLHtzlTGQms2ULcMp6GI6zcabgRK7J8Rkx8p5KY9e?=
 =?us-ascii?Q?pdasel3sqXo78h9hPkHae3MK/53gXwlSX4fQsCsM8l5RT7ccYN2CgSI+tyKk?=
 =?us-ascii?Q?PipdEJ+2IbNIGmvP0+BxvKE6ENr29M5erGACyP0MSY/EyUb0bRA24OE4RhWM?=
 =?us-ascii?Q?tW7EGnKVIu6BobFFwPW+5vMZkEeBW0wZv2BAH1n9Cmr9PQF3SiQAyHc8Xxjz?=
 =?us-ascii?Q?zNJ8SKwd3kro20PMmJB9pEbXhkytu91ci3Uz2/VUFUIgNWH3PnZ1Spyipzq5?=
 =?us-ascii?Q?+TNwQWx87aDKFFbXzlrumhlekKeMlWyAC5LkcxmCtlvZRavSQ8g+3IciPl8l?=
 =?us-ascii?Q?vjXdrUtRp1KeKAuaEzzA47JwYSm40XEnOqoVlFpty7WkBce54tbN0Vf5vdUb?=
 =?us-ascii?Q?v5RCcpV2bhbvVZsN9OiGFwx5srT7ZrCbFDSWegotS5C2LhGG4sDouPl2oLzU?=
 =?us-ascii?Q?HQjjaq4dOWKcmbDYp9T+X2VlHnFN11OJn7wHlXo2tar4asLsVOiJkb/zzruc?=
 =?us-ascii?Q?qqpiP6owWsgqGQ59DklXVfKWH4LqIr6NALmtLC3F?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbad3b2c-d636-4bf4-941b-08dcfe40b11d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 08:54:58.4994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L22BsExgjYGBAKroKKPG5mxpJFxzX5l+kruev/tpMgx2AMi3thhUXpXjA4SYDFednnYmDIp7xhQLqRkXwsUA1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10251

When do perf stat on sys metric, perf tool output nothing now:
$ perf stat -a -M imx95_ddr_read.all -I 1000
$

This command runs on an arm64 machine and the Soc has one DDR hw pmu
except one armv8_cortex_a55 pmu. Their maps show as follows:

const struct pmu_events_map pmu_events_map[] = {
{
	.arch = "arm64",
	.cpuid = "0x00000000410fd050",
	.event_table = {
		.pmus = pmu_events__arm_cortex_a55,
		.num_pmus = ARRAY_SIZE(pmu_events__arm_cortex_a55)
	},
	.metric_table = {
		.pmus = NULL,
		.num_pmus = 0
	}
},

static const struct pmu_sys_events pmu_sys_event_tables[] = {
{
	.event_table = {
		.pmus = pmu_events__freescale_imx95_sys,
		.num_pmus = ARRAY_SIZE(pmu_events__freescale_imx95_sys)
	},
	.metric_table = {
		.pmus = pmu_metrics__freescale_imx95_sys,
		.num_pmus = ARRAY_SIZE(pmu_metrics__freescale_imx95_sys)
	},
	.name = "pmu_events__freescale_imx95_sys",
},

Currently, pmu_metrics_table__find() will return NULL when only do perf
stat on sys metric. Then parse_groups() will never be called to parse
sys metric_name, finally perf tool will exit directly. This should be a
common problem. To fix the issue, this will keep the logic before commit
f20c15d13f01 ("perf pmu-events: Remember the perf_events_map for a PMU")
to return a empty metric table rather than a NULL pointer. This should
be fine since the removed part just check if the table match provided
metric_name. Without these code, the code in parse_groups() will also
check the validity of metrci_name too.

Fixes: f20c15d13f01 ("perf pmu-events: Remember the perf_events_map for a PMU")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 12 +-----------
 tools/perf/pmu-events/jevents.py         | 12 +-----------
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 2b7516946ded..b8719dab264d 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -585,17 +585,7 @@ const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pm
         if (!map)
                 return NULL;
 
-        if (!pmu)
-                return &map->metric_table;
-
-        for (size_t i = 0; i < map->metric_table.num_pmus; i++) {
-                const struct pmu_table_entry *table_pmu = &map->metric_table.pmus[i];
-                const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
-
-                if (pmu__name_match(pmu, pmu_name))
-                           return &map->metric_table;
-        }
-        return NULL;
+	return &map->metric_table;
 }
 
 const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid)
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 6e71b09dbc2a..70f4fd5395fb 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -1101,17 +1101,7 @@ const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pm
         if (!map)
                 return NULL;
 
-        if (!pmu)
-                return &map->metric_table;
-
-        for (size_t i = 0; i < map->metric_table.num_pmus; i++) {
-                const struct pmu_table_entry *table_pmu = &map->metric_table.pmus[i];
-                const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
-
-                if (pmu__name_match(pmu, pmu_name))
-                           return &map->metric_table;
-        }
-        return NULL;
+	return &map->metric_table;
 }
 
 const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid)
-- 
2.34.1

