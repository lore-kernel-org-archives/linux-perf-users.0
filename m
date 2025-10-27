Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020134.outbound.protection.outlook.com [52.101.61.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31452D9EDF;
	Mon, 27 Oct 2025 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555773; cv=fail; b=pG7zrCozOCIy847Ljv8AHPjaSJFB1y11/e6fSeCO57VGL9jqH9sXfwI1SSlRx1V1zHLzf4RthIznAQbXqNS+Q3ZYyuxH7Z3s2c5ZnDSZ6TAr3eRw4wVdjxBcpNP/Xvu5Ui+TPGELxtAL5aCVlYfnSe/DrcI/5DECszu69GE/Rag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555773; c=relaxed/simple;
	bh=DRQq8MGnaC5AbOBzBqQ0Bd2jeoDIAwHq0HstjQZddjE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BHKXVfDaQwfwNC44DDexPoqta0MwmtpbCH6SAG8R2MpApYU1sq6d8+Ohxgv2G/DiYgndDo1PuF9XRqEDerv/fUMTziFRJRut4CE2k10yWaxAcDBC0r8aLE6FRkRnsfBvcP6yu8ez8nNWXfyzoMUhTdF0nJD1Z6Uw+amauExbiw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=0layrOce reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.61.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="0layrOce"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+uaphcL0ezGnqeePD07++dQ90/pqiDxyCRIUeBjGd+wHf5fFz+ZCzhPIAMXXGo6mE9IfQeSegE8fJknSeuUdx2v8k4zJnZqNXUiFwl2kyYYDPpDRxKLWAeTt/mq3nQInBXQKao//G1s5feSyD2vMNfposPFXYYqL8MV/e59JZt7ITGO6v00E4tVNKc66WPrBKdWE0zr725aQbxFqEyCFWzl5ZjGOt97aefFuXFkeDfrdK/xWV0TIuXv0lvnfyABmdNt61OQoOGKzapeStTF2Zm9kPdt38Us9vygD2DBbrRb3YuQRIrgvGPBVZ4FB6uQ6UExzhh4F441TDi4SX1KZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRUZ1l8MoUtD6OpPlEJDxrvsSpty1CZSFEg2JevoJxs=;
 b=gF+6xvJdFFRfDRHUM6OLXnnrRueZLVsncbNoaaphNsv5KkCIjRBj6cUIBikDPhoI4zdBYNVv7A+Dg5Wl49zVYQkrQaMIiKNoLbj/eZJFRSU82E0QrdpWvxTSPjPHGOGmY/qdw7s3D8FTBaQI1wACpqspgc6HaezYzyuarHIwgPr8nFEl+jSZc9WyAfQcAeqJ1fGdSDKSRvZbAbHDWs5GQOxSoAJXIFNUANDPZ8XSrl3cRXpocfAL1aBEJ22eQRWeTbg/Yg90d3Cy/0Wpbv3GE44yyHL10nCp1wx7elH9ABZgGkn67wbptmEPDv4rnuQkMvRLUSOkFuRov4WufyNcyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRUZ1l8MoUtD6OpPlEJDxrvsSpty1CZSFEg2JevoJxs=;
 b=0layrOceRMdSCbjyyZeVlBv1+FKn8BBCdQu0T/QtDvmzUrz0cfvO+fkt4zKJljHmQEpwHjGqegrbUtFegctzjGDpCJ85ubuVsuZ3pyZgpm1T7TnjKhBH8QgjyZyrBLF26WdjIrmpu6AqrLVFfQre3kSLiG7k/h1aGtrOyqH7p6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 SN7PR01MB8186.prod.exchangelabs.com (2603:10b6:806:322::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Mon, 27 Oct 2025 09:02:48 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.9228.016; Mon, 27 Oct 2025
 09:02:48 +0000
Message-ID: <dbc532c8-4624-45ad-89f4-fc080be2a400@amperemail.onmicrosoft.com>
Date: Mon, 27 Oct 2025 17:02:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: arm-spe: set the correct interval for PMSIRR_EL1
To: Huang Shijie <shijie@os.amperecomputing.com>, will@kernel.org,
 mark.rutland@arm.com
Cc: patches@amperecomputing.com, cl@linux.com,
 Shubhang@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251027022445.892607-1-shijie@os.amperecomputing.com>
Content-Language: en-GB
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <20251027022445.892607-1-shijie@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU2P306CA0029.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3b::11) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|SN7PR01MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: dae2964e-3f87-4e5f-1ade-08de153799a0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWtBZ2NwMzdwakt4NWhqV05IaDBYSmJmamxqbVFGWUN5a2pXS0hROENOMGxl?=
 =?utf-8?B?N3VLUFZIeGcwY1NPNHR0Rk5pdk9nZ1Fxek9ReExYY0prRHdKV2ZqYW94MEZr?=
 =?utf-8?B?MTR1U3ZsL3RZRXhiZXBnYXpTUWNDQ2FaMXRHQlYzL2UyME1VNFRkYmc3bjNt?=
 =?utf-8?B?NlNaUTg0MFp5V3ZWajJCVCtjQWFET200T0F6U0xKMEFuRkVVWE4wcGJRL1Yv?=
 =?utf-8?B?cnZKVTlqU08rZGF4US85REI4Wm4vajRvN3hRRlIvSTcxUWFtalppa2ZWTVdl?=
 =?utf-8?B?VTQrenRxTFZrRENyYkoxUCtLbDZaT0szN0pTbHczQTlzTzc2R2UzQkY5dHpO?=
 =?utf-8?B?ZXVpdVBMQ29OTFZ1TVJhWlUveWo3dWgvbU00RjFROTJTdStkOVp2cGJUSjQx?=
 =?utf-8?B?aHA2akJqbkNsQ3RZKy9QUjlJSDNpQ1BPWi8yMHdwOG9vRXdIN2x0N290eFFJ?=
 =?utf-8?B?WUttazBkVWwzcW1ON2dJOUo3YlFxVGdpQ3VZaVNzQS9TL0R5NjRuWDVNcStW?=
 =?utf-8?B?aHdFVmc5eWNLeUs2SG5MazVWRk9QL0djTVRiSmdMeWpCSTc0Qkdjenk5ZzNi?=
 =?utf-8?B?VGZ4K1BpV25DbFE2RENvUE1PSlVMWXVZOHM3ZGxFWC95VVR5ZnJBWWJzVDBk?=
 =?utf-8?B?WklQTWJJMDhab0hvaENwaStIQlAyMThOQnlIUVIvMS9YR1pLbzBxL2sxdUsv?=
 =?utf-8?B?ZUxyaEFiYXR1YXF3ODBxUXlLbWRhUVN6M08xclhIbUhIdnVOMUJTMzZPTHdL?=
 =?utf-8?B?RG5sK2FxemhDZzhHWUwvT1I3N0dNSHU2NlYybGhzaUZpT1NxQXFQUEQrNmtB?=
 =?utf-8?B?cjBubzJPK0ZaVlNxZWZYdXJja3JCbnFoVXE0Y1V1SURIKzZnVGtxL3E3OFNK?=
 =?utf-8?B?bzBvWHFTQk5RUGZlQ0sxY3ZHL0RzUjc4QlVVRkVCdzM0a1J3YjlhWVB5N01U?=
 =?utf-8?B?UEpScTFsOU1KZi9XZjZaQlcvbzB3ckY0dlZ5aEN4Y0dYNzY2MXpBeUp3RFdr?=
 =?utf-8?B?dlFBdTBsR3dYQWtXTklGWlJoUFhqbEVZd2ZnSElqajZxNEtjM05Sd2dYaExq?=
 =?utf-8?B?QWVpZTF1dGZYVFZOTmV5Z2lORGdxanZKd3ZOYmVOdzEzM1hVWWZSRVZnWm5s?=
 =?utf-8?B?VjNDWkp0dWowbnFINVVUaSthamZXSkJESXVCZ0N6SDdWRWN5QS8vcy91ajZM?=
 =?utf-8?B?blpEcnJQV2NpR0FFS0VObDhjcXVja21UQjNMRS9LeHVwZmRYM0Yyb3RhUm4z?=
 =?utf-8?B?RjN2Z3BCS0xmNGR6dDgvT0FOUGhPM1FvMzZpRUl4eUNVa1RBaXUzM1VNOGd5?=
 =?utf-8?B?OFJXTC94anIxOC81VmtNN3k5T2ZjaDNWd0VueVV4dFlIYmk3TXp6bEhvSDNh?=
 =?utf-8?B?L2hNY0tvRHhZNkhNUjJtZFNoQWRkbGVzQzEwUExRUjBuTVdDL3gySzltN3k1?=
 =?utf-8?B?azVqK0wveWRZbU5mQjhHMUdQVnRVREtZYUpqV2ZRaVdCUnZiVElIUXhYSkdi?=
 =?utf-8?B?VDUvVzc4MFlJRGpHUzRicnFudHc1TGpaMGVqRDhpMHVlUk5GR2MwOHhxRklK?=
 =?utf-8?B?MWJJUnpJRHlPSm92cWVPTGFmSDlRR2hjaU1RVVlGaXN2YnNqWmdmaE1EdTQ2?=
 =?utf-8?B?cXYzTlRwOU9yZEh4STFDQ2NkRWRFYUIrem5xMjdFeEFpbUpCUTczWVBaSllB?=
 =?utf-8?B?RDBUV0ZmRU5JQTRXWUdXQ01yS2lYUkJBaUwwUTN4Sktod1RHWVVTY21zd3F4?=
 =?utf-8?B?SWZWY0lBZ25DdFJxdW9oY3EzNlhuN0orZ2crZG5xdEY4NG0yaFo4a1JrZTlH?=
 =?utf-8?B?NGIzVmtrOUw5czFRdEF6OU01aHdVRklGdEpCVGpIallwNHkrYzd0M0xjd3gz?=
 =?utf-8?B?US9VQWlCbGhhOFd6NEpSVllDM0RiRjVYdENYa3NXTFYyaEpnRWdaY2JsWjd6?=
 =?utf-8?Q?01qgcV1IbCqnQkPuh3KVHBasHvhUzWlB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEU3M2JKSWE1cFFBdG1iSmo1QmNLNndhR3E5TTRRVm44VFFuUjlOK1Eyajdl?=
 =?utf-8?B?WVhsNUdrZ04vWlJJcXNOcUR5dGdiQ2laYmhyeWRRYlVYbHNsQUZYRTBiNXJJ?=
 =?utf-8?B?bGMyTzdpem00Rmd3ZzBxbWc1UjljVVBMdlEvejA1OXcxdU43dTFyZW1QdXNE?=
 =?utf-8?B?bWxPOXl3dUhtM0NMZEJUWTV6YjVxSFkvZ2tXbHE3RHQ5WjlacEc4RVZjTFFv?=
 =?utf-8?B?RENLMnJUK0tFOTMvWXJReWcySmpXL2J3NVRBc2o5cW1SMUxFQnZ4SnVtYVRa?=
 =?utf-8?B?TEZUbm5mQWpoTUtiakZlK3JWdC9DOG41MTBTa04zL1JONWlHam5ZSkhxeUVi?=
 =?utf-8?B?d0tiK0hEam9nU1hRdDVZSzkvWHBpSVc1YldkVzdCWTFESlJIS1NrbFhsRnNs?=
 =?utf-8?B?SlVqSlU4YmNhUm9ObG9WME0vZmF5bXJrYlRTT2ZQT1BFZW5vTDhwV1lPMzNn?=
 =?utf-8?B?SkVERjFMMmZvK3h6TWdIa1dWVTB4eXBLNDkxZlB5TWNxNjFvTm91NDJydU8r?=
 =?utf-8?B?NXRoak84d1ZMWkJHK2l3UDhpbnlVUWRNM3lXU1VJRVFRRHNtTldHTmZDQndz?=
 =?utf-8?B?MEpzdzI2YVk2K3B4RWVRYjlaT3dGL3pOL3ViaGRvT1lPNCt1MnBmcVpISmli?=
 =?utf-8?B?NWQzY3NTWWhzMDZZMXdZNFVwOEVMaTFpeCtHd0lodk1ZZlJpa1lIQStPTDVq?=
 =?utf-8?B?a1BheWJYTkhhNlhkWkVnb3VKTFBoVlpva25LRk9WSTdBNkFiR0FZNmp4cGdU?=
 =?utf-8?B?ZE9zdTJqLzN4MGhhWTNMVnVPVmsycE84UVNIZzZBT3VDUllZM2crZWpXYjI2?=
 =?utf-8?B?eDVTVnMyZVcrajJONmlFTDI2ajluTjBOU0o3TXljVFJkWFZjdnFBRFNBbGdV?=
 =?utf-8?B?VU85NDVPT0VXOWNteTZOWVZDNW1YVFFJSUdnUEt3eHNia3BNNWxXNDJGVUF6?=
 =?utf-8?B?TzVnYWxFb2hZSWxNcWZrN2Y5bkRUalIzZUxhUGJwRHQ4N211Nzc4ZEY4STJi?=
 =?utf-8?B?eDMyYVYxZ05VaURPQmxYKzgvc252SnM1SUpsaFUxUW4yaDhwTGtpMlc1MGZm?=
 =?utf-8?B?WEYvLy9jZG5JMWNIQjhPYjNrVTJHcG5tWUFyTU5IUGxpZFJWNWF1T2lzc3Nl?=
 =?utf-8?B?dEtyMVRSekNDQXhFM0lWSWdrMUJ0YjZKSWdHMVNWZnAxaDEra0hBUHBnQ01j?=
 =?utf-8?B?ZjRxREtDZ2RkQUVreklORnJKbGswMFR4Nk5qMlpmMnU0bUQ5RUFIUVJ5VDBC?=
 =?utf-8?B?MkhOOWk4bU42WHJrYkFyVkZZSnIydEFkMW5QV0dDTGk1Z1diV3NTbEdmTitQ?=
 =?utf-8?B?OXYxV0l0MUg4YUEzc29qazVUSGMraTUxMmhBZUxyTys5OGdNay9nMTBja1ls?=
 =?utf-8?B?YVhGVXMyRlgwRVhQR2MwN0R6ajlUL01iOGI0VzhOZVo2L2Evb1d3SEV5RDQ4?=
 =?utf-8?B?UldFcTRFZitvTGhFb1B2QlhzYkhrRW1oNWlYbWJjS2UyNGlOd3VLZk83TFBu?=
 =?utf-8?B?TmN5RUdMTWllZFJIaEI2RXNWTGxsMUxubHdqamUxNFltOFBTTmNoQllpZVM1?=
 =?utf-8?B?NFN4a240NC9VS0N0a0ErRVBtazRGM014OWg0ZVVHdlZzcXNQeGhzSlB2c3JT?=
 =?utf-8?B?bmpRbGE0TVNaT3BsUWZJV0pvT3NGMkV1cmZVNnpFd0V1NEZUdXRQWm15UXdW?=
 =?utf-8?B?ZkhGS3pJSlFGbi9KMUljVWowZWx2R3BKZ2xUdHlRSnRPdGt2ZlpOak5KeWg0?=
 =?utf-8?B?RHdMNkJPaVJJOHh0S3hDRFVGNWd4N0pPQnphZ2pZbjNyVFQ3Z2hsTk5BWUhP?=
 =?utf-8?B?TXIzN1crbUZsTEk2eGNBS3phcEJ4a05Ta21KYVZ1WFZIbFkxdWprc29rQ25t?=
 =?utf-8?B?VlBHUDB4Mnl2c0cvNTRhVHQ1OGxTOCt1UzQ5QWN2Y0lwQnZibSszaGxiYXAx?=
 =?utf-8?B?b3doalNxOHFjUkZkODhPMStTRnVWOThyb0RSTkFEODJZeXJOQlZYcm5mc2VH?=
 =?utf-8?B?dHFNTGpDYkYrM3hoS0pkUmJDdlJIRkxhMEVqbEoybGNnTGNEWkVDMlZHb2FP?=
 =?utf-8?B?aDlRcEpjbGk0SmkzbnllTXBnSDZDVzVvYWJzR2dyMFBLcmZpbDkzWS93TTIw?=
 =?utf-8?B?ei9jVTExYWd5QU1wWFEwRHhQSEFoMXlrcGFVeis4dE5hNzdoSlFrN24xTWhl?=
 =?utf-8?Q?my+6NKS6cfWENdBXm3C8grc=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae2964e-3f87-4e5f-1ade-08de153799a0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 09:02:48.1823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxODO4RPuf1CdFk62PsCf9DheO9wcxCi9qFA9SS5qXIXNH1c7jc+MvDOuQMq0iXQiwdsnR8uoMrJmJAhZLJvr+AxAxnKtwOQfea6TjFISzS07cAMhj3esztOYHerACDX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR01MB8186

Please ignore this email...

Current driver is okay.


On 27/10/2025 10:24, Huang Shijie wrote:
>  From the spec, the "interval" value for PMSIRR_EL1 is in the [31, 8] bits.
> Current code does not set it correctly.
>
> This patch fixes it.
>
> Fixes: d5d9696b03808 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
>   drivers/perf/arm_spe_pmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index fa50645fedda..d424721b79ee 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -400,7 +400,7 @@ static u64 arm_spe_event_to_pmsirr(struct perf_event *event)
>   	arm_spe_event_sanitise_period(event);
>   
>   	reg |= FIELD_PREP(PMSIRR_EL1_RND, ATTR_CFG_GET_FLD(attr, jitter));
> -	reg |= event->hw.sample_period;
> +	reg |= FIELD_PREP(PMSIRR_EL1_INTERVAL, event->hw.sample_period);
>   
>   	return reg;
>   }
