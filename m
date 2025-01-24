Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021078.outbound.protection.outlook.com [52.101.100.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A3921ADA6;
	Fri, 24 Jan 2025 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737716050; cv=fail; b=N0i2FtyPsjug2/ddL2fG9U/sSgAOVWK9OJfmA17tAE1ItTSeBikGYIlapz/69vyYsqiSOBi3nkPEEifhZyXHztR21mA7GuGmO+0gNR0cCv52WccZ0VZeMCzi5hm7atR0teT+iayKvzuQX5NYgswrs44yJ34YPm0Ij5ptNjJAWxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737716050; c=relaxed/simple;
	bh=JWAsb4OnOeOmhBITgJQsmBUjK4gQQVXO0L0D5ldlBCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cr7xrpemSkixTrOO6Qs2mmlyZ47dfAPZirBFkqfYakt0ouP3r71WXBNwUrcIntyux7DtiIBFEnUV5YjYkyjkJ/Py1ESwwMgHFlFUWY8XZHZ6TqjZDaSyB9EVxHa4zq0ciBxKqtYTHwQsuDmuhdACD7Tu73ZgRdWl6pmeOuI4xWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXAoFctkz8jaN1d9YrmGyGxcqR5pCXoBqXF14ZThjbCRRlHkjJUbbbHmVSOLavpxjcdi/JGl8OmPVKD1OiC/F2AT2ICnYIfnXlbd4H3UJ+u674ZzckK4gzQy1KTAAqm2a3wkmWKOw/r15zroGV8YZuaD1SjJkMglV9Vhe7LNUaUWXEqSqXOaeoheePyTo2fhUcQfkMV1b3/JGR5l7EBjRPNGv5p5PfP2XpX9AWADIdUz/noqAI8TliQu9HFt+XQDnTgNg1YVOYvVJCV73HtFvMRau78mlrIRdmOjC/nGT8T4/8hrqaC/hwH4QrQv8wFUB0AUh7RzmfEiJkVacFjTWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97O/y4l49j7So7LNkz5g9LLpRIfF9VKlCk1YNZVOiO0=;
 b=pd5yIDBYFoFaIQyepWBQyhtf2/xd6ez+jza3AnKdn01qbBewrT3QqCYvZVSVCdt87UE27APz6Cxy2mRRp5UU7bHgpta161SGMsZNgWN3fC125zvqCjIXPu/NF8e20kvKaHM85KdaXxos/ffzYk84gYcuG2AnmsIPGrCVHU9yEvpk8k/CYhBJ2JKLru9T7XORS6IPApLBI63n+vv2HORczmoN07dDZxibTCoXRqz9MtuCTnj3Ws2+0kUU8kVMjVKSdeKSZkMD+88WQvjxw5klFFfyO04yErXFUrHVC6A66jRebB1VWbesMcVs9+9G2H3tvEyA9g2N2trpP3MXJw7JTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB6951.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:200::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Fri, 24 Jan
 2025 10:54:05 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6%7]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 10:54:05 +0000
Date: Fri, 24 Jan 2025 10:54:04 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf probe: Introduce --no-advice option when a new
 event is created
Message-ID: <oqon532hz5nktpgilvpmvd5ywuasppbkfw2f6z5gjluyzo62ow@n7ynrou6uykm>
References: <20241214193452.16627-1-atomlin@atomlin.com>
 <Z5Ld5irdG--_Efgl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z5Ld5irdG--_Efgl@google.com>
X-ClientProxiedBy: LO2P265CA0068.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::32) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 18604b53-b0eb-46e7-afe1-08dd3c656ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHV4MUlURzhzdDE2SU80OXdYb254MjJHSzhzTTNrRjBIRDZYWG5GMjZSZDBw?=
 =?utf-8?B?bXZ6QU5NY2RHUFo2OHN6TzEwNjR5alNyQll0Q2xwWVB5bnBCWE5GZ2ozcXR1?=
 =?utf-8?B?ZSsyZmhwc2lIczkxbUQvRmNEeCtjeHQ3QjdFMkRkSENRbjdBNTl6VjI3TUJJ?=
 =?utf-8?B?ZUVMeU9kcWhhRUJKMlBEbGExd3dFUm9sLytvNXljKzV1QWc3dU9YRUpGNVhx?=
 =?utf-8?B?aldGT3RqNTBBNzhjc1lCMEx5c0xLeUY0VThIQjRWMlRPZnRGc0l4WW9JTjAv?=
 =?utf-8?B?TlNCU1ZxUWdEei9QeEcrNG5KV2NIdUVZVzhBM0ZLTmZuQ0RxRUpsSFFHajJX?=
 =?utf-8?B?MVNhU2VaRzZRSHFkSVhpKzl2S2NhbzhuT1k3QWFlOTVsNmdScUFybG1FWkFE?=
 =?utf-8?B?Sk02OHFrdVRlejQrLzdtVzlybWRiSGl4S2MrdDNoWVlub21kZWMrMUdITjln?=
 =?utf-8?B?bWkrTXhGSUljbmh0QmtQMUl0NGtVdmNmakdVY3R2UFkvNEw0emxSNjFla3E0?=
 =?utf-8?B?ZFNaNFpVdjdXc3NYSGFoZEtLdE81eTEya0hOcXFmcm1YSWN4OVduWjM5ZGlq?=
 =?utf-8?B?d09ER3lCRCs3czZqZHMxMHZma0xaQ2YwNmNtNEYwdVdOUnlHUUtOdXY4RXN5?=
 =?utf-8?B?WGdxVzNtYy80cjVLdXZHUDJSZ2UvUnZObkxncURqQ1FhQ3g3QktmMUcvazA5?=
 =?utf-8?B?eno1dDBsYlJKQkpwQTgvWDhDbksrREpsR00xUVltTDhBQ2ExK1ZiWVo1R2lj?=
 =?utf-8?B?UmsybS9JTDgxdUtYbURjNElZMlk4SVcwSjdIbDV6OGtxdnAxMmgrakY0czB2?=
 =?utf-8?B?elI0SWZacEFZRUVTQ01OWVE5L0E0d1h3cmh1YzJnQXVFb3EvcXR4aUl5RFZ1?=
 =?utf-8?B?YnVTd2JyNXU1OGU4dHM4dnlWYWlZLzdTMVNWK1JUTGI2RXVZZURJam9tamtV?=
 =?utf-8?B?WC9jZFBDZ3pGd2I4SzlPQjNVZGFiSzFhaHlMQlowbmZmd3FjVU1qZU9DOGRV?=
 =?utf-8?B?dHU3VU9oaG0wVHQxQlJqT29QOWI3aGJEbkxDMEJhT2Y3YnByYzZreS9EU0RJ?=
 =?utf-8?B?d2QxNjZvVzNTQzVBenlqU0VqM2NFenpwUkVhdWMyRDM0SFNXUitwTjhrdmZk?=
 =?utf-8?B?d2g2YjVaa1luK1FCWGhsR3AxSzJrQkVVNnlpdS80NmYwL2U0dGRnT2VnSlVz?=
 =?utf-8?B?TVlkbWh1dDdLUXcxMUhPSE1iV3NEWis3TmtyNVFYNDBUWk1wUzFJNHZwVFhu?=
 =?utf-8?B?UVRVbFR6ek5NMGtlSjhUc3VoUHpkQ1BJTjRoNFdGUlU2ZURBNjFoUXlsL2Q3?=
 =?utf-8?B?N3VmZ2hQdldLeFhnRUcvVmQxZ1BpK1BxSzJSek5kSjN5eFNXUHljaGp3MTB4?=
 =?utf-8?B?dmJKSWxvYTMvUUtUTE5KN0dMVmZaeVc1ZW9kaFliYWZvcnZpSkRUZ2FDY0VV?=
 =?utf-8?B?YmNKQS96Q20rbkFsWFRnaGV4Q3pSb0lnRUFwOHRXTGl3MWFhQnJpVk43amFE?=
 =?utf-8?B?cmZsRlpaYnByTmQ0Z2p5SjZHSE5STXJBQ0N6SVBoZ0drd3ZTYXNJckkyc2Zr?=
 =?utf-8?B?N3YrMW45RU9yclBDdVRycFZnN1Fpb3ZwZ0NVcHRPNzBxa0kxandXaTIyc2o3?=
 =?utf-8?B?NDFzUmtCTmdjbFJrbzczc05Zd0lXQmxEOFdSamtxYklFN3FWR0pzOUpEbFJV?=
 =?utf-8?B?RE5kV1Z6anB3bzQ5WnFEeHQxcjFJRlVVY0swR0MycG15dFUrMERreGxCZUs3?=
 =?utf-8?B?NWxsRWFhQ1ZNNWNDbE9aOUhMR2Y4cjlIZk9IdERSdGRkNEJBZjNSczczSXJP?=
 =?utf-8?B?dlRzanU5WG4vQmpKa0NNbExiU2Mva2d5dWMwYUZyTG02SGp3Zm9RZm9SK2ZK?=
 =?utf-8?Q?uNjYH2KzTEqRo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDZxSXk5QXgxQlhuZFowVkVocTRrK29ueHVYQWx2dzlNa3VrOGZGQXdKZHU2?=
 =?utf-8?B?Rk9JQTNIdlNMZnVwWnJPbXdldG12K1RBYXpaQmdiM1pjK21wTzN3Q3Q1MW9z?=
 =?utf-8?B?VWppaG9zazNMb1I2WUR6eFhGRFdoaG9hTmNKWHhYWWY0RkYyU3N4WVlTb2g0?=
 =?utf-8?B?eUhiNVUwdCtUSzlzcDl2QTlZa3VDejdqRnE1bTUvcmhMOEhRK1l2b1g1MG5i?=
 =?utf-8?B?b2tWNVg3SU5Hcnh3UEtDWllhTVVyZ2MxdmZrOWRKVUV5c1gxMmhtckRTYndR?=
 =?utf-8?B?c0RFUHpIZmwzTDRKdTRQRi81bXFUU0ZhRExCNFJLV1Z0eXpseXF2cVQyTjNH?=
 =?utf-8?B?am51bmdMZlVBNDU5TVN5WUZiNTVoL0thekRldnZBV3d5QzhzR1VzTUgwVzlR?=
 =?utf-8?B?WU02TThFVkJZQkt6bkVBOVVXYW1wRHVWaWprWnZLdGw2V2dxNW5FQzhsZTVt?=
 =?utf-8?B?UE11ZmNLaXNRM3BUSUFVVUNPdzBBUVB2b1NHV2dEM1Q4NlM3RkNqbVlTNkFp?=
 =?utf-8?B?VnBTQlZ6blBEL3Bka2Jva3paNEpvM2NyUlhOdGJuaGgzbnVkYm11SDg0QnFm?=
 =?utf-8?B?aVhNZGJHRjFmRjFCQnRnY0VaUDl6ZVZxTGlqVTYxNFpvblNVclVJb3Y0QlUv?=
 =?utf-8?B?RnRyL3RNQWVMc1dYVnFHWUJFRTNKQlFFSENwVjBQVUpnNVBBV0V1OE5pZzIw?=
 =?utf-8?B?eGVraU9FNlhHQnZLSjJGQzZiYXE4Q3MyNDliVU1hcE0ycHdxa2MvMEtoN1Z3?=
 =?utf-8?B?c1p4THo3M2dlY29aSUlTekltY1N4cUozOGl3aGxsblBneGtRanozYnFiZmh5?=
 =?utf-8?B?SUdUUktnOTlCTWNxU2tDdDZySmlNc2thRmdTTnEyM0ZrRTNRL1FGTm1SeHVW?=
 =?utf-8?B?V3d2Um5tYjJVSmlxQ3UvVGVadGFjNFdUTDZsTXVVNGVwajhVcGNjQTJ0cmZq?=
 =?utf-8?B?cjN2TWZKZTVJL09tWWlGMVJmVXFoTFFXbk94S3lHRmgyTW0vUktGbDM0T25J?=
 =?utf-8?B?SWs3ejlBNzR4NktVTlZyOGdmSXdlVVRXaWZTOWlPcjlZbHYwY0hDQXZ0V0VL?=
 =?utf-8?B?TlF6U0VIV2tyanVLNHZUSmorYWlLMTFLMFk5SlhmcTlscUJTdXM5azl0cFFt?=
 =?utf-8?B?YkhTbHBoZnVYL1BrT1JyOVk4STlmSDFRQndWMjdJZ3hNaTlaQjkvWk5mZ1pR?=
 =?utf-8?B?MVNCZTlGcXp6WlRYUHJxSnRJeG9CUWh2VlZDYWJxcW5NcHp5Z255S3pzcUU2?=
 =?utf-8?B?T3dOaFdBd1NnQmZ6bi9EeENoakZPSmtLTFY4bEN3ZXpPY1hqWFRSdkJ1Rzd0?=
 =?utf-8?B?T1ZNTUEydktKaENIellDQ1RCZlhsSHZwZi82anRaTkpHNzVrclFzL1ppVVlB?=
 =?utf-8?B?TFdLd2VJa3d2WWQ4SjFxUHFraUx6RzhYNXFvR2FEaENVeHB3bkdLZE5PNjRt?=
 =?utf-8?B?bDFGWGhWUkxQc1pxcC9jc2QrUlc0RU0xOGZma2cxd1hEeWNHZ2Nib1RKTXFZ?=
 =?utf-8?B?cGhhZlY1Njk0L2ZlUlZjMWpnd3dQUzFWZGVCc2dWbnBmZWFRYm5lZG90azJx?=
 =?utf-8?B?SGdhbWloNWxTYzVJaDlCcmxTdzlveUwvTnJBT2pwRmJWaWEzWE9GajlCOUNW?=
 =?utf-8?B?djlOQTVkeFlJR1JXdUF2RitoSmhNc21aYXp6ZlpNT3pzd0ErNlA4bm9FelFI?=
 =?utf-8?B?RWEvcHBRaUFwNllBZWh2NFd3TGFYRlBYczhEZTNzdkJ6b0FDd1crNVAzS1dC?=
 =?utf-8?B?VFVubThWUlhzM045TXVEM2trak9XZWk3NnFSbHRoRmI3aDVLdGxlUjBPaGZ4?=
 =?utf-8?B?QVBFSTBLS0VPU2tmV2RvTU52RHpqMzFyRk5BQWo4YkhTcHBQT2hOd1VzUit3?=
 =?utf-8?B?TGhyYWJnSUgvbzlGUzZNTERadUpuUHRXc3NZbnBHUm9oaHNTcTljZlRRVlln?=
 =?utf-8?B?M1lEWWxkN1hrOU5FVkU5cVo5cms4Z21veDI3ZWpvN1dwczNKaWpFN1ViYVpm?=
 =?utf-8?B?a1hQZGNvdEVlR29EdlBJYS9jTDV1bFg1dVdyT3ozSWNrcmFuaStVRnVqdm5Z?=
 =?utf-8?B?WXJmc3BnbGtic0pVdHVoUEVrc0U3S2ZzNHpjSUE5OEFTZ3lKbWpPMGxLdkR1?=
 =?utf-8?Q?gEQIXnUh6EmlzCVP1IIk1xNDy?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18604b53-b0eb-46e7-afe1-08dd3c656ba6
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 10:54:05.3531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0b7ii0O9OFnjv9w9xdiRsEobEdC4jmP3rGeFLmaxJL59brvrvXozBt2WJpQ+Qj/rLsg5AeEKPzz4XtuwOIPjng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6951

On Thu, Jan 23, 2025 at 04:25:10PM -0800, Namhyung Kim wrote:
> Hello,

Hi Namhyung,

> Sorry for the late reply.

No problem at all.

> On Sat, Dec 14, 2024 at 07:34:52PM +0000, Aaron Tomlin wrote:
> > This patch introduces a new option namely "--no-advice" to be used with
> > the add command. Now one has the ability to avoid the generation of any
> > advice when a new event is created. Thus making the output reasonable.
> > For example:
> > 
> >   # perf probe --no-advice --add 'user_path_at%return return=$retval:s32'
> >   Added new event:
> >     probe:user_path_at__return (on user_path_at%return with return=$retval:s32)
> >   #
> 
> Thanks for sending the patch but why do you care?  You can just ignore
> the message.

I understand.

As a frequent and avid perf-probe user, I often only need to confirm the
successful creation of a new event, ensuring its presence under
/sys/kernel/debug/tracing/events/probes for subsequent use with Ftrace.
The ability to suppress verbose output would be a valuable enhancement.

Please let me know your thoughts.


Kind regards,

-- 
Aaron Tomlin
