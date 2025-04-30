Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F852DC779;
	Wed, 30 Apr 2025 06:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745994994; cv=fail; b=qj5do9qsaJUpeiwHH6REzlyFRK2btNRmRXZyzEN+6S6eNusQHQEVQRj1vjsyq9ruMVrw0lVdspAJ1cMiP4Fq7FXfmgrAjjp3b/w+faLCJ58MgQ6vD4W4Y7k567VSsCjk69rp8NgbXEYHU51/j5AAQrP83EYLkyyOxK+TV/9NL+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745994994; c=relaxed/simple;
	bh=ZZy1hzVFL7vFTFk5yiwQfUR558rGQQ68/g0pitHgZvc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dgDrHGu78ROly3ZzDH19XO2XjNmU/3szpewYfnUwcbSQVmk2aXiggPrXUiSr+phWGEzre1rwU7zQdl6TMREwZJ3aFjRoAxaBEScBbNXegivY/dm9OhQvamtLXQS65VlREuumwSLwROEnKZ5/gW5c7HnozMDzqMN1yNfgMAE5CL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CmJeuEh/; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CmJeuEh/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfDEhmVgJC0uR7ZEClNnevX2aM3T5tOJwRgJQTDr9VkiKPymsudz6kImVNFuqX4FZGCECsBMEkzEYns/EyxyiHkVgC/J39ccLst0IN8yC8dzdWHrfD4DgfqDLOmvAV8HvO06klsJn72ANQuxaZ/xv19KeomH3rZAAmkYInCfoLz98+HmStghZ/BF+tHErVZFQvK9zJDfH5eOQevyH1s3c1FiKCdRBlbebd27zSjl5KQvoPComL0HcBBJjSi5rY5rHh7I59fSX01aa2CEvwu6t/RfHtY0h0FQoEFlrx5IJoGi1Hvb7ZN8TRCejvqozER9NheCQH4vadKobhh3drJ5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOss4+qACsy6SHHJUhgo0eQsQ+hHPuRhRKnrkHpCOWY=;
 b=qqwUaGh5MPscXji8IA7BhwbNXiZZ5QCzSBpFx11rUZ9pt8mDwv0SXq5QDOto447looh38OVIXUHMVYEguDBcuOb576ey6PGxpCMZU24BvE5ZmteenHYtU27uT/KnYhoyQm8k7Ww6tMHn/hhxvIX3mErCMuiTkC5Gt8ryIXGLbruvqw8EB0lnoTN8DAPOOTmCIy9aXMof4nFDsUrKxbzJrzf4wE/vG01eqNYr059Dtqij1S4IA+EeXvY+48W5DZU4jtRwj8Kw1QBii9rbrUsGackc7au3grQrgqIhEuKekUZATSlT7iK00XllKhQe/rABVG2F/NO7VubgZ4tQbCcvYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOss4+qACsy6SHHJUhgo0eQsQ+hHPuRhRKnrkHpCOWY=;
 b=CmJeuEh/5X/7KvByux4/XC1YuCWHkoSdIHa9ZxWvoesvODFgyk5vR4qcuPecrAkv62KqwYtkEgIcDLpIOn+KT9SBPbi2OtsZX7ahBU4beaSoNhG623yimG8pUvbGZhhJJ/4P6kNNFKinAx45TN8XpXJruA6+f7uA0Vc5wW7eIoc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 06:36:29 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%7]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 06:36:29 +0000
Message-ID: <38f35b60-df8b-48a0-a59a-560bed340a6e@amd.com>
Date: Wed, 30 Apr 2025 12:06:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] perf test amd ibs: Add sample period unit test
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Joe Mario <jmario@redhat.com>,
 Stephane Eranian <eranian@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Santosh Shukla <santosh.shukla@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das
 <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250429035938.1301-1-ravi.bangoria@amd.com>
 <20250429035938.1301-5-ravi.bangoria@amd.com> <aBE8raTOCVZLfw7J@x1>
 <aBF5UWrxvYgbnxde@x1>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <aBF5UWrxvYgbnxde@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::19) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d6930d0-7a7d-449b-2a57-08dd87b156de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ck9LM3NZc1VXdzk3NkhWMFIreldyazhuTWhwa05JYVRxV2E3Wk1BVlpFaURk?=
 =?utf-8?B?M2pXN1hxZ2IyZDBPcFlMZHFiRVBlUWV5RnEwZWM3eHlqOW5IN2dlNlJBTHox?=
 =?utf-8?B?ZlIrQldVOTdYYjdGYjdJdGFZS2ZPYll3Q0dWcDZ1MmlIb2tIQ1k4dXBjVS9T?=
 =?utf-8?B?bXdKamtQbDZ0MVM3ZEhRaUNSSkFVRWpsV09sQTUvK2ZqZTNEVnRtTkFRbSs5?=
 =?utf-8?B?SldLbkV1cUJOcnB5UlZTVGphNW5Icnkya255aUFIWFA0SVhDTXFpYlZxdDRO?=
 =?utf-8?B?RzU1NnJ6MWdBL3dpdnlsK1A1RFRSaVVoTFdDTXZnbUtCZmdFSVdWNUxZR3NW?=
 =?utf-8?B?RXorZHZKNkhTbnM5Ym55YWxxRFVBS2RzdkhJdHBYSEdIdk9NSW1nL0g4bVRE?=
 =?utf-8?B?TDRyT2h5bndKNS9YZVFaWTk5d2Z6VW16OE9Bd3h0SHdYV3dWZWl0UjBMVHRh?=
 =?utf-8?B?azVUbDk0ZlFXTFd5ZDRyM1hOZ09aK1NKMFJ1MjhlaUxkeUprZ0NrZEJLb085?=
 =?utf-8?B?UGpLWU0zeEt6SUREeTNSSFVIMFEzdE1CL2FRaWNUTnJNMUJ2T0U5SHlYaVdK?=
 =?utf-8?B?a2pZNDZkUXpFQlNKRHNZTXdjdDJ1YWVKdmdrdE9XNHNsZXZ1TzZxWUp2YkJl?=
 =?utf-8?B?ZnBrQVdLcWRWeHpndHlQenYvMndyNHVXOWJwM0YrT0hQOHdhUkNKc3Q4bEdY?=
 =?utf-8?B?MjZzazRmVjkzSmZjQjdnb1lEQWdtdm5KTnM1S0NYZGdyamk3Vk91Rkk3UnNC?=
 =?utf-8?B?b2gzYW91TWthTnhRYkd5elFRUHlZY3c4Mmo1TUxJSG1sTFIyUGx2Y2ZSZGkr?=
 =?utf-8?B?ek0xWnhkak80UTBHRWNMV3VTMWwrcXBjWXNLNFdaeFZ0NXN5ZWc2UjVCUi93?=
 =?utf-8?B?ZUNiK1lJdWJpNkllMTkxTWZORW5TN3NqM0QxcXcrWGpQYnhnSHcxaFBXL1Bs?=
 =?utf-8?B?SC9VS2RHN2RMbEJwaW1sdnU3aUR2TnJHR1hpaUVLNk9IUGlxQXNRdDQxMnE5?=
 =?utf-8?B?V1hNMS84cHVWZjJRVTE0TzFaazBNNVk1eW56Vkh6dTkzQ21XV1VTMUY5T3Ru?=
 =?utf-8?B?R0VDSi9JV01Rc3B5K1hoSURyUG9CL0ZiT1YrME1QZm5iTjRPTVBFYlEzWTBk?=
 =?utf-8?B?YjEwTC82VmhIb1NIYlc0c1N2VWswQlBWWU8yaEhMRlI5OTY2R1N5ZzZ1QXN6?=
 =?utf-8?B?cHVscHNuNDhDa1l1cXJ4UGNOUEwvRmw3K3IxSVNsSHdBcE5jVFpBUWVnY1lp?=
 =?utf-8?B?RTRzTXE5dTNTTFpCYlBlMUtSZjJuZ2hlQk5DSFQyc29QR3pDTTVJeVdHaUQ3?=
 =?utf-8?B?MFJjRFVnYUYwWHVQQlJZWGhWU0ljSjZCVnVtTWJXNE1jWEpETk1GcldobHpi?=
 =?utf-8?B?VS9CaGxMbEhNeDd6c3U1ekdna2JZRWRzUkRzRjFtb00rR2E2NGkveHFjQkNN?=
 =?utf-8?B?QXJHZnRzZ0FKWVA4QUMzcndET1hLTHFKRXROeHprRVEwRUZWMisvZ3FzMllF?=
 =?utf-8?B?UGdqeVlFVTZQYUtrVjFqNXJva1ZMU1V3R3pkYXFTZVVTbUZlby9xZVFKaHRJ?=
 =?utf-8?B?bmdURDNUMUllSTZLN21NU3k4SjBmWnNHOEQ3SWNOeHlWcU4yMDJIREVQbFR6?=
 =?utf-8?B?ZnA4ZFVLcDBuTnhMNzRoVFJUYkI2ZEdLMnJpalhVRU9GUU42K0Q3aE8rUUgx?=
 =?utf-8?B?dXVqOUxFRmdxWVZoYzVzejJZRlFCbktTTWhxbW1SbUk3RWl5WW1MRjRlb3NR?=
 =?utf-8?B?cUZMZW5KS1UyaUFvb1FjT3hibVpGV3NQTnI2Z2dkWWVORUlieXR1RGEwSkUy?=
 =?utf-8?B?QStwZmFjdnE4RTV1UktUaDY5VWhWVFg5RmxOTVpmSDAwdXJhMlloK08vN3o0?=
 =?utf-8?B?RnhhVFVIUU82OXg2M0FjVitaenZ5cC9rd0VKNkRrUGs3eW9oS3dvUFNMQjA5?=
 =?utf-8?Q?ELpt5LyVaXA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFh2ZENoaFZ0VXRYRzVocG1GTXBWcXA4eHVtaUVEN3VhR0lMV2V2VE9kcENq?=
 =?utf-8?B?Vk81V1AyeUI2cVh4NSsrU3graUNUenhUZVQ4bi9KRTNJSFNjWU9Lb3pMdDln?=
 =?utf-8?B?VkNRWDY2K2g2c2d3REZCbkFLZHJBTnJOZ1ZtK1FXOGJFUjNXa1IwcGN5OFJ3?=
 =?utf-8?B?QVRYZElSS0dtR0pmbzBtRFVtby9LNWJ5K0swSkNVOTRvRDdtb01veFF6bG1W?=
 =?utf-8?B?US85Z21BcTMvbmljSElyMmRWS2R0cFZFbnFSdmo0NEszcmwyQ3E2cmZQR2Fj?=
 =?utf-8?B?NEwzUlNCaUJVV3hNYXJML0lnL0FDUHdrK2JjVk5aeDB2VXNCTStpUnlBRXY4?=
 =?utf-8?B?YnZ0U2RxTHFRdm9xT0h1NUNmbjdNTHZHWlRuZ3R0NTBFVGZWaU0wNjdjQnZk?=
 =?utf-8?B?NE1LdzhWaE5qTGJxdndJMGFQVUZSc1FmZXU1dFM4NGx2ekxTWmwvbkU1ckJV?=
 =?utf-8?B?b25zbTg2bmdWNzRTbHpITXFRMjVyUGZnWkhra2pIbngxSWJaazkwL3FuWHVt?=
 =?utf-8?B?Smw3TVN2RXFuUHNTd1doWXRjR3J5U2s1Z3F1V1dDWUMxZVQwTkZvTDQ4ZVgv?=
 =?utf-8?B?ZlpvREJ4Zk1PdmpxZFZYRFRaaG9BWUE2MlI0akFPWXIyU2M0S0VNWHRuZjFr?=
 =?utf-8?B?bDV0SUJKblNFVmozQXhsYy80empHRStEdWw3ZDhITzVpaUFLTlBubnhNWmRh?=
 =?utf-8?B?TFZSWS9ubHRaWTkwdncrd2VhMGUxQnBxQ0lXVlh3dkM3T0hsZ3dQNFZsbmNR?=
 =?utf-8?B?ZG9SMWhlUWVJUXdsRTkybnN1WVFmYzRWSkQyM09yVjY5bTNzUEsrdVduWXlZ?=
 =?utf-8?B?Q1pjWEZabDR0dnNqRGhycTRnVDhhRk1aL1RNcTVBVXBPM3h4RllLb3dxb1A5?=
 =?utf-8?B?S2JCcCtvNnBBVnZlMkltTjZWZUtURVFBb0U4TDB2VFpKOVA1SWR0cE5TRXMy?=
 =?utf-8?B?VTkwNnUxWnEyR1o0b0xqUHQ3NUU4Y2ZTQ1B2Z3czTi9BN2d4OHhNVFVudll6?=
 =?utf-8?B?VkFPUytSbnBUQWhuaVlKM1hiS2NFQ0U1MjRUcGhYOSsxNElsSGFsSkZrMFBa?=
 =?utf-8?B?RUU1dTY3dzMzWmx3RFdSNUFEMk95cVBWbXQrU0dnNFY1ZFNOZ3BvNW1aWEgy?=
 =?utf-8?B?b0V0RW82UU9QUm5kRkZVUVFuTUh5VGxBaUczS2hhSUVneUFHbDFGczkyZUtO?=
 =?utf-8?B?ZWt0WmcyVXVMaHJ3ak43UEpXQ2xZOVFUSzhSVCtQTmtIM04wYTZEU3pjYjZR?=
 =?utf-8?B?TTBQTTVjWWJlLzFrUUdyVW1PbjFvL0kxZE5BblNyc28rV2dWUEV2TGY5L0t2?=
 =?utf-8?B?dWo2YkxtL0ZwT3VBZFUzdWtDVlp1em9CTE5MZ0xvWDFudGhDYjdJekZnU2hO?=
 =?utf-8?B?VnBaVHREVStsQTE2TVM0bzJBRzNiVk5mNnRKTjZYZnFxcGZPdFlhKzJxV3Jh?=
 =?utf-8?B?TFFRUWxPcnRDSmZhOHZybnNBL0VlbEZLbWMvR2lDU2RrUzhXQUpVRUxNc1ZX?=
 =?utf-8?B?cFBCUFY5KzhFQjNhSWxkNVRIeHgzamlRVmVDVGltUG9uaFp1Q3VCbkptcjky?=
 =?utf-8?B?WjZSdXZLek1oTlkzM0VRM3F3dXcrMzRFU2gyYllEVEtUb0ZMV1V3SW5sd1pa?=
 =?utf-8?B?TzhlYW14b3VzV1M5WkdKckM5NkZuRVRwYm5sOTZJMDdEbkFxUGdIa1gzaDU5?=
 =?utf-8?B?Zy9uRWYxdC9sU2xOYlZWTGMycFpsZFdxazd6M3hxb1U5dW5uVSt0VzVTY1F2?=
 =?utf-8?B?cGNmMStrUkRGdCs3c0o4R2l2c2UzSkZtZjJhK25zay9DR0pEeTNONEY0c0Fn?=
 =?utf-8?B?QmpqZzlQYUp1b1E5OUFSZ2JmaWp5KzlOWHJDVWp4RHNjOE5kUy82RmNOd0J4?=
 =?utf-8?B?SFc5Zk5NbncvU2VGSXVBYzYvTDE4WlQ1c3VZVDZ3WEdNUVR2WVhrYzNQOGZM?=
 =?utf-8?B?VDNVSHd1NTYzSmxjclRsSy9naklQL21JV1JDbkNpWnZ2ak9kMmI2TkdUMFd1?=
 =?utf-8?B?VWdwSDJRSjU1QXdlbDlXMW1NRFFwYmFKOVBjb2JHY096TjVIcW9JMzhGeTFJ?=
 =?utf-8?B?S3VGU0pJTklIa2lnV0llMk52Vy9aVzdKYjE5WnRVeXhCenNyZ3orazlvbEtU?=
 =?utf-8?Q?TpvJzjrDlXQzBYsOTVUQ7pDcA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6930d0-7a7d-449b-2a57-08dd87b156de
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 06:36:29.6776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgA0Wrv7CTr40XDqycuHPMYYBT22CWMWAO0QvpeWQexXlXy7K6xiF7Jltc+ydWlTy6dCKDrRojhlXmUpb0YybQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139

> Another issue when building with clang on musl:
> 
> arch/x86/tests/amd-ibs-period.c:81:3: error: no matching function for call to 'memcpy'
>                 memcpy(func, insn1, sizeof(insn1));
>                 ^~~~~~
> /usr/include/string.h:27:7: note: candidate function not viable: no known conversion from 'int (*)(void)' to 'void *' for 1st argument
> void *memcpy (void *__restrict, const void *__restrict, size_t);
>       ^
> /usr/include/fortify/string.h:40:27: note: candidate function not viable: no known conversion from 'int (*)(void)' to 'void *const' for 1st argument
> _FORTIFY_FN(memcpy) void *memcpy(void * _FORTIFY_POS0 __od,
>                           ^
> arch/x86/tests/amd-ibs-period.c:87:3: error: no matching function for call to 'memcpy'
>                 memcpy(func, insn2, sizeof(insn2));
>                 ^~~~~~
> /usr/include/string.h:27:7: note: candidate function not viable: no known conversion from 'int (*)(void)' to 'void *' for 1st argument
> void *memcpy (void *__restrict, const void *__restrict, size_t);
>       ^
> /usr/include/fortify/string.h:40:27: note: candidate function not viable: no known conversion from 'int (*)(void)' to 'void *const' for 1st argument
> _FORTIFY_FN(memcpy) void *memcpy(void * _FORTIFY_POS0 __od,
>                           ^
> 2 errors generated.
>   CC      /tmp/build/perf/ui/browsers/header.o
>   CC      /tmp/build/perf/arch/x86/util/mem-events.o
> 
> Adding the patch below cures it, still need to test on a Zen 5 system.

Thanks for the fix. Looks good.

Ravi
