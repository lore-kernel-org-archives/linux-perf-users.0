Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD400360;
	Mon, 16 Sep 2024 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726473711; cv=fail; b=RHzvp3mW4rcb3ue8wvcSFbBJNIbSibJVfXCUeHOS4y10Mi0aL4PwN6f5Jwva0lprFZ8q+T/7oGu01ajwaSjkR3OrkcBoB+Kf26N7sTuBYCkZ3VW6YTLzC9PEXKARkijCAX0tWVitBXblL6tVl1u2yslG1i3xBl/uWUBB9iEGios=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726473711; c=relaxed/simple;
	bh=jQNqfJN9WQMjascLOMxL6frzybH+zyzSrmk4/eTkjPE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HoOLdxC0MrDvrT8JaxpVLvqg56qZTSwvV1BS1tmY6FIXTqy59XLlYtUYeX5Xg9JDilqW0gfbRzxwJZbYthgm2TGNF6u5EkXw2wY1VSQDgK/MryCfAxYCItDuuYslwTARjnVKGlexkbuodVaJftUzOmdCYxb3ouH7dFxMOu+1UiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VVfz7CT7; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VVfz7CT7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBN3NH67565qOe3Q4p0F3HX9iThLdRONFOaTY9YNzutGvbbes5d41dYH7qXMzq6LRf1KL4cGjsBde5WHLO0y2QwnDmDfskkgrmM/cYARMDPDbf8hWEItLP4E/4Q3Jn2qjJDngVgJNRuI3Y5ybpQAm83+uzrGHhy6QOQqWIFWA4CqzDALVACqM20MUCalw2X7MCQXsbpUyyllIQW639pc/ubtUJTOa2SO3CKvvNk8323WgCdh2OicPiB5owf40ARRZhXL23IvikRegzdx3EAh3UzX7iuYKnU51GKYxpta6eoemhx3ckYuxxr7NTvCfDjcSDUjno+TT7JyL2s8n3lnVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DW6Fe0O7aTU6u+mO/LjPN9y2W6bJ1cpQ4qpxW6B+pw8=;
 b=K6Jf5oynAcvGxtMmGDNsz3qUHXE4aDCB0T3h3IW299k6yeA60xPRMONOLx86cQyE2u0i59nJrP8I6fTHn/MqoBEceJiIEo/ASpNrAMWFLJoMvHGPDgYbXlOFl2krDhJs2frcxVoG2J6LP7DKJIHOno7KWEwXqSXzAEGHjjf8GvbLHjM+zjrboJCckfh+MEtRjFYLpG2Xf1HgwtglHzcf6AR5cV8XeGpFLfUdepwG8LiueNj9j5KFZkck/V7Sex809xKtufKFjKFHlG67ewsHmYKa9aqzNlVPhFCsUslHxZ/Bs4cJhwVzQJ2a6Gu+YVsxwOGT0cBX1Vk6wQoj1JStBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DW6Fe0O7aTU6u+mO/LjPN9y2W6bJ1cpQ4qpxW6B+pw8=;
 b=VVfz7CT7Wx9nzRVLprgQFMeg/GywJRP67h150zkHbOrVJBLrBNiH+fqJ33MOMEYpDy4or41JQDmpcYSaW26/pnAb1s6QKK83F8ZD/KQ4MvpMOd9O6gxnOv64TfhhrGCzX+cGIxQU36PBps4P8OdNzslmbWk+FuOPOkYRc1PMpZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by IA0PR12MB8279.namprd12.prod.outlook.com (2603:10b6:208:40c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 08:01:46 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.7962.017; Mon, 16 Sep 2024
 08:01:46 +0000
Message-ID: <72dcaad2-4fdc-4ab2-96ec-a1d05f2f8d7d@amd.com>
Date: Mon, 16 Sep 2024 13:31:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] Add per-core RAPL energy counter support for AMD
 CPUs
To: Oleksandr Natalenko <oleksandr@natalenko.name>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, rui.zhang@intel.com
Cc: eranian@google.com, gautham.shenoy@amd.com, ravi.bangoria@amd.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240913152149.6317-1-Dhananjay.Ugwekar@amd.com>
 <12511146.O9o76ZdvQC@natalenko.name>
 <ef56c1b3-5ff9-48de-bfbf-88c99b44695a@amd.com>
 <4593672.LvFx2qVVIh@natalenko.name>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <4593672.LvFx2qVVIh@natalenko.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PEPF00000184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4a) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|IA0PR12MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef315c7-c1e8-4049-3b3d-08dcd625cf67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjNNNGV1bk80c1VGUXMyTlY2bmVBOTVEZDZuUEFRRnYzeFBvZ1R4YlhPdVpr?=
 =?utf-8?B?dG9NM1FyQlVTQk82eVk4dzQ5NzlkQzYycDZVS0pjVU1OY2ZLR2xnSE5FQTVh?=
 =?utf-8?B?a1lWSS9DemgxV1NxM3ByMXhrU3I4ZjJyVFJMSVhqajM5Um5aMkZ0MVhoWkJ2?=
 =?utf-8?B?aGp6L2FNTngya3I5WlVxUFZzTGNkeHRHcE9SN2hReE96UHhYUXhxMEJETWJj?=
 =?utf-8?B?REZhdjB1VzdJTXpUQkJEM2VTcjY2S3F4bDRCN01ITzZON01nVFNFcVJIKzc5?=
 =?utf-8?B?OFNBUkY0ZDlLanVjYk95OElhNVhBeW1mS2x4WW5UbEF4Ui91WFAxaVh0MmxH?=
 =?utf-8?B?MlFLd09rU1dzb3YrYTFPclhGTGdDUkNhNTVxb1VhSVdXMUxZWFUxRnFlR3d0?=
 =?utf-8?B?bG9TdFM4bE1pRE1qTTU2WDBNbjRIKzNGWXMyQWdSV3dXeWsrVkJjYzV6NGhl?=
 =?utf-8?B?U291Nm1OelFGaWpGcm1rYWpjVnV3R2pGNkI0VkgvS0ZGazhnbHFFYVhudkFF?=
 =?utf-8?B?ZXVQV05WZUpHTE5qbzZKNWlHQVM0d095Zm5XcjVjRzBLMHYxVzAvbkk3V1Bz?=
 =?utf-8?B?MFNHN1c0WlhuVDEwNmZiTzhZNnlPZko0U1cwZFJqYXNOdnNNQUdXWCtXYzBu?=
 =?utf-8?B?ZEFIZHRCQzhubXFVUklNQitEQ2hYTUM3bENMZ3ZlVExGVktLdnA3Q3F0czU3?=
 =?utf-8?B?dTNqL2lFZXhjZXVYSEx4SHpJL25qS2tENXhWY0JaeVJzekQ1SVkvcWVPMFJX?=
 =?utf-8?B?NWZBVkpJaXUzMHoxVUxqa2dHTlUwWlZhRkdIeWxwUUk0RExpLzZFWE9zQndI?=
 =?utf-8?B?aU1LNm13TEpnY2M4S3pvT0t4bElEQW5QUUlrUitXdVZ4aXY3aGlBTHBCaDlz?=
 =?utf-8?B?WTJPVnRvdG1qZVVvK0FaRTd4T2xJVDhvWC91aW5lMGhpakEvQzdaZWUwa0dB?=
 =?utf-8?B?T1VvVzF4VGJ4L3B6REFzUkI3RWVORk1xNnQ4T1ViSzFTYllER2FMbkdBbks4?=
 =?utf-8?B?bGRLdGZQRHlwSHpFWnNNOGlzS2ZVdkNGWkRRdGJiVm42TmF6dWN4ZDRUNUFI?=
 =?utf-8?B?d1NvUFdWRW5pRDlYZEdFSjZjYTNjTjJaQndIU0NwYUV0TDVuS0kvZXlNWnd5?=
 =?utf-8?B?ZENtSTY5NHk3bE1Bdm1BSVc0QnlacUs5Q2pNQm84clpBaUxxdU9GdkFBUHhh?=
 =?utf-8?B?amR2Y3ozWE0wamFpeGNkTXN1ZVh4bVFUMHg3MXpDcVZNWWNmL3NnWURVTVE3?=
 =?utf-8?B?UC9IRnZoeG4vZGdZUndhc2ZKb2MvRmY3Z0VhV1FsWTh2RkhLdlkrb2ZMdVJF?=
 =?utf-8?B?UXg5Z2FzelVwQUtrUDVsN3ZYUUI2cEN3QmZwSnZYWmNmKzBJSW9heFNHSjhS?=
 =?utf-8?B?SUgrdW1xQnNNbEk3ZUU3dmVYM2o3OTJueFVGdXA4WkJQU0Faa1kyMndlSTdo?=
 =?utf-8?B?UkU4ZFpkaURwTHVRV1BYYmJZZlp3TElSc2I3ODNjeW5wZStaWHVKbXdJa1Rk?=
 =?utf-8?B?NmhzZlBicEdWMXNKSHZMR2VqYnFDVTNNeVpXcldJMFpUbWFqdEV6TDFKVXht?=
 =?utf-8?B?UEhNUkx6UXdhTW8vWFYwdE4rK3MyT3NZOWpOVXZ5dUVTdW1nMzNCcUxhRTJG?=
 =?utf-8?B?Yml4cG9EODVNN2drTURybDdDS1YxcGQyNjVmdGYvV3k3OGJKRGtWZmJEWTJO?=
 =?utf-8?B?MDVxa1Fhb2hhWmlPSUJrMHpxN1VWcU92R2hjU3BVOFpHRzY2bW5XZnFXeXpN?=
 =?utf-8?B?SjZ6NFo5cDFFY3gwWkptNitBcU1MYmNQMkMxMFh0R3pkZUVVUlVSTkFEMTVJ?=
 =?utf-8?B?QTM1YTdxaEkzbzJUYU4xWC8vT1dKUFhaS0IzSEYwVjROREc4d2JwcEIyalZY?=
 =?utf-8?B?ZFAweXdmdUJzZjJNSmdGcldSd2wwUWRnOW43UG5nSk1wL1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGEzSFNkZkFVWWdveUlFaUZ6ZXVZNUZUYWt4Zk5YR3FMSlNZVGlWSkNYVVhn?=
 =?utf-8?B?bXhBRmtsdVZuNW91MGFRWktvams2UitqSlkrSk5LSDJOSlMrMU8yQjB0UUhi?=
 =?utf-8?B?Z0U4WjJqaG8vSHJzU2J3RFl6QzZNTWljTzJkbnNpcWZXVEZ4TlVjL0JSYVJj?=
 =?utf-8?B?UkREZjYrRGJRMUhoancxVjF4UEE5Z05HNksyczRQVlRGMGt2dC8veG5xdExz?=
 =?utf-8?B?QytNOFdGV1lhTUVJUTFjTTNqVkhqOTlXRjluUlpZKzRpZ1NKTk9rOFZyZlVm?=
 =?utf-8?B?Rkg3c3VxUC8wQnVDZ1h0b25oZUZaUFE3QkVBa2M3WGF4L05YUlVZVDlsazZ5?=
 =?utf-8?B?cU95ejBqNDRIcllEZ3RBNlN4SHpwZWozUE8wSjh6VCt5bk9Sd2ZYRGJNRW1D?=
 =?utf-8?B?QWdXZkUxaHpscnFIQnZwOGFlZFQ4bGIyTFBqR0lnVTB5WWI5MDFubHh5cGMz?=
 =?utf-8?B?elBLYXJPTHBYWE53NGJkSGhGdzZOTnY2SHRza1NSU3FDaUtZRWt2Rm4wamoy?=
 =?utf-8?B?L0M4ZnE2YTcvUllid0VsbTJMdGp1VzNkTENaSklGYmxSZVo1Szg4UVZ4L2x3?=
 =?utf-8?B?YlVnSW12aGJ4enEvdk1FWWZJaHFxSVRZTnNjeGs5Yk9lVmlYZW80Ukk2Z0RK?=
 =?utf-8?B?Wmc4TC9BNUNrV0NablRRTk43TzBmUGtubXAzR1RERENLVFRlOW1NOW5BaVox?=
 =?utf-8?B?MDNXNmRSbkNhdllBNTNyZ0hCS1p2SVhnOHo4SHdBYWlXZGJLZWM3ZTl3N3ZH?=
 =?utf-8?B?MjlWZS9nRERMSEp3SXVkbUhqU3ArQjFjekNJY1k1VUVXRGM5TlNiSHhzazl1?=
 =?utf-8?B?NjhVZDV0OHhpNGFDdUJJWGhHTmcwbFNxNjMxVUMrdGM5L1Arb29KbTJPYTdH?=
 =?utf-8?B?cEN4Z1NCblFIdU8wZ2RHQUZVYWR4eWJETlRURnZQSnlHZWdmdWNUY0IvSHpu?=
 =?utf-8?B?NVdENzZjRVdqMXVCTnQreDY0Tm1qOG9IYzFIeDFEdENmK1NUT1hUMUtORXhP?=
 =?utf-8?B?Q2VnVUg0bXZNeFFVemlHQ3RjVGtSbVRVTmZLOUFmRHM5ZkZJZnhUUU5YYTd6?=
 =?utf-8?B?ak9TTnpIMVZ5Unh1dmQ3VGtadHFobVM2bXlrU3I1RVZxTHZCZEdVTWVYcTI1?=
 =?utf-8?B?RzRTakhOdmhIVUUwMDJhOU83ZE5JeXR0ek9WREVVMW94SkFEdWFlTUhoNWhx?=
 =?utf-8?B?MkZ1NmdyN2VqODArWXBDYko3U1dLVEg4Z1NNdHdkUHN2WXhrd1lNdE5VYXdw?=
 =?utf-8?B?dWV2NDByOC95ZDRIeW9MbC9JQ2ppdEJOSFFNczN6cy9NZVk0Uko3eUo3dTFN?=
 =?utf-8?B?RzREL3gweHdtRTc1YVY0cm5DSDRDY3lFNG56OVFiWHZ2Y2dFbVltTFQvcjY3?=
 =?utf-8?B?dGVoRXd2RW5wSWNTVFBNeTJCd0ZPdGMxWUFOak1XTTVacVBjTVRCQThWQmVh?=
 =?utf-8?B?RU00dGlyNmtlTGZISzZpRUV0Y1NNRUdkcHk1Qm51VEx1RmlsNDdhZjBkK3hI?=
 =?utf-8?B?eHNXdEJrdElPOW5aaSsvT24rdlpyRCtqYkQ0NkIwWVMwT2taWUlKVWRUUTlH?=
 =?utf-8?B?V3NRdUZqTFh4NkxGd2RONU5STEU0U0NhT1NQZ3pCN1BSRGo2V3EzYko1akxw?=
 =?utf-8?B?VHkzQlArUnFaT2dJd0Zkd0lCcVlKc0tSWHA5NUFSY0UwaVNFTm5MdzFJMG9y?=
 =?utf-8?B?NWpqNjlsMmFDUTNXZTZ0eTFRKzZqOUhKWCt4d01Nc1g3bzRMMXJhM1hWMVdU?=
 =?utf-8?B?cjlHYlJVbUJ5UHdPa2VPdmtOYUtpbW1ZUFhpSExiOEpSMUJsTno1MjhBNmZH?=
 =?utf-8?B?ZXdldExBanBZcGl4WVh4Mmg2cFhyTmxaTU5ybjdacWUrc0VzckE0R2dFcitP?=
 =?utf-8?B?VW5iUFZtRHFCRFpyZyt2Y1dMNGc5SHBvcGdUVU82STgwdlFLRnhIdGp0bXNa?=
 =?utf-8?B?TS9xdHRZUTJNcVZwVGRMSi9tWjMvUDd3NHFnTFFWem1IRHgranVHcUJEcGpJ?=
 =?utf-8?B?U2U1djh6cEhFbUgzYTgzVThpanlnQk52L0lzTWZQSGhVYTRpUXZCRXlOU1RR?=
 =?utf-8?B?T2UvNlN4RzBsVlFRS3YxMUZPV29kVE9IK2RzOVdoN0ZDVjk2a1o1OGVMeENU?=
 =?utf-8?Q?DWvgtLWKH1emv0LGN4QOJ+9Fz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef315c7-c1e8-4049-3b3d-08dcd625cf67
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 08:01:46.4645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tONJdY1cUD+ofkwwm7p7CBU4PPpp8/yNJexD7DjDdi1gmUOHqgGPAvsCAgiFtv3wWgUn5kuL6xLZnpSxgNOJAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8279



On 9/16/2024 12:19 PM, Oleksandr Natalenko wrote:
> Hello.
> 
> On pondělí 16. září 2024 6:18:13, SELČ Dhananjay Ugwekar wrote:
>> Hello Oleksandr,
>>
>> On 9/14/2024 2:48 AM, Oleksandr Natalenko wrote:
>>> Hello.
>>>
>>> On pátek 13. září 2024 17:21:40, SELČ Dhananjay Ugwekar wrote:
>>>> Currently the energy-cores event in the power PMU aggregates energy
>>>> consumption data at a package level. On the other hand the core energy
>>>> RAPL counter in AMD CPUs has a core scope (which means the energy 
>>>> consumption is recorded separately for each core). Earlier efforts to add
>>>> the core event in the power PMU had failed [1], due to the difference in 
>>>> the scope of these two events. Hence, there is a need for a new core scope
>>>> PMU.
>>>>
>>>> This patchset adds a new "power_per_core" PMU alongside the existing
>>>> "power" PMU, which will be responsible for collecting the new
>>>> "energy-per-core" event.
>>>>
>>>> Tested the package level and core level PMU counters with workloads
>>>> pinned to different CPUs.
>>>>
>>>> Results with workload pinned to CPU 1 in Core 1 on an AMD Zen4 Genoa 
>>>> machine:
>>>>
>>>> $ perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep 1
>>>>
>>>>  Performance counter stats for 'system wide':
>>>>
>>>> S0-D0-C0         1          0.02 Joules power_per_core/energy-per-core/
>>>> S0-D0-C1         1          5.72 Joules power_per_core/energy-per-core/
>>>> S0-D0-C2         1          0.02 Joules power_per_core/energy-per-core/
>>>> S0-D0-C3         1          0.02 Joules power_per_core/energy-per-core/
>>>> S0-D0-C4         1          0.02 Joules power_per_core/energy-per-core/
>>>> S0-D0-C5         1          0.02 Joules power_per_core/energy-per-core/
>>>> S0-D0-C6         1          0.02 Joules power_per_core/energy-per-core/
>>>> S0-D0-C7         1          0.02 Joules power_per_core/energy-per-core/
>>>> S0-D0-C8         1          0.02 Joules power_per_core/energy-per-core/
>>>> S0-D0-C9         1          0.02 Joules power_per_core/energy-per-core/
>>>> S0-D0-C10        1          0.02 Joules power_per_core/energy-per-core/
>>>>
>>>> v4 Link: https://lore.kernel.org/all/20240711102436.4432-1-Dhananjay.Ugwekar@amd.com/
>>>>
>>>> v5 changes:
>>>> * Rebase on top of Kan Liang's "PMU scope" patchset [2]
>>>> * rapl_cntr_mask moved to rapl_pmus struct in patch 8
>>>> * Patch 1 from v4 is merged separately, so removed from this series
>>>> * Add an extra argument "scope" in patch 5 to the init functions
>>>> * Add an new patch 2, which removes the cpu_to_rapl_pmu() function
>>>>
>>>> Base: tip/perf/core(currently has just 1-5 patches from [2]) + patch 6 from [2] + 
>>>>       diff [3] + patch 7 from [2] + revert [4] + apply [5] 
>>>>
>>>> [1]: https://lore.kernel.org/lkml/3e766f0e-37d4-0f82-3868-31b14228868d@linux.intel.com/
>>>> [2]: https://lore.kernel.org/all/20240802151643.1691631-1-kan.liang@linux.intel.com/
>>>> [3]: https://lore.kernel.org/all/8c09633c-5bf2-48a2-91a6-a0af9b9f2e8c@linux.intel.com/
>>>> [4]: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=perf/core&id=8d72eba1cf8cecd76a2b4c1dd7673c2dc775f514
>>>> [5]: https://lore.kernel.org/all/20240910085504.204814-1-Dhananjay.Ugwekar@amd.com/
>>>>
>>>> Dhananjay Ugwekar (8):
>>>>   perf/x86/rapl: Remove the cpu_to_rapl_pmu() function
>>>>   perf/x86/rapl: Rename rapl_pmu variables
>>>>   perf/x86/rapl: Make rapl_model struct global
>>>>   perf/x86/rapl: Add arguments to the cleanup and init functions
>>>>   perf/x86/rapl: Modify the generic variable names to *_pkg*
>>>>   perf/x86/rapl: Remove the global variable rapl_msrs
>>>>   perf/x86/rapl: Move the cntr_mask to rapl_pmus struct
>>>>   perf/x86/rapl: Add per-core energy counter support for AMD CPUs
>>>>
>>>> K Prateek Nayak (1):
>>>>   x86/topology: Introduce topology_logical_core_id()
>>>>
>>>>  Documentation/arch/x86/topology.rst   |   4 +
>>>>  arch/x86/events/rapl.c                | 406 ++++++++++++++++----------
>>>>  arch/x86/include/asm/processor.h      |   1 +
>>>>  arch/x86/include/asm/topology.h       |   1 +
>>>>  arch/x86/kernel/cpu/debugfs.c         |   1 +
>>>>  arch/x86/kernel/cpu/topology_common.c |   1 +
>>>>  6 files changed, 266 insertions(+), 148 deletions(-)
>>>
>>> With v6.11-rc7 + all the mentioned preparatory patches and this series:
>>>
>>> $ taskset -c 9 dd if=/dev/zero of=/dev/null &
>>>
>>> $ sudo perf stat -a --per-core -e power_per_core/energy-per-core/ sleep 5
>>>
>>>  Performance counter stats for 'system wide':
>>>
>>> S0-D0-C0              1               3,79 Joules power_per_core/energy-per-core/
>>> S0-D0-C1              1               5,65 Joules power_per_core/energy-per-core/
>>> S0-D0-C2              1               1,26 Joules power_per_core/energy-per-core/
>>> S0-D0-C3              1               3,18 Joules power_per_core/energy-per-core/
>>> S0-D0-C4              1               2,06 Joules power_per_core/energy-per-core/
>>> S0-D0-C5              1               3,51 Joules power_per_core/energy-per-core/
>>> S0-D0-C6              1               0,77 Joules power_per_core/energy-per-core/
>>> S0-D0-C7              1               0,55 Joules power_per_core/energy-per-core/
>>> S0-D0-C8              1               1,65 Joules power_per_core/energy-per-core/
>>> S0-D0-C9              1              47,85 Joules power_per_core/energy-per-core/
>>> S0-D0-C10             1               2,49 Joules power_per_core/energy-per-core/
>>> S0-D0-C11             1              11,85 Joules power_per_core/energy-per-core/
>>> S0-D0-C12             1               1,75 Joules power_per_core/energy-per-core/
>>> S0-D0-C13             1               0,74 Joules power_per_core/energy-per-core/
>>> S0-D0-C14             1               2,58 Joules power_per_core/energy-per-core/
>>> S0-D0-C15             1               4,67 Joules power_per_core/energy-per-core/
>>>
>>>        5,003391425 seconds time elapsed
>>>
>>> on the following CPU:
>>>
>>> AMD Ryzen 9 5950X 16-Core Processor
>>>
>>> If this behaves as expected, please add:
>>>
>>> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
>>
>> Energy reported by core 9 is considerably higher than other cores, which is as expected.
>>
>> However, can you please post the core_id for CPU 9 just to be sure,
> 
> $ cat /sys/devices/system/cpu/cpu9/topology/core_id
> 9
> 
>> also I see that other 
>> cores are also showing considerable energy consumption(e.g. core 11), are there some other 
>> tasks running in the background?
> 
> Yes, this is a fully-featured desktop environment. Another run:
> 
> S0-D0-C0              1               7,68 Joules power_per_core/energy-per-core/
> S0-D0-C1              1               2,05 Joules power_per_core/energy-per-core/
> S0-D0-C2              1               0,96 Joules power_per_core/energy-per-core/
> S0-D0-C3              1               5,16 Joules power_per_core/energy-per-core/
> S0-D0-C4              1               1,11 Joules power_per_core/energy-per-core/
> S0-D0-C5              1               2,42 Joules power_per_core/energy-per-core/
> S0-D0-C6              1               1,11 Joules power_per_core/energy-per-core/
> S0-D0-C7              1               0,51 Joules power_per_core/energy-per-core/
> S0-D0-C8              1               1,61 Joules power_per_core/energy-per-core/
> S0-D0-C9              1              47,07 Joules power_per_core/energy-per-core/
> S0-D0-C10             1               1,59 Joules power_per_core/energy-per-core/
> S0-D0-C11             1               3,02 Joules power_per_core/energy-per-core/
> S0-D0-C12             1               1,43 Joules power_per_core/energy-per-core/
> S0-D0-C13             1               0,84 Joules power_per_core/energy-per-core/
> S0-D0-C14             1               0,73 Joules power_per_core/energy-per-core/
> S0-D0-C15             1               0,78 Joules power_per_core/energy-per-core/

Great!, the results are as expected, will add your tested-by,

Thanks,
Dhananjay

> 
> Thank you.
> 
>>
>> Thanks for testing!
>>
>> Regards,
>> Dhananjay
>>
>>>
>>> Thank you.
>>>
>>
> 
> 
