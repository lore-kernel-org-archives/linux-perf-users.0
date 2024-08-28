Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020125.outbound.protection.outlook.com [40.93.198.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A2826AD4
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 05:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724821769; cv=fail; b=GRxcpgsTs1/Z8031XNLC9rN5YPGyRQ5bW86qq08SxvZpuccIk8o8CoOwMUtQ7Miv4nmHOsNJLBY2HAvCUdaeRYrtYQk76kwRjtVbUiVuk6ssu/6WYINrk2ys6E0nQUWTz2z+/A/mNceE5ycDTSNM7CaZS3Sfu9ZlGByu397F3oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724821769; c=relaxed/simple;
	bh=3h4Zc3ClCRYhtwo5pfFE0PFR6RmNuMcZp80+3BQ3fb0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HOznOwQH+E8yi/W8sAH4lgJlbmCoYTpfiyNYDYl07el7lcYpVh/ua7l0acMaV8anIxyjpSpnLZ+/OlpAbq18KLZbICBSI7u24cUCxGpgWJ934WuCML5pLmvg52N33EReX7iPOOBnJ5g2vecCC/24Nh/45FT7PMKRmiHvyzLMF04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=St24fCdt; arc=fail smtp.client-ip=40.93.198.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="St24fCdt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VoYcT+TVbneDGMx84xsyFAD+4J1u+yiE17ftfpP0tOGvcauXurrGUl8sF5dxDd4QdmMsJBMOMEybONlsveH11+aPv3PrfB9rR4i2/+UK47sqCkw8lcXysufgSgVvthD6Ju0KzF2pEit+wPgXJlVt1NoeTzi2ssJYCrcpShaMht6Myvo8UIJ5+pqq0HaakU1pKKT72A/CqQEcNfeZQKC60dhcAmb/z9PIgprHNBIN5v9tH3uvmIsgw8G61Ruuw1huNiN16usSKMkf4QEgwomu5dM3jAgditLASqsuSW7gImXuhc6yWCrYjv62ibbFRrR6G7xLwj/gmkfgU1ohUlKoWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnVupQs8o9232jj4WxO+zXJ9gyN8FVBblEptL7wJsoU=;
 b=Z+9KKZ8Dv5ObXESN9v6J3W0mthN4lVKZFYGyU2ciad29IU5CRFSuzqzWaSO1ZUEMSKAfkb64sVsay9d7H6ejCkyielKrSe+WUvQnDBujEXwHfnf+XKCXHXBtE9UAdPymlHNNn6rudFof82uJKs5Xt0hQMoA7SVe6V3h1Z+mWwSvaJk6pibtA6NKQ9KLD56UzS9TKkxuAy/H9ZpqG9J7pruOllqw26arUC7PuGQHso4X594ZZNOtQf6qRh4/jF37wnNCI2pV63t0RpPXYzuuql03lcISGsQid4CCjO32Oyui7s25KqNladdc6w85GolMrzjPW+2cuqSHLLKwXOXfK1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnVupQs8o9232jj4WxO+zXJ9gyN8FVBblEptL7wJsoU=;
 b=St24fCdtmiBw2fwoRq5LunFmlSYRYYJCqH1+ESlyIlvYvNQ3Km2ewZAMzbYneFkWIvGGy6Nlf0fqdno0EsxqcscMuJYSqcT4Bqs1jQMl7ap+1q+0QMyUzFyCNZq03N5ICwzeNwrZmvF9iDj2jfUkXxyYzxDuookV/oeNuNd7gB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 SA0PR01MB6506.prod.exchangelabs.com (2603:10b6:806:eb::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Wed, 28 Aug 2024 05:09:25 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 05:09:24 +0000
Message-ID: <0e8d5ee6-fa53-4513-8508-74f57eb999ef@os.amperecomputing.com>
Date: Tue, 27 Aug 2024 22:09:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/4] Add map pgoff to python dictionary based on
 MAPPING_TYPE
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: james.clark@linaro.org, mike.leach@linaro.org
Cc: leo.yan@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1724808513.git.scclevenger@os.amperecomputing.com>
 <afca22382f5ee58c8ec5aabe18b8fc680af0fbdc.1724808513.git.scclevenger@os.amperecomputing.com>
Content-Language: en-US
Organization: Ampere Computing
In-Reply-To: <afca22382f5ee58c8ec5aabe18b8fc680af0fbdc.1724808513.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::47) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|SA0PR01MB6506:EE_
X-MS-Office365-Filtering-Correlation-Id: 259163a7-5dc5-47e2-fa24-08dcc71f9559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVlYMXpkeDg3WXhuSFRsM0wxOU5BYU1VU1hlUkJLQWRYVDk4N1pDWlBqY2Mv?=
 =?utf-8?B?NllnSDU1TG55NmQrVG1OWWxwZWNXbWRtaHpjenkxZkVlUmRRNUVReDFDcXpE?=
 =?utf-8?B?R2t5R3dNNm54aUNHSkNwVnpDWllYNEFRTFllL1RHOGtsdzQzaU9xbWdUdXc3?=
 =?utf-8?B?WXo4M0hBZUpTWFhPakxJMytHVngzQjhsQ1BFb2daUk53dXRTWXhaeEtrc0Jz?=
 =?utf-8?B?My83TFlmU2doUDU4dU9ucFFvNTdmUDNZWkxqeTMzUFBNeEx3SVN4UHIyK2Z6?=
 =?utf-8?B?TWlHQVdnUDNqQnd2R3Q1aTlZbW1PWUtMa2ZSZGQ3TkcrTTVJWGx3VkdrRHhJ?=
 =?utf-8?B?cGZVUjBaNGUxY3B3VnIzMzZOUmlxRk1YVWR4RFNMMDBkclNHNDQ0ZGlmQmdX?=
 =?utf-8?B?WWhmM3kzSE9NVjZqUExDQm5jL0g2RXRwK3d5V3dBNGlKVU11MFNwcTdETHZE?=
 =?utf-8?B?ODdkcDZ2d3lBenc3VXpZQTNpNHQreUZ1WUtpV2NXdXdQVDg0djBWVTFTVFpY?=
 =?utf-8?B?MVh5R0J3eHRGRkVhZGplNlVlR2ovNStpS0FpVmQ1RGNkV2YzejBhUi9ka1pJ?=
 =?utf-8?B?UFJkTkVUaFBhUENtR2xtdzB0UERhZ0hMR3UvcmpGdGloc3RxUEtXMzJKK0gy?=
 =?utf-8?B?Z2xtaWVtdjQxbldJa2tFVDVyTHYwVWdhK2I5OE1WNjNMdkcxU3Z2TC96OVdE?=
 =?utf-8?B?MVVmK0pBL2hrQndmVy9tVWNKRDVVYVZCNmRmdHk4TVEwWkxTODJRVFZ6YWd1?=
 =?utf-8?B?aDRvVTA3VGhwUWdLcFNnTUJINDh4dW9Sb1FPYzZGYUdiaDNSWjZ4VmFuY3RU?=
 =?utf-8?B?cnJVODRMMld0eEtNa2NPZmNLSnVkeHI0QlVNTUxmMmlkNWxwUW1yTldpZHEv?=
 =?utf-8?B?MlJXclhWN3hpZnVKa0tlTmhWN1Y5Rm8vUGg0YlVZbUR5RWxmTFlnMDBOWWUv?=
 =?utf-8?B?anhUUzROeFduN3IxSGpOMndsWWdtc2orVCtUNFpyVm9OWmF0SVpBZGVPRWRa?=
 =?utf-8?B?WE8zVjZGZ0hnNU9MaUNnMnZCMVR1TEVYeVNwQ1hiKzVYZHpsb3JqL3JZbXJi?=
 =?utf-8?B?UUk5Z3lrVHBZbnBLdmIvMkZraWhRZmkzSHE4eko3aE5ndFBIdjFNcVNVVU1I?=
 =?utf-8?B?R0lqM1RQbVJBc2xGWUw1OUVmQWxLK044U3FKbWVYK3NpWEZVQlNBVW9IeGVR?=
 =?utf-8?B?U0Yxeng4czc4UGM2bXQxbm1RaU5CQnZSQzB6R2hHTVNPMWxYak53ZlNBWnUv?=
 =?utf-8?B?blJqLzFpT2RHUm1VRTVvVlFwYTBteERTdFlRRWJDa1pUR3VKeWtuUlNueno5?=
 =?utf-8?B?em1UaWhEWDhRNGpnZ1lPRXhIcXBVQVVTLysvVVl1VlpmM05Hb290ZDVhcnNt?=
 =?utf-8?B?TkNWb1h2ampwWStaQWxFbG1TY0IzM2ZnRnNRS1RVNEtsRmY5Q0FOdHRwM3JU?=
 =?utf-8?B?ZG9tZlFmY0RQYkVrekI3OUdTcjNZUk5LeU50dU1IRVR0NjIxaHZ1WndzbU9w?=
 =?utf-8?B?YVhiQy82ZFM2eVBHRnRLQkJvS2g3REJXdWxyUmVPT0dPUytDcU5QcXVoamFH?=
 =?utf-8?B?bXB4S2pPRWplOUc4NHkvRUFnNW1RWDQ5RjlUN1Q1TXNFcUNFRENIbjJhYmpB?=
 =?utf-8?B?bDVCalFYMms0Nmgva1Vnd3JtMFZSUXoxK2Q0VUlJK0tFNlo2YlVBZ2xmR3ZO?=
 =?utf-8?B?UTdIVWZQb2JNaVR2ZEFjTyt1SEFxM2o1WmxTbkFLditncWIvcVd3bTNYeDBN?=
 =?utf-8?B?M1Qxd2lkRVNiUEpDQ3hwK2RlcmF4YU9ya1U2dG9IL1M1bHhPS2hGVWpnYnF4?=
 =?utf-8?B?VVB4VWpXNUprWDJQZStuZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OCtNYU5MQUp3c1BndTRXVEFkVS9lVGdncndMYS8zenFEdkU1L1o2MjNsaFRp?=
 =?utf-8?B?NUtQV3ZiNmdIUzFSVlFFRjlNaVJMdFNrZmFtdzAyTFNHVHFjdFhHV05BRno1?=
 =?utf-8?B?RDRLcWVLR3NGejlST3RoYzlueXJZYXB6NFhzYXdBT2F3MFVMTFRmUHpVWTVD?=
 =?utf-8?B?d0NGejFvL3RqYVJvU1VkTWtEK0pBT1Y5N2xqRmVaeWpXOU5NL21XWXdOUVpw?=
 =?utf-8?B?NFNtQW5Qdy9tSWxXejNIVjcwcVJFRWhSWlNGRlJnclFIemYwTjBnM0FRdEpq?=
 =?utf-8?B?TzJ1TTR5MWtNRk8rckYweE1PM1hJOUtKT01XVE9FT045bFNuTmw5K0J5VjlJ?=
 =?utf-8?B?RWZJZ0NSclNNaFZkVTRLN2N6MHl1TTFYbXFBY1BWV2s0OW9wYno5bzc0M2ZO?=
 =?utf-8?B?dEJsalpJa0xJZkJoRmpaOEFCakdHencwQ1lBSGxJYm0xQkdFWlcxK0Z2K1lT?=
 =?utf-8?B?eDBiS1U4T1E5UUNrZ2Y3OXlqMjhydURHRnRjcDk0aEhJYjZiRlRISTlVazNq?=
 =?utf-8?B?Q3JSQkwybjg5ckEveXhqaEdCRjQxYjBWYUYvRFgzak1mWXZuU2pGRkpwZUtM?=
 =?utf-8?B?bC9vTVd1Vm1XanhCOFFEMmRLV3h0eEtHdlhjVkxVT1pvUFNPSDM1UitwYkhv?=
 =?utf-8?B?V3daT3JSODYzb1BuaGJrZDNOeGtMc0pBT1cvU2JadG5RQkZab21TVEh5YS8x?=
 =?utf-8?B?S0c2RTl1Yi9mVmVBeUhJalhmcktyR2VkWDF5cFozTU5qS3NpS2ZYNzN2VkJH?=
 =?utf-8?B?TkxSVFRpZmRMZnB6blZiT1FyY0tQSVJxeEhudUt1VjNJVDJRRm5STW03SzN1?=
 =?utf-8?B?UnZOdXNEVExTOVUyWVRWOXNPVW1kdUUreXYvVEhBQWM0T0tISkkxbnptMDcz?=
 =?utf-8?B?b2JOSW84Q1haUHc5TWpYVERjNytqT28xQk1UczdPa3phU1NTWERVcTBiZ3JK?=
 =?utf-8?B?QlRhdlNwSTFiZFN0RUdIYkxVYXpRNHI0K3hJa25rTTNRK0trcElYM0Zxa2pU?=
 =?utf-8?B?ZSsyWmFNc3M3VzhNdzYrZUl0c3VNQTFBenRTbG1qbnRZR2Uvb0FwRzRwNnJE?=
 =?utf-8?B?YlRjZlhqWGlwYTNrL1ZYak5LYWVYNi9wVU5FSkIyYWV2d2RyYVhXMGw1T0lM?=
 =?utf-8?B?L2pnb0wxTHFlanBvTFRrT0V2ekM2Yk1RaDNZb1lFU1Zoa3JlYXFiWXMwbzV3?=
 =?utf-8?B?NXBWOUs0d1lUZWoySTdXZGJrVUFMclloZHE4ZlFORzBLaTc2angrOGk4cUpu?=
 =?utf-8?B?RzRIQlV0SVNHMGJuR21XeURiN1hqR0NFVExjcGd5SGJtM3BON1JvUUJvd0NB?=
 =?utf-8?B?UnZCWDZmbzd4L0E3Y1Y3MDlNN1hWY2Q5cFNWakJPTE0zYmEyN0hzU21aem9N?=
 =?utf-8?B?TmlhNXc0RWJQUS9ONDJrYi9kSUtaa3daek1teUk2aGo2N0diZ0hjb3hCQk9n?=
 =?utf-8?B?M2V3SDJTa1pnTmZrNXBTK2hWY2hEQ0pzd3JzMFRVcEVhK0hZb2NtSHI4VCsx?=
 =?utf-8?B?ODFQVTdaTmhXajNlalloaVNJckJNZVU1T3FtU1B5MGpDS1cwVTBzeUx0Y3dL?=
 =?utf-8?B?YnU2TndFb1dIVnIzL29lNjhYb3RYZFQ3clBqOU0xQlpBMS9KbmpuR1pCWjM1?=
 =?utf-8?B?QUdZWFMrOGZZSmxtakVzYmNjd2VERHdNTmtMcnFtRVBhcnB0VlJGTU01Y2Vv?=
 =?utf-8?B?M1hoZ0pmOU01dmdEdk4wMFMrSHlXTXVXV01ZZy8wZjhmdkhmT2wwYlltd3Bw?=
 =?utf-8?B?SFVzYWd2Wlg1ZzBjSXQ2MVpPVXplU25nVEpIaS8yQUpONFBpTmlScGVvQVBT?=
 =?utf-8?B?Q0ZZQkN2KzJ1NlNodGdUcE5RSGJ4YWJiSCtsc281NCsxYjJZK1dUTG56elli?=
 =?utf-8?B?L2x1VUUzRElBOUF5ZTBwVk8vclY1MVBtdHRjV3F4bkd0cGRRV3ArRUtoeFlv?=
 =?utf-8?B?R2UxMkpzVnZTalhVdEtrMzZlWVk5QnVSS1Bvazl5UXJnTnNJMzd1SHFoRWhC?=
 =?utf-8?B?bU0zSzhLRVY2T2lpZUFzUm9qTzR1dS9QMzJSa1JUOTQwbmU0eFQycHNENERv?=
 =?utf-8?B?STF1SmtWQUNkRWVVSnd4VFRady9zR29IOWplTUdLT1c2dmxSMUZ2MVNhV1FZ?=
 =?utf-8?B?U0Zod1daR0hsL09Zak1DOGlveDlRTGRDQWcvVVhtdkVHTm16MnNTWVZIbnhK?=
 =?utf-8?Q?n6FL59h5+xbAQs14P/uok1I=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259163a7-5dc5-47e2-fa24-08dcc71f9559
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 05:09:24.4961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwcESf7mAzDZ8/DYs8cTRvBYGiqmCcPjm757iJGEWKtpi3Zg4dLToQ/am/raqlqxNpmWGgvxEKxwtO7s+5G3ORz2czkmgzRedK+xZcRCkQt2x6Emd5k7ULrRCWmB1wAT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6506


All, I discovered a merge problem to perf-tools-next. V4 is submitted.

Steve C.

On 8/27/2024 6:50 PM, Steve Clevenger wrote:
> Add map_pgoff parameter to python dictionary so it can be seen by the
> python script, arm-cs-trace-disasm.py. map_pgoff is forced to zero in
> the dictionary if file type is MAPPING_TYPE__IDENTITY. Otherwise, the
> map_pgoff value is directly added to the dictionary.
> 
> Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
> ---
>  .../util/scripting-engines/trace-event-python.c     | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 6971dd6c231f..74b66692e3a3 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -798,7 +798,8 @@ static int set_regs_in_dict(PyObject *dict,
>  static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
>  			    const char *dso_field, const char *dso_bid_field,
>  			    const char *dso_map_start, const char *dso_map_end,
> -			    const char *sym_field, const char *symoff_field)
> +			    const char *sym_field, const char *symoff_field,
> +			    const char *map_pgoff)
>  {
>  	char sbuild_id[SBUILD_ID_SIZE];
>  
> @@ -814,6 +815,12 @@ static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
>  			PyLong_FromUnsignedLong(map__start(al->map)));
>  		pydict_set_item_string_decref(dict, dso_map_end,
>  			PyLong_FromUnsignedLong(map__end(al->map)));
> +		if (al->map->mapping_type == MAPPING_TYPE__DSO)
> +			pydict_set_item_string_decref(dict, map_pgoff,
> +					PyLong_FromUnsignedLongLong(al->map->pgoff));	
> +		else
> +			pydict_set_item_string_decref(dict, map_pgoff,
> +				PyLong_FromUnsignedLongLong(0));		
>  	}
>  	if (al->sym) {
>  		pydict_set_item_string_decref(dict, sym_field,
> @@ -900,8 +907,8 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
>  	pydict_set_item_string_decref(dict, "comm",
>  			_PyUnicode_FromString(thread__comm_str(al->thread)));
>  	set_sym_in_dict(dict, al, "dso", "dso_bid", "dso_map_start", "dso_map_end",
> -			"symbol", "symoff");
> -
> +			"symbol", "symoff", "map_pgoff");
> +	
>  	pydict_set_item_string_decref(dict, "callchain", callchain);
>  
>  	brstack = python_process_brstack(sample, al->thread);

