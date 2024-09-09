Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020096.outbound.protection.outlook.com [52.101.193.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA24D18A94C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Sep 2024 20:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725915372; cv=fail; b=OudaMQe0YiG28peqomo6YyQkCuq2gPK5G/ypdnh9Foh27CCblP2B2kyt9wLfdMUrgs9FQ7gPaHXyKn9cYPeEzY4ctxkbwHepWAsPMnsadnPw3fzFRH24vTeIfHmusbMaA2C1+9uNhogLs4DCv4wHmxKQZlgIPYWURgk2vaE+jgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725915372; c=relaxed/simple;
	bh=CGkupTPF3kLtF2pjIHRvHdd+Sw2W2vNqz1Qw2pE4lkY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yzg26qW+aBQv8UH1AQzMQLAeVUoU+oV6LYkoApY6A2+nK+aB77fA1wf7/DKJIHHYIH8Ip8ZjnelxJXJ7W4EkdCquVw/yf9KXRFwOoxy892bgk7cHOnoyZsIY0gvEti5OXg7tpYbVocCkmBAXAIsFH3/0aIaeDzJ8W9GDDnqvRVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=mbPD0Bze; arc=fail smtp.client-ip=52.101.193.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="mbPD0Bze"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUkxDaoPo7hhVZhC7uNyGZ1lKx+qBxWTFXcNsqLW9vwEO0fjq0D8DjHbpIkxUlQdgslB8LIQCtP+h38gL76MxvcKSdFpTymvfqYSvIh6cAX+ANmr+vrNMg84xrtG+Cf+WPD+AyVScJcghIe2wpvCMHapOpEolpT/kkvidgP1AnzHPz/MBiTSlxFRaWHSRCOlQQMoyzbgNCz3CK/NAEsOpbpsFdAVzdsPgZMrmXqBl3MB9E5ZV9LBc5B8nhz8Ah7wA7ol8BDbHTUztcjImHYyJCOB5Mgb1ay+s65rQnVxl+DPaZpGzV67BMAHF5weiOG/eVOOGZ7BUsI6omeOh6iGSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S55Rm26tG6UrO4sjff495MSisDNpFUv83Wz4vwlr5b4=;
 b=OOztSj/qJYGDdT5HyXqQPqq0iQq8erY4SK+JOeCOwAt3br+h/5/vHyjyy20vVV0XC8z1/tlAhOSILnu7/ajizbAXW675BRaKalkoJqbEPp+MVdWprp9RY5aRV5g/G/jJGBf4AXho+GYfa5b1WIKIS/ritR2JPu32OT4y5GZn32KqfFtGzG+zEKuyrJMYU+GZzimVNpXhF5yWcyY3NWFQr00w9OwpibNihJmN/f/y+/dz5dMRSxqKmodzaJXUuyP/QULY3g26A2ahJgQDR6MGozFfLDZW9FDkHI6LBLovwmk86/Q8FhKXSqhSGFLbAON0adcZzdRJcycVKx89FEdSkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S55Rm26tG6UrO4sjff495MSisDNpFUv83Wz4vwlr5b4=;
 b=mbPD0BzeK/s170k+9MCMdGXD0oI9lEqvydHuxne1hI2qecM/DXwoAGIdhR/t+2De4o3FjwqfoJPHeVIOmjEt4HuPJj9kawb9NzUjSUt32vXdSvP/2Ao/jYybmJiQCe1MgdWc7Ju4PJKb+G/CWW5HC1l4Pe9u9aeyB9U5Am8glVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 SA1PR01MB8353.prod.exchangelabs.com (2603:10b6:806:375::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.24; Mon, 9 Sep 2024 20:56:06 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 20:56:05 +0000
Message-ID: <cbe79aea-52c0-4694-b0e4-d8b4dcece4b4@os.amperecomputing.com>
Date: Mon, 9 Sep 2024 13:56:03 -0700
User-Agent: Mozilla Thunderbird
Reply-To: scclevenger@os.amperecomputing.com
Subject: Re: [PATCH V7 4/4] Adjust objdump start/end range per map pgoff
 parameter
To: Leo Yan <leo.yan@arm.com>, james.clark@linaro.org, mike.leach@linaro.org
Cc: ilkka@os.amperecomputing.com, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1725573309.git.scclevenger@os.amperecomputing.com>
 <d730ad217936d952008edf703ba4c34393d89dad.1725573309.git.scclevenger@os.amperecomputing.com>
 <22f7ecdb-14e7-4bb1-a20a-bdb447bcb64f@arm.com>
 <723912a5-4d9a-4fe0-ad86-bbd79ccd4a45@os.amperecomputing.com>
 <22539ca0-551d-4cfc-94f9-4a291998a363@os.amperecomputing.com>
 <fc2870a0-3e0e-464c-b468-70c5ee4a6ebb@arm.com>
Content-Language: en-US
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
Organization: Ampere Computing
In-Reply-To: <fc2870a0-3e0e-464c-b468-70c5ee4a6ebb@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0098.namprd05.prod.outlook.com
 (2603:10b6:a03:334::13) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|SA1PR01MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 4443e586-1051-4792-e914-08dcd111d28b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDU3VE1XaEMrVlJNOXBmemNGY2NpV2o1UUtyZHZPaWhSb01ySCtEVWE3di9S?=
 =?utf-8?B?TjlHOEk2ZWlTQmtDSFhtYkVacVBCN2o5TVV5cjZLRjI1U2ZCNWxiL2NOMFNU?=
 =?utf-8?B?b3ZVbmJlYkQzU2pRZGJ1MXBWOHI3SGJtRTgzeEYyQnJtK3RGS2d0OXdmYVRp?=
 =?utf-8?B?ZDB3cXJGU1pZYUowWnF1SUpUZ1dhTC8yWmd2MlpUMHBBTzZmdVVRTjU1Ykhy?=
 =?utf-8?B?Vlg0VVFHdDVyZmorbFlYSWpPMEtMTFFRQnZDV2RGc1BJZVFXUWszUUt5K2gw?=
 =?utf-8?B?RDNBQ0hYN2FEbUtxR3BablcwMEhKVklLY29QOEhxV2pMckcwRGtGMFVGQjAz?=
 =?utf-8?B?bmE2UjlScTMxaDRWcU5jMjduWFQwNGdwK3JsYUt5V2U0bTZ6WkE1d3BjWGdO?=
 =?utf-8?B?bzJFQ2NMajhobjdQTmZiMXVlQkYxQ2t5WXMyNjdhV3pCMGU1N3BaRlJjNVpw?=
 =?utf-8?B?OHNySzlUQ2g5T0FhaGErOWVkVlo1S0dXOGFMaHE0Nk8xZkpFVzhGYjFNTTc4?=
 =?utf-8?B?SXJEUkkvdWl2QzN3dXQzVEJ6SWtwTVJBbU43UHBKSmFoOUM3akQrdTdIMW9m?=
 =?utf-8?B?TVBsbURwY1c1dGl3VU9UQjFjdklXTVVod00wY3I2Wk9PRWlQU3ZRSTg0ckNL?=
 =?utf-8?B?eFR4TjNvaUFzUEJYdDZCTXNFM3RRcTJ1bHpuUmMwcVJGbW1LQUVWc2hUSjVy?=
 =?utf-8?B?MHRhcTJ2dDF0N3BBaWhZdG1mOEg3aGpJTWdjV1hGNEdMMGluTGJLd0xYb1NT?=
 =?utf-8?B?Y01oZ2tXWVJPQWxHNVdkaHZYMnBNSW53VGhBbXduME5nejFTek9TR1RQajVY?=
 =?utf-8?B?OG40TlFheU5hcmNJUlp6RWZRKzJ0UVY5LzcrOFR0QTdrclFDeVlhRlVVMU8w?=
 =?utf-8?B?OHpGUm5qSk4wd3h2d2ZxUDBkQVBwL2F6WFN2WWZqVnFwQjFzeXhORnVmS0RY?=
 =?utf-8?B?UjZPWmpwc2dqcGtaMmNMSWRQdFVaWGpRSXBCUkxpaVM0d2szTlNpbnRZcThx?=
 =?utf-8?B?UmJrZ2NOeTBVZFkxbVlhMCswUjNNdTBsb2hkekorZnJMbEV3UG9BdHZHLzNm?=
 =?utf-8?B?eTk4WC9sNzFXQkF1MTF0akwzeWR2Rkl3MVRPdzFiTnBPdlhQUkpidnZsQ1Jh?=
 =?utf-8?B?UHp2MngrYU90RjAvdUsvV05nZVo1bmFrTG9wQUdXTFBoK2lVeHNEQW1uQ1Zm?=
 =?utf-8?B?KzN6YmFWSWU5RG9IWUFOS3RyNXZzOG5YUWVrZktOQTUwN3dLeFA5Zk9uTjVY?=
 =?utf-8?B?dnNWWG1JcTdibHVlbHhhMFhkcnFGdm9SRTJWcmEzQllWc21vd0tqWHRvT09w?=
 =?utf-8?B?eFU2cjFlazdWMThXU2M5Z1FqbGEyeUc0WFFkVXk2cFljNHV5UkJtbGtiQ1dv?=
 =?utf-8?B?cG5vcFJwWk0yTjdYTjAzMUdZZGYwcnVkc2ZpYkNtSlY3WWxGN3JFL3lTM1NK?=
 =?utf-8?B?cTdLQktVQUlSSG5vV29CNGM1TEFWckNNL2hYYklCUHFZeWEzSDVjdktEMUdG?=
 =?utf-8?B?d0c0dHdvaHZNN3ZIZ1dGbHlvbE82N1B4UUpVZ1BoZzU2UDFGSDg5V3BLbHhN?=
 =?utf-8?B?bVltbENMQmVhUUVKSEU5aUhod1dCdHdaZHM5VUFQdHg0cElLYXY5NnByVmsy?=
 =?utf-8?B?VkxSNzAzdGNJWEtueTJuYWg2S1FFUUE3YnNIeGFscHVyNzBRY1NsbGlGQXpi?=
 =?utf-8?B?UEJ1dytUVzEwWHRsci9ZeWJNdzM5L0I4SE1VUUs4dUNWRUczV2tVYXN5OGlJ?=
 =?utf-8?B?emNLTVpBNjhYMzFqbkFwUWlVeW5ybkxwT2xWM0YyZ1NqWlVMSFBEb216NVZ1?=
 =?utf-8?B?VUtFcEFzSHIxZ1UwSzdJdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkNTSVg2ZU14ZmtYZnpCL0ZHeVdlUWxaTHQxR2poS2F5dkNZc1cxcnh3OEdU?=
 =?utf-8?B?ZGVXcVRlL0E4MEVkZ0lRNFZ4WU1EcXBDLzlESXUwZEYwbmRwcUtkaDJrQjFx?=
 =?utf-8?B?QTB2bmxJa1NXTTBEa293YkhlYXhIdmhmWFhHanhsN1pBZmRTbW9YblNKcmZH?=
 =?utf-8?B?bFAvZWE0Q09GWkZzdzltMEwrWW9oNDJqb1NHdEpwOHlIQkdDODEyOVZ6S3I0?=
 =?utf-8?B?VlJUT281QTVuSnQ0S05seDJPdXFFSUNGUXZiNmpadWxHSUc0ZjVRMFUzTEcy?=
 =?utf-8?B?Tk15blMxMk8zWjVidS84N3NSN2s0WXZLckhQTUhReW4vWUx3MFlZS1RvL3Zl?=
 =?utf-8?B?ZnVqYnVFK1IrdUJOckVPRG56bTdhaWE3d2w1UTBmYlNaVFJ5dm0vc1lTSmVR?=
 =?utf-8?B?L1FjcUJhWlNqQysyc2hGd0VsaWxzdXIyUmQ2WXN1TGRENXdMTkVkQTRMc08w?=
 =?utf-8?B?Rm8wRTFsS1ZrZTRjNFRuc2ZxemtKV1JkODlJQkpTU0FYYStHV3ZLc0U2Z2g4?=
 =?utf-8?B?OFVRSlJRa1J5UUptNTdiUmxjb3NYZHREYjNHTG9BOU9xNjhDY01ZQThLSWdp?=
 =?utf-8?B?TTIzVVUvbUtiUWpISks0SHowWEJOMnpFdThkdTBQZkE0OEw3Tmd1QUd1eng1?=
 =?utf-8?B?c2NnTVE1T2YvQ2JUS3RwRjJjREhrUU5tOWZVbU9ub3dLOFpTeCtxL2JrZkhj?=
 =?utf-8?B?cnphbUpJand0VGdvMlBiQTVBRnlySGdLeTBqdGVvanZXMjZxR3NuVGhOVEFH?=
 =?utf-8?B?SXhoM1pTMlY0emZzdEhlcjRLcGJkRXB4N2VpV2tpSzByNlNOakcvcjdDSGk2?=
 =?utf-8?B?YlhnLzFnUGhIdXFtWnBpUGFOSjFDZVpwZ1VKVlFKTmM5d1Y3cGJwVnRSOG9y?=
 =?utf-8?B?L0xhQzBSRDlTYnplOTZqTzJMMkx3TTB6RHNQaU04akQ4Q1NzanZSUUZJazI1?=
 =?utf-8?B?emxuU0hMa3RGWDlHTkV0Nk84bWhUZnVzUEtzeWFqOEVrS1ZJaFVDWnpOYmNq?=
 =?utf-8?B?dzk2WE5yaDBmNXkybitOaGErakFwTGs2cWlRN3oyWE5QUzl4VVE5QkxpWHds?=
 =?utf-8?B?VXJvYlJ3KzBqeDRkMTBoeUNDYm0wUk80ZHFPeno1Sk5GSGo4VTVCdlpKN2Jl?=
 =?utf-8?B?TklrTlJMZHdrUjBzb2dWeXZNM3VFOHpsZ21KeVVrd2xUSmNmT0RYbEU4TkJV?=
 =?utf-8?B?U0txdmE2OXh5WEt1Sm1VandYb3A3bnBrOU1vdGpNQjJYdzZxN0FQUDZrb2Zt?=
 =?utf-8?B?SVpyaGF3NUVQa2t5SHNwaFBsTGVpMUlzRTVSbDlIU2NTc29maFdWNXhlY2RT?=
 =?utf-8?B?ZmFiQTQ2MTlBVjVIcWNnaXRQRnM0T3hGTnY2MjYva2FjNkxLcitFd3JyM2l5?=
 =?utf-8?B?Q2hPRG9pOFNNeVNhZ1g2UVlpb3Mya0NVcE41a3o5UllFV21KekNlMHd4cG9k?=
 =?utf-8?B?S2Y4YzE3TzdROWtMa2psKzhtMGs5bWkzSkVXRXAxOU5ta1RYS01iWktqWDB3?=
 =?utf-8?B?U2NKbDVoMXU3NFcxa0JlcWw0bmtTY3JRcWJGalpHZ1dDNFRSRmd0ZUpMcEk0?=
 =?utf-8?B?TGhnNU1pSE5tZVlSWEtnNUJyWCtuN042czdqSjh2eEljUThpa0VrY09kVGQ4?=
 =?utf-8?B?TDZReWVURUtsRFdTek1seFVxVUx3aEZsWjY3SGdmTnZTWktKRk9HaDJQaDlH?=
 =?utf-8?B?b0dnakQrb0RuN3Q1aXR0Znc5ZUE1TEROR2daU3pXdWxpOVplYXJBNkhYZVlF?=
 =?utf-8?B?eno3ZVRjOGRZUGt0bHNHZXRoTlkwR1pzWmhpRUdXVlVpVUR5RUVaWlZuNEZ6?=
 =?utf-8?B?SWdMc1gxMkVZT2tENnhBc0tjYmh2eGJ6b2dXemNjcjF6SzE2MldSZ2RVb0th?=
 =?utf-8?B?VGgyd3RIUTIrMThmcGJHbHlJbFo2MTQ3WFlUWHVRNUYvZVYvWGxKT1dodVVv?=
 =?utf-8?B?QnRlOEdNdklNQmF6eGhDRU1hYXlOdWRkVm9FZzNiYUFLTkRURFhTZDJoZER3?=
 =?utf-8?B?N2RBbHEybFBSUFpwTyt6TmlxcG1hbHRGbm1sdzB5QndPSkJ5WVAzRFFXYUF2?=
 =?utf-8?B?bEpSajFGZlI2MEpWSFZxUjJKSmZjQ0YxdjY4QldIemtlNmNQU1h3TjlRdzdS?=
 =?utf-8?B?SnI5TkI3OFlybStlSVN4YmhSYXBoZFU2QnpmQ2thR3BtZUIyQzZXclB6YVBN?=
 =?utf-8?Q?fpiWlIGGBTWsUhZ/7tKblGrgqheN0MokhW2LXC2A0E7d?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4443e586-1051-4792-e914-08dcd111d28b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:56:05.8793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSvKHASvvkuTYEyczCqsDM2xPXTYLAmdFFb2m4Uj9uDRVoJ4nBabzM/ECP+6Svv2B2Yze1X9VmXFLPSBzAMlik/kRtAMWy2lvhZt05LrO9KTxYkAS4Fm1Y6oukacAH1E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8353



On 9/9/2024 1:33 PM, Leo Yan wrote:
> On 9/7/2024 12:20 AM, Steve Clevenger wrote:
> 
> [...]
> 
>>>>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/
>>>>> perf/scripts/python/arm-cs-trace-disasm.py
>>>>> index 7aff02d84ffb..a867e0db02b8 100755
>>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>> @@ -187,6 +187,7 @@ def process_event(param_dict):
>>>>>          dso_start = get_optional(param_dict, "dso_map_start")
>>>>>          dso_end = get_optional(param_dict, "dso_map_end")
>>>>>          symbol = get_optional(param_dict, "symbol")
>>>>> +       map_pgoff = get_optional(param_dict, "map_pgoff")
>>>>
>>>>
>>>> I am concerned the two sentences below are inconsistence: one uses
>>>> 'start_addr + map_pgoff' and the other uses 'start_addr + int(map_pgoff)'.
>>>>
>>>
>>> Valid point. It's working fine as is, but how is it even working? I look
>>> at print_disam/read_disasm, and no type conversion is done in either
>>> call. The dso_start parameter for these calls is actually dso_vm_start
>>> which is the dso_start integer conversion.
> 
> I agreed with you. After reading code, I have same conclusion that we don't
> need to type conversion to int type.
> 
>> Python thinks the map_pgoff object is already an integer. For example,
>>         map_pgoff = get_optional(param_dict, "map_pgoff")
>>         print("%d" % map_pgoff.isdigit())
>>
>> AttributeError: 'int' object has no attribute 'isdigit'
>> Fatal Python error: handler_call die: problem in Python trace event handler
>>
>> Converting map_pgoff to a string works in the print statement.
>>
>> print("%d" % str(map_pgoff).isdigit())
>> 1
>>
>> I'm not sure, but it's possible get_optional() during some call had
>> converted it to '[unknown]' which would cause a problem.
>>
>> I can explicitly force to integer.
> 
> For backward compatibility, we can use below code:
> 
>    map_pgoff = get_optional(param_dict, "map_pgoff")
>    if (map_pgoff == '[unknown]'):
>        map_pgoff = 0
> 
> Then in the later flow, we should can always use "map_pgoff" as an int type.
> 
> I struggled for James reported issue.
> 
> The variables “map_pgoff,” “dso_start,” and “dso_end” are set together in the
> Python engine. All of them should be of type int if the DSO is found, or all
> should be ‘[unknown]’ if the DSO is missing. We have checked the types for
> “dso_start” and “dso_end”, and if either is ‘[unknown]’ the flow will directly
> bail out. Thus, in theory, “map_pgoff” will not cause trouble if it is an
> ‘[unknown]’ string.
> 
> One possibility is that James has applied your patches but has not built perf.
> So, the field “map_pgoff” is not passed from the Python engine, which will
> cause the reported error. I think the proposed above change can effectively
> avoid the error.
> 
> Thanks,
> Leo

I added that exact'[unknown]' check in last week. There's no need to
explicitly convert to an integer although Python doesn't complain when
about integer to integer conversions. It's probably just a no op. I'll
commit the change later today.

Steve

