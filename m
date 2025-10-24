Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011018.outbound.protection.outlook.com [40.107.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D069D3093CD;
	Fri, 24 Oct 2025 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312013; cv=fail; b=Y35ymqESt54rCg+PXRNu31/wPj13h11oliHH1PENXSgFUhfiXghkdsSAlXUmvO9vCF1Ydfj+rFxn2aIW6vjqHKpf+fJsNzskRwwxN9wxaGrzwe2Ypjb+rNMH2S8BT5Ok/wP5xUzIkdu+XoRJ7M8bWTec0gB4NUSapvRnBVkIzDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312013; c=relaxed/simple;
	bh=VaUbTB8XflqP9Na1bwB7pG61Zt3Y0393X8SUEa/stSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aEpr7BBE0DnIzDrbvNLBYopUA6cCEJAEm/icsp8mbfK6l/+6T/tDka2IlYgVQZjMQkrRWI26m7jGKtRvybc/SPoa0VivQ0+Z1j56lKM5sVi902Xqcxo9S4p+jnxYj6wekrDfBQkpYISMHlDeVp1ooib4f3/8OXF/q7kTaYpdgUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XxyyCP3r; arc=fail smtp.client-ip=40.107.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XxyyCP3r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDWZaadXWWRWFwjE1OzMXJmEA8rdzk6tRBr15SejLx8+S/nkyEggKsB/VsWcHalrk6iLYtIMF1C+m9QZ6X4OMNXOB1dc4eYdHJsItJh2fmtQmEtVuRLDhU49N90YzxQzTtFq23j+aQ6ZjY2jUM32RenH5llJuaC8aBf9a8co6ZQVXAtfwR6MnY4Y2A9N0x8K8C37tnLUoUOXez4hb0NTmheneGyaf7DWEPeWAem5ByOghG41K4wR7GT7FSllXUaqc/duYGZfLoxFVSr0ZF8AwDovzwzVXACs/2QnFnxgXywBlPs0kH3x0DhQCjnoZMHRIjTbgbZAULPdhmfCi3eRMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUbTd94axoLYxXyUS14CaJ5ZNByVlvwuOaV3KPQVUqk=;
 b=YOJxH12BoSMpjRw5z0soNuIAd2mHlbeMS2YK7vYjV1krxl82eaSGAA87a9gx78jgn+/ZJh1kSdtWKvFG9Wuq3WW9k9grSRGHTxL3rshU2wtRyk9xophBGp9+zyYfbhPMaS4o6HIBcpZoYpBgwbn6ONQxPUU1cBVvQfY3cSze1/BxDaxWaKcd7rhW2u/4H0IiTy+2czu05EDVndMoPNDAnRMcjxzu7CUEQgfK2bBuj+JEn/RdbSL32O0w4CTLhMte9MhAUYue3iYAV9Zr72wrIUSLQJY87y1O7WEVCuJvmRChMIsQuIhBl7GkL7mQ+vDNzpHwn3jmImuA7RdzPQ2Nkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUbTd94axoLYxXyUS14CaJ5ZNByVlvwuOaV3KPQVUqk=;
 b=XxyyCP3rggAKyUhV7aaG+dZSSch2S4dLJAJrMPtOW+pAItrUYOBOFj5u6gaIRQQUj1NL6sX0r8WfikY0Cll92broYS3O//IfXOfJ7t83Xe9eGmFBtLTZGNoUDxdBru636O/oqc79Go1k5ppI7MyabIJMBvV/g3RY7HcGG+VQzvJwKPUt7sW+qjZVx9aRLF21XHO1qib2kOVURIEHBaGaw8zQz4eHTEgDIVFRg328ehsuMI3bvfLvPl5y05QuFmlZGed6BxDEwlUhbC11Y35IBeeD6EDgkZ7dqk9IklpoCsDmuoSXopn5QZFCEJhJ3IqD9DmTflHbB0XIPgOtjI6QnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB9992.eurprd04.prod.outlook.com (2603:10a6:10:4c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 13:20:08 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 13:20:08 +0000
Date: Fri, 24 Oct 2025 09:19:57 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Xu Yang <xu.yang_2@nxp.com>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: perf: fsl-imx-ddr: Add compatible
 string for i.MX8QM, i.MX8QXP and i.MX8DXL
Message-ID: <aPt8/exvRPlP0iNl@lizhi-Precision-Tower-5810>
References: <20251023-qm_dts-v1-0-9830d6a45939@nxp.com>
 <20251023-qm_dts-v1-1-9830d6a45939@nxp.com>
 <fbef6d02-74e8-4550-81af-afe7ac4c989b@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbef6d02-74e8-4550-81af-afe7ac4c989b@kernel.org>
X-ClientProxiedBy: PH7PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:510:174::21) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB9PR04MB9992:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b8060e8-f811-4251-2930-08de13000d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O7c/nzIjQrU/XBqfCpSArHVnv1GfaGql7gVlNwpXX1SS1boAe6/uZKdrM7Wg?=
 =?us-ascii?Q?bprTt6OIZBMVnWm0nvehZp4ez7J/bxUBu9TXC5t+yEE9mAVDWZcYSNJKkt6i?=
 =?us-ascii?Q?MJXwcbfZ6sMrqDDv6j8eNTUB3FsdlZB6lYRyrh3H0S6+keJ7OkvEQhOJKvcw?=
 =?us-ascii?Q?PYaSniRMmZ1/SM8LJG68mw3Jf7njbeihf0RmBwOhD5TQYtcDQKgMcaEMye1+?=
 =?us-ascii?Q?CJElksqJ5DZ3t8uRN8mT6S/qFn37/lrryg0WA+Te/De+NFXUGS9mEL70xOgm?=
 =?us-ascii?Q?+Lgi6ERmoqeHGHjy/+Cjpg5xkQ7Ja+//rIpHxeAmaIKfzhnVohyWIvcvZ1cg?=
 =?us-ascii?Q?FwCp8bEA/nFNd9KOkSMSBEjREVrCUyJNdzKnazJ4Mi6GSduUkDxrUD3HT9fu?=
 =?us-ascii?Q?EwwhgbrqJc6id8yO/EtHbZjKRZ+rQfA63XzMoNsrs0j/me/6I57XHSx7WRB7?=
 =?us-ascii?Q?4edmAMQiUGyCJ0iyVhif4eE433iEkYwkhWMJKt699RUbfkw/eUUdjCw5Uw6g?=
 =?us-ascii?Q?KwR+uVqbDJ+pLomavxUelKihmFsV3Kl/mCaev7Jrvdy05F0XukQ5apVG1DJI?=
 =?us-ascii?Q?WaDgii6aaMVQIZu8dMFXadlh7fmvTCcdIU4dJMIuJS7tLZ5HZM/Ti/xNm7Ht?=
 =?us-ascii?Q?7gpFMpdcyIFyk/OieikHZMJPOb3bAHYDZ3v3T3d/ziYGMXkGQ4vrtm10k6NI?=
 =?us-ascii?Q?c6rZ8QBMuyGkkJz0pQ09PAWpMiJzHDRgYPxh4PkJdaCWgLi/O0Mk+Zd7c4QF?=
 =?us-ascii?Q?ihOAjfQHqjiAy8ddI4/LPECaV3yWu7ozLz0w3L6I4V7UG6RHoJMhuN/Uj8T4?=
 =?us-ascii?Q?eilIRMMLTK2yoTjTqH4xLzgWfSudl4tuxlZdKZChhozUo91xAt3CpthP3jpM?=
 =?us-ascii?Q?dO4iSPHFWFs52CqcXOlf4/UyJWX6/4y43N8u2PQq6CT8nMgpwYJwTvMT7dpn?=
 =?us-ascii?Q?VQ0yawYa9xXOwnxxn02LUErTokb5rkfdPYU5afKIOfdtKoJfZNgZP7R9WUmv?=
 =?us-ascii?Q?aMaXWdFHA5E5HfyboyNXTIMu+1YWCfcw58jCJAB2IrlB0P4DD7Txk1AFg4Zx?=
 =?us-ascii?Q?cFUCgZCGlIvvEert919pXhbwI11/xEslKBuw1JjezKbRuCYClLwM+t9my+kY?=
 =?us-ascii?Q?HgLVqhNR4jMBRe2zDd03PDwBuK5Te3MmQd99sAwzyB2xKpnnrVAvmrV9deHq?=
 =?us-ascii?Q?rCdGuFVJZaWXzziQ6po4spLfvl50Rl41drcExwJbghNRLu+H33vWL6Q4hPAz?=
 =?us-ascii?Q?4flvJIx5gOx4ZQIs31PZSJ9v4K7FdeI5fkJWOzAa7pURDrUzpUdZqCJ1vwE1?=
 =?us-ascii?Q?Ozg5IQjAYqmLiaj28qsL158k05z+/w91Z4H/q0711W9TbKfqaYkUwBxLJQlm?=
 =?us-ascii?Q?+gdpNRp/xmcRp6hp4ONHXcJgddRuwG4OGe4swtOb/eTXDDE6dg980D2Uwko1?=
 =?us-ascii?Q?GGGTzI+9jG8hIXmF6fpLHVoIkcMJFgdWRVWITdre70E1EMpyZdpJV+2DvIul?=
 =?us-ascii?Q?EAIN0UYnh7ppUIY1nJgW3OXf+UP/blzUsjMr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qCuprZXRNMuT1iBtOUgdO7DVbIuSrmWjZtJKZWb+VIHgSQ0pKByRB/DGvtMK?=
 =?us-ascii?Q?LbWPgwXAUEAPb9+Kc+hm90UIfUbFmrpb1vYa4ccyPQhUgxIc/lfH0nVltJnW?=
 =?us-ascii?Q?cI27DD8zsoxv0/WkcXjas4/1Ar9uRYJ7O2wbtuD0yWAfP0E2ThHEn28GD1ck?=
 =?us-ascii?Q?zGroINcMesTXBfMsmyvd20rJtlQ+CYDMdeti8naHhGynEFJyqk2hPr1GI9sX?=
 =?us-ascii?Q?UAyqn0iNmtkCKp6DHwsdIHP8sI2xE4dafsYOslQBIEUMn4bxs3PF/K+xt9n+?=
 =?us-ascii?Q?5P9zXApGaQfsbS1w5zsOx09kDcdlnKRMraInqt950jja9Q4RhwAIUU3cMade?=
 =?us-ascii?Q?8GMnySE4RGna2PNbEV/fP7+H7ZnB0xeahvG6Zcib1p/hQaJ2qwN2ZxJe4rmF?=
 =?us-ascii?Q?l7YzbzEW7L1qhPwiO5pMfIrpD5tLuCxM2oh9qMYCE7jh5/ndfzW55aKxidmD?=
 =?us-ascii?Q?8wA6LJSWJJMI2QdSA62YS7JMAdR7rxmSnJBYOfh2bgz7jIQ7zgYoAL6R2Hjk?=
 =?us-ascii?Q?5QwHEchOVmHjXJ+t5jVp5Y/5bdBKuQVIcEr1gZFY8uQrGqzIAQe4IV7dIFwX?=
 =?us-ascii?Q?wgrCnc7764biPgED+C99m4R8Txm44nGwkp9IZuEzcNCvTCAlArAKuhY5u2nQ?=
 =?us-ascii?Q?eVCG9jTnQkF/Hcd+H369cFcc+SL8YBA4VErcZJCRJANwDozzNoJr9tV1K0OV?=
 =?us-ascii?Q?u3urXmgWLyc1UsXi/4pQyNtpzPHmH3X0cCvNrSlSDxYSTCn8gM0s3wI/Qent?=
 =?us-ascii?Q?Zc7WBlTNPtdio2uXwIKT9uqaDSBjCMd9g4IWDRrY+FhzcL8WdFqMvdIUbwt0?=
 =?us-ascii?Q?cCiUSUCYd7FRfYiIntRbxfmmYfoGuH6rn8UteWhBp0bDfB06sJ3Uwam7vSnp?=
 =?us-ascii?Q?69lm2+M7p/yz3VWMf2vDaP8bvLlh2VWVN3U0zVoMw5C0SU7oskG/3b17H8kb?=
 =?us-ascii?Q?dqpsDYKfg3DR+Ftj3WuEiFq26up/FVb7FQZLyGJYA8lnEX8HYhkM10WhCKod?=
 =?us-ascii?Q?FI1J5IZKccj1zRYwlmkq5O+Adc1d2fcVEmwXPGnj0EPBgA9M6JrMVqQwU0TV?=
 =?us-ascii?Q?SMo9ejRn/1f/vQzywhUvYcFvmIvG7oPudYdZdExccSqT0PGKJItC54lMZ9dU?=
 =?us-ascii?Q?tHXaNTsuqQ/J4/fY/T9phhGcE2ND55odUKgJrH0RLtZyOFMjkzI3UTMOvVD7?=
 =?us-ascii?Q?Er+VwZOxGL0V4hkw+D4BS3Dt3kh5A89awYnTcBP5N+MgxP43seVaoBLu3Agc?=
 =?us-ascii?Q?JB2IMM3PqDZQ6otnpz/LkiaSlN6dSrxcn6FHDDa02rkvaMcwWUZ7euIiAgD1?=
 =?us-ascii?Q?BALcaEw/Ol30/6rFkD1BXMZagRPKIHHnYeUXYWHHxkbc7gfrGs96chla8Kfg?=
 =?us-ascii?Q?PUJ3zItpF+2C0JbkIOnR77mnenPVoVpCSApGKRd4DvEtK8r/7gx2Puqb8iIA?=
 =?us-ascii?Q?BIdwoMAD95FMy9pIvzpZW8dMA1kTzAcULLjEJp4iGG2gUjzFULCr11AgQ4dK?=
 =?us-ascii?Q?ecTsVNN3y8WAmy/O79b/AYkHkkYjNzJ2TBADe3Ig/pCjeIMRxNYUVZCglSYk?=
 =?us-ascii?Q?MmO+ossoSjuhleontDiYaYJtVcX6iJlyl9v1jnLf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8060e8-f811-4251-2930-08de13000d94
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 13:20:08.4522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RkKgZMsmsxuce+h4zfkxZpeASQdoHRk3RfSm/ZVvglqa6YfJeFF4//spHIraBjHAwX2FkEqTtXIVJJSpvVK75w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9992

On Fri, Oct 24, 2025 at 03:03:10PM +0200, Krzysztof Kozlowski wrote:
> On 23/10/2025 20:56, Frank Li wrote:
> > Add compatible string fsl,imx8qm-ddr-pmu, fsl,imx8qxp-ddr-pmu and
> > fsl,imx8dxl-db-pmu (for data bus fabric).
> >
> > Add clocks and clock-names for fsl,imx8dxl-db-pmu and keep the same
> > restriction for existing compatible strings.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../devicetree/bindings/perf/fsl-imx-ddr.yaml      | 26 ++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> > index d2e578d6b83b8847c7a0ca9d5aeb208a90e2fa6a..13eb13a79e2100ae1d747ddf6fc4db5b470112a8 100644
> > --- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> > +++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> > @@ -14,6 +14,7 @@ properties:
> >      oneOf:
> >        - enum:
> >            - fsl,imx8-ddr-pmu
> > +          - fsl,imx8dxl-db-pmu
> >            - fsl,imx8m-ddr-pmu
> >            - fsl,imx8mq-ddr-pmu
> >            - fsl,imx8mm-ddr-pmu
> > @@ -29,6 +30,8 @@ properties:
> >            - const: fsl,imx8m-ddr-pmu
> >        - items:
> >            - const: fsl,imx8dxl-ddr-pmu
> > +          - const: fsl,imx8qm-ddr-pmu
> > +          - const: fsl,imx8qxp-ddr-pmu
>
>
> I don't understand the need for this change, not explained in commit
> msg. Why do you change 8dxl-ddr?

I have not change 8dxl-ddr, but add fsl,imx8dxl-db-pmu, which is difference
with fsl,imx8dxl-ddr-pmu. (db vs ddr). db have less events compared to
ddr's pmu.

Frank

>
> Best regards,
> Krzysztof
