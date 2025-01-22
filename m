Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020124.outbound.protection.outlook.com [52.101.189.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA831607AC;
	Wed, 22 Jan 2025 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737576801; cv=fail; b=OYqOdkIBnOFHBsLan0+kCBPrPRpXyBdJoJP9MOhBvsCJUvUzEMh0M50mywEbzqViCGJMtP9n32trUab06METbceQFY/REDpMFH3+XBUNZwT69PQshUvjtpym8TIxNbbAI2wsqfLlGYNg713KlALA+xKR6fx3pK6q9w8/gUstdKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737576801; c=relaxed/simple;
	bh=rYKnf3p09lJWIjACJ6GujSuRnWpy73GWZ6xCslOResg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D1F46oe5Pcq8s5vord/Y/kThet2GBRchB+j12qRIPWbcTOHtdvgLew0WPu5ggOgpovWABK2Blbnki5uB9oEcHhq8GgUCqW47KNWDK3yx/LhqIa01owiOxlQOx7pciQjZtFcWy+Ehx9khF+OnInqwiQYfHcEOPJ+reJ1DogbHeR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=gZwx1fZW; arc=fail smtp.client-ip=52.101.189.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="gZwx1fZW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7Pv/dq04p9DL3191XXhsKK8enr3Xb2zbKa806DbVjzbp3Gt9j+awNo1z+iKHbl1MgHhCn91pVCFvVyLAsZJlKTXeko+yBfCeN/Qi2nOgAPzhriPJUs0CK5KEXuzQOTraPMYN/w8qnYkI2NXcHLlkMS1RGBIEQeUjtkM8wRc8hwCplh5zr4XvXzDjHM6ZHq23HzGC2qi1T+GHywF9D2IcfF00MkYoaFwko+pu7P8OcYBIj033JcYrVJDm5IysKR5ekASN5bjQc1jkzNthAQHCP8lSkFKbyAH0H2e6Ttq2hwYNEQbwnD3wHtaLFP3mYQ/FFxyssge7AlYciUPM7yHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOsJTXlhSbf1/JbwF5W12ZK3l/dxedpZtIj3FhuEbeA=;
 b=egtfBnRFYc2NetOTho72OmQZlWrUgrW9NbAGwRwTWH6sdPsxmnNF7ZO2CEet313SSV6jPCdu9HpD52LbI+djAAN9LR66RX5XpijGXqo6Di48zOucRiKEQXvg1XZ4qUJ314bp9S/6grZ48pK+B2tyWsyAwPej9thCr7pvwPquwxbKsca6KBH5v0wmJxD2Adkh2Fntx7Frha6hYVoM1kqQDLGycTc7164sqLK4FCisu1PKBalQg3LYmc9/BPFxxGqG+EH3k2bqLSe884BYheRiAHtpiPFXTcHVw38Agg+wE19Zp1Q9PdRtVWlv3CEnQHdkbR8+zbpvvgctvmG5z713Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOsJTXlhSbf1/JbwF5W12ZK3l/dxedpZtIj3FhuEbeA=;
 b=gZwx1fZWgktHG+Xxc/V1avSgqdWrpuTjYlMWf27NsTZSGzDIpTjac1bed91HYSJKkeXmK1Lctb5rkraRIAiH6oD5HqwBWcbw57V2rB9uTN6jrKVwgvV9ffZPzBEVljwZuk+F+fouhVMrPeJT+yI4MGhokqx45ngjZ4TFcDSVQ1nGsfGkAO8NhRmo3ycFM+M6IXQ8kBrnQ9pFrsYcByvQpkGW4UTzgdCkNuDzSZqgxXJEYSeTLqWCUIKGRL9Vduvbo9qOvKrew0YEPRQITmkmRpWWBx9/Sv96Bu7jvItF/qLC/LAnIZxk9M/Q/V4xyMaScZ6jsRG7Bta6yEPtJUe20Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by YQXPR01MB6463.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:43::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 20:13:15 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf%6]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 20:13:15 +0000
Message-ID: <e92fc832-ef46-4863-9316-24f30d8d82fd@efficios.com>
Date: Wed, 22 Jan 2025 15:13:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 28/39] unwind_user/deferred: Add deferred unwinding
 interface
To: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org,
 Indu Bhagat <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
 Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jens Remus <jremus@linux.ibm.com>, Florian Weimer <fweimer@redhat.com>,
 Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Weinan Liu <wnliu@google.com>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0168.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::21) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|YQXPR01MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 76f004b5-b8bc-46e5-edfd-08dd3b213415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDFhYmVwQU0xOTMwa2hLSnNjK3hNLzZ6cUs0OU90WEVRNUVxLzVxNjc1QnpE?=
 =?utf-8?B?QmhEMnFXMTZWZHh6RHBwWnhxK2VaM2xTWVdYNE0rTHNCeXhkQklRRmpIU1ZR?=
 =?utf-8?B?NW9jcVhpb0Z2V0dmY1FmSDJRVG1mWml1eGZMM0NwVnRydUVPZVN5U3pqNHlp?=
 =?utf-8?B?TFoxVDlsTDI1bTdpSjlqWDgxTkhHaWNsZzdWMElsOVIrcGFBdnRHZmd4dElm?=
 =?utf-8?B?U1ZPSWZNL0pwOHF0V3dZdzZ5QUNiRlREZHM2anFKanl5VElwVm9uSE9LL09X?=
 =?utf-8?B?VndyL1dNUk1NbDAwVjdqRFdsNk9nSkVEdmNpdjdhSTFqMDlaaU9hV0dWdmhH?=
 =?utf-8?B?Wkx2YVJmTUhadVJDc205Y2ROc3dlc01wczRBaElLRXRPTG13WHRxQ0RkS0Jm?=
 =?utf-8?B?MmEycWVvM2ZaYmdNUVZzSGJsWFJpaEo5OVd2Sll3Y0hDdXp1ZEhYYWVyTno1?=
 =?utf-8?B?U3Z1U0YwNy96THQvdUJRb2lCVG41WFlyWi9GZmxzVEJmb3ZReHJwbFhBWU5h?=
 =?utf-8?B?T04vNzV3dm5ZZmVQTGlYL2dadC9uVU15djBPNHVBMWtFRXQxU25rTWhZSUVX?=
 =?utf-8?B?ZnRkM2VBU0xSUHk1c0VURHpYczAwZHY3UkxHR2FENGM5Unk1bTRoWEg1RGdY?=
 =?utf-8?B?WmJxQkkrM0hrdzZqN0ZYbyt0WHY5UUJxK0lRcGNRdDNCbVBvQXRaVTJ5VURr?=
 =?utf-8?B?cXJmNlVmK2pZbVllVnRXVktncnBVVC9ZbWRQYlZPcUM0SXFURXhhNUpYWjlH?=
 =?utf-8?B?WDNRL3M2UVgyWSt1dVFkOHVTVm9rMEdHalJ1ZHZjVUVBYXE2T0I5MFdxdkNG?=
 =?utf-8?B?dkJ4eDRkcFNMVVg1WXJvVWdrd1ZhQm1yRTBxdmdxK3Q4TVNFUSt6bENnNlJK?=
 =?utf-8?B?ajI3WmVTakkrdzhDUkFmR2JPbWhBWGoyUmQyNUNRL1ZLWEw0c1o2SGVCVktR?=
 =?utf-8?B?d0lnTmJOdms0ako5bHg2ODZFcjdFVmh6WEFWNXgwUnpBMlVKQm9jRFpxQktG?=
 =?utf-8?B?WGlDL21vZE84dlBPMFUxWTBRMDNkazVZcjZYRm9obGI2WTNGOENJN2gvbTQ2?=
 =?utf-8?B?ZTJPSTlsM0tNeU1nUHI4V3I0SG5QVlZvdVhCRVpmWlZCRC9NSGI1NkxpVVJP?=
 =?utf-8?B?YWd3WkZDWVJEdzArbjVDdXgyd3BHeSsxcXZtWk9TdWNocHlPQzljTTduVzFn?=
 =?utf-8?B?WkZaTTZRejVBUTloekJUbjdseFhGS0hZTFRmbnZEa2JuWjAzUk1jayswa2dl?=
 =?utf-8?B?a0RpOU5LUWxXWW1uVStKSVBSUFpsME1SOHorSklIc2dLcnFMZzN0L3BpOWt6?=
 =?utf-8?B?aDNWcWJFM1ZsTFVnZkJjMXRCcms3SU5yRk1EdFNZVS92YW1mb05GWkd1Vjhp?=
 =?utf-8?B?dFVuU002cXp4K3NaY29BNmxWbmh3eWFSVlp0OVJ6VEJOMXIxY2ZidWhvR1JX?=
 =?utf-8?B?TkJoRDBEK0kweXlSM0dEMjhrUG5sVlQvYXp4OStNQy80bGRMSUNyWkF4TWJs?=
 =?utf-8?B?dUQxelJmbmoxQTd2anRsT3BzMXJ4eGFVUVhMWmczOHl2OEZXSk1XbFMxZ3lK?=
 =?utf-8?B?WDJCWitSVGZIQUoycEpMMEwvdFl3SGt3UHZTc0RIT2dRQ25PeUFyZXBUTytW?=
 =?utf-8?B?bkMwb0YwaTZwcFdHWmFqUm5nSWh6NldVNXBsMlBWbFVOTFhHMmJ2ay85UVBt?=
 =?utf-8?B?WXVDYjRJSlliVDdoQ1FmdGtwb1NXU1BtV1dEQkdjWkFyMGVOaGcxNCtLVHcw?=
 =?utf-8?B?ZDI2cmxlcnNZeERTTlVWV0lqbTJhbUhSWldtWnZuSk4xTGpjckpDc3l6UTRO?=
 =?utf-8?B?cEVVY0lNMWFNYXk3cEpoUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3k0dUtzTnRUb0tzbXB3UW9xNUFEV1ZKRmsvdWZzaWJLMmR2R1BXRldBRWFR?=
 =?utf-8?B?VEp4MTFVb0VrWXMxY2ozOW9uejAwUURPdDdiOWRwbFhVNVNKMDJ4K1BWbHAy?=
 =?utf-8?B?dHZzQWxnQ2svSzFSWGFZNGcxTmV4YUZGWkI5dnJxZkZuYkdLdVZzVjIxZTVB?=
 =?utf-8?B?QWNRUTZnazFPWXJyYkc3Rm1YN1U0U1hYZHB3WFozblcvU1hEc3c4YXQ1UE1y?=
 =?utf-8?B?eGp0SGtjR2loUGIwajltNjlTMkpVUGkzWUVaZzZ2WUpRcGtGU05uYmpBaWRz?=
 =?utf-8?B?NDJvQ29iTVV5Y01wak5uNllHSE5SWFVrRzJuTlU0cjZsa1pwOVZJTjIrSVM4?=
 =?utf-8?B?eXp6eEFDUitGMlRMNFpxYmZtSDg1SkRxMlptUmVSSXlDNGE4dVRtUzdtckV6?=
 =?utf-8?B?SnU1c3Q4blY2a0RMY1dCdmpseStFU2VOK3R4dWpCRUprQm42YUllZk5qQm9O?=
 =?utf-8?B?Wlo2M2wyVFovUWk2S3dyVUhzQ09tL1FJNEZaTzB0NTQyaC9maFFnbEc5RXdB?=
 =?utf-8?B?VkF6ZWZrMmQ2dUlDNURXMi9XVk94ZVdnL1BuZ1FpV0RGN0FJdEZ6dnI2ZS9o?=
 =?utf-8?B?Um5FbFRRelFjYStXZHgxQVVOaVJkbFQyQmxVaitMakRieTZBRDQ3UjRGYk9z?=
 =?utf-8?B?R2hGeSt2MmhmaEZPOUxST0diOGEvdDJhSUdzK3FvOEpBcUcwamZBSkJ6dlNW?=
 =?utf-8?B?bjM3cW1wdjNUOGlHUDdjNnNUT3NSbENuQjhkWDB0L1VmWXlodUIrWTI5Y1or?=
 =?utf-8?B?Yk5Zb3Z5WjNvczlXdmZDbDNuQ0lFNktSK0xPVHZLQ1IyclJyRXVhZ0FMS1Bs?=
 =?utf-8?B?bllCbEhiNzMrWjVvZXNYZFNTT1E4MndZRnB2c2VrQ1RnQXdlRnFEbXFwMGh4?=
 =?utf-8?B?MXJ1VjMwcmMyUHVuWFJmV3JDdWRJQVlibDU0dVI3aXF1YmpPZTBwM2xmeEtj?=
 =?utf-8?B?cmNGaFpxdm9FbnoyOS9TVzBtSXhHTU5LemNFN0xDY3lNOWxoQ01wYzdwTFd1?=
 =?utf-8?B?NnlSTmlQK1ZsV3Z4eU1peXZDRnFUVHRiSlpjUzduRnlMWHE2azZVRDhIVndm?=
 =?utf-8?B?VmI3NlJSUTFLeEI2NmVidldNK0p4OStJU3QzYm5oNjdzQ3I1bkU2MStrbmxz?=
 =?utf-8?B?Mis0UmJpZXZlTk5JWDUzRnZvd2IzT3RYcElzL0ZRa3hkMGZKd3UycllFRTh4?=
 =?utf-8?B?UWxlUGxpbXIxMTFhdWRlcThXNXdyeGtINzlrSXlBTnh1Ly9xMVVXcnREbTMz?=
 =?utf-8?B?RGU0MkFINVYvemRFMXo5RmJneldZMUVRWUJaZjZKMlFPaWZLNnIvSGVDOG9M?=
 =?utf-8?B?MnBNUkxxR2s5MThwVERBU0FEY1hIdHNySnRmWGVzRlpNNExiN244Ymg1QTRa?=
 =?utf-8?B?ZkN4K2poR1ozOHpEMDh4OVNyanhNVURvQitYM0E3YWd6dHcxYWdqQy8rQWFi?=
 =?utf-8?B?SWkxOXNzNjJ5VDV4b2x6dXpKMnltNnMxaXJWSTN1VkFyaFlkMVFKMmFjN2Ir?=
 =?utf-8?B?ZkRjSGF0VVJtTGRoL1JWdVptek5YNUxYdXZleDM2UGVtSWtGTW1lUGo2Z0hl?=
 =?utf-8?B?WnIwVldsL3FsRVQ4TnB2SlcwOVpSSGdzWDdNZnd2V2ZObzUvNjl3N3BZZE8z?=
 =?utf-8?B?MkNEbVlUQzNYNXNoODhBa0tpVEZYbk1nWHhwN3p1bXlidHFZVXNhOEp4bHNK?=
 =?utf-8?B?c1FaakFCVForV0Jibk1lSFQxcTlLZDhXRk5jb3BVNk5UcDBPRE8wWFgveW10?=
 =?utf-8?B?WGFLeTBWdEtqU292QXVkbGtBR205RzlJZFdyUkhNWXMvd2xJMkFJVVJzd3hF?=
 =?utf-8?B?azQrVEZHM00vaXRnQytNUzVFRWRRanhYcFNUNTl1b2dUdUxBT0w4UjNzWU00?=
 =?utf-8?B?cld4N3dsb0RIYldtNVg1YTN6WGtmbXkyRjRIcTdTWFVjWHpuMVVMckRaVnVM?=
 =?utf-8?B?U2ZOUHdDaEV2QWVtWWVpODZOVzhuRG1LdFEyWHNYRDl2NlN6K3A5OVV4SGM1?=
 =?utf-8?B?S3h1YzRidy90cmhHOEFaV1NzTGtEOFRIS0hrcTdxS0JpQjIwa0dtOTl2OXJn?=
 =?utf-8?B?bDhySnZQeDd3V0hDV3I4Qk9tNFBOK0I4UDd2MHpOb0lmWUR3ZTk3Sis5cHJ1?=
 =?utf-8?B?UVg5ak1IYmRvWk10aXJTVUtNSlp4em5iMUw4NVd3VERVSk94VDUrVGp4eGxZ?=
 =?utf-8?Q?YN64+5gMu+OjrjB0mcNFxM8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f004b5-b8bc-46e5-edfd-08dd3b213415
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 20:13:15.1808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rotbVq1x3S7UkdBtxI/NkA/49arY0xE5pFYAVBccj+TRcF0MXnU+2y0cucjIeAmLJhDoSsBPwmiroVOO8qmLkaNCBu+G8rixocbwea34k+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6463

On 2025-01-21 21:31, Josh Poimboeuf wrote:
> Add an interface for scheduling task work to unwind the user space stack
> before returning to user space.  This solves several problems for its
> callers:
> 
>    - Ensure the unwind happens in task context even if the caller may be
>      running in NMI or interrupt context.
> 
>    - Avoid duplicate unwinds, whether called multiple times by the same
>      caller or by different callers.
> 
>    - Create a "context cookie" which allows trace post-processing to
>      correlate kernel unwinds/traces with the user unwind.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   include/linux/entry-common.h          |   2 +
>   include/linux/sched.h                 |   5 +
>   include/linux/unwind_deferred.h       |  46 +++++++
>   include/linux/unwind_deferred_types.h |  10 ++
>   kernel/fork.c                         |   4 +
>   kernel/unwind/Makefile                |   2 +-
>   kernel/unwind/deferred.c              | 178 ++++++++++++++++++++++++++
>   7 files changed, 246 insertions(+), 1 deletion(-)
>   create mode 100644 include/linux/unwind_deferred.h
>   create mode 100644 include/linux/unwind_deferred_types.h
>   create mode 100644 kernel/unwind/deferred.c
> 
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index fc61d0205c97..fb2b27154fee 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -12,6 +12,7 @@
>   #include <linux/resume_user_mode.h>
>   #include <linux/tick.h>
>   #include <linux/kmsan.h>
> +#include <linux/unwind_deferred.h>
>   
>   #include <asm/entry-common.h>
>   
> @@ -111,6 +112,7 @@ static __always_inline void enter_from_user_mode(struct pt_regs *regs)
>   
>   	CT_WARN_ON(__ct_state() != CT_STATE_USER);
>   	user_exit_irqoff();
> +	unwind_enter_from_user_mode();
>   
>   	instrumentation_begin();
>   	kmsan_unpoison_entry_regs(regs);
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 64934e0830af..042a95f4f6e6 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -46,6 +46,7 @@
>   #include <linux/rv.h>
>   #include <linux/livepatch_sched.h>
>   #include <linux/uidgid_types.h>
> +#include <linux/unwind_deferred_types.h>
>   #include <asm/kmap_size.h>
>   
>   /* task_struct member predeclarations (sorted alphabetically): */
> @@ -1603,6 +1604,10 @@ struct task_struct {
>   	struct user_event_mm		*user_event_mm;
>   #endif
>   
> +#ifdef CONFIG_UNWIND_USER
> +	struct unwind_task_info		unwind_info;
> +#endif
> +
>   	/*
>   	 * New fields for task_struct should be added above here, so that
>   	 * they are included in the randomized portion of task_struct.
> diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
> new file mode 100644
> index 000000000000..741f409f0d1f
> --- /dev/null
> +++ b/include/linux/unwind_deferred.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_UNWIND_USER_DEFERRED_H
> +#define _LINUX_UNWIND_USER_DEFERRED_H
> +
> +#include <linux/task_work.h>
> +#include <linux/unwind_user.h>
> +#include <linux/unwind_deferred_types.h>
> +
> +struct unwind_work;
> +
> +typedef void (*unwind_callback_t)(struct unwind_work *work, struct unwind_stacktrace *trace, u64 cookie);
> +
> +struct unwind_work {
> +	struct callback_head		work;
> +	unwind_callback_t		func;
> +	int				pending;
> +};

This is a lot of information to keep around per instance.

I'm not sure it would be OK to have a single unwind_work per perf-event
for perf. I suspect it may need to be per perf-event X per-task if a
perf-event can be associated to more than a single task (not sure ?).

For LTTng, we'd have to consider something similar because of multi-session
support. Either we'd have one unwind_work per-session X per-task, or we'd
need to multiplex this internally within LTTng-modules. None of this is
ideal in terms of memory footprint.

We should look at what part of this information can be made static/global
and what part is task-local, so we minimize the amount of redundant data
per-task (memory footprint).

AFAIU, most of that unwind_work information is global:

   - work,
   - func,

And could be registered dynamically by the tracer when it enables
tracing with an interest on stack walking.

At registration, we can allocate a descriptor ID (with a limited bounded
max number, configurable). This would associate a work+func to a given
ID, and keep track of this in a global table (indexed by ID).

I suspect that the only thing we really want to keep track of per-task
is the pending bit, and what is the ID of the unwind_work associated.
This could be kept, per-task, in either:

- a bitmap of pending bits, indexed by ID, or
- an array of pending IDs.

Unregistration of unwind_work could iterate on all tasks and clear the
pending bit or ID associated with the unregistered work, to make sure
we don't trigger unrelated work after a re-use.


> +
> +#ifdef CONFIG_UNWIND_USER
> +
> +void unwind_task_init(struct task_struct *task);
> +void unwind_task_free(struct task_struct *task);
> +
> +void unwind_deferred_init(struct unwind_work *work, unwind_callback_t func);
> +int unwind_deferred_request(struct unwind_work *work, u64 *cookie);
> +bool unwind_deferred_cancel(struct task_struct *task, struct unwind_work *work);
> +
> +static __always_inline void unwind_enter_from_user_mode(void)
> +{
> +	current->unwind_info.cookie = 0;
> +}
> +
> +#else /* !CONFIG_UNWIND_USER */
> +
> +static inline void unwind_task_init(struct task_struct *task) {}
> +static inline void unwind_task_free(struct task_struct *task) {}
> +
> +static inline void unwind_deferred_init(struct unwind_work *work, unwind_callback_t func) {}
> +static inline int unwind_deferred_request(struct task_struct *task, struct unwind_work *work, u64 *cookie) { return -ENOSYS; }
> +static inline bool unwind_deferred_cancel(struct task_struct *task, struct unwind_work *work) { return false; }
> +
> +static inline void unwind_enter_from_user_mode(void) {}
> +
> +#endif /* !CONFIG_UNWIND_USER */
> +
> +#endif /* _LINUX_UNWIND_USER_DEFERRED_H */
> diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
> new file mode 100644
> index 000000000000..9749824aea09
> --- /dev/null
> +++ b/include/linux/unwind_deferred_types.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
> +#define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
> +
> +struct unwind_task_info {
> +	unsigned long		*entries;
> +	u64			cookie;
> +};
> +
> +#endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 88753f8bbdd3..c9a954af72a1 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -106,6 +106,7 @@
>   #include <linux/pidfs.h>
>   #include <linux/tick.h>
>   #include <linux/sframe.h>
> +#include <linux/unwind_deferred.h>
>   
>   #include <asm/pgalloc.h>
>   #include <linux/uaccess.h>
> @@ -973,6 +974,7 @@ void __put_task_struct(struct task_struct *tsk)
>   	WARN_ON(refcount_read(&tsk->usage));
>   	WARN_ON(tsk == current);
>   
> +	unwind_task_free(tsk);
>   	sched_ext_free(tsk);
>   	io_uring_free(tsk);
>   	cgroup_free(tsk);
> @@ -2370,6 +2372,8 @@ __latent_entropy struct task_struct *copy_process(
>   	p->bpf_ctx = NULL;
>   #endif
>   
> +	unwind_task_init(p);
> +
>   	/* Perform scheduler related setup. Assign this task to a CPU. */
>   	retval = sched_fork(clone_flags, p);
>   	if (retval)
> diff --git a/kernel/unwind/Makefile b/kernel/unwind/Makefile
> index f70380d7a6a6..146038165865 100644
> --- a/kernel/unwind/Makefile
> +++ b/kernel/unwind/Makefile
> @@ -1,2 +1,2 @@
> - obj-$(CONFIG_UNWIND_USER)		+= user.o
> + obj-$(CONFIG_UNWIND_USER)		+= user.o deferred.o
>    obj-$(CONFIG_HAVE_UNWIND_USER_SFRAME)	+= sframe.o
> diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
> new file mode 100644
> index 000000000000..f0dbe4069247
> --- /dev/null
> +++ b/kernel/unwind/deferred.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> +* Deferred user space unwinding
> +*/
> +#include <linux/kernel.h>
> +#include <linux/sched.h>
> +#include <linux/sched/task_stack.h>
> +#include <linux/sframe.h>
> +#include <linux/slab.h>
> +#include <linux/task_work.h>
> +#include <linux/mm.h>
> +#include <linux/unwind_deferred.h>
> +
> +#define UNWIND_MAX_ENTRIES 512
> +
> +/* entry-from-user counter */
> +static DEFINE_PER_CPU(u64, unwind_ctx_ctr);
> +
> +/*
> + * The context cookie is a unique identifier which allows post-processing to
> + * correlate kernel trace(s) with user unwinds.  The high 12 bits are the CPU
> + * id; the lower 48 bits are a per-CPU entry counter.
> + */
> +static u64 ctx_to_cookie(u64 cpu, u64 ctx)
> +{
> +	BUILD_BUG_ON(NR_CPUS > 65535);

2^12 = 4k, not 64k. Perhaps you mean to reserve 16 bits
for cpu numbers ?

> +	return (ctx & ((1UL << 48) - 1)) | (cpu << 48);

Perhaps use ilog2(NR_CPUS) instead for the number of bits to use
rather than hard code 12 ?


> +}
> +
> +/*
> + * Read the task context cookie, first initializing it if this is the first
> + * call to get_cookie() since the most recent entry from user.
> + */
> +static u64 get_cookie(struct unwind_task_info *info)
> +{
> +	u64 ctx_ctr;
> +	u64 cookie;
> +	u64 cpu;
> +
> +	guard(irqsave)();
> +
> +	cookie = info->cookie;
> +	if (cookie)
> +		return cookie;
> +
> +
> +	cpu = raw_smp_processor_id();
> +	ctx_ctr = __this_cpu_inc_return(unwind_ctx_ctr);
> +	info->cookie = ctx_to_cookie(cpu, ctx_ctr);
> +
> +	return cookie;
> +
> +}
> +
> +static void unwind_deferred_task_work(struct callback_head *head)
> +{
> +	struct unwind_work *work = container_of(head, struct unwind_work, work);
> +	struct unwind_task_info *info = &current->unwind_info;
> +	struct unwind_stacktrace trace;
> +	u64 cookie;
> +
> +	if (WARN_ON_ONCE(!work->pending))
> +		return;
> +
> +	/*
> +	 * From here on out, the callback must always be called, even if it's
> +	 * just an empty trace.
> +	 */
> +
> +	cookie = get_cookie(info);
> +
> +	/* Check for task exit path. */
> +	if (!current->mm)
> +		goto do_callback;
> +
> +	if (!info->entries) {
> +		info->entries = kmalloc(UNWIND_MAX_ENTRIES * sizeof(long),
> +					GFP_KERNEL);
> +		if (!info->entries)
> +			goto do_callback;
> +	}
> +
> +	trace.entries = info->entries;
> +	trace.nr = 0;
> +	unwind_user(&trace, UNWIND_MAX_ENTRIES);
> +
> +do_callback:
> +	work->func(work, &trace, cookie);
> +	work->pending = 0;
> +}
> +
> +/*
> + * Schedule a user space unwind to be done in task work before exiting the
> + * kernel.
> + *
> + * The returned cookie output is a unique identifer for the current task entry

identifier

Thanks,

Mathieu

> + * context.  Its value will also be passed to the callback function.  It can be
> + * used to stitch kernel and user stack traces together in post-processing.
> + *
> + * It's valid to call this function multiple times for the same @work within
> + * the same task entry context.  Each call will return the same cookie.  If the
> + * callback is already pending, an error will be returned along with the
> + * cookie.  If the callback is not pending because it has already been
> + * previously called for the same entry context, it will be called again with
> + * the same stack trace and cookie.
> + *
> + * Thus are three possible return scenarios:
> + *
> + *   * return != 0, *cookie == 0: the operation failed, no pending callback.
> + *
> + *   * return != 0, *cookie != 0: the callback is already pending. The cookie
> + *     can still be used to correlate with the pending callback.
> + *
> + *   * return == 0, *cookie != 0: the callback queued successfully.  The
> + *     callback is guaranteed to be called with the given cookie.
> + */
> +int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
> +{
> +	struct unwind_task_info *info = &current->unwind_info;
> +	int ret;
> +
> +	*cookie = 0;
> +
> +	if (WARN_ON_ONCE(in_nmi()))
> +		return -EINVAL;
> +
> +	if (!current->mm || !user_mode(task_pt_regs(current)))
> +		return -EINVAL;
> +
> +	guard(irqsave)();
> +
> +	*cookie = get_cookie(info);
> +
> +	/* callback already pending? */
> +	if (work->pending)
> +		return -EEXIST;
> +
> +	ret = task_work_add(current, &work->work, TWA_RESUME);
> +	if (WARN_ON_ONCE(ret))
> +		return ret;
> +
> +	work->pending = 1;
> +
> +	return 0;
> +}
> +
> +bool unwind_deferred_cancel(struct task_struct *task, struct unwind_work *work)
> +{
> +	bool ret;
> +
> +	ret = task_work_cancel(task, &work->work);
> +	if (ret)
> +		work->pending = 0;
> +
> +	return ret;
> +}
> +
> +void unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
> +{
> +	memset(work, 0, sizeof(*work));
> +
> +	init_task_work(&work->work, unwind_deferred_task_work);
> +	work->func = func;
> +}
> +
> +void unwind_task_init(struct task_struct *task)
> +{
> +	struct unwind_task_info *info = &task->unwind_info;
> +
> +	memset(info, 0, sizeof(*info));
> +}
> +
> +void unwind_task_free(struct task_struct *task)
> +{
> +	struct unwind_task_info *info = &task->unwind_info;
> +
> +	kfree(info->entries);
> +}

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

