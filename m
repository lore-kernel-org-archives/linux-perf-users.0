Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020115.outbound.protection.outlook.com [52.101.196.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F6B1B87C9
	for <linux-perf-users@vger.kernel.org>; Sun, 16 Aug 2026 01:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786845047; cv=fail; b=T2rJiKkxJ6Z3fCiZoKSN0Z5QXRJ2S/SW0afWuV/87W1UZYUO16srIfClboV5aZ9JjaH9shAe8buldg4X3gyKW2TQ7PJiGAhh72p/8cCulEppWipp9ppA/q1WgyocVHHbRk6mop9bzlv1GOcUtWIHw3gEeAR76pY5dNixX05c8m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786845047; c=relaxed/simple;
	bh=LJANeOQUsIpcs/oQR43m147Keqnlyq4b5pxw7KEe1Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J+90rpb8H0dO7COPorb3w6w/uKGZU+SCG3FiEoHrE2L30ca8aPBDbvegHT/zE6MnF3MD362UHIXq8hO3jIfcz92jyTIyEZbc+Kysu94EgPSb5gf1Mj78j+3FiFKr3EsQUC+a73XvrIfB8Ar+mIzrmgQpVkh7WyXjOWwwguL86PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXspwS7HauSUP7t6S9xKv3jNDxFNS2Pzg5Z4xTZn9/mrk/8CbXDQFuPl9tayC+TeUbAoqJVZ0F0PqvmtBFaDAo39dtrDPqePdD9YYKxUZwVjDvk76rkxot5WOz3cB8RBay8iT+/wHhk85AoK8dNxRaHQTIfzlbsxSQydmrq0x3XmtZDOOAJx9VXr1YBuuuJXGrmzyXbomT5PGsSPQgMxzs4tZ2dBQc8QVZjm4R+ZrJhYmizRoytZzruvK0C6FhDaa2vwl69jjhVNIntA44DKPxlOfHgLuK5N4zBPlyiUm766lC110hLb6nc/QgIMcJAt3YLJF9h2TaaFeWNf6N/quQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=ZAsRrb+NdCy/rpdR49KUrQUJDrPC/CbTzdeOTmAR0kQ=;
 b=AXJU92DTUkmzU/ZIZqHxOgJ5EkeGE51TcwINS3W1fRkwLkFWa9xEQ9i8CiQM8AJkv5pwGOZjaH8mE0D2fX5EXf4uzmJAIWJ/aWMNrzRXVnzFW6UXiFRY44OcrqUI70yQsEhEedA8YzrZME0S4HjvABCgPbEKC8HhKkdKiNp2RrRipLglklceno4NaydZpEErNf0zDenDR6AvImUzTDDgbt8RJRmqM4Xt5DDJOALFxh7roPCCbocZD1WkO41EC0unTHUPy6UmpKnAjFEHY6tlOGS6DLtsgXCfCEZVUc/TdI8LnSsPcliSEcIV4meXYdm/I6Klb+8SpMEKxz5fbyXFlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOYP123MB3582.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Sun, 16 Aug
 2026 01:50:41 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 01:50:41 +0000
Date: Sat, 15 Aug 2026 21:50:36 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: namhyung@kernel.org, acme@kernel.org, irogers@google.com
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next 1/3] perf trace: Introduce kernel symbol
 beautifier for virtual addresses
Message-ID: <lu6kmbwozimfbpndj7vvfhihqxmblqowwgs67vkdvqp7wp62is@bj6hfyskc2fv>
References: <20260815233651.527936-1-atomlin@atomlin.com>
 <20260815233651.527936-2-atomlin@atomlin.com>
 <20260815234446.84F6D1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260815234446.84F6D1F000E9@smtp.kernel.org>
X-ClientProxiedBy: BN9PR03CA0928.namprd03.prod.outlook.com
 (2603:10b6:408:107::33) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOYP123MB3582:EE_
X-MS-Office365-Filtering-Correlation-Id: aac38a15-d0b6-4a47-27c0-08defb38c6e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|3023799007|4143699003|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kEOjDObbR4fSmmpa20WS0kzI4nKOjXLJOj9QWEnKNz3Nu6l2fpvDbV/eXi29qm5DLloL0KPIx7xC0GiBmkPnIdqUZCEIkhQP5WMmRat9HrjJ7au7PiztH7D6Zel7+g9ldWxzAGXY20VLPzV6ep6thUVH4B+80Y7Kv9iAVSOHkJOWDHuw3h7JPH0CL6MuEKquq2Qudl87bVryyXC2lWYNHRxocAPOSa72P0CByO1cfOwLTkR7dJPua4QVJ18R1j1V1xcfFIcIOBG5H3HS4NIg/UDB39W4Mwa1MEcIZApXkbbqDXicHve4cmgqin5LYTHwFzXyNaFjUHHln6qqF5MSRLVXMDNe/wsaMACQodo/sr75JGwUqIK3ZlqpNGfXqOwFHehrutEVhDQ/g53q3grS5cigSA/d2LT9+DJCK6x47z/c+xWXfba61eGglFM0kIxyPqD06Jgfx0Hxx9xyERA/lsfKQdG7EsodPSQzyp6Jdpcs8YKPD5Xe5FuLhw2/GBv6n+Wps31Lfv6G0iA78HoqsDsOqCa5V51KAnmUkWFI0SUJWjIyyolYX+lFGPiwJGmcJXCd09rT8SJooSKF2nPSeUN/iYq3yvHyYt6elLmqTL9kdhVUzEbFaDMApy+mEuWGVRDpoMzBAgX/d0rmgoLUabAIlXvS5tL5zvVGMMmwRJg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(3023799007)(4143699003)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmlVckd6UWlZbE0yd1NVbjJNeVNNd1R4ajRUWlpydExLMjM0M3BYelVPank5?=
 =?utf-8?B?cWhaekFpdkpXb0V1cjNwTlR0QzFhT0pYQXdzZ242Nzk3S2d5TFFjcG5BQlRp?=
 =?utf-8?B?WER4Y3NPdy9vRVA2QmRhTk9DWTkrL1JEanlGL0F1ZjRvYUlZbHIrVjlEN1Z0?=
 =?utf-8?B?eCtDRHpZVjZQYnA3UTQwdFNJVjBSVmZwU3NibzB5WDBvVUl4Z3JhcVR2S2R3?=
 =?utf-8?B?a2pLblB1c21td291K1l3bkk4SkptWFQ1MW9xZ3hDUklXM0JTN0h6SnJ1OW16?=
 =?utf-8?B?VUtLeWg4dE9rcmMyalhpQ3BrOG1qd0tZaU5nQUtiRFFJNkpzUGpJVk9rNmRr?=
 =?utf-8?B?T1R4dHB1SXBLV3ltSDUvZEgvZEZCcGxLcUFQL0wyK004THA4N2FFa3R3Z254?=
 =?utf-8?B?K0xtajYxMnFkK3BtV2hoejNmcUFQeWlLbjZJQk1ZNW4wKy9UZFJpSnkvVVZr?=
 =?utf-8?B?N2w0SXhlNUQrdTVyWXpmODgvWTExdmowTkxaampIY3FmK2dGS1hVWWJHUUJH?=
 =?utf-8?B?ejI1MGRwLzZtWFZaaTJVV20xRktSV1dQRXZJcThUWVNpZHpOUVNRZC9NVzhq?=
 =?utf-8?B?R2JKOFN2ajFrNmNyRzNBTFhTRzNCTXU3QXRXb1NhZUxvNjZ6NENKQW02REZl?=
 =?utf-8?B?Mm1uSW1kYzlhbjMzN1VNZ3NoRVhEUmFHTTd0NUN0WDRVWmYvVjgzeEZJQXIz?=
 =?utf-8?B?ZzZUcm1ld3JTV2JYUFQ5bVpPa1R4Uy9oVWs5VW5xMjJ2ekFvd1pBSGU3MzU3?=
 =?utf-8?B?aExwQmNkR0VZelh4Qm5YR3BBQUpkR3F0OU16T3QrcW5keG1kcnZ0SEVoT0Mx?=
 =?utf-8?B?NWhLK2F0N1pmZjZRb1NmNWMrbjNvR1VZL24xTklsMHJWUWNGWGFoZlVROUFy?=
 =?utf-8?B?UUIyaVJyRktadGtWVk0rcnZDQi83ZUQyNENyR0ZWVHBybkh3UGRzZDY4S2pi?=
 =?utf-8?B?YkxBazJYdVpvRHVhSEIwZTBVNndrUjFZZDdKOGJYMXdaOTg2UU9WVjhsNlJC?=
 =?utf-8?B?N3RoRVkrWGNranFObG8ybHR1QVZCNzhacGxieXpadEJURG9kU21JWm44a2FM?=
 =?utf-8?B?YmxiV2Z3NFQ0TXJmNXZ4Y2JQc2Z1a1RrcmxDOEhTVkZLTmlKZEsxMk9HaFdR?=
 =?utf-8?B?UVQwOGVaNStuYzZLaHZzczg3cnk1dEF5ak5lQ2djaDhvR2VHRUZDS04va0xY?=
 =?utf-8?B?OEp5Sk9uTnk1WCtaUWVndmhFaDNLWGQyRURETzc3ZDlqZ01QTEcvTXhhQzFQ?=
 =?utf-8?B?ZzZLTFE2Y1VoeUhCVGZuaE9IMStteTJpVlhiNEk2bzFwbGVsWWxrM3kzUVZm?=
 =?utf-8?B?WkxQOFE0ZjBwNlViaUdpN3B0L3FjVGNhZVN4NzFTc3NGc0dsOVJJcmNDejdu?=
 =?utf-8?B?dWtQVEVvdnRFUFNDV3VtVVhuWXNWYXRXc0JxQWQxeFgxUlhxd3pyU2ttSldT?=
 =?utf-8?B?ZEMyVXY5cUpLUHVLUzk5WTdsZ2dpRnQ1L1pRK1JmSC9zUmRRaXdmUjYrbjJp?=
 =?utf-8?B?cFF6L0t0NElzZTRYOGdySnBvL1FoTjdKeTlMeS96aVp1N0JCekVXWnVBbkVJ?=
 =?utf-8?B?T1RXWThScExnSWNTMUt6OHhYQW5PM3J0Q2VsSi9zSzBnb3pCVSt1UjlvcHdN?=
 =?utf-8?B?VFdwWkVDUG1tSEoyOHF5b2d1SDU4cTJZc252SEpvMmRyTHhsMVgrbjJ3MmU0?=
 =?utf-8?B?Y29ycnp4RlRMUnFCTnFHbjI4ci9CYWJCT1BOdGZ2SXZvLzlZVXpZOEZVSDZG?=
 =?utf-8?B?YXhyMTRuUWFqQ0hLeEFhVXdtYW9HbHFGVG41NGFxaTIxeDRqNWlzMklOa1BQ?=
 =?utf-8?B?cmt0QWhzVGFFRHlZVGV4Rkk3WFBWYjN5dE1EcTEwWnd3dDdlY2FFQjJTUStk?=
 =?utf-8?B?T09vbWUxUHgzSDhvQ04ySFlvWHhEV2J4ZURzYzQwdTl2YTM4TEM2ZXowYWxv?=
 =?utf-8?B?MFM4dm81MUVZRGRoazFYeDVncUY3S29PUlR0S2FWUkQyeDNka3I1MGtPYito?=
 =?utf-8?B?ZkMxUENaM2lQUGlyVExlNUMwWFVGUFlWd1haZkhYdnZ5SFhwRDBUWFpqbmIx?=
 =?utf-8?B?NHJIRnZuaUYrak1qU1VBemt1dllPMGZtUDhWaVIxQkcyYlphVU0yZEx5LzhN?=
 =?utf-8?B?VWt4TS8yM3h3L0p3VU1LM0RWSGdmcjhYYW16TTZCVjg4aVlaZFdBdHFtVW5p?=
 =?utf-8?B?eEZqemt1WGJUV3ZaNWRPOFNrUzg2KzRuY0RuYlMvaGNWVUFNTC94akQzb1M0?=
 =?utf-8?B?TGtEeFNzU1U4cjZUTExBNnRMZjRmb3A3VGtFc1BSRytxWFNSZk8rT05SdEJC?=
 =?utf-8?B?ajdtZU5rWGpZMU9TakhZVXFpeThUOXlsL1VidWQwTnEwWFBOTGUrQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac38a15-d0b6-4a47-27c0-08defb38c6e4
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 01:50:40.9149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnj5CFXWBTUlBLXJS3WKkTz8sBzvIvz7wQJFcBzh0yRdibfhbFO6oS8pNiiEep/eElrgslv6B5uvExPimmKr4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3582

On Sat, Aug 15, 2026 at 11:44:46PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Memory leak of reference-counted `struct map` handle in `syscall_arg__scnprintf_ksym`.
> --
> 
> --- Patch [1]: [PATCH perf-tools-next 1/3] perf trace: Introduce kernel symbol beautifier for virtual addresses ---
> commit 0ff39d14d9508d5e3c586057a78b07cbcda7f7fb
> Author: Aaron Tomlin <atomlin@atomlin.com>
> 
> perf trace: Introduce kernel symbol beautifier for virtual addresses
> 
> This commit adds a kernel symbol beautifier for perf trace to translate
> raw kernel virtual addresses into human-readable symbol names and offsets.
> It uses machine__find_kernel_symbol() to look up the symbols dynamically.
> 
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index c3c7f1f85c530..102221b301a54 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> 
> [ ... ]
> 
> > @@ -750,6 +750,30 @@ size_t syscall_arg__scnprintf_ptr(char *bf, size_t size, struct syscall_arg *arg
> >  	return syscall_arg__scnprintf_hex(bf, size, arg);
> >  }
> >  
> > +size_t syscall_arg__scnprintf_ksym(char *bf, size_t size, struct syscall_arg *arg)
> > +{
> > +	if (arg->val == 0)
> > +		return scnprintf(bf, size, "NULL");
> > +
> > +	if (arg->trace && arg->trace->host) {
> > +		struct map *map;
> > +		struct symbol *sym = machine__find_kernel_symbol(arg->trace->host,
> > +								 arg->val, &map);
> > +
> > +		if (sym) {
> > +			u64 start = map__unmap_ip(map, sym->start);
> > +			u64 offset = arg->val - start;
> > +
> > +			if (offset == 0)
> > +				return scnprintf(bf, size, "%s", sym->name);
> > +			return scnprintf(bf, size, "%s+0x%" PRIx64,
> > +					 sym->name, offset);
> 
> [Severity: High]
> Does this code leak the struct map reference?
> 
> When machine__find_kernel_symbol() populates the map pointer, it acquires a
> reference that the caller takes ownership of.
> 
> However, this function returns directly on both success paths and the fallback
> path without calling map__put(map). This will cause a memory leak for every
> formatted event that resolves to a valid map, which can quickly lead to memory
> exhaustion or LSAN crashes when running perf trace.

Yes, the code feedback is completely accurate. The implementation leaks a
reference to struct map.

-- 
Aaron Tomlin
