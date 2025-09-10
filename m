Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A472D4B7C;
	Wed, 10 Sep 2025 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497986; cv=fail; b=lKJD2vV6lwrIleF1lv9XvTyFZd+sSRimWuCdmeR7icG9bOrIBj3p5Ym5NMOMDkNTYC3c68CgT0cKd8a41YqcJfOub1Mr9hCeXiaQYkWMv8/7oXVpY3vcaNvTUie4TPlVIZ5jKKfzan2yPIIVs9BjacpuYdubfXEzR0Rc32jeKxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497986; c=relaxed/simple;
	bh=BD8lT9W/ZzQ8y8FsRv6UT1sRVbsez203xuq6A9tWc2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=il93qb9kA3iXqECf7n5mKBFkbPaAJyUag+k0jTflEINHwIOrta3D1wnURtL8Dd1Ut1yf/MAjMBlYsHuQhQYyz6bUceS68P6hJgc4cgdMF8AXNUXY4SDbEYdWTaLHeuXK4BYmaumUpAzysdFThtBDW/sCDC8wXa4eQdx8WIZ7P44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NbGfaDhB; dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b=RKRJdcDU; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NbGfaDhB";
	dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b="RKRJdcDU"
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A9qXJW021684;
	Wed, 10 Sep 2025 11:52:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	3QkxBTDcycrNoF7YyXTaTjPbl0wB31nsfpnHrzz0ubE=; b=NbGfaDhBtMx9jE5r
	M4Qlhq6aNpgsLBxkpurhGZ/6q63HWqElEzLNky2Ad+NQrz+eI04SHIssMnQUyPz6
	tfcD0bOvEIeQF/O0LID8zZnW1sLFHE7xwOaXm8aiKYzbtlUvJ3/UHd051dIrk3ob
	mI/ZWYwZdnMvbNncPVIc2+4PCZ1aZL5VgM8nWX79BkdP3UQmeKP66trLqeUcbfCV
	BBMWLYl7WcX+OL8HcqFnjm0oxOuCQtZqaf7JS+uy8XzGLLdr7MD6sl9j+fUdtHoy
	0tqJYcr2D25CA5y4VHeYw7bW3yUjY/IOm3qzlAPQZZe00y4hrH+9xAs1dRk3t0cs
	lcDOew==
Received: from osppr02cu001.outbound.protection.outlook.com (mail-norwayeastazon11013064.outbound.protection.outlook.com [40.107.159.64])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4934xjgq19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 11:52:47 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSrO/lKFILnVo5CdN00nIICbGQN9ZFt4Y9DddtSwHi+RkAgctBDjz+Gq4M09hh5Ln5mlw6CrRTnmYSoyrDJQYN2/4oSVXyiK4o5H6I2Ck/BVR9qgPuOEGyWZp/3TLbyDVMSGD3rDe3UODLOiHjA+gK+66bfLjQikYJCi+LRe0l2S2AWEifjwsx7Tdn6ihAssU8aeEjCeivWxjaqI2EgGAlfMM44K0KpREXQOy2rU3MpeLJXT25P9e24UfBB/dzM5MqMkXRGACtfr8nwDHPq9Bw/rPc7n6in7ok3D8ldZNameciTCZnMJQ6qt2/lUS4MlFtUauyHTPxj+bl0V1NLv+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QkxBTDcycrNoF7YyXTaTjPbl0wB31nsfpnHrzz0ubE=;
 b=ytR0BmfAENecZCbG4jknpxIZifvM7d5XlsZxFWaNDjwo+0/ZWQB1L9GmueAQL3L+colUE9RU7H54ghOnXuOFEp+uUboT6oaWA8Vph/AoxZH0WWNIMINiS3WHNEatlvJvTORiLAWqBItRbiSIdbFdT9PX86Yum0+jF78LJgv4tNYplYYP1fltf4XTufFZWbXEqyg7vVNdhZHPuZVkHFlw+cDtvW3i+e8UBOioeMWTWYD0Aj035zS6dW4dR0a4NpfxtPrXyon9cmdOwy3VFPJ14ltAQLUYk/5QVF9ObofvZubVw7uwiC0q51g1Af+DuNvZbNKYlxRIakyqCSYdV8vRnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stmicroelectronics.onmicrosoft.com;
 s=selector2-stmicroelectronics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QkxBTDcycrNoF7YyXTaTjPbl0wB31nsfpnHrzz0ubE=;
 b=RKRJdcDU8zDmh9+06/5MRrUFedju9+G5x1gyuEpzPRWysfIIYH0D5lVoP+FDB/YJSvL2Z6CcaSNfj0you0UX4xkg+rHsNwk0LmNeOXtJ4A5avxqqKwme1YS2ApcljFBjRTXlGnYWjMOtjgV69pAsTGdZnydMBQ6MssQYeuRnSTw=
Received: from AS9PR06CA0424.eurprd06.prod.outlook.com (2603:10a6:20b:49e::8)
 by DBAPR10MB4137.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 09:52:41 +0000
Received: from AM1PEPF000252E0.eurprd07.prod.outlook.com
 (2603:10a6:20b:49e:cafe::9d) by AS9PR06CA0424.outlook.office365.com
 (2603:10a6:20b:49e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.23 via Frontend Transport; Wed,
 10 Sep 2025 09:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 AM1PEPF000252E0.mail.protection.outlook.com (10.167.16.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 09:52:41 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 10 Sep
 2025 11:45:32 +0200
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 10 Sep
 2025 11:52:40 +0200
Message-ID: <96765443-481a-4e4a-86ac-961e50af28a8@foss.st.com>
Date: Wed, 10 Sep 2025 11:52:53 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/20] bus: firewall: move stm32_firewall header file
 in include folder
To: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>,
        "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Gabriel
 Fernandez" <gabriel.fernandez@foss.st.com>,
        Krzysztof Kozlowski
	<krzk@kernel.org>,
        Julius Werner <jwerner@chromium.org>, Will Deacon
	<will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Jonathan Corbet <corbet@lwn.net>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
References: <20250909-b4-ddrperfm-upstream-v6-0-ce082cc801b5@gmail.com>
 <20250909-b4-ddrperfm-upstream-v6-1-ce082cc801b5@gmail.com>
 <9a46c8a8-1d25-410c-9fa2-267eb4040390@foss.st.com>
 <19e664da-df4c-4bc0-84ce-41e4364f10bc@gmail.com>
 <7cfb167a-26df-4abf-a6ec-73813a1a0986@foss.st.com>
 <22a485b9-1b86-41d3-a42c-f813eea94697@gmail.com>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <22a485b9-1b86-41d3-a42c-f813eea94697@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252E0:EE_|DBAPR10MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: b8817310-79d5-4a52-362e-08ddf04fc895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|30052699003|82310400026|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zmo1OXh4YlIyYVJKQnRNM1J6akxRUmJTdlNLVzAzV3BOSFlCTXNNTmF0a3V0?=
 =?utf-8?B?RnRSb1NtS0hQS21FQWtlL2JoT0VmUzJ3M1NoK0VkcEhFZnpmbldnSnNoYXZz?=
 =?utf-8?B?TDlYOVdSQjFJdjFQanBkQ2xIRjVhOCtLanh3anYwTWlhNlJsZElxMEErK2ph?=
 =?utf-8?B?bFhVMisxUnpmNGJRUDVXd2QxQnZhc3FnbkpzZE4ycjlHT2RiUGZDT2RFWFRS?=
 =?utf-8?B?ZjIxRkkyZGJFU2trV1VCT0UwZG16eEdJcXYwZ2xFbjNjUzFCSlh5QVM1RFZL?=
 =?utf-8?B?MzRwbVMxYjJKZVdEb3BnUzFWNzFNQnBEeHYxUXdKSHoxTFRUVVRnbHorQ1J6?=
 =?utf-8?B?Z3dhS29sMzhMWGViOFEydW95VU9XblowNGdoQjBmOFhlZVp3RjhqNStuVThp?=
 =?utf-8?B?YjVoOEI5eUIxMFQ4dWZCc296ZUJWNk14NXlDUk5SKytBUGhqSFJCWm4vK3ZN?=
 =?utf-8?B?ZU4zRTBBQmJvSmlhYUlFaU9GQnRpS1BhNmkxTHF0UW4wcTVBcDhxTjFZcXli?=
 =?utf-8?B?R3ZWRXliSTFuYmlhalhsWXBBQWNTeDNKcEUvQkNOemxKRFNyTko3SXVsOUcx?=
 =?utf-8?B?SUc3Q2VjK1MwMGlMRHBQM2FzTTdBVy90MUJDcDIxZXdTZmRJZ0VNek9KSVA2?=
 =?utf-8?B?cUJrcXBDdDdrSmZxVDhPM0ZuYVo1UUtlVTk3TTI1bWNHenB4Q2ZRNTlRaTRo?=
 =?utf-8?B?WUFIRW9rL1ZJcTlXZDdLRFdneVhrYWxlSFptYk9Bb0E5ckdSTmhmWHpvVm9Q?=
 =?utf-8?B?czVZQWhBQVhyU2lUMWxFbnduZHpmMXRyclF1NnB1UVo3UlZXWEgrbkx4Ty90?=
 =?utf-8?B?OWhnOEZhM29kQktBTUJxd1R1d0dqdFptdE50VGNFRnVRNWVuOUlja0wvNjZY?=
 =?utf-8?B?S2taaVdKM01rRHl5OENXMUVLVGwxMVY4VXV6QUkxUU85NFVTR1g2eGdzUXZ0?=
 =?utf-8?B?ei9kOVdVNEZkSXN0ckdCUi9BTXNMWTIySjJ5bnVYclZkNGkvU0I3WmNFc01y?=
 =?utf-8?B?YTVUbU1SZW52bTBVOWVVbGRscW1DQnJZaW1WbHJsZFpBU1BKcWdabkhXb3Zo?=
 =?utf-8?B?aFJpejF0Q25sdEE0Um5DNDhLaGQ5RFdXeEdYdkVNa0JENEdCZ1JrUWRIOWI4?=
 =?utf-8?B?eEtWRE02c3N0UmRDSHJMejl2OFJOVXF0cHp5SWl4WTRlbFRGbjN4WHNIZXd0?=
 =?utf-8?B?bFpGM1BaUXoybk4yaVBBK1hoQ1paUTk4N0h4ZE9ZRGorTVByMUZSakhQUWlF?=
 =?utf-8?B?YjFaOVkyRlF3ajcreER3bmpaTGdGZndpTHZYZG9pRlpFaVQvRlo0ODNCZ24z?=
 =?utf-8?B?TVFXYWZNeVdrU2l4SlpVMWFVNll4Tk92RG81K29lV25ESy9ORGZENzlwNDRC?=
 =?utf-8?B?SzAwVDE5Y2FIUWFNUTF5L2NPdTZKV0s1QTlhb2xhZUd3dVI2YkZDNE5GQzZT?=
 =?utf-8?B?VExCRUx6WkY4T2VCL3h2SERNT05XQVZsazVWSFh3Sm8rMHd3cmpWVXFlMEtU?=
 =?utf-8?B?VEVBMlJaWE4yMklQVFNwdlZSdzVTUFk5ZWkyOGNlYjhEWmJPS0szY09hc01r?=
 =?utf-8?B?emNYSFNTZmxLTzVxOVg4RWVNL3d0dC9IRERBeXc2YXJBTCtHV3VqRnkyZ2I5?=
 =?utf-8?B?YitSdnE1cE9nMWZTRU9nNW5iSnNFM2RDbFN5UHkrU2tsSTVlSThDRUdKbklz?=
 =?utf-8?B?UmVROVBXM01RZ0RUblhrSGpGUW5weXBzYlVpcVU2QkpnWXJLaG05eXRKMER6?=
 =?utf-8?B?K01Da01VRVRqK0x3YVZDNTNDR1IrdjZKWE1wSjJRbSt0YWw5aFFFcGFLYVdm?=
 =?utf-8?B?ZUFwS2F5QXEvZFF5NElhNFZjdFJLMENBYVhhMUcvSEl5OVA1VEhkUmZsMjRF?=
 =?utf-8?B?Vld6V3ZINEl2TzFBRk1oVGNNd2sxK055UkNPR0tobElkLy8zeU4yWVZFNmpy?=
 =?utf-8?B?Q01WU1l2cktkOVVDUzZiQXdWd3dRT0ZISkI4akhqdVU5V0tTUktpUUdqRE83?=
 =?utf-8?B?K2xteWlpUFB4Q0tmRUpZVzZqb2YrYVc2dzk5TWZOSGUwTmx5V25nemdhRDla?=
 =?utf-8?B?dWNxam9UZkhzZEcySTRIUGZJYm1zd2ZreTRUZz09?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.44;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(30052699003)(82310400026)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 09:52:41.3953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8817310-79d5-4a52-362e-08ddf04fc895
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.44];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252E0.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4137
X-Proofpoint-GUID: BpwbNuEBvSuLigD2oDnIRfWHcPtSJ7zl
X-Authority-Analysis: v=2.4 cv=GuFC+l1C c=1 sm=1 tr=0 ts=68c14a6f cx=c_pps a=JRzJ8T7PdTfL/uBtHARA3w==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ei1tl_lDKmQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=FUbXzq8tPBIA:10 a=8b9GpE9nAAAA:8 a=pGLkceISAAAA:8 a=ogtmliehB0OFRgiU3f0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEwMDA2NiBTYWx0ZWRfX3RKPElTNdAgV EHnxU2Fsx8Gnp3+Kper0GT84R4Ra1wmbe14847DEe/r9r18ps2NblqSu7QA71KgDpLXOV7sOkWm wk2SyBUNfX8Dffzb65EL+6H2tv9TAhgXuxs1leYqF8RRenULSIj1ue2YxeAmMB183VOEzJyPDtM
 cS8VOL7jr5iEBU7MSTG+UkkJjkkMDtj8tUwIQQqXwQPZjDTw59/krcUTH9kPXEURMXah/SAYpl3 m2B0NETPhDuP1H1qoo11/ruWztwbErYx/wfHgcWec/bbP53z6NP41NZ5zAli69Yh2Ljna2iBwvK 0gDopY7q0WwG9nQrmOqUn5itXDivZo9BzkWXy/96aMsgocXOv7xKYJ3O+e2OdRQKl/KnNuwmtk5 qgIeWKUI
X-Proofpoint-ORIG-GUID: BpwbNuEBvSuLigD2oDnIRfWHcPtSJ7zl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509100066



On 9/10/25 11:43, Clément Le Goffic wrote:
> On 10/09/2025 10:42, Gatien CHEVALLIER wrote:
>>
>>
>> On 9/10/25 09:47, Clément Le Goffic wrote:
>>> On 09/09/2025 14:25, Gatien CHEVALLIER wrote:
>>>>
>>>>
>>>> On 9/9/25 12:12, Clément Le Goffic wrote:
>>>>> From: Clément Le Goffic <clement.legoffic@foss.st.com>
>>>>>
>>>>> Other driver than rifsc and etzpc can implement firewall ops, such as
>>>>> rcc.
>>>>> In order for them to have access to the ops and type of this 
>>>>> framework,
>>>>> we need to get the `stm32_firewall.h` file in the include/ folder.
>>>>>
>>>>> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
>>>>> Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
>>>>> ---
>>>>>   drivers/bus/stm32_etzpc.c                       | 3 +--
>>>>>   drivers/bus/stm32_firewall.c                    | 3 +--
>>>>>   drivers/bus/stm32_rifsc.c                       | 3 +--
>>>>>   {drivers => include/linux}/bus/stm32_firewall.h | 0
>>>>>   4 files changed, 3 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/bus/stm32_etzpc.c b/drivers/bus/stm32_etzpc.c
>>>>> index 7fc0f16960be..4918a14e507e 100644
>>>>> --- a/drivers/bus/stm32_etzpc.c
>>>>> +++ b/drivers/bus/stm32_etzpc.c
>>>>> @@ -5,6 +5,7 @@
>>>>>   #include <linux/bitfield.h>
>>>>>   #include <linux/bits.h>
>>>>> +#include <linux/bus/stm32_firewall.h>
>>>>>   #include <linux/device.h>
>>>>>   #include <linux/err.h>
>>>>>   #include <linux/init.h>
>>>>> @@ -16,8 +17,6 @@
>>>>>   #include <linux/platform_device.h>
>>>>>   #include <linux/types.h>
>>>>> -#include "stm32_firewall.h"
>>>>> -
>>>>>   /*
>>>>>    * ETZPC registers
>>>>>    */
>>>>> diff --git a/drivers/bus/stm32_firewall.c b/drivers/bus/ 
>>>>> stm32_firewall.c
>>>>> index 2fc9761dadec..ef4988054b44 100644
>>>>> --- a/drivers/bus/stm32_firewall.c
>>>>> +++ b/drivers/bus/stm32_firewall.c
>>>>> @@ -5,6 +5,7 @@
>>>>>   #include <linux/bitfield.h>
>>>>>   #include <linux/bits.h>
>>>>> +#include <linux/bus/stm32_firewall.h>
>>>>>   #include <linux/bus/stm32_firewall_device.h>
>>>>>   #include <linux/device.h>
>>>>>   #include <linux/err.h>
>>>>> @@ -18,8 +19,6 @@
>>>>>   #include <linux/types.h>
>>>>>   #include <linux/slab.h>
>>>>> -#include "stm32_firewall.h"
>>>>> -
>>>>>   /* Corresponds to STM32_FIREWALL_MAX_EXTRA_ARGS + firewall ID */
>>>>>   #define STM32_FIREWALL_MAX_ARGS (STM32_FIREWALL_MAX_EXTRA_ARGS + 1)
>>>>> diff --git a/drivers/bus/stm32_rifsc.c b/drivers/bus/stm32_rifsc.c
>>>>> index 4cf1b60014b7..643ddd0a5f54 100644
>>>>> --- a/drivers/bus/stm32_rifsc.c
>>>>> +++ b/drivers/bus/stm32_rifsc.c
>>>>> @@ -5,6 +5,7 @@
>>>>>   #include <linux/bitfield.h>
>>>>>   #include <linux/bits.h>
>>>>> +#include <linux/bus/stm32_firewall.h>
>>>>>   #include <linux/device.h>
>>>>>   #include <linux/err.h>
>>>>>   #include <linux/init.h>
>>>>> @@ -16,8 +17,6 @@
>>>>>   #include <linux/platform_device.h>
>>>>>   #include <linux/types.h>
>>>>> -#include "stm32_firewall.h"
>>>>> -
>>>>>   /*
>>>>>    * RIFSC offset register
>>>>>    */
>>>>> diff --git a/drivers/bus/stm32_firewall.h b/include/linux/bus/ 
>>>>> stm32_firewall.h
>>>>> similarity index 100%
>>>>> rename from drivers/bus/stm32_firewall.h
>>>>> rename to include/linux/bus/stm32_firewall.h
>>>>>
>>>
>>> Hi Gatien
>>>
>>>> As the firewall header is moved to a dedicated firewall directory,
>>>
>>> I don't move it to a dedicated firewall directory just to the "bus" 
>>> directory where the "stm32_firewall_device.h" header file is already 
>>> located.
>>>
>>
>> Yes, my bad, I mixed my words there.
>>
>>>> maybe it would be coherent to create the same kind of directory
>>>> for the sources as non-buses drivers use it. I can test it on my
>>>> side if you're willing to make the change.
>>>
>>> Do you mean create an include/linux/bus/firewall/ directory ?
>>>
>>
>> Rather include/linux/firewall/(stm32/). and a drivers/firewall/(stm32/)
>> directory for the firewall files would be great. If that's not too much
>> of a burden.
> 
> I thinks that's a bit too much for this one.
> As you're the firewall maintainer I would need to modify your entry in 
> the MAINTAINER file (and I just see that your entry is lacking the 
> header file path).
> For now I think it is not urgent neither mandatory.
> Maybe in a next patch series ?
> Even in the driver bus directory there is no vendor policy so adding a 
> path like drivers/bus/{stm32/|firewall/}stm32_firewall.c is a bit 
> overlapping as with the filename we already know it is ST and its firewall.
> Let me know what you think !
> 
> BR,
> Clément
> 

Yes, let me handle this afterwards, I don't want to restrain this
patchset from being accepted.

There would be no /bus/ for the firewall files. and the RIFSC/ETZPC
drivers would stay where they are ATM.

Gatien
