Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33B7172BDA;
	Wed, 29 May 2024 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969912; cv=fail; b=qgyC70X2orHqq0KgVFkD84IASfhN3raKdbgc1sLN2xxg8oLxzN1yLTGtEkgG+a+mWgXK1Rfsyjy4mIGJQMrlp2VAvuuVn8TCzZJvBuw9E3xEeQREKjUSHmo4WhncEPFRWXa+RBghVGOm6f7mE3DF+EnWP/K343FQxm34XBHVB7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969912; c=relaxed/simple;
	bh=gZ0NCVQJwcgzPfg0K2dgAsID0DSlDTtFDocYQJCKjcg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U9FmfHOqqPtLHQvAmcYN4oIjYC12DeVgVI2H+XKJdCUBj78viaTT2UdWd9W1ILFs8m+utP/oyR3IdbUiHQXuFob/hJYy+SOM5Y85FXNvrkzQvpf99XHjstyyNIqNYpnMyLzEnCi0TCyk705/aQ2BJzRPZQVmCr32qhsAIYL5TEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kwUAgYpi; arc=fail smtp.client-ip=40.107.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kwUAgYpi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ak4Ot0gi67jgYjvwhRiSd4LzfMdmOhuxjTZGdWnXGBR3hx/LoWA2iK7yI0UWxs5Tm1lI1Zu3j3jK4N2jVUmLByL/p95Lw522BSMsyAkmBDukk2jxT562eFrkQY0BwDe5vsQHSfx3w2RcbzPW4gipakF12prlbmJEEV3sqxmmEq38cOxMqR18N9NFBubEAxbhgUzCs3eMB8uVZznvbEDHTUgHXdtFSXHfp83F3MMa3P2Db+cjBfBWKGOxTMru2qi64ZMDvWGrWZtT+KlX8O4N52G68wUu1Lhd2FbWR6keBVAEZH+u1BF9EJIWWXxRvtikG2TxGSi9IBe/R2aEuT6PZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8xW4gHqzM6JxKa4WjuUK5nNtGxgGV6ViWbKIY4RoX8=;
 b=mJHUT8ensTByAyqG9lYhKwyN05Sxpr4Jghw+HGtobFtvW53JJrTGcc6AwsSPj6h8mQc/H5xRCXDZgVqx57ONHrjLhk5Z8vlNHaXGMS2Uy4P4PxgiYCBIn7ZqE7/4nMn2p52UmVZbroOvFRZSvOelYgkhvr9BbJhj1lq8Q39OU+tgJPtChlJ5jl1FW8wCSQSBYabfJjc7Xdv0Ij/x1y3uSNMQwcwzom652MhUQG/uBHJoogiRBOY+A+q5mseMpbOxgZjGj9lcSMD+YytwWjR2nMuDKb7keh+fMGTv/FrrVXQXe5Sqw7A6v2qrK5NZ/m6WJiFe9DsHlRH63dXBJ6C7SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8xW4gHqzM6JxKa4WjuUK5nNtGxgGV6ViWbKIY4RoX8=;
 b=kwUAgYpiNq1oo5ggUyfaPaJoPC1zJey0S4qM7U3hb7DKSMiIjCX1rBLB3ezxU3dneAPbjJ7TFd9QVaB3gHoMTiRazLoXwGSLjvQevfdKkr3TXxmCvvII64qphPhY4KfS8130cG7WOGkvqKQrlQjsJxwbg8Ib0YGcpGtrxS3wRqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS1PR04MB9384.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 08:05:03 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 08:05:03 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: frank.li@nxp.com,
	will@kernel.org,
	mark.rutland@arm.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	john.g.garry@oracle.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: mike.leach@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v12 5/8] perf: imx_perf: fix counter start and config sequence
Date: Wed, 29 May 2024 16:03:55 +0800
Message-Id: <20240529080358.703784-5-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529080358.703784-1-xu.yang_2@nxp.com>
References: <20240529080358.703784-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS1PR04MB9384:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a61e94-9ada-420f-fc99-08dc7fb60b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|52116005|376005|7416005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y+01n+xo27SREiOPiWIY65Y5VUCj6QP+sHdomi8QB8MSiE5Tam44A0j7idD9?=
 =?us-ascii?Q?EBXZFHLEnKjf07Pa7V2HI6NygzklG8vNrrc2mEynPmH6vWimp84i+Ab1d1/T?=
 =?us-ascii?Q?fFlUSR/yLpdKXTIb1XKqPxoOY/qdZepLbydZvPM1Vcdrr4AlZ/jjVyZBy1D7?=
 =?us-ascii?Q?mbIHQKCIynYva7f+XS8+rpproosG1HPSqr3EG3BHLHWr9v/be8bf21gt/ZqQ?=
 =?us-ascii?Q?z4+dyz3EWzoo1MJv0XrbUgNswVqBTKc32+NOrrNaesSKoQ0OFGRf52OaLFnd?=
 =?us-ascii?Q?wWkb36my1TA/7/Rtb61uamrI4OlR9+zsgN5/P99p9s0ii27qjrai03ziB2dt?=
 =?us-ascii?Q?/zcDp7/bU+aq/L6srTVrfm3sHXhfn54WUqv6z5A+cUMO6HQs3S4/Q5gd10nN?=
 =?us-ascii?Q?ZIigYieCI97oWNfT6XQgdDxDyLlZHZxCyJ8XbzYsQcCRaHCn+/nvBhGDu4fk?=
 =?us-ascii?Q?SO4+rQ26p8saHdOPnd5V/NmqZ+/EvD0dv5QMof2hIaEii+462aNAG5xMROBm?=
 =?us-ascii?Q?lzERtV78qnyIPOTr5Wo+Ed2K9oapmxF9yWVnd0iW2/iNaddAWAVtvrmRx0dk?=
 =?us-ascii?Q?WzCEuBwYvgiLwLigeZ7SceP00di1BJB28CDNrbcAqUlCDYyIjvrfW8ZaSIY9?=
 =?us-ascii?Q?ELtUTYvL83Y+nI6xCHsFbVYpETm6UCysTiwqKaMRVWqX7JNjSvKLuT5zDV95?=
 =?us-ascii?Q?YD0FS6EFOqq2ipKaQmpCtWEJbC3JgLzmMBbrTmk6OeVemN49XFAROouQ3cjB?=
 =?us-ascii?Q?qLhnExTbyZ5ZaTxdF+bDzRAiQOFhyb8K8QCQgeNO6TqyLRlZZwqqqPgKCxeE?=
 =?us-ascii?Q?mrSod1qo2sO7OFdlfdsImdjPH8adRH03KNZNrKT+8IB3CJkharuHRjZOnFXc?=
 =?us-ascii?Q?9GxUW3l1sKicNR1TVOlTUp8tKJOTqEcuNMZVX0CYqGZyjaihfgjAl0LSc0lT?=
 =?us-ascii?Q?0PplVgkcKFxRipxY5Tq/eEE/3GA+e+bQDuDZ7B9KIt8cyFve6rRcaWInBcHS?=
 =?us-ascii?Q?eef+DBa/NebGKaBcZKAYH2hO82Sl/XcwIktJG0lej2+Z/4COhFPCspJxST2L?=
 =?us-ascii?Q?w+v5I62YReDTPM4y/9Z26boxPMHyE//gW9YpxPzhIXNxKdAVTLTjqh4/6gIv?=
 =?us-ascii?Q?uNSihpmV/JiGdyfz/Dz3vxz2Z9zKS8Hl2JyJIgC6AAAp2oRhxZ9ThZkPdY4x?=
 =?us-ascii?Q?Poy8l+BzzyOIaNeJ7J5C+0boQ61fUMHqxXArex0av1ZM1h74sZUaqgA9oaxM?=
 =?us-ascii?Q?i6zhnv2bOFH73Jc2dpxtm4Bn0di2rz61vquvM8+Q+6ArlbpKFkk4NyOkH353?=
 =?us-ascii?Q?5B587mPQbCLhKqSwvPPHrLKqJQ0j+j+k9kq7w/66KDE7cw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(7416005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RfsEQLoBqNSKhUNCRGEEQb7JZdtEds95M/R7xIMhzlOtcF7lwE9bKKrTk6YH?=
 =?us-ascii?Q?flnf81xLw05VmFWF3zlpQLJFpyuPlvYbd5nZLIp7pc2DqBcPQdqhSvo8EhMy?=
 =?us-ascii?Q?sx/yrip3QiyP+OKdWpwG8art3DX4+vJVx+ozEjLWP3PMQCSG8PnhapTMHbtM?=
 =?us-ascii?Q?JnAEkzylVjPsN2eSnWF8njmSDFQhOURaQYubXQ7/GLv8a09kLgw1dsPQcygU?=
 =?us-ascii?Q?mYz62wkeEFITdeBXkPRf75xYWXx/UOIHttRAid+box8LT+Gp8gcqXiH5VI51?=
 =?us-ascii?Q?jeMpttWMulTgaGHsDeOp1vRTRs49iFKSL3MVGB2kWfWG+taz15WlLlGlLddC?=
 =?us-ascii?Q?DNsi/EAwEdNUO9vesRGjUVAmCuFlrH7kh3k5zpnvs9le5OtRczpzAnRHcVP4?=
 =?us-ascii?Q?yk0xMhxEiZ5KKEmLz7ZJH0duMR++BMnuF6/vMxd/blh0EJZVO2k2JS1M32gV?=
 =?us-ascii?Q?lkdUs+olDz66RxUQuVHItr5U83WWFyrnw9V4LElN4Hnsj7351KydiXAwmXTG?=
 =?us-ascii?Q?YJuonnkfohgAVfl5hd8XE5T5I6vCtOo4vdo2G2I11Xcc4BixwgSPaYQTTEDz?=
 =?us-ascii?Q?OCO6wd5yu13bCe5M8IpzTDDlKOwKcbR7bZeg7WWoGHyNgCOsXIgaor5rmkvb?=
 =?us-ascii?Q?clwq1atlLbPcpgZl87kd4mUh6fLNgc3c+SfyCPQFUv7f9XoAiGJh50LpRuM2?=
 =?us-ascii?Q?MJNbY6RigaYhyD1X79Gq3kaqKvb3td02oP1hLqRDp1HMgDG42kLG42GEmIV7?=
 =?us-ascii?Q?p90PrWGCYUqgHz5OseWljC6aebwl5HPdxNqS4nMeg5DmDfVyb/2IFSHVRJq8?=
 =?us-ascii?Q?e3pte/tQRJL/yp9Yo9JSM+D4dcDVfTTKS/haLnWWHkbD5uZ9CtNxtFROS1oD?=
 =?us-ascii?Q?A+bS31gVKhb/tEkXHcqd7X3Wte0I9MdS8LM4y3PRKBHOuW5sb6iZiZTsObMz?=
 =?us-ascii?Q?uzPd6tlfoe8jIWzXI34MDyB7Ic2f5xVHH74fEhQmstQAaKT+9lZrWqVgxxID?=
 =?us-ascii?Q?Y/t+e98gw3u0k6qR6G3g7AOe8PSp+WdeKKVIfFqR7NIsOtILWAXCSpFkvNry?=
 =?us-ascii?Q?zH3ECmwrkRWpEn/adwFXkZQwn0drjhY9nYAtv5m0JNs16sEHJ1lZtDUFTKDV?=
 =?us-ascii?Q?0SwIMOFpZPjKQst+vOg3dPbqviNlka4WeUDqpJkXyF5XZk4bEZEQkTATxKGm?=
 =?us-ascii?Q?Ou5gJYfHZ3+5UJQYb3kov/0SfTtvGgIIfpxcLSBqkuSqKexEqb/WCQON8OGh?=
 =?us-ascii?Q?hGL7AXLoApyxxehZELldUCJ+eBExiVPtucJ+p+eazTdMQn0nYyi6qwjUkIMV?=
 =?us-ascii?Q?NdpcLcdGflnKcYduzUk0ZUdwr61L2ANQSHIl8VtY7RGl4wb60vb0YagQrJla?=
 =?us-ascii?Q?QT6FYTjZmSnsjPu6efEKXqajkODhiH8YRnmTtBM5KWT1dYgXQRev5qhCkuqv?=
 =?us-ascii?Q?bYA4V3rogxHBlJkETg6iSOcnAnz1QviaHiDRUKkp5Lb98lwjFfKRx0Vx6dVS?=
 =?us-ascii?Q?zexhJmMWiWEr6x87a6LiTlsZC/bKwntbyodnee7Jvycbbkim4rX3HjvIwAWV?=
 =?us-ascii?Q?y34/SxWa8m49IWbs5h/TsVU3Yf1kxcS4uIlDQzH7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a61e94-9ada-420f-fc99-08dc7fb60b74
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 08:05:03.4249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JV0NXT4DtcmZTtjEsqLJqbxpPGdQYv6pU1pwG+S7X4EhClU4ThF06oThhG7Zw+7vD9C3rnSd4FjD9s34goO9Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9384

In current driver, the counter will start firstly and then be configured.
This sequence is not correct for AXI filter events since the correct
AXI_MASK and AXI_ID are not set yet. Then the results may be inaccurate.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Fixes: 55691f99d417 ("drivers/perf: imx_ddr: Add support for NXP i.MX9 SoC DDRC PMU driver")
cc: <stable@vger.kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v5:
 - new patch
Changes in v6:
 - no changes
Changes in v7:
 - no changes
Changes in v8:
 - add fix tag
Changes in v9:
 - add Rb tag
Changes in v10:
 - no changes
Changes in v11:
 - no changes
Changes in v12:
 - no changes
---
 drivers/perf/fsl_imx9_ddr_perf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 5433c52a9872..7b43b54920da 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -541,12 +541,12 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	hwc->idx = counter;
 	hwc->state |= PERF_HES_STOPPED;
 
-	if (flags & PERF_EF_START)
-		ddr_perf_event_start(event, flags);
-
 	/* read trans, write trans, read beat */
 	imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
 
+	if (flags & PERF_EF_START)
+		ddr_perf_event_start(event, flags);
+
 	return 0;
 }
 
-- 
2.34.1

