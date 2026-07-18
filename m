Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022088.outbound.protection.outlook.com [52.101.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8862530566E;
	Sat, 18 Jul 2026 05:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784352118; cv=fail; b=OvbBoHPYezyNfgsxnQT4ZHvHCp6WZ8Er5SnXexmS5metfJc7ZSZJrhhzExFkctzo8iUStyFFhK2m4AJfEre8vUUZn3NhUhd9+EOugrpbYIRue/PLYvNirbrGDN6c1DmpODa9FP0K6F3K1fRLEs1uGjK3wKLJazalwBUn3yXcvsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784352118; c=relaxed/simple;
	bh=EZ1JgiKwWjoxuq01JtMd9HFzPBRHjkNYxyd01fVGrU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TM/Xzravs0o1ahLpJ0ok5Py4dpPqpDFEJvw1XPkbYpUmkQ6V0tQtjbWez+3gYY3xS/a8KjGQ5oXtvpWzqO1fm8GmdZcRjraSowzBWMHGIDSwDIFNl0wUix2VYfJkCAdkCG1Ex0baAzH8mc2IxjPyBkBaxonylT8rHsYkFaRp/Ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Va8E/Hy9ueqMzUC/arJu22Z4gqglTUr/Qr7Qb+Q357mM7QouK+EmIt94xhFwSuFf4WEXTIVYtIzO9GQkNudJsGFACUwFuUxQOaco8FECFQrJgM9apPhHgJpCVL4PpHsWblWvy1PwxEAZLpKD+nMa1WTZtU+b//UYo1t7XSGDpBVPSm++My3Pjfzh3WsdMJM4K4Wp6W3Z83w17SRZMPxvE8GoyeRmAbgnPs5bJqdq3XqFLLLfBdaqCzjXRSBI+Lyo2fBO04gP8VPOLdU77p/g95SghkJp9ojDlFs+jZ4RaUZWmuYQ0yizdSPAkIabRNXmGnbCHPwKuedTycrx69SgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=aVvzyrcRcsOJYrdddXKOI6+D0IbHxqbSMePmOmqDYJk=;
 b=m3cXUtM6nVZ3K9FKsvXjp6yaq/A9cQH0QlZ45p5nYCsS9K7cEEnRYvffYQ2gTu3p/0U3AoNc25nxfiU63BZUzMI/HOpsAAyYEUoWFnrJ9k2pWeISPmPvyKp4wc9ML3KUAepUEbii0NLTZP5Kbt8od1COy+CFEC9aVBgwhWdAtCmiTyVJ5sDxDh6fX8RoqIxCYGwXxlz/1HE8zr990M5/VuVrEMEOjJfQ7mKuJgg3PDSKISl0y+6L9nTRFSTEDd83Q9Ir6GetlY1ps4l/S2wsOCeCbVl0O/Gw7DdXtSS+0U3Vh1H6w3DiioZSCgZqlChgXEQ+qyhht3DgPT0aKoncpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO9P123MB7500.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Sat, 18 Jul
 2026 05:21:54 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0223.013; Sat, 18 Jul 2026
 05:21:54 +0000
Date: Sat, 18 Jul 2026 01:21:50 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, sean@ashe.io, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf trace: Add --bitmask-list option and correct
 cpumask formatting
Message-ID: <4bdchumfthzjult4jysgzkq7bntqhtkieo4qygglymfk3d3q3n@i5uw2oowygho>
References: <20260717013544.257768-1-atomlin@atomlin.com>
 <alsI6DoHlx4NniDJ@z2>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alsI6DoHlx4NniDJ@z2>
X-ClientProxiedBy: BN0PR04CA0191.namprd04.prod.outlook.com
 (2603:10b6:408:e9::16) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO9P123MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 24eb3289-174d-4094-344c-08dee48c7ac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|23010399003|22082099003|18002099003|4143699003|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	xken4e7omkcCWG4sBfFMziieFSDSKMZ37qmLWrs1c6GaS4NP2qqBz09nSDp+NKogCYK/Byq5e8nzYil+XuzMcY6GogQY8q6VscBcVqJcn9r9YLzrZHUgGDJmC3xfLzr/pOYeUDxTA+RzVvpA39SpIE8YO8KR1bwdmlGFLQ4qwMG91hykBf2tVdfNdLeC2ltQRF+46pPOt2uf0U456yKY8em/16JxMwbiA+JwlxgKhs2S+mmap9GMs5lWdwnIEo/bNdFZ7CHDmE38yL3JHCwLTACbrI176RDwz02p76r3Sm7L6GGxQ4g2SD9iEGnzflg0vx79h/WsVPK4QfIvOvdLSJwYPaGr4/q+IIranAjkuNvbqTn6mNHgg0KjErr/64RqlE1K0i/BhU2r36qDqmS9lAjFNUK0/3sp7Pe6vaRTw4Iy1LCBT/5+ylD4BgriNYFN6UZ7Bn5ahHMN+PZyaruU4GloiKc3TWdA5rbqR+VqPvGfr2fAigsHsZ3RnRO2etM300cH+POuNZarhPDMXnrD//Tn9ZtnnMIwD3ZDrwL6xhmOsz0TYyvw/v3s07mKOTWmB3N+0BhjODjKtx+bs/E+///A4/LHKOTyuZc1MAAovuQiaijb/FogkVG8T9fxHjTO8V8bXpTiBmZHWiE8arq/oY5ALO+aBcijIK6npxFV4tw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(3023799007)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXVWaWkyODN3MitzTFBLaGhDN2dHdHdBTjdHeTM3NnBjb01wUDdGeXlhN0M3?=
 =?utf-8?B?UlFONVlaWStESjF6bWMwNHJsTWhQcGFBM1dsbWlWUUQwN2pFZGlqcy9SUmtR?=
 =?utf-8?B?dTNNeGlwYStjT3VJMHV4czdOV0xIdVdES1BaWE9HcFFLMjM4TTZrbjQvcXkx?=
 =?utf-8?B?ZTFjUEpDZTJRSzNOb3B4V0hmMUxaTXBhc01LUFU4RFljSVdTejV3MWdsQjVQ?=
 =?utf-8?B?YmNDUjc4WHg5K3NFdDZya0JCQ29ON2ZuWk1tS09VMWhtaW1USUdRUlNuRUt6?=
 =?utf-8?B?Y1FtakFkL1k1c2k2cElCRnphVkFxbjIzeTlRK1ltMXMweFQrN2Z6eTlEUysr?=
 =?utf-8?B?MnA5OXkvbDI0UGdxZEtnVDQ5eFhuTUpUcmVERldXajByWjl3WjgvSGJNTENT?=
 =?utf-8?B?WTdKWCsvWGdvU0FWdmRkNWg4VUFnTmNSeGhMK2JTNlIyby9jYXBrVllxajBn?=
 =?utf-8?B?TXVWS25hYVpLSWxtdGRqMVh0dmh4aDZLYU5CejZuWldXUjdLdktvYnkvcTdr?=
 =?utf-8?B?bEg5RnFVNjF1aSs3TFRWbDZxaWhhdTJvVjk1c2craE1KSlEyUjJzM2w3Qmhw?=
 =?utf-8?B?RHNxOEZLcHZrTHhXbzQwWUF6QmN3ZTBycjFFcXFUQmlIaWhqbVZYbTNOZ05U?=
 =?utf-8?B?aS9KcVhrMnNwNjZReXJtL0VwM29zRUZOd0s1RFpNUG5UbGwzTVlCUFFXbWpP?=
 =?utf-8?B?UVhPc3I2VkloNVdCOGhLekxqbXhsdE1MNjluZ3ZGZk1ONCtySjVDWkdpeEV0?=
 =?utf-8?B?cTBFaGRqTnN2ZUg0YVdldFlaZkxvRFRsd3VWN1RKb1VTSjR5cllhNmNtaGxW?=
 =?utf-8?B?THd3cTFsU3RKQzBhNEt5QzZYOGllQXdSWDNUZDRDRHFjbklKTHhvc2dvZzly?=
 =?utf-8?B?YTkxY0piQzRBOUt3VzUwNjNNOWx3K0dCNVZ1bWU2dVBCRmZjZW16WERFOG9N?=
 =?utf-8?B?N1MrVVA4VFdBaG9EVG9tTGtSSXlXMXl4b3lWdTBBMjRvNUZkWTlGT2tZTlM0?=
 =?utf-8?B?alhWVU9pYlNJZS9kWkRKdk9RSnBWUFQ3ajFOcmw1YXpSb1g0eG1VVXlWaXZo?=
 =?utf-8?B?a3F5YVN1bjk1RVM4MXhnS3c1TWp0T29uLzg1QWZiZUVaMkJFQzVLQUFjajRJ?=
 =?utf-8?B?LzVSVEMvemxrWU5WazhWeXcwZSt6V0drYjd2QzhnWFV5c2FWNmQ1R0ZRa0xB?=
 =?utf-8?B?MlZ5MUk1clRRbUlRYm45WGFaakN6OE91UFpDYWNwWi91cWVOZFBtSzdQMTFB?=
 =?utf-8?B?MDYrbWh3Mk00Z051cTZ3RE91MWxsaHdQN2drR3pXVmY1NjVvdHZsOVVaSnVi?=
 =?utf-8?B?TFhCd3RudmFFeU9wMHFvSDl1MlVRaFlrOXUvdUFsck1ObjZqQnczeGNGcmFQ?=
 =?utf-8?B?aFJzeTM2QkFBNk1XNTZkY0Jhb1VNSkhKWmtuSEVUY2Vjc3QySWo2QllEdldR?=
 =?utf-8?B?bjB2OHFKL2FLMEd5SHRVT3pCTS8yV2FJb2FQd21xZ3pUVHJRLzliR3Exc0xC?=
 =?utf-8?B?T1RQWGhlRSt3by8wTkJEYTBaT0QrcU5Ua3YvV2xJZ05RemdnTlRSdmtETmRD?=
 =?utf-8?B?WTNWSnY4aVkzWlBvK3gyMFUza2J4NjJWWWcxOUJpenpiSU9aLzkyOG9nekdI?=
 =?utf-8?B?YndOL1NuMnVHRUpkSUFMVjFFTGJNcE9vbkpNOHd0WDZEYzc3NXA2QUs2M1FJ?=
 =?utf-8?B?cXpRMngraytVL3lURmgrVVh2V1ZsczdETUttWUtWcGZ0V0pObDFGUHg5Z2NZ?=
 =?utf-8?B?NWtWU3d4YjJhRGVuQ09SZWcxRzhCZ3d6UFJQZTlNam1MbmRJYzVORGIreDhJ?=
 =?utf-8?B?NC9OeHl1YUUxS01wanhUenVhZG9iOHNiWjJJSlRscWtqdlNYbWE1SENoWkE0?=
 =?utf-8?B?bkVLbzJvRyswWHBTaWsyT1lzM2c5WElXZ3IrckJISmJjQkFxazU1YnNnOXc5?=
 =?utf-8?B?WmNheFpyVEpTUXRqR1lSQTdHSWdjSHFzVW5NejBXbEErbDF1d0hWdFFUNjd4?=
 =?utf-8?B?TXNxdnM3c3Y3UHYveTN0akFWRlNIZHJDTUJNQmwyS3A3dHRnbGxLY3JBK2Ux?=
 =?utf-8?B?WEJOdGQzaXFSR1dOWnB3SkN0UjdxT3E0TFNoUXF1cGRpc2NwUHYybjBBS0lG?=
 =?utf-8?B?M2ZxL2JtUnAxa041MU5jaHJ1VThBQU5qWTVxdUErd3pLV29jbHJ4cDNkZHJT?=
 =?utf-8?B?c2w5a1JtdjlxMzRUdnhucTFWQ1ByOEJUVHkyYjBOMEZsTkFicjJSR29aR2lV?=
 =?utf-8?B?alhiQmFiMjNuVzBaQSszTHkvcWVaRkJwQW04dDJpWTdsY2F3d1JPdFdEejlz?=
 =?utf-8?B?Z2FiSnExQm5PVGpjWm1LZTJyS0hVU1RYeUlRSy9icHMyd08vTGJpdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24eb3289-174d-4094-344c-08dee48c7ac6
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 05:21:54.0959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwgGXFkN7WrTNCAl8IRb7xaYrSwG4/ugXJOTM9SkZS3WANdoVbBvbyOtCh/8QOLwSDiesUYw+rnwzsECOLl0OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P123MB7500

On Fri, Jul 17, 2026 at 10:02:32PM -0700, Namhyung Kim wrote:
> On Thu, Jul 16, 2026 at 09:35:44PM -0400, Aaron Tomlin wrote:
> > Currently, dynamic non-array fields such as 'cpumask_t' are mishandled
> > in 'perf trace', causing the raw length and offset descriptors to be
> > interpreted and displayed as a literal integer (e.g., 'cpumask: 524320'
> > instead of the actual mask data).
> > 
> > This patch corrects the parsing of dynamic fields that do not have the
> > TEP_FIELD_IS_ARRAY flag set. By doing so, it ensures the pointer to the
> > raw bits is properly resolved within the payload.
> > 
> > Furthermore, it improves the display formatting for 'cpumask' types:
> >     - By default, the cpumask is now correctly output as a zero-suppressed
> >       hexadecimal string, resolving the aforementioned integer display
> >       anomaly
> > 
> >     - A new '--bitmask-list' command-line option has been introduced.
> >       When specified, this delegates formatting to 'bitmap_scnprintf()',
> >       enabling the cpumask to be rendered as a condensed, human-readable
> >       list (e.g., '0,2-5,7')
> 
> Looks like you are doing two things in a patch.  Can you please split?

Hi Namhyung,

Thank you for your feedback.

Sure.

> And for any user visible changes, I encourage you to add an example
> output in the commit message.  Also please update the documentation for
> the new option.

Understood—I will address the above in the next iteration.


Kind regards,
-- 
Aaron Tomlin
