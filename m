Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022073.outbound.protection.outlook.com [52.101.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BC935839E
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761126; cv=fail; b=Pxwcwka2+bbnzZ8vs8l4ABNWHtZHSe7/+TCD0KQ4BixrljaoEyTV/kw9vZIAZHbyoky4LcQe0bngzjcTsQQclVLigjRGITja9KOX4+EcldHZJtGK3hCik+Ue4lAQRZSYmQMOiXucwBYcgogwpKRvYRbXcB2BTBN7T/Yhfh68Tr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761126; c=relaxed/simple;
	bh=jy6RdD2QMM8G0t7apiqqiI3Cr9IPcgY0qwGC/b34ugE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kp0R1TasPqyPEV7chfGheMMVoMT+BAfgdRKEEFhVdGUmj7i1TbS7fKqkqvLW8phA6oB15vOrgh+0chg7RC5gBGT1ROGiM35xwx9dANotgjV4bE66/VwGKzCLIhi8TbhZ8M/t3UUk+e1r3edpViOZmGDmH/gXOgNo1eGFr2qRWkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HX/zK8I6/X+WGOOmaEaJjIocc2Fe9z0mp+iWOi8hpbug0MHTj/uYoiYBx6UPzkkYncmzdvQ1ZlsRSMi4+LI9xkTipA2105GqxPk1157ZAVckOFIJTHLgjdcX/TUNRwW9wcxADBA0mnJY7FH+LU2aKeTKAAH7m0kiaJ5yhbZAJZfw88Y9lZl0z8w3ebE8wplMlyPTgeFx3ASJdJ5f1HW3BJD769Iok565Y0MuZz3Z8LHltWNkkQL9erGGMBGM8bh3wlZrB/acilZBaCSGPl6XPgdAXKWLRu9AxCtwMQ9zwjOjY2CQAuRODdhg0uoNgnsHzyeYxOd6K9/yS2mOfZ9Ysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=M1X2Q4LFNhHaChf4BPZrFwVKhp+0GjjcWg5ATJLDs5M=;
 b=K/svTuYaBv56SM0MYdpXlf9IiaSekjr0lIiH0vw/ABBeKYgYUZr/uB2eA1sOu9My+U2WMEjgePIOqltFQMkhVGUmkh2M0du0jcvfAPOQZ/dKbM7e7cYfBylOoXWXrkPozU/WhdZvxTHMnFA29NwLtpmrs2GaLS91S39d/3iftgRqEsOjMKFAHXoNCdGOo3kN81rbk0vC+5gnkgX9jyZqL4eKUz1TKTl6f1oIb0hVrm0XYYu5iKsMVSd7pRErOwQzhOPEGfnGjIc4X3OHtvDUYbWPE+ESCbYXt+OV5aqTuAh9AHqUuX/nWpkHOfKC8+nmmE5/HWYeGTMj480vuMAzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB6963.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2cc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 12:45:20 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 12:45:19 +0000
Date: Mon, 3 Aug 2026 08:45:16 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: acme@kernel.org, namhyung@kernel.org, irogers@google.com, 
	jolsa@kernel.org
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf trace: Format fields with hex specifiers in
 print_fmt as hexadecimal
Message-ID: <w6k5v3c7qtjqb7a7lgeqdci4olligryfyiozul2xwiurumzp4u@zv7gwvhev7tl>
References: <20260731215909.125335-1-atomlin@atomlin.com>
 <20260731221204.654141F00AC4@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731221204.654141F00AC4@smtp.kernel.org>
X-ClientProxiedBy: IA1P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::8) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f7161f-ac14-4301-1f95-08def15d1382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|56012099006|4143699003|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	tt11vRYQeq2OMIBSCrgy4qSRH/Ig69i/aEGSYNkhZUG1RHzmbwA4Fs9mOd0VRZBBDugPDsiY4KisAUIFDmQ0iKNFALii+b3JC+CzXD+F6rxyA3AiCZECZskMlqx8LL0HE+EDz7CYNiy2M2/xP1+6gYhjwfYBwtWjN/UWMCMMhYVICbYrMB3PC7VLjOv9v7P4eGDZ5ww3c8DGL2fBJNEROTrmdSuxPoUzFQuIr0oYeXteENF47HBCTxtPUbGJkeLGMc5OYBVVS32B5ZisSVIe55G9SVtBe2/Ra6tvynT+mWMkNHV0mhxA4RsAd3QoHdF6rrq3XnvfT2QBORXrxTYaizVNOG/e+/AUFNaQU4K+x0NFdILTJDzD+XugW0Ma/80uflqOIOrqZNIiZdujrwJwix8JdWEKNc3GRWo6J3mB7I4nCwpX8+REBqnkvOZz8DCtp62F1A3Hkp7VsnxWhtuyr6lxkBLzDX+Yo7qwB0zGHk9T5xXwaLmAbXb1Jfiq+qrAMdW/lmCRWoWOS+kZ1GnaobJ6owJxo5dzS56YGinY0zJZs114MZuCjT2SW2OYxyhCQxjb1m4A6JMlhQQugvj8X/gvE3Chuc4fxLJC4HrB+iA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFZrQ0V5WHZ5QkJ6WGJZSTlIWXVkL3h0ZlNoSzhHZ3hOSW1hWmVLR1FXTVFp?=
 =?utf-8?B?YVp1dXNZbGQxOVQ3Sy9Qb244WWJoek1VdTBId3dpQ2J4cERIdElQMEx1V0xy?=
 =?utf-8?B?WlBrVW5TbW5jdXd2UXYrZzlGU2kycVNnUHNHaUtERGF4V2lDZk5ueXBmUVFr?=
 =?utf-8?B?UG5KT2VCeVhPeW9lMXJTSjh0akh0Q3RGdnl5NGJEVHZXSDhXZmRhMHk4MGVt?=
 =?utf-8?B?d0RoOUx1UlJEc1VucEw5UGxPS2ljUzYwLzU1L1ZMOStHL29Kdk54K014bVd1?=
 =?utf-8?B?NjgrektGMDlIYi95OVdyaTZJWk9rVElmb0NzNkh1N0JwbDNBek9zNEo4Uyt6?=
 =?utf-8?B?OEVtTUo3TmJRVm4zREsrR2xxblZISjFSbi9Zd3dDakpJUzhCcG84Y1QwN1Zn?=
 =?utf-8?B?UXhkSmJJK3ZrbFRhY0hyU2lXU2Z6eWZUbmNYNWJkaHFkaVhIR0sxUnRRUjNO?=
 =?utf-8?B?WkRGYklLM25NbzZRNTNVd0FibmR0ZytvTWFTVUN6YXVMTm1Xd0VUUkpTdmM5?=
 =?utf-8?B?Mk9SakdMenZXdTJBaVhhRDJTSk8vc2VtMG9ENndNRXdmdkJ5R3Q5TGcyem5C?=
 =?utf-8?B?UEJRRXYxRW41NXhKcWhRV3hpSDNwQmt2QTBWcFRTT3I5UHZack9ZazdmeEdS?=
 =?utf-8?B?QkhBR0xidzZ6dkgxaGJxVmp0dlFIWUZmbTRYN0xaMERrR3daUnprb0o2K3h3?=
 =?utf-8?B?Zzh0OG43Z0FwK2RaRTNBbDdvQjZybVJOWmUxQ2hWSDZpbTRyaWRFRzluSnhp?=
 =?utf-8?B?WkNEeEIxNXhma0ZSY0k4ZktQOU9MMWREa2s5em5ZbHBkK3I0dFpkSmMyYjJh?=
 =?utf-8?B?UW1teDFxdlhsZG1VUFB4eWVobzZGbDNCR0Z1M2toRmJSOU4wYXB4UFpJb3My?=
 =?utf-8?B?ay9YL1phUk0yZmYrOGFYK0pUcFlRQmNYdmdRdUx6eU9hazc1ZTBKLytuYlpY?=
 =?utf-8?B?YktLOXJUdWFwb2p2NGMxVkhYN2ZDekpTU0hjMTVxZWd0aXh0SXRTQTBYM0ti?=
 =?utf-8?B?T3h0T3l5QkFoNkJOTldKbWFyVHJVTkNGOUQycng4d1ozN1VwU2VGYUNMVEIx?=
 =?utf-8?B?YUlOWnJyRllKNnhLcUxTUnZlZzAvYkxTWkx6V21SNUcwbWRLZFM2Y1BiSUda?=
 =?utf-8?B?Y0EwYndPSTQ1aUFnYkQ5T1pjWDdRLzFUdjc3ZjllZ3lnRk5zM2Vva1ZEYzF6?=
 =?utf-8?B?QWhHTmMyRG1ESTdwL3BLQy96Zk1VOE14QStIU1hwaDJxeUhPN1FxSGVTR2VB?=
 =?utf-8?B?aWdWWnZEWnE5MUV3SUZKcTJpa3hGNXRnRFRkc3NXMWhzR2VKM3ZsbEZ4SmJM?=
 =?utf-8?B?ZFA4YTEwVmczU0QrNjBtR0xuQlRwSkNOWVYvbHpTbmZScE1UekpRTzdEWklJ?=
 =?utf-8?B?MGp4TVZPeHorN2dNYTRmaXNaY3JjenZ1VllCSW43TUNMUzlJbXpzZS80T3hx?=
 =?utf-8?B?TUhmb1Z4UW8wcndQRUtzai9Zd3lWTWhiZUxvWUV0RDdaK0NSVG5VVUtYei9P?=
 =?utf-8?B?TURUcDdWY09NTUNqTWJJdDEvNVcvdGtlZmxKYTZzUW5ocENFazFvUlJrSXcw?=
 =?utf-8?B?VGIxeGsyNW9OclZNWkh1NEE2K1JySlEybndLMUhGb3lTdTJYNS9GVHBhYmF3?=
 =?utf-8?B?RTV0Y3psWmhaNnI3bXlLTGs5emh0MnpzSldwcmRXR0dLZ2ZGc0RiZitxaGgv?=
 =?utf-8?B?UjY1MFk5YlZyQjZEU1A0VlVxdjROc0syNHRpeFBzQXlsVk5UQXNCYm8yTUR3?=
 =?utf-8?B?Sm5Td1dhRmdzTnF4YXBCaGRMOWRYZFJVQWtJdm9rOC8xcFl0OXFSekhFZXhY?=
 =?utf-8?B?N2ZJaTFEUms1VitxWkl5eWtDR2NjM2ZrR0RiaHFoWWFDcE9Qa0p3bkxuaEN6?=
 =?utf-8?B?bmNtU1kwa09raGhYVmNCOTJYZ3dCcklqVWE0V0tXK3IyZC9SNnpEVE1aTnlH?=
 =?utf-8?B?MDJvaFA3V0NDVmZQa2dTRkVaZmRzV3FoUXFHWkViRjVHdnhiNFkxYlQ1Z0Zm?=
 =?utf-8?B?ZkhFVm5xOVYzTzU2djFxUmw2QUIwTU92SytBZEpyWnN6V0o1TVB5c2piSm8w?=
 =?utf-8?B?TSs5RUg2U3pXYTllT05GS3YzRzN6WWY5S2JFcG94TGtEQXJYMUJtekZJbUE1?=
 =?utf-8?B?SXFWSlhpYk1VdXFwSWJHSVFUWUhYdlpJQ1dhNSsyMnErNEdyODBzd2JFVTFr?=
 =?utf-8?B?eVA2b3FRa1VWUVVYV3FuOXlDTEkzYTJDV1RGMjBkZzQvanVTb2FKWngvYW5u?=
 =?utf-8?B?cWJGMVZKMC9FSFdodDVpeTl3SGxySFhlQzY0SExZOVRyd1RaejMwSHkvQVZn?=
 =?utf-8?B?MEV2YUFqOUhVV2NJazUxclVvbHJudVVoaUtZU0FPd0dlTHJJdTlIQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f7161f-ac14-4301-1f95-08def15d1382
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 12:45:19.7683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j70rpPIqjDVKywuY+o2GkpLXE7DZsnQwuwNgUCMpGcsQZcNsN34eXuI4XY8I429NSS5kcRpT24F9Yvkrkoz1aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6963

On Fri, Jul 31, 2026 at 10:12:03PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] field_has_hex_fmt() prematurely truncates the format string search when it encounters escaped quotes.
> --
> 
> --- Patch [1]: [PATCH] perf trace: Format fields with hex specifiers in print_fmt as hexadecimal ---
> commit 1d9edf5adf3cf666d7e9393e5db036cd73d6656a
> Author: Aaron Tomlin <atomlin@atomlin.com>
> 
> perf trace: Format fields with hex specifiers in print_fmt as hexadecimal
> 
> This commit introduces field_has_hex_fmt to inspect tracepoint print_fmt
> strings. If a field uses hexadecimal specifiers, it assigns SCA_PTR formatting
> to display the value in hexadecimal by default.
> 
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index ba0f8749fc7d7..b0ce9c2a24e57 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> [ ... ]
> > @@ -2098,6 +2098,37 @@ static bool is_internal_field(struct tep_format_field *field)
> >  	return !strcmp(field->type, "__data_loc char[]");
> >  }
> >  
> > +static bool field_has_hex_fmt(struct tep_format_field *field, int len)
> > +{
> > +	const char *fmt, *pos, *end;
> > +
> > +	if (!field || !field->event || !field->event->print_fmt.format)
> > +		return false;
> > +
> > +	fmt = field->event->print_fmt.format;
> > +
> > +	/* Limit scanning strictly to the quoted printf format string */
> > +	if (*fmt == '"') {
> > +		fmt++;
> > +		end = strchr(fmt, '"');
> 
> [Severity: Medium]
> Does this parsing correctly handle escaped quotes inside the format string?
> 
> If a tracepoint format string contains an escaped quote, this strchr call
> will incorrectly match it as the end of the format string, causing the end
> pointer to be prematurely truncated.
> 
> > +	} else {
> > +		end = strchr(fmt, ',');
> > +	}
> > +
> > +	for (pos = strstr(fmt, field->name); pos && (!end || pos < end); pos = strstr(pos + 1, field->name)) {
> 
> [Severity: Medium]
> Because the end pointer can be truncated by an escaped quote earlier, won't
> the pos < end loop condition evaluate to false for any fields positioned after
> that escaped quote?
> 
> This seems like it would skip hex format detection for those subsequent fields,
> causing them to fall back to default decimal formatting.
> 
> > +		if (pos == fmt || !(isalnum(pos[-1]) || pos[-1] == '_')) {
> > +			const char *after = pos + len;
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260731215909.125335-1-atomlin@atomlin.com?part=1

Hi Arnaldo, Namhyung, Jiri, Ian,

I have updated the field_has_hex_fmt() function to use an escape-aware
scanner that explicitly skips backslash-escaped characters when seeking the
closing quote. I shall send through a v2 containing this fix shortly.

Kind regards,
-- 
Aaron Tomlin
