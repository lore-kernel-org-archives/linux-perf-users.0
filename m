Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792993990;
	b=jRTGWXlSu1cIIXO6dXJ5V7cPJcs6bJYVkYyrgAK0GQws4l0bOCAe17297zJCUYKzoOgA
	 zlrZtuMymkJW+sT7EONE1ZdCViQ4vSCcGFC185YP2XMBr9Sg2c95ltSXkg8XM2KjIsujw
	 RAEkY6hKV3Wj9TgqA8RK6ff94k8kTxkYsWw3CwI5kCKW8iwZlhSrTd1SuxITYzLcli45r
	 h/BICsZ9i1z3btlKzZC09/7myl7TJe5/9eZPf877apTqn5tPU6KHtJIYWXIO1zYt7WhCV
	 +So53xBNRMetMaKXEFUa6n/Cla0LWAr6s2+9VdjcK0VRbcu5dEYYNe8TWR4tb5QGZdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792993990;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=x3F88vnVkJzWlh0Om8exyg5wTJIs+txXUssPfeUr0TU=;
	b=ASD8LY8N0hZJFlUYAMsnso4DwPCG3E1724X9vj7LwFv9Yohy5G3KTMvKoX/LPzUnXg6V
	 4YZZppxfgHtMDzlR2EnBm+2zUDwV69dk7gUIytEXuDHQd0JqxdoLmf6K9Y51Es4Bvgx/k
	 fjp1gWHkb8XZsHFKBdGt9KFiGjTOWaFDKJafTQ5Hd58fCkeVUamq9pWjr0V/PESndZG3D
	 d311rzdcpxyTV1u7KzMP2sCOCdfuZ/aavx0+j9dJSd2NB47+9oiGBsoz4Kh0meboW1jk+
	 prgKGRMN5qnXpyD8amaCjsNry096T7taO7icRKYdl8hbYoZQAHsSrKeLp92cGuJMzMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ebDn8Jjd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.24
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C209606A31A;
	Mon, 26 Oct 2026 05:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C209606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ebDn8Jjd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhL298U9nWWg/RrTeL7Bhi7ILX04uL5zrdosPXR/aAwkDUgUsxNPlsks5DdTKvAfZKHhxz9G4nClkF9FoLf+zPYENS0teNsONWu+ETuSC3uI7KysaTGQTbvISiTTQ9mWvdsuhiqmAwtw4wuQVtctsHAzxnhnPuBi+9DaO5SNI6AH8HIDUeVMwTTLN+Ewhw/f1a3+lExM7n2CwyJvlgOIABRtSYc9YXmk+L0EHv44MpdLs7Q/k+/aZpgGAH1bgxCJREf2pubBJMa7lN0BSO0yldAzatliL+1I3eB3aB0DRKuoRCPlUJxK/pLelWY+9j/90wAaRArx35DvKoOpUnQZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3F88vnVkJzWlh0Om8exyg5wTJIs+txXUssPfeUr0TU=;
 b=w4AYxBl4Zg0cwYkw/mUeifnJkr0+JDAPVZF5ohu3BYKdAw4O99RtrctGV4bGjzyDgfqj5N4SmpCaG1eMc5AkSucLNQC8pjpf3BTAaJSc81eyWqdHXoSDKy9x1xVqZavdE+5CJ4fzkLQFiraMMuEi0EP7WxVDvs7DJScW1nUojJnCiaK58eQsGhjK16j8WS9CrMymxlKkQ/Uthw1qdcjAef/ceCrgaDAqJejfKdUwdU6ScfZ8Z9lo6BbLoPFwCV2+QIe620Pz2680sFBAP006MFYzSJwCpo5XiJDpVWkttNzKfi1LRDMit7gqsUTCQxQyp0AGaFFLvqFVkEP/9Lao0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3F88vnVkJzWlh0Om8exyg5wTJIs+txXUssPfeUr0TU=;
 b=ebDn8JjdrD4p3arwRpFe/TYcrkjWGp7KDy1HDaJs/5umI9Kobiu8GBVUjH/+nn+9h58bwPAsHBci1wtoiHCsC2NmgoSqyBFdl+j0bgpJmdSwKCEcscmcnmwmySjP9qXKBZFE0vAm863gd+yiNZNz4ss78GLMOsVgjjwsaqOHiMI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12)
 by CH1PPF989868826.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 05:53:07 +0000
Received: from SA0PR12MB4383.namprd12.prod.outlook.com
 ([fe80::825f:2fc7:9ad8:520]) by SA0PR12MB4383.namprd12.prod.outlook.com
 ([fe80::825f:2fc7:9ad8:520%3]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 05:53:06 +0000
Message-ID: <3e3e9a6d-4083-4454-97e1-d52c7c9504c0@amd.com>
Date: Mon, 26 Oct 2026 11:22:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] perf/amd/ibs: Fix kernel address leak via
 REGS_USER and REGS_INTR
To: Ravi Bangoria <ravi.bangoria@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Jim Mattson <jmattson@google.com>
Cc: Jayapal Ashwin Nair <janair@amd.com>,
 Gennady Kupava <gennady.kupava@gmail.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 x86@kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Santosh Shukla <santosh.shukla@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das
 <sandipan.das@amd.com>, Manali Shukla <manali.shukla@amd.com>
References: <20261026041838.941-1-ravi.bangoria@amd.com>
 <20261026041838.941-3-ravi.bangoria@amd.com>
Content-Language: en-US
From: Jayapal Ashwin Nair <jayapalashwin.nair@amd.com>
In-Reply-To: <20261026041838.941-3-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0122.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::14) To SA0PR12MB4383.namprd12.prod.outlook.com
 (2603:10b6:806:94::12)
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
X-MS-TrafficTypeDiagnostic: SA0PR12MB4383:EE_|CH1PPF989868826:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e66d4c-2dc4-47a1-63ac-08df332567ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|4143699003|11063799006|56012099006|261009223027099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	VX+ikLant1dpFCP23zIMTZnmdIeNhrwOmf+mCD1Ezf3Gfd+OMDmaVMfI9wzKBgD9qpstLIQ5t+OAc6WbNeg1F3KGbdKJkomaVaCqcVbLqRltdwuMjK7NPTmqyBTmFav/QkxBUgOQI4Tl1OEncJN2hYsOml0XGSKYi5CznFl89OdOKQURLNUXP/3sROTB1+MP+eXvnUFysd9deEtlrK8wE5b52p7GhTWun5X6PnJfraP3/95hYFsWmh8bZgkdMovyqsQnTIKgNvLU4aXx3uKW6v3xn9J6CRGhuQpC/s200aEI6PMmejI5+qQJRtpfP8jI7ZujZTA/tN8ZJ7xOwal4evbMdV63MEcG54/puUAZMbYLRsN8+/pRirOnCr1Ni/UhHA7+nxttk3NJVo0z7PrTW1hH6ZRxV39vWEjwXexCPx9bQpd8PxJT7FOG/EpDUVF6fBa3/DxU3Ff/CqLfpq1gMmwZ9Sqw+HPICE4Pf9vzqRtit7FdRKSYLP0JPeIifNbz1xsjJtruy4S0VcndUYjPqxyIf0QtpJF3k+arq19fm2OCVe1ZbVq5oPuEdiVfCylbdRe7RfyVrbk0P9Tq2ZlqS8DgHQGPtMT1DljnI0FNcUVMv3ESukPfmKH5ze7I3kmc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4383.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(261009223027099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WllkTDFqS1YzUENTeDlweG4wMjlPUU9WTU51U2JOdzhYbHNDNWJORXluMk5m?=
 =?utf-8?B?VHFZOUJyZjBBSWVlcythTWRjSE1MbXdDTEdJQzFpZkxzaldpSkdZVU9YT0h4?=
 =?utf-8?B?VDdiU0NBd2JBTTZ6WGdLS3lERWR2YTY1WkQrMFkvTjJ6dmFaZFZnQnR6ODB2?=
 =?utf-8?B?QkJHeTRHNGVqd2R2SDd5eGVrT2ZZaDR5VnRQTnZsVkJTT0IwTE5QaHVydyto?=
 =?utf-8?B?Wnlvb1NvR1F4RlVwT1ZrQ1FWTXQvU2pNQWZ2TGZWWE1Kd1RDbkNibVU0bll6?=
 =?utf-8?B?UjRzSi9VNHhNTHN4K1B1WFVlbVgrTDV0RlphZ3ZIZ2RubTZTR3BCZHRZK0FP?=
 =?utf-8?B?ZWdjYWlqZTlGME5NSTU4TE01TmQwQmYxb1RrZWVWTEVwNXZGVWNCNnlHVkVo?=
 =?utf-8?B?QVJweDliZENsZFlXQjRmYVQ5TlA2MHhSZzFjRGx2TmpWNENaOEMvVGcranRr?=
 =?utf-8?B?NUE5UFhWVS9mNGx5Y0xianRMcUhOaWluSUIxMEk5SWx0YitlODRHSTZEdlYw?=
 =?utf-8?B?S0dISFdxRTA4Nlh5S0lsOEdld29yOWFZY09Ga20rYW5haituNURVYnR0QU9H?=
 =?utf-8?B?RWxKQzVSSkFMT0FMWXR3NFliV1NmRG9Cc2NYWEthSmhBRlpPQ3V4cTNPeVFv?=
 =?utf-8?B?VXptSTFLZ1YyZG0zaHcrWHhJbzQzSms1QjVOU1lXbyt2UjRSUngxRGYybmZs?=
 =?utf-8?B?VG4wRnNqM0h1VzRhdmUzOFdidU04c1ZpRTZtajdERFNmUXd0M2puam9ob3pj?=
 =?utf-8?B?dzhrWlh4N2NYUmVDTEtNa0U2cktaSW1xQTRseGptbUNqSDNhMDgvZlErSWNS?=
 =?utf-8?B?RERNbUV3czVqUDBZdmZlRUtPM0h6dzhkMWZBZllxRGRTak5QQTJKTEttNnBI?=
 =?utf-8?B?RFpQSVQ4K0srditvWGc3WWFXdUhINkEwUGZUMFNvS3JqcTVBVWVpVmZNWWNM?=
 =?utf-8?B?elRsWEwxRTllOTFSaTUxeThEZVVOcmZ3eHZLRzFMaHNtVTdvVWxPT1J5OVla?=
 =?utf-8?B?WmFrLzJzMytiSlJqK1hxMmpWdFg1RHJlMEdGQk1wZ0VDSitzTXphOUFuUVht?=
 =?utf-8?B?bEY0dFZiaWZNQXdpR05PZ2tEVmR2dTRTTi9TRC9MUWFoZm11dzBtUEYvdHZa?=
 =?utf-8?B?MWVBamwvUmt4aEphM0o1NkRtWFFIY0g5RE0zbVRtVWJDQ1VscUdaUUl1OUhy?=
 =?utf-8?B?aXVsNDRoYStINXFYVy9GbDQxQy9ZVXRqbDJCWnk1azc0RWhKM0Zidk5ndlQv?=
 =?utf-8?B?ZmlEazBpV3VWeHMzREw2ZzdKa1BlVHRydWJOZTdGT1VLM2VBWWhpUmY3eWtu?=
 =?utf-8?B?bzZteU05a1pjMUR6YnJDbFBMOHQ3VVRBYUdNbzBGTlFRMVZuV1ZLeUNZNjJU?=
 =?utf-8?B?WXFRWE5SN2lkbVRzODhyV2MvZTJkc24wVS94VmFURGRQNVBoVFRpQklhYzRY?=
 =?utf-8?B?ek4wU3dpb1A2bWVlelVhWjlCRkd4ZUFkazZ1SWNtazIrRENzeXYvOFphN1pT?=
 =?utf-8?B?ZVV4UnlJYnc2empDeUxoTDd0ak9UMGpZNXMxWFNPRVROTVQwRFNibkJ6TDZJ?=
 =?utf-8?B?NFk1ekNCeUNtR1BYZE5XUnJ5eVg1MWhPd0xxUlBSZlllcUpydytuSTl1M1BN?=
 =?utf-8?B?cy9ISWp4UTEyYUh4eXF5NjFPbmFERjJTNlpQOFloaFFPN1VUR2YzZ3VrODRG?=
 =?utf-8?B?dGwyVlBSakVQKzJCQW9TTEc5aDZMVDBmWE94QnlwYng4R3hKSDRxYm5ycE16?=
 =?utf-8?B?NUwzUXhkQjUzTEhuTXowNXpLOWp2UVkzUVZPYmhwTEVDanNlZGh6TFVvUm5S?=
 =?utf-8?B?UThyZnk4MjBsYXZPSUVjWXZoQlR6YTRXUTVmRkRZMXN2YWRyWWZCcUZGTHln?=
 =?utf-8?B?QkhWWlc1RldpS1lZaEJ1TFA2STFTTEM0WFdMczlucWpHSVJVOEdhdVZ5ZnZt?=
 =?utf-8?B?TVNBMFc0UWp1ODFZUTIxYTdZSU1ILzNENHpaaEMxYVEzeXhQN3ZaV0RjWTNp?=
 =?utf-8?B?YU5kWk1JL0VnMWtSTkZnVGJxT21PRU1LQzE2cTJkbWVVK2RKelF4elBQM3U4?=
 =?utf-8?B?aDBaT1VKcFZZellkRElEcWNWOVFHS2FKcmxFRUo0dU1WUFJzMWI1TmlFTnFQ?=
 =?utf-8?B?K2h4QlBDMGthYmxpUEN2QWduNWNCU1pMNXBGZXVLWDhaZUREU2gzNUJtTUgx?=
 =?utf-8?B?QkJmUUhjbFZnUm0xOTVuQmhFS1RvenF4b2pqc2FQNEdoZzdUSmNKOWd2YkFq?=
 =?utf-8?B?VjV4QU96ZmRsdk1Tem5xQmQ0YjYxdFduQXpvNG84MlpKa2FjSXQvMlNrNXBl?=
 =?utf-8?Q?+SJyRVIfMzrJ7jxhhQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e66d4c-2dc4-47a1-63ac-08df332567ff
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4383.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 05:53:06.3083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byExloI1lb370ohJZC0nJzAxq6zoVUeJhjV/8sTmPuc/sLTNoueGFLn/MiBEXbNe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF989868826


On 26-10-2026 09:48, Ravi Bangoria wrote:
> IBS hardware captures a sample and raises an NMI. Since the NMI can be
> delivered with a delay, a privilege change may occur between sample
> capture and NMI delivery. Because IBS only provides the sample RIP, the
> kernel records GPRs from the NMI pt_regs, which may reflect kernel mode
> if a privilege switch occurred in the interim. This can leak kernel
> addresses to unprivileged users through PERF_SAMPLE_REGS_USER and/or
> PERF_SAMPLE_REGS_INTR.
>
> Fix this by using interrupt regs while preparing PERF_SAMPLE_REGS_USER
> and PERF_SAMPLE_REGS_INTR. With the change, when IBS samples a user mode
> instruction but the NMI is delivered in kernel mode, PERF_SAMPLE_REGS_USER
> will source its register state from task_pt_regs(current) and
> PERF_SAMPLE_REGS_INTR will be omitted from the data sent to userspace.
>
> In addition to fixing the kernel address leak, this change also ensures
> GPR snapshot consistency, which resolves the DWARF unwinding issue with
> IBS.
>
> Reported-by: Gennady Kupava <gennady.kupava@gmail.com>
> Closes: https://lore.kernel.org/r/CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com
> Reported-by: Jayapal Ashwin Nair <janair@amd.com>
> Fixes: d29e744c7167 ("perf/x86: Relax privilege filter restriction on AMD IBS")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

Tested-by: Jayapal Ashwin Nair <jayapalashwin.nair@amd.com>

