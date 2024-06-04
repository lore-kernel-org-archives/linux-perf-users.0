Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A98D1459E9;
	Tue,  4 Jun 2024 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717506174; cv=fail; b=HQf0sDtybWVdFU3nP+1JpmOhEx4HbectSBMox2vHSSxFq3/KLgMw2Dn5IcFXoyBLN3qgSFxCceUMsxVYBBbJuLlO52rg4X1AnLPEPu6lOo3KatAefyxDCwwvjfLWU0s6apXCcuFqfQOIWydw5QgtmU1YoVizAaUf3ljg5QzyujM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717506174; c=relaxed/simple;
	bh=pmLHLQvPVrY1snF8h9hTPtxZbUc3o/U79T6K61mV/iE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D6gz8KEW+vQYf8W06vsbGLRIb969eRDpXybG4DnbDNQvEsmMQfTQwuwz9ZDtRZV8cPCNXlbcF5WIpZnWiC0H/mx3ImPsKqzs1L7Ozh/4Qu50uEffOFwSN8NLAycL9aiGsjSMJ9KpuCf5rh4IYqpkzPrOW273istNEpS46jGAOvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MtB8JJJf; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MtB8JJJf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gnxl3qL79gcKOmAEhvC5QtDVsegSPTYRXTiAyvVoG/wvkEhvET17d+Cl32uy8GWa7IruivA4wZgytEboLfo4IpRzxsxpdBPk4c70M85S/zXXVmVrPSDfFFWIhc0vyVaiYAxIrE4dZEoLvRtBxq9NqsbrcmLnqSVzX3bljh6+IhapGheuRnnvsJdesI7ut7MEp0Wv8xibby2GenQuAaTR9AM5rTmDXMvXrNgL8/l+JkU+CtzOT/GDXOSP+B05gRDVR4KNqMEPqjDpexMBaCFLUejqbfGSNyPTgVJY8sU928o2qE3jTm6zK4sF8Jmdx7vfVyxD78Lh+B1EdZOm+2la4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=le/Zf6WypGtAX71xcrhZHhBEFxsHC+m+vQVaT71lrKU=;
 b=dMVt1DbpdL3NbMDslMSuBoF3WRneeiU/TvCMp82FZ7GyEKSXBEv32oCuoTMfiAy4L9c8g+eCAHkEP09SnLNR6R5YSD5eYpjCIxLxh0O3AQ9rlJjpU+P5AIVsAGBGpV0UbEBj0ivM4Z1XMVGcmFUNXtJNu7ZDHdESBQmEJbAa9OACduMFYl9hznpZqfQ0IZrBphgnhwTJ+4lAV4+EgeRUvrU35m8c/j7rNJgKM+Q1uNA9j4iGIpb67I1RnxFytx9pFZkb1YLSE0bD6vZNMh7RyXAT9sYMYtYht0EkXs9CKMQoPdoNi+WhdnX8xMX69DegNUHzVO9Kjby3A6xoyc8YHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=le/Zf6WypGtAX71xcrhZHhBEFxsHC+m+vQVaT71lrKU=;
 b=MtB8JJJfjmvrxuqGPYJYcTPiVuoOOS89TqnZyHzc1NVO1LRS8ysUsKukuxGKnCJSkCXoGBwKoXHYw9AQi5/85MW+jxiDo2cWi0RkMv/7QzbKvvoFMDj+waj0QIJAZVHQ+64/f4CoeRMgFlfwIyMnRkEzt5elKU7bcWVt7sTbPiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 13:02:48 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.7633.018; Tue, 4 Jun 2024
 13:02:48 +0000
Message-ID: <fe76301e-9835-4b7a-9da4-fceb372d9cbf@amd.com>
Date: Tue, 4 Jun 2024 18:32:36 +0530
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
 <61e23449-d77e-4f2c-929c-1cf0f32832a8@amd.com>
 <57bcb95d-8a1c-4903-af8c-b4b08d1270c3@oracle.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <57bcb95d-8a1c-4903-af8c-b4b08d1270c3@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::12) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|BY5PR12MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: 8deb9780-9b6b-4290-e7e3-08dc8496a20c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWJsNGVRWmd0bC9uU2ZLekhUQ3A1VW5JeXh5L3RZQnh1akxGOEV1Z283QlFq?=
 =?utf-8?B?Z2NrOUg1aTlmWFEvS29kU2o4TFU0aHZjMjVNbjJPQUFHN2E3OGIwTjliQ2NY?=
 =?utf-8?B?clBJdW9wb0RaTjcrM1doUjVBcmd0Y21aU0E4anFxUHl3NDNlcmtXbG9yUzda?=
 =?utf-8?B?UytGaXQzV2kzazFHbFB1NytwVEt1c2xUWUZzUkxOei9aM3hRQXpOTUcxVGtq?=
 =?utf-8?B?eVNvUTBHdUFBWHF1ZnFJdU9GOFpnK2VXZFY4Y1FVdm5KSDlpWk0yb0ZpNEtw?=
 =?utf-8?B?aGxyZVNuOTVRSkxCelhjcDZ2aFZxUmRCaHJLTVhNM0FGRE1TeDdFbC9GZWx0?=
 =?utf-8?B?TUp5OTMzRkNGQkptdEtwaThMYmd0ek93VU5JZmN6dFkyQmZQOHdneEhQS0U1?=
 =?utf-8?B?U055alpLNEJuUnh3ZlM0dm5nSG1VcXJHdk12SURKa2pDUnBJdVk4NmR2NHp1?=
 =?utf-8?B?Sm5mN0hjRVB1NWlHM3I3U2h1bVBTck4xTHk2R1d1Tk9yUG1yZUNLU1Y3NTZy?=
 =?utf-8?B?T3R2WjgxbXR5czRWTmR5VU9iYUwxVU9RYWY3KzRQbWJ1TGlsMlFJTFR4VUpF?=
 =?utf-8?B?dzBkRGs2M1VaaGQ3V3dFUVF4YUpDcFBmYjlwbVlFLzlxY2dIMHkrVU9GM2JU?=
 =?utf-8?B?aTBGNFU1YmxqbTU2WWRaMmhFUGVhYloxalBsdDRTR1FiTnBIME9BeHVlTVJx?=
 =?utf-8?B?eXNrK0l4SkV6bGNKcjl5aVBMbFVLWU9rZzJNL3pUNTRDZ2dPNGtpNW9hVzFk?=
 =?utf-8?B?QzY0NjU2eDNUZWZSSGNtUyttSW5ZcEkvbzlzbEx6WUU2Skh1K2NSZVduVDN2?=
 =?utf-8?B?ejJERis5N0I2b1R4Z1FCb1M5UEErZktTRDk1MUhRR2trT1dTSGFzc09LRnhU?=
 =?utf-8?B?MkZvYXBmY0xxR0x3TSt2Q1Q5NWRxTkVtYzliNWsxZnZWS3NJRENWYWd6a203?=
 =?utf-8?B?elBlZkhDWEVLRVFXRVVYZi9ZYUE1aDBuWmI1a2VWWTNLcWp2ZkJmZkhaNVoy?=
 =?utf-8?B?cm00eThpSGpiRldpTXNZV292QnNEU0tlT2dqUERqVktna0IyaFFQaWRpMzlZ?=
 =?utf-8?B?aGpFZ0ZZNnpPeHZMWnNnZXlZNHo1YTlQN1kwWXlLbURmS3NjOW90c1NaTjV4?=
 =?utf-8?B?amJaTXZOVk91ZkU3dXFheEs0UHdFZDhZcXluc3BuaVFCNHpIU1laTWdLSDBM?=
 =?utf-8?B?dHUvVXVicGxpWHliaTJOcEhjZERsRWg3YXlKankrRHJ1MUwwWVcwTlpIdHM0?=
 =?utf-8?B?M04vZG9JKzRWVG1tVXJBZ2JDU2hwZE1IaUcraFNoK2wvdU8rL0xmc05Fallt?=
 =?utf-8?B?ZDJ1Q1dIdUQxVE1RWkxUTzI1TXpvUXhQbXpFZnBRcGtCTTNjazZMWS9ualhH?=
 =?utf-8?B?Y1J3TUYyNW03OUJ5VjZ2c2loSEtVUnhsQnNDNjAxTldMSXJocWxNb2lHQ3pB?=
 =?utf-8?B?dVFxQldWSFN2V2JuR3p4T21qWXBUNmZFenhrNEU3Skg5NExkQ2JvK0VpVDlt?=
 =?utf-8?B?OWdvRno4YVhWT2dwNjM4bHVaMVZldk5OS1VCUlJyUnNJNzdJN3Fyb1hqQ0R3?=
 =?utf-8?B?TmtWTSs0L21BNHdDcVZ1d3lsbmFOUDFlVXgvQU4yc3YwUys2UE90WkllNTN5?=
 =?utf-8?Q?Cd0YNDKUgb7jQBLZR+PlCBGae7UEO9k/tx/eQdXhvTEE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2w1THkxZEd6ZlMzNW83YVMxN2JQMW1IUGxHb2xiK21xakMyM2JCd3NVbzY5?=
 =?utf-8?B?ODRsT0tPM0FRSWVsTFFONWhvTEk2SnMxRjZha2UvSWQ1SXduTURFS0hzdDFt?=
 =?utf-8?B?MmJCNDZDZ2I1bXVhQUFPQ2pZbTRZK2liNGFEd0xVd3V6QlRpL1JOWUhzOTN1?=
 =?utf-8?B?bTNjREFIald4WmhRMWhGcEI0OGVkaG5paGo1dkhWcmZpMGtEVmpaNjArZTZD?=
 =?utf-8?B?MUs4eTZKQVVCbFhvdTVJRWttRHk2bFFqVXFQa043TGZ4dDhQaDAxT1hLWDVU?=
 =?utf-8?B?MFlUcVRIbjVkOENPQi9GeUREOEJwR0d1ekttR0Q4RUZCQ1oveUovZi82SDVy?=
 =?utf-8?B?bVVKKzVTa0hEYTJFclBDcnV1ZzJFOWhFN2ZYU2hGWEVHZ2JjMnRSaEp3a0VX?=
 =?utf-8?B?R1dqUGVhdTBTY1U0d3JFV1FFV1FVL3RWM1hjcy9BVms0VmM4YVBsT0Q5T2NG?=
 =?utf-8?B?d3M4YjZMekxZeVZvVkZTWEdTU3V1MmdxRXpLelZ2ZWN6USthZng5STc0K0RS?=
 =?utf-8?B?QzVVV0NFL3JJVFJ2ZzBVRjVKMUEvVDVrZEJKUUdZSVBYQ2o0TG1ZZXZuWjdU?=
 =?utf-8?B?YzNOR292dEhIM0VVWmVXb2ZiWGtoRHZaS1B4UG1qbElneFdSMk4xVnA2RzNz?=
 =?utf-8?B?dmxZUnU3M0dnbEliT3lTNHgxSllHSlBNVVdxSG1vMmp5NW5BVHgxR1JsNlVQ?=
 =?utf-8?B?ZFc4RlJKemxyVmJla0ZuNk9keGk5cjFQR2VsM1ZQSVBqckpZd1Z1MXpjVXNj?=
 =?utf-8?B?dTBST09ENm5PaG1HSUJxT1NWWnlIVnRBcDJMR002ZWxwZ2RacjNMeTJZT3lQ?=
 =?utf-8?B?b0tkeHhKUnMwT0hqZEFyb1J5a0wvekVQNWsxQXNtbExYdnZlU2t6S2hQMERF?=
 =?utf-8?B?QWhrS1VQaUNqeFEyVnlReHZFTVdhQlk1TkZyZXpEMlp3dmszblJhK1RBNS9H?=
 =?utf-8?B?QWpUSTA5dHFjMmhjL293aDF6V3J5ZXZxaFZFUkJlL05HQzVtT2JIMzYyaWhY?=
 =?utf-8?B?MTNmQ2dxK1FnbXl1UU1pc0pBSEFwM1dEcU54aE4wcmhGOVhVSURRQkFRVnFq?=
 =?utf-8?B?MFZEbkJCRExRTEVsTjFnb01NRitPRkczODY2UElNclg0b3FFNUJLMm9zUmEv?=
 =?utf-8?B?a3ZkV1hNS3M0YkE4dkoxZlR6Q1VBUzRzNFRDWFhvK1VVbDRIN29aY293YVlX?=
 =?utf-8?B?bkpnZ1N2TWR4NWV1NFFDTUpSRE03MWg0S0FCMFZWTEhVdjd2Q1JIcWFTRWNi?=
 =?utf-8?B?clQreERFWjZUQXZubW5nWmRIUmFUaklndHBVNHlhdllhczA3MzhaRzZQMTFV?=
 =?utf-8?B?ZmFRV1FwZ0RRL0cxbW40OGlGZmNVMEtyRzFPV3BnbkNMb0pzMjhCQi84ZzFs?=
 =?utf-8?B?Ui95NStzT3NncVVKOWxoeVBNNGN3WXMvT3M5OW5KS2Rsd1FmUi9WYVEwcUpO?=
 =?utf-8?B?U29FaUtzYmF1UEUzYzMrUy9GWlV1b24yUHFUdEI2MnZ3TGJjdWxOZHpuYi9I?=
 =?utf-8?B?UU9yOWdCN0VtZlNqU0xyZjVmUWJBVmp4cEUvZXA3T1dBM2Q3MlE1RTkxY24w?=
 =?utf-8?B?RXJiMnZWVlBVL2hLQnFWY3I4L3dnblNyZlZLUzFuR0NlbkRnTE9OM2gzS0dC?=
 =?utf-8?B?d2NsT3ZKNFNnUGZmTVRsazlyUEVuVjFmNkZQamIwRWhTb2JtU1Q3UitMNTF6?=
 =?utf-8?B?ZWxSNWswSHp4ZjFEQ1l5YzFETDRaR3ZGQ3pUMXJwN0prbmZKVS9abStid3Vk?=
 =?utf-8?B?bk5rWEZRM2I0SURCRng5OUtRWUhadUs3eWJ3OFN4ZWNkVzhEeXNCZWt0aEZZ?=
 =?utf-8?B?d2tCOHc3Y0xCMDkzcmhGcDdiakVWaklQRWliZGV0N3VQL2xvWm93elVpUlJi?=
 =?utf-8?B?MmFhTHdwRlF1TUtYdmNCRjdreDBrZmtOVi9TdlFRbDlOd0dvZGxYZmhPeWZw?=
 =?utf-8?B?bjVVS3V6V0xQMkVhajEwTkhqd29wc0U2S1V2ZVRLOWd6RWxCUUlKb2cweGJY?=
 =?utf-8?B?SFVKZVJNZGpzVUovSTBkSEM0aGVXQlN5dkhvdjhkeTlRZDZEYVM2bitPV1Ra?=
 =?utf-8?B?eHBVQ2l4THp0NE5xek1SZVEvMjNrUUdyazZ3S2pqREZQbFpPRUdkSHV2elRn?=
 =?utf-8?Q?k5hADZ/FQDsrPxk3FDVk/JTNh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8deb9780-9b6b-4290-e7e3-08dc8496a20c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 13:02:48.1502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOpNA9BZPc25pGsDp4ZqjgpGbUksNe50K+dsDqOajFk5jMQsGLfVxBPQn2ojCe+NSrFiGZhSIyIoDvr3+xJVsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052

>>>>> Syzkaller reported a GPF in amd_pmu_enable_all.
>>>> Can you please provide a bug report link? Also, any reproducer?
>>> The Syzkaller reproducer can be found in this link:
>>> https://lore.kernel.org/netdev/CAMt6jhyec7-TSFpr3F+_ikjpu39WV3jnCBBGwpzpBrPx55w20g@mail.gmail.com/T/#u
>> I'm _not_ able to reproduce the issue with this syzkaller reproducer. I ran
>> it for more than 12 hours. Here is my setup.
>>
>> - EYPC Zen3 Milan _host_
>> - Fedora 40
>> - v6.9 vanilla kernel with attached config
>> - Syzkaller command running as a root
>>    # ./syz-execprog -executor=./syz-executor -threaded=1 -repeat=0 -procs=8 2-repro.prog
>> - Also tried with C program generated using:
>>    # ./syz-prog2c -procs=8 -repeat=0 -threaded=1 -tmpdir=1 -segv=true -prog=2-repro.prog > 2-repro.c
> processor    : 0
> vendor_id    : AuthenticAMD
> cpu family    : 23
> model        : 1
> model name    : AMD EPYC 7551 32-Core Processor
> stepping    : 2
> microcode    : 0x800126e
> cpu MHz        : 2000.000
> cache size    : 512 KB
> physical id    : 0
> siblings    : 64
> core id        : 0
> cpu cores    : 32
> apicid        : 0
> initial apicid    : 0
> fpu        : yes
> fpu_exception    : yes
> cpuid level    : 13
> wp        : yes
> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht sysca
> ll nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf rapl pni
>  pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_le
> gacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw
> _pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 nt_good clz
> ero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshol
> d avic v_vmsave_vmload vgif overflow_recov succor smca
> bugs        : div0 sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass retbleed smt_rsb srso
> bogomips    : 3992.29
> TLB size    : 2560 4K pages
> clflush size    : 64
> cache_alignment    : 64
> address sizes    : 48 bits physical, 48 bits virtual
> power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
> 
> Try these repro steps instead:
> syz-prog2c -prog repro.prog -threaded -repeat 0 -procs 8 -slowdown 1 -sandbox none -sandbox_arg 0 -enable net_reset -enable net_dev -enable cgroups -tmpdir -enable binfmt_misc -enable close_fds -enable sysctl -segv >repro.c
> 
>>
>> Can you please provide your config and system detail in case you are able
>> to reproduce it.
> 
> See attached for repro C and config.
No luck with your reproducers as well :(. My kernel config is almost same as
yours:

$ ./scripts/diffconfig 2-config.repro .config
-CC_HAS_AUTO_VAR_INIT_PATTERN y
-CC_HAS_AUTO_VAR_INIT_ZERO y
-CC_HAS_AUTO_VAR_INIT_ZERO_BARE y
-CC_HAS_KASAN_MEMINTRINSIC_PREFIX y
-INIT_STACK_ALL_PATTERN n
-INIT_STACK_ALL_ZERO y
-TOOLS_SUPPORT_RELR y
 AS_VERSION 24000 -> 23502
 CC_VERSION_TEXT "gcc (GCC) 13.1.1 20230614 (Red Hat 13.1.1-43..0.1)" -> "gcc (GCC) 11.4.1 20231218 (Red Hat 11.4.1-3)"
 GCC_VERSION 130101 -> 110401
 INIT_STACK_NONE n -> y
 LD_VERSION 24000 -> 23502
 LOCALVERSION "" -> "-ravi"
 PAHOLE_VERSION 0 -> 125
+PAHOLE_HAS_LANG_EXCLUDE y
+PAHOLE_HAS_SPLIT_BTF y

And I'm trying on Zen1 test machine:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 23
model           : 1
model name      : AMD EPYC 7601 32-Core Processor
stepping        : 2
microcode       : 0x800126e
cpu MHz         : 2692.575
cache size      : 512 KB
physical id     : 0
siblings        : 64
core id         : 0
cpu cores       : 32
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca sev sev_es
bugs            : sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass retbleed smt_rsb srso div0
bogomips        : 4391.65
TLB size        : 2560 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 43 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
