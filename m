Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A45C22615;
	Mon, 24 Jun 2024 06:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719210344; cv=fail; b=m5PvdRjmfdHmxelk4Y5Hi9qzjH1qXQOHFU0kKEDXxP5mIkoKGVVNpSSn8sAhcc5AibZgpaoEkvI0YHgv4ZMCNBKOYwyp/Yvwzh1H34vVoTQ6ZCE2NdV8HGgaDQ2Q7V9FUlxB9pyEH5yOAQr3TDmv8e7ezGpBCT7WXNQhDMcY5S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719210344; c=relaxed/simple;
	bh=QVOFDnV3b1rViTnFYoImzQTqieeg28+g9aiZ0ss5gok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CDDlj4O+8odlJKIAfUOoQVhYLb1Q9PjtYx14tAFRjJqq9XDZUTYBk0cxRqy5Z2rDmUeUfBA+42k8pGhHxDNwbbvBsLrdFnfX4BScsWaOkkjOEouRWe+++EbWF4H/GuoUGNDWvyJU35/nGGdYJ52Xti43uJIWN5kuTTzZVs/SKoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vw54RhsD; arc=fail smtp.client-ip=40.107.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vw54RhsD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hx5NWUiGurVzq9tqUoTeN87UlgRvMIMuWRjNDaQXpqI0j++qhfi22U01eeqoOjJFEGvG3IDYrx5ZGEv5vO3TasZ4JWno6RQmNFbsem8p02cATVJfys2x4wZhk0Vq3Kuphx54Qbbej37c28sHk8EnTOOkC+N3o5rvc8JKCgEkOGoOnjhwgysxVt5vFASz6oIy4/+RZ+uYBP1hrmavZ7aCrJnzzAi0VCV2cM32Q4XZUEYBjkza0mryVSKMkUmUiV1KZQQOmZ9jedhSm2r+CVs979Zut8OzLWgPRQQAvmEOskXwVYVrjC8LrQvZtaJTlUMqLgCVuRd7O13WxnClJpcSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6S6YSye4rj61aZo4J1wgzQXn1pgKBFst34Z5pUuTzs=;
 b=PCjxC951XF1kUb7GU5sSPMsO6TvvUVOtvU8/L0hx35zPtrXQvTcSQ2fEo+IftoHhz9AzkMoma7YWk2jPrCSr7RoCx4U4DhtVKjRu1ttgjXwaRTk6wskrfc7f4lwfSnM49RYZACkeyT7Bd2S//ukLD/LU7lFDcjMG5iOAYrzkpT7cDi1PAIPCSC6eY22T4KWBmyXu/lyjmBp+DL/Gn63mLg+CSMoXNCPCvdAnLaeH0n4GuYqIDaLddTJzyMs68/Ja/w2RK5iWhiEacODPSKNvm+rrPrh4vTE/z+O020brzpfJzq5xwvl+G63qqYoqTxAwMdzI1lg74y2WDovspQZHtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6S6YSye4rj61aZo4J1wgzQXn1pgKBFst34Z5pUuTzs=;
 b=Vw54RhsDkLKmnruP4zl7Ma2BTUoygDc6hAsAqtR0sLNlRk/a9DdKbuYR2H5x8h1vm8urs7SzskEgtTr/vnUXwIX/pptA18K8DeGYfdm7p/ULX3wlu6u9DKE3hlrTxKfDt3tqrAjqVGW2VH5HNMydZ+brlzoQdI22zAeAOyl2xes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU4PR04MB11079.eurprd04.prod.outlook.com (2603:10a6:10:589::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 06:25:39 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 06:25:39 +0000
Date: Mon, 24 Jun 2024 14:23:34 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: frank.li@nxp.com, will@kernel.org, mark.rutland@arm.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, john.g.garry@oracle.com,
	jolsa@kernel.org, namhyung@kernel.org, irogers@google.com
Cc: mike.leach@linaro.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v12 1/8] dt-bindings: perf: fsl-imx-ddr: Add i.MX95
 compatible
Message-ID: <20240624062334.lpygfmbpmstrn6kd@hippo>
References: <20240529080358.703784-1-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529080358.703784-1-xu.yang_2@nxp.com>
X-ClientProxiedBy: AS4P191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::6) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DU4PR04MB11079:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ee22b15-d0dc-4abe-2835-08dc94167759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|1800799021|52116011|7416011|366013|921017|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XfX4OF6a/Dl1fwVi80jaZFhb8eV7prlDYiGabgcoBtxzAWTjNYn0AJDa5+sN?=
 =?us-ascii?Q?FInr2gWSDu29TdYh4mUvHRZzIIn5uzrsYIvjTH/K0kSHiQyZg6sNWkcDNcQ3?=
 =?us-ascii?Q?BeqDBsI3OKf0MeymjynVP51+kHglKyNajqbyMjBY5uB330S6pQrl8uxOHFbc?=
 =?us-ascii?Q?IlNAX30TSqfuTqlL2RZSoodHBDhffYyh2FSCB0ryyNR/crgVYo3+H4qJbro0?=
 =?us-ascii?Q?0WY2B1yhd9B4MHowZ3sxJRnxI6INdTIwauz23H3BrXugYqcKcH6D7KfQDIa9?=
 =?us-ascii?Q?pycNBrAO7Tnl8d3ebYglvIIjrmdh9/mqEnU3RrPpgZh0mcDS8MtciCmnLvB0?=
 =?us-ascii?Q?HItKi8O4Uc3wh337mGvJ7OE3oWmXd7T224pbrUj123vybKcRngk4jdUZQAkM?=
 =?us-ascii?Q?XC85ZEjfwVp0QgpWaffCjtoeenPxwaA5BcEO6PKMhreTliqPONA0lhwsg6h3?=
 =?us-ascii?Q?o2EiAvGyCjUWECzgGrFCuqGgsr3bhSTAPnQhSHMd6JNsLj130yC8TQFeA4V1?=
 =?us-ascii?Q?e/P3PxmeWFYs1c3juLcSM3zreNEhy5t7+M0Sl2Rr3aI4flME+6d3XnSdRKUW?=
 =?us-ascii?Q?JAi2tmQ/h5NWXQPKmxHTaCdZjMXsVnpepyz3P3h2mALtAKOrgyjzmHRLTxYR?=
 =?us-ascii?Q?EtCHsIRGq/3So5TdcBYjkx7ni3EcUnQnZzXGEzJH2u9H9N2BYjQ7IfIm/zBR?=
 =?us-ascii?Q?0/lWBo5OX0aepcJBahO1vYFf3GTWq8PcFagOK1fSfKiumsabuLK4ICFCv5AD?=
 =?us-ascii?Q?SnDhGQzlZ5wQb5vxZAeTMIUG7gYaAaR5F+6kXIRPLhSsq+Jz4Zp+uYZxe3oB?=
 =?us-ascii?Q?GTNQJcl5QzEfA1Ml+lA97k58XRZfQWpkATc78hAWXflUTPpAMV5Jxsyv/h2u?=
 =?us-ascii?Q?1je1HRSOZT3KB0X54xn8zmuOLKn/KPfn1XMMlypZcBTbniqAc7rGKCRO+IHf?=
 =?us-ascii?Q?gATfvEEZWRS1V7+vk2ijUYAqVDoAy7Vy9RcRF1SKUrRKAD78l6RM40mNZ6o+?=
 =?us-ascii?Q?ymQqNDLwf0X3em3JesdXSPNx/ToOshu1Lf58q6YJ0lWThDhM0//QlGMZnilt?=
 =?us-ascii?Q?4M5iSICeQe6CHcfCdaC+grJF50zey3nHTAvrqxhFCsfAQonY2lwE2k9e+IxY?=
 =?us-ascii?Q?aDzgnbwN0GTf8uBRUfmqSmFcmxkmwc5PadW3UHKtSJqmfvoBonrRvNXcCsKt?=
 =?us-ascii?Q?3Q2HGqKSWq8UcIFIZGkxXK++ZkxBJlDBMFQx8NxwA5lRM9XLF0ObD5Rwc52y?=
 =?us-ascii?Q?uIG+aFZE8o1MmVVhRDuqk7E8NzebRj3G0/CBjl13VDgdvqQBlpUskA6SQxUp?=
 =?us-ascii?Q?v9VRkgSR5RH6MCD/2e514gueCO5QKarMt5tN7q2f7Rq2cn8a7MZzQnHtV7fZ?=
 =?us-ascii?Q?xZMZeHCJ9RTy+gut+LmFLqkRvSkI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(52116011)(7416011)(366013)(921017)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pRoc6uxMOr8iUVp9xKjrbZbwdRWCi0nzbsDMp3SBnG/j5X8E+IUXXVUiZARz?=
 =?us-ascii?Q?YMzUz35fPq1sBUtDnmte++3fV4iiRRpFPrzlQNUin1lMXjg9ofCxkcS8L1rS?=
 =?us-ascii?Q?hqJEcaqHua9t6MiDJy+gcCo1uSHZ2mpP/00U0RlcXk3joxtO0Rx9TiP+ToqZ?=
 =?us-ascii?Q?OT3HuB9Is9XQlG7ajROmuLPl0vGSf7b1+JYz/Dsaqm+plk/MeG2VGs7n4SQH?=
 =?us-ascii?Q?Mhi6S7GAZwcWIIiilPzs4wiDyNSbTEovw/8lfxR38X7ZTIRUWda9qBRTuFDr?=
 =?us-ascii?Q?Foe69FnZvNVNLfFkpyn26aSNpMeKcSAJe/3YWOxaAwth09YbeOuBOe2SElBz?=
 =?us-ascii?Q?kUwGzK9lL6ruRxomyJ91DgU6IvIp6qCRVwYhqmIBfLQRzgtpMcDvGViW1M7D?=
 =?us-ascii?Q?aSxYyfQkPkmI5Mrs7IbaorqTgiWUgaLoN8g0z0buxo/3Jq/XdKPUMSvcxyjO?=
 =?us-ascii?Q?KpHX+5BEnvzFUIxRSjc9CVRnAFuyYo3FBxmlMqzZNMkRDYNZbRWopFKOl9H5?=
 =?us-ascii?Q?QMdcNywEdWhs+63Lu/KzwTpP5hq9+GKNQUbOtl6AzrhXfRFenPeo8sQQ27Oz?=
 =?us-ascii?Q?8wUbmf20WcRxHVG7WmoxNa3bcoJ00G1wPIbAn2Rs1sd/uHDvT3Gc1wy0XSl7?=
 =?us-ascii?Q?S+7kR0wO1fZIVTiFhCOHiZLynaFRnuxzJRAJWQXlUEl7Xynu9HOUzp3o4CDz?=
 =?us-ascii?Q?Mtjohg1uVzfu0s7RkpUgPr7NVtRz8OTUsw0a113kHZ/v2H5PfRNRv8U351TG?=
 =?us-ascii?Q?f+FOVXNS/vJ2Wd4tls5/saimcfSH8rO6tf0vHWjcfdnqiMWpgDTm065ROVOt?=
 =?us-ascii?Q?+wGXf5A32NQDoYaIHSNoCQr/k8Ml505xl6i9UitlrCG8VyGF28dvHXllaptR?=
 =?us-ascii?Q?aTmKL5GDVAX/BAbBMohysmXQ+bEW/0Q6mf8VhwQfCkq6zUHiYvWBMOKcTgrd?=
 =?us-ascii?Q?Tn9dOlXC6D/JKj5WvMkQ0Z5H4MAzp/TpeUNHfQDx2jPXaCXl7QgqhSFMv4Jb?=
 =?us-ascii?Q?LCaMvPSbTMxH4GdnvWrLcUTJxkdTsV0AWxgVCwXtb1TqWAX/Mib9wm+ReLKa?=
 =?us-ascii?Q?MKymMEAEOTHTwMCH5q0/lWGEoUUrTFKJVNsttqMGOux+VsL7gxLXa1FIBtZl?=
 =?us-ascii?Q?4lz66pmE6djqQPVbFg2ZgvBKcczv5XP1cLJ7vgfhOihc5s/eC/8f3e22frFN?=
 =?us-ascii?Q?Dh1jGuCgzMB0Jbi12CXOjBtOaQ75X49DY3NqoWhCOhhkohwQtlSJuk9vRrKo?=
 =?us-ascii?Q?2b3YbYwx33dV0bHKZjKb0jGqVy0w8ak9PwXKczCg6amuX5ipRjmK2WZhcO1R?=
 =?us-ascii?Q?WOjsTX6O+YCEyOuEAgX0caEBeWo6an0KTgigIt3li8rjB2TwAFdWXL/gzwnQ?=
 =?us-ascii?Q?2Q0PWoxa5YMoSRgZNH1B4Rmsdd1GRgEeLsth6pPG2AChpt/96hvK87vhvqht?=
 =?us-ascii?Q?qJGNDU3tzeHGDfN6VUOeJ31Ei87DorMRA35RK17EE0IdM79BMjEGmQghXnh0?=
 =?us-ascii?Q?2trA83eC98ktWVvzRaIJZcsJ2b064ukutipoviZTKmkuF7PX15/8kcalL4Q9?=
 =?us-ascii?Q?gL3ATQVDRW4qweqEacr2aDzEG2LLOejCksGJhI+S?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee22b15-d0dc-4abe-2835-08dc94167759
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 06:25:39.3724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAJC/se5C2oz2H1nyJYVYUtwWZDHfZhf2PuT/YHhzr2Pc6KiUPPUaUfAGVgY5aGwFzgcvHbvPzi2EDUwZNnS3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11079

On Wed, May 29, 2024 at 04:03:51PM +0800, Xu Yang wrote:
> i.MX95 has a DDR pmu. This will add a compatible for it.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v2:
>  - no changes
> Changes in v3:
>  - let imx95 compatilbe with imx93
> Changes in v4:
>  - add Acked-by tag
> Changes in v5:
>  - no changes
> Changes in v6:
>  - no changes
> Changes in v7:
>  - no changes
> Changes in v8:
>  - no changes
> Changes in v9:
>  - no changes
> Changes in v10:
>  - no changes
> Changes in v11:
>  - no changes
> Changes in v12:
>  - no changes
> ---
>  Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> index 6c96a4204e5d..37e8b98f2cdc 100644
> --- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> +++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> @@ -30,6 +30,9 @@ properties:
>        - items:
>            - const: fsl,imx8dxl-ddr-pmu
>            - const: fsl,imx8-ddr-pmu
> +      - items:
> +          - const: fsl,imx95-ddr-pmu
> +          - const: fsl,imx93-ddr-pmu
>  
>    reg:
>      maxItems: 1

A gentle ping.

> -- 
> 2.34.1
> 
