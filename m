Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011047.outbound.protection.outlook.com [52.101.65.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC7F6F2E0;
	Tue, 24 Sep 2024 06:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158323; cv=fail; b=HW6Vn6hdRfuO53va+6gO15kIsJbM8q4tf4o0xdCjD0uiYKLmywanjV7WcJdr7JpXbBUa/8igB51Qc6nYSo8wKb8i/TonKnGjwTjP0QTTWrSbDZmekUT/ojYLiJLHzgyO1fqd80gC8QnrjK5z3j+k6st5kuwghc1jFb8GAfSiTwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158323; c=relaxed/simple;
	bh=U88X6ldV+kirJoGOoxUe7sj+3J3eMBmRTilUdDdaMbk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lE9bPgMKARpxCP0STGNTiIeXWqcZs0O9ZmOXPfzvOLHqKoc3HHEciB5wrGBfgCTFCQMII+zW9/WKhu72tRY0JjtuVeEB+SeJ6LafTih2N+ZrHI30kSIM/1FoAZ6RmwbRr4l+aXa/0azPEzenHVEik28jujnMLqMrfn8tblngk+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U9CQO0mJ; arc=fail smtp.client-ip=52.101.65.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U9CQO0mJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkLMLIG6ALzfZbLOxW+DLjyk0DV6RHZIigtmJLVuG9Z+d174/Z3/Bup40APjCbH4gyP7fwSTByjh49xcKtbLG005L1HxfJhdTj05h+cZ/eKnao199yuAlENz4HjagRpwtmTIw4pOiOQqa3fw0mQ9tWUbVX5hQ//wbNTcsReY0mFJ9PwVb3r1mZEeNca4SoITN6VIMKwU3AiWkEWUm+/fVNSPewLly1U6+kHoIC93WRDk5LtTu/kUDojX7/HIAT6ozHbJ15UMxz/qw6/E+Jf/AHxX+wMvABX4VXlUmJSRY7R/CxXCERN9lYY1jxLt79rnNLQi3OdGu7brGxFYDQRjiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhVSKKa1Vo/eA3S7NqorZDAYj+FnEVs2ClMkIKFCfMI=;
 b=xEOOzhuMjzDmnVGi9Xj7xtMaNVYxHPwNXmQe6KxB5hX0/Itpvacvnpnhzjp3D8A2BuBuom+eVrdZFEbLM/3QvsCrbVMozFjjE63j7LWpRwFvfRwEQBr4nrXDLQM88K+ffSF09YpwJ5Vrp4vSbxloFCgnvY1+fQV8u85Linzrk6Xc9GVpGBvAUjtAqGfhm81F9eaLp6YCZ54lZcHK2QKHpSyOXvXEsRX5W4lnT2VB7gdViwUjMN9I7+ckr5eEktkOZmap6a/Rx/hCBlOyZANaJutgtLftdF0Ipm96PtR4BgvqCxotrTcAEtpjJ27Opk2EmhvG6iitWjPin9QxkUw65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhVSKKa1Vo/eA3S7NqorZDAYj+FnEVs2ClMkIKFCfMI=;
 b=U9CQO0mJa5WE6NmBAIOTjIV2i+LOEizMEuQVkOuXGMNLhJHeR4OpCzrQYwe7XG0oYbHrtS+zOt+gIpu1nJEsXwqaHlsWNHo2/FhwYDrsC4cph6D4jzVnGfAGkIlA4fiXc9p+TxOMThfjRZAo5qPbSzEVa43i0NKnJOGxjCwkOmVkpKuwmySDoQOWqT85n6HLzSfYTvgv6hMbx65VdOuj2/teWCos3uLGU4Ly+kNpxLaudKGw4iwz3FSUuONusWWFV+fU0vdR5vDPEIMhrornn9R/p6DUuOKdkWMBknd8cSBVi3u5D7VWoZQy6IcqntZytlHR5Ei2WrRjgb6TUFTJpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU4PR04MB10981.eurprd04.prod.outlook.com (2603:10a6:10:58d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 06:11:54 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.7918.024; Tue, 24 Sep 2024
 06:11:54 +0000
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
Subject: [PATCH 1/3] dt-bindings: perf: fsl-imx-ddr: Add i.MX91 compatible
Date: Tue, 24 Sep 2024 14:12:49 +0800
Message-Id: <20240924061251.3387850-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 1853f63e-08eb-481c-cf04-08dcdc5fc98f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NoZ8DS6xrUHp1UqzV26oETilyr1fa1wPfGy+mX1foDu4fOv6AaLvDLXp+gHk?=
 =?us-ascii?Q?1IzVSL/aas0puCXEjNAmba9Ub0qxx22J6rI5XWEBugxwmbHnDZc6+myvV9lb?=
 =?us-ascii?Q?iDhfyo8tEcrsBi1ZSnL9MT07ji54oJ9zzuNmRANAgw4e4Y1+z/+9pqpkMYve?=
 =?us-ascii?Q?a1Nko1PIbr6ezWrAb0I4yiEhyurqI+3GjzzVfwe4FMOtSG138I4bHaxLcng7?=
 =?us-ascii?Q?a9qF4aS08itWduOoAfsc6SUjh+/fZ1dyknAxTyiPDPv/xdgiDxkhejAAyNtV?=
 =?us-ascii?Q?6U9gQF7wN1XGXDrV9JnUny4puurIrptxWOjunNa+gQqGdyhz+hlzrv9UAGo/?=
 =?us-ascii?Q?avm+1gkJ/dVLS4A8gF0GYWsEce6/6SBSv3C9gLyA7/2SWw6L42jpIQHJCrRA?=
 =?us-ascii?Q?a1UcaAn+Wgp4m7NrobwSm2BJwKsEmi2aOC+GuY5WgisZ/E1GLh88Bnt/Prdf?=
 =?us-ascii?Q?5a+U+u50ej3pbf2JH8zbbrBx0CCpfhI96DAwXVwQtfHJx36VAj7Lhw/UM24Z?=
 =?us-ascii?Q?T5CWJmKNo7PQsDZA0UZrn6YX5Xp1Q3+fH4gCdbzTUjHkW22UdpXlcsjNl0CM?=
 =?us-ascii?Q?s0lDVO24OJCaeAqlQP7mIfVJ2m7w5XnmcPnyr/PSGa15jV+Q0Dh25XaoUWM6?=
 =?us-ascii?Q?P7AkfAmUl/H09HBmCNHOEiyVpD3UO1gLH7CkoumxpL9tEn9+giVt3MrkN2+/?=
 =?us-ascii?Q?Qa6aCL6OBMqtvLB+JaXHpLe4NU0+5C7SN4O+rP+OuIzdoKSNpNRF9KgMP0SY?=
 =?us-ascii?Q?rEOmskTp6tefDCGgTkoOENRpfQ1qXzsWWoa9wsVVfUYPR+UIHBFDgk4ov96Y?=
 =?us-ascii?Q?WvOovVf7rGbbb9qpLjDczxcM9gyB29/1WYsNyRGffbHsNzkXVtqVRSjqB2Gi?=
 =?us-ascii?Q?b1e1b5NJpI3ChbeqO+qc72J0e42bskhu7j+MdNP65DaEXBWGAc5pU9iO/95n?=
 =?us-ascii?Q?a08EnBCgBmbcG0GOmuCq1SDdJGD2M4jifkDlNiLINkmbXlkjBQAa9pDfeaKd?=
 =?us-ascii?Q?qg6DRsGZ1s16suz7HaIzZR633SIfwGmV4o/982Q6zg80dvXLQCOr7V2qos+u?=
 =?us-ascii?Q?BPMHVDa2AlF+EWfTGg1erWT9nthcU2YuK8LgqJ0neUGpLDW1cPyk63o98+sq?=
 =?us-ascii?Q?4+Be90njtGCxdETtNymnIJ4QyyZDCrEyQqfBO40bJqEe9e+7ngifzLm26Vbk?=
 =?us-ascii?Q?Oeo2mGKsHLgvwPh+KFoCWHug7HH4/UEM4Gts8OfLd9bY57q9CPFUijI1tenM?=
 =?us-ascii?Q?BKN4vdDTiuUCGtGehp2FajIhZQvds32PMFk5sforSAsJcGGWIjwMVI2bynem?=
 =?us-ascii?Q?XiPIT5papGhqwA9/Jge2mOYynVVKfFQMrTq2sA0+0JMhuwrAZ03SSvRlkcNN?=
 =?us-ascii?Q?MHDMiAvnVe2x4o2k+kofAXz+ZFu2f3LNfdOJleJX9wFgNlAEoLRmHuXlh9ww?=
 =?us-ascii?Q?aYPpgE6LqsQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YCowGSMExYzIMzLS//lFtmoBCs4Zz5tjVz5x3bICG/SBA1bKG6F8RDvuW5Ir?=
 =?us-ascii?Q?B9utXcfv8ldmtUhRCaCRD2RsybTpx52GAnCY1VAnuzIa+3F69PlyRXXjSDNt?=
 =?us-ascii?Q?vdbFXjriNeNLUbEOWvlXgxTIFqjL6cRs4Lv+77xyq2dB4G9clCRCaT84lbpr?=
 =?us-ascii?Q?NL4Qk8P4ZLkE3FQL4cfPuhj0SXfIQ79zAsPl9F7s4MWS4f34PZ4S4WT5Jw2Z?=
 =?us-ascii?Q?2ff6evY4OFmP8TzrkAn8HYGUSFeOBUmRKaljd0A2MJuU21xnbphUyIMEKWMV?=
 =?us-ascii?Q?nGUeF/dD673ris2btTxdtD9rkoH3Fuhf6hvOJ3bEKaBOkg8XVhWYMMgNDq45?=
 =?us-ascii?Q?IKq7r4M3Cf8w9FWlWl6O3GAAx5ukWuBGynTAjCcDXtbvKLc8VFtZBoK8I0ge?=
 =?us-ascii?Q?lcealDwACGPbBJCLGwAxRCiatgAd5diJ6ClCgMTi0QYV+BSJ6sAXBVFR7NZc?=
 =?us-ascii?Q?W/frFmVMeTawon8qAPaexE0YNftokLSkdWBTgttXncX7P0foFRetn2l/MrUW?=
 =?us-ascii?Q?zhJ8KlZTMVuqcCpDp0wocUr1cNRKWG/CzhGbMfdu2WgTACx1ce3OWwWuxX0X?=
 =?us-ascii?Q?jiMd2g9UwvngRrXma9aPboF8bWwx4CSjPOtYwCDFyPDJUMWfFwKxCzXEnsge?=
 =?us-ascii?Q?lXCU/dXg84W37UlbdBAH7S9M8wF4yrnblYztvIMUzJQCeA5SMcSlVcRUTfDK?=
 =?us-ascii?Q?Nk4h/i04abkWOguEXU3zv0GTMnsXpqtPBTUsPtCFb9oUEyBZrn71vfNQGjcI?=
 =?us-ascii?Q?sQcdwTQIkJugAwjNkb0O5kPXttT8382f73PUxSNxrOmgLx26kfH3ksLfSTtd?=
 =?us-ascii?Q?p+QaF1g5c0HvKbApU0ruv4wIYcG4Y8wrjpD6qsQgSD7FZt+8WCeqJvIQzUZW?=
 =?us-ascii?Q?K3x9LTxzKbx6xv+Eb4/wHmSk5za2VDxCjOgJ6BABrdbQKCkatJcpeJvmYuJ4?=
 =?us-ascii?Q?C40+qRSGiRO4mBwq7IIjYxIv2AKUx2nL7bUk0aZj6F5MJNMWMYKSl7p7zopV?=
 =?us-ascii?Q?/cFZ4MiHfxi1nG6iWVPNjo+7IC4QAbqbuCIMaD2bSdFDw7w2sJZ1co7930Sg?=
 =?us-ascii?Q?jlS05gZHv6dGIvFfkgxW9zOVnk0FoFUrRiltVJ1yvkZQP3aCCaNa8jt/tBhf?=
 =?us-ascii?Q?om7fSOunf3ilPSaJTKTeQ4qdAh9YGh1wux33AmWIwzjXwnhyMlLh6/ENWXMn?=
 =?us-ascii?Q?Vwe1x43DxIO9jYQICjZONL8ohzDvkXkHwFoP/xYsZP0ZeTy08bvvDbLsCpg2?=
 =?us-ascii?Q?+RG0D7i1RnENlT11bu6pgYfo9v6TcLBUn0idJHpXn71xlXAVpJ0a97xkI5Wx?=
 =?us-ascii?Q?dRLTyg+AoNiRq5v7t5XGGCAM4JMTDBoPRE24y3x28/FJPWzGlXgiPMZJ0vmn?=
 =?us-ascii?Q?2D8fx1x1E2nIpXrfQh7V0aTsQcYrYAZgfhzepVDBi3bSDCU1Hw6jAt6pFDJI?=
 =?us-ascii?Q?ZiVQPCl4f1CZtXmjpMKguyhRtBEU3/JDct9CZqNDdfbXT7lh5NbZvVUlqU1B?=
 =?us-ascii?Q?zmR1sS16O6XhMh1vCVypMW/jue+38Z2U8uc/IfX5OixudmarO9c3wQKdalsG?=
 =?us-ascii?Q?+OQtXwAy/NjDRVQkEepaqpq+evKtG29YaxH0RCUt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1853f63e-08eb-481c-cf04-08dcdc5fc98f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 06:11:54.7299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWVl1Fj1nS/MtNlXn1F1K5+InA5zA77BmFbDpm+0g3IqF+f/He9BQn7Qw7bj8sbOL/WsZfZtURQ0Cc+g/DAXrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10981

i.MX91 has a DDR Performance Monitor Unit which is compatible with i.MX93.
This will add a compatible for i.MX91.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
index 37e8b98f2cdc..8597ea625edb 100644
--- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
+++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
@@ -31,7 +31,9 @@ properties:
           - const: fsl,imx8dxl-ddr-pmu
           - const: fsl,imx8-ddr-pmu
       - items:
-          - const: fsl,imx95-ddr-pmu
+          - enum:
+              - fsl,imx91-ddr-pmu
+              - fsl,imx95-ddr-pmu
           - const: fsl,imx93-ddr-pmu
 
   reg:
-- 
2.34.1

