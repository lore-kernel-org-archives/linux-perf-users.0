Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F1713C83C;
	Tue, 28 May 2024 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883096; cv=fail; b=jnwVMBmPvxIljCZuqhz3oCAwEQsSNWpzY3f3qrUNRZ523BdAgvMmTgWZ97/0GslYeSHrlUpBj8itK1gOvtVShiLOwBDOWQsRGqlv7PyFY8wDR78IM3dIh+8c2/ew2EDBpNs5ZzuVp/2NWxaGizspoi77jfYIwLXNKotcvD+2DlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883096; c=relaxed/simple;
	bh=LyTcA8gwqSZ5bNp/+L3YLgYcbRUswc+Lpu93baCxcNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NplxjXOSf/CGOVl0uF8S3fJSKwrEwVBK+YqwBvX0r3azeB8sQyznOrG47lFkuMqCcqiQWT3CpFTGSuXDt/9o+EHwt8iufGLD27MfDDArrcstuQK45HeJneANLTaYJ4fjyFiQ2QtSTW1Vq768BDeQFH1gFMZyN1ZojzG6mHuybNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GezAgLnz; arc=fail smtp.client-ip=40.107.8.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GezAgLnz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5qYogfos1t/JUUk/oS6A8xP0kCHVznoYEq3kUaqR+J2875mHAEmJ5sMeb1p91uhUjp5LXZ1NiCfC12nzCaSnSpYAlOsaOFzGvrvNIJb6cIFTUDaHFqLrfGlIw8ZW5AlEhdAvy9eYfLw/i1ceI+4aFzRgpYWji0FH3Kwl1MHWvLN+mm3hMGkEUmSVE5Gkm7JAzbVfmvKo6Bzq8sNrvgW7KyXxqHPJJWkPqFNWREpPc33TB1+k93+mPIOjfts5aZijN0kb4czP25YWyMe5Q3zrjzsQXxu1/wnyQ4WvpyYjvbB7trZDSIZ3KCR3kJiyCz9zMQN9FV2gS3Y02GMMPJFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkA+GEwrovSx4DkXR3EJPsYD27EySSEO6QB6cGDpTMo=;
 b=J8uAe+o7y4+VnyAkncYW5Vd2cWyHmnYJFBULnaW8J2uOtB5E/D+4L6+fT5TzkE3ajT9DnFNvVWU8IlmzsuVMj1qVqMsH1nRLkeVDdKgTwIqi6IWk2TMOm9xywwseLqEbJi5dpiykd9XVPx9r3brBLOvBVt9lJG2YMhqhCIKAXnJOdwBax/ml5mN+eqUD8f2k6v99Hd7elaj3+PgTDuAQwSepD6vOjTmuAuLZ7gIbeJ3zBVwkArB/oeeRJ2fTWm/OybeRv18hu06oX9rnMBtQ00H/dGXw/823yw8WsaPGwPolsd8c/kJ6R7nqW2fVTIwi+XZUKgOd+WJnhvII7mVOsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkA+GEwrovSx4DkXR3EJPsYD27EySSEO6QB6cGDpTMo=;
 b=GezAgLnzPiKidj29WPzgwCcKsi68jtd1SZPxJSgAjgBTE4VSAFQZxe59w0DsPVN7FXB7s+Mp32cwayoymIZsDg0MRAd7fLXG5ukfLJsEYetVUKl7A0IkViOamwBq3TXrMc3O4yeY9ISz6NnbWcGCJ9PDIfuBRTdYUrfjw1Fc2cg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by VI1PR04MB7181.eurprd04.prod.outlook.com (2603:10a6:800:12a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 07:58:12 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 07:58:12 +0000
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
Subject: [PATCH v11 7/8] perf vendor events arm64:: Add i.MX93 DDR Performance Monitor metrics
Date: Wed, 29 May 2024 00:05:22 +0800
Message-Id: <20240528160523.1695953-7-xu.yang_2@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|VI1PR04MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: bc6e99dd-32ef-48c4-ff27-08dc7eebebda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|1800799015|366007|376005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KVuKaec0Ud9yMqkUZugoOD8juGE/UCc75deeUIV7JIjdN77ZgAhfVAwDvCwI?=
 =?us-ascii?Q?GkT1J274WdeHy0fB5j/R64xNs+g8uNWcTCMTyIFS/+HEmO5WYiY9I5+pNWk3?=
 =?us-ascii?Q?GEqSXWWPkUz8ugXQaUieRYuNo6X2sdCYxkx8jbUyWGbuFoeyAwiMfyhoABg/?=
 =?us-ascii?Q?WJ7Yiql3QF0oja/PX9PN+zDh8aOtyTY+m+taH51Z5lCQxkTqqtLcMUvLFYN6?=
 =?us-ascii?Q?sPSQTXDcKpnVZIL0yObW5LQsDtsbb7YLuCskq0mnoDbAhNuzNHwFZzJ4Genl?=
 =?us-ascii?Q?mNOBJ3PSM5NGFnfRU4hemRhYqFBWC9ZkMAO1ve+OJcnnOdtHzzZVD0UAGBAq?=
 =?us-ascii?Q?kpbb74gc2bHjyigIfxafNVWoUkHNNn6VGIDtmSKN18je/rA6sfBjP1hjuFfU?=
 =?us-ascii?Q?2iwHWVGTNVEeuYVxr8nQptCEKptlLIM/Hb8z40bIpycJsrKD6t94oriYrcdN?=
 =?us-ascii?Q?tRbHzS1A10MeLj+qH58C2EeIJ2z9ZX8ZICiIPozr1zxhImig8GsH4WufSRwa?=
 =?us-ascii?Q?qjbDGqDG0vddEJ6DqEfrG2S+gUssBX5jpaxaB/DeJ+YCa6IeouLDvsIp/6XF?=
 =?us-ascii?Q?hAADB9CK4wBGWl3mZFvjd9nx32nemu16FL5z6pb6Vy+vrumJmnRyfXF1uhZ8?=
 =?us-ascii?Q?6a9x8126BOdJ8up1ZtHS7qQTvJ8/Q+FPySlcAFTZsKb9AeRF/GCTpPP22CS7?=
 =?us-ascii?Q?M551XoiUOnHzx3T50FIo7V8T6etuVSV9d1vwO4v/524qw8qDdLllD87txnxs?=
 =?us-ascii?Q?5TYVm27jRFEeBtBYvDwW8w2Mjs06JHfccw70DOBgIyEHMYKckFPVL3EMWjsZ?=
 =?us-ascii?Q?Suu/aYJgnVJZGUAScrQ9B0F0oLC2j6ZQMzwYqZXP11OyNnv04fLqTu9l9Z0d?=
 =?us-ascii?Q?91gI+vvIIFBw8X5CWL3cjuU9cZthHCY28HqAq+U6eW9CVJoe7pv4R9TeXb4Q?=
 =?us-ascii?Q?QS8y1QieMOBzx6M3RDqZDqsPyqhL5EoL5Nk/br79lt9sZo6Z90ZHDRgczZXd?=
 =?us-ascii?Q?U0T35RLceqGXT8GGirp2X+3MzGgP9sumT7uhJndsckSRZQNd1xavcyTmDASr?=
 =?us-ascii?Q?T51MTLA7RWBmE6Wtnz5COr8Uj2wdmdivnxGVbxsZGnbeNamn6iOSTGaHoX66?=
 =?us-ascii?Q?8QSWTlHGP1xcqpvOLatnWsD+kvl4dNvyzv2k4zoipPTFeGbzNjR28+x8GZEL?=
 =?us-ascii?Q?o+iAit79BmG6TbtaELPqI1NzADtaGw5V3+w0Rhl4cwy1Dpr7n9fTtoEDJ73s?=
 =?us-ascii?Q?7UhRtOQHpXQho1T6TAMxCx0zYvdeeMnIQ9VR5iilKByQ1mgDsYd54yQc7WHx?=
 =?us-ascii?Q?lUDIgSCT56LvZOs8O1+yFK67E39CDyfP+dslvIHljdpYDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(1800799015)(366007)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k2M204I4N6E8EsfExfEdSXmLx2OwDppPFjT/x6pfsEnzGuwHCq3o4pdwMgkY?=
 =?us-ascii?Q?votTtjXhTcotGMzWpdwmE0KpXCpvJyekG8umxZTaiqSN0dXi84pnkACpXzrV?=
 =?us-ascii?Q?nkxwPTRe3Ldn/bNbt602u5Qktw1BzArhPqWhinW+KaVEC43WrBWDb+ayFyIh?=
 =?us-ascii?Q?+9Ss+5OQW4mgeeC6wEhgfm7KrUmQ2IjSZUboxBLFEol5UYpmxICNH6fS6oGM?=
 =?us-ascii?Q?dwSmGw325CshtqxGxqr+8PBFGDYSrxssVy9eQ9k1NcXZ++OnpHtBoIz9OiLq?=
 =?us-ascii?Q?E1Al3zlul6Cf6o7FtpKeuikB4N0afmzTae9ugq4UTqwUf6e/zj2w/etnIi3I?=
 =?us-ascii?Q?2Li2o8UYBHyCD0AyzsfLW7wWvnu5SD4FqIlcnt9aJfJmZuhWesB5+5F/Dfk6?=
 =?us-ascii?Q?mgvLvnrMUMyfeJHSZk5JoqvtjQKfECKMV3tmvLDePTV8P1AnuuYJwfCZVVZB?=
 =?us-ascii?Q?FRCE42aiVtYKt54HTPF4kKM4GHD8KgLMBFqnwhq0YvmirdSEaqxT4IQ6BqLh?=
 =?us-ascii?Q?YYQQxoay5xVtyCfVDCtL8JoIk4wm+5w03Iq4sFoZUCrc+Q1ISJEzO+HXZtgm?=
 =?us-ascii?Q?q8qYu7f7+BtmVP5r4q0EETBe+/vJ9kKc7TnSzCYEWMfZK8G9gyYs4Z6wUMWM?=
 =?us-ascii?Q?f8bJpqjWKe4RTmEa7R7wS7dUUCFD/eNhgDc56EcV8JWmYBg22TXjb8TDv5ry?=
 =?us-ascii?Q?+TmdYJmuIQQdDWjE0RnFJTX/NqPpfqoheS/ouWk4b2muZ3H0+5XpHknikoho?=
 =?us-ascii?Q?yJ835yFw6eghXHwwy71mOd9W88NEerE+vPMZhI3cm/lB55OXU9TcdSwKl0Ja?=
 =?us-ascii?Q?icArccBqx0asGCUGJhMySYl0u/13iGlruElxn4fGwcdKnZ2N7IGQmWyAFHyJ?=
 =?us-ascii?Q?Gj8TmYDS6yEhasmAUUpKZW5jIpA0MA5YqEZq0YMCE+yXzWzVhVs5TDbBWKFC?=
 =?us-ascii?Q?HZeHQsvUL5f+LSVbL4T4E8aB/UT6mV9xkz/nIqvzhTz+/ZNE5rVZNdhU73qP?=
 =?us-ascii?Q?UGLF7omusE/T8q+ecLk6ZQqbNsNMXrh9iI8h4qf3C3Psr4fElw/WuhlnUF8j?=
 =?us-ascii?Q?b4F2mfmsgD+TPeiDhjsdCizYmTMWVJMMN/iaRKxXS9d2fNXLjFJWRmMpaxuh?=
 =?us-ascii?Q?Yi7H6N5Dvkiqt8BQmu7Eyg8LU1qEsJiQ/GrULe3BaR2ntGQGkiZ0Z4tsbNQH?=
 =?us-ascii?Q?8B/oCGIP0viTbv2ru3JkXdKV6Fa+/y8OtyK2awGGFIi32NbAPzpj8xDahiqM?=
 =?us-ascii?Q?sGhNsIJnuNuzI9ovI34u5jTTh+ZJjn+chRyZ+cY1MoSrPqOXGuN+3vBq2eXp?=
 =?us-ascii?Q?Nw6N0GYihjt7QoBSmFFgAQtPi1R61AtXkoD9acSBsnrVKJS7b/uYRaCaUD6L?=
 =?us-ascii?Q?CqL0cKfxJFrOB0E6T8f8O5ISZGyunTNqu61gYuYFBDvl5vT4B3ZE7IZyY9VO?=
 =?us-ascii?Q?pPU4avzX17XmihugmCKiQU89ad7BMjq32XVktc4UbHDVHqZkF4QGDrs93Rop?=
 =?us-ascii?Q?WkqbenJv+QJWLa01KR0WtMx58KFjrG5JaEKYVREAmqgDxzeiurX9d2gjRhg2?=
 =?us-ascii?Q?bQsICw8IP/4Re/he2Vbu/4i5Y9VzKXUZ7coflQm8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6e99dd-32ef-48c4-ff27-08dc7eebebda
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 07:58:12.0970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOp+2rn3+A5sBEPZzvNKTR4qQxEaXez75ol/tz67RLSwm0MYa4f197MdR+gKhVmDlQYWVZOMYbklhTKsaDZdAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7181

Add JSON metrics for i.MX93 DDR Performance Monitor.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v7:
 - new patch
Changes in v8:
 - no changes
Changes in v9:
 - add Rb tag
Changes in v10:
 - no changes
Changes in v11:
 - no changes
---
 .../arch/arm64/freescale/imx93/sys/ddrc.json  |  9 +++++++
 .../arm64/freescale/imx93/sys/metrics.json    | 26 +++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json
new file mode 100644
index 000000000000..eeeae4d49fce
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json
@@ -0,0 +1,9 @@
+[
+   {
+           "BriefDescription": "ddr cycles event",
+           "EventCode": "0x00",
+           "EventName": "imx93_ddr.cycles",
+           "Unit": "imx9_ddr",
+           "Compat": "imx93"
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json
new file mode 100644
index 000000000000..4d2454ca1259
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json
@@ -0,0 +1,26 @@
+[
+   {
+	    "BriefDescription": "bandwidth usage for lpddr4x evk board",
+	    "MetricName": "imx93_bandwidth_usage.lpddr4x",
+	    "MetricExpr": "(((( imx9_ddr0@ddrc_pm_0@ ) * 2 * 8 ) + (( imx9_ddr0@ddrc_pm_3@ + imx9_ddr0@ddrc_pm_5@ + imx9_ddr0@ddrc_pm_7@ + imx9_ddr0@ddrc_pm_9@ - imx9_ddr0@ddrc_pm_2@ - imx9_ddr0@ddrc_pm_4@ - imx9_ddr0@ddrc_pm_6@ - imx9_ddr0@ddrc_pm_8@ ) * 32 )) / duration_time) / (3733 * 1000000 * 2)",
+	    "ScaleUnit": "1e2%",
+	    "Unit": "imx9_ddr",
+	    "Compat": "imx93"
+   },
+   {
+	    "BriefDescription": "bytes all masters read from ddr",
+	    "MetricName": "imx93_ddr_read.all",
+	    "MetricExpr": "( imx9_ddr0@ddrc_pm_0@ ) * 2 * 8",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx9_ddr",
+	    "Compat": "imx93"
+   },
+   {
+	    "BriefDescription": "bytes all masters write to ddr",
+	    "MetricName": "imx93_ddr_write.all",
+	    "MetricExpr": "( imx9_ddr0@ddrc_pm_3@ + imx9_ddr0@ddrc_pm_5@ + imx9_ddr0@ddrc_pm_7@ + imx9_ddr0@ddrc_pm_9@ - imx9_ddr0@ddrc_pm_2@ - imx9_ddr0@ddrc_pm_4@ - imx9_ddr0@ddrc_pm_6@ - imx9_ddr0@ddrc_pm_8@ ) * 32",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx9_ddr",
+	    "Compat": "imx93"
+   }
+]
-- 
2.34.1

