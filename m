Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164FDEECF
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jul 2024 03:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719803027; cv=fail; b=lnzB3aaFS67GyKqB5DA7szyZq2B1NgnDQzlFXI8DKF7uxgJ5D1fhXFtG1Uxla2NsBpp4HVjdLxX8yOccgG08HbArjfeTKh+2M01zJyITumk4hdm/RdveGVIe0Wa+VsS2qJqHgY4/30e+xMoZbXpFbW6FkoY00rglXmf+wXd+Gtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719803027; c=relaxed/simple;
	bh=+LRkOLC65KHcwgz5UubrXqLfehm7+z8kADslTxZ8Xuk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=irEn6+zvq0zeYE2ftjYYCMFi8c+OvnL+FOzXFjy1y/4WMXEHKNe+8t/O0/qeCSg9Finy5eFK3WDNhY5qEPx+bD9CvVQsN+1xfeQFmnwMM+E9BqMyUqT0uCV0cX6DvVmBV0yjoPcCFVXSNLOzFe4baatYe4EJeZ36EFv7MtUOjTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OVWq03Yl; arc=fail smtp.client-ip=40.107.21.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OVWq03Yl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddqCJtZO3eVS94Hz7PCvGfh0seEl/pChRfgqlbQjrh15tMer/idsUsQcPhpmrA5KlMyYxIaF3cVTyAdB/nyIz08AkblN9HLMYH4/nyXkl9pe7Yw/a/sn3gvpgrjGhqXl6HX8uhd70we3YcP/md0gjCCr+Cq71TDPSQYpQopKqcZkgXfaw2sCDzZFC3aa+pfu9oUK5iHKNWFMZ4qarwfo+La8tzdUl5kH/rQr+0yeOZBxUV2/2jbBjuNvP9XR5I4HvTL/C6GMvLFbXM02wu3yHPyyBltvYwHNUySbo75oSV0reek18lpyzFYKlxleWAzcwCtwiy7JMMRL/V6wVXX4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C821OJj/KSUBI4xpc/QhYYesuIcr0XNt/ef0Ypt7m4A=;
 b=JMXnGoW6aeZCxdVcxm7enddpqqznUSmqVVWjUqY8tIeQahWtLMruxC4o8j5JcNQl2izbcTG6DKg2icmp/F/Q7cN8RHjkjtGdVox/N6L+sMN1KSdzke/Kj9X1PVGgYVw56KtHJzw4ZAg8vY9YNopdxo2CCrTWzpVjFWvQOiC2JkGocU0pGp7D0ZTBU0Xf0DWjOW1ymo8KhvZc2sf0vvOge29HBbmyf15SGai8QZi1mhtFdyOup8ZVk6wfHLZHg7wDenXrilw7vLTe+Z/m6pQPaRqD0A8MXUMh55CGoQfv4xURIyzKvqQ4eVXSLJoaLN40lZ/dkrB0vup+1Dbjye07tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C821OJj/KSUBI4xpc/QhYYesuIcr0XNt/ef0Ypt7m4A=;
 b=OVWq03YlEsKDMcv1N8zTNEz29ohhr8LFQE8H6wBrbB24c3Ju5fY3CIYRIdb8LQUI7qCk12/DkTdcfx5uPLxUfK5327ZVP2xbP+/R2NkfpX4m7Q6C6tr4YkJjkvnxpio2AaPvjyOgaGGWtvH8+wDPR0j6xSIwTvW+g8rwMpLmaRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 03:03:41 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%5]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 03:03:41 +0000
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
	james.clark@arm.com
Cc: linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH] perf pmu: remove one dupliacte ';'
Date: Mon,  1 Jul 2024 11:03:39 +0800
Message-Id: <20240701030339.56424-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PAXPR04MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: fea95cd9-3ba0-4e9e-c652-08dc997a6956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9vMAhhx0/ktXFzjl37jK7K1WktDVYTOHmMXUIfwkn3y3hV+FgJS1K62/yqIy?=
 =?us-ascii?Q?3R3H5NWH/GCulwV3+WJgcKPxHVwoTSUXvNGlKMiEG75G3fqz4z4LXVqIrLjf?=
 =?us-ascii?Q?g1+m0HBpbUMfYeEPtwWr4o1JtVTBqt9cqzjtmD1M0/ac0ji8qE+BopQe6vEi?=
 =?us-ascii?Q?2HN+5sDvg/SSJLD6BzUWssdmL7MbZRcF/mBQYYD1efxlvEsVR7X7NfZ73OBo?=
 =?us-ascii?Q?fPCZkcrpEhg3QRa2ZUvzNdlI/inF1/IN6rCOgbFqLSo9y6Nya6ErZN0WLHiX?=
 =?us-ascii?Q?J64lDOgFlSHSmfI4vwiS1HaUvA9Q5uI26LpMcK2phFyQB+HYIWBg0Sz74Z0M?=
 =?us-ascii?Q?Ru8Mtr6OwsB1ucJpSukzAE6WSjufmC4deBq3LA4WtgYgfv3sAIYRlsksGkAd?=
 =?us-ascii?Q?joOGHDu2cauI77omSQH0NK24pkq7d+ud8R+etFmsCM9ROI1e1fMGilfUvYZn?=
 =?us-ascii?Q?Ith6PypquRPyL5bTitlO/lnU66ce+T9rjbkwI5+zG1xS4p5EN9HWL5caXJq6?=
 =?us-ascii?Q?o0w63HpvpjB13UeLuNqQRX48zigYMLIUr96XxbmKe1CiJOOlLhCouxsgqCjB?=
 =?us-ascii?Q?vM8b1dm0pyPfmKMqN3ZD2qKgcR3oIqY1EUoa1l3yfgHfbf0Xeu42wFMf/E4G?=
 =?us-ascii?Q?xlQM/J1CSaJDNNWmAsYmfb7obYgjp+16UpsRKQDGxLQokPmGIDG6fjtLk0ms?=
 =?us-ascii?Q?6c3SGNCj9lOGGfNNcGywbF1dltEQ5vc1wMygrvfIuiQYUOcZCcHJjyyx7SLd?=
 =?us-ascii?Q?kdmTkMdPq5pBN5lvfEyvORR9wUY2HNZcLBDYoU77zREheBNED4SXE1dW7+qq?=
 =?us-ascii?Q?NoQPZiID877SoHcbkDJK2dCwfenGuD3lMtQJsGi0sTDiqsQvYlBCAPb73OCP?=
 =?us-ascii?Q?1m68SXFJnobgpdAkzp96+3q0QZxnZ/AA8+RcyROWyqkNldoTgd6DSzlkrO2m?=
 =?us-ascii?Q?Mv/4Yip3mWqXovNESnDvFLuvM2b45zoYPNERBITl3Ajjh497PwGFeQ+mqHCR?=
 =?us-ascii?Q?oTdeYvpDLcYc8YyVVIcbqvfigE8EVFQDAh+Pmo7zyLV7ojgooc60BhvXXusA?=
 =?us-ascii?Q?BZ5DsrRoW4mLvVNDlxwDv7EGDbQlSW+2ykxRx8o/IzjGN91+MCghOjnmOR6n?=
 =?us-ascii?Q?9+RmHHdiEyPOqVDFytWXpR3bB/RV83o0Tzg0/SDpmeCeH356/Arpt6/kTONL?=
 =?us-ascii?Q?/DJtaIsZV8Qm+21X7S3ZSIltQxWoBdnpQhhIeNuNCSuHT4Qm1fl+VuGjPAuZ?=
 =?us-ascii?Q?HyoIyc4YLxZHh/198slOrC/9YOZbrdz0MMys9lP3J/hwC63pLVIZtFb6wIgv?=
 =?us-ascii?Q?6hLP9Ia1rX85PqopQdNOzfBbren1wZG6fd5YwlDvGPwABcKKeCx0XrqI4PZ1?=
 =?us-ascii?Q?lPmePpPU1CaOvIghbnxCIymlFGqHSR6PnqBw6V8u4oZ84eS81lvaLonCVmNl?=
 =?us-ascii?Q?CIEPjm1TSrc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rYwqhG0YAfETYZJdv5n0zvtYknzBjqVEXaKGYXE3CrXSZClUgiJM6UnC4cY+?=
 =?us-ascii?Q?jys4fkqlr2r0PkaRGMV2grenw/ACc7YymtG9apLxKygp31/FjLi6Dn6PIk63?=
 =?us-ascii?Q?TljW6Ugeho3/zCsyC/U6/A8c4sT9AhJIwNuCnFvdWe/AwQ2iWNtPCcocmJyS?=
 =?us-ascii?Q?y4x3P90GcMfOeI1yLV5531u4dBiIhkkJf+BH+DG8ksTVBA6FqdBnqQ0AD4lE?=
 =?us-ascii?Q?x8wlK0OcpmqcDwp0I+EZeBVWGGRT4ND1Qi5GI0em6U6k+FBImMXCbBxE9dYO?=
 =?us-ascii?Q?omzjBhm8li0YIL+EKCf1VDSCkLuuudla4jIGmBKaytQC287AugRVWY6nopcv?=
 =?us-ascii?Q?VDyFjAgsxzoY54Tb6oiK7TGeH7R4ZXf/El0fPF3+VKJeOQMBEV98UOJjPo0y?=
 =?us-ascii?Q?S6PFhj02s607FBc2jqLbz0S05Emvr1U3Zvd9jy0hU4S7aglUlNHZumfKvwMc?=
 =?us-ascii?Q?BFtgh5LtgGIaPlxRmlWO5QlHKnRk22meeDYVF7qP07bMHnQncQ/Q9x7KzluD?=
 =?us-ascii?Q?8u6/VQ/4ExazZwYyNny9po4fPg/3klA4n7Nk/sgNiWlWg9dbyjAuwRhiiIou?=
 =?us-ascii?Q?KCLyBgV4xFd4WqiB/QrQi9VhesROWYWjPC5c4zjrrxk6XXkytVrwF8MfhzUe?=
 =?us-ascii?Q?DeMt7vycPEAz/aTQbVoKjihxLvaj9a/pi4tXLq1Yg4km4UTFvjO5fD1F6/AZ?=
 =?us-ascii?Q?dqQqcfgtxUkYlZQXMoMZp+NhD1I3BaBhDZaELX9kQl+OHjN9GuyyzOyOKqBs?=
 =?us-ascii?Q?domq3USqn2+vLIHH+k5Vekfe8SC+fP/4e0mPX4SbgCck/h41J+EexeQrNlqY?=
 =?us-ascii?Q?7G0tyOrKlo4GRro6rKEGFvC/YBsG+/KVwAsPUGHY+RRiBcYANdqo7RCQr4pY?=
 =?us-ascii?Q?X8YQYOZr6LWeRejSt7rDNfqGu26JDljnuRk9iXugVRKl8RyFv/RRhh5jFgZ/?=
 =?us-ascii?Q?xeXD4D4eA5ATDwRXwBA5QyLjEwoZDfDwnuxhq9YNmAZ0vTaq4mWnbilCz2J3?=
 =?us-ascii?Q?kttuOMMmo0us2II1IMJJB93gktZLVg4OMjfzg+GBGodUp0XoydkENIR21daS?=
 =?us-ascii?Q?7b3jumWvi7s8YPOhPq7x5f++Nv9dOa1j7uIWyt2G5RJE1zGOkma6MaJchm8R?=
 =?us-ascii?Q?JPK9ArqJTxD8i0d4nsCayGwNi8IUFsfPrMJN2DFylR+W14x0mUZdyMeVbmsi?=
 =?us-ascii?Q?kIGrZzdVYn1/sh4ftmilYWLjkm/1URdSSfHGUryHl0kcpv/3wZRyJoA7iUMu?=
 =?us-ascii?Q?MxJjBe8m9GW2dCVE/8o1kZoo8FSvCvM8a5I1jHaELtO6SOWpzBboy/pP3aMY?=
 =?us-ascii?Q?dXqlSzm58lCvy6vEUA8SJKLJNRJ5TyRJ54oeTGKeJftBytu/TIt7/6EVygaI?=
 =?us-ascii?Q?+7IA9YPYHRG3vlGr3P/tjTFrNCSAaWXLmacN+6j9A6OYwNwjiznJws/nNPy4?=
 =?us-ascii?Q?oUR14K1M5RizS5FFN2qqhhs+P+5YJfddrr5yypjdcFgUCAA3wP7VqWaubRKl?=
 =?us-ascii?Q?PKaqzEEMM7t5bLLZy+l/Crg7VBd+70y4L5RzDtCfvvG2huLdZCe9cNFYj0mh?=
 =?us-ascii?Q?CTx0WMdO/NgQLHSmHzX9N1FIS4PDBB++whyFpKww?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea95cd9-3ba0-4e9e-c652-08dc997a6956
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 03:03:41.5733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPU/kuLyaxhk/eyMXjc38u3AoSHX5RmYCqgQ3H3LJBZoRyo3vInlWU9LWRPaPvyvbVBcK4O5r9Da9npFpmEWvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8749

Remove one dupliacte ';' in function perf_pmu__num_events().

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 tools/perf/util/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 888ce9912275..d8726ec5368d 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1765,7 +1765,7 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 	size_t nr;
 
 	pmu_aliases_parse(pmu);
-	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;;
+	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;
 
 	if (pmu->cpu_aliases_added)
 		 nr += pmu->cpu_json_aliases;
-- 
2.34.1

