Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2089.outbound.protection.outlook.com [40.107.15.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E487D76036;
	Tue, 28 May 2024 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883082; cv=fail; b=uiWjrYRGG79icz/eAREwBaWeDun4FEYysMFGaFBLy8odE9fuskqQYa3fVNU4Fv9Y7xdiTEugPN0j4XAa2vfNUKuFXBGllXWKr6Znavww7gouvWygQreDLUAuY2bw5rFMkRjJ6Ve6nU2dgB45zulfAaQ49Ov/Qn3K3EQDalrlwFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883082; c=relaxed/simple;
	bh=e7p6JeLdSdK3KD3Xh6wWDjQRYiFUFJfIpuVL3au8LbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CTRhegGpH7kQiezyNP396oFECOnUBLcbbe4X5m8YGN2BkunoPUQX6pA3AUdif89BtAIQpVI0I6preGcLgE/jKqi30FUGE/Mj4r5yhDDCU4cOLLVfsIyISJDwJo+QzAw7dV7mcXnfHDE/qJNDImg4RHRMxIiSDs8N2s8dgVCp2Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DyePhYs0; arc=fail smtp.client-ip=40.107.15.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DyePhYs0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/GxL+RNlrbtgN9nZJSM9DlyZJUrYMOODVWK5ruaWoOzzDRB36lNdpSOPd9cFTAco8sUq5YmxJRgBmGs3MkBNquQh7xFs4NPKpCc+gasaAhb7uR54aeb6QfLuh656leqcrMaD6GLd8Gu+fdBu54xc2j9Bj8bntCLsMFVha5INzHmz2OndvNL5g5hrYzHVKKcj/9sjg8lPbjuo8cysNB2QsAWhn8zBubG+Gmcw6bAibwz4rjv7BzJTlWnFqjaJzId+8wKxBK5U5NsdUUVN4ZQvxPjXzd7QSZLCRdR0/p+XILicknXNluCoYaTXI4PmG1Hu1QCPTZjHeWC4fsGVWzAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxs2UV5b13xIL4BQtgD0ckXFolLoCO9Ne+Z+f4ShyOM=;
 b=WSz8b94ysoaPFRJ/MMI2GFFgDfuHUTr9RbJHWmNNj2caQEx9R2Cm+YWlCWLZrA57NiyXLWqdkwZj0LncCbi0M/kEzNyRQbVXKmpUXGXFXDaWX7u4ldfdz6waLvKMysiT3zacqATw0d5pExW9yprmuexh4rM22ygtPfa8BfEU7xr5CXwi1uyOvO6OexyTEYrEFTFhA5gSYrjYkrRL+zPG9E2GsdubhZ+Q/lRLmpwcWmNQbejmRVuTMO1nykfMOc62BmG8FZ5xc5yIYncW6k25Y5xbEMfqE7eVlad9FW15xg3mi5kv0VVIwDZC6LI8JnCuYCeCnXDWqkznWn464qYa/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxs2UV5b13xIL4BQtgD0ckXFolLoCO9Ne+Z+f4ShyOM=;
 b=DyePhYs0FHg4h1pOuQUeJvw59Vt9nJzszbITBIoKzHCvX1zXWP0NAW0nclk7q+ixcEOjMt7xiG89/bzp8jsoMra1F+nIjzIuyd+2fjJhRgfaGO2cyh/6bFAIOQbBLWb6nf9rNiTrproQe4N6JVWoT+dVffJoRBGdgKD1c/49j7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by VE1PR04MB7229.eurprd04.prod.outlook.com (2603:10a6:800:1a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 07:57:56 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 07:57:56 +0000
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
Subject: [PATCH v11 5/8] perf: imx_perf: fix counter start and config sequence
Date: Wed, 29 May 2024 00:05:20 +0800
Message-Id: <20240528160523.1695953-5-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528160523.1695953-1-xu.yang_2@nxp.com>
References: <20240528160523.1695953-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|VE1PR04MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: 9427b489-d43c-41e3-9558-08dc7eebe218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|7416005|1800799015|52116005|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SPVVWJT7WH6ogoFlH5nmzob1JuEwYx25SJfSireYC3ShRnXEpyNgTVLX8Lpd?=
 =?us-ascii?Q?YqIUr9QnCF/USyLQ8/k0ipca3E33E+dKc1yAKQLkE7CY1PYSDvZIeaPP9KYx?=
 =?us-ascii?Q?ZrJCFj6tJaydBDWrP3Zy4KaKTJNNR4WiOfNGxGChH4A5yGp8+Ue/PId/UIB5?=
 =?us-ascii?Q?im/jMQ7N0PJ34oiLxcesuWDvTdHyXLB9mALncgbE+IXMS6AUGbwRo2gklx0c?=
 =?us-ascii?Q?rNBC5oAMlkGVc5PhS/A6v59ZJhdDonfP+gYCt2q21u2BGUBllEH4VXKtYRzi?=
 =?us-ascii?Q?efWtFeO6amNwmYSbENtqTDV5bVyOWZlv8V0rjrVfMZjEm7Sjpup8wxDKveNZ?=
 =?us-ascii?Q?4g+CrRe63pS+ACT7VXe8e8alBQObodiyLP6MymV4BZkVlpY30djyw1O64t6q?=
 =?us-ascii?Q?JE52/U58rg6hcMdWXBntu9Ou1pWmghxmETo4mvKbAqr+iyy4e+/AzmmJI/YW?=
 =?us-ascii?Q?HFp9/iuVVTAYAc1iwEc13TiQItmKhTOXR6Jg4MYrBtHDRF1trEkcXdPz1fIQ?=
 =?us-ascii?Q?RyNGREiDoMXor1GtJgW8EoGDMXRR47SQTiK1akdQo67fBi50sEiHzTeojt06?=
 =?us-ascii?Q?qdpKfMK7ffTo5TU6hxMTDRkh5H9Dct4AclQOEEvfBUJq3ihZJqyhCuqxxbOc?=
 =?us-ascii?Q?OVIFVk31XwSNCxJRfphX3g5ePwAFXP81EJBn+Iv+raPFZRMxxC1R9OZduLtc?=
 =?us-ascii?Q?MozbfLlFZxjkr+DZTq9cuvrX2lADW7j75J8sNdGWyCan+l6X0BLKbe6PWsk6?=
 =?us-ascii?Q?+DXi2DBkBGs8L3dCFp3C3dhxuvXp/reJ+i3QBHBHvvRkgMNC6ZnfVHmgw+Xd?=
 =?us-ascii?Q?tdN/zuBiguxsJdY1QORMm5wFeZtKeQ8YPhUMIazqvaHQyEDJN/TBZtb6Z/f3?=
 =?us-ascii?Q?ppu6JTGBRtAj4th3UliY9HgRI/qmFXIC4g0fkhOgK/mI41bNRxR63XEupzwW?=
 =?us-ascii?Q?UYXiO3m4VrrzQKXlsEF1Klvnd7eDigiePjhRm9loWyHkw9bRbNoT+bORdvMt?=
 =?us-ascii?Q?835FeS0gMqpYlfSO2HdLhVSkyBOxlYw3x8OJ6k4/DCnx4osBJjO2Pr3NoBHi?=
 =?us-ascii?Q?A+g2dlFpjK4dKMfVyj8BU9BN4y8w2DG7Y+Hr5qzXhg0RZBPZDXFGIzu3B/aL?=
 =?us-ascii?Q?fhSzx1Qt+NZIq56WuXtJ1rdCuWzOO3G1ILgz1CWU9SsYHzEpf1NUM9fVZB5/?=
 =?us-ascii?Q?xMFMFoTFjcnvUL9SEegIGoJYhM17mX6On0MUJy9QSZ4wUsSDHsvOv81qEutJ?=
 =?us-ascii?Q?N/OE3I/nQjCfKT8MSgtVGrJTBhzQTzoh/ATPRGQQFiZGRQ+/CJwgTsrbSm0K?=
 =?us-ascii?Q?sancaxz9/edoY8NfOASr3v4TgjoqsH9LZULKl+i/XONAGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(52116005)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lDRkQX5776YzdLJR1ilwkVzqVw9ES+HLDWvXu7edY9eii4rodv+7K40HPo5H?=
 =?us-ascii?Q?BWjOzY8n2z/8SpO1wZWBQVQFD25WLVVTQBTXeOMG7JgZNXRnbhhSfhtZB3Bs?=
 =?us-ascii?Q?4g/a7sBqXC3z23LsHrlvzmBIIxJEaluUFeWDwdDOmjXKY9JC8ek8zEsSWolp?=
 =?us-ascii?Q?KUuA7eYVH4LUTv8LL7DEqH5Y2GlpfwZ0cXP8/+G1b7gUysXRBrj5jJtzl6L6?=
 =?us-ascii?Q?n5oYRjXxEYtjQ5d4euDlu/DwLAW/qo95tKGnG1YIfVGcXSKR+HtHaXW+wiPX?=
 =?us-ascii?Q?bRaSCaBq0ZdW4SY9tVZD177ZBrzPnAttJcCiBOwX7U8LJDqAqLMTqdCj1vhf?=
 =?us-ascii?Q?B6Fy7nFgDIofqWfeV3XVW6jEHFZcuFDJrjh/hl/gM0W7eZzn7Xz84Iq9WYtJ?=
 =?us-ascii?Q?b6dKxt6rAfYzCEt6DdSToFkbHq+qpihGx4Rp0NO/uI7AfEHeTiX8NeJkzJP+?=
 =?us-ascii?Q?3qU7sW1B/q2vnUgcov6AR2NP+HRIHR3qrU+q3ifMiCnH5/vHiHXCdLBLnuFY?=
 =?us-ascii?Q?zQL7Y/mMgmMrRnHaT2T4fIyRqbGSDDDvcDIUQUo1DV74a7t0Ooym/9t1fvXF?=
 =?us-ascii?Q?j3Cv+26gEdSwOpfFAPb8YnlLkVdlAsvaaQz0uU3poIFLwsCO6ul8U/fEmydx?=
 =?us-ascii?Q?fBjGuXNtOVTpdl1LHEag4qklRQWAWN++xbzUIL7pvq1AAH6xFJXv6zLyWRQZ?=
 =?us-ascii?Q?LM9yD8WNBIjgLrD5GUMpNaZ5WPTAuriaajHUE8ADr8OjlWMyF8CNzaj7K3ak?=
 =?us-ascii?Q?7XtOO3BtUOvzdbRReXJw/LJ0Q3d1G2mUsK5BWZLRFgtWvz2b5KePRtaw70Qp?=
 =?us-ascii?Q?Ul4e75YrFpjyJDC4WIAMYpPQrn1EmVnFlnZxEn/9ryH4Tf1D4TirN0pfOd2k?=
 =?us-ascii?Q?29mbfUtaxU8nFHQocJyTz8C+SB56UVLILaAA/geLWRbOSOLQN4lj2m4qaVjo?=
 =?us-ascii?Q?CSLjePXboe/OMDCAxxCzhJWfXihXFkAtwgKueFLY/UfAL3QhXVRsZgmLAn0E?=
 =?us-ascii?Q?YDPqMTSVpa2lg0oF1NPfHT5YQA1mBDVHNBRD+wWHFBDM8Jj6ZIdWtNJhgv1d?=
 =?us-ascii?Q?ETI90oaeA4iCXC/dvE1gVPWE8eKX/lRFjt72uChiRkHcn6OSPEXyJQHBNuaF?=
 =?us-ascii?Q?Ip3ZFyidS4v2oKSjiGdj1pTNuqmLwT1s3OOYkxbjDRwGnR2Z2rkLNME/uEVI?=
 =?us-ascii?Q?+nA/2YB6grSxijjiDUkictG06xQPGLqWyMxkqNDWq/SQN+T6yRgeqlhAfTw8?=
 =?us-ascii?Q?EmCzs2kvujC2EoEMTHbdTX1rBI9K89NY+HWUIn/T3HLgXclkyPqeqrXpuHCI?=
 =?us-ascii?Q?3r3bY3QPbImYhA80rDMd9yo4U0hxZBmNyZVEXogOXpdZENDn0JamPEL7obQw?=
 =?us-ascii?Q?rzvaC5Sf2bf61nBwW4ZLaqSPA4nz7ODF726g1inQCS7BdVndW84ewRF6Bohx?=
 =?us-ascii?Q?NBtCBVyxLNUHXkELlUQMRtbKVRiMsSZMBZJIjOs9J+Oz7kRw7HzR6HjTW2Ro?=
 =?us-ascii?Q?bOr3QcifJEWJAfdwYnXK1a1T2MCXMCGoKw+EuXnREAxnSJV789CkcvVWIVkD?=
 =?us-ascii?Q?2pgowv3AuWT1HNU/CeRMlhMTL8MHXGefYb2gzjFV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9427b489-d43c-41e3-9558-08dc7eebe218
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 07:57:56.0095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sNSxjMAdbHvEZT8TPH4QcclO4+LQ3TLGb4gER6KUy4WDHx/ZaFbibVTNPoCLZmEdrv+jimLpVHjqdNhkh6vKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7229

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
---
 drivers/perf/fsl_imx9_ddr_perf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index d1c5495d5e48..26144916dba7 100644
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

