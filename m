Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794415147;
	b=QDSpqkDSeCfxz6PoykYnlOoUmUs7Ha6Di6meYoIDO3AmodEZp4J3x2tZayNBHRDMEZH6
	 bFm4DXc2jkUqCl7CwDe+0BaYEzzWp4ioAGIR2US8HtnRj14fleKBhPuAt1V6KbKJfZXC6
	 RM/HdMgPmCv2QF2Aq4e6f2IlFHNqyxLOu2z60A2KQqH9+q0lqx096vTbmYteYgCPd4lo+
	 3/0grFvyY+WEkVAza4kV+GCDPgrumPbjGH38a6LBT+Mmhb0DTJ/yhoxxhsyR0FEW6xM38
	 lD5hy4cYTro2cC+adXWE2cyStBcS3qMu9h4X6G1yDufWeZoiomEnbUWrXHYufGyoZ1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415147;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=58aDKLTrfkLVluG8tWVbb36Ydnsoh0erNivc1qCtfi0=;
	b=hwucxTIEIHQ5F1lez+ex203f7s/rGlGdz4Vq16tK3zeGR8EMCUkmX2SMyld59eJ83GVy
	 191r7VG5F5pvRGzVEdVllWY9yJItp/sYX5K3O8MUsYT5N9UYGpQgu63iV0IZfFUe/Alpj
	 FLj4xaVG2bNPZL6BFSY22tUAIwUXRdJuwbfmAaS25+tFAMKF0rOdUzYBPGdxSPbaEAxNv
	 qFlW9stfL5zrSdo05TnO0zqgEML/U0Bt332ZqcPBhl3IzSxDrxMMGJXvUp3pMimzKSHAm
	 GJa1Pi9UdOPWk23VyMabt14ihuwYe6UkjP6HdB1Cyn3MydE0p+9pUCyTTqIDcXA4huw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MJlBH8An;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.56
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515E3606A33F;
	Wed, 11 Nov 2026 16:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 515E3606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MJlBH8An
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEYi72SH/WWsSh+sACtlY6pF0Y3ZXiPWIZ366Areh+TWtrDCgBh9Ozn0fyoxcveAFrworXI2+65KriM0WG5+IwsKtVDInClZFDDDRw4E1mYOCxM4vW8coS9WzHlGsfb1pawogJ3RWs6BLV9fFVoYSqMCZKqLtpUNlyMf46V4UePIBbxvvOS/Sp6lnaCU1hh0m3aOsbNWeDj2Ltoy2PMrSUDQ9DnKBNKXjQJfyYxjFNgQPMeeS3PCgokJSrMvh9dCQplZXpRJpH3Yz6L++2uJfQovUWRZCtNXCvt1WqX7L9r9ViTGOMD7SayhaW9PdxaW1ihHpS0BEJGRUC9GSBSVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58aDKLTrfkLVluG8tWVbb36Ydnsoh0erNivc1qCtfi0=;
 b=P1KFHBoQLjki6TxnRK0yEbFueJrYDxoxvORGEp1DkAnXIS/Nn7guB0rUBSEPC3CGB3mtgn+sJnME09A2fuptABhc6cO/QYIXbkoPDbBHhIDXSiD2u/V0oDHsjv5QzcXBv9e4D6ottHwxPClUAIrvyfQ0QmJRRh7RwJ+fDrZyS/VP9x36a3X3zDvH/t+ATU7BvzO9JyDqugrrdmBiX3qAfaT65tsLVX5nL1or4Agl7VodFswuLgnPWT9nAUjCJiCzHzulAMzsmD38dpLO7kTYt1q6oGt8akMMIuwEQYN0lMGjkh8F2QPWwRmB+xXJqpwiiJqdgiP65HvX8b6TEVZYbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58aDKLTrfkLVluG8tWVbb36Ydnsoh0erNivc1qCtfi0=;
 b=MJlBH8AnZeTCbd1HS5DyXGqh7lCxVk0ScEmcIV+j3e3UJKgKthCWafpevZRCWtBQdeAswu7z28OiB1YVWlAHfd/su18aa3OHAWXNvdKfD6k0voJfTJjaqF86cUjKHwpusaeygai4bR2gThiEWoThJTBFW8fCTFVpe8kvvp32P5DgCsVUxNfTjaMsFY1j/3Dk2R9srhGEYJUYkG2c9NkQY9hHT6ztJnk857GNsr7qdrGBekNvDmRR1hkLv3D7uoc35RghscCJ0cuH+COOHBBOwDDCZ12RWb7z7qTnwvTOJUpW3VwDIAIcogzptzehl7z9hiSU361+wepLAqISc/vY3g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CH3PR12MB8307.namprd12.prod.outlook.com (2603:10b6:610:12f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 16:38:40 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 16:38:39 +0000
Date: Wed, 11 Nov 2026 11:38:38 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, yury.norov@gmail.com,
	linux-perf-users@vger.kernel.org, mingo@kernel.org,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, tglx@kernel.org,
	sudeep.holla@kernel.org, linux@rasmusvillemoes.dk
Subject: Re: [PATCH 0/5] cpumask: Use cpumask_intersects* APIs where
 applicable
Message-ID: <avSaDpLLwOP6vl-J@yury>
References: <20261111075945.3930230-1-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111075945.3930230-1-sshegde@linux.ibm.com>
X-ClientProxiedBy: MN0PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:208:52d::9) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CH3PR12MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d27104f-5699-4321-51e1-08df40123d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|1800799024|376014|7416014|56012099006|22082099003|18002099003|11063799006|6133799003|10067099003|261009223027099003|261026130827099003|261026121527099003|261026140227099003|261021130227099003|261021121427099003|261022075727099003|261022105027099003|261022113327099003|261021123027099003|261021135927099003|261102123227099003|261022115727099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	vrOfHLYj7s52m74vipT6B0w3WNxiZAtjZC4vHWUaf4T+120IEovn798HP+m2oVqG6t1Gp98g6PeWUA0yVgqOZdXCzQkprbVj6whbXdyWqFm04sn+xQSwC2Vb2KpApxNA2UHtiudqUEXL2rnehG6/mtGTVTLHqKIcgJLVx4CEJT6lUiaJ6GVqInJKk2BshR4PzpgO2n3nYAKHdvju/tcYol9jdsGe+NngXNFL59QlIDex9A8agigyggZFFLwA+upOlTSthn8qYGsuJiKs87hRWY7OFLytmpuNNH8GSwCSh7MtZ8twwSA6QOuVDlEqT2NN2CrKc/Cb7nMeMEUaE19xOUxeeWUh+Qr4j6SAlD2gFkQofB9MpBxvspJmMwVHAHCN8wAFp3ykzMyqrZGzjk+LIRpfBlDVtZmervr1p33cSFOiz7XDE4IQV1dpfDFmnO7hIG8ICfZ6Xv0hO4IoiIjKu6/wXABn6d+bxoGtxoOPTXuuC9vMgWe3HIbHU4SHOm+sbqIsptjgR+P0ViFme5b4hsXaX05PAKYAPJZhnhGcUVnWTxFxDKqiExU6yQTZCf/19R4taI1FFvaTqtTKQaL53gPVSqRyr9ip8d6Ly0GwFyAy53HfyanD/sLUKKEtKNLoK/edipDaWZKQZiJpgKoy5gkqUjaLp001/YzXdrvn15M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(1800799024)(376014)(7416014)(56012099006)(22082099003)(18002099003)(11063799006)(6133799003)(10067099003)(261009223027099003)(261026130827099003)(261026121527099003)(261026140227099003)(261021130227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261022113327099003)(261021123027099003)(261021135927099003)(261102123227099003)(261022115727099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4V9ypVs3X7g/Mil6wp1rTHLA6I8DkFYLeUlZuSb8b8HLo4eRBxAkpSD3irKI?=
 =?us-ascii?Q?yeCszEI8GvI+ffsGdpwW2hwYHySar1xVBZf/gnIBEsN51YUclyT17B0UlTP3?=
 =?us-ascii?Q?J5lCt6yn1jfnAmJCHhm4gVucVooSAxwZQlvHubX+sM5HnJ9PrnpnsB2MVRqA?=
 =?us-ascii?Q?1XVnYNKbnKUX530lQEBRW6Qdq/0phx3rqNGZZa9cqTfESBryBA2fmEi0lF3k?=
 =?us-ascii?Q?i6DxdHzwWZzYclg4Q9+LmGH3NstvNIoQplHY2oU31VIThD23R9peuZLyBL7V?=
 =?us-ascii?Q?wasrzXGAgK+kCpPjkfRPiSdsK3gikQAKRGfm/aIgdP7IZt6gybACLyJj97vz?=
 =?us-ascii?Q?xyRdTWYi/qeaDnjfT/DM/hyF4sCyl+giIK57GmaeMeJ0UZUVjBcfm/CjQH92?=
 =?us-ascii?Q?CO/op9zPkeh3B1y6XWjo+R9eIuAlGf0CMIHBEdXwv/F2CaWE1sxOjU9twIYP?=
 =?us-ascii?Q?1zzBBdddkE7qxaQwJtJOSV9D2Mg82pKFR1R621Wgaz2ZNuU5oUMX2DBaJuCJ?=
 =?us-ascii?Q?TECZEHPR9YR68OLP/h+Iv97OODpIbULuv448EyKiH3kaZMd/STDMX6C0w33r?=
 =?us-ascii?Q?/gsf/Ya8J5pKc8rbYldyeton7nThWd5jSGZrAkDkqn/eSqLrYC1JoxzmTAqz?=
 =?us-ascii?Q?tbmtmoKtOViex4LmNwJ7ZjQF8Y3utv1u/WHawfLH59tEtaKk4IbTBo4udQSk?=
 =?us-ascii?Q?6j4r3aGpxTpVa4zvD8FZWcTcJsQZJ8p6W/Ny/DpWrtegMqKAQAOx9C2nlxXl?=
 =?us-ascii?Q?PPr6uWXJSQ92C27B8xcjpeWCnYcEslyM0ZuJwe4DBftuB+66FUCJZdGwDvqx?=
 =?us-ascii?Q?ZT5Rqa6pNKgig9WTeQ7/81Idmyb8rZG/X2XSmgLdVm6TatxfSiSANcZSOp57?=
 =?us-ascii?Q?uVAykA4n52FgNidbG6HTmEyI3WaZ/4ZnJzGFerlXQEqsJbXNGIRJuN7amW3R?=
 =?us-ascii?Q?PsU2CCtmh84jIGLeuqxUJD2eltn7dREzryfgdGuVrukQ1x/e0UQWTJQHrQvH?=
 =?us-ascii?Q?JNeYfNUgtptl1+mwfcxsY6q4cDoaREbJU8JjCWrhkedhQU8tX/1TAPQR5pR+?=
 =?us-ascii?Q?hifh8Wx1CsMUr5tZ1Ao/BEs9g6Ml8npA+dPdJkQ6nY2RSLkL4UMzFCE6CJ45?=
 =?us-ascii?Q?63njpFRkTvKhgK+ZRYsEeWXyEPbDw7xGrnYjMm09qnq5YxybYyalu7UYQ8tY?=
 =?us-ascii?Q?6g82eOEYm/34KCZt83vhvgO2UAfKMSThUxWTJlnZeIPvrwoDSFM1ozDWRz+C?=
 =?us-ascii?Q?bpVEIwVD0RwE7eGsRwQRKMiWiFWwAUp0GgjrodH/XtL6ZAQZf5VehToXawmn?=
 =?us-ascii?Q?UfYg7TlNDb5pxj/DipkgQbAw4rTsnzQyexiCquKNgW8DWu8Mq1dbialfi8uP?=
 =?us-ascii?Q?m8dElIe0zTQt81jsNGs8Fx4oK5y1FuG4DG4Pb3rPFBLvUl/PJjJRkqHZbXXK?=
 =?us-ascii?Q?NyikqadTcThIDj2VPJiC19jHPfJs1NznqaFKk69rxjQz2LKS23u3k5EqDLJB?=
 =?us-ascii?Q?fCdQLa1HxvtHbrjI7HDOCU0KaktGzevNc/PVwXEr7mBvLXL7Dv6Dz39/+M3q?=
 =?us-ascii?Q?/+1ePJ3iA72C5MhGhEw1o7NHTGR6Kzfds2iDNbsY6/ZtyIwtpxTP+eY2R4oQ?=
 =?us-ascii?Q?udHt754vVA+wOsrsD1P0QjpO5wV6qmLqoka9F9TzT230z6sQTSr8sZEKdcSO?=
 =?us-ascii?Q?/DqCPQsnfn9AxuDYb6d6pcG5x35NSDZDkyPwzAWj/3Mvz4nXaMNIO2uvqsvx?=
 =?us-ascii?Q?OKiIy1OPwnA78c5w5IGT8zKu2SwfacVjiZx4zbl+iA3Crmi7bWGS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d27104f-5699-4321-51e1-08df40123d96
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 16:38:39.8330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XyMTOmZhxExBMCD04kdLumO+j9RnxbX3HDngKmHmOPTQJ2GjdeS1e+9Pcx12Znj3hGOKYjQ1I7ud81o1WpKf5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8307

On Wed, Nov 11, 2026 at 01:29:40PM +0530, Shrikanth Hegde wrote:
> It was observed while working on cpumask_intersects_and, check like
> below could use it instead.
> 
> if (cpumask_first_and_and() < nr_cpu_ids)
> 
> While there, did check the code for any such similar patterns of
> cpumask_any_and, cpumask_first_and and explicit loops where
> cpu found by these APIs are not being used. All those callsites
> instead can simply use cpumask_intersects.
> 
> Note that few more places can use similar change. But, I have left
> them as is. 
> drivers/net/ethernet/sfc/efx_channels.c+370
> drivers/net/ethernet/sfc/siena/efx_channels.c+371
> drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c+153
> 
> Also, these patches can combined into three patches if that is
> easier for review/merge. I have kept it separate since they belong
> to different subsystems.
> 
> Shrikanth Hegde (5):
>   sched/rt: cpupri_find: Use cpumask_intersects where applicable
>   cpu/hotplug: Use cpumask_intersects where applicable
>   perf: Use cpumask_intersects where applicable
>   cpuidle: Use cpumask_intersects_and where applicable
>   arch_topology: Use cpumask_intersects where applicable
 
Reviewed-by: Yury Norov <ynorov@nvidia.com>

>  drivers/base/arch_topology.c | 9 +--------
>  drivers/cpuidle/coupled.c    | 4 ++--
>  kernel/cpu.c                 | 3 +--
>  kernel/events/core.c         | 7 ++-----
>  kernel/sched/cpupri.c        | 2 +-
>  5 files changed, 7 insertions(+), 18 deletions(-)
> 
> -- 
> 2.52.0
> 
