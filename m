Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795022510;
	b=teBFd+2xliT7ud5x5aWVhO6WX5Ts7rzzmsb1hbxPRP2MHYT7wTiIZ5PLTaO9gqWFaLtE
	 ti1KdwL7MMRIv0AdW13ssEp9oSJ9kF93BmqFP30+i+ksiN4jVmgjI0uhBQOBVWwydPQNB
	 55Tdv/FkO8pjLZt692kPwoe4A5qyWXgQjhC4QMxNqyS/ujT5EpJPaTkcuXworqIcmRNI0
	 Xr00W0LgfexfYeuOsk+Xpy3mFnQPQl+fSPV8gx/XllEKh9kILsbHHdd0bQvSMU03voI1Q
	 9YCsliVFZAahrm9MYPS4N6EBRqSh3EwIKSd5n4R7RzQHIiKLtNz6smM5+7Hgoj4b1Jg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022510;
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
	bh=tOGfQ6cQ1En7nNkUe4qRk1JWp9mxMtsaCoiquidtyAw=;
	b=mb73dWA8CiHF9mUvbOk3K1kvcawcSermcFzgA1e723hf8O/jtAy/gRK0S5uBgTlr3ssA
	 K1ot5i0mKsZRA5TML/PNj+m5NXBmMBZDGL3sFWaOZ7GN7LkjsfWl5f04u+o1y/1yquBti
	 XvHoHEbGwnFfMxQ/xnOZNIUW50jiXpnAJ+93v3bKhGJHw9QjP6acHs2uE1ruEVq2nC4uO
	 gO41e0BTQSG64JkOw5N5KqeKVRYCMNf+kAwWLo8c0vlQnqnNvhtc6YRw4st+A2OafP2o5
	 u4Ql1rl6JdrSq5qFHH0PKIjkY6eOasfOhj3gemZdvGKeotrO2CD5CVqqtO/ArE0IEuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	dkim=pass header.d=mobileye.com header.i=@mobileye.com header.a=rsa-sha256 header.s=selector1 header.b=UqTqCcqQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.8
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011008.outbound.protection.outlook.com [52.101.70.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C43606A32C;
	Wed, 18 Nov 2026 17:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29C43606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mobileye.com header.i=@mobileye.com header.a=rsa-sha256 header.s=selector1 header.b=UqTqCcqQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFMe4eNXSIIECR+3JJ/8vWCBeBvipuL6/lEqN+iUGad4wzvfXrlTSZmBH6NSeolFHhnP2u0O13tETPm0UtFkBcmcMujVq23IoJfNXCwYIk4lCnA+a7kUEq1IW7PR9uKedT2bDLJDpIbpaPXBDGgDh6zLpUYhafKyRzU0EGFy52q43yZIHz+0VLcBwvNFkBWKfGQ1r/NkGXi3OxueMc0Q+FKC1tKkdSqgidSFVJOZutcBs2gtTA39o13j5CK6F4pTy5mP91wdC6G5kYT57q8OGjfsZkNwnq8ICXpmOgscYY3VSK19SJ/sjdHze0djhm11T1KDofiOf93ov47zVg6F7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOGfQ6cQ1En7nNkUe4qRk1JWp9mxMtsaCoiquidtyAw=;
 b=lhn04WTLJBSxzMTdZyAuy1F94Lz5jXOUrr9uknSOdDs17JH/m92f1wO/f7D11mSFOx4nHq20tH2owgNuJpJsrJMcEP9JqwlSkdwXStu4+cp9VH1g/DSGMUi8Rh6M/PFC6sNp42jKhWYdsR4Y9saTF1oKotkfkMVPymcK5JaZGEDgdkgzUis/L8jY4zX1UxCbkeLknRCs8RoWmKofNX1kfVJhAhNbrodv79vXej4rxkrL9TJNDcfwpsWvZe28dSVvUA7zfL/NlWkG7CXxd8ota7FRyzRocrm2pLur9ce97FuEZhQAXs6Tf+yQWeCx/rJcUO64XeDzxSpcaSQ+25BiyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mobileye.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOGfQ6cQ1En7nNkUe4qRk1JWp9mxMtsaCoiquidtyAw=;
 b=UqTqCcqQWSF+mnkhYf6245frqgD8XlK+0erv85qaN7JNL4yA6fZnz+cDbYIZfmf/0+MSKufQTp3lbj/TqLXFRLDrKf/t9U7koIBfteLlptjSlDL5ycPSyD4rEoobZfpcbsf3H2Z/56vN8DkXg9wbdY8KLUBAZ6RWEpQ1yNZYeXo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mobileye.com;
Received: from ZR6PR09MB889505.eurprd09.prod.outlook.com
 (2603:10a6:910:e0::22) by VI3PR09MB012160.eurprd09.prod.outlook.com
 (2603:10a6:800:37d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:21:44 +0000
Received: from ZR6PR09MB889505.eurprd09.prod.outlook.com
 ([fe80::9006:1164:b51f:23a2]) by ZR6PR09MB889505.eurprd09.prod.outlook.com
 ([fe80::9006:1164:b51f:23a2%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:21:44 +0000
Message-ID: <962f81ac-2a4f-4b15-9f73-2065ed513af4@mobileye.com>
Date: Wed, 18 Nov 2026 19:21:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] perf: add MIPS Coherence Manager 3 (CM3) PMU
 driver
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, devicetree@vger.kernel.org,
 linux-perf-users@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org
References: <20261112-i6500-cm3-pmu-v2-0-cd2569571819@mobileye.com>
 <20261112-i6500-cm3-pmu-v2-5-cd2569571819@mobileye.com>
 <sashiko-outbox-211133@kernel.org>
Content-Language: en-US
From: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
In-Reply-To: <sashiko-outbox-211133@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To ZR6PR09MB889505.eurprd09.prod.outlook.com
 (2603:10a6:910:e0::22)
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
X-MS-TrafficTypeDiagnostic: ZR6PR09MB889505:EE_|VI3PR09MB012160:EE_
X-MS-Office365-Filtering-Correlation-Id: 501d3b5a-a887-4203-1d74-08df45986b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|22082099003|18002099003|261009223027099003|4143699003|56012099006|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	5EMB0loDHCf7uyYeEV7o+wz+OmJalBJojyPaVW3KIdRTHVD8kTrrJpKBCrrmbpjyDUhqHJEcmnlFbCPVeQlMbbhuZgntJPwu+OZj7Rah25FMAyHXvPqNhU0UeoCKcqswe0j/ytu6ku351yOStUqVMWMmh7c9gWzPJsDWNkwrjXUqsT5ppgrI+JTTMgavwFLs44sIguXXnJoVYcSg73Jjrg0Kt5sI77reDpkWrSEfH0xACRrmckcyLXzffUlU1301YH4WGZBMuuWDx+QZHrjUjEsKzvmRwTu9BzrATCdVvQA/z4ZBaEEbzneYdXxEGRx0pQpP10AcZ25lZTb9EIXUCZeXNb/X1uFgE0tKStU8jztt8Y61G3y9Noa2k/etBeMzk1wZlAdaQB/2H06qpoFUicZaSjw80ibROkgoqrVhl/emW7rKrpwOCvwtgK2n2COhOoQ+fxXFuqOWuAbX/BXajSbBcO/3Ymw3NGmiLjX+sGXwHocitj92mrLlEEu9jFI7/E/Ji7ncHZ90wU4YUD8BZdRzB7zUQVVgPbL2//bLSNqEQ/wkboB+WR0kdvJG+uwGMcVZly809jt0xHTMVTUCIOyLJSm/+J3db1HxJqGwE9cGETIYg31mE3p15NXuk/0SEz/syHZcrMLuWFROVxOxGDpC/ugLT86hNKyCdfddHIQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR6PR09MB889505.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUViNkVVWkdRaCtLZEZHSDhtdUVzTHc0SFY2ZkJ4Y09rTnB6Rk1qZzRYTk1m?=
 =?utf-8?B?c2ttTDlhaC8vSFBXMTFNbmdTY3U0bU13blJkK1VTeHowZWo4SW13enBuV1Ni?=
 =?utf-8?B?OHdQM1ZIY08yZllLN0NWTmdWbS8zbHVrMzcxeStVR1BkTkpCYWlCcENDT1Zz?=
 =?utf-8?B?QXNqM0hLeWZ0Q1hEN3hTMmdURjBEWDQwRUtvaTlKMWdlWGlkeEdqZ2QrQ1hZ?=
 =?utf-8?B?ZnV4RXZ4SUlINDRvQTN1UzV2ZjRRakpXYUIzem1DNjREbklZemNURGFlREVQ?=
 =?utf-8?B?Y1psVzVsK1RxdU9IMmxxQURYZVQzdjVvZFY4YWQzWWJEcmttd3BBWkUxNnpm?=
 =?utf-8?B?aVFhMjNxTmJSb0E2WXlGZEgrbi81UDgwbG1yNkdLRDB2OTdiQW0zWWJJd25v?=
 =?utf-8?B?Q0ZBMW1GWlliMlcrVTk5Rys3ZGpQcDRsZVdkUTdmMHcvSnJ4bFYzRFR4dmNU?=
 =?utf-8?B?dkNBZVlpSzdXZHBsY3labk1WeXFJM3hkQ0xSVXZIb1ZyWjJtYWJFM3ExUlRM?=
 =?utf-8?B?NXo1ajVLS28zZVhxMFltUjNXbTRkUVVvZkF0QXE4U3kwNGpIdHVDRTlxSUNP?=
 =?utf-8?B?UVZQWnBuaFo4RENlUXJ4em5BS1Noa3htbW1jUDlXU0tqc2lmSWRQcFJydnRy?=
 =?utf-8?B?OS94Vmk2QjFtNllHZkJTY0hZU3JZZmcvKzRhZ0dsU0VTRTVvZFVLeGJsR1JD?=
 =?utf-8?B?M0FQSFVhNTNpelh4S2ZlbFJScGRmM2dpOCtudnRXQW16dVE0RXUrM2RYRlhT?=
 =?utf-8?B?bks4MmplRUtEMWh3bExON3M4MW43eXplNjZHc1p4cHhvaWVSc0U5c1NKbmIx?=
 =?utf-8?B?MHVvTkNlT3lDN004dFA5dTV6ekxWZ3dGWmdheFlVM0R3L2ZZdVBGWVRNMnIw?=
 =?utf-8?B?Y1Yxanh2bVBCN2JmaGxsQk5KeS9KSWVsWHJRbXkvZzJQc1k4TlV0bEN0NktE?=
 =?utf-8?B?eFpnclpraGtDVGNPZlhPV3N6cERyaTlNdWxoT2ZrbnlkdzkwZkpib1JkTlNW?=
 =?utf-8?B?Vit1UkdiVUxvUnJqMWt2QUZaOVVvRHRmLzl1M0NqUFV3N1EydGd6TU0vOEJ1?=
 =?utf-8?B?M2Y3Qnk3QytKOGxtcEhkR0NZcE8xRFdtRUM3NmhTZ2V6b3N4WG90UHIyVTRX?=
 =?utf-8?B?NGpXcUM4UUVqa1kydWZJR09IQjhVdmg3YkZMNXJpVmhKWG9oU0Izc25LTkNU?=
 =?utf-8?B?QkVDdmlTQ0hFTExNbHl6SHNrdTJvUW5TT0NvWDBid3pnK2RXdVJURkJsYlkr?=
 =?utf-8?B?UEc1YVpnR3NxOHdJUlQ1NGRTazVRcUJmbkRXdnRlaHVrRVlYcE4vcDQzV1Q1?=
 =?utf-8?B?bTdZTnF4d2FoZ0FrVS9ldkZ2MEhpRHRiVkNZK2lvYUYrcjdUekZ1QUh5RUh2?=
 =?utf-8?B?QUNNaVphdWNicXlmYjZRQkpPaFVtZFV1Q0dVaGNEZXZmMGI1bGwwNzBiMnpx?=
 =?utf-8?B?SFFRM1BwQzArV3pCMUh4a2taMnFSQVZxZHlkMncyeG5oSUh3cGlRQzhrUUU4?=
 =?utf-8?B?b2JkbWhsaWo3Qm0xM29mdC9Sc0FQa1VMRXRybDZ1MUttRXFDcTllWE5icVc2?=
 =?utf-8?B?ejEvOHVEYTlQM3F0WDhUQ092NEM1blA2cWhIdXB0WVhvOTFnSGswdFkzWFZE?=
 =?utf-8?B?dzRETzRzcTgvSUVoMUQxQlE4VE5iYTQxTlo2Y3pnbUo1VG8rVS9WK3hMNTRw?=
 =?utf-8?B?NFp4WDY1a1N0ZHVmakxIQ2w4SjEwdHRGNE9jMGU1Q3VQTWRGK0ZMQUMzWCsz?=
 =?utf-8?B?WHpwaFFGQ0JlRTI1TnBIK1BMY0ZhRVgySFRDRkUzMTM0KzNvZjZ4SElOWU43?=
 =?utf-8?B?dnhuaW1IMnVybVVwaWtRTVE0UkRYQlA0WkdqVjRQWjJyMXRJek5KQVJwSDVx?=
 =?utf-8?B?SHZBY2RPR05HQ1libWxjaFJSK2k1MkRHQnhnYnhweE9pUDlxVURMQW44L1Ez?=
 =?utf-8?B?bllqUHRKdU9TWVNWcEs1Ly9HYmNuSm54NmxNMkVqemJNRGhjdGZxTjVBL3g4?=
 =?utf-8?B?U3p1bW9kTmdWWlAxVDRjQWk0WkZFZ0NaM0hsSzl3ZmxCMVZwdFlVdEhSdXBj?=
 =?utf-8?B?N09ZbzJrYUsrUkZvSWlBZnMraU5qZ3J2U0I2ek9TMjRVT3pvNVZhcUtMNWxQ?=
 =?utf-8?B?Z1FDV0VmZnBtWURxaU9EbVFGcmpnUlRMdUJqcWE1cm5tV3B1ZXp1RjhxVko5?=
 =?utf-8?B?dmdURkY0U3FKQ0JJSXZSUytKTTlIZVorL0NZUi90cnZOend5N3FjUTdUeisz?=
 =?utf-8?B?YUQ4dlMvdHlUNGkxNEdtd0pleDdBejlJVGw1TXFpWGZWS0hENHd4MkswVHV3?=
 =?utf-8?B?QVUrS25WbnNaZ0RMVGFtQzBlN0FscjMwL01tMWhBdmU2Zi81czRvZz09?=
X-OriginatorOrg: mobileye.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 501d3b5a-a887-4203-1d74-08df45986b01
X-MS-Exchange-CrossTenant-AuthSource: ZR6PR09MB889505.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:21:44.3710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jbp5EsXyQNxdyzXG+K2NghF98g5szME+1JyvMcOerI+RkvzDGB5jgrWNaGrzLN3VkggF4+DaaUFsnex3ppkPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI3PR09MB012160

On 11/12/26 15:02, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] perf: mips_cm3_pmu: counter overflow double-counting in
>   cm3_pmu_update()
> - [Low] perf: mips_cm3_pmu: broken !MIPS_CPS / !SMP configuration
> --
> 
> commit 272d1a9241643c479b7f4cabbd1c40edccbe1b16
> Author: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> 
> perf: add MIPS Coherence Manager 3 (CM3) PMU driver
> 
> This commit adds an uncore PMU driver and documentation for the MIPS
> Coherence Manager 3 (CM3) performance and cycle counters.
> 
>> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
>> index 245e7bb763b99..2dbed2fc7b030 100644
>> --- a/drivers/perf/Kconfig
>> +++ b/drivers/perf/Kconfig
>> @@ -75,6 +75,18 @@ config ARM_XSCALE_PMU
>>  	depends on ARM_PMU && CPU_XSCALE
>>  	def_bool y
>>  
>> +config MIPS_CM3_PMU
>> +	tristate "MIPS Coherence Manager 3 (CM3) PMU"
>> +	depends on MIPS_CM
> [Severity: Low]
> Should MIPS_CM3_PMU depend on MIPS_CPS rather than MIPS_CM?
> 
> MIPS_GIC selects MIPS_CM even when CONFIG_MIPS_CPS=n and CONFIG_SMP=n.
> On a !CONFIG_SMP build, irq_set_affinity() is a stub returning -EINVAL, so
> cm3_pmu_online_cpu() unconditionally triggers WARN_ON() when an overflow
> IRQ is present; without CONFIG_MIPS_CPS, cps_smp_setup() also never
> populates the cluster ID in cpu_data[].globalnumber.

This is a false negative. On a !CONFIG_SMP build:

- cm3_pmu_online_cpu() is a CPU hotplug handler, it won't be called on
the !CONFIG_SMP build.

- cpu_data[].globalnumber will stay 0, so cpu_cluster() will return 0,
and it is true

Thanks, Vladimir
