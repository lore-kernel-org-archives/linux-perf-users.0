Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2108.outbound.protection.outlook.com [40.107.93.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FB81E103F
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Oct 2024 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425533; cv=fail; b=OeZ3ZcBHBgKXDSNTbAEXcOsc3pqUWRw8yAuw+r5AFd9Fn0f6ZU46Mt5pv1FK0LmmuoiXGzj27Pl9HlYzhApc4IhU/GTSuDp2R263ch4MxyJNE74w6DhHHTQ4t+z2jlHgqN34hWMC77bIu5+6j+5Nqreh0GskOsBe0w8n/FHRAE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425533; c=relaxed/simple;
	bh=5j6hxllQr3R10Y8QuUzr/VBYAYFTy3jTeNERZbCvKf4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TLPXPfSFgLWOMuUKA8H8ESHlsK3pNrvxM+p446bNsP4hOJMdnijM3sIVJQURxrogGoBrhuqTZ01kpggxxC7aLZT4/bhXgGk45ip+Mlcvt03Wu8HDruvTwhEtwo7sT8WVvELpVLr3MSu7P/od4xvhSDElGxBkpGAh4PxyrxzPoBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=mNcE/d37; arc=fail smtp.client-ip=40.107.93.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="mNcE/d37"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1i3xnf4l6RrhITb42qJyZxQORPhzmRIo8DJqG1tyavNZgXTWvlGGTkPMdn5L51mr15K3k8aSNPotgbnWOuMJgZdZTj1XCgUOJPJjlezTimmz50tiAzej3Nw8K3arHkM+76WVorw82s7ZpbBUK7RIKbBUydCdX/VGUgO+C9jUzWcM1zD9nd2Cd2OERE5nr3VS08TWqm5DzsDZSkYSLHz1eLPJo8dgSNH/55qdB3P2caOy1/wUkAbIoC6wLTpHpVSXZXVhQ5MdjS3AkJ5Q3Iu1utfwEfSd8H7hCahD4qASxP3G4qyT6xNA3V3lcxTIKeYmuQRjrky5IXuCZZqif+fHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VT/0qI1bHmac66alDxFw/GU+PXpOZBVivCN+VebaUTo=;
 b=cfVfw4rnC7/QyG5/8JrZJIBDYMh1cZAbRmxSnqISroCG9MuJS6p3MRYjR9ub2d7VpNGkk7Q+0uDQHs1mTiR2epsI4CJTT+chom6+rO6WC77OOzekO3PIS9WQ71QhCu/3G7IEp5k5l+c/QIRwnEhk91hifvABE0zFX9R5gq66jw89Th9vLI4PUsKb14CPXsncaXzuf+pakUep5HYOTGx09X01oQhA0rFiAw9BuMeXDfQlObLvkFHLP1d6hQ+JWA3RlNqYC3kCZ1bqMBTgKYa9l43mv8YlwAZCebSvIfXyYikOTDU2IjkK0KxscQpvCHu9khGFpkOyR1RK9rd/azqkhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VT/0qI1bHmac66alDxFw/GU+PXpOZBVivCN+VebaUTo=;
 b=mNcE/d37HslCkxxRzEeg0C4ijP987SZ4p0X6cfQ3KJarOcGHOcj2lBoISoziloAeU42PXOloFpTuo5dacyLy8ghpIuhWHxcHb1iZWTrlPt8PPi3A+y/FdVGdO1lIjqzkn+iFCE5lf6s6kK9nIcvFeoc7yPhBPkBLf3W0bFciGjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8150.prod.exchangelabs.com (2603:10b6:a03:4ff::5) by
 SA1PR01MB7374.prod.exchangelabs.com (2603:10b6:806:1f9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.32; Tue, 8 Oct 2024 22:12:06 +0000
Received: from SJ2PR01MB8150.prod.exchangelabs.com
 ([fe80::72ca:29db:7676:9fea]) by SJ2PR01MB8150.prod.exchangelabs.com
 ([fe80::72ca:29db:7676:9fea%6]) with mapi id 15.20.7982.033; Tue, 8 Oct 2024
 22:12:06 +0000
Message-ID: <c062457d-448c-477d-b931-f52a87159f0b@os.amperecomputing.com>
Date: Tue, 8 Oct 2024 15:12:04 -0700
User-Agent: Mozilla Thunderbird
Reply-To: scclevenger@os.amperecomputing.com
Subject: Re: [PATCH V8 0/4] arm-cs-trace-disasm.py/perf must accommodate
 non-zero DSO text offset
To: Namhyung Kim <namhyung@kernel.org>
Cc: leo.yan@arm.com, james.clark@linaro.org, mike.leach@linaro.org,
 suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1725667397.git.scclevenger@os.amperecomputing.com>
 <cover.1725667397.git.scclevenger@os.amperecomputing.com>
 <ZwTIbRbAX2EX31X8@google.com>
 <c2b1d122-83e5-4392-9009-2d22e59aa14a@os.amperecomputing.com>
 <ZwWdhvud5f7tRxkW@google.com>
Content-Language: en-US
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
Organization: Ampere Computing
In-Reply-To: <ZwWdhvud5f7tRxkW@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::6) To SJ2PR01MB8150.prod.exchangelabs.com
 (2603:10b6:a03:4ff::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8150:EE_|SA1PR01MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: b53bf304-0fbf-4d63-0205-08dce7e63f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzVPTFNVYXFBTXJ0TmVkdmZnWWNtMmRzd1YvYkw2bWROTzQvcEN3dkpDeHFL?=
 =?utf-8?B?Z09zK01GWUt1YnkyMEFYa3NnQTRpU0YyejQzVWhYTG5kWm4xNklEdDZUUUFU?=
 =?utf-8?B?V3pDbGlwYXVuZktNYUZpbWVLTmtaYkZSQUVEUjAxZTJ0UXZaSVBjd3JvUGor?=
 =?utf-8?B?UXpENUFQRXBkQ1lKMUtLd0FzTnd3QmQ5aks2NlA0RFV1MFF0RVVUbXA5YWVL?=
 =?utf-8?B?MURIekJocWZ5QnIrQjNEY2VheTZ5bXAzMXlveTdaV2p1a2g3SjVvcElzQXpq?=
 =?utf-8?B?bGJFZktYYktVZGx3ZUNUQUxKbjdNamxyckhvNUtZOW9tc04wN1JNMG5TSVpY?=
 =?utf-8?B?OVRiRkViendiLzJ0dDhEVldlMnM4QWk2c1VEOTY2VEVEeitWQWNuN2IyVGV1?=
 =?utf-8?B?SElEcTE2ZmJBSGtFSTNjdGRVN1Q5NVdEYUN3Q0NVMjd3M2Vvbm5iWk40TEdL?=
 =?utf-8?B?ODhNSExBRitKeXVpYmQ3MFd3cUR1b3VQTUg1Tk5uUTJHaFloM2ZUSk1FN2U4?=
 =?utf-8?B?bXFKZlQyZGVkVmMxSzd2b2kyb1dCQnJucVJ3TGpJUDVOTEpwUnhZY1F3czRB?=
 =?utf-8?B?cHcyRStwT1NRSit5VGJpSGpyUko3a2hkT3JXSVpUUEpiZkZVMzB0a3VRVU5m?=
 =?utf-8?B?WEZuT2hBa2U2djVUcTllQk03Q3p0U1ptc2RxQkRkUThVMlNZK3hKam01Sit1?=
 =?utf-8?B?aVFlaEdvTjF6MlRZS2hhcG9sZWxDeDRHRGJoeHhVemxCZ29vQ01KZzUyOVpj?=
 =?utf-8?B?MTlOUVFGKzJpWmh6a1czVzlGdnNRUlNnWTE1TnAyZVFCdlJ6WG11eDgyUjNi?=
 =?utf-8?B?MU9XUlc2MDB4YkVpWE12SXRsMUo0amh4OHhOMDR4WDUvQ2x1azlwcndIU0Zp?=
 =?utf-8?B?YWhQOTVkVTVlN0hPWStlR3Fqb3hUWkZhU3RxYmxUYU5Yc1Q5ellHM2R0TGpl?=
 =?utf-8?B?aHpmd0JSUzRSU253M0JUNDI3ZzhES1lyRGFwaS9WNHBEeG5GRUxQRFVMMUhv?=
 =?utf-8?B?MWgyUldTbFc3UUxHVmtGQ1lDQ1BKTHVqL0QyTDI3Q1BYcHYrZGNrbWFJYUdO?=
 =?utf-8?B?MHlmTlVkQXZETUtzeUhHMjZsQkFiQnM3eU5HTzlVVUI0cCtOSm1iNGNBN21B?=
 =?utf-8?B?N05zckdBN2ZvWVlzRGY0OXdoZlQvT0ZNelRscnJUMEt5cnkyVTN0bEhHN05P?=
 =?utf-8?B?cklMalZ4WUJ2RmhudGdvUE5DQnVZUUtrWXlicC92bGRpbWo0MHZrcjI0QXZu?=
 =?utf-8?B?VElCbWFPNmU4KzlYL1l0akd1WjBOQWVIRklMaGxFNzZWY2JpdElteU8rVzFH?=
 =?utf-8?B?R2ozU0poU3NpeHc5Ky94MFRuNGI4TjV6WjRrOVZYSTJyK3kvbGZsWlYrYW01?=
 =?utf-8?B?QWkvdXlqcXpockw4OG4xNUI1R3dPU0hJaVk1Z2FWbUVOZDNwY3hFVzdFRllC?=
 =?utf-8?B?d3l0cUttL056WnBxVmtHWXR2TTFCYTIvOUVybmExOGpDb3V2ckJOOGt4bWts?=
 =?utf-8?B?d25YaGxqMk5pc3ZzMG9ydkMxTXNnNlBBVHNLT1NXelZYRXhJTEtIVUNPT1Ux?=
 =?utf-8?B?WnNXLzJBeVBUMEg1OVhXRUNNTm0waXVCN2hjRFcyWFhsNEFGVzhNMEllZCtq?=
 =?utf-8?Q?pchmzfrNqPEm1CFAreh4nOso98olIsJzN8nnCuF1ggdI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8150.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWk3ZUdqQXdBbmRoU1prV29PTndVNXNuUTB0MkRhNHNnbE0rY0JoQ29tbE5O?=
 =?utf-8?B?WndUNXJMblk0WnVuOEZSVUprNnluVWFsQ2puQUlTcTF6dyt6c3hGNWhkNVdE?=
 =?utf-8?B?U0o0ZFo4ZC85OVdnRzZxc3lZYTZGMVNybDZ2Z2FHOWFuZklKMUFYUjhKdFY4?=
 =?utf-8?B?a25JMU9iV21MSDBBRC9WYjh0QTFrejNETmwxdjJSQlRQbitMaEdMR2NxZit5?=
 =?utf-8?B?NnhqUzZIdGZKQzdqMnNhNE9VYnZqQWcxaDJnWGdXT1VHM2gvdTJMQUIwVkhx?=
 =?utf-8?B?U2lYek94YmZGdlA0ZWY1R05odmx4K2xJMS9ockNBWWxWTWNqY2VLNWg5bWpQ?=
 =?utf-8?B?VUcybnYxU1Brb3M5K3pCNjU4K2xncCtYTnF6dnpTSHJFTUw5aHZNZmZXUEFw?=
 =?utf-8?B?K0d5OUlkYWxWelo5Uy9yMXZiT1hoRGxzRGxaaUxkQlovSzVqbU1yeWxPRnRn?=
 =?utf-8?B?c3VnYVdrR1l4SWtkYStDOTRnMnVzditlMGhtN0xPUm95cHVldCtTQWVaRTMw?=
 =?utf-8?B?RzNPaHR3U21FZDFJUXd1VS9MMXNXelhOdkl1U2lkZ0tMcHQremxYMWtkb1ho?=
 =?utf-8?B?K2ZtdXlDMVZmam9RK29UWVg3K2trSkltcG1pdjUyRm40ZTVXdDd4UDNiQ2Mz?=
 =?utf-8?B?aEx1NG80blYwNFFxc0pkMjBJdkZLQkcyTzV2TFkxdEgyc0gyL0p5dW1xMEFF?=
 =?utf-8?B?YlVZY3B5KzVWU051VE12cDFkWlhLTnBzVVVEV0tnZ3l4YW90NDhlOHRRbkFI?=
 =?utf-8?B?aUwrL3Z0blA5Q3lnWkJ5VGVVdFZ6aWF0TmJNdjY1VHZuUXVuK3I2SWlQNnlS?=
 =?utf-8?B?VnBKZGQvRWt1N2xEMTlUdWlac2hrVGVKdS83SUc0Z0N2Z0lleVNKYVdYOXNa?=
 =?utf-8?B?Mnc2UUVveGJ2OVFVR3dxRmxPYVE5OHIyMDdTWXZPbFRvU0M0SlRJL2xOTHhT?=
 =?utf-8?B?WGFQNXU3cTAyY200SHY2WVpMVGpQRjZvbHJpY1E4VW5OMkJNVEo1SFVKSWtI?=
 =?utf-8?B?T2c2VXEydHFLYjFKeTlOTXFYcHRwRjdFWWNDRUdXWUpiL2wrdWxsK1dkYTZm?=
 =?utf-8?B?dFFJYzAyNXQ2MmJSOEEzSXlwT3dCS0Q3WHl4ajlobmg0bjZBSUY4Mk1rTys3?=
 =?utf-8?B?cXAvK2F1WXpSZ01qZTdRYU13NXd2aUxvVzBNTWR6RGI5emhJWlFYVUM2N1Vq?=
 =?utf-8?B?VkUrRjF4bVNMOU44QmpFeHpYTmZhMFRoQVdyMk1rTDZrR2w3TklHUVI2elNy?=
 =?utf-8?B?N0tOaDFYSnFQeENadWJKV2h3cGY4dFdtc2xMUjVTdUZoU2E5cjBJU05mS2hj?=
 =?utf-8?B?OG15anBYa0lZRGcyYVRHTnIxRElobzZoN01RZGJrOHpPUmxwNFF5NFNKcVRs?=
 =?utf-8?B?RzRjVmdaSlhDOUVRdElZS1FhM2tOQ2s1UzBlK0RJUFJIb3ZuR29seTg3eTNM?=
 =?utf-8?B?K0Q4UEVQVjBvZ0JOUUk4VXQwNmtDSm1jSmNNa3VCdWIrNlZLWWkxSTRqZ04y?=
 =?utf-8?B?aGpIcEc2RStxcUJuQ2laL3NCR1Y3KzVDYXV6Wnk2M2NzM0hIaVJCVU92UDMr?=
 =?utf-8?B?RnZzZ1BQbzBnd3ZPbjRwVWY3eGtFY0Vnd1BRem1UcG5Yd1c1U1VWd1lLUWVZ?=
 =?utf-8?B?cTZiNGN2QTJPSDVtR0llK2krODF5cnF6L3ZpcG04VUxrTXZMdGN2WUI2SURW?=
 =?utf-8?B?TWIvdndiWlRLUTYxV2Noc2svbU5lRmpyNWFkVTljaW9DOE0zN1ZXb1ViTU9S?=
 =?utf-8?B?dDJJMHU3NVZ3cGxGMXZ2UnpJNUVROE4zaS9qTERGQWJQSjIvclZ2UXlyK2U4?=
 =?utf-8?B?WXNOOW5nSUtiVVRZUk5saG1pc05GZW9IcmlEUVpZTlA4TEpNMUxwa1kvQWVk?=
 =?utf-8?B?YWI0b1A1TVJ3MmRrZ1pwVzhMS1lmK21LMDgxSVFLVUJhTXpzNC8vWkc1ZkZp?=
 =?utf-8?B?OGtZczZ0bi9sdFlkK043ZWVXNFVZWStVYWx6ZWVCalZ3M2JObGpWUm1oeVYr?=
 =?utf-8?B?ZUNmbG1sZnNET2s1Y0RvMTQvY0NPZGdNeFpVSk0yc0tjZjhDOU1wdW43WEsz?=
 =?utf-8?B?RnYyREl6R0dpb0VOdHVKYVAzMFF1RVREYnU3YWNMUmJGbnVybjFSMlVZUVAv?=
 =?utf-8?B?KzZKZXlTT1B6djNsdmhFV1BSU2xrUEFac0YxVTVsNi84Q0d6Q21jd0RlYWJi?=
 =?utf-8?Q?J/llgJZ9/77yY4736AViCTHM4TmxLg0v97r7SoTMkr0q?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53bf304-0fbf-4d63-0205-08dce7e63f05
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8150.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:12:06.6443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjB49g1nZraoKMtOFbo9ZTks2lIQnpvgSUoeaYs9cfzehwhTmtp+5eQ38H88uLbMtr5pjrSYDguAsOWY7kh1E+QANPVETySmR5k6f+OQjlgsvZF9SRee0A6B8oMlXOWK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7374



On 10/8/2024 2:00 PM, Namhyung Kim wrote:
> On Tue, Oct 08, 2024 at 11:24:45AM -0700, Steve Clevenger wrote:
>>
>> Hello Namhyung,
>>
>> Sorry your question is so late. I don't include the ELF headers here,
>> but the problem can be seen with a perf.data packet dump of user
>> instruction trace capture. The problem is with the non-zero pgoff. The
>> arm-cs-trace-disasm.py script was never passed pgoff information to
>> adjust the start/end disassemble range passed to objdump. This patch
>> distributes the fix between perf and the arm-cs-trace-disasm.py script.
>>
>> Here's a brief excerpt from an e-mail I sent to James Clark describing
>> the patch before I submitted it.
> 
> Oh, is it applied to the coresight tree already?  I don't think I got
> any notification for that.  Please make sure to notify perf maintainers
> (and hopefullly to get Ack's) when you touch non-coresight part of the
> code.
> 
> Also I think we need to clarify how to route coresight tool patches.  I
> thought they are going through the perf-tools tree.  But it doesn't seem
> to be the case?
> 
> Anyway, sorry about being late on this.

FYI. These patch(es) were based on perf-tools-next at revision
6.11.0-rc3. All ack'd by Leo Yan. If they could get merged to
perf-tools, that would be great!

> 
>>
>> -----------------------------------------------------------------
>> .
>> .
>> This e-mail is to document what I know and don’t know about the problem.
>> The background is Fedora 38 introduced non-zero text offsets into common
>> shared objects and executables (e.g. libc.so.6, etc.).
>>
>> If you were to ‘perf report --dump’ the perf.data of a user mode
>> instruction trace on Fedora 37 and grep the PERF_RECORD_MMAP2 packets
>> you’ll notice all zero values (@ 0) for shared binary and executable
>> text offsets. Repeat the same for user trace collected on Fedora 38/39,
>> and these text offsets show as non-zero.
>>
>> Fedora 37:
>>
>> 4294967295 18446744073709551615 0x8ac8 [0x78]: PERF_RECORD_MMAP2
>> 2389577/2389577: [0xffff85124000(0x42000) @ 0 103:04 805306555
>> 1941233998]: r-xp /usr/lib/ld-linux-aarch64.so.1
>> 4294967295 18446744073709551615 0x8b40 [0x60]: PERF_RECORD_MMAP2
>> 2389577/2389577: [0xffff85161000(0x1000) @ 0 00:00 0 0]: r-xp [vdso]
>> 4294967295 18446744073709551615 0x8ba0 [0x68]: PERF_RECORD_MMAP2
>> 2389577/2389577: [0xaaaab09b0000(0x10000) @ 0 103:04 1140851919
>> 994218038]: r-xp /usr/bin/dd
>> 4294967295 18446744073709551615 0x8c08 [0x70]: PERF_RECORD_MMAP2
>> 2389577/2389577: [0xffff84f70000(0x1a9000) @ 0 103:04 1677721733
>> 3891973508]: r-xp /usr/lib64/libc.so.6
>>
>> Fedora 39:
>>
>> 4294967295 18446744073709551615 0x8ac8 [0x78]: PERF_RECORD_MMAP2
>> 18229/18229: [0xffffa5512000(0x1d000) @ 0x10000 103:04 161 4093340249]:
>> r-xp /usr/lib/ld-linux-aarch64.so.1
>> 4294967295 18446744073709551615 0x8b40 [0x60]: PERF_RECORD_MMAP2
>> 18229/18229: [0xffffa554f000(0x1000) @ 0 00:00 0 0]: r-xp [vdso]
>> 4294967295 18446744073709551615 0x8ba0 [0x68]: PERF_RECORD_MMAP2
>> 18229/18229: [0xaaaade7e0000(0xb000) @ 0x10000 103:04 536876423
>> 421616320]: r-xp /usr/bin/dd
>> 4294967295 18446744073709551615 0x8c08 [0x70]: PERF_RECORD_MMAP2
>> 18229/18229: [0xffffa5360000(0x11f000) @ 0x30000 103:04 536873199
>> 2415801053]: r-xp /usr/lib64/libc.so.6
>>
>> The arm-cs-trace-disasm.py script never gets to see the text offset into
>> the dso binaries, so has no opportunity to adjust the start/end address
>> range passed to objdump. This wasn’t a problem on Fedora 37 and below
>> since there’s no start/end adjustment for a zero text offset. On Fedora
>> 38/39 distros, the instruction trace shows unconditional branch
>> instructions which do not branch to the target address, the clearest
>> indication of trouble.
> 
> Ok, thanks for sharing this.  I'm ok with exposing pgoff to the python
> script itself.  But I'd like to make sure if it works correctly with
> PIEs that have non-zero page offsets in other places (probably ok).
> 
> Thanks,
> Namhyung
> 
> 
>> -----------------------------------------------------------------
>>
>> On 10/7/2024 10:51 PM, Namhyung Kim wrote:
>>> Hello,
>>>
>>> Sorry for the long delay.  But can you please explain your problem in
>>> more detail?  Showing ELF program (or section) header would be helpful
>>> as well.
>>>
>>> Is the problem when the text mapping has non-zero pgoff only?  Is the
>>> kernel symbols working correctly?  Or is it just the Python script
>>> broken?
>>>
>>> Thanks,
>>> Namhyung
>>>
>>> On Mon, Sep 09, 2024 at 03:30:02PM -0600, Steve Clevenger wrote:
>>>> Changes in V8:
>>>>   - in arm-cs-trace-disasm.py, ensure map_pgoff is not converted to
>>>>     string.
>>>>   - Remove map_pgoff integer conversion in dso not found print
>>>>     message.
>>>>
>>>> Changes in V7:
>>>>   - In arm-cs-trace-disasm.py, fix print message core dump resulting
>>>>     from mixed type arithmetic.
>>>>   - Modify CS_ETM_TRACE_ON filter to filter zero start_addr. The
>>>>     CS_ETM_TRACE_ON message is changed to print only in verbose mode.
>>>>   - Removed verbose mode only notification for start_addr/stop_addr
>>>>     outside of dso address range.
>>>>
>>>> Changes in V6:
>>>>   - In arm-cs-trace-disasm.py, zero map_pgoff for kernel files. Add
>>>>     map_pgoff to start/end address for dso not found message.
>>>>   - Added "Reviewed-by" trailer for patches 1-3 previously reviewed
>>>>     by Leo Yan in V4 and V5.
>>>>
>>>> Changes in V5:
>>>>   - In symbol-elf.c, branch to exit_close label if open file.
>>>>   - In trace_event_python.c, correct indentation. set_sym_in_dict
>>>>     call parameter "map_pgoff" renamed as "addr_map_pgoff" to
>>>>     match local naming.
>>>>
>>>> Changes in V4:
>>>>   - In trace-event-python.c, fixed perf-tools-next merge problem.
>>>>
>>>> Changes in V3:
>>>>   - Rebased to linux-perf-tools branch.
>>>>   - Squash symbol-elf.c and symbol.h into same commit.
>>>>   - In map.c, merge dso__is_pie() call into existing if statement.
>>>>   - In arm-cs-trace-disasm.py, remove debug artifacts.
>>>>
>>>> Changes in V2:
>>>>   - In dso__is_pie() (symbol-elf.c), Decrease indentation, add null pointer
>>>>     checks per Leo Yan review.
>>>>   - Updated mailing list distribution.
>>>>
>>>> Steve Clevenger (4):
>>>>   Add dso__is_pie call to identify ELF PIE
>>>>   Force MAPPING_TYPE__IDENTIY for PIE
>>>>   Add map pgoff to python dictionary based on MAPPING_TYPE
>>>>   Adjust objdump start/end range per map pgoff parameter
>>>>
>>>>  .../scripts/python/arm-cs-trace-disasm.py     | 17 ++++--
>>>>  tools/perf/util/map.c                         |  4 +-
>>>>  .../scripting-engines/trace-event-python.c    | 13 +++-
>>>>  tools/perf/util/symbol-elf.c                  | 61 +++++++++++++++++++
>>>>  tools/perf/util/symbol.h                      |  1 +
>>>>  5 files changed, 86 insertions(+), 10 deletions(-)
>>>>
>>>> -- 
>>>> 2.44.0
>>>>
>>

