Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA47146D76;
	Tue,  4 Jun 2024 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508478; cv=fail; b=T2AXRl3bpVUDMud9SHY+jDSoeuWBd1NDPL2lzerihNj4HcHh3g1W5OHqlpYn2qT23osT/0/NLAUERVvBJNyWDBcXZrSpRgv0gSbFf7Vkl1f9RFHaniV7z7Isu/SrhYImrqlVTLxhxsu3cXi4Jf4iO6LfC+yo9t5D9POQSqAW8NI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508478; c=relaxed/simple;
	bh=7mq54cJXrsthM30cTFL4PNp8Bn3RxaV9XAMNgmMuJ4U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qfmfaCD6EBH2+6Qgr7ZXTVpQm4LvvLqFB9NxO8DIzJ4prFbaWD06XXLXtPEeJRj0hSwsPeIAsfzbaQAaqlQNVrc0F53Q8U2TCDN7V4S5+5IgCN+wGfInVYdWanbJrroPCacyF6lE78VNRjdYfJ70LJl3G0CbYbkYuBIeXIb4ZZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YfLim3mR; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YfLim3mR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7FRCghoowalXUIT3jppojq73KrtB/hnOzBpFTA5r6GKdGe1ktTpAT2/WsFIwnbwfTqDuUhOlqKUAllllf0vWj8m2GwdSE+C/wNTUthGS7oRwo3A2XRXMZyZGWqSIDp+y4CMwiKW8iy/A1rHvQ02rH8QceChCRjWeKkAp1L0yZRQ4lspmmVo9o0ZkcRETXIMbDjNYBKCQcTUiyr6ZCc5VSA0VptoizNwYXVb/tfA7J+mmJYuXiada4dATXK7uH7czzsYmoogul4ytrXAMkwHEqvBjw9aVhw/nD3bFQTmm0rxdeulKtBZaSqDhAZjMrhTsBB0hFkf/hFz3LTsAuw9jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mq54cJXrsthM30cTFL4PNp8Bn3RxaV9XAMNgmMuJ4U=;
 b=PV4iqcGaqVFK9DBDZ0fKZ+VI3O3FRCol7HMx2neV0H85XDLk3owgVlpJP8AgCZeJCWmrLci2vq6BHDqKdcS5y9QTYy0USEXk6NJYD460E4w41Pi12rbm2ENnY+qAVO1ZuWus47Cp6CXknszhPmpq6zfvPMjfjgBZNBIyISxw5bw8a1je9GWgKOrwaofn3xL8RkZZIjL3vJMV/F3SDnFltPVQVaa929Uh/g9Kk7bmVBbbQjQtnb/iW96wsoTeK3y7W02BKhGe56PBZF0Fu11TeYdDF7ekN8sRVVw76P62oau0PNudUoAswCEWj8ifNB7VwhlJ/DrhtApaJCrlAS3+PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mq54cJXrsthM30cTFL4PNp8Bn3RxaV9XAMNgmMuJ4U=;
 b=YfLim3mRSebIJ9hEPzQ8Aw2bR9F7vyAN/eKImhSHl+44egai5E498A0563TGrZedvbs70vSkHmBpir3G0Gu3w8QQPJqbejs/YJ6sq7nwYct6RciNAsy3I8FGoxFFnmtYZSaOlszuL8Iq9K8IIzBEb6ngaAt9EIR6PYudlJNLS+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 13:41:12 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.7633.018; Tue, 4 Jun 2024
 13:41:12 +0000
Message-ID: <17bfa7c1-43b7-4b25-a8cf-eb6d3797df5a@amd.com>
Date: Tue, 4 Jun 2024 19:10:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd: check event before enable to avoid GPF
To: George Kennedy <george.kennedy@oracle.com>
Cc: harshit.m.mogalapalli@oracle.com, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 ravi.bangoria@amd.com
References: <1716990659-2427-1-git-send-email-george.kennedy@oracle.com>
 <75f6aba1-8ed6-4ef8-8811-de40ae40be90@amd.com>
 <1e14ca4b-6e3e-4d57-acec-bc3ee2bed6ed@oracle.com>
 <0494aedf-9759-4427-a7f3-39a91bd5771d@oracle.com>
 <3ec1cb26-c889-45ab-b8cc-92f933a2b5d1@amd.com>
 <7b27a039-ddb9-4beb-a1b4-ba2b74a3043e@oracle.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <7b27a039-ddb9-4beb-a1b4-ba2b74a3043e@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::10) To DS0PR12MB6584.namprd12.prod.outlook.com
 (2603:10b6:8:d0::6)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MW5PR12MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: 12321ab3-3a44-4360-5ffd-08dc849bfefd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzhtNkZ0UWVVZlhndjdQM3JhT0pWR3RHYjVvUjF3SnhDZDkxQXNmZWh0M1Bq?=
 =?utf-8?B?UlNpQ2NsV2gyTW44NkY4eGxrd1o2MW8ybmpDeFlYcDY2QVhuKytja1N5bEli?=
 =?utf-8?B?dzVCbkRiMTg2RmhLUVBYRUN2amErMUVXUWhZcVQ4RXRQSllOdDBhdnpCT1Fj?=
 =?utf-8?B?TEkwWTBKSjJRQW9DcW5xbFh0RUtPTTYrM3FHeUd1ZWpDSG9iMzIyNVQyVkN6?=
 =?utf-8?B?TTRteitTZGFoVC9JUzNLSmxYZTRwWkJPSXhjMHBSanJ0TVdZZ0FkS3VBQkp5?=
 =?utf-8?B?R05oeU1QZkJWMldQZm5pQVBzYTA2QTREWDBydkxYc2FJaWoyZ0w2Wmo1NUlh?=
 =?utf-8?B?K3ZVSlpjR1NzMmxzMVl3NXpNc3hlSFBacktPRjVwTFJLdEEzYmVkK2lIU25D?=
 =?utf-8?B?a0dqT0thRDVFZ1ZjdWJ4NlZPdzhGRFRmK3hFTDQ5L1E3QURmTTgvcmJLNWdL?=
 =?utf-8?B?RThBNVl1QndickVLQU9YVTZYeGJYSkxmbnY2UXE1MjNFdzJlekM1WjBqZFZs?=
 =?utf-8?B?WE9YbUh3d2pjUEJ4SnNQRjNpVVVVRDRCUGVWTUY4TmtyZURScW5ydDJjbUhG?=
 =?utf-8?B?VGhBaTlZeU80UGVpQjBhZlh3blI0OWJNZXA4OVp3ZGkybSt2cU1JQ2l3NkFz?=
 =?utf-8?B?dW1NVFlIWGx0WTV0WTQ5SXcrenFHeDJraGZwbjZiQzZxL3V2R2VCNStnSmUy?=
 =?utf-8?B?Wk40Ym9KdDhFN1hKVlVIMW9JNm5laSs2NjJzOGZGUmNRMlpWZGVVdVRKY0R6?=
 =?utf-8?B?SVFOQXAxYmpveHdheU4wYndvS2Jjc0hnVFZ3eS9USE9xVy9UbWZNRFlSNklG?=
 =?utf-8?B?MTNWQlg4OURLK1llUENXZ25zSUtEUHN4cG5TRDRqYlFOMUZrQXF1dytuNVRS?=
 =?utf-8?B?bVh6YTNqckNjaVZ0eGFTelNJNzBFMXdleU10QktjYWR2UTF2WlljdkU3RVE3?=
 =?utf-8?B?NndIYXhBaEhYZjRNU0FYQTZKb1poODJyelU2WDkvMnQ3SlBYb3J2Tk8vYUhu?=
 =?utf-8?B?RkpuSDZZdnNDRFRMK01nMUJtWkFLNHhXUGFaYU9yaVdZb20yb3hGMGZ4RWdX?=
 =?utf-8?B?bjZMK3dxUUNxaE1HZ1BIbUFELzJWY3hiUk9iV0JwdTRJb1lUd2N0d3hESTBG?=
 =?utf-8?B?eDZlNE9zWTc5dmc5bU9iY2h2TVFzV3daY2Z3cEFzaSthSWFlbU1hQ2h0bGNx?=
 =?utf-8?B?KzlpNnVCT3EvR2h6bEhOT1R4cHBpQ3BuUSs3aTU1SnVLdWV5Y2NhVitpUSty?=
 =?utf-8?B?YzJEMzE2OUQrck1UUjVEYnFPd0ZYcDFFR2xOS3ErQVBBQlVVZEdFYWN5eFF6?=
 =?utf-8?B?ZFN1Yys1anVwMWpTZmRTQ1cxOHQ0QU9kUWVEZkRydmhCcG4wOWljb0NFdWdH?=
 =?utf-8?B?VGsyQmJIU1RDdjBJUmc5TTkydnArYTJHR0JMTmxZTHZlZ2xtUTVjUDdXd2xm?=
 =?utf-8?B?a3M0UFhDdnJxeHVIcm9DbjlvTDZHYzhkL1IxV21LbjF5R2pLL0NsVWVtVERq?=
 =?utf-8?B?U1hXQTM3cGtZTXFOMTIrZFIzQmFPYk1xOHdDSG01bUNoR0N2SWxWUUd3d2Rm?=
 =?utf-8?B?WDhPVmllbG9ML2hRRkVqL08rRmR5WGtvaS8vQThCaTI5MGR3Smc3aFN3dk93?=
 =?utf-8?Q?Kskpd42TTa6ACm2jmEUzSxlUAz3LhgEmRGNjy3S+lPrc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azJEZXhxUGNhRnovaGZzck5FL28ydEYrVkg2VGJ6N0JKVUlXL0FLbHM5TFpr?=
 =?utf-8?B?QVpHa1VEYXJTRktRUW9CZmdtK2N4c1YxK3dWY1FJczJaZlRmTm1ZUlNwYUpm?=
 =?utf-8?B?QmIrWmNMejdJUEhidjd5cU94SEpHK2lTR0FWa1dkRFl3bGZKaXo3RXgxOVAz?=
 =?utf-8?B?Nno3S0hZcU9JYytrRVVCS0U4Q3BzaU1jYjRNNzlac0ZCSUZrL0RqSUxvaldK?=
 =?utf-8?B?RUR4V3h6Q1pYWG81c0N4QjRyYTl3bGNjR2s0cWNVRFp1bVlIb2kzaExzZ2FO?=
 =?utf-8?B?N1RzRXd5dHFEU2pJZllpMCtkeXZoSEhUc3FSOGRxRkdiVjludzhJZjlmS3k4?=
 =?utf-8?B?VFV1amdaM1VsYXk2T24zbGdtRHZjTDdOTGMwL0N4cDV5eldacGFzdEVLeUFV?=
 =?utf-8?B?MXArem13WDhCd3pXcHErV1V1N1M2a3U0OVhFbmhqVE14d1Q5blh0anB2N1Rh?=
 =?utf-8?B?TXhnL0pZanBWeXRsVVErU3docHU5eWVaOTVPeG5ib0laZHRBYjFVSVpISU5G?=
 =?utf-8?B?OUZDeHdKQXF3c3VWWVoxK0tHdFg2RDFqWFg5Q2dzYld4UExtd0xRYkRFd1RE?=
 =?utf-8?B?N25jSFp1UXErVnQyanV4ZWhmRmlIcVZ3d1hlOERlTER5eTc2N25jTWxJeEVh?=
 =?utf-8?B?R2RiNkFINE1qV0NRV000VGtSaWI0a1BIbVd4TS8yVTN2Nldma1RwenBGNmdN?=
 =?utf-8?B?NG1SYUphUFFrZlBqcXUxWlAzK3h1OHZRZXgyeEowazFFVEdERzQxVVRxVXVI?=
 =?utf-8?B?UWxXNXlSZHBPMGtXRkRKUXVtczRadEtTTU55cVZUS3pmRjV5U1RoT0R5d1Jy?=
 =?utf-8?B?bUZoNkIrTDZMVUJRZ3VSL2RmbVo1a3dRKyttTXpQS2tVUTBiR3JmbFZJWmxh?=
 =?utf-8?B?ZUFWeThYdnNVeTJ1QzExa3JiOVRGYnJEVlE2VzBHNVc0aVJXZDN2amZiQVNM?=
 =?utf-8?B?ekpqWE5wRjg3amw1OGNzWU5oRlE3YmM1MG16eUhveDhBZGR5VEdkSTR0dWUx?=
 =?utf-8?B?VXRibWMvdzZDWVM5a1VaNVdPL05TY0VuTi9Yd1lTQkRZYkl0L0hrZDVmcERa?=
 =?utf-8?B?MWxGdVpkMHNYZmUrRmJUVTc5Vml2RzZVbUZURzVPTGJQaW96QTQ3VDBoOTJt?=
 =?utf-8?B?MmVXQnFoa2ZWNmZQZklWUWdkVVlEVWR4TDZPd0VQRXJyWVd6bEdaZjVpczgy?=
 =?utf-8?B?dHEvOFl3dW11Y3MvUUdjTWxPc2Q5UUhFaDZsVDZYM1U0MHAwaW1qbnJoSnVr?=
 =?utf-8?B?eisrK28vK2xmRy9yY0lORWFXV0lLbEZsOW5PM1lsTzl0MjJUUEV3NTByN0dW?=
 =?utf-8?B?VjgwSG15ZFl1R29GVGxsaTViR1FNdHBPUkJDc2ZLU0tJN2NpUmxZdXJtanUz?=
 =?utf-8?B?L2pBTEhvN1BOMU1DRHRKR2VWcHBHMDJKcG5wS3p0UlVFU2RDUXpWUUZ2TUUw?=
 =?utf-8?B?bGY1VDZxbDdBcUlXZVhNcEpzM0NCcHp1djFHQVN4allhN2NnV1NVbXdoUHBo?=
 =?utf-8?B?Q0ttVjVXV25lcGxTcXJXRkxJZlhUSFYxc0JockNLTnorUHFFNzMzTUtWYllU?=
 =?utf-8?B?cEZlbzYxRE1PeVk5ckNSUWhtV25BcUNaU2tBYkdZNWlybEs2VDNWMGdRdncy?=
 =?utf-8?B?TWVMWjlZM0ZMblB4Wi9yVzEzQVRQRUc0eTFtRXg4c0RkNXk4MnE3bit3N2hR?=
 =?utf-8?B?ZnZHVkV4alh6WlR2eGRuMjFoaWZibFZSN0hSa1VIS1hXRTJWYWVaaGVZK0ow?=
 =?utf-8?B?VEFvV1BRU3Q3WTUwcVpScFRWdlM4ZkN3dnE2aUJZWVlwcXVRUWxvMVJ0VjFE?=
 =?utf-8?B?dkdoRHpZVzUvdEdXR3k1NVBzYjdZT0R4KzVZRFZOMGdiU1RyUnc3aTJhS3Jk?=
 =?utf-8?B?TG1Vd1IxT2VYa01IZVVXQmRhQSs2ajFCYlV0SVpuRFNlZStQUlkyVG1LaW4w?=
 =?utf-8?B?VllMSVJDSVZOdXhEOWJZUTAvN1JMTDJ2cmtacGFCbGFnOVYrZFplT1g2ZzlT?=
 =?utf-8?B?MU5pVVcyRTgwTExadGRCT1ZWODFrU3JGYnNPUXFCRmppZFVQZTRVbXhubCtk?=
 =?utf-8?B?V2FmR2NIallBZlZ5YWFsdkQ2RFZYUFF3ZUdKVWxRK2U3U3hGbDNXVnRJd2xq?=
 =?utf-8?Q?wVA86J8mp6G2jRw/G9pwMpDQ6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12321ab3-3a44-4360-5ffd-08dc849bfefd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6584.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 13:41:12.7676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9P+6RuVBFq6yupOWYrUsAQkRtQigTJ/7LeaeYdFdj8M8pXrP/6Ap8T3Tb4mjkC52Q/CYl1wwVZydW+RyDJhbAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681

> On 6/4/2024 9:16 AM, Ravi Bangoria wrote:
>>>>>> Events can be deleted and the entry can be NULL.
>>>>> Can you please also explain "how".
>>>> It looks like x86_pmu_stop() is clearing the bit in active_mask and setting the events entry to NULL (and doing it in the correct order) for the same events index that amd_pmu_enable_all() is trying to enable.
>>>>>> Check event for NULL in amd_pmu_enable_all() before enable to avoid a GPF.
>>>>>> This appears to be an AMD only issue.
>>>>>>
>>>>>> Syzkaller reported a GPF in amd_pmu_enable_all.
>>>>> Can you please provide a bug report link? Also, any reproducer?
>>>> The Syzkaller reproducer can be found in this link:
>>>> https://lore.kernel.org/netdev/CAMt6jhyec7-TSFpr3F+_ikjpu39WV3jnCBBGwpzpBrPx55w20g@mail.gmail.com/T/#u
>>>>>> @@ -760,7 +760,8 @@ static void amd_pmu_enable_all(int added)
>>>>>>            if (!test_bit(idx, cpuc->active_mask))
>>>>>>                continue;
>>>>>>    -        amd_pmu_enable_event(cpuc->events[idx]);
>>>>>> +        if (cpuc->events[idx])
>>>>>> +            amd_pmu_enable_event(cpuc->events[idx]);
>>>>> What if cpuc->events[idx] becomes NULL after if (cpuc->events[idx]) but
>>>>> before amd_pmu_enable_event(cpuc->events[idx])?
>>>> Good question, but the crash has not reproduced with the proposed fix in hours of testing. It usually reproduces within minutes without the fix.
>>> Also, a similar fix is done in __intel_pmu_enable_all() in arch/x86/events/intel/core.c except that a WARN_ON_ONCE is done as well.
>>> See: https://elixir.bootlin.com/linux/v6.10-rc1/source/arch/x86/events/intel/core.c#L2256
>> There are subtle differences between Intel and AMD pmu implementation.
>> __intel_pmu_enable_all() enables all event with single WRMSR whereas
>> amd_pmu_enable_all() loops over each PMC and enables it individually.
>>
>> The WARN_ON_ONCE() is important because it will warn about potential
>> sw bug somewhere else.
> We could add a similar WARN_ON_ONCE() to the proposed patch.

Sure, that would help in future. But for current splat, can you please
try to rootcause the underlying race condition?

Thanks,
Ravi
