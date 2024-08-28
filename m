Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022078.outbound.protection.outlook.com [40.93.195.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3BC1B969
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 01:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724809295; cv=fail; b=pJe+YMXDV8xJiZsO+cM9mRBtL9z9qNMfCwcFBQtZ/Xr1rzV+3jABMUxaZflhkFjoaOJjuT158rbjWqPkIiDyXVGQKv8ZFkt1oSmgOBn5ISD+k9+F14u9E4aSb8ZKnKbh15/0Jn6S9scmP/SNegCXFR3k05abE0ac9Oj0h3SVuqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724809295; c=relaxed/simple;
	bh=2UdKfgiGopjWl9SlH11/LMtfoJuKFhD9KtSH053aKKI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FVuDHyKrZv+GNhBEUKjhEhX7iYYir3gc86zf9AL2CtDN0AWvYMQ1ki05DKXYtojQidNbsGt9pY5ceoTFWX+ld2kNRVmgatx16PyfQ96PLExX+TVfBHkFDIeHGR9Mfa2mdjbwd/Y0zVJRAyxoRmsscQYZW59IiL+5RibrwFHiEHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=FAZlbyaa; arc=fail smtp.client-ip=40.93.195.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="FAZlbyaa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4GdXbuQzAtCU+PTvWtSJEz7I+3+piF7XLo81W0+bdq9BnQLskG3GvDrgrjlDBSMefMkVXUeMOO5cRbDhLBi71In0Q5LGzCMEiGIFhF3aYkessgt1wOUJjUAG4p4lDea+Ftp6ShEd9ijBYhhY8R9S/Roz8JiVYennq+Zgc6SbA3L4r17ckHSEjwMJJynctiLfOqKTNsf0MX3KJdri0UdIfD39Lc8w5jpw/8NoM6NFosx/KMnbWAFXzMwRS+nbc+VDquvJeZlmsIZKjxNI6zEoburYz5J2Z8LAdLDpvwGg2mR/97VjkMZfMVEF+nZKs42UREb5N6HxuLTmBGVnhS4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRdVpnLJr5bBnCna/mvFSpavvzn1eswPW064YLt6k9Y=;
 b=KUZtTxRl5kHKLjJhIVPU9iYAcllfyD4pw39A2FlhT7z9jJ3gIbEQRtfCrs9oI/hkSCoSJ1pKzzw398lR+SuQrHnpvEkQ58fC/1Yfm0ovEIDrQKdDurnBO2B3hfoCdEo6jcllZPHIRZF7lKQaPMdfGq0Ajgzk+qb2AoueFC5if2o+y+Q2UkRvwJSssu1Ew9BI76XTg744y8r1nzcRuLwxp1vO7Lntu8T74ia0LQ1h6jOBhnbXxYQgmyzueBuPmtgmp7Ja9PiauAvpZmBl04pTxwYBMDnQuMcGbUEhKWZJ2yIlTBa56yqoJXXSyr4KnDA1NMqOt8Ks+bkixoP0KnnS7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRdVpnLJr5bBnCna/mvFSpavvzn1eswPW064YLt6k9Y=;
 b=FAZlbyaaEe7OSTV8P2KGLHMMTOIAfV0MGTXRDOGe5l2sOJ7o4jeWN/IkE+IaXPf7mB9FMsNOCemGcMANEy3sR4ssE5vGjJldgGyjMyUUk9L7KgTvR5XXO/zOG62ejy2exFzHo27C4vlqmiyRDPmZJ5M4s5PKu7xOcx1uc2Fi1BE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 DS7PR01MB7568.prod.exchangelabs.com (2603:10b6:8:73::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Wed, 28 Aug 2024 01:41:28 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 01:41:28 +0000
Message-ID: <9c7fcc8f-1475-42ba-8fb4-e4e76c56d869@os.amperecomputing.com>
Date: Tue, 27 Aug 2024 18:41:25 -0700
User-Agent: Mozilla Thunderbird
Reply-To: scclevenger@os.amperecomputing.com
Subject: Re: [PATCH V2 3/5] Force MAPPING_TYPE__IDENTIY for PIE
To: Leo Yan <leo.yan@arm.com>, james.clark@linaro.org, mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1724698250.git.scclevenger@os.amperecomputing.com>
 <2ed246c95cac628cffc1628c115a4b791459f8fe.1724698250.git.scclevenger@os.amperecomputing.com>
 <9ab26232-90af-4e6a-9960-a8486f0d7bf5@arm.com>
Content-Language: en-US
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
Organization: Ampere Computing
In-Reply-To: <9ab26232-90af-4e6a-9960-a8486f0d7bf5@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:217::19) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|DS7PR01MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b7e0326-89ff-44a8-59af-08dcc70288e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGU5SURNbUxydzJzZ0FiR0tlVlBxeFFXaXVMMldmMVRpelN0ZzJ5T1dxSktS?=
 =?utf-8?B?cWpFVGIzZjFKN01rMEdOemhuUEdQOFc5a0tFZkZsOEVJVjdXNHRrcWJpdHlr?=
 =?utf-8?B?d3I4NlpDREhLSEVUcjY1d0NTTDZweG5xOGVEYituOE1kbWRlRklCTkQvVVBj?=
 =?utf-8?B?emEycWR3U21CaXFIcEJ0UTZnd0JuWWl5S3ROcG9LaVhJSlk0aFRqSGUvZ1pM?=
 =?utf-8?B?OFJlQUpZRFBVaStDb2RXeFpNSU1lN083Nkk4dnpxRFhuSDA1N3dPdUNxdlJE?=
 =?utf-8?B?YWxITVJaVDlJcEZTa3VqQmJGK3Nna0dlYkVCNnBLWVFaTXpTMXZQWVl1bXQ1?=
 =?utf-8?B?YklHc2dPOTlWUFRjdzExamgyUFl6MVhaNHA0eENlUE1NSGh2SHpuUUczb1h5?=
 =?utf-8?B?VGdtM1Noak5CMFY3UmhMRFdYSnliUXZzekJWeTRtVkFuUmNGZGdpMW5TN1lO?=
 =?utf-8?B?QmdUWTV1NzNyQmFuWWNCd2MyYmg4RTdzd2trMlVMTVUzelorTUJSQWhTZTAw?=
 =?utf-8?B?U2IyaytTdVdtRkl4eXlEV2c3TDRCUHh1Q2cyRHRENmFMM0Nza0JWWjVwbGVU?=
 =?utf-8?B?MXN3bTZoK2JGdENBS2swSGZMNWRMeDVJSHVISHpxNEpKSXhmemp3L2RZcSta?=
 =?utf-8?B?K0Qrajl0eUFONzgvbTdBMHhWTDFTUUJOeU1zV3RIcmlobkY3d2dFbkhCRUdk?=
 =?utf-8?B?R3RKSUFOamxEMW85K1F1ZzRKdUh1b0hlUXB6SmR3L2F6ek4xT0NueERuK3hB?=
 =?utf-8?B?MXMrZU9PSnJWNTA2TEVlVmlIbUE3K1dhSjVRZENRa1hsa2Jhd1JmUkFib0FE?=
 =?utf-8?B?QldNb3ZZUTB1dmI0WnNFUlVab05VWTJwdi9kNEV3bEpJVnZKSTVFWUVtcjZt?=
 =?utf-8?B?Y3RDSzRRK3l5anRkbE5STW1oSWJjMFA3eFJQdzNiMWFlYk1VeEdmWEJoeHY0?=
 =?utf-8?B?R3VsRyt3SytQdm5PRmdZanRYRlM2RzYyemlpeWZBaVg2WG1pT3A5eDRkOVhJ?=
 =?utf-8?B?WGdJZWVVUlJCU1J4cEhWcVQzVlpobWRCOGVuaHk0ZnJWclNja2x2ajVOV0or?=
 =?utf-8?B?aExTTGhRYnZpNlpXMEkrOFpmUG5meG1xeUQwaEFTS0ZMTUROZnNzQll3TnNI?=
 =?utf-8?B?QUo3UkY2N1JlZmtSUG9aYmdzcSs4SHFibUJlMWxPMnlEYjM2aUxVUnVQYklt?=
 =?utf-8?B?OUxMKzhyOGtxams4aXlabS9sWnNTYUF3SHE4WTArQStoSldyTDRBMFJrNGVM?=
 =?utf-8?B?R1dTYnpwd0VkSkM3b3gwbmZFZTBKUnFFaVRTeFlGSFBWekZrWXJwc2txa1lv?=
 =?utf-8?B?NC9rMzZHaFcwSC9sMVhZLy9nNnl2cnJCOU5Tb1doekhXdWlQdDhoL0k0SUFj?=
 =?utf-8?B?K1RaZEdvaWxqdVJmTW1RZ3JGZ0lNWkdqZFZJS0x0VDllOHAzOTNFZDRCZXBv?=
 =?utf-8?B?bmhZa1BqQUFXa0xOVVRwUmR2Qy9HQVdkdGIwOG1iV3ZiZ080YkVzeUdhc3N4?=
 =?utf-8?B?QThOd1lLc3JTVHdpZi95WnpvMWhqck5xRzBMMGVCdnBrdjBlVUlNRlR5RHFj?=
 =?utf-8?B?d1pweHdqOGZZck8rajMvWDZ0bG9vU1ZaUVUvalpaQXBTRHBjZVdOYTMzODQw?=
 =?utf-8?B?NDlVTllGUFF1ck5IVmVvSHhlUmNMcE1UVWdpN1B0bU9IU3hUeU1JRk9ybWoy?=
 =?utf-8?B?dTZHSVdlL0hhR0wyZlhWVVlrWE5IcS96YXdVSzFmZUhlY0FDV2tOWDRuWkRt?=
 =?utf-8?B?Ty91Qy9WVVI5SjJRUml5Z1M5ZWNwQ21mOXdhYk9zcmlsdittbXQvbllIbGtC?=
 =?utf-8?Q?gtCjDpI3LHcyaq+Ff9NCLoCbX6/E2QF/xN+7Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0VRWkxQMmpxa252SlVadWFwenU5OS92TlhEbmRGY1lXcHM3S0pJNzV4Vndw?=
 =?utf-8?B?M2hwZ08wdjNUMitPbjU1VTdnQnM4UXZPSk5Nb2t5T2JJenhlWG91Z2VuOUdz?=
 =?utf-8?B?WC9TakVTbURBanQvZEI5cTU5Qm9CSXJDRkEwYUt0WSt3VWhCbmNtaGUwUlZV?=
 =?utf-8?B?TmNvZ09lQnFaalBXbXZPWGdNVXdxbXlLV3dtN2hhUDc1eUtkWlVoU2dLaTRv?=
 =?utf-8?B?YzVmMjFpY0thYm5sMkw0QlNNbHRxY1pzSWpIUVRwTjFvVzJQc1lrajY4RWtx?=
 =?utf-8?B?VHJOLytUQlh6QUFtNFFjMlhuaHhoN1I3cEYrT0MvWTh3T0JvdC9Tc040alRW?=
 =?utf-8?B?aVhybEtBSGFnbTJxenEzQmtBZEJqOWJUWnF0RDlJQXVqSXVqWlc2MDE4T1cr?=
 =?utf-8?B?ektaejN3NUt2cHA3YlJpb3VhWWd1WFNwSVhvUlFhR2dtNEIvQWpxOHdrWndk?=
 =?utf-8?B?ZWM3WHd4bmhjTGVQcDk0MzRaaW02WUpmcGdqMGtrTDZPUXFUazdKV09NL1J0?=
 =?utf-8?B?Qzl4b3RCeGZnSnFtVzlvL0NOUlk2ekJqTVFxa3MyTHUwSE1kdjRjMVdBbUNC?=
 =?utf-8?B?c1BaWkR3ZWlWZEloTVFjaldEdzBweVdObU1NTnZMRzdRa294KzRpTlVJZGw3?=
 =?utf-8?B?eWFHRjNQd3NWZ2hmNHNhRDhQVmlBcURMMGlZOXVLS2dRN1ZKRXI1M3RLOXdk?=
 =?utf-8?B?eUZ4MWxMcVhwZXp0WFc2SFJib1cwYncrNnJneGpWYkNkd3ZUakVyMUdCcERP?=
 =?utf-8?B?cldDU3VPdlZXL1ZHMlRBQUVNS2JUWXk1bzJFRkFUL3FhbVNyQmx0Q2xhNlIr?=
 =?utf-8?B?dm5ialdOQnU0OE1kNXMzak1GVm51SGRXc0QzMkNLU2RnbHdXaGRtdzNNMWNj?=
 =?utf-8?B?Y2g2RE5KbjF2TWdEYWw2aFhBU0k0dDBOUEM1NlJhaDZ2M0IxREd2enZkTDh6?=
 =?utf-8?B?T2lNQ1hmSFArUVJPKy9FeVI1Q09iWnkvT25YR2dzbm5BVDJqZ3BWelh4QkhM?=
 =?utf-8?B?RXNnQlc0bVo4Ry82eGJXNS9adjRlWHFkUy9na1VXK25ORG5mQXJtNnJDclNp?=
 =?utf-8?B?Wlo1dEFuS3UyRm41eHNFanI2YngyRmpMQ1BSU0h1Nk1RYklPYTlra0x6amtC?=
 =?utf-8?B?MnpEWS83YUVkZWdkLzdSY1NrRUFjd1lkY0pYczBaRnVIVmo4L1VJMG5BY0VI?=
 =?utf-8?B?c2ttdDZhNUNOak1rbGVtb21Ic0lTQWNYY1luU3gwLytxWjZIVUx2RkljTVVH?=
 =?utf-8?B?ZGthWGNEemN5MGtKaVFUZ1FvRzhZWGtES0pEa2U3QS9kSlgvODAzdHVnTDU0?=
 =?utf-8?B?WGRHczZ2N3FxdEJGOW4yTkZvbjU3TTc3VkZUMHBGNktST1lQS0Y3MGkxdzNT?=
 =?utf-8?B?eGxhVVJ2NWZzeEljNDBFcUxubGIzWkVRT0RwMW5MaEw3NkZRdW40b0pPWjFt?=
 =?utf-8?B?VjVRTnhqeUN6eXpCYmFzSFFkWVlHSzRObjc2NXdRTkFWMGxTeGdVZ1dlbEcx?=
 =?utf-8?B?Ukk3L0JlSkFONTEwS0NvZDlYUFRaWEw0TzdWV01uL2FIWW51TjNDempXUTl2?=
 =?utf-8?B?ODFBSEtGMnRuSXRkdVRGaHpzTk9JRWR4Y1ZBbDFVbzkxVlErUWN4MTgvTjJx?=
 =?utf-8?B?SURxU00yTFRsd0h4NmtTQUhMS1B5cjVmcFRYVmwxUStDbW9IVFFtUlh4ZXdn?=
 =?utf-8?B?U3poWnRCeTJ6QTc3QTk0UHZLVytkcFdLaW44QzhCL2JuSXU4WHhuY2pjamdm?=
 =?utf-8?B?ejJFeXZpRm1YN2t5OXI2TnBwdnFPemdmdWZuVkJKTWdxdXRIUGZndlpTdUJv?=
 =?utf-8?B?aGxLRjVFaXpzK2lvWndsSUFsS1NoM0tUZE0yaEJKRmdORFdQSVQrZ1lzL1R2?=
 =?utf-8?B?VEFXYlROS1Nnc0pwM20yb1o1WUcrTU9EMG8xeVZOLzA4bURtOEg0d0RlbWRj?=
 =?utf-8?B?bCtjeWI3aWltYWx2Z1EwcmMrVmR2ZjRDMVl6VUxvVXFGUzAxZndBZWs3OWp5?=
 =?utf-8?B?NFBwVEp4OWdSN3Z4WVNHdG5LVnI5NG5KZG0yNk5GRVE0eUZDZ0w1eEZJUGxQ?=
 =?utf-8?B?MGxaQmtEWHc5dTF2cEFCU2dvcHJ6UW16RHdseURsdzVGbFVvanRLb1ErWU9a?=
 =?utf-8?B?UjlkN2s0V0Jvd2VZT2RRdHB4SERjdi90L0tRb3JMbXFxMktzU2hwdkUwRzhj?=
 =?utf-8?Q?zf7ae/WZ9LKDWkBpReT760E=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7e0326-89ff-44a8-59af-08dcc70288e3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 01:41:28.1350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/Dd4rsrIqVA0T91ImGMdsxdf8xMbXFUKWWaQ7GkQ+lrzCBSJXwXjgREJ1fESXzW+k6NyxkWKN0Lxdss5Is25Ph4y1AeU9dCjcr5rWeGbOrtrzmgK07jc544R7ItaKv3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7568



On 8/27/2024 12:55 PM, Leo Yan wrote:
> On 8/26/2024 10:35 PM, Steve Clevenger wrote:
>>
>> Changes in V2:
>>   - Updated mailing list distribution
>>
>> Use dso__is_pie() to check whether the DSO file is a Position
>> Independent Executable (PIE). If PIE, change the MAPPING_TYPE to
>> MAPPING_TYPE__IDENTITY so a zero map pgoff (text offset) is passed
>> into the script.
>>
>>
>> Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
>> ---
>>  tools/perf/util/map.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
>> index e1d14936a60d..df7c06fc373e 100644
>> --- a/tools/perf/util/map.c
>> +++ b/tools/perf/util/map.c
>> @@ -171,8 +171,11 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>>                 assert(!dso__kernel(dso));
>>                 map__init(result, start, start + len, pgoff, dso);
>>
>> +               if (map->pgoff && !no_dso)
>> +                       no_dso = dso__is_pie(dso);      // PIE check
> 
> Here the logic is whatever the `pgoff` is (zero or non-zero), we need to
> always set the mapping type as MAPPING_TYPE__IDENTITY. It is no need to check
> pgoff and is no matter with 'no_dso'. So we can simply check dso__is_pie() and
> set IDENTITY flag for the true case.
> 
>     if (dso__is_pie(dso)) {
>             map__set_mapping_type(map, MAPPING_TYPE__IDENTITY);
>     } else if (anon || no_dso) {
>             ...
>     }
> 
> BTW, please rebase the series on the top of the perf-tools-next branch [1], I
> saw this patch has merging conflict on it.
> 
> Thanks,
> Leo

Hi Leo,

I combined the dso__is_pie() call onto the end of the existing 'if'
statement you now show as an 'else if'. Please see V3 of the patch series.

Steve

> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
>     branch: perf-tools-next
>> +
>>                 if (anon || no_dso) {
>> -                       map->mapping_type = MAPPING_TYPE__IDENTITY;
>> +                       map__set_mapping_type(map, MAPPING_TYPE__IDENTITY);
>>
>>                         /*
>>                          * Set memory without DSO as loaded. All map__find_*
>> --
>> 2.25.1
>>

