Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2055.outbound.protection.outlook.com [40.107.6.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB4377A03;
	Tue, 28 May 2024 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883090; cv=fail; b=ZT59LH6aaIZi9vip5+8NNtaxkVBeEd1YHVtKv4Vb8LpqV+czkpXKLQcx6EA9OsD4ZqQYJyHw/fn5L0J/+Pe/yjPMY4YIBKZo9SvB7YXSzVc2tecygtjgXA7wgWXca1HELYHNUf5PjdoFzXrHMs0r/f+3v0mK9fr5DEPSUL+Dmoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883090; c=relaxed/simple;
	bh=bRrj4IhMXDznXJuNeL22GYshM0VZztdMkJ1Gc82Hg0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pUY5Zxbjm8p469k39OGzJ23nzAUHRm162Pbhcmg9WWIYajC1rUA0yVDyaAAvuHNqJPI8+Ku0Sg5QhA+fJLM8Yk73fPTJER0ThDwdHcJroqQI7S7kjyM/MLYeKLlRIYEOjbXIcIeXNEy+034932Gf0piOqXNc88oa0GgKyjFDDFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EoLnT9sI; arc=fail smtp.client-ip=40.107.6.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EoLnT9sI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZkZtxvxMjFuIjdPJ4eJKRL3cNWVr9K8IqCcbgNYUzEG+l1eZhkuhUA+V8UkfJc3tZilgKsnbGRxgqO+qJwi+r+D6sR7K77O/y0Coisaq9+YZ5IsdO/ViFRgBArTGbIx2QCKdelNe+IwV0ahKN3QT7yIkyMZpn/vhSas0nl3v8UfoPB5cK4UkOAQFm9zO9xBwnvMrH/ry2uXaK0dxY9o1ouhM5n3NwPBrzD8o6Aw6qwtek0rfLwTi1PecffIEIwDu4hGq+eNDiWhUQ2xU5TEz+Koc0tAoy+cRcqkULRKryayeeNb7TfBIMH24LxEXtMAW0qElis4iU8CvPhkiRV7tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5ihKGNDzy7Bpylktea8Pvu1d5BzT2u4Z0ZPjg7sfCU=;
 b=OYpn9TDOxHGYGZeuS9gjMmxiNGzEAsLUttppbaawHPRb5292uNhI0gdzYaTFAxpojrHEHioMaBn3kEfzgoQWW32C/GwiIdPQ3nf/06ACi9RwUMYIKb8E5rvOwwvTWHDotHNrITIliZlVvxn2nvtg+pp3k1yNdB09W4dNwbt4IUkl/FcJz/2EHLRqPke3EWVJzbrdwynUxtifXA+O+5GVSk9ixgYt3D4UH+nFPwRWRuPCcx2HGbNorDpz8iMfYoujw3uI48DXinilPWFSngYw0rRXrJ0RcJWacc6MtRfj1Of/XWsIsuDq4SnGX7I3Ijn8mtXST1FmOSQmHkpcu7J4Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5ihKGNDzy7Bpylktea8Pvu1d5BzT2u4Z0ZPjg7sfCU=;
 b=EoLnT9sIz2w/8DHR2SuP7wwSRh26d6xxG0/5iYv65NShqe8dAPxidZb2a+GmzwzRuAkODdK/3tRlCZz4IhOwqRxBVXenetkKpydSWZrqJejAYRsbS5J3Oq5Ap2lWffSzlnuXyM4ynYMjB/ZsIipf0aqpUyQ5TynffxrxtL++43Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by VE1PR04MB7229.eurprd04.prod.outlook.com (2603:10a6:800:1a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 07:58:05 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 07:58:04 +0000
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
Subject: [PATCH v11 6/8] perf: imx_perf: add support for i.MX95 platform
Date: Wed, 29 May 2024 00:05:21 +0800
Message-Id: <20240528160523.1695953-6-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: cc87683c-0e39-4ba9-ae26-08dc7eebe6ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|7416005|1800799015|52116005|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pG+hYtpDYlXn38vBI1vuLOjppooVoQs35+CzlZlnjIC+5YNLM/KBzx9Ebw3g?=
 =?us-ascii?Q?5TtcdoT5IhumhEVwcGanCtcXPJUasYqa5SY3OJQYCS2vU/jY/Mz/kg3lZbD7?=
 =?us-ascii?Q?LyDRO5tIRZMbaQ1flCFdI3Qv28arOPXr+k79Xfe19phW2fIIwd5JCZ3i3jJf?=
 =?us-ascii?Q?66U/05V/rJRAV1x6h0cD2+MUaNJCVX3fJksdPw9TXyu65WCrL5BabJjnSPkg?=
 =?us-ascii?Q?ht5g6xxJVjgm/qBqyddp5OXIED0g3C/PNrqYtIhf5Vf2o9Jl4Nun/6JnEQbk?=
 =?us-ascii?Q?jVgqTBwPqOWIIOLZ749xUqBz4gdmugFEQUT+/y4JMSPFgQzgVHMujzZb/mu8?=
 =?us-ascii?Q?zTwIJv5RgcfdXTYj0CJHLSuGCFU2vg6ofJquGcr62p/o+dt0IeJ2FQ5M40CH?=
 =?us-ascii?Q?WSA9V6gJ/7AgEgMYskp+IF9HiBeuvO9DJgtWTjAkdJdlDR36bMv4Tc/PeLff?=
 =?us-ascii?Q?e0IaCnhQSCms5CGNmXH5AV5P/75zdrLbehcdj3XBGk1tcfC8jUogLEf5yAsn?=
 =?us-ascii?Q?moCYWEzf3Ks1P64qrh7dvJpVelCzAfooMGl7oiQ2FcMCCy/NCORbKgASlZpi?=
 =?us-ascii?Q?AfstsKy86SOUivckPbMD8KzwpvlBDa9oWQ9m2/XkcDf7/irctY3V4U7T1Ueh?=
 =?us-ascii?Q?MjamD/DVCudtIXXPpC+HD03OQivzBPQ4zH2QBc6KXE3qXL+1ESpMx1H/cQE2?=
 =?us-ascii?Q?rYzBDkAe36W3vOgUZyAjl03P35ZM2NQaazxxEtnB2S21oL01vQGmhRe5qmBN?=
 =?us-ascii?Q?yGW+ZBET5aOsqPOBpVAtcrN2A2eo20oO6fQ03L75hEab/HeqHWm16QSKNRii?=
 =?us-ascii?Q?8WrfXYBE7LOLRPZBW0GCl8qw4GxB5JWFysJq9UI0+0kYJ+y7oXXMdgMIoT1+?=
 =?us-ascii?Q?2hwCyITiIN/+ffsPhZQNy3YLH1afO0BVN0L7JrCtVJCFdWTCBPuo0U9x1Uw5?=
 =?us-ascii?Q?sCzPXT6BX7C+P5rrxTdKI6vtgjdMKbEah6QtxDpO17S0F8bVF1bIGHXg0FzA?=
 =?us-ascii?Q?DtOfomcR/a/guvyAmXC7letQTKIDkRqDiOfGxkj8HGu7RHjU6dG1c0qeyXVE?=
 =?us-ascii?Q?TMeGJEVIo4pMHx68Wm9DtzRN8ngcsQwYv+hNswflUOXD7Tjo0X5SkR/zmqle?=
 =?us-ascii?Q?52TYweZe3CeN0v4r9wOwwfLx35K3p0SQ4osXHp4Yt4CKhfLs/EWgidmEREfp?=
 =?us-ascii?Q?47u/HXDUGlb64ohNe1YSUCcUEJOszVjgp/gf9xJMF4qltcdnUT2afpo9cr0W?=
 =?us-ascii?Q?Zu4Y961XnxnEkqcdvRoZGYvmdYxUzQDNt4VebAyi0OfnPIbPSLgKJWEgcQv2?=
 =?us-ascii?Q?uiYCmhItsE6NhuFjG5BnlmoH5mIOtPL6ekuP3MXDHR9ulQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(52116005)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2SQwzGef1ctS11ZByG1er/50rxbDu6OHO9IWIiMc4kTmlThKbyA7Schbm8a6?=
 =?us-ascii?Q?/4dZdD9vkypCYuxs8qP42EOVE/NuO0yTCIfxnMTjuo9Q9y11GGQ2UJ9HCTVR?=
 =?us-ascii?Q?rn1V9rafj0ZnCsR7mbHixC1GJMsKlwSrtJST0GiMKiDiYp/ILMiZdO5VVh6f?=
 =?us-ascii?Q?jg4d7CF2qf32HsJG7dRBbOyx8XvSeb27GjwLzD4XPCfNPuZXhBI9jinfC2XR?=
 =?us-ascii?Q?PoKjiFVD62c2YoX6xRZkHkiQJQPP8I4HGG2EzuNv1LpARjdbyayl0p48eiAT?=
 =?us-ascii?Q?AgtIDREFqAlMnLwz0Fewlf2cbrW9Nc+HLr2P/i0v1yhTirW+8WNYQJB7Oi56?=
 =?us-ascii?Q?oR/I/owiQdUVcs5v7P/1PEj55IZvwGmDQ7OG37gE5TwOf89pwMOFZdDXS84f?=
 =?us-ascii?Q?maroZJ8iAbQKb2ESKBe2KDY03rI/1AvS2RRlqPJEYPZg6UTvZ1fMKC31DEYT?=
 =?us-ascii?Q?6wNtZoxLFJFLShfZAiD5547+e8XBmVoqby0k/Jz7QVSJz95tz7Qh0eRGBvep?=
 =?us-ascii?Q?LkBLQAIcdRqB5Px/llOd41dtmQ/BawftEWDbjTzbQ3KIffmYHUlddcvNwgcl?=
 =?us-ascii?Q?Tw2m+vg3PfoHCEixZ4D8/KNYvT/ArGxaECHSxuHWQwZ9Def1r9eGqQZ7ygTE?=
 =?us-ascii?Q?YI6ZvpLKsIobzFkhTJ7JFxER+BvrORV4XFRV8mtJA2NQCAupr1P2OlBQr/lE?=
 =?us-ascii?Q?MQchNbTV6HrNSipwVeRvFEWidRPUwI2iQndooN4ba010IZVK1O8oRuy2CWkq?=
 =?us-ascii?Q?bMuT8pCoPfjhaLq12/MPTCFM2SRyf9EwBhuWOwZZwFmTvPkPQDu9A/suKUsy?=
 =?us-ascii?Q?4ju/OYb+0Vm9xw6nrKjm3B80Jz813536PcbQ4gTyqY6A7+mwYF6rO/v15A1K?=
 =?us-ascii?Q?3i8Bf9fA9vknCAhSQDBRB2d0aaF5hoGlAyEFGeXvQGowlIfR9y8xzEJCuPbn?=
 =?us-ascii?Q?wbTJuanaX6Dp/2Te393Y0LF55L/ysxV9TgQEHALRQBK7dUA9GECzxwlEeboO?=
 =?us-ascii?Q?2oZJf68v8C+mI+ZVHPYge9iuQuPLzbEZY4Dabo9cmfapdO/6nhOvwq0yvjk9?=
 =?us-ascii?Q?ebDaD1U69Wm3tlNkUkYDU06EqaXrMzhEMTrOOoPl/0M6cKUGG45bsIr8RZLz?=
 =?us-ascii?Q?/yQtEFseYxNxbkOXRct8/R5t6BGDSSUAbEfTms7qM8/oVwg/SCMpTDriyuVS?=
 =?us-ascii?Q?kDG31mwlzhH+jzL3K+wqBS+LK9EX7xVwh40GLorHZmxQ/K6j74ef/PTmaz0n?=
 =?us-ascii?Q?LpsDtM1C11xthQJXuhJkqDNp5pprg5A76gjvxkv42tvU/pGhBRHtcLelQdC2?=
 =?us-ascii?Q?v+FbhqJKf/UThE4Azgm3yYv3KxXYV4SXxjODxNc6oOWXVEGXqRWedyVLnK0q?=
 =?us-ascii?Q?vH0h0N1qsD3Q8w9ChmVFK9qgHBqSocNEMzjLPpb65c5nu4VS1JRC75YOFJJO?=
 =?us-ascii?Q?r+P1T1nsU4Z1baLPnOK+pBkPDjaY/l3mHEVQMrhTdoUUyj+36ayGhLwTvhzx?=
 =?us-ascii?Q?o3NucySpVxgI4+rp2fMHK4KQhItyZkyfRyGHcM74iqfQzveE/yhm+GWTTkqt?=
 =?us-ascii?Q?aoqAg6+pZSf6/Exvc/7YOeqH8czdXz0GbXMTyOqb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc87683c-0e39-4ba9-ae26-08dc7eebe6ee
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 07:58:04.2249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3EBq/gMlm2D28/lnnZsZJczUZGPvBeWD0uG2pVYRXF4wdZ+EEoxKYjKE2K5ow3Ac2+cswqf4H5cYGDV4wVWtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7229

i.MX95 has a DDR PMU which is almostly same as i.MX93, it now supports
read beat and write beat filter capabilities. This will add support for
i.MX95 and enhance the driver to support specific filter handling for it.

Usage:

For read beat:
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt2,axi_mask=ID_MASK,axi_id=ID/
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt1,axi_mask=ID_MASK,axi_id=ID/
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,axi_mask=ID_MASK,axi_id=ID/
eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,axi_mask=0x00f,axi_id=0x00c/

For write beat:
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,axi_mask=ID_MASK,axi_id=ID/
eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,axi_mask=0x00f,axi_id=0x00c/

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - put soc spefific axi filter events to drvdata according
   to Frank's suggestions.
 - adjust pmcfg axi_id and axi_mask config
Changes in v3:
 - no changes
Changes in v4:
 - only contain imx95 parts
Changes in v5:
 - improve imx95_ddr_perf_monitor_config()
 - use write_relaxed to pair read_relaxed
Changes in v6:
 - no changes
Changes in v7:
 - no changes
Changes in v8:
 - add definition IMX95_DDR_PMU_EVENT_ATTR
Changes in v9:
 - add Rb tag
Changes in v10:
 - no changes
Changes in v11:
 - no changes
---
 drivers/perf/fsl_imx9_ddr_perf.c | 89 ++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 26144916dba7..2077680ed39f 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -17,9 +17,19 @@
 #define MX93_PMCFG1_RD_BT_FILT_EN	BIT(29)
 #define MX93_PMCFG1_ID_MASK		GENMASK(17, 0)
 
+#define MX95_PMCFG1_WR_BEAT_FILT_EN	BIT(31)
+#define MX95_PMCFG1_RD_BEAT_FILT_EN	BIT(30)
+
 #define PMCFG2				0x04
 #define MX93_PMCFG2_ID			GENMASK(17, 0)
 
+#define PMCFG3				0x08
+#define PMCFG4				0x0C
+#define PMCFG5				0x10
+#define PMCFG6				0x14
+#define MX95_PMCFG_ID_MASK		GENMASK(9, 0)
+#define MX95_PMCFG_ID			GENMASK(25, 16)
+
 /* Global control register affects all counters and takes priority over local control registers */
 #define PMGC0		0x40
 /* Global control register bits */
@@ -75,13 +85,23 @@ static const struct imx_ddr_devtype_data imx93_devtype_data = {
 	.identifier = "imx93",
 };
 
+static const struct imx_ddr_devtype_data imx95_devtype_data = {
+	.identifier = "imx95",
+};
+
 static inline bool is_imx93(struct ddr_pmu *pmu)
 {
 	return pmu->devtype_data == &imx93_devtype_data;
 }
 
+static inline bool is_imx95(struct ddr_pmu *pmu)
+{
+	return pmu->devtype_data == &imx95_devtype_data;
+}
+
 static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
-	{.compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data},
+	{ .compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data },
+	{ .compatible = "fsl,imx95-ddr-pmu", .data = &imx95_devtype_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
@@ -158,6 +178,9 @@ static ssize_t ddr_pmu_event_show(struct device *dev,
 #define IMX93_DDR_PMU_EVENT_ATTR(_name, _id)				\
 	DDR_PMU_EVENT_ATTR_COMM(_name, _id, &imx93_devtype_data)
 
+#define IMX95_DDR_PMU_EVENT_ATTR(_name, _id)				\
+	DDR_PMU_EVENT_ATTR_COMM(_name, _id, &imx95_devtype_data)
+
 static struct attribute *ddr_perf_events_attrs[] = {
 	/* counter0 cycles event */
 	IMX9_DDR_PMU_EVENT_ATTR(cycles, 0),
@@ -204,6 +227,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, ID(2, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, ID(2, 72)),
 	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),	/* imx93 specific*/
+	IMX95_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_beat_filt, ID(2, 73)),	/* imx95 specific*/
 
 	/* counter3 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, ID(3, 64)),
@@ -216,6 +240,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, ID(3, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, ID(3, 72)),
 	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),	/* imx93 specific*/
+	IMX95_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt2, ID(3, 73)),	/* imx95 specific*/
 
 	/* counter4 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, ID(4, 64)),
@@ -228,6 +253,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, ID(4, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, ID(4, 72)),
 	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),	/* imx93 specific*/
+	IMX95_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt1, ID(4, 73)),	/* imx95 specific*/
 
 	/* counter5 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, ID(5, 64)),
@@ -239,6 +265,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_6, ID(5, 70)),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_7, ID(5, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq1, ID(5, 72)),
+	IMX95_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt0, ID(5, 73)),	/* imx95 specific*/
 
 	/* counter6 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_end_0, ID(6, 64)),
@@ -432,6 +459,57 @@ static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
 	writel_relaxed(pmcfg2, pmu->base + PMCFG2);
 }
 
+static void imx95_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
+					  int counter, int axi_id, int axi_mask)
+{
+	u32 pmcfg1, pmcfg, offset = 0;
+
+	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
+
+	if (event == 73) {
+		switch (counter) {
+		case 2:
+			pmcfg1 |= MX95_PMCFG1_WR_BEAT_FILT_EN;
+			offset = PMCFG3;
+			break;
+		case 3:
+			pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
+			offset = PMCFG4;
+			break;
+		case 4:
+			pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
+			offset = PMCFG5;
+			break;
+		case 5:
+			pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
+			offset = PMCFG6;
+			break;
+		}
+	} else {
+		switch (counter) {
+		case 2:
+			pmcfg1 &= ~MX95_PMCFG1_WR_BEAT_FILT_EN;
+			break;
+		case 3:
+		case 4:
+		case 5:
+			pmcfg1 &= ~MX95_PMCFG1_RD_BEAT_FILT_EN;
+			break;
+		}
+	}
+
+	writel_relaxed(pmcfg1, pmu->base + PMCFG1);
+
+	if (offset) {
+		pmcfg = readl_relaxed(pmu->base + offset);
+		pmcfg &= ~(FIELD_PREP(MX95_PMCFG_ID_MASK, 0x3FF) |
+			   FIELD_PREP(MX95_PMCFG_ID, 0x3FF));
+		pmcfg |= (FIELD_PREP(MX95_PMCFG_ID_MASK, axi_mask) |
+			  FIELD_PREP(MX95_PMCFG_ID, axi_id));
+		writel_relaxed(pmcfg, pmu->base + offset);
+	}
+}
+
 static void ddr_perf_event_update(struct perf_event *event)
 {
 	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
@@ -541,8 +619,13 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	hwc->idx = counter;
 	hwc->state |= PERF_HES_STOPPED;
 
-	/* read trans, write trans, read beat */
-	imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
+	if (is_imx93(pmu))
+		/* read trans, write trans, read beat */
+		imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
+
+	if (is_imx95(pmu))
+		/* write beat, read beat2, read beat1, read beat */
+		imx95_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
 
 	if (flags & PERF_EF_START)
 		ddr_perf_event_start(event, flags);
-- 
2.34.1

