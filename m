Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012059.outbound.protection.outlook.com [52.101.66.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4090418A6A8;
	Thu,  9 Apr 2026 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775738581; cv=fail; b=ON2HKbjo1spdvKQb7HUqaIlNrLKuUAUjZD4db9oHVcX671IYmDK40bVLfw+sjCXUynSrdCK6NK/qx5A4MZ0sw6xK+uBWELbmkQxfc1sbHVggxQ+1TYKz0cZeuyvwgKgbOwaUDgrU0hb0uJmlNgG5usy/jCqUAX70LT6yXsUiBvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775738581; c=relaxed/simple;
	bh=LoeFpHWX1fslxnkGrbtiITMU6WCvY4WZPCvPC3E7mAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N+UU9ImZoKVv1+rz9MsiPUGowH6/5IkBXmR7jChP6wD/HO0fw7j8AjZEiDhMRiWbZhc9t6TZYNvFQCYEWGqYvkeg9kTHzoUA/JFhuzt9HC9jB6Z9rOxCrCYSlBIJ3JVT+ojguVfc2MlfQVvUIWnBdCJdso4Rv5C1GnG2zNqbc70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VVEdlLG5; arc=fail smtp.client-ip=52.101.66.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VVEdlLG5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TeWu5wp4lqm5eWs4NIAEvFvWRkCizC7rTxqCmWx4bvAAYSwboszkZgYNceR+qgjkobiRKM8PAGreVLUPc1cn89ZTUYbQXg8strQAZu4lQW7luWAhk6+FPcog3A0T5/BLUzmxMubjo4sRSnulyHPvfrNx8gTL18Y0rDYiSBtMgosYmYovseEqwKbq79AePBlLKtQ8rtmd5e1dY36//NYsua0lFfTMT7rbnJL1y945coL9aEEfscbNmzOFDFJtmjjLgxfKcdtW5RnyRajKTW4oTV0ImieNxwwiMeOGZ7XRGS9kuYAHh4Uzni8G7a448YJjDY5vQQimtn2MjRDXuN7pYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSEjgyhC+gpJo9SiL0Jqsge9W51TmiBUhfgtl4WYWDk=;
 b=BOyrPTtAcN9rK0Yn2SjUpV/S6GlwGb8PWT9oX4o01LhtShQ2MxCV372EjmjjZzfjXMQxd0wD0ov0UgOGuf1z3EcaqPqIBtZBKIMNvggkivHVgDzK7OxsjhrOC5cVQ/NCPHx7SKW6CnyemUw3N5lbRczxR5XD04/WIwkQ2HPkqBBdgBLJ5V/4N3MqK3C+Y9JEYVBBe7+0956Xs5EuXumxUZUyadvVn2ibzMdOvRZ381Z8ZAsXWMEpmHTo/pnv83Y2SbYmTOuxR1jpYgPPQeBuTOlbHUZvmmaY6ezpmWmtHG/Me+ddIGX7WhXw7ZntJM6Uof8P4BgTMSdQwbx3y5RNoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSEjgyhC+gpJo9SiL0Jqsge9W51TmiBUhfgtl4WYWDk=;
 b=VVEdlLG54O7nL4wk5tKzRmngunL3V3iCHh5CkxS6rbPGWDIWsf4RI6difi0vtz9Hl1NBai2t2RGKBU4hPQRc7wt/tcQKbVbSEmJsiYXcH0tUlTyIkyr7Q3qAeEgEYlWgr5Xszybs9YJC6vd1LdEMnGlQi1U1PXEw2wHFHSBBvFvK6rQd8UFTK/VcH55yTZNPQPTAWFPn15E2zJNR9nUsUUJ11kqnN65lDzQY2ssmTYe8QncynNjHM0Ce4pDcvYDMM1OKeDyGwn+ZKGY5oFuEievX1WzB3vODpTJLip4vtpIbKhoHECn8TMIAryS7XAZZj0FM6w93kfgh8NkPXRgaPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10632.eurprd04.prod.outlook.com (2603:10a6:150:206::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 9 Apr
 2026 12:42:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Thu, 9 Apr 2026
 12:42:54 +0000
Date: Thu, 9 Apr 2026 20:45:16 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: iommu: arm-smmu-v3: Allow PMU child
 nodes
Message-ID: <adefXAmJQ/pYMENq@shlinux89>
References: <20260408-smmu-perf-v1-0-d75dac96e828@nxp.com>
 <20260408-smmu-perf-v1-1-d75dac96e828@nxp.com>
 <20260409-outstanding-arboreal-peacock-2de6f1@quoll>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-outstanding-arboreal-peacock-2de6f1@quoll>
X-ClientProxiedBy: MA5PR01CA0224.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::7) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10632:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c14276-0522-41cd-5ede-08de963584c7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|52116014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	olbn8gnYEk4IBc8spyzk03wsuIlp29cfnC3S5Wb35nsLbupdgDQY5jOrKXsUmlKJSSgRKJ8wi7ZsLHI8q9kNoiiRHM+b9OL5mUrUrMvGh3KBBJM5eSuTNekU3oKCJoO/yy9haGnPJSBvgOQW7evoYoHYJ2Et0uL3dc8IjDx1OawlwU71bOoYNWgyU2iv879MyIvKOCovQW2cJQPIaUZRwoclAsoCB5U7JbXA1fM3yDffdoYHRZx37D1HDbSqzLeBIZJOW4iNMeRIqOAJK3C0RAt+gXF9llyKZiK4TbpRr88rhs16gfz+bjT0PH3VQNe6YTKvc1lnAuWtukzxbacM9+ZqvrN66TuPMN7zmVcq/g4kWBcDbXxS/ECH0K2oNoDxOJK9dW4+3NxZ5i/CMQ/6JbSeRQL/B4ytei8jNCxw6e3ZigRivTyBDzMxOpFKsZj42rSNIIej6AnU8lOvq/lfNvHAM/TQ1pNlCTaKpabb10vwhuZnvRdqRETZ5ypeywIcz9Y3Vgl4T5p2Y6RGyFmqzt8jvAK/C25m3hTw0ghYLp1DiDWemCdrlw9+WFBoHQ/uoyw/VBQZ6GIkhm7yOYX+gcB21ld2vp7o6MWDE+NJqEqMm2ZHPCe8jv6lQq+Li2h2VBGCQ1BjwmlfB4SJU0dxoxZXLimJiF5A0kitT4r7cNAtlU4KSFe4b+YKiEyrKH7MHLdFoggGQZMVrydsW0O5pntlYW78yQEKCyUZYcZPUuMgu5WJCklo+SHDv1QDNsKaaQ9Yp34BidisJ0arEwpuM6+BRkY3Df8GuWtcjlMFBs8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(52116014)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9/Ir9bkyFDd1laNOhcDbxOMh4BCdl36MbjIv0PS+1F1tCHBJUd32jFG9APlq?=
 =?us-ascii?Q?Y2jdXqNiKVsJfpnSCkwppEQhc3mWzibxbymcE4jA9nNVabKkryjSqac0D6W7?=
 =?us-ascii?Q?L7UEccPnrUKEtd8ozgxDV9JGgLnErIr4NOZOzb1FsS1uXsugQCPIvxWUvmCb?=
 =?us-ascii?Q?af9N6tLpobQmGTUAkHRrG3FlnQmud88ECSiTZSyilM7cD7ZJQEbPH5sPIx0C?=
 =?us-ascii?Q?wWoEBXcB72s49eqAsODnzf2lPjuN2WoSbg4tXjWnrCkUbtWkO7CudG7BVWKe?=
 =?us-ascii?Q?YxReLR7/7QqnCEPuIutGmp2Kf84Xl4w9GyCGdVKevwZf1dMDaVgXo9urhv13?=
 =?us-ascii?Q?t46qaCGgI0aWjNvkI7efFQ4uac2tHH063eN3tvdbMQwmz/VwwnFF4NAXfMN7?=
 =?us-ascii?Q?jiUmfF7nudgrQ/qul9V5QgH/Ct52B1VI59tGDGnntrmiQk7boBK4MOeZNtPE?=
 =?us-ascii?Q?yjyT/73KWfgxn+G7G1x5R6HanSXctAta6GE40kUYEQcsqamt6aF43Ste9Q0d?=
 =?us-ascii?Q?ps/QjRdTbn6tr7pULle6QOz3S5iTOiNnqnDoYhDjMA/D71rAxgPBbzFuMBZN?=
 =?us-ascii?Q?mmsjsdb+EdzLtjZG/Xdsv58MVRknx3N4PFcBxmboSYGduHxIQPEl9masdmAc?=
 =?us-ascii?Q?uJjhVMYr090usn+fHial3qP7YRw3zoqIv+IvyRoZCv0/GeE9iINIPPZ+opVz?=
 =?us-ascii?Q?YfbS/Z7ijDGJuW2tJiDWh7bZ3UQOf6kjdzxOSP/Y/fcf6DBsz5AWeerNWusb?=
 =?us-ascii?Q?cRzdHwrihK5n+KdegSbDmwDZRKAwH6jH+pY824vYz17DKQZ6pn4Cu6NmHbxE?=
 =?us-ascii?Q?TkrLN8n1N2VGIP9Wn+gSlHJWU1IUPnYQzoM7lDL0ngTSXVPDaK4vQUdQuqGL?=
 =?us-ascii?Q?uOlEuYZ5zWqI+hKf9lu5ABqwVzOTKLMHbk6AsK8/gqw5q2DWQ/CyMrLKEqc0?=
 =?us-ascii?Q?RgovUotFl/UnMYRSfcPbkwMbVLwdAwTgOqzbMBLdihhWy5nLgOY8eH1SNzDc?=
 =?us-ascii?Q?dc6JINM22qhs5xpq/QfelbTXw4ODidI9PlOma/da1uiCEUno+JLQz0AjpuLg?=
 =?us-ascii?Q?fedMcmWW7hjyMSjbKh8GpfD1DOeZ9U4gwKAkenReCg8djxckZ/sHmUc0oygB?=
 =?us-ascii?Q?OIcSUJfh68rNXZVVbr7f+d0xvy384eIWQuNgmKShGlz9IC8D7TWTchs4BZSV?=
 =?us-ascii?Q?GhvUB9wdY0bjf4Xkb8y704sh0nw0tGN0OOTbS5kPqhdT4nI50iHu6hQtn1Qe?=
 =?us-ascii?Q?dbnDUIxq/U7BkP744iZy4HbMkPgSDkGft2815PZku/bLUkUuy3hrjwXAT4ki?=
 =?us-ascii?Q?PkCcQmRZYlY3PD7D0wR+TSGeADmyngFOxeLiRvhaNmn8AUBTh00i3jsfffX7?=
 =?us-ascii?Q?ak3uRJcFhqinSMYCcodmBVKVHA6WNQHFhuY9IlaH6ZxI9foSfLa4JcXeya2b?=
 =?us-ascii?Q?n5XpEvypYOwLwR7MFj65nh4bdbrBkAMMpcObn2T6Wt7OwCi7FoFrxn062UOg?=
 =?us-ascii?Q?d9zhwFsk6z68TGef9o/BucqrpH6x1sEVbep8Mgm0ZvH4hEDyJzeWrt+PDibN?=
 =?us-ascii?Q?k3YX1MzYr2kIhF+qUhZmY7Dhuc0t1/SedOB02yIPzQRzU1Azfm5+6wlOXs4f?=
 =?us-ascii?Q?eirFABzRkBY4zufVQcoJ9a3P71WQnSPrgu1GozFBzeyp2WuJLATn1w9t0ViQ?=
 =?us-ascii?Q?cO7L6GWuWG2gwlNP0mZDxft6r3emX8yK619Z0V6k+tYJpJ0coOXH66Kqni0b?=
 =?us-ascii?Q?fpmtjBgy6g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c14276-0522-41cd-5ede-08de963584c7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 12:42:54.0736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opCwybZzUtNqLW6q/2ahIBjkriuHJH6j9aNB8WdWR3SSF4z7+oYU+DWOWGYbAhAxQHKtmgEeOyU+HMvG64gyrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10632

On Thu, Apr 09, 2026 at 10:10:38AM +0200, Krzysztof Kozlowski wrote:
>On Wed, Apr 08, 2026 at 03:51:15PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>> 
>> The Arm SMMU v3 specification defines an optional PMCG (Performance
>
>"optional" in a meaning some SMMUv3 implementations do not have it?

Per SMMUv3 architecture:
Performance monitoring facilities are optional. When implemented, the SMMU has
one or more Performance Monitor Counter Groups (PMCG) associated with it.

>
>> Monitor Control Group) block. Per MMU-700 TRM, it has three 64KB pages,
>> with TCU Performance Monitor Counter Group (PMCG) registers starting at
>> offset 0x02000 in page 0. So PMCG could be described as a child node of the
>> SMMU in Devicetree.
>> 
>> Add a patternProperties entry to the arm,smmu-v3 binding to allow child
>> nodes matching "pmu@<addr>" and reference the existing
>> arm,smmu-v3-pmcg.yaml schema.
>> 
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>> index 82957334bea24402b583e47eb61b5724c91e4378..1d09c5476e5f1a7c3e5c935b677641ee6cc9897e 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>> @@ -50,6 +50,10 @@ properties:
>>              - cmdq-sync   # CMD_SYNC complete
>>              - priq        # PRI Queue not empty
>>  
>> +  '#address-cells': true
>
>Instead enum [1, 2]
>
>> +  '#size-cells': true
>
>Same here
>
>> +  ranges: true
>
>I guess only one mapping is allowed so:
>maxItems: 1

Accept above three comments.

>
>> +
>>    '#iommu-cells':
>>      const: 1
>>  
>> @@ -83,6 +87,12 @@ properties:
>>        register access with page 0 offsets. Set for Cavium ThunderX2 silicon that
>>        doesn't support SMMU page1 register space.
>>  
>> +patternProperties:
>> +  '^pmu@[0-9a-f]+$':
>> +    type: object
>> +    $ref: /schemas/perf/arm,smmu-v3-pmcg.yaml#
>> +    unevaluatedProperties: false
>
>Please add another example with 4-space indentation.

ok.

Thanks,
Peng

>
>> +
>>  allOf:
>>    - if:
>>        not:
>> 
>> -- 
>> 2.37.1
>> 
>
