Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB9442AAB;
	Thu, 30 May 2024 03:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717040269; cv=fail; b=WuLOeTYaQFnrA0Y1ahoSgehFFRYGaOnmR5dA1sWRXTongFer4TpqKpp9yqmh/rfyX+AU7zKve+Bq708uheuH5PiKSP/f4PDPBn5ivUfCITNUbKpnRJiArkGaocWBEMal6PX+KtgLxHb7VYjF7HEkAKFyepqEkeIytaSrfZattQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717040269; c=relaxed/simple;
	bh=jWz6e5rgZi5jwCDJ+Gd/9/ZpRt3djwpdddUpUNOLWwk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uN+Jx8WpRyMzVWKH8+Go5kdVoMPXtplGS8HTZB9mHoIcfHuHptscl4xNg9Uikq9ZMPIZKWZbaBXWd70ENLxqn7ZJy/dic/X3ef7DuZJR3f+zJbD+61cU7Mfmg1cbWlGs16A3JjAabbh2AfKq/90eldRIHKQOPIp52crBkO9qFtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2JA1JT5/; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2JA1JT5/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2/Tw/zXfhe54FXktaUVViZfzOccxYEaQjNt6kt+mm0XbTDYRfakCuz1fOaYRag1l8pv2KzmaVg5dGBL/sspjSsMIHR1Ofq8y5RkjebWZdwyRYfm+dCWlfdsNjL56xuftHxq9kErEs6N9dDl3d267OWfgbvlAFxDyF3lVmrPE1rJT+b7XoWrMh0KVB+nULsAxz2Pg7RjqjQdp0eKhrQzoNJI+d5yflbkuBSZ+ZCblV1h36krw7Qh1Iz8fwV4AS4PbEd0rNcHOeKJf7MBHTlsks8MfsW4gTIeCW+TgeHA22FzDUJYVORirbDJXKVLbgPV+Lzb+ec/E4fyLfTYk//YRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxWx8I6PlRSQbJZyFg0mT+2rU6HbmqcN4iVEg9ljpyY=;
 b=ADSEiGHGEuYjsrVOXaFHCBfvaGeogJMPOP3DsSySrKda3z5E8USfO7B+XGx25kAyCncYxJD21yNeaf+DNY+YgJtpPKdaDAtL+JBFAueXe1YK5w6e2IEDDhfqgOHF3veDUshkDr5+wOMkqVItjXllPG6+WHH3gTr/4+HTX7ginnneVrAgLeIhzaXx17VbXT5ftcu9q2Gv65DMJVJMdJJdlhJxSuBTHy8UkAwilIpPbw0DnOIn74+/IVI40cRmlnwnkpS32GyueUz5tCI5BHA8oVpHdwwt4um6LzGtTA4lEl7Kwf64/B65WcC3ltN/MjObBC6tuDR9KDdikJQsuHTM8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxWx8I6PlRSQbJZyFg0mT+2rU6HbmqcN4iVEg9ljpyY=;
 b=2JA1JT5/jkb5r+zhzHB/RX0kaI9cU+OPPC9rU9agwo3KA2NYe81JTi/vkLRm1wDnGZjmtbVacHnpDCz7qV1tkAEgtj+nT9d1SoPUF7Dbo94KmiBMlJbPHxjOKAuCL7JWd99B2i3JaW1PtSM2bCCQ4ji/PxrXb4sGxBy+rvyEcc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA1PR12MB8262.namprd12.prod.outlook.com (2603:10b6:208:3f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 03:37:44 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 03:37:43 +0000
Message-ID: <75f6aba1-8ed6-4ef8-8811-de40ae40be90@amd.com>
Date: Thu, 30 May 2024 09:07:30 +0530
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
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <1716990659-2427-1-git-send-email-george.kennedy@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::8) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|IA1PR12MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a312e3-2588-495e-76f7-08dc8059dd6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkFjanB4WERTSlAyc25JU3lGODFuRC9XeG5MMTRUMXdFSTRTT3BCRkNCVm5h?=
 =?utf-8?B?bUhialhPTzUzbyt2aUk4MERpUlZRU3dJNzZ6S2UwMm13RVpreWw2U3A4M2NE?=
 =?utf-8?B?OEJ0TmhaeFpTOVF2S0pMaTNQckNZZzNDODdiYXFjaFhITkhDM3pWQ2MzNENV?=
 =?utf-8?B?Ri8rMGk0eFo3UWc5NTY5STk2K0RnajZsRHdHM2pmcnBwcXJvYVkvMGFKTUhu?=
 =?utf-8?B?Y0cxSzV1Yk5YKzVyNGZXM1JuZDdteWwvb0dWWDlVd2FkU2d1YTFiR1IySElp?=
 =?utf-8?B?cjNqZS9XcnJWZzNwcnRYNWprUldiZHZ2SjlEWi9kK2wvL1FCRmZyY0UyTm5K?=
 =?utf-8?B?WkRQa29GWmxBUGpEZjBGR1NKSVhXSzIzOTZ5eUdtV1lCbUw0REdtaTV0QzRQ?=
 =?utf-8?B?UDF1ZXlvWE5EZzhhbzVEdmUrZVA0b2xVZ2NOelc0M0xMaUIxTi9rSll1NG1X?=
 =?utf-8?B?N091d1BCVkdySzlVOTNFaDZEeTMxQmI4Z1FENnQ5MTBxQkN1ZkFQOXRHL3Ax?=
 =?utf-8?B?TTRPb2dwbGZjS3NHRUtmOVlNT1lrRmVhOEg1NVJlTXRIMmxDa09Lczk2Y1I4?=
 =?utf-8?B?Vk1OV0krL2RvS0VBQXNFMlgvb3ppZ1hQRDNZYitxUG5wNE54UHl4OXJHSVFB?=
 =?utf-8?B?WldxZGxaSGRJcjlnakJsUWdJMlJtZkhEUmtMblc1Nk9VbkFtUk0ySDQ1OWV6?=
 =?utf-8?B?bGFiMWJaZWpNdDh1NXJCS011THJsREhmcG55ZVhkZmova2V1TElmbnQvUFlD?=
 =?utf-8?B?TUlUQU9RMGpQdU5MdE0rR3c4d3p6bGd3VDRqaS9Ja0dXSlUvUllBSW05b1ZC?=
 =?utf-8?B?ckJIaTkzTUNGVUVrcklLbEk4UXNxdkNiZ0xhMkZjOHdTd1cwQit3MEkwZ1Vy?=
 =?utf-8?B?MVIwRWVYZGFEQjlWTi9LQi83ZUpaVFgwbXRzTUIrSlBiOHpJYk1qNWZrL1Uz?=
 =?utf-8?B?RHo3bE1WNWhobUtkNHhneEdwQnpjaW1lMXVoaWFFSlVMSU9ZR0xPY2dQUFF0?=
 =?utf-8?B?QkVWTTlFdGZoaVZlcWF5TE53dDduSDhOOWNVU1ZwWUIydVpoM2ViM050bTJ3?=
 =?utf-8?B?ZkZROERRQXpyUDhUMVNlQzZudUErSGtEUDh3bWJBbTcrMkllaHVDdm5TTHhN?=
 =?utf-8?B?UUtha0tFTlZNcjMvWVZhL0JTS3lpVTIwQktmUkpkakdnVFQyRDFDaEU1VE8x?=
 =?utf-8?B?MlV4WDlTeGtpamhqSmpwY2hIOC9CYVdGZVRRbGRDUlRNZ2dRK3JpU0JTMGVk?=
 =?utf-8?B?RXVjWE5rN3pqb1JCYU9GSlRtaUVnOE9sTjcrNTVjb2N5N3loOGpicHVubHlN?=
 =?utf-8?B?WkYvOXQ3VFEycmoxTVNjMzZweW45czAvRE4wbElhN1pjU0VpVEg0UDBLM1ZG?=
 =?utf-8?B?SlhWK0xaanVhVjFKUllvR3VPNmcwMXFsTUpicEh4RFNzUHRWdlMvT1lGSHBx?=
 =?utf-8?B?eGtQUS9tcTlZKzJJTS9KMnQ0bFFOVVQrSktmQTRyeU5tRDFzNGovZkI4QnJG?=
 =?utf-8?B?YWpoTW5heCtvRktCb2lZQ1UwL2I5QXVMUjNqa3A4czlvNTZCaEtuQUhqc0pM?=
 =?utf-8?B?aUZMZFRQSlBCWGRaZ1pXaE1LWVVmN24xNUpOSk4rNzlvRllaWitNTittOEtp?=
 =?utf-8?B?cjhWV2R2S2NINERnaFVqWUdRMmg1cllSdTZibVgvUlFlbFRlUy9va0ZtL2tU?=
 =?utf-8?B?MnpBT2JKZUtvcFIva3JRTFp6RGEzMDJPYlV5anVGbjg1VUt4Vk1aVWVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkMvaFV1UXRmVmdCdnJUamNxN0o1ZW9WZU9xNERkeWdBeGh6dExzcmZTUXU1?=
 =?utf-8?B?eURWTWc5bUFUWkU5alIwUmEveURBYmxiK2tDbzhkTldWOGh2eUFUcFpyVlVo?=
 =?utf-8?B?cDRHM05ueVlVZXZraTFmRFdSelh4eDhqNUZUN2JTNzlaR1BTM2hiSnhIbFow?=
 =?utf-8?B?cDU2YmRPcnVNOENZSURlZ1RNK3B0eTlqVkdaTjFHbVEyM2I4RlE5ZWtmRGZO?=
 =?utf-8?B?YUtzQ09Pd0gvYmQ5SGJESlZHaTh1YVpSWndvK2JrV1RxL0VQTFdNbGFGMHRz?=
 =?utf-8?B?ajN3TSs2UjNLM3p1ZkFRcVpxV1hmN3JlRHNwNVpDV1B5RzdWR3BsWDJjdXpa?=
 =?utf-8?B?RzA4YUd6MUR2OVhaNG8rVHY0YlZlSTdKM3l6THRhSGJZS3pZcnQ0OGJsSmFY?=
 =?utf-8?B?MGlNZWwwZUVRMktwTUg1Nm1MdjEyalIzQ1pFUHRjWlJUZUZHbExhc0NQT0c4?=
 =?utf-8?B?NlJnOVlUbkc5UlJ5Njl6WHNiU3htN1ZncmpTTHJIUXZNQS9xYkV3VEFCYTRM?=
 =?utf-8?B?YTV6cUJ3OHExdndWcS9La2hSZ3gyZmZzMWFvUndKZjNNeE5NeE9zdm5wOWpy?=
 =?utf-8?B?Uy9CMUp3V20wTE1BbnBvM0xqUjJDOTBFUmltTi9PSUtPcU1rRGY1YllFa3V3?=
 =?utf-8?B?bXExQ3paY1ozSW5lVHF5enNtUUZFY0d6b3B2TXdYa2hvRlJtU3B1WGhmSlB6?=
 =?utf-8?B?WWxqeEIwREpjbDlvblF0amx0N04xOWpkSGVYTUU3RnV1Si9BaGVwbmpSLzVo?=
 =?utf-8?B?aVBKRzNBdUdZNDh0U3B5MVJ3cnMzNHFuSFF2RHpvU2Y5WUQxQVRPbDZpcmVI?=
 =?utf-8?B?SzJLSnQrbi8weHdSYTZSSjZVUTdTVHIyTnl2M3Z2a0w2MVp4YjZReDNYRWRv?=
 =?utf-8?B?N1ROTXZSSnNGVlllbGZJL2swYmh5SlpXSzVySXJ2M1ZxM2lwUzN4blBqRkFX?=
 =?utf-8?B?WUcxa2RiaFpHcy83Z3V4WUY5UGNUT2pxWTBDVmdwYm1QK3BWcTFncDVrTlh6?=
 =?utf-8?B?V1ZhbGR6cnZKV3JOMDhRUG5oOGFnQWpKaTNJVU05bGhXUERnMUpGMlprNzZa?=
 =?utf-8?B?MlNISWJJZzJKTmZLT0g4OXJHbmVqVVdNQmRRSHluODRmWExUMml2UnFaR3Fr?=
 =?utf-8?B?a0d0UEFCTWljV29QN3hZcXk4RG1EZEswWUpiVlhqVkpudzZJU2ZNUEhXdmNB?=
 =?utf-8?B?dU5Udld2UzhvUGFlTnlXdEFlM2JlV2ZEVkpvZkJncGNEMVEvU2JydW5jd0tJ?=
 =?utf-8?B?ZklweWNPaTM0eTRGb01xanVZNFBwWkxyZnRsR3hNUnljbmRYQ0FvbGduQVhy?=
 =?utf-8?B?cEhIRnpSczRQUmthMW5jeUMvV05zcEpHVmNNM2pFVEFrMHhnTUJQOWxXSGRF?=
 =?utf-8?B?WDA3eUhmNG1SVFR6RHJMUzdLek8zL1VDTVVZemsvaDUrKzFqd01tR0JOUzI5?=
 =?utf-8?B?L1NYajlyTjhOY2Z0Zy92ZWJZYy9TM1g2OHpwbitDRGlFT0VlVUgrNkd0T3V6?=
 =?utf-8?B?azBxNC9hdlVDaGJucUc4Q3NkQnlwZXAyZmdtN2hIaEhOTU1PTWhSTkI2ejhJ?=
 =?utf-8?B?eG1EeURiNWlxN0JRNzZaZ05MdmhLYVhZdFNnTHdhQWhreXplWUFUbE9ZYUI4?=
 =?utf-8?B?bWx5SVVKdTd5bm84dGVSUlVraWpabGVRaE94UllZMFc4SUpiSXlSOEFNUHRp?=
 =?utf-8?B?UEVTLzAwb1N5UWV1Wm5DSHM3YzdWVjVFeWNWZ3JZWFM3MjVub0ZITHU5UVE5?=
 =?utf-8?B?VkZEd3hvckZaNzYzQ2ZSc0k2ekk0VndJSTJPRXBRd2Z2OWI5RWZLVTBTbjRr?=
 =?utf-8?B?RkFDVTdPZ2pVb2xTYVlCU0pjMHFlUEJBU21HelpKTDNwY1lOcVVPT2Uzdmh5?=
 =?utf-8?B?V0pzK0ZhazAxMmQycFg0dGdQQlNybjlpdEgrWVpPTnBFdit5NFJOWVNFMGh0?=
 =?utf-8?B?ajh5by9nZzBXeUVuS201eTV5NmdTcHNpa0lGMWRwTG9hZEF1bFlRbU9KM2lQ?=
 =?utf-8?B?ODVWQ215bnVxSUI3N1dCR2duQ2UrUzlaNFNEUjV0QmlmdW5hWkFwTXlqYTlu?=
 =?utf-8?B?VE1rV3pRd1NJQUVTRi9TQWp2anVBc1pOYkV1Nms1cXdtcVBtditrbndZZmNm?=
 =?utf-8?Q?kc4yw8WVeckj+gdKCmeX9QQym?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a312e3-2588-495e-76f7-08dc8059dd6d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 03:37:43.8694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ai26Av4pp+svvaB6QR2kh64OgRcMNsns7QhPtAGhZx9Gh6UjWz3SV8C0ze14xfV9xgpqc2g63fBh9/aXFY1iMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8262

Hi George,

> Events can be deleted and the entry can be NULL.

Can you please also explain "how".

> Check event for NULL in amd_pmu_enable_all() before enable to avoid a GPF.
> This appears to be an AMD only issue.
> 
> Syzkaller reported a GPF in amd_pmu_enable_all.

Can you please provide a bug report link? Also, any reproducer?

> @@ -760,7 +760,8 @@ static void amd_pmu_enable_all(int added)
>  		if (!test_bit(idx, cpuc->active_mask))
>  			continue;
>  
> -		amd_pmu_enable_event(cpuc->events[idx]);
> +		if (cpuc->events[idx])
> +			amd_pmu_enable_event(cpuc->events[idx]);

What if cpuc->events[idx] becomes NULL after if (cpuc->events[idx]) but
before amd_pmu_enable_event(cpuc->events[idx])?

Thanks,
Ravi
