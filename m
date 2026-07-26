Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022118.outbound.protection.outlook.com [52.101.96.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE5E175A60
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 01:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785030170; cv=fail; b=lr6Tj9v6pwV6EZzQDoC12aQ9eocvgSfWDlrs6wIpp2vy/on8esxZx6oV2sIyrunV7PZn6BGdfHxhdj3Yx98vsKCmAWCK+g7t/FW7wDl2kWtvBg+Xh2/LXeRY6deCz6k2wEgY08BNTEQ1qNIUQeq5GmatrDG5/g8zfrGUsbpRH/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785030170; c=relaxed/simple;
	bh=LZFICUnNwgwAAEZNDTgvi3mfFXyQoh43sv9rn5QWFus=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oQBUTGUvJFNZKNK3O+7FtnnUn7wa/4lzrUJ/5FQSIhlH7LfFiy8tQGxt65JK1Glnm4X826MleFqVd8AmgXj0h4Smr0x+UMYQnuVVNc5+Lej4Y4+nqoNx7rApbFDf6nMRbPWoLRRyMzokt8Q0o/z4vE5sE79Fx6UeQDklo9Dz/pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyP+ubfr8ZdU+kWHlr/w93ECmcABAH1IuELE5q5qm8Q9NJxBdWyfKO22oUihkaPO7mn7HH0a+/PDyqcYUfKcDw21x7KaJuAyVAvVSkeqECSiAeZWWs77KRNj8ag7V08V8zoODDfkYAoNMCEvPfYZ32plG47fwai9DcwBIqsPUIUMLug2WYw0lqE7vkrc3JRF5xKn1Zt72fxj/f5dQ6s/P8Hix4vYpE91AOEDcGo7xVZL1H6nzhRvB8/e80JYIlwW0cfbrx2BRKHBK/cNsJ3zpdK7/UTZfqJh54BaSbTG7Tg8UfOVeErRtS7pEbRyRABb5Y7AHOIcWEzjyhUmTYw2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=Ru9n34HfKznaEf4F1axD0m6x2xeDMqZmfqFazqXIDkE=;
 b=IpUV+9UkClmGU7GfCg38SA3x28Ay0pLQ19Oe8Sxk/8AVhpyqTuQnKVktU29QkjFNUkZLzhKcF1elmS5L0VdTdaTNMhEyYskUz8jc1J0KRiyyCQY5OrUbFwLMmmu6Kok8SGm5RIWC14/fQEMW8wvWoG36vchhaTAYai0dmyrV7AXu0KXpMLJ3PDzO9EXLyzraS5YoBnMb9D7bzVIaZDXDPqMWxfHxZuNGvGCoFEtfDQtQmQFqiXe4NhE75d4u5tq7ySIN4VaSbnKcUpQvL0cZAaTl4POQJsScmosUZUaL8ssFQuhZYooc2Rmb9QT4zWFGHQ4v1MOylCQWGAtlwELAuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB6201.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sun, 26 Jul
 2026 01:42:39 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 01:42:38 +0000
Date: Sat, 25 Jul 2026 21:42:34 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 2/3] perf sched latency: Auto-scale latency and
 runtime display units
Message-ID: <vunqvcg2qlhqsv7zqiutal5k3zl2kpauru3ryxcfeb4qbc3k7t@a63yynsemqih>
References: <20260725173341.679782-1-atomlin@atomlin.com>
 <20260725173341.679782-3-atomlin@atomlin.com>
 <20260725173934.1D5241F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260725173934.1D5241F000E9@smtp.kernel.org>
X-ClientProxiedBy: BN9PR03CA0967.namprd03.prod.outlook.com
 (2603:10b6:408:109::12) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: 4718b9f9-018f-4a15-d114-08deeab72ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|4143699003|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uaIIsTdj9G4jkbrdSAmfDw37bcX8w1jR76CD2I2m9fsncen3kmP0RW+hskCE962ev10NUrSMuyEGSO4aMP3B9nTwbedav6FwpIlqBNBQdNDHhzhpBhzGhNHufgz9EKTqg6j8X5cOKsAPi0LvLRdqaPztEmYZwaAw2tojoekZGj7io7b87MDJr38FYljzKTWfvSsx7rOMHF9hf8W7cTFoSwB054PoLCp17XN+VmJq/TyEaMVtWrq4jZNC7N1ztNfZZiCEdoC8MZJbXCNrJOeesR4ZdTfkMma1yiasbsNV7UnkjZD4Uo8EcTgbXRBOCKP4wHZQnnDtHfNCICK6ClJHMEiOE71XVOHn5+7exydLF8zLwa1lu3XpUh+WuXYgbMMz1olE9NXR0kVDtqxMRnTxaAMDWLb2mN1Q3VJl756bNgjjC9rte2Z1/Bb9IPTcT2xOuIh0iGWIgNNWGY8T9aqVHU7wvXnhbkFs7vqb5LcPebTUqueil7n0Bx5M3XAOauSkgF6uLSu4RLryin0NGkTIH5t9ftD3LJZ7Wy9av1WliPAjlJxydlvF6xtR33i3+A5Site4MM2VPUtKbN7ADbW9kIhIbwo1RXQIWlut1XJV0mk4q7lbCY7zwkJRspcenQq1Kenh5sEuJ+dlGzJ9ZDIELwvgdNYtb8DKUcDrAsuMlAg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(4143699003)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkJhcysxNTE2ZkpkZVpUc3VmeWhRcmVpcXBPS2FMaHFiYklrZUNuSFY1Z2NF?=
 =?utf-8?B?OXZGY3VBVm1oU3QyVklGZEFqMm5nWm5DRGlVQ1ZYTXFLOUlmYzlJQ1kwY0hH?=
 =?utf-8?B?L0hOWEYyRlFjdE8rUDVhL05hVHhyMHRDSXZ0NllZVVJMOGlEMHRsRCtGbG9X?=
 =?utf-8?B?MExxT1FoRG93VFNvT0JheVhRRTdyQlRDK01FVkl5ZnFwMDl3cmlHZ0VveUdy?=
 =?utf-8?B?NXdaOG1uTEExa1NwSkRFdWlFY1I4OWZUaHhNRDhTUHFEUGhNQjhXZWM2Ukty?=
 =?utf-8?B?Qjhwc2JNbW50TW5QWFN2TVUrcllzMFh5aDkySG92SHpJUG5TZExzRE0yZlZi?=
 =?utf-8?B?Z1ByUktvUXJ5SGtIYVFLckUyVmlyd3FnZ2hlL2p0M3A0Z1JnQ05LUk5jMDg4?=
 =?utf-8?B?UWZyVSsvdzBQSSsvc21sUHJNallId1VyS3VOdFZmK2NiRTRiYUxMRHlSSFo2?=
 =?utf-8?B?ZDNsUDNwRUdqODZtNHBHODhVSExNMGdEaUx4NFRhNlVUR3dubG5uWmdFWlk3?=
 =?utf-8?B?NHVTR29xeFQrS29waFZzY28zN0lhcEJSMHpFK0taQ2dPaE5FK1l1ZGR6Ni9i?=
 =?utf-8?B?ckhSa2poMGdibUExNFJ1TE5tTmFTSHRXRmIxeVIzdjd4SEw0REcvMnVzRmh5?=
 =?utf-8?B?TE4xSGwyT1NJeWMwTVBHS29TdXpPWUU1TWNjcE01NkllYWkvd3o0TmFmUUh3?=
 =?utf-8?B?bGRLSWFkUEc3Y0FQbEU5ZFV6R3MwV1NRcTJ5NnJoT2lMVFZHQnBrZUdCTElF?=
 =?utf-8?B?UXc2aEgwM1B2b2huYjNaUk9LQ1RteGNSbENScmQ4SUs0R1dkYm53RFVkNGQ3?=
 =?utf-8?B?L2hOUzRMRUdIaEZrNWc5dnhOdCs3ckpUUGcrRUU1VmU3TURCUFc1LzJYWGtH?=
 =?utf-8?B?TU5uSnBWeFA1cUpJT2Z4blRKMG1lOEhIU052a3djYVpVVDlWMGZMN3hVSnNk?=
 =?utf-8?B?aU56ZzFkNXorVHVSV3M3dUo3ay9JY0tiUzNDWkY1bUF6cDVqSmQzQkdTdnM1?=
 =?utf-8?B?YXNJR1hWSFluQUVRWVp0ZWVPV2ZsOVVJM2lvWjlUSG8vVU51RllhVXlYREpq?=
 =?utf-8?B?TnMvZGpidWp5VkJCd2FocGZpR2tUWkZXTENiL29LTkgwSjdxTzJiTzhFaVJL?=
 =?utf-8?B?OHYyNjRoWjBnQ0ZtaWFnOVdlN3hzZEhEMFBRRHdpSUsxVk13NjZqKzZIaG1k?=
 =?utf-8?B?ZVhhQ1lQNGtuU3Q5cllWdDRpSko5Vm80S1Z1UHBrTkVuZW9MWklYcEtNd2ox?=
 =?utf-8?B?dkNoN2xYaFFNb0V6aERXRDZFajR1cG1idTh2TGV1RU5RQUdYMGRBR2lDV3dI?=
 =?utf-8?B?SnlkWno2MnBKcDUvM0xybEkwZlk4Z1phWkduYmxnTWJpUjB3ZktkNlEwS09D?=
 =?utf-8?B?Z2Q3Qms0QWlyTmpHaVNVZHJVZVhYbHljWTNub1Q0dm1lcWJTdlZtUVA1Ykta?=
 =?utf-8?B?dHZ2SWt1Yi83QW00bVRZR1ExUzFOTUtFWWlWdmJ1V2x4VHN3VFh2UmZFMS9a?=
 =?utf-8?B?dXY2akxyN29ES1ZabUJRMUNnREJaZnYzN3Rack02NzdPS254dkp3MFpOZk05?=
 =?utf-8?B?ams0MjR3aTZJenNiemVXZU9oUE9raDNGclcrb2hhVFBOZWVuR3cvMmU5ZkMy?=
 =?utf-8?B?c1IrNG5TaWZzaWt3Qko4Q3lZUTJXemd1NjN5UmVUL1doNlVJY3RpNXRvdjR3?=
 =?utf-8?B?RGFUY0JjZkx3NUk4VytpdG00NDlJcVZiWVZOdS81OWZWZ0kyWExFc0ZmQjI5?=
 =?utf-8?B?alY2WnBZM2ZPYyt1ditLbEQ2ZVY1OThXMkJ3akRVK2FXVXJBZnl4bWNxWEY1?=
 =?utf-8?B?cjB4NGRPV0ZtTUpKdHNRYWxQYVY0UldxWUp0eHNYK0VpK0ppTmQ0Q0xRWk84?=
 =?utf-8?B?Uy8vWFo1SmVTQWlsQ0dBeU4zTkcrQWNhdk5DRzVRdzNHMWxBRjB2YXdma0xl?=
 =?utf-8?B?NXExRnRUSXdJaTNWbnMyNmlJYTlzVVJjMllLb0NlbEhlRUlJcE1DOWJobjZi?=
 =?utf-8?B?UUNQQmxGMzhyM01PL3VBWEluMkpxMkdGZm42L1MyY1JhMUdHc1ppdmU2QjRt?=
 =?utf-8?B?enVCQjNmRGxDOUVEMkY5TzFMODBmT1c1VE1zOFgzc3I2bStpUHplelQzajJG?=
 =?utf-8?B?U3R2NmgrRlhoaWRZYVVKajYxejF1dVVFSFBjZUMvTGx1Q2NkcU1jcW5GbjZo?=
 =?utf-8?B?YzJ6ZE5HeVhWaGt3bllRQWt2d0VMajVRdy9vd2tCaVBTK2E5VkZ5QkVySEJp?=
 =?utf-8?B?eUtIbk9JT3dXd2lsa2lRbkRjYnFXMmd3RnJ3OUVkMG9LL3haQzFmL2swd1Bk?=
 =?utf-8?B?RlgxSzJ0N1JBWHlZTEJWdHdlSGxHV1NmYjdFazBKYUp3dDNCVjFkZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4718b9f9-018f-4a15-d114-08deeab72ca6
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 01:42:38.5339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqLmkQXpw1Cc/rVEhz3/ZSfW4RMvb1eVdIYiUJF6IC4G01JnhlPOJDM9huGBoPhs/bro0/Nga0o64NJ5aFIEWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6201

On Sat, Jul 25, 2026 at 05:39:33PM +0000, sashiko-bot@kernel.org wrote:
> > @@ -1430,14 +1443,17 @@ static void output_lat_thread(struct perf_sched *sched, struct work_atoms *work_
> >  		printf(" ");
> >  
> >  	avg = work_list->total_lat / work_list->nb_atoms;
> > +	scnprintf_latency_unit(runtime_lat, sizeof(runtime_lat), work_list->total_runtime);
> > +	scnprintf_latency_unit(avg_lat, sizeof(avg_lat), avg);
> > +	scnprintf_latency_unit(max_lat, sizeof(max_lat), work_list->max_lat);
> >  	timestamp__scnprintf_usec(work_list->max_lat_start, max_lat_start, sizeof(max_lat_start));
> >  	timestamp__scnprintf_usec(work_list->max_lat_end, max_lat_end, sizeof(max_lat_end));
> >  
> > -	printf("|%11.3f ms |%9" PRIu64 " | avg:%8.3f ms | max:%8.3f ms | max start: %12s s | max end: %12s s\n",
> > -	      (double)work_list->total_runtime / NSEC_PER_MSEC,
> > -		 work_list->nb_atoms, (double)avg / NSEC_PER_MSEC,
> > -		 (double)work_list->max_lat / NSEC_PER_MSEC,
> > -		 max_lat_start, max_lat_end);
> > +	printf("|%13s |%9" PRIu64 " | avg:%10s | max:%10s | max start: %12s s | max end: %12s s\n",
> > +	       runtime_lat,
> > +	       work_list->nb_atoms, avg_lat, max_lat,
> > +	       max_lat_start, max_lat_end);
> > +
> >  }
> 
> The table header defines a width of 15 characters for the "Runtime" column
> (|   Runtime     |), and 17 characters for the "Avg delay" and "Max delay"
> columns. The new formats %13s and avg:%10s produce strings that are shorter
> than these expected widths, which appears to cause the vertical bar separators
> to misalign.

Acknowledged.

> > @@ -3626,8 +3643,9 @@ static int perf_sched__lat(struct perf_sched *sched)
> >  	}
> >  
> >  	printf(" -----------------------------------------------------------------------------------------------------------------\n");
> > -	printf("  TOTAL:                |%11.3f ms |%9" PRIu64 " |\n",
> > -		(double)sched->all_runtime / NSEC_PER_MSEC, sched->all_count);
> > +	scnprintf_latency_unit(total_runtime_str, sizeof(total_runtime_str), sched->all_runtime);
> > +	printf("  TOTAL:                |%13s |%9" PRIu64 " |\n",
> > +	       total_runtime_str, sched->all_count);
> >  
> >  	printf(" ---------------------------------------------------\n");

This is a minor concern. Nevertheless, I will address this and the above.


Kind regards,
-- 
Aaron Tomlin
