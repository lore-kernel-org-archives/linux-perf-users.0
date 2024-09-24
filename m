Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116BD78B60;
	Tue, 24 Sep 2024 06:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158331; cv=fail; b=ouM1kxUzyj/Kz6EBBcVUvlliZO5DvGIuPf85r7xtT6Hg5DUX3gVQXBXlWOpF3x9Kc5RgdlFmptHxJ1tQUpa7lsQFzbITowLLJk3M8TEUMv7zoqXgPTHuJG5SutD3XSSZpKLY6fdnmdV/atZE9tiiXjjvcCnUBG2LBjFh/zqvYhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158331; c=relaxed/simple;
	bh=NTOzOGpA8usIATjl+X98n8VTo4bkq4d2LYvedMMxOEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cBfceb6eq7MdgqqF22ihQmGqsA/Z32I4oyYEdQFcWEvjyZiQgKmx0YHWWHeXx1r3crTWgUDDXXgCPPVl+OXxqtazgqBpjkIQE0vwrsGQBvrrJRSiRLvJ+oHqFdCBz9rfHTi976e+F+a5iK/nvik6vJBH3OBovSeUuiWJZrCWJCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KJwO8dMr; arc=fail smtp.client-ip=52.101.70.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KJwO8dMr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euOlXPLcmcCRp9rjx5xKWxjSpuRUpUhTcOT2hJNwq/lY1SkMEA3+Belun05ImFAAHQx7Edr7CD5NFXP3RybqaQBJuTUTEy+IfBvDiSh+T7xEsYAuQQXHKMjHyjbuuXcYD0A27nV56/qwgNGXbtdMS6I69AQBWB8bNuKY980Yjq2WeCEYDf8TOGnSAEGF/FkQtsgI9DlLcye7OmuIxcR/mWelIlWrv244sIxLeBhEjqrA2KynJgxpYnuoFnXOqxhBwNuz3CPdbc/4kdXUdkOPfNb2JjACFowi2ImvvNB/6KtzsRVhjzW3axaqKAm5kV+I/229rp9nwTFda3Ey2gTIBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vLqfIYHHd20u7aM6EbrZbC9Jp9UzvfGO52jj+zPjEw=;
 b=mCi73zT0eUVhtN5YR/zCcZ5J5EA01zZORy57wuvu3590OD3BhW0fdZ6fp7LH1iLaK+8w999pOBDSje6LdtmyRx75YvTBZrZ3CcT1CjuL6EgM8lqCz1zQRp0UgoIbXRx0on3h/NjHYg+ivPYQd7vc0zBSTXV+IUQ4VRBoqcTvHsErouPpqwu94vuxWxOf+2weyEf2lHtdW1fcc1n4bkG55o5HDkhlBpeVDkLyDcWgq08wkJvtsYEYdmmhY6dS9RHjMhXecdt4aYqXncG0TLluC3KEeuu2vQx4OjaiLxGrmP3Ns5k9Szr92nlu69i0FvPb9A83+H8UtKNeDmGhSPKXEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vLqfIYHHd20u7aM6EbrZbC9Jp9UzvfGO52jj+zPjEw=;
 b=KJwO8dMr0d5c4bRJXi1A3+hfHbu/BWtFi0gU1cWYGvGrjaxd4Dq4MP3DY0aNqNbBQI1e6rElgaRvn2nJxo5816nKE2ZG6HTXMugzqk38tazy8iAMrqW+w3eR6MkYDCneFwlYWOOSga1mBP/xirSP+WrxF8CrHAmGS6Z8Qwm8RFxhdZWs5RY7nvQ3GrA+hU9K1MtEnsDUVY+yDEr2MXjT/EF35ZYCKhtfq88Vf3sSheAgGyaNJJ/1jCTXrvKRBwXqPAkZWydXkxeDAOVj7qh+geH6515SZ8QBHvT6DefOj53FNLJF/jptXMeU0/f4Ww7n/Ar5uwFfosfvEWqBBhS+oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU4PR04MB10981.eurprd04.prod.outlook.com (2603:10a6:10:58d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 06:12:02 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.7918.024; Tue, 24 Sep 2024
 06:12:02 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Frank.li@nxp.com,
	will@kernel.org,
	mark.rutland@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	john.g.garry@oracle.com,
	james.clark@linaro.org,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/3] perf: imx_perf: add support for i.MX91 platform
Date: Tue, 24 Sep 2024 14:12:50 +0800
Message-Id: <20240924061251.3387850-2-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924061251.3387850-1-xu.yang_2@nxp.com>
References: <20240924061251.3387850-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DU4PR04MB10981:EE_
X-MS-Office365-Filtering-Correlation-Id: d66df2f0-ca06-4900-67d6-08dcdc5fce8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ih7WOxV4yrLOTte2OCU9Izy4VIUTFju0rZ9MKpHAvV1V0kng5vVQkDSRQwj3?=
 =?us-ascii?Q?6DV6nQ395fgPf43TMW5+u7+WGrkncSUq/bw3LPO8q7O91rna5z0AGI/x23Y/?=
 =?us-ascii?Q?gYNjv1QpD1NLhes0nkoZMr//ix/obLGSXBybnVUOy7AebvC3y2m/lM49S5iD?=
 =?us-ascii?Q?B4qc7m/kLKovvZxJKSYnMSzrt/RW7CcjJZdM9Wd8JBUAdG0Ng8NMAFHtDX8g?=
 =?us-ascii?Q?n11yy1UXOoS/c840ktiEwpVUsBcnTAPoHUSnte03oX3lQIXd63Vkz2IG6Yje?=
 =?us-ascii?Q?HfQ1QRbW92h8Jrtk+Oj766+niB0jGLLM4sLiHHVOy3Q7SvjbaKznsPvXWnBP?=
 =?us-ascii?Q?P9WgUlbfffjvpGYV8mQfP3tDit7mCS0zKQCp9A/4/sCzf3bXemLocpVQKLdj?=
 =?us-ascii?Q?Q7yY1j541c+jKCLj1PMKrd6n++9KKueWaMJ6FzFnSWhuoa5wFr9vjryIvUxn?=
 =?us-ascii?Q?F0G2I3AYqpITUvdTDotS6tyIgvMCkemQN7qYJcZLEl+SqPbjvzPh7Psv/Nls?=
 =?us-ascii?Q?c1yGW9KeaFdXP6LMqroPTeiWtx3nEw8Yl30R0Bh3rJQbhGGPbBdZzkQzyHYb?=
 =?us-ascii?Q?OPjnCkTcbX1+9Uflm3PM/sTKjPVCTk3e+ZzFbab7YzFX6toazRR2ug+XX1fF?=
 =?us-ascii?Q?zoLOXl+NmjQINNuhstvnJOhPq7UsfHTdyGzEzQcyYkICqdDtlugNpojge8OE?=
 =?us-ascii?Q?2aOCktIpvtjMMmEPov+PbDjhYEvW2RpQvKaoZWVmQqVzjuiRUUXS9WmIcMos?=
 =?us-ascii?Q?0aMn9coYtHe16LpDvlodtBNTxUlNiBTIDcKVc8TWPNSb7ykzqe0JNtpu0M4g?=
 =?us-ascii?Q?K6KXs9AzX0DXFKm+nSAXFd5YUPb8ztVqbYGfWplxwDgp8fJL8iKjlP3xW3BU?=
 =?us-ascii?Q?3RNA1Yfln8xjdttI5DOkcWO2uHGd3NnQ6STtGajuLG8eWkBWI9sL4UXlE5Rx?=
 =?us-ascii?Q?eQCc/P8NkAJJQSEWBT69sFFN1cuO/levyyc6QcDBT0alHxGJ9VY0god5xrzH?=
 =?us-ascii?Q?aC7IJZDmL7iwTE+eqHygcc+8zc/TEY/HTKoe5IyMDaAdgEaCC0J7UevaNtLf?=
 =?us-ascii?Q?B4s6sQI913F0PliKerRNuLK4BrYQ3Oxayh5+tBYTRHqFC+EivLRn+b0JXQsE?=
 =?us-ascii?Q?L9xaODnYGlT2IjMuuzKqGvJS9vajnXAo57T747a1lskzDKCN8GANmas7XLdE?=
 =?us-ascii?Q?vvJS89LaOoXl/kYmwC1LjV7a0vJfxQiN/6wKDKwRl7GknYfrY3/pjMqfOotc?=
 =?us-ascii?Q?m1O6FNs+t7FM496e75i2ssQ5R8MZCKqf6KMV8QXfVVsUvC2q+YPYBmxP1dqg?=
 =?us-ascii?Q?8aVyfp29jmysSRfu+Yz9NfZEPL6IT5V7A9cfuTNiwiOL7QaPVuYzVscKOWHm?=
 =?us-ascii?Q?sECH03iE/BOhIn5CC165FKyz4QRiJb/7YNRwRGfjyB/tr55VIWD/c32KLwlO?=
 =?us-ascii?Q?ANv3d5ybwlA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?agvPW7wCi/xPMk2Z9C0A/mk+UpMkEeI4o/VLo/km2VAAyNNPBPUEPTA81+r0?=
 =?us-ascii?Q?WaB4hSQo3SUK7nLdeyrCPLVq/QgaYJlL+gYmanIaP7nRmmfOYHFSwuy669gj?=
 =?us-ascii?Q?ZK9Ed/q620ZBfWGXmX1xCl5fRdEFdwxHNc4mTMvcqYacROnVOPrDcaD/H+O+?=
 =?us-ascii?Q?7BJ8pyrxma5leKaUqe+s0pVxuTGis3JdNZLI2b3ufgoG0/OdQh/E4cYrlaz9?=
 =?us-ascii?Q?iaLul6Nugdjp7nnS1tYBU2BmZJaoUnGotz4QN5X4/FZdiYXwTFi/8OA6CDML?=
 =?us-ascii?Q?9ozxueWQx2/gcxGCx48fPp7oE1udbStNAf3CsEcxrz94OkBahF7dRLboP/f9?=
 =?us-ascii?Q?dkG/yacMgf+e5UBaUQ4joky7FoAazVGXLDUSpHv4IEHiaADNlm9YsJtRfDxz?=
 =?us-ascii?Q?c+CWKXBz134yfxgYfAIUOFJVfDj3gQ1y7lGLoLLNrwNinFvR1GCIlBdTvEol?=
 =?us-ascii?Q?JUX447+ghutS7U37N1qt5ZFpgQ+bikK6hbXw3bTAIMwNRmHnUGbUqhS7BKqz?=
 =?us-ascii?Q?u5dYTOfu3EJBuzhpfOxItlvFNMF1aNItt9HFJTnufZ7IdlfN/KmPxD8V1lZr?=
 =?us-ascii?Q?6KLdJuhV3yRL44JUHmHHvvdqhblQI8Y6wN5H2ua1yVhiCpmfESNYTUfjnKql?=
 =?us-ascii?Q?z6FlPlMg/Z5SZYdPDcqqLZN9gezIK6vSai6kN6oaCq4FM8V1WeUD4dKecsAH?=
 =?us-ascii?Q?3NVpY8zqljAdTBOUxkWZsgJkV9hqei3GYOqF587kOG7bjnAaRabcmTTLfEOf?=
 =?us-ascii?Q?6jfGIjnCLJQ3rymP3wXv94sAAOv3efVyK9IaX25kxZs7qL2pwCzyiDqvijX7?=
 =?us-ascii?Q?roHb+7adKCzNBNFLZaGY/lpRMlrFGG1EYAgEdQQi9uQnTN9yStaRsq9Ror+n?=
 =?us-ascii?Q?iC3gzuUCV4o9o7QB+7Ir5FdRuYXQBUpyoP5Ig9m0CQGSKZLbwUZdCNp3CU1S?=
 =?us-ascii?Q?1wy8+AbLaVUZ1ll9Y3H0Dtl56mMXkQdXMa7+eqFz6TVIRdlCzZ+cYW1yy3Q6?=
 =?us-ascii?Q?QYa5ZL1uJiyQMkoxCfZh3uYzw5hejbeEekeA07Fg2W3+8z99KZKWqJeNhZA8?=
 =?us-ascii?Q?/JpTY56HlMv71C7d8LMmJ6ZsjZs9HObIHxc9kdxIEvh8LKgHWNKa8dh0q3zC?=
 =?us-ascii?Q?jU/gQMjmffS8CHyhpHZdjuVSwbzGMAkuzU7TWDudI9tqSqZebd5zqsCVRoS7?=
 =?us-ascii?Q?/YG6VqZXXAikkDDHdEJicu9Uz4dbj4aq+WlPt3ZW6ZcS6ppJ3P5hBi5evi6I?=
 =?us-ascii?Q?29Ui26iRQGXyZ68y6XMxd11NN/BZAfL8jtdlMp7V1U0IGffbx/DRzhf45xJY?=
 =?us-ascii?Q?Sow0pbQU5e750/LHTNZY+FYOl1lzhP83POGDUeaj64PLDDOHA0Vbt7+nswRQ?=
 =?us-ascii?Q?M5qpaQZfAz3SAf9QMWi7eEHrMrdicGkhnyyYYeOmQo49+rOIoDOAq4kOHJ+0?=
 =?us-ascii?Q?jYCn5PNoAk+ALFaoh/LiuE9+uHyjKZ8SeZXvc5Dew+dyxX6FGylSqNIA7FsD?=
 =?us-ascii?Q?aBg2jtLL2yci7cw47wiJhO+BgV9PUGP7c8iIDxp1/Wh9f+wv8EsUCNJrK+IX?=
 =?us-ascii?Q?ASGunEdJiHL5i8whIsUNYjaIwhYBm2gTIhgRwxyh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d66df2f0-ca06-4900-67d6-08dcdc5fce8c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 06:12:02.8804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Awv5HErs3tDk6ahRUfsNIxAeIDeLV4l0BMDrEUUqHKIVFqxBu1I99EDXqSwUtEHjWYnRN1ptaxZtf/9fF1bH8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10981

This will add compatible and identifier for i.MX91 platform.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/perf/fsl_imx9_ddr_perf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 69f920b1caf2..fe1a51f64751 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -81,6 +81,10 @@ struct ddr_pmu {
 	int id;
 };
 
+static const struct imx_ddr_devtype_data imx91_devtype_data = {
+	.identifier = "imx91",
+};
+
 static const struct imx_ddr_devtype_data imx93_devtype_data = {
 	.identifier = "imx93",
 };
@@ -100,6 +104,7 @@ static inline bool is_imx95(struct ddr_pmu *pmu)
 }
 
 static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
+	{ .compatible = "fsl,imx91-ddr-pmu", .data = &imx91_devtype_data },
 	{ .compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data },
 	{ .compatible = "fsl,imx95-ddr-pmu", .data = &imx95_devtype_data },
 	{ /* sentinel */ }
-- 
2.34.1

