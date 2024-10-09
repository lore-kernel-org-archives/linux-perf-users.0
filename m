Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010016.outbound.protection.outlook.com [52.101.69.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F18E1E04AA;
	Wed,  9 Oct 2024 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495801; cv=fail; b=LxPKab+ykeVu7faqUB2TGT57xD9hkt0MHf8M5y8yOwnJKbcY+ixa/HxV/rmmFKvIrQogF5OgLPeboHfsIZWQgcN8YHwpFbQaQ4eyFLL/TMmG7cIEhfi5bRqRDe8ZJVE+QKef+fL4EbaIV5lJVQJGTTJzBM2nF026I8z1i8ZPCPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495801; c=relaxed/simple;
	bh=wBDeM6OL7Hpp+MpTkAYAAND01iZlidGH1tqYnDZw4SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FyjUTemGuCXAcOVJpEjA5CDZSraFyVNKie/C0AMcVlbvWpX2YW4ZyjzV4kekCZ6XDR4VrMFG9Ses6Ts0641XWB2PNTfR2283Rce2fmJU4ymC9uNal1ORZY18xqPSRVADAgnTe3i0YE29VVM6fYVpiJ+uOqgkEYhJNMKfUviJa74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b+uu8m2u; arc=fail smtp.client-ip=52.101.69.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b+uu8m2u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qts2JUz08h254Jm/1dQW7PAXspK/9DCneOMZ0223VwtNk29sXGTEnHpohtRneP23b7tKXoO9aRCK/aL8J1iRxV275nsF8eBYeR61/ND+eAQZI8B7JeezJWKv5AMgW+sihovhbH3OsRQrd0SkNDDRR+BEP76d2U3bg7W1UcvyWYBARoF3NYz9WWnEEz8zyzsR1taeWRC6BtRKScpkBJhcejxmwRYaF2nvDq//U4HHXz/+45UYMELpcCM1sMNQ1GZ3PCMb7ECp8DbL5ngESjnPT5VzpAwJao48i+U4WP/oNUsbvl4rB1iZzET8mZdR5RETMbW1gmrRO+KqqzdlMBafuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPH/GkxyL8K8yUTC24yJ14OpiuuVr/wR35ZLQR0DnhE=;
 b=p+yfdEsMRkzDf01b371Uc5XJKphx1167aLuEGvv7BJd4x8gxGrUsMr4PY/qdg77/HSjxXx7LUOtITWDd3HLbh1NFSBnLqUF6b+qxWLBjf+0U/DS4lp4ZBrzjXQdtVj4wASPxJXEFkCrYf0/OSX2QD8b1FO6xweOaSFIfRm3C4Wi4n8jqLJkXjeVITNpzRdwctmZ3/9Fz5f52FnbqIbnPGS2a7SZRaDi061q7Sukd1oySrIq6j688a5ErwxqqpVV1t9u/guPqlN5W/XUwZDkrDZJ7awgWfpoy7k/S1NOUuNAzX/euhHIByF/vC8dnzq0++nUjt0YkWGpzIhHndWYoTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPH/GkxyL8K8yUTC24yJ14OpiuuVr/wR35ZLQR0DnhE=;
 b=b+uu8m2uLzNMQI00M2Ok9SUwhm8N0Bc96Hk8ZpR+7hQsHJAAtacliNXmXf7NBFaVHwaZJ5B6KWmvHS41ZQclGllVqATcIsSx/Bue7aqmeu1QY7XeEse4sfeVpRZafTBRkyctE4RUvTG6OHzSIofQIQYGbpyxGBMhJlcgGnTaGaGewjYXCbcr2ywXVY3zCmJdWpzcTCe7WenCVDycR6JJ27RMyyocxbepaHQBux6LQfagqwoJ9TVUURKF6ujxpvPRmsK7cUf2bP1uitHa1i1ufESxXo7Pg6Vx5BN6N/nsOSUYIbCMzWACZoDRhnbd1mttlr1lfObCZg1pto7p6ma1IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9363.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 17:43:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 17:43:09 +0000
Date: Wed, 9 Oct 2024 13:42:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: will@kernel.org, mark.rutland@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	john.g.garry@oracle.com, james.clark@linaro.org,
	mike.leach@linaro.org, leo.yan@linux.dev, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: perf: fsl-imx-ddr: Add i.MX91 compatible
Message-ID: <ZwbAoi6R7MGWHLEI@lizhi-Precision-Tower-5810>
References: <20240924061251.3387850-1-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924061251.3387850-1-xu.yang_2@nxp.com>
X-ClientProxiedBy: BY5PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9363:EE_
X-MS-Office365-Filtering-Correlation-Id: 27438e8b-0966-41e7-f98f-08dce889d6d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4BFV0Z4XVxS/ZUuJIyM/ZOvnzF6MUKJ50m4WcKoVBx1Dr3AmnLOpC94N1LkQ?=
 =?us-ascii?Q?/e3it5sgjA/UUKBBbLs3bYNyJVqdQafBdkQgPuJOgsjULYxO/xOGItCqx/Yh?=
 =?us-ascii?Q?zlJiACKQqhNCdsCDWvH3hdFpgWrgE6YyMKUgHxw1hoYhx0mQExcaphwtQgJj?=
 =?us-ascii?Q?lTLfSlp1W19ON1e0yRKPXUN3iiCRMIMYCF7SiFKhK/ACG5951eYPXGp0XbEb?=
 =?us-ascii?Q?R24iYOHCW4x7chkB9UlP3El2uXbTg8ePpm7z3Gp8+ShBWqj8jnt4ympupGEe?=
 =?us-ascii?Q?SNV3BqYEppJH+paF14ZNSu354QO/algkXlrMDdDGwPK65/4rwQi3qIrSDahE?=
 =?us-ascii?Q?raXDvev6ao0wsTo21j58FDjpRR2r6NYIgztCe2ABOCyKs3ow1y/mnZgTmSwK?=
 =?us-ascii?Q?KjF6rF/xequpu8khusO0Mii0KTFUqdHgcNoJzwKrgLTuA6z6kRGCv+u83y2X?=
 =?us-ascii?Q?7beRyMvR7YBm22o5a9v2LOBcrKXDvbxfZzZ4JVYYE0yzPdhICfmBb9840zeX?=
 =?us-ascii?Q?sHu+yNyVJRSpNis9gfJwVab77xr0PQ+6x+749VfY97OlSp70jRP9vHd3eSMd?=
 =?us-ascii?Q?lNVZarte17Cekqxv4P4GE9NBECmj7FiNZztxvKGEr9hdj3PpQ5PoRNQJA/eX?=
 =?us-ascii?Q?IMRmQeHaL1z6tNl2xVydmLRFta9Lua/zSy2Sbwo7Yio08NznfdLzicvXYkQt?=
 =?us-ascii?Q?0KPxBWbRF3oPzdmPINaD3A8IqUNf5XRI40GlmIopNeLPw1I6tbyhBQ9CaLvq?=
 =?us-ascii?Q?Z38ruoXlUYAPs3J0GtvM3GswyEXr5Q0SOgg9qu3QtvVv2QFcRpqXuY39UxSB?=
 =?us-ascii?Q?B9q3L28S/7BQZyYTdCKc9Pgipn0FjZur7gLX1niSfAL9fm4aKRD8/XtWcMic?=
 =?us-ascii?Q?MsVnga6KHcrFtu/re2pIncWc8wv3EbnRzVowNlUGCtdkjuqOEg41JxVmlLLP?=
 =?us-ascii?Q?lB1mN5IVxD3LyAvP5Sse+JDu5maaJOaXFP0dmbNmX+8OGwfGUolJrC8Iw6Ms?=
 =?us-ascii?Q?T+vSMvIFUO3oWer3AkRvoafus47wPAxJJF4pysaMjue9/hvFSlNqCPB57lfy?=
 =?us-ascii?Q?lcd4Lkhp8E3xN2e2Djuc5eD+setOWEw0f6UzcQa4WjfdNPoWTVl1q97pCj6J?=
 =?us-ascii?Q?YAMgyMsN2b7gWIlQLz6UP/F4yMfWFO17qcGw9VgR95InUzztjfCXzexpmkEO?=
 =?us-ascii?Q?SCDoP4YM1zcWqmjx3mJ4+P9HTwzDQ8WHeLuBZp3Y250W0EL9SgaqFBH81IiF?=
 =?us-ascii?Q?+AHv6Vfmq40uhOMJ1rYqlpiI6J6W50YRj8z6Vn0MBZ8+L72bFrbHBXbqUSZT?=
 =?us-ascii?Q?ui/+IQIH4T9tWw5jbY5TfsmqH/NhEtt0hKfiqgRdAmDDxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rTk9zCijd4+mjtm+fq7qnODSMVGVSai5pDuGLDvSRsyaLDYrFk64iJHLXHEa?=
 =?us-ascii?Q?lBN8VwlSo5PFM4nrnfjTDRDLVdJc9SvItorS1xCROrvH+u/MK1ezSTQQfp/3?=
 =?us-ascii?Q?/CJWejHVr1fDTqD/YkzlmfNjFivVQSZJXzp18vu1yOO9V9AMg438hORdovyQ?=
 =?us-ascii?Q?EmkvMowIrk0zbkoy05hD3/NbvbCab/oTHpI0sA7rwzC+4ijAsZTE9rLtRTD2?=
 =?us-ascii?Q?IbEDiFrz0ZC9zMCebu5L3iruUHehUfms6tj/yoHmiwanfgH+tMG3fGpEgGLQ?=
 =?us-ascii?Q?1H5wVj/ZH3bwGJK6HvQndnhuStDr1wG1qgyHjWcrotHjNXHmv+2f/MqFkzVu?=
 =?us-ascii?Q?ucJu/HIJYE4IJg2jwnY1+nd4zbxMCz0mS5iH8F97cPuMj73p3btgDQOakFZ1?=
 =?us-ascii?Q?tXLhhKdywgGz+yDOO+aU7G+FoNJc1cDvczDzHkVyuuskOWbSsnJzi1eF4H4s?=
 =?us-ascii?Q?mhnlcKcv5N9Ei9xUcoqkVnvi5K0f/HI6NP9pcoB/uWKum2cJZnOAvuBbc0op?=
 =?us-ascii?Q?NiKWBB+geh3yjBCCRy3827bFxKmMlUlfKQjCuBxq1yJR7HT0PG9ij7Z1RnD9?=
 =?us-ascii?Q?Ja/z8GsCLYND+a35NO5eog1/mDo8nfM0YMFKSma5UN700QZsIRW4NqU11zD6?=
 =?us-ascii?Q?uN28U6lYCtFH3HJ5zmlmpbl1Nrj+LlE1bhdrCBpRfef9dDY1iVu2oMxT48Lw?=
 =?us-ascii?Q?EF2NNTCXM20mn+bWZJPjfDtyOj1UKMnxIMtY0H2oO/vtE16HHbnK4gES/mgx?=
 =?us-ascii?Q?fCqSRn2jFN2babg7n1oOUBR0jtAyOMRvWzCSMKBSdMXQqe09b+gWaD8pFqC/?=
 =?us-ascii?Q?vhYJPR2xGVaJc/FDNC1lKqzVgcNqb9DNqLJz7F2kiIwUW2tnpQ2yKGfFrgRQ?=
 =?us-ascii?Q?tBXE8w1tikfphi5Odnt1KU9tJUl+qINjlIwslNreK4ljLen9nozxkorC6iby?=
 =?us-ascii?Q?7DhOSrN+O3R5ffQ9rW6wvbmGyeeZYq+IpCOQm3Wlygp01eNbZpOIPSVc0jn/?=
 =?us-ascii?Q?6khk6yf5RDEgci+ow1AHbfE7coUo7DQXdewTGD8l2vH8N39gqjN9Y8a1ljSj?=
 =?us-ascii?Q?BOnN6h9Qub+FwRdo4xb3hyiKAsPvJg/93N1vMvaVYI3YYl25KJ2GA3FPJf0h?=
 =?us-ascii?Q?bGCLcQ20kem7wnsTT0FqyRBO/kXzyedfJ3Dsiyfs1oWNupArjrlubvWKW5tk?=
 =?us-ascii?Q?hKjsV8uhY5GFIcTk1+eBc/gkdg60hG3SwJoDJg6jMiOepkniQAWNP8Agz4He?=
 =?us-ascii?Q?5tgLErPHYgc8JZc879NyoouEVOyrMzxUkGwUBaLzIX3jhr0gvqlSiS1w1bz+?=
 =?us-ascii?Q?nqVfcAm4o39LIEPICvZIXWUqKn/ctecuD7v84/qQRKHE3AaegOfIgcWuJXXE?=
 =?us-ascii?Q?lCLh1vMxiwNuHGOn8uFV3G7AYZrmtzfVlAtXltnKjZ+a/LcgxQYvq1/71umh?=
 =?us-ascii?Q?Srd5yFdeRfU4NZmIkvcCjpAdK7sLbQVf7tZxbdtI8dTmsmbb//LRdWv/YUF6?=
 =?us-ascii?Q?QHCL1EsnEDkwX8YW/h0qskPEvfDQ9YESUpxnL0uorUWwxYI+qDthxIOLLNt0?=
 =?us-ascii?Q?6Vx54rkwM58yomz/C+ZMoa1qBzt66zuZ7aWPahz6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27438e8b-0966-41e7-f98f-08dce889d6d6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:43:09.3778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJa74Hyxjt6E0jaqPLVwcKdF2D1pZeuvsbxPZLyJ0qM+GumPODG6puWX57Dl/TYuzZOl8PANVTlxyS1DyDZ57g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9363

On Tue, Sep 24, 2024 at 02:12:49PM +0800, Xu Yang wrote:
> i.MX91 has a DDR Performance Monitor Unit which is compatible with i.MX93.
> This will add a compatible for i.MX91.
>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> index 37e8b98f2cdc..8597ea625edb 100644
> --- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> +++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> @@ -31,7 +31,9 @@ properties:
>            - const: fsl,imx8dxl-ddr-pmu
>            - const: fsl,imx8-ddr-pmu
>        - items:
> -          - const: fsl,imx95-ddr-pmu
> +          - enum:
> +              - fsl,imx91-ddr-pmu
> +              - fsl,imx95-ddr-pmu
>            - const: fsl,imx93-ddr-pmu
>
>    reg:
> --
> 2.34.1
>
