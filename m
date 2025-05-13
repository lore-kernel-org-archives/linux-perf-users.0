Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624791F8BBD;
	Tue, 13 May 2025 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747125158; cv=fail; b=TJPnTe+7AwM96ic5o0zLlTBS9pUiN/QwjK8e/YUFg8r72IunEQ6DNPBSozlXBH79LaqfaNu7KyXGsPo0/W3axpP1R4NI9/7OJO/OzAwUUu3EaPzVvZN2F189mKHfwsdQb6rDxkkE9OXomgr/fOc5pnFyvKqqr9sYCIMxIT/r7KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747125158; c=relaxed/simple;
	bh=gmWAUNr+jTBdO7ShQHkWOwwuYua13BZ2/FTRcwGscD4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BwMOtynHIQmWCGUNjvXjfkUALKexIwexH+g0S/rDc2W47cVDAUMt18pFXEfcDXWx73DCaUBkYEHTfPa5hk1Kqjrt6SZVn1qmeat9gTQ16o2I3Z4hlI6CbPRTiNXPId9QnDJysbKhJK0jgD8NAsWzejk8pcvPd0hCmNwtRKEGFWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dq8dQmTq; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dq8dQmTq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mf6d0EfDqwOtSF5FBXZqhP7WD8nHJDy8/Op/2uwHdIV+iZRkIM1JK3XXa2rcmxSPYIpot3qyOpvQ/JqNC2JdUOfy9rlOf1f1lZSOSsy2OlRYhCpcQD509dyPGDohYxpl8iZGi4fcRWpEePURLSlJiQvtTz+ZYJbISUB9EX7CP3WM4P2x9YU4xAeBe2dEf3XLIr5l8D7ec47tMtNWJUoCF/aL4PbK137vyVRI2PnvtX9cQ8CTqRd5Fuwpo4vvCj5ahR9YIFBJfMHllBnoUKZNt8W66FdNzMp6mrT/W573qTghhcxAil7cYIEl6nH/yuTsWFT2ysi/vXrfQzTMABcEIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edeANQAG7ataQvKpSiIDcf/Te5PT84EexKH3MAaX+Rc=;
 b=PyvYG/BnYxZOrJvpY/efga+XKmQPE7DW9CpTzGAkSS5v95xI/0087qhtHX7rimM9anXWsScWWeSFaVhOpItFBSpLfKM3BG977HKkQ8dhNa1M4aQcP1znkUsvETkfcsM+BtZ67oMRyd3Klf3MfKCpW9SxTzoj5Fu6TcGsRWH11e5t4Kl47nSC4+E/lpCTUpMkvmBGOuSpwFEG22Za+P7D3Upzjhyi6dHT34o7Aj/fpoOqIym8fe1bzlto0jDdzjvQAd71eBfAIAYbTN1pCgkQ0W4r50IHaTu6RW06kUlEmYlfMNRSylpT5VLcERgvN2XmRCbPbEV36F9ZnpS45vfp2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edeANQAG7ataQvKpSiIDcf/Te5PT84EexKH3MAaX+Rc=;
 b=Dq8dQmTqSNTCWYaacRBscGy/gHJ5YLEYwfRuZ9S7PpbS5cSaDaIq5ohOIFWHepZm3MOXBFLwBTfxJ2+vzZ7m6TK3ameFmfgyPBsWKROKcbG6k2nDsxuyGh+5GYyrS+u4J+BgXZyDs8RFYZipz/MLcz6SVYf/tsSerUBTnhm3x7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BL1PR12MB5947.namprd12.prod.outlook.com (2603:10b6:208:39a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Tue, 13 May
 2025 08:32:34 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 08:32:34 +0000
Message-ID: <bd37947e-8d0a-452d-a67a-ea964c6a2985@amd.com>
Date: Tue, 13 May 2025 14:02:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] perf/amd/ibs: Add Zen5 support (tools changes)
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
 <aBGEPnB5B4NTaOg9@x1>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <aBGEPnB5B4NTaOg9@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::17) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|BL1PR12MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: b35d3042-32f9-4acf-00b7-08dd91f8b555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGpuN1prejJTaXRuT29KRDlZcmVFdXBTc05DZytuL2kwek9NaVBPVWJaNUt6?=
 =?utf-8?B?VjhEUk9WMTh2TjJzNEJlV2E1bkVmN2dPVDhsanZuc2RPNmRqVStCeVN6c2M3?=
 =?utf-8?B?RFdwYXlvdUtHS0Q3RFBJNVBMMnRod0x5SXBRNDhUa2hGNW5VOEw4eXVjd3FZ?=
 =?utf-8?B?MFIxa3ZmR1R6VzcrWVluM1RIcWVuYkV4SmVsUjVRV1VnVFVXSTkwTEd0MlVx?=
 =?utf-8?B?aUVpVlBSb3o3eit2NllwQjJyQlZQWXhHRDZDUDZkVG91YTYyRmxIVFFXK2NW?=
 =?utf-8?B?VjJMYTVSeXUxa3pEa3FDWm1NK20wc0pWZTFhZlhmYW5wWWFpNkpyZ3M5bWZB?=
 =?utf-8?B?endQU2RqckVwT3hGZnVYOUlyTXFmekVSY283RTY4UHMzS0FPZnA1Sk5acFZm?=
 =?utf-8?B?RzVWcFNCZzh3alprelk3cGM5djNzalByU3kvRnM0OWlkaU9kNzVyVHFkN0Z1?=
 =?utf-8?B?T2dDNUppYWd1MEVBdHptdkR2VmhOQmduNWtWcnYrcEhPYTY2bVh3SEZtelhq?=
 =?utf-8?B?bU5CRFJLMDIwd3QvTTN3bFNSTE9JM0grclpzbTZQQ1lHWTQ3alcxa2V2QSta?=
 =?utf-8?B?bVN0VUxJS1FwYWZGbHVpKzhZUmhjdk1Ea3hiblBYSElUc2QwcWtYTGkzaC9K?=
 =?utf-8?B?ZGhzKzNyeXVhcjdILytJV3lLVjFDOUFGOHNIeGlQS1VLMHBlbVB3aGcwRity?=
 =?utf-8?B?c2dQdSs2TGR6eFJSVEQvQzcwYUlDNXZVYlhDQjczbVJSeVB1RjdqMVNpdmEy?=
 =?utf-8?B?VmtKUHNwdTEzdVp3QzIyWnR5aThsS0hsUGRCVEdtZWtMbExwcFhUdVB2Rnpz?=
 =?utf-8?B?N09PMkU1OFdONWZJenRJUmF6UURsd0ZSSU5HRGxEcGxMd3BhYnZOaWhaSk5r?=
 =?utf-8?B?aHZEenJOYkRWWFllcDlPaHNaTFk3VUZKOUVwbG9nSUxuU3htdS9ONXRDbmM4?=
 =?utf-8?B?YjRseU51cjMwL3FJUHVucTgyZ05XeldsQk9yNFZ2YXJRaXVvZ0huenZhazd5?=
 =?utf-8?B?MndLSVBsQ3pkUi9PTEdNM0lpM1VUb1M0eFc2ejlnaEI1Y0xwMHEvdU9VQlR0?=
 =?utf-8?B?WlJENVZqQllUUFZVb3VEUFJLcVI5eGlIYXBSSWJTZndia2k5U0phTkFhdHEz?=
 =?utf-8?B?dnk0WjJmQnJDS0NMbjRyQStqKy92SlE0T2ZUTUhaZ1EwQUtiNlpYUEFMT0po?=
 =?utf-8?B?UjNzcmd5NFN6bDE3NzFMRmoyU0pHVGtpMU9ENkljWDRRVWh5bUI0UmtKQkRu?=
 =?utf-8?B?RjlkZzBRRTIrM3BMRmxzWTNiL2dkbFYrRXRzQWZHcnVRbmFUeEFTdnpNNTY3?=
 =?utf-8?B?Q3g4VlZtOUdZV3g3Y1BEbGxIcjlkQWxTdUsrMFQyUHdNanZBcFphTFR2MHph?=
 =?utf-8?B?SzZTRlNNWCtGL1VUQnU2b2xpQlJiNUFxV2NmKzBsZ3oxaHBHdnRIUDRneW4w?=
 =?utf-8?B?Z09uci9pVTdGdk85ZXNDa3JBUmdaWFpXYlY3WEkrc3RxOEFWYmp6b21XaFpK?=
 =?utf-8?B?TEl3REtWVG1MTm5tODJwNTNHYS9LL0lRR0lUdWRsWXgvalRUWDV0c2tObGNv?=
 =?utf-8?B?RFh1YzZBOG8raXVscnNicW1WSnBFeXZGZUlKQVJtNm9lRFJNRDFybUZQRzZh?=
 =?utf-8?B?VXpyemo0Q3JNaDRDbnA4blhJbkJzLzQ3dXhRS0VlYkw5VTdTMXdHNjl6Wkwx?=
 =?utf-8?B?OUZJSExyTHVvRXpEMmlHY3lRcEo0SFZyTlpyenBRSnl4MTJOaFVRZEJaKzZa?=
 =?utf-8?B?TGhqWVEvWis3U3pzRDIxeEQxQUoxRFVYWGtHKyt3UStUbW9QT3ArZ0FPOGRV?=
 =?utf-8?B?c1YvdDhUK2RlN1lFM2hMNmFLeTNobVpCdllwUEtDNW53cFBPQ1pqOTB5RnZv?=
 =?utf-8?B?SGZ5Zmg3ak5lcG0zd0d4OXQ4ejZJZHljM2xNUUNnWHBpVjdVdVRpQnU3aFJQ?=
 =?utf-8?Q?cWbtbx7vQ5c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGM4UDEvMnM4MHROcmFLa2Y1WTFEcHM0WUN1VEtFUzlmMkFGTG9YTFEwQ0hr?=
 =?utf-8?B?VmhadFRkL2pWaUlvdjY2MjNiZ0k4MXBQSUMxR3l0NjVxdEo5bVdJeVhkY1dQ?=
 =?utf-8?B?YXVCM0VJekV2NWtwS2J3U2xlSlppejR4akZuL0xtNUZ2ZURtaUhyU2ZPcTRx?=
 =?utf-8?B?Rlk4VDJZRDZ3QUdWTFR5NVpva2t6dWg4aThIeWp4ZlJTUjNZMkN1RmQvUm1S?=
 =?utf-8?B?azRFVkZ5clpGRU1yUW9pY1JOdnpMS3E2SG1iRzlRMmlRNC82QU1qaXVHTG1t?=
 =?utf-8?B?Z1VtclpPekdmTE5ZcjhQMVJrbjJnYTBkZHdDekFqUmh6bHQvYVZkbUR3TUZB?=
 =?utf-8?B?RCsrLzlaNk5nWlhJUWkxK0ZwU1JTZTBhVkJvWDEyZ0VHZlBrRHlocDY3S1hm?=
 =?utf-8?B?QytBOU9OUCtZS3FBekx3QUQ2NmFtemJJaFV2MlhZNjV1MTVlRHJDclZ3WXFh?=
 =?utf-8?B?ZUp3aWMvSVArbVdJVVNDZzVIVWpGazZYZnNXbFBZaGdxT0NINmxtRjhVcVJw?=
 =?utf-8?B?VW1sZHh3UUdiQVZrSEVEc1E3bktYQzVjd29Hd3RYUFo2a2gxZld1NXFVUGFh?=
 =?utf-8?B?eXk4b1o2bXowd3c4K0hYMnk3Tno2K1hTMHdzdlltZ05UN1M5a2FoMVUxTi9M?=
 =?utf-8?B?b3p5ZlQ4U1A5QVJyam1JUHdsZGRWV0dZU3ltbXpWMVp5dCtRYVdNRnNxdkFV?=
 =?utf-8?B?NEJiK2pOb1BETjhhSkFTTnA5SEh5dktEbVVpM0tTUThRc0pnUDQrOHNWcGYw?=
 =?utf-8?B?OEt0OXI5L0t4eGxwMnlTVzdzQUhPdXREUnBCRGxCaDZrcEVHekoxMkUwWHdh?=
 =?utf-8?B?NWQrWmtlazhUTWhBRlFyS1JxQTFhdllNa01uNUdKL3lVd3FJME5GTGI3WmhK?=
 =?utf-8?B?ejJ5c2x2V0tsUGtjTkMwL3RMeUxPV280RFF5TjJkWC9XdUFYWXhCNXRLVzlC?=
 =?utf-8?B?LzVmaFo1ZEpRbDNZTURuSjh5aDF0bnZQeUtqQTZVSnNTVVFhVVkrRU44bFRX?=
 =?utf-8?B?d2lYeHlSSm9Nc3Y1bWR6VGVEWmRHNjVMY2R2bk1OM0lieksyT0FPNmVmSC9z?=
 =?utf-8?B?NjdWekhkdFAvMXRkL0VYVmR0ZmFnSENtRUlGWFpFRFh4Wk5BbkJwK2o5YW1B?=
 =?utf-8?B?MUxZS1dTZk1XZkRvUEZvNWd0aUR3Y2YyVGVDbXRycHR5aTBpZVR3TnptUU1u?=
 =?utf-8?B?Q0pONDI2R1FUTTdnMElwb0xycXNFdW9YdkN3ZWRlV0k3QVFDL2V2VkYzMkcv?=
 =?utf-8?B?WWZjTSt2R2M1OE5yUzlOSDROZkd2Znc3TzB1RWFHN2loL1MzNTRyMUJFc2dw?=
 =?utf-8?B?TnY4UjNGUExmOW8rUWlKdWE2Qk1EdW10aEpGcmZPM2RnZ0FUaVRZN2tHcDNZ?=
 =?utf-8?B?UnFwd1BYZjArN0NjaWFzWTBwVU1aTDVHYXJ4cmIwMmtDWkhGZSt3by81cE5Q?=
 =?utf-8?B?SjJOZVBWQ2ozUzBPWURBOEFGMWg0VTJabEdpdXpHTUl6TGhyRmdMQktXWGhP?=
 =?utf-8?B?UjZ6UXl2cmFjTWdUc1VKNndnalZCU01UbjRzampJcjlzZFg1TkR6ZEZGYTdJ?=
 =?utf-8?B?ZXo5NkRxdmlOZ1l3ODY5WDMwUFpCZHMwbVQ0UlUvT0dIYjFaajdBU1pvR2dC?=
 =?utf-8?B?VGpqb3o5UDZZd1doNVFjS21IeFd1ZE1DU093cTZRWHJzWDZ1RXhXTCs5QVIy?=
 =?utf-8?B?a2RBOThFb29tRkNKaUNEZGtFeGF5UHFtUUxvaFY1SnZCdUkySmVieHBlemRo?=
 =?utf-8?B?SjNlSlM0UEtXblNSb3Q2TEoydHFLOEJuTEZaSWRiRjgwcC8vZC9YMGlhakFs?=
 =?utf-8?B?RXZHRk8rVHZhMjZ1UFgvVU5NQWtUOGtLUTJmMHV6S042bnRLUFpYejk5NXRQ?=
 =?utf-8?B?VDJDOEEzQmo3OE1kRUhIejJZMWMyUVBDUTg3cFFTRngwaUFJZFhoVmc3UFh3?=
 =?utf-8?B?Smp2QytjeDlNVFpKamVXRWExY1Bod2dBdXNYdVpRT1oyT1lRN2lqdUtzZ1pB?=
 =?utf-8?B?RFkyeDJINFBOMlNIUUU3NUQyeDhPTFV4dm1abnl1M0JoeXhDeXdwM1hCMkxs?=
 =?utf-8?B?Y0kwVkdPbkFsQURET2tMQ0dtUTgwL29PdU13ZVdWbVQxdENmbldHR1FjNUtt?=
 =?utf-8?Q?5qWLegx8SEFRQfNHkpRwo8eA5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b35d3042-32f9-4acf-00b7-08dd91f8b555
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 08:32:34.2929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9rtylYFz8+MQ6kORa0C6IDAecFaiqAG5UpZDUF0WhnjrIz761rWRpzPiGJG7IXd8gUyXPbrEPOPB6PPAxloRuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5947

On 30-Apr-25 7:30 AM, Arnaldo Carvalho de Melo wrote:
> On Tue, Apr 29, 2025 at 03:59:34AM +0000, Ravi Bangoria wrote:
>> IBS on Zen5:
>> - Introduced Load Latency filtering capability.
>> - Shows DTLB and page size information differently from prior generations.
>>
>> Kernel changes for these enhancements are already upstream. So, resending
>> tools changes separately.
>>
>> Patches are prepared on perf-tools-next/perf-tools-next (85447f68a1e3).
>>
>> v3: https://lore.kernel.org/r/20250205060547.1337-1-ravi.bangoria@amd.com
>> v3->v4:
>> - Remove kernel changes.
>> - Improve IBS sample period unit test
> 
> Preliminary tests with what is in tmp.perf-tools-next:

[...]

> I'll do more tests tomorrow and try some of the workloads that Joe uses.

Gentle ping, Arnaldo!

Thanks,
Ravi
