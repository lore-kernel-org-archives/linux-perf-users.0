Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF78171A4;
	Fri,  7 Jun 2024 03:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717732591; cv=fail; b=e6vahHTBJHItEaQ7aSt03gPjB0uCD8n/76RzArp0cM2Ak2/SwozmbhpytTG/5Az1un4VyVWY4dCtqUXt6T35aKDxyohXhQSi7GXsDFLx8kdnWxPyahRM6D9DVJSXIftp5RiMRMH16tRf6uJ9ALYg9k68MDVQJvNXhXkYpwvt2YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717732591; c=relaxed/simple;
	bh=mIzxJxVYtsvL4uIE9PFlkhpisaiNLPIOwgKdyrS2KpM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jyNeK4AJZjPqymCUK23/NFtx3IfRn25C71MROVmLmHCLohVbiNINsbQE/oo4+rnBXatPwcL9hUmBVy4QCjIaVt8trwxxDw5WBnaCgEok6tpuqvEYdpe8rNeicpUUQM1o8Iza/NvjPU92WoR6WuThksl2cAuqpXoC8nPc/gTrI+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QN8L5YLN; arc=fail smtp.client-ip=40.107.212.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QN8L5YLN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqYHWrcH/Bz2Q138ZVWAx47akwVnBSVu5cJsz97owkzjuluItlOOHXvyA80tQY/5GvOQi/L9ihllRPQoRqtxNh7DCcn9FeCTYF327OR7KUJ4sZRZ4igDzfg7XgsPfLDBc3I8nyZVsL2yUKm9CUt5FcLkIrSEBodhhMYnokM0uTljk+HkVE0wXdpmdUf71ki3v3QcJpWm7O91dOWxIocxZQcLKdF9yck0gYtoc69LfxszondkWOAeputuoaJ5RSa96hNgNJ2VPzpbABpWfRWdBeISR8tK1lpXTbbcUxZXcKiEStHfmfM01Amx2shqQ/H6d1kb0QDPGgstlh3UePpO/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DO9TxOwyxlzd1hsqHToonYn8XUR9g7LnKqWylCqn3N8=;
 b=Rgd/49DAfuzbFCyK07Pj0O1LmPkoX/MuOYe+TsxeduKphkCbdg6UYMvi7/IEvMY8VWtUTgUXq2yTpAvtlYm/uE+SWCr+c7NexissruYisHIuG7AJ5BpcHjwew30LJlTeDsc+cSCbMftZbMdoFKbsObjW/u7CzsLci35FH3Enae0VwSQdX7hqPAXy+pZ8COD2NpFqThG+pGbL2l/yXxGhQ2sIshJChvTq2ypC4EMkwX04N3hX18AdYT0shjm8dIo/kIT0u+deP7+f8IvUYGzZRlA5xpHxcMaivI/+jotQ6xoQGz8rVQXH51YKvS+un0yl/9h4+OsT6ZgCkiAktQ3BuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DO9TxOwyxlzd1hsqHToonYn8XUR9g7LnKqWylCqn3N8=;
 b=QN8L5YLNM+xFqVuHcM+I8xMMMWl0/kYsbm7AB1rCYUVJ0WOSy/4yzBxvItbqTBSXlsaZvxCoEkslJDuxOiitgj3rUIlxHvntlb4X942RgEIHOj+QZMupw4EMGx9EDIL2KU+hT+6TTgXctVd/PVRqf3Np6cJVEzyNE9Jndg2dOHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 7 Jun
 2024 03:56:25 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.7633.018; Fri, 7 Jun 2024
 03:56:25 +0000
Message-ID: <35b43fd3-54ed-49ba-b8c5-6b7d03c9bb8e@amd.com>
Date: Fri, 7 Jun 2024 09:26:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf top: Make zeroing histogram on refresh the
 default
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
 ravi.bangoria@amd.com
References: <20240516222159.3710131-1-irogers@google.com>
 <86136e0d-45e9-4bf4-826b-359e4993488f@amd.com> <ZmHDmrLCoYPUCv3n@x1>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <ZmHDmrLCoYPUCv3n@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::32) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 925089f4-d905-490a-b0d8-08dc86a5cd76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXR0SURhaVhFL05zUitrOWU0NnN6bHNGZVR0dzFNSXd4eitsbTFoSWwxU3h2?=
 =?utf-8?B?dGdBZnhoR29iaTE4U2NYK2g3VzgxN0V3RWZjNmF5MlN6dDY5a0xUL3BaMDhj?=
 =?utf-8?B?NDFsSjhCUk1xN1dha1VFN1JlTWd0WURWU0xFV3Z6bU90NXkzNmNJMzFJRDBx?=
 =?utf-8?B?YzYzWDdFcFhGVVFDUzc1UGZvY1p1RVhnMlBzQ3hiY2F6RXA5ZWc0OU03cW1y?=
 =?utf-8?B?V3YxSkdFejkrdXozQmNzeHBGeFh1SzU5S21qT0dZVm9RRkxBdisyaU1vVG1j?=
 =?utf-8?B?OFA3dHFxS0pUUzFTYkFIQWEyTUpjb1Z3VTlvcEhhN09xaFZCNEdhajB3eU9V?=
 =?utf-8?B?Q1pIUlp2d0ZCQmNTUk1rVWdkVm9KK3VWN0VRd2ZVcTRDR09RNkQwam1RRjE0?=
 =?utf-8?B?OE9IcTgyZHpVK3ZoS2dmcWc4d1BDekxYT1VtajFaWWh2cWo3ZTJySGFDUjZ0?=
 =?utf-8?B?ZkVxQTI4Ylp2azY3akxqV3RlUk5tcEl4NmFXNmFDMy9zMVdENEUrU0lrSGJX?=
 =?utf-8?B?MVBNNUdQUG9FR0VjdU9HRFFsMVkzWS9PRENtOXkwL2ZnRUFDUXlMUjdZakVS?=
 =?utf-8?B?LysrRDRidVl3YnY0ckJIREpHUUY4VUZYSC9QbmhMME80WDBOUElodmtGczg3?=
 =?utf-8?B?K3JKSGlESnNuTW44N0JEMFFBdzNYelZSM1NzeXhENVBuQ3BJVEFxZnM0Z2Vk?=
 =?utf-8?B?dXBlQ1RBZm5CYXhabmF6dFpIeTlKRzlXRG8zcGsxNENEbnRGV2RhRnFGTVJN?=
 =?utf-8?B?M0orbC8vUUtIckR4L2JMbVF5Y2pYeGNBTkFIU0s4VHBLVE9JYUJBZWVXL1dR?=
 =?utf-8?B?eFJ4Uk5rcE84YUxGWlpvOFVBRWJsZzM4Y1NQZTBnQVlYM2t6V3RTNHltclRl?=
 =?utf-8?B?bkpuZUUvbm5rNlNOd1RhWjFqZVpjU0VtTlpPSlFzTWdPaERBVmg3anpxc3N3?=
 =?utf-8?B?V0c1UTlYMTYybSsrY2xTMkczODRETVNBcEFsS21MQ3ZZRFFISXpkK3g2Ujlo?=
 =?utf-8?B?UmpWRjZDbC8zRkNnaE4zNCtPVFRBa1ZaMjVIOGZJVWh4ZnF2ZUVHNzFkem5S?=
 =?utf-8?B?dEhUdU0yVXlqVTl1RGRzOXFtZnEzRUU5UDFVT05DTFdQT3dNeExUaVQrUWJC?=
 =?utf-8?B?cE9zOEF0ZVBZcFFjTm5TeWF0ZWQ1SUVYVGJGY0czdExmYThoMDczeHkwTkx1?=
 =?utf-8?B?Tlh2VUZFMDloY0lZUWRTL1BrS1Y4R2g2OHBzVmw2TzQrb3lUK2dHYlFFT0Vu?=
 =?utf-8?B?ekY1M2pmdnNjWFBjQ005eDRmQ05MNWROby81MVZoTU54QnFHcU9OMERUclNw?=
 =?utf-8?B?S21ORE13NmxXWU5FdUZDaTdKb1hBeXpHOXpHMTJabHlpWm04Yyt1ZkNKSHBP?=
 =?utf-8?B?dDI0ZFVUV01zZ1JKVldTclkzSms2cmZORFBUK01IK2VGU1FJN2YxZk1rdHNh?=
 =?utf-8?B?Zzd6TlRoOUVwaDRMZUFhZUw4ZXVZNDJxM1ZGOTNCbXpuZmN1Um1aMEthT0lG?=
 =?utf-8?B?TXVzYlhIM1FRREthMGJ2MjVseGUwelArSDJMdFQvZjdrSjloU1Z6MHNaZUIz?=
 =?utf-8?B?SlpYU0pxN0pJNzNSeks3OTMvWTlkYk16Mmx5a29VRll3L3gzcnV3Rm1kNGZ4?=
 =?utf-8?B?REtWR1M4UTZpTHIydkJ6RWJQTWViTWRXYXo0cFllZUt1MExjSXE4aTZESWc0?=
 =?utf-8?B?aXVnR0d1RmdLMFlBdU5qTUxhMU5KRGRJQW1zeGlVYUd5STI1Nkc1RTROUGxp?=
 =?utf-8?Q?2z+j0Bc/B/ab85HJr8UEeiI+o3q9LUaKOjM5hC1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dk5kRkJwbmU3aWh6cFFYZjA1SHJwZUJpclFnYkZKcHpSNHNhd3ZrOE4yUzkz?=
 =?utf-8?B?eURFbE9qcHQ2dDIrd1ZmRVVOZ2ZLejhmbnc1cEF5bjJYcW0wQjBCZGMvcmJm?=
 =?utf-8?B?MjNRcXJWSEhTMFd5WUxCNFBDSnVlUXd4cW56SkF0dU1XZVltVmNlS2xEUFJz?=
 =?utf-8?B?Y25iekJ4UkFsRHNrK2NMWXhZdjRJVG50YUlTUVpzZjBYOXM1ZmZXeEJsS3Iw?=
 =?utf-8?B?b281VENXWVN4UWlsRUpWRGFOZHhBcnFEM0tZM3l4ZHNPaGVBRzVoYVQ1YkY3?=
 =?utf-8?B?T1hWbjFzMXBTYmpmSzdiWmZ6bGhaTHBkbFFBdFVYMUt5V2tYZFhLSHBONHpR?=
 =?utf-8?B?OFJaaDFvcE5GOC92bGlrQWp0ZWxkUklFeVZkME5mNFhvVFRZOGwxTUpxejJS?=
 =?utf-8?B?bXBMd1BkSUcvMEJJYyt4dnN4NWRIeWtwNDBJUHVCdytUM3lKSksxVkxBTmVL?=
 =?utf-8?B?MnZrSGZRWWJyT0RWbGF2MFV6Umh2dk5uMWlKMzkrSGQrNTlPMU9DczRJck96?=
 =?utf-8?B?WERkeVpQQ1JpTVJrOVcwWk9EeUFVZ0JyQmpvVnJYNldxcWJQQ0o4M2twNU5T?=
 =?utf-8?B?SEpzd0w2UzFBbW1tVFV2d2Q4aUYrVHNVQUhIMXVPaG9yLzYreVRxSVg2dWIx?=
 =?utf-8?B?NCtCRkUvc3hTVFlNalpETkt0cGZhRGdQSllCaGhMNEgxRVI0bnZyVDFyWll4?=
 =?utf-8?B?bVZZVThIYWs3Ri9ad1ltMTRud3FlSlhJS1c3YUNZbUhsay9MdVNVVEh1TlM5?=
 =?utf-8?B?alBLOTJkTFFuZDlCM1dpczJqMUZDeElDOWpDVmZuZENVYUUrZXlGMmxEenZn?=
 =?utf-8?B?YzViaVFBdFRyWDR1OVhVK3hiay9URUhnK1Q4Q1VhaFBDd3pjTHJlYUV1NWRW?=
 =?utf-8?B?VnBlcVNuVUJjZm50QXR2NmJzWlp4a1Y4ZU9xbUxHZ1lEcE5UTVV5cG5hRC82?=
 =?utf-8?B?WktkS1BiSE5vQWZ4dWQyS2xRWVhBNkE2U3p4UzQwT2pFb0dGbXQ2RVhXUVZF?=
 =?utf-8?B?NzdwRC9Jc2pvR2dEUmxhZGQ2T3k1ZDlLSHlxNVB2bkdGOFBOVk9oZWQ4RGFC?=
 =?utf-8?B?eXB3bEkzVkdsVm5HNFloUjBvL3BzM1d6c1VCZUVaR3FtOTlIOUYwSFBwbk10?=
 =?utf-8?B?RWpYck5hRjJVSjltUFE3Yk82RFpDYzhxcTJhSUIrVFZQejR4c1cvNWdGWHRI?=
 =?utf-8?B?azkvS0FBOHVMdnN1bFREVG4rcC91ZTNQdlZDUFJxd1d0YmRPaFVPajlOSzRs?=
 =?utf-8?B?TnBxalFlbFJyM1FQSitOV1NlQkhsK3lQMngvdVJiem1lNFhyaGVFUERtc0E0?=
 =?utf-8?B?SEMrTzNSQXZQYS9nTVJKcmJyaStOdlJYWDNGaTJ0U3lvQ010SzV4cENoL3RH?=
 =?utf-8?B?d2dMTFg0N01zRFBvakxzSXlJd0hFb3VXcWQyZzZ5OXQ4djllZGhEY2F2Rk1G?=
 =?utf-8?B?ZlgyQ1BoQVVRUjQ3aTYxU2tvNm5wMjFQRXJSTEFJZU5SYjMyeThlWDlVbUUx?=
 =?utf-8?B?cWdpZnZhRFZielZITFN4c3RXdkl1Y2QwUnVGYmNCVFRMbFFPVGxoQ0VxRFF5?=
 =?utf-8?B?MHVQZnNKTGZZbm9EeDVONUhsdzR4TWRMYUpNTVZpSmFlMzRxQTh6TW1rTEVM?=
 =?utf-8?B?eUwwUzMxRVF3YVRUOWF5OGZrZmFOd2pBa05ZMzRGYkJuMWtVYkowUThWcXlE?=
 =?utf-8?B?bTRoWGRSek1TOFdvRlNQejdraW9Hd01ZSjhjRG1jT3VoWjdhRDJRcjYrWjBQ?=
 =?utf-8?B?dHQvMGt6YWVkMWJ5cjNTSEtjTkNHVkVMeUtyNmxnOWhyNExEZTVRUGp3L1dP?=
 =?utf-8?B?ZE1nRURhK0ZpMWk2bys1RDRXQ2lJQnYvTmNoZ0V4ZEJ6SFBMOWhKdGlRUjNh?=
 =?utf-8?B?Vk5wL1B1SndFeXRyazlJd05LblR0Qjg0UU8vWHFKY0xBODM4T2t2Zk5aNzB3?=
 =?utf-8?B?aGtRa1piNGs5anlnbE9UMEFFaHpNUTFNak5JNk8xRG5QMDc5VTZiUnhjcUwy?=
 =?utf-8?B?MlFZZ0xmQXN6cTFyZmRpT2NHd25PbTl4bUZaYjRZc2t0aU1nQ1N4cFVmdkty?=
 =?utf-8?B?SmVla3gxdVhiV0ZRRWREUDVDUWZ3akpDNXdMRzBKelgva2k3L0E4c0MySlBM?=
 =?utf-8?Q?V6x8y75JNHYpaYGR36RKvI+lA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925089f4-d905-490a-b0d8-08dc86a5cd76
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 03:56:25.7821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IzX4d0PUibaajeJ/yofHqZcmcJGRxzlOLYD2YykcIJ19mCQ1kUvJk3DcqKREO/LFwpj0PTdXOD108x9RbtwykA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945

On 6/6/2024 7:41 PM, Arnaldo Carvalho de Melo wrote:
> On Thu, Jun 06, 2024 at 10:15:00AM +0530, Ravi Bangoria wrote:
>> On 5/17/2024 3:51 AM, Ian Rogers wrote:
>>> Instead of decaying histograms over time change it so that they are
>>> zero-ed on each perf top refresh. Previously the option '-z', or
>>> pressing 'z' in tui mode, would enable this behavior. Decaying samples
>>> is non-intuitive as it isn't how "top" works. Make zeroing on refresh
>>> the default and rename the command line options from 'z' to 'Z' and
>>> 'zero' to 'decay'.
> 
>> I've also felt `perf top` decay as non-intuitive. Esp. when system becomes
>> idle after some heavy workload, even decayed samples are far more compared
>> to samples from currently running processes and thus `perf top` keeps
>> showing already finished processes at the top, which is kind of confusing.
>> fwiw:
>  
>> Acked-by: Ravi Bangoria <ravi.bangoria@amd.com>
> 
> Thanks for voicing your opinion, that is really helpful.
> 
> Changing tool behaviour can have unintended consequences even when done
> with the best intentions and analysis, that is why I'm wary of doing it.
> 
> The --children case generated complaints when we made it the default, so
> we ended up with a ~/.perfconfig option to disable it:
> 
> root@number:~# perf config top.children=false
> root@number:~# perf top -g
> 
> Or enable explicitely:
> 
> root@number:~# perf config top.children=true
> root@number:~# perf top -g
> 
> Same thing with the build id cache, where one can disable it using 'perf
> config', etc.
> 
> So I'd do this initially with a 'perf config top.refresh=zero' instead
> of changing something so few people complained as not being intuitive
> after all those years of having that default.

Makes sense. Thanks for the clarification.

Ravi
